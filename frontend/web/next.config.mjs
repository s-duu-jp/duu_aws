/** @type {import('next').NextConfig} */
const nextConfig = {
  output: "standalone",
  assetPrefix: process.env.NEXT_PUBLIC_ASET_URL,
  compress: true,
};

export default nextConfig;
