# Docker PocketBase Multi Instance

Easy setup for PocketBase Multi Instance

## setup

- clone this repository
- rename **.env.example** to **.env**, and add/change PocketBase Instances

```
PB[number_of_instance]="name:port"
```

#### generate docker compose and Caddyfile

```
$ chmod +x ./generate.sh
$ ./generate.sh
```

#### start docker

```
$ docker-compose up --build
```

#### access pocketbase

```
ip_vps/onlinestore/
ip_vps/bootstore/
```

**or**

```
domain.com/onlinestore/
domain.com/bootstore/
```

## Todo

- not yet
