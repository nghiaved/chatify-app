const chatRoute = require('./chat.route')
const messageRoute = require('./message.route')
const userRoute = require('./user.route')

const routes = app => {
    userRoute(app)
    chatRoute(app)
    messageRoute(app)
}

module.exports = routes
