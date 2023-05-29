const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const User = require('../models/users')
const Work = require('../models/works')

const TaskSchema = new mongoose.Schema({
    userid: {
        type: Schema.Types.ObjectId,
        ref: User.modelName
    },
    workid: {
        type: Schema.Types.ObjectId,
        ref: Work.modelName
    },
    title: String,
    long: String,
    active: String
});

const Task = mongoose.model("Task",TaskSchema);
module.exports = Task;