silently-docker
===============

This docker file build a webserver integrating the [silently-client](https://github.com/mtsgrd/silently-client) and [silently-backend](https://github.com/mtsgrd/silently-backend).


**Build and run**
```
$> git clone https://github.com/mtsgrd/silently-docker
$> cd silently-docker
$> docker build -t silently .
$> docker run --name=silently -i -t --rm -p 5000:5000 \
    -e ORDRIN_API_KEY=[value] \
    -e MONGO_USERNAME=[value] \
    -e MONGO_PORT=[value] \
    -e MONGO_PASSWORD=[value] \
    -e MONGO_HOST=[value] \
    -e SMTP_PASSWORD=[value] \
    -e SMTP_SERVER=[value] \
    -e SMTP_USERNAME=[value] \
    -e MONGO_DATABASE=[value] \
    -e GOOGLE_API_KEY=[value] \
    silently
```
