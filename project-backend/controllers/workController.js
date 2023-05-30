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

async function gAllTasksCount(workid) {
    try {
        const tasks = await Task.find({workid});
        let tum = tasks.length
        let aktif = 0
        let tamam = 0
        

        tasks.forEach(e => {
            if(e["active"] == "false"){
                aktif+=1
            }else{
                tamam+=1
            }
        });

        const data = tum.toString()+","+aktif.toString()+","+tamam.toString()
        return data;
    } catch (err) {
      console.error('Hata:', err);
    }
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

const updateTaskActive = async (req,res) => {
    console.log("Method Type: POST | updateTaskActive\n")
    console.log(req.body);
    console.log("\n\n")
    let {id, active} = req.body;

    if(active == "false"){
        active = "true"
    }else{
        active = "false"
    }

    Task.findByIdAndUpdate({ _id: id }, { $set: { active: active} }, { new: true })
    .then(result => {
        res.json({
            status: "SUCCESS",
            message: "Task Active başarıyla güncellendi.",
            data: result
        })
    })
    .catch(err => {
        res.json({
            status: "FAILED",
            message: "Güncelleme aşamasında bir hata oluştu.",
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

    /*const workDatas = [
        {
          _id: new ObjectId("646cb0f9d3e28bcac6a7967d"),
          userid: new ObjectId("64355ec21e43b3e0cb25621e"),
          title: 'Tasarim',
          status: 'Aktif',
          short: 'Sosyal medya icin tasarimlar yapilacak',
          lastDate: '30.05.2023',
          money: 1400,
          __v: 0
        },
        {
          _id: new ObjectId("646cb126d3e28bcac6a79682"),
          userid: new ObjectId("64355ec21e43b3e0cb25621e"),
          title: 'One Page Site',
          status: 'Tamamlanmış',
          short: 'Kurum icin tek sayfa site yapilacak',
          lastDate: '26.05.2023',
          money: 3200,
          __v: 0
        },
        {
          _id: new ObjectId("646cb154d3e28bcac6a79689"),
          userid: new ObjectId("64355ec21e43b3e0cb25621e"),
          title: 'Frontend',
          status: 'Bekleyen',
          short: 'Frontend kod yazilacak',
          lastDate: '24.05.2023',
          money: 2500,
          __v: 0
        }
      ]*/

    if(workDatas){
        var count = [];
        for (const item of workDatas) {
            try {
            const res = await gAllTasksCount(item["_id"]);
            console.log(res)
            count.push(res)
            } catch (err) {
            console.log(err);
            }
        }
        res.json({
            status: "SUCCESS",
            data: workDatas,
            count: count
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

const getAllTasksCount = async (req,res) => {
    console.log("Method Type: GET | getAllTasksCount")
    console.log("\n")
    let id = req.body.id;
    let workid = id
    const tasks = await Task.find({workid});
    let tum = tasks.length
    let aktif = 0
    let tamam = 0
    

    tasks.forEach(e => {
        if(e["active"] == "false"){
            aktif+=1
        }else{
            tamam+=1
        }
    });

    const data = tum.toString()+","+aktif.toString()+","+tamam.toString()
    console.log(data)

    res.json({
        status: "SUCCESS",
        data: data
    })
}

const addTaskToWork = async (req,res) => {
    
    console.log("Method Type: POST | Add Task To Work\n")
    console.log(req.body);
    console.log("\n\n")
    let {userid,workid,title,long,active} = req.body;
    userid = userid.trim();
    workid = workid.trim();
    title = title.trim();

    const task = new Task({
        userid,
        workid,
        title,
        long,
        active
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
    updateTaskActive,
    getAllWorks,
    addTaskToWork,
    getAllTasks,
    getAllTasksCount,
    deleteTask
}