const mongoose = require('mongoose')
require('dotenv').config()

const urlMongodb = process.env.URL_MONGODB

const connectDB = () => {
    mongoose
        .set('strictQuery', false)
        .connect(urlMongodb, {
            useNewUrlParser: true,
            useUnifiedTopology: true,
        })
        .then(res => {
            console.log('Connect successfully!')
        })
        .catch(error => {
            console.log('Connect failure!')
        })
}

module.exports = connectDB
