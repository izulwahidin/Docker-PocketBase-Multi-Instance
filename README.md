# Docker PocketBase Multi Instance

Easy setup for PocketBase Multi Instance

## setup

- clone this repository
- rename **.env.example** to **.env**, and add/change PocketBase Instances

```
PB[number_of_instance]=name:port
```

#### generate docker compose

```
$ ./generate-compose.sh
```

#### start docker

```
$ docker-compose up --build
```

## Todo

- caddy
- auto subdomain
- auto ssl
