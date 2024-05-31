/** @type {import('next').NextConfig} */
const isProd = process.env.NODE_ENV === "production";

const nextConfig = {
  output: "standalone", // ビルドパッケージに含めるファイルをまとめる
  compress: true, // ビルドパッケージを圧縮する
  distDir: "dist", // ビルドしたアセットを dist ディレクトリに出力
  assetPrefix: isProd ? process.env.NEXT_PUBLIC_STATIC_FOLDER : "",
};

export default nextConfig;
