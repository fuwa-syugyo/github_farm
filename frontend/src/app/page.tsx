import Header from "@/components/Header"

export default function Home() {
  return (
    <div className="font-sans grid grid-rows-[20px_1fr_20px] items-center justify-items-center min-h-screen p-8 pb-20 gap-16 sm:p-20">
      <Header />
      <main className="flex flex-col gap-[32px] row-start-2 items-center sm:items-start">
        ここは牧場予定地
      </main>
      <footer className="row-start-3 flex gap-[24px] flex-wrap items-center justify-center">
        <a
          className="flex items-center gap-2 hover:underline hover:underline-offset-4"
          href=""
          target="_blank"
          rel="noopener noreferrer"
        >
          ご利用上の注意
        </a>

        <a
          className="flex items-center gap-2 hover:underline hover:underline-offset-4"
          href="https://github.com/fuwa-syugyo/github_farm"
          target="_blank"
          rel="noopener noreferrer"
        >
          GitHub
        </a>
        © 2025 fuwa-syugyo
      </footer>
    </div>
  );
}
