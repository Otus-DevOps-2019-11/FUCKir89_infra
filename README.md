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


## Перая домашка по Terraform:

1. FUCKir89_infra/terraform/terraform.tfvars - файл с переменными (в гит залит для примера terraform.tfvars.example)
2. FUCKir89_infra/terraform/main.tf - описание инстенса
3. FUCKir89_infra/terraform/lb.tf - описание балансировщика
4. FUCKir89_infra/terraform/outputs.tf - файл вывода данных
5. FUCKir89_infra/terraform/variables.tf - объявление переменных

Запускать так:
```
cd terraform && terraform apply -var-file="terraform.tfvars.example"
```
*после поднятия инфраструктуры на экран будет выведен адрес для подключения

### Внимание! Все изменения внесенные не через Terraform при следующем деплое будут затерты!

## Вторая домашка по Terraform:

Создано два окружкения ```stage``` и ```prod```.

Для того чтоб "раскатать" ```stage``` надо перейти в папку ./terraform/stage/ и вы полнить в ней ```terraform apply```

Для того чтоб "раскатать" ```prod``` надо перейти в папку ./terraform/prod/ и вы полнить в ней ```terraform apply```

Так же подцеплены бакеты и настроено хранение в них стейтов.

Что еще писать тут не знаю)

## Первая домашка по Ansible

Написали первый плейбук ```clone.yml```

Изменения в первом и втором прогоне плейбука как следствие того, что в первый раз у нас уже были файлы склоненые с репы,
ансибл их увидел и ничего не сделал. Далее мы через ```command``` грохнули эти файлы и прокатили плейбук еще раз.
Файлов небыло и ансибл выполнил клонирование этих файлов из репы.

Поработали с динамическими inventory для ansible. Было сделано следующее: в стейджовом терраформе в main.tf добавлено создание динамического inventory.

Как сие запускать:

1. Зайти в папку с стейджовым терраформомо и выполнить terraform apply
2. Зайти в папку с ансиблом и дернуть скрипт dynamic_inventory.sh который из терраформовского динамического инвентори делает инвентори файл для ансибла
3. Выполить какой нить плейбук или просто запрос ансибла и проверить, что все работает

## Вторая домашка по Ansible

Что сделали:

1. Сделали темплейт ансибла нашей приложухи
2. Поправили образа пакера
3. Поправили конфиги терраформа

Итог: образ пакером собирается, терраформ раскатывает ВМ, ансибл раскатывает софт и настраивает его. 
