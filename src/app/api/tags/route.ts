export async function GET(res: Response) {
  const response: any = await fetch(
    process.env.NEXT_PUBLIC_OLLAMA_URL + "/api/tags",
    {
      method: "GET",
    }
  );
  console.log(response)
  if (!response) {
    return console.log("error");
  }
  // Create a new ReadableStream from the response body
  const headers = new Headers(response.headers);
  headers.set("Content-Type", "application/json");
  // Create a new ReadableStream from the response body

  // Set response headers and return the stream
  return new Response(response, { headers });
}
