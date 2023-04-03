# Using Cypress to populate OWASP ZAP sites for an active Scan 

Run OWASP ZAP as normal and make sure either it listens to an  available Proxy port. From the command line set the variables, if this this is a new command line session. 

```bash
export HTTP_PROXY=http://localhost:8080
export HTTPS_PROXY=http://localhost:8080
```

You can then run it either  

interactively `npm run cypress:tests-show`

or in headless mode`npm run cypress:tests`

Whilst the tests are running you can see the history and site tree in ZAP being populated. Once the tests are there, right click on the site and then attack

<img align="left" src="/home/yanni/Documents/src/dast-cypress-zap/docs/images/owasp-zap-after-cypress-runs.png" alt="image-20230402153410108" style="zoom:33%;" />

This will then start an active scan and you can see the alerts.  

