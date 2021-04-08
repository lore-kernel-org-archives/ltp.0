From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 8 Apr 2021 11:27:09 +0200
Subject: [LTP] LTP msgstress03,
 msgstress04 failure on linux 5.10.19 and 5.10.22
In-Reply-To: <BM1PR01MB2868C0458678E57C87BBC708EE749@BM1PR01MB2868.INDPRD01.PROD.OUTLOOK.COM>
References: <BMXPR01MB287023E7E5B34F6D27B63564EE7E9@BMXPR01MB2870.INDPRD01.PROD.OUTLOOK.COM>
 <60619D5B.6090507@fujitsu.com>
 <BMXPR01MB2870D0447A89D1BEE08EDCA7EE7E9@BMXPR01MB2870.INDPRD01.PROD.OUTLOOK.COM>
 <BM1PR01MB2868C0458678E57C87BBC708EE749@BM1PR01MB2868.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <YG7Mbc/ZTnD85SAh@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I am running msgstress03,msgstress04 with 5.10.19 and 5.10.22 custom
> kernel built using Yocto but both test are getting failed repeatedly.
> i am not able to understand what making both test to fail since these
> tests are stress tests for message queue want to figure if anything
> going wrong with message queue.

What about the LTP version? Can you please include that information
every time you ask abou test failures?

> Pasting few error messages and attaching detailed logs of failures
> 
> msgstress03:-
> msgsnd() error in child 9458, write # = 10000, key = 65e2d9c4: Interrupted system call
> msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43902).
> msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
> msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43925).
> msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
> msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: Cannot open directory /tmp/ltp-9Raz9tykpq/msgQaAD8i; errno=2: ENOENT
> msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43927).
> msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
> msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: Cannot open directory /tmp/ltp-9Raz9tykpq/msgQaAD8i; errno=2: ENOENT
> msgsnd() error in child 9468, write # = 10000, key = 5364a4ac: Interrupted system call
> msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43918).
> msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
> msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
> msgsnd() error in child 9450, write # = 10000, key = 6015ef48: Interrupted system call
> msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43883).
> msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
> msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
> msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43924).
> msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
> msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
> msgsnd() error in child 9454, write # = 10000, key = 37efb13a: Interrupted system call

This looks like fallout from the test doing unclean exit, the root cause
for the failure should be somewhere at the beginning of the log.

-- 
Cyril Hrubis
chrubis@suse.cz
