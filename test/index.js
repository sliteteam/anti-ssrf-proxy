const got = require('got')
const { SocksProxyAgent } = require('@slite/socks-proxy-agent');
const express = require('express')

function protected(options) {
  const info = {
    host: '172.17.0.2',
    userId: 'proxy_username',
    password: 'password',
    tls: true,
  }
  return {
    ...options,
    agent: {
      http: new SocksProxyAgent(info),
      https: new SocksProxyAgent(info),
    },
  }
}


const app = express()
const port = 8888

app.get('/', (req, res) => {
  res.json({ok: true})
})

const server = app.listen(port, async () => {
  const appUrl = `http://127.0.0.1:${port}`;
  console.log(`Express listening at ${appUrl}`)
  const res = await got(
    appUrl,
    {
      responseType: 'json'
    }
  )
  console.log(`Can get internal request without protection: ${JSON.stringify(res.body)}`)

  const githubstatus = await got(
    'https://www.githubstatus.com/',
    protected({
      responseType: 'json',
      headers: {
        'accept': 'application/json'
      },
    })
  )

  console.log(`Can get githubstatus with protection: ${githubstatus.body.status.description}`)

  try {
    await got(
      appUrl,
      protected({
        responseType: 'json'
      })
    )
  } catch(e) {
    console.log(e.message)
  }
  server.close()
})


