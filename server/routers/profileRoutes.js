const express = require('express');
const router = express.Router();
const Profile = require('../Model/profile');

//Get User Profile by username 

router.get('/:username', async (req, res) => {
    try {
        const profile = await Profile.findOne({ username: req.params.username });
        if (!profile) return res.status(404).json({ msg: 'Profile not found' });
        res.json(profile);
    } catch (err) {
        res.status(500).json({ msg: 'Server Error' });
    }
});

//Upate User Profile
router.put('/:username', async (req, res) => {
    const { name, username, bio } = res.body;
    try {
        //check if the new username is already taken
        const existingProfile = await Profile.findOne({ username });
        if (existingProfile && existingProfile.username !== req.params.username) {
            return res.status(400).json({ msg: 'Username already taken' });
        }

        //Update the Profile

        const updatedprofile = await Profile.findByIdAndUpdate(

            { username: req.params.username },
            { name, username, bio },
            { new: true }

        );
        if (!updatedprofile) return res.status(404).json({ msg: 'Profile not find' });
        res.json(updatedprofile);
    } catch (err) {
        res.status(500).json({ msg: 'Server Error' });

    }
});
module.exports = router;