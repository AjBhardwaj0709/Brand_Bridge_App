const express = require("express");
const bcryptjs = require("bcryptjs");
const Users = require("../Model/user");
const authRouters = express.Router();


// sing up 
authRouters.post("/api/signup", async (req, res) => {
    try {
        const { name, email, password } = req.body;
        // const user = await User.create({ name, email, password });
        const existingUser = await Users.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ msg: " User already Exist!" });
        }
        const hashedPassword = await bcryptjs.hash(password, 8);

        let User = new User({
            email, password: hashedPassword,
            name,
        });
        User = await User.save();
        res.json(user);

    }
    catch (e) {
        res.status(500).json({ msg: e.message });
    }

});

//sign in 

authRouters.post("/api/signin", async (req, res) => {
    try {
        const { email, password } = req.body;
        const user= await Users.findOne({email});
        if(!user){
            return res
            .status(400)
            .json({msg:"User with this email does not exist"});
        }
        const isMatch = await bcryptjs.compare(password,user.password);
        if(!isMatch){
            return res.status(400).json({msg:"Incorrect Password"});
    } 
    const token = jwt.sign({id:user._id},"passwordKey");
    res.json({token,...user._doc});
}catch(e){
    res.status(500).json({error:e.message});
}

});
module.exports = authRouters;