import cors from 'cors'
import dotenv from 'dotenv'
import express from 'express'
import { connectDb } from './Db/db.js'
import userRouter from './routes/user.route.js'




dotenv.config()


const PORT = process.env.PORT|| 3300


const app = express()

connectDb();
app.get("/", (req, res) => {
    return res.send("hello");
  });

app.use(express.json())
app.use(cors())
app.use("/api/v1/user",userRouter)


app.listen(process.env.PORT,()=>{
    console.log(`Server started on http://localhost:${3300 || process.env.PORT}`);

})