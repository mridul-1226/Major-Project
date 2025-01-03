import mongoose from "mongoose";
import dotenv from "dotenv"

dotenv.config()

export const connectDb=async()=>{
    try{
        await mongoose.connect(process.env.db_url)
        console.log("Db connected")

    }catch(error){
        console.error("Db connection failed",error)
    }

}