const Money = require('../models/money')

const addMoneyAPI = async (req,res) => {
    
    console.log("Method Type: POST | Add Gelir\n")
    console.log(req.body);
    console.log("\n\n")
    let {userid,title,type,money,workid} = req.body;
    userid = userid.trim();
    title = title.trim();
    type = type.trim();
    money = parseFloat(money)

    const moneyy = new Money({
        userid,
        title,
        type,
        money,
        workid
    })

    moneyy.save()
    .then(result => {
        res.json({
            status: "SUCCESS",
            message: "Money ekleme başarıyla tamamlandı",
        })
    })
    .catch(err => {
        res.json({
            status: "FAILED",
            message: "Money eklenirken bir hata oluştu."
        })
    })
    
}

const getAllMoney = async (req,res) => {
    
    console.log("Method Type: GET | Get All Money")
    console.log(req.query);
    console.log("\n")
    let userid = req.query.userid;
    const moneyDatas = await Money.find({userid})

    if(moneyDatas){
        res.json({
            status: "SUCCESS",
            data: moneyDatas
        })
    }else{
        res.json({
            status: "FAILED",
            message: "Bu kullanıcıya ait money bilgisi bulunamadı.",
            data: moneyDatas
        })
    }

}

const deleteMoneyByWorkId = async (req,res) => {
    console.log("Method Type: POST | Delete Money By Work ID\n")
    console.log(req.body);
    console.log("\n\n")
    let {workid} = req.body;

    Money.findOneAndDelete({ workid: workid })
    .then(result => {
        res.json({
            status: "SUCCESS",
            message: "Belirtilen işe ait money silindi.",
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

const deleteMoney = async (req,res) => {
    console.log("Method Type: POST | Delete Money\n")
    console.log(req.body);
    console.log("\n\n")
    let {id} = req.body;

    Money.findByIdAndDelete({ _id: id })
    .then(result => {
        res.json({
            status: "SUCCESS",
            message: "Belirtilen para bilgisi silindi.",
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

const updateMoneyTypeWorkId = async (req,res) => {
    console.log("Method Type: POST | updateMoneyTypeWorkId\n")
    console.log(req.body);
    console.log("\n\n")
    let {workid, type} = req.body;

    const record = await Money.findOne({ workid: workid });

    if (record) {
      record.type = type;
      await record.save()
      .then(result => {
        res.json({
            status: "SUCCESS",
            message: "Money type başarıyla güncellendi.",
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
      
    } else {
        res.json({
            status: "FAILED",
            message: "Bu workide ait money bulunamadı.",
            data: err
        })
    }
}

module.exports = {
   addMoneyAPI,
   getAllMoney,
   deleteMoneyByWorkId,
   deleteMoney,
   updateMoneyTypeWorkId
}