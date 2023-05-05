const Work = require('../models/works')
const Task = require('../models/tasks')

const addWork = async (req,res) => {
    
    console.log("Method Type: POST | Add Work\n")
    console.log(req.body);
    console.log("\n\n")
    let {userid,title,status,short} = req.body;
    userid = userid.trim();
    title = title.trim();
    status = status.trim();

    const work = new Work({
        userid,
        title,
        status,
        short,
    })
    work.save()
    .then(result => {
        res.json({
            status: "SUCCESS",
            message: "İş ekleme başarıyla tamamlandı",
            data: result
        })
    })
    .catch(err => {
        res.json({
            status: "FAILED",
            message: "İş eklenirken bir hata oluştu."
        })
    })
    
}

const deleteWork = async (req,res) => {
    
}

const changeWorkStatus = async (req,res) => {
    
}

const getAllWorks = async (req,res) => {
    
    let userid = req.query.userid;
    const workDatas = await Work.find({userid})
    console.log(workDatas)

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
    changeWorkStatus,
    getAllWorks,
    addTaskToWork,
    getAllTasks
}