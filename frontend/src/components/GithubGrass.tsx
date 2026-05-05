"use client"

import { addDays, format, startOfWeek, subDays } from "date-fns"
import { useEffect, useState } from "react"
import ActivityCalendar, { type Activity } from "react-activity-calendar"

type User = {
	id: number
	name: string
	uid: string
	image_url: string
}

type Props = {
	user: User | null
}

type ActivityData = {
	date: string
	count: number
}

export default function GithubGrass({ user }: Props) {
	const [data, setData] = useState<Activity[] | null>(null)

	const minimalTheme = {
		light: ["#ebedf0", "seagreen"],
	}

	useEffect(() => {
		if (!user) return

		fetch(`/api/github/contributions`, {
			credentials: "include",
		})
			.then((res) => res.json())
			.then((json) => {
				if (!Array.isArray(json)) {
					console.error("Unexpected response:", json)
					return
				}

				const formatted = json.map((item: ActivityData) => ({
					date: item.date,
					count: item.count > 0 ? 1 : 0, // 草がある日は1
					level: item.count > 0 ? 1 : 0, // 色も2段階（あり/なし）
				}))

				// 今日から30日前程度の日曜日まで表示する
				// 初回ログインから30日経過していない場合、ブランクのマスで埋める(見栄えの問題)
				// ロジックの詳細な確認はテストの時にでも(APIからのレスポンスはモックで)
				const today = new Date()
				const rawStartDate = subDays(today, 30)
				const startDate = startOfWeek(rawStartDate, { weekStartsOn: 0 })
				const allDays = []

				for (let d = startDate; d <= today; d = addDays(d, 1)) {
					const dateStr = format(d, "yyyy-MM-dd")
					const found = formatted.find((item) => item.date === dateStr)
					allDays.push(found || { date: dateStr, count: 0, level: 0 })
				}

				setData(allDays)
			})
			.catch((err) => console.error(err))
	}, [user])

	if (!user) return null

	return (
		<div className="p-6">
			{user && (
				<>
					<h2 className="text-xl mb-4">最近の草</h2>
					{!data ? (
						<p>読み込み中...</p>
					) : (
						<ActivityCalendar
							data={data}
							theme={minimalTheme}
							hideColorLegend={true}
							hideTotalCount={true}
							maxLevel={1}
							showWeekdayLabels={true}
							colorScheme="light"
						/>
					)}
				</>
			)}
		</div>
	)
}
