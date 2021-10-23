#!/bin/bash

ED="\033[31m"     # Error message
GREEN="\033[32m"  # Success message
YELLOW="\033[33m" # Warning message
BLUE="\033[36m"   # Info message
PLAIN='\033[0m'

slogon() {
    echo -e ${GREEN} "     _   _   _   _   _   _   _     _   _   _   _   ${PLAIN}"
    echo -e ${GREEN} " / \ / \ / \ / \ / \ / \ / \   / \ / \ / \ / \ / \ ${PLAIN}"
    echo -e ${BLUE} " ( I | N | S | T | A | L | L ) ( N | G | I | N | X  ${PLAIN}"
    echo -e ${GREEN} " \_/ \_/ \_/ \_/ \_/ \_/ \_/   \_/ \_/ \_/ \_/ \_/ ${PLAIN}"
}

preInstall() {
    #instlal wget and netstat
    colorEcho ${YELLOW} "INSTALL ESSTENTIAL TOOLS "
    yum install -y epel-release telnet wget vim net-tools ntpdate unzip
    res=$(which wget)
    [[ "$?" -ne "0" ]] && yum install -y wget
    res=$(which netstat)
    [[ "$?" != "0" ]] && yum install -y net-tools
}

installNginx() {
    # yum install -y nginx
    res=$(command -v nginx)
    # [[ "$?" -ne "0" ]] && colorEcho ${RED} "Nginx install failed";exit 1
    colorEcho ${GREEN} "是否选择开机启动nginx,默认自启动"
    read -p "Please Choose[y/n]" answer
    if [[ -z "$answer" ]]; then
        echo "systemctl enable nginx"
    elif [[ "$answer" -eq "y" ]]; then
        echo "systemctl enable nginx"
    else
        echo "skip enable nginx"
    fi
}

colorEcho() {
    echo -e "${1}${@:2}${PLAIN}" #输出入参的第2个至最后一个参数
}
main() {
    slogon
    preInstall
    installNginx
}
main"$@"
