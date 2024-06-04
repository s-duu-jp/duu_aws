import Image from "next/image";
import { Suspense } from "react";
import HelloWorld from "./HelloWorld";
import { getPublicUrl } from "../../lib/getBaseUrl";

export default function Home() {
  return (
    <>
      <p>SSRのテスト</p>
      <Suspense fallback={<p>Loading...</p>}>
        <HelloWorld />
      </Suspense>
    </>
  );
}
