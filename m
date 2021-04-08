From: Pankaj Vinodrao Joshi <Pankaj.VJ@exaleapsemi.com>
Date: Thu, 8 Apr 2021 09:02:30 +0000
Subject: [LTP] LTP msgstress03,
 msgstress04 failure on linux 5.10.19 and 5.10.22
In-Reply-To: <BMXPR01MB2870D0447A89D1BEE08EDCA7EE7E9@BMXPR01MB2870.INDPRD01.PROD.OUTLOOK.COM>
References: <BMXPR01MB287023E7E5B34F6D27B63564EE7E9@BMXPR01MB2870.INDPRD01.PROD.OUTLOOK.COM>,
 <60619D5B.6090507@fujitsu.com>,
 <BMXPR01MB2870D0447A89D1BEE08EDCA7EE7E9@BMXPR01MB2870.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <BM1PR01MB2868C0458678E57C87BBC708EE749@BM1PR01MB2868.INDPRD01.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hi,
I am running msgstress03,msgstress04 with 5.10.19 and 5.10.22 custom kernel built using Yocto but both test are getting failed repeatedly. i am not able to understand what making both test to fail since these tests are stress tests for message queue want to figure if anything going wrong with message queue.
Pasting few error messages and attaching detailed logs of failures

msgstress03:-
msgsnd() error in child 9458, write # = 10000, key = 65e2d9c4: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43902).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43925).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: Cannot open directory /tmp/ltp-9Raz9tykpq/msgQaAD8i; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43927).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: Cannot open directory /tmp/ltp-9Raz9tykpq/msgQaAD8i; errno=2: ENOENT
msgsnd() error in child 9468, write # = 10000, key = 5364a4ac: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43918).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9450, write # = 10000, key = 6015ef48: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43883).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43924).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9454, write # = 10000, key = 37efb13a: Interrupted system call

Kindly help to get the failure resolved.

Thanks
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210408/25be34a2/attachment.htm>
