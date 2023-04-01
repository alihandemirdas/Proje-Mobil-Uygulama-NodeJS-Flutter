const router = require('express').Router()
const userController = require('../controllers/userController.js')

router.post('/login', userController.login)
router.post('/register', userController.register)
router.post('/forget-password', userController.forgetPassword)
router.get('/reset-password', userController.resetPassword)

module.exports = router