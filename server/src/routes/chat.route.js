const express = require('express')

const { protect } = require('../middlewares/auth.middleware')
const chatController = require('../controllers/chat.controller')

const router = express.Router()

const chatRoute = app => {
    router.post('/', protect, chatController.accessChat)
    router.get('/', protect, chatController.fetchChats)
    router.post('/group', protect, chatController.createGroupChat)
    router.put('/grouprename', protect, chatController.renameGroup)
    router.put('/groupremove', protect, chatController.removeFromGroup)
    router.put('/groupadd', protect, chatController.addToGroup)

    return app.use('/api/chat', router)
}

module.exports = chatRoute
