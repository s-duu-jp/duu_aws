import { cache } from 'react';

export const getPublicUrl = process.env.NODE_ENV === "production" ? process.env.NEXT_PUBLIC_STATIC_FOLDER : ""

export const getBaseUrl = cache(() =>
    process.env.NODE_ENV === "production"
        ? "https://jbs56ogq6xhrsfdavhq5isgo6m0bfidk.lambda-url.ap-northeast-1.on.aws"
        : `http://127.0.0.1:${process.env.PORT ?? 3000}`,
);
