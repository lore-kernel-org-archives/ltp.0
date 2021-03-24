From: Pankaj Vinodrao Joshi <Pankaj.VJ@exaleapsemi.com>
Date: Wed, 24 Mar 2021 17:43:58 +0000
Subject: [LTP] Msgstress03,
 msgstress04 failure with kernel-5.10.19 and kernel-5.10.22
Message-ID: <BMXPR01MB2870F3CF826EB5BD5F813C46EE639@BMXPR01MB2870.INDPRD01.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
i am running ltp on kernel -5.10.19 and 5.10.22 but tests are getting failed repetitively i am attaching log file for failure.

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
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43898).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43926).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43872).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43853).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43895).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43920).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9429, write # = 10000, key = 671584ca: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43846).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9443, write # = 10000, key = 473b7a9b: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43869).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9447, write # = 10000, key = 63f52d12: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43880).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9466, write # = 10000, key = f6a1561: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43916).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9428, write # = 10000, key = 7ac2c197: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43845).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9437, write # = 10000, key = 2d872afe: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43863).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9445, write # = 10000, key = 62fd4032: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43878).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43906).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9435, write # = 10000, key = 54ede123: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43852).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9427, write # = 10000, key = 582ce21c: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43844).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43870).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43897).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9432, write # = 10000, key = 2c82e224: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43849).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43843).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9441, write # = 10000, key = 5e1a36a4: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43867).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43896).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9430, write # = 10000, key = 538d3bc4: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43847).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43833).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9439, write # = 10000, key = 682d9f: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43865).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9425, write # = 10000, key = 46565e73: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43827).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43892).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43831).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9416, write # = 10000, key = 49aa3593: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43818).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9417, write # = 10000, key = 1106d84c: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43819).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43854).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9426, write # = 10000, key = 6ef4a81e: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43828).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9420, write # = 10000, key = 679d9dde: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43822).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9415, write # = 10000, key = 4242ef4c: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43817).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43855).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9422, write # = 10000, key = 21fbf682: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43824).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9414, write # = 10000, key = e8288d: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43816).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43861).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43856).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43829).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9413, write # = 10000, key = 3c310d2c: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43815).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43921).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9452, write # = 10000, key = 21bf954a: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43885).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43858).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9467, write # = 10000, key = 52272b34: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43917).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43832).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9436, write # = 10000, key = 64f4c0d4: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43862).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9457, write # = 10000, key = 26e4358b: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43901).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9465, write # = 10000, key = 25dd9844: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43915).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43835).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9438, write # = 10000, key = 73470c0b: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43864).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9460, write # = 10000, key = df99853: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43904).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9464, write # = 10000, key = 6d3282fc: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43914).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9440, write # = 10000, key = 26df19e8: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43866).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9463, write # = 10000, key = 3a7c5249: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43913).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43909).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9462, write # = 10000, key = 310ea356: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43912).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43922).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43837).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9442, write # = 10000, key = 6215424f: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43868).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43910).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43923).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43840).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43890).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43908).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43889).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43905).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43842).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9459, write # = 10000, key = 432a9826: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43903).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43873).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9431, write # = 10000, key = 6de4307b: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43848).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9455, write # = 10000, key = db61c52: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43899).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9434, write # = 10000, key = 74cf1272: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43851).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43888).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43894).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43857).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9453, write # = 10000, key = 211be76: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43886).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43893).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43874).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9448, write # = 10000, key = 7403ef61: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43881).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43891).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43860).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43875).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43887).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43871).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9446, write # = 10000, key = 97e4091: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43879).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9451, write # = 10000, key = 5ba167ed: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43884).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9444, write # = 10000, key = 1a4b196f: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43877).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgsnd() error in child 9449, write # = 10000, key = 7bd264cd: Interrupted system call
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43882).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken
msgstress03    0  TWARN  :  tst_tmpdir.c:336: tst_rmdir: rmobj(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed: unlink(/tmp/ltp-9Raz9tykpq/msgQaAD8i) failed; errno=2: ENOENT
msgstress03    1  TBROK  :  tst_sig.c:232: unexpected signal SIGINT(2) received (pid = 43876).
msgstress03    2  TBROK  :  tst_sig.c:232: Remaining cases broken



Can someone please help me what could be the possible reason for failure on both the kernel ???


Thanks!
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210324/681c5a59/attachment-0001.htm>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: msgs.txt
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210324/681c5a59/attachment-0001.txt>
