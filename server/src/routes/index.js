const chatRoute = require('./chat.route')
const userRoute = require('./user.route')

const routes = app => {
    userRoute(app)
    chatRoute(app)
}

module.exports = routes
