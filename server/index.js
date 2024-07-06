const express = require("express");
const mongoose = require("mongoose");
const authRouters= require("./routers/auth");

const PORT = process.env.PORT || 3000;
const app = express();


app.use(express.json());
app.use(authRouters);

const db = "mongodb+srv://brandbridge45:rKUpqJZXpT4YxubI@cluster0.l5nwadx.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";
mongoose.connect(db).then(() => {
    console.log("Connected to MongoDB");
})
    .catch(err => {
        console.log(err);
    });

app.listen(PORT, "0.0.0.0", () => {
    console.log(`connected at port ${PORT}`);
});