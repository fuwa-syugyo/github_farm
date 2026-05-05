"use client"

import Image from "next/image"
import { useEffect, useState } from "react"

type Animal = {
	id: number
	name: string
	recovery_days: number
	escape_days: number
	image_url: string
}

type UserAnimal = {
	id: number
	animal_id: number
	created_at: string
}

type Props = {
	isOpen: boolean
	onClose: () => void
}

export default function AnimalSelectionModal({ isOpen, onClose }: Props) {
	const [animals, setAnimals] = useState<Animal[]>([])
	const [userAnimals, setUserAnimals] = useState<UserAnimal[]>([])

	useEffect(() => {
		if (isOpen) {
			fetch(`/api/animals`, { cache: "no-store" })
				.then((res) => res.json())
				.then((data) => setAnimals(data))
				.catch((err) => console.error("Failed to fetch animals:", err))

			fetch(`/api/user_animals`, {
				credentials: "include",
				cache: "no-store",
			})
				.then((res) => {
					if (!res.ok) throw new Error("Failed to fetch user animals")
					return res.json()
				})
				.then((data) => {
					if (Array.isArray(data)) {
						setUserAnimals(data)
					} else {
						console.error("Unexpected response format:", data)
						setUserAnimals([])
					}
				})
				.catch((err) => {
					console.error("Failed to fetch user animals:", err)
					setUserAnimals([])
				})
		}
	}, [isOpen])

	const handleSelect = async (animalId: number) => {
		const activeAnimal = userAnimals.length > 0

		if (activeAnimal) {
			const confirmed = window.confirm(
				"他の動物を選択しています。選ぶ動物を変更すると、今まで草を与えた日数はリセットされますがよろしいですか？",
			)
			if (!confirmed) return
		}

		try {
			const res = await fetch(`/api/user_animals`, {
				method: "POST",
				headers: {
					"Content-Type": "application/json",
				},
				credentials: "include",
				body: JSON.stringify({ user_animal: { animal_id: animalId } }),
			})

			if (res.ok) {
				alert("動物を選びました！")
				onClose()
			} else {
				console.error("Failed to select animal")
				alert("動物の選択に失敗しました")
			}
		} catch (err) {
			console.error("Error selecting animal:", err)
			alert("エラーが発生しました")
		}
	}

	const getDaysRemaining = (animal: Animal, userAnimal: UserAnimal) => {
		// 日付のみで比較するため、時間を0:00扱いにして差分を計算(現状は仮)
		// TODO: feed_daysの実装をしたらロジックをちゃんと書く
		const today = new Date().setHours(0, 0, 0, 0)
		const created = new Date(userAnimal.created_at).setHours(0, 0, 0, 0)

		const daysPassed = (today - created) / (1000 * 60 * 60 * 24)
		return Math.max(0, animal.recovery_days - daysPassed)
	}

	if (!isOpen) return null

	return (
		<div className="fixed inset-0 bg-black/50 flex justify-center items-center z-50 p-4">
			<div className="relative w-full max-w-2xl">
				<button
					type="button"
					onClick={onClose}
					className="absolute -top-12 -right-2 text-white bg-black/50 rounded-full w-8 h-8 flex items-center justify-center hover:bg-black/70 z-10"
				>
					✕
				</button>

				<div className="bg-white p-6 rounded-lg shadow-lg w-full max-h-[80vh] overflow-y-auto">
					<h2 className="text-2xl font-bold mb-4">動物を選んでください</h2>

					<div className="grid grid-cols-1 md:grid-cols-2 gap-4">
						{animals.map((animal) => {
							const userAnimal = userAnimals.find(
								(ua) => ua.animal_id === animal.id,
							)
							const isSelected = !!userAnimal
							const daysRemaining =
								isSelected && userAnimal
									? getDaysRemaining(animal, userAnimal)
									: null

							return (
								<div
									key={animal.id}
									className="border rounded-lg p-4 flex flex-col items-center"
								>
									<div className="relative w-32 h-32 mb-2">
										<Image
											src={animal.image_url}
											alt={animal.name}
											fill
											className="object-contain"
										/>
									</div>
									<h3 className="text-xl font-semibold">{animal.name}</h3>
									<p className="text-sm text-gray-600">
										回復日数: {animal.recovery_days}日
									</p>
									<p className="text-sm text-gray-600">
										脱走日数: {animal.escape_days}日
									</p>

									{isSelected ? (
										<div className="mt-4 w-full text-center">
											<button
												type="button"
												disabled
												className="bg-gray-400 text-white px-4 py-2 rounded w-full cursor-not-allowed font-bold"
											>
												選択中
											</button>
											<p className="text-red-500 font-bold mt-2">
												クリアまであと{daysRemaining}日
											</p>
										</div>
									) : (
										<button
											type="button"
											onClick={() => handleSelect(animal.id)}
											className="mt-4 bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600 w-full"
										>
											選ぶ
										</button>
									)}
								</div>
							)
						})}
					</div>
				</div>
			</div>
		</div>
	)
}
