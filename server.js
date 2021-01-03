const dayjs = require('dayjs')
const Koa = require('koa')
const bodyParser = require('koa-bodyparser')
var serve = require('koa-static-server')
const router = require('./src/router')
const favicon = require('koa-favicon');

const app = new Koa()
app.proxy = true

app.use(catcher)
app.use(bodyParser())
app.use(router.routes())
app.use(router.allowedMethods())

app.use(serve({rootDir: 'index'}))
app.use(favicon(__dirname + '/index/favicon.ico'));


const PRT = 23333
app.listen(PRT, '0.0.0.0', console.log('http://127.0.0.1:' + PRT))

async function catcher (ctx, next) {
  try {
    return await next()
  } catch (e) {
    console.error(e)
    ctx.status = 500
    ctx.body = e.message
  }
}
