## iPerf-Report - применяется для измерения канала связи внутри туннеля (ipsec/gre) и оповещении, в случае низкой скорости.

![Image alt](https://github.com/Lifailon/iPerf-Report/blob/rsa/Screen/Telegram-Report-150Mbits.jpg)

Для измерения применяется [iperf3](https://github.com/esnet/iperf).

**Требования:**
* Два сервера на базе Windows.
* Серверная часть. Необходимо скопировать директорию **win-iperf** в любое удобное место (**для запуска iperf используется путь: .\iperf\iperf3.exe**) и запустить в планировщик **iperf-Server-Restart.ps1**, который будет проверять процесс iperf, и в случае остановки (например, после перезагрузки), перезапускать его в режиме daemon. Для остановки серверной части: **iperf-Server-Stop.ps1**.
* Клиентская часть. Так же скопировать директорию и добавить в планировщик **iperf-Client-Report-Telegram.ps1**, в котором нужно указать свои значения:

$srv = "server-name" # Имя сервера, на котором запущена серверная часть

$trigger = "150" # Триггерное значение (условие, в Mbits/sec), для отправки оповещения

$token_bot = "" # Токен вашего бота в Telegram

$id_chat = "" # id чата Telegram, для отправки уведомления

> По умолчанию для серверной и клиентской части мною указан порт 5221, который необходимо открыть в firewall. Передача по 1100 Mbytes в обе стороны, если будет использоваться меньше, необходимо заменить в скрипте GBytes на MBytes для корректного парсинга вывода.

**Результаты измерения логируются, после каждого запуска:**
![Image alt](https://github.com/Lifailon/iPerf-Report/blob/rsa/Screen/iperf-log.jpg)

Для тестирования вывода в консоль: **iperf-Client-Report-Write-Host.ps1**
![Image alt](https://github.com/Lifailon/iPerf-Report/blob/rsa/Screen/Write-Host-155Mbits.jpg)

**В дальнейшем добавлю скрипты bash и шаблон Zabbix**
