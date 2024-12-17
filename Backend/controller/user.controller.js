import crypto from 'crypto';
import nodemailer from 'nodemailer';
import OTP from '../models/Otp.model.js';
import User from '../models/user.model.js';

// In-memory OTP store (use Redis or database for production)
const otpStore = new Map();

// Send OTP
const transporter = nodemailer.createTransport({
    host: 'smtp.ethereal.email',
    port: 587,
    secure: false,
    requireTLS: true,
    auth: {
        user: "merlin.gottlieb@ethereal.email",
        pass: "EbFvjhNgt5n6dc1hN5"
    }
});
export const sendOtp = async (req, res) => {
    const { email, registrationNumber } = req.body;

    try {
       
        const user = await User.findOne({ email, registrationNumber });
        if (!user) {
            return res.status(404).json({ message: 'User not found' });
        }

        const otp = crypto.randomInt(100000, 999999).toString();
        const expiresAt = new Date(Date.now() + 5 * 60 * 1000); // 5 minutes

        await OTP.create({ email, otp, expiresAt });

        // Send OTP via email
        const info = await transporter.sendMail({
            from: "merlin.gottlieb@ethereal.email",
            to: email,
            subject: 'Your OTP for Login',
            text: `Your OTP is: ${otp}. It is valid for 5 minutes.`,
            html: `<p>Your OTP is: <b>${otp}</b>. It is valid for 5 minutes.</p>`,
        });

        console.log('Preview URL:', nodemailer.getTestMessageUrl(info));
        res.status(200).json({ message: 'OTP sent successfully', preview: nodemailer.getTestMessageUrl(info),otp });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Error sending OTP' });
    }
};

// Verify OTP
export const verifyOtp = async (req, res) => {
    const { email, otp } = req.body;

    try {
        // Fetch the latest OTP for the given email
        const otpRecord = await OTP.findOne({ email }).sort({ expiresAt: -1 });

        if (!otpRecord) {
            return res.status(400).json({ message: 'OTP expired or not found' });
        }

        // Check OTP expiry
        if (otpRecord.expiresAt < new Date()) {
            await OTP.deleteMany({ email }); // Clear expired OTPs
            return res.status(400).json({ message: 'OTP expired' });
        }

        // Validate OTP
        if (otpRecord.otp === otp) {
            await OTP.deleteMany({ email }); // Clear all OTPs for the user
            return res.status(200).json({ message: 'Login successful' });
        } else {
            return res.status(400).json({ message: 'Invalid OTP' });
        }
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Error verifying OTP' });
    }
};



export const register = async (req, res) => {
    const { registrationNumber, email } = req.body;

    // Check if registrationNumber or email is missing
    if (!registrationNumber || !email) {
        return res.status(400).json({ message: 'Registration number and email are required' });
    }

    try {
        // Check if the registrationNumber or email already exists
        const existingUser = await User.findOne({
            $or: [{ registrationNumber }, { email }]
        });

        if (existingUser) {
            return res.status(400).json({
                message: 'User with this registration number or email already exists'
            });
        }

        // Create a new user
        const newUser = new User({ registrationNumber, email });
        await newUser.save();

        res.status(201).json({
            message: 'User registered successfully',
            user: { registrationNumber: newUser.registrationNumber, email: newUser.email }
        });
    } catch (error) {
        console.error('Error during registration:', error);
        res.status(500).json({
            message: 'Internal server error',
            error: error.message
        });
    }
};
