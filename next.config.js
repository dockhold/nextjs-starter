/** @type {import('next').NextConfig} */
const nextConfig = {
  // The Dockerfile sets BUILD_STANDALONE=1 when it builds the image. Standalone
  // output ships a self-contained server carrying only the modules it needs,
  // instead of the whole node_modules tree, which keeps the image small.
  // Locally it stays off, so `npm run dev` and `npm start` behave the way
  // Next.js normally does.
  output: process.env.BUILD_STANDALONE ? 'standalone' : undefined,

  // Leave `output: 'export'` off. It disables API routes and server rendering.
}

module.exports = nextConfig
