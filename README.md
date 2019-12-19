# FUCKir89_infra
FUCKir89 Infra repository

# Как подключаться через бастион хост

## Краткая инструкция

Для сквозного подключения по ssh через бастион хост нужно отредактировать файл `~/.ssh/config` на своем компьютере (с которого подключаемся)

Пример:

```
Host someinternalhost
        HostName someinternalhost
        ProxyJump semer-ilya@35.241.232.29
        User semer-ilya
```

При такой настройке вводя команду `ssh someinternalhost` на своем компьютере Вы попадете на удаленную ВМ через бастион.


## Данные для проверки cloud-bastion:

bastion_IP = 35.241.232.29 someinternalhost_IP = 10.156.0.3
