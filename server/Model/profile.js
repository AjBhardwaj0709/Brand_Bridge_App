// models/profile.js
const mongoose = require('mongoose');

const profileSchema = new mongoose.Schema({
    name: { type: String, required: true },
    username: { type: String, required: true, unique: true },
    bio: { type: String, default: '' },
    //   profileImage: { type: String, default: '' }, // URL or path to profile image
});

module.exports = mongoose.model('Profile', profileSchema);
