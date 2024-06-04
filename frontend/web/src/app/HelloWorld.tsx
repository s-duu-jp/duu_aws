import React from "react";
import { getBaseUrl } from "../../lib/getBaseUrl";
import crypto from "crypto";

export default async function HelloWorld() {
  const url = `${getBaseUrl()}/api/sample?delay=3000`;
  const method = "POST";

  const accessKey = process.env.NEXT_PUBLIC_AWS_ACCESS_KEY_ID;
  const secretKey = process.env.NEXT_PUBLIC_AWS_SECRET_ACCESS_KEY;

  const region = "ap-northeast-1";
  const service = "lambda";
  const body = JSON.stringify({ message: "Hello, World!" });

  const date = new Date().toISOString().replace(/[:-]|\.\d{3}/g, "");
  const dateStamp = date.slice(0, 8);
  const amzDate = date + "Z";
  const payloadHash = crypto.createHash("sha256").update(body).digest("hex");

  const algorithm = "AWS4-HMAC-SHA256";
  const credentialScope = `${dateStamp}/${region}/${service}/aws4_request`;
  const signedHeaders = "content-type;host;x-amz-date;x-amz-content-sha256";

  const { hostname, pathname, search } = new URL(url);
  const canonicalUri = pathname;
  const canonicalQuerystring = search.slice(1); // Remove the leading '?'
  const canonicalHeaders = `content-type:application/json\nhost:${hostname}\nx-amz-content-sha256:${payloadHash}\nx-amz-date:${amzDate}\n`;
  const canonicalRequest = `${method}\n${canonicalUri}\n${canonicalQuerystring}\n${canonicalHeaders}\n${signedHeaders}\n${payloadHash}`;

  const stringToSign = `${algorithm}\n${amzDate}\n${credentialScope}\n${crypto
    .createHash("sha256")
    .update(canonicalRequest)
    .digest("hex")}`;

  const kDate = crypto
    .createHmac("sha256", `AWS4${secretKey}`)
    .update(dateStamp)
    .digest();
  const kRegion = crypto.createHmac("sha256", kDate).update(region).digest();
  const kService = crypto
    .createHmac("sha256", kRegion)
    .update(service)
    .digest();
  const kSigning = crypto
    .createHmac("sha256", kService)
    .update("aws4_request")
    .digest();
  const signature = crypto
    .createHmac("sha256", kSigning)
    .update(stringToSign)
    .digest("hex");

  const authorizationHeader = `${algorithm} Credential=${accessKey}/${credentialScope}, SignedHeaders=${signedHeaders}, Signature=${signature}`;

  const response = await fetch(url, {
    method,
    headers: {
      "Content-Type": "application/json",
      "x-amz-date": amzDate,
      "x-amz-content-sha256": payloadHash,
      Authorization: authorizationHeader,
    },
    body,
    cache: "no-store",
  });

  const resData = await response.json();

  return <div>res : {JSON.stringify(resData)}</div>;
}
