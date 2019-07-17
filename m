From: Hongzhi, Song <hongzhi.song@windriver.com>
Date: Wed, 17 Jul 2019 16:34:50 +0800
Subject: [LTP] Bug Report: Btrfs can't allocate space for delete when block
 size arounds 512M
Message-ID: <b501bcff-8be0-4303-8789-363fda4658e5@windriver.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi friends,

*Description:*


 ??? One LTP testcase, fs_fill.c, fails on btrfs with kernel error when 
unlink files on Btrfs device:

 ??? "BTRFS warning (device loop0): could not allocate space for a 
delete; will truncate on mount".


 ??? I found the loop block device formatted with btrfs roughly rangs 
from 460M to 560M will cause the error.

 ??? 256M and 1G all pass.


 ??? The fs_fill.c source code:

[https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/fs/fs_fill/fs_fill.c]

 ??? The fs_fill.c calls unlink which triggers the error.

[https://github.com/linux-test-project/ltp/blob/e3457e42c1b93f54bb81da746eba314fd34ad40e/testcases/kernel/fs/fs_fill/fs_fill.c#L55]

[https://github.com/linux-test-project/ltp/blob/e3457e42c1b93f54bb81da746eba314fd34ad40e/lib/safe_macros.c#L358]


*Error info:*

 ??? The issue maybe not reproduced everytime but four fifths chance.

 ??? fs_fill.c:53: INFO: Unlinking mntpoint/thread5/file0
 ??? safe_macros.c:360: BROK: fs_fill.c:55: 
unlink(mntpoint/thread10/file0) failed: ENOSPC
 ??? safe_macros.c:360: BROK: fs_fill.c:55: 
unlink(mntpoint/thread11/file0) failed: ENOSPC
 ??? [62477.378848] BTRFS warning (device loop0): could not allocate 
space for a delete; will truncate on mount
 ??? [62477.378905] BTRFS warning (device loop0): could not allocate 
space for a delete; will truncate on mount



*Kernel:*

 ??? After v5.2-rc1, qemux86-64

 ??? # make -j40 ARCH=x86_64 CROSS_COMPILE=x86-64-gcc
 ??? use qemu to bootup kernel


*LTP:*

 ??? master branch: I tested on 20190625
 ??? Reproduce:

 ??? // build Ltp
 ??? # cd Ltp-source
 ??? # ./build.sh

 ??? // copy files to qemu
 ??? # cp runltp testcases/kernel/fs/fs_fill/fs_fill to qemu

 ??? // login to qemu:
 ??? // adjust block device size to 512M
 ??? # vi runltp
 ??? in function: create_block()
 ??? ??? dd if=/dev/zero of=${TMP}/test.img bs=1024 count=262144
 ??? ??? --->
 ??? ??? dd if=/dev/zero of=${TMP}/test.img bs=1024 count=524288

 ??? // execute testcase
 ??? # runltp -f fs -s fs_fill


*Analysis:*

 ??? One new kernel commit contained in v5.2-rc1 introduces the issue.

 ??? commit c8eaeac7b734347c3afba7008b7af62f37b9c140
 ??? Author: Josef Bacik <josef@toxicpanda.com>
 ??? Date:?? Wed Apr 10 15:56:10 2019 -0400

 ??? ??? btrfs: reserve delalloc metadata differently
 ?? ?? ? ...


Anyone's reply will be appreciated.

--Hongzhi





