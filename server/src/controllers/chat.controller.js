const chatModel = require('../models/chat.model')
const userModel = require('../models/user.model')

const chatController = {
    accessChat: async (req, res, next) => {
        const { userId } = req.body

        if (!userId) {
            console.log("UserId param not sent with request")
            return res.sendStatus(400)
        }

        var isChat = await chatModel.find({
            isGroupChat: false,
            $and: [
                { users: { $elemMatch: { $eq: req.user._id } } },
                { users: { $elemMatch: { $eq: userId } } },
            ],
        })
            .populate("users", "-password")
            .populate("latestMessage")

        isChat = await userModel.populate(isChat, {
            path: "latestMessage.sender",
            select: "name image email",
        })

        if (isChat.length > 0) {
            res.send(isChat[0])
        } else {
            var chatData = {
                chatName: "sender",
                isGroupChat: false,
                users: [req.user._id, userId],
            }

            try {
                const createdChat = await chatModel.create(chatData)
                const fullChat = await chatModel.findOne({ _id: createdChat._id }).populate(
                    "users",
                    "-password"
                )
                res.status(200).json(fullChat)
            } catch (error) {
                res.status(400)
                throw new Error(error.message)
            }
        }
    },

    fetchChats: async (req, res) => {
        try {
            chatModel.find({ users: { $elemMatch: { $eq: req.user._id } } })
                .populate("users", "-password")
                .populate("groupAdmin", "-password")
                .populate("latestMessage")
                .sort({ updatedAt: -1 })
                .then(async (results) => {
                    results = await userModel.populate(results, {
                        path: "latestMessage.sender",
                        select: "name image email",
                    })
                    res.status(200).send(results)
                })
        } catch (error) {
            res.status(400)
            throw new Error(error.message)
        }
    },

    createGroupChat: async (req, res) => {
        if (!req.body.users || !req.body.name) {
            return res.status(400).send({ message: "Please Fill all the fields" })
        }

        var users = JSON.parse(req.body.users)

        if (users.length < 2) {
            return res
                .status(400)
                .send("More than 2 users are required to form a group chat")
        }

        users.push(req.user)

        try {
            const groupChat = await chatModel.create({
                chatName: req.body.name,
                users: users,
                isGroupChat: true,
                groupAdmin: req.user,
            })

            const fullGroupChat = await chatModel.findOne({ _id: groupChat._id })
                .populate("users", "-password")
                .populate("groupAdmin", "-password")

            res.status(200).json(fullGroupChat)
        } catch (error) {
            res.status(400)
            throw new Error(error.message)
        }
    },

    renameGroup: async (req, res) => {
        const { chatId, chatName } = req.body

        const updatedChat = await chatModel.findByIdAndUpdate(
            chatId,
            {
                chatName: chatName,
            },
            {
                new: true,
            }
        )
            .populate("users", "-password")
            .populate("groupAdmin", "-password")

        if (!updatedChat) {
            res.status(404)
            throw new Error("Chat Not Found")
        } else {
            res.json(updatedChat)
        }
    },

    removeFromGroup: async (req, res) => {
        const { chatId, userId } = req.body

        const removed = await chatModel.findByIdAndUpdate(
            chatId,
            {
                $pull: { users: userId },
            },
            {
                new: true,
            }
        )
            .populate("users", "-password")
            .populate("groupAdmin", "-password")

        if (!removed) {
            res.status(404)
            throw new Error("Chat Not Found")
        } else {
            res.json(removed)
        }
    },

    addToGroup: async (req, res) => {
        const { chatId, userId } = req.body;

        const added = await chatModel.findByIdAndUpdate(
            chatId,
            {
                $push: { users: userId },
            },
            {
                new: true,
            }
        )
            .populate("users", "-password")
            .populate("groupAdmin", "-password");

        if (!added) {
            res.status(404);
            throw new Error("Chat Not Found");
        } else {
            res.json(added);
        }
    }
}

module.exports = chatController
