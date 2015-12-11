From: Manjeet Pawar <manjeet.p@samsung.com>
Date: Fri, 11 Dec 2015 11:14:49 +0000 (GMT)
Subject: [LTP]   [Query] Regarding network testcases
Message-ID: <1197254909.597791449832489214.JavaMail.weblogic@epmlwas04b>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

HI,

I am running "ssh-stress 6" 
Rhost= TARGET (fd00::1:1:1:1), Lhost= local machine (localhost = ::1) 

I encountered following issues: (Test03) : When Rhost issue command "ssh-stress03-rmt 6 fd00::1:1:1:1  /root/tmp.fzkPCzr4QA/ssh_config 56218 10  " to local machine, Why local machine check TCP fastopen with localhost (::1) when there is no TCP server running on 
local machine. I guess to run TCP client on a machine, there should be TCP server running on it . Please check below logs 

+tcp_fastopen -R 3 -g 56218
++ tst_ipaddr
++ local type=lhost
++ local ipv=6
++ local tst_host=
++ '[' lhost = lhost ']'
++ eval 'tst_host=$LHOST_IPV6_HOST'
+++ tst_host=:1:1:1:1
++ '[' 6 ']'
++ echo fd00::1:1:1:1
+ tst_rhost_run -s -c 'ssh-stress03-rmt 6 fd00::1:1:1:1 		/root/tmp.fzkPCzr4QA/ssh_config 56218 10'
+ local pre_cmd=
+ local 'post_cmd= || echo RTERR'
+ local out=
+ local user=root
+ local cmd=
+ local safe=0
+ OPTIND=0
+ getopts :bsc:u: opt
+ case "$opt" in
+ safe=1
+ getopts :bsc:u: opt
+ case "$opt" in
+ cmd='ssh-stress03-rmt 6 fd00::1:1:1:1 		/root/tmp.fzkPCzr4QA/ssh_config 56218 10'
+ getopts :bsc:u: opt
+ OPTIND=0
+ '[' -z 'ssh-stress03-rmt 6 fd00::1:1:1:1 		/root/tmp.fzkPCzr4QA/ssh_config 56218 10' ']'
+ local output=
+ local ret=0
+ TST_USE_SSH=1
+ '[' -n 1 ']'
++ ssh -n -q root@107.109.223.240 'sh -c 			'\ssh-stress03-rmt 6 fd00::1:1:1:1 		/root/tmp.fzkPCzr4QA/ssh_config 56218 10  || echo RTERR'\'''
+ output='+ TCID=ssh_stress03_rmt
+ TST_TOTAL=1
+ . test.sh
+ export LTP_RET_VAL=0
+ export TST_COUNT=1
+ export TST_LIB_LOADED=1
+ [ -z ssh_stress03_rmt ]
+ [ -z 1 ]
+ export TCID=ssh_stress03_rmt
+ export TST_TOTAL=1
+ [ -z  ]
+ export LTPROOT=/root
+ export LTP_DATAROOT=/root/datafiles
+ [ 5 -ne 5 ]
+ ip_ver=6
+ server_ipaddr=fd00::1:1:1:1
+ ssh_config=/root/tmp.fzkPCzr4QA/ssh_config
+ rport=56218
+ requests=10
+ ssh -6 -F /root/tmp.fzkPCzr4QA/ssh_config fd00::1:1:1:1 true < /dev/null > /dev/null 2>&1
+ [ 0 -ne 0 ]
+ tst_get_unused_port ipv6 stream
+ lport=15051
+ localhost=::1
+ ssh -6 -f -N -L 15051/[fd00::1:1:1:1]/56218 root@fd00::1:1:1:1 -F /root/tmp.fzkPCzr4QA/ssh_config
Bad local forwarding specification '\''15051/[fd00::1:1:1:1]/56218'\''

<highlighted section>
//////////+ tcp_fastopen -r 10 -l -H ::1 -g 15051  /////////////////  

+ ret=2
+ ps auxw
+ grep -Fv grep
+ + grep ssh[[:blank:]].*/root/tmp.fzkPCzr4QA/ssh_config
awk {print $2}
ssh_stress03_rmt 1 TBROK : TCP traffic client is dead
RTERR
tcp_fastopen is not able to run

please correct me if I am doing somethings wrong.

Thanks
