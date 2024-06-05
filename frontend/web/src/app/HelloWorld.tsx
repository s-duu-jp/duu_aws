import React from "react";
import { getBaseUrl } from "../../lib/getBaseUrl";
import crypto from "crypto";
import useHttpInterceptor from "../../hooks/useHttpInterceptor";

export default async function HelloWorld() {
  const fetchWithInterceptor = useHttpInterceptor();

  const url = `${getBaseUrl()}/api/sample?delay=0`;
  const method = "POST";
  const body = JSON.stringify({ message: "Hello, World!" });

  const response = await fetchWithInterceptor(url, {
    method,
    headers: {
      "Content-Type": "application/json",
    },
    body,
    cache: "no-store",
  });

  const resData = await response.json();

  return <div>res : {JSON.stringify(resData)}</div>;
}
