/** @type {import('next').NextConfig} */
const nextConfig = {
  output: "standalone",
  assetPrefix: `${process.env.NEXT_PUBLIC_BASE_URL}/assets`,
  compress: true,
};

export default nextConfig;
