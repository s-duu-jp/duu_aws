/** @type {import('next').NextConfig} */
const isProd = process.env.NODE_ENV === "production";

const nextConfig = {
  output: "standalone",
  assetPrefix: isProd
    ? `${process.env.NEXT_PUBLIC_BASE_URL}/assets`
    : `${process.env.NEXT_PUBLIC_BASE_URL}:4200`,
  compress: true,
};

export default nextConfig;
