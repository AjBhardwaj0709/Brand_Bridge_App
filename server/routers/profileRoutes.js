const express = require('express');
const router = express.Router();
const Profile = require('../Model/profile');
const User = require('../Model/user'); // Import User model
const authMiddleware = require('../Middleware/profile_auth_middleware'); // Import middleware

// Add New User Profile
router.post('/api/profile', authMiddleware, async (req, res) => {
    const { name, username, bio } = req.body;
    const userId = req.user.id; // Extract user ID from middleware
    
    try {
        // Check if the username already exists
        const existingProfile = await Profile.findOne({ username });
        if (existingProfile) {
            return res.status(400).json({ msg: 'Username already taken' });
        }

        // Create a new profile
        const newProfile = new Profile({
            name,
            username,
            bio,
            user: userId // Associate profile with user
        });

        // Save the profile to the database
        await newProfile.save();

        res.status(201).json(newProfile); // Return the created profile
    } catch (err) {
        res.status(500).json({ msg: 'Server Error' });
    }
});

// Get User Profile by Username
router.get('/api/:username', authMiddleware, async (req, res) => {
    try {
        const profile = await Profile.findOne({ username: req.params.username });
        if (!profile) return res.status(404).json({ msg: 'Profile not found' });
        res.json(profile);
    } catch (err) {
        res.status(500).json({ msg: 'Server Error' });
    }
});

// Update User Profile
router.put('/api/:username', authMiddleware, async (req, res) => {
    const { name, username, bio } = req.body;
    try {
        // Check if the new username is already taken
        const existingProfile = await Profile.findOne({ username });
        if (existingProfile && existingProfile.username !== req.params.username) {
            return res.status(400).json({ msg: 'Username already taken' });
        }

        // Update the Profile
        const updatedProfile = await Profile.findOneAndUpdate(
            { username: req.params.username },
            { name, username, bio },
            { new: true, runValidators: true }
        );
        if (!updatedProfile) return res.status(404).json({ msg: 'Profile not found' });
        res.json(updatedProfile);
    } catch (err) {
        res.status(500).json({ msg: 'Server Error' });
    }
});

module.exports = router;
