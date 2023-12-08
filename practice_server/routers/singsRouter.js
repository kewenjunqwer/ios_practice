const { error } = require('console');
const Router = require('koa-router');
const fs = require("fs").promises
const path = require("path")
const singsRouter = new Router({
    prefix: "/api"
})

// 获取所有的歌曲
singsRouter.get("/sings", async (ctx, next) => {
    const data = await fs.readFile(path.join(__dirname, '../data.json'), 'utf-8');
    const sings = JSON.parse(data).sings
    if (sings.length > 0) {
        ctx.body = Res(0, { sings }, "获取歌曲成功")
    } else {
        ctx.body = Res(0, null, "当前没有歌曲")
    }
})

// 删除一首歌曲
singsRouter.post("/sings/delete",async(ctx,next) =>{
    const { singId } = ctx.request.body
    const data = await fs.readFile(path.join(__dirname, '../data.json'), 'utf-8');
    const sings = JSON.parse(data).sings
    const newSings = sings.filter(item => item.id !== singId)
    data.singIds = newSings
    const jsonData = JSON.stringify(data)
    fs.writeFile(path.join(__dirname, '../data.json'), jsonData, "utf-8", (error) => {
        if (error) {
            ctx.body = Res(-1, null, "写入文件出错啦")
        } else {
            ctx.body = Res(0, null, "删除歌曲成功")
        }
    })
})


// 收藏一首歌曲
singsRouter.post("sings/collect",async(ctx,next) =>{
    const { singId,userId } = ctx.request.body
    const data = await fs.readFile(path.join(__dirname, '../data.json'), 'utf-8');
    const sings = JSON.parse(data).collectSings
    sings.push({singId,userId})
    data.collectSings = sings
    const jsonData = JSON.stringify(data)
    fs.writeFile(path.join(__dirname, '../data.json'), jsonData, "utf-8", (error) => {
        if (error) {
            ctx.body = Res(-1, null, "写入文件出错啦")
        } else {
            ctx.body = Res(0, null, "收藏歌曲成功")
        }
    })
})

// 喜欢一首歌曲
singsRouter.post("sings/liked",async(ctx,next) =>{
    const { singId,userId } = ctx.request.body
    const data = await fs.readFile(path.join(__dirname, '../data.json'), 'utf-8');
    const sings = JSON.parse(data).likedSings
    sings.push({singId,userId})
    data.likedSings = sings
    const jsonData = JSON.stringify(data)
    fs.writeFile(path.join(__dirname, '../data.json'), jsonData, "utf-8", (error) => {
        if (error) {
            ctx.body = Res(-1, null, "写入文件出错啦")
        } else {
            ctx.body = Res(0, null, "喜欢歌曲成功")
        }
    })
})



// 喜欢一首歌曲
function Res(code, data, message) {
    return { code, data, message }
}

module.exports = {
    singsRouter
}
