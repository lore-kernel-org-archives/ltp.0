From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Wed, 19 Dec 2018 14:33:47 -0200
Subject: [LTP] lib: tst_device.c - /dev/loop0 in use
Message-ID: <de5fb563-4273-7132-f94d-887e6e211672@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Cyril,

Apparently, when having "all_filesystems" flag set for one test, there
is a room of opportunity for the subsequent filesystems tests to find
the device, acquired by "tst_acquire_device()", busy.

I suppose, in the case bellow, fsync() caused async work in some kernel
thread to cause the "/dev/loop0 is apparently in use by the system"
error when trying a new mkfs.XXXX call - for the subsequent filesystem -
using the same acquired device.

With the "all_filesystems" logic, the acquired device is not detached,
nor find_free_loopdev() is called again, which *could* mitigate this.

The error:

tst_test.c:1015: INFO: Timeout per run is 0h 15m 00s
fsync01.c:58: PASS: fsync() returned 0
fsync01.c:58: PASS: fsync() returned 0
fsync01.c:58: PASS: fsync() returned 0
fsync01.c:58: PASS: fsync() returned 0
fsync01.c:58: PASS: fsync() returned 0
fsync01.c:58: PASS: fsync() returned 0
fsync01.c:58: PASS: fsync() returned 0
fsync01.c:58: PASS: fsync() returned 0
fsync01.c:58: PASS: fsync() returned 0
fsync01.c:58: PASS: fsync() returned 0
tst_test.c:1076: INFO: Testing on ext3
tst_mkfs.c:83: INFO: Formatting /dev/loop0 with ext3 opts='' extra opts=''
mke2fs 1.43.5 (04-Aug-2017)
[   48.457646] EXT4-fs (loop0): mounting ext3 file system using the ext4
subsystem
[   48.502872] EXT4-fs (loop0): mounted filesystem with ordered data
mode. Opts: (null)
tst_test.c:1015: INFO: Timeout per run is 0h 15m 00s
fsync01.c:58: PASS: fsync() returned 0
fsync01.c:58: PASS: fsync() returned 0
fsync01.c:58: PASS: fsync() returned 0
fsync01.c:58: PASS: fsync() returned 0
fsync01.c:58: PASS: fsync() returned 0
fsync01.c:58: PASS: fsync() returned 0
fsync01.c:58: PASS: fsync() returned 0
fsync01.c:58: PASS: fsync() returned 0
fsync01.c:58: PASS: fsync() returned 0
fsync01.c:58: PASS: fsync() returned 0
tst_test.c:1076: INFO: Testing on ext4
tst_mkfs.c:83: INFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
mke2fs 1.43.5 (04-Aug-2017)
/dev/loop0 is apparently in use by the system; will not make a
filesystem here!
tst_mkfs.c:94: BROK: mkfs.ext4:1: tst_test.c failed with 729

Thoughts ?

Cheers o/
-- 
Rafael D. Tinoco
Linaro - Kernel Validation
