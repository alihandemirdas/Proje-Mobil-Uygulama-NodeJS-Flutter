const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const WorksSchema = new mongoose.Schema({
    userid: {
        type: String,
        default: ""
    },
    title: String,
    short: String,
    tasks: [{
        title: String,
        long: String,
    }],

});

const User = mongoose.model("User",UserSchema);
module.exports = User;