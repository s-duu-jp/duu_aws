import Image from "next/image";

export default function Home() {
  return (
    <>
      <p>Cat</p>
      <Image src="/images/cat.png" width={390} height={520} alt="猫" />
    </>
  );
}
