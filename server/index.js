

const express = require("express");
const mongoose = require("mongoose");
const authRouters = require("./routers/auth");
const profileRouter = require('./routers/profileRoutes');
const cors = require('cors');
require('dotenv').config();


const app = express();
const PORT = process.env.PORT || 3000;
const MONGODB_URI = process.env.MONGODB_URI;

// CORS configuration
const corsOptions = {
    origin: '*',
    methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
    allowedHeaders: '*',
};

// Middleware
app.use(cors(corsOptions));
app.use(express.json());
app.use(authRouters);
app.use (profileRouter);

// Connect to MongoDB

mongoose.connect(MONGODB_URI)
    .then(() => {
        console.log("Connected to MongoDB");
    })
    .catch(err => {
        console.error("MongoDB connection error:", err);
    });


// Start the server
app.listen(PORT, "0.0.0.0", () => {
    console.log(`Server running on http://localhost:${PORT}`);
});
