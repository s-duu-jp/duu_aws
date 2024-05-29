import Image from "next/image";
import getConfig from "next/config";

export default function Home() {
  const publicUrl = getConfig().publicRuntimeConfig.staticFolder;

  return (
    <>
      <p>以下に猫の画像を表示します。</p>
      <Image
        src={`${publicUrl}/images/cat.png`}
        width={390}
        height={520}
        alt="猫"
      />
    </>
  );
}
