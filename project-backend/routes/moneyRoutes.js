const router = require('express').Router()
const moneyController = require('../controllers/moneyController.js')

router.post('/add-money', moneyController.addMoneyAPI)
router.post('/delete-money-workid', moneyController.deleteMoneyByWorkId)
router.post('/delete-money', moneyController.deleteMoney)
router.post('/update-money-type-workid', moneyController.updateMoneyTypeWorkId)
router.get('/get-all-money', moneyController.getAllMoney)

module.exports = router