const mongoose = require('mongoose')

const Schema = mongoose.Schema

const messageSchema = new Schema({
    sender: { type: mongoose.Schema.Types.ObjectId, ref: "user" },
    content: { type: String, trim: true },
    chat: { type: mongoose.Schema.Types.ObjectId, ref: "chat" },
    readBy: [{ type: mongoose.Schema.Types.ObjectId, ref: "user" }],
},
    { timestamps: true }
)

module.exports = mongoose.model('message', messageSchema)
