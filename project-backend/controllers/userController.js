const User = require('../models/users')
const bcrypt = require('bcrypt')
const nodemailer = require('nodemailer')
const randomstring = require('randomstring')
const config = require('../config/config')

const sendPasswordResetMail = async (name, email, token) => {
    try {
        
        const sender = nodemailer.createTransport({
            host: 'smtp.gmail.com',
            port:587,
            secure: false,
            requireTLS:true,
            auth:{
                user:config.emailUsername,
                pass:config.emailPassword
            }
        });

        const mailOptions = {
            from:config.emailUsername,
            to:email,
            subject:'Password Reset for Dönem Projesi',
            html: '<p> Hi '+name+', please copy the link and <a href="http://127.0.0.1:3000/reset-password?token='+token+'">reset your password</a></a> </p>'
        }

        sender.sendMail(mailOptions,function(error,info){
            if(error){
                console.log(error);
            }else{
                console.log("Mail basariyla gonderildi. -> "+info.response)
            }
        });


    } catch (error) {
        console.log(error);
        console.log("Reset maili gönderilirken bir hata olustu.")
    }
}

const login = async (req,res) => {
    console.log("Method Type: POST | Login")
    console.log(req.body);
    console.log("\n")
    let username = req.body.username;
    let password = req.body.password;
    username = username.trim();
    password = password.trim();

    if(username == "" || password == "")
    {
        res.json({
            status: "FAILED",
            message: "Boş yerleri doldurunuz."
        })
    }else{
        await User.find({username})
        .then(data => {
            if(data){
                const hashedPW = data[0].password;
                bcrypt.compare(password, hashedPW)
                .then(result => {
                    if(result){
                        res.json({
                            status: "SUCCESS",
                            message: "Başarıyla giriş yapıldı.",
                            data: result
                        })
                    }else{
                        res.json({
                            status: "FAILED",
                            message: "Girdiğiniz şifre yanlış. Tekrar deneyiniz."
                        })
                    }
                }).catch(err => {
                    res.json({
                        status: "FAILED",
                        message: "Sistemsel bir hata oluştu. Tekrar deneyiniz."
                    })
                })
            }
        })
        .catch(err => {
            res.json({
                status: "FAILED",
                message: "Geçersiz kullanıcı adı girdiniz."
            })
        })
    }
}

const register = async (req,res) => {
    console.log("Method Type: POST | Register\n")
    console.log(req.body);
    console.log("\n\n")
    let {name,surname,email,username,password} = req.body;
    name = name.trim();
    surname = surname.trim();
    email = email.trim();
    username = username.trim();
    password = password.trim();

    if(name == "" || surname == "" || email == "" || username == "" || password == "")
    {
        res.json({
            status: "FAILED",
            message: "Bos yerleri doldurunuz."
        })
    }else{
        await User.find({username})
        .then(result => {
            if(result.length){
                res.json({
                    status: "FAILED",
                    message: "Bu kullanıcı adı sistemde kayıtlı. Farklı bir kullanıcı adı deneyin."
                })
            }
            else{
                const secret = 10;
                bcrypt.hash(password,secret)
                .then(hashedPW => {
                    const user = new User({
                        name,
                        surname,
                        email,
                        username,
                        password: hashedPW
                    })
                    user.save()
                    .then(result => {
                        res.json({
                            status: "SUCCESS",
                            message: "Kayıt işlemi başarıyla tamamlandı.",
                            data: result
                        })
                    })
                    .catch(err => {
                        res.json({
                            status: "FAILED",
                            message: "Kayıt olunurken bir hata oluştu."
                        })   
                    })
                })
                .catch(err => {
                    res.json({
                        status: "FAILED",
                        message: "Sistemsel bir hata oluştu. Tekrar deneyiniz."
                    })
                })
            }
        })
        .catch(err => {
            console.log(err);
            res.json({
                status: "FAILED",
                message: "Username aranirken bir hata olustu."
            })
        })
    }
}

const forgetPassword = async (req,res) => {
    try {
        
        const email = req.body.email;
        const userData = await User.findOne({email:email});

        if(userData){
            const random = randomstring.generate();
            const data = await User.updateOne({email:email},{$set:{token:random}});
            sendPasswordResetMail(userData.name, userData.email, random);
            res.json({
                status: "SUCCESS",
                message: "Email adresini kontrol edin."
            })
        }else{
            res.json({
                status: "FAILED",
                message: "Kayitli email bulunamadi."
            })
        }

    } catch (error) {
        res.json({
            status: "FAILED",
            message: "Sifremi unuttum kisminda bir hata olustu."
        })
    }
}

const resetPassword = async (req,res) => {
    try {
        const token = req.query.token;
        const tokenData = await User.findOne({token:token})
        if(tokenData){
            const password = req.body.password;
            const newpw = await bcrypt.hash(password,10);
            const userData = await User.findByIdAndUpdate({_id:tokenData._id},{$set: {password:newpw,token:''}},{new:true});
            res.json({
                status: "SUCCESS",
                message: "Sifre basariyla degistirildi.",
                data: userData
            })

        }else{
            res.json({
                status: "FAILED",
                message: "Bu token linki gecersiz."
            })
        }
    } catch (error) {
        res.json({
            status: "FAILED",
            message: "Kayitli email bulunamadi."
        })
    }
}

module.exports = {
    login,
    register,
    forgetPassword,
    resetPassword
}