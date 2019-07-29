#!/bin/bash

action="$1"

RULES=( "-I INPUT -p udp --dport 4500 -j ACCEPT"
        "-I INPUT -p udp --dport 500 -j ACCEPT"
        "-I INPUT -p esp -j ACCEPT")

function add_filter_header()
    {
        touch /etc/sysconfig/iptables-custom
        echo "" >> /etc/sysconfig/iptables-custom
        echo "*filter" >> /etc/sysconfig/iptables-custom
        echo ":INPUT DROP [0:0]" >> /etc/sysconfig/iptables-custom
        echo ":FORWARD DROP [0:0]" >> /etc/sysconfig/iptables-custom
        echo ":OUTPUT ACCEPT [0:0]" >> /etc/sysconfig/iptables-custom
        echo "COMMIT" >> /etc/sysconfig/iptables-custom
    }

function add_rules()
    {
        #https://stackoverflow.com/questions/30099736/sed-insert-line-after-x-lines-after-match
        for rule in "${RULES[@]}"; do
            sed "/\*filter/!{p;d;};n;n;n;a $rule" -i /etc/sysconfig/iptables-custom
        done;

        #sed '/\*filter/!{p;d;};n;n;n;a -I INPUT -p udp --dport 4500 -j ACCEPT' -i /etc/sysconfig/iptables-custom
        #sed '/\*filter/!{p;d;};n;n;n;a -I INPUT -p udp --dport 500 -j ACCEPT' -i /etc/sysconfig/iptables-custom
        #sed '/\*filter/!{p;d;};n;n;n;a -I INPUT -p esp -j ACCEPT' -i /etc/sysconfig/iptables-custom
    }

stat /etc/sysconfig/iptables-custom 2>1 >/dev/null
# if /etc/sysconfig/iptables-custom file exists
if [ $? -eq 0 ]; then
    # check if *filter exists
    grep -q "*filter" /etc/sysconfig/iptables-custom 2>1 >/dev/null
    if [ $? -eq 0 ]; then
        for rule in "${RULES[@]}"; do
            #grep -q "$rule" /etc/sysconfig/iptables-custom 2>1 >/dev/null
            grep -q "$(echo $rule|sed 's#-#\\-#g')" /etc/sysconfig/iptables-custom 2>1 >/dev/null
            if [ $? -gt 0 ]; then
                sed "/\*filter/!{p;d;};n;n;n;a $rule" -i /etc/sysconfig/iptables-custom
            fi
            if [ "$action" == "uninstall" ]; then
                sed "s#$rule.*##" -i /etc/sysconfig/iptables-custom
            fi
        done;
        #add_rules
    # if *filter doesn't exist
    else
        add_filter_header
        add_rules
    fi
# if /etc/sysconfig/iptables-custom doesn't exist
else
    add_filter_header
    add_rules
fi

jem=$(which /usr/bin/jem 2>/dev/null)
if [ $? -eq 0 ]; then
    $jem firewall fwstart
fi
