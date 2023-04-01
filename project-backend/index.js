const express = require('express')
const mongoose = require('mongoose')
var bodyParser = require("body-parser");
const userRoutes = require('./routes/userRoutes')
const app = express()

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

const databaseURL = 'mongodb+srv://admin:1234@donem-projesi.4gokqjc.mongodb.net/?retryWrites=true&w=majority'
mongoose.connect(databaseURL) //hata verirse -> dbURL, {useNewUrlParser: true , useUnifiedTopology: true}
    .then((result) => console.log('MongoDB veritabanı bağlantısı kuruldu.'))
    .catch((err) => console.log(err))

app.listen(3000)
app.use('/api',userRoutes)