From: Xiuzhe Xiao <xiuzhe.xiao@nautel.com>
Date: Fri, 16 Feb 2018 13:19:53 +0000
Subject: [LTP] No space left on device
Message-ID: <BY2PR13MB0709E6ADB72B75A42150F2F990CB0@BY2PR13MB0709.namprd13.prod.outlook.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi

I met a problem when using LTP
Many tests failed because of "errno=ENOSPC(28): No space left on device"
Here is one of the example:

<<<test_start>>>
tag=readv01 stime=1518724492
cmdline="readv01"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
readv01     1  TBROK  :  safe_macros.c:440: readv01.c:113: write(6,0x30274,4294967295) failed: errno=ENOSPC(28): No space left on device
readv01     2  TBROK  :  safe_macros.c:440: Remaining cases broken
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=2 corefile=no
cutime=0 cstime=1
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20170116
./runltp: line 973: cannot create temp file for here-document: No space left on device

root@adzs-sc589-ezlite:/opt/ltp# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/root              7462604    555564   6504916   8% /
devtmpfs                110608         0    110608   0% /dev
tmpfs                   110688        40    110648   0% /run
tmpfs                   110688        52    110636   0% /var/volatile

Notice I have plenty of space on my disk, and I also check "df -i". Inodes are free as well
Is anyone had this problem? Please give me a hint, I'll be appreciated

Shawnx


This communication, including any attached documentation, is intended only for the person or entity to which it is addressed, and may contain confidential, personal, and/or privileged information. Any unauthorized disclosure, copying, or taking action on the contents is strictly prohibited. If you have received this message in error, please contact us immediately so we may correct our records. Please then delete or destroy the original transmission and any subsequent reply. Thank you.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180216/846db833/attachment.html>
