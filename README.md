# Next.js starter

A full-stack Next.js app — pages, API routes, and server rendering — that
deploys to [Dockhold](https://dockhold.eu) with zero config. It runs as a real
Node server, so you don't have to flatten it to a static export.

[![Deploy on Dockhold](https://dockhold.eu/button.svg)](https://app.dockhold.eu/new?repo=https://github.com/dockhold/nextjs-starter&name=nextjs-starter&ref=button)

## Deploy it

1. Click **Use this template** (or fork this repo) to get your own copy.
2. Click the **Deploy on Dockhold** button above, or open
   [app.dockhold.eu/new](https://app.dockhold.eu/new), connect GitHub, and pick
   your repo.
3. Dockhold builds the included [`Dockerfile`](Dockerfile), which runs
   `npm run build`, and starts the app. It goes live at
   `https://<your-app>.dockhold.app` with HTTPS handled.

Every later push to your main branch redeploys automatically.

## Deploy with your AI tool

Install the Dockhold plugin or MCP server in your AI coding tool
([setup guide](https://dockhold.eu/docs/recipes/deploy-from-your-ai-tool)), then
say "put this online" in a folder with this template. The tool signs you in
through the browser once and reports the URL when the app is live.

Or from a terminal: `npx dockhold login`, then `npx dockhold deploy`.

## How it serves

[`next.config.js`](next.config.js) sets `output: 'standalone'`, so the build
produces a self-contained server carrying only the modules it needs instead of
all of `node_modules`. The [`Dockerfile`](Dockerfile) ships that server and runs
it. The result is a small image that deploys on any plan.

Two settings do the work, both in the Dockerfile:

```dockerfile
ENV HOSTNAME=0.0.0.0
CMD ["node", "server.js"]
```

The server reads `$PORT` on its own, and `HOSTNAME=0.0.0.0` binds every
interface. That pair is the one rule that matters. Bind localhost or a fixed
port and no traffic reaches you.

Anything you put in `public/` is served as-is. Don't set `output: 'export'`
unless you specifically want a static-only build, because it disables API routes
and server rendering.

## Environment variables

Set variables in the dashboard, not a committed `.env` — Dockhold doesn't read
one. Server code reads them from `process.env` at runtime (route handlers,
server components); keep secrets in the Vault. Variables that reach the browser
need the `NEXT_PUBLIC_` prefix and are baked in **at build time** — the build
doesn't see dashboard variables, so set those in code (e.g. `next.config.js`),
and only ever for public values, never a secret. See [`.env.example`](.env.example).

## Add a database

Enable the managed database add-on and read `process.env.DATABASE_URL` in server
code. Apps are stateless — persist state in the database, not on local disk.

## Run it locally

```bash
npm install
npm run dev      # http://localhost:3000 with hot reload
# or test the production path:
npm run build && PORT=3000 npm start
```

## Full walkthrough

[Deploy a Next.js app](https://dockhold.eu/docs/recipes/deploy-a-nextjs-app) —
the step-by-step recipe, including host/port binding and API-route fixes.
