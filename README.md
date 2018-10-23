# docker-puppeteer-chinese

- [x] 默认使用淘宝镜像源，无需科学上网即可安装
- [x] 默认安装中文字体，解决乱码问题
- [x] 可直接引入项目
- [x] 开箱即用


## 使用说明


1. 克隆项目 

```
git clone https://github.com/notadd/docker-puppeteer-chinese.git
```

2. 将 Dockerfile 与 docker-compose.yml 放在项目根路径

3. 确保 `package.json` 中含有 start 脚本，项目监听3000端口。

4. 执行 `docker-compose start`

5. 访问： localhost：3001 （对外端口默认监听3001，可根据自己需要修改 docker-compose.yml 的 ports） 


## 参考 demo


```
const assert = require('assert')
const puppeteer = require('puppeteer')

let browser
let page

before(async() => {
  browser = await puppeteer.launch({
    args: [
      // Required for Docker version of Puppeteer
      '--no-sandbox',
      '--disable-setuid-sandbox',
      // This will write shared memory files into /tmp instead of /dev/shm,
      // because Docker’s default for /dev/shm is 64MB
      '--disable-dev-shm-usage'
    ]
  })

  const browserVersion = await browser.version()
  console.log(`Started ${browserVersion}`)
})

beforeEach(async() => {
  page = await browser.newPage()
})

afterEach(async() => {
  await page.close()
})

after(async() => {
  await browser.close()
})

describe('App', () => {
  it('renders', async() => {
    const response = await page.goto('http://github.com/')
    assert(response.ok())
    await page.screenshot({ path: `/app/screenshot/app.png` })
  })
})
```

