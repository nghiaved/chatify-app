const messageModel = require('../models/message.model')
const chatModel = require('../models/chat.model')
const userModel = require('../models/user.model')

const messageController = {
    allMessages: async (req, res) => {
        try {
            const messages = await messageModel.find({ chat: req.params.chatId })
                .populate("sender", "name image email")
                .populate("chat")
            res.json(messages)
        } catch (error) {
            res.status(400)
            throw new Error(error.message)
        }
    },

    sendMessage: async (req, res) => {
        const { content, chatId } = req.body

        if (!content || !chatId) {
            console.log("Invalid data passed into request")
            return res.sendStatus(400)
        }

        var newMessage = {
            sender: req.user._id,
            content: content,
            chat: chatId,
        }

        try {
            var message = await messageModel.create(newMessage)

            message = await message.populate("sender", "name image")
            message = await message.populate("chat")
            message = await userModel.populate(message, {
                path: "chat.users",
                select: "name image email",
            })

            await chatModel.findByIdAndUpdate(req.body.chatId, { latestMessage: message })

            res.json(message)
        } catch (error) {
            res.status(400)
            throw new Error(error.message)
        }
    },
}

module.exports = messageController
