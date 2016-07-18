From: nousi <bnousilal@gmail.com>
Date: Mon, 18 Jul 2016 16:06:04 +0530
Subject: [LTP] ltp netns test cases are failing
Message-ID: <CAJ5vXcSyetKpPx4PutrPn8rrK6h8_+a=_2DrZxHskTWOj5aBSw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

please, let me know what could be the reason for failing all the "*netns"* test
cases,
Do I need to enable anything in kernel module before executing these test
cases?



#./netns_crtchild_delchild
netns_crtchild_[1437]: unhandled level 2 translation fault (11) at
0x00000000, esr 0x83000006
pgd = ffffffc1e7694000
[00000000] *pgd=0000000268db6003, *pmd=0000000000000000

CPU: 2 PID: 1437 Comm: netns_crtchild_ Not tainted 3.14.65 #1
task: ffffffc07b551500 ti: ffffffc1e7644000 task.ti: ffffffc1e7644000
PC is at 0x0
LR is at 0x40574c
pc : [<0000000000000000>] lr : [<000000000040574c>] pstate: 00000000
sp : 0000007fe2403d40
x29: 0000007fe2403d40 x28: 0000000000000000
x27: 0000000000000000 x26: 0000000000000000
x25: 0000000000000000 x24: 0000000000000000
x23: 0000000000000000 x22: 0000000000000000
x21: 0000000040020000 x20: 0000000000000000
x19: 0000000000000000 x18: 0000007fe2403ab0
x17: 0000007f9f0a30c0 x16: 0000000000000000
x15: 0000007f9efe7ac8 x14: ffffffffffffffff
x13: 0000000000000005 x12: 000000000000000a
x11: 0000000000000008 x10: 0101010101010101
x9 : 0000000000000000 x8 : 0000000000000039
x7 : 0000007f9f12b2b0 x6 : 0000007f9f12b2b0
x5 : 0000007f9f12c630 x4 : 0000007f9f12c598
x3 : 0000007f9f12c000 x2 : 0000000000000002
x1 : 0000000000407c30 x0 : 0000000000000000

sh: netns_parentns.sh: command not found
netns_crtchild_delchild    1  TFAIL  :  common.c:89: Error while running
the script

root@nousi:/opt/ltp# --: netns_childns.sh: No such file or directory

netns_crtchild               FAIL 1
netns_two_children_ns        FAIL 1
netns_crtchild_delchild      FAIL 1
netns_par_chld_ipv6          FAIL 1
netns_netlink                FAIL 1
netns_devices                FAIL 2
netns_devices2               FAIL 2
netns_isolation              FAIL 2
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160718/779ff347/attachment.html>
