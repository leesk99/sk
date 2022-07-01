#!/bin/bash

##
## 해당 스크립트는 /etc/ssh/sshd_config 의 포트를 변경 시켜줍니다.
## made by yj

sed -i 's/#Port\ 22/Port\ 10022/g' /etc/ssh/sshd_config

