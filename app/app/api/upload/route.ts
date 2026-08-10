import { NextResponse } from "next/server"
import { S3Client, PutObjectCommand } from "@aws-sdk/client-s3"

const s3 = new S3Client({
    region: process.env.AWS_REGION
})

export async function POST(request: Request) {

    try {
        const formdata = await request.formData()

        const file = formdata.get("file")

        if (!(file instanceof File)) {
            return NextResponse.json(
                {
                    error: "no file provided"
                },
                {
                    status: 400
                }
            )
        }

        const buffer = Buffer.from(
            await file.arrayBuffer()
        )

        const key = `images/${crypto.randomUUID()}-${file.name}`

        const command = new PutObjectCommand({
            Bucket: process.env.S3_BUCKET_NAME,
            Key: key,
            Body: buffer,
            ContentType: file.type
        })

        await s3.send(command)

        return NextResponse.json({
            message: "upload successful",
            key
        })

    } catch (error) {

        console.error("s3 upload error", error)

        return NextResponse.json(
            {
                error: "upload failed"
            },
            {
                status: 500
            }
        )
    }
}