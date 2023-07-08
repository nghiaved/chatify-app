const express = require('express')
const routes = require('./routes')
const bodyParser = require('body-parser')
const cors = require('cors')
const app = express()

require('./config/db')()

app.use(bodyParser.json({ limit: "50mb" }))
app.use(bodyParser.urlencoded({
    limit: "50mb",
    extended: true,
    parameterLimit: 50000
}))

app.use(cors())

routes(app)

const port = 7000
app.listen(port, () => {
    console.log(`Server's listening at http://localhost:${port}`);
})
