const { error } = require('console');
const Router = require('koa-router');
const fs = require("fs").promises
const path = require("path")
const singsRouter = new Router({
    prefix: "/api"
})

// 获取所有的书
singsRouter.get("/sings", async (ctx, next) => {
    const data = await fs.readFile(path.join(__dirname, '../data.json'), 'utf-8');
    const sings = JSON.parse(data).sings
    if(sings.length>0){
        ctx.body = Res(0, { sings }, "获取歌曲成功")
    }else{
        ctx.body = Res(0, null, "当前没有歌曲")
    }
 
}
)

function Res(code, data, message) {
    return { code, data, message }
}

module.exports = {
    singsRouter
}
