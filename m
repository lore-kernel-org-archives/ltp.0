From: Hongzhi, Song <hongzhi.song@windriver.com>
Date: Wed, 26 Jun 2019 17:50:24 +0800
Subject: [LTP] Bug Report: fs_fill: fails on btrfs with "ENOSPC" when disk
 size = 512M
Message-ID: <a361073f-3fbd-13af-b688-01da6b443b22@windriver.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,


      Description:

fs_fill fails on Btrfs when /dev/loop//*size = 512M*/.
I tested other size, 256M 1G, all passed.


      Kernel:

v5.2-rc1, qemux86-64

|# make -j40 ARCH=x86_64 CROSS_COMPILE=x86-64-gcc use qemu to bootup kernel |


      LTP:

master branch: date 20190625


      Reproduce:

|build ltp source and cp ltp all outputs to qemu # vi runltp in 
function: create_block() dd if=/dev/zero of=${TMP}/test.img bs=1024 
count=262144 ---> dd if=/dev/zero of=${TMP}/test.img bs=1024 
count=524288 # runltp -f fs -s fs_fill |


      Issue:

The issue maybe not reproduced everytime but four fifths chance.

|safe_macros.c:358: BROK: fs_fill.c:67: unlink(mntpoint/thread9/file0) 
failed: ENOSPC safe_macros.c:358: BROK: fs_fill.c:67: 
unlink(mntpoint/thread4/file0) failed: ENOSPC [ 154.762502] BTRFS 
warning (device loop0): could not allocate space for a delete; will 
truncate on mount [ 155.691577] BTRFS warning (device loop0): could not 
allocate space for a delete; will truncate on mount [ 156.017697] BTRFS 
warning (device loop0): could not allocate space for a delete; will 
truncate on mount |


      Analysis:

One new kernel commit contained in v5.2-rc1 introduces the issue.

|commit c8eaeac7b734347c3afba7008b7af62f37b9c140 Author: Josef Bacik 
<josef@toxicpanda.com> Date: Wed Apr 10 15:56:10 2019 -0400 btrfs: 
reserve delalloc metadata differently ...|


Anyone's reply will be appreciated.

--Hongzhi

||
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190626/0f0a22ae/attachment.htm>
