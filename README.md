# MaxTunnel VPN Server

Ядро сервера для MaxTunnel — VPN-туннеля поверх DTLS + TURN relay с обфускацией под RTP (audio/video/datachannel).

## Возможности

- **DTLS + WRAP** — DTLS-соединение с дополнительной обфускацией ChaCha20-Poly1305 (RTP audio/video или raw datachannel)
- **Userspace WireGuard** — встроенный WireGuard-сервер (без модуля ядра)
- **Управление паролями** — база `passwords.json` с привязкой к устройствам, сроками действия
- **Telegram Bot** — управление паролями, просмотр статистики через Telegram
- **NAT / Firewall** — автоматическая настройка MASQUERADE, iptables/nftables
- **Cтатистика** — мониторинг трафика, активных подключений, uptime

## Сборка

```bash
# Linux amd64
make build-amd64

# Linux arm64
make build-arm64
```

## Установка

```bash
# Собрать
make build-amd64

# Или скачать с релизов
wget https://github.com/elizqmill/maxtunnel-server/releases/latest/download/maxtunnel-server
chmod +x maxtunnel-server

# Запустить
./maxtunnel-server -listen 0.0.0.0:56000 -wg-port 56001 -config-dir /etc/maxtunnel -password YOUR_MASTER_PASSWORD
```

### Systemd (рекомендуется)

```bash
install -m 0755 maxtunnel-server /usr/local/bin/maxtunnel-server
install -m 0644 maxtunnel.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable --now maxtunnel
```

## Параметры

| Флаг | Описание | По умолчанию |
|------|----------|-------------|
| `-listen` | Адрес DTLS | `0.0.0.0:56000` |
| `-wg-port` | Порт WireGuard | `56001` |
| `-config-dir` | Директория конфигурации | `/etc/maxtunnel` |
| `-password` | Пароль владельца | — |
| `-admin` | Telegram Admin ID | — |
| `-bot-token` | Telegram Bot Token | — |
| `-dns` | DNS для клиентов | `1.1.1.1` |

## Обновление

```bash
# Через deploy.sh (без потери конфига)
./deploy.sh user@host ./maxtunnel-server
```

Или через Android-приложение: кнопка **Обновить сервер** в разделе деплоя.
