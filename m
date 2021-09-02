From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 2 Sep 2021 19:32:55 +0530
Subject: [LTP] ftruncate04: WARNING: the mand mount option is being
 deprecated and will be removed in v5.15!
Message-ID: <CA+G9fYs=GY7eQSEc08PHdaT1WtzZtaxD3Fc8jpu1Dy4g=o5Xtg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

While running LTP syscalls test case ftruncate04 found this warning.

[  136.115071] loop0: detected capacity change from 0 to 524288
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:889: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
mke2fs 1.43.8 (1-Jan-2018)
[  136.250270] EXT4-fs (loop0): mounting ext2 file system using the
ext4 subsystem
[  136.255226] ext2 filesystem being mounted at
/tmp/ltp-GKVnWFZH5N/nTMmf9/mntpoint supports timestamps until 2038
(0x7fffffff)
[  136.258936] ======================================================
[  136.258936] WARNING: the mand mount option is being deprecated and
[  136.258936]          will be removed in v5.15!
[  136.258936] ======================================================
tst_test.c:1313: TINFO: Timeout per run is 0h 15m 00s
[  136.266703] EXT4-fs (loop0): re-mounted. Opts: (null). Quota mode: none.
[  136.267843] ext2 filesystem being remounted at
/tmp/ltp-GKVnWFZH5N/nTMmf9/mntpoint supports timestamps until 2038
(0x7fffffff)
ftruncate04.c:116: TINFO: Child locks file
ftruncate04.c:60: TPASS: ftruncate() offset before lock failed with EAGAIN
ftruncate04.c:60: TPASS: ftruncate() offset in lock failed with EAGAIN
ftruncate04.c:84: TPASS: ftruncate() offset after lock succeded
ftruncate04.c:127: TINFO: Child unlocks file
ftruncate04.c:84: TPASS: ftruncate() offset in lock succeded
ftruncate04.c:84: TPASS: ftruncate() offset before lock succeded
ftruncate04.c:84: TPASS: ftruncate() offset after lock succeded

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

Full test log link,
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.14.y/build/v5.14-rc6-389-g95dc72bb9c03/testrun/5607838/suite/linux-log-parser/test/check-kernel-warning-3410862/log

Test case link,
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/ftruncate/ftruncate04.c

- Naresh
