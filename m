From: Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
Date: Tue, 11 Feb 2020 14:00:39 +0000
Subject: [LTP] Running kill11 failing with safe_macros.h:312: kill11.c:207:
 setrlimit(4, 0x3ffff109c0) failed: errno=EINVAL(22): Invalid argument
Message-ID: <BMXPR01MB29991C0EF971408503911674EE180@BMXPR01MB2999.INDPRD01.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
i am trying to run kill11 test on machine my test is getting breaked with follwing message.

kill11 0 TINFO : Adjusting RLIMIT_CORE to 1048576
kill11 1 TBROK : ../../../../include/old/safe_macros.h:312: kill11.c:207: setrlimit(4,0x3ffff109c0) failed: errno=EINVAL(22): Invalid argument
kill11 2 TBROK : ../../../../include/old/safe_macros.h:312: Remaining cases broken
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200211/e0bfc194/attachment-0001.htm>
