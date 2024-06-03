import Image from "next/image";
import { Suspense } from "react";
import HelloWorld from "./HelloWorld";
import { getPublicUrl } from "../../lib/getBaseUrl";

export default function Home() {
  return (
    <>
      <p>以下に猫の画像を表示します。</p>
      <Image
        src={`${getPublicUrl()}/images/cat.png`}
        width={390}
        height={520}
        alt="猫"
      />
      <hr />
      <p>SSRのテスト</p>

      <Suspense fallback={<p>Loading...</p>}>
        <HelloWorld />
      </Suspense>
    </>
  );
}
