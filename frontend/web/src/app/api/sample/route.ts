export async function GET(request: Request) {
  const { searchParams } = new URL(request.url);
  const delay = searchParams.get('delay');

  if (delay) {
    await new Promise((resolve) => setTimeout(resolve, Number(delay)));
  }

  return new Response(JSON.stringify({}), {
    status: 200,
    headers: {
      'content-type': 'application/json',
    },
  });
}
