export async function POST(request: Request) {
  const { searchParams } = new URL(request.url);
  const delay = searchParams.get("delay");
  const body = await request.json();

  if (delay) {
    await new Promise((resolve) => setTimeout(resolve, Number(delay)));
  }

  return new Response(JSON.stringify(body), {
    status: 200,
    headers: {
      "content-type": "application/json",
    },
  });
}
