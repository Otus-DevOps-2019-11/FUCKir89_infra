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

testapp_IP = 34.77.32.77
testapp_port = 9292

gcloud compute instances create reddit-app-2 --boot-disk-size=10GB --image-family ubuntu-1604-lts --image-project=ubuntu-os-cloud --machine-type=g1-small --tags puma-server --restart-on-failure --metadata="startup-script=curl -O http://semer-ilya.myjino.ru/startup.sh && chmod +x startup.sh && chmod 777 startup.sh && sudo -u appuser bash startup.sh"

gcloud compute --project=infra-262408 firewall-rules create default-puma-server --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:9292 --source-ranges=0.0.0.0/0 --target-tags=puma-server
