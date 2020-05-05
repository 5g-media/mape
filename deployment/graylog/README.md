# Graylog Deployment

## Introduction
Deploy the graylog stack using the docker compose project.

The stack includes the services:
 - graylog
 - elastic search
 - mongo db
 
## Requirements
The following services must be available to build the project: 
- docker engine
- docker-compose

Furthermore, the firewall must allow traffic in the ports:
 - 9000 (tcp)
 - 1514 (tcp)
 - 1514 (udp)
 - 12201 (tcp)
 - 12201 (udp)
 
These are the default ports. In case that you modify them, you need to configure the firewall properly. 


## Deployment

Start the docker engine service:
```
$ sudo service docker start
```

Build the project:
```
$ sudo docker-compose up -d
```

Inspect the logs of the project:
```
$ sudo docker-compose logs -f
```

Delete the project:
```
$ sudo docker-compose down
```

> Note: a set of variables are included in the `.env` file. You are able to edit it properly before the build of the project.


## Usage

After the build of the preject, you are to access the graylog UI by typing the URL `${GRAYLOG_EXTERNAL_URL}` as defined in the `.env`.
The default credentials are admin/admin.
