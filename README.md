## iPerf-Report - реализация измерения канала связи внутри туннеля ipsec/gre с отправкой оповещений в Telegram, в случае падения скорости ниже указанного значения.

![Image alt](https://github.com/Lifailon/iPerf-Report/blob/rsa/Screen/Telegram-Report-150Mbits.jpg)

Для измерения используется [iperf3](https://github.com/esnet/iperf).

**Требования:**
* Два сервера на базе Windows.
* **Серверная часть**. Открыть в Firewall порт 5221 (указан по умолчанию, можно изменить). Необходимо скопировать директорию **win-iperf** в любое удобное место (**для запуска программы используется путь: .\iperf\iperf3.exe из корня директории win-iperf**) и добавить в планировщик **iperf-Server-Restart.ps1**, который будет проверять процесс iperf, и в случае остановки (например, после перезагрузки ОС), перезапускать его в режиме daemon. Для остановки серверной части: **iperf-Server-Stop.ps1**.
* **Клиентская часть**. Так же скопировать директорию и добавить в планировщик **iperf-Client-Report-Telegram.ps1** с запуском каждые 20-30 минут. В скрипте нужно указать свои значения:

$srv = "server-name" # Имя сервера, на котором запущена серверная часть

$trigger = "150" # Триггерное значение (условие, в Mbits/sec), для срабатывания отправки оповещения

$token_bot = "" # Токен вашего бота в Telegram

$id_chat = "" # id чата Telegram, для отправки уведомления

> Передается 1100 Mbytes в обе стороны, если будет использоваться меньше, необходимо заменить в скрипте GBytes на MBytes для корректного парсинга вывода.

**После каждого запуска, результаты измерения логируются:**

![Image alt](https://github.com/Lifailon/iPerf-Report/blob/rsa/Screen/iperf-log.jpg)

Для тестирования вывода в консоль: **iperf-Client-Report-Write-Host.ps1**

![Image alt](https://github.com/Lifailon/iPerf-Report/blob/rsa/Screen/Write-Host-155Mbits.jpg)

**В дальнейшем добавлю скрипты bash и шаблон Zabbix**
