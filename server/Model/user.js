const mongoose = require("mongoose");

const userSchema = mongoose.Schema({
    name: {
        required: true,
        type: String,
        trim: true,
    },
    email: {
        required: true,
        unique: true,
        type: String,
        trim: true,
        validate: {
            validator: (value) => {
                const re = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re);
            },
            mesaage: "Please Enter a valid Email",
        },
    },
    password: {
        type: String,
        required: true,
        minlength: 6,
    },

}, {timestamps:true});
const Users = mongoose.model("Users", userSchema);
module.exports = Users;
