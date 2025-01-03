import express from 'express'
import { register, sendOtp, verifyOtp } from '../controller/user.controller.js'


const userRouter= express.Router()

userRouter.post("/send-otp",sendOtp)
userRouter.post("/register",register)
userRouter.post("/verify",verifyOtp)


export default userRouter;