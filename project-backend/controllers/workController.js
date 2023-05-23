const Work = require('../models/works')
const Task = require('../models/tasks')
const mongoose = require('mongoose');


const addWork = async (req,res) => {
    
    console.log("Method Type: POST | Add Work\n")
    console.log(req.body);
    console.log("\n\n")
    let {userid,title,status,short, lastDate, money} = req.body;
    userid = userid.trim();
    title = title.trim();
    status = status.trim();
    money = parseFloat(money)


    const work = new Work({
        userid,
        title,
        status,
        short,
        lastDate,
        money
    })

    work.save()
    .then(result => {
        res.json({
            status: "SUCCESS",
            message: "İş ekleme başarıyla tamamlandı",
            workid: result._id
        })
    })
    .catch(err => {
        console.log(err)
        res.json({
            status: "FAILED",
            message: "İş eklenirken bir hata oluştu."
        })
    })
    
}

async function deleteTasksByWorkId(workid) {
    try {
        const result = await Task.deleteMany({ workid: workid })
        .then(result => {
            console.log("Belirtilen taskler silindi");
        })
        .catch(err => {
            console.log("Bir hata oluştu"+err);
        })
    } catch (err) {
      console.error('Hata:', err);
    }
}

const deleteWork = async (req,res) => {
    console.log("Method Type: POST | Delete Work\n")
    console.log(req.body);
    console.log("\n\n")
    let {workid} = req.body;
    deleteTasksByWorkId(workid);

    Work.findByIdAndDelete(workid)
    .then(result => {
        res.json({
            status: "SUCCESS",
            message: "İş ve işe ait görevler silindi.",
            data: result
        })
    })
    .catch(err => {
        res.json({
            status: "FAILED",
            message: "Silme aşamasında bir hata oluştu.",
            data: err
        })
    })


}

const deleteTask = async (req,res) => {
    console.log("Method Type: POST | Delete Task\n")
    console.log(req.body);
    console.log("\n\n")
    let {taskid} = req.body;

    Task.findByIdAndDelete(taskid)
    .then(result => {
        res.json({
            status: "SUCCESS",
            message: "Görev başarıyla silindi.",
            data: result
        })
    })
    .catch(err => {
        res.json({
            status: "FAILED",
            message: "Silme aşamasında bir hata oluştu.",
            data: err
        })
    })


}

const updateWorkStatus = async (req,res) => {
    console.log("Method Type: POST | updateWorkStatus\n")
    console.log(req.body);
    console.log("\n\n")
    let {id, status} = req.body;

    Work.findByIdAndUpdate({ _id: id }, { $set: { status: status} }, { new: true })
    .then(result => {
        res.json({
            status: "SUCCESS",
            message: "İş durumu başarıyla güncellendi.",
            data: result
        })
    })
    .catch(err => {
        res.json({
            status: "FAILED",
            message: "Silme aşamasında bir hata oluştu.",
            data: err
        })
    })
}

const getAllWorks = async (req,res) => {
    
    console.log("Method Type: GET | Get All Works")
    console.log(req.query);
    console.log("\n")
    let userid = req.query.userid;
    const workDatas = await Work.find({userid})

    if(workDatas){
        res.json({
            status: "SUCCESS",
            data: workDatas
        })
    }else{
        res.json({
            status: "FAILED",
            message: "Bu kullanıcıya ait iş bulunamadı.",
            data: workDatas
        })
    }

}

const getAllTasks = async (req,res) => {
    let workid = req.query.workid;
    const tasks = await Task.find({workid});

    if(tasks){
        res.json({
            status: "SUCCESS",
            data: tasks
        })
    }else{
        res.json({
            status: "FAILED",
            message: "Bu kullanıcıya ait iş bulunamadı.",
            data: tasks
        })
    }
}

const addTaskToWork = async (req,res) => {
    
    console.log("Method Type: POST | Add Task To Work\n")
    console.log(req.body);
    console.log("\n\n")
    let {userid,workid,title,long} = req.body;
    userid = userid.trim();
    workid = workid.trim();
    title = title.trim();

    const task = new Task({
        userid,
        workid,
        title,
        long,
    })
    task.save()
    .then(result => {
        res.json({
            status: "SUCCESS",
            message: "Görev ekleme başarıyla tamamlandı",
            data: result
        })
    })
    .catch(err => {
        res.json({
            status: "FAILED",
            message: "Görev eklenirken bir hata oluştu."
        })
    })

}

module.exports = {
    addWork,
    deleteWork,
    updateWorkStatus,
    getAllWorks,
    addTaskToWork,
    getAllTasks,
    deleteTask
}