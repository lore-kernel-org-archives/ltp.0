From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 18 Nov 2016 13:00:13 +0300
Subject: [LTP] netns testcases are failing.
In-Reply-To: <CAJ5vXcRsWRChhW-uCUtQ3y+zJdvFrz+eJMLeUNt9CyL0DWHrkA@mail.gmail.com>
References: <CAJ5vXcRsWRChhW-uCUtQ3y+zJdvFrz+eJMLeUNt9CyL0DWHrkA@mail.gmail.com>
Message-ID: <582ED12D.1090400@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On 11/18/2016 09:16 AM, nousi wrote:
> Hi,
>
> please can someone help me on the below error.
> Why the test case is unable create the veth pair.
> CONFIG_VETH=y is enabled.
>
> + scrpt=netns_parent.sh
> + debug 'INFO: Script to be executed in parent NS is netns_parent.sh'

There is no such script since commit, netns tests were rewritten a year ago:

commit 3a23e1bf110e9b14e599e2181031ceb32d267516
Author: Matus Marhefka <mmarhefk@redhat.com>
Date:   Tue Aug 18 13:58:45 2015 +0200

     containers/netns tests rewritten

Please make sure you are running the latest LTP version.

Thanks,
Alexey

> + '[' 0 = 1 ']'
> + echo 1
> + echo 1
> + create_veth
> + ip link show
> + ip link add type veth
> + sleep 1
> + ip link show
> ++ diff /tmp/net1 /tmp/net2
> ++ awk '-F: ' '/^> [0-9]*:/ { print "dev" i+0 "=" $2; i++  }'
> + eval
> + vnet0=
> + vnet1=
> + '[' -z '' -o -z '' ']'
> + tst_resm TFAIL 'Error: unable to create veth pair'
> + tst_flag2mask TFAIL
> + case "$1" in
> + return 1
> + local mask=1
> + LTP_RET_VAL=1
> + local ret=TFAIL
> + shift
> + echo 'netns_parentns.sh 1 TFAIL : Error: unable to create veth pair'
> netns_parentns.sh 1 TFAIL : Error: unable to create veth pair
> + case "$ret" in
> + TST_COUNT=2
> + exit 1
> netns_crtchild    1  TFAIL  :  common.c:89: Error while running the script
>

