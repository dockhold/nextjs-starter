export default function Home() {
  return (
    <main>
      <h1>It&apos;s live.</h1>
      <p>
        This Next.js app runs as a real Node server on Dockhold, so server
        components, API routes, and server-side rendering all work — bound to the
        port Dockhold assigned, over HTTPS.
      </p>
      <p>
        Edit <code>app/page.js</code>, push to your main branch, and the change
        redeploys on its own.
      </p>
      <a className="cta" href="https://dockhold.eu/docs/recipes/deploy-a-nextjs-app">
        How this works &rarr;
      </a>
    </main>
  )
}
