import express from 'express'
import dotenv from 'dotenv'
import cors from 'cors'




dotenv.config()


const PORT = process.env.PORT || 3300


const app = express()


app.get("/",(_,res)=>{
    return res.status(200).json({
        message:"I am coming from backend",
        success:true
    })
})

app.use(express.json())
app.use(cors())


app.listen(process.env.PORT ||3300,()=>{
    console.log(`Server started on http://localhost:${3300 || process.env.PORT}`);

})