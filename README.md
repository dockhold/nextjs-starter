# Next.js starter

A full-stack Next.js app — pages, API routes, and server rendering — that
deploys to [Dockhold](https://dockhold.eu) with zero config. It runs as a real
Node server, so you don't have to flatten it to a static export.

[![Deploy to Dockhold](https://img.shields.io/badge/Deploy%20to-Dockhold-2563eb?style=for-the-badge)](https://app.dockhold.eu/new?repo=https://github.com/dockhold/nextjs-starter)

## Deploy it

1. Click **Use this template** (or fork this repo) to get your own copy.
2. Click the **Deploy to Dockhold** button above, or open
   [app.dockhold.eu/new](https://app.dockhold.eu/new), connect GitHub, and pick
   your repo.
3. Dockhold installs dependencies, runs `npm run build`, and starts the app. It
   goes live at `https://<your-app>.dockhold.app` with HTTPS handled.

Every later push to your main branch redeploys automatically.

## How it serves

The `start` script in [`package.json`](package.json) binds `next start` to the
assigned port, on all interfaces:

```json
"build": "next build",
"start": "next start -H 0.0.0.0 -p $PORT"
```

`-H 0.0.0.0 -p $PORT` is the one rule that matters — a default `next start` may
bind the wrong host or port and no traffic reaches you. Don't set
`output: 'export'` in [`next.config.js`](next.config.js) unless you specifically
want a static-only build — it disables API routes and server rendering.

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
