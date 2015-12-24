This is my CS50 2015 final project


## Install

Install ansible on your computer. Create inventory file like

[ws]
Ip or hostname of host

And change sip user and sip host in playbook.

After that you need to install and run manually RTPENGINE with command rtpengine -i [IP OF SERVER] --listen-ng=127.0.0.1:22222 -m 30000 -M 35000 --dtls-passive

