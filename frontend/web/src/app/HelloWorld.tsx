import React from "react";
import { getBaseUrl } from "../../lib/getBaseUrl";
import crypto from "crypto";

export default async function HelloWorld() {
  const url = `${getBaseUrl()}/api/sample?delay=3000`;
  const method = "POST";
  const body = JSON.stringify({ message: "Hello, World!" });

  const response = await fetch(url, {
    method,
    headers: {
      "Content-Type": "application/json",
      "x-amz-content-sha256": crypto
        .createHash("sha256")
        .update(body)
        .digest("hex"),
    },
    body,
    cache: "no-store",
  });

  const resData = await response.json();

  return <div>res : {JSON.stringify(resData)}</div>;
}
