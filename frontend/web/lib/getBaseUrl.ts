import { cache } from "react";

/** Base URL */
export const getBaseUrl = cache(() => process.env.NEXT_PUBLIC_BASE_URL);

/** Assets URL */
export const getPublicUrl = cache(() => process.env.NEXT_PUBLIC_ASET_URL);
