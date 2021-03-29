From: Pankaj Vinodrao Joshi <Pankaj.VJ@exaleapsemi.com>
Date: Mon, 29 Mar 2021 09:07:51 +0000
Subject: [LTP] msgstress03, msgstress04 failure on linux 5.10.19 and 5.10.22
Message-ID: <BMXPR01MB287023E7E5B34F6D27B63564EE7E9@BMXPR01MB2870.INDPRD01.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
I am running msgstress03,msgstress04 with 5.10.19 and 5.10.22 custom kernel built using Yocto but both test are getting failed repeatedly. i am not able to understand what making both test to fail since these tests are stress tests for message queue want to figure if anything going wrong with message queue.

Pasting few error message and attaching detailed logs of failures

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

msgstress04:-
msgstress04    0  TINFO  :  Found 31994 available message queues
msgstress04    0  TINFO  :  Using upto 2097104 pids
Fork failure in the second child of child group 9218
Fork failure in the first child of child group 9198
Fork failure in the first child of child group 9216
Fork failure in the first child of child group 9208
Fork failure in the first child of child group 9250
Fork failure in the second child of child group 9249
Fork failure in the first child of child group 9230
Fork failure in the first child of child group 9233
Fork failure in the first child of child group 9247
Fork failure in the first child of child group 9254
Fork failure in the second child of child group 9228
Fork failure in the second child of child group 9253
Fork failure in the first child of child group 9242
Fork failure in the second child of child group 9246
Fork failure in the first child of child group 9243
Fork failure in the second child of child group 9240
Fork failure in the second child of child group 9238
Fork failure in the first child of child group 9252
msgstress04    1  TFAIL  :  msgstress04.c:204: Fork failed (may be OK if under stress)
Fork failure in the second child of child group 9234

Kindly help to get the failure resolved.

Thanks
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210329/d25029eb/attachment-0001.htm>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: ms04.txt
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210329/d25029eb/attachment-0002.txt>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: msgs03.txt
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210329/d25029eb/attachment-0003.txt>
