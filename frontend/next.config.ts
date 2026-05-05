import type { NextConfig } from "next"

const nextConfig: NextConfig = {
	images: {
		remotePatterns: [
			{
				protocol: "https",
				hostname: "avatars.githubusercontent.com",
			},
		],
	},
	async rewrites() {
		if (process.env.NODE_ENV === "development") {
			return [
				{
					source: "/api/:path*",
					destination: "http://localhost:3001/api/:path*",
				},
			]
		} else {
			return [
				{
					source: "/api/:path*",
					destination: "https://api.gh-farm.com/api/:path*",
				},
			]
		}
	},
}

export default nextConfig
