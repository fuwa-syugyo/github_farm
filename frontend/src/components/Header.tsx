"use client"

import Image from "next/image"
import { useState } from "react"
import AnimalSelectionModal from "./AnimalSelectionModal"
import NotificationSettingModal from "./NotificationSettingModal"

type User = {
	id: number
	name: string
	uid: string
	image_url: string
}

type Props = {
	user: User | null
}

export default function Header({ user }: Props) {
	const [isModalOpen, setIsModalOpen] = useState(false)

	return (
		<>
			<header className="w-full bg-green-500 text-white px-6 py-4 flex justify-between items-center shadow-md">
				<h1 className="text-2xl font-bold tracking-wide">ぎっとはぶ牧場</h1>
				<div className="flex items-center gap-4">
					{user && (
						<>
							<button
								type="button"
								onClick={() => setIsModalOpen(true)}
								className="bg-white text-black border border-black px-4 py-2 rounded hover:bg-gray-100 font-bold"
							>
								通知設定
							</button>
							<button
								type="button"
								onClick={() => setIsModalOpen(true)}
								className="bg-white text-black border border-black px-4 py-2 rounded hover:bg-gray-100 font-bold"
							>
								動物選択
							</button>
							<Image
								src={user.image_url}
								alt={user.name}
								className="w-8 h-8 rounded-full border border-gray-500 bg-white"
								width={100}
								height={100}
							/>
						</>
					)}

					{user ? (
						<button
							type="button"
							onClick={() => {
								window.location.href = "http://localhost:3001/logout"
							}}
							className="bg-gray-600 text-white px-4 py-2 rounded hover:bg-gray-700"
						>
							ログアウト
						</button>
					) : (
						<button
							type="button"
							onClick={() => {
								window.location.href = "http://localhost:3001/auth/github"
							}}
							className="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-800"
						>
							Github連携
						</button>
					)}
				</div>
			</header>
			<AnimalSelectionModal
				isOpen={isModalOpen}
				onClose={() => setIsModalOpen(false)}
			/>
			<NotificationSettingModal
				isOpen={isModalOpen}
				onClose={() => setIsModalOpen(false)}
			/>
		</>
	)
}
