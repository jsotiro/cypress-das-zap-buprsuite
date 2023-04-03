# DevSecOps: Automated Guided DAST with Cypress,  OWASP ZAP,  Burp Suite Pro

 

DAST (Dynamic Application Security Test) tools use spidering/crawling to discover resources and then actively scan them for vulnerabilities. This approach is not really effective for SPAs  (single page applications) with heavy use of REST APIs that have no OpenAPI specification endpoints to crawl. The approach can also be problematic if you want to avoid large scale crawling and focus on the applications journey and business logic. 

This is where leveraging existing web automated test scripts can help for effective and guided DAST scan in the pipeline. 

This project is a proof of concept of leveraging web automated tests to automate DAST scans. 

In this PoC we will use [Cypress](https://www.cypress.io)  a very popular UI/E2E testing framework for web applications to guide [the OWASP ZAP](https://www.zaproxy.org/)  DAST tool.  The approach is applicable to any other web testing framework with  proxy configuration.

We use  [OWASP Juice Shop](https://owasp.org/www-project-juice-shop/) ,  an intentionally vulnerable web application as our example application.



The project is built combining the best elements from two other previous efforts found in  https://github.com/jverhoelen/security-tests-with-owasp-zap-cypress and https://github.com/el-davo/cypress-zap

## Automated DAST with Cypress and Desktop tools

### OWASP ZAP

You can use  cypress to help  guide your desktop OWASP ZAP scans. [Here](docs/ZapDesktopWithCypress.md) is the guide on how to do it

### Bup Suite

Cypress can be used to drive Live Tasks with active scans ('audit') in Burp Suite Pro or passive crawling with Burp Suite Community.   [Here](/docs/BurpSuiteWithCypress.md) step by step walk through on  how to do this 



## CLI and CI-level Automated DAST with Cypress

### OWASP ZAP

You can use OWASP ZAP in headless mode, as a daemon). This can be done either using a local install of ZAP or the official docker file. The PoC provides  npm scripts for both.  Once the traffic is proxied we can start an active scan on the proxied traffic with the ZAP API, monitor its progress, retrieve the report , and optionally terminate the ZAP daemon.

#### Using OWASP ZAP locally 

1. Setup the Proxy ports environment variables

```bash
export HTTP_PROXY=http://localhost:8080
export HTTPS_PROXY=http://localhost:8080
```

2. Start ZAP locally using

```bash
npm run zap-local:start 
```

 This will start the zap daemon in foreground mode with its own output and blocking the terminal until you terminate  it.   

Alternatively you can use 

```bash
npm run zap-local:start-bg 
```

 which starts the zap daemon in the background

In both cases you can check whether the daemon is running successful but using https://localhost:8080 in the browser.

3. Run Cypress tests to proxy all traffic through ZAP

The PoC provides scripts to do in a couple of different ways:

npm run cypress:tests-show

or 

npm run cypress:tests 

which runs 





RuThese tools can be combined in an interesting way. **Cypress** can proxy all of its traffic generated during test execution through **OWASP ZAP**. ZAP will roughly learn which sites the web app under test has. It gathers security alerts found in the traffic. Afterwards ZAP can run active scans against the application in addition. These try some active attacks against the site, such as SQL injections or Cross-Site-Scripting attempts. OWASP ZAP afterwards provides reports including all found vulnerabilities.

### 

The famous JS has a fair amount of serious vulnerabilities. Therefor it's perfect for demonstrating what kind of vulnerabilities and smells can be discovered with automated click tests and active scanning.

## Running it

### Locally against remote Juice Shop

Juice Shop is up already on: https://juice-shop.herokuapp.com

Start OWASP ZAP in headless mode using Docker, as we just need its HTTP API, on `http://localhost:8080`:

```bash
docker run -u zap -p 8080:8080 jverhoelen/owasp-zap-with-entrypoint
# this image is a variant of https://github.com/zaproxy/zaproxy/blob/develop/docker/Dockerfile-bare
# it has been built from file https://github.com/jverhoelen/zaproxy/blob/develop/docker/Dockerfile-bare-entrypoint
# it just runs ZAP as Docker entrypoint using its bash script wrapper zap.sh with some default arguments so it binds to 0.0.0.0:8080 as daemon without API key
```

Configure ZAP as proxy for Cypress and run tests:

```bash
nvm use
npm i

export HTTP_PROXY=http://localhost:8080
export HTTPS_PROXY=http://localhost:8080

    npm run zap:start
    npm run zap:zap-active-scan
    # or "npm run remote:all" for both after another
```

