/** @type {import('next').NextConfig} */
const isProd = process.env.NODE_ENV === "production";

const nextConfig = {
  output: "standalone", // ビルドパッケージに含めるファイルをまとめる
  distDir: "dist", // ビルドしたアセットを dist ディレクトリに出力
  assetPrefix: isProd ? "https://d2j9tl78967y2b.cloudfront.net" : "",
  publicRuntimeConfig: {
    staticFolder: isProd ? "https://d2j9tl78967y2b.cloudfront.net" : "",
  },
  serverRuntimeConfig: {
    staticFolder: isProd ? "https://d2j9tl78967y2b.cloudfront.net" : "",
  },
};

export default nextConfig;
