# Redmine deployment

## Introduction

Through this docker project, the [Redmine](https://www.redmine.org/) is easily deployed in a VM. MySQL has been selected as persistent database. 

## Deployment

Instantiate the Redmine project
```
$ sudo docker-compose up -d
```

Terminate the redmine project
```
$ sudo docker-compose down
```

The MySQL data are stored in a persistent manner using a docker volume.
```
$ sudo docker volume ls
```


## Usage

* Open your favorite browser, and type the address http://{host}:80.
* Login to the Redmine using the default administrative credentials (admin/admin) and then, change the administrative credentials
* Go to the administration area:
  * Do the authentication necessary in the *Settings > Authentication* tab by setting the `Authentication required` to `YES` 
  * Enable the REST API in the *Settings > API* tab by checking the `Enable REST web service` and then `save`
  * Configure the projects options in the *Settings > Projects* tab
* Go to the Projects area
  * Register the project you need in the *New project > Projects* tab