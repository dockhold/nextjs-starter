import './globals.css'

export const metadata = {
  title: 'Next.js on Dockhold',
  description: 'A full-stack Next.js app deployed on Dockhold.',
}

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  )
}
