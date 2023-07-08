const userModel = require('../models/user.model')

const jwt = require('jsonwebtoken')

class UserService {
    static async registerUser(userInfo) {
        try {
            const createUser = new userModel(userInfo)
            return await createUser.save()
        } catch (error) {
            throw error
        }
    }

    static async checkEmail(email) {
        try {
            return await userModel.findOne({ email })
        } catch (error) {
            throw error
        }
    }

    static async generateToken(tokenData, secretKey, jwtExpire) {
        return jwt.sign(tokenData, secretKey, { expiresIn: jwtExpire })
    }
}

module.exports = UserService
