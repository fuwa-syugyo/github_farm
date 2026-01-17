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
		return [
			{
				source: "/backend/api/:path*",
				destination: "http://localhost:3001/api/:path*",
			},
		]
	},
}

export default nextConfig
