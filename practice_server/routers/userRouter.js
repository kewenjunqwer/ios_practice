const { error } = require('console');
const Router = require('koa-router');
const fs = require("fs").promises
const path = require("path")
// const router = new Router();
const userRouter = new Router({
    prefix: "/api"
})

function Res(code, data, message) {
    return { code, data, message }
}

// 请求登陆
userRouter.post("/login", async (ctx, next) => {
    const userInfo = ctx.request.body
    console.log(userInfo)
    const { account, password } = userInfo
    const userData = await fs.readFile(path.join(__dirname, '../data.json'), 'utf-8');
    const users = JSON.parse(userData).users;
    let user = users.filter(item => item.account === account && item.password === password)?.[0]
    if (user) {
        ctx.body = Res(0, { user }, "登陆成功")
    } else {
        ctx.body = Res(-1, {}, "账户有误，请校验成功后再进行登陆")
    }
})

// 修改密码
userRouter.post("/changepwd", async (ctx, next) => {
    const { userId, password, newPassword } = ctx.request.body
    const data = await fs.readFile(path.join(__dirname, './data.json'), 'utf-8');
    const users = JSON.parse(data).users;
    const newUsers = users.map(item => {
        if (item.userId === userId) {
            if (password === item.password) {
                item.password = newPassword
                return item
            }
        } else {
            return item
        }
    })
    data.users = newUsers
    const jsonData = JSON.stringify(jsonData)
    fs.writeFile(path.join(__dirname, '../data.json'), jsonData, "utf-8", (error) => {
        if (error) {
            ctx.body = Res(-1, null, "写入文件出错啦")
        } else {
            ctx.body = Res(0, null, "修改密码成功")
        }
    })
    if (user) {
        ctx.body = Res(0, { user }, "登陆成功")
    } else {
        ctx.body = Res(-1, {}, "账户有误，请校验成功后再进行登陆")
    }
})




module.exports = {
    userRouter
} 