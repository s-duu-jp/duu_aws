# Build環境
FROM imbios/bun-node AS builder

# 作業ディレクトリを設定
WORKDIR /builder

# プロジェクトの依存関係のファイルを先にコピー
COPY package.json bun.lockb next.config.mjs ./

# 依存関係のインストール
RUN bun install --frozen-lockfile

# sharpモジュールのインストール
RUN npm install sharp

# ビルドに必要なファイルのみをコピー
COPY . .

# プロジェクトを本番ビルド
RUN bun run build

# 実行環境
FROM node:20.13.1-slim AS runner

# 作業ディレクトリを設定
WORKDIR /app
COPY --from=builder /builder/public ./public
COPY --from=builder /builder/.next/static ./.next/static
COPY --from=builder /builder/.next/standalone ./

CMD ["node", "server.js"]
