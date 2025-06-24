сохраняем текущие настройки
 
```
 ./pi_hole_b.sh 
```

1. Создать директорию для конфигурации Pi-hole:
```bash
sudo mkdir -p /opt/stacks/pihole
cd /opt/stacks/pihole
```

2. Создать файл `docker-compose.yml` с конфигурацией Pi-hole (пример минимальной конфигурации):
```yaml
version: "3"

services:
  pihole:
    container_name: pihole
    image: pihole/pihole:latest
    environment:
      TZ: 'Europe/Moscow' # замените на ваш часовой пояс
      WEBPASSWORD: 'your_password' # задайте пароль для веб-интерфейса
    volumes:
      - './etc-pihole/:/etc/pihole/'
      - './etc-dnsmasq.d/:/etc/dnsmasq.d/'
    ports:
      - "53:53/tcp"
      - "53:53/udp"
      - "80:80/tcp"
    restart: unless-stopped
```

6. Запустить контейнер Pi-hole:
```bash
docker compose up -d
```

7. Проверить работу Pi-hole, зайдя в веб-интерфейс по адресу `http://<IP_вашего_прибора>/admin` и войти с паролем из `WEBPASSWORD`.

## Установка Stubby в Docker

Stubby — это DNS-over-TLS резолвер, который можно использовать совместно с Pi-hole для безопасного резолвинга DNS.

1. Создать директорию для Stubby:
```bash
sudo mkdir -p /opt/stacks/stubby
cd /opt/stacks/stubby
```

2. Создать `docker-compose.yml` для Stubby (пример):
```yaml
version: "3"

services:
  stubby:
    container_name: stubby
    image: ghcr.io/dkgroot/stubby:latest
    ports:
      - "127.0.0.1:853:853/tcp"
      - "127.0.0.1:853:853/udp"
    volumes:
      - ./stubby.yml:/etc/stubby/stubby.yml:ro
    restart: unless-stopped
```

3. Создать конфигурационный файл `stubby.yml` с настройками DNS-over-TLS (пример можно взять из официальной документации Stubby).
4. Запустить Stubby:
```bash
docker compose up -d
```


## Настройка Pi-hole для использования Stubby

1. В настройках Pi-hole указать в качестве upstream DNS серверов `127.0.0.1#853` (локальный Stubby).
2. Перезапустить Pi-hole контейнер, если требуется.

---

Таким образом, последовательность команд будет примерно следующей: