import { cache } from "react";

/** Base URL */
export const getApiUrl = cache(() =>
  process.env.NODE_ENV === "production"
    ? `${process.env.NEXT_PUBLIC_BASE_URL}/v1`
    : `${process.env.NEXT_PUBLIC_BASE_URL}:3000`
);

/** Assets URL */
export const getPublicUrl = cache(() =>
  process.env.NODE_ENV === "production"
    ? `${process.env.NEXT_PUBLIC_BASE_URL}/assets`
    : `${process.env.NEXT_PUBLIC_BASE_URL}:4200`
);
