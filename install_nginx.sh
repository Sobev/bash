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
    yum install -y nginx
    res=$(command -v nginx)
    [[ "$?" -ne "0" ]] && colorEcho ${RED} "Nginx install failed"
    exit 1
    colorEcho ${GREEN} "是否选择开机启动nginx,默认自启动"
    read -p "Please Choose[y/n]" answer
    if [[ -z "$answer" ]]; then
        echo "systemctl enable nginx"
    elif [[ "$answer" -eq "y" ]]; then
        echo "systemctl enable nginx"
    else
        echo "skip enable nginx"
    fi

    cat >/etc/nginx/nginx.conf <<-EOF
user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

# Load dynamic modules. See /usr/share/doc/nginx/README.dynamic.
include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    log_format  main  '\$remote_addr - \$remote_user [\$time_local] "\$request" '
                      '\$status \$body_bytes_sent "\$http_referer" '
                      '"\$http_user_agent" "\$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    gzip                on;
    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 2048;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    # Load modular configuration files from the /etc/nginx/conf.d directory.
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    # for more information.
    include /etc/nginx/conf.d/*.conf;
}
EOF
    startNginx
    res=$(netstat -nltp | grep 443 | grep nginx)
    if [[ "${res}" = "" ]]; then
        nginx -t
        echo -e " 请到 ${RED}nginx启动失败！${PLAIN} "
        exit 1
    fi
}

startNginx() {
    systemctl start nginx
}

stopNginx() {
    systemctl stop nginx
}

setFirewall() {
    systemctl status firewalld >/dev/null 2>&1
    if [[ $? -eq 0 ]]; then
        firewall-cmd --permanent --add-service=http
        firewall-cmd --permanent --add-service=https
        if [[ "$PORT" != "443" ]]; then
            firewall-cmd --permanent --add-port=${PORT}/tcp
        fi
        firewall-cmd --reload
    else
        nl=$(iptables -nL | nl | grep FORWARD | awk '{print $1}') # -nL numberic and List  nl add number to list
        if [[ "$nl" != "3" ]]; then
            iptables -I INPUT -p tcp --dport 80 -j ACCEPT
            iptables -I INPUT -p tcp --dport 443 -j ACCEPT
            if [[ "$PORT" != "443" ]]; then
                iptables -I INPUT -p tcp --dport ${PORT} -j ACCEPT
            fi
        fi
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
