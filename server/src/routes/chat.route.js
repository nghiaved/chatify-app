const express = require('express')

const { protect } = require('../middlewares/auth.middleware')
const chatController = require('../controllers/chat.controller')

const router = express.Router()

const chatRoute = app => {
    router.post('/', protect, chatController.accessChat)
    router.get('/', protect, chatController.fetchChats)

    return app.use('/api/chat', router)
}

module.exports = chatRoute
