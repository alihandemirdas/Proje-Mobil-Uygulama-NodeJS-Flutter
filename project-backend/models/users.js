const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const UserSchema = new mongoose.Schema({
    name: String,
    surname: String,
    email: String,
    username: String,
    password: String,
    token: {
        type: String,
        default: ""
    }
});

const User = mongoose.model("User",UserSchema);
module.exports = User;