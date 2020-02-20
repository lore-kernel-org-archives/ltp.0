From: Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
Date: Thu, 20 Feb 2020 06:09:31 +0000
Subject: [LTP] min_free_kbytes  test failing
Message-ID: <BM1PR0101MB1459EF571BFF86EE43FBF66BEE130@BM1PR0101MB1459.INDPRD01.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
I am running min_free_kbytes on my RISC  v system wth linux 5.4.3 with custom Yocto distro,the test is getting failed with following errors.What could be the possible reason for failure?


root@exaleapsemi:~/pankaj_ltp/ltp/testcases/kernel/mem/tunable# ./min_free_kbytes
tst_test.c:1206: INFO: Timeout per run is disabled
mem.c:817: INFO: set overcommit_memory to 2
mem.c:817: INFO: set min_free_kbytes to 11441
memfree is 7968532 kB before eatup mem
memfree is 4196564 kB after eatup mem
mem.c:817: INFO: set min_free_kbytes to 22882
memfree is 7967752 kB before eatup mem
memfree is 4198660 kB after eatup mem
mem.c:817: INFO: set min_free_kbytes to 163642
memfree is 7967328 kB before eatup mem
memfree is 4186296 kB after eatup mem
mem.c:817: INFO: set overcommit_memory to 0
mem.c:817: INFO: set min_free_kbytes to 11441
memfree is 7966824 kB before eatup mem
min_free_kbytes.c:152: FAIL: child unexpectedly failed: 11
mem.c:817: INFO: set min_free_kbytes to 22882
memfree is 7992744 kB before eatup mem
safe_macros.c:633: BROK: min_free_kbytes.c:121: waitpid(34,0x3fffec0854,10) failed: ECHILD (10)
min_free_kbytes.c:147: FAIL: child unexpectedly failed: 512
mem.c:817: INFO: set min_free_kbytes to 163642
memfree is 7987848 kB before eatup mem
safe_macros.c:633: BROK: min_free_kbytes.c:121: waitpid(34,0x3fffec0854,10) failed: ECHILD (10)
min_free_kbytes.c:147: FAIL: child unexpectedly failed: 512
mem.c:817: INFO: set overcommit_memory to 1
mem.c:817: INFO: set min_free_kbytes to 11441
memfree is 7987748 kB before eatup mem
min_free_kbytes.c:134: FAIL: child unexpectedly failed: 11
mem.c:817: INFO: set min_free_kbytes to 22882
memfree is 7995428 kB before eatup mem
min_free_kbytes.c:134: FAIL: child unexpectedly failed: 11
mem.c:817: INFO: set min_free_kbytes to 163642
memfree is 7995760 kB before eatup mem
min_free_kbytes.c:134: FAIL: child unexpectedly failed: 11
min_free_kbytes.c:82: PASS: min_free_kbytes test pass
mem.c:817: INFO: set min_free_kbytes to 11441
mem.c:817: INFO: set overcommit_memory to 0

Summary:
passed   1
failed   6
skipped  0
warnings 0

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200220/a5d0a0e4/attachment.htm>
