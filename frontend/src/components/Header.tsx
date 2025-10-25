"use client";

import Image from 'next/image'

type User = {
  id: number;
  name: string;
  uid: string;
  image_url: string;
}

type Props = {
  user: User | null;
};

export default function Header({ user }: Props) {
  return (
    <header className="w-full bg-green-500 text-white px-6 py-4 flex justify-between items-center shadow-md">
      <h1 className="text-2xl font-bold tracking-wide">Github牧場</h1>
      <div className="flex items-center gap-4">
        {user && (
          <Image
            src={user.image_url}
            alt={user.name}
            className="w-8 h-8 rounded-full border border-gray-500 bg-white"
            width={100}
            height={100}
          />
        )}

        {user ? (
          <button
            onClick={() => (window.location.href = 'http://localhost:3001/logout')}
            className="bg-gray-600 text-white px-4 py-2 rounded hover:bg-gray-700"
          >
            ログアウト
          </button>
        ) : (
          <button
            onClick={() => (window.location.href = 'http://localhost:3001/auth/github')}
            className="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-800"
          >
            Github連携
          </button>
        )}
      </div>
    </header>
  );
}
