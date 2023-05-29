const router = require('express').Router()
const workController = require('../controllers/workController.js')

router.post('/add-work', workController.addWork)
router.post('/delete-work', workController.deleteWork)
router.post('/delete-task', workController.deleteTask)
router.post('/get-all-task-counts', workController.getAllTasksCount)
router.post('/update-task-active', workController.updateTaskActive)
router.post('/update-work-status', workController.updateWorkStatus)
router.get('/get-all-works', workController.getAllWorks)
router.get('/get-all-tasks', workController.getAllTasks)
router.post('/add-task-to-work', workController.addTaskToWork)

module.exports = router