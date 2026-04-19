"use client"

import { useEffect, useState } from "react"
import GithubGrass from "@/components/GithubGrass"
import Header from "@/components/Header"

const API_URL = process.env.NEXT_PUBLIC_API_URL!

function urlBase64ToUint8Array(base64String: string) {
	const padding = "=".repeat((4 - (base64String.length % 4)) % 4)
	const base64 = (base64String + padding).replace(/-/g, "+").replace(/_/g, "/")

	const rawData = window.atob(base64)
	return Uint8Array.from([...rawData].map((char) => char.charCodeAt(0)))
}

export default function Page() {
	const [user, setUser] = useState(null)
	const registerPush = async () => {
		await Notification.requestPermission()

		const registration = await navigator.serviceWorker.register("/sw.js")

		const subscription = await registration.pushManager.subscribe({
			userVisibleOnly: true,
			applicationServerKey: urlBase64ToUint8Array(
				process.env.NEXT_PUBLIC_VAPID_PUBLIC_KEY!,
			),
		})

		await fetch(`${API_URL}/push_subscriptions`, {
			method: "POST",
			headers: {
				"Content-Type": "application/json",
			},
			body: JSON.stringify({ subscription }),
			credentials: "include",
		})
	}

	const sendPush = async () => {
		await fetch(`${API_URL}/push`, {
			method: "POST",
			credentials: "include",
		})
	}

	useEffect(() => {
		const fetchCurrentUser = async () => {
			const res = await fetch(`${API_URL}/api/current_user`, {
				credentials: "include",
				cache: "no-store",
			})
			if (res.ok) {
				const data = await res.json()
				setUser(data.logged_in ? data.user : null)
			}
		}
		fetchCurrentUser()
	}, [])

	return (
		<div className="font-sans grid grid-rows-[20px_1fr_20px] items-center justify-items-center min-h-screen p-8 pb-20 gap-16 sm:p-20">
			<Header user={user} />
			<div style={{ padding: 40 }}>
				<button onClick={registerPush}>Push登録</button>
				<br />
				<br />
				<button onClick={sendPush}>テスト通知送信</button>
			</div>
			<main className="flex flex-col gap-[32px] row-start-2 items-center sm:items-start">
				<GithubGrass user={user} />
			</main>
			<footer className="row-start-3 flex gap-[24px] flex-wrap items-center justify-center">
				※本サービスはGitHub社とは一切関係ありません。
				<a
					className="flex items-center gap-2 hover:underline hover:underline-offset-4"
					href="https://github.com/fuwa-syugyo/github_farm"
					target="_blank"
					rel="noopener noreferrer"
				>
					GitHub
				</a>
				© 2026 fuwa-syugyo
			</footer>
		</div>
	)
}
