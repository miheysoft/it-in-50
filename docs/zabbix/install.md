#Установка и первоначальная настройка
##Установка Zabbix Server 7.4
### **Задача**  
*[Опишите цель или проблему, например:]*  
- Установка Zabbix Server на Debian 13  

---

### **Решение**  
1. **Добавления репозитория Zabbix 7.4 в ранее  приготовленную систему. Для этого выполните 
следующие команды. Для систем на базе Debian:**  
```bash
wget https://repo.zabbix.com/zabbix/7.4/release/debian/pool/main/z/zabbix-release/zabbix-release_latest_7.4+debian13_all.deb
sudo dpkg -i zabbix-release_latest_7.4+debian13_all.deb
sudo apt update  
```  
2. **Теперь установим наш сервер Zabbix с поддержкой pgsql. Для этого выпол-
ните следующие команды:**
```bash

sudo apt install postgresql 
sudo systemctl enable postgresql 
sudo systemctl start postgresql
sudo apt install zabbix-server-pgsql zabbix-frontend-php php8.4-pgsql zabbix-nginx-conf zabbix-sql-scripts zabbix-agent # 
```  
3. **Создаем исходную базу данных**

   Создание пользователя PostgreSQL
   Создание базы данных
   Импорт схемы базы данных
```bash
sudo -u postgres createuser --pwprompt zabbix
sudo -u postgres createdb -O zabbix zabbix
zcat /usr/share/zabbix/sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix
```  
4. **Настройка базы данных для Zabbix-сервера**  
   - Использовать скрипт `alertscripts/telegram.sh` (см. гл. 8 книги).  
```bash
sudo nvim /etc/zabbix/zabbix_server.conf
sudo nvim /etc/zabbix/nginx.conf
sudo systemctl restart zabbix-server nginx php8.4-fpm
sudo systemctl restart postgresql
```  

---

### **Комментарий**  
*[Важные нюансы, личные наблюдения:]*  
- **Важно!** Для SNMP-устройств проверьте версию протокола (v2c/v3) и community-строку.  
- В книге рекомендовано отключить `StartPollers=50` в `zabbix_server.conf` при малом количестве хостов.  
- Проблема: веб-интерфейс не грузился из-за неверных прав на `/etc/zabbix/web/zabbix.conf.php`.  

---

### **Дополнительная информация**  
*[Ссылки, параметры, рекомендации из книги:]*  
- **Ссылки:**  
  - Официальная документация: [Zabbix 7 Manual](https://www.zabbix.com/documentation/7.0/ru)  
  - Глава 4 книги: «Оптимизация производительности сервера».  
- **Параметры для мониторинга Windows-хостов:**  
  - Использовать Zabbix Agent 2 с шаблоном `Template OS Windows by Zabbix agent 2`.  
- **Рекомендация из книги:**  
  > «Для защиты базы данных настройте ежедневное резервное копирование с помощью mysqldump» (с. 112).  

---

**Теги:** `#Установка` `#SNMP` `#Алертинг` `[Дополнительные_теги]`  
**Статус:** [✅ Завершено / ⏳ В процессе / ❗ Проблемы]  

---

### **Советы по использованию шаблона**  
1. Добавляйте теги для быстрого поиска (например, `#Docker`, `#API`).  
2. Используйте `Ctrl + F` для поиска по ключевым словам (например, «SNMP», «ошибка 500»).  
3. В раздел «Комментарий» вносите только субъективные наблюдения, объективные данные — в «Решение» или «Дополнительная информация».  

Пример заполненной заметки — в [приложении](ссылка_на_пример).