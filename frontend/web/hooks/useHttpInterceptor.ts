// src/hooks/useHttpInterceptor.js
import { useCallback } from "react";
import crypto from "crypto";

const useHttpInterceptor = () => {
  return useCallback(async (url, options) => {
    if (options.method === "POST" || options.method === "PUT") {
      const body = options.body || "";
      const sha256 = crypto.createHash("sha256").update(body).digest("hex");
      options.headers = {
        ...options.headers,
        "x-amz-content-sha256": sha256,
      };
    }
    return fetch(url, options);
  }, []);
};

export default useHttpInterceptor;
