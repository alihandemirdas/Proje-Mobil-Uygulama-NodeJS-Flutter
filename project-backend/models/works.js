const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const User = require('../models/users')

const WorksSchema = new mongoose.Schema({
    userid: {
        type: Schema.Types.ObjectId,
        ref: User.modelName
    },
    title: String,
    status: String,
    short: String,
    lastDate: String,
    money: Number
});

const Work = mongoose.model("Work",WorksSchema);
module.exports = Work;