From: nousi <bnousilal@gmail.com>
Date: Fri, 18 Nov 2016 11:46:31 +0530
Subject: [LTP] netns testcases are failing.
Message-ID: <CAJ5vXcRsWRChhW-uCUtQ3y+zJdvFrz+eJMLeUNt9CyL0DWHrkA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

please can someone help me on the below error.
Why the test case is unable create the veth pair.
CONFIG_VETH=y is enabled.

+ scrpt=netns_parent.sh
+ debug 'INFO: Script to be executed in parent NS is netns_parent.sh'
+ '[' 0 = 1 ']'
+ echo 1
+ echo 1
+ create_veth
+ ip link show
+ ip link add type veth
+ sleep 1
+ ip link show
++ diff /tmp/net1 /tmp/net2
++ awk '-F: ' '/^> [0-9]*:/ { print "dev" i+0 "=" $2; i++  }'
+ eval
+ vnet0=
+ vnet1=
+ '[' -z '' -o -z '' ']'
+ tst_resm TFAIL 'Error: unable to create veth pair'
+ tst_flag2mask TFAIL
+ case "$1" in
+ return 1
+ local mask=1
+ LTP_RET_VAL=1
+ local ret=TFAIL
+ shift
+ echo 'netns_parentns.sh 1 TFAIL : Error: unable to create veth pair'
netns_parentns.sh 1 TFAIL : Error: unable to create veth pair
+ case "$ret" in
+ TST_COUNT=2
+ exit 1
netns_crtchild    1  TFAIL  :  common.c:89: Error while running the script

-- 
Thanks & Regards,
B.Nousilal,
