"use client"

import { useEffect, useState } from "react"
import { Button } from "@/components/ui/button"
import {
	Select,
	SelectContent,
	SelectItem,
	SelectTrigger,
	SelectValue,
} from "@/components/ui/select"
import { Switch } from "@/components/ui/switch"

type Props = {
	isOpen: boolean
	onClose: () => void
}

export default function NotificationSettingModal({ isOpen, onClose }: Props) {
	useEffect(() => {
		if (isOpen) {
			// TODO: 現在の通知時刻とactiveを取得
		}
	}, [isOpen])

	const [enabled, setEnabled] = useState(true)
	const [time, setTime] = useState("21:00")

	// TODO: 通知時刻のプルダウンとactiveのトグルスイッチを保存する処理を追加
	if (!isOpen) return null

	const handleSave = () => {
		console.log({ enabled, time })
	}

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
					<h2 className="text-2xl font-bold mb-4">通知設定</h2>
					{/* 時刻 + トグル */}
					<div className="mt-6 flex items-center justify-between rounded-md border px-4 py-6">
						{/* プルダウン（Select） */}
						<Select value={time} onValueChange={setTime} disabled={!enabled}>
							<SelectTrigger className="w-32 text-lg font-semibold">
								<SelectValue />
							</SelectTrigger>
							<SelectContent>
								<SelectItem value="12:00">12:00</SelectItem>
								<SelectItem value="15:00">15:00</SelectItem>
								<SelectItem value="18:00">18:00</SelectItem>
								<SelectItem value="19:00">19:00</SelectItem>
								<SelectItem value="20:00">20:00</SelectItem>
								<SelectItem value="21:00">21:00</SelectItem>
								<SelectItem value="22:00">22:00</SelectItem>
								<SelectItem value="23:00">23:00</SelectItem>
							</SelectContent>
						</Select>
						<Switch checked={enabled} onCheckedChange={setEnabled} />
					</div>
					<div>
						<Button variant="outline">キャンセル</Button>
						<Button onClick={handleSave}>保存</Button>
					</div>
				</div>
			</div>
		</div>
	)
}
