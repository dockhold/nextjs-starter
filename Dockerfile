# Build the Next.js app, then ship only the files the server actually needs.
# Dockhold builds this image and runs it as a non-root user (uid 1001).

# --- dependencies -----------------------------------------------------------
FROM node:22-alpine AS deps
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci

# --- build ------------------------------------------------------------------
FROM node:22-alpine AS build
WORKDIR /app
ENV NEXT_TELEMETRY_DISABLED=1
# Turns on standalone output in next.config.js: the build traces the handful of
# modules the server needs instead of copying all of node_modules. Without it
# the image is several hundred MB larger.
ENV BUILD_STANDALONE=1
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm run build
# Anything you drop in public/ is served as-is. Create it so this build works
# whether or not the directory exists yet.
RUN mkdir -p public

# --- runtime ----------------------------------------------------------------
FROM node:22-alpine AS runtime
WORKDIR /app
ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1
# Bind every interface. Listening on localhost means no traffic reaches you.
ENV HOSTNAME=0.0.0.0

# Match the uid Dockhold runs the container as, so the app can write its cache.
RUN addgroup -g 1001 -S nodejs \
  && adduser -u 1001 -S nextjs -G nodejs \
  && mkdir -p /app/.next/cache \
  && chown -R nextjs:nodejs /app

COPY --from=build --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=build --chown=nextjs:nodejs /app/.next/static ./.next/static
COPY --from=build --chown=nextjs:nodejs /app/public ./public

USER nextjs

# The standalone build ships its own server and reads $PORT itself.
CMD ["node", "server.js"]
