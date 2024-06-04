
# Docker PocketBase Multi Instance

Easy setup for PocketBase Multi Instance

## Setup

1. **Clone this repository**

    ```bash
    git clone https://github.com/izulwahidin/Docker-PocketBase-Multi-Instance.git
    cd Docker-PocketBase-Multi-Instance
    ```

2. **Configure your environment**

    Copy and rename the **.env.example** file to **.env**, then customize it according to your preferences.

    ```bash
    cp .env.example .env
    ```

## Run Services

To start the services, run the following command:

```bash
./run.sh
```

## Access PocketBase

Once the services are running, you can access PocketBase instances at:

```
http://<ip_vps>/onlinestore/
http://<ip_vps>/bootstore/
```

Or using a domain:

```
http://<domain.com>/onlinestore/
http://<domain.com>/bootstore/
```

## Todo
```
- Not yet
```
