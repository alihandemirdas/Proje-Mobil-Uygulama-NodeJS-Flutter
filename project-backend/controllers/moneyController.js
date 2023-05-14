const Money = require('../models/money')


const addMoneyAPI = async (req,res) => {
    
    console.log("Method Type: POST | Add Gelir\n")
    console.log(req.body);
    console.log("\n\n")
    let {userid,title,type,money} = req.body;
    userid = userid.trim();
    title = title.trim();
    type = type.trim();
    money = parseFloat(money)

    const moneyy = new Money({
        userid,
        title,
        type,
        money
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

module.exports = {
   addMoneyAPI,
   getAllMoney
}