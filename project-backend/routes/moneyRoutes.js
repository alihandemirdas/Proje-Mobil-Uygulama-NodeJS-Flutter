const router = require('express').Router()
const moneyController = require('../controllers/moneyController.js')

router.post('/add-money', moneyController.addMoneyAPI)
router.get('/get-all-money', moneyController.getAllMoney)

module.exports = router