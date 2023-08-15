const express = require('express')

const userController = require('../controllers/user.controller')
const { protect } = require('../middlewares/auth.middleware')

const router = express.Router()

const userRoute = app => {
    router.post('/register', userController.handleRegister)
    router.post('/login', userController.handleLogin)
    router.put('/update/:id', userController.handleUpdate)
    router.delete('/delete/:id', userController.handleDelete)
    router.get('/', protect, userController.getAllUsers)

    return app.use('/api/user', router)
}

module.exports = userRoute
