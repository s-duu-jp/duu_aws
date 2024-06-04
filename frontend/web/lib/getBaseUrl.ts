import { cache } from "react";

/** Base URL */
export const getBaseUrl = cache(() => process.env.NEXT_PUBLIC_BASE_URL);

/** Assets URL */
export const getPublicUrl = cache(() =>
  process.env.NODE_ENV === "production"
    ? `${process.env.NEXT_PUBLIC_BASE_URL}/assets`
    : `${process.env.NEXT_PUBLIC_BASE_URL}`
);
