const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const User = require('../models/users')

const MoneySchema = new mongoose.Schema({
    userid: {
        type: Schema.Types.ObjectId,
        ref: User.modelName
    },
    title: String,
    type: String,
    money: Number
});

const Money = mongoose.model("Money",MoneySchema);
module.exports = Money;