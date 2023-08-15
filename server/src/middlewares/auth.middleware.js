const jwt = require('jsonwebtoken')
const userModel = require('../models/user.model')

const protect = async (req, res, next) => {
    let token
    if (
        req.headers.authorization
        && req.headers.authorization.startsWith("Bearer")
    ) {
        try {
            token = req.headers.authorization.split(" ")[1]
            const decoded = jwt.verify(token, 'secretKey')
            req.user = await userModel
                .findById(decoded._id)
                .select("-password")
            next()
        } catch (error) {
            res.status(401)
            throw new Error("Not authorized, token failed")
        }
    }

    if (!token) {
        res.status(401)
        throw new Error("Not authorized, no token")
    }
}

module.exports = { protect }
