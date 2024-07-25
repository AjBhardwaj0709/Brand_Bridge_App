const mongoose = require('mongoose');

const profileSchema = mongoose.Schema({
    name: {
        type: String,
        required: true,
    },
    username: {
        type: String,
        required: true,
        unique: true,
    },
    bio: {
        type: String,
    },
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Users',
        required: true,
    }
}, { timestamps: true });

const Profile = mongoose.model('Profile', profileSchema);
module.exports = Profile;
