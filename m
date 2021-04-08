From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 8 Apr 2021 12:28:02 +0200
Subject: [LTP] LTP msgstress03,
 msgstress04 failure on linux 5.10.19 and 5.10.22
In-Reply-To: <BM1PR01MB28686329F64867227F9F9279EE749@BM1PR01MB2868.INDPRD01.PROD.OUTLOOK.COM>
References: <BMXPR01MB287023E7E5B34F6D27B63564EE7E9@BMXPR01MB2870.INDPRD01.PROD.OUTLOOK.COM>
 <60619D5B.6090507@fujitsu.com>
 <BMXPR01MB2870D0447A89D1BEE08EDCA7EE7E9@BMXPR01MB2870.INDPRD01.PROD.OUTLOOK.COM>
 <BM1PR01MB2868C0458678E57C87BBC708EE749@BM1PR01MB2868.INDPRD01.PROD.OUTLOOK.COM>
 <YG7Mbc/ZTnD85SAh@yuki>
 <BM1PR01MB28686329F64867227F9F9279EE749@BM1PR01MB2868.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <YG7asu6B4EEa1HUD@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> sorry, i forgot to attach log file.The LTP version i am using is  LTP Version:  20200515 and even i have tried with latest master sources as well

Using anything older than the latest stable release is strongly discouraged.

<<<test_start>>>
tag=msgstress03 stime=1617104557
cmdline="msgstress03"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
Fork failed (may be OK if under stress)
Fork failed (may be OK if under stress)
Fork failed (may be OK if under stress)
Fork failed (may be OK if under stress)
Fork failed (may be OK if under stress)
Fork failed (may be OK if under stress)
msgstress03    1  TFAIL  :  msgstress03.c:155:  Fork failed (may be OK if under stress)
<<<execution_status>>>

Here is the real reason for the failures, the test fails to fork() a few times,
that is since the machine seems to have 8GB RAM and for the default maximal
number of message queues 32000 (as set in /proc/sys/kernel/msgmni) is too high.

In other words we do have 8GB RAM and try to fork 64000 (two processes per
message queue) that leaves us about 125kB per process (aprox: 8 * 1024 * 1024 /
64000) which is likely too low. You can try to set the /proc/sys/kernel/msgmni
to half of it's default i.e. 16000 and re-run the test.

The test should be cleaned up changed to scale better with available memory
however estimating how much memory will the test process need is not an easy
task.

The rest of the messages you see are as I've said fallout from the test doing
unclean exit, i.e. the main process exits without waiting for it's children.
Which should be fixed as well, when the test is being rewritten.

-- 
Cyril Hrubis
chrubis@suse.cz
