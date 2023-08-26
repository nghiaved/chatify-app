const express = require('express')

const { protect } = require('../middlewares/auth.middleware')
const messageController = require('../controllers/message.controller')

const router = express.Router()

const messageRoute = app => {
    router.get('/:chatId', protect, messageController.allMessages)
    router.post('/', protect, messageController.sendMessage)
    router.patch('/:messageId', protect, messageController.readMessage)

    return app.use('/api/message', router)
}

module.exports = messageRoute
