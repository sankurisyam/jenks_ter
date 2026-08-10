"use client";

import { ChangeEvent, useState } from "react";

export default function Home() {
  const [file, setFile] = useState<File | null>(null);
  const [message, setMessage] = useState("");

  function handleFileChange(event: ChangeEvent<HTMLInputElement>) {
    const selectedFile = event.target.files?.[0];

    if (selectedFile) {
      setFile(selectedFile);
    }
  }

  async function uploadImage() {
    if (!file) {
      setMessage("Please select an image");
      return;
    }

    const formData = new FormData();

    formData.append("file", file);

    setMessage("Uploading...");

    const response = await fetch("/api/upload", {
      method: "POST",
      body: formData,
    });

    const data = await response.json();

    if (!response.ok) {
      setMessage(data.error ?? "Upload failed");
      return;
    }

    setMessage(`Upload successful: ${data.key}`);
  }

  return (
    <main className="flex min-h-screen flex-col items-center justify-center gap-6">
      <h1 className="text-3xl font-bold">
        ImageVault
      </h1>

      <input
        type="file"
        accept="image/*"
        onChange={handleFileChange}
      />

      <button
        onClick={uploadImage}
        className="rounded bg-black px-5 py-2 text-white"
      >
        Upload Image
      </button>

      <p>{message}</p>
    </main>
  );
}