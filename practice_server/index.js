const Koa = require('koa');
const {koaBody} = require("koa-body")
const app = new Koa();

const {userRouter} = require('./routers/userRouter') 
const { singsRouter } = require('./routers/singsRouter')
// 中间件函数
app.use(koaBody())
app.use(userRouter.routes())
app.use(singsRouter.routes())
 
 // 监听端口
  app.listen(3000, () => {
    console.log('Server is running on http://localhost:3000');
  });
  