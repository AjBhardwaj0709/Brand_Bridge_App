const express = require("express");
const jwt = require("jsonwebtoken")
const bcryptjs = require("bcryptjs");
const Users = require("../Model/user");
const authRouters = express.Router();

// sing up 
authRouters.post("/api/signup", async (req, res) => {
    console.log("Signup route hit", req.body);
    try {
        console.log("Received signup request", req.body);
        const { name, email, password } = req.body;

        const existingUser = await Users.findOne({ email });
        console.log("Existing user check complete", existingUser);

        if (existingUser) {
            return res.status(400).json({ msg: "User already exists!" });
        }

        const hashedPassword = await bcryptjs.hash(password, 8);
        console.log("Password hashed");

        let newUser = new Users({
            name,
            email,
            password: hashedPassword,
        });

        newUser = await newUser.save();
        console.log('New user saved:', newUser);

        // Generate JWT token
        const token = jwt.sign({ id: newUser._id }, "passwordKey", { expiresIn: '1h' });
        console.log('JWT token generated:', token);

        res.status(200).json({ token, user: newUser });
    } catch (e) {
        res.status(500).json({ msg: e.message });
    }
});

//sign in 

authRouters.post("/api/login", async (req, res) => {
    console.log("Signin route hit", req.body);
    try {
        const { email, password } = req.body;
        const user = await Users.findOne({ email });
        console.log(' user loggedin:', user);

        if (!user) {
            return res
                .status(400)
                .json({ msg: "User with this email does not exist" });
        }
        const isMatch = await bcryptjs.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({ msg: "Incorrect Password" });
        }
        const token = jwt.sign({ id: user._id }, "passwordKey");
        res.json({ token, ...user._doc });
    } catch (e) {
        res.status(500).json({ error: e.message });
    }

});


module.exports = authRouters;