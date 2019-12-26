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
```
bastion_IP = 34.77.197.102
someinternalhost_IP = 10.132.0.5
```
## Данные для проверки cloud-testapp
```
testapp_IP = 34.77.32.77
testapp_port = 9292
```

## Деплойка ВМ с приложением
```
gcloud compute instances create reddit-app-2 --boot-disk-size=10GB --image-family ubuntu-1604-lts --image-project=ubuntu-os-cloud --machine-type=g1-small --tags puma-server --restart-on-failure --metadata="startup-script=curl -O http://semer-ilya.myjino.ru/startup.sh && chmod +x startup.sh && chmod 777 startup.sh && sudo -u appuser bash startup.sh"
```

## Деплойка правила файервола
```
gcloud compute --project=infra-262408 firewall-rules create default-puma-server --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:9292 --source-ranges=0.0.0.0/0 --target-tags=puma-server
```

## Готовая ВМ с приложением через Packer:

1. Основной скрипт запуска: FUCKir89_infra/config-scripts/create-redditvm.sh
В нем мы запускаем билд образа, созадаем из этого образа ВМ с приложением и создаем правило фаервола

2. FUCKir89_infra/pascker/immutable.json - конфиг сборки образа

3. FUCKir89_infra/packer/variables.json.example - пример переменных для сборки образа

4. FUCKir89_infra/packer/variables.json и UCKir89_infra/packer/.gitignore - боевые переменные для сборки и файлик который не дает загружать в гит боевые переменные

5. FUCKir89_infra/packer/scripts/install_daemon.sh - скрипт установки демона

6. FUCKir89_infra/blob/packer-base/packer/files/puma.service - файл демона systemd
