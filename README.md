# FUCKir89_infra
FUCKir89 Infra repository

# Как подключаться через бастион хост

## Краткая инструкция

Для сквозного подключения по ssh через бастион хост нужно отредактировать файл `~/.ssh/config` на своем компьютере (с которого подключаемся)

Пример:

```
Host someinternalhost
        HostName someinternalhost
        ProxyJump appuser@34.77.197.102
        User appuser
        IdentityFile ~/.ssh/appuser
```

При такой настройке вводя команду `ssh someinternalhost` на своем компьютере Вы попадете на удаленную ВМ через бастион.


## Данные для проверки cloud-bastion:

bastion_IP = 34.77.197.102
someinternalhost_IP = 10.132.0.5

testapp_IP = 10.132.0.9
testapp_port = 9292
