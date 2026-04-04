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

type NotificationSetting = {
	notify_hour: number
	enabled: boolean
} | null

type Props = {
	isOpen: boolean
	onClose: () => void
}

export default function NotificationSettingModal({ isOpen, onClose }: Props) {
	const [setting, setSetting] = useState<NotificationSetting>(null)

	const [notify_hour, setNotify_hour] = useState(21)
	const [enabled, setEnabled] = useState(true)

	useEffect(() => {
		if (!isOpen) return

		const fetchSetting = async () => {
			const res = await fetch("/backend/api/notification_setting", {
				credentials: "include",
			})
			if (!res.ok) return

			const json = await res.json()

			if (json.notification_setting) {
				setSetting(json.notification_setting)
				setNotify_hour(json.notification_setting.notify_hour)
				setEnabled(json.notification_setting.enabled)
			} else {
				setSetting(null)
			}
		}
		fetchSetting()
	}, [isOpen])

	if (!isOpen) return null

	const handleSave = async () => {
		await fetch("/backend/api/notification_setting", {
			credentials: "include",
			method: setting ? "PUT" : "POST",
			headers: {
				"Content-Type": "application/json",
			},
			body: JSON.stringify({
				notification_setting: {
					notify_hour,
					enabled,
				},
			}),
		})
		onClose()
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
					<div className="mt-6 flex items-center justify-between rounded-md border px-4 py-6">
						<Select
							value={String(notify_hour)}
							onValueChange={(v) => setNotify_hour(Number(v))}
							disabled={!enabled}
						>
							<SelectTrigger className="w-32 text-lg font-semibold">
								<SelectValue />
							</SelectTrigger>
							<SelectContent>
								{[12, 15, 18, 19, 20, 21, 22, 23].map((h) => (
									<SelectItem key={h} value={String(h)}>
										{h}:00
									</SelectItem>
								))}
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
