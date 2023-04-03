# Using Cypress with Burp Suite

Run Burp Suite Pro and make sure the  the proxy is configured to the port  to  8080 (You can use any other prort as long as it is available and it is used when setting HTTP_PROXY and HTTPS_PROXY later on. 

Start Live Task, and configure it use Audit (active scanning) and to cover Proxy traffic

<img align="left" src="/home/yanni/Documents/src/dast-cypress-zap/docs/images/live-scan-main-config.png" style="zoom: 33%;" />

Select the appropriate scan configuration e.g., select  Audit coverage - maximum from the configuration library.

<img src="/home/yanni/Documents/src/dast-cypress-zap/docs/images/live-task-scan-config.png" align="left" alt="live-task-scan-config" style="zoom: 40%;" />



Back in the command line set the HTTP Proxy as follows:

```bash
export HTTP_PROXY=http://localhost:8080
export HTTPS_PROXY=http://localhost:8080
```

You can then run it either  

interactively `npm run cypress:tests-show`

or in headless mode`npm run cypress:tests`

Once the tests are there, check the results in the Live Task Dashboard and click Show Details to see all the findings.  

<img src="/home/yanni/Documents/src/dast-cypress-zap/docs/images/live-task-results.png" align="left" style="zoom:35%;" />

> You can do this with the free Burp Suite Community Edition, but the Live Task only allows Passive Crawling which is of limited value. 
>
> In both cases you can also see the captured traffic in the Proxy's Web History. (You can save this as a proxy capture file and use it with other DAST Tools, eg. both Fortify and Qualys WAS support importing of Burp Suite Proxy files.



In Burp Suite Pro, you can alternatively just run the tests and then select the Proxy's Web History, right click and send to Active Scan. This will initiate a new active scan which you can configure as needed.