English | [简体中文](README-ZH.md)

# ebook-sender-bot
Send E-Book to kindle with Telegram Bot.

Try it: [https://t.me/e_book_send_bot](https://t.me/e_book_send_bot)

> We wanted to let you know that starting August 2022, you’ll no longer be able to send MOBI (.mobi, .azw) files to your Kindle library. Any MOBI files already in your library will not be affected by this change. MOBI is an older file format and won’t support the newest Kindle features for documents. Any existing MOBI files you want to read with our most up-to-date features for documents will need to be re-sent in a compatible format.

> Compatible formats now include EPUB (.epub), which you can send to your library using your Send to Kindle email address. We’ll also be adding EPUB support to the free Kindle app for iOS and Android devices and the Send to Kindle desktop app for PC and Mac. 

## Usage

1. Open bot link:[https://t.me/e_book_send_bot](https://t.me/e_book_send_bot)
2. Send */email your-kindle-email@kindle.com* to set your kindle email address.
3. Add bot email to your [Approved Personal Document E-mail](https://www.amazon.com/hz/mycd/myx#/home/settings/payment).
4. Send a supported document to this bot and check your Kindle.

## Support document format
### send directly
- doc 
- docx 
- rtf 
- html 
- htm 
- pdf
- epub

### convert to epub and send
- azw 
- azw1 
- azw3 
- azw4 
- fb2 
- lrf 
- kfx 
- pdb 
- lit
- txt 
- mobi

---

## Setup

### [recommended] docker-compose install
[docker-compose.yml](docker-compose.yml)
```shell
docker compose up -d
```

The container now persists runtime files under `/app/storage` only. After the first GHCR publish, set the package visibility to `Public` if you want anonymous `docker pull` access.

### [recommended] docker install
```shell
docker run -d \
    --restart unless-stopped \
    --name ebook-sender-bot \
    -e TZ=Asia/Shanghai \
    -e APP_MODE=prod \
    -e MAX_SEND_LIMIT=10 \
    -e FORMAT=epub \
    -e EMAIL_PROVIDER=config \
    -e DB=sqlite \
    -e DB_NAME=/app/storage/ebook-sender-bot.db \
    -e SMTP_HOST=smtp.fastmail.com \
    -e SMTP_PORT=465 \
    -e SMTP_USERNAME=${FASTMAIL_USERNAME} \
    -e SMTP_PASSWORD=${FASTMAIL_PASSWORD} \
    -e BOT_TOKEN=${EBOOK_SENDER_BOT_TOKEN} \
    -e DEVELOPER_CHAT_ID=${EBOOK_SENDER_BOT_DEVELOPER_CHAT_ID} \
    -v ebook-sender-bot-storage:/app/storage \
    ghcr.io/monlor/ebook-sender-bot:latest
```

### source install
1. copy *config.ini.example* to *config.ini*
2. install requirements
```shell
pip3 install -r requirments.txt
```
3. [install calibre](https://calibre-ebook.com/download)
4. run main.py
```shell
python3 main.py
```

### config.ini
```ini
[default]
# mode: [dev] printf runtime log to console 
mode=dev
# Set a daily limit of e-mailing per user
email_send_limit=10
# database: sqlite,mysql,postgresql
database=sqlite
# email_provider: config,mailcow,mailcow_alias
email_provider=config

# when database is sqlite
[sqlite]
name=ebook-sender-bot

# when database is mysql
[mysql]
name=ebook-sender-bot
host=192.168.1.1
port=3306
user=root
password=root

# when database is postgresql
[postgresql]
name=ebook-sender-bot
host=192.168.1.1
port=5432
user=root
password=root

[smtp]
host=smtp.gmail.com
port=465
username=your_email_address
password=your_email_account_password

# when email_provider is mailcow or mailcow_alias
[provider]
mailcow_url=your_mailcow_url
mailcow_api_key=mailcow_admin_api_key
mailcow_mailbox_domain=mailcow_mailbox_domain

[telegram]
# telegram tg_bot token
bot_token=your_telegram_bot_token
# your telegram chat id
developer_chat_id=your_telegram_chat_id
```

## Preview
![telegram-bot](https://cdn.jsdelivr.net/gh/image-backup/qcgzxw-images@master/image/16344769229431634476922938.png)
![kindle](https://cdn.jsdelivr.net/gh/image-backup/qcgzxw-images@master/image/16344842508421634484250830.png)

## Donate

<https://afdian.com/a/ebook-sender-bot>

👉[Buy me a beer](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=M67JY6LTXNLB4&on0=donate&os0=Buy+Me+A+Beer)

👉[Buy me a vps](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=M67JY6LTXNLB4&on0=donate&os0=Buy+Me+A+VPS)

👉[Buy me a keyboard](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=M67JY6LTXNLB4&on0=donate&os0=Buy+Me+A+Keyboard)

## Todo
- [x] docker
- [x] Send document to kindle email
- [x] mysql
- [x] document information
- [x] covert books with calibre
- [x] use configParse instead of os.getenv()
- [x] i18n
- [x] telegram MessageReply class
- [x] admin command
- [ ] unique email
- [ ] queue
- [ ] test case
