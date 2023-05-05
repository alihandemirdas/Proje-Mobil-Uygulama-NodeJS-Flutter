const router = require('express').Router()
const workController = require('../controllers/workController.js')

router.post('/add-work', workController.addWork)
//router.get('/delete-work', workController.deleteWork)
//router.get('/change-work-status', workController.changeWorkStatus)
router.get('/get-all-works', workController.getAllWorks)
router.get('/get-all-tasks', workController.getAllTasks)
router.post('/add-task-to-work', workController.addTaskToWork)

module.exports = router