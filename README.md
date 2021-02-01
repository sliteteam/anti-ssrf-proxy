# anti-ssrf-proxy
Combine stunnel (https://www.stunnel.org/) and dante (https://www.inet.no/dante/) to provide TLS authenticated proxy with blocked private ip range.

## Build

`docker build -t anti-ssrf-proxy:latest .`

## Test

Create self-signed certificate:

`openssl req -new -x509 -days 365 -nodes -out test/ssl-cert-snakeoil.pem -keyout test/ssl-cert-snakeoil.key`

Run anti-ssrf-proxy

`docker run --rm -d -e PASSWORD=password -v $(pwd)/test/ssl-cert-snakeoil.key:/opt/stunnel/privkey.pem -v $(pwd)/test/ssl-cert-snakeoil.pem:/opt/stunnel/fullchain.pem -p 1080:1080 anti-ssrf-proxy:latest`

```
cd test
yarn install
NODE_TLS_REJECT_UNAUTHORIZED=0 node index.js
```

You should obtain:

```
Express listening at http://127.0.0.1:8888
Can get internal request without protection: {"ok":true}
Can get githubstatus with protection: All Systems Operational
Socks5 proxy rejected connection - NotAllowed
```