Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1N1cJU-0005vi-Vu
	for ltp-list@lists.sourceforge.net; Sat, 24 Oct 2009 08:49:28 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N1cJP-0007u6-PX
	for ltp-list@lists.sourceforge.net; Sat, 24 Oct 2009 08:49:28 +0000
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9O8j8Qx007627
	for <ltp-list@lists.sourceforge.net>; Sat, 24 Oct 2009 04:45:08 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9O8nICR069482
	for <ltp-list@lists.sourceforge.net>; Sat, 24 Oct 2009 04:49:18 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n9O4mHHL013398
	for <ltp-list@lists.sourceforge.net>; Sat, 24 Oct 2009 00:48:17 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Sat, 24 Oct 2009 14:19:08 +0530
Message-Id: <20091024084906.11570.79144.sendpatchset@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [PATCH] Add new testcases for ext4 new features
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8762529754926621804=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Miao Xie <miaox@cn.fujitsu.com>
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>

--===============8762529754926621804==

Hi Miao,

Thanks for this updated patch once again. I have done a bit of testing
and following are the results are few questions again.

>On Tue, 2009-10-06 at 16:31 +0900, Miao Xie wrote:
>Hi, Subrata
> 
> on 2009-9-28 23:17, Subrata Modak wrote:
> > 1) The patch had many broken lines, for which i had to manually edit a lot
> > before it got applied,
> > 2) The patch needs to update the ltp/README file as well for the pre-requisites
> > of building or executing the tests, like as follows:
> > 	2.1) Built the kernel with CONFIG_EXT4*=y,
> > 	2.2) Download and build the latest e2fsprogs-* from sourceforge.net, so
> > that the latest utilities like mke2fs, tune2fs, dumpe2fs, mkfs.ext4, etc can be
> > built on this system.
> > However, this was not sufficient when i tried to build the sources. I found that
> > header files from e2fslibs-devel* package is also required. Though i did not find
> > an appropraite source RPM or TAR for my system, however, i was able to build by
> > just copying those required headers (e2p.h,bitops.h,ext2_err.h,ext2_ext_attr.h,
> > ext2_fs.h,ext2fs.h,ext2_io.h,ext2_types.h,ext3_extents.h,tdb.h) and Shared Objects
> > (libe2p.a,libe2p.so,libext2fs.a,libext2fs.so). Please mention in ltp/README of
> > where to locate these pre-requisites packages,
> > 3) Do not integrate the ext4-* build with the default LTP build, because you
> > need the user to execute
> > ./configure
> > 	at
> > LTPROOT/testcases/kernel/fs/ext4-new-features/
> > And also if the pre-requisites are not present then LTP default build from
> > LTPROOT will fail at LTPROOT/testcases/kernel/fs/ext4-new-features/ directory.
> > So, let us keep the ext4* test cases build and execution seperate. Let users
> > manually cd to LTPROOT/testcases/kernel/fs/ext4-new-features/,
> > and then do:
> > ./configure,
> > make
> > make install
> > 	and then run
> > ./runltp -f fs_ext4
> > 	from LTPROOT
> 
> I have fixed these problems in the latest patch that is attached.
> 
> > 
> > 4) Following are my system parameters. I had created 20GB of primary partition
> > which is ext4 formatted. However many of those tests failed owing to less
> > space on the disk and generated segmentation faults as well. Please see the
> > output and logs attached. If you think that the failures are due to insufficient
> > partition size, etc, please mention then at ltp/README. Please let me know if
> > these issues can be fixed earlier so that i can retest and include it in
> > September 2009 release (may get delayed by a week).
> 
> I'm sorry to say that I can't reproduce these problems. I think it might be caused
> by the wrong e2fsprogs-devel package. Could you help me retest it after installing
> the right packages?
> 
> The necessary packages are following:
> e2fsprogs
> e2fsprogs-devel
> e2fsprogs-libs
> and the version of these packages should be 1.41.4 or above.

The SEGMENTATION Fault in ffsb was there, but i found the problem and the
following patch should be applied to fix that problem:

Signed-off-by: Subrata Modak <subrata@linux.vnet.ibm.com>
---

--- ltp-full-20090930/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/parser.c.orig	2009-10-24 19:28:44.000000000 +0530
+++ ltp-full-20090930/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/parser.c	2009-10-24 19:28:02.000000000 +0530
@@ -961,7 +961,6 @@ static void init_tg_stats(ffsb_config_t
 
 	tmp_cont = get_tg_container(fc, num);
 	if (tmp_cont->child) {
-		tmp_cont = tmp_cont->child;
 		if (tmp_cont->type == STATS) {
 			config = tmp_cont->config;
 			if (get_config_bool(config, "enable_stats")) {

---

Issues/Observations:

1) The test was running for more than 44 hours, so, i had to terminate it.
I had no idea of how long the test will run. Can you please update:
ltp-full-20090930/testcases/kernel/fs/ext4-new-features/README file
for the duration of the test run under nornal circumstance(s) ?
Does it depend upon the size of the partition (i ran it on a 680 GB
LVM this time) ??
And i also gave LTP a nice value of -20 this time to speed up the
process, still it was taking huge time.
2) Good news is that, the CODE COVERAGE generated on 2.6.30 kernel
was more than 50% for lines, and 61% for EXT functions. That�� a good news.
Can you please device strategies for increasing the code coverage
by writing tests in those areas which remained untouched.
3) Due to changes in the Makefile structures in LTP made by Garret
in the first week of Oct 2009, your patch will not apply as-is. Can you
please rebase your patch over the latest Makefile infrastructre, include
the above comments and resend it once again.

Thanks once again for writing these tests and taking the trouble
to fix the integration issues with LTP. Following are the system
parameters where i executed these tests:

# uname -a
Linux 2.6.31 #1 SMP Tue Oct 20 22:57:16 IST 2009 i686 i686 i386 GNU/Linux

# cat /etc/issue
Welcome to SUSE Linux Enterprise Server 11 (i586) - Kernel \r (\l).

# lvdisplay 
  --- Logical volume ---
  LV Name                /dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING
  VG Name                MYVG1_FOR_EXT4_TESTING
  LV UUID                ETwDrf-wzXN-vPln-SM8N-1b5E-P2A1-AqNMGc
  LV Write Access        read/write
  LV Status              available
  # open                 0
  LV Size                680.00 GB
  Current LE             174080
  Segments               5
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     256
  Block device           253:0

# cat /proc/cpuinfo
8 Intel(R) Xeon(TM) MP CPU 3.00GHz

# cat /proc/meminfo 
MemTotal:        2057156 kB

# cat ltp-full-20090930/output/fs_ext4_round_3.out 
<<<test_start>>>
tag=ext4_new_feature_test stime=1256230847
cmdline="run_ext4_test.sh"
contacts=""
analysis=exit
<<<test_output>>>
EXT4 NEW FEATURE TESTING
TEST STARTED: Please avoid using system while this test executes
 
Ext4 block allocation test
ext4-delalloc-mballoc    0  TINFO  :  isDelalloc: delalloc, isDirectIO: 0, Blocksize: 1024,             isAuto_da_alloc: auto_da_alloc=1
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
fsck 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 13865248/713031680 blocks
ext4-delalloc-mballoc    1  TPASS  :  delalloc/mballoc test pass
ext4-delalloc-mballoc    0  TINFO  :  isDelalloc: delalloc, isDirectIO: 0, Blocksize: 1024,             isAuto_da_alloc: noauto_da_alloc
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
fsck 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 13964313/713031680 blocks
ext4-delalloc-mballoc    2  TPASS  :  delalloc/mballoc test pass
ext4-delalloc-mballoc    0  TINFO  :  isDelalloc: nodelalloc, isDirectIO: 0, Blocksize: 1024,           isAuto_da_alloc: auto_da_alloc=1
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
fsck 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 13732571/713031680 blocks
ext4-delalloc-mballoc    3  TPASS  :  delalloc/mballoc test pass
ext4-delalloc-mballoc    0  TINFO  :  isDelalloc: nodelalloc, isDirectIO: 0, Blocksize: 1024,           isAuto_da_alloc: noauto_da_alloc
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
fsck 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 13772321/713031680 blocks
ext4-delalloc-mballoc    4  TPASS  :  delalloc/mballoc test pass
ext4-delalloc-mballoc    0  TINFO  :  isDelalloc: delalloc, isDirectIO: 1, Blocksize: 1024,             isAuto_da_alloc: auto_da_alloc=1
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
fsck 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 11959107/713031680 blocks
ext4-delalloc-mballoc    5  TPASS  :  delalloc/mballoc test pass
ext4-delalloc-mballoc    0  TINFO  :  isDelalloc: delalloc, isDirectIO: 1, Blocksize: 1024,             isAuto_da_alloc: noauto_da_alloc
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
fsck 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 11960448/713031680 blocks
ext4-delalloc-mballoc    6  TPASS  :  delalloc/mballoc test pass
ext4-delalloc-mballoc    0  TINFO  :  isDelalloc: nodelalloc, isDirectIO: 1, Blocksize: 1024,           isAuto_da_alloc: auto_da_alloc=1
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
fsck 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 11956445/713031680 blocks
ext4-delalloc-mballoc    7  TPASS  :  delalloc/mballoc test pass
ext4-delalloc-mballoc    0  TINFO  :  isDelalloc: nodelalloc, isDirectIO: 1, Blocksize: 1024,           isAuto_da_alloc: noauto_da_alloc
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
fsck 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 11960391/713031680 blocks
ext4-delalloc-mballoc    8  TPASS  :  delalloc/mballoc test pass
ext4-delalloc-mballoc    0  TINFO  :  isDelalloc: delalloc, isDirectIO: 0, Blocksize: 4096,             isAuto_da_alloc: auto_da_alloc=1
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
fsck 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 3572192/178257920 blocks
ext4-delalloc-mballoc    9  TPASS  :  delalloc/mballoc test pass
ext4-delalloc-mballoc    0  TINFO  :  isDelalloc: delalloc, isDirectIO: 0, Blocksize: 4096,             isAuto_da_alloc: noauto_da_alloc
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
fsck 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 3597495/178257920 blocks
ext4-delalloc-mballoc   10  TPASS  :  delalloc/mballoc test pass
ext4-delalloc-mballoc    0  TINFO  :  isDelalloc: nodelalloc, isDirectIO: 0, Blocksize: 4096,           isAuto_da_alloc: auto_da_alloc=1
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
fsck 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 3548055/178257920 blocks
ext4-delalloc-mballoc   11  TPASS  :  delalloc/mballoc test pass
ext4-delalloc-mballoc    0  TINFO  :  isDelalloc: nodelalloc, isDirectIO: 0, Blocksize: 4096,           isAuto_da_alloc: noauto_da_alloc
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
fsck 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 3519203/178257920 blocks
ext4-delalloc-mballoc   12  TPASS  :  delalloc/mballoc test pass
ext4-delalloc-mballoc    0  TINFO  :  isDelalloc: delalloc, isDirectIO: 1, Blocksize: 4096,             isAuto_da_alloc: auto_da_alloc=1
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
fsck 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 2984396/178257920 blocks
ext4-delalloc-mballoc   13  TPASS  :  delalloc/mballoc test pass
ext4-delalloc-mballoc    0  TINFO  :  isDelalloc: delalloc, isDirectIO: 1, Blocksize: 4096,             isAuto_da_alloc: noauto_da_alloc
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
fsck 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 2984107/178257920 blocks
ext4-delalloc-mballoc   14  TPASS  :  delalloc/mballoc test pass
ext4-delalloc-mballoc    0  TINFO  :  isDelalloc: nodelalloc, isDirectIO: 1, Blocksize: 4096,           isAuto_da_alloc: auto_da_alloc=1
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
fsck 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 2984696/178257920 blocks
ext4-delalloc-mballoc   15  TPASS  :  delalloc/mballoc test pass
ext4-delalloc-mballoc    0  TINFO  :  isDelalloc: nodelalloc, isDirectIO: 1, Blocksize: 4096,           isAuto_da_alloc: noauto_da_alloc
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
fsck 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 2984536/178257920 blocks
ext4-delalloc-mballoc   16  TPASS  :  delalloc/mballoc test pass
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
fsck 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 13868269/713031680 blocks
ext4-delalloc-mballoc   17  TPASS  :  remount test pass
 
Ext4 journal checksum test
ext4-journal-checksum    0  TINFO  :  journal mode: writeback, commit interval: 1,              journal_checksum: Used,                 journal_async_commit: Used, barrier: 0
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 3402854/178257920 blocks
ext4-journal-checksum    1  TPASS  :  ext4 journal checksum test pass
ext4-journal-checksum    0  TINFO  :  journal mode: ordered, commit interval: 1,                journal_checksum: Used,                 journal_async_commit: Used, barrier: 0
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 3472921/178257920 blocks
ext4-journal-checksum    2  TPASS  :  ext4 journal checksum test pass
ext4-journal-checksum    0  TINFO  :  journal mode: journal, commit interval: 1,                journal_checksum: Used,                 journal_async_commit: Used, barrier: 0
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 3294199/178257920 blocks
ext4-journal-checksum    3  TPASS  :  ext4 journal checksum test pass
ext4-journal-checksum    0  TINFO  :  journal mode: writeback, commit interval: 100,            journal_checksum: Used,                 journal_async_commit: Used, barrier: 0
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 3436952/178257920 blocks
ext4-journal-checksum    4  TPASS  :  ext4 journal checksum test pass
ext4-journal-checksum    0  TINFO  :  journal mode: ordered, commit interval: 100,              journal_checksum: Used,                 journal_async_commit: Used, barrier: 0
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 3460127/178257920 blocks
ext4-journal-checksum    5  TPASS  :  ext4 journal checksum test pass
ext4-journal-checksum    0  TINFO  :  journal mode: journal, commit interval: 100,              journal_checksum: Used,                 journal_async_commit: Used, barrier: 0
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 3291530/178257920 blocks
ext4-journal-checksum    6  TPASS  :  ext4 journal checksum test pass
ext4-journal-checksum    0  TINFO  :  journal mode: writeback, commit interval: 1,              journal_checksum: Used,                 journal_async_commit: No use, barrier: 0
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 3402145/178257920 blocks
ext4-journal-checksum    7  TPASS  :  ext4 journal checksum test pass
ext4-journal-checksum    0  TINFO  :  journal mode: ordered, commit interval: 1,                journal_checksum: Used,                 journal_async_commit: No use, barrier: 0
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 3457816/178257920 blocks
ext4-journal-checksum    8  TPASS  :  ext4 journal checksum test pass
ext4-journal-checksum    0  TINFO  :  journal mode: journal, commit interval: 1,                journal_checksum: Used,                 journal_async_commit: No use, barrier: 0
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 3297178/178257920 blocks
ext4-journal-checksum    9  TPASS  :  ext4 journal checksum test pass
ext4-journal-checksum    0  TINFO  :  journal mode: writeback, commit interval: 100,            journal_checksum: Used,                 journal_async_commit: No use, barrier: 0
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 3427099/178257920 blocks
ext4-journal-checksum   10  TPASS  :  ext4 journal checksum test pass
ext4-journal-checksum    0  TINFO  :  journal mode: ordered, commit interval: 100,              journal_checksum: Used,                 journal_async_commit: No use, barrier: 0
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 3463779/178257920 blocks
ext4-journal-checksum   11  TPASS  :  ext4 journal checksum test pass
ext4-journal-checksum    0  TINFO  :  journal mode: journal, commit interval: 100,              journal_checksum: Used,                 journal_async_commit: No use, barrier: 0
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 3297264/178257920 blocks
ext4-journal-checksum   12  TPASS  :  ext4 journal checksum test pass
ext4-journal-checksum    0  TINFO  :  journal mode: writeback, commit interval: 1,              journal_checksum: No use,               journal_async_commit: No use, barrier: 0
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 3418069/178257920 blocks
ext4-journal-checksum   13  TPASS  :  ext4 journal checksum test pass
ext4-journal-checksum    0  TINFO  :  journal mode: ordered, commit interval: 1,                journal_checksum: No use,               journal_async_commit: No use, barrier: 0
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 3461732/178257920 blocks
ext4-journal-checksum   14  TPASS  :  ext4 journal checksum test pass
ext4-journal-checksum    0  TINFO  :  journal mode: journal, commit interval: 1,                journal_checksum: No use,               journal_async_commit: No use, barrier: 0
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 3296798/178257920 blocks
ext4-journal-checksum   15  TPASS  :  ext4 journal checksum test pass
ext4-journal-checksum    0  TINFO  :  journal mode: writeback, commit interval: 100,            journal_checksum: No use,               journal_async_commit: No use, barrier: 0
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 3448823/178257920 blocks
ext4-journal-checksum   16  TPASS  :  ext4 journal checksum test pass
ext4-journal-checksum    0  TINFO  :  journal mode: ordered, commit interval: 100,              journal_checksum: No use,               journal_async_commit: No use, barrier: 0
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 3477400/178257920 blocks
ext4-journal-checksum   17  TPASS  :  ext4 journal checksum test pass
ext4-journal-checksum    0  TINFO  :  journal mode: journal, commit interval: 100,              journal_checksum: No use,               journal_async_commit: No use, barrier: 0
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 3292601/178257920 blocks
ext4-journal-checksum   18  TPASS  :  ext4 journal checksum test pass
ext4-journal-checksum    0  TINFO  :  journal mode: writeback, commit interval: 1,              journal_checksum: Used,                 journal_async_commit: Used, barrier: 1
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 3390847/178257920 blocks
ext4-journal-checksum   19  TPASS  :  ext4 journal checksum test pass
ext4-journal-checksum    0  TINFO  :  journal mode: ordered, commit interval: 1,                journal_checksum: Used,                 journal_async_commit: Used, barrier: 1
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 3425279/178257920 blocks
ext4-journal-checksum   20  TPASS  :  ext4 journal checksum test pass
ext4-journal-checksum    0  TINFO  :  journal mode: journal, commit interval: 1,                journal_checksum: Used,                 journal_async_commit: Used, barrier: 1
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 3292356/178257920 blocks
ext4-journal-checksum   21  TPASS  :  ext4 journal checksum test pass
ext4-journal-checksum    0  TINFO  :  journal mode: writeback, commit interval: 100,            journal_checksum: Used,                 journal_async_commit: Used, barrier: 1
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 3442559/178257920 blocks
ext4-journal-checksum   22  TPASS  :  ext4 journal checksum test pass
ext4-journal-checksum    0  TINFO  :  journal mode: ordered, commit interval: 100,              journal_checksum: Used,                 journal_async_commit: Used, barrier: 1
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 3426227/178257920 blocks
ext4-journal-checksum   23  TPASS  :  ext4 journal checksum test pass
ext4-journal-checksum    0  TINFO  :  journal mode: journal, commit interval: 100,              journal_checksum: Used,                 journal_async_commit: Used, barrier: 1
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 3294010/178257920 blocks
ext4-journal-checksum   24  TPASS  :  ext4 journal checksum test pass
ext4-journal-checksum    0  TINFO  :  journal mode: writeback, commit interval: 1,              journal_checksum: Used,                 journal_async_commit: No use, barrier: 1
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 3332723/178257920 blocks
ext4-journal-checksum   25  TPASS  :  ext4 journal checksum test pass
ext4-journal-checksum    0  TINFO  :  journal mode: ordered, commit interval: 1,                journal_checksum: Used,                 journal_async_commit: No use, barrier: 1
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 3384843/178257920 blocks
ext4-journal-checksum   26  TPASS  :  ext4 journal checksum test pass
ext4-journal-checksum    0  TINFO  :  journal mode: journal, commit interval: 1,                journal_checksum: Used,                 journal_async_commit: No use, barrier: 1
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 3301835/178257920 blocks
ext4-journal-checksum   27  TPASS  :  ext4 journal checksum test pass
ext4-journal-checksum    0  TINFO  :  journal mode: writeback, commit interval: 100,            journal_checksum: Used,                 journal_async_commit: No use, barrier: 1
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 3399501/178257920 blocks
ext4-journal-checksum   28  TPASS  :  ext4 journal checksum test pass
ext4-journal-checksum    0  TINFO  :  journal mode: ordered, commit interval: 100,              journal_checksum: Used,                 journal_async_commit: No use, barrier: 1
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 3469033/178257920 blocks
ext4-journal-checksum   29  TPASS  :  ext4 journal checksum test pass
ext4-journal-checksum    0  TINFO  :  journal mode: journal, commit interval: 100,              journal_checksum: Used,                 journal_async_commit: No use, barrier: 1
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 3305989/178257920 blocks
ext4-journal-checksum   30  TPASS  :  ext4 journal checksum test pass
ext4-journal-checksum    0  TINFO  :  journal mode: writeback, commit interval: 1,              journal_checksum: No use,               journal_async_commit: No use, barrier: 1
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 3327513/178257920 blocks
ext4-journal-checksum   31  TPASS  :  ext4 journal checksum test pass
ext4-journal-checksum    0  TINFO  :  journal mode: ordered, commit interval: 1,                journal_checksum: No use,               journal_async_commit: No use, barrier: 1
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 3387554/178257920 blocks
ext4-journal-checksum   32  TPASS  :  ext4 journal checksum test pass
ext4-journal-checksum    0  TINFO  :  journal mode: journal, commit interval: 1,                journal_checksum: No use,               journal_async_commit: No use, barrier: 1
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 3302200/178257920 blocks
ext4-journal-checksum   33  TPASS  :  ext4 journal checksum test pass
ext4-journal-checksum    0  TINFO  :  journal mode: writeback, commit interval: 100,            journal_checksum: No use,               journal_async_commit: No use, barrier: 1
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 3403332/178257920 blocks
ext4-journal-checksum   34  TPASS  :  ext4 journal checksum test pass
ext4-journal-checksum    0  TINFO  :  journal mode: ordered, commit interval: 100,              journal_checksum: No use,               journal_async_commit: No use, barrier: 1
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 3378421/178257920 blocks
ext4-journal-checksum   35  TPASS  :  ext4 journal checksum test pass
ext4-journal-checksum    0  TINFO  :  journal mode: journal, commit interval: 100,              journal_checksum: No use,               journal_async_commit: No use, barrier: 1
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 100053/44564480 files, 3309306/178257920 blocks
ext4-journal-checksum   36  TPASS  :  ext4 journal checksum test pass
 
Ext4 subdir limit test
ext4-subdir-limit    0  TINFO  :  Num of dirs to create: 65537, Dir name len: short name                        Parent dir: mnt_point, Block size: 1024
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 10/44564480 files, 11420549/713031680 blocks
dumpe2fs 1.41.9 (22-Aug-2009)
ext4-subdir-limit    1  TPASS  :  ext4 subdir limit test pass
ext4-subdir-limit    0  TINFO  :  Num of dirs to create: 65537, Dir name len: long name                         Parent dir: mnt_point, Block size: 1024
mkdir: No space left on device
ext4-subdir-limit    2  TFAIL  :  failed to create directories - 19808
ext4-subdir-limit    0  TINFO  :  Num of dirs to create: 65537, Dir name len: short name                        Parent dir: mnt_point/sub, Block size: 1024
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 12/44564480 files, 11420535/713031680 blocks
dumpe2fs 1.41.9 (22-Aug-2009)
ext4-subdir-limit    3  TPASS  :  ext4 subdir limit test pass
ext4-subdir-limit    0  TINFO  :  Num of dirs to create: 65537, Dir name len: long name                         Parent dir: mnt_point/sub, Block size: 1024
mkdir: No space left on device
ext4-subdir-limit    4  TFAIL  :  failed to create directories - 20195
ext4-subdir-limit    0  TINFO  :  Num of dirs to create: 65537, Dir name len: short name                        Parent dir: mnt_point, Block size: 2048
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 10/44564480 files, 5666176/356515840 blocks
dumpe2fs 1.41.9 (22-Aug-2009)
ext4-subdir-limit    5  TPASS  :  ext4 subdir limit test pass
ext4-subdir-limit    0  TINFO  :  Num of dirs to create: 65537, Dir name len: long name                         Parent dir: mnt_point, Block size: 2048
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 10/44564480 files, 5678956/356515840 blocks
dumpe2fs 1.41.9 (22-Aug-2009)
ext4-subdir-limit    6  TPASS  :  ext4 subdir limit test pass
ext4-subdir-limit    0  TINFO  :  Num of dirs to create: 65537, Dir name len: short name                        Parent dir: mnt_point/sub, Block size: 2048
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 11/44564480 files, 5679516/356515840 blocks
dumpe2fs 1.41.9 (22-Aug-2009)
ext4-subdir-limit    7  TPASS  :  ext4 subdir limit test pass
ext4-subdir-limit    0  TINFO  :  Num of dirs to create: 65537, Dir name len: long name                         Parent dir: mnt_point/sub, Block size: 2048
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 11/44564480 files, 5692302/356515840 blocks
dumpe2fs 1.41.9 (22-Aug-2009)
ext4-subdir-limit    8  TPASS  :  ext4 subdir limit test pass
ext4-subdir-limit    0  TINFO  :  Num of dirs to create: 65537, Dir name len: short name                        Parent dir: mnt_point, Block size: 4096
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: The test_fs flag is set (and ext4 is available).  CLEARED.
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 10/44564480 files, 2847650/178257920 blocks
dumpe2fs 1.41.9 (22-Aug-2009)
ext4-subdir-limit    9  TPASS  :  ext4 subdir limit test pass
ext4-subdir-limit    0  TINFO  :  Num of dirs to create: 65537, Dir name len: long name                         Parent dir: mnt_point, Block size: 4096
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 10/44564480 files, 2853603/178257920 blocks
dumpe2fs 1.41.9 (22-Aug-2009)
ext4-subdir-limit   10  TPASS  :  ext4 subdir limit test pass
ext4-subdir-limit    0  TINFO  :  Num of dirs to create: 65537, Dir name len: short name                        Parent dir: mnt_point/sub, Block size: 4096
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 11/44564480 files, 2853874/178257920 blocks
dumpe2fs 1.41.9 (22-Aug-2009)
ext4-subdir-limit   11  TPASS  :  ext4 subdir limit test pass
ext4-subdir-limit    0  TINFO  :  Num of dirs to create: 65537, Dir name len: long name                         Parent dir: mnt_point/sub, Block size: 4096
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 11/44564480 files, 2859841/178257920 blocks
dumpe2fs 1.41.9 (22-Aug-2009)
ext4-subdir-limit   12  TPASS  :  ext4 subdir limit test pass
 
Ext4 nanosecond timestamp test
ext4-nsec-timestamps    0  TINFO  :  Test timestamps with 128 inode size
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
ext4-nsec-timestamps    1  TPASS  :  Ext4 nanosecond timestamps test with 128 inode size pass
./ext4_nsec_timestamps_test.sh: line 183: [0: command not found
ext4-nsec-timestamps    0  TINFO  :  Test timestamps with 256 inode size
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
ext4-nsec-timestamps    2  TPASS  :  Ext4 nanosecond timestamps test with 256 inode size pass
./ext4_nsec_timestamps_test.sh: line 189: [0: command not found
 
Ext4 persist prealloc test
mke2fs 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 16/44564480 files, 11419497/713031680 blocks
ext4-persistent-preallocation    1  TPASS  :  ext4 persistent preallocation test pass
mke2fs 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 16/44564480 files, 2847450/178257920 blocks
ext4-persistent-preallocation    2  TPASS  :  ext4 persistent preallocation test pass
 
Ext4 inode version test
ext4-inode-version    0  TINFO  :  Test inode version is 32 bits with 128 inode size
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
debugfs 1.41.9 (22-Aug-2009)
debugfs 1.41.9 (22-Aug-2009)
ext4-inode-version    1  TPASS  :  32 bits inode version with 128 inode size test pass
mke2fs 1.41.9 (22-Aug-2009)
debugfs 1.41.9 (22-Aug-2009)
debugfs 1.41.9 (22-Aug-2009)
ext4-inode-version    2  TPASS  :  inode version with 256 inode size test pass
mke2fs 1.41.9 (22-Aug-2009)
debugfs 1.41.9 (22-Aug-2009)
debugfs 1.41.9 (22-Aug-2009)
debugfs 1.41.9 (22-Aug-2009)
ext4-inode-version    3  TPASS  :  inode version with 256 inode size test pass
mke2fs 1.41.9 (22-Aug-2009)
debugfs 1.41.9 (22-Aug-2009)
debugfs 1.41.9 (22-Aug-2009)
debugfs 1.41.9 (22-Aug-2009)
ext4-inode-version    4  TPASS  :  inode version with 256 inode size test pass
mke2fs 1.41.9 (22-Aug-2009)
debugfs 1.41.9 (22-Aug-2009)
debugfs 1.41.9 (22-Aug-2009)
debugfs 1.41.9 (22-Aug-2009)
debugfs 1.41.9 (22-Aug-2009)
ext4-inode-version    5  TPASS  :  inode version with 256 inode size test pass
mke2fs 1.41.9 (22-Aug-2009)
debugfs 1.41.9 (22-Aug-2009)
debugfs 1.41.9 (22-Aug-2009)
debugfs 1.41.9 (22-Aug-2009)
ext4-inode-version    6  TPASS  :  inode version with 256 inode size test pass
mke2fs 1.41.9 (22-Aug-2009)
debugfs 1.41.9 (22-Aug-2009)
debugfs 1.41.9 (22-Aug-2009)
debugfs 1.41.9 (22-Aug-2009)
debugfs 1.41.9 (22-Aug-2009)
debugfs 1.41.9 (22-Aug-2009)
ext4-inode-version    7  TPASS  :  inode version with 256 inode size test pass
mke2fs 1.41.9 (22-Aug-2009)
debugfs 1.41.9 (22-Aug-2009)
debugfs 1.41.9 (22-Aug-2009)
debugfs 1.41.9 (22-Aug-2009)
debugfs 1.41.9 (22-Aug-2009)
debugfs 1.41.9 (22-Aug-2009)
ext4-inode-version    8  TPASS  :  inode version with 256 inode size test pass
 
Ext4 uninit groups test
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
fsck 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 10/44564480 files, 2847380/178257920 blocks
ext4-uninit-groups    1  TPASS  :  ext4 uninit groups test pass
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
./ext4_uninit_groups_test.sh: line 50: 31487 Killed                  ./ffsb ffsb-config$n > /dev/null
fsck 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 993712/44564480 files, 153853771/178257920 blocks
ext4-uninit-groups    2  TPASS  :  ext4 uninit groups test pass
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
dumpe2fs 1.41.9 (22-Aug-2009)
dumpe2fs 1.41.9 (22-Aug-2009)
dd: writing `mnt_point/tmp_dir': No space left on device
175410496+0 records in
175410495+0 records out
718481387520 bytes (718 GB) copied, 10848.7 s, 66.2 MB/s
fsck 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 11/44564480 files, 178257895/178257920 blocks
ext4-uninit-groups    3  TPASS  :  ext4 uninit groups test pass
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
fsck 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 10/44564480 files, 2847380/178257920 blocks
ext4-uninit-groups    4  TPASS  :  ext4 uninit groups test pass
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
write: Success
write: Success
fsck 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 1150485/44564480 files, 178257751/178257920 blocks
ext4-uninit-groups    5  TPASS  :  ext4 uninit groups test pass
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
dumpe2fs 1.41.9 (22-Aug-2009)
dumpe2fs 1.41.9 (22-Aug-2009)
dd: writing `mnt_point/tmp_dir': No space left on device
175410500+0 records in
175410499+0 records out
718481403904 bytes (718 GB) copied, 10918 s, 65.8 MB/s
fsck 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 11/44564480 files, 178257899/178257920 blocks
ext4-uninit-groups    6  TPASS  :  ext4 uninit groups test pass
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
fsck 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 10/44564480 files, 2847380/178257920 blocks
ext4-uninit-groups    7  TPASS  :  ext4 uninit groups test pass
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
./ext4_uninit_groups_test.sh: line 50:  5057 Killed                  ./ffsb ffsb-config$n > /dev/null
./ext4_uninit_groups_test.sh: line 50:  5698 Killed                  ./ffsb ffsb-config$n > /dev/null
./ext4_uninit_groups_test.sh: line 50:  5717 Killed                  ./ffsb ffsb-config$n > /dev/null
./ext4_uninit_groups_test.sh: line 50:  5733 Killed                  ./ffsb ffsb-config$n > /dev/null
./ext4_uninit_groups_test.sh: line 50:  5754 Killed                  ./ffsb ffsb-config$n > /dev/null
fsck 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 161807/44564480 files, 27650675/178257920 blocks
ext4-uninit-groups    8  TPASS  :  ext4 uninit groups test pass
mke2fs 1.41.9 (22-Aug-2009)
tune2fs 1.41.9 (22-Aug-2009)
Setting test filesystem flag
dumpe2fs 1.41.9 (22-Aug-2009)
dumpe2fs 1.41.9 (22-Aug-2009)
./ext4_uninit_groups_test.sh: line 50:  5817 Killed                  dd if=/dev/zero of=mnt_point/tmp_dir bs=$bsize count=$bcount
fsck 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING: clean, 11/44564480 files, 131587430/178257920 blocks
ext4-uninit-groups    9  TPASS  :  ext4 uninit groups test pass
mke2fs 1.41.9 (22-Aug-2009)
/root/subrata/ltp/ltp-full-20090930/testcases/bin/run_ext4_test.sh: line 163: 29289 Killed                  ./ext4_uninit_groups_test.sh ./ext4-test-config
 
Ext4 online defrag test
The output of defrag program is in the file LTPROOT/output/ext4_online_defrag.txt
mkdir: cannot create directory `mnt_point': File exists
ext4-online-defrag    0  TINFO  :  defrag type: 1, defrag obj: 1, block size: 1024
mke2fs 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING is apparently in use by the system; will not make a filesystem here!
ext4-online-defrag    1  TFAIL  :  failed to create ext4 filesystem
ext4-online-defrag    0  TINFO  :  defrag type: 1, defrag obj: 2, block size: 1024
mke2fs 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING is apparently in use by the system; will not make a filesystem here!
ext4-online-defrag    2  TFAIL  :  failed to create ext4 filesystem
ext4-online-defrag    0  TINFO  :  defrag type: 1, defrag obj: 3, block size: 1024
mke2fs 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING is apparently in use by the system; will not make a filesystem here!
ext4-online-defrag    3  TFAIL  :  failed to create ext4 filesystem
ext4-online-defrag    0  TINFO  :  defrag type: 2, defrag obj: 1, block size: 1024
mke2fs 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING is apparently in use by the system; will not make a filesystem here!
ext4-online-defrag    4  TFAIL  :  failed to create ext4 filesystem
ext4-online-defrag    0  TINFO  :  defrag type: 2, defrag obj: 2, block size: 1024
mke2fs 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING is apparently in use by the system; will not make a filesystem here!
ext4-online-defrag    5  TFAIL  :  failed to create ext4 filesystem
ext4-online-defrag    0  TINFO  :  defrag type: 2, defrag obj: 3, block size: 1024
mke2fs 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING is apparently in use by the system; will not make a filesystem here!
ext4-online-defrag    6  TFAIL  :  failed to create ext4 filesystem
ext4-online-defrag    0  TINFO  :  defrag type: 3, defrag obj: 1, block size: 1024
mke2fs 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING is apparently in use by the system; will not make a filesystem here!
ext4-online-defrag    7  TFAIL  :  failed to create ext4 filesystem
ext4-online-defrag    0  TINFO  :  defrag type: 3, defrag obj: 2, block size: 1024
mke2fs 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING is apparently in use by the system; will not make a filesystem here!
ext4-online-defrag    8  TFAIL  :  failed to create ext4 filesystem
ext4-online-defrag    0  TINFO  :  defrag type: 3, defrag obj: 3, block size: 1024
mke2fs 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING is apparently in use by the system; will not make a filesystem here!
ext4-online-defrag    9  TFAIL  :  failed to create ext4 filesystem
ext4-online-defrag    0  TINFO  :  defrag type: 1, defrag obj: 1, block size: 4096
mke2fs 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING is apparently in use by the system; will not make a filesystem here!
ext4-online-defrag   10  TFAIL  :  failed to create ext4 filesystem
ext4-online-defrag    0  TINFO  :  defrag type: 1, defrag obj: 2, block size: 4096
mke2fs 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING is apparently in use by the system; will not make a filesystem here!
ext4-online-defrag   11  TFAIL  :  failed to create ext4 filesystem
ext4-online-defrag    0  TINFO  :  defrag type: 1, defrag obj: 3, block size: 4096
mke2fs 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING is apparently in use by the system; will not make a filesystem here!
ext4-online-defrag   12  TFAIL  :  failed to create ext4 filesystem
ext4-online-defrag    0  TINFO  :  defrag type: 2, defrag obj: 1, block size: 4096
mke2fs 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING is apparently in use by the system; will not make a filesystem here!
ext4-online-defrag   13  TFAIL  :  failed to create ext4 filesystem
ext4-online-defrag    0  TINFO  :  defrag type: 2, defrag obj: 2, block size: 4096
mke2fs 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING is apparently in use by the system; will not make a filesystem here!
ext4-online-defrag   14  TFAIL  :  failed to create ext4 filesystem
ext4-online-defrag    0  TINFO  :  defrag type: 2, defrag obj: 3, block size: 4096
mke2fs 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING is apparently in use by the system; will not make a filesystem here!
ext4-online-defrag   15  TFAIL  :  failed to create ext4 filesystem
ext4-online-defrag    0  TINFO  :  defrag type: 3, defrag obj: 1, block size: 4096
mke2fs 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING is apparently in use by the system; will not make a filesystem here!
ext4-online-defrag   16  TFAIL  :  failed to create ext4 filesystem
ext4-online-defrag    0  TINFO  :  defrag type: 3, defrag obj: 2, block size: 4096
mke2fs 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING is apparently in use by the system; will not make a filesystem here!
ext4-online-defrag   17  TFAIL  :  failed to create ext4 filesystem
ext4-online-defrag    0  TINFO  :  defrag type: 3, defrag obj: 3, block size: 4096
mke2fs 1.41.9 (22-Aug-2009)
/dev/MYVG1_FOR_EXT4_TESTING/MYLV1_FOR_EXT4_TESTING is apparently in use by the system; will not make a filesystem here!
ext4-online-defrag   18  TFAIL  :  failed to create ext4 filesystem
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=159188 termination_type=exited termination_id=1 corefile=no
cutime=107622 cstime=13813200
<<<test_end>>>

Regards--
Subrata

> 
> Thanks.
> Miao
> 
> ---
>   README                                             |   18 +
>   runtest/fs_ext4                                    |    1 +
>   testcases/kernel/fs/ext4-new-features/Makefile     |   24 +
>   testcases/kernel/fs/ext4-new-features/README       |  145 +
>   testcases/kernel/fs/ext4-new-features/configure    |   23 +
>   .../ext4-delalloc-mballoc/Makefile                 |   12 +
>   .../ext4-delalloc-mballoc/ext4-alloc-test.sh       |  167 +
>   .../fs/ext4-new-features/ext4-ffsb-config/Makefile |   17 +
>   .../ext4-ffsb-config/ffsb-config0                  |   23 +
>   .../ext4-ffsb-config/ffsb-config1                  |   23 +
>   .../ext4-ffsb-config/ffsb-config2                  |   23 +
>   .../ext4-ffsb-config/ffsb-config3                  |   29 +
>   .../ext4-ffsb-config/ffsb-config4                  |   29 +
>   .../ext4-ffsb-config/ffsb-config5                  |   29 +
>   .../ext4-ffsb-config/ffsb-config6                  |   29 +
>   .../ext4-ffsb-config/ffsb-config7                  |   29 +
>   .../ext4-new-features/ext4-inode-version/Makefile  |   19 +
>   .../ext4-inode-version/ext4_get_inode_version.sh   |   41 +
>   .../ext4-inode-version/ext4_inode_version_test.sh  |  205 +
>   .../ext4-inode-version/ext4_test_inode_version.c   |  219 +
>   .../ext4-journal-checksum/Makefile                 |   12 +
>   .../ext4-journal-checksum/ext4_journal_checksum.sh |  148 +
>   .../ext4-nsec-timestamps/Makefile                  |   17 +
>   .../ext4-nsec-timestamps/ext4_file_time.c          |   70 +
>   .../ext4_nsec_timestamps_test.sh                   |  196 +
>   .../ext4-new-features/ext4-online-defrag/Makefile  |   18 +
>   .../ext4-online-defrag/e4defrag.c                  | 2171 ++++++
>   .../ext4-online-defrag/ext4_online_defrag_test.sh  |  192 +
>   .../ext4-persist-prealloc/Makefile                 |   12 +
>   .../ext4_persist_prealloc_test.sh                  |  113 +
>   .../ext4-new-features/ext4-subdir-limit/Makefile   |   18 +
>   .../ext4-subdir-limit/create_long_dirs.c           |  156 +
>   .../ext4-subdir-limit/create_short_dirs.c          |  158 +
>   .../ext4-subdir-limit/ext4_subdir_limit_test.sh    |  167 +
>   .../ext4-new-features/ext4-uninit-groups/Makefile  |   12 +
>   .../ext4-uninit-groups/ext4_uninit_groups_test.sh  |  161 +
>   .../kernel/fs/ext4-new-features/ext4_funcs.sh      |   47 +
>   .../fs/ext4-new-features/ffsb-6.0-rc2/AUTHORS      |    7 +
>   .../fs/ext4-new-features/ffsb-6.0-rc2/COPYING      |  340 +
>   .../fs/ext4-new-features/ffsb-6.0-rc2/INSTALL      |  182 +
>   .../fs/ext4-new-features/ffsb-6.0-rc2/LICENSE      |  347 +
>   .../fs/ext4-new-features/ffsb-6.0-rc2/Makefile.am  |   46 +
>   .../fs/ext4-new-features/ffsb-6.0-rc2/Makefile.in  |  628 ++
>   .../fs/ext4-new-features/ffsb-6.0-rc2/README       |  413 ++
>   .../fs/ext4-new-features/ffsb-6.0-rc2/aclocal.m4   |  880 +++
>   .../fs/ext4-new-features/ffsb-6.0-rc2/cirlist.c    |  107 +
>   .../fs/ext4-new-features/ffsb-6.0-rc2/cirlist.h    |   41 +
>   .../fs/ext4-new-features/ffsb-6.0-rc2/config.guess | 1450 ++++
>   .../fs/ext4-new-features/ffsb-6.0-rc2/config.h.in  |  130 +
>   .../fs/ext4-new-features/ffsb-6.0-rc2/config.sub   | 1545 +++++
>   .../fs/ext4-new-features/ffsb-6.0-rc2/configure    | 7000 ++++++++++++++++++++
>   .../fs/ext4-new-features/ffsb-6.0-rc2/configure.in |   49 +
>   .../fs/ext4-new-features/ffsb-6.0-rc2/depcomp      |  472 ++
>   .../ffsb-6.0-rc2/examples/profile_everything       |  119 +
>   .../fs/ext4-new-features/ffsb-6.0-rc2/ffsb.h       |  105 +
>   .../fs/ext4-new-features/ffsb-6.0-rc2/ffsb_fc.c    |  112 +
>   .../fs/ext4-new-features/ffsb-6.0-rc2/ffsb_fs.c    |  634 ++
>   .../fs/ext4-new-features/ffsb-6.0-rc2/ffsb_fs.h    |  184 +
>   .../fs/ext4-new-features/ffsb-6.0-rc2/ffsb_op.c    |  178 +
>   .../fs/ext4-new-features/ffsb-6.0-rc2/ffsb_op.h    |  102 +
>   .../fs/ext4-new-features/ffsb-6.0-rc2/ffsb_stats.c |  241 +
>   .../fs/ext4-new-features/ffsb-6.0-rc2/ffsb_stats.h |  109 +
>   .../fs/ext4-new-features/ffsb-6.0-rc2/ffsb_tg.c    |  369 +
>   .../fs/ext4-new-features/ffsb-6.0-rc2/ffsb_tg.h    |  206 +
>   .../ext4-new-features/ffsb-6.0-rc2/ffsb_thread.c   |  171 +
>   .../ext4-new-features/ffsb-6.0-rc2/ffsb_thread.h   |  108 +
>   .../kernel/fs/ext4-new-features/ffsb-6.0-rc2/fh.c  |  278 +
>   .../kernel/fs/ext4-new-features/ffsb-6.0-rc2/fh.h  |   41 +
>   .../fs/ext4-new-features/ffsb-6.0-rc2/filelist.c   |  503 ++
>   .../fs/ext4-new-features/ffsb-6.0-rc2/filelist.h   |  145 +
>   .../fs/ext4-new-features/ffsb-6.0-rc2/fileops.c    |  547 ++
>   .../fs/ext4-new-features/ffsb-6.0-rc2/fileops.h    |   51 +
>   .../fs/ext4-new-features/ffsb-6.0-rc2/install-sh   |  250 +
>   .../fs/ext4-new-features/ffsb-6.0-rc2/list.c       |   55 +
>   .../fs/ext4-new-features/ffsb-6.0-rc2/list.h       |   53 +
>   .../fs/ext4-new-features/ffsb-6.0-rc2/main.c       |  258 +
>   .../fs/ext4-new-features/ffsb-6.0-rc2/metaops.c    |  112 +
>   .../fs/ext4-new-features/ffsb-6.0-rc2/metaops.h    |   28 +
>   .../fs/ext4-new-features/ffsb-6.0-rc2/missing      |  336 +
>   .../ext4-new-features/ffsb-6.0-rc2/mkinstalldirs   |   40 +
>   .../fs/ext4-new-features/ffsb-6.0-rc2/parser.c     | 1034 +++
>   .../fs/ext4-new-features/ffsb-6.0-rc2/parser.h     |  151 +
>   .../ffsb-6.0-rc2/public-description                |    4 +
>   .../fs/ext4-new-features/ffsb-6.0-rc2/rand.c       |  188 +
>   .../fs/ext4-new-features/ffsb-6.0-rc2/rand.h       |   60 +
>   .../kernel/fs/ext4-new-features/ffsb-6.0-rc2/rbt.c | 1040 +++
>   .../kernel/fs/ext4-new-features/ffsb-6.0-rc2/rbt.h |  316 +
>   .../ffsb-6.0-rc2/registration-description          |    7 +
>   .../fs/ext4-new-features/ffsb-6.0-rc2/rwlock.c     |  109 +
>   .../fs/ext4-new-features/ffsb-6.0-rc2/rwlock.h     |   51 +
>   .../fs/ext4-new-features/ffsb-6.0-rc2/stamp-h.in   |    1 +
>   .../fs/ext4-new-features/ffsb-6.0-rc2/util.c       |  351 +
>   .../fs/ext4-new-features/ffsb-6.0-rc2/util.h       |   94 +
>   .../kernel/fs/ext4-new-features/run_ext4_test.sh   |  179 +
>   94 files changed, 27330 insertions(+), 0 deletions(-)
>   create mode 100644 runtest/fs_ext4
>   create mode 100644 testcases/kernel/fs/ext4-new-features/Makefile
>   create mode 100644 testcases/kernel/fs/ext4-new-features/README
>   create mode 100644 testcases/kernel/fs/ext4-new-features/configure
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/Makefile
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/Makefile
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config0
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config1
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config2
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config3
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config4
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config5
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config6
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config7
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-inode-version/Makefile
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_get_inode_version.sh
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_test_inode_version.c
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/Makefile
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/Makefile
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_file_time.c
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-online-defrag/Makefile
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-online-defrag/e4defrag.c
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-online-defrag/ext4_online_defrag_test.sh
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/Makefile
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/Makefile
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/create_long_dirs.c
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/create_short_dirs.c
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/Makefile
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ext4_funcs.sh
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/AUTHORS
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/COPYING
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/INSTALL
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/LICENSE
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/Makefile.am
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/Makefile.in
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/README
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/aclocal.m4
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/cirlist.c
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/cirlist.h
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/config.guess
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/config.h.in
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/config.sub
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/configure
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/configure.in
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/depcomp
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/examples/profile_everything
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb.h
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_fc.c
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_fs.c
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_fs.h
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_op.c
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_op.h
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_stats.c
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_stats.h
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_tg.c
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_tg.h
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_thread.c
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_thread.h
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/fh.c
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/fh.h
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/filelist.c
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/filelist.h
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/fileops.c
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/fileops.h
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/install-sh
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/list.c
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/list.h
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/main.c
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/metaops.c
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/metaops.h
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/missing
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/mkinstalldirs
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/parser.c
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/parser.h
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/public-description
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/rand.c
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/rand.h
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/rbt.c
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/rbt.h
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/registration-description
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/rwlock.c
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/rwlock.h
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/stamp-h.in
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/util.c
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/util.h
>   create mode 100644 testcases/kernel/fs/ext4-new-features/run_ext4_test.sh


--===============8762529754926621804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
--===============8762529754926621804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8762529754926621804==--
