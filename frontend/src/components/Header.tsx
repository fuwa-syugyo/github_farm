"use client";

export default function Header() {
  const handleGithubLogin = () => {
    window.location.href = "http://localhost:3001/auth/github";
  };

  return (
    <header className="p-4 flex justify-end w-full">
      <button
        onClick={handleGithubLogin}
        className="bg-gray-800 text-white px-4 py-2 rounded hover:bg-gray-700"
      >
        GitHub連携
      </button>
    </header>
  );
}
