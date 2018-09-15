From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 15 Sep 2018 15:23:31 +0530
Subject: [LTP] statx04.c:53: FAIL: STATX_ATTR_COMPRESSED flag is not set -
 Testing on ext2
Message-ID: <CA+G9fYsr=iYgaaepEnJOOu_-bR0p=3gCxAhcw6adQWPUnPfiYA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

statx04 test failed on Hikey (arm64) while testing for ext2 which is
running 4.18 stable kernel and LTP master branch. Same test case got
PASS for ext3 and ext4.

Is this test case need any special prerequirements ?

Test log.
tst_test.c:1124: INFO: Testing on ext2
tst_mkfs.c:90: INFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
mke2fs 1.43.5 (04-Aug-2017)
tst_test.c:1063: INFO: Timeout per run is 0h 15m 00s
statx04.c:45: PASS: sys_statx(AT_FDCWD, mntpoint/test_dir1, 0, 0, &buf)
statx04.c:53: FAIL: STATX_ATTR_COMPRESSED flag is not set
statx04.c:58: FAIL: STATX_ATTR_APPEND flag is not set
statx04.c:63: FAIL: STATX_ATTR_IMMUTABLE flag is not set
statx04.c:68: FAIL: STATX_ATTR_NODUMP flag is not set
statx04.c:79: PASS: sys_statx(AT_FDCWD, mntpoint/test_dir2, 0, 0, &buf)
statx04.c:86: PASS: STATX_ATTR_COMPRESSED flag is not set
statx04.c:91: PASS: STATX_ATTR_APPEND flag is not set
statx04.c:96: PASS: STATX_ATTR_IMMUTABLE flag is not set
statx04.c:101: PASS: STATX_ATTR_NODUMP flag is not set

Full test log,
https://lkft.validation.linaro.org/scheduler/job/420924#L13367

Please investigate this failure.

P.S. I did not tested on any other architecture and board.

- Naresh
