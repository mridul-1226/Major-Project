import mongoose from "mongoose";

const userSchema = mongoose.Schema({
    fullName: {
        type: String,
        required: true,
      },
      email: {
        type: String,
        required: true,
      },
      phone: {
        type: Number,
        required: true,
      },
      address: {
        type: String,
        required: true,
      },
      FatherName:{
        type: String,
      required: true,
    },
    FatherNumber:{
        type: String,
      required: true,
    },   
    Gender:{
        type:String,
        enum: ["Male", "Female"],
        required: true,

    }, dob: {
        type: Date,
        required: true,
      },
      branch:{
        type:String,
        enum: ["CS", "EE","EL"],
      }

    

})