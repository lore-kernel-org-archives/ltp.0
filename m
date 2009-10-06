Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <miaox@cn.fujitsu.com>) id 1Mv4WD-00024w-1R
	for ltp-list@lists.sourceforge.net; Tue, 06 Oct 2009 07:31:33 +0000
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mv4W9-0001Xs-H3
	for ltp-list@lists.sourceforge.net; Tue, 06 Oct 2009 07:31:32 +0000
Message-ID: <4ACAF235.5010308@cn.fujitsu.com>
Date: Tue, 06 Oct 2009 16:31:01 +0900
From: Miao Xie <miaox@cn.fujitsu.com>
MIME-Version: 1.0
References: <20090928141727.30985.64585.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20090928141727.30985.64585.sendpatchset@subratamodak.linux.ibm.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: LTP-ML <ltp-list@lists.sourceforge.net>

Hi, Subrata

on 2009-9-28 23:17, Subrata Modak wrote:
> 1) The patch had many broken lines, for which i had to manually edit a lot
> before it got applied,
> 2) The patch needs to update the ltp/README file as well for the pre-requisites
> of building or executing the tests, like as follows:
> 	2.1) Built the kernel with CONFIG_EXT4*=y,
> 	2.2) Download and build the latest e2fsprogs-* from sourceforge.net, so
> that the latest utilities like mke2fs, tune2fs, dumpe2fs, mkfs.ext4, etc can be
> built on this system.
> However, this was not sufficient when i tried to build the sources. I found that
> header files from e2fslibs-devel* package is also required. Though i did not find
> an appropraite source RPM or TAR for my system, however, i was able to build by
> just copying those required headers (e2p.h,bitops.h,ext2_err.h,ext2_ext_attr.h,
> ext2_fs.h,ext2fs.h,ext2_io.h,ext2_types.h,ext3_extents.h,tdb.h) and Shared Objects
> (libe2p.a,libe2p.so,libext2fs.a,libext2fs.so). Please mention in ltp/README of
> where to locate these pre-requisites packages,
> 3) Do not integrate the ext4-* build with the default LTP build, because you
> need the user to execute
> ./configure
> 	at
> LTPROOT/testcases/kernel/fs/ext4-new-features/
> And also if the pre-requisites are not present then LTP default build from
> LTPROOT will fail at LTPROOT/testcases/kernel/fs/ext4-new-features/ directory.
> So, let us keep the ext4* test cases build and execution seperate. Let users
> manually cd to LTPROOT/testcases/kernel/fs/ext4-new-features/,
> and then do:
> ./configure,
> make
> make install
> 	and then run
> ./runltp -f fs_ext4
> 	from LTPROOT

I have fixed these problems in the latest patch that is attached.

> 
> 4) Following are my system parameters. I had created 20GB of primary partition
> which is ext4 formatted. However many of those tests failed owing to less
> space on the disk and generated segmentation faults as well. Please see the
> output and logs attached. If you think that the failures are due to insufficient
> partition size, etc, please mention then at ltp/README. Please let me know if
> these issues can be fixed earlier so that i can retest and include it in
> September 2009 release (may get delayed by a week).

I'm sorry to say that I can't reproduce these problems. I think it might be caused
by the wrong e2fsprogs-devel package. Could you help me retest it after installing
the right packages?

The necessary packages are following:
e2fsprogs
e2fsprogs-devel
e2fsprogs-libs
and the version of these packages should be 1.41.4 or above.

Thanks.
Miao

---
  README                                             |   18 +
  runtest/fs_ext4                                    |    1 +
  testcases/kernel/fs/ext4-new-features/Makefile     |   24 +
  testcases/kernel/fs/ext4-new-features/README       |  145 +
  testcases/kernel/fs/ext4-new-features/configure    |   23 +
  .../ext4-delalloc-mballoc/Makefile                 |   12 +
  .../ext4-delalloc-mballoc/ext4-alloc-test.sh       |  167 +
  .../fs/ext4-new-features/ext4-ffsb-config/Makefile |   17 +
  .../ext4-ffsb-config/ffsb-config0                  |   23 +
  .../ext4-ffsb-config/ffsb-config1                  |   23 +
  .../ext4-ffsb-config/ffsb-config2                  |   23 +
  .../ext4-ffsb-config/ffsb-config3                  |   29 +
  .../ext4-ffsb-config/ffsb-config4                  |   29 +
  .../ext4-ffsb-config/ffsb-config5                  |   29 +
  .../ext4-ffsb-config/ffsb-config6                  |   29 +
  .../ext4-ffsb-config/ffsb-config7                  |   29 +
  .../ext4-new-features/ext4-inode-version/Makefile  |   19 +
  .../ext4-inode-version/ext4_get_inode_version.sh   |   41 +
  .../ext4-inode-version/ext4_inode_version_test.sh  |  205 +
  .../ext4-inode-version/ext4_test_inode_version.c   |  219 +
  .../ext4-journal-checksum/Makefile                 |   12 +
  .../ext4-journal-checksum/ext4_journal_checksum.sh |  148 +
  .../ext4-nsec-timestamps/Makefile                  |   17 +
  .../ext4-nsec-timestamps/ext4_file_time.c          |   70 +
  .../ext4_nsec_timestamps_test.sh                   |  196 +
  .../ext4-new-features/ext4-online-defrag/Makefile  |   18 +
  .../ext4-online-defrag/e4defrag.c                  | 2171 ++++++
  .../ext4-online-defrag/ext4_online_defrag_test.sh  |  192 +
  .../ext4-persist-prealloc/Makefile                 |   12 +
  .../ext4_persist_prealloc_test.sh                  |  113 +
  .../ext4-new-features/ext4-subdir-limit/Makefile   |   18 +
  .../ext4-subdir-limit/create_long_dirs.c           |  156 +
  .../ext4-subdir-limit/create_short_dirs.c          |  158 +
  .../ext4-subdir-limit/ext4_subdir_limit_test.sh    |  167 +
  .../ext4-new-features/ext4-uninit-groups/Makefile  |   12 +
  .../ext4-uninit-groups/ext4_uninit_groups_test.sh  |  161 +
  .../kernel/fs/ext4-new-features/ext4_funcs.sh      |   47 +
  .../fs/ext4-new-features/ffsb-6.0-rc2/AUTHORS      |    7 +
  .../fs/ext4-new-features/ffsb-6.0-rc2/COPYING      |  340 +
  .../fs/ext4-new-features/ffsb-6.0-rc2/INSTALL      |  182 +
  .../fs/ext4-new-features/ffsb-6.0-rc2/LICENSE      |  347 +
  .../fs/ext4-new-features/ffsb-6.0-rc2/Makefile.am  |   46 +
  .../fs/ext4-new-features/ffsb-6.0-rc2/Makefile.in  |  628 ++
  .../fs/ext4-new-features/ffsb-6.0-rc2/README       |  413 ++
  .../fs/ext4-new-features/ffsb-6.0-rc2/aclocal.m4   |  880 +++
  .../fs/ext4-new-features/ffsb-6.0-rc2/cirlist.c    |  107 +
  .../fs/ext4-new-features/ffsb-6.0-rc2/cirlist.h    |   41 +
  .../fs/ext4-new-features/ffsb-6.0-rc2/config.guess | 1450 ++++
  .../fs/ext4-new-features/ffsb-6.0-rc2/config.h.in  |  130 +
  .../fs/ext4-new-features/ffsb-6.0-rc2/config.sub   | 1545 +++++
  .../fs/ext4-new-features/ffsb-6.0-rc2/configure    | 7000 ++++++++++++++++++++
  .../fs/ext4-new-features/ffsb-6.0-rc2/configure.in |   49 +
  .../fs/ext4-new-features/ffsb-6.0-rc2/depcomp      |  472 ++
  .../ffsb-6.0-rc2/examples/profile_everything       |  119 +
  .../fs/ext4-new-features/ffsb-6.0-rc2/ffsb.h       |  105 +
  .../fs/ext4-new-features/ffsb-6.0-rc2/ffsb_fc.c    |  112 +
  .../fs/ext4-new-features/ffsb-6.0-rc2/ffsb_fs.c    |  634 ++
  .../fs/ext4-new-features/ffsb-6.0-rc2/ffsb_fs.h    |  184 +
  .../fs/ext4-new-features/ffsb-6.0-rc2/ffsb_op.c    |  178 +
  .../fs/ext4-new-features/ffsb-6.0-rc2/ffsb_op.h    |  102 +
  .../fs/ext4-new-features/ffsb-6.0-rc2/ffsb_stats.c |  241 +
  .../fs/ext4-new-features/ffsb-6.0-rc2/ffsb_stats.h |  109 +
  .../fs/ext4-new-features/ffsb-6.0-rc2/ffsb_tg.c    |  369 +
  .../fs/ext4-new-features/ffsb-6.0-rc2/ffsb_tg.h    |  206 +
  .../ext4-new-features/ffsb-6.0-rc2/ffsb_thread.c   |  171 +
  .../ext4-new-features/ffsb-6.0-rc2/ffsb_thread.h   |  108 +
  .../kernel/fs/ext4-new-features/ffsb-6.0-rc2/fh.c  |  278 +
  .../kernel/fs/ext4-new-features/ffsb-6.0-rc2/fh.h  |   41 +
  .../fs/ext4-new-features/ffsb-6.0-rc2/filelist.c   |  503 ++
  .../fs/ext4-new-features/ffsb-6.0-rc2/filelist.h   |  145 +
  .../fs/ext4-new-features/ffsb-6.0-rc2/fileops.c    |  547 ++
  .../fs/ext4-new-features/ffsb-6.0-rc2/fileops.h    |   51 +
  .../fs/ext4-new-features/ffsb-6.0-rc2/install-sh   |  250 +
  .../fs/ext4-new-features/ffsb-6.0-rc2/list.c       |   55 +
  .../fs/ext4-new-features/ffsb-6.0-rc2/list.h       |   53 +
  .../fs/ext4-new-features/ffsb-6.0-rc2/main.c       |  258 +
  .../fs/ext4-new-features/ffsb-6.0-rc2/metaops.c    |  112 +
  .../fs/ext4-new-features/ffsb-6.0-rc2/metaops.h    |   28 +
  .../fs/ext4-new-features/ffsb-6.0-rc2/missing      |  336 +
  .../ext4-new-features/ffsb-6.0-rc2/mkinstalldirs   |   40 +
  .../fs/ext4-new-features/ffsb-6.0-rc2/parser.c     | 1034 +++
  .../fs/ext4-new-features/ffsb-6.0-rc2/parser.h     |  151 +
  .../ffsb-6.0-rc2/public-description                |    4 +
  .../fs/ext4-new-features/ffsb-6.0-rc2/rand.c       |  188 +
  .../fs/ext4-new-features/ffsb-6.0-rc2/rand.h       |   60 +
  .../kernel/fs/ext4-new-features/ffsb-6.0-rc2/rbt.c | 1040 +++
  .../kernel/fs/ext4-new-features/ffsb-6.0-rc2/rbt.h |  316 +
  .../ffsb-6.0-rc2/registration-description          |    7 +
  .../fs/ext4-new-features/ffsb-6.0-rc2/rwlock.c     |  109 +
  .../fs/ext4-new-features/ffsb-6.0-rc2/rwlock.h     |   51 +
  .../fs/ext4-new-features/ffsb-6.0-rc2/stamp-h.in   |    1 +
  .../fs/ext4-new-features/ffsb-6.0-rc2/util.c       |  351 +
  .../fs/ext4-new-features/ffsb-6.0-rc2/util.h       |   94 +
  .../kernel/fs/ext4-new-features/run_ext4_test.sh   |  179 +
  94 files changed, 27330 insertions(+), 0 deletions(-)
  create mode 100644 runtest/fs_ext4
  create mode 100644 testcases/kernel/fs/ext4-new-features/Makefile
  create mode 100644 testcases/kernel/fs/ext4-new-features/README
  create mode 100644 testcases/kernel/fs/ext4-new-features/configure
  create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/Makefile
  create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh
  create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/Makefile
  create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config0
  create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config1
  create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config2
  create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config3
  create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config4
  create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config5
  create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config6
  create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config7
  create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-inode-version/Makefile
  create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_get_inode_version.sh
  create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh
  create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_test_inode_version.c
  create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/Makefile
  create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh
  create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/Makefile
  create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_file_time.c
  create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
  create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-online-defrag/Makefile
  create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-online-defrag/e4defrag.c
  create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-online-defrag/ext4_online_defrag_test.sh
  create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/Makefile
  create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh
  create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/Makefile
  create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/create_long_dirs.c
  create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/create_short_dirs.c
  create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh
  create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/Makefile
  create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh
  create mode 100644 testcases/kernel/fs/ext4-new-features/ext4_funcs.sh
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/AUTHORS
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/COPYING
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/INSTALL
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/LICENSE
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/Makefile.am
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/Makefile.in
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/README
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/aclocal.m4
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/cirlist.c
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/cirlist.h
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/config.guess
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/config.h.in
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/config.sub
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/configure
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/configure.in
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/depcomp
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/examples/profile_everything
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb.h
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_fc.c
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_fs.c
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_fs.h
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_op.c
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_op.h
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_stats.c
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_stats.h
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_tg.c
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_tg.h
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_thread.c
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_thread.h
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/fh.c
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/fh.h
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/filelist.c
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/filelist.h
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/fileops.c
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/fileops.h
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/install-sh
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/list.c
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/list.h
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/main.c
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/metaops.c
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/metaops.h
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/missing
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/mkinstalldirs
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/parser.c
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/parser.h
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/public-description
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/rand.c
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/rand.h
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/rbt.c
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/rbt.h
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/registration-description
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/rwlock.c
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/rwlock.h
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/stamp-h.in
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/util.c
  create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/util.h
  create mode 100644 testcases/kernel/fs/ext4-new-features/run_ext4_test.sh

diff --git a/README b/README
index cec6e36..e98827c 100644
--- a/README
+++ b/README
@@ -405,3 +405,21 @@ end
  1) Add as many framework as they get added/modifed in the kernel
  ---------------------------------

+---------------------------------
+Enabling Kernel Configuration to test ext4 new features
+---------------------------------
+CONFIG_EXT4_FS=y
+CONFIG_EXT4DEV_COMPAT=y
+CONFIG_EXT4_FS_XATTR=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
+
+Beside that, the following packages are necessary.
+  e2fsprogs
+  e2fsprogs-devel
+  e2fsprogs-libs
+And the version of packages must be 1.41.4 or above.
+
+For more information to build/install/run these tests, look through:
+ltp/testcases/kernel/fs/ext4-new-features/README
+---------------------------------
diff --git a/runtest/fs_ext4 b/runtest/fs_ext4
new file mode 100644
index 0000000..c65ebab
--- /dev/null
+++ b/runtest/fs_ext4
@@ -0,0 +1 @@
+ext4_new_feature_test	run_ext4_test.sh
diff --git a/testcases/kernel/fs/ext4-new-features/Makefile b/testcases/kernel/fs/ext4-new-features/Makefile
new file mode 100644
index 0000000..19a053a
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/Makefile
@@ -0,0 +1,24 @@
+SUBDIRS = ext4-delalloc-mballoc ext4-journal-checksum ext4-subdir-limit
+SUBDIRS += ext4-nsec-timestamps ext4-persist-prealloc ext4-inode-version
+SUBDIRS += ext4-uninit-groups ext4-online-defrag ext4-ffsb-config
+
+all:
+	@set -e; \
+	for i in $(SUBDIRS); do $(MAKE) -C $$i $@; done;
+	$(MAKE) -C ffsb-6.0-rc2 $@;
+
+install:
+	@set -e; \
+	for i in $(SUBDIRS); do $(MAKE) -C $$i install ; done;
+	ln -f run_ext4_test.sh ../../../bin/run_ext4_test.sh;
+	chmod +x run_ext4_test.sh;
+	ln -f ext4_funcs.sh ../../../bin/ext4_funcs.sh;
+	chmod +x ext4_funcs.sh;
+	ln -f ffsb-6.0-rc2/ffsb ../../../bin/ffsb;
+	chmod +x ffsb-6.0-rc2/ffsb;
+	ln -f ext4-test-config ../../../bin/ext4-test-config;
+
+clean:
+	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i clean; done
+	rm -rf ext4-test-config
+
diff --git a/testcases/kernel/fs/ext4-new-features/README b/testcases/kernel/fs/ext4-new-features/README
new file mode 100644
index 0000000..12ee456
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/README
@@ -0,0 +1,145 @@
+TEST SUITE:
+
+The directory ext4-new-features contains the tests related to the ext4
+filesystem's new features.
+
+Ext4 is an advanced level of the ext3 filesystem which incorporates scalability
+and reliability enhancements for supporting large filesystems(64 bit) in keeping
+with increasing disk capacities and state-of-the-art feature requirements. More
+extensive information of ext4 can be found at the ext4 wiki site at the URL:
+http://ext4.wiki.kernel.org
+
+There are total 119 testcases for ext4 new features test that have been added.
+Now, these testcases can test multi-block alloc/delayed alloc, inode version
+field on disk, journal checksumming, nanosec timestamps, online defrag, persist
+prealloc, subdirectory limit and uninit groups of ext4.
+The detail information of ext4 new features can be found at the URL:
+http://ext4.wiki.kernel.org/index.php/New_ext4_features
+
+
+TESTS AIM:
+
+The aim of the tests is to test ext4 new features.
+
+
+TEST STEPS:
+# cd LTPROOT/testcases/kernel/fs/ext4-new-features
+# ./configure
+# make
+# make install
+# cd LTPROOT
+# ./runltp -f fs_ext4
+
+**This testsuite wouldn't be built when doing LTP default build. We MUST do it
+  by ourself.
+
+
+NOTE:
+
+1. This test can be run by root only.
+2. Your MUST run *configure* in this directory to config the tool of ffsb and
+   specify a partition to be used for test before compiling the tool, and be
+   CAREFUL the data on the specified partition would be DESTROYED.
+3. Before starting test ext4 new features, please check whether ext4 filesystem
+   is compiled into the kernel or not, and the kernel version is *2.6.31* or
+   above.
+4. A snapshot of config file options is given below:
+   ONFIG_EXT4_FS=y
+   CONFIG_EXT4DEV_COMPAT=y
+   CONFIG_EXT4_FS_XATTR=y
+   CONFIG_EXT4_FS_POSIX_ACL=y
+   CONFIG_EXT4_FS_SECURITY=y
+
+5. Beside that, the following packages are necessary:
+   e2fsprogs
+     (http://www.rpmfind.net/linux/rpm2html/search.php?query=e2fsprogs)
+   e2fsprogs-devel
+     (http://www.rpmfind.net/linux/rpm2html/search.php?query=e2fsprogs-devel)
+   e2fsprogs-libs
+     (http://www.rpmfind.net/linux/rpm2html/search.php?query=e2fsprogs-libs)
+   and the version of these packages should be 1.41.4 or above, otherwise the
+   test will fail.
+
+
+FILES DESCRIPTION:
+
+configure
+---------
+This is a config script that is used to configure the ffsb tool and specify a
+partition for test. And the data on the specified partition would be destroyed.
+Be careful! Beside that, you MUST run this script before compile the testcases.
+
+ext4-delalloc-mballoc
+---------------------
+Directory containing the shell script which is used to test multi-block
+allocation and delayed allocation of ext4.
+
+ext4-ffsb-config
+----------------
+Directory containing the config of ffsb for test.
+
+ext4-inode-version
+------------------
+Directory containing the shell script which is used to test inode version field
+on disk of ext4.
+
+ext4-journal-checksum
+---------------------
+Directory containing the shell script which is used to test journal checksumming
+of ext4.
+
+ext4-nsec-timestamps
+--------------------
+Directory containing the shell script which is used to test nanosec timestamps
+of ext4.
+
+ext4-online-defrag
+------------------
+Directory containing the shell script which is used to test online defrag
+feature of ext4.
+
+ext4-persist-prealloc
+---------------------
+Directory containing the shell script which is used to test persist prealloc
+feature of ext4.
+
+ext4-subdir-limit
+-----------------
+Directory containing the shell script which is used to test subdirectory limit
+of ext4. According to the kernel documentation, we create more than 32000
+subdirectorys on the ext4 filesystem.
+
+But, when then block size is small, such as 1024, and the name of every
+subdirectory is very long, such as every name is 255 bytes, we can just create
+less than 20000 subdirectory. In this test suite, there is two FAIL cases by
+reason of it.
+
+ext4-uninit-groups
+------------------
+Directory containing the shell script which is used to test uninitialized groups
+feature of ext4.
+
+ffsb-6.0-rc2
+------------
+This directory contains The Flexible Filesystem Benchmark (FFSB) tool. We use
+this tool to create some files to fill the test partition. This tool was written
+by Sonny Rao(raosanth@us.ibm.com).
+
+ext4_funcs.sh
+-------------
+This script contains some functions for ext4 new features test script.
+such as: ext4_setup, ext4_cleanup
+
+run_ext4_test.sh
+----------------
+This script runs all the 119 testcases.
+
+Makefile
+--------
+Each directory in this directory has its usual makefile, it is for its
+directory.
+
+README
+------
+The one you have gone through.
+
diff --git a/testcases/kernel/fs/ext4-new-features/configure b/testcases/kernel/fs/ext4-new-features/configure
new file mode 100644
index 0000000..13f43f9
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/configure
@@ -0,0 +1,23 @@
+#!/bin/sh
+
+echo "Run the ffsb's configure"
+cd ./ffsb-6.0-rc2
+./configure
+cd ..
+
+EXT4_DEV=
+RESULT=
+
+echo "Ext4 new features test configure"
+echo "Please specify a partition to create ext4 filesystem:"
+read EXT4_DEV
+
+echo "The partition is: $EXT4_DEV, Are you sure(Y/N)?"
+read RESULT
+if [ "$RESULT" == "Y" ] || [ "$RESULT" == "y" ]; then
+	echo "EXT4_DEV=$EXT4_DEV" > ./ext4-test-config
+elif [ "$RESULT" == "N" ]; then
+	echo "Give up specifing a partition!"
+else
+	echo "Your input is wrong($RESULT)."
+fi
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/Makefile b/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/Makefile
new file mode 100644
index 0000000..4396397
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/Makefile
@@ -0,0 +1,12 @@
+SRCS = $(wildcard *.sh)
+
+all:
+	@true
+
+install:
+	@set -e;
+	for i in $(SRCS); do ln -f $$i ../../../../bin/$$i; chmod +x $$i; done;
+
+clean:
+	@true
+
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh b/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh
new file mode 100644
index 0000000..ec2f389
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh
@@ -0,0 +1,167 @@
+#!/bin/bash
+
+################################################################################
+#                                                                              #
+# Copyright (c) 2009 FUJITSU LIMITED                                           #
+#                                                                              #
+# This program is free software;  you can redistribute it and#or modify        #
+# it under the terms of the GNU General Public License as published by         #
+# the Free Software Foundation; either version 2 of the License, or            #
+# (at your option) any later version.                                          #
+#                                                                              #
+# This program is distributed in the hope that it will be useful, but          #
+# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY   #
+# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License     #
+# for more details.                                                            #
+#                                                                              #
+# You should have received a copy of the GNU General Public License            #
+# along with this program;  if not, write to the Free Software                 #
+# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA      #
+#                                                                              #
+################################################################################
+
+cd $LTPROOT/testcases/bin
+
+. ./ext4_funcs.sh
+
+export TCID="ext4-delalloc-mballoc"
+export TST_TOTAL=17
+export TST_COUNT=1
+
+# $1: the test config
+
+export TEST_DIR=$PWD
+
+read_config $1
+
+# Case 17: mount ext4 partition to ext3
+ext4_test_remount()
+{
+	mkfs.ext3 -I 256 -b 1024 $EXT4_DEV > /dev/null
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "failed to create ext4 filesystem"
+		return 1
+	fi
+
+	tune2fs -E test_fs $EXT4_DEV
+
+	mount -t ext4 -o delalloc,auto_da_alloc $EXT4_DEV mnt_point
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "failed to mount ext4 filesystem"
+		return 1
+	fi
+
+	./ffsb ffsb-config0 > /dev/null
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "ffsb returned failure"
+		umount mnt_point
+		return 1
+	fi
+
+	umount mnt_point
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "failed to umount ext4 filesystem"
+		return
+	fi
+
+	mount -t ext3 $EXT4_DEV mnt_point
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "failed to mount to ext3"
+		return 1
+	fi
+	umount mnt_point
+
+	fsck -p $EXT4_DEV
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "fsck returned failure"
+		return 1
+	fi
+
+	tst_resm TPASS "remount test pass"
+}
+
+# Case 1-16: Use ffsb to test mballoc and delalloc
+# $1: delalloc or nodelalloc
+# $2: 0 - indirect-io, 1 - direct-io
+# $3: block size
+# $4: auto_da_alloc
+ext4_test_delalloc_mballoc()
+{
+	tst_resm TINFO "isDelalloc: $1, isDirectIO: $2, Blocksize: $3, \
+		isAuto_da_alloc: $4"
+
+	mkfs.ext4 -I 256 -b $3 /$EXT4_DEV > /dev/null
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "failed to create ext4 filesystem"
+		return 1
+	fi
+
+	tune2fs -E test_fs -O extents $EXT4_DEV
+
+	mount -t ext4 -o $1,$4 $EXT4_DEV mnt_point
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "failed to mount ext4 filesystem"
+		return 1
+	fi
+
+	./ffsb ffsb-config$2 > /dev/null
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "ffsb returned failure"
+		umount mnt_point
+		return 1
+	fi
+
+	umount mnt_point
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "failed to umount ext4 filesystem"
+		return 1
+	fi
+
+	fsck -p $EXT4_DEV
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "fsck returned failure"
+		return 1
+	fi
+
+	tst_resm TPASS "delalloc/mballoc test pass"
+}
+
+# main
+ext4_setup
+
+DELALLOC=( "delalloc" "nodelalloc" )
+DIRECT_IO=( 0 1 )
+BLOCK_SIZE=( 1024 4096 )
+BLOCK_AUTO_DA_ALLOC=( "auto_da_alloc=1" "noauto_da_alloc" )
+
+RET=0
+
+for ((i = 0; i < 2; i++))
+{
+	for ((j = 0; j < 2; j++))
+	{
+		for ((k = 0; k < 2; k++))
+		{
+			for ((l = 0; l < 2; l++))
+			{
+				ext4_test_delalloc_mballoc ${DELALLOC[$k]} \
+						${DIRECT_IO[$j]} \
+						${BLOCK_SIZE[$i]} \
+						${BLOCK_AUTO_DA_ALLOC[$l]}
+				if [ $? -ne 0 ]; then
+					RET=1
+				fi
+				: $((TST_COUNT++))
+			}
+		}
+	}
+}
+
+ext4_test_remount
+if [ $? -ne 0 ]; then
+	RET=1
+fi
+
+ext4_cleanup
+
+exit $RET
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/Makefile b/testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/Makefile
new file mode 100644
index 0000000..ed07019
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/Makefile
@@ -0,0 +1,17 @@
+all:
+	@true
+
+install:
+	@set -e;
+	ln -f ffsb-config0 ../../../../bin/ffsb-config0;
+	ln -f ffsb-config1 ../../../../bin/ffsb-config1;
+	ln -f ffsb-config2 ../../../../bin/ffsb-config2;
+	ln -f ffsb-config3 ../../../../bin/ffsb-config3;
+	ln -f ffsb-config4 ../../../../bin/ffsb-config4;
+	ln -f ffsb-config5 ../../../../bin/ffsb-config5;
+	ln -f ffsb-config6 ../../../../bin/ffsb-config6;
+	ln -f ffsb-config7 ../../../../bin/ffsb-config7;
+
+clean:
+	@true
+
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config0 b/testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config0
new file mode 100644
index 0000000..caf1928
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config0
@@ -0,0 +1,23 @@
+directio=0
+time=500
+
+[filesystem0]
+location=mnt_point
+num_files=100000
+num_dirs=40
+max_filesize=40960
+min_filesize=4096
+[end0]
+
+
+[threadgroup0]
+num_threads=10
+read_weight=3
+write_weight=1
+append_weight=1
+write_random=1
+write_size=4096
+write_blocksize=4096
+read_size=4096
+read_blocksize=4096
+[end0]
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config1 b/testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config1
new file mode 100644
index 0000000..9fe820d
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config1
@@ -0,0 +1,23 @@
+directio=1
+time=400
+
+[filesystem0]
+location=mnt_point
+num_files=100000
+num_dirs=40
+max_filesize=4096
+min_filesize=4096
+[end0]
+
+
+[threadgroup0]
+num_threads=10
+read_weight=3
+write_weight=1
+append_weight=1
+write_random=1
+write_size=4096
+write_blocksize=4096
+read_size=4096
+read_blocksize=4096
+[end0]
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config2 b/testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config2
new file mode 100644
index 0000000..993fe14
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config2
@@ -0,0 +1,23 @@
+directio=0
+time=500
+
+[filesystem0]
+location=mnt_point
+num_files=100000
+num_dirs=40
+max_filesize=20480
+min_filesize=4096
+[end0]
+
+
+[threadgroup0]
+num_threads=10
+read_weight=3
+write_weight=1
+append_weight=1
+write_random=1
+write_size=4096
+write_blocksize=4096
+read_size=4096
+read_blocksize=4096
+[end0]
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config3 b/testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config3
new file mode 100644
index 0000000..d95149d
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config3
@@ -0,0 +1,29 @@
+directio=0
+time=0
+
+[filesystem0]
+	location=mnt_point/
+	num_files=1
+	num_dirs=1
+	max_filesize=409600
+	min_filesize=40960
+	agefs=1
+	[threadgroup0]
+		num_threads=10
+		write_size=409600
+		write_blocksize=40960
+		create_weight=10
+		append_weight=10
+		delete_weight=1
+	[end0]
+		desired_util=0.20
+[end0]
+
+[threadgroup0]
+	num_threads=32
+	read_weight=1
+
+	read_size=4096
+	read_blocksize=4096
+[end0]
+
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config4 b/testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config4
new file mode 100644
index 0000000..f1a432e
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config4
@@ -0,0 +1,29 @@
+directio=0
+time=0
+
+[filesystem0]
+	location=mnt_point/
+	num_files=1
+	num_dirs=1
+	max_filesize=409600
+	min_filesize=40960
+	agefs=1
+	[threadgroup0]
+		num_threads=10
+		write_size=409600
+		write_blocksize=40960
+		create_weight=10
+		append_weight=10
+		delete_weight=1
+	[end0]
+		desired_util=0.40
+[end0]
+
+[threadgroup0]
+	num_threads=32
+	read_weight=1
+
+	read_size=4096
+	read_blocksize=4096
+[end0]
+
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config5 b/testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config5
new file mode 100644
index 0000000..758eded
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config5
@@ -0,0 +1,29 @@
+directio=0
+time=0
+
+[filesystem0]
+	location=mnt_point/
+	num_files=1
+	num_dirs=1
+	max_filesize=409600
+	min_filesize=40960
+	agefs=1
+	[threadgroup0]
+		num_threads=10
+		write_size=409600
+		write_blocksize=40960
+		create_weight=10
+		append_weight=10
+		delete_weight=1
+	[end0]
+		desired_util=0.60
+[end0]
+
+[threadgroup0]
+	num_threads=32
+	read_weight=1
+
+	read_size=4096
+	read_blocksize=4096
+[end0]
+
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config6 b/testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config6
new file mode 100644
index 0000000..6592177
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config6
@@ -0,0 +1,29 @@
+directio=0
+time=0
+
+[filesystem0]
+	location=mnt_point/
+	num_files=1
+	num_dirs=1
+	max_filesize=409600
+	min_filesize=40960
+	agefs=1
+	[threadgroup0]
+		num_threads=10
+		write_size=409600
+		write_blocksize=40960
+		create_weight=10
+		append_weight=10
+		delete_weight=1
+	[end0]
+		desired_util=0.80
+[end0]
+
+[threadgroup0]
+	num_threads=32
+	read_weight=1
+
+	read_size=4096
+	read_blocksize=4096
+[end0]
+
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config7 b/testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config7
new file mode 100644
index 0000000..0f6df51
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config7
@@ -0,0 +1,29 @@
+directio=0
+time=0
+
+[filesystem0]
+	location=mnt_point/
+	num_files=1
+	num_dirs=1
+	max_filesize=409600
+	min_filesize=40960
+	agefs=1
+	[threadgroup0]
+		num_threads=10
+		write_size=409600
+		write_blocksize=40960
+		create_weight=10
+		append_weight=10
+		delete_weight=1
+	[end0]
+		desired_util=1.00
+[end0]
+
+[threadgroup0]
+	num_threads=32
+	read_weight=1
+
+	read_size=4096
+	read_blocksize=4096
+[end0]
+
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-inode-version/Makefile b/testcases/kernel/fs/ext4-new-features/ext4-inode-version/Makefile
new file mode 100644
index 0000000..0e3ff1d
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ext4-inode-version/Makefile
@@ -0,0 +1,19 @@
+CFLAGS += -Wall -g -Wextra
+LDLIBS += -lm
+
+SRCS=$(wildcard *.c)
+OBJECTS=$(patsubst %.c,%.o,$(SRCS))
+TARGETS=$(patsubst %.c,%,$(SRCS))
+
+SHELL_SRCS=$(wildcard *.sh)
+
+all: $(TARGETS)
+
+install:
+	@set -e;
+	for i in $(SHELL_SRCS); do ln -f $$i ../../../../bin/$$i; chmod +x $$i; done;
+	for i in $(TARGETS); do ln -f $$i ../../../../bin/$$i; chmod +x $$i; done;
+
+clean:
+	rm -rf $(TARGETS) $(OBJECTS)
+
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_get_inode_version.sh b/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_get_inode_version.sh
new file mode 100644
index 0000000..8f5c907
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_get_inode_version.sh
@@ -0,0 +1,41 @@
+#! /bin/bash
+
+################################################################################
+#                                                                              #
+# Copyright (c) 2009 FUJITSU LIMITED                                           #
+#                                                                              #
+# This program is free software;  you can redistribute it and#or modify        #
+# it under the terms of the GNU General Public License as published by         #
+# the Free Software Foundation; either version 2 of the License, or            #
+# (at your option) any later version.                                          #
+#                                                                              #
+# This program is distributed in the hope that it will be useful, but          #
+# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY   #
+# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License     #
+# for more details.                                                            #
+#                                                                              #
+# You should have received a copy of the GNU General Public License            #
+# along with this program;  if not, write to the Free Software                 #
+# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA      #
+#                                                                              #
+################################################################################
+
+#$1: inode version of which file
+#$2: 1  - return inode version by return value
+#    !1 - writting inode version to stddev
+
+inode_version=`debugfs -R "stat $1" $EXT4_DEV | grep 'Version' | awk '{
+print $NF }'`
+
+# The inode_version's format: '0x0000000a' or '0x00000000:0000000a',
+# so delete ':'
+inode_version=`echo $inode_version | sed 's/://'`
+
+inode_version=$(( $inode_version ))
+
+if [ "$2" == "1" ]; then
+	exit $inode_version
+else
+	echo $inode_version
+fi
+
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh
new file mode 100644
index 0000000..f27248b
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh
@@ -0,0 +1,205 @@
+#!/bin/bash
+
+################################################################################
+##                                                                            ##
+## Copyright (c) 2009 FUJITSU LIMITED                                         ##
+##                                                                            ##
+## This program is free software;  you can redistribute it and#or modify      ##
+## it under the terms of the GNU General Public License as published by       ##
+## the Free Software Foundation; either version 2 of the License, or          ##
+## (at your option) any later version.                                        ##
+##                                                                            ##
+## This program is distributed in the hope that it will be useful, but        ##
+## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
+## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
+## for more details.                                                          ##
+##                                                                            ##
+## You should have received a copy of the GNU General Public License          ##
+## along with this program;  if not, write to the Free Software               ##
+## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
+##                                                                            ##
+## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
+##         Miao Xie <miaox@cn.fujitsu.com>                                    ##
+##                                                                            ##
+################################################################################
+
+cd $LTPROOT/testcases/bin
+
+. ./ext4_funcs.sh
+
+export TCID="ext4-inode-version"
+export TST_TOTAL=8
+export TST_COUNT=1
+
+export TEST_DIR=$PWD
+
+# $1: the test config
+read_config $1
+
+# Test that inode version is not 32 bits with 128 inode size
+ext4_test_128_inode_version()
+{
+	tst_resm TINFO "Test inode version is 32 bits with 128 inode size"
+
+	mkfs.ext4 -I 128 $EXT4_DEV > /dev/null
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "failed to create ext4 filesystem"
+		return 1
+	fi
+
+	tune2fs -E test_fs -O extents $EXT4_DEV
+
+	mount -t ext4 -o i_version $EXT4_DEV mnt_point
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "failed to mount ext4 filesystem"
+		return 1
+	fi
+
+	# inode version > 0
+	touch mnt_point/tmp_file
+	sync
+	version=`./ext4_get_inode_version.sh tmp_file`
+
+	if [ $version -lt 1 ]; then
+		tst_resm TFAIL "inode version is smaller than 1"
+		umount mnt_point
+		return 1
+	fi
+
+	# inode version is 32 bits: 0x00000000
+	version=`debugfs $EXT4_DEV -R "stat tmp_file" | grep 'Version'`
+	version=`echo $version | awk '{ print $NF }'`
+	version=`echo $version | sed 's/^0x//'`
+	len=${#version}
+
+	if [ $len -ne 8 ]; then
+		tst_resm TFAIL "inode version is not 32 bits"
+		umount mnt_point
+		return 1
+	fi
+
+	umount mnt_point
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "failed to umount ext4 filesystem"
+		return 1
+	fi
+
+	tst_resm TPASS "32 bits inode version with 128 inode size test pass"
+}
+
+# Test file timestamps is nanosecond with 256 inode size
+# $1: file operation
+test_inode_version()
+{
+	mkfs.ext3 -I 256 $EXT4_DEV > /dev/null
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "failed to create ext4 filesystem"
+		return 1
+	fi
+
+	tune2fs -E test_fs $EXT4_DEV > /dev/null
+
+	mount -t ext4 -o i_version $EXT4_DEV mnt_point
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "failed to mount ext4 filesystem"
+		return 1
+	fi
+
+	# Check the inode version after some file operation
+	old_version=`./ext4_test_inode_version $1 mnt_point/tmp_file tmp_file`
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "inode version is wrong"
+		umount mnt_point
+		return 1
+	fi
+
+	umount mnt_point
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "failed to umount ext4 filesystem"
+		return 1
+	fi
+
+	# Test mount to ext3 and then mount back to ext4
+	mount -t ext3 $EXT4_DEV mnt_point
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "failed to mount to ext3"
+		return 1
+	fi
+	umount mnt_point
+
+	mount -t ext4 $EXT4_DEV mnt_point
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "failed to mount back to ext4"
+		return 1
+	fi
+
+	version=`./ext4_get_inode_version.sh tmp_file`
+#	echo "remount: old - $old_version"
+#	echo "remount: new - $version"
+	if [ $old_version -ne $version ]; then
+		tst_resm TFAIL "inode version has changed unexpected"
+		umount mnt_point
+		return 1
+	else
+		tst_resm TPASS "inode version with 256 inode size test pass"
+		umount mnt_point
+	fi
+}
+
+# main
+ext4_setup
+
+RET=0
+
+ext4_test_128_inode_version
+if [ $? -ne 0 ]; then
+	RET=1
+fi
+: $((TST_COUNT++))
+
+test_inode_version create
+if [ $? -ne 0 ]; then
+	RET=1
+fi
+: $((TST_COUNT++))
+
+test_inode_version chmod
+if [ $? -ne 0 ]; then
+	RET=1
+fi
+: $((TST_COUNT++))
+
+test_inode_version chown
+if [ $? -ne 0 ]; then
+	RET=1
+fi
+: $((TST_COUNT++))
+
+test_inode_version read
+if [ $? -ne 0 ]; then
+	RET=1
+fi
+: $((TST_COUNT++))
+
+test_inode_version write
+if [ $? -ne 0 ]; then
+	RET=1
+fi
+: $((TST_COUNT++))
+
+test_inode_version mmap_read
+if [ $? -ne 0 ]; then
+	RET=1
+fi
+: $((TST_COUNT++))
+
+test_inode_version mmap_write
+if [ $? -ne 0 ]; then
+	RET=1
+fi
+: $((TST_COUNT++))
+
+ext4_cleanup
+
+exit $RET
+
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_test_inode_version.c b/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_test_inode_version.c
new file mode 100644
index 0000000..e9f3840
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_test_inode_version.c
@@ -0,0 +1,219 @@
+/******************************************************************************/
+/*                                                                            */
+/* Copyright (c) 2009 FUJITSU LIMITED                                         */
+/*                                                                            */
+/* This program is free software;  you can redistribute it and/or modify      */
+/* it under the terms of the GNU General Public License as published by       */
+/* the Free Software Foundation; either version 2 of the License, or          */
+/* (at your option) any later version.                                        */
+/*                                                                            */
+/* This program is distributed in the hope that it will be useful,            */
+/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
+/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
+/* the GNU General Public License for more details.                           */
+/*                                                                            */
+/* You should have received a copy of the GNU General Public License          */
+/* along with this program;  if not, write to the Free Software               */
+/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    */
+/*                                                                            */
+/* Author: Li Zefan <lizf@cn.fujitsu.com>                                     */
+/*                                                                            */
+/******************************************************************************/
+
+#include <unistd.h>
+#include <wait.h>
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <fcntl.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+
+char *filename;
+char *filepath;
+int fd;
+
+int old_inode_version;
+int new_inode_version;
+
+int get_inode_version(void)
+{
+	char buf[1024];
+
+	sprintf(buf, "./ext4_get_inode_version.sh %s 1", filename);
+
+	/* sync before run debugfs to get inode version */
+	sync();
+
+	return WEXITSTATUS(system(buf));
+}
+
+void test_chmod(void)
+{
+	if (fchmod(fd, S_IRUSR | S_IWUSR)) {
+		fprintf(stderr, "fchmod failed\n");
+		exit(1);
+	}
+}
+
+void test_chown(void)
+{
+	if (fchown(fd, 1, 1)) {
+		fprintf(stderr, "fchown failed\n");
+		exit(1);
+	}
+}
+
+void test_read(void)
+{
+	char buf[2];
+
+	/* write something before read */
+	if (write(fd, "abc", 4) == -1) {
+		perror("write");
+		exit(1);
+	}
+	close(fd);
+
+	if (open(filepath, O_RDONLY) == -1) {
+		perror("open");
+		exit(1);
+	}
+
+	old_inode_version = get_inode_version();
+
+	if (read(fd, buf, 1) == -1) {
+		perror("read");
+		exit(1);
+	}
+}
+
+void test_write(void)
+{
+	if (write(fd, "a", 1) == -1) {
+		fprintf(stderr, "write failed\n");
+		exit(1);
+	}
+}
+
+void test_mmap_read(void)
+{
+	char *p;
+	char c;
+
+	/* write something before read */
+	if (write(fd, "abc", 4) == -1) {
+		perror("write");
+		exit(1);
+	}
+	close(fd);
+
+	if (open(filepath, O_RDONLY) == -1) {
+		perror("open");
+		exit(1);
+	}
+
+	old_inode_version = get_inode_version();
+
+	p = mmap(NULL, 1, PROT_READ, MAP_PRIVATE | MAP_FILE, fd, 0);
+	if (p == (void *)-1) {
+		perror("mmap");
+		exit(1);
+	}
+	c = *p;
+
+	new_inode_version = get_inode_version();
+
+	msync(p, 1, MS_SYNC);
+}
+
+void test_mmap_write(void)
+{
+	char *p;
+
+	if (write(fd, "abc", 4) == -1) {
+		perror("write");
+		exit(1);
+	}
+	close(fd);
+
+	if (open(filepath, O_RDWR) == -1) {
+		perror("open");
+		exit(1);
+	}
+
+	old_inode_version = get_inode_version();
+
+	p = mmap(NULL, 1, PROT_WRITE,
+		 MAP_PRIVATE | MAP_FILE, fd, 0);
+	if (p == (void *)-1) {
+		perror("mmap");
+		exit(1);
+	}
+	*p = 'x';
+
+	new_inode_version = get_inode_version();
+
+	msync(p, 1, MS_SYNC);
+}
+
+/**
+ * argv[1]: file operation
+ * argv[2]: file to test (with path)
+ * argv[3]: file to test (without path)
+ */
+int main(int argc, char *argv[])
+{
+	if (argc != 4) {
+		fprintf(stderr, "wrong argument number\n");
+		return 1;
+	}
+	filepath = argv[2];
+	filename = argv[3];
+
+	/* create file and get the initial inode version */
+	fd = creat(argv[2], O_RDWR);
+	if (fd == -1) {
+		fprintf(stderr, "failed to create file: %s\n", argv[2]);
+		return 1;
+	}
+
+	old_inode_version = get_inode_version();
+
+	if (strcmp(argv[1], "create") == 0) {
+		printf("%d\n", old_inode_version);
+		return 0;
+	} else if (strcmp(argv[1], "chmod") == 0) {
+		test_chmod();
+	} else if (strcmp(argv[1], "chown") == 0) {
+		test_chown();
+	} else if (strcmp(argv[1], "read") == 0) {
+		test_read();
+	} else if (strcmp(argv[1], "write") == 0) {
+		test_write();
+	} else if (strcmp(argv[1], "mmap_read") == 0) {
+		test_mmap_read();
+	} else if (strcmp(argv[1], "mmap_write") == 0) {
+		test_mmap_write();
+	} else {
+		fprintf(stderr, "wrong file operation: %s\n", argv[1]);
+		return 1;
+	}
+
+	new_inode_version = get_inode_version();
+#if 0
+	fprintf(stderr, "test_inode_version: old - %d\n", old_inode_version);
+	fprintf(stderr, "test_inode_version: new - %d\n", new_inode_version);
+#endif
+	/* wrong inode version, test failed */
+	if (new_inode_version <= old_inode_version)
+		return 1;
+
+	printf("%d\n", new_inode_version);
+
+	close(fd);
+
+	return 0;
+}
+
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/Makefile b/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/Makefile
new file mode 100644
index 0000000..4396397
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/Makefile
@@ -0,0 +1,12 @@
+SRCS = $(wildcard *.sh)
+
+all:
+	@true
+
+install:
+	@set -e;
+	for i in $(SRCS); do ln -f $$i ../../../../bin/$$i; chmod +x $$i; done;
+
+clean:
+	@true
+
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh b/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh
new file mode 100644
index 0000000..550afa1
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh
@@ -0,0 +1,148 @@
+#!/bin/bash
+
+################################################################################
+##                                                                            ##
+## Copyright (c) 2009 FUJITSU LIMITED                                         ##
+##                                                                            ##
+## This program is free software;  you can redistribute it and#or modify      ##
+## it under the terms of the GNU General Public License as published by       ##
+## the Free Software Foundation; either version 2 of the License, or          ##
+## (at your option) any later version.                                        ##
+##                                                                            ##
+## This program is distributed in the hope that it will be useful, but        ##
+## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
+## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
+## for more details.                                                          ##
+##                                                                            ##
+## You should have received a copy of the GNU General Public License          ##
+## along with this program;  if not, write to the Free Software               ##
+## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
+##                                                                            ##
+## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
+##         Miao Xie <miaox@cn.fujitsu.com>                                    ##
+##                                                                            ##
+################################################################################
+
+cd $LTPROOT/testcases/bin
+
+. ./ext4_funcs.sh
+
+export TCID="ext4-journal-checksum"
+export TST_TOTAL=36
+export TST_COUNT=1
+
+# $1: the test config
+
+export TEST_DIR=$PWD
+
+read_config $1
+
+# Use ffsb to test journal checksumming
+# $1: journal mode: writeback, ordered, journal
+# $2: commit interval: 1 sec, 100 sec
+# $3: journal_checksum or not
+# $4: journal_async_commit or not
+# $5: barrier: 0, 1
+ext4_test_journal_checksum()
+{
+	local checksum=
+	local async_commit=
+
+	if [ "$3" == "" ]; then
+		checksum="No use"
+	else
+		checksum="Used"
+	fi
+	if [ "$4" == "" ]; then
+		async_commit="No use"
+	else
+		async_commit="Used"
+	fi
+
+	tst_resm TINFO "journal mode: $1, commit interval: $2, \
+		journal_checksum: $checksum, \
+		journal_async_commit: $async_commit, barrier: $5"
+
+	mkfs.ext4 -I 256 $EXT4_DEV > /dev/null
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "failed to create ext4 filesystem"
+		return 1
+	fi
+
+	tune2fs -E test_fs -O extents $EXT4_DEV
+
+	mount -t ext4 -o data=$1,commit=$2,$3,$4,barrier=$5 $EXT4_DEV mnt_point
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "failed to mount ext4 filesystem"
+		return 1
+	fi
+
+	./ffsb ffsb-config2 > /dev/null
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "ffsb returned failure"
+		umount mnt_point
+		return 1
+	fi
+
+	umount mnt_point
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "failed to umount ext4 filesystem"
+		return 1
+	fi
+
+	e2fsck -p $EXT4_DEV
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "fsck returned failure"
+		return 1
+	fi
+
+	tst_resm TPASS "ext4 journal checksum test pass"
+}
+
+# main
+ext4_setup
+
+DATA=( "writeback" "ordered" "journal" )
+COMMIT=( 1 100 )
+JOURNAL_CHECKSUM=( "journal_checksum" "" )
+JOURNAL_ASYNC_COMMIT=( "journal_async_commit" "" )
+BARRIER=( 0 1 )
+
+RET=0
+
+for ((i = 0; i < 2; i++))
+{
+	for ((j = 0; j < 2; j++))
+	{
+		for ((k = 0; k < 2; k++))
+		{
+			for ((l = 0; l < 2; l++))
+			{
+				for ((m = 0; m < 3; m++))
+				{
+
+					# when journal_async_commit is used,
+					# journal_checksum is set automatically
+					if [ $j -eq 0 -a $k -eq 1 ]; then
+						continue
+					fi
+
+					ext4_test_journal_checksum ${DATA[$m]} \
+						${COMMIT[$l]} \
+						"${JOURNAL_CHECKSUM[$k]}" \
+						"${JOURNAL_ASYNC_COMMIT[$j]}" \
+						${BARRIER[$i]}
+					if [ $? -ne 0 ]; then
+						RET=1
+					fi
+
+					: $((TST_COUNT++))
+				}
+			}
+		}
+	}
+}
+
+ext4_cleanup
+
+exit $RET
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/Makefile b/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/Makefile
new file mode 100644
index 0000000..e916de3
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/Makefile
@@ -0,0 +1,17 @@
+CFLAGS += -Wall -g -Wextra
+LDLIBS += -lm
+
+SRCS=$(wildcard *.c)
+OBJECTS=$(patsubst %.c,%.o,$(SRCS))
+TARGETS=$(patsubst %.c,%,$(SRCS))
+
+all: $(TARGETS)
+
+clean:
+	rm -rf $(TARGETS) $(OBJECTS)
+
+install:
+	@set -e;
+	for i in $(TARGETS); do ln -f $$i ../../../../bin/$$i; chmod +x $$i; done;
+	ln -f ext4_nsec_timestamps_test.sh ../../../../bin/ext4_nsec_timestamps_test.sh;
+	chmod +x ext4_nsec_timestamps_test.sh
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_file_time.c b/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_file_time.c
new file mode 100644
index 0000000..faa9383
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_file_time.c
@@ -0,0 +1,70 @@
+/******************************************************************************/
+/*                                                                            */
+/* Copyright (c) 2009 FUJITSU LIMITED                                         */
+/*                                                                            */
+/* This program is free software;  you can redistribute it and/or modify      */
+/* it under the terms of the GNU General Public License as published by       */
+/* the Free Software Foundation; either version 2 of the License, or          */
+/* (at your option) any later version.                                        */
+/*                                                                            */
+/* This program is distributed in the hope that it will be useful,            */
+/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
+/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
+/* the GNU General Public License for more details.                           */
+/*                                                                            */
+/* You should have received a copy of the GNU General Public License          */
+/* along with this program;  if not, write to the Free Software               */
+/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    */
+/*                                                                            */
+/* Author: Li Zefan <lizf@cn.fujitsu.com>                                     */
+/*                                                                            */
+/******************************************************************************/
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <string.h>
+
+/*
+ * Usage: file_time <filename> <atime|mtime|ctime> <sec|nsec>
+ */
+int main(int argc, char *argv[])
+{
+	time_t t;
+	struct stat st;
+
+	if (argc != 4) {
+		fprintf(stderr, "Wrong argument num!\n");
+		return 1;
+	}
+
+	if (stat(argv[1], &st) != 0) {
+		perror("stat failed");
+		return 1;
+	}
+
+	if (strcmp(argv[3], "sec") == 0) {
+		if (strcmp(argv[2], "atime") == 0)
+			t = st.st_atime;
+		else if (strcmp(argv[2], "mtime") == 0)
+			t = st.st_mtime;
+		else
+			t = st.st_ctime;
+	} else if (strcmp(argv[3], "nsec") == 0) {
+		if (strcmp(argv[2], "atime") == 0)
+			t = st.st_atim.tv_nsec;
+		else if (strcmp(argv[2], "mtime") == 0)
+			t = st.st_mtim.tv_nsec;
+		else
+			t = st.st_ctim.tv_nsec;
+	} else {
+		fprintf(stderr, "Wrong argument: %s\n", argv[3]);
+		return 1;
+	}
+
+	printf("%lu\n", t);
+
+	return 0;
+}
+
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
new file mode 100644
index 0000000..ad7729e
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
@@ -0,0 +1,196 @@
+#!/bin/bash
+
+################################################################################
+##                                                                            ##
+## Copyright (c) 2009 FUJITSU LIMITED                                         ##
+##                                                                            ##
+## This program is free software;  you can redistribute it and#or modify      ##
+## it under the terms of the GNU General Public License as published by       ##
+## the Free Software Foundation; either version 2 of the License, or          ##
+## (at your option) any later version.                                        ##
+##                                                                            ##
+## This program is distributed in the hope that it will be useful, but        ##
+## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
+## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
+## for more details.                                                          ##
+##                                                                            ##
+## You should have received a copy of the GNU General Public License          ##
+## along with this program;  if not, write to the Free Software               ##
+## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
+##                                                                            ##
+## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
+##         Miao Xie <miaox@cn.fujitsu.com>                                    ##
+##                                                                            ##
+################################################################################
+
+cd $LTPROOT/testcases/bin
+
+. ./ext4_funcs.sh
+
+export TCID="ext4-nsec-timestamps"
+export TST_TOTAL=2
+export TST_COUNT=1
+
+# $1: the test config
+read_config $1
+
+TEST_DIR=$PWD
+
+# Test that file timestamps is second with 128 inode size
+ext4_test_sec_timestamps()
+{
+	tst_resm TINFO "Test timestamps with 128 inode size"
+
+	mkfs.ext4 -I 128 $EXT4_DEV > /dev/null
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "failed to create ext4 filesystem"
+		return 1
+	fi
+
+	tune2fs -E test_fs -O extents $EXT4_DEV
+
+	mount -t ext4 $EXT4_DEV mnt_point
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "failed to mount ext4 filesystem"
+		return 1
+	fi
+
+	touch mnt_point/tmp_file
+
+	atime=`./ext4_file_time mnt_point/tmp_file atime nsec`
+	mtime=`./ext4_file_time mnt_point/tmp_file mtime nsec`
+	ctime=`./ext4_file_time mnt_point/tmp_file ctime nsec`
+
+	if [ $atime -ne 0 -o $mtime -ne 0 -o $ctime -ne 0 ]; then
+		tst_resm TFAIL "Timestamp is not second(atime: $atime, mtime: \
+				$mtime, ctime: $ctime)"
+		umount mnt_point
+		return 1
+	fi
+
+	umount mnt_point
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "failed to umount ext4 filesystem"
+		return 1
+	fi
+
+	tst_resm TPASS "Ext4 nanosecond timestamps test with 128 inode size pass"
+}
+
+# Test file timestamps is nanosecond with 256 inode size
+ext4_test_nsec_timestamps()
+{
+	tst_resm TINFO "Test timestamps with 256 inode size"
+
+	mkfs.ext3 -I 256 $EXT4_DEV > /dev/null
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "failed to create ext4 filesystem"
+		return 1
+	fi
+
+	tune2fs -E test_fs $EXT4_DEV
+
+	mount -t ext4 $EXT4_DEV mnt_point
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "failed to mount ext4 filesystem"
+		return 1
+	fi
+
+	# Create file
+	touch mnt_point/tmp_file
+	sleep 1
+
+	# Change atime, ctime and mtime of the file
+	touch mnt_point/tmp_file
+
+	cur_time=`date '+%s %N'`
+	sec=`echo $cur_time | awk {'print $1'}`
+	nsec=`echo $cur_time | awk {'print $2'}`
+
+	sec_atime=`./ext4_file_time mnt_point/tmp_file atime sec`
+	sec_mtime=`./ext4_file_time mnt_point/tmp_file mtime sec`
+	sec_ctime=`./ext4_file_time mnt_point/tmp_file ctime sec`
+	nsec_atime=`./ext4_file_time mnt_point/tmp_file atime nsec`
+	nsec_mtime=`./ext4_file_time mnt_point/tmp_file mtime nsec`
+	nsec_ctime=`./ext4_file_time mnt_point/tmp_file ctime nsec`
+
+	# Test nanosecond
+	if [ $nsec_atime -eq 0 -a $nsec_mtime -eq 0 -a $nsec_ctime -eq 0 ]
+	then
+		tst_resm TFAIL "The timestamp is not nanosecond(nsec_atime: $nsec_atime, nsec_mtime: $nsec_mtime, nsec_ctime: $nsec_ctime)"
+		umount mnt_point
+		return 1
+	fi
+
+	diff1=$(( $sec_atime - $sec ))
+	diff2=$(( $sec_mtime - $sec ))
+	diff3=$(( $sec_ctime - $sec ))
+
+	# Test difference between file time and current time
+	if [ $diff1 -gt 1 -o $diff2 -gt 1 -o $diff2 -gt 1 ]; then
+		tst_resm TFAIL "The timestamp is wrong, it must be earlier \
+			than the current time we got.(sec_atime: $sec_atime, \
+			sec_mtime: $sec_mtime, sec_ctime: $sec_ctime, \
+			cur_time[s]: $sec)"
+		umount mnt_point
+		return 1
+	fi
+
+	umount mnt_point
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "failed to umount ext4 filesystem"
+		return 1
+	fi
+
+	# Test mount to ext3 and then mount back to ext4
+	mount -t ext3 $EXT4_DEV mnt_point
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "failed to mount to ext3"
+		return 1
+	fi
+	umount mnt_point
+
+	mount -t ext4 $EXT4_DEV mnt_point
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "failed to mount back to ext4"
+		return 1
+	fi
+
+	nsec_atime2=`./ext4_file_time mnt_point/tmp_file atime nsec`
+	nsec_mtime2=`./ext4_file_time mnt_point/tmp_file mtime nsec`
+	nsec_ctime2=`./ext4_file_time mnt_point/tmp_file mtime nsec`
+
+	if [ $nsec_atime -ne $nsec_atime2 -o $nsec_ctime -ne $nsec_ctime2 -o \
+	     $nsec_mtime -ne $nsec_mtime2 ]; then
+		tst_resm TFAIL "File nanosecond timestamp has changed \
+			unexpected. Before[atime mtime ctime]: $nsec_atime \
+			$nsec_mtime $nsec_ctime, After[atime mtime ctime]: \
+			$nsec_atime2 $nsec_mtime2 $nsec_ctime2)"
+		umount mnt_point
+		return 1
+	fi
+
+	umount mnt_point
+	tst_resm TPASS "Ext4 nanosecond timestamps test with 256 inode size pass"
+}
+
+# main
+ext4_setup
+
+RET=0
+
+ext4_test_sec_timestamps
+if [$? -ne 0 ]; then
+	RET=1
+fi
+: $((TST_COUNT++))
+
+ext4_test_nsec_timestamps
+if [$? -ne 0 ]; then
+	RET=1
+fi
+: $((TST_COUNT++))
+
+ext4_cleanup
+exit $RET
+
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-online-defrag/Makefile b/testcases/kernel/fs/ext4-new-features/ext4-online-defrag/Makefile
new file mode 100644
index 0000000..0ea5e90
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ext4-online-defrag/Makefile
@@ -0,0 +1,18 @@
+CFLAGS += -Wall -g -Wextra
+LDLIBS += -lm
+
+SRCS=$(wildcard *.c)
+OBJECTS=$(patsubst %.c,%.o,$(SRCS))
+TARGETS=$(patsubst %.c,%,$(SRCS))
+
+all: $(TARGETS)
+
+install:
+	@set -e;
+	for i in $(TARGETS); do ln -f $$i ../../../../bin/$$i; chmod +x $$i; done;
+	ln -f ext4_online_defrag_test.sh ../../../../bin/ext4_online_defrag_test.sh;
+	chmod +x ext4_online_defrag_test.sh
+
+clean:
+	rm -rf $(TARGETS) $(OBJECTS)
+
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-online-defrag/e4defrag.c b/testcases/kernel/fs/ext4-new-features/ext4-online-defrag/e4defrag.c
new file mode 100644
index 0000000..05d6893
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ext4-online-defrag/e4defrag.c
@@ -0,0 +1,2171 @@
+/*
+ * e4defrag.c - ext4 filesystem defragmenter
+ *
+ * Copyright (C) 2009 NEC Software Tohoku, Ltd.
+ *
+ * Author: Akira Fujita	<a-fujita@rs.jp.nec.com>
+ *         Takashi Sato	<t-sato@yk.jp.nec.com>
+ */
+
+#ifndef _LARGEFILE_SOURCE
+#define _LARGEFILE_SOURCE
+#endif
+
+#ifndef _LARGEFILE64_SOURCE
+#define _LARGEFILE64_SOURCE
+#endif
+
+#define _XOPEN_SOURCE	500
+#define _GNU_SOURCE
+#include <ctype.h>
+#include <dirent.h>
+#include <endian.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <ftw.h>
+#include <limits.h>
+#include <mntent.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <ext2fs/ext2_types.h>
+#include <ext2fs/ext2fs.h>
+#include <linux/fs.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <sys/statfs.h>
+#include <sys/syscall.h>
+#include <sys/vfs.h>
+
+/* Ioctl command */
+#define FS_IOC_FIEMAP		_IOWR('f', 11, struct fiemap)
+#define EXT4_IOC_MOVE_EXT	_IOWR('f', 15, struct move_extent)
+
+/* Macro functions */
+#define PRINT_ERR_MSG(msg)	fprintf(stderr, "%s\n", (msg))
+#define IN_FTW_PRINT_ERR_MSG(msg)	\
+	fprintf(stderr, "\t%s\t\t[ NG ]\n", (msg))
+#define PRINT_FILE_NAME(file)	fprintf(stderr, " \"%s\"\n", (file))
+#define PRINT_ERR_MSG_WITH_ERRNO(msg)	\
+	fprintf(stderr, "\t%s:%s\t[ NG ]\n", (msg), strerror(errno))
+#define STATISTIC_ERR_MSG(msg)	\
+	fprintf(stderr, "\t%s\n", (msg))
+#define STATISTIC_ERR_MSG_WITH_ERRNO(msg)	\
+	fprintf(stderr, "\t%s:%s\n", (msg), strerror(errno))
+#define min(x, y) (((x) > (y)) ? (y) : (x))
+#define SECTOR_TO_BLOCK(sectors, blocksize) \
+	((sectors) / ((blocksize) >> 9))
+#define CALC_SCORE(ratio) \
+	((ratio) > 10 ? (80 + 20 * (ratio) / 100) : (8 * (ratio)))
+/* Wrap up the free function */
+#define FREE(tmp)				\
+	do {					\
+		if ((tmp) != NULL)		\
+			free(tmp);		\
+	} while (0)				\
+/* Insert list2 after list1 */
+#define insert(list1, list2)			\
+	do {					\
+		list2->next = list1->next;	\
+		list1->next->prev = list2;	\
+		list2->prev = list1;		\
+		list1->next = list2;		\
+	} while (0)
+
+/* To delete unused warning */
+#ifdef __GNUC__
+#define EXT2FS_ATTR(x) __attribute__(x)
+#else
+#define EXT2FS_ATTR(x)
+#endif
+
+#ifndef __NR_fadvise64
+#define __NR_fadvise64		250
+#endif
+
+#ifndef __NR_sync_file_range
+#define __NR_sync_file_range	314
+#endif
+
+#ifndef __NR_fallocate
+#define __NR_fallocate		324
+#endif
+
+#ifndef POSIX_FADV_DONTNEED
+#if defined(__s390x__)
+#define POSIX_FADV_DONTNEED	6 /* Don't need these pages */
+#else
+#define POSIX_FADV_DONTNEED	4 /* Don't need these pages */
+#endif
+#endif
+
+#ifndef SYNC_FILE_RANGE_WAIT_BEFORE
+#define SYNC_FILE_RANGE_WAIT_BEFORE	1
+#endif
+#ifndef SYNC_FILE_RANGE_WRITE
+#define SYNC_FILE_RANGE_WRITE		2
+#endif
+#ifndef SYNC_FILE_RANGE_WAIT_AFTER
+#define SYNC_FILE_RANGE_WAIT_AFTER	4
+#endif
+
+/* The mode of defrag */
+#define DETAIL			0x01
+#define STATISTIC		0x02
+
+#define DEVNAME			0
+#define DIRNAME			1
+#define FILENAME		2
+
+#define FTW_OPEN_FD		2000
+
+#define FS_EXT4			"ext4"
+#define ROOT_UID		0
+
+#define BOUND_SCORE		55
+#define SHOW_FRAG_FILES	5
+
+/* Magic number for ext4 */
+#define EXT4_SUPER_MAGIC	0xEF53
+
+/* Definition of flex_bg */
+#define EXT4_FEATURE_INCOMPAT_FLEX_BG		0x0200
+
+/* The following four macros are used for ioctl FS_IOC_FIEMAP
+ * FIEMAP_FLAG_SYNC:	sync file data before map.
+ * FIEMAP_EXTENT_LAST:	last extent in file.
+ * FIEMAP_MAX_OFFSET:	max file offset.
+ * EXTENT_MAX_COUNT:	the maximum number of extents for exchanging between
+ *			kernel-space and user-space per ioctl
+ */
+#define FIEMAP_FLAG_SYNC	0x00000001
+#define FIEMAP_EXTENT_LAST	0x00000001
+#define FIEMAP_EXTENT_UNWRITTEN	0x00000800
+#define FIEMAP_MAX_OFFSET	(~0ULL)
+#define EXTENT_MAX_COUNT	512
+
+/* The following macros are error message */
+#define MSG_USAGE		\
+"Usage	: e4defrag [-v] file...| directory...| device...\n\
+	: e4defrag  -c  file...| directory...| device...\n"
+
+#define NGMSG_EXT4		"Filesystem is not ext4 filesystem"
+#define NGMSG_FILE_EXTENT	"Failed to get file extents"
+#define NGMSG_FILE_INFO		"Failed to get file information"
+#define NGMSG_FILE_OPEN		"Failed to open"
+#define NGMSG_FILE_UNREG	"File is not regular file"
+#define NGMSG_LOST_FOUND	"Can not process \"lost+found\""
+
+/* Data type for filesystem-wide blocks number */
+typedef unsigned long long ext4_fsblk_t;
+
+struct fiemap_extent_data {
+	__u64 len;			/* blocks count */
+	__u64 logical;		/* start logical block number */
+	ext4_fsblk_t physical;		/* start physical block number */
+};
+
+struct fiemap_extent_list {
+	struct fiemap_extent_list *prev;
+	struct fiemap_extent_list *next;
+	struct fiemap_extent_data data;	/* extent belong to file */
+};
+
+struct fiemap_extent_group {
+	struct fiemap_extent_group *prev;
+	struct fiemap_extent_group *next;
+	__u64 len;	/* length of this continuous region */
+	struct fiemap_extent_list *start;	/* start ext */
+	struct fiemap_extent_list *end;		/* end ext */
+};
+
+struct move_extent {
+	__s32 reserved;	/* original file descriptor */
+	__u32 donor_fd;	/* donor file descriptor */
+	__u64 orig_start;	/* logical start offset in block for orig */
+	__u64 donor_start;	/* logical start offset in block for donor */
+	__u64 len;	/* block length to be moved */
+	__u64 moved_len;	/* moved block length */
+};
+
+struct fiemap_extent {
+	__u64 fe_logical;	/* logical offset in bytes for the start of
+				* the extent from the beginning of the file */
+	__u64 fe_physical;	/* physical offset in bytes for the start
+				* of the extent from the beginning
+				* of the disk */
+	__u64 fe_length;	/* length in bytes for this extent */
+	__u64 fe_reserved64[2];
+	__u32 fe_flags;    	/* FIEMAP_EXTENT_* flags for this extent */
+	__u32 fe_reserved[3];
+};
+
+struct fiemap {
+	__u64 fm_start;		/* logical offset (inclusive) at
+				* which to start mapping (in) */
+	__u64 fm_length;	/* logical length of mapping which
+				* userspace wants (in) */
+	__u32 fm_flags;		/* FIEMAP_FLAG_* flags for request (in/out) */
+	__u32 fm_mapped_extents;/* number of extents that were mapped (out) */
+	__u32 fm_extent_count;	/* size of fm_extents array (in) */
+	__u32 fm_reserved;
+	struct fiemap_extent fm_extents[0];/* array of mapped extents (out) */
+};
+
+struct frag_statistic_ino {
+	int now_count;	/* the file's extents count of before defrag */
+	int best_count; /* the best file's extents count */
+	float ratio;	/* the ratio of fragmentation */
+	char msg_buffer[PATH_MAX + 1];	/* pathname of the file */
+};
+
+typedef __u16 __le16;
+typedef __u32 __le32;
+typedef __u64 __le64;
+
+/*
+ * Structure of the super block
+ */
+struct ext4_super_block {
+/*00*/	__le32	s_inodes_count;		/* Inodes count */
+	__le32	s_blocks_count_lo;	/* Blocks count */
+	__le32	s_r_blocks_count_lo;	/* Reserved blocks count */
+	__le32	s_free_blocks_count_lo;	/* Free blocks count */
+/*10*/	__le32	s_free_inodes_count;	/* Free inodes count */
+	__le32	s_first_data_block;	/* First Data Block */
+	__le32	s_log_block_size;	/* Block size */
+	__le32	s_obso_log_frag_size;	/* Obsoleted fragment size */
+/*20*/	__le32	s_blocks_per_group;	/* # Blocks per group */
+	__le32	s_obso_frags_per_group;	/* Obsoleted fragments per group */
+	__le32	s_inodes_per_group;	/* # Inodes per group */
+	__le32	s_mtime;		/* Mount time */
+/*30*/	__le32	s_wtime;		/* Write time */
+	__le16	s_mnt_count;		/* Mount count */
+	__le16	s_max_mnt_count;	/* Maximal mount count */
+	__le16	s_magic;		/* Magic signature */
+	__le16	s_state;		/* File system state */
+	__le16	s_errors;		/* Behaviour when detecting errors */
+	__le16	s_minor_rev_level;	/* minor revision level */
+/*40*/	__le32	s_lastcheck;		/* time of last check */
+	__le32	s_checkinterval;	/* max. time between checks */
+	__le32	s_creator_os;		/* OS */
+	__le32	s_rev_level;		/* Revision level */
+/*50*/	__le16	s_def_resuid;		/* Default uid for reserved blocks */
+	__le16	s_def_resgid;		/* Default gid for reserved blocks */
+	/*
+	 * These fields are for EXT4_DYNAMIC_REV superblocks only.
+	 *
+	 * Note: the difference between the compatible feature set and
+	 * the incompatible feature set is that if there is a bit set
+	 * in the incompatible feature set that the kernel doesn't
+	 * know about, it should refuse to mount the filesystem.
+	 *
+	 * e2fsck's requirements are more strict; if it doesn't know
+	 * about a feature in either the compatible or incompatible
+	 * feature set, it must abort and not try to meddle with
+	 * things it doesn't understand...
+	 */
+	__le32	s_first_ino;		/* First non-reserved inode */
+	__le16  s_inode_size;		/* size of inode structure */
+	__le16	s_block_group_nr;	/* block group # of this superblock */
+	__le32	s_feature_compat;	/* compatible feature set */
+/*60*/	__le32	s_feature_incompat;	/* incompatible feature set */
+	__le32	s_feature_ro_compat;	/* readonly-compatible feature set */
+/*68*/	__u8	s_uuid[16];		/* 128-bit uuid for volume */
+/*78*/	char	s_volume_name[16];	/* volume name */
+/*88*/	char	s_last_mounted[64];	/* directory where last mounted */
+/*C8*/	__le32	s_algorithm_usage_bitmap; /* For compression */
+	/*
+	 * Performance hints.  Directory preallocation should only
+	 * happen if the EXT4_FEATURE_COMPAT_DIR_PREALLOC flag is on.
+	 */
+	__u8	s_prealloc_blocks;	/* Nr of blocks to try to preallocate*/
+	__u8	s_prealloc_dir_blocks;	/* Nr to preallocate for dirs */
+	__le16	s_reserved_gdt_blocks;	/* Per group desc for online growth */
+	/*
+	 * Journaling support valid if EXT4_FEATURE_COMPAT_HAS_JOURNAL set.
+	 */
+/*D0*/	__u8	s_journal_uuid[16];	/* uuid of journal superblock */
+/*E0*/	__le32	s_journal_inum;		/* inode number of journal file */
+	__le32	s_journal_dev;		/* device number of journal file */
+	__le32	s_last_orphan;		/* start of list of inodes to delete */
+	__le32	s_hash_seed[4];		/* HTREE hash seed */
+	__u8	s_def_hash_version;	/* Default hash version to use */
+	__u8	s_reserved_char_pad;
+	__le16  s_desc_size;		/* size of group descriptor */
+/*100*/	__le32	s_default_mount_opts;
+	__le32	s_first_meta_bg;	/* First metablock block group */
+	__le32	s_mkfs_time;		/* When the filesystem was created */
+	__le32	s_jnl_blocks[17];	/* Backup of the journal inode */
+	/* 64bit support valid if EXT4_FEATURE_COMPAT_64BIT */
+/*150*/	__le32	s_blocks_count_hi;	/* Blocks count */
+	__le32	s_r_blocks_count_hi;	/* Reserved blocks count */
+	__le32	s_free_blocks_count_hi;	/* Free blocks count */
+	__le16	s_min_extra_isize;	/* All inodes have at least # bytes */
+	__le16	s_want_extra_isize; 	/* New inodes should reserve # bytes */
+	__le32	s_flags;		/* Miscellaneous flags */
+	__le16  s_raid_stride;		/* RAID stride */
+	__le16  s_mmp_interval;         /* # seconds to wait in MMP checking */
+	__le64  s_mmp_block;            /* Block for multi-mount protection */
+	__le32  s_raid_stripe_width;    /* blocks on all data disks (N*stride)*/
+	__u8	s_log_groups_per_flex;  /* FLEX_BG group size */
+	__u8	s_reserved_char_pad2;
+	__le16  s_reserved_pad;
+	__u32   s_reserved[162];        /* Padding to the end of the block */
+};
+
+char	lost_found_dir[PATH_MAX + 1];
+int	block_size;
+int	extents_before_defrag;
+int	extents_after_defrag;
+int	mode_flag;
+unsigned int	current_uid;
+unsigned int	defraged_file_count;
+unsigned int	frag_files_before_defrag;
+unsigned int	frag_files_after_defrag;
+unsigned int	regular_count;
+unsigned int	succeed_cnt;
+unsigned int	total_count;
+__u8 log_groups_per_flex;
+__le32 blocks_per_group;
+__le32 feature_incompat;
+ext4_fsblk_t	files_block_count;
+struct frag_statistic_ino	frag_rank[SHOW_FRAG_FILES];
+
+/*
+ * ext2fs_swab32() -	Change endian.
+ *
+ * @val:		the entry used for change.
+ */
+__u32 ext2fs_swab32(__u32 val)
+{
+#if BYTE_ORDER == BIG_ENDIAN
+	return (val >> 24) | ((val >> 8) & 0xFF00) |
+		((val << 8) & 0xFF0000) | (val << 24);
+#else
+	return val;
+#endif
+}
+
+/*
+ * fadvise() -		Give advice about file access.
+ *
+ * @fd:			defrag target file's descriptor.
+ * @offset:		file offset.
+ * @len:		area length.
+ * @advise:		process flag.
+ */
+int fadvise(int fd, loff_t offset, size_t len, int advise)
+{
+	return syscall(__NR_fadvise64, fd, offset, len, advise);
+}
+
+/*
+ * sync_file_range() -	Sync file region.
+ *
+ * @fd:			defrag target file's descriptor.
+ * @offset:		file offset.
+ * @length:		area length.
+ * @flag:		process flag.
+ */
+int sync_file_range(int fd, loff_t offset, loff_t length, unsigned int flag)
+{
+	return syscall(__NR_sync_file_range, fd, offset, length, flag);
+}
+
+/*
+ * fallocate() -	Manipulate file space.
+ *
+ * @fd:			defrag target file's descriptor.
+ * @mode:		process flag.
+ * @offset:		file offset.
+ * @len:		file size.
+ */
+int fallocate(int fd, int mode, loff_t offset, loff_t len)
+{
+	return syscall(__NR_fallocate, fd, mode, offset, len);
+}
+
+/*
+ * get_mount_point() -	Get device's mount point.
+ *
+ * @devname:		the device's name.
+ * @mount_point:	the mount point.
+ * @dir_path_len:	the length of directory.
+ */
+int get_mount_point(const char *devname, char *mount_point, int dir_path_len)
+{
+	/* Refer to /etc/mtab */
+	char	*mtab = MOUNTED;
+	FILE	*fp = NULL;
+	struct mntent	*mnt = NULL;
+
+	fp = setmntent(mtab, "r");
+	if (fp == NULL) {
+		perror("Couldn't access /etc/mtab");
+		return -1;
+	}
+
+	while ((mnt = getmntent(fp)) != NULL) {
+		if (strcmp(devname, mnt->mnt_fsname) != 0)
+			continue;
+
+		endmntent(fp);
+		if (strcmp(mnt->mnt_type, FS_EXT4) == 0) {
+			strncpy(mount_point, mnt->mnt_dir,
+				dir_path_len);
+			return 0;
+		}
+		PRINT_ERR_MSG(NGMSG_EXT4);
+		return -1;
+	}
+	endmntent(fp);
+	PRINT_ERR_MSG("Filesystem is not mounted");
+	return -1;
+}
+
+/*
+ * is_ext4() -		Whether on an ext4 filesystem.
+ *
+ * @file:		the file's name.
+ */
+int is_ext4(const char *file)
+{
+	int 	maxlen = 0;
+	int	len, ret;
+	FILE	*fp = NULL;
+	char	*mnt_type = NULL;
+	/* Refer to /etc/mtab */
+	char	*mtab = MOUNTED;
+	char	file_path[PATH_MAX + 1];
+	struct mntent	*mnt = NULL;
+	struct statfs64	fsbuf;
+
+	/* Get full path */
+	if (realpath(file, file_path) == NULL) {
+		perror("Couldn't get full path");
+		PRINT_FILE_NAME(file);
+		return -1;
+	}
+
+	if (statfs64(file_path, &fsbuf) < 0) {
+		perror("Failed to get filesystem information");
+		PRINT_FILE_NAME(file);
+		return -1;
+	}
+
+	if (fsbuf.f_type != EXT4_SUPER_MAGIC) {
+		PRINT_ERR_MSG(NGMSG_EXT4);
+		return -1;
+	}
+
+	fp = setmntent(mtab, "r");
+	if (fp == NULL) {
+		perror("Couldn't access /etc/mtab");
+		return -1;
+	}
+
+	while ((mnt = getmntent(fp)) != NULL) {
+		len = strlen(mnt->mnt_dir);
+		ret = memcmp(file_path, mnt->mnt_dir, len);
+		if (ret != 0)
+			continue;
+
+		if (maxlen >= len)
+			continue;
+
+		maxlen = len;
+
+		mnt_type = realloc(mnt_type, strlen(mnt->mnt_type) + 1);
+		if (mnt_type == NULL) {
+			endmntent(fp);
+			return -1;
+		}
+		memset(mnt_type, 0, strlen(mnt->mnt_type) + 1);
+		strncpy(mnt_type, mnt->mnt_type, strlen(mnt->mnt_type));
+		strncpy(lost_found_dir, mnt->mnt_dir, PATH_MAX);
+	}
+
+	endmntent(fp);
+	if (strcmp(mnt_type, FS_EXT4) == 0) {
+		FREE(mnt_type);
+		return 0;
+	} else {
+		FREE(mnt_type);
+		PRINT_ERR_MSG(NGMSG_EXT4);
+		return -1;
+	}
+}
+
+/*
+ * calc_entry_counts() -	Calculate file counts.
+ *
+ * @file:		file name.
+ * @buf:		file info.
+ * @flag:		file type.
+ * @ftwbuf:		the pointer of a struct FTW.
+ */
+int calc_entry_counts(const char *file EXT2FS_ATTR((unused)),
+		const struct stat64 *buf, int flag EXT2FS_ATTR((unused)),
+		struct FTW *ftwbuf EXT2FS_ATTR((unused)))
+{
+	if (S_ISREG(buf->st_mode))
+		regular_count++;
+
+	total_count++;
+
+	return 0;
+}
+
+/*
+ * page_in_core() -	Get information on whether pages are in core.
+ *
+ * @fd:			defrag target file's descriptor.
+ * @defrag_data:	data used for defrag.
+ * @vec:		page state array.
+ * @page_num:		page number.
+ */
+int page_in_core(int fd, struct move_extent defrag_data,
+			unsigned char **vec, unsigned int *page_num)
+{
+	long	pagesize = sysconf(_SC_PAGESIZE);
+	void	*page = NULL;
+	loff_t	offset, end_offset, length;
+
+	if (vec == NULL || *vec != NULL)
+		return -1;
+
+	/* In mmap, offset should be a multiple of the page size */
+	offset = (loff_t)defrag_data.orig_start * block_size;
+	length = (loff_t)defrag_data.len * block_size;
+	end_offset = offset + length;
+	/* Round the offset down to the nearest multiple of pagesize */
+	offset = (offset / pagesize) * pagesize;
+	length = end_offset - offset;
+
+	page = mmap(NULL, length, PROT_READ, MAP_SHARED, fd, offset);
+	if (page == MAP_FAILED)
+		return -1;
+
+	*page_num = 0;
+	*page_num = (length + pagesize - 1) / pagesize;
+	*vec = (unsigned char *)calloc(*page_num, 1);
+	if (*vec == NULL)
+		return -1;
+
+	/* Get information on whether pages are in core */
+	if (mincore(page, (size_t)length, *vec) == -1 ||
+		munmap(page, length) == -1) {
+		FREE(*vec);
+		return -1;
+	}
+
+	return 0;
+}
+
+/*
+ * defrag_fadvise() -	Predeclare an access pattern for file data.
+ *
+ * @fd:			defrag target file's descriptor.
+ * @defrag_data:	data used for defrag.
+ * @vec:		page state array.
+ * @page_num:		page number.
+ */
+int defrag_fadvise(int fd, struct move_extent defrag_data,
+		   unsigned char *vec, unsigned int page_num)
+{
+	int	flag = 1;
+	long	pagesize = sysconf(_SC_PAGESIZE);
+	int	fadvise_flag = POSIX_FADV_DONTNEED;
+	int	sync_flag = SYNC_FILE_RANGE_WAIT_BEFORE |
+			    SYNC_FILE_RANGE_WRITE |
+			    SYNC_FILE_RANGE_WAIT_AFTER;
+	unsigned int	i;
+	loff_t	offset;
+
+	offset = (loff_t)defrag_data.orig_start * block_size;
+	offset = (offset / pagesize) * pagesize;
+
+	/* Sync file for fadvise process */
+	if (sync_file_range(fd, offset,
+		(loff_t)pagesize * page_num, sync_flag) < 0)
+		return -1;
+
+	/* Try to release buffer cache which this process used,
+	 * then other process can use the released buffer
+	 */
+	for (i = 0; i < page_num; i++) {
+		if ((vec[i] & 0x1) == 0) {
+			offset += pagesize;
+			continue;
+		}
+		if (fadvise(fd, offset, pagesize, fadvise_flag) < 0) {
+			if ((mode_flag & DETAIL) && flag) {
+				perror("\tFailed to fadvise");
+				flag = 0;
+			}
+		}
+		offset += pagesize;
+	}
+
+	return 0;
+}
+
+/*
+ * check_free_size() -	Check if there's enough disk space.
+ *
+ * @fd:			defrag target file's descriptor.
+ * @file:		file name.
+ * @buf:		the pointer of the struct stat64.
+ */
+int check_free_size(int fd, const char *file, const struct stat64 *buf)
+{
+	ext4_fsblk_t	blk_count;
+	ext4_fsblk_t	free_blk_count;
+	struct statfs64	fsbuf;
+
+	if (fstatfs64(fd, &fsbuf) < 0) {
+		if (mode_flag & DETAIL) {
+			PRINT_FILE_NAME(file);
+			PRINT_ERR_MSG_WITH_ERRNO(
+				"Failed to get filesystem information");
+		}
+		return -1;
+	}
+
+	/* Target file size measured by filesystem IO blocksize */
+	blk_count = SECTOR_TO_BLOCK(buf->st_blocks, fsbuf.f_bsize);
+
+	/* Compute free space for root and normal user separately */
+	if (current_uid == ROOT_UID)
+		free_blk_count = fsbuf.f_bfree;
+	else
+		free_blk_count = fsbuf.f_bavail;
+
+	if (free_blk_count >= blk_count)
+		return 0;
+
+	return -ENOSPC;
+}
+
+/*
+ * file_frag_count() -	Get file fragment count.
+ *
+ * @fd:			defrag target file's descriptor.
+ */
+int file_frag_count(int fd)
+{
+	int	ret;
+	struct fiemap	fiemap_buf;
+
+	/* When fm_extent_count is 0,
+	 * ioctl just get file fragment count.
+	 */
+	memset(&fiemap_buf, 0, sizeof(struct fiemap));
+	fiemap_buf.fm_start = 0;
+	fiemap_buf.fm_length = FIEMAP_MAX_OFFSET;
+	fiemap_buf.fm_flags |= FIEMAP_FLAG_SYNC;
+
+	ret = ioctl(fd, FS_IOC_FIEMAP, &fiemap_buf);
+	if (ret < 0)
+		return ret;
+
+	return fiemap_buf.fm_mapped_extents;
+}
+
+/*
+ * file_check() -	Check file's attributes.
+ *
+ * @fd:			defrag target file's descriptor.
+ * @buf:		a pointer of the struct stat64.
+ * @file:		the file's name.
+ * @extents:		the file's extents.
+ */
+int file_check(int fd, const struct stat64 *buf, const char *file,
+		int extents)
+{
+	int	ret;
+	struct flock	lock;
+
+	/* Write-lock check is more reliable */
+	lock.l_type = F_WRLCK;
+	lock.l_start = 0;
+	lock.l_whence = SEEK_SET;
+	lock.l_len = 0;
+
+	/* Free space */
+	ret = check_free_size(fd, file, buf);
+	if (ret < 0) {
+		if ((mode_flag & DETAIL) && ret == -ENOSPC) {
+			printf("\033[79;0H\033[K[%u/%u] \"%s\"\t\t"
+				"  extents: %d -> %d\n", defraged_file_count,
+				total_count, file, extents, extents);
+			IN_FTW_PRINT_ERR_MSG(
+			"Defrag size is larger than filesystem's free space");
+		}
+		return -1;
+	}
+
+	/* Access authority */
+	if (current_uid != ROOT_UID &&
+		buf->st_uid != current_uid) {
+		if (mode_flag & DETAIL) {
+			printf("\033[79;0H\033[K[%u/%u] \"%s\"\t\t"
+				"  extents: %d -> %d\n", defraged_file_count,
+				total_count, file, extents, extents);
+			IN_FTW_PRINT_ERR_MSG(
+				"File is not current user's file"
+				" or current user is not root");
+		}
+		return -1;
+	}
+
+	/* Lock status */
+	if (fcntl(fd, F_GETLK, &lock) < 0) {
+		if (mode_flag & DETAIL) {
+			PRINT_FILE_NAME(file);
+			PRINT_ERR_MSG_WITH_ERRNO(
+				"Failed to get lock information");
+		}
+		return -1;
+	} else if (lock.l_type != F_UNLCK) {
+		if (mode_flag & DETAIL) {
+			PRINT_FILE_NAME(file);
+			IN_FTW_PRINT_ERR_MSG("File has been locked");
+		}
+		return -1;
+	}
+
+	return 0;
+}
+
+/*
+ * insert_extent_by_logical() -	Sequentially insert extent by logical.
+ *
+ * @ext_list_head:	the head of logical extent list.
+ * @ext:		the extent element which will be inserted.
+ */
+int insert_extent_by_logical(struct fiemap_extent_list **ext_list_head,
+			struct fiemap_extent_list *ext)
+{
+	struct fiemap_extent_list	*ext_list_tmp = *ext_list_head;
+
+	if (ext == NULL)
+		goto out;
+
+	/* First element */
+	if (*ext_list_head == NULL) {
+		(*ext_list_head) = ext;
+		(*ext_list_head)->prev = *ext_list_head;
+		(*ext_list_head)->next = *ext_list_head;
+		return 0;
+	}
+
+	if (ext->data.logical <= ext_list_tmp->data.logical) {
+		/* Insert before head */
+		if (ext_list_tmp->data.logical <
+			ext->data.logical + ext->data.len)
+			/* Overlap */
+			goto out;
+		/* Adjust head */
+		*ext_list_head = ext;
+	} else {
+		/* Insert into the middle or last of the list */
+		do {
+			if (ext->data.logical < ext_list_tmp->data.logical)
+				break;
+			ext_list_tmp = ext_list_tmp->next;
+		} while (ext_list_tmp != (*ext_list_head));
+		if (ext->data.logical <
+		    ext_list_tmp->prev->data.logical +
+			ext_list_tmp->prev->data.len)
+			/* Overlap */
+			goto out;
+
+		if (ext_list_tmp != *ext_list_head &&
+		    ext_list_tmp->data.logical <
+		    ext->data.logical + ext->data.len)
+			/* Overlap */
+			goto out;
+	}
+	ext_list_tmp = ext_list_tmp->prev;
+	/* Insert "ext" after "ext_list_tmp" */
+	insert(ext_list_tmp, ext);
+	return 0;
+out:
+	errno = EINVAL;
+	return -1;
+}
+
+/*
+ * insert_extent_by_physical() -	Sequentially insert extent by physical.
+ *
+ * @ext_list_head:	the head of physical extent list.
+ * @ext:		the extent element which will be inserted.
+ */
+int insert_extent_by_physical(struct fiemap_extent_list **ext_list_head,
+			struct fiemap_extent_list *ext)
+{
+	struct fiemap_extent_list	*ext_list_tmp = *ext_list_head;
+
+	if (ext == NULL)
+		goto out;
+
+	/* First element */
+	if (*ext_list_head == NULL) {
+		(*ext_list_head) = ext;
+		(*ext_list_head)->prev = *ext_list_head;
+		(*ext_list_head)->next = *ext_list_head;
+		return 0;
+	}
+
+	if (ext->data.physical <= ext_list_tmp->data.physical) {
+		/* Insert before head */
+		if (ext_list_tmp->data.physical <
+					ext->data.physical + ext->data.len)
+			/* Overlap */
+			goto out;
+		/* Adjust head */
+		*ext_list_head = ext;
+	} else {
+		/* Insert into the middle or last of the list */
+		do {
+			if (ext->data.physical < ext_list_tmp->data.physical)
+				break;
+			ext_list_tmp = ext_list_tmp->next;
+		} while (ext_list_tmp != (*ext_list_head));
+		if (ext->data.physical <
+		    ext_list_tmp->prev->data.physical +
+				ext_list_tmp->prev->data.len)
+			/* Overlap */
+			goto out;
+
+		if (ext_list_tmp != *ext_list_head &&
+		    ext_list_tmp->data.physical <
+				ext->data.physical + ext->data.len)
+			/* Overlap */
+			goto out;
+	}
+	ext_list_tmp = ext_list_tmp->prev;
+	/* Insert "ext" after "ext_list_tmp" */
+	insert(ext_list_tmp, ext);
+	return 0;
+out:
+	errno = EINVAL;
+	return -1;
+}
+
+/*
+ * insert_exts_group() -	Insert a exts_group.
+ *
+ * @ext_group_head:		the head of a exts_group list.
+ * @exts_group:			the exts_group element which will be inserted.
+ */
+int insert_exts_group(struct fiemap_extent_group **ext_group_head,
+				struct fiemap_extent_group *exts_group)
+{
+	struct fiemap_extent_group	*ext_group_tmp = NULL;
+
+	if (exts_group == NULL) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	/* Initialize list */
+	if (*ext_group_head == NULL) {
+		(*ext_group_head) = exts_group;
+		(*ext_group_head)->prev = *ext_group_head;
+		(*ext_group_head)->next = *ext_group_head;
+		return 0;
+	}
+
+	ext_group_tmp = (*ext_group_head)->prev;
+	insert(ext_group_tmp, exts_group);
+
+	return 0;
+}
+
+/*
+ * join_extents() -		Find continuous region(exts_group).
+ *
+ * @ext_list_head:		the head of the extent list.
+ * @ext_group_head:		the head of the target exts_group list.
+ */
+int join_extents(struct fiemap_extent_list *ext_list_head,
+		struct fiemap_extent_group **ext_group_head)
+{
+	__u64	len = ext_list_head->data.len;
+	struct fiemap_extent_list *ext_list_start = ext_list_head;
+	struct fiemap_extent_list *ext_list_tmp = ext_list_head->next;
+
+	do {
+		struct fiemap_extent_group	*ext_group_tmp = NULL;
+
+		/* This extent and previous extent are not continuous,
+		 * so, all previous extents are treated as an extent group.
+		 */
+		if ((ext_list_tmp->prev->data.logical +
+			ext_list_tmp->prev->data.len)
+				!= ext_list_tmp->data.logical) {
+			ext_group_tmp =
+				malloc(sizeof(struct fiemap_extent_group));
+			if (ext_group_tmp == NULL)
+				return -1;
+
+			memset(ext_group_tmp, 0,
+				sizeof(struct fiemap_extent_group));
+			ext_group_tmp->len = len;
+			ext_group_tmp->start = ext_list_start;
+			ext_group_tmp->end = ext_list_tmp->prev;
+
+			if (insert_exts_group(ext_group_head,
+				ext_group_tmp) < 0) {
+				FREE(ext_group_tmp);
+				return -1;
+			}
+			ext_list_start = ext_list_tmp;
+			len = ext_list_tmp->data.len;
+			ext_list_tmp = ext_list_tmp->next;
+			continue;
+		}
+
+		/* This extent and previous extent are continuous,
+		 * so, they belong to the same extent group, and we check
+		 * if the next extent belongs to the same extent group.
+		 */
+		len += ext_list_tmp->data.len;
+		ext_list_tmp = ext_list_tmp->next;
+	} while (ext_list_tmp != ext_list_head->next);
+
+	return 0;
+}
+
+/*
+ * get_file_extents() -	Get file's extent list.
+ *
+ * @fd:			defrag target file's descriptor.
+ * @ext_list_head:	the head of the extent list.
+ */
+int get_file_extents(int fd, struct fiemap_extent_list **ext_list_head)
+{
+	__u32	i;
+	int	ret;
+	int	ext_buf_size, fie_buf_size;
+	__u64	pos = 0;
+	struct fiemap	*fiemap_buf = NULL;
+	struct fiemap_extent	*ext_buf = NULL;
+	struct fiemap_extent_list	*ext_list = NULL;
+
+	/* Convert units, in bytes.
+	 * Be careful : now, physical block number in extent is 48bit,
+	 * and the maximum blocksize for ext4 is 4K(12bit),
+	 * so there is no overflow, but in future it may be changed.
+	 */
+
+	/* Alloc space for fiemap */
+	ext_buf_size = EXTENT_MAX_COUNT * sizeof(struct fiemap_extent);
+	fie_buf_size = sizeof(struct fiemap) + ext_buf_size;
+
+	fiemap_buf = malloc(fie_buf_size);
+	if (fiemap_buf == NULL)
+		return -1;
+
+	ext_buf = fiemap_buf->fm_extents;
+	memset(fiemap_buf, 0, fie_buf_size);
+	fiemap_buf->fm_length = FIEMAP_MAX_OFFSET;
+	fiemap_buf->fm_flags |= FIEMAP_FLAG_SYNC;
+	fiemap_buf->fm_extent_count = EXTENT_MAX_COUNT;
+
+	do {
+		fiemap_buf->fm_start = pos;
+		memset(ext_buf, 0, ext_buf_size);
+		ret = ioctl(fd, FS_IOC_FIEMAP, fiemap_buf);
+		if (ret < 0)
+			goto out;
+		for (i = 0; i < fiemap_buf->fm_mapped_extents; i++) {
+			ext_list = NULL;
+			ext_list = malloc(sizeof(struct fiemap_extent_list));
+			if (ext_list == NULL)
+				goto out;
+
+			ext_list->data.physical = ext_buf[i].fe_physical
+						/ block_size;
+			ext_list->data.logical = ext_buf[i].fe_logical
+						/ block_size;
+			ext_list->data.len = ext_buf[i].fe_length
+						/ block_size;
+
+			ret = insert_extent_by_physical(
+					ext_list_head, ext_list);
+			if (ret < 0) {
+				FREE(ext_list);
+				goto out;
+			}
+		}
+		/* Record file's logical offset this time */
+		pos = ext_buf[EXTENT_MAX_COUNT-1].fe_logical +
+			ext_buf[EXTENT_MAX_COUNT-1].fe_length;
+		/*
+		 * If fm_extents array has been filled and
+		 * there are extents left, continue to cycle.
+		 */
+	} while (fiemap_buf->fm_mapped_extents
+					== EXTENT_MAX_COUNT &&
+		!(ext_buf[EXTENT_MAX_COUNT-1].fe_flags
+					& FIEMAP_EXTENT_LAST));
+
+	FREE(fiemap_buf);
+	return 0;
+out:
+	FREE(fiemap_buf);
+	return -1;
+}
+
+/*
+ * get_logical_count() -	Get the file logical extents count.
+ *
+ * @logical_list_head:	the head of the logical extent list.
+ */
+int get_logical_count(struct fiemap_extent_list *logical_list_head)
+{
+	int ret = 0;
+	struct fiemap_extent_list *ext_list_tmp  = logical_list_head;
+
+	do {
+		ret++;
+		ext_list_tmp = ext_list_tmp->next;
+	} while (ext_list_tmp != logical_list_head);
+
+	return ret;
+}
+
+/*
+ * get_physical_count() -	Get the file physical extents count.
+ *
+ * @physical_list_head:	the head of the physical extent list.
+ */
+int get_physical_count(struct fiemap_extent_list *physical_list_head)
+{
+	int ret = 0;
+	struct fiemap_extent_list *ext_list_tmp = physical_list_head;
+
+	do {
+		if ((ext_list_tmp->data.physical + ext_list_tmp->data.len)
+				!= ext_list_tmp->next->data.physical) {
+			/* This extent and next extent are not continuous. */
+			ret++;
+		}
+
+		ext_list_tmp = ext_list_tmp->next;
+	} while (ext_list_tmp != physical_list_head);
+
+	return ret;
+}
+
+/*
+ * change_physical_to_logical() -	Change list from physical to logical.
+ *
+ * @physical_list_head:	the head of physical extent list.
+ * @logical_list_head:	the head of logical extent list.
+ */
+int change_physical_to_logical(struct fiemap_extent_list **physical_list_head,
+				struct fiemap_extent_list **logical_list_head)
+{
+	int ret;
+	struct fiemap_extent_list *ext_list_tmp = *physical_list_head;
+	struct fiemap_extent_list *ext_list_next = ext_list_tmp->next;
+
+	while (1) {
+		if (ext_list_tmp == ext_list_next) {
+			ret = insert_extent_by_logical(
+				logical_list_head, ext_list_tmp);
+			if (ret < 0)
+				return -1;
+
+			*physical_list_head = NULL;
+			break;
+		}
+
+		ext_list_tmp->prev->next = ext_list_tmp->next;
+		ext_list_tmp->next->prev = ext_list_tmp->prev;
+		*physical_list_head = ext_list_next;
+
+		ret = insert_extent_by_logical(
+			logical_list_head, ext_list_tmp);
+		if (ret < 0) {
+			FREE(ext_list_tmp);
+			return -1;
+		}
+		ext_list_tmp = ext_list_next;
+		ext_list_next = ext_list_next->next;
+	}
+
+	return 0;
+}
+
+/*
+ * free_ext() -		Free the extent list.
+ *
+ * @ext_list_head:	the extent list head of which will be free.
+ */
+void free_ext(struct fiemap_extent_list *ext_list_head)
+{
+	struct fiemap_extent_list	*ext_list_tmp = NULL;
+
+	if (ext_list_head == NULL)
+		return;
+
+	while (ext_list_head->next != ext_list_head) {
+		ext_list_tmp = ext_list_head;
+		ext_list_head->prev->next = ext_list_head->next;
+		ext_list_head->next->prev = ext_list_head->prev;
+		ext_list_head = ext_list_head->next;
+		free(ext_list_tmp);
+	}
+	free(ext_list_head);
+}
+
+/*
+ * free_exts_group() -		Free the exts_group.
+ *
+ * @*ext_group_head:	the exts_group list head which will be free.
+ */
+ void free_exts_group(struct fiemap_extent_group *ext_group_head)
+{
+	struct fiemap_extent_group	*ext_group_tmp = NULL;
+
+	if (ext_group_head == NULL)
+		return;
+
+	while (ext_group_head->next != ext_group_head) {
+		ext_group_tmp = ext_group_head;
+		ext_group_head->prev->next = ext_group_head->next;
+		ext_group_head->next->prev = ext_group_head->prev;
+		ext_group_head = ext_group_head->next;
+		free(ext_group_tmp);
+	}
+	free(ext_group_head);
+}
+
+/*
+ * get_superblock_info() -	Get superblock info by the file name.
+ *
+ * @file:		the file's name.
+ * @sb:		the pointer of the struct ext4_super_block.
+ */
+int get_superblock_info(const char *file, struct ext4_super_block *sb)
+{
+	/* Refer to /etc/mtab */
+	char	*mtab = MOUNTED;
+	FILE	*fp = NULL;
+
+	int	fd = -1;
+	int	ret;
+	size_t maxlen = 0;
+	size_t len;
+	char	dev_name[PATH_MAX + 1];
+	struct mntent	*mnt = NULL;
+
+	fp = setmntent(mtab, "r");
+	if (fp == NULL)
+		return -1;
+
+	while ((mnt = getmntent(fp)) != NULL) {
+		len = strlen(mnt->mnt_dir);
+		ret = memcmp(file, mnt->mnt_dir, len);
+		if (ret != 0)
+			continue;
+
+		if (len < maxlen)
+			continue;
+
+		maxlen = len;
+
+		memset(dev_name, 0, PATH_MAX + 1);
+		strncpy(dev_name, mnt->mnt_fsname,
+				strnlen(mnt->mnt_fsname, PATH_MAX));
+	}
+
+	fd = open64(dev_name, O_RDONLY);
+	if (fd < 0) {
+		ret = -1;
+		goto out;
+	}
+
+	/* Set offset to read superblock */
+	ret = lseek64(fd, SUPERBLOCK_OFFSET, SEEK_SET);
+	if (ret < 0)
+		goto out;
+
+	ret = read(fd, sb, sizeof(struct ext4_super_block));
+	if (ret < 0)
+		goto out;
+
+out:
+	if (fd != -1)
+		close(fd);
+	endmntent(fp);
+	return ret;
+}
+
+/*
+ * get_best_count() -	Get the file best extents count.
+ *
+ * @block_count:		the file's physical block count.
+ */
+int get_best_count(ext4_fsblk_t block_count)
+{
+	int ret;
+	unsigned int flex_bg_num;
+
+	/* Calcuate best extents count */
+	if (feature_incompat & EXT4_FEATURE_INCOMPAT_FLEX_BG) {
+		flex_bg_num = 1 << log_groups_per_flex;
+		ret = ((block_count - 1) /
+			((ext4_fsblk_t)blocks_per_group *
+				flex_bg_num)) + 1;
+	} else
+		ret = ((block_count - 1) / blocks_per_group) + 1;
+
+	return ret;
+}
+
+
+/*
+ * file_statistic() -	Get statistic info of the file's fragments.
+ *
+ * @file:		the file's name.
+ * @buf:		the pointer of the struct stat64.
+ * @flag:		file type.
+ * @ftwbuf:		the pointer of a struct FTW.
+ */
+int file_statistic(const char *file, const struct stat64 *buf,
+			int flag EXT2FS_ATTR((unused)),
+			struct FTW *ftwbuf EXT2FS_ATTR((unused)))
+{
+	int	fd;
+	int	ret;
+	int	now_ext_count, best_ext_count, physical_ext_count;
+	int	i, j;
+	float	ratio = 0.0;
+	ext4_fsblk_t	blk_count = 0;
+	char	msg_buffer[PATH_MAX + 24];
+	struct fiemap_extent_list *physical_list_head = NULL;
+	struct fiemap_extent_list *logical_list_head = NULL;
+
+	defraged_file_count++;
+
+	if (mode_flag & DETAIL) {
+		if (total_count == 1 && regular_count == 1)
+			printf("<File>\n");
+		else {
+			printf("[%u/%u]", defraged_file_count, total_count);
+			fflush(stdout);
+		}
+	}
+	if (lost_found_dir[0] != '\0' &&
+	    !memcmp(file, lost_found_dir, strnlen(lost_found_dir, PATH_MAX))) {
+		if (mode_flag & DETAIL) {
+			PRINT_FILE_NAME(file);
+			STATISTIC_ERR_MSG(NGMSG_LOST_FOUND);
+		}
+			return 0;
+	}
+
+	if (!S_ISREG(buf->st_mode)) {
+		if (mode_flag & DETAIL) {
+			PRINT_FILE_NAME(file);
+			STATISTIC_ERR_MSG(NGMSG_FILE_UNREG);
+		}
+		return 0;
+	}
+
+	/* Access authority */
+	if (current_uid != ROOT_UID &&
+		buf->st_uid != current_uid) {
+		if (mode_flag & DETAIL) {
+			PRINT_FILE_NAME(file);
+			STATISTIC_ERR_MSG(
+				"File is not current user's file"
+				" or current user is not root");
+		}
+		return 0;
+	}
+
+	/* Empty file */
+	if (buf->st_size == 0) {
+		if (mode_flag & DETAIL) {
+			PRINT_FILE_NAME(file);
+			STATISTIC_ERR_MSG("File size is 0");
+		}
+		return 0;
+	}
+
+	fd = open64(file, O_RDONLY);
+	if (fd < 0) {
+		if (mode_flag & DETAIL) {
+			PRINT_FILE_NAME(file);
+			STATISTIC_ERR_MSG_WITH_ERRNO(NGMSG_FILE_OPEN);
+		}
+		return 0;
+	}
+
+	/* Get file's physical extents  */
+	ret = get_file_extents(fd, &physical_list_head);
+	if (ret < 0) {
+		if (mode_flag & DETAIL) {
+			PRINT_FILE_NAME(file);
+			STATISTIC_ERR_MSG_WITH_ERRNO(NGMSG_FILE_EXTENT);
+		}
+		goto out;
+	}
+
+	/* Get the count of file's continuous physical region */
+	physical_ext_count = get_physical_count(physical_list_head);
+
+	/* Change list from physical to logical */
+	ret = change_physical_to_logical(&physical_list_head,
+							&logical_list_head);
+	if (ret < 0) {
+		if (mode_flag & DETAIL) {
+			PRINT_FILE_NAME(file);
+			STATISTIC_ERR_MSG_WITH_ERRNO(NGMSG_FILE_EXTENT);
+		}
+		goto out;
+	}
+
+	/* Count file fragments before defrag */
+	now_ext_count = get_logical_count(logical_list_head);
+
+	if (current_uid == ROOT_UID) {
+		/* Calculate fragment ratio  */
+		blk_count =
+				SECTOR_TO_BLOCK(buf->st_blocks, block_size);
+
+		best_ext_count = get_best_count(blk_count);
+
+		ratio = (float)(physical_ext_count - best_ext_count) * 100 /
+							blk_count;
+
+		extents_before_defrag += now_ext_count;
+		extents_after_defrag += best_ext_count;
+		files_block_count += blk_count;
+	}
+
+	if (total_count == 1 && regular_count == 1) {
+		/* File only */
+		if (mode_flag & DETAIL) {
+			int count = 0;
+			struct fiemap_extent_list *ext_list_tmp =
+						logical_list_head;
+
+			/* Print extents info */
+			do {
+				count++;
+				printf("[ext %d]:\tstart %llu:\tlogical "
+						"%llu:\tlen %llu\n", count,
+						ext_list_tmp->data.physical,
+						ext_list_tmp->data.logical,
+						ext_list_tmp->data.len);
+				ext_list_tmp = ext_list_tmp->next;
+			} while (ext_list_tmp != logical_list_head);
+
+		} else {
+			printf("%-40s%10s/%-10s%9s\n",
+					"<File>", "now", "best", "ratio");
+			if (current_uid == ROOT_UID) {
+				if (strlen(file) > 40)
+					printf("%s\n%50d/%-10d%8.2f%%\n",
+						file, now_ext_count,
+						best_ext_count, ratio);
+				else
+					printf("%-40s%10d/%-10d%8.2f%%\n",
+						file, now_ext_count,
+						best_ext_count, ratio);
+			} else {
+				if (strlen(file) > 40)
+					printf("%s\n%50d/%-10s%7s\n",
+							file, now_ext_count,
+							"-", "-");
+				else
+					printf("%-40s%10d/%-10s%7s\n",
+							file, now_ext_count,
+							"-", "-");
+			}
+		}
+		succeed_cnt++;
+		goto out;
+	}
+
+	if (mode_flag & DETAIL) {
+		/* Print statistic info */
+		sprintf(msg_buffer, "[%u/%u]%s",
+				defraged_file_count, total_count, file);
+		if (current_uid == ROOT_UID) {
+			if (strlen(msg_buffer) > 40)
+				printf("\033[79;0H\033[K%s\n"
+						"%50d/%-10d%8.2f%%\n",
+						msg_buffer, now_ext_count,
+						best_ext_count, ratio);
+			else
+				printf("\033[79;0H\033[K%-40s"
+						"%10d/%-10d%8.2f%%\n",
+						msg_buffer, now_ext_count,
+						best_ext_count, ratio);
+		} else {
+			if (strlen(msg_buffer) > 40)
+				printf("\033[79;0H\033[K%s\n%50d/%-10s%7s\n",
+						msg_buffer, now_ext_count,
+							"-", "-");
+			else
+				printf("\033[79;0H\033[K%-40s%10d/%-10s%7s\n",
+						msg_buffer, now_ext_count,
+							"-", "-");
+		}
+	}
+
+	for (i = 0; i < SHOW_FRAG_FILES; i++) {
+		if (ratio >= frag_rank[i].ratio) {
+			for (j = SHOW_FRAG_FILES - 1; j > i; j--) {
+				memcpy(&frag_rank[j], &frag_rank[j - 1],
+					sizeof(struct frag_statistic_ino));
+			}
+			memset(&frag_rank[i], 0,
+					sizeof(struct frag_statistic_ino));
+			strncpy(frag_rank[i].msg_buffer, file,
+						strnlen(file, PATH_MAX));
+			frag_rank[i].now_count = now_ext_count;
+			frag_rank[i].best_count = best_ext_count;
+			frag_rank[i].ratio = ratio;
+			break;
+		}
+	}
+
+	succeed_cnt++;
+
+out:
+	close(fd);
+	free_ext(physical_list_head);
+	free_ext(logical_list_head);
+	return 0;
+}
+
+/*
+ * print_progress -	Print defrag progress
+ *
+ * @file:		file name.
+ * @start:		logical offset for defrag target file
+ * @file_size:		defrag target filesize
+ */
+void print_progress(const char *file, loff_t start, loff_t file_size)
+{
+	int percent = (start * 100) / file_size;
+	printf("\033[79;0H\033[K[%u/%u]%s:\t%3d%%",
+		defraged_file_count, total_count, file, min(percent, 100));
+	fflush(stdout);
+
+	return;
+}
+
+/*
+ * call_defrag() -	Execute the defrag program.
+ *
+ * @fd:			target file descriptor.
+ * @donor_fd:		donor file descriptor.
+ * @file:			target file name.
+ * @buf:			pointer of the struct stat64.
+ * @ext_list_head:	head of the extent list.
+ */
+int call_defrag(int fd, int donor_fd, const char *file,
+	const struct stat64 *buf, struct fiemap_extent_list *ext_list_head)
+{
+	loff_t	start = 0;
+	unsigned int	page_num;
+	unsigned char	*vec = NULL;
+	int	defraged_ret = 0;
+	int	ret;
+	struct move_extent	move_data;
+	struct fiemap_extent_list	*ext_list_tmp = NULL;
+
+	memset(&move_data, 0, sizeof(struct move_extent));
+	move_data.donor_fd = donor_fd;
+
+	/* Print defrag progress */
+	print_progress(file, start, buf->st_size);
+
+	ext_list_tmp = ext_list_head;
+	do {
+		move_data.orig_start = ext_list_tmp->data.logical;
+		/* Logical offset of orig and donor should be same */
+		move_data.donor_start = move_data.orig_start;
+		move_data.len = ext_list_tmp->data.len;
+		move_data.moved_len = 0;
+
+		ret = page_in_core(fd, move_data, &vec, &page_num);
+		if (ret < 0) {
+			if (mode_flag & DETAIL) {
+				printf("\n");
+				PRINT_ERR_MSG_WITH_ERRNO(
+						"Failed to get file map");
+			} else {
+				printf("\t[ NG ]\n");
+			}
+			return -1;
+		}
+
+		/* EXT4_IOC_MOVE_EXT */
+		defraged_ret =
+			ioctl(fd, EXT4_IOC_MOVE_EXT, &move_data);
+
+		/* Free pages */
+		ret = defrag_fadvise(fd, move_data, vec, page_num);
+		if (vec) {
+			free(vec);
+			vec = NULL;
+		}
+		if (ret < 0) {
+			if (mode_flag & DETAIL) {
+				printf("\n");
+				PRINT_ERR_MSG_WITH_ERRNO(
+					"Failed to free page");
+			} else {
+				printf("\t[ NG ]\n");
+			}
+			return -1;
+		}
+
+		if (defraged_ret < 0) {
+			if (mode_flag & DETAIL) {
+				printf("\n");
+				PRINT_ERR_MSG_WITH_ERRNO(
+						"Failed to defrag");
+			} else {
+				printf("\t[ NG ]\n");
+			}
+			return -1;
+		}
+		/* Adjust logical offset for next ioctl */
+		move_data.orig_start += move_data.moved_len;
+		move_data.donor_start = move_data.orig_start;
+
+		start = move_data.orig_start * buf->st_blksize;
+
+		/* Print defrag progress */
+		print_progress(file, start, buf->st_size);
+
+		/* End of file */
+		if (start >= buf->st_size)
+			break;
+
+		ext_list_tmp = ext_list_tmp->next;
+	} while (ext_list_tmp != ext_list_head);
+
+	return 0;
+}
+
+/*
+ * file_defrag() -		Check file attributes and call ioctl to defrag.
+ *
+ * @file:		the file's name.
+ * @buf:		the pointer of the struct stat64.
+ * @flag:		file type.
+ * @ftwbuf:		the pointer of a struct FTW.
+ */
+int file_defrag(const char *file, const struct stat64 *buf,
+			int flag EXT2FS_ATTR((unused)),
+			struct FTW *ftwbuf EXT2FS_ATTR((unused)))
+{
+	int	fd;
+	int	donor_fd = -1;
+	int	ret;
+	int	best;
+	int	file_frags_start, file_frags_end;
+	int	orig_physical_cnt, donor_physical_cnt;
+	char	tmp_inode_name[PATH_MAX + 8];
+	struct fiemap_extent_list	*orig_list_physical = NULL;
+	struct fiemap_extent_list	*orig_list_logical = NULL;
+	struct fiemap_extent_list	*donor_list_physical = NULL;
+	struct fiemap_extent_list	*donor_list_logical = NULL;
+	struct fiemap_extent_group	*orig_group_head = NULL;
+	struct fiemap_extent_group	*orig_group_tmp = NULL;
+
+	defraged_file_count++;
+
+	if (mode_flag & DETAIL) {
+		printf("[%u/%u]", defraged_file_count, total_count);
+		fflush(stdout);
+	}
+
+	if (lost_found_dir[0] != '\0' &&
+	    !memcmp(file, lost_found_dir, strnlen(lost_found_dir, PATH_MAX))) {
+		if (mode_flag & DETAIL) {
+			PRINT_FILE_NAME(file);
+			IN_FTW_PRINT_ERR_MSG(NGMSG_LOST_FOUND);
+		}
+		return 0;
+	}
+
+	if (!S_ISREG(buf->st_mode)) {
+		if (mode_flag & DETAIL) {
+			PRINT_FILE_NAME(file);
+			IN_FTW_PRINT_ERR_MSG(NGMSG_FILE_UNREG);
+		}
+		return 0;
+	}
+
+	/* Empty file */
+	if (buf->st_size == 0) {
+		if (mode_flag & DETAIL) {
+			PRINT_FILE_NAME(file);
+			IN_FTW_PRINT_ERR_MSG("File size is 0");
+		}
+		return 0;
+	}
+
+	fd = open64(file, O_RDONLY);
+	if (fd < 0) {
+		if (mode_flag & DETAIL) {
+			PRINT_FILE_NAME(file);
+			PRINT_ERR_MSG_WITH_ERRNO(NGMSG_FILE_OPEN);
+		}
+		return 0;
+	}
+
+	/* Get file's extents */
+	ret = get_file_extents(fd, &orig_list_physical);
+	if (ret < 0) {
+		if (mode_flag & DETAIL) {
+			PRINT_FILE_NAME(file);
+			PRINT_ERR_MSG_WITH_ERRNO(NGMSG_FILE_EXTENT);
+		}
+		goto out;
+	}
+
+	/* Get the count of file's continuous physical region */
+	orig_physical_cnt = get_physical_count(orig_list_physical);
+
+	/* Change list from physical to logical */
+	ret = change_physical_to_logical(&orig_list_physical,
+							&orig_list_logical);
+	if (ret < 0) {
+		if (mode_flag & DETAIL) {
+			PRINT_FILE_NAME(file);
+			PRINT_ERR_MSG_WITH_ERRNO(NGMSG_FILE_EXTENT);
+		}
+		goto out;
+	}
+
+	/* Count file fragments before defrag */
+	file_frags_start = get_logical_count(orig_list_logical);
+
+	if (file_check(fd, buf, file, file_frags_start) < 0)
+		goto out;
+
+	if (fsync(fd) < 0) {
+		if (mode_flag & DETAIL) {
+			PRINT_FILE_NAME(file);
+			PRINT_ERR_MSG_WITH_ERRNO("Failed to sync(fsync)");
+		}
+		goto out;
+	}
+
+	if (current_uid == ROOT_UID)
+		best =
+		get_best_count(SECTOR_TO_BLOCK(buf->st_blocks, block_size));
+	else
+		best = 1;
+
+	if (file_frags_start <= best)
+		goto check_improvement;
+
+	/* Combine extents to group */
+	ret = join_extents(orig_list_logical, &orig_group_head);
+	if (ret < 0) {
+		if (mode_flag & DETAIL) {
+			PRINT_FILE_NAME(file);
+			PRINT_ERR_MSG_WITH_ERRNO(NGMSG_FILE_EXTENT);
+		}
+		goto out;
+	}
+
+	/* Create donor inode */
+	memset(tmp_inode_name, 0, PATH_MAX + 8);
+	sprintf(tmp_inode_name, "%.*s.defrag",  strnlen(file, PATH_MAX), file);
+	donor_fd = open64(tmp_inode_name, O_WRONLY | O_CREAT | O_EXCL, S_IRUSR);
+	if (donor_fd < 0) {
+		if (mode_flag & DETAIL) {
+			PRINT_FILE_NAME(file);
+			if (errno == EEXIST)
+				PRINT_ERR_MSG_WITH_ERRNO(
+				"File is being defraged by other program");
+			else
+				PRINT_ERR_MSG_WITH_ERRNO(NGMSG_FILE_OPEN);
+		}
+		goto out;
+	}
+
+	/* Unlink donor inode */
+	ret = unlink(tmp_inode_name);
+	if (ret < 0) {
+		if (mode_flag & DETAIL) {
+			PRINT_FILE_NAME(file);
+			PRINT_ERR_MSG_WITH_ERRNO("Failed to unlink");
+		}
+		goto out;
+	}
+
+	/* Allocate space for donor inode */
+	orig_group_tmp = orig_group_head;
+	do {
+		ret = fallocate(donor_fd, 0,
+		  (loff_t)orig_group_tmp->start->data.logical * block_size,
+		  (loff_t)orig_group_tmp->len * block_size);
+		if (ret < 0) {
+			if (mode_flag & DETAIL) {
+				PRINT_FILE_NAME(file);
+				PRINT_ERR_MSG_WITH_ERRNO("Failed to fallocate");
+			}
+			goto out;
+		}
+
+		orig_group_tmp = orig_group_tmp->next;
+	} while (orig_group_tmp != orig_group_head);
+
+	/* Get donor inode's extents */
+	ret = get_file_extents(donor_fd, &donor_list_physical);
+	if (ret < 0) {
+		if (mode_flag & DETAIL) {
+			PRINT_FILE_NAME(file);
+			PRINT_ERR_MSG_WITH_ERRNO(NGMSG_FILE_EXTENT);
+		}
+		goto out;
+	}
+
+	/* Calcuate donor inode's continuous physical region */
+	donor_physical_cnt = get_physical_count(donor_list_physical);
+
+	/* Change donor extent list from physical to logical */
+	ret = change_physical_to_logical(&donor_list_physical,
+							&donor_list_logical);
+	if (ret < 0) {
+		if (mode_flag & DETAIL) {
+			PRINT_FILE_NAME(file);
+			PRINT_ERR_MSG_WITH_ERRNO(NGMSG_FILE_EXTENT);
+		}
+		goto out;
+	}
+
+check_improvement:
+	if (mode_flag & DETAIL) {
+		if (file_frags_start != 1)
+			frag_files_before_defrag++;
+
+		extents_before_defrag += file_frags_start;
+	}
+
+	if (file_frags_start <= best ||
+			orig_physical_cnt <= donor_physical_cnt) {
+		printf("\033[79;0H\033[K[%u/%u]%s:\t%3d%%",
+			defraged_file_count, total_count, file, 100);
+		if (mode_flag & DETAIL)
+			printf("  extents: %d -> %d",
+				file_frags_start, file_frags_start);
+
+		printf("\t[ OK ]\n");
+		succeed_cnt++;
+
+		if (file_frags_start != 1)
+			frag_files_after_defrag++;
+
+		extents_after_defrag += file_frags_start;
+		goto out;
+	}
+
+	/* Defrag the file */
+	ret = call_defrag(fd, donor_fd, file, buf, donor_list_logical);
+
+	/* Count file fragments after defrag and print extents info */
+	if (mode_flag & DETAIL) {
+		file_frags_end = file_frag_count(fd);
+		if (file_frags_end < 0) {
+			printf("\n");
+			PRINT_ERR_MSG_WITH_ERRNO(NGMSG_FILE_INFO);
+			goto out;
+		}
+
+		if (file_frags_end != 1)
+			frag_files_after_defrag++;
+
+		extents_after_defrag += file_frags_end;
+
+		if (ret < 0)
+			goto out;
+
+		printf("  extents: %d -> %d",
+			file_frags_start, file_frags_end);
+		fflush(stdout);
+	}
+
+	if (ret < 0)
+		goto out;
+
+	printf("\t[ OK ]\n");
+	fflush(stdout);
+	succeed_cnt++;
+
+out:
+	close(fd);
+	if (donor_fd != -1)
+		close(donor_fd);
+	free_ext(orig_list_physical);
+	free_ext(orig_list_logical);
+	free_ext(donor_list_physical);
+	free_exts_group(orig_group_head);
+	return 0;
+}
+
+/*
+ * main() -		Ext4 online defrag.
+ *
+ * @argc:		the number of parameter.
+ * @argv[]:		the pointer array of parameter.
+ */
+int main(int argc, char *argv[])
+{
+	int	opt;
+	int	i, j;
+	int	flags = FTW_PHYS | FTW_MOUNT;
+	int	arg_type = -1;
+	int	success_flag = 0;
+	char	dir_name[PATH_MAX + 1];
+	struct stat64	buf;
+	struct ext4_super_block sb;
+
+	/* Parse arguments */
+	if (argc == 1)
+		goto out;
+
+	while ((opt = getopt(argc, argv, "vc")) != EOF) {
+		switch (opt) {
+		case 'v':
+			mode_flag |= DETAIL;
+			break;
+		case 'c':
+			mode_flag |= STATISTIC;
+			break;
+		default:
+			goto out;
+		}
+	}
+
+	if (argc == optind)
+		goto out;
+
+	current_uid = getuid();
+
+	/* Main process */
+	for (i = optind; i < argc; i++) {
+		succeed_cnt = 0;
+		regular_count = 0;
+		total_count = 0;
+		frag_files_before_defrag = 0;
+		frag_files_after_defrag = 0;
+		extents_before_defrag = 0;
+		extents_after_defrag = 0;
+		defraged_file_count = 0;
+		files_block_count = 0;
+		blocks_per_group = 0;
+		feature_incompat = 0;
+		log_groups_per_flex = 0;
+
+		memset(dir_name, 0, PATH_MAX + 1);
+		memset(lost_found_dir, 0, PATH_MAX + 1);
+		memset(frag_rank, 0,
+			sizeof(struct frag_statistic_ino) * SHOW_FRAG_FILES);
+
+		if ((mode_flag & STATISTIC) && i > optind)
+			printf("\n");
+
+#if BYTE_ORDER != BIG_ENDIAN && BYTE_ORDER != LITTLE_ENDIAN
+		PRINT_ERR_MSG("Endian's type is not big/little endian");
+		PRINT_FILE_NAME(argv[i]);
+		continue;
+#endif
+
+		if (lstat64(argv[i], &buf) < 0) {
+			perror(NGMSG_FILE_INFO);
+			PRINT_FILE_NAME(argv[i]);
+			continue;
+		}
+
+		if (S_ISBLK(buf.st_mode)) {
+			/* Block device */
+			if (get_mount_point(argv[i], dir_name, PATH_MAX) < 0)
+				continue;
+			if (lstat64(dir_name, &buf) < 0) {
+				perror(NGMSG_FILE_INFO);
+				PRINT_FILE_NAME(argv[i]);
+				continue;
+			}
+			arg_type = DEVNAME;
+			if (!(mode_flag & STATISTIC))
+				printf("ext4 defragmentation for device(%s)\n",
+					argv[i]);
+		} else if (S_ISDIR(buf.st_mode)) {
+			/* Directory */
+			if (access(argv[i], R_OK) < 0) {
+				perror(argv[i]);
+				continue;
+			}
+			arg_type = DIRNAME;
+			strncpy(dir_name, argv[i], strnlen(argv[i], PATH_MAX));
+		} else if (S_ISREG(buf.st_mode)) {
+			/* Regular file */
+			arg_type = FILENAME;
+		} else {
+			/* Irregular file */
+			PRINT_ERR_MSG(NGMSG_FILE_UNREG);
+			PRINT_FILE_NAME(argv[i]);
+			continue;
+		}
+
+		/* Set blocksize */
+		block_size = buf.st_blksize;
+
+		/* For device case,
+		 * filesystem type checked in get_mount_point()
+		 */
+		if (arg_type == FILENAME || arg_type == DIRNAME) {
+			if (is_ext4(argv[i]) < 0)
+				continue;
+			if (realpath(argv[i], dir_name) == NULL) {
+				perror("Couldn't get full path");
+				PRINT_FILE_NAME(argv[i]);
+				continue;
+			}
+		}
+
+		if (current_uid == ROOT_UID) {
+			/* Get super block info */
+			memset(&sb, 0, sizeof(struct ext4_super_block));
+			if (get_superblock_info(dir_name, &sb) < 0) {
+				if (mode_flag & DETAIL) {
+					perror("Can't get super block info");
+					PRINT_FILE_NAME(argv[i]);
+				}
+				continue;
+			}
+
+			blocks_per_group = ext2fs_swab32(sb.s_blocks_per_group);
+			feature_incompat = ext2fs_swab32(sb.s_feature_incompat);
+			log_groups_per_flex = sb.s_log_groups_per_flex;
+		}
+
+		switch (arg_type) {
+		case DIRNAME:
+			if (!(mode_flag & STATISTIC))
+				printf("ext4 defragmentation "
+					"for directory(%s)\n", argv[i]);
+
+			int mount_dir_len = 0;
+			mount_dir_len = strnlen(lost_found_dir, PATH_MAX);
+
+			strncat(lost_found_dir, "/lost+found",
+				PATH_MAX - strnlen(lost_found_dir, PATH_MAX));
+
+			/* Not the case("e4defrag  mount_piont_dir") */
+			if (dir_name[mount_dir_len] != '\0') {
+				/*
+				 * "e4defrag mount_piont_dir/lost+found"
+				 * or "e4defrag mount_piont_dir/lost+found/"
+				 */
+				if (strncmp(lost_found_dir, dir_name,
+					    strnlen(lost_found_dir,
+						    PATH_MAX)) == 0 &&
+				    (dir_name[strnlen(lost_found_dir,
+						      PATH_MAX)] == '\0' ||
+				     dir_name[strnlen(lost_found_dir,
+						      PATH_MAX)] == '/')) {
+					PRINT_ERR_MSG(NGMSG_LOST_FOUND);
+					PRINT_FILE_NAME(argv[i]);
+					continue;
+				}
+
+				/* "e4defrag mount_piont_dir/else_dir" */
+				memset(lost_found_dir, 0, PATH_MAX + 1);
+			}
+		case DEVNAME:
+			if (arg_type == DEVNAME) {
+				strncpy(lost_found_dir, dir_name,
+					strnlen(dir_name, PATH_MAX));
+				strncat(lost_found_dir, "/lost+found/",
+					PATH_MAX - strnlen(lost_found_dir,
+							   PATH_MAX));
+			}
+
+			nftw64(dir_name, calc_entry_counts, FTW_OPEN_FD, flags);
+
+			if (mode_flag & STATISTIC) {
+				if (mode_flag & DETAIL)
+					printf("%-40s%10s/%-10s%9s\n",
+					"<File>", "now", "best", "ratio");
+
+				if (!(mode_flag & DETAIL) &&
+						current_uid != ROOT_UID) {
+					printf(" Done.\n");
+					continue;
+				}
+
+				nftw64(dir_name, file_statistic,
+							FTW_OPEN_FD, flags);
+
+				if (succeed_cnt != 0 &&
+					current_uid == ROOT_UID) {
+					if (mode_flag & DETAIL)
+						printf("\n");
+					printf("%-40s%10s/%-10s%9s\n",
+						"<Fragmented files>", "now",
+						"best", "ratio");
+					for (j = 0; j < SHOW_FRAG_FILES; j++) {
+						if (strlen(frag_rank[j].
+							msg_buffer) > 37) {
+							printf("%d. %s\n%50d/"
+							"%-10d%8.2f%%\n", j + 1,
+							frag_rank[j].msg_buffer,
+							frag_rank[j].now_count,
+							frag_rank[j].best_count,
+							frag_rank[j].ratio);
+						} else if (strlen(frag_rank[j].
+							msg_buffer) > 0) {
+							printf("%d. %-37s%10d/"
+							"%-10d%8.2f%%\n", j + 1,
+							frag_rank[j].msg_buffer,
+							frag_rank[j].now_count,
+							frag_rank[j].best_count,
+							frag_rank[j].ratio);
+						} else
+							break;
+					}
+				}
+				break;
+			}
+			/* File tree walk */
+			nftw64(dir_name, file_defrag, FTW_OPEN_FD, flags);
+			printf("\n\tSuccess:\t\t\t[ %u/%u ]\n", succeed_cnt,
+				total_count);
+			printf("\tFailure:\t\t\t[ %u/%u ]\n",
+				total_count - succeed_cnt, total_count);
+			if (mode_flag & DETAIL) {
+				printf("\tTotal extents:\t\t\t%4d->%d\n",
+					extents_before_defrag,
+					extents_after_defrag);
+				printf("\tFragmented percentage:\t\t"
+					"%3llu%%->%llu%%\n",
+					!regular_count ? 0 :
+					((unsigned long long)
+					frag_files_before_defrag * 100) /
+					regular_count,
+					!regular_count ? 0 :
+					((unsigned long long)
+					frag_files_after_defrag * 100) /
+					regular_count);
+			}
+			break;
+		case FILENAME:
+			total_count = 1;
+			regular_count = 1;
+			strncat(lost_found_dir, "/lost+found/",
+				PATH_MAX - strnlen(lost_found_dir,
+						   PATH_MAX));
+			if (strncmp(lost_found_dir, dir_name,
+				    strnlen(lost_found_dir,
+					    PATH_MAX)) == 0) {
+				PRINT_ERR_MSG(NGMSG_LOST_FOUND);
+				PRINT_FILE_NAME(argv[i]);
+				continue;
+			}
+
+			if (mode_flag & STATISTIC) {
+				file_statistic(argv[i], &buf, FTW_F, NULL);
+				break;
+			} else
+				printf("ext4 defragmentation for %s\n",
+								 argv[i]);
+			/* Defrag single file process */
+			file_defrag(argv[i], &buf, FTW_F, NULL);
+			if (succeed_cnt != 0)
+				printf(" Success:\t\t\t[1/1]\n");
+			else
+				printf(" Success:\t\t\t[0/1]\n");
+
+			break;
+		}
+
+		if (succeed_cnt != 0)
+			success_flag = 1;
+		if (mode_flag & STATISTIC) {
+			if (current_uid != ROOT_UID) {
+				printf(" Done.\n");
+				continue;
+			}
+
+			if (!succeed_cnt) {
+				if (mode_flag & DETAIL)
+					printf("\n");
+
+				if (arg_type == DEVNAME)
+					printf(" In this device(%s), "
+					"none can be defragmented.\n", argv[i]);
+				else if (arg_type == DIRNAME)
+					printf(" In this directory(%s), "
+					"none can be defragmented.\n", argv[i]);
+				else
+					printf(" This file(%s) "
+					"can't be defragmented.\n", argv[i]);
+			} else {
+				float files_ratio = 0.0;
+				float score = 0.0;
+				files_ratio = (float)(extents_before_defrag -
+						extents_after_defrag) *
+						100 / files_block_count;
+				score = CALC_SCORE(files_ratio);
+				printf("\n Total/best extents\t\t\t\t%d/%d\n"
+					" Fragmentation ratio\t\t\t\t%.2f%%\n"
+					" Fragmentation score\t\t\t\t%.2f\n",
+						extents_before_defrag,
+						extents_after_defrag,
+						files_ratio, score);
+				printf(" [0-30 no problem:"
+					" 31-55 a little bit fragmented:"
+					" 55- needs defrag]\n");
+
+				if (arg_type == DEVNAME)
+					printf(" This device(%s) ", argv[i]);
+				else if (arg_type == DIRNAME)
+					printf(" This directory(%s) ", argv[i]);
+				else
+					printf(" This file(%s) ", argv[i]);
+
+				if (score > BOUND_SCORE)
+					printf("needs defragmentation.\n");
+				else
+					printf("does not need "
+							"defragmentation.\n");
+			}
+			printf(" Done.\n");
+		}
+
+	}
+
+	if (success_flag)
+		return 0;
+
+	exit(1);
+
+out:
+	printf(MSG_USAGE);
+	exit(1);
+}
+
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-online-defrag/ext4_online_defrag_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-online-defrag/ext4_online_defrag_test.sh
new file mode 100644
index 0000000..84613c8
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ext4-online-defrag/ext4_online_defrag_test.sh
@@ -0,0 +1,192 @@
+#!/bin/bash
+
+################################################################################
+#                                                                              #
+# Copyright (c) 2009 FUJITSU LIMITED                                           #
+#                                                                              #
+# This program is free software;  you can redistribute it and#or modify        #
+# it under the terms of the GNU General Public License as published by         #
+# the Free Software Foundation; either version 2 of the License, or            #
+# (at your option) any later version.                                          #
+#                                                                              #
+# This program is distributed in the hope that it will be useful, but          #
+# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY   #
+# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License     #
+# for more details.                                                            #
+#                                                                              #
+# You should have received a copy of the GNU General Public License            #
+# along with this program;  if not, write to the Free Software                 #
+# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA      #
+#                                                                              #
+################################################################################
+
+cd $LTPROOT/testcases/bin
+
+. ./ext4_funcs.sh
+
+export TCID="ext4-online-defrag"
+export TST_TOTAL=18
+export TST_COUNT=1
+
+export TEST_DIR=$PWD
+
+# $1: the test config
+read_config $1
+
+# How to age filesystem
+EMPTY=1
+SMALL=2
+LARGE=3
+
+# Defrag what
+FILE=1
+DIR=2
+FILESYSTEM=3
+
+age_filesystem()
+{
+	local dirId=
+	local idx=
+	rm -rf mnt_point/*
+	if [ $1 -eq $EMPTY ]; then
+		if [ $2 -eq $FILE -o $2 -eq $FILESYSTEM ]; then
+			touch mnt_point/tmp_file
+			echo "abc" > mnt_point/tmp_file
+		elif [ $2 -eq $DIR ]; then
+			mkdir mnt_point/tmp_dir
+			echo "abc" > mnt_point/tmp_dir/tmp_file
+		fi
+	elif [ $1 -eq $SMALL ]; then
+
+		dd if=/dev/zero of=mnt_point/occupy bs=1M count=40
+
+		# age filesystem from 0.0 to 0.2 -> 0.4 -> 0.6 -> 0.8 -> 1.0
+		for ((idx = 3; idx < 8; idx++))
+		{
+			./ffsb ffsb-config$idx > /dev/null
+			dirId=$((idx - 3))
+			mv mnt_point/data mnt_point/data$dirId
+		}
+
+		rm mnt_point/occupy
+
+		df
+	else
+		rm -rf mnt_point/*
+		if [ $2 -eq $DIR ]; then
+			mkdir mnt_point/tmp_dir
+			dest=mnt_point/tmp_dir/tmp_file
+		else
+			dest=mnt_point/tmp_file
+		fi
+
+		bsize=`dumpe2fs -h $EXT4_DEV | grep 'Block size'`
+		bsize=`echo $bsize | awk '{ print $NF }'`
+		bcount=`dumpe2fs -h $EXT4_DEV | grep 'Free blocks'`
+		bcount=`echo $bcount | awk '{ print $NF }'`
+		bcount=$(( $bcount / 2 - 100 ))
+		dd if=/dev/zero of=$dest bs=$bsize count=$bcount
+
+	fi
+}
+
+my_e4defrag()
+{
+	if [ $1 -eq $FILE ]; then
+		if [ $2 -eq $SMALL ]; then
+			./e4defrag mnt_point/data0/
+			return $?
+		# EMPTY or LARGE
+		else
+			./e4defrag mnt_point/tmp_file
+			return $?
+		fi
+	elif [ $1 -eq $DIR ]; then
+		if [ $2 -eq $SMALL ]; then
+			./e4defrag mnt_point/data0/
+			return $?
+		else
+			./e4defrag mnt_point/tmp_dir
+			return $?
+		fi
+	else
+		./e4defrag $EXT4_DEV
+		return $?
+	fi
+}
+
+# Test online defragmentation feature
+# $1: defrag type
+# $2: 1 - empty, 2 - full with small files, 3 - full with large files
+# $3: block size
+ext4_test_online_defrag()
+{
+	tst_resm TINFO "defrag type: $1, defrag obj: $2, block size: $3"
+
+	mkfs.ext4 -m 0 -b $3 -O ^flex_bg $EXT4_DEV > /dev/null
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "failed to create ext4 filesystem"
+		return 1
+	fi
+
+	tune2fs -E test_fs -O extents $EXT4_DEV
+
+	mount -t ext4 -o nodelalloc $EXT4_DEV mnt_point
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL"failed to mount ext4 filesystem"
+		return 1
+	fi
+
+	age_filesystem $2 $1
+
+	my_e4defrag $1 $2 >> $LTPROOT/output/ext4_online_defrag_result.txt
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "e4defrag returned failure"
+		umount mnt_point
+		return 1
+	fi
+
+	umount mnt_point
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "failed to umount ext4 filesystem"
+		return 1
+	fi
+
+	e2fsck -p $EXT4_DEV
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "fsck returned failure"
+		return 1
+	fi
+
+	tst_resm TPASS "ext4 online defrag test pass(defrag type: $1, Aging: $2, block size: $3)"
+}
+
+# main
+ext4_setup
+
+DEFRAG=( $FILE $DIR $FILESYSTEM )
+AGING=( $EMPTY $SMALL $LARGE )
+BLOCK_SIZE=( 1024 4096 )
+
+RET=0
+
+for ((i = 0; i < 2; i++))
+{
+	for ((j = 0; j < 3; j++))
+	{
+		for ((k = 0; k < 3; k++))
+		{
+			ext4_test_online_defrag ${DEFRAG[$j]} ${AGING[$k]} \
+						${BLOCK_SIZE[$i]}
+			if [ $? -ne 0 ]; then
+				RET=1
+			fi
+			: $((TST_COUNT++))
+		}
+	}
+}
+
+ext4_cleanup
+
+exit $RET
+
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/Makefile b/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/Makefile
new file mode 100644
index 0000000..4396397
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/Makefile
@@ -0,0 +1,12 @@
+SRCS = $(wildcard *.sh)
+
+all:
+	@true
+
+install:
+	@set -e;
+	for i in $(SRCS); do ln -f $$i ../../../../bin/$$i; chmod +x $$i; done;
+
+clean:
+	@true
+
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh
new file mode 100644
index 0000000..0d293e8
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh
@@ -0,0 +1,113 @@
+#!/bin/bash
+
+################################################################################
+##                                                                            ##
+## Copyright (c) 2009 FUJITSU LIMITED                                         ##
+##                                                                            ##
+## This program is free software;  you can redistribute it and#or modify      ##
+## it under the terms of the GNU General Public License as published by       ##
+## the Free Software Foundation; either version 2 of the License, or          ##
+## (at your option) any later version.                                        ##
+##                                                                            ##
+## This program is distributed in the hope that it will be useful, but        ##
+## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
+## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
+## for more details.                                                          ##
+##                                                                            ##
+## You should have received a copy of the GNU General Public License          ##
+## along with this program;  if not, write to the Free Software               ##
+## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
+##                                                                            ##
+## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
+##         Miao Xie <miaox@cn.fujitsu.com>                                    ##
+##                                                                            ##
+################################################################################
+
+cd $LTPROOT/testcases/bin
+
+. ./ext4_funcs.sh
+
+export TCID="ext4-persistent-preallocation"
+export TST_TOTAL=2
+export TST_COUNT=1
+
+export TEST_DIR=$PWD
+
+# $1: the test config
+read_config $1
+
+# The test path of fallocate
+export TDIRECTORY=$PWD/mnt_point/
+
+# Use ltp's syscall/fallocate to test this feature
+# $1: 1024 or 4096
+ext4_test_persist_prealloc()
+{
+	mkfs.ext4 -I 256 -b $1 $EXT4_DEV > /dev/null
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "failed to create ext4 filesystem"
+		return 1
+	fi
+
+	mount -t ext4 $EXT4_DEV mnt_point
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "failed to mount ext4 filesystem"
+		return 1
+	fi
+
+	ret=1
+
+	for ((i = 1; i <= 3; i++))
+	{
+		if [ ! -f fallocate0${i} ];  then
+			tst_resm TFAIL "file - fallocate0${i} doesn't exist. Please \
+				check whether it was compiled and installed.\
+				(Path: LTPROOT/testcases/kernel/syscalls/fallocate)"
+			umount mnt_point
+			return 1
+		fi
+
+		./fallocate0${i} | grep -q "CONF"
+		if [ $? -ne $ret ]; then
+			tst_resm TFAIL "fallocate's return value is not expected"
+			umount mnt_point
+			return 1
+		fi
+	}
+
+	umount mnt_point
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "failed to umount ext4 filesystem"
+		return 1
+	fi
+
+	e2fsck -p $EXT4_DEV
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "fsck returned failure"
+		return 1
+	fi
+
+	tst_resm TPASS "ext4 persistent preallocation test pass"
+}
+
+# main
+ext4_setup
+
+RET=0
+
+ext4_test_persist_prealloc 1024
+if [ $? -ne 0 ]; then
+	RET=1;
+fi
+: $((TST_COUNT++))
+
+ext4_test_persist_prealloc 4096
+if [ $? -ne 0 ]; then
+	RET=1;
+fi
+: $((TST_COUNT++))
+
+ext4_cleanup
+
+exit $RET
+
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/Makefile b/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/Makefile
new file mode 100644
index 0000000..29fa210
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/Makefile
@@ -0,0 +1,18 @@
+CFLAGS += -Wall -g -Wextra
+LDLIBS += -lm
+
+SRCS=$(wildcard *.c)
+OBJECTS=$(patsubst %.c,%.o,$(SRCS))
+TARGETS=$(patsubst %.c,%,$(SRCS))
+
+all: $(TARGETS)
+
+clean:
+	rm -rf $(TARGETS) $(OBJECTS)
+
+install:
+	@set -e;
+	for i in $(TARGETS); do ln -f $$i ../../../../bin/$$i; chmod +x $$i; done;
+	ln -f ext4_subdir_limit_test.sh ../../../../bin/ext4_subdir_limit_test.sh;
+	chmod +x ext4_subdir_limit_test.sh;
+
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/create_long_dirs.c b/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/create_long_dirs.c
new file mode 100644
index 0000000..55c3d0a
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/create_long_dirs.c
@@ -0,0 +1,156 @@
+/******************************************************************************/
+/*                                                                            */
+/* Copyright (c) 2009 FUJITSU LIMITED                                         */
+/*                                                                            */
+/* This program is free software;  you can redistribute it and/or modify      */
+/* it under the terms of the GNU General Public License as published by       */
+/* the Free Software Foundation; either version 2 of the License, or          */
+/* (at your option) any later version.                                        */
+/*                                                                            */
+/* This program is distributed in the hope that it will be useful,            */
+/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
+/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
+/* the GNU General Public License for more details.                           */
+/*                                                                            */
+/* You should have received a copy of the GNU General Public License          */
+/* along with this program;  if not, write to the Free Software               */
+/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    */
+/*                                                                            */
+/* Author: Li Zefan <lizf@cn.fujitsu.com>                                     */
+/*                                                                            */
+/******************************************************************************/
+
+#define _ATFILE_SOURCE
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <time.h>
+#include <fcntl.h>
+#include <sys/types.h>
+//#define __USE_ATFILE
+#include <sys/stat.h>
+
+#define NAME_LEN	255
+#define NCHARS		62
+#define MAX_LEN1	62
+#define MAX_LEN2	(62 * 62)
+#define MAX_LEN3	(62 * 62 * 62)
+
+/* valid characters for the directory name */
+char chars[NCHARS + 1] =
+	"0123456789qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM";
+
+/* to store the generated directory name */
+char name[NAME_LEN + 1];
+int names;
+int parent_fd;
+
+/*
+ * init_name - initialize the directory name
+ *
+ * Generate a randomized directory name, and then we generate more
+ * directory names based on it.
+ */
+void init_name(void)
+{
+	int i;
+
+	srand(time(NULL));
+
+	for (i = 0; i < NAME_LEN; i++)
+		name[i] = chars[rand() % 62];
+}
+
+void create_dir(void)
+{
+	if (mkdirat(parent_fd, name, S_IRWXU)) {
+		perror("mkdir");
+		exit(1);
+	}
+}
+
+/*
+ * create_dirs - create @names directory names
+ * @n: how many names to be created
+ *
+ * if n <= 62,       we need to modify 1 char of the name
+ * if n <= 62*62,    we need to modify 2 chars
+ * if n <= 62*62*62, we need to modify 3 chars
+ */
+void create_dirs(int n)
+{
+	int i, j, k;
+	int depth;
+
+	if (n <= MAX_LEN1)
+		depth = 1;
+	else if (n <= MAX_LEN2)
+		depth = 2;
+	else
+		depth = 3;
+
+	for (i = 0; i < NCHARS; i++) {
+		name[0] = chars[i];
+		if (depth == 1) {
+			create_dir();
+			if (--n == 0)
+				return;
+			continue;
+		}
+
+		for (j = 0; j < NCHARS; j++) {
+			name[1] = chars[j];
+			if (depth == 2) {
+				create_dir();
+				if (--n == 0)
+					return;
+				continue;
+			}
+
+			for (k = 0; k < NCHARS; k++) {
+				name[2] = chars[k];
+				create_dir();
+				if (--n == 0)
+					return;
+			}
+		}
+	}
+}
+
+void usage()
+{
+	fprintf(stderr, "Usage: create_long_dirs nr_dirs parent_dir\n");
+}
+
+/*
+ * Create long-name directories
+ * @argv[1]: directory number
+ * @argv[2]: parent directory
+ */
+int main(int argc, char *argv[])
+{
+	if (argc != 3) {
+		usage();
+		return 1;
+	}
+
+	names = atoi(argv[1]);
+	if (names > MAX_LEN3 || names <= 0) {
+		usage();
+		return 1;
+	}
+
+	parent_fd = open(argv[2], O_RDONLY);
+	if (parent_fd == -1) {
+		perror("open parent dir failed");
+		return 1;
+	}
+
+	init_name();
+
+	create_dirs(names);
+
+	return 0;
+}
+
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/create_short_dirs.c b/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/create_short_dirs.c
new file mode 100644
index 0000000..328daa2
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/create_short_dirs.c
@@ -0,0 +1,158 @@
+/******************************************************************************/
+/*                                                                            */
+/* Copyright (c) 2009 FUJITSU LIMITED                                         */
+/*                                                                            */
+/* This program is free software;  you can redistribute it and/or modify      */
+/* it under the terms of the GNU General Public License as published by       */
+/* the Free Software Foundation; either version 2 of the License, or          */
+/* (at your option) any later version.                                        */
+/*                                                                            */
+/* This program is distributed in the hope that it will be useful,            */
+/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
+/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
+/* the GNU General Public License for more details.                           */
+/*                                                                            */
+/* You should have received a copy of the GNU General Public License          */
+/* along with this program;  if not, write to the Free Software               */
+/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    */
+/*                                                                            */
+/* Author: Li Zefan <lizf@cn.fujitsu.com>                                     */
+/*                                                                            */
+/******************************************************************************/
+
+#define _ATFILE_SOURCE
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+
+/* valid characters for a directory name */
+char chars[] = "0123456789qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM";
+
+/* to store the generated directory name */
+char name[10];
+int names;
+int parent_fd;
+
+/* NCHARS = 10 + 26 + 26 = 62 */
+#define NCHARS		62
+#define MAX_LEN1	62
+#define MAX_LEN2	(62 * 62)
+#define MAX_LEN3	(62 * 62 * 62)
+#define MAX_NAMES	(MAX_LEN1 + MAX_LEN2 + MAX_LEN3)
+
+void create_dir(void)
+{
+	if (mkdirat(parent_fd, name, S_IRWXU)) {
+		perror("mkdir");
+		exit(1);
+	}
+}
+
+/*
+ * create_1 - create length-1 directory names
+ * @n: how name names to be created
+ */
+void create_1(int n)
+{
+	int i;
+
+	name[1] = '\0';
+	for (i = 0; i < NCHARS; i++) {
+		name[0] = chars[i];
+		create_dir();
+		if (--n == 0)
+			return ;
+	}
+}
+
+/*
+ * create_2 - generate length-2 directory names
+ * @n: how many names to be created
+ */
+void create_2(int n)
+{
+	int i, j;
+
+	name[2] = '\0';
+	for (i = 0; i < NCHARS; i++) {
+		name[0] = chars[i];
+		for (j = 0; j < NCHARS; j++) {
+			name[1] = chars[j];
+			create_dir();
+			if (--n == 0)
+				return ;
+		}
+	}
+}
+
+/*
+ * create_3 - generate length-3 directory names
+ * @n: how many names to be created
+ */
+void create_3(int n)
+{
+	int i, j, k;
+
+	name[3] = '\0';
+	for (i = 0; i < NCHARS; i++) {
+		name[0] = chars[i];
+		for (j = 0; j < NCHARS; j++) {
+			name[1] = chars[j];
+			for (k = 0; k < NCHARS; k++) {
+				name[2] = chars[k];
+				create_dir();
+				if (--n == 0)
+					return ;
+			}
+		}
+	}
+}
+
+void usage()
+{
+	fprintf(stderr, "Usage: create_short_dirs nr_dirs parent_dir\n");
+}
+
+/*
+ * Create short-name directoriess
+ * @argv[1]: director number
+ * @argv[2]: the parent directory
+ */
+int main(int argc, char *argv[])
+{
+	if (argc != 3) {
+		usage();
+		return 1;
+	}
+
+	names = atoi(argv[1]);
+	if (names > MAX_NAMES || names <= 0) {
+		usage();
+		return 1;
+	}
+
+	parent_fd = open(argv[2], O_RDONLY);
+	if (parent_fd == -1) {
+		perror("open parent dir");
+		return 1;
+	}
+
+	create_1(names);
+	if (names <= MAX_LEN1)
+		return 0;
+
+	names -= MAX_LEN1;
+	create_2(names);
+	if (names <= MAX_LEN2)
+		return 0;
+
+	names -= MAX_LEN2;
+	create_3(names);
+
+	return 0;
+}
+
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh
new file mode 100644
index 0000000..42c4336
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh
@@ -0,0 +1,167 @@
+#!/bin/bash
+
+################################################################################
+##                                                                            ##
+## Copyright (c) 2009 FUJITSU LIMITED                                         ##
+##                                                                            ##
+## This program is free software;  you can redistribute it and#or modify      ##
+## it under the terms of the GNU General Public License as published by       ##
+## the Free Software Foundation; either version 2 of the License, or          ##
+## (at your option) any later version.                                        ##
+##                                                                            ##
+## This program is distributed in the hope that it will be useful, but        ##
+## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
+## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
+## for more details.                                                          ##
+##                                                                            ##
+## You should have received a copy of the GNU General Public License          ##
+## along with this program;  if not, write to the Free Software               ##
+## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
+##                                                                            ##
+## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
+##         Miao Xie <miaox@cn.fujitsu.com>                                    ##
+##                                                                            ##
+################################################################################
+
+cd $LTPROOT/testcases/bin
+
+. ./ext4_funcs.sh
+
+export TCID="ext4-subdir-limit"
+export TST_TOTAL=12
+export TST_COUNT=1
+
+# $1: the test config
+read_config $1
+
+TEST_DIR=$PWD
+SHORT_DIR=1
+LONG_DIR=2
+
+FAIL=1
+PASS=0
+
+prev_block_size=-1
+prev_result=$FAIL
+
+# Run a test case
+# $1: Number of directories to create
+# $2: create short dir or long dir
+# $3: parent directory
+# $4: filesystem block size
+ext4_run_case()
+{
+	local dir_name_len=
+
+	if [ $2 -eq $SHORT_DIR ]; then
+		dir_name_len="short name"
+	else
+		dir_name_len="long name"
+	fi
+
+	tst_resm TINFO "Num of dirs to create: $1, Dir name len: $dir_name_len \
+			Parent dir: $3, Block size: $4"
+
+	# only mkfs if block size has been changed,
+	# or previous case failed
+	if [ $prev_result -ne $PASS -o $4 -ne $prev_block_size ]; then
+		mkfs.ext4 -b $4 -I 256 $EXT4_DEV > /dev/null
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL "failed to create ext4 filesystem"
+			return 1
+		fi
+		prev_block_size=$4
+
+		tune2fs -E test_fs -O extents $EXT4_DEV
+	fi
+
+	prev_result=$FAIL
+
+	# mount ext4 filesystem
+	mount -t ext4 $EXT4_DEV mnt_point
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "failed to mount ext4 filesystem"
+		return 1
+	fi
+
+	# create directories
+	mkdir -p $3 2> /dev/null
+
+	if [ $2 -eq $SHORT_DIR ]; then
+		./create_short_dirs $1 $3
+	else
+		./create_long_dirs $1 $3
+	fi
+
+	if [ $? -ne 0 ]; then
+		nr_dirs=`ls $3 | wc -l`
+		tst_resm TFAIL "failed to create directories - $nr_dirs"
+		umount mnt_point
+		return 1
+	fi
+
+	# delete directories
+	cd $3
+	ls | xargs rmdir
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "failed to remove directories"
+
+		cd $TEST_DIR
+		umount mnt_point
+		return 1
+	fi
+	cd $TEST_DIR
+
+	# unmount ext4 filesystem
+	umount mnt_point
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "failed to umount ext4 filesystem"
+		return 1
+	fi
+
+	# run fsck to make sure the filesystem has no errors
+	e2fsck -p $EXT4_DEV
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "fsck: the filesystem has errors"
+		return 1
+	fi
+
+	# check dir_nlink is set
+	dumpe2fs $EXT4_DEV | grep '^Filesystem features' | grep -q dir_nlink
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "feature dir_nlink is not set"
+		return 1
+	fi
+
+	prev_result=$PASS
+	tst_resm TPASS "ext4 subdir limit test pass"
+}
+
+# main
+ext4_setup
+
+DIR_LEN=( $SHORT_DIR $LONG_DIR )
+PARENT_DIR=( "mnt_point" "mnt_point/sub" )
+BLOCK_SIZE=( 1024 2048 4096 )
+
+RET=0
+
+for ((i = 0; i < 3; i++))
+{
+	for ((j = 0; j < 2; j++))
+	{
+		for ((k = 0; k < 2; k++))
+		{
+			ext4_run_case 65537 ${DIR_LEN[$k]} ${PARENT_DIR[$j]} \
+					${BLOCK_SIZE[$i]}
+			if [ $? -ne 0 ]; then
+				RET=1
+			fi
+			: $((TST_COUNT++))
+		}
+	}
+}
+
+ext4_cleanup
+
+exit $RET
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/Makefile b/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/Makefile
new file mode 100644
index 0000000..4396397
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/Makefile
@@ -0,0 +1,12 @@
+SRCS = $(wildcard *.sh)
+
+all:
+	@true
+
+install:
+	@set -e;
+	for i in $(SRCS); do ln -f $$i ../../../../bin/$$i; chmod +x $$i; done;
+
+clean:
+	@true
+
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh
new file mode 100644
index 0000000..27cbb5f
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh
@@ -0,0 +1,161 @@
+#!/bin/bash
+
+################################################################################
+#                                                                              #
+# Copyright (c) 2009 FUJITSU LIMITED                                           #
+#                                                                              #
+# This program is free software;  you can redistribute it and#or modify        #
+# it under the terms of the GNU General Public License as published by         #
+# the Free Software Foundation; either version 2 of the License, or            #
+# (at your option) any later version.                                          #
+#                                                                              #
+# This program is distributed in the hope that it will be useful, but          #
+# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY   #
+# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License     #
+# for more details.                                                            #
+#                                                                              #
+# You should have received a copy of the GNU General Public License            #
+# along with this program;  if not, write to the Free Software                 #
+# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA      #
+#                                                                              #
+################################################################################
+
+cd $LTPROOT/testcases/bin
+
+. ./ext4_funcs.sh
+
+export TCID="ext4-uninit-groups"
+export TST_TOTAL=24
+export TST_COUNT=1
+
+export TEST_DIR=$PWD
+# $1: the test config
+read_config $1
+
+# How to age filesystem
+EMPTY=1
+SMALL=2
+LARGE=3
+
+# filesystem free size in bytes: blocks_size * free_blocks
+filesystem_free_size()
+{
+	bsize=`dumpe2fs -h $EXT4_DEV | grep 'Block size' | awk '{ print $2 }'`
+	blocks=`dumpe2fs -h $EXT4_DEV | grep 'Free blocks'| awk '{ print $2 }'`
+
+	echo $bsize * $blocks
+}
+
+age_filesystem()
+{
+	if [ $1 -eq $EMPTY ]; then
+		# aging, then del
+		./ffsb ffsb-config3 > /dev/null
+		rm -rf mnt_point/*
+	elif [ $1 -eq $SMALL ]; then
+		# age filesystem from 0.0 to 0.2 -> 0.4 -> 0.6 -> 0.8 -> 1.0
+		for ((n = 3; n < 8; n++))
+		{
+			./ffsb ffsb-config$n > /dev/null
+			mv mnt_point/data mnt_point/data$n
+		}
+	elif [ $1 -eq $LARGE ]; then
+		rm -rf mnt_point/*
+		bsize=`dumpe2fs -h $EXT4_DEV | grep 'Block size'`
+		bsize=`echo $bsize | awk '{ print $3 }'`
+		bcount=`dumpe2fs -h $EXT4_DEV | grep 'Free blocks'`
+		bcount=`echo $bcount | awk '{ print $3 }'`
+		dd if=/dev/zero of=mnt_point/tmp_dir bs=$bsize count=$bcount
+	else
+		return 1
+	fi
+
+	return 0
+}
+
+# Test uninitialized groups
+# $1: orlov, oldalloc
+# $2: delalloc
+# $3: flex_bg
+# $4: age filesystem: $EMPTY, $SMALL, $LARGE
+ext4_test_uninit_groups()
+{
+	mkfs.ext4 -I 256 -m 0 $EXT4_DEV > /dev/null
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "failed to create ext4 filesystem"
+		return 1
+	fi
+
+	if [ $3 == "no_flex_bg" ]; then
+		flag=""
+	else
+		flag=$3
+	fi
+
+	tune2fs -E test_fs -O extents,uninit_groups,$flag $EXT4_DEV
+
+	# Must run fsck after setting uninit_groups
+	fsck -p $EXT4_DEV > /dev/null
+
+	mount -t ext4 -o $1,$2 $EXT4_DEV mnt_point
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "failed to mount ext4 filesystem"
+		return 1
+	fi
+
+	age_filesystem $4
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "age filesystem failed"
+		umount mnt_point
+		return 1
+	fi
+
+	umount mnt_point
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "failed to umount ext4 filesystem"
+		return 1
+	fi
+
+	fsck -p $EXT4_DEV
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "fsck returned failure"
+		return 1
+	fi
+
+	tst_resm TPASS "ext4 uninit groups test pass"
+}
+
+# main
+ext4_setup
+
+ORLOV=( "orlov" "oldalloc" )
+DELALLOC=( "delalloc" "nodelalloc" )
+FLEX_BG=( "flex_bg" "no_flex_bg" )
+AGING=( $EMPTY $SMALL $LARGE )
+
+RET=0
+
+for ((i = 0; i < 2; i++))
+{
+	for ((j = 0; j < 2; j++))
+	{
+		for ((k = 0; k < 2; k++))
+		{
+			for ((l = 0; l < 3; l++))
+			{
+				ext4_test_uninit_groups ${ORLOV[$i]} \
+							${DELALLOC[$j]} \
+							${FLEX_BG[$k]} \
+							${AGING[$l]}
+				if [ $? -ne 0 ]; then
+					RET=1
+				fi
+				: $((TST_COUNT++))
+			}
+		}
+	}
+}
+
+ext4_cleanup
+
+exit $RET
diff --git a/testcases/kernel/fs/ext4-new-features/ext4_funcs.sh b/testcases/kernel/fs/ext4-new-features/ext4_funcs.sh
new file mode 100644
index 0000000..34fb65c
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ext4_funcs.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+
+################################################################################
+##                                                                            ##
+## Copyright (c) 2009 FUJITSU LIMITED                                         ##
+##                                                                            ##
+## This program is free software;  you can redistribute it and#or modify      ##
+## it under the terms of the GNU General Public License as published by       ##
+## the Free Software Foundation; either version 2 of the License, or          ##
+## (at your option) any later version.                                        ##
+##                                                                            ##
+## This program is distributed in the hope that it will be useful, but        ##
+## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
+## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
+## for more details.                                                          ##
+##                                                                            ##
+## You should have received a copy of the GNU General Public License          ##
+## along with this program;  if not, write to the Free Software               ##
+## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
+##                                                                            ##
+## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
+##         Miao Xie <miaox@cn.fujitsu.com>                                    ##
+##                                                                            ##
+################################################################################
+
+ext4_setup()
+{
+	mkdir mnt_point
+}
+
+ext4_cleanup()
+{
+	rmdir mnt_point
+}
+
+# $1: the config file
+read_config()
+{
+	while read config
+	do
+		echo $config | grep -q -E ".*=.*"
+		if [ $? -eq 0 ]; then
+			export $config
+		fi
+	done < $1
+}
+
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/AUTHORS b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/AUTHORS
new file mode 100644
index 0000000..85d037d
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/AUTHORS
@@ -0,0 +1,7 @@
+Dominique Heger (dheger@us.ibm.com)
+Josh Jacobs (josh@mit.edu)
+
+-> up to Version 3.0 of FFSB
+
+Sonny Rao (raosanth@us.ibm.com)
+versions 3.1 and beyond
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/COPYING b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/COPYING
new file mode 100644
index 0000000..e90dfed
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/COPYING
@@ -0,0 +1,340 @@
+		    GNU GENERAL PUBLIC LICENSE
+		       Version 2, June 1991
+
+ Copyright (C) 1989, 1991 Free Software Foundation, Inc.
+     59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ Everyone is permitted to copy and distribute verbatim copies
+ of this license document, but changing it is not allowed.
+
+			    Preamble
+
+  The licenses for most software are designed to take away your
+freedom to share and change it.  By contrast, the GNU General Public
+License is intended to guarantee your freedom to share and change free
+software--to make sure the software is free for all its users.  This
+General Public License applies to most of the Free Software
+Foundation's software and to any other program whose authors commit to
+using it.  (Some other Free Software Foundation software is covered by
+the GNU Library General Public License instead.)  You can apply it to
+your programs, too.
+
+  When we speak of free software, we are referring to freedom, not
+price.  Our General Public Licenses are designed to make sure that you
+have the freedom to distribute copies of free software (and charge for
+this service if you wish), that you receive source code or can get it
+if you want it, that you can change the software or use pieces of it
+in new free programs; and that you know you can do these things.
+
+  To protect your rights, we need to make restrictions that forbid
+anyone to deny you these rights or to ask you to surrender the rights.
+These restrictions translate to certain responsibilities for you if you
+distribute copies of the software, or if you modify it.
+
+  For example, if you distribute copies of such a program, whether
+gratis or for a fee, you must give the recipients all the rights that
+you have.  You must make sure that they, too, receive or can get the
+source code.  And you must show them these terms so they know their
+rights.
+
+  We protect your rights with two steps: (1) copyright the software, and
+(2) offer you this license which gives you legal permission to copy,
+distribute and/or modify the software.
+
+  Also, for each author's protection and ours, we want to make certain
+that everyone understands that there is no warranty for this free
+software.  If the software is modified by someone else and passed on, we
+want its recipients to know that what they have is not the original, so
+that any problems introduced by others will not reflect on the original
+authors' reputations.
+
+  Finally, any free program is threatened constantly by software
+patents.  We wish to avoid the danger that redistributors of a free
+program will individually obtain patent licenses, in effect making the
+program proprietary.  To prevent this, we have made it clear that any
+patent must be licensed for everyone's free use or not licensed at all.
+
+  The precise terms and conditions for copying, distribution and
+modification follow.
+
+		    GNU GENERAL PUBLIC LICENSE
+   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
+
+  0. This License applies to any program or other work which contains
+a notice placed by the copyright holder saying it may be distributed
+under the terms of this General Public License.  The "Program", below,
+refers to any such program or work, and a "work based on the Program"
+means either the Program or any derivative work under copyright law:
+that is to say, a work containing the Program or a portion of it,
+either verbatim or with modifications and/or translated into another
+language.  (Hereinafter, translation is included without limitation in
+the term "modification".)  Each licensee is addressed as "you".
+
+Activities other than copying, distribution and modification are not
+covered by this License; they are outside its scope.  The act of
+running the Program is not restricted, and the output from the Program
+is covered only if its contents constitute a work based on the
+Program (independent of having been made by running the Program).
+Whether that is true depends on what the Program does.
+
+  1. You may copy and distribute verbatim copies of the Program's
+source code as you receive it, in any medium, provided that you
+conspicuously and appropriately publish on each copy an appropriate
+copyright notice and disclaimer of warranty; keep intact all the
+notices that refer to this License and to the absence of any warranty;
+and give any other recipients of the Program a copy of this License
+along with the Program.
+
+You may charge a fee for the physical act of transferring a copy, and
+you may at your option offer warranty protection in exchange for a fee.
+
+  2. You may modify your copy or copies of the Program or any portion
+of it, thus forming a work based on the Program, and copy and
+distribute such modifications or work under the terms of Section 1
+above, provided that you also meet all of these conditions:
+
+    a) You must cause the modified files to carry prominent notices
+    stating that you changed the files and the date of any change.
+
+    b) You must cause any work that you distribute or publish, that in
+    whole or in part contains or is derived from the Program or any
+    part thereof, to be licensed as a whole at no charge to all third
+    parties under the terms of this License.
+
+    c) If the modified program normally reads commands interactively
+    when run, you must cause it, when started running for such
+    interactive use in the most ordinary way, to print or display an
+    announcement including an appropriate copyright notice and a
+    notice that there is no warranty (or else, saying that you provide
+    a warranty) and that users may redistribute the program under
+    these conditions, and telling the user how to view a copy of this
+    License.  (Exception: if the Program itself is interactive but
+    does not normally print such an announcement, your work based on
+    the Program is not required to print an announcement.)
+
+These requirements apply to the modified work as a whole.  If
+identifiable sections of that work are not derived from the Program,
+and can be reasonably considered independent and separate works in
+themselves, then this License, and its terms, do not apply to those
+sections when you distribute them as separate works.  But when you
+distribute the same sections as part of a whole which is a work based
+on the Program, the distribution of the whole must be on the terms of
+this License, whose permissions for other licensees extend to the
+entire whole, and thus to each and every part regardless of who wrote it.
+
+Thus, it is not the intent of this section to claim rights or contest
+your rights to work written entirely by you; rather, the intent is to
+exercise the right to control the distribution of derivative or
+collective works based on the Program.
+
+In addition, mere aggregation of another work not based on the Program
+with the Program (or with a work based on the Program) on a volume of
+a storage or distribution medium does not bring the other work under
+the scope of this License.
+
+  3. You may copy and distribute the Program (or a work based on it,
+under Section 2) in object code or executable form under the terms of
+Sections 1 and 2 above provided that you also do one of the following:
+
+    a) Accompany it with the complete corresponding machine-readable
+    source code, which must be distributed under the terms of Sections
+    1 and 2 above on a medium customarily used for software interchange; or,
+
+    b) Accompany it with a written offer, valid for at least three
+    years, to give any third party, for a charge no more than your
+    cost of physically performing source distribution, a complete
+    machine-readable copy of the corresponding source code, to be
+    distributed under the terms of Sections 1 and 2 above on a medium
+    customarily used for software interchange; or,
+
+    c) Accompany it with the information you received as to the offer
+    to distribute corresponding source code.  (This alternative is
+    allowed only for noncommercial distribution and only if you
+    received the program in object code or executable form with such
+    an offer, in accord with Subsection b above.)
+
+The source code for a work means the preferred form of the work for
+making modifications to it.  For an executable work, complete source
+code means all the source code for all modules it contains, plus any
+associated interface definition files, plus the scripts used to
+control compilation and installation of the executable.  However, as a
+special exception, the source code distributed need not include
+anything that is normally distributed (in either source or binary
+form) with the major components (compiler, kernel, and so on) of the
+operating system on which the executable runs, unless that component
+itself accompanies the executable.
+
+If distribution of executable or object code is made by offering
+access to copy from a designated place, then offering equivalent
+access to copy the source code from the same place counts as
+distribution of the source code, even though third parties are not
+compelled to copy the source along with the object code.
+
+  4. You may not copy, modify, sublicense, or distribute the Program
+except as expressly provided under this License.  Any attempt
+otherwise to copy, modify, sublicense or distribute the Program is
+void, and will automatically terminate your rights under this License.
+However, parties who have received copies, or rights, from you under
+this License will not have their licenses terminated so long as such
+parties remain in full compliance.
+
+  5. You are not required to accept this License, since you have not
+signed it.  However, nothing else grants you permission to modify or
+distribute the Program or its derivative works.  These actions are
+prohibited by law if you do not accept this License.  Therefore, by
+modifying or distributing the Program (or any work based on the
+Program), you indicate your acceptance of this License to do so, and
+all its terms and conditions for copying, distributing or modifying
+the Program or works based on it.
+
+  6. Each time you redistribute the Program (or any work based on the
+Program), the recipient automatically receives a license from the
+original licensor to copy, distribute or modify the Program subject to
+these terms and conditions.  You may not impose any further
+restrictions on the recipients' exercise of the rights granted herein.
+You are not responsible for enforcing compliance by third parties to
+this License.
+
+  7. If, as a consequence of a court judgment or allegation of patent
+infringement or for any other reason (not limited to patent issues),
+conditions are imposed on you (whether by court order, agreement or
+otherwise) that contradict the conditions of this License, they do not
+excuse you from the conditions of this License.  If you cannot
+distribute so as to satisfy simultaneously your obligations under this
+License and any other pertinent obligations, then as a consequence you
+may not distribute the Program at all.  For example, if a patent
+license would not permit royalty-free redistribution of the Program by
+all those who receive copies directly or indirectly through you, then
+the only way you could satisfy both it and this License would be to
+refrain entirely from distribution of the Program.
+
+If any portion of this section is held invalid or unenforceable under
+any particular circumstance, the balance of the section is intended to
+apply and the section as a whole is intended to apply in other
+circumstances.
+
+It is not the purpose of this section to induce you to infringe any
+patents or other property right claims or to contest validity of any
+such claims; this section has the sole purpose of protecting the
+integrity of the free software distribution system, which is
+implemented by public license practices.  Many people have made
+generous contributions to the wide range of software distributed
+through that system in reliance on consistent application of that
+system; it is up to the author/donor to decide if he or she is willing
+to distribute software through any other system and a licensee cannot
+impose that choice.
+
+This section is intended to make thoroughly clear what is believed to
+be a consequence of the rest of this License.
+
+  8. If the distribution and/or use of the Program is restricted in
+certain countries either by patents or by copyrighted interfaces, the
+original copyright holder who places the Program under this License
+may add an explicit geographical distribution limitation excluding
+those countries, so that distribution is permitted only in or among
+countries not thus excluded.  In such case, this License incorporates
+the limitation as if written in the body of this License.
+
+  9. The Free Software Foundation may publish revised and/or new versions
+of the General Public License from time to time.  Such new versions will
+be similar in spirit to the present version, but may differ in detail to
+address new problems or concerns.
+
+Each version is given a distinguishing version number.  If the Program
+specifies a version number of this License which applies to it and "any
+later version", you have the option of following the terms and conditions
+either of that version or of any later version published by the Free
+Software Foundation.  If the Program does not specify a version number of
+this License, you may choose any version ever published by the Free Software
+Foundation.
+
+  10. If you wish to incorporate parts of the Program into other free
+programs whose distribution conditions are different, write to the author
+to ask for permission.  For software which is copyrighted by the Free
+Software Foundation, write to the Free Software Foundation; we sometimes
+make exceptions for this.  Our decision will be guided by the two goals
+of preserving the free status of all derivatives of our free software and
+of promoting the sharing and reuse of software generally.
+
+			    NO WARRANTY
+
+  11. BECAUSE THE PROGRAM IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
+FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW.  EXCEPT WHEN
+OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
+PROVIDE THE PROGRAM "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED
+OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.  THE ENTIRE RISK AS
+TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU.  SHOULD THE
+PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING,
+REPAIR OR CORRECTION.
+
+  12. IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
+WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
+REDISTRIBUTE THE PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES,
+INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING
+OUT OF THE USE OR INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED
+TO LOSS OF DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY
+YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER
+PROGRAMS), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE
+POSSIBILITY OF SUCH DAMAGES.
+
+		     END OF TERMS AND CONDITIONS
+
+	    How to Apply These Terms to Your New Programs
+
+  If you develop a new program, and you want it to be of the greatest
+possible use to the public, the best way to achieve this is to make it
+free software which everyone can redistribute and change under these terms.
+
+  To do so, attach the following notices to the program.  It is safest
+to attach them to the start of each source file to most effectively
+convey the exclusion of warranty; and each file should have at least
+the "copyright" line and a pointer to where the full notice is found.
+
+    <one line to give the program's name and a brief idea of what it does.>
+    Copyright (C) <year>  <name of author>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+
+
+Also add information on how to contact you by electronic and paper mail.
+
+If the program is interactive, make it output a short notice like this
+when it starts in an interactive mode:
+
+    Gnomovision version 69, Copyright (C) year  name of author
+    Gnomovision comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
+    This is free software, and you are welcome to redistribute it
+    under certain conditions; type `show c' for details.
+
+The hypothetical commands `show w' and `show c' should show the appropriate
+parts of the General Public License.  Of course, the commands you use may
+be called something other than `show w' and `show c'; they could even be
+mouse-clicks or menu items--whatever suits your program.
+
+You should also get your employer (if you work as a programmer) or your
+school, if any, to sign a "copyright disclaimer" for the program, if
+necessary.  Here is a sample; alter the names:
+
+  Yoyodyne, Inc., hereby disclaims all copyright interest in the program
+  `Gnomovision' (which makes passes at compilers) written by James Hacker.
+
+  <signature of Ty Coon>, 1 April 1989
+  Ty Coon, President of Vice
+
+This General Public License does not permit incorporating your program into
+proprietary programs.  If your program is a subroutine library, you may
+consider it more useful to permit linking proprietary applications with the
+library.  If this is what you want to do, use the GNU Library General
+Public License instead of this License.
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/INSTALL b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/INSTALL
new file mode 100644
index 0000000..b42a17a
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/INSTALL
@@ -0,0 +1,182 @@
+Basic Installation
+==================
+
+   These are generic installation instructions.
+
+   The `configure' shell script attempts to guess correct values for
+various system-dependent variables used during compilation.  It uses
+those values to create a `Makefile' in each directory of the package.
+It may also create one or more `.h' files containing system-dependent
+definitions.  Finally, it creates a shell script `config.status' that
+you can run in the future to recreate the current configuration, a file
+`config.cache' that saves the results of its tests to speed up
+reconfiguring, and a file `config.log' containing compiler output
+(useful mainly for debugging `configure').
+
+   If you need to do unusual things to compile the package, please try
+to figure out how `configure' could check whether to do them, and mail
+diffs or instructions to the address given in the `README' so they can
+be considered for the next release.  If at some point `config.cache'
+contains results you don't want to keep, you may remove or edit it.
+
+   The file `configure.in' is used to create `configure' by a program
+called `autoconf'.  You only need `configure.in' if you want to change
+it or regenerate `configure' using a newer version of `autoconf'.
+
+The simplest way to compile this package is:
+
+  1. `cd' to the directory containing the package's source code and type
+     `./configure' to configure the package for your system.  If you're
+     using `csh' on an old version of System V, you might need to type
+     `sh ./configure' instead to prevent `csh' from trying to execute
+     `configure' itself.
+
+     Running `configure' takes awhile.  While running, it prints some
+     messages telling which features it is checking for.
+
+  2. Type `make' to compile the package.
+
+  3. Optionally, type `make check' to run any self-tests that come with
+     the package.
+
+  4. Type `make install' to install the programs and any data files and
+     documentation.
+
+  5. You can remove the program binaries and object files from the
+     source code directory by typing `make clean'.  To also remove the
+     files that `configure' created (so you can compile the package for
+     a different kind of computer), type `make distclean'.  There is
+     also a `make maintainer-clean' target, but that is intended mainly
+     for the package's developers.  If you use it, you may have to get
+     all sorts of other programs in order to regenerate files that came
+     with the distribution.
+
+Compilers and Options
+=====================
+
+   Some systems require unusual options for compilation or linking that
+the `configure' script does not know about.  You can give `configure'
+initial values for variables by setting them in the environment.  Using
+a Bourne-compatible shell, you can do that on the command line like
+this:
+     CC=c89 CFLAGS=-O2 LIBS=-lposix ./configure
+
+Or on systems that have the `env' program, you can do it like this:
+     env CPPFLAGS=-I/usr/local/include LDFLAGS=-s ./configure
+
+Compiling For Multiple Architectures
+====================================
+
+   You can compile the package for more than one kind of computer at the
+same time, by placing the object files for each architecture in their
+own directory.  To do this, you must use a version of `make' that
+supports the `VPATH' variable, such as GNU `make'.  `cd' to the
+directory where you want the object files and executables to go and run
+the `configure' script.  `configure' automatically checks for the
+source code in the directory that `configure' is in and in `..'.
+
+   If you have to use a `make' that does not supports the `VPATH'
+variable, you have to compile the package for one architecture at a time
+in the source code directory.  After you have installed the package for
+one architecture, use `make distclean' before reconfiguring for another
+architecture.
+
+Installation Names
+==================
+
+   By default, `make install' will install the package's files in
+`/usr/local/bin', `/usr/local/man', etc.  You can specify an
+installation prefix other than `/usr/local' by giving `configure' the
+option `--prefix=PATH'.
+
+   You can specify separate installation prefixes for
+architecture-specific files and architecture-independent files.  If you
+give `configure' the option `--exec-prefix=PATH', the package will use
+PATH as the prefix for installing programs and libraries.
+Documentation and other data files will still use the regular prefix.
+
+   In addition, if you use an unusual directory layout you can give
+options like `--bindir=PATH' to specify different values for particular
+kinds of files.  Run `configure --help' for a list of the directories
+you can set and what kinds of files go in them.
+
+   If the package supports it, you can cause programs to be installed
+with an extra prefix or suffix on their names by giving `configure' the
+option `--program-prefix=PREFIX' or `--program-suffix=SUFFIX'.
+
+Optional Features
+=================
+
+   Some packages pay attention to `--enable-FEATURE' options to
+`configure', where FEATURE indicates an optional part of the package.
+They may also pay attention to `--with-PACKAGE' options, where PACKAGE
+is something like `gnu-as' or `x' (for the X Window System).  The
+`README' should mention any `--enable-' and `--with-' options that the
+package recognizes.
+
+   For packages that use the X Window System, `configure' can usually
+find the X include and library files automatically, but if it doesn't,
+you can use the `configure' options `--x-includes=DIR' and
+`--x-libraries=DIR' to specify their locations.
+
+Specifying the System Type
+==========================
+
+   There may be some features `configure' can not figure out
+automatically, but needs to determine by the type of host the package
+will run on.  Usually `configure' can figure that out, but if it prints
+a message saying it can not guess the host type, give it the
+`--host=TYPE' option.  TYPE can either be a short name for the system
+type, such as `sun4', or a canonical name with three fields:
+     CPU-COMPANY-SYSTEM
+
+See the file `config.sub' for the possible values of each field.  If
+`config.sub' isn't included in this package, then this package doesn't
+need to know the host type.
+
+   If you are building compiler tools for cross-compiling, you can also
+use the `--target=TYPE' option to select the type of system they will
+produce code for and the `--build=TYPE' option to select the type of
+system on which you are compiling the package.
+
+Sharing Defaults
+================
+
+   If you want to set default values for `configure' scripts to share,
+you can create a site shell script called `config.site' that gives
+default values for variables like `CC', `cache_file', and `prefix'.
+`configure' looks for `PREFIX/share/config.site' if it exists, then
+`PREFIX/etc/config.site' if it exists.  Or, you can set the
+`CONFIG_SITE' environment variable to the location of the site script.
+A warning: not all `configure' scripts look for a site script.
+
+Operation Controls
+==================
+
+   `configure' recognizes the following options to control how it
+operates.
+
+`--cache-file=FILE'
+     Use and save the results of the tests in FILE instead of
+     `./config.cache'.  Set FILE to `/dev/null' to disable caching, for
+     debugging `configure'.
+
+`--help'
+     Print a summary of the options to `configure', and exit.
+
+`--quiet'
+`--silent'
+`-q'
+     Do not print messages saying which checks are being made.  To
+     suppress all normal output, redirect it to `/dev/null' (any error
+     messages will still be shown).
+
+`--srcdir=DIR'
+     Look for the package's source code in directory DIR.  Usually
+     `configure' can determine that directory automatically.
+
+`--version'
+     Print the version of Autoconf used to generate the `configure'
+     script, and exit.
+
+`configure' also accepts some other, not widely useful, options.
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/LICENSE b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/LICENSE
new file mode 100644
index 0000000..76d9f61
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/LICENSE
@@ -0,0 +1,347 @@
+		    GNU GENERAL PUBLIC LICENSE
+		       Version 2, June 1991
+
+ Copyright (C) 1989, 1991 Free Software Foundation, Inc.
+     59 Temple Place, Suite 330, Boston, MA 02111-1307, USA
+ Everyone is permitted to copy and distribute verbatim copies
+ of this license document, but changing it is not allowed.
+
+The Free Software Foundation has exempted Bash from the requirement of
+Paragraph 2c of the General Public License.  This is to say, there is
+no requirement for Bash to print a notice when it is started
+interactively in the usual way.  We made this exception because users
+and standards expect shells not to print such messages.  This
+exception applies to any program that serves as a shell and that is
+based primarily on Bash as opposed to other GNU software.
+
+			    Preamble
+
+  The licenses for most software are designed to take away your
+freedom to share and change it.  By contrast, the GNU General Public
+License is intended to guarantee your freedom to share and change free
+software--to make sure the software is free for all its users.  This
+General Public License applies to most of the Free Software
+Foundation's software and to any other program whose authors commit to
+using it.  (Some other Free Software Foundation software is covered by
+the GNU Library General Public License instead.)  You can apply it to
+your programs, too.
+
+  When we speak of free software, we are referring to freedom, not
+price.  Our General Public Licenses are designed to make sure that you
+have the freedom to distribute copies of free software (and charge for
+this service if you wish), that you receive source code or can get it
+if you want it, that you can change the software or use pieces of it
+in new free programs; and that you know you can do these things.
+
+  To protect your rights, we need to make restrictions that forbid
+anyone to deny you these rights or to ask you to surrender the rights.
+These restrictions translate to certain responsibilities for you if you
+distribute copies of the software, or if you modify it.
+
+  For example, if you distribute copies of such a program, whether
+gratis or for a fee, you must give the recipients all the rights that
+you have.  You must make sure that they, too, receive or can get the
+source code.  And you must show them these terms so they know their
+rights.
+
+  We protect your rights with two steps: (1) copyright the software, and
+(2) offer you this license which gives you legal permission to copy,
+distribute and/or modify the software.
+
+  Also, for each author's protection and ours, we want to make certain
+that everyone understands that there is no warranty for this free
+software.  If the software is modified by someone else and passed on, we
+want its recipients to know that what they have is not the original, so
+that any problems introduced by others will not reflect on the original
+authors' reputations.
+
+  Finally, any free program is threatened constantly by software
+patents.  We wish to avoid the danger that redistributors of a free
+program will individually obtain patent licenses, in effect making the
+program proprietary.  To prevent this, we have made it clear that any
+patent must be licensed for everyone's free use or not licensed at all.
+
+  The precise terms and conditions for copying, distribution and
+modification follow.
+
+		    GNU GENERAL PUBLIC LICENSE
+   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
+
+  0. This License applies to any program or other work which contains
+a notice placed by the copyright holder saying it may be distributed
+under the terms of this General Public License.  The "Program", below,
+refers to any such program or work, and a "work based on the Program"
+means either the Program or any derivative work under copyright law:
+that is to say, a work containing the Program or a portion of it,
+either verbatim or with modifications and/or translated into another
+language.  (Hereinafter, translation is included without limitation in
+the term "modification".)  Each licensee is addressed as "you".
+
+Activities other than copying, distribution and modification are not
+covered by this License; they are outside its scope.  The act of
+running the Program is not restricted, and the output from the Program
+is covered only if its contents constitute a work based on the
+Program (independent of having been made by running the Program).
+Whether that is true depends on what the Program does.
+
+  1. You may copy and distribute verbatim copies of the Program's
+source code as you receive it, in any medium, provided that you
+conspicuously and appropriately publish on each copy an appropriate
+copyright notice and disclaimer of warranty; keep intact all the
+notices that refer to this License and to the absence of any warranty;
+and give any other recipients of the Program a copy of this License
+along with the Program.
+
+You may charge a fee for the physical act of transferring a copy, and
+you may at your option offer warranty protection in exchange for a fee.
+
+  2. You may modify your copy or copies of the Program or any portion
+of it, thus forming a work based on the Program, and copy and
+distribute such modifications or work under the terms of Section 1
+above, provided that you also meet all of these conditions:
+
+    a) You must cause the modified files to carry prominent notices
+    stating that you changed the files and the date of any change.
+
+    b) You must cause any work that you distribute or publish, that in
+    whole or in part contains or is derived from the Program or any
+    part thereof, to be licensed as a whole at no charge to all third
+    parties under the terms of this License.
+
+    c) If the modified program normally reads commands interactively
+    when run, you must cause it, when started running for such
+    interactive use in the most ordinary way, to print or display an
+    announcement including an appropriate copyright notice and a
+    notice that there is no warranty (or else, saying that you provide
+    a warranty) and that users may redistribute the program under
+    these conditions, and telling the user how to view a copy of this
+    License.  (Exception: if the Program itself is interactive but
+    does not normally print such an announcement, your work based on
+    the Program is not required to print an announcement.)
+
+These requirements apply to the modified work as a whole.  If
+identifiable sections of that work are not derived from the Program,
+and can be reasonably considered independent and separate works in
+themselves, then this License, and its terms, do not apply to those
+sections when you distribute them as separate works.  But when you
+distribute the same sections as part of a whole which is a work based
+on the Program, the distribution of the whole must be on the terms of
+this License, whose permissions for other licensees extend to the
+entire whole, and thus to each and every part regardless of who wrote it.
+
+Thus, it is not the intent of this section to claim rights or contest
+your rights to work written entirely by you; rather, the intent is to
+exercise the right to control the distribution of derivative or
+collective works based on the Program.
+
+In addition, mere aggregation of another work not based on the Program
+with the Program (or with a work based on the Program) on a volume of
+a storage or distribution medium does not bring the other work under
+the scope of this License.
+
+  3. You may copy and distribute the Program (or a work based on it,
+under Section 2) in object code or executable form under the terms of
+Sections 1 and 2 above provided that you also do one of the following:
+
+    a) Accompany it with the complete corresponding machine-readable
+    source code, which must be distributed under the terms of Sections
+    1 and 2 above on a medium customarily used for software interchange; or,
+
+    b) Accompany it with a written offer, valid for at least three
+    years, to give any third party, for a charge no more than your
+    cost of physically performing source distribution, a complete
+    machine-readable copy of the corresponding source code, to be
+    distributed under the terms of Sections 1 and 2 above on a medium
+    customarily used for software interchange; or,
+
+    c) Accompany it with the information you received as to the offer
+    to distribute corresponding source code.  (This alternative is
+    allowed only for noncommercial distribution and only if you
+    received the program in object code or executable form with such
+    an offer, in accord with Subsection b above.)
+
+The source code for a work means the preferred form of the work for
+making modifications to it.  For an executable work, complete source
+code means all the source code for all modules it contains, plus any
+associated interface definition files, plus the scripts used to
+control compilation and installation of the executable.  However, as a
+special exception, the source code distributed need not include
+anything that is normally distributed (in either source or binary
+form) with the major components (compiler, kernel, and so on) of the
+operating system on which the executable runs, unless that component
+itself accompanies the executable.
+
+If distribution of executable or object code is made by offering
+access to copy from a designated place, then offering equivalent
+access to copy the source code from the same place counts as
+distribution of the source code, even though third parties are not
+compelled to copy the source along with the object code.
+
+  4. You may not copy, modify, sublicense, or distribute the Program
+except as expressly provided under this License.  Any attempt
+otherwise to copy, modify, sublicense or distribute the Program is
+void, and will automatically terminate your rights under this License.
+However, parties who have received copies, or rights, from you under
+this License will not have their licenses terminated so long as such
+parties remain in full compliance.
+
+  5. You are not required to accept this License, since you have not
+signed it.  However, nothing else grants you permission to modify or
+distribute the Program or its derivative works.  These actions are
+prohibited by law if you do not accept this License.  Therefore, by
+modifying or distributing the Program (or any work based on the
+Program), you indicate your acceptance of this License to do so, and
+all its terms and conditions for copying, distributing or modifying
+the Program or works based on it.
+
+  6. Each time you redistribute the Program (or any work based on the
+Program), the recipient automatically receives a license from the
+original licensor to copy, distribute or modify the Program subject to
+these terms and conditions.  You may not impose any further
+restrictions on the recipients' exercise of the rights granted herein.
+You are not responsible for enforcing compliance by third parties to
+this License.
+
+  7. If, as a consequence of a court judgment or allegation of patent
+infringement or for any other reason (not limited to patent issues),
+conditions are imposed on you (whether by court order, agreement or
+otherwise) that contradict the conditions of this License, they do not
+excuse you from the conditions of this License.  If you cannot
+distribute so as to satisfy simultaneously your obligations under this
+License and any other pertinent obligations, then as a consequence you
+may not distribute the Program at all.  For example, if a patent
+license would not permit royalty-free redistribution of the Program by
+all those who receive copies directly or indirectly through you, then
+the only way you could satisfy both it and this License would be to
+refrain entirely from distribution of the Program.
+
+If any portion of this section is held invalid or unenforceable under
+any particular circumstance, the balance of the section is intended to
+apply and the section as a whole is intended to apply in other
+circumstances.
+
+It is not the purpose of this section to induce you to infringe any
+patents or other property right claims or to contest validity of any
+such claims; this section has the sole purpose of protecting the
+integrity of the free software distribution system, which is
+implemented by public license practices.  Many people have made
+generous contributions to the wide range of software distributed
+through that system in reliance on consistent application of that
+system; it is up to the author/donor to decide if he or she is willing
+to distribute software through any other system and a licensee cannot
+impose that choice.
+
+This section is intended to make thoroughly clear what is believed to
+be a consequence of the rest of this License.
+
+  8. If the distribution and/or use of the Program is restricted in
+certain countries either by patents or by copyrighted interfaces, the
+original copyright holder who places the Program under this License
+may add an explicit geographical distribution limitation excluding
+those countries, so that distribution is permitted only in or among
+countries not thus excluded.  In such case, this License incorporates
+the limitation as if written in the body of this License.
+
+  9. The Free Software Foundation may publish revised and/or new versions
+of the General Public License from time to time.  Such new versions will
+be similar in spirit to the present version, but may differ in detail to
+address new problems or concerns.
+
+Each version is given a distinguishing version number.  If the Program
+specifies a version number of this License which applies to it and "any
+later version", you have the option of following the terms and conditions
+either of that version or of any later version published by the Free
+Software Foundation.  If the Program does not specify a version number of
+this License, you may choose any version ever published by the Free Software
+Foundation.
+
+  10. If you wish to incorporate parts of the Program into other free
+programs whose distribution conditions are different, write to the author
+to ask for permission.  For software which is copyrighted by the Free
+Software Foundation, write to the Free Software Foundation; we sometimes
+make exceptions for this.  Our decision will be guided by the two goals
+of preserving the free status of all derivatives of our free software and
+of promoting the sharing and reuse of software generally.
+
+			    NO WARRANTY
+
+  11. BECAUSE THE PROGRAM IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
+FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW.  EXCEPT WHEN
+OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
+PROVIDE THE PROGRAM "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED
+OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.  THE ENTIRE RISK AS
+TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU.  SHOULD THE
+PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING,
+REPAIR OR CORRECTION.
+
+  12. IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
+WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
+REDISTRIBUTE THE PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES,
+INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING
+OUT OF THE USE OR INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED
+TO LOSS OF DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY
+YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER
+PROGRAMS), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE
+POSSIBILITY OF SUCH DAMAGES.
+
+		     END OF TERMS AND CONDITIONS
+
+	Appendix: How to Apply These Terms to Your New Programs
+
+  If you develop a new program, and you want it to be of the greatest
+possible use to the public, the best way to achieve this is to make it
+free software which everyone can redistribute and change under these terms.
+
+  To do so, attach the following notices to the program.  It is safest
+to attach them to the start of each source file to most effectively
+convey the exclusion of warranty; and each file should have at least
+the "copyright" line and a pointer to where the full notice is found.
+
+    <one line to give the program's name and a brief idea of what it does.>
+    Copyright (C) 19yy  <name of author>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA
+
+Also add information on how to contact you by electronic and paper mail.
+
+If the program is interactive, make it output a short notice like this
+when it starts in an interactive mode:
+
+    Gnomovision version 69, Copyright (C) 19yy name of author
+    Gnomovision comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
+    This is free software, and you are welcome to redistribute it
+    under certain conditions; type `show c' for details.
+
+The hypothetical commands `show w' and `show c' should show the appropriate
+parts of the General Public License.  Of course, the commands you use may
+be called something other than `show w' and `show c'; they could even be
+mouse-clicks or menu items--whatever suits your program.
+
+You should also get your employer (if you work as a programmer) or your
+school, if any, to sign a "copyright disclaimer" for the program, if
+necessary.  Here is a sample; alter the names:
+
+  Yoyodyne, Inc., hereby disclaims all copyright interest in the program
+  `Gnomovision' (which makes passes at compilers) written by James Hacker.
+
+  <signature of Ty Coon>, 1 April 1989
+  Ty Coon, President of Vice
+
+This General Public License does not permit incorporating your program into
+proprietary programs.  If your program is a subroutine library, you may
+consider it more useful to permit linking proprietary applications with the
+library.  If this is what you want to do, use the GNU Library General
+Public License instead of this License.
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/Makefile.am b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/Makefile.am
new file mode 100644
index 0000000..9ed678b
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/Makefile.am
@@ -0,0 +1,46 @@
+bin_PROGRAMS = ffsb #ffsb_test
+ffsb_SOURCES = \
+	fileops.c \
+	rand.c \
+	config.h \
+	fileops.h \
+	ffsb.h \
+	rand.h \
+	main.c \
+	fh.h \
+	fh.c \
+	filelist.c \
+	filelist.h \
+	metaops.c \
+	metaops.h \
+	rwlock.h \
+	rwlock.c \
+	cirlist.c \
+	cirlist.h \
+	rbt.c \
+	rbt.h \
+	ffsb_tg.h \
+	ffsb_tg.c \
+	ffsb_fs.h \
+	ffsb_fs.c \
+	ffsb_thread.c \
+	ffsb_thread.h \
+	ffsb_op.h \
+	ffsb_op.c \
+	util.h \
+	util.c \
+	parser.c \
+	parser.h \
+	ffsb_fc.c \
+	ffsb_stats.c \
+	list.c
+
+#ffsb_test_SOURCES = config.h fileops.h ffsb.h rand.h fh.h filelist.h metaops.h rwlock.h cirlist.h rbt.h ffsb_tg.h ffsb_fs.h ffsb_thread.h ffsb_op.h util.h parser.c parser.h ffsb_test.c
+
+EXTRA_DIST = *.txt *.tex
+
+AM_CFLAGS = -D_GNU_SOURCE
+
+#CFLAGS += -Wall -Werror -g -Wconversion -ansi
+#LDFLAGS += -lefence
+
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/Makefile.in b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/Makefile.in
new file mode 100644
index 0000000..131dd5f
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/Makefile.in
@@ -0,0 +1,628 @@
+# Makefile.in generated by automake 1.10.1 from Makefile.am.
+# @configure_input@
+
+# Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
+# 2003, 2004, 2005, 2006, 2007, 2008  Free Software Foundation, Inc.
+# This Makefile.in is free software; the Free Software Foundation
+# gives unlimited permission to copy and/or distribute it,
+# with or without modifications, as long as this notice is preserved.
+
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY, to the extent permitted by law; without
+# even the implied warranty of MERCHANTABILITY or FITNESS FOR A
+# PARTICULAR PURPOSE.
+
+@SET_MAKE@
+
+VPATH = @srcdir@
+pkgdatadir = $(datadir)/@PACKAGE@
+pkglibdir = $(libdir)/@PACKAGE@
+pkgincludedir = $(includedir)/@PACKAGE@
+am__cd = CDPATH="$${ZSH_VERSION+.}$(PATH_SEPARATOR)" && cd
+install_sh_DATA = $(install_sh) -c -m 644
+install_sh_PROGRAM = $(install_sh) -c
+install_sh_SCRIPT = $(install_sh) -c
+INSTALL_HEADER = $(INSTALL_DATA)
+transform = $(program_transform_name)
+NORMAL_INSTALL = :
+PRE_INSTALL = :
+POST_INSTALL = :
+NORMAL_UNINSTALL = :
+PRE_UNINSTALL = :
+POST_UNINSTALL = :
+build_triplet = @build@
+host_triplet = @host@
+bin_PROGRAMS = ffsb$(EXEEXT)
+subdir = .
+DIST_COMMON = README $(am__configure_deps) $(srcdir)/Makefile.am \
+	$(srcdir)/Makefile.in $(srcdir)/config.h.in \
+	$(top_srcdir)/configure AUTHORS COPYING ChangeLog INSTALL NEWS \
+	config.guess config.sub depcomp install-sh missing \
+	mkinstalldirs
+ACLOCAL_M4 = $(top_srcdir)/aclocal.m4
+am__aclocal_m4_deps = $(top_srcdir)/configure.in
+am__configure_deps = $(am__aclocal_m4_deps) $(CONFIGURE_DEPENDENCIES) \
+	$(ACLOCAL_M4)
+am__CONFIG_DISTCLEAN_FILES = config.status config.cache config.log \
+ configure.lineno config.status.lineno
+mkinstalldirs = $(SHELL) $(top_srcdir)/mkinstalldirs
+CONFIG_HEADER = config.h
+CONFIG_CLEAN_FILES =
+am__installdirs = "$(DESTDIR)$(bindir)"
+binPROGRAMS_INSTALL = $(INSTALL_PROGRAM)
+PROGRAMS = $(bin_PROGRAMS)
+am_ffsb_OBJECTS = fileops.$(OBJEXT) rand.$(OBJEXT) main.$(OBJEXT) \
+	fh.$(OBJEXT) filelist.$(OBJEXT) metaops.$(OBJEXT) \
+	rwlock.$(OBJEXT) cirlist.$(OBJEXT) rbt.$(OBJEXT) \
+	ffsb_tg.$(OBJEXT) ffsb_fs.$(OBJEXT) ffsb_thread.$(OBJEXT) \
+	ffsb_op.$(OBJEXT) util.$(OBJEXT) parser.$(OBJEXT) \
+	ffsb_fc.$(OBJEXT) ffsb_stats.$(OBJEXT) list.$(OBJEXT)
+ffsb_OBJECTS = $(am_ffsb_OBJECTS)
+ffsb_LDADD = $(LDADD)
+DEFAULT_INCLUDES = -I.@am__isrc@
+depcomp = $(SHELL) $(top_srcdir)/depcomp
+am__depfiles_maybe = depfiles
+COMPILE = $(CC) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(AM_CPPFLAGS) \
+	$(CPPFLAGS) $(AM_CFLAGS) $(CFLAGS)
+CCLD = $(CC)
+LINK = $(CCLD) $(AM_CFLAGS) $(CFLAGS) $(AM_LDFLAGS) $(LDFLAGS) -o $@
+SOURCES = $(ffsb_SOURCES)
+DIST_SOURCES = $(ffsb_SOURCES)
+ETAGS = etags
+CTAGS = ctags
+DISTFILES = $(DIST_COMMON) $(DIST_SOURCES) $(TEXINFOS) $(EXTRA_DIST)
+distdir = $(PACKAGE)-$(VERSION)
+top_distdir = $(distdir)
+am__remove_distdir = \
+  { test ! -d $(distdir) \
+    || { find $(distdir) -type d ! -perm -200 -exec chmod u+w {} ';' \
+         && rm -fr $(distdir); }; }
+DIST_ARCHIVES = $(distdir).tar.gz
+GZIP_ENV = --best
+distuninstallcheck_listfiles = find . -type f -print
+distcleancheck_listfiles = find . -type f -print
+ACLOCAL = @ACLOCAL@
+AMTAR = @AMTAR@
+AUTOCONF = @AUTOCONF@
+AUTOHEADER = @AUTOHEADER@
+AUTOMAKE = @AUTOMAKE@
+AWK = @AWK@
+CC = @CC@
+CCDEPMODE = @CCDEPMODE@
+CFLAGS = @CFLAGS@
+CPP = @CPP@
+CPPFLAGS = @CPPFLAGS@
+CYGPATH_W = @CYGPATH_W@
+DEFS = @DEFS@
+DEPDIR = @DEPDIR@
+ECHO_C = @ECHO_C@
+ECHO_N = @ECHO_N@
+ECHO_T = @ECHO_T@
+EGREP = @EGREP@
+EXEEXT = @EXEEXT@
+GREP = @GREP@
+INSTALL = @INSTALL@
+INSTALL_DATA = @INSTALL_DATA@
+INSTALL_PROGRAM = @INSTALL_PROGRAM@
+INSTALL_SCRIPT = @INSTALL_SCRIPT@
+INSTALL_STRIP_PROGRAM = @INSTALL_STRIP_PROGRAM@
+LDFLAGS = @LDFLAGS@
+LIBOBJS = @LIBOBJS@
+LIBS = @LIBS@
+LTLIBOBJS = @LTLIBOBJS@
+MAKEINFO = @MAKEINFO@
+MKDIR_P = @MKDIR_P@
+OBJEXT = @OBJEXT@
+PACKAGE = @PACKAGE@
+PACKAGE_BUGREPORT = @PACKAGE_BUGREPORT@
+PACKAGE_NAME = @PACKAGE_NAME@
+PACKAGE_STRING = @PACKAGE_STRING@
+PACKAGE_TARNAME = @PACKAGE_TARNAME@
+PACKAGE_VERSION = @PACKAGE_VERSION@
+PATH_SEPARATOR = @PATH_SEPARATOR@
+SET_MAKE = @SET_MAKE@
+SHELL = @SHELL@
+STRIP = @STRIP@
+VERSION = @VERSION@
+abs_builddir = @abs_builddir@
+abs_srcdir = @abs_srcdir@
+abs_top_builddir = @abs_top_builddir@
+abs_top_srcdir = @abs_top_srcdir@
+ac_ct_CC = @ac_ct_CC@
+am__include = @am__include@
+am__leading_dot = @am__leading_dot@
+am__quote = @am__quote@
+am__tar = @am__tar@
+am__untar = @am__untar@
+bindir = @bindir@
+build = @build@
+build_alias = @build_alias@
+build_cpu = @build_cpu@
+build_os = @build_os@
+build_vendor = @build_vendor@
+builddir = @builddir@
+datadir = @datadir@
+datarootdir = @datarootdir@
+docdir = @docdir@
+dvidir = @dvidir@
+exec_prefix = @exec_prefix@
+host = @host@
+host_alias = @host_alias@
+host_cpu = @host_cpu@
+host_os = @host_os@
+host_vendor = @host_vendor@
+htmldir = @htmldir@
+includedir = @includedir@
+infodir = @infodir@
+install_sh = @install_sh@
+libdir = @libdir@
+libexecdir = @libexecdir@
+localedir = @localedir@
+localstatedir = @localstatedir@
+mandir = @mandir@
+mkdir_p = @mkdir_p@
+oldincludedir = @oldincludedir@
+pdfdir = @pdfdir@
+prefix = @prefix@
+program_transform_name = @program_transform_name@
+psdir = @psdir@
+sbindir = @sbindir@
+sharedstatedir = @sharedstatedir@
+srcdir = @srcdir@
+sysconfdir = @sysconfdir@
+target_alias = @target_alias@
+top_builddir = @top_builddir@
+top_srcdir = @top_srcdir@
+ffsb_SOURCES = \
+	fileops.c \
+	rand.c \
+	config.h \
+	fileops.h \
+	ffsb.h \
+	rand.h \
+	main.c \
+	fh.h \
+	fh.c \
+	filelist.c \
+	filelist.h \
+	metaops.c \
+	metaops.h \
+	rwlock.h \
+	rwlock.c \
+	cirlist.c \
+	cirlist.h \
+	rbt.c \
+	rbt.h \
+	ffsb_tg.h \
+	ffsb_tg.c \
+	ffsb_fs.h \
+	ffsb_fs.c \
+	ffsb_thread.c \
+	ffsb_thread.h \
+	ffsb_op.h \
+	ffsb_op.c \
+	util.h \
+	util.c \
+	parser.c \
+	parser.h \
+	ffsb_fc.c \
+	ffsb_stats.c \
+	list.c
+
+
+#ffsb_test_SOURCES = config.h fileops.h ffsb.h rand.h fh.h filelist.h metaops.h rwlock.h cirlist.h rbt.h ffsb_tg.h ffsb_fs.h ffsb_thread.h ffsb_op.h util.h parser.c parser.h ffsb_test.c
+EXTRA_DIST = *.txt *.tex
+AM_CFLAGS = -D_GNU_SOURCE
+all: config.h
+	$(MAKE) $(AM_MAKEFLAGS) all-am
+
+.SUFFIXES:
+.SUFFIXES: .c .o .obj
+am--refresh:
+	@:
+$(srcdir)/Makefile.in:  $(srcdir)/Makefile.am  $(am__configure_deps)
+	@for dep in $?; do \
+	  case '$(am__configure_deps)' in \
+	    *$$dep*) \
+	      echo ' cd $(srcdir) && $(AUTOMAKE) --gnu '; \
+	      cd $(srcdir) && $(AUTOMAKE) --gnu  \
+		&& exit 0; \
+	      exit 1;; \
+	  esac; \
+	done; \
+	echo ' cd $(top_srcdir) && $(AUTOMAKE) --gnu  Makefile'; \
+	cd $(top_srcdir) && \
+	  $(AUTOMAKE) --gnu  Makefile
+.PRECIOUS: Makefile
+Makefile: $(srcdir)/Makefile.in $(top_builddir)/config.status
+	@case '$?' in \
+	  *config.status*) \
+	    echo ' $(SHELL) ./config.status'; \
+	    $(SHELL) ./config.status;; \
+	  *) \
+	    echo ' cd $(top_builddir) && $(SHELL) ./config.status $@ $(am__depfiles_maybe)'; \
+	    cd $(top_builddir) && $(SHELL) ./config.status $@ $(am__depfiles_maybe);; \
+	esac;
+
+$(top_builddir)/config.status: $(top_srcdir)/configure $(CONFIG_STATUS_DEPENDENCIES)
+	$(SHELL) ./config.status --recheck
+
+$(top_srcdir)/configure:  $(am__configure_deps)
+	cd $(srcdir) && $(AUTOCONF)
+$(ACLOCAL_M4):  $(am__aclocal_m4_deps)
+	cd $(srcdir) && $(ACLOCAL) $(ACLOCAL_AMFLAGS)
+
+config.h: stamp-h1
+	@if test ! -f $@; then \
+	  rm -f stamp-h1; \
+	  $(MAKE) $(AM_MAKEFLAGS) stamp-h1; \
+	else :; fi
+
+stamp-h1: $(srcdir)/config.h.in $(top_builddir)/config.status
+	@rm -f stamp-h1
+	cd $(top_builddir) && $(SHELL) ./config.status config.h
+$(srcdir)/config.h.in:  $(am__configure_deps)
+	cd $(top_srcdir) && $(AUTOHEADER)
+	rm -f stamp-h1
+	touch $@
+
+distclean-hdr:
+	-rm -f config.h stamp-h1
+install-binPROGRAMS: $(bin_PROGRAMS)
+	@$(NORMAL_INSTALL)
+	test -z "$(bindir)" || $(MKDIR_P) "$(DESTDIR)$(bindir)"
+	@list='$(bin_PROGRAMS)'; for p in $$list; do \
+	  p1=`echo $$p|sed 's/$(EXEEXT)$$//'`; \
+	  if test -f $$p \
+	  ; then \
+	    f=`echo "$$p1" | sed 's,^.*/,,;$(transform);s/$$/$(EXEEXT)/'`; \
+	   echo " $(INSTALL_PROGRAM_ENV) $(binPROGRAMS_INSTALL) '$$p' '$(DESTDIR)$(bindir)/$$f'"; \
+	   $(INSTALL_PROGRAM_ENV) $(binPROGRAMS_INSTALL) "$$p" "$(DESTDIR)$(bindir)/$$f" || exit 1; \
+	  else :; fi; \
+	done
+
+uninstall-binPROGRAMS:
+	@$(NORMAL_UNINSTALL)
+	@list='$(bin_PROGRAMS)'; for p in $$list; do \
+	  f=`echo "$$p" | sed 's,^.*/,,;s/$(EXEEXT)$$//;$(transform);s/$$/$(EXEEXT)/'`; \
+	  echo " rm -f '$(DESTDIR)$(bindir)/$$f'"; \
+	  rm -f "$(DESTDIR)$(bindir)/$$f"; \
+	done
+
+clean-binPROGRAMS:
+	-test -z "$(bin_PROGRAMS)" || rm -f $(bin_PROGRAMS)
+ffsb$(EXEEXT): $(ffsb_OBJECTS) $(ffsb_DEPENDENCIES)
+	@rm -f ffsb$(EXEEXT)
+	$(LINK) $(ffsb_OBJECTS) $(ffsb_LDADD) $(LIBS)
+
+mostlyclean-compile:
+	-rm -f *.$(OBJEXT)
+
+distclean-compile:
+	-rm -f *.tab.c
+
+@AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/cirlist.Po@am__quote@
+@AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/ffsb_fc.Po@am__quote@
+@AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/ffsb_fs.Po@am__quote@
+@AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/ffsb_op.Po@am__quote@
+@AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/ffsb_stats.Po@am__quote@
+@AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/ffsb_tg.Po@am__quote@
+@AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/ffsb_thread.Po@am__quote@
+@AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/fh.Po@am__quote@
+@AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/filelist.Po@am__quote@
+@AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/fileops.Po@am__quote@
+@AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/list.Po@am__quote@
+@AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/main.Po@am__quote@
+@AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/metaops.Po@am__quote@
+@AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/parser.Po@am__quote@
+@AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/rand.Po@am__quote@
+@AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/rbt.Po@am__quote@
+@AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/rwlock.Po@am__quote@
+@AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/util.Po@am__quote@
+
+.c.o:
+@am__fastdepCC_TRUE@	$(COMPILE) -MT $@ -MD -MP -MF $(DEPDIR)/$*.Tpo -c -o $@ $<
+@am__fastdepCC_TRUE@	mv -f $(DEPDIR)/$*.Tpo $(DEPDIR)/$*.Po
+@AMDEP_TRUE@@am__fastdepCC_FALSE@	source='$<' object='$@' libtool=no @AMDEPBACKSLASH@
+@AMDEP_TRUE@@am__fastdepCC_FALSE@	DEPDIR=$(DEPDIR) $(CCDEPMODE) $(depcomp) @AMDEPBACKSLASH@
+@am__fastdepCC_FALSE@	$(COMPILE) -c $<
+
+.c.obj:
+@am__fastdepCC_TRUE@	$(COMPILE) -MT $@ -MD -MP -MF $(DEPDIR)/$*.Tpo -c -o $@ `$(CYGPATH_W) '$<'`
+@am__fastdepCC_TRUE@	mv -f $(DEPDIR)/$*.Tpo $(DEPDIR)/$*.Po
+@AMDEP_TRUE@@am__fastdepCC_FALSE@	source='$<' object='$@' libtool=no @AMDEPBACKSLASH@
+@AMDEP_TRUE@@am__fastdepCC_FALSE@	DEPDIR=$(DEPDIR) $(CCDEPMODE) $(depcomp) @AMDEPBACKSLASH@
+@am__fastdepCC_FALSE@	$(COMPILE) -c `$(CYGPATH_W) '$<'`
+
+ID: $(HEADERS) $(SOURCES) $(LISP) $(TAGS_FILES)
+	list='$(SOURCES) $(HEADERS) $(LISP) $(TAGS_FILES)'; \
+	unique=`for i in $$list; do \
+	    if test -f "$$i"; then echo $$i; else echo $(srcdir)/$$i; fi; \
+	  done | \
+	  $(AWK) '{ files[$$0] = 1; nonemtpy = 1; } \
+	      END { if (nonempty) { for (i in files) print i; }; }'`; \
+	mkid -fID $$unique
+tags: TAGS
+
+TAGS:  $(HEADERS) $(SOURCES) config.h.in $(TAGS_DEPENDENCIES) \
+		$(TAGS_FILES) $(LISP)
+	tags=; \
+	here=`pwd`; \
+	list='$(SOURCES) $(HEADERS) config.h.in $(LISP) $(TAGS_FILES)'; \
+	unique=`for i in $$list; do \
+	    if test -f "$$i"; then echo $$i; else echo $(srcdir)/$$i; fi; \
+	  done | \
+	  $(AWK) '{ files[$$0] = 1; nonempty = 1; } \
+	      END { if (nonempty) { for (i in files) print i; }; }'`; \
+	if test -z "$(ETAGS_ARGS)$$tags$$unique"; then :; else \
+	  test -n "$$unique" || unique=$$empty_fix; \
+	  $(ETAGS) $(ETAGSFLAGS) $(AM_ETAGSFLAGS) $(ETAGS_ARGS) \
+	    $$tags $$unique; \
+	fi
+ctags: CTAGS
+CTAGS:  $(HEADERS) $(SOURCES) config.h.in $(TAGS_DEPENDENCIES) \
+		$(TAGS_FILES) $(LISP)
+	tags=; \
+	list='$(SOURCES) $(HEADERS) config.h.in $(LISP) $(TAGS_FILES)'; \
+	unique=`for i in $$list; do \
+	    if test -f "$$i"; then echo $$i; else echo $(srcdir)/$$i; fi; \
+	  done | \
+	  $(AWK) '{ files[$$0] = 1; nonempty = 1; } \
+	      END { if (nonempty) { for (i in files) print i; }; }'`; \
+	test -z "$(CTAGS_ARGS)$$tags$$unique" \
+	  || $(CTAGS) $(CTAGSFLAGS) $(AM_CTAGSFLAGS) $(CTAGS_ARGS) \
+	     $$tags $$unique
+
+GTAGS:
+	here=`$(am__cd) $(top_builddir) && pwd` \
+	  && cd $(top_srcdir) \
+	  && gtags -i $(GTAGS_ARGS) $$here
+
+distclean-tags:
+	-rm -f TAGS ID GTAGS GRTAGS GSYMS GPATH tags
+
+distdir: $(DISTFILES)
+	$(am__remove_distdir)
+	test -d $(distdir) || mkdir $(distdir)
+	@srcdirstrip=`echo "$(srcdir)" | sed 's/[].[^$$\\*]/\\\\&/g'`; \
+	topsrcdirstrip=`echo "$(top_srcdir)" | sed 's/[].[^$$\\*]/\\\\&/g'`; \
+	list='$(DISTFILES)'; \
+	  dist_files=`for file in $$list; do echo $$file; done | \
+	  sed -e "s|^$$srcdirstrip/||;t" \
+	      -e "s|^$$topsrcdirstrip/|$(top_builddir)/|;t"`; \
+	case $$dist_files in \
+	  */*) $(MKDIR_P) `echo "$$dist_files" | \
+			   sed '/\//!d;s|^|$(distdir)/|;s,/[^/]*$$,,' | \
+			   sort -u` ;; \
+	esac; \
+	for file in $$dist_files; do \
+	  if test -f $$file || test -d $$file; then d=.; else d=$(srcdir); fi; \
+	  if test -d $$d/$$file; then \
+	    dir=`echo "/$$file" | sed -e 's,/[^/]*$$,,'`; \
+	    if test -d $(srcdir)/$$file && test $$d != $(srcdir); then \
+	      cp -pR $(srcdir)/$$file $(distdir)$$dir || exit 1; \
+	    fi; \
+	    cp -pR $$d/$$file $(distdir)$$dir || exit 1; \
+	  else \
+	    test -f $(distdir)/$$file \
+	    || cp -p $$d/$$file $(distdir)/$$file \
+	    || exit 1; \
+	  fi; \
+	done
+	-find $(distdir) -type d ! -perm -777 -exec chmod a+rwx {} \; -o \
+	  ! -type d ! -perm -444 -links 1 -exec chmod a+r {} \; -o \
+	  ! -type d ! -perm -400 -exec chmod a+r {} \; -o \
+	  ! -type d ! -perm -444 -exec $(install_sh) -c -m a+r {} {} \; \
+	|| chmod -R a+r $(distdir)
+dist-gzip: distdir
+	tardir=$(distdir) && $(am__tar) | GZIP=$(GZIP_ENV) gzip -c >$(distdir).tar.gz
+	$(am__remove_distdir)
+
+dist-bzip2: distdir
+	tardir=$(distdir) && $(am__tar) | bzip2 -9 -c >$(distdir).tar.bz2
+	$(am__remove_distdir)
+
+dist-lzma: distdir
+	tardir=$(distdir) && $(am__tar) | lzma -9 -c >$(distdir).tar.lzma
+	$(am__remove_distdir)
+
+dist-tarZ: distdir
+	tardir=$(distdir) && $(am__tar) | compress -c >$(distdir).tar.Z
+	$(am__remove_distdir)
+
+dist-shar: distdir
+	shar $(distdir) | GZIP=$(GZIP_ENV) gzip -c >$(distdir).shar.gz
+	$(am__remove_distdir)
+
+dist-zip: distdir
+	-rm -f $(distdir).zip
+	zip -rq $(distdir).zip $(distdir)
+	$(am__remove_distdir)
+
+dist dist-all: distdir
+	tardir=$(distdir) && $(am__tar) | GZIP=$(GZIP_ENV) gzip -c >$(distdir).tar.gz
+	$(am__remove_distdir)
+
+# This target untars the dist file and tries a VPATH configuration.  Then
+# it guarantees that the distribution is self-contained by making another
+# tarfile.
+distcheck: dist
+	case '$(DIST_ARCHIVES)' in \
+	*.tar.gz*) \
+	  GZIP=$(GZIP_ENV) gunzip -c $(distdir).tar.gz | $(am__untar) ;;\
+	*.tar.bz2*) \
+	  bunzip2 -c $(distdir).tar.bz2 | $(am__untar) ;;\
+	*.tar.lzma*) \
+	  unlzma -c $(distdir).tar.lzma | $(am__untar) ;;\
+	*.tar.Z*) \
+	  uncompress -c $(distdir).tar.Z | $(am__untar) ;;\
+	*.shar.gz*) \
+	  GZIP=$(GZIP_ENV) gunzip -c $(distdir).shar.gz | unshar ;;\
+	*.zip*) \
+	  unzip $(distdir).zip ;;\
+	esac
+	chmod -R a-w $(distdir); chmod a+w $(distdir)
+	mkdir $(distdir)/_build
+	mkdir $(distdir)/_inst
+	chmod a-w $(distdir)
+	dc_install_base=`$(am__cd) $(distdir)/_inst && pwd | sed -e 's,^[^:\\/]:[\\/],/,'` \
+	  && dc_destdir="$${TMPDIR-/tmp}/am-dc-$$$$/" \
+	  && cd $(distdir)/_build \
+	  && ../configure --srcdir=.. --prefix="$$dc_install_base" \
+	    $(DISTCHECK_CONFIGURE_FLAGS) \
+	  && $(MAKE) $(AM_MAKEFLAGS) \
+	  && $(MAKE) $(AM_MAKEFLAGS) dvi \
+	  && $(MAKE) $(AM_MAKEFLAGS) check \
+	  && $(MAKE) $(AM_MAKEFLAGS) install \
+	  && $(MAKE) $(AM_MAKEFLAGS) installcheck \
+	  && $(MAKE) $(AM_MAKEFLAGS) uninstall \
+	  && $(MAKE) $(AM_MAKEFLAGS) distuninstallcheck_dir="$$dc_install_base" \
+	        distuninstallcheck \
+	  && chmod -R a-w "$$dc_install_base" \
+	  && ({ \
+	       (cd ../.. && umask 077 && mkdir "$$dc_destdir") \
+	       && $(MAKE) $(AM_MAKEFLAGS) DESTDIR="$$dc_destdir" install \
+	       && $(MAKE) $(AM_MAKEFLAGS) DESTDIR="$$dc_destdir" uninstall \
+	       && $(MAKE) $(AM_MAKEFLAGS) DESTDIR="$$dc_destdir" \
+	            distuninstallcheck_dir="$$dc_destdir" distuninstallcheck; \
+	      } || { rm -rf "$$dc_destdir"; exit 1; }) \
+	  && rm -rf "$$dc_destdir" \
+	  && $(MAKE) $(AM_MAKEFLAGS) dist \
+	  && rm -rf $(DIST_ARCHIVES) \
+	  && $(MAKE) $(AM_MAKEFLAGS) distcleancheck
+	$(am__remove_distdir)
+	@(echo "$(distdir) archives ready for distribution: "; \
+	  list='$(DIST_ARCHIVES)'; for i in $$list; do echo $$i; done) | \
+	  sed -e 1h -e 1s/./=/g -e 1p -e 1x -e '$$p' -e '$$x'
+distuninstallcheck:
+	@cd $(distuninstallcheck_dir) \
+	&& test `$(distuninstallcheck_listfiles) | wc -l` -le 1 \
+	   || { echo "ERROR: files left after uninstall:" ; \
+	        if test -n "$(DESTDIR)"; then \
+	          echo "  (check DESTDIR support)"; \
+	        fi ; \
+	        $(distuninstallcheck_listfiles) ; \
+	        exit 1; } >&2
+distcleancheck: distclean
+	@if test '$(srcdir)' = . ; then \
+	  echo "ERROR: distcleancheck can only run from a VPATH build" ; \
+	  exit 1 ; \
+	fi
+	@test `$(distcleancheck_listfiles) | wc -l` -eq 0 \
+	  || { echo "ERROR: files left in build directory after distclean:" ; \
+	       $(distcleancheck_listfiles) ; \
+	       exit 1; } >&2
+check-am: all-am
+check: check-am
+all-am: Makefile $(PROGRAMS) config.h
+installdirs:
+	for dir in "$(DESTDIR)$(bindir)"; do \
+	  test -z "$$dir" || $(MKDIR_P) "$$dir"; \
+	done
+install: install-am
+install-exec: install-exec-am
+install-data: install-data-am
+uninstall: uninstall-am
+
+install-am: all-am
+	@$(MAKE) $(AM_MAKEFLAGS) install-exec-am install-data-am
+
+installcheck: installcheck-am
+install-strip:
+	$(MAKE) $(AM_MAKEFLAGS) INSTALL_PROGRAM="$(INSTALL_STRIP_PROGRAM)" \
+	  install_sh_PROGRAM="$(INSTALL_STRIP_PROGRAM)" INSTALL_STRIP_FLAG=-s \
+	  `test -z '$(STRIP)' || \
+	    echo "INSTALL_PROGRAM_ENV=STRIPPROG='$(STRIP)'"` install
+mostlyclean-generic:
+
+clean-generic:
+
+distclean-generic:
+	-test -z "$(CONFIG_CLEAN_FILES)" || rm -f $(CONFIG_CLEAN_FILES)
+
+maintainer-clean-generic:
+	@echo "This command is intended for maintainers to use"
+	@echo "it deletes files that may require special tools to rebuild."
+clean: clean-am
+
+clean-am: clean-binPROGRAMS clean-generic mostlyclean-am
+
+distclean: distclean-am
+	-rm -f $(am__CONFIG_DISTCLEAN_FILES)
+	-rm -rf ./$(DEPDIR)
+	-rm -f Makefile
+distclean-am: clean-am distclean-compile distclean-generic \
+	distclean-hdr distclean-tags
+
+dvi: dvi-am
+
+dvi-am:
+
+html: html-am
+
+info: info-am
+
+info-am:
+
+install-data-am:
+
+install-dvi: install-dvi-am
+
+install-exec-am: install-binPROGRAMS
+
+install-html: install-html-am
+
+install-info: install-info-am
+
+install-man:
+
+install-pdf: install-pdf-am
+
+install-ps: install-ps-am
+
+installcheck-am:
+
+maintainer-clean: maintainer-clean-am
+	-rm -f $(am__CONFIG_DISTCLEAN_FILES)
+	-rm -rf $(top_srcdir)/autom4te.cache
+	-rm -rf ./$(DEPDIR)
+	-rm -f Makefile
+maintainer-clean-am: distclean-am maintainer-clean-generic
+
+mostlyclean: mostlyclean-am
+
+mostlyclean-am: mostlyclean-compile mostlyclean-generic
+
+pdf: pdf-am
+
+pdf-am:
+
+ps: ps-am
+
+ps-am:
+
+uninstall-am: uninstall-binPROGRAMS
+
+.MAKE: install-am install-strip
+
+.PHONY: CTAGS GTAGS all all-am am--refresh check check-am clean \
+	clean-binPROGRAMS clean-generic ctags dist dist-all dist-bzip2 \
+	dist-gzip dist-lzma dist-shar dist-tarZ dist-zip distcheck \
+	distclean distclean-compile distclean-generic distclean-hdr \
+	distclean-tags distcleancheck distdir distuninstallcheck dvi \
+	dvi-am html html-am info info-am install install-am \
+	install-binPROGRAMS install-data install-data-am install-dvi \
+	install-dvi-am install-exec install-exec-am install-html \
+	install-html-am install-info install-info-am install-man \
+	install-pdf install-pdf-am install-ps install-ps-am \
+	install-strip installcheck installcheck-am installdirs \
+	maintainer-clean maintainer-clean-generic mostlyclean \
+	mostlyclean-compile mostlyclean-generic pdf pdf-am ps ps-am \
+	tags uninstall uninstall-am uninstall-binPROGRAMS
+
+
+#CFLAGS += -Wall -Werror -g -Wconversion -ansi
+#LDFLAGS += -lefence
+# Tell versions [3.59,3.63) of GNU make to not export all variables.
+# Otherwise a system limit (for SysV at least) may be exceeded.
+.NOEXPORT:
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/README b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/README
new file mode 100644
index 0000000..077f64b
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/README
@@ -0,0 +1,413 @@
+Introduction:
+
+The Flexible Filesystem Benchmark (FFSB) is a filesystem performance
+measurement tool.  It is a multi-threaded application (using
+pthreads), written entirely in C with cross-platform portability in
+mind.  It differs from other filesystem benchmarks in that the user
+may supply a profile to create custom workloads, while most other
+filesystem benchmarks use a fixed set of workloads.
+
+As of version 5.1, it supports seven different basic operations, support
+for multiple groups of threads with different operation mixtures,
+support for operation across multiple filesystems, and support for
+filesystem aging prior to benchmarking.
+
+
+Differences from version 4.0 and older:
+
+Version 5.0 and above represent almost a total re-write and many
+things have changed.  In version 5.0 and above FFSB moved to a
+time-regulated run versus doing a set number of different operations
+and timing the whole thing.  This is primarily to better deal with the
+use of multiple threadgroups which would otherwise not be synchronized
+at termination time.
+
+Additionally, the FFSB configuration file format has changed in
+version 5.0, although we do support old-style configuration files
+along with a run-time passed on the command line.  In this mode,
+version 5.0 and above ignores the iterations parameter, and simply
+uses the time specified on the command line.
+
+Behaviorally, most of the old operations are the same -- sequential
+reads and sequential writes work as they did before.  One change in
+version 5.0 is the skip-read behavior of reading then seeking forward
+a fixed amount then reading again is removed, we now support fully
+randomized reads and writes from random offsets within the file.
+
+Version 4.0 didn't support overwrites (only appends) so we interpret
+writes in old config files to be append operations.
+
+On Linux, CPU utilization information will only be accurate for
+systems using NPTL, older Linuxthreads systems will probably only see
+zeros for CPU utilization because Linuxthreads is non-compliant to
+POSIX. Version 4.0 and older could be recompiled to work on
+Linuxthreads, but in 5.0 and later we no longer support this.
+
+We no longer support the "outputfile" on the command line.
+
+One should simply use tee or similar to capture the output.  FFSB
+unbuffers standard out for this purpose, and errors are sent on
+standard error.
+
+Global options:
+
+There are eight valid global options placed at the beginning of the
+profile.  Three of them are required: num_filesystems (number of
+filesystems), num_threadgroups (number of threadgroups), and time
+(running time of the benchmark).  The other five options are:
+
+directio   - each call to open will be made using O_DIRECT
+alignio    - aligns all block operations for random reads and writes
+             on 4k boundaries.
+bufferedio - currently ignorred: it is intended to use libc
+             fread,rwrite, instead of just unix read and write calls
+verbose    - currently ignored
+
+callout    - calls and external command and waits for its termination
+	     before FFSB begins the benchmark phase.
+	     This is useful for synchronizing distributed clients,
+	     starting profilers, etc.
+
+They must be specified in the above order (num_filesystems,
+num_threadgroups, time, directio, alignio, bufferedio, verbose,
+callout).
+
+
+
+Filesystems:
+
+Filesystems are specified to FFSB in the form of a directory.  FFSB
+assumes that the filesystem is mounted at this directory and will not
+do any verification of this fact beyond ensuring it can read/write to
+the location.  So be careful to ensure something with enough space to
+handle the dataset is in fact mounted at the specified location.
+
+In the filesystem clause of the profile, one may set the starting
+number of files and directories as well as a minimum and maximum
+filesize for the filesystem.  One may also specify the blocksize
+used for creating the files separately in the filesystem clause.
+
+Also, if a filesystem is to be aged, a special threadgroup clause may
+be embedded in a filesystem clause to specify the operation mixture
+and number of threads used to age the filesystem.  This threadgroup is
+run until filesystem utilization reaches the specified amount.
+
+Inheritance --  if you are using multiple filesystems, all attributes
+except the location should be inherited from the previous filesystem.
+This is done to make it easier to add groups of similar filesystems.
+In this case, only the location is required in the filesystem clause.
+
+As of version 5.1, filesystem re-use is supported if a given
+filesystem hasn't been modified beyond it's orginal specifications
+(number of files and directories is correct, and file sizes are within
+specifications).  This can be a huge time saver if one wishes to do
+multiple runs on the same data-set without altering it during a run,
+because the fileset doesn't need to be recreated before each run.
+
+To do this, specify "reuse=1" in the filesystem clause, and FFSB will
+verify the fileset first, and if it checks out it will use it.
+Otherwise, it will remove everything and re-create the filesets for
+that filesystem.
+
+Threadgroups:
+
+An arbitrary number of threadgroups with differing numbers of threads
+and operation mixes can be specified.  The operations are specified
+using a weighting for each operation, if an operation isn't specified
+it's weighting is assumed to be zero (not used).
+
+"Think-time" for a threadgroup may also be specified in millisecond
+amounts using the "op_delay" parameter, where every thread will wait
+for the specified amount between each operation.
+
+Operations:
+
+All operations begin by randomly selecting a filesystem from the list
+of filesystems specified in the profile.  The distribution aims to be
+uniform across all filesystems.
+
+
+The seven operations are:
+
+reads  - read() calls with an overall amount and a blocksize
+         operates on existing files.  Care must be taken to ensure
+         that the read amount is smaller than the size of any possible
+         file.
+
+	 If random_read is specified, then the each individual blocks
+         will be read starting from a random point with the file, and
+         this will continune until the entire amount specifed has been
+         read.  This offset of each random block will be totally
+         random to the byte level, unless the "alignio" global parameter
+         is on, and then the reads will be 4096 byte aligned.  This is
+         generally recommended.
+
+
+readall - Very similar to read above, except it doesn't take an
+          amount; it simply reads the entire file sequentially using the
+          read_blocksize.   This is useful for situations where
+	  different filesystems have differently sized files, and sequential
+	  read patterns across all filesystems are desired.
+
+writes - write() calls with an overall amount and blocksize
+         this is an overwrite operation and will not enlarge an existing
+         file, again one must be careful not to specify a write amount
+         that is larger than any possible file in the data set.
+
+	 If random_write is specified, then the each individual blocks
+         will be written starting from a random point with the file, and
+         this will continune until the entire amount specifed has been
+         written out.  This offset of each random block will be totally
+         random to the byte level, unless the "alignio" global parameter
+         is on, and then the writes will be 4096 byte aligned.  This
+         is generally recommended.
+
+	 If the fsync_flag parameter for the threadgroup is non-zero,
+	 then after all of the write calls are finished, fsync() will
+   	 be called on the file descriptor before the file is closed.
+
+
+creates - creates a file using open() call and determines the size
+          randomly between on the constraints (min_filesize and
+          max_filesize) for the selected filesystem. Write operations will
+          be done using the same blocksize as is specified for the
+          write operation.
+deletes - calls unlink() on a filename and removes it from the
+          internal data-structures.  One must be careful to ensure
+          there are enough files to delete at all times or else the benchmark
+          will terminate.
+appends - calls write() using the append flag with an overall amount
+          and a blocksize to be appended onto a randomly chosen file.
+metas   - this is actually a mix of several different directory
+          operations.  Each "meta" operation consists of two directory
+          creates, one directory remove, and a directory rename.
+          These operations are all carried out separately from the
+          other 5 operations.
+
+Operation accounting:
+
+Each operation which uses a blocksize counts each read/write of a
+blocksize as an operation (reads,writes,creates, and appends) whereas
+deletes and metas are considered single operations.
+
+Running the benchmark:
+
+There are three phases to running the benchmark, aging, fileset
+creates, and the benchmark phase.
+
+The create phase is carried out across all filesystems simultanously
+with one dedicated thread per filesystem.
+
+After the create phase, sync() is called to ensure all dirty data gets
+written out before the benchmark phase begins, and sync() is again
+called at the end of the benchmark phase.  The time in sync() at the
+end of the benchmark phase is counted as part of the benchmark phase.
+
+Caveats/Holes/Bugs:
+
+Aging and aging across multiple filesystems simultaneously hasn't been tested
+very much.
+
+If *any* i/o operation or system call/libc call fails, the benchmark
+will terminate immediately.
+
+The parser doesn't handle mal-formed or incorrect profiles very well
+(or at all).
+
+The parser doesn't check to make sure all of the appropriate options
+have been specified.  For example, if writes are specified in a
+threadgroup but write_blocksize isn't specified, the parse won't catch
+it, but the benchmark run will fail later on.
+
+
+Configuration Files (new style):
+
+New Style Configuration allows for arbitrary newlines between lines,
+and comments using '#' at the start of a line.  Also it allows tabs,
+whitespace before and after configuration parameters.
+
+The new style configuration file is broken up into three main parts:
+
+global parameters, filesystems, and threadgroups
+
+The sections must be in the above order.
+
+Global parameters:
+
+Global Paramters are described above, the first three are always
+required. Example:
+
+----------
+
+num_filesystems=1
+num_threadgroups=1
+time=30 		# time is in seconds
+
+directio=0 		# don't use direct io
+alignio=1  		# align random IOs to 4k
+bufferedio=0		# this does nothing right now
+verbose=0		# this does nothing right now
+
+			# calls and external command and waits
+			# everything until the newline is taken
+			# so you can have abritrary parmeters
+callout=synchronize.sh myhostname
+
+---------
+
+All of these must appear in this order, though you can leave out the
+optional ones.
+
+Filesystems:
+
+Filesystems describe differnt logical sets of files residing in
+different directorys.  There is no strict requirement that they
+actually be on different filesystems, only that the directory
+specified already exists.
+
+Filesystems are specified by a clause with a filesystem number like
+this:
+
+[filesystem0]
+	location=/mnt/testing/
+	num_files=10
+	num_dirs=1
+	max_filesize=4096
+	min_filesize=4096
+[end0]
+
+
+The clause must always begin with [filesystemX] and end with [endX]
+where X is the number of that filesystem.
+
+You should start wiht X = 0, and increment by one for each following
+filesystem.  If they are out of order, things will likely break.
+
+The required information for each filesystem is: location, num_files,
+num_dirs, max_filesize, and min_filesize.  Beyond those the following
+four options are supported:
+
+
+
+reuse=1 # check the filesystem to see if it is reusable
+
+	# filesystem aging, three components required
+	# takes agefs=1 to turn it on
+	# then a valid threadgroup specification
+	# then a desired utilization percentage
+
+agefs=1 # age the filesystem according to the following threadgroup
+	[threadgroup0]
+		num_threads=10
+		write_size=40960
+		write_blocksize=4096
+		create_weight=10
+		append_weight=10
+		delete_weight=1
+	[end0]
+desired_util=0.20	# In this case, age until the fs is 20% full
+
+create_blocksize=4096   # specify the blocksize to write()
+		        # for creating the fileset, defaults to 4096
+
+age_blocksize=4096      # specify the blocksize to write() for aging
+
+
+Also, to allow lazy people to use lots of filesystems, we support
+filesystem inheritance, which simply copies all options but the
+location from the previous filesystem clause if nothing is specified.
+Obviously, this doesn't work for filesystem0. (May not work for aging
+either?)
+
+Full blown filesystem clause example:
+
+----
+
+[filesystem0]
+
+	# required parts
+
+	location=/home/sonny/tmp
+	num_files=100
+	num_dirs=100
+	max_filesize=65536
+	min_filesize=4096
+
+	# aging part
+	agefs=0
+	[threadgroup0]
+		num_threads=10
+		write_size=40960
+		write_blocksize=4096
+		create_weight=10
+		append_weight=10
+		delete_weight=1
+	[end0]
+		desired_util=0.02	# age until 2% full
+
+	# other optional commands
+
+	create_blocksize=1024		# use a small create blocksize
+	age_blocksize=1024		# and smaller age create blocksize
+	reuse=0	                        # don't reuse it
+[end0]
+
+
+
+--
+
+Threadgroups:
+
+Threadgropus are very similar to filesystems in that any number of
+them can be specified in clauses, and they must be in order starting
+with threadgroup0.
+
+Example:
+
+---
+
+[threadgroup0]
+	num_threads=32
+	read_weight=4
+	append_weight=1
+
+	write_size=4096
+	write_blocksize=4096
+
+	read_size=4096
+	read_blocksize=4096
+[end0]
+
+---
+
+In a threadgroup clause, num_threads is required and must be at least
+1.  Then, at least one operation must be given a weight greater than 0
+to be a valid threadgroup.  Operations can be given a weighting of 0,
+and in this case they are ignored.
+
+Certain operations will also require other commands, for example, if
+read_weight is greater than zero, then one must also include a
+read_size and a read_blocksize.  Here's the table of requirements and
+options:
+
+
+Operation		Requirements			Options
+--			--				--
+read_weight		read_size, read_blocksize	read_random
+readall_weight		read_blocksize			none
+write_weight		write_size, write_blocksize	write_random,fsync_file
+create_weight		write_blocksize or create_blocksize	none
+append_weight		write_blocksize, write_size	none
+delete_weight		none				none
+meta_weight		none				none
+
+
+
+Other threadgroup options:
+
+op_delay=10  # specify a wait between operations in milli-seconds
+
+bindfs=3     # This allows you to restrict a threadgroup's operation
+             # to a specific filesystem number.  Currently only
+	     # binding to one specific filesystem is supported
+
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/aclocal.m4 b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/aclocal.m4
new file mode 100644
index 0000000..d57c8f6
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/aclocal.m4
@@ -0,0 +1,880 @@
+# generated automatically by aclocal 1.10.1 -*- Autoconf -*-
+
+# Copyright (C) 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004,
+# 2005, 2006, 2007, 2008  Free Software Foundation, Inc.
+# This file is free software; the Free Software Foundation
+# gives unlimited permission to copy and/or distribute it,
+# with or without modifications, as long as this notice is preserved.
+
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY, to the extent permitted by law; without
+# even the implied warranty of MERCHANTABILITY or FITNESS FOR A
+# PARTICULAR PURPOSE.
+
+m4_ifndef([AC_AUTOCONF_VERSION],
+  [m4_copy([m4_PACKAGE_VERSION], [AC_AUTOCONF_VERSION])])dnl
+m4_if(AC_AUTOCONF_VERSION, [2.61],,
+[m4_warning([this file was generated for autoconf 2.61.
+You have another version of autoconf.  It may work, but is not guaranteed to.
+If you have problems, you may need to regenerate the build system entirely.
+To do so, use the procedure documented by the package, typically `autoreconf'.])])
+
+# Copyright (C) 2002, 2003, 2005, 2006, 2007  Free Software Foundation, Inc.
+#
+# This file is free software; the Free Software Foundation
+# gives unlimited permission to copy and/or distribute it,
+# with or without modifications, as long as this notice is preserved.
+
+# AM_AUTOMAKE_VERSION(VERSION)
+# ----------------------------
+# Automake X.Y traces this macro to ensure aclocal.m4 has been
+# generated from the m4 files accompanying Automake X.Y.
+# (This private macro should not be called outside this file.)
+AC_DEFUN([AM_AUTOMAKE_VERSION],
+[am__api_version='1.10'
+dnl Some users find AM_AUTOMAKE_VERSION and mistake it for a way to
+dnl require some minimum version.  Point them to the right macro.
+m4_if([$1], [1.10.1], [],
+      [AC_FATAL([Do not call $0, use AM_INIT_AUTOMAKE([$1]).])])dnl
+])
+
+# _AM_AUTOCONF_VERSION(VERSION)
+# -----------------------------
+# aclocal traces this macro to find the Autoconf version.
+# This is a private macro too.  Using m4_define simplifies
+# the logic in aclocal, which can simply ignore this definition.
+m4_define([_AM_AUTOCONF_VERSION], [])
+
+# AM_SET_CURRENT_AUTOMAKE_VERSION
+# -------------------------------
+# Call AM_AUTOMAKE_VERSION and AM_AUTOMAKE_VERSION so they can be traced.
+# This function is AC_REQUIREd by AC_INIT_AUTOMAKE.
+AC_DEFUN([AM_SET_CURRENT_AUTOMAKE_VERSION],
+[AM_AUTOMAKE_VERSION([1.10.1])dnl
+m4_ifndef([AC_AUTOCONF_VERSION],
+  [m4_copy([m4_PACKAGE_VERSION], [AC_AUTOCONF_VERSION])])dnl
+_AM_AUTOCONF_VERSION(AC_AUTOCONF_VERSION)])
+
+# AM_AUX_DIR_EXPAND                                         -*- Autoconf -*-
+
+# Copyright (C) 2001, 2003, 2005  Free Software Foundation, Inc.
+#
+# This file is free software; the Free Software Foundation
+# gives unlimited permission to copy and/or distribute it,
+# with or without modifications, as long as this notice is preserved.
+
+# For projects using AC_CONFIG_AUX_DIR([foo]), Autoconf sets
+# $ac_aux_dir to `$srcdir/foo'.  In other projects, it is set to
+# `$srcdir', `$srcdir/..', or `$srcdir/../..'.
+#
+# Of course, Automake must honor this variable whenever it calls a
+# tool from the auxiliary directory.  The problem is that $srcdir (and
+# therefore $ac_aux_dir as well) can be either absolute or relative,
+# depending on how configure is run.  This is pretty annoying, since
+# it makes $ac_aux_dir quite unusable in subdirectories: in the top
+# source directory, any form will work fine, but in subdirectories a
+# relative path needs to be adjusted first.
+#
+# $ac_aux_dir/missing
+#    fails when called from a subdirectory if $ac_aux_dir is relative
+# $top_srcdir/$ac_aux_dir/missing
+#    fails if $ac_aux_dir is absolute,
+#    fails when called from a subdirectory in a VPATH build with
+#          a relative $ac_aux_dir
+#
+# The reason of the latter failure is that $top_srcdir and $ac_aux_dir
+# are both prefixed by $srcdir.  In an in-source build this is usually
+# harmless because $srcdir is `.', but things will broke when you
+# start a VPATH build or use an absolute $srcdir.
+#
+# So we could use something similar to $top_srcdir/$ac_aux_dir/missing,
+# iff we strip the leading $srcdir from $ac_aux_dir.  That would be:
+#   am_aux_dir='\$(top_srcdir)/'`expr "$ac_aux_dir" : "$srcdir//*\(.*\)"`
+# and then we would define $MISSING as
+#   MISSING="\${SHELL} $am_aux_dir/missing"
+# This will work as long as MISSING is not called from configure, because
+# unfortunately $(top_srcdir) has no meaning in configure.
+# However there are other variables, like CC, which are often used in
+# configure, and could therefore not use this "fixed" $ac_aux_dir.
+#
+# Another solution, used here, is to always expand $ac_aux_dir to an
+# absolute PATH.  The drawback is that using absolute paths prevent a
+# configured tree to be moved without reconfiguration.
+
+AC_DEFUN([AM_AUX_DIR_EXPAND],
+[dnl Rely on autoconf to set up CDPATH properly.
+AC_PREREQ([2.50])dnl
+# expand $ac_aux_dir to an absolute path
+am_aux_dir=`cd $ac_aux_dir && pwd`
+])
+
+# AM_CONDITIONAL                                            -*- Autoconf -*-
+
+# Copyright (C) 1997, 2000, 2001, 2003, 2004, 2005, 2006
+# Free Software Foundation, Inc.
+#
+# This file is free software; the Free Software Foundation
+# gives unlimited permission to copy and/or distribute it,
+# with or without modifications, as long as this notice is preserved.
+
+# serial 8
+
+# AM_CONDITIONAL(NAME, SHELL-CONDITION)
+# -------------------------------------
+# Define a conditional.
+AC_DEFUN([AM_CONDITIONAL],
+[AC_PREREQ(2.52)dnl
+ ifelse([$1], [TRUE],  [AC_FATAL([$0: invalid condition: $1])],
+	[$1], [FALSE], [AC_FATAL([$0: invalid condition: $1])])dnl
+AC_SUBST([$1_TRUE])dnl
+AC_SUBST([$1_FALSE])dnl
+_AM_SUBST_NOTMAKE([$1_TRUE])dnl
+_AM_SUBST_NOTMAKE([$1_FALSE])dnl
+if $2; then
+  $1_TRUE=
+  $1_FALSE='#'
+else
+  $1_TRUE='#'
+  $1_FALSE=
+fi
+AC_CONFIG_COMMANDS_PRE(
+[if test -z "${$1_TRUE}" && test -z "${$1_FALSE}"; then
+  AC_MSG_ERROR([[conditional "$1" was never defined.
+Usually this means the macro was only invoked conditionally.]])
+fi])])
+
+# Copyright (C) 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006
+# Free Software Foundation, Inc.
+#
+# This file is free software; the Free Software Foundation
+# gives unlimited permission to copy and/or distribute it,
+# with or without modifications, as long as this notice is preserved.
+
+# serial 9
+
+# There are a few dirty hacks below to avoid letting `AC_PROG_CC' be
+# written in clear, in which case automake, when reading aclocal.m4,
+# will think it sees a *use*, and therefore will trigger all it's
+# C support machinery.  Also note that it means that autoscan, seeing
+# CC etc. in the Makefile, will ask for an AC_PROG_CC use...
+
+
+# _AM_DEPENDENCIES(NAME)
+# ----------------------
+# See how the compiler implements dependency checking.
+# NAME is "CC", "CXX", "GCJ", or "OBJC".
+# We try a few techniques and use that to set a single cache variable.
+#
+# We don't AC_REQUIRE the corresponding AC_PROG_CC since the latter was
+# modified to invoke _AM_DEPENDENCIES(CC); we would have a circular
+# dependency, and given that the user is not expected to run this macro,
+# just rely on AC_PROG_CC.
+AC_DEFUN([_AM_DEPENDENCIES],
+[AC_REQUIRE([AM_SET_DEPDIR])dnl
+AC_REQUIRE([AM_OUTPUT_DEPENDENCY_COMMANDS])dnl
+AC_REQUIRE([AM_MAKE_INCLUDE])dnl
+AC_REQUIRE([AM_DEP_TRACK])dnl
+
+ifelse([$1], CC,   [depcc="$CC"   am_compiler_list=],
+       [$1], CXX,  [depcc="$CXX"  am_compiler_list=],
+       [$1], OBJC, [depcc="$OBJC" am_compiler_list='gcc3 gcc'],
+       [$1], UPC,  [depcc="$UPC"  am_compiler_list=],
+       [$1], GCJ,  [depcc="$GCJ"  am_compiler_list='gcc3 gcc'],
+                   [depcc="$$1"   am_compiler_list=])
+
+AC_CACHE_CHECK([dependency style of $depcc],
+               [am_cv_$1_dependencies_compiler_type],
+[if test -z "$AMDEP_TRUE" && test -f "$am_depcomp"; then
+  # We make a subdir and do the tests there.  Otherwise we can end up
+  # making bogus files that we don't know about and never remove.  For
+  # instance it was reported that on HP-UX the gcc test will end up
+  # making a dummy file named `D' -- because `-MD' means `put the output
+  # in D'.
+  mkdir conftest.dir
+  # Copy depcomp to subdir because otherwise we won't find it if we're
+  # using a relative directory.
+  cp "$am_depcomp" conftest.dir
+  cd conftest.dir
+  # We will build objects and dependencies in a subdirectory because
+  # it helps to detect inapplicable dependency modes.  For instance
+  # both Tru64's cc and ICC support -MD to output dependencies as a
+  # side effect of compilation, but ICC will put the dependencies in
+  # the current directory while Tru64 will put them in the object
+  # directory.
+  mkdir sub
+
+  am_cv_$1_dependencies_compiler_type=none
+  if test "$am_compiler_list" = ""; then
+     am_compiler_list=`sed -n ['s/^#*\([a-zA-Z0-9]*\))$/\1/p'] < ./depcomp`
+  fi
+  for depmode in $am_compiler_list; do
+    # Setup a source with many dependencies, because some compilers
+    # like to wrap large dependency lists on column 80 (with \), and
+    # we should not choose a depcomp mode which is confused by this.
+    #
+    # We need to recreate these files for each test, as the compiler may
+    # overwrite some of them when testing with obscure command lines.
+    # This happens at least with the AIX C compiler.
+    : > sub/conftest.c
+    for i in 1 2 3 4 5 6; do
+      echo '#include "conftst'$i'.h"' >> sub/conftest.c
+      # Using `: > sub/conftst$i.h' creates only sub/conftst1.h with
+      # Solaris 8's {/usr,}/bin/sh.
+      touch sub/conftst$i.h
+    done
+    echo "${am__include} ${am__quote}sub/conftest.Po${am__quote}" > confmf
+
+    case $depmode in
+    nosideeffect)
+      # after this tag, mechanisms are not by side-effect, so they'll
+      # only be used when explicitly requested
+      if test "x$enable_dependency_tracking" = xyes; then
+	continue
+      else
+	break
+      fi
+      ;;
+    none) break ;;
+    esac
+    # We check with `-c' and `-o' for the sake of the "dashmstdout"
+    # mode.  It turns out that the SunPro C++ compiler does not properly
+    # handle `-M -o', and we need to detect this.
+    if depmode=$depmode \
+       source=sub/conftest.c object=sub/conftest.${OBJEXT-o} \
+       depfile=sub/conftest.Po tmpdepfile=sub/conftest.TPo \
+       $SHELL ./depcomp $depcc -c -o sub/conftest.${OBJEXT-o} sub/conftest.c \
+         >/dev/null 2>conftest.err &&
+       grep sub/conftst1.h sub/conftest.Po > /dev/null 2>&1 &&
+       grep sub/conftst6.h sub/conftest.Po > /dev/null 2>&1 &&
+       grep sub/conftest.${OBJEXT-o} sub/conftest.Po > /dev/null 2>&1 &&
+       ${MAKE-make} -s -f confmf > /dev/null 2>&1; then
+      # icc doesn't choke on unknown options, it will just issue warnings
+      # or remarks (even with -Werror).  So we grep stderr for any message
+      # that says an option was ignored or not supported.
+      # When given -MP, icc 7.0 and 7.1 complain thusly:
+      #   icc: Command line warning: ignoring option '-M'; no argument required
+      # The diagnosis changed in icc 8.0:
+      #   icc: Command line remark: option '-MP' not supported
+      if (grep 'ignoring option' conftest.err ||
+          grep 'not supported' conftest.err) >/dev/null 2>&1; then :; else
+        am_cv_$1_dependencies_compiler_type=$depmode
+        break
+      fi
+    fi
+  done
+
+  cd ..
+  rm -rf conftest.dir
+else
+  am_cv_$1_dependencies_compiler_type=none
+fi
+])
+AC_SUBST([$1DEPMODE], [depmode=$am_cv_$1_dependencies_compiler_type])
+AM_CONDITIONAL([am__fastdep$1], [
+  test "x$enable_dependency_tracking" != xno \
+  && test "$am_cv_$1_dependencies_compiler_type" = gcc3])
+])
+
+
+# AM_SET_DEPDIR
+# -------------
+# Choose a directory name for dependency files.
+# This macro is AC_REQUIREd in _AM_DEPENDENCIES
+AC_DEFUN([AM_SET_DEPDIR],
+[AC_REQUIRE([AM_SET_LEADING_DOT])dnl
+AC_SUBST([DEPDIR], ["${am__leading_dot}deps"])dnl
+])
+
+
+# AM_DEP_TRACK
+# ------------
+AC_DEFUN([AM_DEP_TRACK],
+[AC_ARG_ENABLE(dependency-tracking,
+[  --disable-dependency-tracking  speeds up one-time build
+  --enable-dependency-tracking   do not reject slow dependency extractors])
+if test "x$enable_dependency_tracking" != xno; then
+  am_depcomp="$ac_aux_dir/depcomp"
+  AMDEPBACKSLASH='\'
+fi
+AM_CONDITIONAL([AMDEP], [test "x$enable_dependency_tracking" != xno])
+AC_SUBST([AMDEPBACKSLASH])dnl
+_AM_SUBST_NOTMAKE([AMDEPBACKSLASH])dnl
+])
+
+# Generate code to set up dependency tracking.              -*- Autoconf -*-
+
+# Copyright (C) 1999, 2000, 2001, 2002, 2003, 2004, 2005
+# Free Software Foundation, Inc.
+#
+# This file is free software; the Free Software Foundation
+# gives unlimited permission to copy and/or distribute it,
+# with or without modifications, as long as this notice is preserved.
+
+#serial 3
+
+# _AM_OUTPUT_DEPENDENCY_COMMANDS
+# ------------------------------
+AC_DEFUN([_AM_OUTPUT_DEPENDENCY_COMMANDS],
+[for mf in $CONFIG_FILES; do
+  # Strip MF so we end up with the name of the file.
+  mf=`echo "$mf" | sed -e 's/:.*$//'`
+  # Check whether this is an Automake generated Makefile or not.
+  # We used to match only the files named `Makefile.in', but
+  # some people rename them; so instead we look at the file content.
+  # Grep'ing the first line is not enough: some people post-process
+  # each Makefile.in and add a new line on top of each file to say so.
+  # Grep'ing the whole file is not good either: AIX grep has a line
+  # limit of 2048, but all sed's we know have understand at least 4000.
+  if sed -n 's,^#.*generated by automake.*,X,p' "$mf" | grep X >/dev/null 2>&1; then
+    dirpart=`AS_DIRNAME("$mf")`
+  else
+    continue
+  fi
+  # Extract the definition of DEPDIR, am__include, and am__quote
+  # from the Makefile without running `make'.
+  DEPDIR=`sed -n 's/^DEPDIR = //p' < "$mf"`
+  test -z "$DEPDIR" && continue
+  am__include=`sed -n 's/^am__include = //p' < "$mf"`
+  test -z "am__include" && continue
+  am__quote=`sed -n 's/^am__quote = //p' < "$mf"`
+  # When using ansi2knr, U may be empty or an underscore; expand it
+  U=`sed -n 's/^U = //p' < "$mf"`
+  # Find all dependency output files, they are included files with
+  # $(DEPDIR) in their names.  We invoke sed twice because it is the
+  # simplest approach to changing $(DEPDIR) to its actual value in the
+  # expansion.
+  for file in `sed -n "
+    s/^$am__include $am__quote\(.*(DEPDIR).*\)$am__quote"'$/\1/p' <"$mf" | \
+       sed -e 's/\$(DEPDIR)/'"$DEPDIR"'/g' -e 's/\$U/'"$U"'/g'`; do
+    # Make sure the directory exists.
+    test -f "$dirpart/$file" && continue
+    fdir=`AS_DIRNAME(["$file"])`
+    AS_MKDIR_P([$dirpart/$fdir])
+    # echo "creating $dirpart/$file"
+    echo '# dummy' > "$dirpart/$file"
+  done
+done
+])# _AM_OUTPUT_DEPENDENCY_COMMANDS
+
+
+# AM_OUTPUT_DEPENDENCY_COMMANDS
+# -----------------------------
+# This macro should only be invoked once -- use via AC_REQUIRE.
+#
+# This code is only required when automatic dependency tracking
+# is enabled.  FIXME.  This creates each `.P' file that we will
+# need in order to bootstrap the dependency handling code.
+AC_DEFUN([AM_OUTPUT_DEPENDENCY_COMMANDS],
+[AC_CONFIG_COMMANDS([depfiles],
+     [test x"$AMDEP_TRUE" != x"" || _AM_OUTPUT_DEPENDENCY_COMMANDS],
+     [AMDEP_TRUE="$AMDEP_TRUE" ac_aux_dir="$ac_aux_dir"])
+])
+
+# Copyright (C) 1996, 1997, 2000, 2001, 2003, 2005
+# Free Software Foundation, Inc.
+#
+# This file is free software; the Free Software Foundation
+# gives unlimited permission to copy and/or distribute it,
+# with or without modifications, as long as this notice is preserved.
+
+# serial 8
+
+# AM_CONFIG_HEADER is obsolete.  It has been replaced by AC_CONFIG_HEADERS.
+AU_DEFUN([AM_CONFIG_HEADER], [AC_CONFIG_HEADERS($@)])
+
+# Do all the work for Automake.                             -*- Autoconf -*-
+
+# Copyright (C) 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004,
+# 2005, 2006, 2008 Free Software Foundation, Inc.
+#
+# This file is free software; the Free Software Foundation
+# gives unlimited permission to copy and/or distribute it,
+# with or without modifications, as long as this notice is preserved.
+
+# serial 13
+
+# This macro actually does too much.  Some checks are only needed if
+# your package does certain things.  But this isn't really a big deal.
+
+# AM_INIT_AUTOMAKE(PACKAGE, VERSION, [NO-DEFINE])
+# AM_INIT_AUTOMAKE([OPTIONS])
+# -----------------------------------------------
+# The call with PACKAGE and VERSION arguments is the old style
+# call (pre autoconf-2.50), which is being phased out.  PACKAGE
+# and VERSION should now be passed to AC_INIT and removed from
+# the call to AM_INIT_AUTOMAKE.
+# We support both call styles for the transition.  After
+# the next Automake release, Autoconf can make the AC_INIT
+# arguments mandatory, and then we can depend on a new Autoconf
+# release and drop the old call support.
+AC_DEFUN([AM_INIT_AUTOMAKE],
+[AC_PREREQ([2.60])dnl
+dnl Autoconf wants to disallow AM_ names.  We explicitly allow
+dnl the ones we care about.
+m4_pattern_allow([^AM_[A-Z]+FLAGS$])dnl
+AC_REQUIRE([AM_SET_CURRENT_AUTOMAKE_VERSION])dnl
+AC_REQUIRE([AC_PROG_INSTALL])dnl
+if test "`cd $srcdir && pwd`" != "`pwd`"; then
+  # Use -I$(srcdir) only when $(srcdir) != ., so that make's output
+  # is not polluted with repeated "-I."
+  AC_SUBST([am__isrc], [' -I$(srcdir)'])_AM_SUBST_NOTMAKE([am__isrc])dnl
+  # test to see if srcdir already configured
+  if test -f $srcdir/config.status; then
+    AC_MSG_ERROR([source directory already configured; run "make distclean" there first])
+  fi
+fi
+
+# test whether we have cygpath
+if test -z "$CYGPATH_W"; then
+  if (cygpath --version) >/dev/null 2>/dev/null; then
+    CYGPATH_W='cygpath -w'
+  else
+    CYGPATH_W=echo
+  fi
+fi
+AC_SUBST([CYGPATH_W])
+
+# Define the identity of the package.
+dnl Distinguish between old-style and new-style calls.
+m4_ifval([$2],
+[m4_ifval([$3], [_AM_SET_OPTION([no-define])])dnl
+ AC_SUBST([PACKAGE], [$1])dnl
+ AC_SUBST([VERSION], [$2])],
+[_AM_SET_OPTIONS([$1])dnl
+dnl Diagnose old-style AC_INIT with new-style AM_AUTOMAKE_INIT.
+m4_if(m4_ifdef([AC_PACKAGE_NAME], 1)m4_ifdef([AC_PACKAGE_VERSION], 1), 11,,
+  [m4_fatal([AC_INIT should be called with package and version arguments])])dnl
+ AC_SUBST([PACKAGE], ['AC_PACKAGE_TARNAME'])dnl
+ AC_SUBST([VERSION], ['AC_PACKAGE_VERSION'])])dnl
+
+_AM_IF_OPTION([no-define],,
+[AC_DEFINE_UNQUOTED(PACKAGE, "$PACKAGE", [Name of package])
+ AC_DEFINE_UNQUOTED(VERSION, "$VERSION", [Version number of package])])dnl
+
+# Some tools Automake needs.
+AC_REQUIRE([AM_SANITY_CHECK])dnl
+AC_REQUIRE([AC_ARG_PROGRAM])dnl
+AM_MISSING_PROG(ACLOCAL, aclocal-${am__api_version})
+AM_MISSING_PROG(AUTOCONF, autoconf)
+AM_MISSING_PROG(AUTOMAKE, automake-${am__api_version})
+AM_MISSING_PROG(AUTOHEADER, autoheader)
+AM_MISSING_PROG(MAKEINFO, makeinfo)
+AM_PROG_INSTALL_SH
+AM_PROG_INSTALL_STRIP
+AC_REQUIRE([AM_PROG_MKDIR_P])dnl
+# We need awk for the "check" target.  The system "awk" is bad on
+# some platforms.
+AC_REQUIRE([AC_PROG_AWK])dnl
+AC_REQUIRE([AC_PROG_MAKE_SET])dnl
+AC_REQUIRE([AM_SET_LEADING_DOT])dnl
+_AM_IF_OPTION([tar-ustar], [_AM_PROG_TAR([ustar])],
+              [_AM_IF_OPTION([tar-pax], [_AM_PROG_TAR([pax])],
+	      		     [_AM_PROG_TAR([v7])])])
+_AM_IF_OPTION([no-dependencies],,
+[AC_PROVIDE_IFELSE([AC_PROG_CC],
+                  [_AM_DEPENDENCIES(CC)],
+                  [define([AC_PROG_CC],
+                          defn([AC_PROG_CC])[_AM_DEPENDENCIES(CC)])])dnl
+AC_PROVIDE_IFELSE([AC_PROG_CXX],
+                  [_AM_DEPENDENCIES(CXX)],
+                  [define([AC_PROG_CXX],
+                          defn([AC_PROG_CXX])[_AM_DEPENDENCIES(CXX)])])dnl
+AC_PROVIDE_IFELSE([AC_PROG_OBJC],
+                  [_AM_DEPENDENCIES(OBJC)],
+                  [define([AC_PROG_OBJC],
+                          defn([AC_PROG_OBJC])[_AM_DEPENDENCIES(OBJC)])])dnl
+])
+])
+
+
+# When config.status generates a header, we must update the stamp-h file.
+# This file resides in the same directory as the config header
+# that is generated.  The stamp files are numbered to have different names.
+
+# Autoconf calls _AC_AM_CONFIG_HEADER_HOOK (when defined) in the
+# loop where config.status creates the headers, so we can generate
+# our stamp files there.
+AC_DEFUN([_AC_AM_CONFIG_HEADER_HOOK],
+[# Compute $1's index in $config_headers.
+_am_arg=$1
+_am_stamp_count=1
+for _am_header in $config_headers :; do
+  case $_am_header in
+    $_am_arg | $_am_arg:* )
+      break ;;
+    * )
+      _am_stamp_count=`expr $_am_stamp_count + 1` ;;
+  esac
+done
+echo "timestamp for $_am_arg" >`AS_DIRNAME(["$_am_arg"])`/stamp-h[]$_am_stamp_count])
+
+# Copyright (C) 2001, 2003, 2005  Free Software Foundation, Inc.
+#
+# This file is free software; the Free Software Foundation
+# gives unlimited permission to copy and/or distribute it,
+# with or without modifications, as long as this notice is preserved.
+
+# AM_PROG_INSTALL_SH
+# ------------------
+# Define $install_sh.
+AC_DEFUN([AM_PROG_INSTALL_SH],
+[AC_REQUIRE([AM_AUX_DIR_EXPAND])dnl
+install_sh=${install_sh-"\$(SHELL) $am_aux_dir/install-sh"}
+AC_SUBST(install_sh)])
+
+# Copyright (C) 2003, 2005  Free Software Foundation, Inc.
+#
+# This file is free software; the Free Software Foundation
+# gives unlimited permission to copy and/or distribute it,
+# with or without modifications, as long as this notice is preserved.
+
+# serial 2
+
+# Check whether the underlying file-system supports filenames
+# with a leading dot.  For instance MS-DOS doesn't.
+AC_DEFUN([AM_SET_LEADING_DOT],
+[rm -rf .tst 2>/dev/null
+mkdir .tst 2>/dev/null
+if test -d .tst; then
+  am__leading_dot=.
+else
+  am__leading_dot=_
+fi
+rmdir .tst 2>/dev/null
+AC_SUBST([am__leading_dot])])
+
+# Check to see how 'make' treats includes.	            -*- Autoconf -*-
+
+# Copyright (C) 2001, 2002, 2003, 2005  Free Software Foundation, Inc.
+#
+# This file is free software; the Free Software Foundation
+# gives unlimited permission to copy and/or distribute it,
+# with or without modifications, as long as this notice is preserved.
+
+# serial 3
+
+# AM_MAKE_INCLUDE()
+# -----------------
+# Check to see how make treats includes.
+AC_DEFUN([AM_MAKE_INCLUDE],
+[am_make=${MAKE-make}
+cat > confinc << 'END'
+am__doit:
+	@echo done
+.PHONY: am__doit
+END
+# If we don't find an include directive, just comment out the code.
+AC_MSG_CHECKING([for style of include used by $am_make])
+am__include="#"
+am__quote=
+_am_result=none
+# First try GNU make style include.
+echo "include confinc" > confmf
+# We grep out `Entering directory' and `Leaving directory'
+# messages which can occur if `w' ends up in MAKEFLAGS.
+# In particular we don't look at `^make:' because GNU make might
+# be invoked under some other name (usually "gmake"), in which
+# case it prints its new name instead of `make'.
+if test "`$am_make -s -f confmf 2> /dev/null | grep -v 'ing directory'`" = "done"; then
+   am__include=include
+   am__quote=
+   _am_result=GNU
+fi
+# Now try BSD make style include.
+if test "$am__include" = "#"; then
+   echo '.include "confinc"' > confmf
+   if test "`$am_make -s -f confmf 2> /dev/null`" = "done"; then
+      am__include=.include
+      am__quote="\""
+      _am_result=BSD
+   fi
+fi
+AC_SUBST([am__include])
+AC_SUBST([am__quote])
+AC_MSG_RESULT([$_am_result])
+rm -f confinc confmf
+])
+
+# Fake the existence of programs that GNU maintainers use.  -*- Autoconf -*-
+
+# Copyright (C) 1997, 1999, 2000, 2001, 2003, 2004, 2005
+# Free Software Foundation, Inc.
+#
+# This file is free software; the Free Software Foundation
+# gives unlimited permission to copy and/or distribute it,
+# with or without modifications, as long as this notice is preserved.
+
+# serial 5
+
+# AM_MISSING_PROG(NAME, PROGRAM)
+# ------------------------------
+AC_DEFUN([AM_MISSING_PROG],
+[AC_REQUIRE([AM_MISSING_HAS_RUN])
+$1=${$1-"${am_missing_run}$2"}
+AC_SUBST($1)])
+
+
+# AM_MISSING_HAS_RUN
+# ------------------
+# Define MISSING if not defined so far and test if it supports --run.
+# If it does, set am_missing_run to use it, otherwise, to nothing.
+AC_DEFUN([AM_MISSING_HAS_RUN],
+[AC_REQUIRE([AM_AUX_DIR_EXPAND])dnl
+AC_REQUIRE_AUX_FILE([missing])dnl
+test x"${MISSING+set}" = xset || MISSING="\${SHELL} $am_aux_dir/missing"
+# Use eval to expand $SHELL
+if eval "$MISSING --run true"; then
+  am_missing_run="$MISSING --run "
+else
+  am_missing_run=
+  AC_MSG_WARN([`missing' script is too old or missing])
+fi
+])
+
+# Copyright (C) 2003, 2004, 2005, 2006  Free Software Foundation, Inc.
+#
+# This file is free software; the Free Software Foundation
+# gives unlimited permission to copy and/or distribute it,
+# with or without modifications, as long as this notice is preserved.
+
+# AM_PROG_MKDIR_P
+# ---------------
+# Check for `mkdir -p'.
+AC_DEFUN([AM_PROG_MKDIR_P],
+[AC_PREREQ([2.60])dnl
+AC_REQUIRE([AC_PROG_MKDIR_P])dnl
+dnl Automake 1.8 to 1.9.6 used to define mkdir_p.  We now use MKDIR_P,
+dnl while keeping a definition of mkdir_p for backward compatibility.
+dnl @MKDIR_P@ is magic: AC_OUTPUT adjusts its value for each Makefile.
+dnl However we cannot define mkdir_p as $(MKDIR_P) for the sake of
+dnl Makefile.ins that do not define MKDIR_P, so we do our own
+dnl adjustment using top_builddir (which is defined more often than
+dnl MKDIR_P).
+AC_SUBST([mkdir_p], ["$MKDIR_P"])dnl
+case $mkdir_p in
+  [[\\/$]]* | ?:[[\\/]]*) ;;
+  */*) mkdir_p="\$(top_builddir)/$mkdir_p" ;;
+esac
+])
+
+# Helper functions for option handling.                     -*- Autoconf -*-
+
+# Copyright (C) 2001, 2002, 2003, 2005  Free Software Foundation, Inc.
+#
+# This file is free software; the Free Software Foundation
+# gives unlimited permission to copy and/or distribute it,
+# with or without modifications, as long as this notice is preserved.
+
+# serial 3
+
+# _AM_MANGLE_OPTION(NAME)
+# -----------------------
+AC_DEFUN([_AM_MANGLE_OPTION],
+[[_AM_OPTION_]m4_bpatsubst($1, [[^a-zA-Z0-9_]], [_])])
+
+# _AM_SET_OPTION(NAME)
+# ------------------------------
+# Set option NAME.  Presently that only means defining a flag for this option.
+AC_DEFUN([_AM_SET_OPTION],
+[m4_define(_AM_MANGLE_OPTION([$1]), 1)])
+
+# _AM_SET_OPTIONS(OPTIONS)
+# ----------------------------------
+# OPTIONS is a space-separated list of Automake options.
+AC_DEFUN([_AM_SET_OPTIONS],
+[AC_FOREACH([_AM_Option], [$1], [_AM_SET_OPTION(_AM_Option)])])
+
+# _AM_IF_OPTION(OPTION, IF-SET, [IF-NOT-SET])
+# -------------------------------------------
+# Execute IF-SET if OPTION is set, IF-NOT-SET otherwise.
+AC_DEFUN([_AM_IF_OPTION],
+[m4_ifset(_AM_MANGLE_OPTION([$1]), [$2], [$3])])
+
+# Check to make sure that the build environment is sane.    -*- Autoconf -*-
+
+# Copyright (C) 1996, 1997, 2000, 2001, 2003, 2005
+# Free Software Foundation, Inc.
+#
+# This file is free software; the Free Software Foundation
+# gives unlimited permission to copy and/or distribute it,
+# with or without modifications, as long as this notice is preserved.
+
+# serial 4
+
+# AM_SANITY_CHECK
+# ---------------
+AC_DEFUN([AM_SANITY_CHECK],
+[AC_MSG_CHECKING([whether build environment is sane])
+# Just in case
+sleep 1
+echo timestamp > conftest.file
+# Do `set' in a subshell so we don't clobber the current shell's
+# arguments.  Must try -L first in case configure is actually a
+# symlink; some systems play weird games with the mod time of symlinks
+# (eg FreeBSD returns the mod time of the symlink's containing
+# directory).
+if (
+   set X `ls -Lt $srcdir/configure conftest.file 2> /dev/null`
+   if test "$[*]" = "X"; then
+      # -L didn't work.
+      set X `ls -t $srcdir/configure conftest.file`
+   fi
+   rm -f conftest.file
+   if test "$[*]" != "X $srcdir/configure conftest.file" \
+      && test "$[*]" != "X conftest.file $srcdir/configure"; then
+
+      # If neither matched, then we have a broken ls.  This can happen
+      # if, for instance, CONFIG_SHELL is bash and it inherits a
+      # broken ls alias from the environment.  This has actually
+      # happened.  Such a system could not be considered "sane".
+      AC_MSG_ERROR([ls -t appears to fail.  Make sure there is not a broken
+alias in your environment])
+   fi
+
+   test "$[2]" = conftest.file
+   )
+then
+   # Ok.
+   :
+else
+   AC_MSG_ERROR([newly created file is older than distributed files!
+Check your system clock])
+fi
+AC_MSG_RESULT(yes)])
+
+# Copyright (C) 2001, 2003, 2005  Free Software Foundation, Inc.
+#
+# This file is free software; the Free Software Foundation
+# gives unlimited permission to copy and/or distribute it,
+# with or without modifications, as long as this notice is preserved.
+
+# AM_PROG_INSTALL_STRIP
+# ---------------------
+# One issue with vendor `install' (even GNU) is that you can't
+# specify the program used to strip binaries.  This is especially
+# annoying in cross-compiling environments, where the build's strip
+# is unlikely to handle the host's binaries.
+# Fortunately install-sh will honor a STRIPPROG variable, so we
+# always use install-sh in `make install-strip', and initialize
+# STRIPPROG with the value of the STRIP variable (set by the user).
+AC_DEFUN([AM_PROG_INSTALL_STRIP],
+[AC_REQUIRE([AM_PROG_INSTALL_SH])dnl
+# Installed binaries are usually stripped using `strip' when the user
+# run `make install-strip'.  However `strip' might not be the right
+# tool to use in cross-compilation environments, therefore Automake
+# will honor the `STRIP' environment variable to overrule this program.
+dnl Don't test for $cross_compiling = yes, because it might be `maybe'.
+if test "$cross_compiling" != no; then
+  AC_CHECK_TOOL([STRIP], [strip], :)
+fi
+INSTALL_STRIP_PROGRAM="\$(install_sh) -c -s"
+AC_SUBST([INSTALL_STRIP_PROGRAM])])
+
+# Copyright (C) 2006  Free Software Foundation, Inc.
+#
+# This file is free software; the Free Software Foundation
+# gives unlimited permission to copy and/or distribute it,
+# with or without modifications, as long as this notice is preserved.
+
+# _AM_SUBST_NOTMAKE(VARIABLE)
+# ---------------------------
+# Prevent Automake from outputting VARIABLE = @VARIABLE@ in Makefile.in.
+# This macro is traced by Automake.
+AC_DEFUN([_AM_SUBST_NOTMAKE])
+
+# Check how to create a tarball.                            -*- Autoconf -*-
+
+# Copyright (C) 2004, 2005  Free Software Foundation, Inc.
+#
+# This file is free software; the Free Software Foundation
+# gives unlimited permission to copy and/or distribute it,
+# with or without modifications, as long as this notice is preserved.
+
+# serial 2
+
+# _AM_PROG_TAR(FORMAT)
+# --------------------
+# Check how to create a tarball in format FORMAT.
+# FORMAT should be one of `v7', `ustar', or `pax'.
+#
+# Substitute a variable $(am__tar) that is a command
+# writing to stdout a FORMAT-tarball containing the directory
+# $tardir.
+#     tardir=directory && $(am__tar) > result.tar
+#
+# Substitute a variable $(am__untar) that extract such
+# a tarball read from stdin.
+#     $(am__untar) < result.tar
+AC_DEFUN([_AM_PROG_TAR],
+[# Always define AMTAR for backward compatibility.
+AM_MISSING_PROG([AMTAR], [tar])
+m4_if([$1], [v7],
+     [am__tar='${AMTAR} chof - "$$tardir"'; am__untar='${AMTAR} xf -'],
+     [m4_case([$1], [ustar],, [pax],,
+              [m4_fatal([Unknown tar format])])
+AC_MSG_CHECKING([how to create a $1 tar archive])
+# Loop over all known methods to create a tar archive until one works.
+_am_tools='gnutar m4_if([$1], [ustar], [plaintar]) pax cpio none'
+_am_tools=${am_cv_prog_tar_$1-$_am_tools}
+# Do not fold the above two line into one, because Tru64 sh and
+# Solaris sh will not grok spaces in the rhs of `-'.
+for _am_tool in $_am_tools
+do
+  case $_am_tool in
+  gnutar)
+    for _am_tar in tar gnutar gtar;
+    do
+      AM_RUN_LOG([$_am_tar --version]) && break
+    done
+    am__tar="$_am_tar --format=m4_if([$1], [pax], [posix], [$1]) -chf - "'"$$tardir"'
+    am__tar_="$_am_tar --format=m4_if([$1], [pax], [posix], [$1]) -chf - "'"$tardir"'
+    am__untar="$_am_tar -xf -"
+    ;;
+  plaintar)
+    # Must skip GNU tar: if it does not support --format= it doesn't create
+    # ustar tarball either.
+    (tar --version) >/dev/null 2>&1 && continue
+    am__tar='tar chf - "$$tardir"'
+    am__tar_='tar chf - "$tardir"'
+    am__untar='tar xf -'
+    ;;
+  pax)
+    am__tar='pax -L -x $1 -w "$$tardir"'
+    am__tar_='pax -L -x $1 -w "$tardir"'
+    am__untar='pax -r'
+    ;;
+  cpio)
+    am__tar='find "$$tardir" -print | cpio -o -H $1 -L'
+    am__tar_='find "$tardir" -print | cpio -o -H $1 -L'
+    am__untar='cpio -i -H $1 -d'
+    ;;
+  none)
+    am__tar=false
+    am__tar_=false
+    am__untar=false
+    ;;
+  esac
+
+  # If the value was cached, stop now.  We just wanted to have am__tar
+  # and am__untar set.
+  test -n "${am_cv_prog_tar_$1}" && break
+
+  # tar/untar a dummy directory, and stop if the command works
+  rm -rf conftest.dir
+  mkdir conftest.dir
+  echo GrepMe > conftest.dir/file
+  AM_RUN_LOG([tardir=conftest.dir && eval $am__tar_ >conftest.tar])
+  rm -rf conftest.dir
+  if test -s conftest.tar; then
+    AM_RUN_LOG([$am__untar <conftest.tar])
+    grep GrepMe conftest.dir/file >/dev/null 2>&1 && break
+  fi
+done
+rm -rf conftest.dir
+
+AC_CACHE_VAL([am_cv_prog_tar_$1], [am_cv_prog_tar_$1=$_am_tool])
+AC_MSG_RESULT([$am_cv_prog_tar_$1])])
+AC_SUBST([am__tar])
+AC_SUBST([am__untar])
+]) # _AM_PROG_TAR
+
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/cirlist.c b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/cirlist.c
new file mode 100644
index 0000000..799ae44
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/cirlist.c
@@ -0,0 +1,107 @@
+/*
+ *   Copyright (c) International Business Machines Corp., 2001-2004
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+#include <stdlib.h>
+#include <assert.h>
+
+#include "cirlist.h"
+#include "util.h"
+
+
+void init_cirlist(struct cirlist *cl)
+{
+	cl->count = 0;
+	cl->head  = NULL;
+}
+
+int cl_empty(struct cirlist *cl)
+{
+	return !(cl->count);
+}
+
+void cl_insert_tail(struct cirlist *cl , cldatatype object)
+{
+	struct cnode *new = ffsb_malloc(sizeof(struct cnode));
+	new->obj = object;
+	if (cl->count == 0) {
+		assert(cl->head == NULL);
+		cl->head = new;
+		cl->head->next = cl->head;
+		cl->head->prev = cl->head;
+		cl->count = 1;
+	} else {
+		if (cl->count == 1) {
+			assert(cl->head->next == cl->head);
+			assert(cl->head->prev == cl->head);
+			cl->head->next = new;
+			cl->head->prev = new;
+			new->next = cl->head;
+			new->prev = cl->head;
+		} else {
+			assert(cl->head->next != cl->head);
+			assert(cl->head->prev != cl->head);
+
+			new->next = cl->head;
+			new->prev = (cl->head)->prev;
+			cl->head->prev->next = new;
+			cl->head->prev = new;
+		}
+		cl->count++;
+	}
+}
+
+cldatatype cl_remove_head(struct cirlist *cl)
+{
+	struct cnode *oldhead = NULL;
+	struct cnode *newhead = NULL;
+	cldatatype ret = NULL;
+
+	if (cl->count == 0) {
+		assert(cl->head == NULL);
+		return NULL;
+	}
+	if (cl->count == 1) {
+		assert(cl->head->next == cl->head);
+		assert(cl->head->prev == cl->head);
+		oldhead = cl->head;
+		cl->head = NULL;
+		cl->count = 0;
+	} else if (cl->count == 2) {
+		oldhead = cl->head;
+		newhead = oldhead->next;
+		newhead->next = newhead;
+		newhead->prev = newhead;
+		cl->head = newhead;
+		cl->count = 1;
+	} else {
+		assert(cl->head->next != cl->head);
+		assert(cl->head->prev != cl->head);
+		oldhead = cl->head;
+		newhead = oldhead->next;
+		newhead->prev = oldhead->prev;
+		newhead->prev->next = newhead;
+		cl->head = newhead;
+		cl->count--;
+	}
+	ret = oldhead->obj;
+	oldhead->obj = (void *)(-1);
+	oldhead->next = (void *)(-1);
+	oldhead->prev = (void *)(-1);
+	free(oldhead);
+
+	return ret;
+}
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/cirlist.h b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/cirlist.h
new file mode 100644
index 0000000..565578c
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/cirlist.h
@@ -0,0 +1,41 @@
+/*
+ *   Copyright (c) International Business Machines Corp., 2001-2004
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+#ifndef _CIRLIST_H
+#define _CIRLIST_H
+
+#include "filelist.h"
+
+typedef struct ffsb_file *cldatatype;
+
+struct cnode {
+	cldatatype obj;
+	struct cnode *next;
+	struct cnode *prev;
+};
+
+struct cirlist {
+	int count;
+	struct cnode *head;
+};
+
+void init_cirlist(struct cirlist *cl);
+int cl_empty(struct cirlist *cl);
+void cl_insert_tail(struct cirlist *cl , cldatatype object);
+cldatatype cl_remove_head(struct cirlist *cl);
+
+#endif /* _CIRLIST_H */
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/config.guess b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/config.guess
new file mode 100644
index 0000000..00ccf89
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/config.guess
@@ -0,0 +1,1450 @@
+#! /bin/sh
+# Attempt to guess a canonical system name.
+#   Copyright (C) 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999,
+#   2000, 2001, 2002, 2003 Free Software Foundation, Inc.
+
+timestamp='2004-02-16'
+
+# This file is free software; you can redistribute it and/or modify it
+# under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful, but
+# WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+# General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+#
+# As a special exception to the GNU General Public License, if you
+# distribute this file as part of a program that contains a
+# configuration script generated by Autoconf, you may include it under
+# the same distribution terms that you use for the rest of that program.
+
+# Originally written by Per Bothner <per@bothner.com>.
+# Please send patches to <config-patches@gnu.org>.  Submit a context
+# diff and a properly formatted ChangeLog entry.
+#
+# This script attempts to guess a canonical system name similar to
+# config.sub.  If it succeeds, it prints the system name on stdout, and
+# exits with 0.  Otherwise, it exits with 1.
+#
+# The plan is that this can be called by configure scripts if you
+# don't specify an explicit build system type.
+
+me=`echo "$0" | sed -e 's,.*/,,'`
+
+usage="\
+Usage: $0 [OPTION]
+
+Output the configuration name of the system \`$me' is run on.
+
+Operation modes:
+  -h, --help         print this help, then exit
+  -t, --time-stamp   print date of last modification, then exit
+  -v, --version      print version number, then exit
+
+Report bugs and patches to <config-patches@gnu.org>."
+
+version="\
+GNU config.guess ($timestamp)
+
+Originally written by Per Bothner.
+Copyright (C) 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001
+Free Software Foundation, Inc.
+
+This is free software; see the source for copying conditions.  There is NO
+warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE."
+
+help="
+Try \`$me --help' for more information."
+
+# Parse command line
+while test $# -gt 0 ; do
+  case $1 in
+    --time-stamp | --time* | -t )
+       echo "$timestamp" ; exit 0 ;;
+    --version | -v )
+       echo "$version" ; exit 0 ;;
+    --help | --h* | -h )
+       echo "$usage"; exit 0 ;;
+    -- )     # Stop option processing
+       shift; break ;;
+    - )	# Use stdin as input.
+       break ;;
+    -* )
+       echo "$me: invalid option $1$help" >&2
+       exit 1 ;;
+    * )
+       break ;;
+  esac
+done
+
+if test $# != 0; then
+  echo "$me: too many arguments$help" >&2
+  exit 1
+fi
+
+trap 'exit 1' 1 2 15
+
+# CC_FOR_BUILD -- compiler used by this script. Note that the use of a
+# compiler to aid in system detection is discouraged as it requires
+# temporary files to be created and, as you can see below, it is a
+# headache to deal with in a portable fashion.
+
+# Historically, `CC_FOR_BUILD' used to be named `HOST_CC'. We still
+# use `HOST_CC' if defined, but it is deprecated.
+
+# Portable tmp directory creation inspired by the Autoconf team.
+
+set_cc_for_build='
+trap "exitcode=\$?; (rm -f \$tmpfiles 2>/dev/null; rmdir \$tmp 2>/dev/null) && exit \$exitcode" 0 ;
+trap "rm -f \$tmpfiles 2>/dev/null; rmdir \$tmp 2>/dev/null; exit 1" 1 2 13 15 ;
+: ${TMPDIR=/tmp} ;
+ { tmp=`(umask 077 && mktemp -d -q "$TMPDIR/cgXXXXXX") 2>/dev/null` && test -n "$tmp" && test -d "$tmp" ; } ||
+ { test -n "$RANDOM" && tmp=$TMPDIR/cg$$-$RANDOM && (umask 077 && mkdir $tmp) ; } ||
+ { tmp=$TMPDIR/cg-$$ && (umask 077 && mkdir $tmp) && echo "Warning: creating insecure temp directory" >&2 ; } ||
+ { echo "$me: cannot create a temporary directory in $TMPDIR" >&2 ; exit 1 ; } ;
+dummy=$tmp/dummy ;
+tmpfiles="$dummy.c $dummy.o $dummy.rel $dummy" ;
+case $CC_FOR_BUILD,$HOST_CC,$CC in
+ ,,)    echo "int x;" > $dummy.c ;
+	for c in cc gcc c89 c99 ; do
+	  if ($c -c -o $dummy.o $dummy.c) >/dev/null 2>&1 ; then
+	     CC_FOR_BUILD="$c"; break ;
+	  fi ;
+	done ;
+	if test x"$CC_FOR_BUILD" = x ; then
+	  CC_FOR_BUILD=no_compiler_found ;
+	fi
+	;;
+ ,,*)   CC_FOR_BUILD=$CC ;;
+ ,*,*)  CC_FOR_BUILD=$HOST_CC ;;
+esac ;'
+
+# This is needed to find uname on a Pyramid OSx when run in the BSD universe.
+# (ghazi@noc.rutgers.edu 1994-08-24)
+if (test -f /.attbin/uname) >/dev/null 2>&1 ; then
+	PATH=$PATH:/.attbin ; export PATH
+fi
+
+UNAME_MACHINE=`(uname -m) 2>/dev/null` || UNAME_MACHINE=unknown
+UNAME_RELEASE=`(uname -r) 2>/dev/null` || UNAME_RELEASE=unknown
+UNAME_SYSTEM=`(uname -s) 2>/dev/null`  || UNAME_SYSTEM=unknown
+UNAME_VERSION=`(uname -v) 2>/dev/null` || UNAME_VERSION=unknown
+
+# Note: order is significant - the case branches are not exclusive.
+
+case "${UNAME_MACHINE}:${UNAME_SYSTEM}:${UNAME_RELEASE}:${UNAME_VERSION}" in
+    *:NetBSD:*:*)
+	# NetBSD (nbsd) targets should (where applicable) match one or
+	# more of the tupples: *-*-netbsdelf*, *-*-netbsdaout*,
+	# *-*-netbsdecoff* and *-*-netbsd*.  For targets that recently
+	# switched to ELF, *-*-netbsd* would select the old
+	# object file format.  This provides both forward
+	# compatibility and a consistent mechanism for selecting the
+	# object file format.
+	#
+	# Note: NetBSD doesn't particularly care about the vendor
+	# portion of the name.  We always set it to "unknown".
+	sysctl="sysctl -n hw.machine_arch"
+	UNAME_MACHINE_ARCH=`(/sbin/$sysctl 2>/dev/null || \
+	    /usr/sbin/$sysctl 2>/dev/null || echo unknown)`
+	case "${UNAME_MACHINE_ARCH}" in
+	    armeb) machine=armeb-unknown ;;
+	    arm*) machine=arm-unknown ;;
+	    sh3el) machine=shl-unknown ;;
+	    sh3eb) machine=sh-unknown ;;
+	    *) machine=${UNAME_MACHINE_ARCH}-unknown ;;
+	esac
+	# The Operating System including object format, if it has switched
+	# to ELF recently, or will in the future.
+	case "${UNAME_MACHINE_ARCH}" in
+	    arm*|i386|m68k|ns32k|sh3*|sparc|vax)
+		eval $set_cc_for_build
+		if echo __ELF__ | $CC_FOR_BUILD -E - 2>/dev/null \
+			| grep __ELF__ >/dev/null
+		then
+		    # Once all utilities can be ECOFF (netbsdecoff) or a.out (netbsdaout).
+		    # Return netbsd for either.  FIX?
+		    os=netbsd
+		else
+		    os=netbsdelf
+		fi
+		;;
+	    *)
+	        os=netbsd
+		;;
+	esac
+	# The OS release
+	# Debian GNU/NetBSD machines have a different userland, and
+	# thus, need a distinct triplet. However, they do not need
+	# kernel version information, so it can be replaced with a
+	# suitable tag, in the style of linux-gnu.
+	case "${UNAME_VERSION}" in
+	    Debian*)
+		release='-gnu'
+		;;
+	    *)
+		release=`echo ${UNAME_RELEASE}|sed -e 's/[-_].*/\./'`
+		;;
+	esac
+	# Since CPU_TYPE-MANUFACTURER-KERNEL-OPERATING_SYSTEM:
+	# contains redundant information, the shorter form:
+	# CPU_TYPE-MANUFACTURER-OPERATING_SYSTEM is used.
+	echo "${machine}-${os}${release}"
+	exit 0 ;;
+    amd64:OpenBSD:*:*)
+	echo x86_64-unknown-openbsd${UNAME_RELEASE}
+	exit 0 ;;
+    amiga:OpenBSD:*:*)
+	echo m68k-unknown-openbsd${UNAME_RELEASE}
+	exit 0 ;;
+    arc:OpenBSD:*:*)
+	echo mipsel-unknown-openbsd${UNAME_RELEASE}
+	exit 0 ;;
+    cats:OpenBSD:*:*)
+	echo arm-unknown-openbsd${UNAME_RELEASE}
+	exit 0 ;;
+    hp300:OpenBSD:*:*)
+	echo m68k-unknown-openbsd${UNAME_RELEASE}
+	exit 0 ;;
+    mac68k:OpenBSD:*:*)
+	echo m68k-unknown-openbsd${UNAME_RELEASE}
+	exit 0 ;;
+    macppc:OpenBSD:*:*)
+	echo powerpc-unknown-openbsd${UNAME_RELEASE}
+	exit 0 ;;
+    mvme68k:OpenBSD:*:*)
+	echo m68k-unknown-openbsd${UNAME_RELEASE}
+	exit 0 ;;
+    mvme88k:OpenBSD:*:*)
+	echo m88k-unknown-openbsd${UNAME_RELEASE}
+	exit 0 ;;
+    mvmeppc:OpenBSD:*:*)
+	echo powerpc-unknown-openbsd${UNAME_RELEASE}
+	exit 0 ;;
+    pegasos:OpenBSD:*:*)
+	echo powerpc-unknown-openbsd${UNAME_RELEASE}
+	exit 0 ;;
+    pmax:OpenBSD:*:*)
+	echo mipsel-unknown-openbsd${UNAME_RELEASE}
+	exit 0 ;;
+    sgi:OpenBSD:*:*)
+	echo mipseb-unknown-openbsd${UNAME_RELEASE}
+	exit 0 ;;
+    sun3:OpenBSD:*:*)
+	echo m68k-unknown-openbsd${UNAME_RELEASE}
+	exit 0 ;;
+    wgrisc:OpenBSD:*:*)
+	echo mipsel-unknown-openbsd${UNAME_RELEASE}
+	exit 0 ;;
+    *:OpenBSD:*:*)
+	echo ${UNAME_MACHINE}-unknown-openbsd${UNAME_RELEASE}
+	exit 0 ;;
+    *:ekkoBSD:*:*)
+	echo ${UNAME_MACHINE}-unknown-ekkobsd${UNAME_RELEASE}
+	exit 0 ;;
+    macppc:MirBSD:*:*)
+	echo powerppc-unknown-mirbsd${UNAME_RELEASE}
+	exit 0 ;;
+    *:MirBSD:*:*)
+	echo ${UNAME_MACHINE}-unknown-mirbsd${UNAME_RELEASE}
+	exit 0 ;;
+    alpha:OSF1:*:*)
+	if test $UNAME_RELEASE = "V4.0"; then
+		UNAME_RELEASE=`/usr/sbin/sizer -v | awk '{print $3}'`
+	fi
+	# According to Compaq, /usr/sbin/psrinfo has been available on
+	# OSF/1 and Tru64 systems produced since 1995.  I hope that
+	# covers most systems running today.  This code pipes the CPU
+	# types through head -n 1, so we only detect the type of CPU 0.
+	ALPHA_CPU_TYPE=`/usr/sbin/psrinfo -v | sed -n -e 's/^  The alpha \(.*\) processor.*$/\1/p' | head -n 1`
+	case "$ALPHA_CPU_TYPE" in
+	    "EV4 (21064)")
+		UNAME_MACHINE="alpha" ;;
+	    "EV4.5 (21064)")
+		UNAME_MACHINE="alpha" ;;
+	    "LCA4 (21066/21068)")
+		UNAME_MACHINE="alpha" ;;
+	    "EV5 (21164)")
+		UNAME_MACHINE="alphaev5" ;;
+	    "EV5.6 (21164A)")
+		UNAME_MACHINE="alphaev56" ;;
+	    "EV5.6 (21164PC)")
+		UNAME_MACHINE="alphapca56" ;;
+	    "EV5.7 (21164PC)")
+		UNAME_MACHINE="alphapca57" ;;
+	    "EV6 (21264)")
+		UNAME_MACHINE="alphaev6" ;;
+	    "EV6.7 (21264A)")
+		UNAME_MACHINE="alphaev67" ;;
+	    "EV6.8CB (21264C)")
+		UNAME_MACHINE="alphaev68" ;;
+	    "EV6.8AL (21264B)")
+		UNAME_MACHINE="alphaev68" ;;
+	    "EV6.8CX (21264D)")
+		UNAME_MACHINE="alphaev68" ;;
+	    "EV6.9A (21264/EV69A)")
+		UNAME_MACHINE="alphaev69" ;;
+	    "EV7 (21364)")
+		UNAME_MACHINE="alphaev7" ;;
+	    "EV7.9 (21364A)")
+		UNAME_MACHINE="alphaev79" ;;
+	esac
+	# A Vn.n version is a released version.
+	# A Tn.n version is a released field test version.
+	# A Xn.n version is an unreleased experimental baselevel.
+	# 1.2 uses "1.2" for uname -r.
+	echo ${UNAME_MACHINE}-dec-osf`echo ${UNAME_RELEASE} | sed -e 's/^[VTX]//' | tr 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' 'abcdefghijklmnopqrstuvwxyz'`
+	exit 0 ;;
+    Alpha*:OpenVMS:*:*)
+	echo alpha-hp-vms
+	exit 0 ;;
+    Alpha\ *:Windows_NT*:*)
+	# How do we know it's Interix rather than the generic POSIX subsystem?
+	# Should we change UNAME_MACHINE based on the output of uname instead
+	# of the specific Alpha model?
+	echo alpha-pc-interix
+	exit 0 ;;
+    21064:Windows_NT:50:3)
+	echo alpha-dec-winnt3.5
+	exit 0 ;;
+    Amiga*:UNIX_System_V:4.0:*)
+	echo m68k-unknown-sysv4
+	exit 0;;
+    *:[Aa]miga[Oo][Ss]:*:*)
+	echo ${UNAME_MACHINE}-unknown-amigaos
+	exit 0 ;;
+    *:[Mm]orph[Oo][Ss]:*:*)
+	echo ${UNAME_MACHINE}-unknown-morphos
+	exit 0 ;;
+    *:OS/390:*:*)
+	echo i370-ibm-openedition
+	exit 0 ;;
+    *:OS400:*:*)
+        echo powerpc-ibm-os400
+	exit 0 ;;
+    arm:RISC*:1.[012]*:*|arm:riscix:1.[012]*:*)
+	echo arm-acorn-riscix${UNAME_RELEASE}
+	exit 0;;
+    SR2?01:HI-UX/MPP:*:* | SR8000:HI-UX/MPP:*:*)
+	echo hppa1.1-hitachi-hiuxmpp
+	exit 0;;
+    Pyramid*:OSx*:*:* | MIS*:OSx*:*:* | MIS*:SMP_DC-OSx*:*:*)
+	# akee@wpdis03.wpafb.af.mil (Earle F. Ake) contributed MIS and NILE.
+	if test "`(/bin/universe) 2>/dev/null`" = att ; then
+		echo pyramid-pyramid-sysv3
+	else
+		echo pyramid-pyramid-bsd
+	fi
+	exit 0 ;;
+    NILE*:*:*:dcosx)
+	echo pyramid-pyramid-svr4
+	exit 0 ;;
+    DRS?6000:unix:4.0:6*)
+	echo sparc-icl-nx6
+	exit 0 ;;
+    DRS?6000:UNIX_SV:4.2*:7*)
+	case `/usr/bin/uname -p` in
+	    sparc) echo sparc-icl-nx7 && exit 0 ;;
+	esac ;;
+    sun4H:SunOS:5.*:*)
+	echo sparc-hal-solaris2`echo ${UNAME_RELEASE}|sed -e 's/[^.]*//'`
+	exit 0 ;;
+    sun4*:SunOS:5.*:* | tadpole*:SunOS:5.*:*)
+	echo sparc-sun-solaris2`echo ${UNAME_RELEASE}|sed -e 's/[^.]*//'`
+	exit 0 ;;
+    i86pc:SunOS:5.*:*)
+	echo i386-pc-solaris2`echo ${UNAME_RELEASE}|sed -e 's/[^.]*//'`
+	exit 0 ;;
+    sun4*:SunOS:6*:*)
+	# According to config.sub, this is the proper way to canonicalize
+	# SunOS6.  Hard to guess exactly what SunOS6 will be like, but
+	# it's likely to be more like Solaris than SunOS4.
+	echo sparc-sun-solaris3`echo ${UNAME_RELEASE}|sed -e 's/[^.]*//'`
+	exit 0 ;;
+    sun4*:SunOS:*:*)
+	case "`/usr/bin/arch -k`" in
+	    Series*|S4*)
+		UNAME_RELEASE=`uname -v`
+		;;
+	esac
+	# Japanese Language versions have a version number like `4.1.3-JL'.
+	echo sparc-sun-sunos`echo ${UNAME_RELEASE}|sed -e 's/-/_/'`
+	exit 0 ;;
+    sun3*:SunOS:*:*)
+	echo m68k-sun-sunos${UNAME_RELEASE}
+	exit 0 ;;
+    sun*:*:4.2BSD:*)
+	UNAME_RELEASE=`(sed 1q /etc/motd | awk '{print substr($5,1,3)}') 2>/dev/null`
+	test "x${UNAME_RELEASE}" = "x" && UNAME_RELEASE=3
+	case "`/bin/arch`" in
+	    sun3)
+		echo m68k-sun-sunos${UNAME_RELEASE}
+		;;
+	    sun4)
+		echo sparc-sun-sunos${UNAME_RELEASE}
+		;;
+	esac
+	exit 0 ;;
+    aushp:SunOS:*:*)
+	echo sparc-auspex-sunos${UNAME_RELEASE}
+	exit 0 ;;
+    # The situation for MiNT is a little confusing.  The machine name
+    # can be virtually everything (everything which is not
+    # "atarist" or "atariste" at least should have a processor
+    # > m68000).  The system name ranges from "MiNT" over "FreeMiNT"
+    # to the lowercase version "mint" (or "freemint").  Finally
+    # the system name "TOS" denotes a system which is actually not
+    # MiNT.  But MiNT is downward compatible to TOS, so this should
+    # be no problem.
+    atarist[e]:*MiNT:*:* | atarist[e]:*mint:*:* | atarist[e]:*TOS:*:*)
+        echo m68k-atari-mint${UNAME_RELEASE}
+	exit 0 ;;
+    atari*:*MiNT:*:* | atari*:*mint:*:* | atarist[e]:*TOS:*:*)
+	echo m68k-atari-mint${UNAME_RELEASE}
+        exit 0 ;;
+    *falcon*:*MiNT:*:* | *falcon*:*mint:*:* | *falcon*:*TOS:*:*)
+        echo m68k-atari-mint${UNAME_RELEASE}
+	exit 0 ;;
+    milan*:*MiNT:*:* | milan*:*mint:*:* | *milan*:*TOS:*:*)
+        echo m68k-milan-mint${UNAME_RELEASE}
+        exit 0 ;;
+    hades*:*MiNT:*:* | hades*:*mint:*:* | *hades*:*TOS:*:*)
+        echo m68k-hades-mint${UNAME_RELEASE}
+        exit 0 ;;
+    *:*MiNT:*:* | *:*mint:*:* | *:*TOS:*:*)
+        echo m68k-unknown-mint${UNAME_RELEASE}
+        exit 0 ;;
+    m68k:machten:*:*)
+	echo m68k-apple-machten${UNAME_RELEASE}
+	exit 0 ;;
+    powerpc:machten:*:*)
+	echo powerpc-apple-machten${UNAME_RELEASE}
+	exit 0 ;;
+    RISC*:Mach:*:*)
+	echo mips-dec-mach_bsd4.3
+	exit 0 ;;
+    RISC*:ULTRIX:*:*)
+	echo mips-dec-ultrix${UNAME_RELEASE}
+	exit 0 ;;
+    VAX*:ULTRIX*:*:*)
+	echo vax-dec-ultrix${UNAME_RELEASE}
+	exit 0 ;;
+    2020:CLIX:*:* | 2430:CLIX:*:*)
+	echo clipper-intergraph-clix${UNAME_RELEASE}
+	exit 0 ;;
+    mips:*:*:UMIPS | mips:*:*:RISCos)
+	eval $set_cc_for_build
+	sed 's/^	//' << EOF >$dummy.c
+#ifdef __cplusplus
+#include <stdio.h>  /* for printf() prototype */
+	int main (int argc, char *argv[]) {
+#else
+	int main (argc, argv) int argc; char *argv[]; {
+#endif
+	#if defined (host_mips) && defined (MIPSEB)
+	#if defined (SYSTYPE_SYSV)
+	  printf ("mips-mips-riscos%ssysv\n", argv[1]); exit (0);
+	#endif
+	#if defined (SYSTYPE_SVR4)
+	  printf ("mips-mips-riscos%ssvr4\n", argv[1]); exit (0);
+	#endif
+	#if defined (SYSTYPE_BSD43) || defined(SYSTYPE_BSD)
+	  printf ("mips-mips-riscos%sbsd\n", argv[1]); exit (0);
+	#endif
+	#endif
+	  exit (-1);
+	}
+EOF
+	$CC_FOR_BUILD -o $dummy $dummy.c \
+	  && $dummy `echo "${UNAME_RELEASE}" | sed -n 's/\([0-9]*\).*/\1/p'` \
+	  && exit 0
+	echo mips-mips-riscos${UNAME_RELEASE}
+	exit 0 ;;
+    Motorola:PowerMAX_OS:*:*)
+	echo powerpc-motorola-powermax
+	exit 0 ;;
+    Motorola:*:4.3:PL8-*)
+	echo powerpc-harris-powermax
+	exit 0 ;;
+    Night_Hawk:*:*:PowerMAX_OS | Synergy:PowerMAX_OS:*:*)
+	echo powerpc-harris-powermax
+	exit 0 ;;
+    Night_Hawk:Power_UNIX:*:*)
+	echo powerpc-harris-powerunix
+	exit 0 ;;
+    m88k:CX/UX:7*:*)
+	echo m88k-harris-cxux7
+	exit 0 ;;
+    m88k:*:4*:R4*)
+	echo m88k-motorola-sysv4
+	exit 0 ;;
+    m88k:*:3*:R3*)
+	echo m88k-motorola-sysv3
+	exit 0 ;;
+    AViiON:dgux:*:*)
+        # DG/UX returns AViiON for all architectures
+        UNAME_PROCESSOR=`/usr/bin/uname -p`
+	if [ $UNAME_PROCESSOR = mc88100 ] || [ $UNAME_PROCESSOR = mc88110 ]
+	then
+	    if [ ${TARGET_BINARY_INTERFACE}x = m88kdguxelfx ] || \
+	       [ ${TARGET_BINARY_INTERFACE}x = x ]
+	    then
+		echo m88k-dg-dgux${UNAME_RELEASE}
+	    else
+		echo m88k-dg-dguxbcs${UNAME_RELEASE}
+	    fi
+	else
+	    echo i586-dg-dgux${UNAME_RELEASE}
+	fi
+ 	exit 0 ;;
+    M88*:DolphinOS:*:*)	# DolphinOS (SVR3)
+	echo m88k-dolphin-sysv3
+	exit 0 ;;
+    M88*:*:R3*:*)
+	# Delta 88k system running SVR3
+	echo m88k-motorola-sysv3
+	exit 0 ;;
+    XD88*:*:*:*) # Tektronix XD88 system running UTekV (SVR3)
+	echo m88k-tektronix-sysv3
+	exit 0 ;;
+    Tek43[0-9][0-9]:UTek:*:*) # Tektronix 4300 system running UTek (BSD)
+	echo m68k-tektronix-bsd
+	exit 0 ;;
+    *:IRIX*:*:*)
+	echo mips-sgi-irix`echo ${UNAME_RELEASE}|sed -e 's/-/_/g'`
+	exit 0 ;;
+    ????????:AIX?:[12].1:2)   # AIX 2.2.1 or AIX 2.1.1 is RT/PC AIX.
+	echo romp-ibm-aix      # uname -m gives an 8 hex-code CPU id
+	exit 0 ;;              # Note that: echo "'`uname -s`'" gives 'AIX '
+    i*86:AIX:*:*)
+	echo i386-ibm-aix
+	exit 0 ;;
+    ia64:AIX:*:*)
+	if [ -x /usr/bin/oslevel ] ; then
+		IBM_REV=`/usr/bin/oslevel`
+	else
+		IBM_REV=${UNAME_VERSION}.${UNAME_RELEASE}
+	fi
+	echo ${UNAME_MACHINE}-ibm-aix${IBM_REV}
+	exit 0 ;;
+    *:AIX:2:3)
+	if grep bos325 /usr/include/stdio.h >/dev/null 2>&1; then
+		eval $set_cc_for_build
+		sed 's/^		//' << EOF >$dummy.c
+		#include <sys/systemcfg.h>
+
+		main()
+			{
+			if (!__power_pc())
+				exit(1);
+			puts("powerpc-ibm-aix3.2.5");
+			exit(0);
+			}
+EOF
+		$CC_FOR_BUILD -o $dummy $dummy.c && $dummy && exit 0
+		echo rs6000-ibm-aix3.2.5
+	elif grep bos324 /usr/include/stdio.h >/dev/null 2>&1; then
+		echo rs6000-ibm-aix3.2.4
+	else
+		echo rs6000-ibm-aix3.2
+	fi
+	exit 0 ;;
+    *:AIX:*:[45])
+	IBM_CPU_ID=`/usr/sbin/lsdev -C -c processor -S available | sed 1q | awk '{ print $1 }'`
+	if /usr/sbin/lsattr -El ${IBM_CPU_ID} | grep ' POWER' >/dev/null 2>&1; then
+		IBM_ARCH=rs6000
+	else
+		IBM_ARCH=powerpc
+	fi
+	if [ -x /usr/bin/oslevel ] ; then
+		IBM_REV=`/usr/bin/oslevel`
+	else
+		IBM_REV=${UNAME_VERSION}.${UNAME_RELEASE}
+	fi
+	echo ${IBM_ARCH}-ibm-aix${IBM_REV}
+	exit 0 ;;
+    *:AIX:*:*)
+	echo rs6000-ibm-aix
+	exit 0 ;;
+    ibmrt:4.4BSD:*|romp-ibm:BSD:*)
+	echo romp-ibm-bsd4.4
+	exit 0 ;;
+    ibmrt:*BSD:*|romp-ibm:BSD:*)            # covers RT/PC BSD and
+	echo romp-ibm-bsd${UNAME_RELEASE}   # 4.3 with uname added to
+	exit 0 ;;                           # report: romp-ibm BSD 4.3
+    *:BOSX:*:*)
+	echo rs6000-bull-bosx
+	exit 0 ;;
+    DPX/2?00:B.O.S.:*:*)
+	echo m68k-bull-sysv3
+	exit 0 ;;
+    9000/[34]??:4.3bsd:1.*:*)
+	echo m68k-hp-bsd
+	exit 0 ;;
+    hp300:4.4BSD:*:* | 9000/[34]??:4.3bsd:2.*:*)
+	echo m68k-hp-bsd4.4
+	exit 0 ;;
+    9000/[34678]??:HP-UX:*:*)
+	HPUX_REV=`echo ${UNAME_RELEASE}|sed -e 's/[^.]*.[0B]*//'`
+	case "${UNAME_MACHINE}" in
+	    9000/31? )            HP_ARCH=m68000 ;;
+	    9000/[34]?? )         HP_ARCH=m68k ;;
+	    9000/[678][0-9][0-9])
+		if [ -x /usr/bin/getconf ]; then
+		    sc_cpu_version=`/usr/bin/getconf SC_CPU_VERSION 2>/dev/null`
+                    sc_kernel_bits=`/usr/bin/getconf SC_KERNEL_BITS 2>/dev/null`
+                    case "${sc_cpu_version}" in
+                      523) HP_ARCH="hppa1.0" ;; # CPU_PA_RISC1_0
+                      528) HP_ARCH="hppa1.1" ;; # CPU_PA_RISC1_1
+                      532)                      # CPU_PA_RISC2_0
+                        case "${sc_kernel_bits}" in
+                          32) HP_ARCH="hppa2.0n" ;;
+                          64) HP_ARCH="hppa2.0w" ;;
+			  '') HP_ARCH="hppa2.0" ;;   # HP-UX 10.20
+                        esac ;;
+                    esac
+		fi
+		if [ "${HP_ARCH}" = "" ]; then
+		    eval $set_cc_for_build
+		    sed 's/^              //' << EOF >$dummy.c
+
+              #define _HPUX_SOURCE
+              #include <stdlib.h>
+              #include <unistd.h>
+
+              int main ()
+              {
+              #if defined(_SC_KERNEL_BITS)
+                  long bits = sysconf(_SC_KERNEL_BITS);
+              #endif
+                  long cpu  = sysconf (_SC_CPU_VERSION);
+
+                  switch (cpu)
+              	{
+              	case CPU_PA_RISC1_0: puts ("hppa1.0"); break;
+              	case CPU_PA_RISC1_1: puts ("hppa1.1"); break;
+              	case CPU_PA_RISC2_0:
+              #if defined(_SC_KERNEL_BITS)
+              	    switch (bits)
+              		{
+              		case 64: puts ("hppa2.0w"); break;
+              		case 32: puts ("hppa2.0n"); break;
+              		default: puts ("hppa2.0"); break;
+              		} break;
+              #else  /* !defined(_SC_KERNEL_BITS) */
+              	    puts ("hppa2.0"); break;
+              #endif
+              	default: puts ("hppa1.0"); break;
+              	}
+                  exit (0);
+              }
+EOF
+		    (CCOPTS= $CC_FOR_BUILD -o $dummy $dummy.c 2>/dev/null) && HP_ARCH=`$dummy`
+		    test -z "$HP_ARCH" && HP_ARCH=hppa
+		fi ;;
+	esac
+	if [ ${HP_ARCH} = "hppa2.0w" ]
+	then
+	    # avoid double evaluation of $set_cc_for_build
+	    test -n "$CC_FOR_BUILD" || eval $set_cc_for_build
+	    if echo __LP64__ | (CCOPTS= $CC_FOR_BUILD -E -) | grep __LP64__ >/dev/null
+	    then
+		HP_ARCH="hppa2.0w"
+	    else
+		HP_ARCH="hppa64"
+	    fi
+	fi
+	echo ${HP_ARCH}-hp-hpux${HPUX_REV}
+	exit 0 ;;
+    ia64:HP-UX:*:*)
+	HPUX_REV=`echo ${UNAME_RELEASE}|sed -e 's/[^.]*.[0B]*//'`
+	echo ia64-hp-hpux${HPUX_REV}
+	exit 0 ;;
+    3050*:HI-UX:*:*)
+	eval $set_cc_for_build
+	sed 's/^	//' << EOF >$dummy.c
+	#include <unistd.h>
+	int
+	main ()
+	{
+	  long cpu = sysconf (_SC_CPU_VERSION);
+	  /* The order matters, because CPU_IS_HP_MC68K erroneously returns
+	     true for CPU_PA_RISC1_0.  CPU_IS_PA_RISC returns correct
+	     results, however.  */
+	  if (CPU_IS_PA_RISC (cpu))
+	    {
+	      switch (cpu)
+		{
+		  case CPU_PA_RISC1_0: puts ("hppa1.0-hitachi-hiuxwe2"); break;
+		  case CPU_PA_RISC1_1: puts ("hppa1.1-hitachi-hiuxwe2"); break;
+		  case CPU_PA_RISC2_0: puts ("hppa2.0-hitachi-hiuxwe2"); break;
+		  default: puts ("hppa-hitachi-hiuxwe2"); break;
+		}
+	    }
+	  else if (CPU_IS_HP_MC68K (cpu))
+	    puts ("m68k-hitachi-hiuxwe2");
+	  else puts ("unknown-hitachi-hiuxwe2");
+	  exit (0);
+	}
+EOF
+	$CC_FOR_BUILD -o $dummy $dummy.c && $dummy && exit 0
+	echo unknown-hitachi-hiuxwe2
+	exit 0 ;;
+    9000/7??:4.3bsd:*:* | 9000/8?[79]:4.3bsd:*:* )
+	echo hppa1.1-hp-bsd
+	exit 0 ;;
+    9000/8??:4.3bsd:*:*)
+	echo hppa1.0-hp-bsd
+	exit 0 ;;
+    *9??*:MPE/iX:*:* | *3000*:MPE/iX:*:*)
+	echo hppa1.0-hp-mpeix
+	exit 0 ;;
+    hp7??:OSF1:*:* | hp8?[79]:OSF1:*:* )
+	echo hppa1.1-hp-osf
+	exit 0 ;;
+    hp8??:OSF1:*:*)
+	echo hppa1.0-hp-osf
+	exit 0 ;;
+    i*86:OSF1:*:*)
+	if [ -x /usr/sbin/sysversion ] ; then
+	    echo ${UNAME_MACHINE}-unknown-osf1mk
+	else
+	    echo ${UNAME_MACHINE}-unknown-osf1
+	fi
+	exit 0 ;;
+    parisc*:Lites*:*:*)
+	echo hppa1.1-hp-lites
+	exit 0 ;;
+    C1*:ConvexOS:*:* | convex:ConvexOS:C1*:*)
+	echo c1-convex-bsd
+        exit 0 ;;
+    C2*:ConvexOS:*:* | convex:ConvexOS:C2*:*)
+	if getsysinfo -f scalar_acc
+	then echo c32-convex-bsd
+	else echo c2-convex-bsd
+	fi
+        exit 0 ;;
+    C34*:ConvexOS:*:* | convex:ConvexOS:C34*:*)
+	echo c34-convex-bsd
+        exit 0 ;;
+    C38*:ConvexOS:*:* | convex:ConvexOS:C38*:*)
+	echo c38-convex-bsd
+        exit 0 ;;
+    C4*:ConvexOS:*:* | convex:ConvexOS:C4*:*)
+	echo c4-convex-bsd
+        exit 0 ;;
+    CRAY*Y-MP:*:*:*)
+	echo ymp-cray-unicos${UNAME_RELEASE} | sed -e 's/\.[^.]*$/.X/'
+	exit 0 ;;
+    CRAY*[A-Z]90:*:*:*)
+	echo ${UNAME_MACHINE}-cray-unicos${UNAME_RELEASE} \
+	| sed -e 's/CRAY.*\([A-Z]90\)/\1/' \
+	      -e y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/ \
+	      -e 's/\.[^.]*$/.X/'
+	exit 0 ;;
+    CRAY*TS:*:*:*)
+	echo t90-cray-unicos${UNAME_RELEASE} | sed -e 's/\.[^.]*$/.X/'
+	exit 0 ;;
+    CRAY*T3E:*:*:*)
+	echo alphaev5-cray-unicosmk${UNAME_RELEASE} | sed -e 's/\.[^.]*$/.X/'
+	exit 0 ;;
+    CRAY*SV1:*:*:*)
+	echo sv1-cray-unicos${UNAME_RELEASE} | sed -e 's/\.[^.]*$/.X/'
+	exit 0 ;;
+    *:UNICOS/mp:*:*)
+	echo nv1-cray-unicosmp${UNAME_RELEASE} | sed -e 's/\.[^.]*$/.X/'
+	exit 0 ;;
+    F30[01]:UNIX_System_V:*:* | F700:UNIX_System_V:*:*)
+	FUJITSU_PROC=`uname -m | tr 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' 'abcdefghijklmnopqrstuvwxyz'`
+        FUJITSU_SYS=`uname -p | tr 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' 'abcdefghijklmnopqrstuvwxyz' | sed -e 's/\///'`
+        FUJITSU_REL=`echo ${UNAME_RELEASE} | sed -e 's/ /_/'`
+        echo "${FUJITSU_PROC}-fujitsu-${FUJITSU_SYS}${FUJITSU_REL}"
+        exit 0 ;;
+    5000:UNIX_System_V:4.*:*)
+        FUJITSU_SYS=`uname -p | tr 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' 'abcdefghijklmnopqrstuvwxyz' | sed -e 's/\///'`
+        FUJITSU_REL=`echo ${UNAME_RELEASE} | tr 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' 'abcdefghijklmnopqrstuvwxyz' | sed -e 's/ /_/'`
+        echo "sparc-fujitsu-${FUJITSU_SYS}${FUJITSU_REL}"
+	exit 0 ;;
+    i*86:BSD/386:*:* | i*86:BSD/OS:*:* | *:Ascend\ Embedded/OS:*:*)
+	echo ${UNAME_MACHINE}-pc-bsdi${UNAME_RELEASE}
+	exit 0 ;;
+    sparc*:BSD/OS:*:*)
+	echo sparc-unknown-bsdi${UNAME_RELEASE}
+	exit 0 ;;
+    *:BSD/OS:*:*)
+	echo ${UNAME_MACHINE}-unknown-bsdi${UNAME_RELEASE}
+	exit 0 ;;
+    *:FreeBSD:*:*)
+	# Determine whether the default compiler uses glibc.
+	eval $set_cc_for_build
+	sed 's/^	//' << EOF >$dummy.c
+	#include <features.h>
+	#if __GLIBC__ >= 2
+	LIBC=gnu
+	#else
+	LIBC=
+	#endif
+EOF
+	eval `$CC_FOR_BUILD -E $dummy.c 2>/dev/null | grep ^LIBC=`
+	# GNU/KFreeBSD systems have a "k" prefix to indicate we are using
+	# FreeBSD's kernel, but not the complete OS.
+	case ${LIBC} in gnu) kernel_only='k' ;; esac
+	echo ${UNAME_MACHINE}-unknown-${kernel_only}freebsd`echo ${UNAME_RELEASE}|sed -e 's/[-(].*//'`${LIBC:+-$LIBC}
+	exit 0 ;;
+    i*:CYGWIN*:*)
+	echo ${UNAME_MACHINE}-pc-cygwin
+	exit 0 ;;
+    i*:MINGW*:*)
+	echo ${UNAME_MACHINE}-pc-mingw32
+	exit 0 ;;
+    i*:PW*:*)
+	echo ${UNAME_MACHINE}-pc-pw32
+	exit 0 ;;
+    x86:Interix*:[34]*)
+	echo i586-pc-interix${UNAME_RELEASE}|sed -e 's/\..*//'
+	exit 0 ;;
+    [345]86:Windows_95:* | [345]86:Windows_98:* | [345]86:Windows_NT:*)
+	echo i${UNAME_MACHINE}-pc-mks
+	exit 0 ;;
+    i*:Windows_NT*:* | Pentium*:Windows_NT*:*)
+	# How do we know it's Interix rather than the generic POSIX subsystem?
+	# It also conflicts with pre-2.0 versions of AT&T UWIN. Should we
+	# UNAME_MACHINE based on the output of uname instead of i386?
+	echo i586-pc-interix
+	exit 0 ;;
+    i*:UWIN*:*)
+	echo ${UNAME_MACHINE}-pc-uwin
+	exit 0 ;;
+    p*:CYGWIN*:*)
+	echo powerpcle-unknown-cygwin
+	exit 0 ;;
+    prep*:SunOS:5.*:*)
+	echo powerpcle-unknown-solaris2`echo ${UNAME_RELEASE}|sed -e 's/[^.]*//'`
+	exit 0 ;;
+    *:GNU:*:*)
+	# the GNU system
+	echo `echo ${UNAME_MACHINE}|sed -e 's,[-/].*$,,'`-unknown-gnu`echo ${UNAME_RELEASE}|sed -e 's,/.*$,,'`
+	exit 0 ;;
+    *:GNU/*:*:*)
+	# other systems with GNU libc and userland
+	echo ${UNAME_MACHINE}-unknown-`echo ${UNAME_SYSTEM} | sed 's,^[^/]*/,,' | tr '[A-Z]' '[a-z]'``echo ${UNAME_RELEASE}|sed -e 's/[-(].*//'`-gnu
+	exit 0 ;;
+    i*86:Minix:*:*)
+	echo ${UNAME_MACHINE}-pc-minix
+	exit 0 ;;
+    arm*:Linux:*:*)
+	echo ${UNAME_MACHINE}-unknown-linux-gnu
+	exit 0 ;;
+    cris:Linux:*:*)
+	echo cris-axis-linux-gnu
+	exit 0 ;;
+    ia64:Linux:*:*)
+	echo ${UNAME_MACHINE}-unknown-linux-gnu
+	exit 0 ;;
+    m68*:Linux:*:*)
+	echo ${UNAME_MACHINE}-unknown-linux-gnu
+	exit 0 ;;
+    mips:Linux:*:*)
+	eval $set_cc_for_build
+	sed 's/^	//' << EOF >$dummy.c
+	#undef CPU
+	#undef mips
+	#undef mipsel
+	#if defined(__MIPSEL__) || defined(__MIPSEL) || defined(_MIPSEL) || defined(MIPSEL)
+	CPU=mipsel
+	#else
+	#if defined(__MIPSEB__) || defined(__MIPSEB) || defined(_MIPSEB) || defined(MIPSEB)
+	CPU=mips
+	#else
+	CPU=
+	#endif
+	#endif
+EOF
+	eval `$CC_FOR_BUILD -E $dummy.c 2>/dev/null | grep ^CPU=`
+	test x"${CPU}" != x && echo "${CPU}-unknown-linux-gnu" && exit 0
+	;;
+    mips64:Linux:*:*)
+	eval $set_cc_for_build
+	sed 's/^	//' << EOF >$dummy.c
+	#undef CPU
+	#undef mips64
+	#undef mips64el
+	#if defined(__MIPSEL__) || defined(__MIPSEL) || defined(_MIPSEL) || defined(MIPSEL)
+	CPU=mips64el
+	#else
+	#if defined(__MIPSEB__) || defined(__MIPSEB) || defined(_MIPSEB) || defined(MIPSEB)
+	CPU=mips64
+	#else
+	CPU=
+	#endif
+	#endif
+EOF
+	eval `$CC_FOR_BUILD -E $dummy.c 2>/dev/null | grep ^CPU=`
+	test x"${CPU}" != x && echo "${CPU}-unknown-linux-gnu" && exit 0
+	;;
+    ppc:Linux:*:*)
+	echo powerpc-unknown-linux-gnu
+	exit 0 ;;
+    ppc64:Linux:*:*)
+	echo powerpc64-unknown-linux-gnu
+	exit 0 ;;
+    alpha:Linux:*:*)
+	case `sed -n '/^cpu model/s/^.*: \(.*\)/\1/p' < /proc/cpuinfo` in
+	  EV5)   UNAME_MACHINE=alphaev5 ;;
+	  EV56)  UNAME_MACHINE=alphaev56 ;;
+	  PCA56) UNAME_MACHINE=alphapca56 ;;
+	  PCA57) UNAME_MACHINE=alphapca56 ;;
+	  EV6)   UNAME_MACHINE=alphaev6 ;;
+	  EV67)  UNAME_MACHINE=alphaev67 ;;
+	  EV68*) UNAME_MACHINE=alphaev68 ;;
+        esac
+	objdump --private-headers /bin/sh | grep ld.so.1 >/dev/null
+	if test "$?" = 0 ; then LIBC="libc1" ; else LIBC="" ; fi
+	echo ${UNAME_MACHINE}-unknown-linux-gnu${LIBC}
+	exit 0 ;;
+    parisc:Linux:*:* | hppa:Linux:*:*)
+	# Look for CPU level
+	case `grep '^cpu[^a-z]*:' /proc/cpuinfo 2>/dev/null | cut -d' ' -f2` in
+	  PA7*) echo hppa1.1-unknown-linux-gnu ;;
+	  PA8*) echo hppa2.0-unknown-linux-gnu ;;
+	  *)    echo hppa-unknown-linux-gnu ;;
+	esac
+	exit 0 ;;
+    parisc64:Linux:*:* | hppa64:Linux:*:*)
+	echo hppa64-unknown-linux-gnu
+	exit 0 ;;
+    s390:Linux:*:* | s390x:Linux:*:*)
+	echo ${UNAME_MACHINE}-ibm-linux
+	exit 0 ;;
+    sh64*:Linux:*:*)
+    	echo ${UNAME_MACHINE}-unknown-linux-gnu
+	exit 0 ;;
+    sh*:Linux:*:*)
+	echo ${UNAME_MACHINE}-unknown-linux-gnu
+	exit 0 ;;
+    sparc:Linux:*:* | sparc64:Linux:*:*)
+	echo ${UNAME_MACHINE}-unknown-linux-gnu
+	exit 0 ;;
+    x86_64:Linux:*:*)
+	echo x86_64-unknown-linux-gnu
+	exit 0 ;;
+    i*86:Linux:*:*)
+	# The BFD linker knows what the default object file format is, so
+	# first see if it will tell us. cd to the root directory to prevent
+	# problems with other programs or directories called `ld' in the path.
+	# Set LC_ALL=C to ensure ld outputs messages in English.
+	ld_supported_targets=`cd /; LC_ALL=C ld --help 2>&1 \
+			 | sed -ne '/supported targets:/!d
+				    s/[ 	][ 	]*/ /g
+				    s/.*supported targets: *//
+				    s/ .*//
+				    p'`
+        case "$ld_supported_targets" in
+	  elf32-i386)
+		TENTATIVE="${UNAME_MACHINE}-pc-linux-gnu"
+		;;
+	  a.out-i386-linux)
+		echo "${UNAME_MACHINE}-pc-linux-gnuaout"
+		exit 0 ;;
+	  coff-i386)
+		echo "${UNAME_MACHINE}-pc-linux-gnucoff"
+		exit 0 ;;
+	  "")
+		# Either a pre-BFD a.out linker (linux-gnuoldld) or
+		# one that does not give us useful --help.
+		echo "${UNAME_MACHINE}-pc-linux-gnuoldld"
+		exit 0 ;;
+	esac
+	# Determine whether the default compiler is a.out or elf
+	eval $set_cc_for_build
+	sed 's/^	//' << EOF >$dummy.c
+	#include <features.h>
+	#ifdef __ELF__
+	# ifdef __GLIBC__
+	#  if __GLIBC__ >= 2
+	LIBC=gnu
+	#  else
+	LIBC=gnulibc1
+	#  endif
+	# else
+	LIBC=gnulibc1
+	# endif
+	#else
+	#ifdef __INTEL_COMPILER
+	LIBC=gnu
+	#else
+	LIBC=gnuaout
+	#endif
+	#endif
+	#ifdef __dietlibc__
+	LIBC=dietlibc
+	#endif
+EOF
+	eval `$CC_FOR_BUILD -E $dummy.c 2>/dev/null | grep ^LIBC=`
+	test x"${LIBC}" != x && echo "${UNAME_MACHINE}-pc-linux-${LIBC}" && exit 0
+	test x"${TENTATIVE}" != x && echo "${TENTATIVE}" && exit 0
+	;;
+    i*86:DYNIX/ptx:4*:*)
+	# ptx 4.0 does uname -s correctly, with DYNIX/ptx in there.
+	# earlier versions are messed up and put the nodename in both
+	# sysname and nodename.
+	echo i386-sequent-sysv4
+	exit 0 ;;
+    i*86:UNIX_SV:4.2MP:2.*)
+        # Unixware is an offshoot of SVR4, but it has its own version
+        # number series starting with 2...
+        # I am not positive that other SVR4 systems won't match this,
+	# I just have to hope.  -- rms.
+        # Use sysv4.2uw... so that sysv4* matches it.
+	echo ${UNAME_MACHINE}-pc-sysv4.2uw${UNAME_VERSION}
+	exit 0 ;;
+    i*86:OS/2:*:*)
+	# If we were able to find `uname', then EMX Unix compatibility
+	# is probably installed.
+	echo ${UNAME_MACHINE}-pc-os2-emx
+	exit 0 ;;
+    i*86:XTS-300:*:STOP)
+	echo ${UNAME_MACHINE}-unknown-stop
+	exit 0 ;;
+    i*86:atheos:*:*)
+	echo ${UNAME_MACHINE}-unknown-atheos
+	exit 0 ;;
+	i*86:syllable:*:*)
+	echo ${UNAME_MACHINE}-pc-syllable
+	exit 0 ;;
+    i*86:LynxOS:2.*:* | i*86:LynxOS:3.[01]*:* | i*86:LynxOS:4.0*:*)
+	echo i386-unknown-lynxos${UNAME_RELEASE}
+	exit 0 ;;
+    i*86:*DOS:*:*)
+	echo ${UNAME_MACHINE}-pc-msdosdjgpp
+	exit 0 ;;
+    i*86:*:4.*:* | i*86:SYSTEM_V:4.*:*)
+	UNAME_REL=`echo ${UNAME_RELEASE} | sed 's/\/MP$//'`
+	if grep Novell /usr/include/link.h >/dev/null 2>/dev/null; then
+		echo ${UNAME_MACHINE}-univel-sysv${UNAME_REL}
+	else
+		echo ${UNAME_MACHINE}-pc-sysv${UNAME_REL}
+	fi
+	exit 0 ;;
+    i*86:*:5:[78]*)
+	case `/bin/uname -X | grep "^Machine"` in
+	    *486*)	     UNAME_MACHINE=i486 ;;
+	    *Pentium)	     UNAME_MACHINE=i586 ;;
+	    *Pent*|*Celeron) UNAME_MACHINE=i686 ;;
+	esac
+	echo ${UNAME_MACHINE}-unknown-sysv${UNAME_RELEASE}${UNAME_SYSTEM}${UNAME_VERSION}
+	exit 0 ;;
+    i*86:*:3.2:*)
+	if test -f /usr/options/cb.name; then
+		UNAME_REL=`sed -n 's/.*Version //p' </usr/options/cb.name`
+		echo ${UNAME_MACHINE}-pc-isc$UNAME_REL
+	elif /bin/uname -X 2>/dev/null >/dev/null ; then
+		UNAME_REL=`(/bin/uname -X|grep Release|sed -e 's/.*= //')`
+		(/bin/uname -X|grep i80486 >/dev/null) && UNAME_MACHINE=i486
+		(/bin/uname -X|grep '^Machine.*Pentium' >/dev/null) \
+			&& UNAME_MACHINE=i586
+		(/bin/uname -X|grep '^Machine.*Pent *II' >/dev/null) \
+			&& UNAME_MACHINE=i686
+		(/bin/uname -X|grep '^Machine.*Pentium Pro' >/dev/null) \
+			&& UNAME_MACHINE=i686
+		echo ${UNAME_MACHINE}-pc-sco$UNAME_REL
+	else
+		echo ${UNAME_MACHINE}-pc-sysv32
+	fi
+	exit 0 ;;
+    pc:*:*:*)
+	# Left here for compatibility:
+        # uname -m prints for DJGPP always 'pc', but it prints nothing about
+        # the processor, so we play safe by assuming i386.
+	echo i386-pc-msdosdjgpp
+        exit 0 ;;
+    Intel:Mach:3*:*)
+	echo i386-pc-mach3
+	exit 0 ;;
+    paragon:*:*:*)
+	echo i860-intel-osf1
+	exit 0 ;;
+    i860:*:4.*:*) # i860-SVR4
+	if grep Stardent /usr/include/sys/uadmin.h >/dev/null 2>&1 ; then
+	  echo i860-stardent-sysv${UNAME_RELEASE} # Stardent Vistra i860-SVR4
+	else # Add other i860-SVR4 vendors below as they are discovered.
+	  echo i860-unknown-sysv${UNAME_RELEASE}  # Unknown i860-SVR4
+	fi
+	exit 0 ;;
+    mini*:CTIX:SYS*5:*)
+	# "miniframe"
+	echo m68010-convergent-sysv
+	exit 0 ;;
+    mc68k:UNIX:SYSTEM5:3.51m)
+	echo m68k-convergent-sysv
+	exit 0 ;;
+    M680?0:D-NIX:5.3:*)
+	echo m68k-diab-dnix
+	exit 0 ;;
+    M68*:*:R3V[567]*:*)
+	test -r /sysV68 && echo 'm68k-motorola-sysv' && exit 0 ;;
+    3[345]??:*:4.0:3.0 | 3[34]??A:*:4.0:3.0 | 3[34]??,*:*:4.0:3.0 | 3[34]??/*:*:4.0:3.0 | 4400:*:4.0:3.0 | 4850:*:4.0:3.0 | SKA40:*:4.0:3.0 | SDS2:*:4.0:3.0 | SHG2:*:4.0:3.0)
+	OS_REL=''
+	test -r /etc/.relid \
+	&& OS_REL=.`sed -n 's/[^ ]* [^ ]* \([0-9][0-9]\).*/\1/p' < /etc/.relid`
+	/bin/uname -p 2>/dev/null | grep 86 >/dev/null \
+	  && echo i486-ncr-sysv4.3${OS_REL} && exit 0
+	/bin/uname -p 2>/dev/null | /bin/grep entium >/dev/null \
+	  && echo i586-ncr-sysv4.3${OS_REL} && exit 0 ;;
+    3[34]??:*:4.0:* | 3[34]??,*:*:4.0:*)
+        /bin/uname -p 2>/dev/null | grep 86 >/dev/null \
+          && echo i486-ncr-sysv4 && exit 0 ;;
+    m68*:LynxOS:2.*:* | m68*:LynxOS:3.0*:*)
+	echo m68k-unknown-lynxos${UNAME_RELEASE}
+	exit 0 ;;
+    mc68030:UNIX_System_V:4.*:*)
+	echo m68k-atari-sysv4
+	exit 0 ;;
+    TSUNAMI:LynxOS:2.*:*)
+	echo sparc-unknown-lynxos${UNAME_RELEASE}
+	exit 0 ;;
+    rs6000:LynxOS:2.*:*)
+	echo rs6000-unknown-lynxos${UNAME_RELEASE}
+	exit 0 ;;
+    PowerPC:LynxOS:2.*:* | PowerPC:LynxOS:3.[01]*:* | PowerPC:LynxOS:4.0*:*)
+	echo powerpc-unknown-lynxos${UNAME_RELEASE}
+	exit 0 ;;
+    SM[BE]S:UNIX_SV:*:*)
+	echo mips-dde-sysv${UNAME_RELEASE}
+	exit 0 ;;
+    RM*:ReliantUNIX-*:*:*)
+	echo mips-sni-sysv4
+	exit 0 ;;
+    RM*:SINIX-*:*:*)
+	echo mips-sni-sysv4
+	exit 0 ;;
+    *:SINIX-*:*:*)
+	if uname -p 2>/dev/null >/dev/null ; then
+		UNAME_MACHINE=`(uname -p) 2>/dev/null`
+		echo ${UNAME_MACHINE}-sni-sysv4
+	else
+		echo ns32k-sni-sysv
+	fi
+	exit 0 ;;
+    PENTIUM:*:4.0*:*) # Unisys `ClearPath HMP IX 4000' SVR4/MP effort
+                      # says <Richard.M.Bartel@ccMail.Census.GOV>
+        echo i586-unisys-sysv4
+        exit 0 ;;
+    *:UNIX_System_V:4*:FTX*)
+	# From Gerald Hewes <hewes@openmarket.com>.
+	# How about differentiating between stratus architectures? -djm
+	echo hppa1.1-stratus-sysv4
+	exit 0 ;;
+    *:*:*:FTX*)
+	# From seanf@swdc.stratus.com.
+	echo i860-stratus-sysv4
+	exit 0 ;;
+    *:VOS:*:*)
+	# From Paul.Green@stratus.com.
+	echo hppa1.1-stratus-vos
+	exit 0 ;;
+    mc68*:A/UX:*:*)
+	echo m68k-apple-aux${UNAME_RELEASE}
+	exit 0 ;;
+    news*:NEWS-OS:6*:*)
+	echo mips-sony-newsos6
+	exit 0 ;;
+    R[34]000:*System_V*:*:* | R4000:UNIX_SYSV:*:* | R*000:UNIX_SV:*:*)
+	if [ -d /usr/nec ]; then
+	        echo mips-nec-sysv${UNAME_RELEASE}
+	else
+	        echo mips-unknown-sysv${UNAME_RELEASE}
+	fi
+        exit 0 ;;
+    BeBox:BeOS:*:*)	# BeOS running on hardware made by Be, PPC only.
+	echo powerpc-be-beos
+	exit 0 ;;
+    BeMac:BeOS:*:*)	# BeOS running on Mac or Mac clone, PPC only.
+	echo powerpc-apple-beos
+	exit 0 ;;
+    BePC:BeOS:*:*)	# BeOS running on Intel PC compatible.
+	echo i586-pc-beos
+	exit 0 ;;
+    SX-4:SUPER-UX:*:*)
+	echo sx4-nec-superux${UNAME_RELEASE}
+	exit 0 ;;
+    SX-5:SUPER-UX:*:*)
+	echo sx5-nec-superux${UNAME_RELEASE}
+	exit 0 ;;
+    SX-6:SUPER-UX:*:*)
+	echo sx6-nec-superux${UNAME_RELEASE}
+	exit 0 ;;
+    Power*:Rhapsody:*:*)
+	echo powerpc-apple-rhapsody${UNAME_RELEASE}
+	exit 0 ;;
+    *:Rhapsody:*:*)
+	echo ${UNAME_MACHINE}-apple-rhapsody${UNAME_RELEASE}
+	exit 0 ;;
+    *:Darwin:*:*)
+	case `uname -p` in
+	    *86) UNAME_PROCESSOR=i686 ;;
+	    powerpc) UNAME_PROCESSOR=powerpc ;;
+	esac
+	echo ${UNAME_PROCESSOR}-apple-darwin${UNAME_RELEASE}
+	exit 0 ;;
+    *:procnto*:*:* | *:QNX:[0123456789]*:*)
+	UNAME_PROCESSOR=`uname -p`
+	if test "$UNAME_PROCESSOR" = "x86"; then
+		UNAME_PROCESSOR=i386
+		UNAME_MACHINE=pc
+	fi
+	echo ${UNAME_PROCESSOR}-${UNAME_MACHINE}-nto-qnx${UNAME_RELEASE}
+	exit 0 ;;
+    *:QNX:*:4*)
+	echo i386-pc-qnx
+	exit 0 ;;
+    NSR-?:NONSTOP_KERNEL:*:*)
+	echo nsr-tandem-nsk${UNAME_RELEASE}
+	exit 0 ;;
+    *:NonStop-UX:*:*)
+	echo mips-compaq-nonstopux
+	exit 0 ;;
+    BS2000:POSIX*:*:*)
+	echo bs2000-siemens-sysv
+	exit 0 ;;
+    DS/*:UNIX_System_V:*:*)
+	echo ${UNAME_MACHINE}-${UNAME_SYSTEM}-${UNAME_RELEASE}
+	exit 0 ;;
+    *:Plan9:*:*)
+	# "uname -m" is not consistent, so use $cputype instead. 386
+	# is converted to i386 for consistency with other x86
+	# operating systems.
+	if test "$cputype" = "386"; then
+	    UNAME_MACHINE=i386
+	else
+	    UNAME_MACHINE="$cputype"
+	fi
+	echo ${UNAME_MACHINE}-unknown-plan9
+	exit 0 ;;
+    *:TOPS-10:*:*)
+	echo pdp10-unknown-tops10
+	exit 0 ;;
+    *:TENEX:*:*)
+	echo pdp10-unknown-tenex
+	exit 0 ;;
+    KS10:TOPS-20:*:* | KL10:TOPS-20:*:* | TYPE4:TOPS-20:*:*)
+	echo pdp10-dec-tops20
+	exit 0 ;;
+    XKL-1:TOPS-20:*:* | TYPE5:TOPS-20:*:*)
+	echo pdp10-xkl-tops20
+	exit 0 ;;
+    *:TOPS-20:*:*)
+	echo pdp10-unknown-tops20
+	exit 0 ;;
+    *:ITS:*:*)
+	echo pdp10-unknown-its
+	exit 0 ;;
+    SEI:*:*:SEIUX)
+        echo mips-sei-seiux${UNAME_RELEASE}
+	exit 0 ;;
+    *:DragonFly:*:*)
+	echo ${UNAME_MACHINE}-unknown-dragonfly`echo ${UNAME_RELEASE}|sed -e 's/[-(].*//'`
+	exit 0 ;;
+esac
+
+#echo '(No uname command or uname output not recognized.)' 1>&2
+#echo "${UNAME_MACHINE}:${UNAME_SYSTEM}:${UNAME_RELEASE}:${UNAME_VERSION}" 1>&2
+
+eval $set_cc_for_build
+cat >$dummy.c <<EOF
+#ifdef _SEQUENT_
+# include <sys/types.h>
+# include <sys/utsname.h>
+#endif
+main ()
+{
+#if defined (sony)
+#if defined (MIPSEB)
+  /* BFD wants "bsd" instead of "newsos".  Perhaps BFD should be changed,
+     I don't know....  */
+  printf ("mips-sony-bsd\n"); exit (0);
+#else
+#include <sys/param.h>
+  printf ("m68k-sony-newsos%s\n",
+#ifdef NEWSOS4
+          "4"
+#else
+	  ""
+#endif
+         ); exit (0);
+#endif
+#endif
+
+#if defined (__arm) && defined (__acorn) && defined (__unix)
+  printf ("arm-acorn-riscix"); exit (0);
+#endif
+
+#if defined (hp300) && !defined (hpux)
+  printf ("m68k-hp-bsd\n"); exit (0);
+#endif
+
+#if defined (NeXT)
+#if !defined (__ARCHITECTURE__)
+#define __ARCHITECTURE__ "m68k"
+#endif
+  int version;
+  version=`(hostinfo | sed -n 's/.*NeXT Mach \([0-9]*\).*/\1/p') 2>/dev/null`;
+  if (version < 4)
+    printf ("%s-next-nextstep%d\n", __ARCHITECTURE__, version);
+  else
+    printf ("%s-next-openstep%d\n", __ARCHITECTURE__, version);
+  exit (0);
+#endif
+
+#if defined (MULTIMAX) || defined (n16)
+#if defined (UMAXV)
+  printf ("ns32k-encore-sysv\n"); exit (0);
+#else
+#if defined (CMU)
+  printf ("ns32k-encore-mach\n"); exit (0);
+#else
+  printf ("ns32k-encore-bsd\n"); exit (0);
+#endif
+#endif
+#endif
+
+#if defined (__386BSD__)
+  printf ("i386-pc-bsd\n"); exit (0);
+#endif
+
+#if defined (sequent)
+#if defined (i386)
+  printf ("i386-sequent-dynix\n"); exit (0);
+#endif
+#if defined (ns32000)
+  printf ("ns32k-sequent-dynix\n"); exit (0);
+#endif
+#endif
+
+#if defined (_SEQUENT_)
+    struct utsname un;
+
+    uname(&un);
+
+    if (strncmp(un.version, "V2", 2) == 0) {
+	printf ("i386-sequent-ptx2\n"); exit (0);
+    }
+    if (strncmp(un.version, "V1", 2) == 0) { /* XXX is V1 correct? */
+	printf ("i386-sequent-ptx1\n"); exit (0);
+    }
+    printf ("i386-sequent-ptx\n"); exit (0);
+
+#endif
+
+#if defined (vax)
+# if !defined (ultrix)
+#  include <sys/param.h>
+#  if defined (BSD)
+#   if BSD == 43
+      printf ("vax-dec-bsd4.3\n"); exit (0);
+#   else
+#    if BSD == 199006
+      printf ("vax-dec-bsd4.3reno\n"); exit (0);
+#    else
+      printf ("vax-dec-bsd\n"); exit (0);
+#    endif
+#   endif
+#  else
+    printf ("vax-dec-bsd\n"); exit (0);
+#  endif
+# else
+    printf ("vax-dec-ultrix\n"); exit (0);
+# endif
+#endif
+
+#if defined (alliant) && defined (i860)
+  printf ("i860-alliant-bsd\n"); exit (0);
+#endif
+
+  exit (1);
+}
+EOF
+
+$CC_FOR_BUILD -o $dummy $dummy.c 2>/dev/null && $dummy && exit 0
+
+# Apollos put the system type in the environment.
+
+test -d /usr/apollo && { echo ${ISP}-apollo-${SYSTYPE}; exit 0; }
+
+# Convex versions that predate uname can use getsysinfo(1)
+
+if [ -x /usr/convex/getsysinfo ]
+then
+    case `getsysinfo -f cpu_type` in
+    c1*)
+	echo c1-convex-bsd
+	exit 0 ;;
+    c2*)
+	if getsysinfo -f scalar_acc
+	then echo c32-convex-bsd
+	else echo c2-convex-bsd
+	fi
+	exit 0 ;;
+    c34*)
+	echo c34-convex-bsd
+	exit 0 ;;
+    c38*)
+	echo c38-convex-bsd
+	exit 0 ;;
+    c4*)
+	echo c4-convex-bsd
+	exit 0 ;;
+    esac
+fi
+
+cat >&2 <<EOF
+$0: unable to guess system type
+
+This script, last modified $timestamp, has failed to recognize
+the operating system you are using. It is advised that you
+download the most up to date version of the config scripts from
+
+    ftp://ftp.gnu.org/pub/gnu/config/
+
+If the version you run ($0) is already up to date, please
+send the following data and any information you think might be
+pertinent to <config-patches@gnu.org> in order to provide the needed
+information to handle your system.
+
+config.guess timestamp = $timestamp
+
+uname -m = `(uname -m) 2>/dev/null || echo unknown`
+uname -r = `(uname -r) 2>/dev/null || echo unknown`
+uname -s = `(uname -s) 2>/dev/null || echo unknown`
+uname -v = `(uname -v) 2>/dev/null || echo unknown`
+
+/usr/bin/uname -p = `(/usr/bin/uname -p) 2>/dev/null`
+/bin/uname -X     = `(/bin/uname -X) 2>/dev/null`
+
+hostinfo               = `(hostinfo) 2>/dev/null`
+/bin/universe          = `(/bin/universe) 2>/dev/null`
+/usr/bin/arch -k       = `(/usr/bin/arch -k) 2>/dev/null`
+/bin/arch              = `(/bin/arch) 2>/dev/null`
+/usr/bin/oslevel       = `(/usr/bin/oslevel) 2>/dev/null`
+/usr/convex/getsysinfo = `(/usr/convex/getsysinfo) 2>/dev/null`
+
+UNAME_MACHINE = ${UNAME_MACHINE}
+UNAME_RELEASE = ${UNAME_RELEASE}
+UNAME_SYSTEM  = ${UNAME_SYSTEM}
+UNAME_VERSION = ${UNAME_VERSION}
+EOF
+
+exit 1
+
+# Local variables:
+# eval: (add-hook 'write-file-hooks 'time-stamp)
+# time-stamp-start: "timestamp='"
+# time-stamp-format: "%:y-%02m-%02d"
+# time-stamp-end: "'"
+# End:
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/config.h.in b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/config.h.in
new file mode 100644
index 0000000..8e1aa84
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/config.h.in
@@ -0,0 +1,130 @@
+/* config.h.in.  Generated from configure.in by autoheader.  */
+
+/* Define to 1 if you have the <fcntl.h> header file. */
+#undef HAVE_FCNTL_H
+
+/* Define to 1 if you have the `fseeko64' function. */
+#undef HAVE_FSEEKO64
+
+/* Define to 1 if you have the `gettimeofday' function. */
+#undef HAVE_GETTIMEOFDAY
+
+/* Define to 1 if you have the <inttypes.h> header file. */
+#undef HAVE_INTTYPES_H
+
+/* Define to 1 if you have the `m' library (-lm). */
+#undef HAVE_LIBM
+
+/* Define to 1 if you have the `pthread' library (-lpthread). */
+#undef HAVE_LIBPTHREAD
+
+/* Define to 1 if you have the <limits.h> header file. */
+#undef HAVE_LIMITS_H
+
+/* Define to 1 if you have the `lrand48_r' function. */
+#undef HAVE_LRAND48_R
+
+/* Define to 1 if you have the <memory.h> header file. */
+#undef HAVE_MEMORY_H
+
+/* Define to 1 if you have the `mkdir' function. */
+#undef HAVE_MKDIR
+
+/* Define to 1 if you have the `open64' function. */
+#undef HAVE_OPEN64
+
+/* Define to 1 if you have the <pthread.h> header file. */
+#undef HAVE_PTHREAD_H
+
+/* Define to 1 if you have the `srand48_r' function. */
+#undef HAVE_SRAND48_R
+
+/* Define to 1 if you have the `stat64' function. */
+#undef HAVE_STAT64
+
+/* Define to 1 if you have the <stdint.h> header file. */
+#undef HAVE_STDINT_H
+
+/* Define to 1 if you have the <stdlib.h> header file. */
+#undef HAVE_STDLIB_H
+
+/* Define to 1 if you have the `strerror' function. */
+#undef HAVE_STRERROR
+
+/* Define to 1 if you have the <strings.h> header file. */
+#undef HAVE_STRINGS_H
+
+/* Define to 1 if you have the <string.h> header file. */
+#undef HAVE_STRING_H
+
+/* Define to 1 if you have the `system' function. */
+#undef HAVE_SYSTEM
+
+/* Define to 1 if you have the <sys/limits.h> header file. */
+#undef HAVE_SYS_LIMITS_H
+
+/* Define to 1 if you have the <sys/stat.h> header file. */
+#undef HAVE_SYS_STAT_H
+
+/* Define to 1 if you have the <sys/time.h> header file. */
+#undef HAVE_SYS_TIME_H
+
+/* Define to 1 if you have the <sys/types.h> header file. */
+#undef HAVE_SYS_TYPES_H
+
+/* Define to 1 if you have the <sys/vfs.h> header file. */
+#undef HAVE_SYS_VFS_H
+
+/* Define to 1 if you have <sys/wait.h> that is POSIX.1 compatible. */
+#undef HAVE_SYS_WAIT_H
+
+/* Define to 1 if you have the <unistd.h> header file. */
+#undef HAVE_UNISTD_H
+
+/* Name of package */
+#undef PACKAGE
+
+/* Define to the address where bug reports for this package should be sent. */
+#undef PACKAGE_BUGREPORT
+
+/* Define to the full name of this package. */
+#undef PACKAGE_NAME
+
+/* Define to the full name and version of this package. */
+#undef PACKAGE_STRING
+
+/* Define to the one symbol short name of this package. */
+#undef PACKAGE_TARNAME
+
+/* Define to the version of this package. */
+#undef PACKAGE_VERSION
+
+/* Define to 1 if the C compiler supports function prototypes. */
+#undef PROTOTYPES
+
+/* Define to 1 if the `setvbuf' function takes the buffering type as its
+   second argument and the buffer pointer as the third, as on System V before
+   release 3. */
+#undef SETVBUF_REVERSED
+
+/* Define to 1 if you have the ANSI C header files. */
+#undef STDC_HEADERS
+
+/* Define to 1 if you can safely include both <sys/time.h> and <time.h>. */
+#undef TIME_WITH_SYS_TIME
+
+/* Version number of package */
+#undef VERSION
+
+/* Define to 1 if on AIX 3.
+   System headers sometimes define this.
+   We just want to avoid a redefinition error message.  */
+#ifndef _ALL_SOURCE
+# undef _ALL_SOURCE
+#endif
+
+/* Define like PROTOTYPES; this can be used by system headers. */
+#undef __PROTOTYPES
+
+/* Define to empty if `const' does not conform to ANSI C. */
+#undef const
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/config.sub b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/config.sub
new file mode 100644
index 0000000..d2e3557
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/config.sub
@@ -0,0 +1,1545 @@
+#! /bin/sh
+# Configuration validation subroutine script.
+#   Copyright (C) 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999,
+#   2000, 2001, 2002, 2003 Free Software Foundation, Inc.
+
+timestamp='2004-02-16'
+
+# This file is (in principle) common to ALL GNU software.
+# The presence of a machine in this file suggests that SOME GNU software
+# can handle that machine.  It does not imply ALL GNU software can.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 59 Temple Place - Suite 330,
+# Boston, MA 02111-1307, USA.
+
+# As a special exception to the GNU General Public License, if you
+# distribute this file as part of a program that contains a
+# configuration script generated by Autoconf, you may include it under
+# the same distribution terms that you use for the rest of that program.
+
+# Please send patches to <config-patches@gnu.org>.  Submit a context
+# diff and a properly formatted ChangeLog entry.
+#
+# Configuration subroutine to validate and canonicalize a configuration type.
+# Supply the specified configuration type as an argument.
+# If it is invalid, we print an error message on stderr and exit with code 1.
+# Otherwise, we print the canonical config type on stdout and succeed.
+
+# This file is supposed to be the same for all GNU packages
+# and recognize all the CPU types, system types and aliases
+# that are meaningful with *any* GNU software.
+# Each package is responsible for reporting which valid configurations
+# it does not support.  The user should be able to distinguish
+# a failure to support a valid configuration from a meaningless
+# configuration.
+
+# The goal of this file is to map all the various variations of a given
+# machine specification into a single specification in the form:
+#	CPU_TYPE-MANUFACTURER-OPERATING_SYSTEM
+# or in some cases, the newer four-part form:
+#	CPU_TYPE-MANUFACTURER-KERNEL-OPERATING_SYSTEM
+# It is wrong to echo any other type of specification.
+
+me=`echo "$0" | sed -e 's,.*/,,'`
+
+usage="\
+Usage: $0 [OPTION] CPU-MFR-OPSYS
+       $0 [OPTION] ALIAS
+
+Canonicalize a configuration name.
+
+Operation modes:
+  -h, --help         print this help, then exit
+  -t, --time-stamp   print date of last modification, then exit
+  -v, --version      print version number, then exit
+
+Report bugs and patches to <config-patches@gnu.org>."
+
+version="\
+GNU config.sub ($timestamp)
+
+Copyright (C) 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001
+Free Software Foundation, Inc.
+
+This is free software; see the source for copying conditions.  There is NO
+warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE."
+
+help="
+Try \`$me --help' for more information."
+
+# Parse command line
+while test $# -gt 0 ; do
+  case $1 in
+    --time-stamp | --time* | -t )
+       echo "$timestamp" ; exit 0 ;;
+    --version | -v )
+       echo "$version" ; exit 0 ;;
+    --help | --h* | -h )
+       echo "$usage"; exit 0 ;;
+    -- )     # Stop option processing
+       shift; break ;;
+    - )	# Use stdin as input.
+       break ;;
+    -* )
+       echo "$me: invalid option $1$help"
+       exit 1 ;;
+
+    *local*)
+       # First pass through any local machine types.
+       echo $1
+       exit 0;;
+
+    * )
+       break ;;
+  esac
+done
+
+case $# in
+ 0) echo "$me: missing argument$help" >&2
+    exit 1;;
+ 1) ;;
+ *) echo "$me: too many arguments$help" >&2
+    exit 1;;
+esac
+
+# Separate what the user gave into CPU-COMPANY and OS or KERNEL-OS (if any).
+# Here we must recognize all the valid KERNEL-OS combinations.
+maybe_os=`echo $1 | sed 's/^\(.*\)-\([^-]*-[^-]*\)$/\2/'`
+case $maybe_os in
+  nto-qnx* | linux-gnu* | linux-dietlibc | linux-uclibc* | uclinux-uclibc* | uclinux-gnu* | \
+  kfreebsd*-gnu* | knetbsd*-gnu* | netbsd*-gnu* | storm-chaos* | os2-emx* | rtmk-nova*)
+    os=-$maybe_os
+    basic_machine=`echo $1 | sed 's/^\(.*\)-\([^-]*-[^-]*\)$/\1/'`
+    ;;
+  *)
+    basic_machine=`echo $1 | sed 's/-[^-]*$//'`
+    if [ $basic_machine != $1 ]
+    then os=`echo $1 | sed 's/.*-/-/'`
+    else os=; fi
+    ;;
+esac
+
+### Let's recognize common machines as not being operating systems so
+### that things like config.sub decstation-3100 work.  We also
+### recognize some manufacturers as not being operating systems, so we
+### can provide default operating systems below.
+case $os in
+	-sun*os*)
+		# Prevent following clause from handling this invalid input.
+		;;
+	-dec* | -mips* | -sequent* | -encore* | -pc532* | -sgi* | -sony* | \
+	-att* | -7300* | -3300* | -delta* | -motorola* | -sun[234]* | \
+	-unicom* | -ibm* | -next | -hp | -isi* | -apollo | -altos* | \
+	-convergent* | -ncr* | -news | -32* | -3600* | -3100* | -hitachi* |\
+	-c[123]* | -convex* | -sun | -crds | -omron* | -dg | -ultra | -tti* | \
+	-harris | -dolphin | -highlevel | -gould | -cbm | -ns | -masscomp | \
+	-apple | -axis)
+		os=
+		basic_machine=$1
+		;;
+	-sim | -cisco | -oki | -wec | -winbond)
+		os=
+		basic_machine=$1
+		;;
+	-scout)
+		;;
+	-wrs)
+		os=-vxworks
+		basic_machine=$1
+		;;
+	-chorusos*)
+		os=-chorusos
+		basic_machine=$1
+		;;
+ 	-chorusrdb)
+ 		os=-chorusrdb
+		basic_machine=$1
+ 		;;
+	-hiux*)
+		os=-hiuxwe2
+		;;
+	-sco5)
+		os=-sco3.2v5
+		basic_machine=`echo $1 | sed -e 's/86-.*/86-pc/'`
+		;;
+	-sco4)
+		os=-sco3.2v4
+		basic_machine=`echo $1 | sed -e 's/86-.*/86-pc/'`
+		;;
+	-sco3.2.[4-9]*)
+		os=`echo $os | sed -e 's/sco3.2./sco3.2v/'`
+		basic_machine=`echo $1 | sed -e 's/86-.*/86-pc/'`
+		;;
+	-sco3.2v[4-9]*)
+		# Don't forget version if it is 3.2v4 or newer.
+		basic_machine=`echo $1 | sed -e 's/86-.*/86-pc/'`
+		;;
+	-sco*)
+		os=-sco3.2v2
+		basic_machine=`echo $1 | sed -e 's/86-.*/86-pc/'`
+		;;
+	-udk*)
+		basic_machine=`echo $1 | sed -e 's/86-.*/86-pc/'`
+		;;
+	-isc)
+		os=-isc2.2
+		basic_machine=`echo $1 | sed -e 's/86-.*/86-pc/'`
+		;;
+	-clix*)
+		basic_machine=clipper-intergraph
+		;;
+	-isc*)
+		basic_machine=`echo $1 | sed -e 's/86-.*/86-pc/'`
+		;;
+	-lynx*)
+		os=-lynxos
+		;;
+	-ptx*)
+		basic_machine=`echo $1 | sed -e 's/86-.*/86-sequent/'`
+		;;
+	-windowsnt*)
+		os=`echo $os | sed -e 's/windowsnt/winnt/'`
+		;;
+	-psos*)
+		os=-psos
+		;;
+	-mint | -mint[0-9]*)
+		basic_machine=m68k-atari
+		os=-mint
+		;;
+esac
+
+# Decode aliases for certain CPU-COMPANY combinations.
+case $basic_machine in
+	# Recognize the basic CPU types without company name.
+	# Some are omitted here because they have special meanings below.
+	1750a | 580 \
+	| a29k \
+	| alpha | alphaev[4-8] | alphaev56 | alphaev6[78] | alphapca5[67] \
+	| alpha64 | alpha64ev[4-8] | alpha64ev56 | alpha64ev6[78] | alpha64pca5[67] \
+	| am33_2.0 \
+	| arc | arm | arm[bl]e | arme[lb] | armv[2345] | armv[345][lb] | avr \
+	| c4x | clipper \
+	| d10v | d30v | dlx | dsp16xx \
+	| fr30 | frv \
+	| h8300 | h8500 | hppa | hppa1.[01] | hppa2.0 | hppa2.0[nw] | hppa64 \
+	| i370 | i860 | i960 | ia64 \
+	| ip2k | iq2000 \
+	| m32r | m68000 | m68k | m88k | mcore \
+	| mips | mipsbe | mipseb | mipsel | mipsle \
+	| mips16 \
+	| mips64 | mips64el \
+	| mips64vr | mips64vrel \
+	| mips64orion | mips64orionel \
+	| mips64vr4100 | mips64vr4100el \
+	| mips64vr4300 | mips64vr4300el \
+	| mips64vr5000 | mips64vr5000el \
+	| mipsisa32 | mipsisa32el \
+	| mipsisa32r2 | mipsisa32r2el \
+	| mipsisa64 | mipsisa64el \
+	| mipsisa64r2 | mipsisa64r2el \
+	| mipsisa64sb1 | mipsisa64sb1el \
+	| mipsisa64sr71k | mipsisa64sr71kel \
+	| mipstx39 | mipstx39el \
+	| mn10200 | mn10300 \
+	| msp430 \
+	| ns16k | ns32k \
+	| openrisc | or32 \
+	| pdp10 | pdp11 | pj | pjl \
+	| powerpc | powerpc64 | powerpc64le | powerpcle | ppcbe \
+	| pyramid \
+	| sh | sh[1234] | sh[23]e | sh[34]eb | shbe | shle | sh[1234]le | sh3ele \
+	| sh64 | sh64le \
+	| sparc | sparc64 | sparc86x | sparclet | sparclite | sparcv9 | sparcv9b \
+	| strongarm \
+	| tahoe | thumb | tic4x | tic80 | tron \
+	| v850 | v850e \
+	| we32k \
+	| x86 | xscale | xstormy16 | xtensa \
+	| z8k)
+		basic_machine=$basic_machine-unknown
+		;;
+	m6811 | m68hc11 | m6812 | m68hc12)
+		# Motorola 68HC11/12.
+		basic_machine=$basic_machine-unknown
+		os=-none
+		;;
+	m88110 | m680[12346]0 | m683?2 | m68360 | m5200 | v70 | w65 | z8k)
+		;;
+
+	# We use `pc' rather than `unknown'
+	# because (1) that's what they normally are, and
+	# (2) the word "unknown" tends to confuse beginning users.
+	i*86 | x86_64)
+	  basic_machine=$basic_machine-pc
+	  ;;
+	# Object if more than one company name word.
+	*-*-*)
+		echo Invalid configuration \`$1\': machine \`$basic_machine\' not recognized 1>&2
+		exit 1
+		;;
+	# Recognize the basic CPU types with company name.
+	580-* \
+	| a29k-* \
+	| alpha-* | alphaev[4-8]-* | alphaev56-* | alphaev6[78]-* \
+	| alpha64-* | alpha64ev[4-8]-* | alpha64ev56-* | alpha64ev6[78]-* \
+	| alphapca5[67]-* | alpha64pca5[67]-* | arc-* \
+	| arm-*  | armbe-* | armle-* | armeb-* | armv*-* \
+	| avr-* \
+	| bs2000-* \
+	| c[123]* | c30-* | [cjt]90-* | c4x-* | c54x-* | c55x-* | c6x-* \
+	| clipper-* | cydra-* \
+	| d10v-* | d30v-* | dlx-* \
+	| elxsi-* \
+	| f30[01]-* | f700-* | fr30-* | frv-* | fx80-* \
+	| h8300-* | h8500-* \
+	| hppa-* | hppa1.[01]-* | hppa2.0-* | hppa2.0[nw]-* | hppa64-* \
+	| i*86-* | i860-* | i960-* | ia64-* \
+	| ip2k-* | iq2000-* \
+	| m32r-* \
+	| m68000-* | m680[012346]0-* | m68360-* | m683?2-* | m68k-* \
+	| m88110-* | m88k-* | mcore-* \
+	| mips-* | mipsbe-* | mipseb-* | mipsel-* | mipsle-* \
+	| mips16-* \
+	| mips64-* | mips64el-* \
+	| mips64vr-* | mips64vrel-* \
+	| mips64orion-* | mips64orionel-* \
+	| mips64vr4100-* | mips64vr4100el-* \
+	| mips64vr4300-* | mips64vr4300el-* \
+	| mips64vr5000-* | mips64vr5000el-* \
+	| mipsisa32-* | mipsisa32el-* \
+	| mipsisa32r2-* | mipsisa32r2el-* \
+	| mipsisa64-* | mipsisa64el-* \
+	| mipsisa64r2-* | mipsisa64r2el-* \
+	| mipsisa64sb1-* | mipsisa64sb1el-* \
+	| mipsisa64sr71k-* | mipsisa64sr71kel-* \
+	| mipstx39-* | mipstx39el-* \
+	| msp430-* \
+	| none-* | np1-* | nv1-* | ns16k-* | ns32k-* \
+	| orion-* \
+	| pdp10-* | pdp11-* | pj-* | pjl-* | pn-* | power-* \
+	| powerpc-* | powerpc64-* | powerpc64le-* | powerpcle-* | ppcbe-* \
+	| pyramid-* \
+	| romp-* | rs6000-* \
+	| sh-* | sh[1234]-* | sh[23]e-* | sh[34]eb-* | shbe-* \
+	| shle-* | sh[1234]le-* | sh3ele-* | sh64-* | sh64le-* \
+	| sparc-* | sparc64-* | sparc86x-* | sparclet-* | sparclite-* \
+	| sparcv9-* | sparcv9b-* | strongarm-* | sv1-* | sx?-* \
+	| tahoe-* | thumb-* \
+	| tic30-* | tic4x-* | tic54x-* | tic55x-* | tic6x-* | tic80-* \
+	| tron-* \
+	| v850-* | v850e-* | vax-* \
+	| we32k-* \
+	| x86-* | x86_64-* | xps100-* | xscale-* | xstormy16-* \
+	| xtensa-* \
+	| ymp-* \
+	| z8k-*)
+		;;
+	# Recognize the various machine names and aliases which stand
+	# for a CPU type and a company and sometimes even an OS.
+	386bsd)
+		basic_machine=i386-unknown
+		os=-bsd
+		;;
+	3b1 | 7300 | 7300-att | att-7300 | pc7300 | safari | unixpc)
+		basic_machine=m68000-att
+		;;
+	3b*)
+		basic_machine=we32k-att
+		;;
+	a29khif)
+		basic_machine=a29k-amd
+		os=-udi
+		;;
+    	abacus)
+		basic_machine=abacus-unknown
+		;;
+	adobe68k)
+		basic_machine=m68010-adobe
+		os=-scout
+		;;
+	alliant | fx80)
+		basic_machine=fx80-alliant
+		;;
+	altos | altos3068)
+		basic_machine=m68k-altos
+		;;
+	am29k)
+		basic_machine=a29k-none
+		os=-bsd
+		;;
+	amd64)
+		basic_machine=x86_64-pc
+		;;
+	amd64-*)
+		basic_machine=x86_64-`echo $basic_machine | sed 's/^[^-]*-//'`
+		;;
+	amdahl)
+		basic_machine=580-amdahl
+		os=-sysv
+		;;
+	amiga | amiga-*)
+		basic_machine=m68k-unknown
+		;;
+	amigaos | amigados)
+		basic_machine=m68k-unknown
+		os=-amigaos
+		;;
+	amigaunix | amix)
+		basic_machine=m68k-unknown
+		os=-sysv4
+		;;
+	apollo68)
+		basic_machine=m68k-apollo
+		os=-sysv
+		;;
+	apollo68bsd)
+		basic_machine=m68k-apollo
+		os=-bsd
+		;;
+	aux)
+		basic_machine=m68k-apple
+		os=-aux
+		;;
+	balance)
+		basic_machine=ns32k-sequent
+		os=-dynix
+		;;
+	c90)
+		basic_machine=c90-cray
+		os=-unicos
+		;;
+	convex-c1)
+		basic_machine=c1-convex
+		os=-bsd
+		;;
+	convex-c2)
+		basic_machine=c2-convex
+		os=-bsd
+		;;
+	convex-c32)
+		basic_machine=c32-convex
+		os=-bsd
+		;;
+	convex-c34)
+		basic_machine=c34-convex
+		os=-bsd
+		;;
+	convex-c38)
+		basic_machine=c38-convex
+		os=-bsd
+		;;
+	cray | j90)
+		basic_machine=j90-cray
+		os=-unicos
+		;;
+	cr16c)
+		basic_machine=cr16c-unknown
+		os=-elf
+		;;
+	crds | unos)
+		basic_machine=m68k-crds
+		;;
+	cris | cris-* | etrax*)
+		basic_machine=cris-axis
+		;;
+	da30 | da30-*)
+		basic_machine=m68k-da30
+		;;
+	decstation | decstation-3100 | pmax | pmax-* | pmin | dec3100 | decstatn)
+		basic_machine=mips-dec
+		;;
+	decsystem10* | dec10*)
+		basic_machine=pdp10-dec
+		os=-tops10
+		;;
+	decsystem20* | dec20*)
+		basic_machine=pdp10-dec
+		os=-tops20
+		;;
+	delta | 3300 | motorola-3300 | motorola-delta \
+	      | 3300-motorola | delta-motorola)
+		basic_machine=m68k-motorola
+		;;
+	delta88)
+		basic_machine=m88k-motorola
+		os=-sysv3
+		;;
+	dpx20 | dpx20-*)
+		basic_machine=rs6000-bull
+		os=-bosx
+		;;
+	dpx2* | dpx2*-bull)
+		basic_machine=m68k-bull
+		os=-sysv3
+		;;
+	ebmon29k)
+		basic_machine=a29k-amd
+		os=-ebmon
+		;;
+	elxsi)
+		basic_machine=elxsi-elxsi
+		os=-bsd
+		;;
+	encore | umax | mmax)
+		basic_machine=ns32k-encore
+		;;
+	es1800 | OSE68k | ose68k | ose | OSE)
+		basic_machine=m68k-ericsson
+		os=-ose
+		;;
+	fx2800)
+		basic_machine=i860-alliant
+		;;
+	genix)
+		basic_machine=ns32k-ns
+		;;
+	gmicro)
+		basic_machine=tron-gmicro
+		os=-sysv
+		;;
+	go32)
+		basic_machine=i386-pc
+		os=-go32
+		;;
+	h3050r* | hiux*)
+		basic_machine=hppa1.1-hitachi
+		os=-hiuxwe2
+		;;
+	h8300hms)
+		basic_machine=h8300-hitachi
+		os=-hms
+		;;
+	h8300xray)
+		basic_machine=h8300-hitachi
+		os=-xray
+		;;
+	h8500hms)
+		basic_machine=h8500-hitachi
+		os=-hms
+		;;
+	harris)
+		basic_machine=m88k-harris
+		os=-sysv3
+		;;
+	hp300-*)
+		basic_machine=m68k-hp
+		;;
+	hp300bsd)
+		basic_machine=m68k-hp
+		os=-bsd
+		;;
+	hp300hpux)
+		basic_machine=m68k-hp
+		os=-hpux
+		;;
+	hp3k9[0-9][0-9] | hp9[0-9][0-9])
+		basic_machine=hppa1.0-hp
+		;;
+	hp9k2[0-9][0-9] | hp9k31[0-9])
+		basic_machine=m68000-hp
+		;;
+	hp9k3[2-9][0-9])
+		basic_machine=m68k-hp
+		;;
+	hp9k6[0-9][0-9] | hp6[0-9][0-9])
+		basic_machine=hppa1.0-hp
+		;;
+	hp9k7[0-79][0-9] | hp7[0-79][0-9])
+		basic_machine=hppa1.1-hp
+		;;
+	hp9k78[0-9] | hp78[0-9])
+		# FIXME: really hppa2.0-hp
+		basic_machine=hppa1.1-hp
+		;;
+	hp9k8[67]1 | hp8[67]1 | hp9k80[24] | hp80[24] | hp9k8[78]9 | hp8[78]9 | hp9k893 | hp893)
+		# FIXME: really hppa2.0-hp
+		basic_machine=hppa1.1-hp
+		;;
+	hp9k8[0-9][13679] | hp8[0-9][13679])
+		basic_machine=hppa1.1-hp
+		;;
+	hp9k8[0-9][0-9] | hp8[0-9][0-9])
+		basic_machine=hppa1.0-hp
+		;;
+	hppa-next)
+		os=-nextstep3
+		;;
+	hppaosf)
+		basic_machine=hppa1.1-hp
+		os=-osf
+		;;
+	hppro)
+		basic_machine=hppa1.1-hp
+		os=-proelf
+		;;
+	i370-ibm* | ibm*)
+		basic_machine=i370-ibm
+		;;
+# I'm not sure what "Sysv32" means.  Should this be sysv3.2?
+	i*86v32)
+		basic_machine=`echo $1 | sed -e 's/86.*/86-pc/'`
+		os=-sysv32
+		;;
+	i*86v4*)
+		basic_machine=`echo $1 | sed -e 's/86.*/86-pc/'`
+		os=-sysv4
+		;;
+	i*86v)
+		basic_machine=`echo $1 | sed -e 's/86.*/86-pc/'`
+		os=-sysv
+		;;
+	i*86sol2)
+		basic_machine=`echo $1 | sed -e 's/86.*/86-pc/'`
+		os=-solaris2
+		;;
+	i386mach)
+		basic_machine=i386-mach
+		os=-mach
+		;;
+	i386-vsta | vsta)
+		basic_machine=i386-unknown
+		os=-vsta
+		;;
+	iris | iris4d)
+		basic_machine=mips-sgi
+		case $os in
+		    -irix*)
+			;;
+		    *)
+			os=-irix4
+			;;
+		esac
+		;;
+	isi68 | isi)
+		basic_machine=m68k-isi
+		os=-sysv
+		;;
+	m88k-omron*)
+		basic_machine=m88k-omron
+		;;
+	magnum | m3230)
+		basic_machine=mips-mips
+		os=-sysv
+		;;
+	merlin)
+		basic_machine=ns32k-utek
+		os=-sysv
+		;;
+	mingw32)
+		basic_machine=i386-pc
+		os=-mingw32
+		;;
+	miniframe)
+		basic_machine=m68000-convergent
+		;;
+	*mint | -mint[0-9]* | *MiNT | *MiNT[0-9]*)
+		basic_machine=m68k-atari
+		os=-mint
+		;;
+	mips3*-*)
+		basic_machine=`echo $basic_machine | sed -e 's/mips3/mips64/'`
+		;;
+	mips3*)
+		basic_machine=`echo $basic_machine | sed -e 's/mips3/mips64/'`-unknown
+		;;
+	mmix*)
+		basic_machine=mmix-knuth
+		os=-mmixware
+		;;
+	monitor)
+		basic_machine=m68k-rom68k
+		os=-coff
+		;;
+	morphos)
+		basic_machine=powerpc-unknown
+		os=-morphos
+		;;
+	msdos)
+		basic_machine=i386-pc
+		os=-msdos
+		;;
+	mvs)
+		basic_machine=i370-ibm
+		os=-mvs
+		;;
+	ncr3000)
+		basic_machine=i486-ncr
+		os=-sysv4
+		;;
+	netbsd386)
+		basic_machine=i386-unknown
+		os=-netbsd
+		;;
+	netwinder)
+		basic_machine=armv4l-rebel
+		os=-linux
+		;;
+	news | news700 | news800 | news900)
+		basic_machine=m68k-sony
+		os=-newsos
+		;;
+	news1000)
+		basic_machine=m68030-sony
+		os=-newsos
+		;;
+	news-3600 | risc-news)
+		basic_machine=mips-sony
+		os=-newsos
+		;;
+	necv70)
+		basic_machine=v70-nec
+		os=-sysv
+		;;
+	next | m*-next )
+		basic_machine=m68k-next
+		case $os in
+		    -nextstep* )
+			;;
+		    -ns2*)
+		      os=-nextstep2
+			;;
+		    *)
+		      os=-nextstep3
+			;;
+		esac
+		;;
+	nh3000)
+		basic_machine=m68k-harris
+		os=-cxux
+		;;
+	nh[45]000)
+		basic_machine=m88k-harris
+		os=-cxux
+		;;
+	nindy960)
+		basic_machine=i960-intel
+		os=-nindy
+		;;
+	mon960)
+		basic_machine=i960-intel
+		os=-mon960
+		;;
+	nonstopux)
+		basic_machine=mips-compaq
+		os=-nonstopux
+		;;
+	np1)
+		basic_machine=np1-gould
+		;;
+	nv1)
+		basic_machine=nv1-cray
+		os=-unicosmp
+		;;
+	nsr-tandem)
+		basic_machine=nsr-tandem
+		;;
+	op50n-* | op60c-*)
+		basic_machine=hppa1.1-oki
+		os=-proelf
+		;;
+	or32 | or32-*)
+		basic_machine=or32-unknown
+		os=-coff
+		;;
+	os400)
+		basic_machine=powerpc-ibm
+		os=-os400
+		;;
+	OSE68000 | ose68000)
+		basic_machine=m68000-ericsson
+		os=-ose
+		;;
+	os68k)
+		basic_machine=m68k-none
+		os=-os68k
+		;;
+	pa-hitachi)
+		basic_machine=hppa1.1-hitachi
+		os=-hiuxwe2
+		;;
+	paragon)
+		basic_machine=i860-intel
+		os=-osf
+		;;
+	pbd)
+		basic_machine=sparc-tti
+		;;
+	pbb)
+		basic_machine=m68k-tti
+		;;
+	pc532 | pc532-*)
+		basic_machine=ns32k-pc532
+		;;
+	pentium | p5 | k5 | k6 | nexgen | viac3)
+		basic_machine=i586-pc
+		;;
+	pentiumpro | p6 | 6x86 | athlon | athlon_*)
+		basic_machine=i686-pc
+		;;
+	pentiumii | pentium2 | pentiumiii | pentium3)
+		basic_machine=i686-pc
+		;;
+	pentium4)
+		basic_machine=i786-pc
+		;;
+	pentium-* | p5-* | k5-* | k6-* | nexgen-* | viac3-*)
+		basic_machine=i586-`echo $basic_machine | sed 's/^[^-]*-//'`
+		;;
+	pentiumpro-* | p6-* | 6x86-* | athlon-*)
+		basic_machine=i686-`echo $basic_machine | sed 's/^[^-]*-//'`
+		;;
+	pentiumii-* | pentium2-* | pentiumiii-* | pentium3-*)
+		basic_machine=i686-`echo $basic_machine | sed 's/^[^-]*-//'`
+		;;
+	pentium4-*)
+		basic_machine=i786-`echo $basic_machine | sed 's/^[^-]*-//'`
+		;;
+	pn)
+		basic_machine=pn-gould
+		;;
+	power)	basic_machine=power-ibm
+		;;
+	ppc)	basic_machine=powerpc-unknown
+		;;
+	ppc-*)	basic_machine=powerpc-`echo $basic_machine | sed 's/^[^-]*-//'`
+		;;
+	ppcle | powerpclittle | ppc-le | powerpc-little)
+		basic_machine=powerpcle-unknown
+		;;
+	ppcle-* | powerpclittle-*)
+		basic_machine=powerpcle-`echo $basic_machine | sed 's/^[^-]*-//'`
+		;;
+	ppc64)	basic_machine=powerpc64-unknown
+		;;
+	ppc64-*) basic_machine=powerpc64-`echo $basic_machine | sed 's/^[^-]*-//'`
+		;;
+	ppc64le | powerpc64little | ppc64-le | powerpc64-little)
+		basic_machine=powerpc64le-unknown
+		;;
+	ppc64le-* | powerpc64little-*)
+		basic_machine=powerpc64le-`echo $basic_machine | sed 's/^[^-]*-//'`
+		;;
+	ps2)
+		basic_machine=i386-ibm
+		;;
+	pw32)
+		basic_machine=i586-unknown
+		os=-pw32
+		;;
+	rom68k)
+		basic_machine=m68k-rom68k
+		os=-coff
+		;;
+	rm[46]00)
+		basic_machine=mips-siemens
+		;;
+	rtpc | rtpc-*)
+		basic_machine=romp-ibm
+		;;
+	s390 | s390-*)
+		basic_machine=s390-ibm
+		;;
+	s390x | s390x-*)
+		basic_machine=s390x-ibm
+		;;
+	sa29200)
+		basic_machine=a29k-amd
+		os=-udi
+		;;
+	sb1)
+		basic_machine=mipsisa64sb1-unknown
+		;;
+	sb1el)
+		basic_machine=mipsisa64sb1el-unknown
+		;;
+	sei)
+		basic_machine=mips-sei
+		os=-seiux
+		;;
+	sequent)
+		basic_machine=i386-sequent
+		;;
+	sh)
+		basic_machine=sh-hitachi
+		os=-hms
+		;;
+	sh64)
+		basic_machine=sh64-unknown
+		;;
+	sparclite-wrs | simso-wrs)
+		basic_machine=sparclite-wrs
+		os=-vxworks
+		;;
+	sps7)
+		basic_machine=m68k-bull
+		os=-sysv2
+		;;
+	spur)
+		basic_machine=spur-unknown
+		;;
+	st2000)
+		basic_machine=m68k-tandem
+		;;
+	stratus)
+		basic_machine=i860-stratus
+		os=-sysv4
+		;;
+	sun2)
+		basic_machine=m68000-sun
+		;;
+	sun2os3)
+		basic_machine=m68000-sun
+		os=-sunos3
+		;;
+	sun2os4)
+		basic_machine=m68000-sun
+		os=-sunos4
+		;;
+	sun3os3)
+		basic_machine=m68k-sun
+		os=-sunos3
+		;;
+	sun3os4)
+		basic_machine=m68k-sun
+		os=-sunos4
+		;;
+	sun4os3)
+		basic_machine=sparc-sun
+		os=-sunos3
+		;;
+	sun4os4)
+		basic_machine=sparc-sun
+		os=-sunos4
+		;;
+	sun4sol2)
+		basic_machine=sparc-sun
+		os=-solaris2
+		;;
+	sun3 | sun3-*)
+		basic_machine=m68k-sun
+		;;
+	sun4)
+		basic_machine=sparc-sun
+		;;
+	sun386 | sun386i | roadrunner)
+		basic_machine=i386-sun
+		;;
+	sv1)
+		basic_machine=sv1-cray
+		os=-unicos
+		;;
+	symmetry)
+		basic_machine=i386-sequent
+		os=-dynix
+		;;
+	t3e)
+		basic_machine=alphaev5-cray
+		os=-unicos
+		;;
+	t90)
+		basic_machine=t90-cray
+		os=-unicos
+		;;
+	tic54x | c54x*)
+		basic_machine=tic54x-unknown
+		os=-coff
+		;;
+	tic55x | c55x*)
+		basic_machine=tic55x-unknown
+		os=-coff
+		;;
+	tic6x | c6x*)
+		basic_machine=tic6x-unknown
+		os=-coff
+		;;
+	tx39)
+		basic_machine=mipstx39-unknown
+		;;
+	tx39el)
+		basic_machine=mipstx39el-unknown
+		;;
+	toad1)
+		basic_machine=pdp10-xkl
+		os=-tops20
+		;;
+	tower | tower-32)
+		basic_machine=m68k-ncr
+		;;
+	tpf)
+		basic_machine=s390x-ibm
+		os=-tpf
+		;;
+	udi29k)
+		basic_machine=a29k-amd
+		os=-udi
+		;;
+	ultra3)
+		basic_machine=a29k-nyu
+		os=-sym1
+		;;
+	v810 | necv810)
+		basic_machine=v810-nec
+		os=-none
+		;;
+	vaxv)
+		basic_machine=vax-dec
+		os=-sysv
+		;;
+	vms)
+		basic_machine=vax-dec
+		os=-vms
+		;;
+	vpp*|vx|vx-*)
+		basic_machine=f301-fujitsu
+		;;
+	vxworks960)
+		basic_machine=i960-wrs
+		os=-vxworks
+		;;
+	vxworks68)
+		basic_machine=m68k-wrs
+		os=-vxworks
+		;;
+	vxworks29k)
+		basic_machine=a29k-wrs
+		os=-vxworks
+		;;
+	w65*)
+		basic_machine=w65-wdc
+		os=-none
+		;;
+	w89k-*)
+		basic_machine=hppa1.1-winbond
+		os=-proelf
+		;;
+	xps | xps100)
+		basic_machine=xps100-honeywell
+		;;
+	ymp)
+		basic_machine=ymp-cray
+		os=-unicos
+		;;
+	z8k-*-coff)
+		basic_machine=z8k-unknown
+		os=-sim
+		;;
+	none)
+		basic_machine=none-none
+		os=-none
+		;;
+
+# Here we handle the default manufacturer of certain CPU types.  It is in
+# some cases the only manufacturer, in others, it is the most popular.
+	w89k)
+		basic_machine=hppa1.1-winbond
+		;;
+	op50n)
+		basic_machine=hppa1.1-oki
+		;;
+	op60c)
+		basic_machine=hppa1.1-oki
+		;;
+	romp)
+		basic_machine=romp-ibm
+		;;
+	rs6000)
+		basic_machine=rs6000-ibm
+		;;
+	vax)
+		basic_machine=vax-dec
+		;;
+	pdp10)
+		# there are many clones, so DEC is not a safe bet
+		basic_machine=pdp10-unknown
+		;;
+	pdp11)
+		basic_machine=pdp11-dec
+		;;
+	we32k)
+		basic_machine=we32k-att
+		;;
+	sh3 | sh4 | sh[34]eb | sh[1234]le | sh[23]ele)
+		basic_machine=sh-unknown
+		;;
+	sh64)
+		basic_machine=sh64-unknown
+		;;
+	sparc | sparcv9 | sparcv9b)
+		basic_machine=sparc-sun
+		;;
+	cydra)
+		basic_machine=cydra-cydrome
+		;;
+	orion)
+		basic_machine=orion-highlevel
+		;;
+	orion105)
+		basic_machine=clipper-highlevel
+		;;
+	mac | mpw | mac-mpw)
+		basic_machine=m68k-apple
+		;;
+	pmac | pmac-mpw)
+		basic_machine=powerpc-apple
+		;;
+	*-unknown)
+		# Make sure to match an already-canonicalized machine name.
+		;;
+	*)
+		echo Invalid configuration \`$1\': machine \`$basic_machine\' not recognized 1>&2
+		exit 1
+		;;
+esac
+
+# Here we canonicalize certain aliases for manufacturers.
+case $basic_machine in
+	*-digital*)
+		basic_machine=`echo $basic_machine | sed 's/digital.*/dec/'`
+		;;
+	*-commodore*)
+		basic_machine=`echo $basic_machine | sed 's/commodore.*/cbm/'`
+		;;
+	*)
+		;;
+esac
+
+# Decode manufacturer-specific aliases for certain operating systems.
+
+if [ x"$os" != x"" ]
+then
+case $os in
+        # First match some system type aliases
+        # that might get confused with valid system types.
+	# -solaris* is a basic system type, with this one exception.
+	-solaris1 | -solaris1.*)
+		os=`echo $os | sed -e 's|solaris1|sunos4|'`
+		;;
+	-solaris)
+		os=-solaris2
+		;;
+	-svr4*)
+		os=-sysv4
+		;;
+	-unixware*)
+		os=-sysv4.2uw
+		;;
+	-gnu/linux*)
+		os=`echo $os | sed -e 's|gnu/linux|linux-gnu|'`
+		;;
+	# First accept the basic system types.
+	# The portable systems comes first.
+	# Each alternative MUST END IN A *, to match a version number.
+	# -sysv* is not here because it comes later, after sysvr4.
+	-gnu* | -bsd* | -mach* | -minix* | -genix* | -ultrix* | -irix* \
+	      | -*vms* | -sco* | -esix* | -isc* | -aix* | -sunos | -sunos[34]*\
+	      | -hpux* | -unos* | -osf* | -luna* | -dgux* | -solaris* | -sym* \
+	      | -amigaos* | -amigados* | -msdos* | -newsos* | -unicos* | -aof* \
+	      | -aos* \
+	      | -nindy* | -vxsim* | -vxworks* | -ebmon* | -hms* | -mvs* \
+	      | -clix* | -riscos* | -uniplus* | -iris* | -rtu* | -xenix* \
+	      | -hiux* | -386bsd* | -knetbsd* | -mirbsd* | -netbsd* | -openbsd* \
+	      | -ekkobsd* | -kfreebsd* | -freebsd* | -riscix* | -lynxos* \
+	      | -bosx* | -nextstep* | -cxux* | -aout* | -elf* | -oabi* \
+	      | -ptx* | -coff* | -ecoff* | -winnt* | -domain* | -vsta* \
+	      | -udi* | -eabi* | -lites* | -ieee* | -go32* | -aux* \
+	      | -chorusos* | -chorusrdb* \
+	      | -cygwin* | -pe* | -psos* | -moss* | -proelf* | -rtems* \
+	      | -mingw32* | -linux-gnu* | -linux-uclibc* | -uxpv* | -beos* | -mpeix* | -udk* \
+	      | -interix* | -uwin* | -mks* | -rhapsody* | -darwin* | -opened* \
+	      | -openstep* | -oskit* | -conix* | -pw32* | -nonstopux* \
+	      | -storm-chaos* | -tops10* | -tenex* | -tops20* | -its* \
+	      | -os2* | -vos* | -palmos* | -uclinux* | -nucleus* \
+	      | -morphos* | -superux* | -rtmk* | -rtmk-nova* | -windiss* \
+	      | -powermax* | -dnix* | -nx6 | -nx7 | -sei* | -dragonfly*)
+	# Remember, each alternative MUST END IN *, to match a version number.
+		;;
+	-qnx*)
+		case $basic_machine in
+		    x86-* | i*86-*)
+			;;
+		    *)
+			os=-nto$os
+			;;
+		esac
+		;;
+	-nto-qnx*)
+		;;
+	-nto*)
+		os=`echo $os | sed -e 's|nto|nto-qnx|'`
+		;;
+	-sim | -es1800* | -hms* | -xray | -os68k* | -none* | -v88r* \
+	      | -windows* | -osx | -abug | -netware* | -os9* | -beos* \
+	      | -macos* | -mpw* | -magic* | -mmixware* | -mon960* | -lnews*)
+		;;
+	-mac*)
+		os=`echo $os | sed -e 's|mac|macos|'`
+		;;
+	-linux-dietlibc)
+		os=-linux-dietlibc
+		;;
+	-linux*)
+		os=`echo $os | sed -e 's|linux|linux-gnu|'`
+		;;
+	-sunos5*)
+		os=`echo $os | sed -e 's|sunos5|solaris2|'`
+		;;
+	-sunos6*)
+		os=`echo $os | sed -e 's|sunos6|solaris3|'`
+		;;
+	-opened*)
+		os=-openedition
+		;;
+        -os400*)
+		os=-os400
+		;;
+	-wince*)
+		os=-wince
+		;;
+	-osfrose*)
+		os=-osfrose
+		;;
+	-osf*)
+		os=-osf
+		;;
+	-utek*)
+		os=-bsd
+		;;
+	-dynix*)
+		os=-bsd
+		;;
+	-acis*)
+		os=-aos
+		;;
+	-atheos*)
+		os=-atheos
+		;;
+	-syllable*)
+		os=-syllable
+		;;
+	-386bsd)
+		os=-bsd
+		;;
+	-ctix* | -uts*)
+		os=-sysv
+		;;
+	-nova*)
+		os=-rtmk-nova
+		;;
+	-ns2 )
+		os=-nextstep2
+		;;
+	-nsk*)
+		os=-nsk
+		;;
+	# Preserve the version number of sinix5.
+	-sinix5.*)
+		os=`echo $os | sed -e 's|sinix|sysv|'`
+		;;
+	-sinix*)
+		os=-sysv4
+		;;
+        -tpf*)
+		os=-tpf
+		;;
+	-triton*)
+		os=-sysv3
+		;;
+	-oss*)
+		os=-sysv3
+		;;
+	-svr4)
+		os=-sysv4
+		;;
+	-svr3)
+		os=-sysv3
+		;;
+	-sysvr4)
+		os=-sysv4
+		;;
+	# This must come after -sysvr4.
+	-sysv*)
+		;;
+	-ose*)
+		os=-ose
+		;;
+	-es1800*)
+		os=-ose
+		;;
+	-xenix)
+		os=-xenix
+		;;
+	-*mint | -mint[0-9]* | -*MiNT | -MiNT[0-9]*)
+		os=-mint
+		;;
+	-aros*)
+		os=-aros
+		;;
+	-kaos*)
+		os=-kaos
+		;;
+	-none)
+		;;
+	*)
+		# Get rid of the `-' at the beginning of $os.
+		os=`echo $os | sed 's/[^-]*-//'`
+		echo Invalid configuration \`$1\': system \`$os\' not recognized 1>&2
+		exit 1
+		;;
+esac
+else
+
+# Here we handle the default operating systems that come with various machines.
+# The value should be what the vendor currently ships out the door with their
+# machine or put another way, the most popular os provided with the machine.
+
+# Note that if you're going to try to match "-MANUFACTURER" here (say,
+# "-sun"), then you have to tell the case statement up towards the top
+# that MANUFACTURER isn't an operating system.  Otherwise, code above
+# will signal an error saying that MANUFACTURER isn't an operating
+# system, and we'll never get to this point.
+
+case $basic_machine in
+	*-acorn)
+		os=-riscix1.2
+		;;
+	arm*-rebel)
+		os=-linux
+		;;
+	arm*-semi)
+		os=-aout
+		;;
+    c4x-* | tic4x-*)
+        os=-coff
+        ;;
+	# This must come before the *-dec entry.
+	pdp10-*)
+		os=-tops20
+		;;
+	pdp11-*)
+		os=-none
+		;;
+	*-dec | vax-*)
+		os=-ultrix4.2
+		;;
+	m68*-apollo)
+		os=-domain
+		;;
+	i386-sun)
+		os=-sunos4.0.2
+		;;
+	m68000-sun)
+		os=-sunos3
+		# This also exists in the configure program, but was not the
+		# default.
+		# os=-sunos4
+		;;
+	m68*-cisco)
+		os=-aout
+		;;
+	mips*-cisco)
+		os=-elf
+		;;
+	mips*-*)
+		os=-elf
+		;;
+	or32-*)
+		os=-coff
+		;;
+	*-tti)	# must be before sparc entry or we get the wrong os.
+		os=-sysv3
+		;;
+	sparc-* | *-sun)
+		os=-sunos4.1.1
+		;;
+	*-be)
+		os=-beos
+		;;
+	*-ibm)
+		os=-aix
+		;;
+	*-wec)
+		os=-proelf
+		;;
+	*-winbond)
+		os=-proelf
+		;;
+	*-oki)
+		os=-proelf
+		;;
+	*-hp)
+		os=-hpux
+		;;
+	*-hitachi)
+		os=-hiux
+		;;
+	i860-* | *-att | *-ncr | *-altos | *-motorola | *-convergent)
+		os=-sysv
+		;;
+	*-cbm)
+		os=-amigaos
+		;;
+	*-dg)
+		os=-dgux
+		;;
+	*-dolphin)
+		os=-sysv3
+		;;
+	m68k-ccur)
+		os=-rtu
+		;;
+	m88k-omron*)
+		os=-luna
+		;;
+	*-next )
+		os=-nextstep
+		;;
+	*-sequent)
+		os=-ptx
+		;;
+	*-crds)
+		os=-unos
+		;;
+	*-ns)
+		os=-genix
+		;;
+	i370-*)
+		os=-mvs
+		;;
+	*-next)
+		os=-nextstep3
+		;;
+	*-gould)
+		os=-sysv
+		;;
+	*-highlevel)
+		os=-bsd
+		;;
+	*-encore)
+		os=-bsd
+		;;
+	*-sgi)
+		os=-irix
+		;;
+	*-siemens)
+		os=-sysv4
+		;;
+	*-masscomp)
+		os=-rtu
+		;;
+	f30[01]-fujitsu | f700-fujitsu)
+		os=-uxpv
+		;;
+	*-rom68k)
+		os=-coff
+		;;
+	*-*bug)
+		os=-coff
+		;;
+	*-apple)
+		os=-macos
+		;;
+	*-atari*)
+		os=-mint
+		;;
+	*)
+		os=-none
+		;;
+esac
+fi
+
+# Here we handle the case where we know the os, and the CPU type, but not the
+# manufacturer.  We pick the logical manufacturer.
+vendor=unknown
+case $basic_machine in
+	*-unknown)
+		case $os in
+			-riscix*)
+				vendor=acorn
+				;;
+			-sunos*)
+				vendor=sun
+				;;
+			-aix*)
+				vendor=ibm
+				;;
+			-beos*)
+				vendor=be
+				;;
+			-hpux*)
+				vendor=hp
+				;;
+			-mpeix*)
+				vendor=hp
+				;;
+			-hiux*)
+				vendor=hitachi
+				;;
+			-unos*)
+				vendor=crds
+				;;
+			-dgux*)
+				vendor=dg
+				;;
+			-luna*)
+				vendor=omron
+				;;
+			-genix*)
+				vendor=ns
+				;;
+			-mvs* | -opened*)
+				vendor=ibm
+				;;
+			-os400*)
+				vendor=ibm
+				;;
+			-ptx*)
+				vendor=sequent
+				;;
+			-tpf*)
+				vendor=ibm
+				;;
+			-vxsim* | -vxworks* | -windiss*)
+				vendor=wrs
+				;;
+			-aux*)
+				vendor=apple
+				;;
+			-hms*)
+				vendor=hitachi
+				;;
+			-mpw* | -macos*)
+				vendor=apple
+				;;
+			-*mint | -mint[0-9]* | -*MiNT | -MiNT[0-9]*)
+				vendor=atari
+				;;
+			-vos*)
+				vendor=stratus
+				;;
+		esac
+		basic_machine=`echo $basic_machine | sed "s/unknown/$vendor/"`
+		;;
+esac
+
+echo $basic_machine$os
+exit 0
+
+# Local variables:
+# eval: (add-hook 'write-file-hooks 'time-stamp)
+# time-stamp-start: "timestamp='"
+# time-stamp-format: "%:y-%02m-%02d"
+# time-stamp-end: "'"
+# End:
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/configure b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/configure
new file mode 100644
index 0000000..12d5202
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/configure
@@ -0,0 +1,7000 @@
+#! /bin/sh
+# Guess values for system-dependent variables and create Makefiles.
+# Generated by GNU Autoconf 2.61.
+#
+# Copyright (C) 1992, 1993, 1994, 1995, 1996, 1998, 1999, 2000, 2001,
+# 2002, 2003, 2004, 2005, 2006 Free Software Foundation, Inc.
+# This configure script is free software; the Free Software Foundation
+# gives unlimited permission to copy, distribute and modify it.
+## --------------------- ##
+## M4sh Initialization.  ##
+## --------------------- ##
+
+# Be more Bourne compatible
+DUALCASE=1; export DUALCASE # for MKS sh
+if test -n "${ZSH_VERSION+set}" && (emulate sh) >/dev/null 2>&1; then
+  emulate sh
+  NULLCMD=:
+  # Zsh 3.x and 4.x performs word splitting on ${1+"$@"}, which
+  # is contrary to our usage.  Disable this feature.
+  alias -g '${1+"$@"}'='"$@"'
+  setopt NO_GLOB_SUBST
+else
+  case `(set -o) 2>/dev/null` in
+  *posix*) set -o posix ;;
+esac
+
+fi
+
+
+
+
+# PATH needs CR
+# Avoid depending upon Character Ranges.
+as_cr_letters='abcdefghijklmnopqrstuvwxyz'
+as_cr_LETTERS='ABCDEFGHIJKLMNOPQRSTUVWXYZ'
+as_cr_Letters=$as_cr_letters$as_cr_LETTERS
+as_cr_digits='0123456789'
+as_cr_alnum=$as_cr_Letters$as_cr_digits
+
+# The user is always right.
+if test "${PATH_SEPARATOR+set}" != set; then
+  echo "#! /bin/sh" >conf$$.sh
+  echo  "exit 0"   >>conf$$.sh
+  chmod +x conf$$.sh
+  if (PATH="/nonexistent;."; conf$$.sh) >/dev/null 2>&1; then
+    PATH_SEPARATOR=';'
+  else
+    PATH_SEPARATOR=:
+  fi
+  rm -f conf$$.sh
+fi
+
+# Support unset when possible.
+if ( (MAIL=60; unset MAIL) || exit) >/dev/null 2>&1; then
+  as_unset=unset
+else
+  as_unset=false
+fi
+
+
+# IFS
+# We need space, tab and new line, in precisely that order.  Quoting is
+# there to prevent editors from complaining about space-tab.
+# (If _AS_PATH_WALK were called with IFS unset, it would disable word
+# splitting by setting IFS to empty value.)
+as_nl='
+'
+IFS=" ""	$as_nl"
+
+# Find who we are.  Look in the path if we contain no directory separator.
+case $0 in
+  *[\\/]* ) as_myself=$0 ;;
+  *) as_save_IFS=$IFS; IFS=$PATH_SEPARATOR
+for as_dir in $PATH
+do
+  IFS=$as_save_IFS
+  test -z "$as_dir" && as_dir=.
+  test -r "$as_dir/$0" && as_myself=$as_dir/$0 && break
+done
+IFS=$as_save_IFS
+
+     ;;
+esac
+# We did not find ourselves, most probably we were run as `sh COMMAND'
+# in which case we are not to be found in the path.
+if test "x$as_myself" = x; then
+  as_myself=$0
+fi
+if test ! -f "$as_myself"; then
+  echo "$as_myself: error: cannot find myself; rerun with an absolute file name" >&2
+  { (exit 1); exit 1; }
+fi
+
+# Work around bugs in pre-3.0 UWIN ksh.
+for as_var in ENV MAIL MAILPATH
+do ($as_unset $as_var) >/dev/null 2>&1 && $as_unset $as_var
+done
+PS1='$ '
+PS2='> '
+PS4='+ '
+
+# NLS nuisances.
+for as_var in \
+  LANG LANGUAGE LC_ADDRESS LC_ALL LC_COLLATE LC_CTYPE LC_IDENTIFICATION \
+  LC_MEASUREMENT LC_MESSAGES LC_MONETARY LC_NAME LC_NUMERIC LC_PAPER \
+  LC_TELEPHONE LC_TIME
+do
+  if (set +x; test -z "`(eval $as_var=C; export $as_var) 2>&1`"); then
+    eval $as_var=C; export $as_var
+  else
+    ($as_unset $as_var) >/dev/null 2>&1 && $as_unset $as_var
+  fi
+done
+
+# Required to use basename.
+if expr a : '\(a\)' >/dev/null 2>&1 &&
+   test "X`expr 00001 : '.*\(...\)'`" = X001; then
+  as_expr=expr
+else
+  as_expr=false
+fi
+
+if (basename -- /) >/dev/null 2>&1 && test "X`basename -- / 2>&1`" = "X/"; then
+  as_basename=basename
+else
+  as_basename=false
+fi
+
+
+# Name of the executable.
+as_me=`$as_basename -- "$0" ||
+$as_expr X/"$0" : '.*/\([^/][^/]*\)/*$' \| \
+	 X"$0" : 'X\(//\)$' \| \
+	 X"$0" : 'X\(/\)' \| . 2>/dev/null ||
+echo X/"$0" |
+    sed '/^.*\/\([^/][^/]*\)\/*$/{
+	    s//\1/
+	    q
+	  }
+	  /^X\/\(\/\/\)$/{
+	    s//\1/
+	    q
+	  }
+	  /^X\/\(\/\).*/{
+	    s//\1/
+	    q
+	  }
+	  s/.*/./; q'`
+
+# CDPATH.
+$as_unset CDPATH
+
+
+if test "x$CONFIG_SHELL" = x; then
+  if (eval ":") 2>/dev/null; then
+  as_have_required=yes
+else
+  as_have_required=no
+fi
+
+  if test $as_have_required = yes && 	 (eval ":
+(as_func_return () {
+  (exit \$1)
+}
+as_func_success () {
+  as_func_return 0
+}
+as_func_failure () {
+  as_func_return 1
+}
+as_func_ret_success () {
+  return 0
+}
+as_func_ret_failure () {
+  return 1
+}
+
+exitcode=0
+if as_func_success; then
+  :
+else
+  exitcode=1
+  echo as_func_success failed.
+fi
+
+if as_func_failure; then
+  exitcode=1
+  echo as_func_failure succeeded.
+fi
+
+if as_func_ret_success; then
+  :
+else
+  exitcode=1
+  echo as_func_ret_success failed.
+fi
+
+if as_func_ret_failure; then
+  exitcode=1
+  echo as_func_ret_failure succeeded.
+fi
+
+if ( set x; as_func_ret_success y && test x = \"\$1\" ); then
+  :
+else
+  exitcode=1
+  echo positional parameters were not saved.
+fi
+
+test \$exitcode = 0) || { (exit 1); exit 1; }
+
+(
+  as_lineno_1=\$LINENO
+  as_lineno_2=\$LINENO
+  test \"x\$as_lineno_1\" != \"x\$as_lineno_2\" &&
+  test \"x\`expr \$as_lineno_1 + 1\`\" = \"x\$as_lineno_2\") || { (exit 1); exit 1; }
+") 2> /dev/null; then
+  :
+else
+  as_candidate_shells=
+    as_save_IFS=$IFS; IFS=$PATH_SEPARATOR
+for as_dir in /bin$PATH_SEPARATOR/usr/bin$PATH_SEPARATOR$PATH
+do
+  IFS=$as_save_IFS
+  test -z "$as_dir" && as_dir=.
+  case $as_dir in
+	 /*)
+	   for as_base in sh bash ksh sh5; do
+	     as_candidate_shells="$as_candidate_shells $as_dir/$as_base"
+	   done;;
+       esac
+done
+IFS=$as_save_IFS
+
+
+      for as_shell in $as_candidate_shells $SHELL; do
+	 # Try only shells that exist, to save several forks.
+	 if { test -f "$as_shell" || test -f "$as_shell.exe"; } &&
+		{ ("$as_shell") 2> /dev/null <<\_ASEOF
+if test -n "${ZSH_VERSION+set}" && (emulate sh) >/dev/null 2>&1; then
+  emulate sh
+  NULLCMD=:
+  # Zsh 3.x and 4.x performs word splitting on ${1+"$@"}, which
+  # is contrary to our usage.  Disable this feature.
+  alias -g '${1+"$@"}'='"$@"'
+  setopt NO_GLOB_SUBST
+else
+  case `(set -o) 2>/dev/null` in
+  *posix*) set -o posix ;;
+esac
+
+fi
+
+
+:
+_ASEOF
+}; then
+  CONFIG_SHELL=$as_shell
+	       as_have_required=yes
+	       if { "$as_shell" 2> /dev/null <<\_ASEOF
+if test -n "${ZSH_VERSION+set}" && (emulate sh) >/dev/null 2>&1; then
+  emulate sh
+  NULLCMD=:
+  # Zsh 3.x and 4.x performs word splitting on ${1+"$@"}, which
+  # is contrary to our usage.  Disable this feature.
+  alias -g '${1+"$@"}'='"$@"'
+  setopt NO_GLOB_SUBST
+else
+  case `(set -o) 2>/dev/null` in
+  *posix*) set -o posix ;;
+esac
+
+fi
+
+
+:
+(as_func_return () {
+  (exit $1)
+}
+as_func_success () {
+  as_func_return 0
+}
+as_func_failure () {
+  as_func_return 1
+}
+as_func_ret_success () {
+  return 0
+}
+as_func_ret_failure () {
+  return 1
+}
+
+exitcode=0
+if as_func_success; then
+  :
+else
+  exitcode=1
+  echo as_func_success failed.
+fi
+
+if as_func_failure; then
+  exitcode=1
+  echo as_func_failure succeeded.
+fi
+
+if as_func_ret_success; then
+  :
+else
+  exitcode=1
+  echo as_func_ret_success failed.
+fi
+
+if as_func_ret_failure; then
+  exitcode=1
+  echo as_func_ret_failure succeeded.
+fi
+
+if ( set x; as_func_ret_success y && test x = "$1" ); then
+  :
+else
+  exitcode=1
+  echo positional parameters were not saved.
+fi
+
+test $exitcode = 0) || { (exit 1); exit 1; }
+
+(
+  as_lineno_1=$LINENO
+  as_lineno_2=$LINENO
+  test "x$as_lineno_1" != "x$as_lineno_2" &&
+  test "x`expr $as_lineno_1 + 1`" = "x$as_lineno_2") || { (exit 1); exit 1; }
+
+_ASEOF
+}; then
+  break
+fi
+
+fi
+
+      done
+
+      if test "x$CONFIG_SHELL" != x; then
+  for as_var in BASH_ENV ENV
+        do ($as_unset $as_var) >/dev/null 2>&1 && $as_unset $as_var
+        done
+        export CONFIG_SHELL
+        exec "$CONFIG_SHELL" "$as_myself" ${1+"$@"}
+fi
+
+
+    if test $as_have_required = no; then
+  echo This script requires a shell more modern than all the
+      echo shells that I found on your system.  Please install a
+      echo modern shell, or manually run the script under such a
+      echo shell if you do have one.
+      { (exit 1); exit 1; }
+fi
+
+
+fi
+
+fi
+
+
+
+(eval "as_func_return () {
+  (exit \$1)
+}
+as_func_success () {
+  as_func_return 0
+}
+as_func_failure () {
+  as_func_return 1
+}
+as_func_ret_success () {
+  return 0
+}
+as_func_ret_failure () {
+  return 1
+}
+
+exitcode=0
+if as_func_success; then
+  :
+else
+  exitcode=1
+  echo as_func_success failed.
+fi
+
+if as_func_failure; then
+  exitcode=1
+  echo as_func_failure succeeded.
+fi
+
+if as_func_ret_success; then
+  :
+else
+  exitcode=1
+  echo as_func_ret_success failed.
+fi
+
+if as_func_ret_failure; then
+  exitcode=1
+  echo as_func_ret_failure succeeded.
+fi
+
+if ( set x; as_func_ret_success y && test x = \"\$1\" ); then
+  :
+else
+  exitcode=1
+  echo positional parameters were not saved.
+fi
+
+test \$exitcode = 0") || {
+  echo No shell found that supports shell functions.
+  echo Please tell autoconf@gnu.org about your system,
+  echo including any error possibly output before this
+  echo message
+}
+
+
+
+  as_lineno_1=$LINENO
+  as_lineno_2=$LINENO
+  test "x$as_lineno_1" != "x$as_lineno_2" &&
+  test "x`expr $as_lineno_1 + 1`" = "x$as_lineno_2" || {
+
+  # Create $as_me.lineno as a copy of $as_myself, but with $LINENO
+  # uniformly replaced by the line number.  The first 'sed' inserts a
+  # line-number line after each line using $LINENO; the second 'sed'
+  # does the real work.  The second script uses 'N' to pair each
+  # line-number line with the line containing $LINENO, and appends
+  # trailing '-' during substitution so that $LINENO is not a special
+  # case at line end.
+  # (Raja R Harinath suggested sed '=', and Paul Eggert wrote the
+  # scripts with optimization help from Paolo Bonzini.  Blame Lee
+  # E. McMahon (1931-1989) for sed's syntax.  :-)
+  sed -n '
+    p
+    /[$]LINENO/=
+  ' <$as_myself |
+    sed '
+      s/[$]LINENO.*/&-/
+      t lineno
+      b
+      :lineno
+      N
+      :loop
+      s/[$]LINENO\([^'$as_cr_alnum'_].*\n\)\(.*\)/\2\1\2/
+      t loop
+      s/-\n.*//
+    ' >$as_me.lineno &&
+  chmod +x "$as_me.lineno" ||
+    { echo "$as_me: error: cannot create $as_me.lineno; rerun with a POSIX shell" >&2
+   { (exit 1); exit 1; }; }
+
+  # Don't try to exec as it changes $[0], causing all sort of problems
+  # (the dirname of $[0] is not the place where we might find the
+  # original and so on.  Autoconf is especially sensitive to this).
+  . "./$as_me.lineno"
+  # Exit status is that of the last command.
+  exit
+}
+
+
+if (as_dir=`dirname -- /` && test "X$as_dir" = X/) >/dev/null 2>&1; then
+  as_dirname=dirname
+else
+  as_dirname=false
+fi
+
+ECHO_C= ECHO_N= ECHO_T=
+case `echo -n x` in
+-n*)
+  case `echo 'x\c'` in
+  *c*) ECHO_T='	';;	# ECHO_T is single tab character.
+  *)   ECHO_C='\c';;
+  esac;;
+*)
+  ECHO_N='-n';;
+esac
+
+if expr a : '\(a\)' >/dev/null 2>&1 &&
+   test "X`expr 00001 : '.*\(...\)'`" = X001; then
+  as_expr=expr
+else
+  as_expr=false
+fi
+
+rm -f conf$$ conf$$.exe conf$$.file
+if test -d conf$$.dir; then
+  rm -f conf$$.dir/conf$$.file
+else
+  rm -f conf$$.dir
+  mkdir conf$$.dir
+fi
+echo >conf$$.file
+if ln -s conf$$.file conf$$ 2>/dev/null; then
+  as_ln_s='ln -s'
+  # ... but there are two gotchas:
+  # 1) On MSYS, both `ln -s file dir' and `ln file dir' fail.
+  # 2) DJGPP < 2.04 has no symlinks; `ln -s' creates a wrapper executable.
+  # In both cases, we have to default to `cp -p'.
+  ln -s conf$$.file conf$$.dir 2>/dev/null && test ! -f conf$$.exe ||
+    as_ln_s='cp -p'
+elif ln conf$$.file conf$$ 2>/dev/null; then
+  as_ln_s=ln
+else
+  as_ln_s='cp -p'
+fi
+rm -f conf$$ conf$$.exe conf$$.dir/conf$$.file conf$$.file
+rmdir conf$$.dir 2>/dev/null
+
+if mkdir -p . 2>/dev/null; then
+  as_mkdir_p=:
+else
+  test -d ./-p && rmdir ./-p
+  as_mkdir_p=false
+fi
+
+if test -x / >/dev/null 2>&1; then
+  as_test_x='test -x'
+else
+  if ls -dL / >/dev/null 2>&1; then
+    as_ls_L_option=L
+  else
+    as_ls_L_option=
+  fi
+  as_test_x='
+    eval sh -c '\''
+      if test -d "$1"; then
+        test -d "$1/.";
+      else
+	case $1 in
+        -*)set "./$1";;
+	esac;
+	case `ls -ld'$as_ls_L_option' "$1" 2>/dev/null` in
+	???[sx]*):;;*)false;;esac;fi
+    '\'' sh
+  '
+fi
+as_executable_p=$as_test_x
+
+# Sed expression to map a string onto a valid CPP name.
+as_tr_cpp="eval sed 'y%*$as_cr_letters%P$as_cr_LETTERS%;s%[^_$as_cr_alnum]%_%g'"
+
+# Sed expression to map a string onto a valid variable name.
+as_tr_sh="eval sed 'y%*+%pp%;s%[^_$as_cr_alnum]%_%g'"
+
+
+
+exec 7<&0 </dev/null 6>&1
+
+# Name of the host.
+# hostname on some systems (SVR3.2, Linux) returns a bogus exit status,
+# so uname gets run too.
+ac_hostname=`(hostname || uname -n) 2>/dev/null | sed 1q`
+
+#
+# Initializations.
+#
+ac_default_prefix=/usr/local
+ac_clean_files=
+ac_config_libobj_dir=.
+LIBOBJS=
+cross_compiling=no
+subdirs=
+MFLAGS=
+MAKEFLAGS=
+SHELL=${CONFIG_SHELL-/bin/sh}
+
+# Identity of this package.
+PACKAGE_NAME=
+PACKAGE_TARNAME=
+PACKAGE_VERSION=
+PACKAGE_STRING=
+PACKAGE_BUGREPORT=
+
+ac_unique_file="main.c"
+# Factoring default headers for most tests.
+ac_includes_default="\
+#include <stdio.h>
+#ifdef HAVE_SYS_TYPES_H
+# include <sys/types.h>
+#endif
+#ifdef HAVE_SYS_STAT_H
+# include <sys/stat.h>
+#endif
+#ifdef STDC_HEADERS
+# include <stdlib.h>
+# include <stddef.h>
+#else
+# ifdef HAVE_STDLIB_H
+#  include <stdlib.h>
+# endif
+#endif
+#ifdef HAVE_STRING_H
+# if !defined STDC_HEADERS && defined HAVE_MEMORY_H
+#  include <memory.h>
+# endif
+# include <string.h>
+#endif
+#ifdef HAVE_STRINGS_H
+# include <strings.h>
+#endif
+#ifdef HAVE_INTTYPES_H
+# include <inttypes.h>
+#endif
+#ifdef HAVE_STDINT_H
+# include <stdint.h>
+#endif
+#ifdef HAVE_UNISTD_H
+# include <unistd.h>
+#endif"
+
+ac_subst_vars='SHELL
+PATH_SEPARATOR
+PACKAGE_NAME
+PACKAGE_TARNAME
+PACKAGE_VERSION
+PACKAGE_STRING
+PACKAGE_BUGREPORT
+exec_prefix
+prefix
+program_transform_name
+bindir
+sbindir
+libexecdir
+datarootdir
+datadir
+sysconfdir
+sharedstatedir
+localstatedir
+includedir
+oldincludedir
+docdir
+infodir
+htmldir
+dvidir
+pdfdir
+psdir
+libdir
+localedir
+mandir
+DEFS
+ECHO_C
+ECHO_N
+ECHO_T
+LIBS
+build_alias
+host_alias
+target_alias
+INSTALL_PROGRAM
+INSTALL_SCRIPT
+INSTALL_DATA
+am__isrc
+CYGPATH_W
+PACKAGE
+VERSION
+ACLOCAL
+AUTOCONF
+AUTOMAKE
+AUTOHEADER
+MAKEINFO
+install_sh
+STRIP
+INSTALL_STRIP_PROGRAM
+mkdir_p
+AWK
+SET_MAKE
+am__leading_dot
+AMTAR
+am__tar
+am__untar
+build
+build_cpu
+build_vendor
+build_os
+host
+host_cpu
+host_vendor
+host_os
+CC
+CFLAGS
+LDFLAGS
+CPPFLAGS
+ac_ct_CC
+EXEEXT
+OBJEXT
+DEPDIR
+am__include
+am__quote
+AMDEP_TRUE
+AMDEP_FALSE
+AMDEPBACKSLASH
+CCDEPMODE
+am__fastdepCC_TRUE
+am__fastdepCC_FALSE
+CPP
+GREP
+EGREP
+LIBOBJS
+LTLIBOBJS'
+ac_subst_files=''
+      ac_precious_vars='build_alias
+host_alias
+target_alias
+CC
+CFLAGS
+LDFLAGS
+LIBS
+CPPFLAGS
+CPP'
+
+
+# Initialize some variables set by options.
+ac_init_help=
+ac_init_version=false
+# The variables have the same names as the options, with
+# dashes changed to underlines.
+cache_file=/dev/null
+exec_prefix=NONE
+no_create=
+no_recursion=
+prefix=NONE
+program_prefix=NONE
+program_suffix=NONE
+program_transform_name=s,x,x,
+silent=
+site=
+srcdir=
+verbose=
+x_includes=NONE
+x_libraries=NONE
+
+# Installation directory options.
+# These are left unexpanded so users can "make install exec_prefix=/foo"
+# and all the variables that are supposed to be based on exec_prefix
+# by default will actually change.
+# Use braces instead of parens because sh, perl, etc. also accept them.
+# (The list follows the same order as the GNU Coding Standards.)
+bindir='${exec_prefix}/bin'
+sbindir='${exec_prefix}/sbin'
+libexecdir='${exec_prefix}/libexec'
+datarootdir='${prefix}/share'
+datadir='${datarootdir}'
+sysconfdir='${prefix}/etc'
+sharedstatedir='${prefix}/com'
+localstatedir='${prefix}/var'
+includedir='${prefix}/include'
+oldincludedir='/usr/include'
+docdir='${datarootdir}/doc/${PACKAGE}'
+infodir='${datarootdir}/info'
+htmldir='${docdir}'
+dvidir='${docdir}'
+pdfdir='${docdir}'
+psdir='${docdir}'
+libdir='${exec_prefix}/lib'
+localedir='${datarootdir}/locale'
+mandir='${datarootdir}/man'
+
+ac_prev=
+ac_dashdash=
+for ac_option
+do
+  # If the previous option needs an argument, assign it.
+  if test -n "$ac_prev"; then
+    eval $ac_prev=\$ac_option
+    ac_prev=
+    continue
+  fi
+
+  case $ac_option in
+  *=*)	ac_optarg=`expr "X$ac_option" : '[^=]*=\(.*\)'` ;;
+  *)	ac_optarg=yes ;;
+  esac
+
+  # Accept the important Cygnus configure options, so we can diagnose typos.
+
+  case $ac_dashdash$ac_option in
+  --)
+    ac_dashdash=yes ;;
+
+  -bindir | --bindir | --bindi | --bind | --bin | --bi)
+    ac_prev=bindir ;;
+  -bindir=* | --bindir=* | --bindi=* | --bind=* | --bin=* | --bi=*)
+    bindir=$ac_optarg ;;
+
+  -build | --build | --buil | --bui | --bu)
+    ac_prev=build_alias ;;
+  -build=* | --build=* | --buil=* | --bui=* | --bu=*)
+    build_alias=$ac_optarg ;;
+
+  -cache-file | --cache-file | --cache-fil | --cache-fi \
+  | --cache-f | --cache- | --cache | --cach | --cac | --ca | --c)
+    ac_prev=cache_file ;;
+  -cache-file=* | --cache-file=* | --cache-fil=* | --cache-fi=* \
+  | --cache-f=* | --cache-=* | --cache=* | --cach=* | --cac=* | --ca=* | --c=*)
+    cache_file=$ac_optarg ;;
+
+  --config-cache | -C)
+    cache_file=config.cache ;;
+
+  -datadir | --datadir | --datadi | --datad)
+    ac_prev=datadir ;;
+  -datadir=* | --datadir=* | --datadi=* | --datad=*)
+    datadir=$ac_optarg ;;
+
+  -datarootdir | --datarootdir | --datarootdi | --datarootd | --dataroot \
+  | --dataroo | --dataro | --datar)
+    ac_prev=datarootdir ;;
+  -datarootdir=* | --datarootdir=* | --datarootdi=* | --datarootd=* \
+  | --dataroot=* | --dataroo=* | --dataro=* | --datar=*)
+    datarootdir=$ac_optarg ;;
+
+  -disable-* | --disable-*)
+    ac_feature=`expr "x$ac_option" : 'x-*disable-\(.*\)'`
+    # Reject names that are not valid shell variable names.
+    expr "x$ac_feature" : ".*[^-._$as_cr_alnum]" >/dev/null &&
+      { echo "$as_me: error: invalid feature name: $ac_feature" >&2
+   { (exit 1); exit 1; }; }
+    ac_feature=`echo $ac_feature | sed 's/[-.]/_/g'`
+    eval enable_$ac_feature=no ;;
+
+  -docdir | --docdir | --docdi | --doc | --do)
+    ac_prev=docdir ;;
+  -docdir=* | --docdir=* | --docdi=* | --doc=* | --do=*)
+    docdir=$ac_optarg ;;
+
+  -dvidir | --dvidir | --dvidi | --dvid | --dvi | --dv)
+    ac_prev=dvidir ;;
+  -dvidir=* | --dvidir=* | --dvidi=* | --dvid=* | --dvi=* | --dv=*)
+    dvidir=$ac_optarg ;;
+
+  -enable-* | --enable-*)
+    ac_feature=`expr "x$ac_option" : 'x-*enable-\([^=]*\)'`
+    # Reject names that are not valid shell variable names.
+    expr "x$ac_feature" : ".*[^-._$as_cr_alnum]" >/dev/null &&
+      { echo "$as_me: error: invalid feature name: $ac_feature" >&2
+   { (exit 1); exit 1; }; }
+    ac_feature=`echo $ac_feature | sed 's/[-.]/_/g'`
+    eval enable_$ac_feature=\$ac_optarg ;;
+
+  -exec-prefix | --exec_prefix | --exec-prefix | --exec-prefi \
+  | --exec-pref | --exec-pre | --exec-pr | --exec-p | --exec- \
+  | --exec | --exe | --ex)
+    ac_prev=exec_prefix ;;
+  -exec-prefix=* | --exec_prefix=* | --exec-prefix=* | --exec-prefi=* \
+  | --exec-pref=* | --exec-pre=* | --exec-pr=* | --exec-p=* | --exec-=* \
+  | --exec=* | --exe=* | --ex=*)
+    exec_prefix=$ac_optarg ;;
+
+  -gas | --gas | --ga | --g)
+    # Obsolete; use --with-gas.
+    with_gas=yes ;;
+
+  -help | --help | --hel | --he | -h)
+    ac_init_help=long ;;
+  -help=r* | --help=r* | --hel=r* | --he=r* | -hr*)
+    ac_init_help=recursive ;;
+  -help=s* | --help=s* | --hel=s* | --he=s* | -hs*)
+    ac_init_help=short ;;
+
+  -host | --host | --hos | --ho)
+    ac_prev=host_alias ;;
+  -host=* | --host=* | --hos=* | --ho=*)
+    host_alias=$ac_optarg ;;
+
+  -htmldir | --htmldir | --htmldi | --htmld | --html | --htm | --ht)
+    ac_prev=htmldir ;;
+  -htmldir=* | --htmldir=* | --htmldi=* | --htmld=* | --html=* | --htm=* \
+  | --ht=*)
+    htmldir=$ac_optarg ;;
+
+  -includedir | --includedir | --includedi | --included | --include \
+  | --includ | --inclu | --incl | --inc)
+    ac_prev=includedir ;;
+  -includedir=* | --includedir=* | --includedi=* | --included=* | --include=* \
+  | --includ=* | --inclu=* | --incl=* | --inc=*)
+    includedir=$ac_optarg ;;
+
+  -infodir | --infodir | --infodi | --infod | --info | --inf)
+    ac_prev=infodir ;;
+  -infodir=* | --infodir=* | --infodi=* | --infod=* | --info=* | --inf=*)
+    infodir=$ac_optarg ;;
+
+  -libdir | --libdir | --libdi | --libd)
+    ac_prev=libdir ;;
+  -libdir=* | --libdir=* | --libdi=* | --libd=*)
+    libdir=$ac_optarg ;;
+
+  -libexecdir | --libexecdir | --libexecdi | --libexecd | --libexec \
+  | --libexe | --libex | --libe)
+    ac_prev=libexecdir ;;
+  -libexecdir=* | --libexecdir=* | --libexecdi=* | --libexecd=* | --libexec=* \
+  | --libexe=* | --libex=* | --libe=*)
+    libexecdir=$ac_optarg ;;
+
+  -localedir | --localedir | --localedi | --localed | --locale)
+    ac_prev=localedir ;;
+  -localedir=* | --localedir=* | --localedi=* | --localed=* | --locale=*)
+    localedir=$ac_optarg ;;
+
+  -localstatedir | --localstatedir | --localstatedi | --localstated \
+  | --localstate | --localstat | --localsta | --localst | --locals)
+    ac_prev=localstatedir ;;
+  -localstatedir=* | --localstatedir=* | --localstatedi=* | --localstated=* \
+  | --localstate=* | --localstat=* | --localsta=* | --localst=* | --locals=*)
+    localstatedir=$ac_optarg ;;
+
+  -mandir | --mandir | --mandi | --mand | --man | --ma | --m)
+    ac_prev=mandir ;;
+  -mandir=* | --mandir=* | --mandi=* | --mand=* | --man=* | --ma=* | --m=*)
+    mandir=$ac_optarg ;;
+
+  -nfp | --nfp | --nf)
+    # Obsolete; use --without-fp.
+    with_fp=no ;;
+
+  -no-create | --no-create | --no-creat | --no-crea | --no-cre \
+  | --no-cr | --no-c | -n)
+    no_create=yes ;;
+
+  -no-recursion | --no-recursion | --no-recursio | --no-recursi \
+  | --no-recurs | --no-recur | --no-recu | --no-rec | --no-re | --no-r)
+    no_recursion=yes ;;
+
+  -oldincludedir | --oldincludedir | --oldincludedi | --oldincluded \
+  | --oldinclude | --oldinclud | --oldinclu | --oldincl | --oldinc \
+  | --oldin | --oldi | --old | --ol | --o)
+    ac_prev=oldincludedir ;;
+  -oldincludedir=* | --oldincludedir=* | --oldincludedi=* | --oldincluded=* \
+  | --oldinclude=* | --oldinclud=* | --oldinclu=* | --oldincl=* | --oldinc=* \
+  | --oldin=* | --oldi=* | --old=* | --ol=* | --o=*)
+    oldincludedir=$ac_optarg ;;
+
+  -prefix | --prefix | --prefi | --pref | --pre | --pr | --p)
+    ac_prev=prefix ;;
+  -prefix=* | --prefix=* | --prefi=* | --pref=* | --pre=* | --pr=* | --p=*)
+    prefix=$ac_optarg ;;
+
+  -program-prefix | --program-prefix | --program-prefi | --program-pref \
+  | --program-pre | --program-pr | --program-p)
+    ac_prev=program_prefix ;;
+  -program-prefix=* | --program-prefix=* | --program-prefi=* \
+  | --program-pref=* | --program-pre=* | --program-pr=* | --program-p=*)
+    program_prefix=$ac_optarg ;;
+
+  -program-suffix | --program-suffix | --program-suffi | --program-suff \
+  | --program-suf | --program-su | --program-s)
+    ac_prev=program_suffix ;;
+  -program-suffix=* | --program-suffix=* | --program-suffi=* \
+  | --program-suff=* | --program-suf=* | --program-su=* | --program-s=*)
+    program_suffix=$ac_optarg ;;
+
+  -program-transform-name | --program-transform-name \
+  | --program-transform-nam | --program-transform-na \
+  | --program-transform-n | --program-transform- \
+  | --program-transform | --program-transfor \
+  | --program-transfo | --program-transf \
+  | --program-trans | --program-tran \
+  | --progr-tra | --program-tr | --program-t)
+    ac_prev=program_transform_name ;;
+  -program-transform-name=* | --program-transform-name=* \
+  | --program-transform-nam=* | --program-transform-na=* \
+  | --program-transform-n=* | --program-transform-=* \
+  | --program-transform=* | --program-transfor=* \
+  | --program-transfo=* | --program-transf=* \
+  | --program-trans=* | --program-tran=* \
+  | --progr-tra=* | --program-tr=* | --program-t=*)
+    program_transform_name=$ac_optarg ;;
+
+  -pdfdir | --pdfdir | --pdfdi | --pdfd | --pdf | --pd)
+    ac_prev=pdfdir ;;
+  -pdfdir=* | --pdfdir=* | --pdfdi=* | --pdfd=* | --pdf=* | --pd=*)
+    pdfdir=$ac_optarg ;;
+
+  -psdir | --psdir | --psdi | --psd | --ps)
+    ac_prev=psdir ;;
+  -psdir=* | --psdir=* | --psdi=* | --psd=* | --ps=*)
+    psdir=$ac_optarg ;;
+
+  -q | -quiet | --quiet | --quie | --qui | --qu | --q \
+  | -silent | --silent | --silen | --sile | --sil)
+    silent=yes ;;
+
+  -sbindir | --sbindir | --sbindi | --sbind | --sbin | --sbi | --sb)
+    ac_prev=sbindir ;;
+  -sbindir=* | --sbindir=* | --sbindi=* | --sbind=* | --sbin=* \
+  | --sbi=* | --sb=*)
+    sbindir=$ac_optarg ;;
+
+  -sharedstatedir | --sharedstatedir | --sharedstatedi \
+  | --sharedstated | --sharedstate | --sharedstat | --sharedsta \
+  | --sharedst | --shareds | --shared | --share | --shar \
+  | --sha | --sh)
+    ac_prev=sharedstatedir ;;
+  -sharedstatedir=* | --sharedstatedir=* | --sharedstatedi=* \
+  | --sharedstated=* | --sharedstate=* | --sharedstat=* | --sharedsta=* \
+  | --sharedst=* | --shareds=* | --shared=* | --share=* | --shar=* \
+  | --sha=* | --sh=*)
+    sharedstatedir=$ac_optarg ;;
+
+  -site | --site | --sit)
+    ac_prev=site ;;
+  -site=* | --site=* | --sit=*)
+    site=$ac_optarg ;;
+
+  -srcdir | --srcdir | --srcdi | --srcd | --src | --sr)
+    ac_prev=srcdir ;;
+  -srcdir=* | --srcdir=* | --srcdi=* | --srcd=* | --src=* | --sr=*)
+    srcdir=$ac_optarg ;;
+
+  -sysconfdir | --sysconfdir | --sysconfdi | --sysconfd | --sysconf \
+  | --syscon | --sysco | --sysc | --sys | --sy)
+    ac_prev=sysconfdir ;;
+  -sysconfdir=* | --sysconfdir=* | --sysconfdi=* | --sysconfd=* | --sysconf=* \
+  | --syscon=* | --sysco=* | --sysc=* | --sys=* | --sy=*)
+    sysconfdir=$ac_optarg ;;
+
+  -target | --target | --targe | --targ | --tar | --ta | --t)
+    ac_prev=target_alias ;;
+  -target=* | --target=* | --targe=* | --targ=* | --tar=* | --ta=* | --t=*)
+    target_alias=$ac_optarg ;;
+
+  -v | -verbose | --verbose | --verbos | --verbo | --verb)
+    verbose=yes ;;
+
+  -version | --version | --versio | --versi | --vers | -V)
+    ac_init_version=: ;;
+
+  -with-* | --with-*)
+    ac_package=`expr "x$ac_option" : 'x-*with-\([^=]*\)'`
+    # Reject names that are not valid shell variable names.
+    expr "x$ac_package" : ".*[^-._$as_cr_alnum]" >/dev/null &&
+      { echo "$as_me: error: invalid package name: $ac_package" >&2
+   { (exit 1); exit 1; }; }
+    ac_package=`echo $ac_package | sed 's/[-.]/_/g'`
+    eval with_$ac_package=\$ac_optarg ;;
+
+  -without-* | --without-*)
+    ac_package=`expr "x$ac_option" : 'x-*without-\(.*\)'`
+    # Reject names that are not valid shell variable names.
+    expr "x$ac_package" : ".*[^-._$as_cr_alnum]" >/dev/null &&
+      { echo "$as_me: error: invalid package name: $ac_package" >&2
+   { (exit 1); exit 1; }; }
+    ac_package=`echo $ac_package | sed 's/[-.]/_/g'`
+    eval with_$ac_package=no ;;
+
+  --x)
+    # Obsolete; use --with-x.
+    with_x=yes ;;
+
+  -x-includes | --x-includes | --x-include | --x-includ | --x-inclu \
+  | --x-incl | --x-inc | --x-in | --x-i)
+    ac_prev=x_includes ;;
+  -x-includes=* | --x-includes=* | --x-include=* | --x-includ=* | --x-inclu=* \
+  | --x-incl=* | --x-inc=* | --x-in=* | --x-i=*)
+    x_includes=$ac_optarg ;;
+
+  -x-libraries | --x-libraries | --x-librarie | --x-librari \
+  | --x-librar | --x-libra | --x-libr | --x-lib | --x-li | --x-l)
+    ac_prev=x_libraries ;;
+  -x-libraries=* | --x-libraries=* | --x-librarie=* | --x-librari=* \
+  | --x-librar=* | --x-libra=* | --x-libr=* | --x-lib=* | --x-li=* | --x-l=*)
+    x_libraries=$ac_optarg ;;
+
+  -*) { echo "$as_me: error: unrecognized option: $ac_option
+Try \`$0 --help' for more information." >&2
+   { (exit 1); exit 1; }; }
+    ;;
+
+  *=*)
+    ac_envvar=`expr "x$ac_option" : 'x\([^=]*\)='`
+    # Reject names that are not valid shell variable names.
+    expr "x$ac_envvar" : ".*[^_$as_cr_alnum]" >/dev/null &&
+      { echo "$as_me: error: invalid variable name: $ac_envvar" >&2
+   { (exit 1); exit 1; }; }
+    eval $ac_envvar=\$ac_optarg
+    export $ac_envvar ;;
+
+  *)
+    # FIXME: should be removed in autoconf 3.0.
+    echo "$as_me: WARNING: you should use --build, --host, --target" >&2
+    expr "x$ac_option" : ".*[^-._$as_cr_alnum]" >/dev/null &&
+      echo "$as_me: WARNING: invalid host type: $ac_option" >&2
+    : ${build_alias=$ac_option} ${host_alias=$ac_option} ${target_alias=$ac_option}
+    ;;
+
+  esac
+done
+
+if test -n "$ac_prev"; then
+  ac_option=--`echo $ac_prev | sed 's/_/-/g'`
+  { echo "$as_me: error: missing argument to $ac_option" >&2
+   { (exit 1); exit 1; }; }
+fi
+
+# Be sure to have absolute directory names.
+for ac_var in	exec_prefix prefix bindir sbindir libexecdir datarootdir \
+		datadir sysconfdir sharedstatedir localstatedir includedir \
+		oldincludedir docdir infodir htmldir dvidir pdfdir psdir \
+		libdir localedir mandir
+do
+  eval ac_val=\$$ac_var
+  case $ac_val in
+    [\\/$]* | ?:[\\/]* )  continue;;
+    NONE | '' ) case $ac_var in *prefix ) continue;; esac;;
+  esac
+  { echo "$as_me: error: expected an absolute directory name for --$ac_var: $ac_val" >&2
+   { (exit 1); exit 1; }; }
+done
+
+# There might be people who depend on the old broken behavior: `$host'
+# used to hold the argument of --host etc.
+# FIXME: To remove some day.
+build=$build_alias
+host=$host_alias
+target=$target_alias
+
+# FIXME: To remove some day.
+if test "x$host_alias" != x; then
+  if test "x$build_alias" = x; then
+    cross_compiling=maybe
+    echo "$as_me: WARNING: If you wanted to set the --build type, don't use --host.
+    If a cross compiler is detected then cross compile mode will be used." >&2
+  elif test "x$build_alias" != "x$host_alias"; then
+    cross_compiling=yes
+  fi
+fi
+
+ac_tool_prefix=
+test -n "$host_alias" && ac_tool_prefix=$host_alias-
+
+test "$silent" = yes && exec 6>/dev/null
+
+
+ac_pwd=`pwd` && test -n "$ac_pwd" &&
+ac_ls_di=`ls -di .` &&
+ac_pwd_ls_di=`cd "$ac_pwd" && ls -di .` ||
+  { echo "$as_me: error: Working directory cannot be determined" >&2
+   { (exit 1); exit 1; }; }
+test "X$ac_ls_di" = "X$ac_pwd_ls_di" ||
+  { echo "$as_me: error: pwd does not report name of working directory" >&2
+   { (exit 1); exit 1; }; }
+
+
+# Find the source files, if location was not specified.
+if test -z "$srcdir"; then
+  ac_srcdir_defaulted=yes
+  # Try the directory containing this script, then the parent directory.
+  ac_confdir=`$as_dirname -- "$0" ||
+$as_expr X"$0" : 'X\(.*[^/]\)//*[^/][^/]*/*$' \| \
+	 X"$0" : 'X\(//\)[^/]' \| \
+	 X"$0" : 'X\(//\)$' \| \
+	 X"$0" : 'X\(/\)' \| . 2>/dev/null ||
+echo X"$0" |
+    sed '/^X\(.*[^/]\)\/\/*[^/][^/]*\/*$/{
+	    s//\1/
+	    q
+	  }
+	  /^X\(\/\/\)[^/].*/{
+	    s//\1/
+	    q
+	  }
+	  /^X\(\/\/\)$/{
+	    s//\1/
+	    q
+	  }
+	  /^X\(\/\).*/{
+	    s//\1/
+	    q
+	  }
+	  s/.*/./; q'`
+  srcdir=$ac_confdir
+  if test ! -r "$srcdir/$ac_unique_file"; then
+    srcdir=..
+  fi
+else
+  ac_srcdir_defaulted=no
+fi
+if test ! -r "$srcdir/$ac_unique_file"; then
+  test "$ac_srcdir_defaulted" = yes && srcdir="$ac_confdir or .."
+  { echo "$as_me: error: cannot find sources ($ac_unique_file) in $srcdir" >&2
+   { (exit 1); exit 1; }; }
+fi
+ac_msg="sources are in $srcdir, but \`cd $srcdir' does not work"
+ac_abs_confdir=`(
+	cd "$srcdir" && test -r "./$ac_unique_file" || { echo "$as_me: error: $ac_msg" >&2
+   { (exit 1); exit 1; }; }
+	pwd)`
+# When building in place, set srcdir=.
+if test "$ac_abs_confdir" = "$ac_pwd"; then
+  srcdir=.
+fi
+# Remove unnecessary trailing slashes from srcdir.
+# Double slashes in file names in object file debugging info
+# mess up M-x gdb in Emacs.
+case $srcdir in
+*/) srcdir=`expr "X$srcdir" : 'X\(.*[^/]\)' \| "X$srcdir" : 'X\(.*\)'`;;
+esac
+for ac_var in $ac_precious_vars; do
+  eval ac_env_${ac_var}_set=\${${ac_var}+set}
+  eval ac_env_${ac_var}_value=\$${ac_var}
+  eval ac_cv_env_${ac_var}_set=\${${ac_var}+set}
+  eval ac_cv_env_${ac_var}_value=\$${ac_var}
+done
+
+#
+# Report the --help message.
+#
+if test "$ac_init_help" = "long"; then
+  # Omit some internal or obsolete options to make the list less imposing.
+  # This message is too long to be a string in the A/UX 3.1 sh.
+  cat <<_ACEOF
+\`configure' configures this package to adapt to many kinds of systems.
+
+Usage: $0 [OPTION]... [VAR=VALUE]...
+
+To assign environment variables (e.g., CC, CFLAGS...), specify them as
+VAR=VALUE.  See below for descriptions of some of the useful variables.
+
+Defaults for the options are specified in brackets.
+
+Configuration:
+  -h, --help              display this help and exit
+      --help=short        display options specific to this package
+      --help=recursive    display the short help of all the included packages
+  -V, --version           display version information and exit
+  -q, --quiet, --silent   do not print \`checking...' messages
+      --cache-file=FILE   cache test results in FILE [disabled]
+  -C, --config-cache      alias for \`--cache-file=config.cache'
+  -n, --no-create         do not create output files
+      --srcdir=DIR        find the sources in DIR [configure dir or \`..']
+
+Installation directories:
+  --prefix=PREFIX         install architecture-independent files in PREFIX
+			  [$ac_default_prefix]
+  --exec-prefix=EPREFIX   install architecture-dependent files in EPREFIX
+			  [PREFIX]
+
+By default, \`make install' will install all the files in
+\`$ac_default_prefix/bin', \`$ac_default_prefix/lib' etc.  You can specify
+an installation prefix other than \`$ac_default_prefix' using \`--prefix',
+for instance \`--prefix=\$HOME'.
+
+For better control, use the options below.
+
+Fine tuning of the installation directories:
+  --bindir=DIR           user executables [EPREFIX/bin]
+  --sbindir=DIR          system admin executables [EPREFIX/sbin]
+  --libexecdir=DIR       program executables [EPREFIX/libexec]
+  --sysconfdir=DIR       read-only single-machine data [PREFIX/etc]
+  --sharedstatedir=DIR   modifiable architecture-independent data [PREFIX/com]
+  --localstatedir=DIR    modifiable single-machine data [PREFIX/var]
+  --libdir=DIR           object code libraries [EPREFIX/lib]
+  --includedir=DIR       C header files [PREFIX/include]
+  --oldincludedir=DIR    C header files for non-gcc [/usr/include]
+  --datarootdir=DIR      read-only arch.-independent data root [PREFIX/share]
+  --datadir=DIR          read-only architecture-independent data [DATAROOTDIR]
+  --infodir=DIR          info documentation [DATAROOTDIR/info]
+  --localedir=DIR        locale-dependent data [DATAROOTDIR/locale]
+  --mandir=DIR           man documentation [DATAROOTDIR/man]
+  --docdir=DIR           documentation root [DATAROOTDIR/doc/PACKAGE]
+  --htmldir=DIR          html documentation [DOCDIR]
+  --dvidir=DIR           dvi documentation [DOCDIR]
+  --pdfdir=DIR           pdf documentation [DOCDIR]
+  --psdir=DIR            ps documentation [DOCDIR]
+_ACEOF
+
+  cat <<\_ACEOF
+
+Program names:
+  --program-prefix=PREFIX            prepend PREFIX to installed program names
+  --program-suffix=SUFFIX            append SUFFIX to installed program names
+  --program-transform-name=PROGRAM   run sed PROGRAM on installed program names
+
+System types:
+  --build=BUILD     configure for building on BUILD [guessed]
+  --host=HOST       cross-compile to build programs to run on HOST [BUILD]
+_ACEOF
+fi
+
+if test -n "$ac_init_help"; then
+
+  cat <<\_ACEOF
+
+Optional Features:
+  --disable-FEATURE       do not include FEATURE (same as --enable-FEATURE=no)
+  --enable-FEATURE[=ARG]  include FEATURE [ARG=yes]
+  --disable-dependency-tracking  speeds up one-time build
+  --enable-dependency-tracking   do not reject slow dependency extractors
+
+Some influential environment variables:
+  CC          C compiler command
+  CFLAGS      C compiler flags
+  LDFLAGS     linker flags, e.g. -L<lib dir> if you have libraries in a
+              nonstandard directory <lib dir>
+  LIBS        libraries to pass to the linker, e.g. -l<library>
+  CPPFLAGS    C/C++/Objective C preprocessor flags, e.g. -I<include dir> if
+              you have headers in a nonstandard directory <include dir>
+  CPP         C preprocessor
+
+Use these variables to override the choices made by `configure' or to help
+it to find libraries and programs with nonstandard names/locations.
+
+_ACEOF
+ac_status=$?
+fi
+
+if test "$ac_init_help" = "recursive"; then
+  # If there are subdirs, report their specific --help.
+  for ac_dir in : $ac_subdirs_all; do test "x$ac_dir" = x: && continue
+    test -d "$ac_dir" || continue
+    ac_builddir=.
+
+case "$ac_dir" in
+.) ac_dir_suffix= ac_top_builddir_sub=. ac_top_build_prefix= ;;
+*)
+  ac_dir_suffix=/`echo "$ac_dir" | sed 's,^\.[\\/],,'`
+  # A ".." for each directory in $ac_dir_suffix.
+  ac_top_builddir_sub=`echo "$ac_dir_suffix" | sed 's,/[^\\/]*,/..,g;s,/,,'`
+  case $ac_top_builddir_sub in
+  "") ac_top_builddir_sub=. ac_top_build_prefix= ;;
+  *)  ac_top_build_prefix=$ac_top_builddir_sub/ ;;
+  esac ;;
+esac
+ac_abs_top_builddir=$ac_pwd
+ac_abs_builddir=$ac_pwd$ac_dir_suffix
+# for backward compatibility:
+ac_top_builddir=$ac_top_build_prefix
+
+case $srcdir in
+  .)  # We are building in place.
+    ac_srcdir=.
+    ac_top_srcdir=$ac_top_builddir_sub
+    ac_abs_top_srcdir=$ac_pwd ;;
+  [\\/]* | ?:[\\/]* )  # Absolute name.
+    ac_srcdir=$srcdir$ac_dir_suffix;
+    ac_top_srcdir=$srcdir
+    ac_abs_top_srcdir=$srcdir ;;
+  *) # Relative name.
+    ac_srcdir=$ac_top_build_prefix$srcdir$ac_dir_suffix
+    ac_top_srcdir=$ac_top_build_prefix$srcdir
+    ac_abs_top_srcdir=$ac_pwd/$srcdir ;;
+esac
+ac_abs_srcdir=$ac_abs_top_srcdir$ac_dir_suffix
+
+    cd "$ac_dir" || { ac_status=$?; continue; }
+    # Check for guested configure.
+    if test -f "$ac_srcdir/configure.gnu"; then
+      echo &&
+      $SHELL "$ac_srcdir/configure.gnu" --help=recursive
+    elif test -f "$ac_srcdir/configure"; then
+      echo &&
+      $SHELL "$ac_srcdir/configure" --help=recursive
+    else
+      echo "$as_me: WARNING: no configuration information is in $ac_dir" >&2
+    fi || ac_status=$?
+    cd "$ac_pwd" || { ac_status=$?; break; }
+  done
+fi
+
+test -n "$ac_init_help" && exit $ac_status
+if $ac_init_version; then
+  cat <<\_ACEOF
+configure
+generated by GNU Autoconf 2.61
+
+Copyright (C) 1992, 1993, 1994, 1995, 1996, 1998, 1999, 2000, 2001,
+2002, 2003, 2004, 2005, 2006 Free Software Foundation, Inc.
+This configure script is free software; the Free Software Foundation
+gives unlimited permission to copy, distribute and modify it.
+_ACEOF
+  exit
+fi
+cat >config.log <<_ACEOF
+This file contains any messages produced by compilers while
+running configure, to aid debugging if configure makes a mistake.
+
+It was created by $as_me, which was
+generated by GNU Autoconf 2.61.  Invocation command line was
+
+  $ $0 $@
+
+_ACEOF
+exec 5>>config.log
+{
+cat <<_ASUNAME
+## --------- ##
+## Platform. ##
+## --------- ##
+
+hostname = `(hostname || uname -n) 2>/dev/null | sed 1q`
+uname -m = `(uname -m) 2>/dev/null || echo unknown`
+uname -r = `(uname -r) 2>/dev/null || echo unknown`
+uname -s = `(uname -s) 2>/dev/null || echo unknown`
+uname -v = `(uname -v) 2>/dev/null || echo unknown`
+
+/usr/bin/uname -p = `(/usr/bin/uname -p) 2>/dev/null || echo unknown`
+/bin/uname -X     = `(/bin/uname -X) 2>/dev/null     || echo unknown`
+
+/bin/arch              = `(/bin/arch) 2>/dev/null              || echo unknown`
+/usr/bin/arch -k       = `(/usr/bin/arch -k) 2>/dev/null       || echo unknown`
+/usr/convex/getsysinfo = `(/usr/convex/getsysinfo) 2>/dev/null || echo unknown`
+/usr/bin/hostinfo      = `(/usr/bin/hostinfo) 2>/dev/null      || echo unknown`
+/bin/machine           = `(/bin/machine) 2>/dev/null           || echo unknown`
+/usr/bin/oslevel       = `(/usr/bin/oslevel) 2>/dev/null       || echo unknown`
+/bin/universe          = `(/bin/universe) 2>/dev/null          || echo unknown`
+
+_ASUNAME
+
+as_save_IFS=$IFS; IFS=$PATH_SEPARATOR
+for as_dir in $PATH
+do
+  IFS=$as_save_IFS
+  test -z "$as_dir" && as_dir=.
+  echo "PATH: $as_dir"
+done
+IFS=$as_save_IFS
+
+} >&5
+
+cat >&5 <<_ACEOF
+
+
+## ----------- ##
+## Core tests. ##
+## ----------- ##
+
+_ACEOF
+
+
+# Keep a trace of the command line.
+# Strip out --no-create and --no-recursion so they do not pile up.
+# Strip out --silent because we don't want to record it for future runs.
+# Also quote any args containing shell meta-characters.
+# Make two passes to allow for proper duplicate-argument suppression.
+ac_configure_args=
+ac_configure_args0=
+ac_configure_args1=
+ac_must_keep_next=false
+for ac_pass in 1 2
+do
+  for ac_arg
+  do
+    case $ac_arg in
+    -no-create | --no-c* | -n | -no-recursion | --no-r*) continue ;;
+    -q | -quiet | --quiet | --quie | --qui | --qu | --q \
+    | -silent | --silent | --silen | --sile | --sil)
+      continue ;;
+    *\'*)
+      ac_arg=`echo "$ac_arg" | sed "s/'/'\\\\\\\\''/g"` ;;
+    esac
+    case $ac_pass in
+    1) ac_configure_args0="$ac_configure_args0 '$ac_arg'" ;;
+    2)
+      ac_configure_args1="$ac_configure_args1 '$ac_arg'"
+      if test $ac_must_keep_next = true; then
+	ac_must_keep_next=false # Got value, back to normal.
+      else
+	case $ac_arg in
+	  *=* | --config-cache | -C | -disable-* | --disable-* \
+	  | -enable-* | --enable-* | -gas | --g* | -nfp | --nf* \
+	  | -q | -quiet | --q* | -silent | --sil* | -v | -verb* \
+	  | -with-* | --with-* | -without-* | --without-* | --x)
+	    case "$ac_configure_args0 " in
+	      "$ac_configure_args1"*" '$ac_arg' "* ) continue ;;
+	    esac
+	    ;;
+	  -* ) ac_must_keep_next=true ;;
+	esac
+      fi
+      ac_configure_args="$ac_configure_args '$ac_arg'"
+      ;;
+    esac
+  done
+done
+$as_unset ac_configure_args0 || test "${ac_configure_args0+set}" != set || { ac_configure_args0=; export ac_configure_args0; }
+$as_unset ac_configure_args1 || test "${ac_configure_args1+set}" != set || { ac_configure_args1=; export ac_configure_args1; }
+
+# When interrupted or exit'd, cleanup temporary files, and complete
+# config.log.  We remove comments because anyway the quotes in there
+# would cause problems or look ugly.
+# WARNING: Use '\'' to represent an apostrophe within the trap.
+# WARNING: Do not start the trap code with a newline, due to a FreeBSD 4.0 bug.
+trap 'exit_status=$?
+  # Save into config.log some information that might help in debugging.
+  {
+    echo
+
+    cat <<\_ASBOX
+## ---------------- ##
+## Cache variables. ##
+## ---------------- ##
+_ASBOX
+    echo
+    # The following way of writing the cache mishandles newlines in values,
+(
+  for ac_var in `(set) 2>&1 | sed -n '\''s/^\([a-zA-Z_][a-zA-Z0-9_]*\)=.*/\1/p'\''`; do
+    eval ac_val=\$$ac_var
+    case $ac_val in #(
+    *${as_nl}*)
+      case $ac_var in #(
+      *_cv_*) { echo "$as_me:$LINENO: WARNING: Cache variable $ac_var contains a newline." >&5
+echo "$as_me: WARNING: Cache variable $ac_var contains a newline." >&2;} ;;
+      esac
+      case $ac_var in #(
+      _ | IFS | as_nl) ;; #(
+      *) $as_unset $ac_var ;;
+      esac ;;
+    esac
+  done
+  (set) 2>&1 |
+    case $as_nl`(ac_space='\'' '\''; set) 2>&1` in #(
+    *${as_nl}ac_space=\ *)
+      sed -n \
+	"s/'\''/'\''\\\\'\'''\''/g;
+	  s/^\\([_$as_cr_alnum]*_cv_[_$as_cr_alnum]*\\)=\\(.*\\)/\\1='\''\\2'\''/p"
+      ;; #(
+    *)
+      sed -n "/^[_$as_cr_alnum]*_cv_[_$as_cr_alnum]*=/p"
+      ;;
+    esac |
+    sort
+)
+    echo
+
+    cat <<\_ASBOX
+## ----------------- ##
+## Output variables. ##
+## ----------------- ##
+_ASBOX
+    echo
+    for ac_var in $ac_subst_vars
+    do
+      eval ac_val=\$$ac_var
+      case $ac_val in
+      *\'\''*) ac_val=`echo "$ac_val" | sed "s/'\''/'\''\\\\\\\\'\'''\''/g"`;;
+      esac
+      echo "$ac_var='\''$ac_val'\''"
+    done | sort
+    echo
+
+    if test -n "$ac_subst_files"; then
+      cat <<\_ASBOX
+## ------------------- ##
+## File substitutions. ##
+## ------------------- ##
+_ASBOX
+      echo
+      for ac_var in $ac_subst_files
+      do
+	eval ac_val=\$$ac_var
+	case $ac_val in
+	*\'\''*) ac_val=`echo "$ac_val" | sed "s/'\''/'\''\\\\\\\\'\'''\''/g"`;;
+	esac
+	echo "$ac_var='\''$ac_val'\''"
+      done | sort
+      echo
+    fi
+
+    if test -s confdefs.h; then
+      cat <<\_ASBOX
+## ----------- ##
+## confdefs.h. ##
+## ----------- ##
+_ASBOX
+      echo
+      cat confdefs.h
+      echo
+    fi
+    test "$ac_signal" != 0 &&
+      echo "$as_me: caught signal $ac_signal"
+    echo "$as_me: exit $exit_status"
+  } >&5
+  rm -f core *.core core.conftest.* &&
+    rm -f -r conftest* confdefs* conf$$* $ac_clean_files &&
+    exit $exit_status
+' 0
+for ac_signal in 1 2 13 15; do
+  trap 'ac_signal='$ac_signal'; { (exit 1); exit 1; }' $ac_signal
+done
+ac_signal=0
+
+# confdefs.h avoids OS command line length limits that DEFS can exceed.
+rm -f -r conftest* confdefs.h
+
+# Predefined preprocessor variables.
+
+cat >>confdefs.h <<_ACEOF
+#define PACKAGE_NAME "$PACKAGE_NAME"
+_ACEOF
+
+
+cat >>confdefs.h <<_ACEOF
+#define PACKAGE_TARNAME "$PACKAGE_TARNAME"
+_ACEOF
+
+
+cat >>confdefs.h <<_ACEOF
+#define PACKAGE_VERSION "$PACKAGE_VERSION"
+_ACEOF
+
+
+cat >>confdefs.h <<_ACEOF
+#define PACKAGE_STRING "$PACKAGE_STRING"
+_ACEOF
+
+
+cat >>confdefs.h <<_ACEOF
+#define PACKAGE_BUGREPORT "$PACKAGE_BUGREPORT"
+_ACEOF
+
+
+# Let the site file select an alternate cache file if it wants to.
+# Prefer explicitly selected file to automatically selected ones.
+if test -n "$CONFIG_SITE"; then
+  set x "$CONFIG_SITE"
+elif test "x$prefix" != xNONE; then
+  set x "$prefix/share/config.site" "$prefix/etc/config.site"
+else
+  set x "$ac_default_prefix/share/config.site" \
+	"$ac_default_prefix/etc/config.site"
+fi
+shift
+for ac_site_file
+do
+  if test -r "$ac_site_file"; then
+    { echo "$as_me:$LINENO: loading site script $ac_site_file" >&5
+echo "$as_me: loading site script $ac_site_file" >&6;}
+    sed 's/^/| /' "$ac_site_file" >&5
+    . "$ac_site_file"
+  fi
+done
+
+if test -r "$cache_file"; then
+  # Some versions of bash will fail to source /dev/null (special
+  # files actually), so we avoid doing that.
+  if test -f "$cache_file"; then
+    { echo "$as_me:$LINENO: loading cache $cache_file" >&5
+echo "$as_me: loading cache $cache_file" >&6;}
+    case $cache_file in
+      [\\/]* | ?:[\\/]* ) . "$cache_file";;
+      *)                      . "./$cache_file";;
+    esac
+  fi
+else
+  { echo "$as_me:$LINENO: creating cache $cache_file" >&5
+echo "$as_me: creating cache $cache_file" >&6;}
+  >$cache_file
+fi
+
+# Check that the precious variables saved in the cache have kept the same
+# value.
+ac_cache_corrupted=false
+for ac_var in $ac_precious_vars; do
+  eval ac_old_set=\$ac_cv_env_${ac_var}_set
+  eval ac_new_set=\$ac_env_${ac_var}_set
+  eval ac_old_val=\$ac_cv_env_${ac_var}_value
+  eval ac_new_val=\$ac_env_${ac_var}_value
+  case $ac_old_set,$ac_new_set in
+    set,)
+      { echo "$as_me:$LINENO: error: \`$ac_var' was set to \`$ac_old_val' in the previous run" >&5
+echo "$as_me: error: \`$ac_var' was set to \`$ac_old_val' in the previous run" >&2;}
+      ac_cache_corrupted=: ;;
+    ,set)
+      { echo "$as_me:$LINENO: error: \`$ac_var' was not set in the previous run" >&5
+echo "$as_me: error: \`$ac_var' was not set in the previous run" >&2;}
+      ac_cache_corrupted=: ;;
+    ,);;
+    *)
+      if test "x$ac_old_val" != "x$ac_new_val"; then
+	{ echo "$as_me:$LINENO: error: \`$ac_var' has changed since the previous run:" >&5
+echo "$as_me: error: \`$ac_var' has changed since the previous run:" >&2;}
+	{ echo "$as_me:$LINENO:   former value:  $ac_old_val" >&5
+echo "$as_me:   former value:  $ac_old_val" >&2;}
+	{ echo "$as_me:$LINENO:   current value: $ac_new_val" >&5
+echo "$as_me:   current value: $ac_new_val" >&2;}
+	ac_cache_corrupted=:
+      fi;;
+  esac
+  # Pass precious variables to config.status.
+  if test "$ac_new_set" = set; then
+    case $ac_new_val in
+    *\'*) ac_arg=$ac_var=`echo "$ac_new_val" | sed "s/'/'\\\\\\\\''/g"` ;;
+    *) ac_arg=$ac_var=$ac_new_val ;;
+    esac
+    case " $ac_configure_args " in
+      *" '$ac_arg' "*) ;; # Avoid dups.  Use of quotes ensures accuracy.
+      *) ac_configure_args="$ac_configure_args '$ac_arg'" ;;
+    esac
+  fi
+done
+if $ac_cache_corrupted; then
+  { echo "$as_me:$LINENO: error: changes in the environment can compromise the build" >&5
+echo "$as_me: error: changes in the environment can compromise the build" >&2;}
+  { { echo "$as_me:$LINENO: error: run \`make distclean' and/or \`rm $cache_file' and start over" >&5
+echo "$as_me: error: run \`make distclean' and/or \`rm $cache_file' and start over" >&2;}
+   { (exit 1); exit 1; }; }
+fi
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+ac_ext=c
+ac_cpp='$CPP $CPPFLAGS'
+ac_compile='$CC -c $CFLAGS $CPPFLAGS conftest.$ac_ext >&5'
+ac_link='$CC -o conftest$ac_exeext $CFLAGS $CPPFLAGS $LDFLAGS conftest.$ac_ext $LIBS >&5'
+ac_compiler_gnu=$ac_cv_c_compiler_gnu
+
+
+am__api_version='1.10'
+
+ac_aux_dir=
+for ac_dir in "$srcdir" "$srcdir/.." "$srcdir/../.."; do
+  if test -f "$ac_dir/install-sh"; then
+    ac_aux_dir=$ac_dir
+    ac_install_sh="$ac_aux_dir/install-sh -c"
+    break
+  elif test -f "$ac_dir/install.sh"; then
+    ac_aux_dir=$ac_dir
+    ac_install_sh="$ac_aux_dir/install.sh -c"
+    break
+  elif test -f "$ac_dir/shtool"; then
+    ac_aux_dir=$ac_dir
+    ac_install_sh="$ac_aux_dir/shtool install -c"
+    break
+  fi
+done
+if test -z "$ac_aux_dir"; then
+  { { echo "$as_me:$LINENO: error: cannot find install-sh or install.sh in \"$srcdir\" \"$srcdir/..\" \"$srcdir/../..\"" >&5
+echo "$as_me: error: cannot find install-sh or install.sh in \"$srcdir\" \"$srcdir/..\" \"$srcdir/../..\"" >&2;}
+   { (exit 1); exit 1; }; }
+fi
+
+# These three variables are undocumented and unsupported,
+# and are intended to be withdrawn in a future Autoconf release.
+# They can cause serious problems if a builder's source tree is in a directory
+# whose full name contains unusual characters.
+ac_config_guess="$SHELL $ac_aux_dir/config.guess"  # Please don't use this var.
+ac_config_sub="$SHELL $ac_aux_dir/config.sub"  # Please don't use this var.
+ac_configure="$SHELL $ac_aux_dir/configure"  # Please don't use this var.
+
+
+# Find a good install program.  We prefer a C program (faster),
+# so one script is as good as another.  But avoid the broken or
+# incompatible versions:
+# SysV /etc/install, /usr/sbin/install
+# SunOS /usr/etc/install
+# IRIX /sbin/install
+# AIX /bin/install
+# AmigaOS /C/install, which installs bootblocks on floppy discs
+# AIX 4 /usr/bin/installbsd, which doesn't work without a -g flag
+# AFS /usr/afsws/bin/install, which mishandles nonexistent args
+# SVR4 /usr/ucb/install, which tries to use the nonexistent group "staff"
+# OS/2's system install, which has a completely different semantic
+# ./install, which can be erroneously created by make from ./install.sh.
+{ echo "$as_me:$LINENO: checking for a BSD-compatible install" >&5
+echo $ECHO_N "checking for a BSD-compatible install... $ECHO_C" >&6; }
+if test -z "$INSTALL"; then
+if test "${ac_cv_path_install+set}" = set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  as_save_IFS=$IFS; IFS=$PATH_SEPARATOR
+for as_dir in $PATH
+do
+  IFS=$as_save_IFS
+  test -z "$as_dir" && as_dir=.
+  # Account for people who put trailing slashes in PATH elements.
+case $as_dir/ in
+  ./ | .// | /cC/* | \
+  /etc/* | /usr/sbin/* | /usr/etc/* | /sbin/* | /usr/afsws/bin/* | \
+  ?:\\/os2\\/install\\/* | ?:\\/OS2\\/INSTALL\\/* | \
+  /usr/ucb/* ) ;;
+  *)
+    # OSF1 and SCO ODT 3.0 have their own names for install.
+    # Don't use installbsd from OSF since it installs stuff as root
+    # by default.
+    for ac_prog in ginstall scoinst install; do
+      for ac_exec_ext in '' $ac_executable_extensions; do
+	if { test -f "$as_dir/$ac_prog$ac_exec_ext" && $as_test_x "$as_dir/$ac_prog$ac_exec_ext"; }; then
+	  if test $ac_prog = install &&
+	    grep dspmsg "$as_dir/$ac_prog$ac_exec_ext" >/dev/null 2>&1; then
+	    # AIX install.  It has an incompatible calling convention.
+	    :
+	  elif test $ac_prog = install &&
+	    grep pwplus "$as_dir/$ac_prog$ac_exec_ext" >/dev/null 2>&1; then
+	    # program-specific install script used by HP pwplus--don't use.
+	    :
+	  else
+	    ac_cv_path_install="$as_dir/$ac_prog$ac_exec_ext -c"
+	    break 3
+	  fi
+	fi
+      done
+    done
+    ;;
+esac
+done
+IFS=$as_save_IFS
+
+
+fi
+  if test "${ac_cv_path_install+set}" = set; then
+    INSTALL=$ac_cv_path_install
+  else
+    # As a last resort, use the slow shell script.  Don't cache a
+    # value for INSTALL within a source directory, because that will
+    # break other packages using the cache if that directory is
+    # removed, or if the value is a relative name.
+    INSTALL=$ac_install_sh
+  fi
+fi
+{ echo "$as_me:$LINENO: result: $INSTALL" >&5
+echo "${ECHO_T}$INSTALL" >&6; }
+
+# Use test -z because SunOS4 sh mishandles braces in ${var-val}.
+# It thinks the first close brace ends the variable substitution.
+test -z "$INSTALL_PROGRAM" && INSTALL_PROGRAM='${INSTALL}'
+
+test -z "$INSTALL_SCRIPT" && INSTALL_SCRIPT='${INSTALL}'
+
+test -z "$INSTALL_DATA" && INSTALL_DATA='${INSTALL} -m 644'
+
+{ echo "$as_me:$LINENO: checking whether build environment is sane" >&5
+echo $ECHO_N "checking whether build environment is sane... $ECHO_C" >&6; }
+# Just in case
+sleep 1
+echo timestamp > conftest.file
+# Do `set' in a subshell so we don't clobber the current shell's
+# arguments.  Must try -L first in case configure is actually a
+# symlink; some systems play weird games with the mod time of symlinks
+# (eg FreeBSD returns the mod time of the symlink's containing
+# directory).
+if (
+   set X `ls -Lt $srcdir/configure conftest.file 2> /dev/null`
+   if test "$*" = "X"; then
+      # -L didn't work.
+      set X `ls -t $srcdir/configure conftest.file`
+   fi
+   rm -f conftest.file
+   if test "$*" != "X $srcdir/configure conftest.file" \
+      && test "$*" != "X conftest.file $srcdir/configure"; then
+
+      # If neither matched, then we have a broken ls.  This can happen
+      # if, for instance, CONFIG_SHELL is bash and it inherits a
+      # broken ls alias from the environment.  This has actually
+      # happened.  Such a system could not be considered "sane".
+      { { echo "$as_me:$LINENO: error: ls -t appears to fail.  Make sure there is not a broken
+alias in your environment" >&5
+echo "$as_me: error: ls -t appears to fail.  Make sure there is not a broken
+alias in your environment" >&2;}
+   { (exit 1); exit 1; }; }
+   fi
+
+   test "$2" = conftest.file
+   )
+then
+   # Ok.
+   :
+else
+   { { echo "$as_me:$LINENO: error: newly created file is older than distributed files!
+Check your system clock" >&5
+echo "$as_me: error: newly created file is older than distributed files!
+Check your system clock" >&2;}
+   { (exit 1); exit 1; }; }
+fi
+{ echo "$as_me:$LINENO: result: yes" >&5
+echo "${ECHO_T}yes" >&6; }
+test "$program_prefix" != NONE &&
+  program_transform_name="s&^&$program_prefix&;$program_transform_name"
+# Use a double $ so make ignores it.
+test "$program_suffix" != NONE &&
+  program_transform_name="s&\$&$program_suffix&;$program_transform_name"
+# Double any \ or $.  echo might interpret backslashes.
+# By default was `s,x,x', remove it if useless.
+cat <<\_ACEOF >conftest.sed
+s/[\\$]/&&/g;s/;s,x,x,$//
+_ACEOF
+program_transform_name=`echo $program_transform_name | sed -f conftest.sed`
+rm -f conftest.sed
+
+# expand $ac_aux_dir to an absolute path
+am_aux_dir=`cd $ac_aux_dir && pwd`
+
+test x"${MISSING+set}" = xset || MISSING="\${SHELL} $am_aux_dir/missing"
+# Use eval to expand $SHELL
+if eval "$MISSING --run true"; then
+  am_missing_run="$MISSING --run "
+else
+  am_missing_run=
+  { echo "$as_me:$LINENO: WARNING: \`missing' script is too old or missing" >&5
+echo "$as_me: WARNING: \`missing' script is too old or missing" >&2;}
+fi
+
+{ echo "$as_me:$LINENO: checking for a thread-safe mkdir -p" >&5
+echo $ECHO_N "checking for a thread-safe mkdir -p... $ECHO_C" >&6; }
+if test -z "$MKDIR_P"; then
+  if test "${ac_cv_path_mkdir+set}" = set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  as_save_IFS=$IFS; IFS=$PATH_SEPARATOR
+for as_dir in $PATH$PATH_SEPARATOR/opt/sfw/bin
+do
+  IFS=$as_save_IFS
+  test -z "$as_dir" && as_dir=.
+  for ac_prog in mkdir gmkdir; do
+	 for ac_exec_ext in '' $ac_executable_extensions; do
+	   { test -f "$as_dir/$ac_prog$ac_exec_ext" && $as_test_x "$as_dir/$ac_prog$ac_exec_ext"; } || continue
+	   case `"$as_dir/$ac_prog$ac_exec_ext" --version 2>&1` in #(
+	     'mkdir (GNU coreutils) '* | \
+	     'mkdir (coreutils) '* | \
+	     'mkdir (fileutils) '4.1*)
+	       ac_cv_path_mkdir=$as_dir/$ac_prog$ac_exec_ext
+	       break 3;;
+	   esac
+	 done
+       done
+done
+IFS=$as_save_IFS
+
+fi
+
+  if test "${ac_cv_path_mkdir+set}" = set; then
+    MKDIR_P="$ac_cv_path_mkdir -p"
+  else
+    # As a last resort, use the slow shell script.  Don't cache a
+    # value for MKDIR_P within a source directory, because that will
+    # break other packages using the cache if that directory is
+    # removed, or if the value is a relative name.
+    test -d ./--version && rmdir ./--version
+    MKDIR_P="$ac_install_sh -d"
+  fi
+fi
+{ echo "$as_me:$LINENO: result: $MKDIR_P" >&5
+echo "${ECHO_T}$MKDIR_P" >&6; }
+
+mkdir_p="$MKDIR_P"
+case $mkdir_p in
+  [\\/$]* | ?:[\\/]*) ;;
+  */*) mkdir_p="\$(top_builddir)/$mkdir_p" ;;
+esac
+
+for ac_prog in gawk mawk nawk awk
+do
+  # Extract the first word of "$ac_prog", so it can be a program name with args.
+set dummy $ac_prog; ac_word=$2
+{ echo "$as_me:$LINENO: checking for $ac_word" >&5
+echo $ECHO_N "checking for $ac_word... $ECHO_C" >&6; }
+if test "${ac_cv_prog_AWK+set}" = set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  if test -n "$AWK"; then
+  ac_cv_prog_AWK="$AWK" # Let the user override the test.
+else
+as_save_IFS=$IFS; IFS=$PATH_SEPARATOR
+for as_dir in $PATH
+do
+  IFS=$as_save_IFS
+  test -z "$as_dir" && as_dir=.
+  for ac_exec_ext in '' $ac_executable_extensions; do
+  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_word$ac_exec_ext"; }; then
+    ac_cv_prog_AWK="$ac_prog"
+    echo "$as_me:$LINENO: found $as_dir/$ac_word$ac_exec_ext" >&5
+    break 2
+  fi
+done
+done
+IFS=$as_save_IFS
+
+fi
+fi
+AWK=$ac_cv_prog_AWK
+if test -n "$AWK"; then
+  { echo "$as_me:$LINENO: result: $AWK" >&5
+echo "${ECHO_T}$AWK" >&6; }
+else
+  { echo "$as_me:$LINENO: result: no" >&5
+echo "${ECHO_T}no" >&6; }
+fi
+
+
+  test -n "$AWK" && break
+done
+
+{ echo "$as_me:$LINENO: checking whether ${MAKE-make} sets \$(MAKE)" >&5
+echo $ECHO_N "checking whether ${MAKE-make} sets \$(MAKE)... $ECHO_C" >&6; }
+set x ${MAKE-make}; ac_make=`echo "$2" | sed 's/+/p/g; s/[^a-zA-Z0-9_]/_/g'`
+if { as_var=ac_cv_prog_make_${ac_make}_set; eval "test \"\${$as_var+set}\" = set"; }; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  cat >conftest.make <<\_ACEOF
+SHELL = /bin/sh
+all:
+	@echo '@@@%%%=$(MAKE)=@@@%%%'
+_ACEOF
+# GNU make sometimes prints "make[1]: Entering...", which would confuse us.
+case `${MAKE-make} -f conftest.make 2>/dev/null` in
+  *@@@%%%=?*=@@@%%%*)
+    eval ac_cv_prog_make_${ac_make}_set=yes;;
+  *)
+    eval ac_cv_prog_make_${ac_make}_set=no;;
+esac
+rm -f conftest.make
+fi
+if eval test \$ac_cv_prog_make_${ac_make}_set = yes; then
+  { echo "$as_me:$LINENO: result: yes" >&5
+echo "${ECHO_T}yes" >&6; }
+  SET_MAKE=
+else
+  { echo "$as_me:$LINENO: result: no" >&5
+echo "${ECHO_T}no" >&6; }
+  SET_MAKE="MAKE=${MAKE-make}"
+fi
+
+rm -rf .tst 2>/dev/null
+mkdir .tst 2>/dev/null
+if test -d .tst; then
+  am__leading_dot=.
+else
+  am__leading_dot=_
+fi
+rmdir .tst 2>/dev/null
+
+if test "`cd $srcdir && pwd`" != "`pwd`"; then
+  # Use -I$(srcdir) only when $(srcdir) != ., so that make's output
+  # is not polluted with repeated "-I."
+  am__isrc=' -I$(srcdir)'
+  # test to see if srcdir already configured
+  if test -f $srcdir/config.status; then
+    { { echo "$as_me:$LINENO: error: source directory already configured; run \"make distclean\" there first" >&5
+echo "$as_me: error: source directory already configured; run \"make distclean\" there first" >&2;}
+   { (exit 1); exit 1; }; }
+  fi
+fi
+
+# test whether we have cygpath
+if test -z "$CYGPATH_W"; then
+  if (cygpath --version) >/dev/null 2>/dev/null; then
+    CYGPATH_W='cygpath -w'
+  else
+    CYGPATH_W=echo
+  fi
+fi
+
+
+# Define the identity of the package.
+ PACKAGE=ffsb
+ VERSION=6.0-RC2
+
+
+cat >>confdefs.h <<_ACEOF
+#define PACKAGE "$PACKAGE"
+_ACEOF
+
+
+cat >>confdefs.h <<_ACEOF
+#define VERSION "$VERSION"
+_ACEOF
+
+# Some tools Automake needs.
+
+ACLOCAL=${ACLOCAL-"${am_missing_run}aclocal-${am__api_version}"}
+
+
+AUTOCONF=${AUTOCONF-"${am_missing_run}autoconf"}
+
+
+AUTOMAKE=${AUTOMAKE-"${am_missing_run}automake-${am__api_version}"}
+
+
+AUTOHEADER=${AUTOHEADER-"${am_missing_run}autoheader"}
+
+
+MAKEINFO=${MAKEINFO-"${am_missing_run}makeinfo"}
+
+install_sh=${install_sh-"\$(SHELL) $am_aux_dir/install-sh"}
+
+# Installed binaries are usually stripped using `strip' when the user
+# run `make install-strip'.  However `strip' might not be the right
+# tool to use in cross-compilation environments, therefore Automake
+# will honor the `STRIP' environment variable to overrule this program.
+if test "$cross_compiling" != no; then
+  if test -n "$ac_tool_prefix"; then
+  # Extract the first word of "${ac_tool_prefix}strip", so it can be a program name with args.
+set dummy ${ac_tool_prefix}strip; ac_word=$2
+{ echo "$as_me:$LINENO: checking for $ac_word" >&5
+echo $ECHO_N "checking for $ac_word... $ECHO_C" >&6; }
+if test "${ac_cv_prog_STRIP+set}" = set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  if test -n "$STRIP"; then
+  ac_cv_prog_STRIP="$STRIP" # Let the user override the test.
+else
+as_save_IFS=$IFS; IFS=$PATH_SEPARATOR
+for as_dir in $PATH
+do
+  IFS=$as_save_IFS
+  test -z "$as_dir" && as_dir=.
+  for ac_exec_ext in '' $ac_executable_extensions; do
+  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_word$ac_exec_ext"; }; then
+    ac_cv_prog_STRIP="${ac_tool_prefix}strip"
+    echo "$as_me:$LINENO: found $as_dir/$ac_word$ac_exec_ext" >&5
+    break 2
+  fi
+done
+done
+IFS=$as_save_IFS
+
+fi
+fi
+STRIP=$ac_cv_prog_STRIP
+if test -n "$STRIP"; then
+  { echo "$as_me:$LINENO: result: $STRIP" >&5
+echo "${ECHO_T}$STRIP" >&6; }
+else
+  { echo "$as_me:$LINENO: result: no" >&5
+echo "${ECHO_T}no" >&6; }
+fi
+
+
+fi
+if test -z "$ac_cv_prog_STRIP"; then
+  ac_ct_STRIP=$STRIP
+  # Extract the first word of "strip", so it can be a program name with args.
+set dummy strip; ac_word=$2
+{ echo "$as_me:$LINENO: checking for $ac_word" >&5
+echo $ECHO_N "checking for $ac_word... $ECHO_C" >&6; }
+if test "${ac_cv_prog_ac_ct_STRIP+set}" = set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  if test -n "$ac_ct_STRIP"; then
+  ac_cv_prog_ac_ct_STRIP="$ac_ct_STRIP" # Let the user override the test.
+else
+as_save_IFS=$IFS; IFS=$PATH_SEPARATOR
+for as_dir in $PATH
+do
+  IFS=$as_save_IFS
+  test -z "$as_dir" && as_dir=.
+  for ac_exec_ext in '' $ac_executable_extensions; do
+  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_word$ac_exec_ext"; }; then
+    ac_cv_prog_ac_ct_STRIP="strip"
+    echo "$as_me:$LINENO: found $as_dir/$ac_word$ac_exec_ext" >&5
+    break 2
+  fi
+done
+done
+IFS=$as_save_IFS
+
+fi
+fi
+ac_ct_STRIP=$ac_cv_prog_ac_ct_STRIP
+if test -n "$ac_ct_STRIP"; then
+  { echo "$as_me:$LINENO: result: $ac_ct_STRIP" >&5
+echo "${ECHO_T}$ac_ct_STRIP" >&6; }
+else
+  { echo "$as_me:$LINENO: result: no" >&5
+echo "${ECHO_T}no" >&6; }
+fi
+
+  if test "x$ac_ct_STRIP" = x; then
+    STRIP=":"
+  else
+    case $cross_compiling:$ac_tool_warned in
+yes:)
+{ echo "$as_me:$LINENO: WARNING: In the future, Autoconf will not detect cross-tools
+whose name does not start with the host triplet.  If you think this
+configuration is useful to you, please write to autoconf@gnu.org." >&5
+echo "$as_me: WARNING: In the future, Autoconf will not detect cross-tools
+whose name does not start with the host triplet.  If you think this
+configuration is useful to you, please write to autoconf@gnu.org." >&2;}
+ac_tool_warned=yes ;;
+esac
+    STRIP=$ac_ct_STRIP
+  fi
+else
+  STRIP="$ac_cv_prog_STRIP"
+fi
+
+fi
+INSTALL_STRIP_PROGRAM="\$(install_sh) -c -s"
+
+# We need awk for the "check" target.  The system "awk" is bad on
+# some platforms.
+# Always define AMTAR for backward compatibility.
+
+AMTAR=${AMTAR-"${am_missing_run}tar"}
+
+am__tar='${AMTAR} chof - "$$tardir"'; am__untar='${AMTAR} xf -'
+
+
+
+
+
+
+ac_config_headers="$ac_config_headers config.h"
+
+# Make sure we can run config.sub.
+$SHELL "$ac_aux_dir/config.sub" sun4 >/dev/null 2>&1 ||
+  { { echo "$as_me:$LINENO: error: cannot run $SHELL $ac_aux_dir/config.sub" >&5
+echo "$as_me: error: cannot run $SHELL $ac_aux_dir/config.sub" >&2;}
+   { (exit 1); exit 1; }; }
+
+{ echo "$as_me:$LINENO: checking build system type" >&5
+echo $ECHO_N "checking build system type... $ECHO_C" >&6; }
+if test "${ac_cv_build+set}" = set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  ac_build_alias=$build_alias
+test "x$ac_build_alias" = x &&
+  ac_build_alias=`$SHELL "$ac_aux_dir/config.guess"`
+test "x$ac_build_alias" = x &&
+  { { echo "$as_me:$LINENO: error: cannot guess build type; you must specify one" >&5
+echo "$as_me: error: cannot guess build type; you must specify one" >&2;}
+   { (exit 1); exit 1; }; }
+ac_cv_build=`$SHELL "$ac_aux_dir/config.sub" $ac_build_alias` ||
+  { { echo "$as_me:$LINENO: error: $SHELL $ac_aux_dir/config.sub $ac_build_alias failed" >&5
+echo "$as_me: error: $SHELL $ac_aux_dir/config.sub $ac_build_alias failed" >&2;}
+   { (exit 1); exit 1; }; }
+
+fi
+{ echo "$as_me:$LINENO: result: $ac_cv_build" >&5
+echo "${ECHO_T}$ac_cv_build" >&6; }
+case $ac_cv_build in
+*-*-*) ;;
+*) { { echo "$as_me:$LINENO: error: invalid value of canonical build" >&5
+echo "$as_me: error: invalid value of canonical build" >&2;}
+   { (exit 1); exit 1; }; };;
+esac
+build=$ac_cv_build
+ac_save_IFS=$IFS; IFS='-'
+set x $ac_cv_build
+shift
+build_cpu=$1
+build_vendor=$2
+shift; shift
+# Remember, the first character of IFS is used to create $*,
+# except with old shells:
+build_os=$*
+IFS=$ac_save_IFS
+case $build_os in *\ *) build_os=`echo "$build_os" | sed 's/ /-/g'`;; esac
+
+
+{ echo "$as_me:$LINENO: checking host system type" >&5
+echo $ECHO_N "checking host system type... $ECHO_C" >&6; }
+if test "${ac_cv_host+set}" = set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  if test "x$host_alias" = x; then
+  ac_cv_host=$ac_cv_build
+else
+  ac_cv_host=`$SHELL "$ac_aux_dir/config.sub" $host_alias` ||
+    { { echo "$as_me:$LINENO: error: $SHELL $ac_aux_dir/config.sub $host_alias failed" >&5
+echo "$as_me: error: $SHELL $ac_aux_dir/config.sub $host_alias failed" >&2;}
+   { (exit 1); exit 1; }; }
+fi
+
+fi
+{ echo "$as_me:$LINENO: result: $ac_cv_host" >&5
+echo "${ECHO_T}$ac_cv_host" >&6; }
+case $ac_cv_host in
+*-*-*) ;;
+*) { { echo "$as_me:$LINENO: error: invalid value of canonical host" >&5
+echo "$as_me: error: invalid value of canonical host" >&2;}
+   { (exit 1); exit 1; }; };;
+esac
+host=$ac_cv_host
+ac_save_IFS=$IFS; IFS='-'
+set x $ac_cv_host
+shift
+host_cpu=$1
+host_vendor=$2
+shift; shift
+# Remember, the first character of IFS is used to create $*,
+# except with old shells:
+host_os=$*
+IFS=$ac_save_IFS
+case $host_os in *\ *) host_os=`echo "$host_os" | sed 's/ /-/g'`;; esac
+
+
+
+DEPDIR="${am__leading_dot}deps"
+
+ac_config_commands="$ac_config_commands depfiles"
+
+
+am_make=${MAKE-make}
+cat > confinc << 'END'
+am__doit:
+	@echo done
+.PHONY: am__doit
+END
+# If we don't find an include directive, just comment out the code.
+{ echo "$as_me:$LINENO: checking for style of include used by $am_make" >&5
+echo $ECHO_N "checking for style of include used by $am_make... $ECHO_C" >&6; }
+am__include="#"
+am__quote=
+_am_result=none
+# First try GNU make style include.
+echo "include confinc" > confmf
+# We grep out `Entering directory' and `Leaving directory'
+# messages which can occur if `w' ends up in MAKEFLAGS.
+# In particular we don't look at `^make:' because GNU make might
+# be invoked under some other name (usually "gmake"), in which
+# case it prints its new name instead of `make'.
+if test "`$am_make -s -f confmf 2> /dev/null | grep -v 'ing directory'`" = "done"; then
+   am__include=include
+   am__quote=
+   _am_result=GNU
+fi
+# Now try BSD make style include.
+if test "$am__include" = "#"; then
+   echo '.include "confinc"' > confmf
+   if test "`$am_make -s -f confmf 2> /dev/null`" = "done"; then
+      am__include=.include
+      am__quote="\""
+      _am_result=BSD
+   fi
+fi
+
+
+{ echo "$as_me:$LINENO: result: $_am_result" >&5
+echo "${ECHO_T}$_am_result" >&6; }
+rm -f confinc confmf
+
+# Check whether --enable-dependency-tracking was given.
+if test "${enable_dependency_tracking+set}" = set; then
+  enableval=$enable_dependency_tracking;
+fi
+
+if test "x$enable_dependency_tracking" != xno; then
+  am_depcomp="$ac_aux_dir/depcomp"
+  AMDEPBACKSLASH='\'
+fi
+ if test "x$enable_dependency_tracking" != xno; then
+  AMDEP_TRUE=
+  AMDEP_FALSE='#'
+else
+  AMDEP_TRUE='#'
+  AMDEP_FALSE=
+fi
+
+
+ac_ext=c
+ac_cpp='$CPP $CPPFLAGS'
+ac_compile='$CC -c $CFLAGS $CPPFLAGS conftest.$ac_ext >&5'
+ac_link='$CC -o conftest$ac_exeext $CFLAGS $CPPFLAGS $LDFLAGS conftest.$ac_ext $LIBS >&5'
+ac_compiler_gnu=$ac_cv_c_compiler_gnu
+if test -n "$ac_tool_prefix"; then
+  # Extract the first word of "${ac_tool_prefix}gcc", so it can be a program name with args.
+set dummy ${ac_tool_prefix}gcc; ac_word=$2
+{ echo "$as_me:$LINENO: checking for $ac_word" >&5
+echo $ECHO_N "checking for $ac_word... $ECHO_C" >&6; }
+if test "${ac_cv_prog_CC+set}" = set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  if test -n "$CC"; then
+  ac_cv_prog_CC="$CC" # Let the user override the test.
+else
+as_save_IFS=$IFS; IFS=$PATH_SEPARATOR
+for as_dir in $PATH
+do
+  IFS=$as_save_IFS
+  test -z "$as_dir" && as_dir=.
+  for ac_exec_ext in '' $ac_executable_extensions; do
+  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_word$ac_exec_ext"; }; then
+    ac_cv_prog_CC="${ac_tool_prefix}gcc"
+    echo "$as_me:$LINENO: found $as_dir/$ac_word$ac_exec_ext" >&5
+    break 2
+  fi
+done
+done
+IFS=$as_save_IFS
+
+fi
+fi
+CC=$ac_cv_prog_CC
+if test -n "$CC"; then
+  { echo "$as_me:$LINENO: result: $CC" >&5
+echo "${ECHO_T}$CC" >&6; }
+else
+  { echo "$as_me:$LINENO: result: no" >&5
+echo "${ECHO_T}no" >&6; }
+fi
+
+
+fi
+if test -z "$ac_cv_prog_CC"; then
+  ac_ct_CC=$CC
+  # Extract the first word of "gcc", so it can be a program name with args.
+set dummy gcc; ac_word=$2
+{ echo "$as_me:$LINENO: checking for $ac_word" >&5
+echo $ECHO_N "checking for $ac_word... $ECHO_C" >&6; }
+if test "${ac_cv_prog_ac_ct_CC+set}" = set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  if test -n "$ac_ct_CC"; then
+  ac_cv_prog_ac_ct_CC="$ac_ct_CC" # Let the user override the test.
+else
+as_save_IFS=$IFS; IFS=$PATH_SEPARATOR
+for as_dir in $PATH
+do
+  IFS=$as_save_IFS
+  test -z "$as_dir" && as_dir=.
+  for ac_exec_ext in '' $ac_executable_extensions; do
+  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_word$ac_exec_ext"; }; then
+    ac_cv_prog_ac_ct_CC="gcc"
+    echo "$as_me:$LINENO: found $as_dir/$ac_word$ac_exec_ext" >&5
+    break 2
+  fi
+done
+done
+IFS=$as_save_IFS
+
+fi
+fi
+ac_ct_CC=$ac_cv_prog_ac_ct_CC
+if test -n "$ac_ct_CC"; then
+  { echo "$as_me:$LINENO: result: $ac_ct_CC" >&5
+echo "${ECHO_T}$ac_ct_CC" >&6; }
+else
+  { echo "$as_me:$LINENO: result: no" >&5
+echo "${ECHO_T}no" >&6; }
+fi
+
+  if test "x$ac_ct_CC" = x; then
+    CC=""
+  else
+    case $cross_compiling:$ac_tool_warned in
+yes:)
+{ echo "$as_me:$LINENO: WARNING: In the future, Autoconf will not detect cross-tools
+whose name does not start with the host triplet.  If you think this
+configuration is useful to you, please write to autoconf@gnu.org." >&5
+echo "$as_me: WARNING: In the future, Autoconf will not detect cross-tools
+whose name does not start with the host triplet.  If you think this
+configuration is useful to you, please write to autoconf@gnu.org." >&2;}
+ac_tool_warned=yes ;;
+esac
+    CC=$ac_ct_CC
+  fi
+else
+  CC="$ac_cv_prog_CC"
+fi
+
+if test -z "$CC"; then
+          if test -n "$ac_tool_prefix"; then
+    # Extract the first word of "${ac_tool_prefix}cc", so it can be a program name with args.
+set dummy ${ac_tool_prefix}cc; ac_word=$2
+{ echo "$as_me:$LINENO: checking for $ac_word" >&5
+echo $ECHO_N "checking for $ac_word... $ECHO_C" >&6; }
+if test "${ac_cv_prog_CC+set}" = set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  if test -n "$CC"; then
+  ac_cv_prog_CC="$CC" # Let the user override the test.
+else
+as_save_IFS=$IFS; IFS=$PATH_SEPARATOR
+for as_dir in $PATH
+do
+  IFS=$as_save_IFS
+  test -z "$as_dir" && as_dir=.
+  for ac_exec_ext in '' $ac_executable_extensions; do
+  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_word$ac_exec_ext"; }; then
+    ac_cv_prog_CC="${ac_tool_prefix}cc"
+    echo "$as_me:$LINENO: found $as_dir/$ac_word$ac_exec_ext" >&5
+    break 2
+  fi
+done
+done
+IFS=$as_save_IFS
+
+fi
+fi
+CC=$ac_cv_prog_CC
+if test -n "$CC"; then
+  { echo "$as_me:$LINENO: result: $CC" >&5
+echo "${ECHO_T}$CC" >&6; }
+else
+  { echo "$as_me:$LINENO: result: no" >&5
+echo "${ECHO_T}no" >&6; }
+fi
+
+
+  fi
+fi
+if test -z "$CC"; then
+  # Extract the first word of "cc", so it can be a program name with args.
+set dummy cc; ac_word=$2
+{ echo "$as_me:$LINENO: checking for $ac_word" >&5
+echo $ECHO_N "checking for $ac_word... $ECHO_C" >&6; }
+if test "${ac_cv_prog_CC+set}" = set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  if test -n "$CC"; then
+  ac_cv_prog_CC="$CC" # Let the user override the test.
+else
+  ac_prog_rejected=no
+as_save_IFS=$IFS; IFS=$PATH_SEPARATOR
+for as_dir in $PATH
+do
+  IFS=$as_save_IFS
+  test -z "$as_dir" && as_dir=.
+  for ac_exec_ext in '' $ac_executable_extensions; do
+  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_word$ac_exec_ext"; }; then
+    if test "$as_dir/$ac_word$ac_exec_ext" = "/usr/ucb/cc"; then
+       ac_prog_rejected=yes
+       continue
+     fi
+    ac_cv_prog_CC="cc"
+    echo "$as_me:$LINENO: found $as_dir/$ac_word$ac_exec_ext" >&5
+    break 2
+  fi
+done
+done
+IFS=$as_save_IFS
+
+if test $ac_prog_rejected = yes; then
+  # We found a bogon in the path, so make sure we never use it.
+  set dummy $ac_cv_prog_CC
+  shift
+  if test $# != 0; then
+    # We chose a different compiler from the bogus one.
+    # However, it has the same basename, so the bogon will be chosen
+    # first if we set CC to just the basename; use the full file name.
+    shift
+    ac_cv_prog_CC="$as_dir/$ac_word${1+' '}$@"
+  fi
+fi
+fi
+fi
+CC=$ac_cv_prog_CC
+if test -n "$CC"; then
+  { echo "$as_me:$LINENO: result: $CC" >&5
+echo "${ECHO_T}$CC" >&6; }
+else
+  { echo "$as_me:$LINENO: result: no" >&5
+echo "${ECHO_T}no" >&6; }
+fi
+
+
+fi
+if test -z "$CC"; then
+  if test -n "$ac_tool_prefix"; then
+  for ac_prog in cl.exe
+  do
+    # Extract the first word of "$ac_tool_prefix$ac_prog", so it can be a program name with args.
+set dummy $ac_tool_prefix$ac_prog; ac_word=$2
+{ echo "$as_me:$LINENO: checking for $ac_word" >&5
+echo $ECHO_N "checking for $ac_word... $ECHO_C" >&6; }
+if test "${ac_cv_prog_CC+set}" = set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  if test -n "$CC"; then
+  ac_cv_prog_CC="$CC" # Let the user override the test.
+else
+as_save_IFS=$IFS; IFS=$PATH_SEPARATOR
+for as_dir in $PATH
+do
+  IFS=$as_save_IFS
+  test -z "$as_dir" && as_dir=.
+  for ac_exec_ext in '' $ac_executable_extensions; do
+  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_word$ac_exec_ext"; }; then
+    ac_cv_prog_CC="$ac_tool_prefix$ac_prog"
+    echo "$as_me:$LINENO: found $as_dir/$ac_word$ac_exec_ext" >&5
+    break 2
+  fi
+done
+done
+IFS=$as_save_IFS
+
+fi
+fi
+CC=$ac_cv_prog_CC
+if test -n "$CC"; then
+  { echo "$as_me:$LINENO: result: $CC" >&5
+echo "${ECHO_T}$CC" >&6; }
+else
+  { echo "$as_me:$LINENO: result: no" >&5
+echo "${ECHO_T}no" >&6; }
+fi
+
+
+    test -n "$CC" && break
+  done
+fi
+if test -z "$CC"; then
+  ac_ct_CC=$CC
+  for ac_prog in cl.exe
+do
+  # Extract the first word of "$ac_prog", so it can be a program name with args.
+set dummy $ac_prog; ac_word=$2
+{ echo "$as_me:$LINENO: checking for $ac_word" >&5
+echo $ECHO_N "checking for $ac_word... $ECHO_C" >&6; }
+if test "${ac_cv_prog_ac_ct_CC+set}" = set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  if test -n "$ac_ct_CC"; then
+  ac_cv_prog_ac_ct_CC="$ac_ct_CC" # Let the user override the test.
+else
+as_save_IFS=$IFS; IFS=$PATH_SEPARATOR
+for as_dir in $PATH
+do
+  IFS=$as_save_IFS
+  test -z "$as_dir" && as_dir=.
+  for ac_exec_ext in '' $ac_executable_extensions; do
+  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_word$ac_exec_ext"; }; then
+    ac_cv_prog_ac_ct_CC="$ac_prog"
+    echo "$as_me:$LINENO: found $as_dir/$ac_word$ac_exec_ext" >&5
+    break 2
+  fi
+done
+done
+IFS=$as_save_IFS
+
+fi
+fi
+ac_ct_CC=$ac_cv_prog_ac_ct_CC
+if test -n "$ac_ct_CC"; then
+  { echo "$as_me:$LINENO: result: $ac_ct_CC" >&5
+echo "${ECHO_T}$ac_ct_CC" >&6; }
+else
+  { echo "$as_me:$LINENO: result: no" >&5
+echo "${ECHO_T}no" >&6; }
+fi
+
+
+  test -n "$ac_ct_CC" && break
+done
+
+  if test "x$ac_ct_CC" = x; then
+    CC=""
+  else
+    case $cross_compiling:$ac_tool_warned in
+yes:)
+{ echo "$as_me:$LINENO: WARNING: In the future, Autoconf will not detect cross-tools
+whose name does not start with the host triplet.  If you think this
+configuration is useful to you, please write to autoconf@gnu.org." >&5
+echo "$as_me: WARNING: In the future, Autoconf will not detect cross-tools
+whose name does not start with the host triplet.  If you think this
+configuration is useful to you, please write to autoconf@gnu.org." >&2;}
+ac_tool_warned=yes ;;
+esac
+    CC=$ac_ct_CC
+  fi
+fi
+
+fi
+
+
+test -z "$CC" && { { echo "$as_me:$LINENO: error: no acceptable C compiler found in \$PATH
+See \`config.log' for more details." >&5
+echo "$as_me: error: no acceptable C compiler found in \$PATH
+See \`config.log' for more details." >&2;}
+   { (exit 1); exit 1; }; }
+
+# Provide some information about the compiler.
+echo "$as_me:$LINENO: checking for C compiler version" >&5
+ac_compiler=`set X $ac_compile; echo $2`
+{ (ac_try="$ac_compiler --version >&5"
+case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=\$ac_try;;
+  *) ac_try_echo=$ac_try;;
+esac
+eval "echo \"\$as_me:$LINENO: $ac_try_echo\"") >&5
+  (eval "$ac_compiler --version >&5") 2>&5
+  ac_status=$?
+  echo "$as_me:$LINENO: \$? = $ac_status" >&5
+  (exit $ac_status); }
+{ (ac_try="$ac_compiler -v >&5"
+case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=\$ac_try;;
+  *) ac_try_echo=$ac_try;;
+esac
+eval "echo \"\$as_me:$LINENO: $ac_try_echo\"") >&5
+  (eval "$ac_compiler -v >&5") 2>&5
+  ac_status=$?
+  echo "$as_me:$LINENO: \$? = $ac_status" >&5
+  (exit $ac_status); }
+{ (ac_try="$ac_compiler -V >&5"
+case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=\$ac_try;;
+  *) ac_try_echo=$ac_try;;
+esac
+eval "echo \"\$as_me:$LINENO: $ac_try_echo\"") >&5
+  (eval "$ac_compiler -V >&5") 2>&5
+  ac_status=$?
+  echo "$as_me:$LINENO: \$? = $ac_status" >&5
+  (exit $ac_status); }
+
+cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+
+int
+main ()
+{
+
+  ;
+  return 0;
+}
+_ACEOF
+ac_clean_files_save=$ac_clean_files
+ac_clean_files="$ac_clean_files a.out a.exe b.out"
+# Try to create an executable without -o first, disregard a.out.
+# It will help us diagnose broken compilers, and finding out an intuition
+# of exeext.
+{ echo "$as_me:$LINENO: checking for C compiler default output file name" >&5
+echo $ECHO_N "checking for C compiler default output file name... $ECHO_C" >&6; }
+ac_link_default=`echo "$ac_link" | sed 's/ -o *conftest[^ ]*//'`
+#
+# List of possible output files, starting from the most likely.
+# The algorithm is not robust to junk in `.', hence go to wildcards (a.*)
+# only as a last resort.  b.out is created by i960 compilers.
+ac_files='a_out.exe a.exe conftest.exe a.out conftest a.* conftest.* b.out'
+#
+# The IRIX 6 linker writes into existing files which may not be
+# executable, retaining their permissions.  Remove them first so a
+# subsequent execution test works.
+ac_rmfiles=
+for ac_file in $ac_files
+do
+  case $ac_file in
+    *.$ac_ext | *.xcoff | *.tds | *.d | *.pdb | *.xSYM | *.bb | *.bbg | *.map | *.inf | *.o | *.obj ) ;;
+    * ) ac_rmfiles="$ac_rmfiles $ac_file";;
+  esac
+done
+rm -f $ac_rmfiles
+
+if { (ac_try="$ac_link_default"
+case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=\$ac_try;;
+  *) ac_try_echo=$ac_try;;
+esac
+eval "echo \"\$as_me:$LINENO: $ac_try_echo\"") >&5
+  (eval "$ac_link_default") 2>&5
+  ac_status=$?
+  echo "$as_me:$LINENO: \$? = $ac_status" >&5
+  (exit $ac_status); }; then
+  # Autoconf-2.13 could set the ac_cv_exeext variable to `no'.
+# So ignore a value of `no', otherwise this would lead to `EXEEXT = no'
+# in a Makefile.  We should not override ac_cv_exeext if it was cached,
+# so that the user can short-circuit this test for compilers unknown to
+# Autoconf.
+for ac_file in $ac_files ''
+do
+  test -f "$ac_file" || continue
+  case $ac_file in
+    *.$ac_ext | *.xcoff | *.tds | *.d | *.pdb | *.xSYM | *.bb | *.bbg | *.map | *.inf | *.o | *.obj )
+	;;
+    [ab].out )
+	# We found the default executable, but exeext='' is most
+	# certainly right.
+	break;;
+    *.* )
+        if test "${ac_cv_exeext+set}" = set && test "$ac_cv_exeext" != no;
+	then :; else
+	   ac_cv_exeext=`expr "$ac_file" : '[^.]*\(\..*\)'`
+	fi
+	# We set ac_cv_exeext here because the later test for it is not
+	# safe: cross compilers may not add the suffix if given an `-o'
+	# argument, so we may need to know it at that point already.
+	# Even if this section looks crufty: it has the advantage of
+	# actually working.
+	break;;
+    * )
+	break;;
+  esac
+done
+test "$ac_cv_exeext" = no && ac_cv_exeext=
+
+else
+  ac_file=''
+fi
+
+{ echo "$as_me:$LINENO: result: $ac_file" >&5
+echo "${ECHO_T}$ac_file" >&6; }
+if test -z "$ac_file"; then
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+{ { echo "$as_me:$LINENO: error: C compiler cannot create executables
+See \`config.log' for more details." >&5
+echo "$as_me: error: C compiler cannot create executables
+See \`config.log' for more details." >&2;}
+   { (exit 77); exit 77; }; }
+fi
+
+ac_exeext=$ac_cv_exeext
+
+# Check that the compiler produces executables we can run.  If not, either
+# the compiler is broken, or we cross compile.
+{ echo "$as_me:$LINENO: checking whether the C compiler works" >&5
+echo $ECHO_N "checking whether the C compiler works... $ECHO_C" >&6; }
+# FIXME: These cross compiler hacks should be removed for Autoconf 3.0
+# If not cross compiling, check that we can run a simple program.
+if test "$cross_compiling" != yes; then
+  if { ac_try='./$ac_file'
+  { (case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=\$ac_try;;
+  *) ac_try_echo=$ac_try;;
+esac
+eval "echo \"\$as_me:$LINENO: $ac_try_echo\"") >&5
+  (eval "$ac_try") 2>&5
+  ac_status=$?
+  echo "$as_me:$LINENO: \$? = $ac_status" >&5
+  (exit $ac_status); }; }; then
+    cross_compiling=no
+  else
+    if test "$cross_compiling" = maybe; then
+	cross_compiling=yes
+    else
+	{ { echo "$as_me:$LINENO: error: cannot run C compiled programs.
+If you meant to cross compile, use \`--host'.
+See \`config.log' for more details." >&5
+echo "$as_me: error: cannot run C compiled programs.
+If you meant to cross compile, use \`--host'.
+See \`config.log' for more details." >&2;}
+   { (exit 1); exit 1; }; }
+    fi
+  fi
+fi
+{ echo "$as_me:$LINENO: result: yes" >&5
+echo "${ECHO_T}yes" >&6; }
+
+rm -f a.out a.exe conftest$ac_cv_exeext b.out
+ac_clean_files=$ac_clean_files_save
+# Check that the compiler produces executables we can run.  If not, either
+# the compiler is broken, or we cross compile.
+{ echo "$as_me:$LINENO: checking whether we are cross compiling" >&5
+echo $ECHO_N "checking whether we are cross compiling... $ECHO_C" >&6; }
+{ echo "$as_me:$LINENO: result: $cross_compiling" >&5
+echo "${ECHO_T}$cross_compiling" >&6; }
+
+{ echo "$as_me:$LINENO: checking for suffix of executables" >&5
+echo $ECHO_N "checking for suffix of executables... $ECHO_C" >&6; }
+if { (ac_try="$ac_link"
+case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=\$ac_try;;
+  *) ac_try_echo=$ac_try;;
+esac
+eval "echo \"\$as_me:$LINENO: $ac_try_echo\"") >&5
+  (eval "$ac_link") 2>&5
+  ac_status=$?
+  echo "$as_me:$LINENO: \$? = $ac_status" >&5
+  (exit $ac_status); }; then
+  # If both `conftest.exe' and `conftest' are `present' (well, observable)
+# catch `conftest.exe'.  For instance with Cygwin, `ls conftest' will
+# work properly (i.e., refer to `conftest.exe'), while it won't with
+# `rm'.
+for ac_file in conftest.exe conftest conftest.*; do
+  test -f "$ac_file" || continue
+  case $ac_file in
+    *.$ac_ext | *.xcoff | *.tds | *.d | *.pdb | *.xSYM | *.bb | *.bbg | *.map | *.inf | *.o | *.obj ) ;;
+    *.* ) ac_cv_exeext=`expr "$ac_file" : '[^.]*\(\..*\)'`
+	  break;;
+    * ) break;;
+  esac
+done
+else
+  { { echo "$as_me:$LINENO: error: cannot compute suffix of executables: cannot compile and link
+See \`config.log' for more details." >&5
+echo "$as_me: error: cannot compute suffix of executables: cannot compile and link
+See \`config.log' for more details." >&2;}
+   { (exit 1); exit 1; }; }
+fi
+
+rm -f conftest$ac_cv_exeext
+{ echo "$as_me:$LINENO: result: $ac_cv_exeext" >&5
+echo "${ECHO_T}$ac_cv_exeext" >&6; }
+
+rm -f conftest.$ac_ext
+EXEEXT=$ac_cv_exeext
+ac_exeext=$EXEEXT
+{ echo "$as_me:$LINENO: checking for suffix of object files" >&5
+echo $ECHO_N "checking for suffix of object files... $ECHO_C" >&6; }
+if test "${ac_cv_objext+set}" = set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+
+int
+main ()
+{
+
+  ;
+  return 0;
+}
+_ACEOF
+rm -f conftest.o conftest.obj
+if { (ac_try="$ac_compile"
+case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=\$ac_try;;
+  *) ac_try_echo=$ac_try;;
+esac
+eval "echo \"\$as_me:$LINENO: $ac_try_echo\"") >&5
+  (eval "$ac_compile") 2>&5
+  ac_status=$?
+  echo "$as_me:$LINENO: \$? = $ac_status" >&5
+  (exit $ac_status); }; then
+  for ac_file in conftest.o conftest.obj conftest.*; do
+  test -f "$ac_file" || continue;
+  case $ac_file in
+    *.$ac_ext | *.xcoff | *.tds | *.d | *.pdb | *.xSYM | *.bb | *.bbg | *.map | *.inf ) ;;
+    *) ac_cv_objext=`expr "$ac_file" : '.*\.\(.*\)'`
+       break;;
+  esac
+done
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+{ { echo "$as_me:$LINENO: error: cannot compute suffix of object files: cannot compile
+See \`config.log' for more details." >&5
+echo "$as_me: error: cannot compute suffix of object files: cannot compile
+See \`config.log' for more details." >&2;}
+   { (exit 1); exit 1; }; }
+fi
+
+rm -f conftest.$ac_cv_objext conftest.$ac_ext
+fi
+{ echo "$as_me:$LINENO: result: $ac_cv_objext" >&5
+echo "${ECHO_T}$ac_cv_objext" >&6; }
+OBJEXT=$ac_cv_objext
+ac_objext=$OBJEXT
+{ echo "$as_me:$LINENO: checking whether we are using the GNU C compiler" >&5
+echo $ECHO_N "checking whether we are using the GNU C compiler... $ECHO_C" >&6; }
+if test "${ac_cv_c_compiler_gnu+set}" = set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+
+int
+main ()
+{
+#ifndef __GNUC__
+       choke me
+#endif
+
+  ;
+  return 0;
+}
+_ACEOF
+rm -f conftest.$ac_objext
+if { (ac_try="$ac_compile"
+case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=\$ac_try;;
+  *) ac_try_echo=$ac_try;;
+esac
+eval "echo \"\$as_me:$LINENO: $ac_try_echo\"") >&5
+  (eval "$ac_compile") 2>conftest.er1
+  ac_status=$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? = $ac_status" >&5
+  (exit $ac_status); } && {
+	 test -z "$ac_c_werror_flag" ||
+	 test ! -s conftest.err
+       } && test -s conftest.$ac_objext; then
+  ac_compiler_gnu=yes
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+	ac_compiler_gnu=no
+fi
+
+rm -f core conftest.err conftest.$ac_objext conftest.$ac_ext
+ac_cv_c_compiler_gnu=$ac_compiler_gnu
+
+fi
+{ echo "$as_me:$LINENO: result: $ac_cv_c_compiler_gnu" >&5
+echo "${ECHO_T}$ac_cv_c_compiler_gnu" >&6; }
+GCC=`test $ac_compiler_gnu = yes && echo yes`
+ac_test_CFLAGS=${CFLAGS+set}
+ac_save_CFLAGS=$CFLAGS
+{ echo "$as_me:$LINENO: checking whether $CC accepts -g" >&5
+echo $ECHO_N "checking whether $CC accepts -g... $ECHO_C" >&6; }
+if test "${ac_cv_prog_cc_g+set}" = set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  ac_save_c_werror_flag=$ac_c_werror_flag
+   ac_c_werror_flag=yes
+   ac_cv_prog_cc_g=no
+   CFLAGS="-g"
+   cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+
+int
+main ()
+{
+
+  ;
+  return 0;
+}
+_ACEOF
+rm -f conftest.$ac_objext
+if { (ac_try="$ac_compile"
+case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=\$ac_try;;
+  *) ac_try_echo=$ac_try;;
+esac
+eval "echo \"\$as_me:$LINENO: $ac_try_echo\"") >&5
+  (eval "$ac_compile") 2>conftest.er1
+  ac_status=$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? = $ac_status" >&5
+  (exit $ac_status); } && {
+	 test -z "$ac_c_werror_flag" ||
+	 test ! -s conftest.err
+       } && test -s conftest.$ac_objext; then
+  ac_cv_prog_cc_g=yes
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+	CFLAGS=""
+      cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+
+int
+main ()
+{
+
+  ;
+  return 0;
+}
+_ACEOF
+rm -f conftest.$ac_objext
+if { (ac_try="$ac_compile"
+case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=\$ac_try;;
+  *) ac_try_echo=$ac_try;;
+esac
+eval "echo \"\$as_me:$LINENO: $ac_try_echo\"") >&5
+  (eval "$ac_compile") 2>conftest.er1
+  ac_status=$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? = $ac_status" >&5
+  (exit $ac_status); } && {
+	 test -z "$ac_c_werror_flag" ||
+	 test ! -s conftest.err
+       } && test -s conftest.$ac_objext; then
+  :
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+	ac_c_werror_flag=$ac_save_c_werror_flag
+	 CFLAGS="-g"
+	 cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+
+int
+main ()
+{
+
+  ;
+  return 0;
+}
+_ACEOF
+rm -f conftest.$ac_objext
+if { (ac_try="$ac_compile"
+case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=\$ac_try;;
+  *) ac_try_echo=$ac_try;;
+esac
+eval "echo \"\$as_me:$LINENO: $ac_try_echo\"") >&5
+  (eval "$ac_compile") 2>conftest.er1
+  ac_status=$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? = $ac_status" >&5
+  (exit $ac_status); } && {
+	 test -z "$ac_c_werror_flag" ||
+	 test ! -s conftest.err
+       } && test -s conftest.$ac_objext; then
+  ac_cv_prog_cc_g=yes
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+
+fi
+
+rm -f core conftest.err conftest.$ac_objext conftest.$ac_ext
+fi
+
+rm -f core conftest.err conftest.$ac_objext conftest.$ac_ext
+fi
+
+rm -f core conftest.err conftest.$ac_objext conftest.$ac_ext
+   ac_c_werror_flag=$ac_save_c_werror_flag
+fi
+{ echo "$as_me:$LINENO: result: $ac_cv_prog_cc_g" >&5
+echo "${ECHO_T}$ac_cv_prog_cc_g" >&6; }
+if test "$ac_test_CFLAGS" = set; then
+  CFLAGS=$ac_save_CFLAGS
+elif test $ac_cv_prog_cc_g = yes; then
+  if test "$GCC" = yes; then
+    CFLAGS="-g -O2"
+  else
+    CFLAGS="-g"
+  fi
+else
+  if test "$GCC" = yes; then
+    CFLAGS="-O2"
+  else
+    CFLAGS=
+  fi
+fi
+{ echo "$as_me:$LINENO: checking for $CC option to accept ISO C89" >&5
+echo $ECHO_N "checking for $CC option to accept ISO C89... $ECHO_C" >&6; }
+if test "${ac_cv_prog_cc_c89+set}" = set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  ac_cv_prog_cc_c89=no
+ac_save_CC=$CC
+cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+#include <stdarg.h>
+#include <stdio.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+/* Most of the following tests are stolen from RCS 5.7's src/conf.sh.  */
+struct buf { int x; };
+FILE * (*rcsopen) (struct buf *, struct stat *, int);
+static char *e (p, i)
+     char **p;
+     int i;
+{
+  return p[i];
+}
+static char *f (char * (*g) (char **, int), char **p, ...)
+{
+  char *s;
+  va_list v;
+  va_start (v,p);
+  s = g (p, va_arg (v,int));
+  va_end (v);
+  return s;
+}
+
+/* OSF 4.0 Compaq cc is some sort of almost-ANSI by default.  It has
+   function prototypes and stuff, but not '\xHH' hex character constants.
+   These don't provoke an error unfortunately, instead are silently treated
+   as 'x'.  The following induces an error, until -std is added to get
+   proper ANSI mode.  Curiously '\x00'!='x' always comes out true, for an
+   array size at least.  It's necessary to write '\x00'==0 to get something
+   that's true only with -std.  */
+int osf4_cc_array ['\x00' == 0 ? 1 : -1];
+
+/* IBM C 6 for AIX is almost-ANSI by default, but it replaces macro parameters
+   inside strings and character constants.  */
+#define FOO(x) 'x'
+int xlc6_cc_array[FOO(a) == 'x' ? 1 : -1];
+
+int test (int i, double x);
+struct s1 {int (*f) (int a);};
+struct s2 {int (*f) (double a);};
+int pairnames (int, char **, FILE *(*)(struct buf *, struct stat *, int), int, int);
+int argc;
+char **argv;
+int
+main ()
+{
+return f (e, argv, 0) != argv[0]  ||  f (e, argv, 1) != argv[1];
+  ;
+  return 0;
+}
+_ACEOF
+for ac_arg in '' -qlanglvl=extc89 -qlanglvl=ansi -std \
+	-Ae "-Aa -D_HPUX_SOURCE" "-Xc -D__EXTENSIONS__"
+do
+  CC="$ac_save_CC $ac_arg"
+  rm -f conftest.$ac_objext
+if { (ac_try="$ac_compile"
+case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=\$ac_try;;
+  *) ac_try_echo=$ac_try;;
+esac
+eval "echo \"\$as_me:$LINENO: $ac_try_echo\"") >&5
+  (eval "$ac_compile") 2>conftest.er1
+  ac_status=$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? = $ac_status" >&5
+  (exit $ac_status); } && {
+	 test -z "$ac_c_werror_flag" ||
+	 test ! -s conftest.err
+       } && test -s conftest.$ac_objext; then
+  ac_cv_prog_cc_c89=$ac_arg
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+
+fi
+
+rm -f core conftest.err conftest.$ac_objext
+  test "x$ac_cv_prog_cc_c89" != "xno" && break
+done
+rm -f conftest.$ac_ext
+CC=$ac_save_CC
+
+fi
+# AC_CACHE_VAL
+case "x$ac_cv_prog_cc_c89" in
+  x)
+    { echo "$as_me:$LINENO: result: none needed" >&5
+echo "${ECHO_T}none needed" >&6; } ;;
+  xno)
+    { echo "$as_me:$LINENO: result: unsupported" >&5
+echo "${ECHO_T}unsupported" >&6; } ;;
+  *)
+    CC="$CC $ac_cv_prog_cc_c89"
+    { echo "$as_me:$LINENO: result: $ac_cv_prog_cc_c89" >&5
+echo "${ECHO_T}$ac_cv_prog_cc_c89" >&6; } ;;
+esac
+
+
+ac_ext=c
+ac_cpp='$CPP $CPPFLAGS'
+ac_compile='$CC -c $CFLAGS $CPPFLAGS conftest.$ac_ext >&5'
+ac_link='$CC -o conftest$ac_exeext $CFLAGS $CPPFLAGS $LDFLAGS conftest.$ac_ext $LIBS >&5'
+ac_compiler_gnu=$ac_cv_c_compiler_gnu
+
+depcc="$CC"   am_compiler_list=
+
+{ echo "$as_me:$LINENO: checking dependency style of $depcc" >&5
+echo $ECHO_N "checking dependency style of $depcc... $ECHO_C" >&6; }
+if test "${am_cv_CC_dependencies_compiler_type+set}" = set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  if test -z "$AMDEP_TRUE" && test -f "$am_depcomp"; then
+  # We make a subdir and do the tests there.  Otherwise we can end up
+  # making bogus files that we don't know about and never remove.  For
+  # instance it was reported that on HP-UX the gcc test will end up
+  # making a dummy file named `D' -- because `-MD' means `put the output
+  # in D'.
+  mkdir conftest.dir
+  # Copy depcomp to subdir because otherwise we won't find it if we're
+  # using a relative directory.
+  cp "$am_depcomp" conftest.dir
+  cd conftest.dir
+  # We will build objects and dependencies in a subdirectory because
+  # it helps to detect inapplicable dependency modes.  For instance
+  # both Tru64's cc and ICC support -MD to output dependencies as a
+  # side effect of compilation, but ICC will put the dependencies in
+  # the current directory while Tru64 will put them in the object
+  # directory.
+  mkdir sub
+
+  am_cv_CC_dependencies_compiler_type=none
+  if test "$am_compiler_list" = ""; then
+     am_compiler_list=`sed -n 's/^#*\([a-zA-Z0-9]*\))$/\1/p' < ./depcomp`
+  fi
+  for depmode in $am_compiler_list; do
+    # Setup a source with many dependencies, because some compilers
+    # like to wrap large dependency lists on column 80 (with \), and
+    # we should not choose a depcomp mode which is confused by this.
+    #
+    # We need to recreate these files for each test, as the compiler may
+    # overwrite some of them when testing with obscure command lines.
+    # This happens at least with the AIX C compiler.
+    : > sub/conftest.c
+    for i in 1 2 3 4 5 6; do
+      echo '#include "conftst'$i'.h"' >> sub/conftest.c
+      # Using `: > sub/conftst$i.h' creates only sub/conftst1.h with
+      # Solaris 8's {/usr,}/bin/sh.
+      touch sub/conftst$i.h
+    done
+    echo "${am__include} ${am__quote}sub/conftest.Po${am__quote}" > confmf
+
+    case $depmode in
+    nosideeffect)
+      # after this tag, mechanisms are not by side-effect, so they'll
+      # only be used when explicitly requested
+      if test "x$enable_dependency_tracking" = xyes; then
+	continue
+      else
+	break
+      fi
+      ;;
+    none) break ;;
+    esac
+    # We check with `-c' and `-o' for the sake of the "dashmstdout"
+    # mode.  It turns out that the SunPro C++ compiler does not properly
+    # handle `-M -o', and we need to detect this.
+    if depmode=$depmode \
+       source=sub/conftest.c object=sub/conftest.${OBJEXT-o} \
+       depfile=sub/conftest.Po tmpdepfile=sub/conftest.TPo \
+       $SHELL ./depcomp $depcc -c -o sub/conftest.${OBJEXT-o} sub/conftest.c \
+         >/dev/null 2>conftest.err &&
+       grep sub/conftst1.h sub/conftest.Po > /dev/null 2>&1 &&
+       grep sub/conftst6.h sub/conftest.Po > /dev/null 2>&1 &&
+       grep sub/conftest.${OBJEXT-o} sub/conftest.Po > /dev/null 2>&1 &&
+       ${MAKE-make} -s -f confmf > /dev/null 2>&1; then
+      # icc doesn't choke on unknown options, it will just issue warnings
+      # or remarks (even with -Werror).  So we grep stderr for any message
+      # that says an option was ignored or not supported.
+      # When given -MP, icc 7.0 and 7.1 complain thusly:
+      #   icc: Command line warning: ignoring option '-M'; no argument required
+      # The diagnosis changed in icc 8.0:
+      #   icc: Command line remark: option '-MP' not supported
+      if (grep 'ignoring option' conftest.err ||
+          grep 'not supported' conftest.err) >/dev/null 2>&1; then :; else
+        am_cv_CC_dependencies_compiler_type=$depmode
+        break
+      fi
+    fi
+  done
+
+  cd ..
+  rm -rf conftest.dir
+else
+  am_cv_CC_dependencies_compiler_type=none
+fi
+
+fi
+{ echo "$as_me:$LINENO: result: $am_cv_CC_dependencies_compiler_type" >&5
+echo "${ECHO_T}$am_cv_CC_dependencies_compiler_type" >&6; }
+CCDEPMODE=depmode=$am_cv_CC_dependencies_compiler_type
+
+ if
+  test "x$enable_dependency_tracking" != xno \
+  && test "$am_cv_CC_dependencies_compiler_type" = gcc3; then
+  am__fastdepCC_TRUE=
+  am__fastdepCC_FALSE='#'
+else
+  am__fastdepCC_TRUE='#'
+  am__fastdepCC_FALSE=
+fi
+
+
+
+ac_ext=c
+ac_cpp='$CPP $CPPFLAGS'
+ac_compile='$CC -c $CFLAGS $CPPFLAGS conftest.$ac_ext >&5'
+ac_link='$CC -o conftest$ac_exeext $CFLAGS $CPPFLAGS $LDFLAGS conftest.$ac_ext $LIBS >&5'
+ac_compiler_gnu=$ac_cv_c_compiler_gnu
+{ echo "$as_me:$LINENO: checking how to run the C preprocessor" >&5
+echo $ECHO_N "checking how to run the C preprocessor... $ECHO_C" >&6; }
+# On Suns, sometimes $CPP names a directory.
+if test -n "$CPP" && test -d "$CPP"; then
+  CPP=
+fi
+if test -z "$CPP"; then
+  if test "${ac_cv_prog_CPP+set}" = set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+      # Double quotes because CPP needs to be expanded
+    for CPP in "$CC -E" "$CC -E -traditional-cpp" "/lib/cpp"
+    do
+      ac_preproc_ok=false
+for ac_c_preproc_warn_flag in '' yes
+do
+  # Use a header file that comes with gcc, so configuring glibc
+  # with a fresh cross-compiler works.
+  # Prefer <limits.h> to <assert.h> if __STDC__ is defined, since
+  # <limits.h> exists even on freestanding compilers.
+  # On the NeXT, cc -E runs the code through the compiler's parser,
+  # not just through cpp. "Syntax error" is here to catch this case.
+  cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+#ifdef __STDC__
+# include <limits.h>
+#else
+# include <assert.h>
+#endif
+		     Syntax error
+_ACEOF
+if { (ac_try="$ac_cpp conftest.$ac_ext"
+case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=\$ac_try;;
+  *) ac_try_echo=$ac_try;;
+esac
+eval "echo \"\$as_me:$LINENO: $ac_try_echo\"") >&5
+  (eval "$ac_cpp conftest.$ac_ext") 2>conftest.er1
+  ac_status=$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? = $ac_status" >&5
+  (exit $ac_status); } >/dev/null && {
+	 test -z "$ac_c_preproc_warn_flag$ac_c_werror_flag" ||
+	 test ! -s conftest.err
+       }; then
+  :
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+  # Broken: fails on valid input.
+continue
+fi
+
+rm -f conftest.err conftest.$ac_ext
+
+  # OK, works on sane cases.  Now check whether nonexistent headers
+  # can be detected and how.
+  cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+#include <ac_nonexistent.h>
+_ACEOF
+if { (ac_try="$ac_cpp conftest.$ac_ext"
+case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=\$ac_try;;
+  *) ac_try_echo=$ac_try;;
+esac
+eval "echo \"\$as_me:$LINENO: $ac_try_echo\"") >&5
+  (eval "$ac_cpp conftest.$ac_ext") 2>conftest.er1
+  ac_status=$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? = $ac_status" >&5
+  (exit $ac_status); } >/dev/null && {
+	 test -z "$ac_c_preproc_warn_flag$ac_c_werror_flag" ||
+	 test ! -s conftest.err
+       }; then
+  # Broken: success on invalid input.
+continue
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+  # Passes both tests.
+ac_preproc_ok=:
+break
+fi
+
+rm -f conftest.err conftest.$ac_ext
+
+done
+# Because of `break', _AC_PREPROC_IFELSE's cleaning code was skipped.
+rm -f conftest.err conftest.$ac_ext
+if $ac_preproc_ok; then
+  break
+fi
+
+    done
+    ac_cv_prog_CPP=$CPP
+
+fi
+  CPP=$ac_cv_prog_CPP
+else
+  ac_cv_prog_CPP=$CPP
+fi
+{ echo "$as_me:$LINENO: result: $CPP" >&5
+echo "${ECHO_T}$CPP" >&6; }
+ac_preproc_ok=false
+for ac_c_preproc_warn_flag in '' yes
+do
+  # Use a header file that comes with gcc, so configuring glibc
+  # with a fresh cross-compiler works.
+  # Prefer <limits.h> to <assert.h> if __STDC__ is defined, since
+  # <limits.h> exists even on freestanding compilers.
+  # On the NeXT, cc -E runs the code through the compiler's parser,
+  # not just through cpp. "Syntax error" is here to catch this case.
+  cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+#ifdef __STDC__
+# include <limits.h>
+#else
+# include <assert.h>
+#endif
+		     Syntax error
+_ACEOF
+if { (ac_try="$ac_cpp conftest.$ac_ext"
+case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=\$ac_try;;
+  *) ac_try_echo=$ac_try;;
+esac
+eval "echo \"\$as_me:$LINENO: $ac_try_echo\"") >&5
+  (eval "$ac_cpp conftest.$ac_ext") 2>conftest.er1
+  ac_status=$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? = $ac_status" >&5
+  (exit $ac_status); } >/dev/null && {
+	 test -z "$ac_c_preproc_warn_flag$ac_c_werror_flag" ||
+	 test ! -s conftest.err
+       }; then
+  :
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+  # Broken: fails on valid input.
+continue
+fi
+
+rm -f conftest.err conftest.$ac_ext
+
+  # OK, works on sane cases.  Now check whether nonexistent headers
+  # can be detected and how.
+  cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+#include <ac_nonexistent.h>
+_ACEOF
+if { (ac_try="$ac_cpp conftest.$ac_ext"
+case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=\$ac_try;;
+  *) ac_try_echo=$ac_try;;
+esac
+eval "echo \"\$as_me:$LINENO: $ac_try_echo\"") >&5
+  (eval "$ac_cpp conftest.$ac_ext") 2>conftest.er1
+  ac_status=$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? = $ac_status" >&5
+  (exit $ac_status); } >/dev/null && {
+	 test -z "$ac_c_preproc_warn_flag$ac_c_werror_flag" ||
+	 test ! -s conftest.err
+       }; then
+  # Broken: success on invalid input.
+continue
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+  # Passes both tests.
+ac_preproc_ok=:
+break
+fi
+
+rm -f conftest.err conftest.$ac_ext
+
+done
+# Because of `break', _AC_PREPROC_IFELSE's cleaning code was skipped.
+rm -f conftest.err conftest.$ac_ext
+if $ac_preproc_ok; then
+  :
+else
+  { { echo "$as_me:$LINENO: error: C preprocessor \"$CPP\" fails sanity check
+See \`config.log' for more details." >&5
+echo "$as_me: error: C preprocessor \"$CPP\" fails sanity check
+See \`config.log' for more details." >&2;}
+   { (exit 1); exit 1; }; }
+fi
+
+ac_ext=c
+ac_cpp='$CPP $CPPFLAGS'
+ac_compile='$CC -c $CFLAGS $CPPFLAGS conftest.$ac_ext >&5'
+ac_link='$CC -o conftest$ac_exeext $CFLAGS $CPPFLAGS $LDFLAGS conftest.$ac_ext $LIBS >&5'
+ac_compiler_gnu=$ac_cv_c_compiler_gnu
+
+
+{ echo "$as_me:$LINENO: checking for grep that handles long lines and -e" >&5
+echo $ECHO_N "checking for grep that handles long lines and -e... $ECHO_C" >&6; }
+if test "${ac_cv_path_GREP+set}" = set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  # Extract the first word of "grep ggrep" to use in msg output
+if test -z "$GREP"; then
+set dummy grep ggrep; ac_prog_name=$2
+if test "${ac_cv_path_GREP+set}" = set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  ac_path_GREP_found=false
+# Loop through the user's path and test for each of PROGNAME-LIST
+as_save_IFS=$IFS; IFS=$PATH_SEPARATOR
+for as_dir in $PATH$PATH_SEPARATOR/usr/xpg4/bin
+do
+  IFS=$as_save_IFS
+  test -z "$as_dir" && as_dir=.
+  for ac_prog in grep ggrep; do
+  for ac_exec_ext in '' $ac_executable_extensions; do
+    ac_path_GREP="$as_dir/$ac_prog$ac_exec_ext"
+    { test -f "$ac_path_GREP" && $as_test_x "$ac_path_GREP"; } || continue
+    # Check for GNU ac_path_GREP and select it if it is found.
+  # Check for GNU $ac_path_GREP
+case `"$ac_path_GREP" --version 2>&1` in
+*GNU*)
+  ac_cv_path_GREP="$ac_path_GREP" ac_path_GREP_found=:;;
+*)
+  ac_count=0
+  echo $ECHO_N "0123456789$ECHO_C" >"conftest.in"
+  while :
+  do
+    cat "conftest.in" "conftest.in" >"conftest.tmp"
+    mv "conftest.tmp" "conftest.in"
+    cp "conftest.in" "conftest.nl"
+    echo 'GREP' >> "conftest.nl"
+    "$ac_path_GREP" -e 'GREP$' -e '-(cannot match)-' < "conftest.nl" >"conftest.out" 2>/dev/null || break
+    diff "conftest.out" "conftest.nl" >/dev/null 2>&1 || break
+    ac_count=`expr $ac_count + 1`
+    if test $ac_count -gt ${ac_path_GREP_max-0}; then
+      # Best one so far, save it but keep looking for a better one
+      ac_cv_path_GREP="$ac_path_GREP"
+      ac_path_GREP_max=$ac_count
+    fi
+    # 10*(2^10) chars as input seems more than enough
+    test $ac_count -gt 10 && break
+  done
+  rm -f conftest.in conftest.tmp conftest.nl conftest.out;;
+esac
+
+
+    $ac_path_GREP_found && break 3
+  done
+done
+
+done
+IFS=$as_save_IFS
+
+
+fi
+
+GREP="$ac_cv_path_GREP"
+if test -z "$GREP"; then
+  { { echo "$as_me:$LINENO: error: no acceptable $ac_prog_name could be found in $PATH$PATH_SEPARATOR/usr/xpg4/bin" >&5
+echo "$as_me: error: no acceptable $ac_prog_name could be found in $PATH$PATH_SEPARATOR/usr/xpg4/bin" >&2;}
+   { (exit 1); exit 1; }; }
+fi
+
+else
+  ac_cv_path_GREP=$GREP
+fi
+
+
+fi
+{ echo "$as_me:$LINENO: result: $ac_cv_path_GREP" >&5
+echo "${ECHO_T}$ac_cv_path_GREP" >&6; }
+ GREP="$ac_cv_path_GREP"
+
+
+{ echo "$as_me:$LINENO: checking for egrep" >&5
+echo $ECHO_N "checking for egrep... $ECHO_C" >&6; }
+if test "${ac_cv_path_EGREP+set}" = set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  if echo a | $GREP -E '(a|b)' >/dev/null 2>&1
+   then ac_cv_path_EGREP="$GREP -E"
+   else
+     # Extract the first word of "egrep" to use in msg output
+if test -z "$EGREP"; then
+set dummy egrep; ac_prog_name=$2
+if test "${ac_cv_path_EGREP+set}" = set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  ac_path_EGREP_found=false
+# Loop through the user's path and test for each of PROGNAME-LIST
+as_save_IFS=$IFS; IFS=$PATH_SEPARATOR
+for as_dir in $PATH$PATH_SEPARATOR/usr/xpg4/bin
+do
+  IFS=$as_save_IFS
+  test -z "$as_dir" && as_dir=.
+  for ac_prog in egrep; do
+  for ac_exec_ext in '' $ac_executable_extensions; do
+    ac_path_EGREP="$as_dir/$ac_prog$ac_exec_ext"
+    { test -f "$ac_path_EGREP" && $as_test_x "$ac_path_EGREP"; } || continue
+    # Check for GNU ac_path_EGREP and select it if it is found.
+  # Check for GNU $ac_path_EGREP
+case `"$ac_path_EGREP" --version 2>&1` in
+*GNU*)
+  ac_cv_path_EGREP="$ac_path_EGREP" ac_path_EGREP_found=:;;
+*)
+  ac_count=0
+  echo $ECHO_N "0123456789$ECHO_C" >"conftest.in"
+  while :
+  do
+    cat "conftest.in" "conftest.in" >"conftest.tmp"
+    mv "conftest.tmp" "conftest.in"
+    cp "conftest.in" "conftest.nl"
+    echo 'EGREP' >> "conftest.nl"
+    "$ac_path_EGREP" 'EGREP$' < "conftest.nl" >"conftest.out" 2>/dev/null || break
+    diff "conftest.out" "conftest.nl" >/dev/null 2>&1 || break
+    ac_count=`expr $ac_count + 1`
+    if test $ac_count -gt ${ac_path_EGREP_max-0}; then
+      # Best one so far, save it but keep looking for a better one
+      ac_cv_path_EGREP="$ac_path_EGREP"
+      ac_path_EGREP_max=$ac_count
+    fi
+    # 10*(2^10) chars as input seems more than enough
+    test $ac_count -gt 10 && break
+  done
+  rm -f conftest.in conftest.tmp conftest.nl conftest.out;;
+esac
+
+
+    $ac_path_EGREP_found && break 3
+  done
+done
+
+done
+IFS=$as_save_IFS
+
+
+fi
+
+EGREP="$ac_cv_path_EGREP"
+if test -z "$EGREP"; then
+  { { echo "$as_me:$LINENO: error: no acceptable $ac_prog_name could be found in $PATH$PATH_SEPARATOR/usr/xpg4/bin" >&5
+echo "$as_me: error: no acceptable $ac_prog_name could be found in $PATH$PATH_SEPARATOR/usr/xpg4/bin" >&2;}
+   { (exit 1); exit 1; }; }
+fi
+
+else
+  ac_cv_path_EGREP=$EGREP
+fi
+
+
+   fi
+fi
+{ echo "$as_me:$LINENO: result: $ac_cv_path_EGREP" >&5
+echo "${ECHO_T}$ac_cv_path_EGREP" >&6; }
+ EGREP="$ac_cv_path_EGREP"
+
+
+
+{ echo "$as_me:$LINENO: checking for AIX" >&5
+echo $ECHO_N "checking for AIX... $ECHO_C" >&6; }
+cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+#ifdef _AIX
+  yes
+#endif
+
+_ACEOF
+if (eval "$ac_cpp conftest.$ac_ext") 2>&5 |
+  $EGREP "yes" >/dev/null 2>&1; then
+  { echo "$as_me:$LINENO: result: yes" >&5
+echo "${ECHO_T}yes" >&6; }
+cat >>confdefs.h <<\_ACEOF
+#define _ALL_SOURCE 1
+_ACEOF
+
+else
+  { echo "$as_me:$LINENO: result: no" >&5
+echo "${ECHO_T}no" >&6; }
+fi
+rm -f conftest*
+
+
+
+case "${host}" in
+  *aix*)
+    CFLAGS="${CFLAGS} -D_THREAD_SAFE"
+    ;;
+  *linux*)
+    CFLAGS="${CFLAGS} -D_REENTRANT"
+    ;;
+  *)
+    echo "detected unknown platform : ${host} : compiles may fail"
+    CFLAGS="${CFLAGS} -D_REENTRANT"
+    ;;
+esac
+
+ac_ext=c
+ac_cpp='$CPP $CPPFLAGS'
+ac_compile='$CC -c $CFLAGS $CPPFLAGS conftest.$ac_ext >&5'
+ac_link='$CC -o conftest$ac_exeext $CFLAGS $CPPFLAGS $LDFLAGS conftest.$ac_ext $LIBS >&5'
+ac_compiler_gnu=$ac_cv_c_compiler_gnu
+if test -n "$ac_tool_prefix"; then
+  # Extract the first word of "${ac_tool_prefix}gcc", so it can be a program name with args.
+set dummy ${ac_tool_prefix}gcc; ac_word=$2
+{ echo "$as_me:$LINENO: checking for $ac_word" >&5
+echo $ECHO_N "checking for $ac_word... $ECHO_C" >&6; }
+if test "${ac_cv_prog_CC+set}" = set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  if test -n "$CC"; then
+  ac_cv_prog_CC="$CC" # Let the user override the test.
+else
+as_save_IFS=$IFS; IFS=$PATH_SEPARATOR
+for as_dir in $PATH
+do
+  IFS=$as_save_IFS
+  test -z "$as_dir" && as_dir=.
+  for ac_exec_ext in '' $ac_executable_extensions; do
+  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_word$ac_exec_ext"; }; then
+    ac_cv_prog_CC="${ac_tool_prefix}gcc"
+    echo "$as_me:$LINENO: found $as_dir/$ac_word$ac_exec_ext" >&5
+    break 2
+  fi
+done
+done
+IFS=$as_save_IFS
+
+fi
+fi
+CC=$ac_cv_prog_CC
+if test -n "$CC"; then
+  { echo "$as_me:$LINENO: result: $CC" >&5
+echo "${ECHO_T}$CC" >&6; }
+else
+  { echo "$as_me:$LINENO: result: no" >&5
+echo "${ECHO_T}no" >&6; }
+fi
+
+
+fi
+if test -z "$ac_cv_prog_CC"; then
+  ac_ct_CC=$CC
+  # Extract the first word of "gcc", so it can be a program name with args.
+set dummy gcc; ac_word=$2
+{ echo "$as_me:$LINENO: checking for $ac_word" >&5
+echo $ECHO_N "checking for $ac_word... $ECHO_C" >&6; }
+if test "${ac_cv_prog_ac_ct_CC+set}" = set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  if test -n "$ac_ct_CC"; then
+  ac_cv_prog_ac_ct_CC="$ac_ct_CC" # Let the user override the test.
+else
+as_save_IFS=$IFS; IFS=$PATH_SEPARATOR
+for as_dir in $PATH
+do
+  IFS=$as_save_IFS
+  test -z "$as_dir" && as_dir=.
+  for ac_exec_ext in '' $ac_executable_extensions; do
+  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_word$ac_exec_ext"; }; then
+    ac_cv_prog_ac_ct_CC="gcc"
+    echo "$as_me:$LINENO: found $as_dir/$ac_word$ac_exec_ext" >&5
+    break 2
+  fi
+done
+done
+IFS=$as_save_IFS
+
+fi
+fi
+ac_ct_CC=$ac_cv_prog_ac_ct_CC
+if test -n "$ac_ct_CC"; then
+  { echo "$as_me:$LINENO: result: $ac_ct_CC" >&5
+echo "${ECHO_T}$ac_ct_CC" >&6; }
+else
+  { echo "$as_me:$LINENO: result: no" >&5
+echo "${ECHO_T}no" >&6; }
+fi
+
+  if test "x$ac_ct_CC" = x; then
+    CC=""
+  else
+    case $cross_compiling:$ac_tool_warned in
+yes:)
+{ echo "$as_me:$LINENO: WARNING: In the future, Autoconf will not detect cross-tools
+whose name does not start with the host triplet.  If you think this
+configuration is useful to you, please write to autoconf@gnu.org." >&5
+echo "$as_me: WARNING: In the future, Autoconf will not detect cross-tools
+whose name does not start with the host triplet.  If you think this
+configuration is useful to you, please write to autoconf@gnu.org." >&2;}
+ac_tool_warned=yes ;;
+esac
+    CC=$ac_ct_CC
+  fi
+else
+  CC="$ac_cv_prog_CC"
+fi
+
+if test -z "$CC"; then
+          if test -n "$ac_tool_prefix"; then
+    # Extract the first word of "${ac_tool_prefix}cc", so it can be a program name with args.
+set dummy ${ac_tool_prefix}cc; ac_word=$2
+{ echo "$as_me:$LINENO: checking for $ac_word" >&5
+echo $ECHO_N "checking for $ac_word... $ECHO_C" >&6; }
+if test "${ac_cv_prog_CC+set}" = set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  if test -n "$CC"; then
+  ac_cv_prog_CC="$CC" # Let the user override the test.
+else
+as_save_IFS=$IFS; IFS=$PATH_SEPARATOR
+for as_dir in $PATH
+do
+  IFS=$as_save_IFS
+  test -z "$as_dir" && as_dir=.
+  for ac_exec_ext in '' $ac_executable_extensions; do
+  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_word$ac_exec_ext"; }; then
+    ac_cv_prog_CC="${ac_tool_prefix}cc"
+    echo "$as_me:$LINENO: found $as_dir/$ac_word$ac_exec_ext" >&5
+    break 2
+  fi
+done
+done
+IFS=$as_save_IFS
+
+fi
+fi
+CC=$ac_cv_prog_CC
+if test -n "$CC"; then
+  { echo "$as_me:$LINENO: result: $CC" >&5
+echo "${ECHO_T}$CC" >&6; }
+else
+  { echo "$as_me:$LINENO: result: no" >&5
+echo "${ECHO_T}no" >&6; }
+fi
+
+
+  fi
+fi
+if test -z "$CC"; then
+  # Extract the first word of "cc", so it can be a program name with args.
+set dummy cc; ac_word=$2
+{ echo "$as_me:$LINENO: checking for $ac_word" >&5
+echo $ECHO_N "checking for $ac_word... $ECHO_C" >&6; }
+if test "${ac_cv_prog_CC+set}" = set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  if test -n "$CC"; then
+  ac_cv_prog_CC="$CC" # Let the user override the test.
+else
+  ac_prog_rejected=no
+as_save_IFS=$IFS; IFS=$PATH_SEPARATOR
+for as_dir in $PATH
+do
+  IFS=$as_save_IFS
+  test -z "$as_dir" && as_dir=.
+  for ac_exec_ext in '' $ac_executable_extensions; do
+  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_word$ac_exec_ext"; }; then
+    if test "$as_dir/$ac_word$ac_exec_ext" = "/usr/ucb/cc"; then
+       ac_prog_rejected=yes
+       continue
+     fi
+    ac_cv_prog_CC="cc"
+    echo "$as_me:$LINENO: found $as_dir/$ac_word$ac_exec_ext" >&5
+    break 2
+  fi
+done
+done
+IFS=$as_save_IFS
+
+if test $ac_prog_rejected = yes; then
+  # We found a bogon in the path, so make sure we never use it.
+  set dummy $ac_cv_prog_CC
+  shift
+  if test $# != 0; then
+    # We chose a different compiler from the bogus one.
+    # However, it has the same basename, so the bogon will be chosen
+    # first if we set CC to just the basename; use the full file name.
+    shift
+    ac_cv_prog_CC="$as_dir/$ac_word${1+' '}$@"
+  fi
+fi
+fi
+fi
+CC=$ac_cv_prog_CC
+if test -n "$CC"; then
+  { echo "$as_me:$LINENO: result: $CC" >&5
+echo "${ECHO_T}$CC" >&6; }
+else
+  { echo "$as_me:$LINENO: result: no" >&5
+echo "${ECHO_T}no" >&6; }
+fi
+
+
+fi
+if test -z "$CC"; then
+  if test -n "$ac_tool_prefix"; then
+  for ac_prog in cl.exe
+  do
+    # Extract the first word of "$ac_tool_prefix$ac_prog", so it can be a program name with args.
+set dummy $ac_tool_prefix$ac_prog; ac_word=$2
+{ echo "$as_me:$LINENO: checking for $ac_word" >&5
+echo $ECHO_N "checking for $ac_word... $ECHO_C" >&6; }
+if test "${ac_cv_prog_CC+set}" = set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  if test -n "$CC"; then
+  ac_cv_prog_CC="$CC" # Let the user override the test.
+else
+as_save_IFS=$IFS; IFS=$PATH_SEPARATOR
+for as_dir in $PATH
+do
+  IFS=$as_save_IFS
+  test -z "$as_dir" && as_dir=.
+  for ac_exec_ext in '' $ac_executable_extensions; do
+  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_word$ac_exec_ext"; }; then
+    ac_cv_prog_CC="$ac_tool_prefix$ac_prog"
+    echo "$as_me:$LINENO: found $as_dir/$ac_word$ac_exec_ext" >&5
+    break 2
+  fi
+done
+done
+IFS=$as_save_IFS
+
+fi
+fi
+CC=$ac_cv_prog_CC
+if test -n "$CC"; then
+  { echo "$as_me:$LINENO: result: $CC" >&5
+echo "${ECHO_T}$CC" >&6; }
+else
+  { echo "$as_me:$LINENO: result: no" >&5
+echo "${ECHO_T}no" >&6; }
+fi
+
+
+    test -n "$CC" && break
+  done
+fi
+if test -z "$CC"; then
+  ac_ct_CC=$CC
+  for ac_prog in cl.exe
+do
+  # Extract the first word of "$ac_prog", so it can be a program name with args.
+set dummy $ac_prog; ac_word=$2
+{ echo "$as_me:$LINENO: checking for $ac_word" >&5
+echo $ECHO_N "checking for $ac_word... $ECHO_C" >&6; }
+if test "${ac_cv_prog_ac_ct_CC+set}" = set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  if test -n "$ac_ct_CC"; then
+  ac_cv_prog_ac_ct_CC="$ac_ct_CC" # Let the user override the test.
+else
+as_save_IFS=$IFS; IFS=$PATH_SEPARATOR
+for as_dir in $PATH
+do
+  IFS=$as_save_IFS
+  test -z "$as_dir" && as_dir=.
+  for ac_exec_ext in '' $ac_executable_extensions; do
+  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_word$ac_exec_ext"; }; then
+    ac_cv_prog_ac_ct_CC="$ac_prog"
+    echo "$as_me:$LINENO: found $as_dir/$ac_word$ac_exec_ext" >&5
+    break 2
+  fi
+done
+done
+IFS=$as_save_IFS
+
+fi
+fi
+ac_ct_CC=$ac_cv_prog_ac_ct_CC
+if test -n "$ac_ct_CC"; then
+  { echo "$as_me:$LINENO: result: $ac_ct_CC" >&5
+echo "${ECHO_T}$ac_ct_CC" >&6; }
+else
+  { echo "$as_me:$LINENO: result: no" >&5
+echo "${ECHO_T}no" >&6; }
+fi
+
+
+  test -n "$ac_ct_CC" && break
+done
+
+  if test "x$ac_ct_CC" = x; then
+    CC=""
+  else
+    case $cross_compiling:$ac_tool_warned in
+yes:)
+{ echo "$as_me:$LINENO: WARNING: In the future, Autoconf will not detect cross-tools
+whose name does not start with the host triplet.  If you think this
+configuration is useful to you, please write to autoconf@gnu.org." >&5
+echo "$as_me: WARNING: In the future, Autoconf will not detect cross-tools
+whose name does not start with the host triplet.  If you think this
+configuration is useful to you, please write to autoconf@gnu.org." >&2;}
+ac_tool_warned=yes ;;
+esac
+    CC=$ac_ct_CC
+  fi
+fi
+
+fi
+
+
+test -z "$CC" && { { echo "$as_me:$LINENO: error: no acceptable C compiler found in \$PATH
+See \`config.log' for more details." >&5
+echo "$as_me: error: no acceptable C compiler found in \$PATH
+See \`config.log' for more details." >&2;}
+   { (exit 1); exit 1; }; }
+
+# Provide some information about the compiler.
+echo "$as_me:$LINENO: checking for C compiler version" >&5
+ac_compiler=`set X $ac_compile; echo $2`
+{ (ac_try="$ac_compiler --version >&5"
+case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=\$ac_try;;
+  *) ac_try_echo=$ac_try;;
+esac
+eval "echo \"\$as_me:$LINENO: $ac_try_echo\"") >&5
+  (eval "$ac_compiler --version >&5") 2>&5
+  ac_status=$?
+  echo "$as_me:$LINENO: \$? = $ac_status" >&5
+  (exit $ac_status); }
+{ (ac_try="$ac_compiler -v >&5"
+case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=\$ac_try;;
+  *) ac_try_echo=$ac_try;;
+esac
+eval "echo \"\$as_me:$LINENO: $ac_try_echo\"") >&5
+  (eval "$ac_compiler -v >&5") 2>&5
+  ac_status=$?
+  echo "$as_me:$LINENO: \$? = $ac_status" >&5
+  (exit $ac_status); }
+{ (ac_try="$ac_compiler -V >&5"
+case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=\$ac_try;;
+  *) ac_try_echo=$ac_try;;
+esac
+eval "echo \"\$as_me:$LINENO: $ac_try_echo\"") >&5
+  (eval "$ac_compiler -V >&5") 2>&5
+  ac_status=$?
+  echo "$as_me:$LINENO: \$? = $ac_status" >&5
+  (exit $ac_status); }
+
+{ echo "$as_me:$LINENO: checking whether we are using the GNU C compiler" >&5
+echo $ECHO_N "checking whether we are using the GNU C compiler... $ECHO_C" >&6; }
+if test "${ac_cv_c_compiler_gnu+set}" = set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+
+int
+main ()
+{
+#ifndef __GNUC__
+       choke me
+#endif
+
+  ;
+  return 0;
+}
+_ACEOF
+rm -f conftest.$ac_objext
+if { (ac_try="$ac_compile"
+case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=\$ac_try;;
+  *) ac_try_echo=$ac_try;;
+esac
+eval "echo \"\$as_me:$LINENO: $ac_try_echo\"") >&5
+  (eval "$ac_compile") 2>conftest.er1
+  ac_status=$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? = $ac_status" >&5
+  (exit $ac_status); } && {
+	 test -z "$ac_c_werror_flag" ||
+	 test ! -s conftest.err
+       } && test -s conftest.$ac_objext; then
+  ac_compiler_gnu=yes
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+	ac_compiler_gnu=no
+fi
+
+rm -f core conftest.err conftest.$ac_objext conftest.$ac_ext
+ac_cv_c_compiler_gnu=$ac_compiler_gnu
+
+fi
+{ echo "$as_me:$LINENO: result: $ac_cv_c_compiler_gnu" >&5
+echo "${ECHO_T}$ac_cv_c_compiler_gnu" >&6; }
+GCC=`test $ac_compiler_gnu = yes && echo yes`
+ac_test_CFLAGS=${CFLAGS+set}
+ac_save_CFLAGS=$CFLAGS
+{ echo "$as_me:$LINENO: checking whether $CC accepts -g" >&5
+echo $ECHO_N "checking whether $CC accepts -g... $ECHO_C" >&6; }
+if test "${ac_cv_prog_cc_g+set}" = set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  ac_save_c_werror_flag=$ac_c_werror_flag
+   ac_c_werror_flag=yes
+   ac_cv_prog_cc_g=no
+   CFLAGS="-g"
+   cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+
+int
+main ()
+{
+
+  ;
+  return 0;
+}
+_ACEOF
+rm -f conftest.$ac_objext
+if { (ac_try="$ac_compile"
+case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=\$ac_try;;
+  *) ac_try_echo=$ac_try;;
+esac
+eval "echo \"\$as_me:$LINENO: $ac_try_echo\"") >&5
+  (eval "$ac_compile") 2>conftest.er1
+  ac_status=$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? = $ac_status" >&5
+  (exit $ac_status); } && {
+	 test -z "$ac_c_werror_flag" ||
+	 test ! -s conftest.err
+       } && test -s conftest.$ac_objext; then
+  ac_cv_prog_cc_g=yes
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+	CFLAGS=""
+      cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+
+int
+main ()
+{
+
+  ;
+  return 0;
+}
+_ACEOF
+rm -f conftest.$ac_objext
+if { (ac_try="$ac_compile"
+case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=\$ac_try;;
+  *) ac_try_echo=$ac_try;;
+esac
+eval "echo \"\$as_me:$LINENO: $ac_try_echo\"") >&5
+  (eval "$ac_compile") 2>conftest.er1
+  ac_status=$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? = $ac_status" >&5
+  (exit $ac_status); } && {
+	 test -z "$ac_c_werror_flag" ||
+	 test ! -s conftest.err
+       } && test -s conftest.$ac_objext; then
+  :
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+	ac_c_werror_flag=$ac_save_c_werror_flag
+	 CFLAGS="-g"
+	 cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+
+int
+main ()
+{
+
+  ;
+  return 0;
+}
+_ACEOF
+rm -f conftest.$ac_objext
+if { (ac_try="$ac_compile"
+case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=\$ac_try;;
+  *) ac_try_echo=$ac_try;;
+esac
+eval "echo \"\$as_me:$LINENO: $ac_try_echo\"") >&5
+  (eval "$ac_compile") 2>conftest.er1
+  ac_status=$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? = $ac_status" >&5
+  (exit $ac_status); } && {
+	 test -z "$ac_c_werror_flag" ||
+	 test ! -s conftest.err
+       } && test -s conftest.$ac_objext; then
+  ac_cv_prog_cc_g=yes
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+
+fi
+
+rm -f core conftest.err conftest.$ac_objext conftest.$ac_ext
+fi
+
+rm -f core conftest.err conftest.$ac_objext conftest.$ac_ext
+fi
+
+rm -f core conftest.err conftest.$ac_objext conftest.$ac_ext
+   ac_c_werror_flag=$ac_save_c_werror_flag
+fi
+{ echo "$as_me:$LINENO: result: $ac_cv_prog_cc_g" >&5
+echo "${ECHO_T}$ac_cv_prog_cc_g" >&6; }
+if test "$ac_test_CFLAGS" = set; then
+  CFLAGS=$ac_save_CFLAGS
+elif test $ac_cv_prog_cc_g = yes; then
+  if test "$GCC" = yes; then
+    CFLAGS="-g -O2"
+  else
+    CFLAGS="-g"
+  fi
+else
+  if test "$GCC" = yes; then
+    CFLAGS="-O2"
+  else
+    CFLAGS=
+  fi
+fi
+{ echo "$as_me:$LINENO: checking for $CC option to accept ISO C89" >&5
+echo $ECHO_N "checking for $CC option to accept ISO C89... $ECHO_C" >&6; }
+if test "${ac_cv_prog_cc_c89+set}" = set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  ac_cv_prog_cc_c89=no
+ac_save_CC=$CC
+cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+#include <stdarg.h>
+#include <stdio.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+/* Most of the following tests are stolen from RCS 5.7's src/conf.sh.  */
+struct buf { int x; };
+FILE * (*rcsopen) (struct buf *, struct stat *, int);
+static char *e (p, i)
+     char **p;
+     int i;
+{
+  return p[i];
+}
+static char *f (char * (*g) (char **, int), char **p, ...)
+{
+  char *s;
+  va_list v;
+  va_start (v,p);
+  s = g (p, va_arg (v,int));
+  va_end (v);
+  return s;
+}
+
+/* OSF 4.0 Compaq cc is some sort of almost-ANSI by default.  It has
+   function prototypes and stuff, but not '\xHH' hex character constants.
+   These don't provoke an error unfortunately, instead are silently treated
+   as 'x'.  The following induces an error, until -std is added to get
+   proper ANSI mode.  Curiously '\x00'!='x' always comes out true, for an
+   array size at least.  It's necessary to write '\x00'==0 to get something
+   that's true only with -std.  */
+int osf4_cc_array ['\x00' == 0 ? 1 : -1];
+
+/* IBM C 6 for AIX is almost-ANSI by default, but it replaces macro parameters
+   inside strings and character constants.  */
+#define FOO(x) 'x'
+int xlc6_cc_array[FOO(a) == 'x' ? 1 : -1];
+
+int test (int i, double x);
+struct s1 {int (*f) (int a);};
+struct s2 {int (*f) (double a);};
+int pairnames (int, char **, FILE *(*)(struct buf *, struct stat *, int), int, int);
+int argc;
+char **argv;
+int
+main ()
+{
+return f (e, argv, 0) != argv[0]  ||  f (e, argv, 1) != argv[1];
+  ;
+  return 0;
+}
+_ACEOF
+for ac_arg in '' -qlanglvl=extc89 -qlanglvl=ansi -std \
+	-Ae "-Aa -D_HPUX_SOURCE" "-Xc -D__EXTENSIONS__"
+do
+  CC="$ac_save_CC $ac_arg"
+  rm -f conftest.$ac_objext
+if { (ac_try="$ac_compile"
+case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=\$ac_try;;
+  *) ac_try_echo=$ac_try;;
+esac
+eval "echo \"\$as_me:$LINENO: $ac_try_echo\"") >&5
+  (eval "$ac_compile") 2>conftest.er1
+  ac_status=$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? = $ac_status" >&5
+  (exit $ac_status); } && {
+	 test -z "$ac_c_werror_flag" ||
+	 test ! -s conftest.err
+       } && test -s conftest.$ac_objext; then
+  ac_cv_prog_cc_c89=$ac_arg
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+
+fi
+
+rm -f core conftest.err conftest.$ac_objext
+  test "x$ac_cv_prog_cc_c89" != "xno" && break
+done
+rm -f conftest.$ac_ext
+CC=$ac_save_CC
+
+fi
+# AC_CACHE_VAL
+case "x$ac_cv_prog_cc_c89" in
+  x)
+    { echo "$as_me:$LINENO: result: none needed" >&5
+echo "${ECHO_T}none needed" >&6; } ;;
+  xno)
+    { echo "$as_me:$LINENO: result: unsupported" >&5
+echo "${ECHO_T}unsupported" >&6; } ;;
+  *)
+    CC="$CC $ac_cv_prog_cc_c89"
+    { echo "$as_me:$LINENO: result: $ac_cv_prog_cc_c89" >&5
+echo "${ECHO_T}$ac_cv_prog_cc_c89" >&6; } ;;
+esac
+
+
+ac_ext=c
+ac_cpp='$CPP $CPPFLAGS'
+ac_compile='$CC -c $CFLAGS $CPPFLAGS conftest.$ac_ext >&5'
+ac_link='$CC -o conftest$ac_exeext $CFLAGS $CPPFLAGS $LDFLAGS conftest.$ac_ext $LIBS >&5'
+ac_compiler_gnu=$ac_cv_c_compiler_gnu
+
+depcc="$CC"   am_compiler_list=
+
+{ echo "$as_me:$LINENO: checking dependency style of $depcc" >&5
+echo $ECHO_N "checking dependency style of $depcc... $ECHO_C" >&6; }
+if test "${am_cv_CC_dependencies_compiler_type+set}" = set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  if test -z "$AMDEP_TRUE" && test -f "$am_depcomp"; then
+  # We make a subdir and do the tests there.  Otherwise we can end up
+  # making bogus files that we don't know about and never remove.  For
+  # instance it was reported that on HP-UX the gcc test will end up
+  # making a dummy file named `D' -- because `-MD' means `put the output
+  # in D'.
+  mkdir conftest.dir
+  # Copy depcomp to subdir because otherwise we won't find it if we're
+  # using a relative directory.
+  cp "$am_depcomp" conftest.dir
+  cd conftest.dir
+  # We will build objects and dependencies in a subdirectory because
+  # it helps to detect inapplicable dependency modes.  For instance
+  # both Tru64's cc and ICC support -MD to output dependencies as a
+  # side effect of compilation, but ICC will put the dependencies in
+  # the current directory while Tru64 will put them in the object
+  # directory.
+  mkdir sub
+
+  am_cv_CC_dependencies_compiler_type=none
+  if test "$am_compiler_list" = ""; then
+     am_compiler_list=`sed -n 's/^#*\([a-zA-Z0-9]*\))$/\1/p' < ./depcomp`
+  fi
+  for depmode in $am_compiler_list; do
+    # Setup a source with many dependencies, because some compilers
+    # like to wrap large dependency lists on column 80 (with \), and
+    # we should not choose a depcomp mode which is confused by this.
+    #
+    # We need to recreate these files for each test, as the compiler may
+    # overwrite some of them when testing with obscure command lines.
+    # This happens at least with the AIX C compiler.
+    : > sub/conftest.c
+    for i in 1 2 3 4 5 6; do
+      echo '#include "conftst'$i'.h"' >> sub/conftest.c
+      # Using `: > sub/conftst$i.h' creates only sub/conftst1.h with
+      # Solaris 8's {/usr,}/bin/sh.
+      touch sub/conftst$i.h
+    done
+    echo "${am__include} ${am__quote}sub/conftest.Po${am__quote}" > confmf
+
+    case $depmode in
+    nosideeffect)
+      # after this tag, mechanisms are not by side-effect, so they'll
+      # only be used when explicitly requested
+      if test "x$enable_dependency_tracking" = xyes; then
+	continue
+      else
+	break
+      fi
+      ;;
+    none) break ;;
+    esac
+    # We check with `-c' and `-o' for the sake of the "dashmstdout"
+    # mode.  It turns out that the SunPro C++ compiler does not properly
+    # handle `-M -o', and we need to detect this.
+    if depmode=$depmode \
+       source=sub/conftest.c object=sub/conftest.${OBJEXT-o} \
+       depfile=sub/conftest.Po tmpdepfile=sub/conftest.TPo \
+       $SHELL ./depcomp $depcc -c -o sub/conftest.${OBJEXT-o} sub/conftest.c \
+         >/dev/null 2>conftest.err &&
+       grep sub/conftst1.h sub/conftest.Po > /dev/null 2>&1 &&
+       grep sub/conftst6.h sub/conftest.Po > /dev/null 2>&1 &&
+       grep sub/conftest.${OBJEXT-o} sub/conftest.Po > /dev/null 2>&1 &&
+       ${MAKE-make} -s -f confmf > /dev/null 2>&1; then
+      # icc doesn't choke on unknown options, it will just issue warnings
+      # or remarks (even with -Werror).  So we grep stderr for any message
+      # that says an option was ignored or not supported.
+      # When given -MP, icc 7.0 and 7.1 complain thusly:
+      #   icc: Command line warning: ignoring option '-M'; no argument required
+      # The diagnosis changed in icc 8.0:
+      #   icc: Command line remark: option '-MP' not supported
+      if (grep 'ignoring option' conftest.err ||
+          grep 'not supported' conftest.err) >/dev/null 2>&1; then :; else
+        am_cv_CC_dependencies_compiler_type=$depmode
+        break
+      fi
+    fi
+  done
+
+  cd ..
+  rm -rf conftest.dir
+else
+  am_cv_CC_dependencies_compiler_type=none
+fi
+
+fi
+{ echo "$as_me:$LINENO: result: $am_cv_CC_dependencies_compiler_type" >&5
+echo "${ECHO_T}$am_cv_CC_dependencies_compiler_type" >&6; }
+CCDEPMODE=depmode=$am_cv_CC_dependencies_compiler_type
+
+ if
+  test "x$enable_dependency_tracking" != xno \
+  && test "$am_cv_CC_dependencies_compiler_type" = gcc3; then
+  am__fastdepCC_TRUE=
+  am__fastdepCC_FALSE='#'
+else
+  am__fastdepCC_TRUE='#'
+  am__fastdepCC_FALSE=
+fi
+
+
+
+
+{ echo "$as_me:$LINENO: checking for main in -lm" >&5
+echo $ECHO_N "checking for main in -lm... $ECHO_C" >&6; }
+if test "${ac_cv_lib_m_main+set}" = set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  ac_check_lib_save_LIBS=$LIBS
+LIBS="-lm  $LIBS"
+cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+
+
+int
+main ()
+{
+return main ();
+  ;
+  return 0;
+}
+_ACEOF
+rm -f conftest.$ac_objext conftest$ac_exeext
+if { (ac_try="$ac_link"
+case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=\$ac_try;;
+  *) ac_try_echo=$ac_try;;
+esac
+eval "echo \"\$as_me:$LINENO: $ac_try_echo\"") >&5
+  (eval "$ac_link") 2>conftest.er1
+  ac_status=$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? = $ac_status" >&5
+  (exit $ac_status); } && {
+	 test -z "$ac_c_werror_flag" ||
+	 test ! -s conftest.err
+       } && test -s conftest$ac_exeext &&
+       $as_test_x conftest$ac_exeext; then
+  ac_cv_lib_m_main=yes
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+	ac_cv_lib_m_main=no
+fi
+
+rm -f core conftest.err conftest.$ac_objext conftest_ipa8_conftest.oo \
+      conftest$ac_exeext conftest.$ac_ext
+LIBS=$ac_check_lib_save_LIBS
+fi
+{ echo "$as_me:$LINENO: result: $ac_cv_lib_m_main" >&5
+echo "${ECHO_T}$ac_cv_lib_m_main" >&6; }
+if test $ac_cv_lib_m_main = yes; then
+  cat >>confdefs.h <<_ACEOF
+#define HAVE_LIBM 1
+_ACEOF
+
+  LIBS="-lm $LIBS"
+
+fi
+
+
+{ echo "$as_me:$LINENO: checking for main in -lpthread" >&5
+echo $ECHO_N "checking for main in -lpthread... $ECHO_C" >&6; }
+if test "${ac_cv_lib_pthread_main+set}" = set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  ac_check_lib_save_LIBS=$LIBS
+LIBS="-lpthread  $LIBS"
+cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+
+
+int
+main ()
+{
+return main ();
+  ;
+  return 0;
+}
+_ACEOF
+rm -f conftest.$ac_objext conftest$ac_exeext
+if { (ac_try="$ac_link"
+case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=\$ac_try;;
+  *) ac_try_echo=$ac_try;;
+esac
+eval "echo \"\$as_me:$LINENO: $ac_try_echo\"") >&5
+  (eval "$ac_link") 2>conftest.er1
+  ac_status=$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? = $ac_status" >&5
+  (exit $ac_status); } && {
+	 test -z "$ac_c_werror_flag" ||
+	 test ! -s conftest.err
+       } && test -s conftest$ac_exeext &&
+       $as_test_x conftest$ac_exeext; then
+  ac_cv_lib_pthread_main=yes
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+	ac_cv_lib_pthread_main=no
+fi
+
+rm -f core conftest.err conftest.$ac_objext conftest_ipa8_conftest.oo \
+      conftest$ac_exeext conftest.$ac_ext
+LIBS=$ac_check_lib_save_LIBS
+fi
+{ echo "$as_me:$LINENO: result: $ac_cv_lib_pthread_main" >&5
+echo "${ECHO_T}$ac_cv_lib_pthread_main" >&6; }
+if test $ac_cv_lib_pthread_main = yes; then
+  cat >>confdefs.h <<_ACEOF
+#define HAVE_LIBPTHREAD 1
+_ACEOF
+
+  LIBS="-lpthread $LIBS"
+
+fi
+
+
+
+{ echo "$as_me:$LINENO: checking for ANSI C header files" >&5
+echo $ECHO_N "checking for ANSI C header files... $ECHO_C" >&6; }
+if test "${ac_cv_header_stdc+set}" = set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+#include <stdlib.h>
+#include <stdarg.h>
+#include <string.h>
+#include <float.h>
+
+int
+main ()
+{
+
+  ;
+  return 0;
+}
+_ACEOF
+rm -f conftest.$ac_objext
+if { (ac_try="$ac_compile"
+case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=\$ac_try;;
+  *) ac_try_echo=$ac_try;;
+esac
+eval "echo \"\$as_me:$LINENO: $ac_try_echo\"") >&5
+  (eval "$ac_compile") 2>conftest.er1
+  ac_status=$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? = $ac_status" >&5
+  (exit $ac_status); } && {
+	 test -z "$ac_c_werror_flag" ||
+	 test ! -s conftest.err
+       } && test -s conftest.$ac_objext; then
+  ac_cv_header_stdc=yes
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+	ac_cv_header_stdc=no
+fi
+
+rm -f core conftest.err conftest.$ac_objext conftest.$ac_ext
+
+if test $ac_cv_header_stdc = yes; then
+  # SunOS 4.x string.h does not declare mem*, contrary to ANSI.
+  cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+#include <string.h>
+
+_ACEOF
+if (eval "$ac_cpp conftest.$ac_ext") 2>&5 |
+  $EGREP "memchr" >/dev/null 2>&1; then
+  :
+else
+  ac_cv_header_stdc=no
+fi
+rm -f conftest*
+
+fi
+
+if test $ac_cv_header_stdc = yes; then
+  # ISC 2.0.2 stdlib.h does not declare free, contrary to ANSI.
+  cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+#include <stdlib.h>
+
+_ACEOF
+if (eval "$ac_cpp conftest.$ac_ext") 2>&5 |
+  $EGREP "free" >/dev/null 2>&1; then
+  :
+else
+  ac_cv_header_stdc=no
+fi
+rm -f conftest*
+
+fi
+
+if test $ac_cv_header_stdc = yes; then
+  # /bin/cc in Irix-4.0.5 gets non-ANSI ctype macros unless using -ansi.
+  if test "$cross_compiling" = yes; then
+  :
+else
+  cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+#include <ctype.h>
+#include <stdlib.h>
+#if ((' ' & 0x0FF) == 0x020)
+# define ISLOWER(c) ('a' <= (c) && (c) <= 'z')
+# define TOUPPER(c) (ISLOWER(c) ? 'A' + ((c) - 'a') : (c))
+#else
+# define ISLOWER(c) \
+		   (('a' <= (c) && (c) <= 'i') \
+		     || ('j' <= (c) && (c) <= 'r') \
+		     || ('s' <= (c) && (c) <= 'z'))
+# define TOUPPER(c) (ISLOWER(c) ? ((c) | 0x40) : (c))
+#endif
+
+#define XOR(e, f) (((e) && !(f)) || (!(e) && (f)))
+int
+main ()
+{
+  int i;
+  for (i = 0; i < 256; i++)
+    if (XOR (islower (i), ISLOWER (i))
+	|| toupper (i) != TOUPPER (i))
+      return 2;
+  return 0;
+}
+_ACEOF
+rm -f conftest$ac_exeext
+if { (ac_try="$ac_link"
+case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=\$ac_try;;
+  *) ac_try_echo=$ac_try;;
+esac
+eval "echo \"\$as_me:$LINENO: $ac_try_echo\"") >&5
+  (eval "$ac_link") 2>&5
+  ac_status=$?
+  echo "$as_me:$LINENO: \$? = $ac_status" >&5
+  (exit $ac_status); } && { ac_try='./conftest$ac_exeext'
+  { (case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=\$ac_try;;
+  *) ac_try_echo=$ac_try;;
+esac
+eval "echo \"\$as_me:$LINENO: $ac_try_echo\"") >&5
+  (eval "$ac_try") 2>&5
+  ac_status=$?
+  echo "$as_me:$LINENO: \$? = $ac_status" >&5
+  (exit $ac_status); }; }; then
+  :
+else
+  echo "$as_me: program exited with status $ac_status" >&5
+echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+( exit $ac_status )
+ac_cv_header_stdc=no
+fi
+rm -f core *.core core.conftest.* gmon.out bb.out conftest$ac_exeext conftest.$ac_objext conftest.$ac_ext
+fi
+
+
+fi
+fi
+{ echo "$as_me:$LINENO: result: $ac_cv_header_stdc" >&5
+echo "${ECHO_T}$ac_cv_header_stdc" >&6; }
+if test $ac_cv_header_stdc = yes; then
+
+cat >>confdefs.h <<\_ACEOF
+#define STDC_HEADERS 1
+_ACEOF
+
+fi
+
+{ echo "$as_me:$LINENO: checking for sys/wait.h that is POSIX.1 compatible" >&5
+echo $ECHO_N "checking for sys/wait.h that is POSIX.1 compatible... $ECHO_C" >&6; }
+if test "${ac_cv_header_sys_wait_h+set}" = set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+#include <sys/types.h>
+#include <sys/wait.h>
+#ifndef WEXITSTATUS
+# define WEXITSTATUS(stat_val) ((unsigned int) (stat_val) >> 8)
+#endif
+#ifndef WIFEXITED
+# define WIFEXITED(stat_val) (((stat_val) & 255) == 0)
+#endif
+
+int
+main ()
+{
+  int s;
+  wait (&s);
+  s = WIFEXITED (s) ? WEXITSTATUS (s) : 1;
+  ;
+  return 0;
+}
+_ACEOF
+rm -f conftest.$ac_objext
+if { (ac_try="$ac_compile"
+case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=\$ac_try;;
+  *) ac_try_echo=$ac_try;;
+esac
+eval "echo \"\$as_me:$LINENO: $ac_try_echo\"") >&5
+  (eval "$ac_compile") 2>conftest.er1
+  ac_status=$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? = $ac_status" >&5
+  (exit $ac_status); } && {
+	 test -z "$ac_c_werror_flag" ||
+	 test ! -s conftest.err
+       } && test -s conftest.$ac_objext; then
+  ac_cv_header_sys_wait_h=yes
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+	ac_cv_header_sys_wait_h=no
+fi
+
+rm -f core conftest.err conftest.$ac_objext conftest.$ac_ext
+fi
+{ echo "$as_me:$LINENO: result: $ac_cv_header_sys_wait_h" >&5
+echo "${ECHO_T}$ac_cv_header_sys_wait_h" >&6; }
+if test $ac_cv_header_sys_wait_h = yes; then
+
+cat >>confdefs.h <<\_ACEOF
+#define HAVE_SYS_WAIT_H 1
+_ACEOF
+
+fi
+
+# On IRIX 5.3, sys/types and inttypes.h are conflicting.
+
+
+
+
+
+
+
+
+
+for ac_header in sys/types.h sys/stat.h stdlib.h string.h memory.h strings.h \
+		  inttypes.h stdint.h unistd.h
+do
+as_ac_Header=`echo "ac_cv_header_$ac_header" | $as_tr_sh`
+{ echo "$as_me:$LINENO: checking for $ac_header" >&5
+echo $ECHO_N "checking for $ac_header... $ECHO_C" >&6; }
+if { as_var=$as_ac_Header; eval "test \"\${$as_var+set}\" = set"; }; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+$ac_includes_default
+
+#include <$ac_header>
+_ACEOF
+rm -f conftest.$ac_objext
+if { (ac_try="$ac_compile"
+case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=\$ac_try;;
+  *) ac_try_echo=$ac_try;;
+esac
+eval "echo \"\$as_me:$LINENO: $ac_try_echo\"") >&5
+  (eval "$ac_compile") 2>conftest.er1
+  ac_status=$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? = $ac_status" >&5
+  (exit $ac_status); } && {
+	 test -z "$ac_c_werror_flag" ||
+	 test ! -s conftest.err
+       } && test -s conftest.$ac_objext; then
+  eval "$as_ac_Header=yes"
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+	eval "$as_ac_Header=no"
+fi
+
+rm -f core conftest.err conftest.$ac_objext conftest.$ac_ext
+fi
+ac_res=`eval echo '${'$as_ac_Header'}'`
+	       { echo "$as_me:$LINENO: result: $ac_res" >&5
+echo "${ECHO_T}$ac_res" >&6; }
+if test `eval echo '${'$as_ac_Header'}'` = yes; then
+  cat >>confdefs.h <<_ACEOF
+#define `echo "HAVE_$ac_header" | $as_tr_cpp` 1
+_ACEOF
+
+fi
+
+done
+
+
+
+
+
+
+
+
+
+
+for ac_header in pthread.h fcntl.h limits.h stdint.h sys/time.h unistd.h sys/vfs.h sys/limits.h
+do
+as_ac_Header=`echo "ac_cv_header_$ac_header" | $as_tr_sh`
+if { as_var=$as_ac_Header; eval "test \"\${$as_var+set}\" = set"; }; then
+  { echo "$as_me:$LINENO: checking for $ac_header" >&5
+echo $ECHO_N "checking for $ac_header... $ECHO_C" >&6; }
+if { as_var=$as_ac_Header; eval "test \"\${$as_var+set}\" = set"; }; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+fi
+ac_res=`eval echo '${'$as_ac_Header'}'`
+	       { echo "$as_me:$LINENO: result: $ac_res" >&5
+echo "${ECHO_T}$ac_res" >&6; }
+else
+  # Is the header compilable?
+{ echo "$as_me:$LINENO: checking $ac_header usability" >&5
+echo $ECHO_N "checking $ac_header usability... $ECHO_C" >&6; }
+cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+$ac_includes_default
+#include <$ac_header>
+_ACEOF
+rm -f conftest.$ac_objext
+if { (ac_try="$ac_compile"
+case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=\$ac_try;;
+  *) ac_try_echo=$ac_try;;
+esac
+eval "echo \"\$as_me:$LINENO: $ac_try_echo\"") >&5
+  (eval "$ac_compile") 2>conftest.er1
+  ac_status=$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? = $ac_status" >&5
+  (exit $ac_status); } && {
+	 test -z "$ac_c_werror_flag" ||
+	 test ! -s conftest.err
+       } && test -s conftest.$ac_objext; then
+  ac_header_compiler=yes
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+	ac_header_compiler=no
+fi
+
+rm -f core conftest.err conftest.$ac_objext conftest.$ac_ext
+{ echo "$as_me:$LINENO: result: $ac_header_compiler" >&5
+echo "${ECHO_T}$ac_header_compiler" >&6; }
+
+# Is the header present?
+{ echo "$as_me:$LINENO: checking $ac_header presence" >&5
+echo $ECHO_N "checking $ac_header presence... $ECHO_C" >&6; }
+cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+#include <$ac_header>
+_ACEOF
+if { (ac_try="$ac_cpp conftest.$ac_ext"
+case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=\$ac_try;;
+  *) ac_try_echo=$ac_try;;
+esac
+eval "echo \"\$as_me:$LINENO: $ac_try_echo\"") >&5
+  (eval "$ac_cpp conftest.$ac_ext") 2>conftest.er1
+  ac_status=$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? = $ac_status" >&5
+  (exit $ac_status); } >/dev/null && {
+	 test -z "$ac_c_preproc_warn_flag$ac_c_werror_flag" ||
+	 test ! -s conftest.err
+       }; then
+  ac_header_preproc=yes
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+  ac_header_preproc=no
+fi
+
+rm -f conftest.err conftest.$ac_ext
+{ echo "$as_me:$LINENO: result: $ac_header_preproc" >&5
+echo "${ECHO_T}$ac_header_preproc" >&6; }
+
+# So?  What about this header?
+case $ac_header_compiler:$ac_header_preproc:$ac_c_preproc_warn_flag in
+  yes:no: )
+    { echo "$as_me:$LINENO: WARNING: $ac_header: accepted by the compiler, rejected by the preprocessor!" >&5
+echo "$as_me: WARNING: $ac_header: accepted by the compiler, rejected by the preprocessor!" >&2;}
+    { echo "$as_me:$LINENO: WARNING: $ac_header: proceeding with the compiler's result" >&5
+echo "$as_me: WARNING: $ac_header: proceeding with the compiler's result" >&2;}
+    ac_header_preproc=yes
+    ;;
+  no:yes:* )
+    { echo "$as_me:$LINENO: WARNING: $ac_header: present but cannot be compiled" >&5
+echo "$as_me: WARNING: $ac_header: present but cannot be compiled" >&2;}
+    { echo "$as_me:$LINENO: WARNING: $ac_header:     check for missing prerequisite headers?" >&5
+echo "$as_me: WARNING: $ac_header:     check for missing prerequisite headers?" >&2;}
+    { echo "$as_me:$LINENO: WARNING: $ac_header: see the Autoconf documentation" >&5
+echo "$as_me: WARNING: $ac_header: see the Autoconf documentation" >&2;}
+    { echo "$as_me:$LINENO: WARNING: $ac_header:     section \"Present But Cannot Be Compiled\"" >&5
+echo "$as_me: WARNING: $ac_header:     section \"Present But Cannot Be Compiled\"" >&2;}
+    { echo "$as_me:$LINENO: WARNING: $ac_header: proceeding with the preprocessor's result" >&5
+echo "$as_me: WARNING: $ac_header: proceeding with the preprocessor's result" >&2;}
+    { echo "$as_me:$LINENO: WARNING: $ac_header: in the future, the compiler will take precedence" >&5
+echo "$as_me: WARNING: $ac_header: in the future, the compiler will take precedence" >&2;}
+
+    ;;
+esac
+{ echo "$as_me:$LINENO: checking for $ac_header" >&5
+echo $ECHO_N "checking for $ac_header... $ECHO_C" >&6; }
+if { as_var=$as_ac_Header; eval "test \"\${$as_var+set}\" = set"; }; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  eval "$as_ac_Header=\$ac_header_preproc"
+fi
+ac_res=`eval echo '${'$as_ac_Header'}'`
+	       { echo "$as_me:$LINENO: result: $ac_res" >&5
+echo "${ECHO_T}$ac_res" >&6; }
+
+fi
+if test `eval echo '${'$as_ac_Header'}'` = yes; then
+  cat >>confdefs.h <<_ACEOF
+#define `echo "HAVE_$ac_header" | $as_tr_cpp` 1
+_ACEOF
+
+fi
+
+done
+
+
+{ echo "$as_me:$LINENO: checking for an ANSI C-conforming const" >&5
+echo $ECHO_N "checking for an ANSI C-conforming const... $ECHO_C" >&6; }
+if test "${ac_cv_c_const+set}" = set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+
+int
+main ()
+{
+/* FIXME: Include the comments suggested by Paul. */
+#ifndef __cplusplus
+  /* Ultrix mips cc rejects this.  */
+  typedef int charset[2];
+  const charset cs;
+  /* SunOS 4.1.1 cc rejects this.  */
+  char const *const *pcpcc;
+  char **ppc;
+  /* NEC SVR4.0.2 mips cc rejects this.  */
+  struct point {int x, y;};
+  static struct point const zero = {0,0};
+  /* AIX XL C 1.02.0.0 rejects this.
+     It does not let you subtract one const X* pointer from another in
+     an arm of an if-expression whose if-part is not a constant
+     expression */
+  const char *g = "string";
+  pcpcc = &g + (g ? g-g : 0);
+  /* HPUX 7.0 cc rejects these. */
+  ++pcpcc;
+  ppc = (char**) pcpcc;
+  pcpcc = (char const *const *) ppc;
+  { /* SCO 3.2v4 cc rejects this.  */
+    char *t;
+    char const *s = 0 ? (char *) 0 : (char const *) 0;
+
+    *t++ = 0;
+    if (s) return 0;
+  }
+  { /* Someone thinks the Sun supposedly-ANSI compiler will reject this.  */
+    int x[] = {25, 17};
+    const int *foo = &x[0];
+    ++foo;
+  }
+  { /* Sun SC1.0 ANSI compiler rejects this -- but not the above. */
+    typedef const int *iptr;
+    iptr p = 0;
+    ++p;
+  }
+  { /* AIX XL C 1.02.0.0 rejects this saying
+       "k.c", line 2.27: 1506-025 (S) Operand must be a modifiable lvalue. */
+    struct s { int j; const int *ap[3]; };
+    struct s *b; b->j = 5;
+  }
+  { /* ULTRIX-32 V3.1 (Rev 9) vcc rejects this */
+    const int foo = 10;
+    if (!foo) return 0;
+  }
+  return !cs[0] && !zero.x;
+#endif
+
+  ;
+  return 0;
+}
+_ACEOF
+rm -f conftest.$ac_objext
+if { (ac_try="$ac_compile"
+case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=\$ac_try;;
+  *) ac_try_echo=$ac_try;;
+esac
+eval "echo \"\$as_me:$LINENO: $ac_try_echo\"") >&5
+  (eval "$ac_compile") 2>conftest.er1
+  ac_status=$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? = $ac_status" >&5
+  (exit $ac_status); } && {
+	 test -z "$ac_c_werror_flag" ||
+	 test ! -s conftest.err
+       } && test -s conftest.$ac_objext; then
+  ac_cv_c_const=yes
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+	ac_cv_c_const=no
+fi
+
+rm -f core conftest.err conftest.$ac_objext conftest.$ac_ext
+fi
+{ echo "$as_me:$LINENO: result: $ac_cv_c_const" >&5
+echo "${ECHO_T}$ac_cv_c_const" >&6; }
+if test $ac_cv_c_const = no; then
+
+cat >>confdefs.h <<\_ACEOF
+#define const
+_ACEOF
+
+fi
+
+{ echo "$as_me:$LINENO: checking whether time.h and sys/time.h may both be included" >&5
+echo $ECHO_N "checking whether time.h and sys/time.h may both be included... $ECHO_C" >&6; }
+if test "${ac_cv_header_time+set}" = set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+#include <sys/types.h>
+#include <sys/time.h>
+#include <time.h>
+
+int
+main ()
+{
+if ((struct tm *) 0)
+return 0;
+  ;
+  return 0;
+}
+_ACEOF
+rm -f conftest.$ac_objext
+if { (ac_try="$ac_compile"
+case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=\$ac_try;;
+  *) ac_try_echo=$ac_try;;
+esac
+eval "echo \"\$as_me:$LINENO: $ac_try_echo\"") >&5
+  (eval "$ac_compile") 2>conftest.er1
+  ac_status=$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? = $ac_status" >&5
+  (exit $ac_status); } && {
+	 test -z "$ac_c_werror_flag" ||
+	 test ! -s conftest.err
+       } && test -s conftest.$ac_objext; then
+  ac_cv_header_time=yes
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+	ac_cv_header_time=no
+fi
+
+rm -f core conftest.err conftest.$ac_objext conftest.$ac_ext
+fi
+{ echo "$as_me:$LINENO: result: $ac_cv_header_time" >&5
+echo "${ECHO_T}$ac_cv_header_time" >&6; }
+if test $ac_cv_header_time = yes; then
+
+cat >>confdefs.h <<\_ACEOF
+#define TIME_WITH_SYS_TIME 1
+_ACEOF
+
+fi
+
+
+{ echo "$as_me:$LINENO: checking for function prototypes" >&5
+echo $ECHO_N "checking for function prototypes... $ECHO_C" >&6; }
+if test "$ac_cv_prog_cc_c89" != no; then
+  { echo "$as_me:$LINENO: result: yes" >&5
+echo "${ECHO_T}yes" >&6; }
+
+cat >>confdefs.h <<\_ACEOF
+#define PROTOTYPES 1
+_ACEOF
+
+
+cat >>confdefs.h <<\_ACEOF
+#define __PROTOTYPES 1
+_ACEOF
+
+else
+  { echo "$as_me:$LINENO: result: no" >&5
+echo "${ECHO_T}no" >&6; }
+fi
+
+{ echo "$as_me:$LINENO: checking whether setvbuf arguments are reversed" >&5
+echo $ECHO_N "checking whether setvbuf arguments are reversed... $ECHO_C" >&6; }
+if test "${ac_cv_func_setvbuf_reversed+set}" = set; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  ac_cv_func_setvbuf_reversed=no
+   cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+#include <stdio.h>
+#	  ifdef PROTOTYPES
+	   int (setvbuf) (FILE *, int, char *, size_t);
+#	  endif
+int
+main ()
+{
+char buf; return setvbuf (stdout, _IOLBF, &buf, 1);
+  ;
+  return 0;
+}
+_ACEOF
+rm -f conftest.$ac_objext conftest$ac_exeext
+if { (ac_try="$ac_link"
+case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=\$ac_try;;
+  *) ac_try_echo=$ac_try;;
+esac
+eval "echo \"\$as_me:$LINENO: $ac_try_echo\"") >&5
+  (eval "$ac_link") 2>conftest.er1
+  ac_status=$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? = $ac_status" >&5
+  (exit $ac_status); } && {
+	 test -z "$ac_c_werror_flag" ||
+	 test ! -s conftest.err
+       } && test -s conftest$ac_exeext &&
+       $as_test_x conftest$ac_exeext; then
+  cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+#include <stdio.h>
+#	     ifdef PROTOTYPES
+	      int (setvbuf) (FILE *, int, char *, size_t);
+#	     endif
+int
+main ()
+{
+char buf; return setvbuf (stdout, &buf, _IOLBF, 1);
+  ;
+  return 0;
+}
+_ACEOF
+rm -f conftest.$ac_objext conftest$ac_exeext
+if { (ac_try="$ac_link"
+case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=\$ac_try;;
+  *) ac_try_echo=$ac_try;;
+esac
+eval "echo \"\$as_me:$LINENO: $ac_try_echo\"") >&5
+  (eval "$ac_link") 2>conftest.er1
+  ac_status=$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? = $ac_status" >&5
+  (exit $ac_status); } && {
+	 test -z "$ac_c_werror_flag" ||
+	 test ! -s conftest.err
+       } && test -s conftest$ac_exeext &&
+       $as_test_x conftest$ac_exeext; then
+  # It compiles and links either way, so it must not be declared
+	 # with a prototype and most likely this is a K&R C compiler.
+	 # Try running it.
+	 if test "$cross_compiling" = yes; then
+  : # Assume setvbuf is not reversed when cross-compiling.
+else
+  cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+$ac_includes_default
+int
+main ()
+{
+/* This call has the arguments reversed.
+		   A reversed system may check and see that the address of buf
+		   is not _IOLBF, _IONBF, or _IOFBF, and return nonzero.  */
+		char buf;
+		if (setvbuf (stdout, _IOLBF, &buf, 1) != 0)
+		  return 1;
+		putchar ('\r');
+		return 0; /* Non-reversed systems SEGV here.  */
+  ;
+  return 0;
+}
+_ACEOF
+rm -f conftest$ac_exeext
+if { (ac_try="$ac_link"
+case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=\$ac_try;;
+  *) ac_try_echo=$ac_try;;
+esac
+eval "echo \"\$as_me:$LINENO: $ac_try_echo\"") >&5
+  (eval "$ac_link") 2>&5
+  ac_status=$?
+  echo "$as_me:$LINENO: \$? = $ac_status" >&5
+  (exit $ac_status); } && { ac_try='./conftest$ac_exeext'
+  { (case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=\$ac_try;;
+  *) ac_try_echo=$ac_try;;
+esac
+eval "echo \"\$as_me:$LINENO: $ac_try_echo\"") >&5
+  (eval "$ac_try") 2>&5
+  ac_status=$?
+  echo "$as_me:$LINENO: \$? = $ac_status" >&5
+  (exit $ac_status); }; }; then
+  ac_cv_func_setvbuf_reversed=yes
+else
+  echo "$as_me: program exited with status $ac_status" >&5
+echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+fi
+rm -f core *.core core.conftest.* gmon.out bb.out conftest$ac_exeext conftest.$ac_objext conftest.$ac_ext
+fi
+
+
+	ac_cv_func_setvbuf_reversed=yes
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+
+fi
+
+rm -f core conftest.err conftest.$ac_objext conftest_ipa8_conftest.oo \
+      conftest$ac_exeext conftest.$ac_ext
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+
+fi
+
+rm -f core conftest.err conftest.$ac_objext conftest_ipa8_conftest.oo \
+      conftest$ac_exeext conftest.$ac_ext
+fi
+{ echo "$as_me:$LINENO: result: $ac_cv_func_setvbuf_reversed" >&5
+echo "${ECHO_T}$ac_cv_func_setvbuf_reversed" >&6; }
+if test $ac_cv_func_setvbuf_reversed = yes; then
+
+cat >>confdefs.h <<\_ACEOF
+#define SETVBUF_REVERSED 1
+_ACEOF
+
+fi
+
+
+
+
+
+
+
+
+
+
+for ac_func in system gettimeofday mkdir strerror open64 stat64 fseeko64 lrand48_r srand48_r
+do
+as_ac_var=`echo "ac_cv_func_$ac_func" | $as_tr_sh`
+{ echo "$as_me:$LINENO: checking for $ac_func" >&5
+echo $ECHO_N "checking for $ac_func... $ECHO_C" >&6; }
+if { as_var=$as_ac_var; eval "test \"\${$as_var+set}\" = set"; }; then
+  echo $ECHO_N "(cached) $ECHO_C" >&6
+else
+  cat >conftest.$ac_ext <<_ACEOF
+/* confdefs.h.  */
+_ACEOF
+cat confdefs.h >>conftest.$ac_ext
+cat >>conftest.$ac_ext <<_ACEOF
+/* end confdefs.h.  */
+/* Define $ac_func to an innocuous variant, in case <limits.h> declares $ac_func.
+   For example, HP-UX 11i <limits.h> declares gettimeofday.  */
+#define $ac_func innocuous_$ac_func
+
+/* System header to define __stub macros and hopefully few prototypes,
+    which can conflict with char $ac_func (); below.
+    Prefer <limits.h> to <assert.h> if __STDC__ is defined, since
+    <limits.h> exists even on freestanding compilers.  */
+
+#ifdef __STDC__
+# include <limits.h>
+#else
+# include <assert.h>
+#endif
+
+#undef $ac_func
+
+/* Override any GCC internal prototype to avoid an error.
+   Use char because int might match the return type of a GCC
+   builtin and then its argument prototype would still apply.  */
+#ifdef __cplusplus
+extern "C"
+#endif
+char $ac_func ();
+/* The GNU C library defines this for functions which it implements
+    to always fail with ENOSYS.  Some functions are actually named
+    something starting with __ and the normal name is an alias.  */
+#if defined __stub_$ac_func || defined __stub___$ac_func
+choke me
+#endif
+
+int
+main ()
+{
+return $ac_func ();
+  ;
+  return 0;
+}
+_ACEOF
+rm -f conftest.$ac_objext conftest$ac_exeext
+if { (ac_try="$ac_link"
+case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=\$ac_try;;
+  *) ac_try_echo=$ac_try;;
+esac
+eval "echo \"\$as_me:$LINENO: $ac_try_echo\"") >&5
+  (eval "$ac_link") 2>conftest.er1
+  ac_status=$?
+  grep -v '^ *+' conftest.er1 >conftest.err
+  rm -f conftest.er1
+  cat conftest.err >&5
+  echo "$as_me:$LINENO: \$? = $ac_status" >&5
+  (exit $ac_status); } && {
+	 test -z "$ac_c_werror_flag" ||
+	 test ! -s conftest.err
+       } && test -s conftest$ac_exeext &&
+       $as_test_x conftest$ac_exeext; then
+  eval "$as_ac_var=yes"
+else
+  echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+	eval "$as_ac_var=no"
+fi
+
+rm -f core conftest.err conftest.$ac_objext conftest_ipa8_conftest.oo \
+      conftest$ac_exeext conftest.$ac_ext
+fi
+ac_res=`eval echo '${'$as_ac_var'}'`
+	       { echo "$as_me:$LINENO: result: $ac_res" >&5
+echo "${ECHO_T}$ac_res" >&6; }
+if test `eval echo '${'$as_ac_var'}'` = yes; then
+  cat >>confdefs.h <<_ACEOF
+#define `echo "HAVE_$ac_func" | $as_tr_cpp` 1
+_ACEOF
+
+fi
+done
+
+
+
+
+ac_config_files="$ac_config_files Makefile"
+
+ac_config_commands="$ac_config_commands default"
+
+cat >confcache <<\_ACEOF
+# This file is a shell script that caches the results of configure
+# tests run on this system so they can be shared between configure
+# scripts and configure runs, see configure's option --config-cache.
+# It is not useful on other systems.  If it contains results you don't
+# want to keep, you may remove or edit it.
+#
+# config.status only pays attention to the cache file if you give it
+# the --recheck option to rerun configure.
+#
+# `ac_cv_env_foo' variables (set or unset) will be overridden when
+# loading this file, other *unset* `ac_cv_foo' will be assigned the
+# following values.
+
+_ACEOF
+
+# The following way of writing the cache mishandles newlines in values,
+# but we know of no workaround that is simple, portable, and efficient.
+# So, we kill variables containing newlines.
+# Ultrix sh set writes to stderr and can't be redirected directly,
+# and sets the high bit in the cache file unless we assign to the vars.
+(
+  for ac_var in `(set) 2>&1 | sed -n 's/^\([a-zA-Z_][a-zA-Z0-9_]*\)=.*/\1/p'`; do
+    eval ac_val=\$$ac_var
+    case $ac_val in #(
+    *${as_nl}*)
+      case $ac_var in #(
+      *_cv_*) { echo "$as_me:$LINENO: WARNING: Cache variable $ac_var contains a newline." >&5
+echo "$as_me: WARNING: Cache variable $ac_var contains a newline." >&2;} ;;
+      esac
+      case $ac_var in #(
+      _ | IFS | as_nl) ;; #(
+      *) $as_unset $ac_var ;;
+      esac ;;
+    esac
+  done
+
+  (set) 2>&1 |
+    case $as_nl`(ac_space=' '; set) 2>&1` in #(
+    *${as_nl}ac_space=\ *)
+      # `set' does not quote correctly, so add quotes (double-quote
+      # substitution turns \\\\ into \\, and sed turns \\ into \).
+      sed -n \
+	"s/'/'\\\\''/g;
+	  s/^\\([_$as_cr_alnum]*_cv_[_$as_cr_alnum]*\\)=\\(.*\\)/\\1='\\2'/p"
+      ;; #(
+    *)
+      # `set' quotes correctly as required by POSIX, so do not add quotes.
+      sed -n "/^[_$as_cr_alnum]*_cv_[_$as_cr_alnum]*=/p"
+      ;;
+    esac |
+    sort
+) |
+  sed '
+     /^ac_cv_env_/b end
+     t clear
+     :clear
+     s/^\([^=]*\)=\(.*[{}].*\)$/test "${\1+set}" = set || &/
+     t end
+     s/^\([^=]*\)=\(.*\)$/\1=${\1=\2}/
+     :end' >>confcache
+if diff "$cache_file" confcache >/dev/null 2>&1; then :; else
+  if test -w "$cache_file"; then
+    test "x$cache_file" != "x/dev/null" &&
+      { echo "$as_me:$LINENO: updating cache $cache_file" >&5
+echo "$as_me: updating cache $cache_file" >&6;}
+    cat confcache >$cache_file
+  else
+    { echo "$as_me:$LINENO: not updating unwritable cache $cache_file" >&5
+echo "$as_me: not updating unwritable cache $cache_file" >&6;}
+  fi
+fi
+rm -f confcache
+
+test "x$prefix" = xNONE && prefix=$ac_default_prefix
+# Let make expand exec_prefix.
+test "x$exec_prefix" = xNONE && exec_prefix='${prefix}'
+
+DEFS=-DHAVE_CONFIG_H
+
+ac_libobjs=
+ac_ltlibobjs=
+for ac_i in : $LIBOBJS; do test "x$ac_i" = x: && continue
+  # 1. Remove the extension, and $U if already installed.
+  ac_script='s/\$U\././;s/\.o$//;s/\.obj$//'
+  ac_i=`echo "$ac_i" | sed "$ac_script"`
+  # 2. Prepend LIBOBJDIR.  When used with automake>=1.10 LIBOBJDIR
+  #    will be set to the directory where LIBOBJS objects are built.
+  ac_libobjs="$ac_libobjs \${LIBOBJDIR}$ac_i\$U.$ac_objext"
+  ac_ltlibobjs="$ac_ltlibobjs \${LIBOBJDIR}$ac_i"'$U.lo'
+done
+LIBOBJS=$ac_libobjs
+
+LTLIBOBJS=$ac_ltlibobjs
+
+
+if test -z "${AMDEP_TRUE}" && test -z "${AMDEP_FALSE}"; then
+  { { echo "$as_me:$LINENO: error: conditional \"AMDEP\" was never defined.
+Usually this means the macro was only invoked conditionally." >&5
+echo "$as_me: error: conditional \"AMDEP\" was never defined.
+Usually this means the macro was only invoked conditionally." >&2;}
+   { (exit 1); exit 1; }; }
+fi
+if test -z "${am__fastdepCC_TRUE}" && test -z "${am__fastdepCC_FALSE}"; then
+  { { echo "$as_me:$LINENO: error: conditional \"am__fastdepCC\" was never defined.
+Usually this means the macro was only invoked conditionally." >&5
+echo "$as_me: error: conditional \"am__fastdepCC\" was never defined.
+Usually this means the macro was only invoked conditionally." >&2;}
+   { (exit 1); exit 1; }; }
+fi
+if test -z "${am__fastdepCC_TRUE}" && test -z "${am__fastdepCC_FALSE}"; then
+  { { echo "$as_me:$LINENO: error: conditional \"am__fastdepCC\" was never defined.
+Usually this means the macro was only invoked conditionally." >&5
+echo "$as_me: error: conditional \"am__fastdepCC\" was never defined.
+Usually this means the macro was only invoked conditionally." >&2;}
+   { (exit 1); exit 1; }; }
+fi
+
+: ${CONFIG_STATUS=./config.status}
+ac_clean_files_save=$ac_clean_files
+ac_clean_files="$ac_clean_files $CONFIG_STATUS"
+{ echo "$as_me:$LINENO: creating $CONFIG_STATUS" >&5
+echo "$as_me: creating $CONFIG_STATUS" >&6;}
+cat >$CONFIG_STATUS <<_ACEOF
+#! $SHELL
+# Generated by $as_me.
+# Run this file to recreate the current configuration.
+# Compiler output produced by configure, useful for debugging
+# configure, is in config.log if it exists.
+
+debug=false
+ac_cs_recheck=false
+ac_cs_silent=false
+SHELL=\${CONFIG_SHELL-$SHELL}
+_ACEOF
+
+cat >>$CONFIG_STATUS <<\_ACEOF
+## --------------------- ##
+## M4sh Initialization.  ##
+## --------------------- ##
+
+# Be more Bourne compatible
+DUALCASE=1; export DUALCASE # for MKS sh
+if test -n "${ZSH_VERSION+set}" && (emulate sh) >/dev/null 2>&1; then
+  emulate sh
+  NULLCMD=:
+  # Zsh 3.x and 4.x performs word splitting on ${1+"$@"}, which
+  # is contrary to our usage.  Disable this feature.
+  alias -g '${1+"$@"}'='"$@"'
+  setopt NO_GLOB_SUBST
+else
+  case `(set -o) 2>/dev/null` in
+  *posix*) set -o posix ;;
+esac
+
+fi
+
+
+
+
+# PATH needs CR
+# Avoid depending upon Character Ranges.
+as_cr_letters='abcdefghijklmnopqrstuvwxyz'
+as_cr_LETTERS='ABCDEFGHIJKLMNOPQRSTUVWXYZ'
+as_cr_Letters=$as_cr_letters$as_cr_LETTERS
+as_cr_digits='0123456789'
+as_cr_alnum=$as_cr_Letters$as_cr_digits
+
+# The user is always right.
+if test "${PATH_SEPARATOR+set}" != set; then
+  echo "#! /bin/sh" >conf$$.sh
+  echo  "exit 0"   >>conf$$.sh
+  chmod +x conf$$.sh
+  if (PATH="/nonexistent;."; conf$$.sh) >/dev/null 2>&1; then
+    PATH_SEPARATOR=';'
+  else
+    PATH_SEPARATOR=:
+  fi
+  rm -f conf$$.sh
+fi
+
+# Support unset when possible.
+if ( (MAIL=60; unset MAIL) || exit) >/dev/null 2>&1; then
+  as_unset=unset
+else
+  as_unset=false
+fi
+
+
+# IFS
+# We need space, tab and new line, in precisely that order.  Quoting is
+# there to prevent editors from complaining about space-tab.
+# (If _AS_PATH_WALK were called with IFS unset, it would disable word
+# splitting by setting IFS to empty value.)
+as_nl='
+'
+IFS=" ""	$as_nl"
+
+# Find who we are.  Look in the path if we contain no directory separator.
+case $0 in
+  *[\\/]* ) as_myself=$0 ;;
+  *) as_save_IFS=$IFS; IFS=$PATH_SEPARATOR
+for as_dir in $PATH
+do
+  IFS=$as_save_IFS
+  test -z "$as_dir" && as_dir=.
+  test -r "$as_dir/$0" && as_myself=$as_dir/$0 && break
+done
+IFS=$as_save_IFS
+
+     ;;
+esac
+# We did not find ourselves, most probably we were run as `sh COMMAND'
+# in which case we are not to be found in the path.
+if test "x$as_myself" = x; then
+  as_myself=$0
+fi
+if test ! -f "$as_myself"; then
+  echo "$as_myself: error: cannot find myself; rerun with an absolute file name" >&2
+  { (exit 1); exit 1; }
+fi
+
+# Work around bugs in pre-3.0 UWIN ksh.
+for as_var in ENV MAIL MAILPATH
+do ($as_unset $as_var) >/dev/null 2>&1 && $as_unset $as_var
+done
+PS1='$ '
+PS2='> '
+PS4='+ '
+
+# NLS nuisances.
+for as_var in \
+  LANG LANGUAGE LC_ADDRESS LC_ALL LC_COLLATE LC_CTYPE LC_IDENTIFICATION \
+  LC_MEASUREMENT LC_MESSAGES LC_MONETARY LC_NAME LC_NUMERIC LC_PAPER \
+  LC_TELEPHONE LC_TIME
+do
+  if (set +x; test -z "`(eval $as_var=C; export $as_var) 2>&1`"); then
+    eval $as_var=C; export $as_var
+  else
+    ($as_unset $as_var) >/dev/null 2>&1 && $as_unset $as_var
+  fi
+done
+
+# Required to use basename.
+if expr a : '\(a\)' >/dev/null 2>&1 &&
+   test "X`expr 00001 : '.*\(...\)'`" = X001; then
+  as_expr=expr
+else
+  as_expr=false
+fi
+
+if (basename -- /) >/dev/null 2>&1 && test "X`basename -- / 2>&1`" = "X/"; then
+  as_basename=basename
+else
+  as_basename=false
+fi
+
+
+# Name of the executable.
+as_me=`$as_basename -- "$0" ||
+$as_expr X/"$0" : '.*/\([^/][^/]*\)/*$' \| \
+	 X"$0" : 'X\(//\)$' \| \
+	 X"$0" : 'X\(/\)' \| . 2>/dev/null ||
+echo X/"$0" |
+    sed '/^.*\/\([^/][^/]*\)\/*$/{
+	    s//\1/
+	    q
+	  }
+	  /^X\/\(\/\/\)$/{
+	    s//\1/
+	    q
+	  }
+	  /^X\/\(\/\).*/{
+	    s//\1/
+	    q
+	  }
+	  s/.*/./; q'`
+
+# CDPATH.
+$as_unset CDPATH
+
+
+
+  as_lineno_1=$LINENO
+  as_lineno_2=$LINENO
+  test "x$as_lineno_1" != "x$as_lineno_2" &&
+  test "x`expr $as_lineno_1 + 1`" = "x$as_lineno_2" || {
+
+  # Create $as_me.lineno as a copy of $as_myself, but with $LINENO
+  # uniformly replaced by the line number.  The first 'sed' inserts a
+  # line-number line after each line using $LINENO; the second 'sed'
+  # does the real work.  The second script uses 'N' to pair each
+  # line-number line with the line containing $LINENO, and appends
+  # trailing '-' during substitution so that $LINENO is not a special
+  # case at line end.
+  # (Raja R Harinath suggested sed '=', and Paul Eggert wrote the
+  # scripts with optimization help from Paolo Bonzini.  Blame Lee
+  # E. McMahon (1931-1989) for sed's syntax.  :-)
+  sed -n '
+    p
+    /[$]LINENO/=
+  ' <$as_myself |
+    sed '
+      s/[$]LINENO.*/&-/
+      t lineno
+      b
+      :lineno
+      N
+      :loop
+      s/[$]LINENO\([^'$as_cr_alnum'_].*\n\)\(.*\)/\2\1\2/
+      t loop
+      s/-\n.*//
+    ' >$as_me.lineno &&
+  chmod +x "$as_me.lineno" ||
+    { echo "$as_me: error: cannot create $as_me.lineno; rerun with a POSIX shell" >&2
+   { (exit 1); exit 1; }; }
+
+  # Don't try to exec as it changes $[0], causing all sort of problems
+  # (the dirname of $[0] is not the place where we might find the
+  # original and so on.  Autoconf is especially sensitive to this).
+  . "./$as_me.lineno"
+  # Exit status is that of the last command.
+  exit
+}
+
+
+if (as_dir=`dirname -- /` && test "X$as_dir" = X/) >/dev/null 2>&1; then
+  as_dirname=dirname
+else
+  as_dirname=false
+fi
+
+ECHO_C= ECHO_N= ECHO_T=
+case `echo -n x` in
+-n*)
+  case `echo 'x\c'` in
+  *c*) ECHO_T='	';;	# ECHO_T is single tab character.
+  *)   ECHO_C='\c';;
+  esac;;
+*)
+  ECHO_N='-n';;
+esac
+
+if expr a : '\(a\)' >/dev/null 2>&1 &&
+   test "X`expr 00001 : '.*\(...\)'`" = X001; then
+  as_expr=expr
+else
+  as_expr=false
+fi
+
+rm -f conf$$ conf$$.exe conf$$.file
+if test -d conf$$.dir; then
+  rm -f conf$$.dir/conf$$.file
+else
+  rm -f conf$$.dir
+  mkdir conf$$.dir
+fi
+echo >conf$$.file
+if ln -s conf$$.file conf$$ 2>/dev/null; then
+  as_ln_s='ln -s'
+  # ... but there are two gotchas:
+  # 1) On MSYS, both `ln -s file dir' and `ln file dir' fail.
+  # 2) DJGPP < 2.04 has no symlinks; `ln -s' creates a wrapper executable.
+  # In both cases, we have to default to `cp -p'.
+  ln -s conf$$.file conf$$.dir 2>/dev/null && test ! -f conf$$.exe ||
+    as_ln_s='cp -p'
+elif ln conf$$.file conf$$ 2>/dev/null; then
+  as_ln_s=ln
+else
+  as_ln_s='cp -p'
+fi
+rm -f conf$$ conf$$.exe conf$$.dir/conf$$.file conf$$.file
+rmdir conf$$.dir 2>/dev/null
+
+if mkdir -p . 2>/dev/null; then
+  as_mkdir_p=:
+else
+  test -d ./-p && rmdir ./-p
+  as_mkdir_p=false
+fi
+
+if test -x / >/dev/null 2>&1; then
+  as_test_x='test -x'
+else
+  if ls -dL / >/dev/null 2>&1; then
+    as_ls_L_option=L
+  else
+    as_ls_L_option=
+  fi
+  as_test_x='
+    eval sh -c '\''
+      if test -d "$1"; then
+        test -d "$1/.";
+      else
+	case $1 in
+        -*)set "./$1";;
+	esac;
+	case `ls -ld'$as_ls_L_option' "$1" 2>/dev/null` in
+	???[sx]*):;;*)false;;esac;fi
+    '\'' sh
+  '
+fi
+as_executable_p=$as_test_x
+
+# Sed expression to map a string onto a valid CPP name.
+as_tr_cpp="eval sed 'y%*$as_cr_letters%P$as_cr_LETTERS%;s%[^_$as_cr_alnum]%_%g'"
+
+# Sed expression to map a string onto a valid variable name.
+as_tr_sh="eval sed 'y%*+%pp%;s%[^_$as_cr_alnum]%_%g'"
+
+
+exec 6>&1
+
+# Save the log message, to keep $[0] and so on meaningful, and to
+# report actual input values of CONFIG_FILES etc. instead of their
+# values after options handling.
+ac_log="
+This file was extended by $as_me, which was
+generated by GNU Autoconf 2.61.  Invocation command line was
+
+  CONFIG_FILES    = $CONFIG_FILES
+  CONFIG_HEADERS  = $CONFIG_HEADERS
+  CONFIG_LINKS    = $CONFIG_LINKS
+  CONFIG_COMMANDS = $CONFIG_COMMANDS
+  $ $0 $@
+
+on `(hostname || uname -n) 2>/dev/null | sed 1q`
+"
+
+_ACEOF
+
+cat >>$CONFIG_STATUS <<_ACEOF
+# Files that config.status was made for.
+config_files="$ac_config_files"
+config_headers="$ac_config_headers"
+config_commands="$ac_config_commands"
+
+_ACEOF
+
+cat >>$CONFIG_STATUS <<\_ACEOF
+ac_cs_usage="\
+\`$as_me' instantiates files from templates according to the
+current configuration.
+
+Usage: $0 [OPTIONS] [FILE]...
+
+  -h, --help       print this help, then exit
+  -V, --version    print version number and configuration settings, then exit
+  -q, --quiet      do not print progress messages
+  -d, --debug      don't remove temporary files
+      --recheck    update $as_me by reconfiguring in the same conditions
+  --file=FILE[:TEMPLATE]
+		   instantiate the configuration file FILE
+  --header=FILE[:TEMPLATE]
+		   instantiate the configuration header FILE
+
+Configuration files:
+$config_files
+
+Configuration headers:
+$config_headers
+
+Configuration commands:
+$config_commands
+
+Report bugs to <bug-autoconf@gnu.org>."
+
+_ACEOF
+cat >>$CONFIG_STATUS <<_ACEOF
+ac_cs_version="\\
+config.status
+configured by $0, generated by GNU Autoconf 2.61,
+  with options \\"`echo "$ac_configure_args" | sed 's/^ //; s/[\\""\`\$]/\\\\&/g'`\\"
+
+Copyright (C) 2006 Free Software Foundation, Inc.
+This config.status script is free software; the Free Software Foundation
+gives unlimited permission to copy, distribute and modify it."
+
+ac_pwd='$ac_pwd'
+srcdir='$srcdir'
+INSTALL='$INSTALL'
+MKDIR_P='$MKDIR_P'
+_ACEOF
+
+cat >>$CONFIG_STATUS <<\_ACEOF
+# If no file are specified by the user, then we need to provide default
+# value.  By we need to know if files were specified by the user.
+ac_need_defaults=:
+while test $# != 0
+do
+  case $1 in
+  --*=*)
+    ac_option=`expr "X$1" : 'X\([^=]*\)='`
+    ac_optarg=`expr "X$1" : 'X[^=]*=\(.*\)'`
+    ac_shift=:
+    ;;
+  *)
+    ac_option=$1
+    ac_optarg=$2
+    ac_shift=shift
+    ;;
+  esac
+
+  case $ac_option in
+  # Handling of the options.
+  -recheck | --recheck | --rechec | --reche | --rech | --rec | --re | --r)
+    ac_cs_recheck=: ;;
+  --version | --versio | --versi | --vers | --ver | --ve | --v | -V )
+    echo "$ac_cs_version"; exit ;;
+  --debug | --debu | --deb | --de | --d | -d )
+    debug=: ;;
+  --file | --fil | --fi | --f )
+    $ac_shift
+    CONFIG_FILES="$CONFIG_FILES $ac_optarg"
+    ac_need_defaults=false;;
+  --header | --heade | --head | --hea )
+    $ac_shift
+    CONFIG_HEADERS="$CONFIG_HEADERS $ac_optarg"
+    ac_need_defaults=false;;
+  --he | --h)
+    # Conflict between --help and --header
+    { echo "$as_me: error: ambiguous option: $1
+Try \`$0 --help' for more information." >&2
+   { (exit 1); exit 1; }; };;
+  --help | --hel | -h )
+    echo "$ac_cs_usage"; exit ;;
+  -q | -quiet | --quiet | --quie | --qui | --qu | --q \
+  | -silent | --silent | --silen | --sile | --sil | --si | --s)
+    ac_cs_silent=: ;;
+
+  # This is an error.
+  -*) { echo "$as_me: error: unrecognized option: $1
+Try \`$0 --help' for more information." >&2
+   { (exit 1); exit 1; }; } ;;
+
+  *) ac_config_targets="$ac_config_targets $1"
+     ac_need_defaults=false ;;
+
+  esac
+  shift
+done
+
+ac_configure_extra_args=
+
+if $ac_cs_silent; then
+  exec 6>/dev/null
+  ac_configure_extra_args="$ac_configure_extra_args --silent"
+fi
+
+_ACEOF
+cat >>$CONFIG_STATUS <<_ACEOF
+if \$ac_cs_recheck; then
+  echo "running CONFIG_SHELL=$SHELL $SHELL $0 "$ac_configure_args \$ac_configure_extra_args " --no-create --no-recursion" >&6
+  CONFIG_SHELL=$SHELL
+  export CONFIG_SHELL
+  exec $SHELL "$0"$ac_configure_args \$ac_configure_extra_args --no-create --no-recursion
+fi
+
+_ACEOF
+cat >>$CONFIG_STATUS <<\_ACEOF
+exec 5>>config.log
+{
+  echo
+  sed 'h;s/./-/g;s/^.../## /;s/...$/ ##/;p;x;p;x' <<_ASBOX
+## Running $as_me. ##
+_ASBOX
+  echo "$ac_log"
+} >&5
+
+_ACEOF
+cat >>$CONFIG_STATUS <<_ACEOF
+#
+# INIT-COMMANDS
+#
+AMDEP_TRUE="$AMDEP_TRUE" ac_aux_dir="$ac_aux_dir"
+
+_ACEOF
+
+cat >>$CONFIG_STATUS <<\_ACEOF
+
+# Handling of arguments.
+for ac_config_target in $ac_config_targets
+do
+  case $ac_config_target in
+    "config.h") CONFIG_HEADERS="$CONFIG_HEADERS config.h" ;;
+    "depfiles") CONFIG_COMMANDS="$CONFIG_COMMANDS depfiles" ;;
+    "Makefile") CONFIG_FILES="$CONFIG_FILES Makefile" ;;
+    "default") CONFIG_COMMANDS="$CONFIG_COMMANDS default" ;;
+
+  *) { { echo "$as_me:$LINENO: error: invalid argument: $ac_config_target" >&5
+echo "$as_me: error: invalid argument: $ac_config_target" >&2;}
+   { (exit 1); exit 1; }; };;
+  esac
+done
+
+
+# If the user did not use the arguments to specify the items to instantiate,
+# then the envvar interface is used.  Set only those that are not.
+# We use the long form for the default assignment because of an extremely
+# bizarre bug on SunOS 4.1.3.
+if $ac_need_defaults; then
+  test "${CONFIG_FILES+set}" = set || CONFIG_FILES=$config_files
+  test "${CONFIG_HEADERS+set}" = set || CONFIG_HEADERS=$config_headers
+  test "${CONFIG_COMMANDS+set}" = set || CONFIG_COMMANDS=$config_commands
+fi
+
+# Have a temporary directory for convenience.  Make it in the build tree
+# simply because there is no reason against having it here, and in addition,
+# creating and moving files from /tmp can sometimes cause problems.
+# Hook for its removal unless debugging.
+# Note that there is a small window in which the directory will not be cleaned:
+# after its creation but before its name has been assigned to `$tmp'.
+$debug ||
+{
+  tmp=
+  trap 'exit_status=$?
+  { test -z "$tmp" || test ! -d "$tmp" || rm -fr "$tmp"; } && exit $exit_status
+' 0
+  trap '{ (exit 1); exit 1; }' 1 2 13 15
+}
+# Create a (secure) tmp directory for tmp files.
+
+{
+  tmp=`(umask 077 && mktemp -d "./confXXXXXX") 2>/dev/null` &&
+  test -n "$tmp" && test -d "$tmp"
+}  ||
+{
+  tmp=./conf$$-$RANDOM
+  (umask 077 && mkdir "$tmp")
+} ||
+{
+   echo "$me: cannot create a temporary directory in ." >&2
+   { (exit 1); exit 1; }
+}
+
+#
+# Set up the sed scripts for CONFIG_FILES section.
+#
+
+# No need to generate the scripts if there are no CONFIG_FILES.
+# This happens for instance when ./config.status config.h
+if test -n "$CONFIG_FILES"; then
+
+_ACEOF
+
+
+
+ac_delim='%!_!# '
+for ac_last_try in false false false false false :; do
+  cat >conf$$subs.sed <<_ACEOF
+SHELL!$SHELL$ac_delim
+PATH_SEPARATOR!$PATH_SEPARATOR$ac_delim
+PACKAGE_NAME!$PACKAGE_NAME$ac_delim
+PACKAGE_TARNAME!$PACKAGE_TARNAME$ac_delim
+PACKAGE_VERSION!$PACKAGE_VERSION$ac_delim
+PACKAGE_STRING!$PACKAGE_STRING$ac_delim
+PACKAGE_BUGREPORT!$PACKAGE_BUGREPORT$ac_delim
+exec_prefix!$exec_prefix$ac_delim
+prefix!$prefix$ac_delim
+program_transform_name!$program_transform_name$ac_delim
+bindir!$bindir$ac_delim
+sbindir!$sbindir$ac_delim
+libexecdir!$libexecdir$ac_delim
+datarootdir!$datarootdir$ac_delim
+datadir!$datadir$ac_delim
+sysconfdir!$sysconfdir$ac_delim
+sharedstatedir!$sharedstatedir$ac_delim
+localstatedir!$localstatedir$ac_delim
+includedir!$includedir$ac_delim
+oldincludedir!$oldincludedir$ac_delim
+docdir!$docdir$ac_delim
+infodir!$infodir$ac_delim
+htmldir!$htmldir$ac_delim
+dvidir!$dvidir$ac_delim
+pdfdir!$pdfdir$ac_delim
+psdir!$psdir$ac_delim
+libdir!$libdir$ac_delim
+localedir!$localedir$ac_delim
+mandir!$mandir$ac_delim
+DEFS!$DEFS$ac_delim
+ECHO_C!$ECHO_C$ac_delim
+ECHO_N!$ECHO_N$ac_delim
+ECHO_T!$ECHO_T$ac_delim
+LIBS!$LIBS$ac_delim
+build_alias!$build_alias$ac_delim
+host_alias!$host_alias$ac_delim
+target_alias!$target_alias$ac_delim
+INSTALL_PROGRAM!$INSTALL_PROGRAM$ac_delim
+INSTALL_SCRIPT!$INSTALL_SCRIPT$ac_delim
+INSTALL_DATA!$INSTALL_DATA$ac_delim
+am__isrc!$am__isrc$ac_delim
+CYGPATH_W!$CYGPATH_W$ac_delim
+PACKAGE!$PACKAGE$ac_delim
+VERSION!$VERSION$ac_delim
+ACLOCAL!$ACLOCAL$ac_delim
+AUTOCONF!$AUTOCONF$ac_delim
+AUTOMAKE!$AUTOMAKE$ac_delim
+AUTOHEADER!$AUTOHEADER$ac_delim
+MAKEINFO!$MAKEINFO$ac_delim
+install_sh!$install_sh$ac_delim
+STRIP!$STRIP$ac_delim
+INSTALL_STRIP_PROGRAM!$INSTALL_STRIP_PROGRAM$ac_delim
+mkdir_p!$mkdir_p$ac_delim
+AWK!$AWK$ac_delim
+SET_MAKE!$SET_MAKE$ac_delim
+am__leading_dot!$am__leading_dot$ac_delim
+AMTAR!$AMTAR$ac_delim
+am__tar!$am__tar$ac_delim
+am__untar!$am__untar$ac_delim
+build!$build$ac_delim
+build_cpu!$build_cpu$ac_delim
+build_vendor!$build_vendor$ac_delim
+build_os!$build_os$ac_delim
+host!$host$ac_delim
+host_cpu!$host_cpu$ac_delim
+host_vendor!$host_vendor$ac_delim
+host_os!$host_os$ac_delim
+CC!$CC$ac_delim
+CFLAGS!$CFLAGS$ac_delim
+LDFLAGS!$LDFLAGS$ac_delim
+CPPFLAGS!$CPPFLAGS$ac_delim
+ac_ct_CC!$ac_ct_CC$ac_delim
+EXEEXT!$EXEEXT$ac_delim
+OBJEXT!$OBJEXT$ac_delim
+DEPDIR!$DEPDIR$ac_delim
+am__include!$am__include$ac_delim
+am__quote!$am__quote$ac_delim
+AMDEP_TRUE!$AMDEP_TRUE$ac_delim
+AMDEP_FALSE!$AMDEP_FALSE$ac_delim
+AMDEPBACKSLASH!$AMDEPBACKSLASH$ac_delim
+CCDEPMODE!$CCDEPMODE$ac_delim
+am__fastdepCC_TRUE!$am__fastdepCC_TRUE$ac_delim
+am__fastdepCC_FALSE!$am__fastdepCC_FALSE$ac_delim
+CPP!$CPP$ac_delim
+GREP!$GREP$ac_delim
+EGREP!$EGREP$ac_delim
+LIBOBJS!$LIBOBJS$ac_delim
+LTLIBOBJS!$LTLIBOBJS$ac_delim
+_ACEOF
+
+  if test `sed -n "s/.*$ac_delim\$/X/p" conf$$subs.sed | grep -c X` = 88; then
+    break
+  elif $ac_last_try; then
+    { { echo "$as_me:$LINENO: error: could not make $CONFIG_STATUS" >&5
+echo "$as_me: error: could not make $CONFIG_STATUS" >&2;}
+   { (exit 1); exit 1; }; }
+  else
+    ac_delim="$ac_delim!$ac_delim _$ac_delim!! "
+  fi
+done
+
+ac_eof=`sed -n '/^CEOF[0-9]*$/s/CEOF/0/p' conf$$subs.sed`
+if test -n "$ac_eof"; then
+  ac_eof=`echo "$ac_eof" | sort -nru | sed 1q`
+  ac_eof=`expr $ac_eof + 1`
+fi
+
+cat >>$CONFIG_STATUS <<_ACEOF
+cat >"\$tmp/subs-1.sed" <<\CEOF$ac_eof
+/@[a-zA-Z_][a-zA-Z_0-9]*@/!b end
+_ACEOF
+sed '
+s/[,\\&]/\\&/g; s/@/@|#_!!_#|/g
+s/^/s,@/; s/!/@,|#_!!_#|/
+:n
+t n
+s/'"$ac_delim"'$/,g/; t
+s/$/\\/; p
+N; s/^.*\n//; s/[,\\&]/\\&/g; s/@/@|#_!!_#|/g; b n
+' >>$CONFIG_STATUS <conf$$subs.sed
+rm -f conf$$subs.sed
+cat >>$CONFIG_STATUS <<_ACEOF
+:end
+s/|#_!!_#|//g
+CEOF$ac_eof
+_ACEOF
+
+
+# VPATH may cause trouble with some makes, so we remove $(srcdir),
+# ${srcdir} and @srcdir@ from VPATH if srcdir is ".", strip leading and
+# trailing colons and then remove the whole line if VPATH becomes empty
+# (actually we leave an empty line to preserve line numbers).
+if test "x$srcdir" = x.; then
+  ac_vpsub='/^[	 ]*VPATH[	 ]*=/{
+s/:*\$(srcdir):*/:/
+s/:*\${srcdir}:*/:/
+s/:*@srcdir@:*/:/
+s/^\([^=]*=[	 ]*\):*/\1/
+s/:*$//
+s/^[^=]*=[	 ]*$//
+}'
+fi
+
+cat >>$CONFIG_STATUS <<\_ACEOF
+fi # test -n "$CONFIG_FILES"
+
+
+for ac_tag in  :F $CONFIG_FILES  :H $CONFIG_HEADERS    :C $CONFIG_COMMANDS
+do
+  case $ac_tag in
+  :[FHLC]) ac_mode=$ac_tag; continue;;
+  esac
+  case $ac_mode$ac_tag in
+  :[FHL]*:*);;
+  :L* | :C*:*) { { echo "$as_me:$LINENO: error: Invalid tag $ac_tag." >&5
+echo "$as_me: error: Invalid tag $ac_tag." >&2;}
+   { (exit 1); exit 1; }; };;
+  :[FH]-) ac_tag=-:-;;
+  :[FH]*) ac_tag=$ac_tag:$ac_tag.in;;
+  esac
+  ac_save_IFS=$IFS
+  IFS=:
+  set x $ac_tag
+  IFS=$ac_save_IFS
+  shift
+  ac_file=$1
+  shift
+
+  case $ac_mode in
+  :L) ac_source=$1;;
+  :[FH])
+    ac_file_inputs=
+    for ac_f
+    do
+      case $ac_f in
+      -) ac_f="$tmp/stdin";;
+      *) # Look for the file first in the build tree, then in the source tree
+	 # (if the path is not absolute).  The absolute path cannot be DOS-style,
+	 # because $ac_f cannot contain `:'.
+	 test -f "$ac_f" ||
+	   case $ac_f in
+	   [\\/$]*) false;;
+	   *) test -f "$srcdir/$ac_f" && ac_f="$srcdir/$ac_f";;
+	   esac ||
+	   { { echo "$as_me:$LINENO: error: cannot find input file: $ac_f" >&5
+echo "$as_me: error: cannot find input file: $ac_f" >&2;}
+   { (exit 1); exit 1; }; };;
+      esac
+      ac_file_inputs="$ac_file_inputs $ac_f"
+    done
+
+    # Let's still pretend it is `configure' which instantiates (i.e., don't
+    # use $as_me), people would be surprised to read:
+    #    /* config.h.  Generated by config.status.  */
+    configure_input="Generated from "`IFS=:
+	  echo $* | sed 's|^[^:]*/||;s|:[^:]*/|, |g'`" by configure."
+    if test x"$ac_file" != x-; then
+      configure_input="$ac_file.  $configure_input"
+      { echo "$as_me:$LINENO: creating $ac_file" >&5
+echo "$as_me: creating $ac_file" >&6;}
+    fi
+
+    case $ac_tag in
+    *:-:* | *:-) cat >"$tmp/stdin";;
+    esac
+    ;;
+  esac
+
+  ac_dir=`$as_dirname -- "$ac_file" ||
+$as_expr X"$ac_file" : 'X\(.*[^/]\)//*[^/][^/]*/*$' \| \
+	 X"$ac_file" : 'X\(//\)[^/]' \| \
+	 X"$ac_file" : 'X\(//\)$' \| \
+	 X"$ac_file" : 'X\(/\)' \| . 2>/dev/null ||
+echo X"$ac_file" |
+    sed '/^X\(.*[^/]\)\/\/*[^/][^/]*\/*$/{
+	    s//\1/
+	    q
+	  }
+	  /^X\(\/\/\)[^/].*/{
+	    s//\1/
+	    q
+	  }
+	  /^X\(\/\/\)$/{
+	    s//\1/
+	    q
+	  }
+	  /^X\(\/\).*/{
+	    s//\1/
+	    q
+	  }
+	  s/.*/./; q'`
+  { as_dir="$ac_dir"
+  case $as_dir in #(
+  -*) as_dir=./$as_dir;;
+  esac
+  test -d "$as_dir" || { $as_mkdir_p && mkdir -p "$as_dir"; } || {
+    as_dirs=
+    while :; do
+      case $as_dir in #(
+      *\'*) as_qdir=`echo "$as_dir" | sed "s/'/'\\\\\\\\''/g"`;; #(
+      *) as_qdir=$as_dir;;
+      esac
+      as_dirs="'$as_qdir' $as_dirs"
+      as_dir=`$as_dirname -- "$as_dir" ||
+$as_expr X"$as_dir" : 'X\(.*[^/]\)//*[^/][^/]*/*$' \| \
+	 X"$as_dir" : 'X\(//\)[^/]' \| \
+	 X"$as_dir" : 'X\(//\)$' \| \
+	 X"$as_dir" : 'X\(/\)' \| . 2>/dev/null ||
+echo X"$as_dir" |
+    sed '/^X\(.*[^/]\)\/\/*[^/][^/]*\/*$/{
+	    s//\1/
+	    q
+	  }
+	  /^X\(\/\/\)[^/].*/{
+	    s//\1/
+	    q
+	  }
+	  /^X\(\/\/\)$/{
+	    s//\1/
+	    q
+	  }
+	  /^X\(\/\).*/{
+	    s//\1/
+	    q
+	  }
+	  s/.*/./; q'`
+      test -d "$as_dir" && break
+    done
+    test -z "$as_dirs" || eval "mkdir $as_dirs"
+  } || test -d "$as_dir" || { { echo "$as_me:$LINENO: error: cannot create directory $as_dir" >&5
+echo "$as_me: error: cannot create directory $as_dir" >&2;}
+   { (exit 1); exit 1; }; }; }
+  ac_builddir=.
+
+case "$ac_dir" in
+.) ac_dir_suffix= ac_top_builddir_sub=. ac_top_build_prefix= ;;
+*)
+  ac_dir_suffix=/`echo "$ac_dir" | sed 's,^\.[\\/],,'`
+  # A ".." for each directory in $ac_dir_suffix.
+  ac_top_builddir_sub=`echo "$ac_dir_suffix" | sed 's,/[^\\/]*,/..,g;s,/,,'`
+  case $ac_top_builddir_sub in
+  "") ac_top_builddir_sub=. ac_top_build_prefix= ;;
+  *)  ac_top_build_prefix=$ac_top_builddir_sub/ ;;
+  esac ;;
+esac
+ac_abs_top_builddir=$ac_pwd
+ac_abs_builddir=$ac_pwd$ac_dir_suffix
+# for backward compatibility:
+ac_top_builddir=$ac_top_build_prefix
+
+case $srcdir in
+  .)  # We are building in place.
+    ac_srcdir=.
+    ac_top_srcdir=$ac_top_builddir_sub
+    ac_abs_top_srcdir=$ac_pwd ;;
+  [\\/]* | ?:[\\/]* )  # Absolute name.
+    ac_srcdir=$srcdir$ac_dir_suffix;
+    ac_top_srcdir=$srcdir
+    ac_abs_top_srcdir=$srcdir ;;
+  *) # Relative name.
+    ac_srcdir=$ac_top_build_prefix$srcdir$ac_dir_suffix
+    ac_top_srcdir=$ac_top_build_prefix$srcdir
+    ac_abs_top_srcdir=$ac_pwd/$srcdir ;;
+esac
+ac_abs_srcdir=$ac_abs_top_srcdir$ac_dir_suffix
+
+
+  case $ac_mode in
+  :F)
+  #
+  # CONFIG_FILE
+  #
+
+  case $INSTALL in
+  [\\/$]* | ?:[\\/]* ) ac_INSTALL=$INSTALL ;;
+  *) ac_INSTALL=$ac_top_build_prefix$INSTALL ;;
+  esac
+  ac_MKDIR_P=$MKDIR_P
+  case $MKDIR_P in
+  [\\/$]* | ?:[\\/]* ) ;;
+  */*) ac_MKDIR_P=$ac_top_build_prefix$MKDIR_P ;;
+  esac
+_ACEOF
+
+cat >>$CONFIG_STATUS <<\_ACEOF
+# If the template does not know about datarootdir, expand it.
+# FIXME: This hack should be removed a few years after 2.60.
+ac_datarootdir_hack=; ac_datarootdir_seen=
+
+case `sed -n '/datarootdir/ {
+  p
+  q
+}
+/@datadir@/p
+/@docdir@/p
+/@infodir@/p
+/@localedir@/p
+/@mandir@/p
+' $ac_file_inputs` in
+*datarootdir*) ac_datarootdir_seen=yes;;
+*@datadir@*|*@docdir@*|*@infodir@*|*@localedir@*|*@mandir@*)
+  { echo "$as_me:$LINENO: WARNING: $ac_file_inputs seems to ignore the --datarootdir setting" >&5
+echo "$as_me: WARNING: $ac_file_inputs seems to ignore the --datarootdir setting" >&2;}
+_ACEOF
+cat >>$CONFIG_STATUS <<_ACEOF
+  ac_datarootdir_hack='
+  s&@datadir@&$datadir&g
+  s&@docdir@&$docdir&g
+  s&@infodir@&$infodir&g
+  s&@localedir@&$localedir&g
+  s&@mandir@&$mandir&g
+    s&\\\${datarootdir}&$datarootdir&g' ;;
+esac
+_ACEOF
+
+# Neutralize VPATH when `$srcdir' = `.'.
+# Shell code in configure.ac might set extrasub.
+# FIXME: do we really want to maintain this feature?
+cat >>$CONFIG_STATUS <<_ACEOF
+  sed "$ac_vpsub
+$extrasub
+_ACEOF
+cat >>$CONFIG_STATUS <<\_ACEOF
+:t
+/@[a-zA-Z_][a-zA-Z_0-9]*@/!b
+s&@configure_input@&$configure_input&;t t
+s&@top_builddir@&$ac_top_builddir_sub&;t t
+s&@srcdir@&$ac_srcdir&;t t
+s&@abs_srcdir@&$ac_abs_srcdir&;t t
+s&@top_srcdir@&$ac_top_srcdir&;t t
+s&@abs_top_srcdir@&$ac_abs_top_srcdir&;t t
+s&@builddir@&$ac_builddir&;t t
+s&@abs_builddir@&$ac_abs_builddir&;t t
+s&@abs_top_builddir@&$ac_abs_top_builddir&;t t
+s&@INSTALL@&$ac_INSTALL&;t t
+s&@MKDIR_P@&$ac_MKDIR_P&;t t
+$ac_datarootdir_hack
+" $ac_file_inputs | sed -f "$tmp/subs-1.sed" >$tmp/out
+
+test -z "$ac_datarootdir_hack$ac_datarootdir_seen" &&
+  { ac_out=`sed -n '/\${datarootdir}/p' "$tmp/out"`; test -n "$ac_out"; } &&
+  { ac_out=`sed -n '/^[	 ]*datarootdir[	 ]*:*=/p' "$tmp/out"`; test -z "$ac_out"; } &&
+  { echo "$as_me:$LINENO: WARNING: $ac_file contains a reference to the variable \`datarootdir'
+which seems to be undefined.  Please make sure it is defined." >&5
+echo "$as_me: WARNING: $ac_file contains a reference to the variable \`datarootdir'
+which seems to be undefined.  Please make sure it is defined." >&2;}
+
+  rm -f "$tmp/stdin"
+  case $ac_file in
+  -) cat "$tmp/out"; rm -f "$tmp/out";;
+  *) rm -f "$ac_file"; mv "$tmp/out" $ac_file;;
+  esac
+ ;;
+  :H)
+  #
+  # CONFIG_HEADER
+  #
+_ACEOF
+
+# Transform confdefs.h into a sed script `conftest.defines', that
+# substitutes the proper values into config.h.in to produce config.h.
+rm -f conftest.defines conftest.tail
+# First, append a space to every undef/define line, to ease matching.
+echo 's/$/ /' >conftest.defines
+# Then, protect against being on the right side of a sed subst, or in
+# an unquoted here document, in config.status.  If some macros were
+# called several times there might be several #defines for the same
+# symbol, which is useless.  But do not sort them, since the last
+# AC_DEFINE must be honored.
+ac_word_re=[_$as_cr_Letters][_$as_cr_alnum]*
+# These sed commands are passed to sed as "A NAME B PARAMS C VALUE D", where
+# NAME is the cpp macro being defined, VALUE is the value it is being given.
+# PARAMS is the parameter list in the macro definition--in most cases, it's
+# just an empty string.
+ac_dA='s,^\\([	 #]*\\)[^	 ]*\\([	 ]*'
+ac_dB='\\)[	 (].*,\\1define\\2'
+ac_dC=' '
+ac_dD=' ,'
+
+uniq confdefs.h |
+  sed -n '
+	t rset
+	:rset
+	s/^[	 ]*#[	 ]*define[	 ][	 ]*//
+	t ok
+	d
+	:ok
+	s/[\\&,]/\\&/g
+	s/^\('"$ac_word_re"'\)\(([^()]*)\)[	 ]*\(.*\)/ '"$ac_dA"'\1'"$ac_dB"'\2'"${ac_dC}"'\3'"$ac_dD"'/p
+	s/^\('"$ac_word_re"'\)[	 ]*\(.*\)/'"$ac_dA"'\1'"$ac_dB$ac_dC"'\2'"$ac_dD"'/p
+  ' >>conftest.defines
+
+# Remove the space that was appended to ease matching.
+# Then replace #undef with comments.  This is necessary, for
+# example, in the case of _POSIX_SOURCE, which is predefined and required
+# on some systems where configure will not decide to define it.
+# (The regexp can be short, since the line contains either #define or #undef.)
+echo 's/ $//
+s,^[	 #]*u.*,/* & */,' >>conftest.defines
+
+# Break up conftest.defines:
+ac_max_sed_lines=50
+
+# First sed command is:	 sed -f defines.sed $ac_file_inputs >"$tmp/out1"
+# Second one is:	 sed -f defines.sed "$tmp/out1" >"$tmp/out2"
+# Third one will be:	 sed -f defines.sed "$tmp/out2" >"$tmp/out1"
+# et cetera.
+ac_in='$ac_file_inputs'
+ac_out='"$tmp/out1"'
+ac_nxt='"$tmp/out2"'
+
+while :
+do
+  # Write a here document:
+    cat >>$CONFIG_STATUS <<_ACEOF
+    # First, check the format of the line:
+    cat >"\$tmp/defines.sed" <<\\CEOF
+/^[	 ]*#[	 ]*undef[	 ][	 ]*$ac_word_re[	 ]*\$/b def
+/^[	 ]*#[	 ]*define[	 ][	 ]*$ac_word_re[(	 ]/b def
+b
+:def
+_ACEOF
+  sed ${ac_max_sed_lines}q conftest.defines >>$CONFIG_STATUS
+  echo 'CEOF
+    sed -f "$tmp/defines.sed"' "$ac_in >$ac_out" >>$CONFIG_STATUS
+  ac_in=$ac_out; ac_out=$ac_nxt; ac_nxt=$ac_in
+  sed 1,${ac_max_sed_lines}d conftest.defines >conftest.tail
+  grep . conftest.tail >/dev/null || break
+  rm -f conftest.defines
+  mv conftest.tail conftest.defines
+done
+rm -f conftest.defines conftest.tail
+
+echo "ac_result=$ac_in" >>$CONFIG_STATUS
+cat >>$CONFIG_STATUS <<\_ACEOF
+  if test x"$ac_file" != x-; then
+    echo "/* $configure_input  */" >"$tmp/config.h"
+    cat "$ac_result" >>"$tmp/config.h"
+    if diff $ac_file "$tmp/config.h" >/dev/null 2>&1; then
+      { echo "$as_me:$LINENO: $ac_file is unchanged" >&5
+echo "$as_me: $ac_file is unchanged" >&6;}
+    else
+      rm -f $ac_file
+      mv "$tmp/config.h" $ac_file
+    fi
+  else
+    echo "/* $configure_input  */"
+    cat "$ac_result"
+  fi
+  rm -f "$tmp/out12"
+# Compute $ac_file's index in $config_headers.
+_am_arg=$ac_file
+_am_stamp_count=1
+for _am_header in $config_headers :; do
+  case $_am_header in
+    $_am_arg | $_am_arg:* )
+      break ;;
+    * )
+      _am_stamp_count=`expr $_am_stamp_count + 1` ;;
+  esac
+done
+echo "timestamp for $_am_arg" >`$as_dirname -- "$_am_arg" ||
+$as_expr X"$_am_arg" : 'X\(.*[^/]\)//*[^/][^/]*/*$' \| \
+	 X"$_am_arg" : 'X\(//\)[^/]' \| \
+	 X"$_am_arg" : 'X\(//\)$' \| \
+	 X"$_am_arg" : 'X\(/\)' \| . 2>/dev/null ||
+echo X"$_am_arg" |
+    sed '/^X\(.*[^/]\)\/\/*[^/][^/]*\/*$/{
+	    s//\1/
+	    q
+	  }
+	  /^X\(\/\/\)[^/].*/{
+	    s//\1/
+	    q
+	  }
+	  /^X\(\/\/\)$/{
+	    s//\1/
+	    q
+	  }
+	  /^X\(\/\).*/{
+	    s//\1/
+	    q
+	  }
+	  s/.*/./; q'`/stamp-h$_am_stamp_count
+ ;;
+
+  :C)  { echo "$as_me:$LINENO: executing $ac_file commands" >&5
+echo "$as_me: executing $ac_file commands" >&6;}
+ ;;
+  esac
+
+
+  case $ac_file$ac_mode in
+    "depfiles":C) test x"$AMDEP_TRUE" != x"" || for mf in $CONFIG_FILES; do
+  # Strip MF so we end up with the name of the file.
+  mf=`echo "$mf" | sed -e 's/:.*$//'`
+  # Check whether this is an Automake generated Makefile or not.
+  # We used to match only the files named `Makefile.in', but
+  # some people rename them; so instead we look at the file content.
+  # Grep'ing the first line is not enough: some people post-process
+  # each Makefile.in and add a new line on top of each file to say so.
+  # Grep'ing the whole file is not good either: AIX grep has a line
+  # limit of 2048, but all sed's we know have understand at least 4000.
+  if sed -n 's,^#.*generated by automake.*,X,p' "$mf" | grep X >/dev/null 2>&1; then
+    dirpart=`$as_dirname -- "$mf" ||
+$as_expr X"$mf" : 'X\(.*[^/]\)//*[^/][^/]*/*$' \| \
+	 X"$mf" : 'X\(//\)[^/]' \| \
+	 X"$mf" : 'X\(//\)$' \| \
+	 X"$mf" : 'X\(/\)' \| . 2>/dev/null ||
+echo X"$mf" |
+    sed '/^X\(.*[^/]\)\/\/*[^/][^/]*\/*$/{
+	    s//\1/
+	    q
+	  }
+	  /^X\(\/\/\)[^/].*/{
+	    s//\1/
+	    q
+	  }
+	  /^X\(\/\/\)$/{
+	    s//\1/
+	    q
+	  }
+	  /^X\(\/\).*/{
+	    s//\1/
+	    q
+	  }
+	  s/.*/./; q'`
+  else
+    continue
+  fi
+  # Extract the definition of DEPDIR, am__include, and am__quote
+  # from the Makefile without running `make'.
+  DEPDIR=`sed -n 's/^DEPDIR = //p' < "$mf"`
+  test -z "$DEPDIR" && continue
+  am__include=`sed -n 's/^am__include = //p' < "$mf"`
+  test -z "am__include" && continue
+  am__quote=`sed -n 's/^am__quote = //p' < "$mf"`
+  # When using ansi2knr, U may be empty or an underscore; expand it
+  U=`sed -n 's/^U = //p' < "$mf"`
+  # Find all dependency output files, they are included files with
+  # $(DEPDIR) in their names.  We invoke sed twice because it is the
+  # simplest approach to changing $(DEPDIR) to its actual value in the
+  # expansion.
+  for file in `sed -n "
+    s/^$am__include $am__quote\(.*(DEPDIR).*\)$am__quote"'$/\1/p' <"$mf" | \
+       sed -e 's/\$(DEPDIR)/'"$DEPDIR"'/g' -e 's/\$U/'"$U"'/g'`; do
+    # Make sure the directory exists.
+    test -f "$dirpart/$file" && continue
+    fdir=`$as_dirname -- "$file" ||
+$as_expr X"$file" : 'X\(.*[^/]\)//*[^/][^/]*/*$' \| \
+	 X"$file" : 'X\(//\)[^/]' \| \
+	 X"$file" : 'X\(//\)$' \| \
+	 X"$file" : 'X\(/\)' \| . 2>/dev/null ||
+echo X"$file" |
+    sed '/^X\(.*[^/]\)\/\/*[^/][^/]*\/*$/{
+	    s//\1/
+	    q
+	  }
+	  /^X\(\/\/\)[^/].*/{
+	    s//\1/
+	    q
+	  }
+	  /^X\(\/\/\)$/{
+	    s//\1/
+	    q
+	  }
+	  /^X\(\/\).*/{
+	    s//\1/
+	    q
+	  }
+	  s/.*/./; q'`
+    { as_dir=$dirpart/$fdir
+  case $as_dir in #(
+  -*) as_dir=./$as_dir;;
+  esac
+  test -d "$as_dir" || { $as_mkdir_p && mkdir -p "$as_dir"; } || {
+    as_dirs=
+    while :; do
+      case $as_dir in #(
+      *\'*) as_qdir=`echo "$as_dir" | sed "s/'/'\\\\\\\\''/g"`;; #(
+      *) as_qdir=$as_dir;;
+      esac
+      as_dirs="'$as_qdir' $as_dirs"
+      as_dir=`$as_dirname -- "$as_dir" ||
+$as_expr X"$as_dir" : 'X\(.*[^/]\)//*[^/][^/]*/*$' \| \
+	 X"$as_dir" : 'X\(//\)[^/]' \| \
+	 X"$as_dir" : 'X\(//\)$' \| \
+	 X"$as_dir" : 'X\(/\)' \| . 2>/dev/null ||
+echo X"$as_dir" |
+    sed '/^X\(.*[^/]\)\/\/*[^/][^/]*\/*$/{
+	    s//\1/
+	    q
+	  }
+	  /^X\(\/\/\)[^/].*/{
+	    s//\1/
+	    q
+	  }
+	  /^X\(\/\/\)$/{
+	    s//\1/
+	    q
+	  }
+	  /^X\(\/\).*/{
+	    s//\1/
+	    q
+	  }
+	  s/.*/./; q'`
+      test -d "$as_dir" && break
+    done
+    test -z "$as_dirs" || eval "mkdir $as_dirs"
+  } || test -d "$as_dir" || { { echo "$as_me:$LINENO: error: cannot create directory $as_dir" >&5
+echo "$as_me: error: cannot create directory $as_dir" >&2;}
+   { (exit 1); exit 1; }; }; }
+    # echo "creating $dirpart/$file"
+    echo '# dummy' > "$dirpart/$file"
+  done
+done
+ ;;
+    "default":C) echo timestamp > stamp-h ;;
+
+  esac
+done # for ac_tag
+
+
+{ (exit 0); exit 0; }
+_ACEOF
+chmod +x $CONFIG_STATUS
+ac_clean_files=$ac_clean_files_save
+
+
+# configure is writing to config.log, and then calls config.status.
+# config.status does its own redirection, appending to config.log.
+# Unfortunately, on DOS this fails, as config.log is still kept open
+# by configure, so config.status won't be able to write to it; its
+# output is simply discarded.  So we exec the FD to /dev/null,
+# effectively closing config.log, so it can be properly (re)opened and
+# appended to by config.status.  When coming back to configure, we
+# need to make the FD available again.
+if test "$no_create" != yes; then
+  ac_cs_success=:
+  ac_config_status_args=
+  test "$silent" = yes &&
+    ac_config_status_args="$ac_config_status_args --quiet"
+  exec 5>/dev/null
+  $SHELL $CONFIG_STATUS $ac_config_status_args || ac_cs_success=false
+  exec 5>>config.log
+  # Use ||, not &&, to avoid exiting from the if with $? = 1, which
+  # would make configure fail if this is the last instruction.
+  $ac_cs_success || { (exit 1); exit 1; }
+fi
+
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/configure.in b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/configure.in
new file mode 100644
index 0000000..9ce49d2
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/configure.in
@@ -0,0 +1,49 @@
+dnl Process this file with autoconf to produce a configure script.
+AC_INIT(main.c)
+AM_INIT_AUTOMAKE(ffsb, 6.0-RC2)
+
+AM_CONFIG_HEADER(config.h)
+AC_CANONICAL_HOST
+
+dnl need to define _ALL_SOURCE and _THREAD_SAFE on AIX
+AC_AIX
+
+case "${host}" in
+  *aix*)
+    CFLAGS="${CFLAGS} -D_THREAD_SAFE"
+    ;;
+  *linux*)
+    CFLAGS="${CFLAGS} -D_REENTRANT"
+    ;;
+  *)
+    echo "detected unknown platform : ${host} : compiles may fail"
+    CFLAGS="${CFLAGS} -D_REENTRANT"
+    ;;
+esac
+
+dnl Checks for programs.
+AC_PROG_CC
+
+dnl Checks for libraries.
+dnl Replace `main' with a function in -lm:
+AC_CHECK_LIB(m, main)
+dnl Replace `main' with a function in -lpthread:
+AC_CHECK_LIB(pthread, main)
+
+
+dnl Checks for header files.
+AC_HEADER_STDC
+AC_HEADER_SYS_WAIT
+AC_CHECK_HEADERS(pthread.h fcntl.h limits.h stdint.h sys/time.h unistd.h sys/vfs.h sys/limits.h)
+
+dnl Checks for typedefs, structures, and compiler characteristics.
+AC_C_CONST
+AC_HEADER_TIME
+
+dnl Checks for library functions.
+AC_FUNC_SETVBUF_REVERSED
+AC_CHECK_FUNCS(system gettimeofday mkdir strerror open64 stat64 fseeko64 lrand48_r srand48_r)
+
+AC_SUBST(CFLAGS)
+AC_SUBST(CC)
+AC_OUTPUT(Makefile, echo timestamp > stamp-h)
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/depcomp b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/depcomp
new file mode 100644
index 0000000..aea3d00
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/depcomp
@@ -0,0 +1,472 @@
+#! /bin/sh
+
+# depcomp - compile a program generating dependencies as side-effects
+# Copyright 1999, 2000 Free Software Foundation, Inc.
+
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2, or (at your option)
+# any later version.
+
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+# 02111-1307, USA.
+
+# As a special exception to the GNU General Public License, if you
+# distribute this file as part of a program that contains a
+# configuration script generated by Autoconf, you may include it under
+# the same distribution terms that you use for the rest of that program.
+
+# Originally written by Alexandre Oliva <oliva@dcc.unicamp.br>.
+
+if test -z "$depmode" || test -z "$source" || test -z "$object"; then
+  echo "depcomp: Variables source, object and depmode must be set" 1>&2
+  exit 1
+fi
+# `libtool' can also be set to `yes' or `no'.
+
+if test -z "$depfile"; then
+   base=`echo "$object" | sed -e 's,^.*/,,' -e 's,\.\([^.]*\)$,.P\1,'`
+   dir=`echo "$object" | sed 's,/.*$,/,'`
+   if test "$dir" = "$object"; then
+      dir=
+   fi
+   # FIXME: should be _deps on DOS.
+   depfile="$dir.deps/$base"
+fi
+
+tmpdepfile=${tmpdepfile-`echo "$depfile" | sed 's/\.\([^.]*\)$/.T\1/'`}
+
+rm -f "$tmpdepfile"
+
+# Some modes work just like other modes, but use different flags.  We
+# parameterize here, but still list the modes in the big case below,
+# to make depend.m4 easier to write.  Note that we *cannot* use a case
+# here, because this file can only contain one case statement.
+if test "$depmode" = hp; then
+  # HP compiler uses -M and no extra arg.
+  gccflag=-M
+  depmode=gcc
+fi
+
+if test "$depmode" = dashXmstdout; then
+   # This is just like dashmstdout with a different argument.
+   dashmflag=-xM
+   depmode=dashmstdout
+fi
+
+case "$depmode" in
+gcc3)
+## gcc 3 implements dependency tracking that does exactly what
+## we want.  Yay!  Note: for some reason libtool 1.4 doesn't like
+## it if -MD -MP comes after the -MF stuff.  Hmm.
+  "$@" -MT "$object" -MD -MP -MF "$tmpdepfile"
+  stat=$?
+  if test $stat -eq 0; then :
+  else
+    rm -f "$tmpdepfile"
+    exit $stat
+  fi
+  mv "$tmpdepfile" "$depfile"
+  ;;
+
+gcc)
+## There are various ways to get dependency output from gcc.  Here's
+## why we pick this rather obscure method:
+## - Don't want to use -MD because we'd like the dependencies to end
+##   up in a subdir.  Having to rename by hand is ugly.
+##   (We might end up doing this anyway to support other compilers.)
+## - The DEPENDENCIES_OUTPUT environment variable makes gcc act like
+##   -MM, not -M (despite what the docs say).
+## - Using -M directly means running the compiler twice (even worse
+##   than renaming).
+  if test -z "$gccflag"; then
+    gccflag=-MD,
+  fi
+  "$@" -Wp,"$gccflag$tmpdepfile"
+  stat=$?
+  if test $stat -eq 0; then :
+  else
+    rm -f "$tmpdepfile"
+    exit $stat
+  fi
+  rm -f "$depfile"
+  echo "$object : \\" > "$depfile"
+  alpha=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz
+## The second -e expression handles DOS-style file names with drive letters.
+  sed -e 's/^[^:]*: / /' \
+      -e 's/^['$alpha']:\/[^:]*: / /' < "$tmpdepfile" >> "$depfile"
+## This next piece of magic avoids the `deleted header file' problem.
+## The problem is that when a header file which appears in a .P file
+## is deleted, the dependency causes make to die (because there is
+## typically no way to rebuild the header).  We avoid this by adding
+## dummy dependencies for each header file.  Too bad gcc doesn't do
+## this for us directly.
+  tr ' ' '
+' < "$tmpdepfile" |
+## Some versions of gcc put a space before the `:'.  On the theory
+## that the space means something, we add a space to the output as
+## well.
+## Some versions of the HPUX 10.20 sed can't process this invocation
+## correctly.  Breaking it into two sed invocations is a workaround.
+    sed -e 's/^\\$//' -e '/^$/d' -e '/:$/d' | sed -e 's/$/ :/' >> "$depfile"
+  rm -f "$tmpdepfile"
+  ;;
+
+hp)
+  # This case exists only to let depend.m4 do its work.  It works by
+  # looking at the text of this script.  This case will never be run,
+  # since it is checked for above.
+  exit 1
+  ;;
+
+sgi)
+  if test "$libtool" = yes; then
+    "$@" "-Wp,-MDupdate,$tmpdepfile"
+  else
+    "$@" -MDupdate "$tmpdepfile"
+  fi
+  stat=$?
+  if test $stat -eq 0; then :
+  else
+    rm -f "$tmpdepfile"
+    exit $stat
+  fi
+  rm -f "$depfile"
+
+  if test -f "$tmpdepfile"; then  # yes, the sourcefile depend on other files
+    echo "$object : \\" > "$depfile"
+
+    # Clip off the initial element (the dependent).  Don't try to be
+    # clever and replace this with sed code, as IRIX sed won't handle
+    # lines with more than a fixed number of characters (4096 in
+    # IRIX 6.2 sed, 8192 in IRIX 6.5).  We also remove comment lines;
+    # the IRIX cc adds comments like `#:fec' to the end of the
+    # dependency line.
+    tr ' ' '
+' < "$tmpdepfile" \
+    | sed -e 's/^.*\.o://' -e 's/#.*$//' -e '/^$/ d' | \
+    tr '
+' ' ' >> $depfile
+    echo >> $depfile
+
+    # The second pass generates a dummy entry for each header file.
+    tr ' ' '
+' < "$tmpdepfile" \
+   | sed -e 's/^.*\.o://' -e 's/#.*$//' -e '/^$/ d' -e 's/$/:/' \
+   >> $depfile
+  else
+    # The sourcefile does not contain any dependencies, so just
+    # store a dummy comment line, to avoid errors with the Makefile
+    # "include basename.Plo" scheme.
+    echo "#dummy" > "$depfile"
+  fi
+  rm -f "$tmpdepfile"
+  ;;
+
+aix)
+  # The C for AIX Compiler uses -M and outputs the dependencies
+  # in a .u file.  This file always lives in the current directory.
+  # Also, the AIX compiler puts `$object:' at the start of each line;
+  # $object doesn't have directory information.
+  stripped=`echo "$object" | sed -e 's,^.*/,,' -e 's/\(.*\)\..*$/\1/'`
+  tmpdepfile="$stripped.u"
+  outname="$stripped.o"
+  if test "$libtool" = yes; then
+    "$@" -Wc,-M
+  else
+    "$@" -M
+  fi
+
+  stat=$?
+  if test $stat -eq 0; then :
+  else
+    rm -f "$tmpdepfile"
+    exit $stat
+  fi
+
+  if test -f "$tmpdepfile"; then
+    # Each line is of the form `foo.o: dependent.h'.
+    # Do two passes, one to just change these to
+    # `$object: dependent.h' and one to simply `dependent.h:'.
+    sed -e "s,^$outname:,$object :," < "$tmpdepfile" > "$depfile"
+    sed -e "s,^$outname: \(.*\)$,\1:," < "$tmpdepfile" >> "$depfile"
+  else
+    # The sourcefile does not contain any dependencies, so just
+    # store a dummy comment line, to avoid errors with the Makefile
+    # "include basename.Plo" scheme.
+    echo "#dummy" > "$depfile"
+  fi
+  rm -f "$tmpdepfile"
+  ;;
+
+icc)
+  # Intel's C compiler understands `-MD -MF file'.  However on
+  #    icc -MD -MF foo.d -c -o sub/foo.o sub/foo.c
+  # ICC 7.0 will fill foo.d with something like
+  #    foo.o: sub/foo.c
+  #    foo.o: sub/foo.h
+  # which is wrong.  We want:
+  #    sub/foo.o: sub/foo.c
+  #    sub/foo.o: sub/foo.h
+  #    sub/foo.c:
+  #    sub/foo.h:
+  # ICC 7.1 will output
+  #    foo.o: sub/foo.c sub/foo.h
+  # and will wrap long lines using \ :
+  #    foo.o: sub/foo.c ... \
+  #     sub/foo.h ... \
+  #     ...
+
+  "$@" -MD -MF "$tmpdepfile"
+  stat=$?
+  if test $stat -eq 0; then :
+  else
+    rm -f "$tmpdepfile"
+    exit $stat
+  fi
+  rm -f "$depfile"
+  # Each line is of the form `foo.o: dependent.h',
+  # or `foo.o: dep1.h dep2.h \', or ` dep3.h dep4.h \'.
+  # Do two passes, one to just change these to
+  # `$object: dependent.h' and one to simply `dependent.h:'.
+  sed "s,^[^:]*:,$object :," < "$tmpdepfile" > "$depfile"
+  # Some versions of the HPUX 10.20 sed can't process this invocation
+  # correctly.  Breaking it into two sed invocations is a workaround.
+  sed 's,^[^:]*: \(.*\)$,\1,;s/^\\$//;/^$/d;/:$/d' < "$tmpdepfile" |
+    sed -e 's/$/ :/' >> "$depfile"
+  rm -f "$tmpdepfile"
+  ;;
+
+tru64)
+   # The Tru64 compiler uses -MD to generate dependencies as a side
+   # effect.  `cc -MD -o foo.o ...' puts the dependencies into `foo.o.d'.
+   # At least on Alpha/Redhat 6.1, Compaq CCC V6.2-504 seems to put
+   # dependencies in `foo.d' instead, so we check for that too.
+   # Subdirectories are respected.
+   dir=`echo "$object" | sed -e 's|/[^/]*$|/|'`
+   test "x$dir" = "x$object" && dir=
+   base=`echo "$object" | sed -e 's|^.*/||' -e 's/\.o$//' -e 's/\.lo$//'`
+
+   if test "$libtool" = yes; then
+      tmpdepfile1="$dir.libs/$base.lo.d"
+      tmpdepfile2="$dir.libs/$base.d"
+      "$@" -Wc,-MD
+   else
+      tmpdepfile1="$dir$base.o.d"
+      tmpdepfile2="$dir$base.d"
+      "$@" -MD
+   fi
+
+   stat=$?
+   if test $stat -eq 0; then :
+   else
+      rm -f "$tmpdepfile1" "$tmpdepfile2"
+      exit $stat
+   fi
+
+   if test -f "$tmpdepfile1"; then
+      tmpdepfile="$tmpdepfile1"
+   else
+      tmpdepfile="$tmpdepfile2"
+   fi
+   if test -f "$tmpdepfile"; then
+      sed -e "s,^.*\.[a-z]*:,$object:," < "$tmpdepfile" > "$depfile"
+      # That's a space and a tab in the [].
+      sed -e 's,^.*\.[a-z]*:[ 	]*,,' -e 's,$,:,' < "$tmpdepfile" >> "$depfile"
+   else
+      echo "#dummy" > "$depfile"
+   fi
+   rm -f "$tmpdepfile"
+   ;;
+
+#nosideeffect)
+  # This comment above is used by automake to tell side-effect
+  # dependency tracking mechanisms from slower ones.
+
+dashmstdout)
+  # Important note: in order to support this mode, a compiler *must*
+  # always write the proprocessed file to stdout, regardless of -o.
+  "$@" || exit $?
+
+  # Remove the call to Libtool.
+  if test "$libtool" = yes; then
+    while test $1 != '--mode=compile'; do
+      shift
+    done
+    shift
+  fi
+
+  # Remove `-o $object'.
+  IFS=" "
+  for arg
+  do
+    case $arg in
+    -o)
+      shift
+      ;;
+    $object)
+      shift
+      ;;
+    *)
+      set fnord "$@" "$arg"
+      shift # fnord
+      shift # $arg
+      ;;
+    esac
+  done
+
+  test -z "$dashmflag" && dashmflag=-M
+  # Require at least two characters before searching for `:'
+  # in the target name.  This is to cope with DOS-style filenames:
+  # a dependency such as `c:/foo/bar' could be seen as target `c' otherwise.
+  "$@" $dashmflag |
+    sed 's:^[  ]*[^: ][^:][^:]*\:[    ]*:'"$object"'\: :' > "$tmpdepfile"
+  rm -f "$depfile"
+  cat < "$tmpdepfile" > "$depfile"
+  tr ' ' '
+' < "$tmpdepfile" | \
+## Some versions of the HPUX 10.20 sed can't process this invocation
+## correctly.  Breaking it into two sed invocations is a workaround.
+    sed -e 's/^\\$//' -e '/^$/d' -e '/:$/d' | sed -e 's/$/ :/' >> "$depfile"
+  rm -f "$tmpdepfile"
+  ;;
+
+dashXmstdout)
+  # This case only exists to satisfy depend.m4.  It is never actually
+  # run, as this mode is specially recognized in the preamble.
+  exit 1
+  ;;
+
+makedepend)
+  "$@" || exit $?
+  # Remove any Libtool call
+  if test "$libtool" = yes; then
+    while test $1 != '--mode=compile'; do
+      shift
+    done
+    shift
+  fi
+  # X makedepend
+  shift
+  cleared=no
+  for arg in "$@"; do
+    case $cleared in
+    no)
+      set ""; shift
+      cleared=yes ;;
+    esac
+    case "$arg" in
+    -D*|-I*)
+      set fnord "$@" "$arg"; shift ;;
+    # Strip any option that makedepend may not understand.  Remove
+    # the object too, otherwise makedepend will parse it as a source file.
+    -*|$object)
+      ;;
+    *)
+      set fnord "$@" "$arg"; shift ;;
+    esac
+  done
+  obj_suffix="`echo $object | sed 's/^.*\././'`"
+  touch "$tmpdepfile"
+  ${MAKEDEPEND-makedepend} -o"$obj_suffix" -f"$tmpdepfile" "$@"
+  rm -f "$depfile"
+  cat < "$tmpdepfile" > "$depfile"
+  sed '1,2d' "$tmpdepfile" | tr ' ' '
+' | \
+## Some versions of the HPUX 10.20 sed can't process this invocation
+## correctly.  Breaking it into two sed invocations is a workaround.
+    sed -e 's/^\\$//' -e '/^$/d' -e '/:$/d' | sed -e 's/$/ :/' >> "$depfile"
+  rm -f "$tmpdepfile" "$tmpdepfile".bak
+  ;;
+
+cpp)
+  # Important note: in order to support this mode, a compiler *must*
+  # always write the proprocessed file to stdout.
+  "$@" || exit $?
+
+  # Remove the call to Libtool.
+  if test "$libtool" = yes; then
+    while test $1 != '--mode=compile'; do
+      shift
+    done
+    shift
+  fi
+
+  # Remove `-o $object'.
+  IFS=" "
+  for arg
+  do
+    case $arg in
+    -o)
+      shift
+      ;;
+    $object)
+      shift
+      ;;
+    *)
+      set fnord "$@" "$arg"
+      shift # fnord
+      shift # $arg
+      ;;
+    esac
+  done
+
+  "$@" -E |
+    sed -n '/^# [0-9][0-9]* "\([^"]*\)".*/ s:: \1 \\:p' |
+    sed '$ s: \\$::' > "$tmpdepfile"
+  rm -f "$depfile"
+  echo "$object : \\" > "$depfile"
+  cat < "$tmpdepfile" >> "$depfile"
+  sed < "$tmpdepfile" '/^$/d;s/^ //;s/ \\$//;s/$/ :/' >> "$depfile"
+  rm -f "$tmpdepfile"
+  ;;
+
+msvisualcpp)
+  # Important note: in order to support this mode, a compiler *must*
+  # always write the proprocessed file to stdout, regardless of -o,
+  # because we must use -o when running libtool.
+  "$@" || exit $?
+  IFS=" "
+  for arg
+  do
+    case "$arg" in
+    "-Gm"|"/Gm"|"-Gi"|"/Gi"|"-ZI"|"/ZI")
+	set fnord "$@"
+	shift
+	shift
+	;;
+    *)
+	set fnord "$@" "$arg"
+	shift
+	shift
+	;;
+    esac
+  done
+  "$@" -E |
+  sed -n '/^#line [0-9][0-9]* "\([^"]*\)"/ s::echo "`cygpath -u \\"\1\\"`":p' | sort | uniq > "$tmpdepfile"
+  rm -f "$depfile"
+  echo "$object : \\" > "$depfile"
+  . "$tmpdepfile" | sed 's% %\\ %g' | sed -n '/^\(.*\)$/ s::	\1 \\:p' >> "$depfile"
+  echo "	" >> "$depfile"
+  . "$tmpdepfile" | sed 's% %\\ %g' | sed -n '/^\(.*\)$/ s::\1\::p' >> "$depfile"
+  rm -f "$tmpdepfile"
+  ;;
+
+none)
+  exec "$@"
+  ;;
+
+*)
+  echo "Unknown depmode $depmode" 1>&2
+  exit 1
+  ;;
+esac
+
+exit 0
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/examples/profile_everything b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/examples/profile_everything
new file mode 100644
index 0000000..67972e1
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/examples/profile_everything
@@ -0,0 +1,119 @@
+directio	= 0
+time		= 10
+
+[filesystem]
+	location	= /mnt/test1
+
+	num_dirs	= 100
+
+	size_weight	4k	33
+	size_weight	8k	21
+	size_weight	16k	13
+	size_weight	32k	10
+	size_weight	64k	8
+	size_weight	128k	5
+	size_weight	256k	4
+	size_weight	512k	3
+	size_weight	8m	2
+	size_weight	32m	1
+#	size_weight	1g	1
+
+#	min_filesize	= 4k
+#	max_filesize	= 10m
+
+#	num_files	= 0
+	init_size	= 100m
+#	init_size	= 6GB
+#	init_size	= 1gb
+#	init_util	= 0.002
+
+	agefs		= 0
+	[threadgroup]
+		num_threads	= 10
+		write_size	= 400
+		write_blocksize	= 1024
+		create_weight	= 10
+		append_weight	= 10
+		delete_weight	= 1
+	[end]
+	desired_util	= 0.005
+
+
+[end]
+
+#[filesystem]
+#	location	= /mnt/test1
+#	clone		= /mnt/test2
+#[end]
+
+[threadgroup]
+	num_threads	= 4
+
+#	bindfs		= /mnt/test1
+
+	append_weight		= 1
+	append_fsync_weight	= 1
+	stat_weight		= 1
+#	write_weight		= 1
+#	write_fsync_weight	= 1
+#	read_weight		= 1
+	create_weight		= 1
+	create_fsync_weight	= 1
+	delete_weight		= 1
+	readall_weight		= 1
+	writeall_weight		= 1
+	writeall_fsync_weight	= 1
+	open_close_weight	= 1
+
+	read_random	= 0
+	write_random	= 0
+
+	write_size	= 40k
+	write_blocksize	= 4k
+	read_size	= 40k
+	read_blocksize	= 4k
+
+	op_delay	= 0
+
+	[stats]
+		enable_stats	= 1
+		enable_range	= 0
+
+#		ignore		= close
+#		ignore		= open
+#		ignore		= lseek
+#		ignore		= write
+#		ignore		= read
+
+		msec_range	0.00 0.01
+		msec_range	0.01 0.02
+		msec_range	0.02 0.03
+		msec_range	0.03 0.04
+		msec_range	0.04 0.05
+		msec_range	0.05 0.1
+		msec_range	0.1 0.2
+		msec_range	0.2 0.5
+		msec_range	0.5 1.0
+		msec_range	1.0 2.0
+		msec_range	2.0 3.0
+		msec_range	3.0 4.0
+		msec_range	4.0 5.0
+		msec_range	5.0 10.0
+		msec_range	10.0 10000.0
+	[end]
+[end]
+
+#[threadgroup]
+#	num_threads	= 1
+#
+#	readall_weight  = 0
+#	writeall_weight = 0
+#	createdir_weight = 0
+#
+#	write_size      = 4096
+#	write_blocksize = 4096
+#	read_size       = 4096
+#	read_blocksize  = 4096
+#
+#	op_delay	= 12
+#[end]
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb.h b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb.h
new file mode 100644
index 0000000..ad9fcad
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb.h
@@ -0,0 +1,105 @@
+/*
+ *   Copyright (c) International Business Machines Corp., 2001-2004
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+#ifndef _FFSB_H_
+#define _FFSB_H_
+
+#include <sys/time.h>
+#include <sys/resource.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+
+#include "config.h"
+
+#include "ffsb_op.h"
+#include "ffsb_tg.h"
+#include "ffsb_fs.h"
+
+/*
+ * The main thread wakes up once in so many seconds to check elapsed
+ * time this is a tunable for that sleep interval in seconds
+ */
+
+#define FFSB_TG_WAIT_TIME (1)
+
+#define MARK printf("MARK FUNC: %s() @ %s:%d\n", __FUNCTION__, __FILE__, __LINE__);
+
+struct results {
+	struct rusage before;
+	struct rusage after;
+	double runtime;
+	double cputime;
+	double cpu_before;
+	double cpu_after;
+	double cpu_total;
+};
+
+struct ffsb_tg;
+struct ffsb_fs;
+
+typedef struct profile_config {
+	struct config_options *global;
+	struct container *fs_container;
+	struct container *tg_container;
+} profile_config_t;
+
+typedef struct ffsb_config {
+	unsigned time;
+
+	unsigned num_filesys;
+	unsigned num_threadgroups;
+
+	int num_totalthreads;		/* gets calculated after init() */
+
+	struct ffsb_tg *groups;
+	struct ffsb_fs *filesystems;
+
+	struct profile_config *profile_conf;
+	char *callout;			/* we will try and exec this */
+
+	struct results results;
+} ffsb_config_t;
+
+void init_ffsb_config(ffsb_config_t *fc, unsigned num_fs, unsigned num_tg);
+
+/*
+ * this is kind of like a special case "constructor" which is only
+ * used by fs-aging code to build a fake config for the aging tg
+ */
+void init_ffsb_config_1fs(ffsb_config_t *fc, struct ffsb_fs *fs,
+			   struct ffsb_tg *tg);
+
+void destroy_ffsb_config(ffsb_config_t *fc);
+
+/* getters/setters, parser only should use setters */
+
+void fc_set_time(ffsb_config_t *fc, unsigned time);
+
+void fc_set_num_totalthreads(ffsb_config_t *fc, int num);
+
+/* num is zero-based */
+/* get a particular threadgroup object */
+struct ffsb_tg *fc_get_tg(ffsb_config_t *fc, unsigned num);
+
+/* get a particular filesystem object */
+struct ffsb_fs *fc_get_fs(ffsb_config_t *fc, unsigned num);
+
+void fc_set_callout(ffsb_config_t *fc, char *callout);
+char *fc_get_callout(ffsb_config_t *fc);
+
+#endif
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_fc.c b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_fc.c
new file mode 100644
index 0000000..99de871
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_fc.c
@@ -0,0 +1,112 @@
+/*
+ *   Copyright (c) International Business Machines Corp., 2001-2004
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+#include <pthread.h>
+#include <sys/time.h>
+#include <sys/times.h>
+#include <unistd.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <pthread.h>
+
+#include <assert.h>
+
+#include "config.h"
+
+#include "ffsb.h"
+#include "util.h"
+#include "parser.h"
+
+void init_ffsb_config(ffsb_config_t *fc, unsigned num_fs, unsigned num_tg)
+{
+	memset(fc, 0, sizeof(ffsb_config_t));
+
+	fc->num_totalthreads = -1;
+	fc->num_threadgroups = num_tg;
+	fc->num_filesys = num_fs;
+
+	fc->groups = ffsb_malloc(sizeof(ffsb_tg_t) * num_tg);
+	fc->filesystems = ffsb_malloc(sizeof(ffsb_fs_t) * num_fs);
+}
+
+void init_ffsb_config_1fs(ffsb_config_t *fc, ffsb_fs_t *fs, ffsb_tg_t *tg)
+{
+	memset(fc, 0, sizeof(*fc));
+
+	fc->num_totalthreads = tg_get_numthreads(tg);
+	fc->num_threadgroups = 1;
+	fc->num_filesys = 1;
+
+	fc->groups = tg;
+	fc->filesystems = fs;
+}
+
+void destroy_ffsb_config(ffsb_config_t *fc)
+{
+	int i;
+	for (i = 0; i < fc->num_filesys; i++)
+		destroy_ffsb_fs(&fc->filesystems[i]);
+
+	for (i = 0; i < fc->num_threadgroups; i++)
+		destroy_ffsb_tg(&fc->groups[i]);
+
+	free(fc->groups);
+	free(fc->filesystems);
+}
+
+void fc_set_time(ffsb_config_t *fc, unsigned time)
+{
+	fc->time = time;
+}
+
+unsigned fc_get_num_filesys(ffsb_config_t *fc)
+{
+	return fc->num_filesys;
+}
+
+
+
+struct ffsb_tg *fc_get_tg(ffsb_config_t *fc, unsigned num)
+{
+	assert(num < fc->num_threadgroups);
+	return &fc->groups[num];
+}
+
+struct ffsb_fs *fc_get_fs(ffsb_config_t *fc, unsigned num)
+{
+	assert(num < fc->num_filesys);
+	return &fc->filesystems[num];
+}
+
+void fc_set_num_totalthreads(ffsb_config_t *fc, int num)
+{
+	assert(num > 0);
+	fc->num_totalthreads = num;
+}
+
+void fc_set_callout(ffsb_config_t *fc, char *callout)
+{
+	if (fc->callout)
+		free(fc->callout);
+	fc->callout = ffsb_strdup(callout);
+}
+
+char *fc_get_callout(ffsb_config_t *fc)
+{
+	return fc->callout;
+}
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_fs.c b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_fs.c
new file mode 100644
index 0000000..9715406
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_fs.c
@@ -0,0 +1,634 @@
+/*
+ *   Copyright (c) International Business Machines Corp., 2001-2004
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <dirent.h>
+#include <fcntl.h>
+
+#include "ffsb_fs.h"
+#include "util.h"
+#include "fh.h"
+
+/* First zero out struct, set num_dirs, and strdups basedir */
+void init_ffsb_fs(ffsb_fs_t *fs, char *basedir, uint32_t num_data_dirs,
+		  uint32_t numstartfiles, unsigned flags)
+{
+	memset(fs, 0, sizeof(ffsb_fs_t));
+	fs->basedir = ffsb_strdup(basedir);
+	fs->num_dirs = num_data_dirs;
+	fs->num_start_files = numstartfiles;
+	fs->flags = flags;
+	fs->create_blocksize = FFSB_FS_DEFAULT_CREATE_BLOCKSIZE;
+	fs->age_blocksize = FFSB_FS_DEFAULT_AGE_BLOCKSIZE;
+	fs->age_fs = 0;
+}
+
+/*
+ * Does not remove files/dirs on disk, only frees up data
+ * structures
+*/
+void destroy_ffsb_fs(ffsb_fs_t *fs)
+{
+	free(fs->basedir);
+	destroy_filelist(&fs->files);
+	destroy_filelist(&fs->fill);
+	destroy_filelist(&fs->meta);
+}
+
+void clone_ffsb_fs(ffsb_fs_t *target, ffsb_fs_t *orig)
+{
+	target->basedir = orig->basedir;
+	target->flags = orig->flags;
+
+	/* !!!! hackish, write a filelist_clone() function later */
+	memcpy(&target->files, &orig->files, sizeof(orig->files));
+	memcpy(&target->fill, &orig->fill, sizeof(orig->fill));
+	memcpy(&target->meta, &orig->meta, sizeof(orig->meta));
+
+	target->num_dirs = orig->num_dirs;
+	target->num_start_files = orig->num_start_files;
+	target->minfilesize = orig->minfilesize;
+	target->maxfilesize = orig->maxfilesize;
+
+	target->start_fsutil = orig->start_fsutil;
+	target->desired_fsutil = orig->desired_fsutil;
+
+	target->age_fs = orig->age_fs;
+	target->num_age_dirs = orig->num_age_dirs;
+	target->aging_tg = orig->aging_tg;
+
+	target->create_blocksize = orig->create_blocksize;
+	target->age_blocksize = orig->age_blocksize;
+
+	memcpy(target->op_data, orig->op_data, sizeof(void *) * FFSB_NUMOPS);
+}
+
+static void add_files(ffsb_fs_t *fs, struct benchfiles *bf, int num,
+		      uint64_t minsize, uint64_t maxsize, unsigned blocksize)
+{
+	struct ffsb_file *cur;
+	int i, fd, condition = 0, has_directio = 0;
+	randdata_t rd;
+	char *buf = ffsb_malloc(blocksize);
+	uint64_t initial_free = getfsutil_size(fs->basedir);
+
+	if (fs_get_directio(fs)) {
+		has_directio = 1;
+		fs_set_directio(fs, 0);
+	}
+
+	assert(blocksize);
+
+	init_random(&rd, 0);
+
+	if (num)
+		condition = num;
+	else if (fs->init_size) {
+		if (getfsutil(fs->basedir) != initial_free ||
+		    fs->init_size > (getfsutil_size(fs->basedir) -
+		    initial_free))
+			condition = 1;
+		else
+			condition = 0;
+	}
+	else if (fs->init_fsutil) {
+		if (fs->init_fsutil > getfsutil(fs->basedir))
+			condition = 1;
+		else
+			condition = 0;
+	}
+
+	while (condition) {
+		uint64_t size;
+		if (fs->num_weights) {
+			int num = 1 + getrandom(&rd, fs->sum_weights);
+			int curop = 0;
+
+			while (fs->size_weights[curop].weight < num) {
+				num -= fs->size_weights[curop].weight;
+				curop++;
+			}
+			size = fs->size_weights[curop].size;
+		}
+		else
+			size = minsize + getllrandom(&rd, maxsize - minsize);
+
+		cur = add_file(bf, size, &rd);
+		fd = fhopencreate(cur->name, NULL, fs);
+		writefile_helper(fd, size, blocksize, buf, NULL, fs);
+		fhclose(fd, NULL, fs);
+		unlock_file_writer(cur);
+
+		if (num)
+			condition--;
+		else if (fs->init_size) {
+			if (fs->init_size > getfsutil_size(fs->basedir) -
+			    initial_free)
+				condition = 1;
+			else
+				condition = 0;
+		}
+		else if (fs->init_fsutil) {
+			if (fs->init_fsutil > getfsutil(fs->basedir))
+				condition = 1;
+			else
+				condition = 0;
+		}
+
+	}
+	free(buf);
+	if (has_directio)
+		fs_set_directio(fs, 1);
+}
+
+static void age_fs(ffsb_fs_t *fs, double utilization);
+static ffsb_fs_t *construct_new_fileset(ffsb_fs_t *fs);
+static ffsb_fs_t *check_existing_fileset(ffsb_fs_t *fs);
+
+void *construct_ffsb_fs(void *data)
+{
+	ffsb_fs_t *fs  = (ffsb_fs_t *)data;
+	ffsb_fs_t *ret = NULL;
+
+	if (fs_get_reuse_fs(fs)) {
+		printf("checking existing fs: %s\n", fs->basedir);
+		ret = check_existing_fileset(fs);
+		if (ret == NULL) {
+			printf("recreating new fileset\n");
+			ret = construct_new_fileset(fs);
+		}
+	} else {
+		printf("creating new fileset %s\n", fs->basedir);
+		ret = construct_new_fileset(fs);
+	}
+	if (ret == NULL) {
+		printf("fs setup on %s failed\n", fs->basedir);
+		exit(1);
+	}
+	return ret;
+}
+
+static int verify_file(struct benchfiles *bf, char *fname, void *fs_ptr)
+{
+	ffsb_fs_t *fs = (ffsb_fs_t *)fs_ptr;
+	uint64_t minsize = fs->minfilesize;
+	uint64_t maxsize = fs->maxfilesize;
+	uint64_t filesize = 0;
+	int fd = 0;
+	DIR *dirptr = NULL;
+
+	/* If it is a directory and it passed the name verification we
+	 * don't need to do anything here
+	 */
+	dirptr = opendir(fname);
+	if (dirptr) {
+		closedir(dirptr);
+		return 0;
+	}
+
+	fd = open(fname, O_RDONLY);
+	/* If we can't open it for read we're done */
+	if (fd < 0) {
+		printf("verify_file: error opening %s for readonly\n", fname);
+		perror(fname);
+		return 1;
+	}
+	close(fd);
+	filesize = ffsb_get_filesize(fname);
+
+	if (filesize < minsize || filesize > maxsize) {
+		printf("size %llu bytes for file %s is invalid\n",
+		       filesize, fname);
+		return 1;
+	}
+
+	return 0;
+}
+
+/* Record the number of files and directorys there are supposed to be
+ * grab (check and build the structures) the regular data fileset then
+ * check to make sure the number of directories and files in that
+ * filelist matches up.  Then grab the meta filelist and verify that
+ * the meta filelist is empty.  Set up the filelist for fill (aging)
+ * and setup the ops for the benchmark.
+*/
+static ffsb_fs_t *check_existing_fileset(ffsb_fs_t *fs)
+{
+	char buf[FILENAME_MAX * 3];
+	int retval = 0;
+	uint32_t num_dirs = fs->num_dirs;
+	uint32_t num_files = fs->num_start_files;
+
+	if (fs->age_fs) {
+		printf("Aging and reusing the fileset are mutually "
+		       "exclusive\n");
+		printf("aborting\n");
+		return NULL;
+	}
+
+	/* Set up bench/age dir */
+	if (FILENAME_MAX <=
+	    snprintf(buf, FILENAME_MAX, "%s/%s", fs->basedir, FILES_BASE)) {
+		printf("pathname \"%s\" is too long, aborting\n", buf);
+		return NULL;
+	}
+
+	/* Make a "dummy" filelist that has numsubdirs set to 0 and
+	 * numstartfiles set to 0
+	 */
+	init_filelist(&fs->files, buf, FILES_BASE, 0, 0);
+
+	retval = grab_old_fileset(&fs->files, buf, verify_file, fs);
+
+	if (retval)
+		return NULL;
+
+	if ((get_listsize(&fs->files) != num_files) ||
+	    (get_numsubdirs(&fs->files) != num_dirs)) {
+		printf("check_existing_fileset: number of files (%u)"
+		       " or directorys (%u) don't match up\n",
+		       get_listsize(&fs->files), get_numsubdirs(&fs->files));
+		destroy_filelist(&fs->files);
+		return NULL;
+	}
+
+	if (FILENAME_MAX <=
+	    snprintf(buf, FILENAME_MAX, "%s/%s", fs->basedir, META_BASE)) {
+		printf("pathname \"%s\" is too long, aborting\n", buf);
+		return NULL;
+	}
+
+	init_filelist(&fs->meta, buf, META_BASE, 0, 1);
+	retval = grab_old_fileset(&fs->meta, buf, verify_file, fs);
+
+	if (retval) {
+		destroy_filelist(&fs->files);
+		return NULL;
+	}
+
+	if ((get_listsize(&fs->meta) != 0) ||
+	    (get_numsubdirs(&fs->meta) != 0)) {
+		printf("check_existing_fileset: meta directory isn't empty\n"
+		       "aborting\n");
+		destroy_filelist(&fs->files);
+		destroy_filelist(&fs->meta);
+		return NULL;
+	}
+
+	/* Even though we won't use it, we still need to be consistent
+	 * here.
+	 */
+	init_filelist(&fs->fill,  buf, AGE_BASE, 0, 0);
+
+	/* Have to do this or everything else could break. */
+	ops_setup_bench(fs);
+
+	return fs;
+}
+
+/*
+ *  clean up fs, "rm -rf data meta"
+ *  record utilization
+ *  set up the dirs: files, meta
+ *  age filesystem
+ *  have ffsb_ops setup their data
+ *  create starting files in files
+ */
+static ffsb_fs_t *construct_new_fileset(ffsb_fs_t *fs)
+{
+	char buf[FILENAME_MAX * 3];
+
+	/* TODO: Convert this quick and dirty rm -rf to a "real"
+	 * programmatic version, that doesn't rely on the rm command.
+	 */
+	if (FILENAME_MAX * 3 <= snprintf(buf, FILENAME_MAX * 3,
+					 "rm -rf %s/data %s/meta",
+					 fs->basedir, fs->basedir)) {
+		printf("pathname too long for command \"%s\"\n", buf);
+		return NULL;
+	}
+
+	if (ffsb_system(buf) < 0) {
+		perror(buf);
+		return NULL;
+	}
+
+	fs->start_fsutil = getfsutil(fs->basedir);
+
+	/* Set up bench/age dir */
+	if (FILENAME_MAX <=
+	    snprintf(buf, FILENAME_MAX, "%s/%s", fs->basedir, FILES_BASE)) {
+		printf("pathname \"%s\" is too long, aborting\n", buf);
+		return NULL;
+	}
+
+	ffsb_mkdir(buf);
+
+	/* Regular files and aging share this directory */
+	init_filelist(&fs->files, buf, FILES_BASE, fs->num_dirs, 1);
+	init_filelist(&fs->fill, buf, AGE_BASE, fs->num_age_dirs, 1);
+
+	/* Set up meta dir */
+	snprintf(buf, FILENAME_MAX, "%s/%s", fs->basedir, META_BASE);
+
+	ffsb_mkdir(buf);
+
+	init_filelist(&fs->meta, buf, META_BASE, 0, 1);
+
+	/* Do aging */
+	if (fs->age_fs)
+		age_fs(fs, fs->desired_fsutil);
+
+	/* Call back into ops, set for benchmark */
+	ops_setup_bench(fs);
+
+	/* Create initial fileset */
+	add_files(fs, &fs->files, fs->num_start_files, fs->minfilesize,
+		  fs->maxfilesize, fs->create_blocksize);
+	return fs;
+}
+
+
+struct poll_data {
+	ffsb_fs_t *fs;
+	double    util;
+};
+
+static int fs_get_util(void *data)
+{
+	struct poll_data *pd = (struct poll_data *) data;
+	double fsutil = getfsutil(pd->fs->basedir);
+
+	if (fsutil >= pd->util)
+		return 1;
+
+	return 0;
+}
+
+static void age_fs(ffsb_fs_t *fs, double utilization)
+{
+	ffsb_barrier_t barrier;
+	pthread_t thread;
+	struct poll_data pdata;
+	ffsb_tg_t *tg = fs_get_aging_tg(fs);
+	tg_run_params_t params;
+	ffsb_config_t fc;
+
+	printf("aging fs %s from %.2lf to %.2lf\n", fs->basedir,
+	       fs->start_fsutil, utilization);
+	ffsb_barrier_init(&barrier, tg_get_numthreads(tg));
+
+	init_ffsb_config_1fs(&fc, fs, tg);
+
+	pdata.fs = fs;
+	pdata.util = utilization;
+
+	params.tg = tg;
+	params.poll_fn = fs_get_util;
+	params.poll_data = &pdata;
+	params.wait_time = 1;
+	params.fc = &fc;
+
+	params.tg_barrier = NULL;
+	params.thread_barrier = &barrier;
+
+	/* Call back into ops, setup for aging */
+	ops_setup_age(fs);
+
+	/* Throw in some files to start off, so there's something */
+	add_files(fs, &fs->fill, 10, 0, 0, fs->age_blocksize);
+
+	pthread_create(&thread, NULL, tg_run, &params);
+	pthread_join(thread, NULL);
+}
+
+void fs_set_create_blocksize(ffsb_fs_t *fs, uint32_t blocksize)
+{
+	fs->create_blocksize = blocksize;
+}
+
+void fs_set_age_blocksize(ffsb_fs_t *fs, uint32_t blocksize)
+{
+	fs->age_blocksize = blocksize;
+}
+
+uint32_t fs_get_create_blocksize(ffsb_fs_t *fs)
+{
+	return fs->create_blocksize;
+}
+
+uint32_t fs_get_age_blocksize(ffsb_fs_t *fs)
+{
+	return fs->age_blocksize;
+}
+
+char *fs_get_basedir(ffsb_fs_t *fs)
+{
+	return fs->basedir;
+}
+
+uint32_t fs_get_numstartfiles(ffsb_fs_t *fs)
+{
+	return fs->num_start_files;
+}
+
+uint32_t fs_get_numdirs(ffsb_fs_t *fs)
+{
+	return fs->num_dirs;
+}
+
+int fs_get_libcio(ffsb_fs_t *fs)
+{
+	return fs->flags & FFSB_FS_LIBCIO;
+}
+
+void fs_set_libcio(ffsb_fs_t *fs, int lio)
+{
+	if (lio)
+		fs->flags |= FFSB_FS_LIBCIO;
+	else
+		fs->flags &= ~0 & ~FFSB_FS_LIBCIO;
+}
+
+int fs_get_directio(ffsb_fs_t *fs)
+{
+	return fs->flags & FFSB_FS_DIRECTIO;
+}
+
+void fs_set_directio(ffsb_fs_t *fs, int dio)
+{
+	if (dio)
+		fs->flags |= FFSB_FS_DIRECTIO;
+	else
+		fs->flags &= ~0 & ~FFSB_FS_DIRECTIO;
+}
+
+int fs_get_alignio(ffsb_fs_t *fs)
+{
+	return fs->flags & FFSB_FS_ALIGNIO4K;
+}
+
+void fs_set_alignio(ffsb_fs_t *fs, int aio)
+{
+	if (aio)
+		fs->flags |= FFSB_FS_ALIGNIO4K;
+	else
+		fs->flags &= ~0 & ~FFSB_FS_ALIGNIO4K;
+}
+
+int fs_get_reuse_fs(ffsb_fs_t *fs)
+{
+	return fs->flags & FFSB_FS_REUSE_FS;
+}
+
+void fs_set_reuse_fs(ffsb_fs_t *fs, int rfs)
+{
+	if (rfs)
+		fs->flags |= FFSB_FS_REUSE_FS;
+	else
+		fs->flags &= ~0 & ~FFSB_FS_REUSE_FS;
+}
+
+struct benchfiles *fs_get_datafiles(ffsb_fs_t *fs)
+{
+	return &fs->files;
+}
+
+struct benchfiles *fs_get_metafiles(ffsb_fs_t *fs)
+{
+	return &fs->meta;
+}
+
+struct benchfiles *fs_get_agefiles(ffsb_fs_t *fs)
+{
+	return &fs->fill;
+}
+
+void fs_set_aging_tg(ffsb_fs_t *fs, struct ffsb_tg *tg, double util)
+{
+	fs->aging_tg = tg;
+	fs->age_fs = 1;
+	fs->desired_fsutil = util;
+}
+
+struct ffsb_tg *fs_get_aging_tg(ffsb_fs_t *fs)
+{
+	return fs->aging_tg;
+}
+
+int fs_get_agefs(ffsb_fs_t *fs)
+{
+	return fs->age_fs;
+}
+
+/* TODO: Implement this!!!*/
+void fs_set_num_age_dirs(ffsb_fs_t *fs, uint32_t numdirs)
+{
+	fs->num_age_dirs = numdirs;
+}
+
+void fs_set_opdata(ffsb_fs_t *fs, void *data, unsigned opnum)
+{
+	fs->op_data[opnum] = data;
+}
+
+void *fs_get_opdata(ffsb_fs_t *fs, unsigned opnum)
+{
+	return fs->op_data[opnum];
+}
+
+void fs_set_min_filesize(ffsb_fs_t *fs, uint64_t size)
+{
+	fs->minfilesize = size;
+}
+
+void fs_set_max_filesize(ffsb_fs_t *fs, uint64_t size)
+{
+	fs->maxfilesize = size;
+}
+
+uint64_t fs_get_min_filesize(ffsb_fs_t *fs)
+{
+	return fs->minfilesize;
+}
+
+uint64_t fs_get_max_filesize(ffsb_fs_t *fs)
+{
+	return fs->maxfilesize;
+}
+
+double fs_get_desired_fsutil(ffsb_fs_t *fs)
+{
+	return fs->desired_fsutil;
+}
+
+void fs_print_config(ffsb_fs_t *fs)
+{
+	char buf[256];
+
+	printf("FileSystem %s\n", fs->basedir);
+	printf("==========\n");
+	printf("\t num_dirs         = %u\n", fs->num_dirs);
+	printf("\t starting files   = %u\n", fs->num_start_files);
+	printf("\t\n");
+	if (fs->num_weights) {
+		int i;
+		printf("\t Fileset weight:\n");
+		for (i = 0; i < fs->num_weights; i++)
+			printf("\t\t %12llu (%6s) -> %u (%.2f\%)\n",
+			       fs->size_weights[i].size,
+			       ffsb_printsize(buf, fs->size_weights[i].size, 256),
+			       fs->size_weights[i].weight,
+			       ((float)fs->size_weights[i].weight /
+				(float)fs->sum_weights) * 100);
+	}
+	else {
+		printf("\t min file size    = %llu\t(%s)\n", fs->minfilesize,
+		       ffsb_printsize(buf, fs->minfilesize, 256));
+		printf("\t max file size    = %llu\t(%s)\n", fs->maxfilesize,
+		       ffsb_printsize(buf, fs->maxfilesize, 256));
+	}
+	printf("\t directio         = %s\n", (fs->flags & FFSB_FS_DIRECTIO) ?
+	       "on" : "off");
+	printf("\t alignedio        = %s\n", (fs->flags & FFSB_FS_ALIGNIO4K) ?
+	       "on" : "off");
+	printf("\t bufferedio       = %s\n", (fs->flags & FFSB_FS_LIBCIO) ?
+	       "on" : "off");
+	printf("\t\n");
+	printf("\t aging is %s\n", (fs->age_fs) ? "on" : "off");
+	printf("\t current utilization = %.2f\%\n", getfsutil(fs->basedir)*100);
+	if (fs->age_fs) {
+		printf("\t desired utilization = %.2lf%\n", fs->desired_fsutil * 100);
+		printf("\t \n");
+		tg_print_config_aging(fs->aging_tg, fs->basedir);
+	}
+	printf("\t\n");
+}
+
+int fs_needs_stats(ffsb_fs_t *fs, syscall_t sys)
+{
+	return (fs != NULL) ? (int)fs->fsd.config : 0;
+}
+
+void fs_add_stat(ffsb_fs_t *fs, syscall_t sys, uint32_t val)
+{
+	if (fs)
+		ffsb_add_data(&fs->fsd, sys, val);
+}
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_fs.h b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_fs.h
new file mode 100644
index 0000000..7b38104
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_fs.h
@@ -0,0 +1,184 @@
+/*
+ *   Copyright (c) International Business Machines Corp., 2001-2004
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+#ifndef _FFSB_FS_H_
+#define _FFSB_FS_H_
+
+#include "filelist.h"
+#include "ffsb_op.h"
+#include "ffsb_tg.h"
+#include "ffsb_stats.h"
+
+/* These are the base names for the different file types on a
+ * filesystem.
+*/
+#define FILES_BASE "data"
+#define META_BASE  "meta"
+#define AGE_BASE   "fill"
+
+struct ffsb_tg;
+
+typedef struct size_weight {
+	uint64_t size;
+	int weight;
+} size_weight_t;
+
+/* A filesystem object
+ * --
+ * represents a filesystem on disk, and maintains access to the different
+ * directories within it.  Currently there are two directories created in
+ * each filesystem: data and meta
+ * "data" contains the aging files and the working set files
+ * "meta" only contains directories for use in the metadata operation
+ *
+ * Aging
+ * This object contains methods for aging the filesystem if needed
+ * a properly set up threadgroup is supplied by the parser which is run
+ * until the filesystem reaches the desired utilization
+ *
+ * Operations
+ * The semantics of a ffsb operation are always such that they occur on
+ * a filesystem, so the filesystem also hold operation specific data as
+ * an opaque type
+ * One example of how this is useful is the aging process, where a different
+ * set of files is operated upon than in the regular benchmark and the
+ * op_data is pointing to the "fill" set rather than the "files" set
+ */
+
+typedef struct ffsb_fs {
+	char *basedir;
+
+	struct benchfiles files;
+	struct benchfiles meta;
+	struct benchfiles fill;
+
+	int flags;
+#define FFSB_FS_DIRECTIO   (1 << 0)
+#define FFSB_FS_ALIGNIO4K  (1 << 1)
+#define FFSB_FS_LIBCIO     (1 << 2)
+#define FFSB_FS_REUSE_FS   (1 << 3)
+
+	/* These pararmeters pertain to files in the files and fill
+	 * dirs.  Meta dir only contains directories, starting with 0.
+	 */
+	uint32_t num_dirs;
+	uint32_t num_start_files;
+	uint64_t minfilesize, maxfilesize;
+	double init_fsutil;
+	uint64_t init_size;
+
+	/* These two parameters specify the blocksize to use for
+	 * writes when creating and aging the fs.
+	 */
+	uint32_t create_blocksize, age_blocksize;
+#define FFSB_FS_DEFAULT_CREATE_BLOCKSIZE 4096
+#define FFSB_FS_DEFAULT_AGE_BLOCKSIZE    4096
+
+	double start_fsutil;
+
+	/* Aging data/parameters */
+	double desired_fsutil;
+	int age_fs;
+	uint32_t num_age_dirs;
+
+	/* Use an ffsb thread group to do the aging work */
+	struct ffsb_tg *aging_tg;
+
+	/* If a particular operation wants to maintain fs-specific
+	 * data, it should use this array.  Naturally, the ops must
+	 * synchonize access to the data for now, they are all just
+	 * putting pointers to a particular benchfiles struct here,
+	 * which is already sync'ed
+	 */
+	void *op_data[FFSB_NUMOPS];
+
+	/* per-fs stats */
+	ffsb_statsc_t fsc;
+	ffsb_statsd_t fsd;
+
+	size_weight_t *size_weights;
+	unsigned num_weights;
+	unsigned sum_weights;
+
+} ffsb_fs_t;
+
+/* Set up the structure, zeros everything out and dups the basedir
+ * string
+ */
+void init_ffsb_fs(ffsb_fs_t *fs, char *basedir, uint32_t num_data_dirs,
+		  uint32_t num_start_files, unsigned flags);
+
+/* Does not remove files/dirs on disk, only frees up data
+ * structures
+ */
+void destroy_ffsb_fs(ffsb_fs_t *fs);
+
+/* Set up the files and such on the disk including aging if requested.
+ * Should call back into each op, which initialize its op_data[]
+ * entry.  Aging is done by starting the aging_tg thread group, and
+ * waiting until the desired utilization is achieved.  It can (and is)
+ * be used with pthread_create().  Parameter should be a ffsb_fs_t * ,
+ * and it will return the same type
+ */
+void *construct_ffsb_fs(void *ffsb_fs_ptr);
+
+/* Shallow clone, original should simply be discarded (not destroyed).
+ * Generally should only be used by parser to write into the config
+ * object
+ */
+void clone_ffsb_fs(ffsb_fs_t *target, ffsb_fs_t *original);
+
+void fs_print_config(ffsb_fs_t *fs);
+
+char *fs_get_basedir(ffsb_fs_t *fs);
+int fs_get_directio(ffsb_fs_t *fs);
+void fs_set_directio(ffsb_fs_t *fs, int dio);
+int fs_get_alignio(ffsb_fs_t *fs);
+void fs_set_alignio(ffsb_fs_t *fs, int aio);
+int fs_get_libcio(ffsb_fs_t *fs);
+void fs_set_libcio(ffsb_fs_t *fs, int lio);
+int fs_get_reuse_fs(ffsb_fs_t *fs);
+void fs_set_reuse_fs(ffsb_fs_t *fs, int rfs);
+
+struct benchfiles *fs_get_datafiles(ffsb_fs_t *fs);
+struct benchfiles *fs_get_metafiles(ffsb_fs_t *fs);
+struct benchfiles *fs_get_agefiles(ffsb_fs_t *fs);
+
+void fs_set_aging_tg(ffsb_fs_t *fs, struct ffsb_tg *, double util);
+struct ffsb_tg *fs_get_aging_tg(ffsb_fs_t *fs);
+int fs_get_agefs(ffsb_fs_t *fs);
+
+void fs_set_opdata(ffsb_fs_t *fs, void *data, unsigned opnum);
+void *fs_get_opdata(ffsb_fs_t *fs, unsigned opnum);
+void fs_set_min_filesize(ffsb_fs_t *fs, uint64_t size);
+void fs_set_max_filesize(ffsb_fs_t *fs, uint64_t size);
+void fs_set_create_blocksize(ffsb_fs_t *fs, uint32_t blocksize);
+void fs_set_age_blocksize(ffsb_fs_t *fs, uint32_t blocksize);
+uint32_t fs_get_create_blocksize(ffsb_fs_t *fs);
+uint32_t fs_get_age_blocksize(ffsb_fs_t *fs);
+uint64_t fs_get_min_filesize(ffsb_fs_t *fs);
+uint64_t fs_get_max_filesize(ffsb_fs_t *fs);
+uint32_t fs_get_numstartfiles(ffsb_fs_t *fs);
+uint32_t fs_get_numdirs(ffsb_fs_t *fs);
+
+double fs_get_desired_fsutil(ffsb_fs_t *fs);
+
+/* For these two, fs == NULL is OK */
+int fs_needs_stats(ffsb_fs_t *fs, syscall_t s);
+void fs_add_stat(ffsb_fs_t *fs, syscall_t sys, uint32_t val);
+
+#endif /* _FFSB_FS_H_ */
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_op.c b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_op.c
new file mode 100644
index 0000000..0cae599
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_op.c
@@ -0,0 +1,178 @@
+/*
+ *   Copyright (c) International Business Machines Corp., 2001-2004
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+
+#include "ffsb_op.h"
+#include "fileops.h"
+#include "metaops.h"
+
+ffsb_op_t ffsb_op_list[] =
+{{0, "read", ffsb_readfile, READ, fop_bench, NULL},
+ {1, "readall",	ffsb_readall, READ, fop_bench, NULL},
+ {2, "write", ffsb_writefile, WRITE, fop_bench, NULL},
+ {3, "create", ffsb_createfile, WRITE, fop_bench, fop_age},
+ {4, "append", ffsb_appendfile, WRITE, fop_bench, fop_age},
+ {5, "delete", ffsb_deletefile, NA, fop_bench, fop_age},
+ {6, "metaop", ffsb_metaops, NA, metaops_metadir, NULL},
+ {7, "createdir", ffsb_createdir, NA, fop_bench, NULL},
+ {8, "stat", ffsb_stat, NA, fop_bench, NULL},
+ {9, "writeall", ffsb_writeall, WRITE, fop_bench, NULL},
+ {10, "writeall_fsync", ffsb_writeall_fsync, WRITE, fop_bench, NULL},
+ {11, "open_close", ffsb_open_close, NA, fop_bench, NULL},
+ {12, "write_fsync", ffsb_writefile_fsync, WRITE, fop_bench, NULL},
+ {13, "create_fsync", ffsb_createfile_fsync, WRITE, fop_bench, fop_age},
+ {14, "append_fsync", ffsb_appendfile_fsync, WRITE, fop_bench, fop_age},
+};
+
+void init_ffsb_op_results(ffsb_op_results_t *results)
+{
+	memset(results, 0, sizeof(ffsb_op_results_t));
+}
+
+static int exclusive_op(ffsb_op_results_t *results, unsigned int op_num)
+{
+	int i;
+	int ret = 0;
+	for (i = 0; i < FFSB_NUMOPS ; i++) {
+		if (i == op_num)
+			continue;
+		ret += results->ops[i];
+	}
+
+	if (ret)
+		return 0;
+	return 1;
+}
+
+static void generic_op_print(char *name, unsigned num, double op_pcnt,
+			     double weigth_pcnt, double runtime, char *tput)
+{
+	printf("%20s : %12u\t%10.2lf\t%6.3lf%%\t\t%6.3lf%%\t  %11s\n",
+	       name, num, num/runtime, op_pcnt, weigth_pcnt, tput);
+}
+
+static void print_op_results(unsigned int op_num, ffsb_op_results_t *results,
+			     double runtime, unsigned total_ops,
+			     unsigned total_weight)
+{
+	char buf[256];
+
+	double op_pcnt = 100 * (double)results->ops[op_num] /
+		(double)total_ops;
+	double weight_pcnt = 100 * (double)results->op_weight[op_num] /
+		(double)total_weight;
+	if (ffsb_op_list[op_num].throughput) {
+		ffsb_printsize (buf, results->bytes[op_num] / runtime, 256);
+		sprintf(buf, "%s/sec\0", buf);
+	}
+	else
+		sprintf(buf, "NA\0");
+	generic_op_print(ffsb_op_list[op_num].op_name, results->ops[op_num],
+			 op_pcnt, weight_pcnt, runtime, buf);
+}
+
+#if 0
+static void print_op_throughput(unsigned int op_num, ffsb_op_results_t *results,
+				double runtime)
+{
+	if (ffsb_op_list[op_num].op_exl_print_fn != NULL)
+		ffsb_op_list[op_num].op_exl_print_fn(results, runtime, op_num);
+}
+#endif
+
+void print_results(struct ffsb_op_results *results, double runtime)
+{
+	int i;
+	uint64_t total_ops = 0;
+	uint64_t total_weight = 0;
+	char buf[256];
+
+	for (i = 0; i < FFSB_NUMOPS ; i++) {
+		total_ops += results->ops[i];
+		total_weight += results->op_weight[i];
+	}
+
+	printf("             Op Name   Transactions\t Trans/sec\t% Trans\t    % Op Weight\t   Throughput\n");
+	printf("             =======   ============\t =========\t=======\t    ===========\t   ==========\n");
+	for (i = 0; i < FFSB_NUMOPS ; i++)
+		if (results->ops[i] != 0)
+			print_op_results(i, results, runtime, total_ops,
+					 total_weight);
+	printf("-\n%.2lf Transactions per Second\n\n", (double)total_ops / runtime);
+
+	if (results->write_bytes || results->read_bytes)
+		printf("Throughput Results\n===================\n");
+	if (results->read_bytes) {
+		ffsb_printsize(buf, results->read_bytes / runtime, 256);
+		printf("Read Throughput: %s/sec\n", buf);
+	}
+	if (results->write_bytes) {
+		ffsb_printsize(buf, results->write_bytes / runtime, 256);
+		printf("Write Throughput: %s/sec\n", buf);
+	}
+}
+
+
+char *op_get_name(int opnum)
+{
+	return ffsb_op_list[opnum].op_name;
+}
+
+void ops_setup_bench(ffsb_fs_t *fs)
+{
+	int i;
+	for (i = 0; i < FFSB_NUMOPS; i++)
+		ffsb_op_list[i].op_bench(fs, i);
+}
+
+void ops_setup_age(ffsb_fs_t *fs)
+{
+	int i;
+	for (i = 0; i < FFSB_NUMOPS; i++)
+		if (ffsb_op_list[i].op_age)
+		    ffsb_op_list[i].op_age(fs, i);
+}
+
+int ops_find_op(char *opname)
+{
+	int i;
+	for (i = 0; i < FFSB_NUMOPS; i++)
+		if (!strcmp(opname, ffsb_op_list[i].op_name))
+			return i;
+	return -1;
+}
+
+void add_results(struct ffsb_op_results *target, struct ffsb_op_results *src)
+{
+	int i;
+	target->read_bytes += src->read_bytes;
+	target->write_bytes += src->write_bytes;
+
+	for (i = 0; i < FFSB_NUMOPS; i++) {
+		target->ops[i] += src->ops[i];
+		target->op_weight[i] += src->op_weight[i];
+		target->bytes[i] += src->bytes[i];
+	}
+}
+
+void do_op(struct ffsb_thread *ft, struct ffsb_fs *fs, unsigned op_num)
+{
+	ffsb_op_list[op_num].op_fn(ft, fs, op_num);
+}
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_op.h b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_op.h
new file mode 100644
index 0000000..1b4509b
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_op.h
@@ -0,0 +1,102 @@
+/*
+ *   Copyright (c) International Business Machines Corp., 2001-2004
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+#ifndef _FFSB_OP_H_
+#define _FFSB_OP_H_
+
+#include <stdlib.h>
+#include <sys/types.h>
+#include <inttypes.h>
+
+struct ffsb_op_results;
+struct ffsb_thread;
+struct ffsb_fs;
+
+#define NA 0x00
+#define READ 0x01
+#define WRITE 0x02
+
+/* This file handles all of the operations FFSB supports.  It has
+ * tight interactions with the filesystem objects, but is otherwise
+ * pretty abstract.
+ */
+
+/* The op callback */
+typedef void (*ffsb_op_fn)(struct ffsb_thread *, struct ffsb_fs *,
+			     unsigned op_num);
+
+/* Operation results printing function */
+typedef void (*ffsb_op_print_fn)(struct ffsb_op_results *, double secs,
+				  unsigned int op_num);
+
+/* Operation specific initialization for a filesystem */
+typedef void (*ffsb_op_fs_fn)(struct ffsb_fs *, unsigned opnum);
+
+typedef struct ffsb_op {
+	unsigned int op_id;
+	char *op_name;
+	ffsb_op_fn op_fn;
+
+	unsigned int throughput;
+	/* The point of these two fields is to determine which set of
+	 * files are being worked on.  Currently either data, meta, or
+	 * aging.  Data and meta are mutually exclusive, so we only
+	 * need two funcs.
+	 */
+	ffsb_op_fs_fn op_bench;
+	ffsb_op_fs_fn op_age;
+} ffsb_op_t;
+
+/* List of all operations, located in ffsb_op.c */
+extern ffsb_op_t ffsb_op_list[];
+
+/* This *must* be updated when a new operation is added or one is
+ * removed several other structures use it for statically sized arrays
+ */
+#define FFSB_NUMOPS (15)
+
+/* Returns index of an op.
+ * Returns -1 if opname isn't found, and its case sensitive :)
+ */
+int ops_find_op(char *opname);
+
+typedef struct ffsb_op_results {
+	/* Count of how many times each op was run */
+	unsigned int ops[FFSB_NUMOPS];
+	unsigned int op_weight[FFSB_NUMOPS];
+	uint64_t bytes[FFSB_NUMOPS];
+
+	uint64_t read_bytes;
+	uint64_t write_bytes;
+} ffsb_op_results_t;
+
+void init_ffsb_op_results(struct ffsb_op_results *);
+void print_results(struct ffsb_op_results *results, double runtime);
+char *op_get_name(int opnum);
+
+/* Setup the ops for the benchmark */
+void ops_setup_bench(struct ffsb_fs *fs);
+
+/* setup the ops for aging the filesystem */
+void ops_setup_age(struct ffsb_fs *fs);
+
+void add_results(struct ffsb_op_results *target, struct ffsb_op_results *src);
+
+/* Run this op, using this thread state, on this filesystem */
+void do_op(struct ffsb_thread *ft, struct ffsb_fs *fs, unsigned op_num);
+
+#endif /* _FFSB_OP_H_ */
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_stats.c b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_stats.c
new file mode 100644
index 0000000..d3e20fd
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_stats.c
@@ -0,0 +1,241 @@
+#include <stdio.h>
+#include <assert.h>
+#include <limits.h>
+#include "ffsb_stats.h"
+#include "util.h"
+
+char *syscall_names[] = {
+	"open",
+	"read",
+	"write",
+	"create",
+	"lseek",
+	"unlink",
+	"close",
+	"stat",
+};
+
+/* yuck, just for the parser anyway.. */
+int ffsb_stats_str2syscall(char *str, syscall_t *sys)
+{
+	int i;
+	int ret;
+	for (i = 0; i < FFSB_NUM_SYSCALLS; i++) {
+		ret = strncasecmp(syscall_names[i], str,
+				  strlen(syscall_names[i]));
+		/* printf("%s = syscall_names[%d] vs %str ret = %d\n",
+		 * syscall_names[i],i,str,ret);
+		 */
+		if (0 == ret) {
+			*sys = (syscall_t)i; /* ewww */
+			/* printf("matched syscall %s\n",syscall_names[i]); */
+			return 1;
+		}
+	}
+	printf("warning: failed to get match for syscall %s\n", str);
+	return 0;
+}
+
+void  ffsb_statsc_init(ffsb_statsc_t *fsc)
+{
+	fsc->num_buckets = 0;
+	fsc->buckets = NULL;
+	fsc->ignore_stats = 0;
+}
+
+void ffsb_statsc_addbucket(ffsb_statsc_t *fsc, uint32_t min, uint32_t max)
+{
+	struct stat_bucket *temp;
+	fsc->num_buckets++;
+
+	/* printf("ffsb_realloc(): fsc_buckets = %d\n",fsc->num_buckets); */
+	temp = ffsb_realloc(fsc->buckets, sizeof(struct stat_bucket) *
+			    fsc->num_buckets);
+
+	fsc->buckets = temp;
+
+	/* Convert to micro-secs from milli-secs */
+	fsc->buckets[fsc->num_buckets-1].min = min ;
+	fsc->buckets[fsc->num_buckets-1].max = max ;
+}
+
+void ffsb_statsc_destroy(ffsb_statsc_t *fsc)
+{
+	free(fsc->buckets);
+}
+
+void ffsb_statsc_ignore_sys(ffsb_statsc_t *fsc, syscall_t s)
+{
+	/* printf("fsis: oring 0x%x with 0x%x\n",
+	 *      fsc->ignore_stats,
+	 *      (1 << s ) );
+	 */
+	fsc->ignore_stats |= (1 << s);
+}
+
+int fsc_ignore_sys(ffsb_statsc_t *fsc, syscall_t s)
+{
+	return fsc->ignore_stats & (1 << s);
+}
+
+void ffsb_statsd_init(ffsb_statsd_t *fsd, ffsb_statsc_t *fsc)
+{
+	int i;
+	memset(fsd, 0, sizeof(*fsd));
+
+	for (i = 0; i < FFSB_NUM_SYSCALLS; i++) {
+		fsd->totals[i] = 0;
+		fsd->mins[i] = UINT_MAX;
+		fsd->maxs[i] = 0;
+		fsd->buckets[i] = ffsb_malloc(sizeof(uint32_t) *
+					      fsc->num_buckets);
+		assert(fsd->buckets[i] != NULL);
+
+		memset(fsd->buckets[i], 0, sizeof(uint32_t) *
+		       fsc->num_buckets);
+	}
+	fsd->config = fsc;
+}
+
+void ffsb_statsd_destroy(ffsb_statsd_t *fsd)
+{
+	int i ;
+	for (i = 0 ; i < FFSB_NUM_SYSCALLS; i++)
+		free(fsd->buckets[i]);
+}
+
+void ffsb_add_data(ffsb_statsd_t *fsd, syscall_t s, uint32_t value)
+{
+	unsigned num_buckets, i;
+	struct stat_bucket *bucket_defs;
+
+	if (!fsd || fsc_ignore_sys(fsd->config, s))
+		return;
+
+	if (value < fsd->mins[s])
+		fsd->mins[s] = value;
+	if (value > fsd->maxs[s])
+		fsd->maxs[s] = value;
+
+	fsd->counts[s]++;
+	fsd->totals[s] += value;
+
+	if (fsd->config->num_buckets == 0)
+		return;
+
+	num_buckets = fsd->config->num_buckets;
+	bucket_defs = fsd->config->buckets;
+
+	for (i = 0; i < num_buckets; i++) {
+		struct stat_bucket *b = &bucket_defs[i];
+
+		if (value <= b->max && value >= b->min) {
+			fsd->buckets[s][i]++;
+			break;
+		}
+	}
+}
+
+void ffsb_statsc_copy(ffsb_statsc_t *dest, ffsb_statsc_t *src)
+{
+	memcpy(dest, src, sizeof(*src));
+}
+
+void ffsb_statsd_add(ffsb_statsd_t *dest, ffsb_statsd_t *src)
+{
+	int i, j;
+	unsigned num_buckets;
+	if (dest->config != src->config)
+		printf("ffsb_statsd_add: warning configs do not"
+		       "match for data being collected\n");
+
+	num_buckets = dest->config->num_buckets;
+
+	for (i = 0; i < FFSB_NUM_SYSCALLS; i++) {
+		dest->counts[i] += src->counts[i];
+		dest->totals[i] += src->totals[i];
+
+		if (src->mins[i] < dest->mins[i])
+			dest->mins[i] = src->mins[i];
+		if (src->maxs[i] > dest->maxs[i])
+			dest->maxs[i] = src->maxs[i];
+
+		for (j = 0; j < num_buckets; j++)
+			dest->buckets[i][j] += src->buckets[i][j];
+	}
+}
+
+static void print_buckets_helper(ffsb_statsc_t *fsc, uint32_t *buckets)
+{
+	int i;
+	if (fsc->num_buckets == 0) {
+		printf("   -\n");
+		return;
+	}
+	for (i = 0; i < fsc->num_buckets; i++) {
+		struct stat_bucket *sb = &fsc->buckets[i];
+		printf("\t\t msec_range[%d]\t%f - %f : %8u\n",
+		       i, (double)sb->min/1000.0f, (double)sb->max/1000.0f,
+		       buckets[i]);
+	}
+	printf("\n");
+}
+
+void ffsb_statsd_print(ffsb_statsd_t *fsd)
+{
+	int i;
+	printf("\nSystem Call Latency statistics in millisecs\n" "=====\n");
+	printf("\t\tMin\t\tAvg\t\tMax\t\tTotal Calls\n");
+	printf("\t\t========\t========\t========\t============\n");
+	for (i = 0; i < FFSB_NUM_SYSCALLS; i++)
+		if (fsd->counts[i]) {
+			printf("[%7s]\t%05f\t%05lf\t%05f\t%12u\n",
+			       syscall_names[i], (float)fsd->mins[i] / 1000.0f,
+			       (fsd->totals[i] / (1000.0f *
+						  (double)fsd->counts[i])),
+			       (float)fsd->maxs[i] / 1000.0f, fsd->counts[i]);
+			print_buckets_helper(fsd->config, fsd->buckets[i]);
+		}
+}
+
+#if 0 /* Testing */
+
+void *ffsb_malloc(size_t s)
+{
+	void *p = malloc(s);
+	assert(p != NULL);
+	return p;
+}
+
+int main(int arc, char *argv[])
+{
+	ffsb_statsc_t fsc;
+	ffsb_statsd_t fsd;
+	int i ;
+
+	printf("init\n");
+
+	ffsb_statsc_init(&fsc, 10);
+	ffsb_statsc_setbucket(&fsc, 0, 0.0f, 50.0f);
+	ffsb_statsc_setbucket(&fsc, 1, 50.0f, 10000.0f);
+	ffsb_statsc_setbucket(&fsc, 2, 0.1f, 0.2f);
+	ffsb_statsc_setbucket(&fsc, 3, 0.0f, 50.0f);
+	ffsb_statsc_setbucket(&fsc, 4, 50.0f, 10000.0f);
+	ffsb_statsc_setbucket(&fsc, 5, 0.1f, 0.2f);
+	ffsb_statsc_setbucket(&fsc, 6, 0.0f, 50.0f);
+	ffsb_statsc_setbucket(&fsc, 7, 50.0f, 10000.0f);
+	ffsb_statsc_setbucket(&fsc, 8, 0.1f, 0.2f);
+	ffsb_statsc_setbucket(&fsc, 9, 50.0f, 10000.0f);
+	ffsb_statsd_init(&fsd, &fsc);
+
+	printf("test\n");
+	for (i = 0; i < 50000000; i++)
+		ffsb_add_data(&fsd, SYS_READ, (float)i);
+
+	printf("cleanup\n");
+	ffsb_statsd_destroy(&fsd);
+	ffsb_statsc_destroy(&fsc);
+	return 0;
+}
+
+#endif /* Testing */
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_stats.h b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_stats.h
new file mode 100644
index 0000000..8718eed
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_stats.h
@@ -0,0 +1,109 @@
+/*
+ *   Copyright (c) International Business Machines Corp., 2001-2007
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+#ifndef _FFSB_STATS_H_
+#define _FFSB_STATS_H_
+
+#include <inttypes.h>
+
+/* Latency statistics collection extension.
+ *
+ * For now, we are going to collect latency info on each (most)
+ * syscalls using gettimeofday. Unfortunately, it is the
+ * responsibility of each operation to collect this timing info.  We
+ * try to make this easier by providing a function that does the
+ * timing for supported syscalls.
+ *
+ * We want the ability to collect the average latency for a particular
+ * call, and also to collect latency info for user specified intervals
+ * -- called "buckets"
+ */
+
+struct stat_bucket {
+	uint32_t min;
+	uint32_t max;
+	/* max = 0 indicates uninitialized bucket */
+};
+
+/* These are all the syscalls we currently support */
+typedef enum { SYS_OPEN = 0,
+	       SYS_READ,
+	       SYS_WRITE,
+	       SYS_CREATE,
+	       SYS_LSEEK,
+	       SYS_UNLINK,
+	       SYS_CLOSE,
+	       SYS_STAT
+} syscall_t;
+
+/* ASCII versions of the syscall names */
+extern char *syscall_names[];
+
+/* Return 1 on success, 0 on error */
+int ffsb_stats_str2syscall(char *, syscall_t *);
+
+/* Keep it in sync with syscall_t */
+#define FFSB_NUM_SYSCALLS (8UL)
+
+/* What stats to collect, shared among all threads  */
+typedef struct ffsb_stats_config {
+	unsigned num_buckets;
+	struct stat_bucket *buckets;
+
+	/* Ignore stats collection for some syscalls.
+	 * Each bit corresponds to one syscall.
+	 */
+	uint32_t ignore_stats;
+} ffsb_statsc_t;
+
+void ffsb_statsc_init(ffsb_statsc_t *);
+void ffsb_statsc_addbucket(ffsb_statsc_t *, uint32_t min, uint32_t max);
+void ffsb_statsc_ignore_sys(ffsb_statsc_t *, syscall_t s);
+void ffsb_statsc_destroy(ffsb_statsc_t *);
+
+/* If we are collecting stats, then the config field is non-NULL */
+typedef struct ffsb_stats_data {
+	ffsb_statsc_t *config;
+	uint32_t counts[FFSB_NUM_SYSCALLS];
+	uint64_t totals[FFSB_NUM_SYSCALLS]; /* cumulative sums */
+	uint64_t mins[FFSB_NUM_SYSCALLS];
+	uint64_t maxs[FFSB_NUM_SYSCALLS];
+	uint32_t *buckets[FFSB_NUM_SYSCALLS]; /* bucket counters */
+} ffsb_statsd_t ;
+
+/* constructor/destructor */
+void ffsb_statsd_init(ffsb_statsd_t *, ffsb_statsc_t *);
+void ffsb_statsd_destroy(ffsb_statsd_t *);
+
+/* Add data to a stats data struct.  Value should be in microsecs
+ * _NOT_ milli-secs
+ */
+void ffsb_add_data(ffsb_statsd_t *, syscall_t, uint32_t);
+
+/* Make a copy of a stats config */
+void ffsb_statsc_copy(ffsb_statsc_t *, ffsb_statsc_t *);
+
+/* Add two statsd structs together */
+void ffsb_statsd_add(ffsb_statsd_t *, ffsb_statsd_t *);
+
+/* Print out statsd structure */
+void ffsb_statsd_print(ffsb_statsd_t *fsd);
+
+/* Do we want stats for the specified syscall */
+int fsc_ignore_sys(ffsb_statsc_t *fsc, syscall_t s);
+
+#endif /* _FFSB_STATS_H_ */
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_tg.c b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_tg.c
new file mode 100644
index 0000000..908e89c
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_tg.c
@@ -0,0 +1,369 @@
+/*
+ *   Copyright (c) International Business Machines Corp., 2001-2004
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+#include <string.h>
+#include <stdio.h>
+#include <assert.h>
+#include <pthread.h>
+
+#include "ffsb_tg.h"
+#include "util.h"
+
+void init_ffsb_tg(ffsb_tg_t *tg, unsigned num_threads, unsigned tg_num)
+{
+	int i;
+	memset(tg, 0, sizeof(ffsb_tg_t));
+
+	tg->threads = ffsb_malloc(sizeof(ffsb_thread_t) * num_threads);
+	tg->tg_num = tg_num;
+	tg->num_threads = num_threads;
+
+	tg->bindfs = -1; /* default is not bound */
+
+	tg->thread_bufsize = 0;
+	for (i = 0 ; i < num_threads ; i++)
+		init_ffsb_thread(tg->threads + i, tg, 0, tg_num, i);
+}
+
+void destroy_ffsb_tg(ffsb_tg_t *tg)
+{
+	int i;
+	for (i = 0; i < tg->num_threads; i++)
+		destroy_ffsb_thread(tg->threads + i);
+	free(tg->threads);
+	if (tg_needs_stats(tg))
+		ffsb_statsc_destroy(&tg->fsc);
+}
+
+void *tg_run(void *data)
+{
+	tg_run_params_t *params = (tg_run_params_t *)data;
+	ffsb_tg_t *tg = params->tg;
+	int i;
+	pthread_attr_t attr;
+
+	pthread_attr_init(&attr);
+	pthread_attr_setscope(&attr, PTHREAD_SCOPE_SYSTEM);
+
+	tg->start_barrier = params->thread_barrier;
+
+	/* Sum up the weights for use later by tg_get_op() */
+	tg->sum_weights = 0;
+	for (i = 0; i < FFSB_NUMOPS; i++)
+		tg->sum_weights += tg->op_weights[i];
+
+	tg->fc = params->fc;
+	tg->flagval = -1;
+	tg->stopval = 1;
+
+	/* spawn threads */
+	for (i = 0; i < tg->num_threads; i++) {
+		ffsb_thread_t *ft = &tg->threads[i];
+		pthread_create(&ft->ptid, &attr, ft_run, ft);
+	}
+
+	if (params->tg_barrier)
+		ffsb_barrier_wait(params->tg_barrier);
+
+	/* wait for termination condition to be true */
+	do {
+		ffsb_sleep(params->wait_time);
+	} while (params->poll_fn(params->poll_data) == 0);
+
+	/* set flag value */
+	tg->flagval = tg->stopval;
+
+	/* wait on theads to finish */
+	for (i = 0; i < tg->num_threads; i++)
+		pthread_join(tg->threads[i].ptid, NULL);
+
+	return NULL;
+}
+
+/* Needs to set params->opnum and params->fs */
+void tg_get_op(ffsb_tg_t *tg, randdata_t *rd, tg_op_params_t *params)
+{
+	unsigned curop;
+	int num;
+	int fsnum;
+
+	num = 1 + getrandom(rd, tg->sum_weights);
+	curop = 0;
+
+	while (tg->op_weights[curop] < num) {
+		num -= tg->op_weights[curop];
+		curop++;
+	}
+
+	params->opnum = curop;
+
+	/* If we're bound to a particular filesystem, use that,
+	 * otherwise, pick one at random.
+	 */
+	fsnum = tg->bindfs;
+	if (fsnum < 0)
+		fsnum = getrandom(rd, tg->fc->num_filesys);
+
+	params->fs = fc_get_fs(tg->fc, fsnum);
+}
+
+void tg_set_op_weight(ffsb_tg_t *tg, char *opname, unsigned weight)
+{
+	int opnum = ops_find_op(opname);
+	assert(opnum >= 0);
+	tg->op_weights[opnum] = weight;
+}
+
+unsigned tg_get_op_weight(ffsb_tg_t *tg, char *opname)
+{
+	int opnum = ops_find_op(opname);
+	assert(opnum >= 0);
+	return tg->op_weights[opnum];
+}
+
+void tg_set_bindfs(ffsb_tg_t *tg, int fsnum)
+{
+	tg->bindfs = fsnum;
+}
+
+int tg_get_bindfs(ffsb_tg_t *tg)
+{
+	return tg->bindfs;
+}
+
+unsigned tg_get_numthreads(ffsb_tg_t *tg)
+{
+	return tg->num_threads;
+}
+
+static void update_bufsize(ffsb_tg_t *tg)
+{
+	int i;
+	uint32_t newmax = max(tg->read_blocksize, tg->write_blocksize);
+
+	if (newmax == max(newmax, tg->thread_bufsize))
+		for (i = 0; i < tg->num_threads ; i++)
+			ft_alter_bufsize(tg->threads + i, newmax);
+}
+
+void tg_set_read_random(ffsb_tg_t *tg, int rr)
+{
+	tg->read_random = rr;
+}
+
+void tg_set_write_random(ffsb_tg_t *tg, int wr)
+{
+	tg->write_random = wr;
+}
+
+void tg_set_fsync_file(ffsb_tg_t *tg, int fsync)
+{
+	tg->fsync_file = fsync;
+}
+
+void tg_set_read_size(ffsb_tg_t *tg, uint64_t rs)
+{
+	tg->read_size = rs;
+}
+
+void tg_set_read_blocksize(ffsb_tg_t *tg, uint32_t rs)
+{
+	tg->read_blocksize = rs;
+	update_bufsize(tg);
+}
+
+void tg_set_read_skip(ffsb_tg_t *tg, int rs)
+{
+	tg->read_skip = rs;
+}
+
+void tg_set_read_skipsize(ffsb_tg_t *tg, uint32_t rs)
+{
+	tg->read_skipsize = rs;
+}
+
+void tg_set_write_size(ffsb_tg_t *tg, uint64_t ws)
+{
+	tg->write_size = ws;
+}
+
+void tg_set_write_blocksize(ffsb_tg_t *tg, uint32_t ws)
+{
+	tg->write_blocksize = ws;
+	update_bufsize(tg);
+}
+
+int tg_get_read_random(ffsb_tg_t *tg)
+{
+	return tg->read_random;
+}
+
+int tg_get_write_random(ffsb_tg_t *tg)
+{
+	return tg->write_random;
+}
+
+int tg_get_fsync_file(ffsb_tg_t *tg)
+{
+	return tg->fsync_file;
+}
+
+uint64_t tg_get_read_size(ffsb_tg_t *tg)
+{
+	return tg->read_size;
+}
+
+uint32_t tg_get_read_blocksize(ffsb_tg_t *tg)
+{
+	return tg->read_blocksize;
+}
+
+int tg_get_read_skip(ffsb_tg_t *tg)
+{
+	return tg->read_skip;
+}
+
+uint32_t tg_get_read_skipsize(ffsb_tg_t *tg)
+{
+	return tg->read_skipsize;
+}
+
+uint64_t tg_get_write_size(ffsb_tg_t *tg)
+{
+	return tg->write_size;
+}
+
+uint32_t tg_get_write_blocksize(ffsb_tg_t *tg)
+{
+	return tg->write_blocksize;
+}
+
+int tg_get_stopval(ffsb_tg_t *tg)
+{
+	return tg->stopval;
+}
+
+ffsb_barrier_t *tg_get_start_barrier(ffsb_tg_t *tg)
+{
+	return tg->start_barrier;
+}
+
+static void tg_print_config_helper(ffsb_tg_t *tg)
+{
+	int i;
+	int sumweights = 0;
+	char buf[256];
+
+	printf("\t num_threads      = %d\n", tg->num_threads);
+	printf("\t\n");
+	printf("\t read_random      = %s\n", (tg->read_random) ? "on" : "off");
+	printf("\t read_size        = %llu\t(%s)\n", tg->read_size,
+	       ffsb_printsize(buf, tg->read_size, 256));
+	printf("\t read_blocksize   = %u\t(%s)\n", tg->read_blocksize,
+	       ffsb_printsize(buf, tg->read_blocksize, 256));
+	printf("\t read_skip        = %s\n", (tg->read_skip) ? "on" : "off");
+	printf("\t read_skipsize    = %u\t(%s)\n", tg->read_skipsize,
+	       ffsb_printsize(buf, tg->read_skipsize, 256));
+	printf("\t\n");
+	printf("\t write_random     = %s\n", (tg->write_random) ? "on" : "off");
+	printf("\t write_size       = %llu\t(%s)\n", tg->write_size,
+	       ffsb_printsize(buf, tg->write_size, 256));
+	printf("\t fsync_file       = %d\n", tg->fsync_file);
+	printf("\t write_blocksize  = %u\t(%s)\n", tg->write_blocksize,
+	       ffsb_printsize(buf, tg->write_blocksize, 256));
+	printf("\t wait time        = %u\n", tg->wait_time);
+	if (tg->bindfs >= 0) {
+		printf("\t\n");
+		printf("\t bound to fs %d\n", tg->bindfs);
+	}
+	printf("\t\n");
+	printf("\t op weights\n");
+
+	for (i = 0; i < FFSB_NUMOPS; i++)
+		sumweights += tg->op_weights[i];
+
+	for (i = 0; i < FFSB_NUMOPS; i++)
+		printf("\t %20s = %d (%.2f%%)\n", op_get_name(i),
+		       tg->op_weights[i], 100 * (float)tg->op_weights[i] /
+		       (float)sumweights);
+	printf("\t\n");
+}
+
+void tg_print_config(ffsb_tg_t *tg)
+{
+	printf("ThreadGroup %d\n", tg->tg_num);
+	printf("================\n");
+	tg_print_config_helper(tg);
+}
+
+void tg_print_config_aging(ffsb_tg_t *tg, char *fsname)
+{
+	printf("\t Aging ThreadGroup for fs %s\n", fsname);
+	printf("\t ================\n");
+	tg_print_config_helper(tg);
+}
+
+void tg_collect_results(ffsb_tg_t *tg, ffsb_op_results_t *r)
+{
+	int i;
+	for (i = 0; i < tg_get_numthreads(tg); i++)
+		add_results(r, ft_get_results(tg->threads + i));
+}
+
+void tg_set_waittime(ffsb_tg_t *tg, unsigned time)
+{
+	tg->wait_time = time;
+}
+
+unsigned tg_get_waittime(ffsb_tg_t *tg)
+{
+	return tg->wait_time;
+}
+
+int tg_get_flagval(ffsb_tg_t *tg)
+{
+	return tg->flagval;
+}
+
+void tg_set_statsc(ffsb_tg_t *tg, ffsb_statsc_t *fsc)
+{
+	if (fsc) {
+		int i;
+
+		tg->need_stats = 1;
+		ffsb_statsc_copy(&tg->fsc, fsc);
+
+		for (i = 0; i < tg->num_threads; i++)
+			ft_set_statsc(tg->threads + i, &tg->fsc);
+	}
+}
+
+void tg_collect_stats(ffsb_tg_t *tg, ffsb_statsd_t *fsd)
+{
+	int i;
+
+	assert(tg->need_stats);
+	ffsb_statsd_init(fsd, &tg->fsc);
+
+	for (i = 0; i < tg_get_numthreads(tg); i++)
+		ffsb_statsd_add(fsd, ft_get_stats_data(tg->threads+i));
+}
+
+int tg_needs_stats(ffsb_tg_t *tg)
+{
+	return tg->need_stats;
+}
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_tg.h b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_tg.h
new file mode 100644
index 0000000..2611e0a
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_tg.h
@@ -0,0 +1,206 @@
+/*
+ *   Copyright (c) International Business Machines Corp., 2001-2004
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+#ifndef _FFSB_TG_H_
+#define _FFSB_TG_H_
+#include <inttypes.h>
+#include <stdlib.h>
+#include <sys/types.h>
+
+#include <pthread.h>
+
+#include "ffsb.h"
+#include "ffsb_op.h"
+#include "ffsb_thread.h"
+#include "ffsb_fs.h"
+#include "ffsb_stats.h"
+
+#include "util.h" /* for barrier obj */
+
+/* "Thread Group" object defs.
+ *
+ *  A thread group contains configuration information and can run its
+ *  "gang" of threads performing a particular mix of operations.
+ *
+ * The thread group is responsible for creating the ffsb_thread
+ * objects which must ask the thread group object to select an
+ * operation and a filesystem to run that operation on.  The thread
+ * objects don't contain any of the configuration information.
+ *
+ * Thread groups are also abstracted so they can be "run" arbitrarily
+ * which is useful because we can reuse them for aging.  The running
+ * is a bit complex, the thread group has to have a callback function
+ * which is runs at a specified interval to determine when to
+ * terminate.
+ *
+ * To synchronize starting across many thread groups there are two
+ * barriers used, the first one "tg_barrier" in the run_params is to
+ * synchronize multiple thread-groups being ready to start, meaning
+ * that all their threads have been spawned The second one
+ * "thread_barrier" synchronizes all threads across multiple thread
+ * groups, so that they all start at once.
+*/
+
+struct ffsb_thread;
+struct ffsb_config;
+
+typedef struct ffsb_tg {
+	unsigned tg_num;
+	unsigned num_threads;
+	unsigned op_weights[FFSB_NUMOPS];
+	struct ffsb_thread *threads;
+
+	/* A threadgroup can be bound to just one filesystem.
+	 * A value * < 0 , means we aren't bound to any.
+	*/
+	int bindfs;
+
+	int read_random;	/* boolean */
+	uint64_t read_size;
+	uint32_t read_blocksize;
+
+	int read_skip;		/* boolean */
+	uint32_t read_skipsize;
+
+	int write_random;	/* boolean */
+	uint64_t write_size;
+	uint32_t write_blocksize;
+
+	int fsync_file;		/* boolean */
+
+	/* Should be max(write_blocksize, read_blocksize) */
+	uint32_t thread_bufsize;
+
+	/* these fields are calculated/set by tg_run() */
+	unsigned sum_weights;
+	struct ffsb_config *fc;
+	ffsb_barrier_t *start_barrier;
+
+	/* Used for stopping the threads */
+	int flagval;
+	int stopval;
+
+	/* Delay between every operation, in milliseconds*/
+	unsigned wait_time;
+
+	/* stats configuration */
+	int need_stats;
+	ffsb_statsc_t fsc;
+} ffsb_tg_t;
+
+/* Init should be the very first thing called on the tg.  After that,
+ * the user can call the set methods and finally run.
+ */
+void init_ffsb_tg(ffsb_tg_t *tg, unsigned num_threads, unsigned tg_num);
+void destroy_ffsb_tg(ffsb_tg_t *tg);
+
+/* Parameters needed to fire off a thread group.  The main thread will
+ * evaluate poll_fn(poll_data) until it gets a nonzero return value.
+ * It will sleep for wait_time secs between calls The ffsb_config
+ * struct is needed for fs selection.  Barriers are to synchronize
+ * multiple tgs and all threads pt is for pthread_create()
+ */
+typedef struct tg_run_params {
+	ffsb_tg_t *tg;
+	int (*poll_fn)(void *);
+	void *poll_data;
+	unsigned wait_time; /* in sec */
+	struct ffsb_config *fc;
+	ffsb_barrier_t *tg_barrier;
+
+	/* Should be initialized by caller to tg_run() */
+	ffsb_barrier_t *thread_barrier;
+	pthread_t  pt;
+} tg_run_params_t;
+
+/* This function is meant to be called as a parameter to
+ * pthread_create()
+ */
+void *tg_run(void *);
+
+void tg_print_config(ffsb_tg_t *tg);
+void tg_print_config_aging(ffsb_tg_t *tg, char *fsname);
+
+/* Adds all of this tg's results to res */
+void tg_collect_results(ffsb_tg_t *tg, ffsb_op_results_t *res);
+
+/* Adds up all this tg's stats to totals */
+void tg_collect_stats(ffsb_tg_t *tg, ffsb_statsd_t *totals);
+
+/* getters/setters, setters should not be called after a run has begun */
+
+void tg_set_statsc(ffsb_tg_t *tg, ffsb_statsc_t *fsc);
+
+void tg_set_bindfs(ffsb_tg_t *tg, int fsnum);
+int  tg_get_bindfs(ffsb_tg_t *tg);
+
+unsigned tg_get_numthreads(ffsb_tg_t *tg);
+
+void tg_set_op_weight(ffsb_tg_t *tg, char *opname, unsigned weight);
+unsigned tg_get_op_weight(ffsb_tg_t *tg, char *opname);
+
+void tg_set_read_random(ffsb_tg_t *tg, int rr);
+void tg_set_write_random(ffsb_tg_t *tg, int wr);
+void tg_set_fsync_file(ffsb_tg_t *tg, int fsync);
+
+int tg_get_read_random(ffsb_tg_t *tg);
+int tg_get_write_random(ffsb_tg_t *tg);
+int tg_get_fsync_file(ffsb_tg_t *tg);
+
+void tg_set_read_size(ffsb_tg_t *tg, uint64_t rs);
+void tg_set_read_blocksize(ffsb_tg_t *tg, uint32_t rs);
+
+void tg_set_read_skipsize(ffsb_tg_t *tg, uint32_t rs);
+void tg_set_read_skip(ffsb_tg_t *tg, int rs);
+
+void tg_set_write_size(ffsb_tg_t *tg, uint64_t ws);
+void tg_set_write_blocksize(ffsb_tg_t *tg, uint32_t ws);
+
+uint64_t tg_get_read_size(ffsb_tg_t *tg);
+uint32_t tg_get_read_blocksize(ffsb_tg_t *tg);
+
+int tg_get_read_skip(ffsb_tg_t *tg);
+uint32_t tg_get_read_skipsize(ffsb_tg_t *tg);
+
+uint64_t tg_get_write_size(ffsb_tg_t *tg);
+uint32_t tg_get_write_blocksize(ffsb_tg_t *tg);
+
+void tg_set_waittime(ffsb_tg_t *tg, unsigned time);
+unsigned tg_get_waittime(ffsb_tg_t *tg);
+
+/* The threads in the tg should be the only ones using these (below)
+ * funcs.
+ */
+ffsb_barrier_t *tg_get_start_barrier(ffsb_tg_t *tg);
+int tg_get_stopval(ffsb_tg_t *tg);
+int tg_get_flagval(ffsb_tg_t *tg);
+
+/* The threads in this tg will use this function to get an op to run,
+ * so all configuration specific information is kept in this object.
+ */
+typedef struct tg_op_params {
+	struct ffsb_fs *fs;     /* out parameter */
+	unsigned opnum;         /* out parameter */
+} tg_op_params_t;
+
+/* tg and rd and in parameters, everything in params is out */
+void  tg_get_op(ffsb_tg_t *tg, randdata_t *rd, tg_op_params_t *params);
+
+/* want stats for this tg ? */
+int tg_needs_stats(ffsb_tg_t *tg);
+
+#endif /* _FFSB_TG_H_ */
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_thread.c b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_thread.c
new file mode 100644
index 0000000..e3a2039
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_thread.c
@@ -0,0 +1,171 @@
+/*
+ *   Copyright (c) International Business Machines Corp., 2001-2004
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+#include "ffsb_tg.h"
+#include "ffsb_thread.h"
+#include "ffsb_op.h"
+#include "util.h"
+
+void init_ffsb_thread(ffsb_thread_t *ft, struct ffsb_tg *tg, unsigned bufsize,
+		      unsigned tg_num, unsigned thread_num)
+{
+	memset(ft, 0, sizeof(ffsb_thread_t));
+
+	ft->tg = tg;
+	ft->tg_num = tg_num;
+	ft->thread_num = thread_num;
+
+	if (bufsize)
+		ft_alter_bufsize(ft, bufsize);
+
+	init_random(&ft->rd, MAX_RANDBUF_SIZE);
+}
+
+void destroy_ffsb_thread(ffsb_thread_t *ft)
+{
+	free(ft->mallocbuf);
+	destroy_random(&ft->rd);
+	if (ft->fsd.config)
+		ffsb_statsd_destroy(&ft->fsd);
+}
+
+void ft_set_statsc(ffsb_thread_t *ft, ffsb_statsc_t *fsc)
+{
+	ffsb_statsd_init(&ft->fsd, fsc);
+}
+
+void *ft_run(void *data)
+{
+	ffsb_thread_t *ft = (ffsb_thread_t *)data;
+	tg_op_params_t params;
+	unsigned wait_time = tg_get_waittime(ft->tg);
+	int stopval = tg_get_stopval(ft->tg);
+
+	ffsb_barrier_wait(tg_get_start_barrier(ft->tg));
+
+	while (tg_get_flagval(ft->tg) != stopval) {
+		tg_get_op(ft->tg, &ft->rd, &params);
+		do_op(ft, params.fs, params.opnum);
+		ffsb_milli_sleep(wait_time);
+	}
+	return NULL;
+}
+
+void ft_alter_bufsize(ffsb_thread_t *ft, unsigned bufsize)
+{
+	if (ft->mallocbuf != NULL)
+		free(ft->mallocbuf);
+	ft->mallocbuf = ffsb_malloc(bufsize + 4096);
+	ft->alignedbuf = ffsb_align_4k(ft->mallocbuf + (4096 - 1));
+}
+
+char *ft_getbuf(ffsb_thread_t *ft)
+{
+	return ft->alignedbuf;
+}
+
+
+int ft_get_read_random(ffsb_thread_t *ft)
+{
+	return tg_get_read_random(ft->tg);
+}
+
+uint32_t ft_get_read_size(ffsb_thread_t *ft)
+{
+	return tg_get_read_size(ft->tg);
+}
+
+uint32_t ft_get_read_blocksize(ffsb_thread_t *ft)
+{
+	return tg_get_read_blocksize(ft->tg);
+}
+
+int ft_get_write_random(ffsb_thread_t *ft)
+{
+	return tg_get_write_random(ft->tg);
+}
+
+uint32_t ft_get_write_size(ffsb_thread_t *ft)
+{
+	return tg_get_write_size(ft->tg);
+}
+
+uint32_t ft_get_write_blocksize(ffsb_thread_t *ft)
+{
+	return tg_get_write_blocksize(ft->tg);
+}
+
+int ft_get_fsync_file(ffsb_thread_t *ft)
+{
+	return tg_get_fsync_file(ft->tg);
+}
+
+randdata_t *ft_get_randdata(ffsb_thread_t *ft)
+{
+	return &ft->rd;
+}
+
+void ft_incr_op(ffsb_thread_t *ft, unsigned opnum, unsigned increment, uint64_t bytes)
+{
+	ft->results.ops[opnum] += increment;
+	ft->results.op_weight[opnum]++;
+	ft->results.bytes[opnum] += bytes;
+}
+
+void ft_add_readbytes(ffsb_thread_t *ft, uint32_t bytes)
+{
+	ft->results.read_bytes += bytes;
+}
+
+void ft_add_writebytes(ffsb_thread_t *ft, uint32_t bytes)
+{
+	ft->results.write_bytes += bytes;
+}
+
+ffsb_op_results_t *ft_get_results(ffsb_thread_t *ft)
+{
+	return &ft->results;
+}
+
+int ft_get_read_skip(ffsb_thread_t *ft)
+{
+	return tg_get_read_skip(ft->tg);
+}
+
+uint32_t ft_get_read_skipsize(ffsb_thread_t *ft)
+{
+	return tg_get_read_skipsize(ft->tg);
+}
+
+int ft_needs_stats(ffsb_thread_t *ft, syscall_t sys)
+{
+	int ret = 0;
+	if (ft && ft->fsd.config && !fsc_ignore_sys(ft->fsd.config, sys))
+		ret = 1;
+	return ret;
+}
+
+void ft_add_stat(ffsb_thread_t *ft, syscall_t sys, uint32_t val)
+{
+	if (ft)
+		ffsb_add_data(&ft->fsd, sys, val);
+}
+
+ffsb_statsd_t *ft_get_stats_data(ffsb_thread_t *ft)
+{
+	return &ft->fsd;
+}
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_thread.h b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_thread.h
new file mode 100644
index 0000000..c4315a5
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_thread.h
@@ -0,0 +1,108 @@
+/*
+ *   Copyright (c) International Business Machines Corp., 2001-2004
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+#ifndef _FFSB_THREAD_H_
+#define _FFSB_THREAD_H_
+
+#include <pthread.h>
+#include <inttypes.h>
+
+#include "rand.h"
+#include "ffsb_op.h"
+#include "ffsb_tg.h"
+#include "ffsb_stats.h"
+
+#include "util.h" /* for barrier stuff */
+
+struct ffsb_tg;
+struct ffsb_op_results;
+
+/* FFSB thread object
+ *
+ * The thread object doesn't store any configuration information, it
+ * mostly just holds per-thread state information such as the random
+ * data store and the per-thread buffer to copy data to/from disk
+ */
+
+typedef struct ffsb_thread {
+	unsigned thread_num;
+	unsigned tg_num;
+	pthread_t ptid;
+	struct randdata rd;
+	struct ffsb_tg *tg; /* owning thread group */
+
+	/* If we are using Direct IO, then we must only use a 4k
+	 * aligned buffer so, alignedbuf_4k is a pointer into
+	 * "mallocbuf" which is what malloc gave us.
+	 */
+	char *alignedbuf;
+	char *mallocbuf;
+
+	struct ffsb_op_results results;
+
+	/* stats */
+	ffsb_statsd_t fsd;
+} ffsb_thread_t ;
+
+void init_ffsb_thread(ffsb_thread_t *, struct ffsb_tg *, unsigned,
+		       unsigned, unsigned);
+void destroy_ffsb_thread(ffsb_thread_t *);
+
+/* Owning thread group will start thread with this, thread runs until
+ * *ft->checkval == ft->stopval.  Yes this is not strictly
+ * synchronized, but that is okay for our purposes, and it limits (IMO
+ * expensive) bus-locking.
+ *
+ * pthread_create() is called by tg with this function as a parameter
+ * data is a (ffsb_thread_t*)
+ */
+void *ft_run(void *);
+
+void ft_alter_bufsize(ffsb_thread_t *, unsigned);
+char *ft_getbuf(ffsb_thread_t *);
+
+int ft_get_read_random(ffsb_thread_t *);
+uint32_t ft_get_read_size(ffsb_thread_t *);
+uint32_t ft_get_read_blocksize(ffsb_thread_t *);
+
+int ft_get_write_random(ffsb_thread_t *);
+uint32_t ft_get_write_size(ffsb_thread_t *);
+uint32_t ft_get_write_blocksize(ffsb_thread_t *);
+
+int ft_get_fsync_file(ffsb_thread_t *);
+
+randdata_t *ft_get_randdata(ffsb_thread_t *);
+
+void ft_incr_op(ffsb_thread_t *ft, unsigned opnum, unsigned increment, uint64_t bytes);
+
+void ft_add_readbytes(ffsb_thread_t *, uint32_t);
+void ft_add_writebytes(ffsb_thread_t *, uint32_t);
+
+int ft_get_read_skip(ffsb_thread_t *);
+uint32_t ft_get_read_skipsize(ffsb_thread_t *);
+
+ffsb_op_results_t *ft_get_results(ffsb_thread_t *);
+
+void ft_set_statsc(ffsb_thread_t *, ffsb_statsc_t *);
+
+/* for these two, ft == NULL is OK */
+int ft_needs_stats(ffsb_thread_t *, syscall_t);
+void ft_add_stat(ffsb_thread_t *, syscall_t, uint32_t);
+
+ffsb_statsd_t *ft_get_stats_data(ffsb_thread_t *);
+
+#endif /* _FFSB_THREAD_H_ */
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/fh.c b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/fh.c
new file mode 100644
index 0000000..8a5aa0f
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/fh.c
@@ -0,0 +1,278 @@
+/*
+ *   Copyright (c) International Business Machines Corp., 2001-2004
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#define FILE_OFFSET_BITS 64
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <assert.h>
+#include <inttypes.h>
+#include <assert.h>
+
+#include "ffsb.h"
+#include "fh.h"
+
+#include "config.h"
+
+/* !!! ugly */
+#ifndef HAVE_OPEN64
+#define open64 open
+#endif
+
+#ifndef HAVE_FSEEKO64
+#define lseek64 lseek
+#endif
+
+/* All these functions read the global mainconfig->bufferedio variable
+ * to determine if they are to do buffered i/o or normal.
+ *
+ * ha, well, they're supposed to anyway...!!! TODO -SR 2006/05/14
+ */
+
+static void do_stats(struct timeval *start, struct timeval *end,
+		     ffsb_thread_t *ft, ffsb_fs_t *fs, syscall_t sys)
+{
+	struct timeval diff;
+	uint32_t value = 0;
+
+	if (!ft && !fs)
+		return;
+
+	timersub(end, start, &diff);
+
+	value = 1000000 * diff.tv_sec + diff.tv_usec;
+
+	if (ft && ft_needs_stats(ft, sys))
+		ft_add_stat(ft, sys, value);
+	if (fs && fs_needs_stats(fs, sys))
+		fs_add_stat(fs, sys, value);
+}
+
+static int fhopenhelper(char *filename, char *bufflags, int flags,
+			ffsb_thread_t *ft, ffsb_fs_t *fs)
+{
+	int fd = 0;
+	struct timeval start, end;
+	int need_stats = ft_needs_stats(ft, SYS_OPEN) ||
+		fs_needs_stats(fs, SYS_OPEN);
+
+	flags |= O_LARGEFILE;
+
+	if (need_stats)
+		gettimeofday(&start, NULL);
+
+	fd = open64(filename, flags, S_IRWXU);
+	if (fd < 0) {
+		perror(filename);
+		exit(0);
+	}
+
+	if (need_stats) {
+		gettimeofday(&end, NULL);
+		do_stats(&start, &end, ft, fs, SYS_OPEN);
+	}
+
+	return fd;
+}
+
+int fhopenread(char *filename, ffsb_thread_t *ft, ffsb_fs_t *fs)
+{
+	int flags = O_RDONLY;
+	int directio = fs_get_directio(fs);
+
+	if (directio)
+		flags |= O_DIRECT;
+	return fhopenhelper(filename, "r", flags, ft, fs);
+}
+
+int fhopenappend(char *filename, ffsb_thread_t *ft, ffsb_fs_t *fs)
+{
+	int flags = O_APPEND | O_WRONLY;
+	int directio = fs_get_directio(fs);
+
+	if (directio)
+		flags |= O_DIRECT;
+	return fhopenhelper(filename, "a", flags, ft, fs);
+}
+
+int fhopenwrite(char *filename, ffsb_thread_t *ft, ffsb_fs_t *fs)
+{
+	int flags = O_WRONLY;
+	int directio = fs_get_directio(fs);
+
+	if (directio)
+		flags |= O_DIRECT;
+	return fhopenhelper(filename, "w", flags, ft, fs);
+}
+
+int fhopencreate(char *filename, ffsb_thread_t *ft, ffsb_fs_t *fs)
+{
+	int flags = O_CREAT | O_RDWR | O_TRUNC;
+	int directio = fs_get_directio(fs);
+
+	if (directio)
+		flags |= O_DIRECT;
+	return fhopenhelper(filename, "rw", flags, ft, fs);
+}
+
+void fhread(int fd, void *buf, uint64_t size, ffsb_thread_t *ft, ffsb_fs_t *fs)
+{
+	ssize_t realsize;
+	struct timeval start, end;
+	int need_stats = ft_needs_stats(ft, SYS_READ) ||
+		fs_needs_stats(fs, SYS_READ);
+
+	assert(size <= SIZE_MAX);
+	if (need_stats)
+		gettimeofday(&start, NULL);
+	realsize = read(fd, buf, size);
+
+	if (need_stats) {
+		gettimeofday(&end, NULL);
+		do_stats(&start, &end, ft, fs, SYS_READ);
+	}
+
+	if (realsize != size) {
+		printf("Read %lld instead of %llu bytes.\n",
+		       (unsigned long long)realsize, (unsigned long long)size);
+		perror("read");
+		exit(1);
+	}
+}
+
+void fhwrite(int fd, void *buf, uint32_t size, ffsb_thread_t *ft, ffsb_fs_t *fs)
+{
+	ssize_t realsize;
+	struct timeval start, end;
+	int need_stats = ft_needs_stats(ft, SYS_WRITE) ||
+		fs_needs_stats(fs, SYS_WRITE);
+
+	assert(size <= SIZE_MAX);
+	if (need_stats)
+		gettimeofday(&start, NULL);
+
+	realsize = write(fd, buf, size);
+
+	if (need_stats) {
+		gettimeofday(&end, NULL);
+		do_stats(&start, &end, ft, fs, SYS_WRITE);
+	}
+
+	if (realsize != size) {
+		printf("Wrote %d instead of %d bytes.\n"
+			  "Probably out of disk space\n", realsize, size);
+		perror("write");
+		exit(1);
+	}
+}
+
+void fhseek(int fd, uint64_t offset, int whence, ffsb_thread_t *ft,
+	    ffsb_fs_t *fs)
+{
+	uint64_t res;
+	struct timeval start, end;
+	int need_stats = ft_needs_stats(ft, SYS_LSEEK) ||
+		fs_needs_stats(fs, SYS_LSEEK);
+
+	if ((whence == SEEK_CUR) && (offset == 0))
+		return;
+
+	if (need_stats)
+		gettimeofday(&start, NULL);
+
+	res = lseek64(fd, offset, whence);
+
+	if (need_stats) {
+		gettimeofday(&end, NULL);
+		do_stats(&start, &end, ft, fs, SYS_LSEEK);
+	}
+	if ((whence == SEEK_SET) && (res != offset))
+		perror("seek");
+
+	if (res == -1) {
+		if (whence == SEEK_SET)
+			fprintf(stderr, "tried to seek to %lld\n", offset);
+		else
+			fprintf(stderr, "tried to seek from current "
+				"position to %lld\n", offset);
+
+		perror("seek");
+		exit(1);
+	}
+}
+
+void fhclose(int fd, ffsb_thread_t *ft, ffsb_fs_t *fs)
+{
+	struct timeval start, end;
+	int need_stats = ft_needs_stats(ft, SYS_CLOSE) ||
+		fs_needs_stats(fs, SYS_CLOSE);
+
+	if (need_stats)
+		gettimeofday(&start, NULL);
+
+	close(fd);
+
+	if (need_stats) {
+		gettimeofday(&end, NULL);
+		do_stats(&start, &end, ft, fs, SYS_CLOSE);
+	}
+}
+
+void fhstat(char *name, ffsb_thread_t *ft, ffsb_fs_t *fs)
+{
+	struct timeval start, end;
+	struct stat tmp_stat;
+
+	int need_stats = ft_needs_stats(ft, SYS_STAT) ||
+		fs_needs_stats(fs, SYS_CLOSE);
+
+	if (need_stats)
+		gettimeofday(&start, NULL);
+
+	if (stat(name, &tmp_stat)) {
+		fprintf (stderr, "stat call failed for file %s\n", name);
+		exit(1);
+	}
+
+	if (need_stats) {
+		gettimeofday(&end, NULL);
+		do_stats(&start, &end, ft, fs, SYS_STAT);
+	}
+}
+
+int writefile_helper(int fd, uint64_t size, uint32_t blocksize, char *buf,
+		     struct ffsb_thread *ft, struct ffsb_fs *fs)
+{
+	uint64_t iterations, a;
+	uint64_t last;
+
+	iterations = size / blocksize;
+	last = size % blocksize;
+
+	for (a = 0; a < iterations; a++)
+		fhwrite(fd, buf, blocksize, ft, fs);
+
+	if (last) {
+		a++;
+		fhwrite(fd, buf, last, ft, fs);
+	}
+	return a;
+}
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/fh.h b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/fh.h
new file mode 100644
index 0000000..d047b39
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/fh.h
@@ -0,0 +1,41 @@
+/*
+ *   Copyright (c) International Business Machines Corp., 2001-2004
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+#ifndef _FH_H_
+#define _FH_H_
+
+#include <inttypes.h>
+
+struct ffsb_thread;
+struct ffsb_fs;
+
+int fhopenread(char *, struct ffsb_thread *, struct ffsb_fs *);
+int fhopenwrite(char *, struct ffsb_thread *, struct ffsb_fs *);
+int fhopencreate(char *, struct ffsb_thread *, struct ffsb_fs *);
+int fhopenappend(char *, struct ffsb_thread *, struct ffsb_fs *);
+
+void fhread(int, void *, uint64_t, struct ffsb_thread *, struct ffsb_fs *);
+
+/* can only write up to size_t bytes at a time, so size is a uint32_t */
+void fhwrite(int, void *, uint32_t, struct ffsb_thread *, struct ffsb_fs *);
+void fhseek(int, uint64_t, int, struct ffsb_thread *, struct ffsb_fs *);
+void fhclose(int, struct ffsb_thread *, struct ffsb_fs *);
+
+int writefile_helper(int, uint64_t, uint32_t, char *, struct ffsb_thread *,
+		     struct ffsb_fs *);
+
+#endif /* _FH_H_ */
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/filelist.c b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/filelist.c
new file mode 100644
index 0000000..647674b
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/filelist.c
@@ -0,0 +1,503 @@
+/*
+ *   Copyright (c) International Business Machines Corp., 2001-2004
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+#include <limits.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <dirent.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+
+#include "rand.h"
+#include "filelist.h"
+#include "util.h"
+#include "rwlock.h"
+#include "rbt.h"
+#include "cirlist.h"
+
+#if 0
+static
+void print_cl(struct cirlist *cl)
+{
+	struct cnode *cur = cl->head;
+	printf("curlist: ");
+	if (cur == NULL) {
+		printf("\n");
+		return;
+	}
+	do {
+		printf("%d ", cur->obj->num);
+		cur = cur->next;
+	} while (cur != cl->head);
+	printf("\n");
+}
+#endif
+
+#if 0
+static
+int node_cmp(struct ffsb_file *a, struct ffsb_file *b)
+{
+	return a->num - b->num;
+}
+#endif
+
+static
+void build_dirs(struct benchfiles *bf)
+{
+	char buf[FILENAME_MAX];
+	int i;
+
+	if (mkdir(bf->basedir, S_IRWXU) < 0)
+		if (errno != EEXIST) {
+			perror(bf->basedir);
+			exit(1);
+		}
+	for (i = 0; i < bf->numsubdirs; i++) {
+		snprintf(buf, FILENAME_MAX, "%s/%s%s%d",
+			 bf->basedir, bf->basename,
+			 SUBDIRNAME_BASE, i);
+		if (mkdir(buf, S_IRWXU) == -1)
+			if (errno != EEXIST) {
+				perror(buf);
+				exit(1);
+			}
+	}
+}
+
+
+void init_filelist(struct benchfiles *b, char *basedir, char *basename,
+		   uint32_t numsubdirs, int builddirs)
+{
+	memset(b, 0, sizeof(struct benchfiles));
+	b->basedir = ffsb_strdup(basedir);
+	b->basename = ffsb_strdup(basename);
+	b->numsubdirs = numsubdirs;
+	init_rwlock(&b->fileslock);
+	b->files = rbtree_construct();
+	b->dirs = rbtree_construct();
+	b->holes = ffsb_malloc(sizeof(struct cirlist));
+	b->dholes = ffsb_malloc(sizeof(struct cirlist));
+	init_cirlist(b->holes);
+	init_cirlist(b->dholes);
+
+	if (builddirs)
+		build_dirs(b);
+}
+
+static void file_destructor(struct ffsb_file *file)
+{
+	free(file->name);
+	free(file);
+}
+
+void destroy_filelist(struct benchfiles *bf)
+{
+	free(bf->basedir);
+	free(bf->basename);
+
+	while (!cl_empty(bf->holes)) {
+		struct ffsb_file *cur = cl_remove_head(bf->holes);
+		file_destructor(cur);
+	}
+	free(bf->holes);
+	rbtree_clean(bf->files, file_destructor);
+	free(bf->files);
+}
+
+struct ffsb_file *add_file(struct benchfiles *b, uint64_t size, randdata_t *rd)
+{
+	struct ffsb_file *newfile, *oldfile = NULL;
+	int filenum = 0;
+
+	/* We pre-allocate here, because I don't want to spend time
+	 * malloc'ing while the list is locked we free it later if
+	 * necessary
+	 */
+	newfile = ffsb_malloc(sizeof(struct ffsb_file));
+
+	newfile->size = size;
+	init_rwlock(&(newfile->lock));
+
+	/* Write lock the filelist, begin critical section */
+	rw_lock_write(&b->fileslock);
+
+	/* First check "holes" for a file  */
+	if (!cl_empty(b->holes)) {
+		oldfile = cl_remove_head(b->holes);
+		rbtree_insert(b->files, oldfile);
+		rw_lock_write(&oldfile->lock);
+	} else {
+		filenum = b->listsize;
+		b->listsize++;
+
+		newfile->num = filenum;
+		rbtree_insert(b->files, newfile);
+
+		rw_lock_write(&newfile->lock);
+	}
+
+	/* unlock filelist */
+	rw_unlock_write(&b->fileslock);
+
+	if (oldfile == NULL) {
+		char buf[FILENAME_MAX];
+		int randdir = getrandom(rd, b->numsubdirs+1);
+		int namesize = 0;
+		if (randdir == 0)
+			namesize = snprintf(buf, FILENAME_MAX, "%s/%s%s%d",
+					    b->basedir, b->basename,
+					    FILENAME_BASE, filenum);
+		else
+			namesize = snprintf(buf, FILENAME_MAX,
+					    "%s/%s%s%d/%s%s%d", b->basedir,
+					    b->basename, SUBDIRNAME_BASE,
+					    randdir - 1, b->basename,
+					    FILENAME_BASE, filenum);
+		if (namesize >= FILENAME_MAX)
+			/* !!! do something about this ? */
+			printf("warning: filename \"%s\" too long\n", buf);
+		newfile->name = ffsb_strdup(buf);
+		return newfile;
+	} else {
+		free(newfile);
+		return oldfile;
+	}
+}
+
+struct ffsb_file *add_dir(struct benchfiles *b, uint64_t size, randdata_t *rd)
+{
+	struct ffsb_file *newdir, *olddir = NULL;
+	int dirnum = 0;
+
+	newdir = ffsb_malloc(sizeof(struct ffsb_file));
+
+	init_rwlock(&newdir->lock);
+
+	/* write lock the filelist, beging critical section */
+	rw_lock_write(&b->fileslock);
+
+	/* First check "holes" for a file  */
+	if (!cl_empty(b->dholes)) {
+		olddir = cl_remove_head(b->dholes);
+		rbtree_insert(b->files, olddir);
+		rw_lock_write(&olddir->lock);
+	} else {
+		dirnum = b->numsubdirs;
+		b->numsubdirs++;
+		printf("dirnum: %d\n", dirnum);
+		newdir->num = dirnum;
+		rbtree_insert(b->dirs, newdir);
+
+		rw_lock_write(&newdir->lock);
+	}
+
+	/* unlock filelist */
+	rw_unlock_write(&b->fileslock);
+
+	if (olddir == NULL) {
+		char buf[FILENAME_MAX];
+		int namesize = 0;
+		namesize = snprintf(buf, FILENAME_MAX, "%s/%s%s%d",
+				    b->basedir, b->basename,
+				    SUBDIRNAME_BASE, dirnum);
+		if (namesize >= FILENAME_MAX)
+			printf("warning: filename \"%s\" too long\n", buf);
+			/* TODO: take action here... */
+		newdir->name = ffsb_strdup(buf);
+		return newdir;
+	} else {
+		free(newdir);
+		return olddir;
+	}
+}
+
+/* Private version of above function used only for reusing a
+ * fileset.
+ */
+static struct ffsb_file *add_file_named(struct benchfiles *b, uint64_t size,
+					 char *name)
+{
+	struct ffsb_file *newfile = NULL;
+
+	newfile = ffsb_malloc(sizeof(struct ffsb_file));
+	memset(newfile, 0, sizeof(struct ffsb_file));
+	newfile->name = ffsb_strdup(name);
+	newfile->size = size;
+	init_rwlock(&newfile->lock);
+
+	/* Write lock the filelist, begin critical section */
+	rw_lock_write(&b->fileslock);
+
+	newfile->num = b->listsize;
+	b->listsize++;
+
+	/* Add a new file to the rbtree */
+	rbtree_insert(b->files, newfile);
+
+	rw_lock_write(&newfile->lock);
+
+	/* Unlock filelist */
+	rw_unlock_write(&b->fileslock);
+
+	return newfile;
+}
+
+
+#if 0
+static void print_rb_helper(rb_node *cur)
+{
+	if (cur != NULL) {
+		print_rb_helper(cur->left);
+		printf("%d ", cur->object->num);
+		print_rb_helper(cur->right);
+	}
+}
+
+static void print_rb(rb_tree *tree)
+{
+	print_rb_helper(tree->root);
+}
+#endif
+
+void remove_file(struct benchfiles *b, struct ffsb_file *entry)
+{
+	rw_lock_write(&b->fileslock);
+
+	rbtree_remove(b->files, entry, NULL);
+	/* add node to the cir. list of "holes" */
+	cl_insert_tail(b->holes, entry);
+
+	rw_unlock_write(&b->fileslock);
+}
+
+static struct ffsb_file *choose_file(struct benchfiles *b, randdata_t *rd)
+{
+	rb_node *cur = NULL;
+	int chosen = 0;
+	struct ffsb_file temp;
+	temp.num = chosen;
+
+	if (b->listsize == 0) {
+		fprintf(stderr, "No more files to operate on,"
+			  " try making more initial files "
+			  "or fewer delete operations\n");
+		exit(0);
+	}
+
+	while (cur == NULL) {
+		chosen = getrandom(rd, b->listsize);
+		temp.num = chosen;
+		cur = rbtree_find(b->files, &temp);
+	}
+	return cur->object;
+}
+
+struct ffsb_file *choose_file_reader(struct benchfiles *bf, randdata_t *rd)
+{
+	struct ffsb_file *ret;
+
+	rw_lock_read(&bf->fileslock);
+	/* If b->holes->count == bf->listsize, all files have been
+	 * deleted!
+	 */
+	assert(bf->holes->count != bf->listsize);
+
+	ret = choose_file(bf, rd);
+	if (rw_trylock_read(&ret->lock)) {
+		rw_unlock_read(&bf->fileslock);
+		return choose_file_reader(bf, rd);
+	}
+
+	rw_unlock_read(&bf->fileslock);
+	return ret;
+}
+
+struct ffsb_file *choose_file_writer(struct benchfiles *bf, randdata_t *rd)
+{
+	struct ffsb_file *ret ;
+
+	rw_lock_read(&bf->fileslock);
+	assert(bf->holes->count != bf->listsize);
+	ret = choose_file(bf, rd);
+
+	if (rw_trylock_write(&ret->lock)) {
+		rw_unlock_read(&bf->fileslock);
+		return choose_file_writer(bf, rd);
+	}
+
+	rw_unlock_read(&bf->fileslock);
+	return ret;
+}
+
+void unlock_file_reader(struct ffsb_file *file)
+{
+	rw_unlock_read(&file->lock) ;
+}
+
+void unlock_file_writer(struct ffsb_file *file)
+{
+	rw_unlock_write(&file->lock) ;
+}
+
+void rename_file(struct ffsb_file *file)
+{
+	char *newname = malloc(strlen(file->name) + 2);
+	sprintf(newname, "%sa", file->name);
+	file->name = newname;
+}
+
+int validate_filename(struct benchfiles *bf, char *name)
+{
+	int retval = -1;
+	char fmt_str[FILENAME_MAX];
+	if (FILENAME_MAX <= snprintf(fmt_str, FILENAME_MAX,
+				 "%s%s%%d", bf->basename, FILENAME_BASE)) {
+		printf("filename is too long declaring it invalid\n");
+		return -1;
+	}
+
+	sscanf(name, fmt_str, &retval);
+	return retval;
+}
+
+int validate_dirname(struct benchfiles *bf, char *name)
+{
+	int retval = -1;
+	char fmt_str[FILENAME_MAX];
+	if (FILENAME_MAX <= snprintf(fmt_str, FILENAME_MAX, "%s%s%%d",
+				     bf->basename, SUBDIRNAME_BASE)) {
+		printf("dirname is too long declaring it invalid\n");
+		return -1;
+	}
+
+	sscanf(name, fmt_str, &retval);
+	return retval;
+}
+
+/* Do all the dirty work of recursing through a directory structure
+ * check everything for validitiy and update everything properly.
+ * Note it does not check filesizes !!!, it doesn't know anything
+ * about them
+ */
+static int add_dir_to_filelist(struct benchfiles *bf, DIR *subdir,
+			       char *subdir_path, fl_validation_func_t vfunc,
+			       void *vf_data)
+{
+	int retval = 0;
+	struct dirent *d_ent = NULL;
+
+	while ((d_ent = readdir(subdir)) != NULL) {
+		DIR *tmp = NULL;
+		char filename_buf[FILENAME_MAX*2];
+
+		if (FILENAME_MAX < snprintf(filename_buf, FILENAME_MAX, "%s/%s",
+					    subdir_path, d_ent->d_name)) {
+			printf("filename \"%s\" too long aborting\n",
+			       filename_buf);
+			return -1;
+		}
+		tmp = opendir(filename_buf);
+		if (tmp == NULL) {
+			struct ffsb_file *ffsb_file = NULL;
+
+			if (validate_filename(bf, d_ent->d_name) < 0) {
+				printf("filename \"%s\" is invalid aborting\n",
+				       d_ent->d_name);
+				return -1;
+			}
+			/* Verify size/other attributes via callback  */
+			if (vfunc(bf, filename_buf, vf_data)) {
+				printf("filename \"%s\" didn't pass "
+				       "validation\n", d_ent->d_name);
+				return -1;
+			}
+			/* Add file to data structure */
+			ffsb_file = add_file_named(bf, ffsb_get_filesize(filename_buf),
+				       filename_buf);
+			unlock_file_writer(ffsb_file);
+		} else {
+			/* Check for the usual suspects and skip them */
+			if ((0 == strcmp(".", d_ent->d_name)) ||
+			    (0 == strcmp("..", d_ent->d_name))) {
+				closedir(tmp);
+				continue;
+			}
+			if (validate_dirname(bf, d_ent->d_name) < 0) {
+				printf("dirname \"%s\" is invalid aborting\n",
+				       d_ent->d_name);
+				closedir(tmp);
+				return -1;
+			}
+			if (vfunc(bf, filename_buf, vf_data)) {
+				printf("dir \"%s\" didn't pass validation\n",
+				       d_ent->d_name);
+				closedir(tmp);
+				return -1;
+			}
+			/* Update filelist */
+			bf->numsubdirs++;
+
+			/* recurse */
+			retval += add_dir_to_filelist(bf, tmp, filename_buf,
+						      vfunc, vf_data);
+
+			/* clean up */
+			closedir(tmp);
+		}
+	}
+	return retval;
+}
+
+
+int grab_old_fileset(struct benchfiles *bf, char *basename,
+		      fl_validation_func_t vfunc, void *vfunc_data)
+{
+	int retval = 0;
+	char buf[FILENAME_MAX*2];
+	DIR *lc_dir = NULL;
+
+	if (FILENAME_MAX < snprintf(buf, FILENAME_MAX, "%s",
+				    bf->basedir)) {
+		printf("filename \"%s\" is too long aborting\n", buf);
+		return -1;
+	}
+
+	lc_dir = opendir(buf);
+	if (lc_dir == NULL) {
+		perror("opendir");
+		return -1;
+	}
+
+	retval = add_dir_to_filelist(bf, lc_dir, buf, vfunc, vfunc_data);
+
+	closedir(lc_dir);
+	return retval ;
+}
+
+/* Get the number of files */
+uint32_t get_listsize(struct benchfiles *bf)
+{
+	return bf->listsize;
+}
+
+/* Get the number of subdirectories */
+uint32_t get_numsubdirs(struct benchfiles *bf)
+{
+	return bf->numsubdirs;
+}
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/filelist.h b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/filelist.h
new file mode 100644
index 0000000..f94120c
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/filelist.h
@@ -0,0 +1,145 @@
+/*
+ *   Copyright (c) International Business Machines Corp., 2001-2004
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+#ifndef _FILELIST_H_
+#define _FILELIST_H_
+
+#include <pthread.h>
+#include "rand.h"
+#include "rwlock.h"
+#include "cirlist.h"
+#include "rbt.h"
+
+#define SUBDIRNAME_BASE "dir"
+#define FILENAME_BASE "file"
+
+struct ffsb_file {
+	char *name;
+	uint64_t size;
+	struct rwlock lock;
+	uint32_t num;
+};
+
+struct cirlist;
+
+/* Tree of ffsb_file structs and associated state info struct must be
+ * locked during use.
+ */
+struct benchfiles {
+	/* The base directory in which all subdirs and files are
+	 * created
+	 */
+	char *basedir;
+
+	/* The name to prepend to all directory and file names */
+	char *basename;
+	uint32_t numsubdirs;
+
+	/* Files which currently exist on the filesystem */
+	struct red_black_tree *files;
+
+	/* Directories which currently exist on the filesystem */
+	struct red_black_tree *dirs;
+
+	/* Files which have been deleted, and whose numbers should be
+	 * reused
+	 */
+	struct cirlist *holes;
+	struct cirlist *dholes;
+
+	/* This lock must be held while manipulating the structure */
+	struct rwlock fileslock;
+	uint32_t listsize; /* Sum size of nodes in files and holes */
+};
+
+/* Initializes the list, user must call this before anything else it
+ * will create the basedir and subdirs on the filesystem automatically
+ * if the builddirs arg. is nonzero
+ */
+void init_filelist(struct benchfiles *, char *, char *, uint32_t, int);
+void destroy_filelist(struct benchfiles *);
+
+/* Allocates a new file, adds to list, (write) locks it, and returns
+ * it.  This function also randomly selects a filename + path to
+ * assign to the new file.
+ *
+ * It first checks the "holes" list for any available filenames.
+ * Caller must ensure file is actually created on disk
+ */
+struct ffsb_file *add_file(struct benchfiles *b, uint64_t size, randdata_t *rd);
+struct ffsb_file *add_dir(struct benchfiles *, uint64_t, randdata_t *);
+
+/* Removes file from list, decrements listsize.
+ *
+ * File should be writer-locked before calling this function.
+ *
+ * This function does not unlock file after removal from list.
+ *
+ * Caller must ensure file is actually removed on disk.
+ *
+ * Caller must NOT free file->name and file, since oldfiles are being
+ * put into holes list.
+ */
+void remove_file(struct benchfiles *, struct ffsb_file *);
+
+/* Picks a file at random, locks it for reading and returns it
+ * locked
+ */
+struct ffsb_file *choose_file_reader(struct benchfiles *, randdata_t *);
+
+/* Picks a file at random, locks it for writing and returns it
+ * locked
+ */
+struct ffsb_file *choose_file_writer(struct benchfiles *, randdata_t *);
+
+/* changes the file->name of a file, file must be write locked
+ * it does not free the old file->name, so caller must keep a ref to it
+ * and free after the call
+ */
+void rename_file(struct ffsb_file *);
+
+void unlock_file_reader(struct ffsb_file *);
+void unlock_file_writer(struct ffsb_file *);
+
+/* Uses SUBDIRNAME_BASE/FILENAME_BASE + bf->basename to validate a
+ * name returns a negative on invalid names, and the actual file
+ * number if valid
+ */
+int validate_filename(struct benchfiles *, char *);
+int validate_dirname(struct benchfiles *, char *);
+
+/* Function type which, does some validation of existing files
+ * currently only used by ffsb_fs stuff, returns 0 on success
+ */
+typedef int (*fl_validation_func_t)(struct benchfiles *, char *, void *);
+
+/* Provided for re-use of filesets.  Also runs the validation callback
+ * on each file/dir that is found, after verifying the name is
+ * conformant.  The fileset should be initialized with init_fileset()
+ * beforehand.
+ * Returns 0 on success
+ */
+int grab_old_fileset(struct benchfiles *, char *, fl_validation_func_t,
+		      void *);
+
+/* Get the number of files */
+uint32_t get_listsize(struct benchfiles *);
+
+/* Get the number of subdirectories */
+uint32_t get_numsubdirs(struct benchfiles *);
+
+#endif /* _FILELIST_H_ */
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/fileops.c b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/fileops.c
new file mode 100644
index 0000000..e8aa2fc
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/fileops.c
@@ -0,0 +1,547 @@
+/*
+ *   Copyright (c) International Business Machines Corp., 2001-2004
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+#define _LARGEFILE64_SOURCE
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <pthread.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <assert.h>
+#include <errno.h>
+
+
+#include "fh.h"
+#include "util.h"
+#include "ffsb.h"
+#include "fileops.h"
+#include "ffsb_op.h"
+
+static void do_stats(struct timeval *start, struct timeval *end,
+		     ffsb_thread_t *ft, ffsb_fs_t *fs, syscall_t sys)
+{
+	struct timeval diff;
+	uint32_t value = 0;
+
+	if (!ft && !fs)
+		return;
+
+	timersub(end, start, &diff);
+
+	value = 1000000 * diff.tv_sec + diff.tv_usec;
+
+	if (ft && ft_needs_stats(ft, sys))
+		ft_add_stat(ft, sys, value);
+	if (fs && fs_needs_stats(fs, sys))
+		fs_add_stat(fs, sys, value);
+}
+
+void fop_bench(ffsb_fs_t *fs, unsigned opnum)
+{
+	fs_set_opdata(fs, fs_get_datafiles(fs), opnum);
+}
+
+void fop_age(ffsb_fs_t *fs, unsigned opnum)
+{
+	fs_set_opdata(fs, fs_get_agefiles(fs), opnum);
+}
+
+static unsigned readfile_helper(int fd, uint64_t size, uint32_t blocksize,
+				char *buf, ffsb_thread_t *ft, ffsb_fs_t *fs)
+{
+	int iterations, a;
+	int last;
+
+	iterations = size / blocksize;
+	last = size % blocksize;
+
+	for (a = 0; a < iterations; a++)
+		fhread(fd, buf, blocksize, ft, fs);
+	if (last)
+		fhread(fd, buf, last, ft, fs);
+	return iterations;
+}
+
+static uint64_t get_random_offset(randdata_t *rd, uint64_t filesize,
+				  int aligned)
+{
+	if (!aligned)
+		return getllrandom(rd, filesize);
+
+	filesize /= 4096;
+	return getllrandom(rd, filesize) * 4096;
+}
+
+void ffsb_readfile(ffsb_thread_t *ft, ffsb_fs_t *fs, unsigned opnum)
+{
+	struct benchfiles *bf = (struct benchfiles *)fs_get_opdata(fs, opnum);
+	struct ffsb_file *curfile = NULL;
+
+	int fd;
+	uint64_t filesize;
+
+	char *buf = ft_getbuf(ft);
+	int read_random = ft_get_read_random(ft);
+	uint64_t read_size = ft_get_read_size(ft);
+	uint32_t read_blocksize = ft_get_read_blocksize(ft);
+	uint32_t read_skipsize = ft_get_read_skipsize(ft);
+	int skip_reads = ft_get_read_skip(ft);
+	struct randdata *rd = ft_get_randdata(ft);
+
+	uint64_t iterations = 0;
+
+	curfile = choose_file_reader(bf, rd);
+	fd = fhopenread(curfile->name, ft, fs);
+
+	filesize = ffsb_get_filesize(curfile->name);
+
+	assert(filesize >= read_size);
+
+	/* Sequential read, starting at a random point */
+	if (!read_random) {
+		uint64_t range = filesize - read_size;
+		uint64_t offset = 0;
+		/* Skip or "stride" reads option */
+		if (skip_reads) {
+			unsigned i, last;
+			uint64_t minfilesize;
+			iterations = read_size / read_blocksize;
+			last = read_size % read_blocksize;
+
+			/* Double check that the user hasn't specified
+			 * a read_size that is too large when combined
+			 * with the seeks
+			 */
+			if (last)
+				minfilesize = last + iterations *
+					(read_blocksize + read_skipsize);
+			else
+				minfilesize = read_blocksize + iterations - 1 *
+					(read_blocksize + read_skipsize);
+
+			if (minfilesize > filesize) {
+				  printf("Error: read size %llu bytes too big "
+					 "w/ skipsize %u and blocksize %u,"
+					 " for file of size %llu bytes\n"
+					 " aborting\n\n", read_size,
+					 read_skipsize, read_blocksize,
+					 filesize);
+				  printf("minimum file size must be at least "
+					 " %llu bytes\n", minfilesize);
+					 exit(1);
+			}
+
+			for (i = 0; i < iterations; i++) {
+				fhread(fd, buf, read_blocksize, ft, fs);
+				fhseek(fd, (uint64_t)read_skipsize, SEEK_CUR,
+				       ft, fs);
+			}
+			if (last) {
+				fhread(fd, buf, (uint64_t)last, ft, fs);
+				iterations++;
+			}
+		} else {
+			/* Regular sequential reads */
+			if (range) {
+				offset = get_random_offset(rd, range,
+							   fs_get_alignio(fs));
+				fhseek(fd, offset, SEEK_SET, ft, fs);
+			}
+			iterations = readfile_helper(fd, read_size,
+						     read_blocksize, buf,
+						     ft, fs);
+		}
+	} else {
+		/* Randomized read */
+		uint64_t range = filesize - read_blocksize;
+		int i;
+
+		iterations = read_size / read_blocksize;
+
+		for (i = 0; i < iterations; i++) {
+			uint64_t offset = get_random_offset(rd, range,
+							    fs_get_alignio(fs));
+			fhseek(fd, offset, SEEK_SET, ft, fs);
+			fhread(fd, buf, read_blocksize, ft, fs);
+		}
+	}
+
+	unlock_file_reader(curfile);
+	fhclose(fd, ft, fs);
+
+	ft_incr_op(ft, opnum, iterations, read_size);
+	ft_add_readbytes(ft, read_size);
+}
+
+/* Just like ffsb_readfile but we read the whole file from start to
+ * finish regardless of file size.
+ */
+void ffsb_readall(ffsb_thread_t *ft, ffsb_fs_t *fs, unsigned opnum)
+{
+	struct benchfiles *bf = (struct benchfiles *)fs_get_opdata(fs, opnum);
+	struct ffsb_file *curfile = NULL;
+	int fd;
+	uint64_t filesize;
+
+	char *buf = ft_getbuf(ft);
+	uint32_t read_blocksize = ft_get_read_blocksize(ft);
+	struct randdata *rd = ft_get_randdata(ft);
+
+	unsigned iterations = 0;
+
+	curfile = choose_file_reader(bf, rd);
+	fd = fhopenread(curfile->name, ft, fs);
+
+	filesize = ffsb_get_filesize(curfile->name);
+	iterations = readfile_helper(fd, filesize, read_blocksize, buf, ft, fs);
+
+	unlock_file_reader(curfile);
+	fhclose(fd, ft, fs);
+
+	ft_incr_op(ft, opnum, iterations, filesize);
+	ft_add_readbytes(ft, filesize);
+}
+
+/* Shared core between ffsb_writefile and ffsb_writefile_fsync.*/
+
+static unsigned ffsb_writefile_core(ffsb_thread_t *ft, ffsb_fs_t *fs,
+				    unsigned opnum, uint64_t *filesize_ret,
+				    int fsync_file)
+{
+	struct benchfiles *bf = (struct benchfiles *)fs_get_opdata(fs, opnum);
+	struct ffsb_file *curfile = NULL;
+
+	int fd;
+	uint64_t filesize;
+
+	char *buf = ft_getbuf(ft);
+	int write_random = ft_get_write_random(ft);
+	uint32_t write_size = ft_get_write_size(ft);
+	uint32_t write_blocksize = ft_get_write_blocksize(ft);
+	struct randdata *rd = ft_get_randdata(ft);
+	unsigned iterations = 0;
+
+	curfile = choose_file_reader(bf, rd);
+	fd = fhopenwrite(curfile->name, ft, fs);
+
+	filesize = ffsb_get_filesize(curfile->name);
+
+	assert(filesize >= write_size);
+
+	/* Sequential write, starting at a random point  */
+	if (!write_random) {
+		uint64_t range = filesize - write_size;
+		uint64_t offset = 0;
+		if (range) {
+			offset = get_random_offset(rd, range,
+						   fs_get_alignio(fs));
+			fhseek(fd, offset, SEEK_SET, ft, fs);
+		}
+		iterations = writefile_helper(fd, write_size, write_blocksize,
+					      buf, ft, fs);
+	} else {
+		/* Randomized write */
+		uint64_t range = filesize - write_blocksize;
+		int i;
+		iterations = write_size / write_blocksize;
+
+		for (i = 0; i < iterations; i++) {
+			uint64_t offset = get_random_offset(rd, range,
+							    fs_get_alignio(fs));
+			fhseek(fd, offset, SEEK_SET, ft, fs);
+			fhwrite(fd, buf, write_blocksize, ft, fs);
+		}
+	}
+
+	if (fsync_file) {
+		if (fsync(fd)) {
+			perror("fsync");
+			printf("aborting\n");
+			exit(1);
+		}
+	}
+	unlock_file_reader(curfile);
+	fhclose(fd, ft, fs);
+	*filesize_ret = filesize;
+	return iterations;
+}
+
+void ffsb_writefile(ffsb_thread_t *ft, ffsb_fs_t *fs, unsigned opnum)
+{
+	unsigned iterations;
+	uint64_t filesize;
+
+	iterations = ffsb_writefile_core(ft, fs, opnum, &filesize, 0);
+	ft_incr_op(ft, opnum, iterations, filesize);
+	ft_add_writebytes(ft, filesize);
+}
+
+void ffsb_writefile_fsync(ffsb_thread_t *ft, ffsb_fs_t *fs, unsigned opnum)
+{
+	unsigned iterations;
+	uint64_t filesize;
+
+	iterations = ffsb_writefile_core(ft, fs, opnum, &filesize, 1);
+	ft_incr_op(ft, opnum, iterations, filesize);
+	ft_add_writebytes(ft, filesize);
+}
+
+
+/* Shared core between ffsb_writeall and ffsb_writeall_fsync.*/
+
+static unsigned ffsb_writeall_core(ffsb_thread_t *ft, ffsb_fs_t *fs,
+				   unsigned opnum, uint64_t *filesize_ret,
+				   int fsync_file)
+{
+	struct benchfiles *bf = (struct benchfiles *)fs_get_opdata(fs, opnum);
+	struct ffsb_file *curfile = NULL;
+	int fd;
+	uint64_t filesize;
+
+	char *buf = ft_getbuf(ft);
+	uint32_t write_blocksize = ft_get_write_blocksize(ft);
+	struct randdata *rd = ft_get_randdata(ft);
+
+	unsigned iterations = 0;
+
+	curfile = choose_file_reader(bf, rd);
+	fd = fhopenwrite(curfile->name, ft, fs);
+
+	filesize = ffsb_get_filesize(curfile->name);
+	iterations = writefile_helper(fd, filesize, write_blocksize, buf,
+				      ft, fs);
+	if (fsync_file)
+		if (fsync(fd)) {
+			perror("fsync");
+			printf("aborting\n");
+			exit(1);
+		}
+
+	unlock_file_reader(curfile);
+	fhclose(fd, ft, fs);
+	*filesize_ret = filesize;
+	return iterations;
+}
+
+/* Just like ffsb_writefile but we write the whole file from start to
+ * finish regardless of file size
+ */
+void ffsb_writeall(ffsb_thread_t *ft, ffsb_fs_t *fs, unsigned opnum)
+{
+	unsigned iterations;
+	uint64_t filesize;
+
+	iterations = ffsb_writeall_core(ft, fs, opnum, &filesize, 0);
+	ft_incr_op(ft, opnum, iterations, filesize);
+	ft_add_writebytes(ft, filesize);
+}
+
+void ffsb_writeall_fsync(ffsb_thread_t *ft, ffsb_fs_t *fs, unsigned opnum)
+{
+	unsigned iterations;
+	uint64_t filesize;
+
+	iterations = ffsb_writeall_core(ft, fs, opnum, &filesize, 1);
+	ft_incr_op(ft, opnum, iterations, filesize);
+	ft_add_writebytes(ft, filesize);
+}
+
+
+static unsigned ffsb_appendfile_core(ffsb_thread_t *ft, ffsb_fs_t *fs,
+				unsigned opnum, uint64_t *filesize_ret,
+				int fsync_file)
+{
+	struct benchfiles *bf = (struct benchfiles *)fs_get_opdata(fs, opnum);
+	struct ffsb_file *curfile;
+
+	int fd;
+
+	char *buf = ft_getbuf(ft);
+	uint32_t write_size = ft_get_write_size(ft);
+	uint32_t write_blocksize = ft_get_write_blocksize(ft);
+	struct randdata *rd = ft_get_randdata(ft);
+	unsigned iterations = 0;
+
+	curfile = choose_file_reader(bf, rd);
+	fd = fhopenappend(curfile->name, ft, fs);
+
+	unlock_file_reader(curfile);
+
+	curfile->size += (uint64_t)write_size;
+
+	iterations = writefile_helper(fd, write_size, write_blocksize, buf,
+				      ft, fs);
+	if (fsync_file)
+ 		if (fsync(fd)) {
+ 			perror("fsync");
+ 			printf("aborting\n");
+ 			exit(1);
+ 		}
+
+	fhclose(fd, ft, fs);
+ 	*filesize_ret = write_size;
+	return iterations;
+}
+
+void ffsb_appendfile(ffsb_thread_t *ft, ffsb_fs_t *fs, unsigned opnum)
+{
+	unsigned iterations;
+	uint64_t filesize;
+
+	iterations = ffsb_appendfile_core(ft, fs, opnum, &filesize, 0);
+	ft_incr_op(ft, opnum, iterations, filesize);
+	ft_add_writebytes(ft, filesize);
+}
+
+void ffsb_appendfile_fsync(ffsb_thread_t *ft, ffsb_fs_t *fs, unsigned opnum)
+{
+	unsigned iterations;
+	uint64_t filesize;
+
+	iterations = ffsb_appendfile_core(ft, fs, opnum, &filesize, 1);
+	ft_incr_op(ft, opnum, iterations, filesize);
+	ft_add_writebytes(ft, filesize);
+}
+
+static unsigned ffsb_createfile_core(ffsb_thread_t *ft, ffsb_fs_t *fs,
+				     unsigned opnum, uint64_t *filesize_ret,
+				     int fsync_file)
+{
+	struct benchfiles *bf = (struct benchfiles *)fs_get_opdata(fs, opnum);
+	struct ffsb_file *newfile = NULL;
+
+	int fd;
+	uint64_t size;
+
+	char *buf = ft_getbuf(ft);
+	uint32_t write_blocksize = ft_get_write_blocksize(ft);
+	struct randdata *rd = ft_get_randdata(ft);
+	unsigned iterations = 0;
+
+	if (fs->num_weights) {
+		int num = 1 + getrandom(rd, fs->sum_weights);
+		int curop = 0;
+
+		while (fs->size_weights[curop].weight < num) {
+			num -= fs->size_weights[curop].weight;
+			curop++;
+		}
+		size = fs->size_weights[curop].size;
+	}
+	else {
+		uint64_t range = fs_get_max_filesize(fs) - fs_get_min_filesize(fs);
+		size = fs_get_min_filesize(fs);
+		if (range != 0)
+			size += getllrandom(rd, range);
+	}
+
+	newfile = add_file(bf, size, rd);
+	fd = fhopencreate(newfile->name, ft, fs);
+	iterations = writefile_helper(fd, size, write_blocksize, buf, ft, fs);
+
+	if (fsync_file)
+ 		if (fsync(fd)) {
+ 			perror("fsync");
+ 			printf("aborting\n");
+ 			exit(1);
+ 		}
+
+	fhclose(fd, ft, fs);
+	unlock_file_writer(newfile);
+ 	*filesize_ret = size;
+	return iterations;
+}
+
+void ffsb_createfile(ffsb_thread_t *ft, ffsb_fs_t *fs, unsigned opnum)
+{
+	unsigned iterations;
+	uint64_t filesize;
+
+	iterations = ffsb_createfile_core(ft, fs, opnum, &filesize, 0);
+	ft_incr_op(ft, opnum, iterations, filesize);
+	ft_add_writebytes(ft, filesize);
+}
+
+void ffsb_createfile_fsync(ffsb_thread_t *ft, ffsb_fs_t *fs, unsigned opnum)
+{
+	unsigned iterations;
+	uint64_t filesize;
+
+	iterations = ffsb_createfile_core(ft, fs, opnum, &filesize, 1);
+	ft_incr_op(ft, opnum, iterations, filesize);
+	ft_add_writebytes(ft, filesize);
+}
+
+void ffsb_deletefile(ffsb_thread_t *ft, ffsb_fs_t *fs, unsigned opnum)
+{
+	struct benchfiles *bf = (struct benchfiles *)fs_get_opdata(fs, opnum);
+	struct ffsb_file *curfile = NULL;
+	randdata_t *rd = ft_get_randdata(ft);
+	struct timeval start, end;
+	int need_stats = ft_needs_stats(ft, SYS_UNLINK) ||
+		fs_needs_stats(fs, SYS_UNLINK);
+
+	curfile = choose_file_writer(bf, rd);
+	remove_file(bf, curfile);
+
+	if (need_stats)
+		gettimeofday(&start, NULL);
+
+	if (unlink(curfile->name) == -1) {
+		printf("error deleting %s in deletefile\n", curfile->name);
+		perror("deletefile");
+		exit(0);
+	}
+
+	if (need_stats) {
+		gettimeofday(&end, NULL);
+		do_stats(&start, &end, ft, fs, SYS_UNLINK);
+	}
+
+	rw_unlock_write(&curfile->lock);
+
+	ft_incr_op(ft, opnum, 1, 0);
+}
+
+void ffsb_open_close(ffsb_thread_t *ft, ffsb_fs_t *fs, unsigned opnum)
+{
+	struct benchfiles *bf = (struct benchfiles *)fs_get_opdata(fs, opnum);
+	struct ffsb_file *curfile = NULL;
+	randdata_t *rd = ft_get_randdata(ft);
+	int fd;
+
+	curfile = choose_file_reader(bf, rd);
+	fd = fhopenread(curfile->name, ft, fs);
+	fhclose(fd, ft, fs);
+	unlock_file_reader(curfile);
+	ft_incr_op(ft, opnum, 1, 0);
+}
+
+void ffsb_stat(ffsb_thread_t *ft, ffsb_fs_t *fs, unsigned opnum)
+{
+	struct benchfiles *bf = (struct benchfiles *)fs_get_opdata(fs, opnum);
+	struct ffsb_file *curfile = NULL;
+	randdata_t *rd = ft_get_randdata(ft);
+
+	curfile = choose_file_reader(bf, rd);
+	fhstat(curfile->name, ft, fs);
+	unlock_file_reader(curfile);
+
+	ft_incr_op(ft, opnum, 1, 0);
+}
+
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/fileops.h b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/fileops.h
new file mode 100644
index 0000000..9d35e94
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/fileops.h
@@ -0,0 +1,51 @@
+/*
+ *   Copyright (c) International Business Machines Corp., 2001-2004
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+#ifndef _FILEOPS_H_
+#define _FILEOPS_H_
+
+#include "ffsb_thread.h"
+#include "ffsb.h"
+#include "ffsb_op.h"
+#include "ffsb_fs.h"
+
+void ffsb_readfile(ffsb_thread_t *tconfig, ffsb_fs_t *, unsigned opnum);
+void ffsb_readall(ffsb_thread_t *tconfig, ffsb_fs_t *, unsigned opnum);
+void ffsb_writefile(ffsb_thread_t *tconfig, ffsb_fs_t *, unsigned opnum);
+void ffsb_writefile_fsync(ffsb_thread_t *tconfig, ffsb_fs_t *, unsigned opnum);
+void ffsb_writeall(ffsb_thread_t *tconfig, ffsb_fs_t *, unsigned opnum);
+void ffsb_writeall_fsync(ffsb_thread_t *tconfig, ffsb_fs_t *, unsigned opnum);
+void ffsb_createfile(ffsb_thread_t *tconfig, ffsb_fs_t *, unsigned opnum);
+void ffsb_createfile_fsync(ffsb_thread_t *tconfig, ffsb_fs_t *, unsigned opnum);
+void ffsb_deletefile(ffsb_thread_t *tconfig, ffsb_fs_t *, unsigned opnum);
+void ffsb_appendfile(ffsb_thread_t *tconfig, ffsb_fs_t *, unsigned opnum);
+void ffsb_appendfile_fsync(ffsb_thread_t *tconfig, ffsb_fs_t *, unsigned opnum);
+void ffsb_stat(ffsb_thread_t *ft, ffsb_fs_t *fs, unsigned opnum);
+void ffsb_open_close(ffsb_thread_t *ft, ffsb_fs_t *fs, unsigned opnum);
+
+struct ffsb_op_results;
+
+void ffsb_read_print_exl(struct ffsb_op_results *, double secs, unsigned op_num);
+void ffsb_write_print_exl(struct ffsb_op_results *, double secs, unsigned op_num);
+void ffsb_create_print_exl(struct ffsb_op_results *, double secs, unsigned op_num);
+void ffsb_append_print_exl(struct ffsb_op_results *, double secs, unsigned op_num);
+
+/* Set up ops for either aging or benchmarking */
+void fop_bench(ffsb_fs_t *fs, unsigned opnum);
+void fop_age(ffsb_fs_t *fs, unsigned opnum);
+
+#endif /* _FILEOPS_H_ */
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/install-sh b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/install-sh
new file mode 100644
index 0000000..4b1cd95
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/install-sh
@@ -0,0 +1,250 @@
+#!/bin/sh
+#
+# install - install a program, script, or datafile
+# This comes from X11R5 (mit/util/scripts/install.sh).
+#
+# Copyright 1991 by the Massachusetts Institute of Technology
+#
+# Permission to use, copy, modify, distribute, and sell this software and its
+# documentation for any purpose is hereby granted without fee, provided that
+# the above copyright notice appear in all copies and that both that
+# copyright notice and this permission notice appear in supporting
+# documentation, and that the name of M.I.T. not be used in advertising or
+# publicity pertaining to distribution of the software without specific,
+# written prior permission.  M.I.T. makes no representations about the
+# suitability of this software for any purpose.  It is provided "as is"
+# without express or implied warranty.
+#
+# Calling this script install-sh is preferred over install.sh, to prevent
+# `make' implicit rules from creating a file called install from it
+# when there is no Makefile.
+#
+# This script is compatible with the BSD install script, but was written
+# from scratch.  It can only install one file at a time, a restriction
+# shared with many OS's install programs.
+
+
+# set DOITPROG to echo to test this script
+
+# Don't use :- since 4.3BSD and earlier shells don't like it.
+doit="${DOITPROG-}"
+
+
+# put in absolute paths if you don't have them in your path; or use env. vars.
+
+mvprog="${MVPROG-mv}"
+cpprog="${CPPROG-cp}"
+chmodprog="${CHMODPROG-chmod}"
+chownprog="${CHOWNPROG-chown}"
+chgrpprog="${CHGRPPROG-chgrp}"
+stripprog="${STRIPPROG-strip}"
+rmprog="${RMPROG-rm}"
+mkdirprog="${MKDIRPROG-mkdir}"
+
+transformbasename=""
+transform_arg=""
+instcmd="$mvprog"
+chmodcmd="$chmodprog 0755"
+chowncmd=""
+chgrpcmd=""
+stripcmd=""
+rmcmd="$rmprog -f"
+mvcmd="$mvprog"
+src=""
+dst=""
+dir_arg=""
+
+while [ x"$1" != x ]; do
+    case $1 in
+	-c) instcmd="$cpprog"
+	    shift
+	    continue;;
+
+	-d) dir_arg=true
+	    shift
+	    continue;;
+
+	-m) chmodcmd="$chmodprog $2"
+	    shift
+	    shift
+	    continue;;
+
+	-o) chowncmd="$chownprog $2"
+	    shift
+	    shift
+	    continue;;
+
+	-g) chgrpcmd="$chgrpprog $2"
+	    shift
+	    shift
+	    continue;;
+
+	-s) stripcmd="$stripprog"
+	    shift
+	    continue;;
+
+	-t=*) transformarg=`echo $1 | sed 's/-t=//'`
+	    shift
+	    continue;;
+
+	-b=*) transformbasename=`echo $1 | sed 's/-b=//'`
+	    shift
+	    continue;;
+
+	*)  if [ x"$src" = x ]
+	    then
+		src=$1
+	    else
+		# this colon is to work around a 386BSD /bin/sh bug
+		:
+		dst=$1
+	    fi
+	    shift
+	    continue;;
+    esac
+done
+
+if [ x"$src" = x ]
+then
+	echo "install:	no input file specified"
+	exit 1
+else
+	true
+fi
+
+if [ x"$dir_arg" != x ]; then
+	dst=$src
+	src=""
+
+	if [ -d $dst ]; then
+		instcmd=:
+		chmodcmd=""
+	else
+		instcmd=mkdir
+	fi
+else
+
+# Waiting for this to be detected by the "$instcmd $src $dsttmp" command
+# might cause directories to be created, which would be especially bad
+# if $src (and thus $dsttmp) contains '*'.
+
+	if [ -f $src -o -d $src ]
+	then
+		true
+	else
+		echo "install:  $src does not exist"
+		exit 1
+	fi
+
+	if [ x"$dst" = x ]
+	then
+		echo "install:	no destination specified"
+		exit 1
+	else
+		true
+	fi
+
+# If destination is a directory, append the input filename; if your system
+# does not like double slashes in filenames, you may need to add some logic
+
+	if [ -d $dst ]
+	then
+		dst="$dst"/`basename $src`
+	else
+		true
+	fi
+fi
+
+## this sed command emulates the dirname command
+dstdir=`echo $dst | sed -e 's,[^/]*$,,;s,/$,,;s,^$,.,'`
+
+# Make sure that the destination directory exists.
+#  this part is taken from Noah Friedman's mkinstalldirs script
+
+# Skip lots of stat calls in the usual case.
+if [ ! -d "$dstdir" ]; then
+defaultIFS=''
+IFS="${IFS-${defaultIFS}}"
+
+oIFS="${IFS}"
+# Some sh's can't handle IFS=/ for some reason.
+IFS='%'
+set - `echo ${dstdir} | sed -e 's@/@%@g' -e 's@^%@/@'`
+IFS="${oIFS}"
+
+pathcomp=''
+
+while [ $# -ne 0 ] ; do
+	pathcomp="${pathcomp}${1}"
+	shift
+
+	if [ ! -d "${pathcomp}" ] ;
+        then
+		$mkdirprog "${pathcomp}"
+	else
+		true
+	fi
+
+	pathcomp="${pathcomp}/"
+done
+fi
+
+if [ x"$dir_arg" != x ]
+then
+	$doit $instcmd $dst &&
+
+	if [ x"$chowncmd" != x ]; then $doit $chowncmd $dst; else true ; fi &&
+	if [ x"$chgrpcmd" != x ]; then $doit $chgrpcmd $dst; else true ; fi &&
+	if [ x"$stripcmd" != x ]; then $doit $stripcmd $dst; else true ; fi &&
+	if [ x"$chmodcmd" != x ]; then $doit $chmodcmd $dst; else true ; fi
+else
+
+# If we're going to rename the final executable, determine the name now.
+
+	if [ x"$transformarg" = x ]
+	then
+		dstfile=`basename $dst`
+	else
+		dstfile=`basename $dst $transformbasename |
+			sed $transformarg`$transformbasename
+	fi
+
+# don't allow the sed command to completely eliminate the filename
+
+	if [ x"$dstfile" = x ]
+	then
+		dstfile=`basename $dst`
+	else
+		true
+	fi
+
+# Make a temp file name in the proper directory.
+
+	dsttmp=$dstdir/#inst.$$#
+
+# Move or copy the file name to the temp name
+
+	$doit $instcmd $src $dsttmp &&
+
+	trap "rm -f ${dsttmp}" 0 &&
+
+# and set any options; do chmod last to preserve setuid bits
+
+# If any of these fail, we abort the whole thing.  If we want to
+# ignore errors from any of these, just make sure not to ignore
+# errors from the above "$doit $instcmd $src $dsttmp" command.
+
+	if [ x"$chowncmd" != x ]; then $doit $chowncmd $dsttmp; else true;fi &&
+	if [ x"$chgrpcmd" != x ]; then $doit $chgrpcmd $dsttmp; else true;fi &&
+	if [ x"$stripcmd" != x ]; then $doit $stripcmd $dsttmp; else true;fi &&
+	if [ x"$chmodcmd" != x ]; then $doit $chmodcmd $dsttmp; else true;fi &&
+
+# Now rename the file to the real destination.
+
+	$doit $rmcmd -f $dstdir/$dstfile &&
+	$doit $mvcmd $dsttmp $dstdir/$dstfile
+
+fi &&
+
+
+exit 0
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/list.c b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/list.c
new file mode 100644
index 0000000..9a90284
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/list.c
@@ -0,0 +1,55 @@
+
+/*
+ * Simple list implementation mostly take from the Linux Kernel
+ */
+
+#include <stdlib.h>
+#include "list.h"
+
+void INIT_LIST_HEAD(struct list_head *list)
+{
+	list->next = list;
+	list->prev = list;
+}
+
+void __list_add(struct list_head *new,
+		struct list_head *prev,
+		struct list_head *next)
+{
+	next->prev = new;
+	new->next = next;
+	new->prev = prev;
+	prev->next = new;
+}
+
+void __list_del(struct list_head *prev, struct list_head *next)
+{
+	next->prev = prev;
+	prev->next = next;
+}
+
+void list_add(struct list_head *new, struct list_head *head)
+{
+	__list_add(new, head, head->next);
+}
+
+void list_add_tail(struct list_head *new, struct list_head *head)
+{
+	__list_add(new, head->prev, head);
+}
+
+void list_del(struct list_head *entry)
+{
+	__list_del(entry->prev, entry->next);
+	entry->next = NULL;
+	entry->prev = NULL;
+}
+
+void list_replace(struct list_head *old,
+		  struct list_head *new)
+{
+	new->next = old->next;
+	new->next->prev = new;
+	new->prev = old->prev;
+	new->prev->next = new;
+}
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/list.h b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/list.h
new file mode 100644
index 0000000..e14709d
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/list.h
@@ -0,0 +1,53 @@
+
+/*
+ * Simple list implementation mostly take from the Linux Kernel
+ */
+
+#ifndef _LIST_H_
+#define _LIST_H_
+
+struct list_head {
+	struct list_head *next, *prev;
+};
+
+void INIT_LIST_HEAD(struct list_head *list);
+void __list_add(struct list_head *new, struct list_head *prev,
+		struct list_head *next);
+void __list_del(struct list_head *prev, struct list_head *next);
+void list_add(struct list_head *new, struct list_head *head);
+void list_add_tail(struct list_head *new, struct list_head *head);
+void list_del(struct list_head *entry);
+void list_replace(struct list_head *old, struct list_head *new);
+
+#define LIST_HEAD_INIT(name) { &(name), &(name) }
+
+#define LIST_HEAD(name) struct list_head name = LIST_HEAD_INIT(name)
+
+#define list_for_each(pos, head) \
+	for (pos = (head)->next; pos->next, pos != (head); pos = pos->next)
+
+#define offsetof(type, member) ((int) &((type *)0)->member)
+
+#define container_of(ptr, type, member) ({ \
+	const typeof(((type *)0)->member) *__mptr = (ptr); \
+	(type *)((char *)__mptr - offsetof(type, member)); })
+
+#define list_entry(ptr, type, member) \
+	container_of(ptr, type, member)
+
+#define list_for_each_entry(pos, head, member) \
+	for (pos = list_entry((head)->next, typeof(*pos), member);	\
+	     pos->member.next, &pos->member != (head); 	\
+	     pos = list_entry(pos->member.next, typeof(*pos), member))
+
+#define list_for_each_entry_safe(pos, n, head, member)			\
+	for (pos = list_entry((head)->next, typeof(*pos), member),	\
+		n = list_entry(pos->member.next, typeof(*pos), member);	\
+	     &pos->member != (head); 					\
+	     pos = n, n = list_entry(n->member.next, typeof(*n), member))
+
+#define list_for_each_safe(pos, n, head) \
+	for (pos = (head)->next, n = pos->next; pos != (head); \
+		pos = n, n = pos->next)
+
+#endif
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/main.c b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/main.c
new file mode 100644
index 0000000..abee1f3
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/main.c
@@ -0,0 +1,258 @@
+/*
+ *   Copyright (c) International Business Machines Corp., 2001-2004
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+#include <pthread.h>
+#include <sys/time.h>
+#include <sys/times.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <pthread.h>
+
+#include <assert.h>
+
+#include "config.h"
+
+#include "ffsb.h"
+#include "util.h"
+#include "parser.h"
+
+/* State information for the polling function below */
+struct ffsb_time_poll {
+	struct timeval starttime;
+	int wait_time;
+};
+
+/* This is the polling function used by the threadgroups to check
+ * elapsed time, when it returns 1 they know it is time to stop
+ */
+static int ffsb_poll_fn(void *ptr)
+{
+	struct ffsb_time_poll *data = (struct ffsb_time_poll *)ptr;
+	struct timeval curtime, difftime;
+	gettimeofday(&curtime, NULL);
+
+	timersub(&curtime, &data->starttime, &difftime);
+	if (difftime.tv_sec >= data->wait_time)
+		return 1;
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int i;
+	ffsb_config_t fc;
+	ffsb_barrier_t thread_barrier, tg_barrier;
+	tg_run_params_t *params;
+	struct ffsb_time_poll pdata;
+	struct timeval starttime, endtime, difftime;
+	pthread_attr_t attr;
+	ffsb_op_results_t total_results;
+	double totaltime = 0.0f, usertime = 0.0f, systime = 0.0f;
+	struct rusage before_self, before_children, after_self, after_children;
+	pthread_t *fs_pts; /* threads to do filesystem creates in parallel */
+	char *callout = NULL;
+
+	char ctime_start_buf[32];
+	char ctime_end_buf[32];
+
+	memset(&before_self, 0, sizeof(before_self));
+	memset(&before_children, 0, sizeof(before_children));
+	memset(&after_self, 0, sizeof(after_self));
+	memset(&after_children, 0, sizeof(after_children));
+
+	ffsb_unbuffer_stdout();
+
+	if (argc < 2) {
+		fprintf(stderr, "usage: %s <config file>\n",
+			argv[0]);
+		exit(1);
+	}
+
+	/* VERSION comes from config.h (which is autogenerated by autoconf) */
+	printf("FFSB version %s started\n\n", VERSION);
+
+	ffsb_parse_newconfig(&fc, argv[1]);
+	pdata.wait_time = fc.time;
+
+	if (fc.time)
+		printf("benchmark time = %u\n", fc.time);
+	 else
+		printf("Only creating the fileset, not running benchmark.\n");
+
+	pthread_attr_init(&attr);
+	pthread_attr_setscope(&attr, PTHREAD_SCOPE_SYSTEM);
+
+	for (i = 0; i < fc.num_threadgroups; i++)
+		tg_print_config(&fc.groups[i]);
+
+	fs_pts = ffsb_malloc(sizeof(pthread_t) * fc.num_filesys);
+
+	gettimeofday(&starttime, NULL);
+	for (i = 0; i < fc.num_filesys; i++) {
+		fs_print_config(&fc.filesystems[i]);
+		pthread_create(fs_pts + i, &attr, construct_ffsb_fs,
+			       &fc.filesystems[i]);
+	}
+
+	fflush(stdout);
+	for (i = 0; i < fc.num_filesys; i++)
+		pthread_join(fs_pts[i], NULL);
+
+	gettimeofday(&endtime, NULL);
+	timersub(&endtime, &starttime, &difftime);
+	printf("fs setup took %ld secs\n", difftime.tv_sec);
+	free(fs_pts);
+
+	if (fc.time == 0) {
+		printf("Setup complete, exiting\n");
+		return 0;
+	}
+
+	params = ffsb_malloc(sizeof(tg_run_params_t) * fc.num_threadgroups);
+
+	init_ffsb_op_results(&total_results);
+	ffsb_barrier_init(&thread_barrier, fc.num_totalthreads);
+	ffsb_barrier_init(&tg_barrier, fc.num_threadgroups + 1);
+
+	ffsb_sync();
+
+	/* Execute the callout if any and wait for it to return */
+	callout = fc_get_callout(&fc);
+	if (callout) {
+		printf("executing callout: \n %s\n", callout);
+		if (ffsb_system(callout) < 0) {
+			perror("system");
+			exit(1);
+		}
+	}
+
+	/* Spawn all of the threadgroup master threads */
+	for (i = 0; i < fc.num_threadgroups; i++) {
+		params[i].tg = &fc.groups[i];
+		params[i].fc = &fc;
+		params[i].poll_fn = ffsb_poll_fn;
+		params[i].poll_data = &pdata;
+		params[i].wait_time = FFSB_TG_WAIT_TIME;
+		params[i].tg_barrier = &tg_barrier;
+		params[i].thread_barrier = &thread_barrier;
+
+		pthread_create(&params[i].pt, &attr, tg_run, &params[i]);
+	}
+
+	ffsb_getrusage(&before_self, &before_children);
+	gettimeofday(&pdata.starttime, NULL);
+
+	ffsb_barrier_wait(&tg_barrier);  /* sync with tg's to start*/
+	printf("Starting Actual Benchmark At: %s\n",
+	       ctime_r(&pdata.starttime.tv_sec, ctime_start_buf));
+	fflush(stdout);
+
+	/* Wait for all of the threadgroup master threads to finish */
+	for (i = 0; i < fc.num_threadgroups; i++)
+		pthread_join(params[i].pt, NULL);
+
+	ffsb_sync();
+	gettimeofday(&endtime, NULL);
+	ffsb_getrusage(&after_self, &after_children);
+
+	printf("FFSB benchmark finished   at: %s\n",
+	       ctime_r(&endtime.tv_sec, ctime_end_buf));
+	printf("Results:\n");
+	fflush(stdout);
+
+	timersub(&endtime, &pdata.starttime, &difftime);
+
+	totaltime = tvtodouble(&difftime);
+
+	printf("Benchmark took %.2lf sec\n", totaltime);
+	printf("\n");
+
+	for (i = 0; i < fc.num_threadgroups; i++) {
+		struct ffsb_op_results tg_results;
+		ffsb_tg_t *tg = fc.groups + i;
+
+		init_ffsb_op_results(&tg_results);
+
+		/* Grab the individual tg results */
+		tg_collect_results(tg, &tg_results);
+
+		if (fc.num_threadgroups == 1)
+			printf("Total Results\n");
+		else
+			printf("ThreadGroup %d\n", i);
+
+		printf("===============\n");
+		print_results(&tg_results, totaltime);
+
+		if (tg_needs_stats(tg)) {
+			ffsb_statsd_t fsd;
+			tg_collect_stats(tg, &fsd);
+			ffsb_statsd_print(&fsd);
+		}
+		printf("\n");
+
+		/* Add the tg results to the total */
+		tg_collect_results(&fc.groups[i], &total_results);
+	}
+
+	if (fc.num_threadgroups > 1) {
+		printf("Total Results\n");
+		printf("===============\n");
+		print_results(&total_results, totaltime);
+	}
+
+#define USEC_PER_SEC ((double)(1000000.0f))
+
+	/* sum up self and children after */
+	usertime = (after_self.ru_utime.tv_sec +
+		    ((after_self.ru_utime.tv_usec)/USEC_PER_SEC)) +
+		((after_children.ru_utime.tv_sec +
+		  ((after_children.ru_utime.tv_usec)/USEC_PER_SEC)));
+
+	/* subtract away the before */
+	usertime -= (before_self.ru_utime.tv_sec +
+		     ((before_self.ru_utime.tv_usec)/USEC_PER_SEC)) +
+		((before_children.ru_utime.tv_sec +
+		  ((before_children.ru_utime.tv_usec)/USEC_PER_SEC)));
+
+
+	/* sum up self and children after */
+	systime = (after_self.ru_stime.tv_sec +
+		   ((after_self.ru_stime.tv_usec)/USEC_PER_SEC)) +
+		((after_children.ru_stime.tv_sec +
+		  ((after_children.ru_stime.tv_usec)/USEC_PER_SEC)));
+
+	/* subtract away the before */
+	systime -= (before_self.ru_stime.tv_sec +
+		    ((before_self.ru_stime.tv_usec)/USEC_PER_SEC)) +
+		((before_children.ru_stime.tv_sec +
+		  ((before_children.ru_stime.tv_usec)/USEC_PER_SEC)));
+
+	printf("\n\n");
+	printf("%.1lf%% User   Time\n", 100 * usertime / totaltime);
+	printf("%.1lf%% System Time\n", 100 * systime / totaltime);
+	printf("%.1f%% CPU Utilization\n", 100 * (usertime + systime) /
+	       totaltime);
+	free(params);
+	destroy_ffsb_config(&fc);
+
+	return 0;
+}
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/metaops.c b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/metaops.c
new file mode 100644
index 0000000..c9e2409
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/metaops.c
@@ -0,0 +1,112 @@
+/*
+ *   Copyright (c) International Business Machines Corp., 2001-2004
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+#include <unistd.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "ffsb.h"
+#include "metaops.h"
+#include "rand.h"
+#include "filelist.h"
+
+/* metaops:
+ *  createdir
+ *  removedir
+ *  renamedir
+ *  renamefile
+ */
+
+void metaops_metadir(ffsb_fs_t *fs, unsigned opnum)
+{
+	fs_set_opdata(fs, fs_get_metafiles(fs), opnum);
+}
+
+static void createdir(struct benchfiles *dirs, randdata_t *rd)
+{
+	struct ffsb_file *newdir;
+
+	newdir = add_file(dirs, 0, rd);
+	if (mkdir(newdir->name, S_IRWXU) < 0) {
+		perror("mkdir");
+		exit(1);
+	}
+	unlock_file_writer(newdir);
+}
+
+static void removedir(struct benchfiles *dirs, randdata_t *rd)
+{
+	struct ffsb_file *deldir;
+
+	deldir = choose_file_writer(dirs, rd);
+	remove_file(dirs, deldir);
+
+	if (rmdir(deldir->name) < 0) {
+		perror("rmdir");
+		exit(1);
+	}
+	unlock_file_writer(deldir);
+}
+
+static void renamedir(struct benchfiles *dirs, randdata_t *rd)
+{
+	struct ffsb_file *dir;
+	char *oldname;
+
+	dir = choose_file_writer(dirs, rd);
+	oldname = dir->name;
+	rename_file(dir);
+
+	if (rename(oldname, dir->name) < 0) {
+		perror("rename");
+		exit(1);
+	}
+	unlock_file_writer(dir);
+	free(oldname);
+}
+
+void ffsb_metaops(ffsb_thread_t *ft, ffsb_fs_t *fs, unsigned opnum)
+{
+	struct benchfiles *bf = (struct benchfiles *)fs_get_opdata(fs, opnum);
+	randdata_t *rd = ft_get_randdata(ft);
+
+	createdir(bf, rd);
+	createdir(bf, rd);
+	removedir(bf, rd);
+	renamedir(bf, rd);
+
+	ft_incr_op(ft, opnum, 1, 0);
+}
+
+void ffsb_createdir(ffsb_thread_t *ft, ffsb_fs_t *fs, unsigned opnum)
+{
+	struct benchfiles *bf = (struct benchfiles *)fs_get_opdata(fs, opnum);
+	struct ffsb_file *newdir;
+	randdata_t *rd = ft_get_randdata(ft);
+
+	newdir = add_dir(bf, 0, rd);
+	if (mkdir(newdir->name, S_IRWXU) < 0) {
+		perror("mkdir");
+		exit(1);
+	}
+	unlock_file_writer(newdir);
+
+	ft_incr_op(ft, opnum, 1, 0);
+}
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/metaops.h b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/metaops.h
new file mode 100644
index 0000000..04cbe9f
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/metaops.h
@@ -0,0 +1,28 @@
+/*
+ *   Copyright (c) International Business Machines Corp., 2001-2004
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+#ifndef _METAOPS_H_
+#define _METAOPS_H_
+
+#include "ffsb.h"
+#include "fileops.h"
+
+void ffsb_metaops(struct ffsb_thread *, ffsb_fs_t *, unsigned);
+void ffsb_createdir(struct ffsb_thread *, ffsb_fs_t *, unsigned);
+void metaops_metadir(ffsb_fs_t *, unsigned);
+
+#endif /* _METAOPS_H_ */
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/missing b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/missing
new file mode 100644
index 0000000..6a37006
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/missing
@@ -0,0 +1,336 @@
+#! /bin/sh
+# Common stub for a few missing GNU programs while installing.
+# Copyright (C) 1996, 1997, 1999, 2000, 2002 Free Software Foundation, Inc.
+# Originally by Fran,cois Pinard <pinard@iro.umontreal.ca>, 1996.
+
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2, or (at your option)
+# any later version.
+
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+# 02111-1307, USA.
+
+# As a special exception to the GNU General Public License, if you
+# distribute this file as part of a program that contains a
+# configuration script generated by Autoconf, you may include it under
+# the same distribution terms that you use for the rest of that program.
+
+if test $# -eq 0; then
+  echo 1>&2 "Try \`$0 --help' for more information"
+  exit 1
+fi
+
+run=:
+
+# In the cases where this matters, `missing' is being run in the
+# srcdir already.
+if test -f configure.ac; then
+  configure_ac=configure.ac
+else
+  configure_ac=configure.in
+fi
+
+case "$1" in
+--run)
+  # Try to run requested program, and just exit if it succeeds.
+  run=
+  shift
+  "$@" && exit 0
+  ;;
+esac
+
+# If it does not exist, or fails to run (possibly an outdated version),
+# try to emulate it.
+case "$1" in
+
+  -h|--h|--he|--hel|--help)
+    echo "\
+$0 [OPTION]... PROGRAM [ARGUMENT]...
+
+Handle \`PROGRAM [ARGUMENT]...' for when PROGRAM is missing, or return an
+error status if there is no known handling for PROGRAM.
+
+Options:
+  -h, --help      display this help and exit
+  -v, --version   output version information and exit
+  --run           try to run the given command, and emulate it if it fails
+
+Supported PROGRAM values:
+  aclocal      touch file \`aclocal.m4'
+  autoconf     touch file \`configure'
+  autoheader   touch file \`config.h.in'
+  automake     touch all \`Makefile.in' files
+  bison        create \`y.tab.[ch]', if possible, from existing .[ch]
+  flex         create \`lex.yy.c', if possible, from existing .c
+  help2man     touch the output file
+  lex          create \`lex.yy.c', if possible, from existing .c
+  makeinfo     touch the output file
+  tar          try tar, gnutar, gtar, then tar without non-portable flags
+  yacc         create \`y.tab.[ch]', if possible, from existing .[ch]"
+    ;;
+
+  -v|--v|--ve|--ver|--vers|--versi|--versio|--version)
+    echo "missing 0.4 - GNU automake"
+    ;;
+
+  -*)
+    echo 1>&2 "$0: Unknown \`$1' option"
+    echo 1>&2 "Try \`$0 --help' for more information"
+    exit 1
+    ;;
+
+  aclocal*)
+    if test -z "$run" && ($1 --version) > /dev/null 2>&1; then
+       # We have it, but it failed.
+       exit 1
+    fi
+
+    echo 1>&2 "\
+WARNING: \`$1' is missing on your system.  You should only need it if
+         you modified \`acinclude.m4' or \`${configure_ac}'.  You might want
+         to install the \`Automake' and \`Perl' packages.  Grab them from
+         any GNU archive site."
+    touch aclocal.m4
+    ;;
+
+  autoconf)
+    if test -z "$run" && ($1 --version) > /dev/null 2>&1; then
+       # We have it, but it failed.
+       exit 1
+    fi
+
+    echo 1>&2 "\
+WARNING: \`$1' is missing on your system.  You should only need it if
+         you modified \`${configure_ac}'.  You might want to install the
+         \`Autoconf' and \`GNU m4' packages.  Grab them from any GNU
+         archive site."
+    touch configure
+    ;;
+
+  autoheader)
+    if test -z "$run" && ($1 --version) > /dev/null 2>&1; then
+       # We have it, but it failed.
+       exit 1
+    fi
+
+    echo 1>&2 "\
+WARNING: \`$1' is missing on your system.  You should only need it if
+         you modified \`acconfig.h' or \`${configure_ac}'.  You might want
+         to install the \`Autoconf' and \`GNU m4' packages.  Grab them
+         from any GNU archive site."
+    files=`sed -n 's/^[ ]*A[CM]_CONFIG_HEADER(\([^)]*\)).*/\1/p' ${configure_ac}`
+    test -z "$files" && files="config.h"
+    touch_files=
+    for f in $files; do
+      case "$f" in
+      *:*) touch_files="$touch_files "`echo "$f" |
+				       sed -e 's/^[^:]*://' -e 's/:.*//'`;;
+      *) touch_files="$touch_files $f.in";;
+      esac
+    done
+    touch $touch_files
+    ;;
+
+  automake*)
+    if test -z "$run" && ($1 --version) > /dev/null 2>&1; then
+       # We have it, but it failed.
+       exit 1
+    fi
+
+    echo 1>&2 "\
+WARNING: \`$1' is missing on your system.  You should only need it if
+         you modified \`Makefile.am', \`acinclude.m4' or \`${configure_ac}'.
+         You might want to install the \`Automake' and \`Perl' packages.
+         Grab them from any GNU archive site."
+    find . -type f -name Makefile.am -print |
+	   sed 's/\.am$/.in/' |
+	   while read f; do touch "$f"; done
+    ;;
+
+  autom4te)
+    if test -z "$run" && ($1 --version) > /dev/null 2>&1; then
+       # We have it, but it failed.
+       exit 1
+    fi
+
+    echo 1>&2 "\
+WARNING: \`$1' is needed, and you do not seem to have it handy on your
+         system.  You might have modified some files without having the
+         proper tools for further handling them.
+         You can get \`$1Help2man' as part of \`Autoconf' from any GNU
+         archive site."
+
+    file=`echo "$*" | sed -n 's/.*--output[ =]*\([^ ]*\).*/\1/p'`
+    test -z "$file" && file=`echo "$*" | sed -n 's/.*-o[ ]*\([^ ]*\).*/\1/p'`
+    if test -f "$file"; then
+	touch $file
+    else
+	test -z "$file" || exec >$file
+	echo "#! /bin/sh"
+	echo "# Created by GNU Automake missing as a replacement of"
+	echo "#  $ $@"
+	echo "exit 0"
+	chmod +x $file
+	exit 1
+    fi
+    ;;
+
+  bison|yacc)
+    echo 1>&2 "\
+WARNING: \`$1' is missing on your system.  You should only need it if
+         you modified a \`.y' file.  You may need the \`Bison' package
+         in order for those modifications to take effect.  You can get
+         \`Bison' from any GNU archive site."
+    rm -f y.tab.c y.tab.h
+    if [ $# -ne 1 ]; then
+        eval LASTARG="\${$#}"
+	case "$LASTARG" in
+	*.y)
+	    SRCFILE=`echo "$LASTARG" | sed 's/y$/c/'`
+	    if [ -f "$SRCFILE" ]; then
+	         cp "$SRCFILE" y.tab.c
+	    fi
+	    SRCFILE=`echo "$LASTARG" | sed 's/y$/h/'`
+	    if [ -f "$SRCFILE" ]; then
+	         cp "$SRCFILE" y.tab.h
+	    fi
+	  ;;
+	esac
+    fi
+    if [ ! -f y.tab.h ]; then
+	echo >y.tab.h
+    fi
+    if [ ! -f y.tab.c ]; then
+	echo 'main() { return 0; }' >y.tab.c
+    fi
+    ;;
+
+  lex|flex)
+    echo 1>&2 "\
+WARNING: \`$1' is missing on your system.  You should only need it if
+         you modified a \`.l' file.  You may need the \`Flex' package
+         in order for those modifications to take effect.  You can get
+         \`Flex' from any GNU archive site."
+    rm -f lex.yy.c
+    if [ $# -ne 1 ]; then
+        eval LASTARG="\${$#}"
+	case "$LASTARG" in
+	*.l)
+	    SRCFILE=`echo "$LASTARG" | sed 's/l$/c/'`
+	    if [ -f "$SRCFILE" ]; then
+	         cp "$SRCFILE" lex.yy.c
+	    fi
+	  ;;
+	esac
+    fi
+    if [ ! -f lex.yy.c ]; then
+	echo 'main() { return 0; }' >lex.yy.c
+    fi
+    ;;
+
+  help2man)
+    if test -z "$run" && ($1 --version) > /dev/null 2>&1; then
+       # We have it, but it failed.
+       exit 1
+    fi
+
+    echo 1>&2 "\
+WARNING: \`$1' is missing on your system.  You should only need it if
+	 you modified a dependency of a manual page.  You may need the
+	 \`Help2man' package in order for those modifications to take
+	 effect.  You can get \`Help2man' from any GNU archive site."
+
+    file=`echo "$*" | sed -n 's/.*-o \([^ ]*\).*/\1/p'`
+    if test -z "$file"; then
+	file=`echo "$*" | sed -n 's/.*--output=\([^ ]*\).*/\1/p'`
+    fi
+    if [ -f "$file" ]; then
+	touch $file
+    else
+	test -z "$file" || exec >$file
+	echo ".ab help2man is required to generate this page"
+	exit 1
+    fi
+    ;;
+
+  makeinfo)
+    if test -z "$run" && (makeinfo --version) > /dev/null 2>&1; then
+       # We have makeinfo, but it failed.
+       exit 1
+    fi
+
+    echo 1>&2 "\
+WARNING: \`$1' is missing on your system.  You should only need it if
+         you modified a \`.texi' or \`.texinfo' file, or any other file
+         indirectly affecting the aspect of the manual.  The spurious
+         call might also be the consequence of using a buggy \`make' (AIX,
+         DU, IRIX).  You might want to install the \`Texinfo' package or
+         the \`GNU make' package.  Grab either from any GNU archive site."
+    file=`echo "$*" | sed -n 's/.*-o \([^ ]*\).*/\1/p'`
+    if test -z "$file"; then
+      file=`echo "$*" | sed 's/.* \([^ ]*\) *$/\1/'`
+      file=`sed -n '/^@setfilename/ { s/.* \([^ ]*\) *$/\1/; p; q; }' $file`
+    fi
+    touch $file
+    ;;
+
+  tar)
+    shift
+    if test -n "$run"; then
+      echo 1>&2 "ERROR: \`tar' requires --run"
+      exit 1
+    fi
+
+    # We have already tried tar in the generic part.
+    # Look for gnutar/gtar before invocation to avoid ugly error
+    # messages.
+    if (gnutar --version > /dev/null 2>&1); then
+       gnutar "$@" && exit 0
+    fi
+    if (gtar --version > /dev/null 2>&1); then
+       gtar "$@" && exit 0
+    fi
+    firstarg="$1"
+    if shift; then
+	case "$firstarg" in
+	*o*)
+	    firstarg=`echo "$firstarg" | sed s/o//`
+	    tar "$firstarg" "$@" && exit 0
+	    ;;
+	esac
+	case "$firstarg" in
+	*h*)
+	    firstarg=`echo "$firstarg" | sed s/h//`
+	    tar "$firstarg" "$@" && exit 0
+	    ;;
+	esac
+    fi
+
+    echo 1>&2 "\
+WARNING: I can't seem to be able to run \`tar' with the given arguments.
+         You may want to install GNU tar or Free paxutils, or check the
+         command line arguments."
+    exit 1
+    ;;
+
+  *)
+    echo 1>&2 "\
+WARNING: \`$1' is needed, and you do not seem to have it handy on your
+         system.  You might have modified some files without having the
+         proper tools for further handling them.  Check the \`README' file,
+         it often tells you about the needed prerequirements for installing
+         this package.  You may also peek at any GNU archive site, in case
+         some other package would contain this missing \`$1' program."
+    exit 1
+    ;;
+esac
+
+exit 0
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/mkinstalldirs b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/mkinstalldirs
new file mode 100644
index 0000000..08bec60
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/mkinstalldirs
@@ -0,0 +1,40 @@
+#! /bin/sh
+# mkinstalldirs --- make directory hierarchy
+# Author: Noah Friedman <friedman@prep.ai.mit.edu>
+# Created: 1993-05-16
+# Public domain
+
+# $Id: mkinstalldirs,v 4.0 2004/03/31 17:52:41 sonnyrao Exp $
+
+errstatus=0
+
+for file
+do
+   set fnord `echo ":$file" | sed -ne 's/^:\//#/;s/^://;s/\// /g;s/^#/\//;p'`
+   shift
+
+   pathcomp=
+   for d
+   do
+     pathcomp="$pathcomp$d"
+     case "$pathcomp" in
+       -* ) pathcomp=./$pathcomp ;;
+     esac
+
+     if test ! -d "$pathcomp"; then
+        echo "mkdir $pathcomp"
+
+        mkdir "$pathcomp" || lasterr=$?
+
+        if test ! -d "$pathcomp"; then
+  	  errstatus=$lasterr
+        fi
+     fi
+
+     pathcomp="$pathcomp/"
+   done
+done
+
+exit $errstatus
+
+# mkinstalldirs ends here
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/parser.c b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/parser.c
new file mode 100644
index 0000000..43ec151
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/parser.c
@@ -0,0 +1,1034 @@
+/*
+ *   Copyright (c) International Business Machines Corp., 2001-2004
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+#include <stdio.h>
+#include <string.h>
+#include <assert.h>
+#include <inttypes.h>
+#include <ctype.h>
+
+#include "ffsb.h"
+#include "parser.h"
+#include "ffsb_tg.h"
+#include "ffsb_stats.h"
+#include "util.h"
+#include "list.h"
+
+#define BUFSIZE 1024
+
+config_options_t global_options[] = GLOBAL_OPTIONS;
+config_options_t tg_options[] = THREADGROUP_OPTIONS;
+config_options_t fs_options[] = FILESYSTEM_OPTIONS;
+config_options_t stats_options[] = STATS_OPTIONS;
+container_desc_t container_desc[] = CONTAINER_DESC;
+
+/* strips out whitespace and comments, returns NULL on eof */
+void parseerror(char *msg)
+{
+	fprintf(stderr, "Error parsing %s\n", msg);
+	exit(1);
+}
+
+static char *get_next_line(FILE *f)
+{
+	static char buf[BUFSIZE];
+	char *ret, *tmp;
+	int flag = 1;
+	while (flag) {
+		ret = fgets(buf, BUFSIZE, f);
+		if (ret == NULL)
+			return NULL;
+		ret = buf;
+		while (isspace(*ret))
+			ret++;
+
+		if ((*ret == COMMENT_CHAR) || (*ret == '\0'))
+			continue;
+
+		tmp = ret;
+		while (*tmp != '\0') {
+			if (*tmp == COMMENT_CHAR) {
+				*tmp = '\0';
+				break;
+			}
+			tmp++;
+		}
+		flag = 0;
+	}
+	return ret;
+}
+
+static char *strip_space(char *buf)
+{
+	int len;
+	char *tmp, *tmp2;
+	int flag = 1;
+
+	len = strnlen(buf, BUFSIZE);
+	tmp = malloc(sizeof(char) * len);
+	memset(tmp, 0, sizeof(char) * len);
+	tmp2 = tmp;
+	while (flag) {
+		if (!isspace(*buf)) {
+			*tmp = *buf;
+			tmp++;
+		}
+		buf++;
+		if (*buf != '\0')
+			continue;
+		flag = 0;
+	}
+	return tmp2;
+}
+
+static uint64_t size64_convert(char *buf)
+{
+	size_t buf_size = strlen(buf);
+	char unit[3] = {0};
+	char search_str[256];
+	uint64_t size;
+	uint64_t multiplier = 1;
+	int i;
+
+	if (buf_size == 1)
+		goto out;
+
+	strcpy(unit, buf + (buf_size - 2));
+	for (i = 0; i < 2; i++) {
+		if (isdigit(unit[i]))
+			goto try_single;
+		unit[i] = toupper(unit[i]);
+	}
+	goto do_multiplier;
+
+try_single:
+	memcpy(unit, "\0", 3);
+	strcpy(unit, buf + (buf_size - 1));
+	if (isdigit(unit[0])) {
+		unit[0] = 0;
+		goto out;
+	}
+	unit[0] = toupper(unit[0]);
+
+do_multiplier:
+	if (!strcmp("KB", unit) || !strcmp("K", unit))
+		multiplier = 1024;
+	if (!strcmp("MB", unit) || !strcmp("M", unit))
+		multiplier = 1048576;
+	if (!strcmp("GB", unit) || !strcmp("G", unit))
+		multiplier = 1073741824;
+	if (multiplier == 1) {
+		unit[0] = 0;
+		multiplier = 0;
+	}
+out:
+	sprintf(search_str, "%%llu%s", unit);
+	if (1 == sscanf(buf, search_str, &size))
+		return size * multiplier;
+	return 0;
+}
+
+static uint64_t *get_opt64(char *buf, char string[])
+{
+	char search_str[256];
+	char *line = strip_space(buf);
+	uint64_t temp;
+	uint64_t *ret;
+
+	sprintf(search_str, "%s=%%llu\\n", string);
+	if (1 == sscanf(line, search_str, &temp)) {
+		ret = malloc(sizeof(uint64_t));
+		*ret = temp;
+		return ret;
+	}
+	free(line);
+	return NULL;
+}
+
+static uint32_t *get_opt32(char *buf, char string[])
+{
+	uint32_t *ret;
+	uint64_t *res;
+	res = get_opt64(buf, string);
+	if (res) {
+		ret = malloc(sizeof(uint32_t));
+		*ret = *res;
+		free(res);
+		return ret;
+	}
+	return NULL;
+}
+
+static uint8_t *get_optbool(char *buf, char string[])
+{
+	uint8_t *ret;
+	uint64_t *res;
+	res = get_opt64(buf, string);
+	if (res) {
+		if ((int)*res < 0 || (int)*res > 1) {
+			printf("Error in: %s", buf);
+			printf("%llu not boolean\n", (long long unsigned) *res);
+			exit(1);
+		}
+		ret = malloc(sizeof(uint8_t));
+		*ret = *res;
+		free(res);
+		return ret;
+	}
+	return NULL;
+}
+
+static char *get_optstr(char *buf, char string[])
+{
+	char search_str[256];
+	char *line = strip_space(buf);
+	char *ret_buf;
+	char temp[BUFSIZE];
+	int len;
+
+	len = strnlen(string, BUFSIZE);
+	sprintf(search_str, "%s=%%%ds\\n", string, BUFSIZE - len-1);
+	if (1 == sscanf(line, search_str, &temp)) {
+		len = strnlen(temp, 4096);
+		ret_buf = malloc(len);
+		strncpy(ret_buf, temp, len);
+		return ret_buf;
+		}
+	free(line);
+	return NULL;
+}
+
+static double *get_optdouble(char *buf, char string[])
+{
+	char search_str[256];
+	char *line = strip_space(buf);
+	double temp;
+	double *ret;
+
+	sprintf(search_str, "%s=%%lf\\n", string);
+	if (1 == sscanf(line, search_str, &temp)) {
+		ret = malloc(sizeof(double));
+		*ret = temp;
+		return ret;
+	}
+	free(line);
+	return NULL;
+}
+
+static range_t *get_optrange(char *buf, char string[])
+{
+	char search_str[256];
+	double a, b;
+	range_t *ret;
+
+	sprintf(search_str, "%s %%lf %%lf\\n", string);
+	if (2 == sscanf(buf, search_str, &a, &b)) {
+		ret = malloc(sizeof(struct range));
+		ret->a = a;
+		ret->b = b;
+		return ret;
+	}
+	return NULL;
+}
+
+static size_weight_t *get_optsizeweight(char *buf, char string[])
+{
+	char search_str[256];
+	char size[256];
+	int weight;
+	size_weight_t *ret;
+
+	sprintf(search_str, "%s %%s %%d\\n", string);
+	if (2 == sscanf(buf, search_str, &size, &weight)) {
+		ret = malloc(sizeof(struct size_weight));
+		ret->size = size64_convert(size);
+		ret->weight = weight;
+		return ret;
+	}
+	return NULL;
+}
+
+static uint64_t * get_optsize64(char *buf, char string[])
+{
+	char search_str[256];
+	char *line = strip_space(buf);
+	char temp[256];
+	uint64_t size;
+	uint64_t *ret = NULL;
+
+	sprintf(search_str, "%s=%%s\\n", string);
+	if (1 == sscanf(line, search_str, &temp)) {
+		ret = malloc(sizeof(uint64_t));
+		*ret = size64_convert(temp);
+	}
+	free(line);
+	return ret;
+}
+
+static uint32_t * get_optsize32(char *buf, char string [])
+{
+	uint32_t *ret;
+	uint64_t *res;
+	res = get_optsize64(buf, string);
+	if (res) {
+		ret = malloc(sizeof(uint32_t));
+		*ret = *res;
+		free(res);
+		return ret;
+	}
+	return NULL;
+}
+
+static uint64_t *get_deprecated(char *buf, char string[])
+{
+	char search_str[256];
+	char temp[BUFSIZE];
+	int len;
+
+	len = strnlen(string, BUFSIZE);
+	sprintf(search_str, "%s%%%ds\\n", string, BUFSIZE - len-1);
+	if (1 == sscanf(buf, search_str, &temp))
+		printf("WARNING: The \"%s\" option is deprecated!!!\n", string);
+
+	return NULL;
+}
+
+static container_t *init_container(void)
+{
+	container_t *container;
+	container = malloc(sizeof(container_t));
+	container->config = NULL;
+	container->type = 0;
+	container->next = NULL;
+	return container;
+}
+
+static int set_option(char *buf, config_options_t *options)
+{
+	void *value;
+
+	while (options->name) {
+		switch (options->type) {
+		case TYPE_WEIGHT:
+		case TYPE_U32:
+			value = get_opt32(buf, options->name);
+			if (value)
+				goto out;
+			break;
+		case TYPE_U64:
+			value = get_opt64(buf, options->name);
+			if (value)
+				goto out;
+			break;
+		case TYPE_STRING:
+			value = get_optstr(buf, options->name);
+			if (value)
+				goto out;
+			break;
+		case TYPE_BOOLEAN:
+			value = get_optbool(buf, options->name);
+			if (value)
+				goto out;
+			break;
+		case TYPE_DOUBLE:
+			value = get_optdouble(buf, options->name);
+			if (value)
+				goto out;
+			break;
+		case TYPE_RANGE:
+			value = get_optrange(buf, options->name);
+			if (value)
+				goto out;
+			break;
+		case TYPE_SIZEWEIGHT:
+			value = get_optsizeweight(buf, options->name);
+			if (value)
+				goto out;
+			break;
+		case TYPE_DEPRECATED:
+			value = get_deprecated(buf, options->name);
+			if (value)
+				goto out;
+			break;
+		case TYPE_SIZE32:
+			value = get_optsize32(buf, options->name);
+			if (value)
+				goto out;
+			break;
+		case TYPE_SIZE64:
+			value = get_optsize64(buf, options->name);
+			if (value)
+				goto out;
+			break;
+		default:
+			printf("Unknown type\n");
+			break;
+		}
+		options++;
+	}
+	return 0;
+
+out:
+	if (options->storage_type == STORE_SINGLE)
+		options->value = value;
+	if (options->storage_type == STORE_LIST) {
+		if (!options->value) {
+			value_list_t *lhead;
+			lhead = malloc(sizeof(struct value_list));
+			INIT_LIST_HEAD(&lhead->list);
+			options->value = lhead;
+		}
+		value_list_t *tmp_list, *tmp_list2;
+		tmp_list = malloc(sizeof(struct value_list));
+		INIT_LIST_HEAD(&tmp_list->list);
+		tmp_list->value = value;
+		tmp_list2 = (struct value_list *)options->value;
+		list_add(&(tmp_list->list), &(tmp_list2->list));
+	}
+
+	return 1;
+}
+
+void insert_container(container_t *container, container_t *new_container)
+{
+	while (container->next)
+		container = container->next;
+	container->next = new_container;
+}
+
+container_t *search_group(char *, FILE *);
+
+container_t *handle_container(char *buf, FILE *f, uint32_t type,
+			      config_options_t *options)
+{
+	container_desc_t *desc = container_desc;
+	container_t *ret_container;
+	container_t *tmp_container, *tmp2_container;
+	container_t *child = NULL;
+	int is_option;
+
+	while (desc->name)
+		if (desc->type == type)
+			break;
+		else
+			desc++;
+
+	if (!desc->name)
+		return NULL;
+
+	buf = get_next_line(f);
+	while (buf) {
+		is_option = set_option(buf, options);
+		tmp_container = search_group(buf, f);
+		if (tmp_container) {
+			if (tmp_container->type == END) {
+				free(tmp_container);
+				break;
+			} else {
+				if (child == NULL)
+					child = tmp_container;
+				else {
+					tmp2_container = child;
+					while (tmp2_container->next)
+						tmp2_container = tmp2_container->next;
+					tmp2_container->next = tmp_container;
+				}
+
+			}
+		}
+		if (!is_option && !tmp_container) {
+			printf("ERROR!!! Unknow option: %s", buf);
+			exit(1);
+		}
+		buf = get_next_line(f);
+	}
+	ret_container = init_container();
+	ret_container->config = options;
+	ret_container->type = type;
+	if (child)
+		ret_container->child = child;
+
+	return ret_container;
+}
+
+container_t *search_group(char *buf, FILE *f)
+{
+	char temp[BUFSIZE];
+	char *ptr;
+	config_options_t *options;
+	container_desc_t *desc = container_desc;
+	container_t *ret_container;
+
+	if (1 == sscanf(buf, "[%s]\n", (char *) &temp))
+		while (desc->name) {
+			ptr = strstr(buf, desc->name);
+			if (ptr)
+				switch (desc->type) {
+				case FILESYSTEM:
+					options = malloc(sizeof(fs_options));
+					memcpy(options, fs_options,
+					       sizeof(fs_options));
+					return handle_container(buf, f,
+								desc->type,
+								options);
+					break;
+				case THREAD_GROUP:
+					options = malloc(sizeof(tg_options));
+					memcpy(options, tg_options,
+					       sizeof(tg_options));
+					return handle_container(buf, f,
+								desc->type,
+								options);
+					break;
+				case STATS:
+					options = malloc(sizeof(stats_options));
+					memcpy(options, stats_options,
+					       sizeof(stats_options));
+					return handle_container(buf, f,
+								desc->type,
+								options);
+					break;
+				case END:
+					ret_container = init_container();
+					ret_container->type = END;
+					return ret_container;
+					break;
+				}
+			desc++;
+		}
+	return NULL;
+}
+
+void *get_value(config_options_t *config, char *name)
+{
+	while (config->name) {
+		if (!strcmp(config->name, name)) {
+			if (config->value)
+				return config->value;
+			else
+				return NULL;
+		}
+		config++;
+	}
+	return 0;
+}
+
+char *get_config_str(config_options_t *config, char *name)
+{
+	return get_value(config, name);
+}
+
+uint32_t get_config_u32(config_options_t *config, char *name)
+{
+	void *value = get_value(config, name);
+	if (value)
+		return *(uint32_t *)value;
+	return 0;
+}
+
+uint8_t get_config_bool(config_options_t *config, char *name)
+{
+	void *value = get_value(config, name);
+	if (value)
+		return *(uint8_t *)value;
+	return 0;
+}
+
+uint64_t get_config_u64(config_options_t *config, char *name)
+{
+	void *value = get_value(config, name);
+	if (value)
+		return *(uint64_t *)value;
+	return 0;
+}
+
+double get_config_double(config_options_t *config, char *name)
+{
+	void *value = get_value(config, name);
+	if (value)
+		return *(double *)value;
+	return 0;
+}
+
+static profile_config_t *parse(FILE *f)
+{
+	char *buf;
+	profile_config_t *profile_conf;
+	container_t *tmp_container;
+
+	profile_conf = malloc(sizeof(profile_config_t));
+	profile_conf->global = malloc(sizeof(global_options));
+	memcpy(profile_conf->global, global_options, sizeof(global_options));
+	profile_conf->fs_container = NULL;
+	profile_conf->tg_container = NULL;
+	int is_option;
+	buf = get_next_line(f);
+
+	while (buf) {
+		is_option = set_option(buf, profile_conf->global);
+		tmp_container = search_group(buf, f);
+		if (tmp_container)
+			switch (tmp_container->type) {
+			case FILESYSTEM:
+				if (profile_conf->fs_container == NULL)
+					profile_conf->fs_container = tmp_container;
+				else
+					insert_container(profile_conf->fs_container,
+							 tmp_container);
+				break;
+			case THREAD_GROUP:
+				if (profile_conf->tg_container == NULL)
+					profile_conf->tg_container = tmp_container;
+				else
+					insert_container(profile_conf->tg_container,
+							 tmp_container);
+				break;
+			default:
+				break;
+			}
+		if (!is_option && !tmp_container) {
+			printf("ERROR!!! Unknow option: %s", buf);
+			exit(1);
+		}
+		buf = get_next_line(f);
+	}
+	return profile_conf;
+}
+
+void set_weight(ffsb_tg_t *tg, config_options_t *config)
+{
+	char *op;
+	int len;
+	config_options_t *tmp_config = config;
+
+	while (tmp_config->name) {
+		if (tmp_config->type == TYPE_WEIGHT) {
+			len = strlen(tmp_config->name);
+			op = malloc(sizeof(char) * len - 6);
+			memset(op, 0, sizeof(char) * len - 6);
+			strncpy (op, tmp_config->name, len - 7);
+			tg_set_op_weight(tg, op,
+					 get_config_u32(config,
+							tmp_config->name));
+			free(op);
+		}
+		tmp_config++;
+	}
+}
+
+int get_weight_total(ffsb_tg_t *tg)
+{
+	char *op;
+	int len;
+	int total = 0;
+	config_options_t *tmp_config = tg_options;
+
+	while (tmp_config->name) {
+		if (tmp_config->type == TYPE_WEIGHT) {
+			len = strlen(tmp_config->name);
+			op = malloc(sizeof(char) * len - 6);
+			memset(op, 0, sizeof(char) * len - 6);
+			strncpy (op, tmp_config->name, len - 7);
+			total += tg_get_op_weight(tg, op);
+			free(op);
+		}
+		tmp_config++;
+	}
+	return total;
+}
+
+/* !!! hackish verification function, we should somehow roll this into the */
+/* op descriptions/struct themselves at some point with a callback verify */
+/* op requirements: */
+/* require tg->read_blocksize:  read, readall */
+/* require tg->write_blocksize: write, create, append, rewritefsync */
+/* */
+
+static int verify_tg(ffsb_tg_t *tg)
+{
+	uint32_t read_weight    = tg_get_op_weight(tg, "read");
+	uint32_t readall_weight = tg_get_op_weight(tg, "readall");
+	uint32_t write_weight   = tg_get_op_weight(tg, "write");
+	uint32_t create_weight  = tg_get_op_weight(tg, "create");
+	uint32_t append_weight  = tg_get_op_weight(tg, "append");
+	uint32_t createdir_weight = tg_get_op_weight(tg, "createdir");
+	uint32_t delete_weight    = tg_get_op_weight(tg, "delete");
+	uint32_t writeall_weight = tg_get_op_weight(tg, "writeall");
+	uint32_t writeall_fsync_weight = tg_get_op_weight(tg, "writeall_fsync");
+
+	uint32_t sum_weight = get_weight_total(tg);
+
+	uint32_t read_blocksize  = tg_get_read_blocksize(tg);
+	uint32_t write_blocksize = tg_get_write_blocksize(tg);
+
+	int read_random          = tg_get_read_random(tg);
+	int read_skip            = tg_get_read_skip(tg);
+	uint32_t read_skipsize   = tg_get_read_skipsize(tg);
+
+	if (sum_weight == 0) {
+		printf("Error: A threadgroup must have at least one weighted "
+		       "operation\n");
+		return 1;
+	}
+
+	if ((read_weight || readall_weight) && !(read_blocksize)) {
+		printf("Error: read and readall operations require a "
+		       "read_blocksize\n");
+		return 1;
+	}
+
+	if ((write_weight || create_weight || append_weight || writeall_weight
+	     || writeall_fsync_weight) && !(write_blocksize)) {
+		printf("Error: write, writeall, create, append"
+		       "operations require a write_blocksize\n");
+		return 1;
+	}
+
+	if (read_random && read_skip) {
+		printf("Error: read_random and read_skip are mutually "
+		       "exclusive\n");
+		return 1;
+	}
+
+	if (read_skip && !(read_skipsize)) {
+		printf("Error: read_skip specified but read_skipsize is "
+		       "zero\n");
+		return 1;
+	}
+
+	return 0;
+}
+
+static unsigned get_num_containers(container_t *container)
+{
+	int numtg = 0;
+	while (container) {
+		numtg++;
+		container = container->next;
+	}
+	return numtg;
+}
+
+static unsigned get_num_threadgroups(profile_config_t *profile_conf)
+{
+	return get_num_containers(profile_conf->tg_container);
+}
+
+static unsigned get_num_filesystems(profile_config_t *profile_conf)
+{
+	return get_num_containers(profile_conf->fs_container);
+}
+
+static int get_num_totalthreads(profile_config_t *profile_conf)
+{
+	int num_threads = 0;
+	container_t *tg = profile_conf->tg_container;
+	config_options_t *tg_config;
+
+	while (tg) {
+		tg_config = tg->config;
+		while (tg_config->name) {
+			if (!strcmp(tg_config->name, "num_threads"))
+				num_threads += *(uint32_t *) tg_config->value;
+			tg_config++;
+		}
+		if (tg->next)
+			tg = tg->next;
+		else
+			break;
+	}
+
+	return num_threads;
+}
+
+container_t *get_container(container_t *head_cont, int pos)
+{
+	int count = 0;
+	while (head_cont) {
+		if (count == pos)
+			return head_cont;
+		head_cont = head_cont->next;
+		count++;
+	}
+	return NULL;
+}
+
+config_options_t *get_fs_config(ffsb_config_t *fc, int pos)
+{
+	container_t *tmp_cont;
+
+	assert(pos < fc->num_filesys);
+	tmp_cont = get_container(fc->profile_conf->fs_container, pos);
+	if (tmp_cont)
+		return tmp_cont->config;
+	return NULL;
+}
+
+container_t *get_fs_container(ffsb_config_t *fc, int pos)
+{
+	assert(pos < fc->num_filesys);
+	return get_container(fc->profile_conf->fs_container, pos);
+}
+
+config_options_t *get_tg_config(ffsb_config_t *fc, int pos)
+{
+	container_t *tmp_cont;
+
+	assert(pos < fc->num_threadgroups);
+	tmp_cont = get_container(fc->profile_conf->tg_container, pos);
+	if (tmp_cont)
+		return tmp_cont->config;
+	return NULL;
+}
+
+container_t *get_tg_container(ffsb_config_t *fc, int pos)
+{
+	assert(pos < fc->num_threadgroups);
+	return get_container(fc->profile_conf->tg_container, pos);
+}
+
+static void init_threadgroup(ffsb_config_t *fc, config_options_t *config,
+			    ffsb_tg_t *tg, int tg_num)
+{
+	int num_threads;
+	memset(tg, 0, sizeof(ffsb_tg_t));
+
+	num_threads = get_config_u32(config, "num_threads");
+
+	init_ffsb_tg(tg, num_threads, tg_num);
+
+	if (get_config_str(config, "bindfs")) {
+		int i;
+		config_options_t *tmp_config;
+		for (i = 0; i < fc->num_filesys; i++) {
+			tmp_config = get_fs_config(fc, i);
+			if (!strcmp(get_config_str(config, "bindfs"),
+				    get_config_str(tmp_config, "location")))
+				break;
+		}
+		if (strcmp(get_config_str(config, "bindfs"),
+			   get_config_str(tmp_config, "location"))) {
+			printf ("Bind fs failed:  Base fs \"%s\" not found\n",
+				get_config_str(config, "bindfs"));
+			exit(1);
+		}
+		printf("%d\n", i);
+		tg->bindfs = i;
+	}
+
+	tg->read_random = get_config_bool(config, "read_random");
+	tg->read_size = get_config_u64(config, "read_size");
+	tg->read_skip = get_config_bool(config, "read_skip");
+	tg->read_skipsize = get_config_u32(config, "read_skipsize");
+
+	tg->write_random = get_config_bool(config, "write_random");
+	tg->write_size = get_config_u64(config, "write_size");
+	tg->fsync_file = get_config_bool(config, "fsync_file");
+
+	tg->wait_time = get_config_u32(config, "op_delay");
+
+	tg_set_read_blocksize(tg, get_config_u32(config, "read_blocksize"));
+	tg_set_write_blocksize(tg, get_config_u32(config, "write_blocksize"));
+
+	set_weight(tg, config);
+
+	if (verify_tg(tg)) {
+		printf("threadgroup %d verification failed\n", tg_num);
+		exit(1);
+	}
+}
+
+static void init_filesys(ffsb_config_t *fc, int num)
+{
+	config_options_t *config = get_fs_config(fc, num);
+	profile_config_t *profile_conf = fc->profile_conf;
+	ffsb_fs_t *fs = &fc->filesystems[num];
+	value_list_t *tmp_list, *list_head;
+
+	memset(fs, 0, sizeof(ffsb_fs_t));
+
+	fs->basedir = get_config_str(config, "location");
+
+	if (get_config_str(config, "clone")) {
+		int i;
+		config_options_t *tmp_config;
+		for (i = 0; i < fc->num_filesys; i++) {
+			tmp_config = get_fs_config(fc, i);
+			if (!strcmp(get_config_str(config, "clone"),
+				    get_config_str(tmp_config, "location")))
+				break;
+		}
+		if (strcmp(get_config_str(config, "clone"),
+			   get_config_str(tmp_config, "location"))) {
+			printf ("Clone fs failed:  Base fs \"%s\" not found\n",
+				get_config_str(config, "clone"));
+			exit(1);
+		}
+		config = tmp_config;
+	}
+
+	fs->num_dirs = get_config_u32(config, "num_dirs");
+	fs->num_start_files = get_config_u32(config, "num_files");
+	fs->minfilesize = get_config_u64(config, "min_filesize");
+	fs->maxfilesize = get_config_u64(config, "max_filesize");
+	fs->desired_fsutil = get_config_double(config, "desired_util");
+	fs->init_fsutil = get_config_double(config, "init_util");
+	fs->init_size = get_config_u64(config, "init_size");
+
+	fs->flags = 0;
+	if (get_config_bool(config, "reuse"))
+		fs->flags |= FFSB_FS_REUSE_FS;
+
+	if (get_config_bool(profile_conf->global, "directio"))
+		fs->flags |= FFSB_FS_DIRECTIO | FFSB_FS_ALIGNIO4K;
+
+	if (get_config_bool(profile_conf->global, "bufferio"))
+		fs->flags |= FFSB_FS_LIBCIO;
+
+	if (get_config_bool(profile_conf->global, "alignio"))
+		fs->flags |= FFSB_FS_ALIGNIO4K;
+
+	if (get_config_bool(config, "agefs")) {
+		container_t *age_cont = get_fs_container(fc, num);
+		if (!age_cont->child) {
+			printf("No age threaggroup in profile");
+			exit(1);
+		}
+
+		age_cont = age_cont->child;
+		ffsb_tg_t *age_tg = ffsb_malloc(sizeof(ffsb_tg_t));
+		init_threadgroup(fc, age_cont->config, age_tg, 0);
+		fs->aging_tg = age_tg;
+		fs->age_fs = 1;
+	}
+
+	if (get_config_u32(config, "create_blocksize"))
+		fs->create_blocksize = get_config_u32(config,
+							"create_blocksize");
+	else
+		fs->create_blocksize = FFSB_FS_DEFAULT_CREATE_BLOCKSIZE;
+
+	if (get_config_u32(config, "age_blocksize"))
+		fs->age_blocksize = get_config_u32(config, "age_blocksize");
+	else
+		fs->age_blocksize = FFSB_FS_DEFAULT_AGE_BLOCKSIZE;
+
+	list_head = (value_list_t *) get_value(config, "size_weight");
+	if (list_head) {
+		int count = 0;
+		size_weight_t *sizew;
+		list_for_each_entry(tmp_list, &list_head->list, list)
+			count++;
+
+		fs->num_weights=count;
+		fs->size_weights = malloc(sizeof(size_weight_t) * fs->num_weights);
+
+		count = 0;
+		list_for_each_entry(tmp_list, &list_head->list, list) {
+			sizew = (size_weight_t *)tmp_list->value;
+			fs->size_weights[count].size = sizew->size;
+			fs->size_weights[count].weight = sizew->weight;
+			fs->sum_weights += sizew->weight;
+			count++;
+		}
+	}
+}
+
+static void init_tg_stats(ffsb_config_t *fc, int num)
+{
+	config_options_t *config;
+	container_t *tmp_cont;
+	value_list_t *tmp_list, *list_head;
+	syscall_t sys;
+	ffsb_statsc_t fsc = { 0, };
+	char *sys_name;
+	range_t *bucket_range;
+	uint32_t min, max;
+
+	tmp_cont = get_tg_container(fc, num);
+	if (tmp_cont->child) {
+		tmp_cont = tmp_cont->child;
+		if (tmp_cont->type == STATS) {
+			config = tmp_cont->config;
+			if (get_config_bool(config, "enable_stats")) {
+
+				list_head = (value_list_t *) get_value(config, "ignore");
+				if (list_head)
+					list_for_each_entry(tmp_list,
+							    &list_head->list, list) {
+						sys_name = (char *)tmp_list->value;
+						ffsb_stats_str2syscall(sys_name, &sys);
+						ffsb_statsc_ignore_sys(&fsc, sys);
+					}
+
+				list_head = (value_list_t *) get_value(config, "msec_range");
+				if (list_head && get_config_bool(config, "enable_range"))
+					list_for_each_entry(tmp_list,
+							    &list_head->list, list) {
+						bucket_range = (range_t *)tmp_list->value;
+						min = (uint32_t)(bucket_range->a * 1000.0f);
+						max = (uint32_t)(bucket_range->b * 1000.0f);
+						ffsb_statsc_addbucket(&fsc, min, max);
+					}
+
+				tg_set_statsc(&fc->groups[num], &fsc);
+			}
+		}
+	}
+}
+
+static void init_config(ffsb_config_t *fc, profile_config_t *profile_conf)
+{
+	config_options_t *config;
+	container_t *tmp_cont;
+	int i;
+
+	fc->time = get_config_u32(profile_conf->global, "time");
+	fc->num_filesys = get_num_filesystems(profile_conf);
+	fc->num_threadgroups = get_num_threadgroups(profile_conf);
+	fc->num_totalthreads = get_num_totalthreads(profile_conf);
+	fc->profile_conf = profile_conf;
+	fc->callout = get_config_str(profile_conf->global, "callout");
+
+	fc->filesystems = ffsb_malloc(sizeof(ffsb_fs_t) * fc->num_filesys);
+	for (i = 0; i < fc->num_filesys; i++)
+		init_filesys(fc, i);
+
+	fc->groups = ffsb_malloc(sizeof(ffsb_tg_t) * fc->num_threadgroups);
+	for (i = 0; i < fc->num_threadgroups; i++) {
+		config = get_tg_config(fc, i);
+		init_threadgroup(fc, config, &fc->groups[i], i);
+		init_tg_stats(fc, i);
+	}
+}
+
+void ffsb_parse_newconfig(ffsb_config_t *fc, char *filename)
+{
+	FILE *f;
+
+	profile_config_t *profile_conf;
+
+	f = fopen(filename, "r");
+	if (f == NULL) {
+		perror(filename);
+		exit(1);
+	}
+	profile_conf = parse(f);
+	fclose(f);
+
+	init_config(fc, profile_conf);
+}
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/parser.h b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/parser.h
new file mode 100644
index 0000000..3df4ffe
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/parser.h
@@ -0,0 +1,151 @@
+/*
+ *   Copyright (c) International Business Machines Corp., 2001-2004
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+#ifndef _PARSER_H_
+#define _PARSER_H_
+
+#include "ffsb.h"
+#include "list.h"
+
+#define COMMENT_CHAR	'#'
+
+#define STORE_SINGLE		0x0001
+#define STORE_LIST		0x0002
+
+#define TYPE_U32		0x0001
+#define	TYPE_U64		0x0002
+#define TYPE_STRING		0x0004
+#define TYPE_BOOLEAN		0x0008
+#define TYPE_DOUBLE		0x0010
+#define TYPE_RANGE		0x0020
+#define TYPE_SIZEWEIGHT		0x0040
+#define TYPE_DEPRECATED		0x0080
+#define TYPE_WEIGHT		0x0100
+#define TYPE_SIZE32		0x0200
+#define TYPE_SIZE64		0x0400
+
+#define ROOT			0x0001
+#define THREAD_GROUP		0x0002
+#define FILESYSTEM		0x0004
+#define END			0x0008
+#define STATS			0x0010
+
+#define GLOBAL_OPTIONS {						\
+	{"num_filesystems", NULL, TYPE_DEPRECATED, STORE_SINGLE},	\
+	{"num_threadgroups", NULL, TYPE_DEPRECATED, STORE_SINGLE},	\
+	{"verbose", NULL, TYPE_BOOLEAN, STORE_SINGLE},			\
+	{"time", NULL, TYPE_U32, STORE_SINGLE},				\
+	{"directio", NULL, TYPE_BOOLEAN, STORE_SINGLE},			\
+	{"bufferio", NULL, TYPE_BOOLEAN, STORE_SINGLE},			\
+	{"alignio", NULL, TYPE_BOOLEAN, STORE_SINGLE},			\
+	{"callout", NULL, TYPE_STRING, STORE_SINGLE},			\
+	{NULL, NULL, 0, 0} }
+
+#define THREADGROUP_OPTIONS {						\
+	{"bindfs", NULL, TYPE_STRING, STORE_SINGLE},			\
+	{"num_threads", NULL, TYPE_U32, STORE_SINGLE},			\
+	{"read_weight", NULL, TYPE_WEIGHT, STORE_SINGLE},		\
+	{"readall_weight", NULL, TYPE_WEIGHT, STORE_SINGLE},		\
+	{"read_random", NULL, TYPE_BOOLEAN, STORE_SINGLE},		\
+	{"read_skip", NULL, TYPE_U32, STORE_SINGLE},			\
+	{"read_size", NULL, TYPE_SIZE64, STORE_SINGLE},			\
+	{"read_blocksize", NULL, TYPE_SIZE32, STORE_SINGLE},		\
+	{"read_skipsize", NULL, TYPE_SIZE32, STORE_SINGLE},		\
+	{"write_weight", NULL, TYPE_WEIGHT, STORE_SINGLE},		\
+	{"write_fsync_weight", NULL, TYPE_WEIGHT, STORE_SINGLE},	\
+	{"write_random", NULL, TYPE_BOOLEAN, STORE_SINGLE},		\
+	{"fsync_file", NULL, TYPE_DEPRECATED, STORE_SINGLE},		\
+	{"write_size", NULL, TYPE_SIZE64, STORE_SINGLE},		\
+	{"write_blocksize", NULL, TYPE_SIZE32, STORE_SINGLE},		\
+	{"create_weight", NULL, TYPE_WEIGHT, STORE_SINGLE},		\
+	{"create_fsync_weight", NULL, TYPE_WEIGHT, STORE_SINGLE},	\
+	{"delete_weight", NULL, TYPE_WEIGHT, STORE_SINGLE},		\
+	{"append_weight", NULL, TYPE_WEIGHT, STORE_SINGLE},		\
+	{"append_fsync_weight", NULL, TYPE_WEIGHT, STORE_SINGLE},	\
+	{"metaop_weight", NULL, TYPE_WEIGHT, STORE_SINGLE},		\
+	{"createdir_weight", NULL, TYPE_WEIGHT, STORE_SINGLE},		\
+	{"op_delay", NULL, TYPE_U32, STORE_SINGLE},			\
+	{"stat_weight", NULL, TYPE_WEIGHT, STORE_SINGLE},		\
+	{"writeall_weight", NULL, TYPE_WEIGHT, STORE_SINGLE},		\
+	{"writeall_fsync_weight", NULL, TYPE_WEIGHT, STORE_SINGLE},	\
+	{"open_close_weight", NULL, TYPE_WEIGHT, STORE_SINGLE},		\
+	{NULL, NULL, 0} }
+
+#define FILESYSTEM_OPTIONS {						\
+	{"location", NULL, TYPE_STRING, STORE_SINGLE},			\
+	{"num_files", NULL, TYPE_U32, STORE_SINGLE},			\
+	{"num_dirs", NULL, TYPE_U32, STORE_SINGLE},			\
+	{"reuse", NULL, TYPE_BOOLEAN, STORE_SINGLE},			\
+	{"min_filesize", NULL, TYPE_SIZE64, STORE_SINGLE},		\
+	{"max_filesize", NULL, TYPE_SIZE64, STORE_SINGLE},		\
+	{"create_blocksize", NULL, TYPE_SIZE32, STORE_SINGLE},		\
+	{"age_blocksize", NULL, TYPE_SIZE32, STORE_SINGLE},		\
+	{"desired_util", NULL, TYPE_DOUBLE, STORE_SINGLE},		\
+	{"agefs", NULL, TYPE_BOOLEAN, STORE_SINGLE},			\
+	{"size_weight", NULL, TYPE_SIZEWEIGHT, STORE_LIST},		\
+	{"init_util", NULL, TYPE_DOUBLE, STORE_SINGLE},			\
+	{"init_size", NULL, TYPE_SIZE64, STORE_SINGLE},			\
+	{"clone", NULL, TYPE_STRING, STORE_SINGLE},			\
+	{NULL, NULL, 0} }
+
+#define STATS_OPTIONS {							\
+	{"enable_stats", NULL, TYPE_BOOLEAN, STORE_SINGLE},		\
+	{"enable_range", NULL, TYPE_BOOLEAN, STORE_SINGLE},		\
+	{"ignore", NULL, TYPE_STRING, STORE_LIST},			\
+	{"msec_range", NULL, TYPE_RANGE, STORE_LIST},			\
+	{NULL, NULL, 0} }
+
+#define CONTAINER_DESC {				\
+	{"filesystem", FILESYSTEM, 10},			\
+	{"threadgroup", THREAD_GROUP, 11},		\
+	{"end", END, 3},				\
+	{"stats", STATS, 5},				\
+	{NULL, 0, 0} }
+
+typedef struct container {
+	struct config_options *config;
+	uint32_t type;
+	struct container *child;
+	struct container *next;
+} container_t;
+
+typedef struct config_options {
+	char *name;
+	void *value;
+	int type;
+	int storage_type;
+} config_options_t;
+
+typedef struct container_desc {
+	char *name;
+	uint16_t type;
+	uint16_t size;
+} container_desc_t;
+
+typedef struct range {
+	double a;
+	double b;
+} range_t;
+
+typedef struct value_list {
+	void *value;
+	struct list_head list;
+} value_list_t;
+
+void ffsb_parse_newconfig(ffsb_config_t *fc, char *filename);
+
+#endif
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/public-description b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/public-description
new file mode 100644
index 0000000..f770dd0
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/public-description
@@ -0,0 +1,4 @@
+The Flexible Filesystem Benchmark (FFSB) is a filesystem performance
+measurement tool.  It uses customizable profiles to measure of different
+workloads, and it supports multiple groups of threads across multiple
+filesystems.
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/rand.c b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/rand.c
new file mode 100644
index 0000000..b8c4a2c
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/rand.c
@@ -0,0 +1,188 @@
+/*
+ *   Copyright (c) International Business Machines Corp., 2001-2004
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+#include <stdlib.h>
+#include <stdio.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/time.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <limits.h>
+#include <inttypes.h>
+#include <assert.h>
+
+#include "config.h"
+#include "rand.h"
+#include "util.h"
+
+#define RANDSRC "/dev/urandom"
+
+static int randfd = -1;
+
+/* close the file after we're done with the benchmark */
+void randcleanup(void)
+{
+	if (randfd > 0)
+		close(randfd);
+}
+
+/* We fill up the array with random bits from RANDSRC here and set index */
+/* to 0 */
+/* pre: state->size must be set and state->mt must be allocated! */
+static void sgenrand(randdata_t *state)
+{
+	int got = 0;
+	got = read(randfd, state->mt, state->size);
+	if (got != state->size) {
+		int i ;
+		/* fall back on lrand48 */
+		/* printf("fallback_rand\n"); */
+
+		for (i = got ; i < state->size ; i += 4) {
+			long int  rand = 0;
+#ifdef HAVE_LRAND48
+			lrand48_r(&(state->data), &rand);
+#else
+			rand = random();
+#endif
+			assert(rand != 0);
+			state->mt[i]   = (rand >> 24) & (512 - 1);
+			state->mt[i+1] = (rand >> 16) & (512 - 1);
+			state->mt[i+2] = (rand >>  8) & (512 - 1);
+			state->mt[i+3] = (rand) & (512 - 1);
+		}
+
+	}
+	state->mti = 0;
+}
+
+/* returns 8 random bits */
+static uint8_t genrand8(randdata_t *state)
+{
+	unsigned long ret = 0;
+	if (state->mti >= state->size) {
+/*		sgenrand(state); */
+		state->mti = 0;
+	}
+	ret = state->mt[state->mti];
+	state->mti++;
+	return ret;
+}
+
+/* returns 32 random bits */
+static uint32_t genrand32(randdata_t *state)
+{
+	uint8_t bytes[4];
+	uint32_t ret = 0;
+
+	bytes[0] = genrand8(state);
+	bytes[1] = genrand8(state);
+	bytes[2] = genrand8(state);
+	bytes[3] = genrand8(state);
+
+	ret = *((uint32_t *)bytes); /* !!! hack */
+	return ret;
+}
+
+void init_random(randdata_t *state, uint32_t iter)
+{
+	struct timeval time;
+	if (iter == 0)
+		state->size = MIN_RANDBUF_SIZE * AVG_ITR_RNDBTS;
+	else if (iter > MAX_RANDBUF_SIZE)
+		state->size = MAX_RANDBUF_SIZE * AVG_ITR_RNDBTS;
+	else
+		state->size = iter * AVG_ITR_RNDBTS;
+
+	state->mt = ffsb_malloc(state->size);
+
+	/* !!!! racy? add pthread_once stuff later  */
+	if ((randfd < 0) && (randfd = open(RANDSRC, O_RDONLY)) < 0) {
+		perror("open " RANDSRC);
+		exit(1);
+	}
+	sgenrand(state);
+	gettimeofday(&time, NULL);
+#ifdef HAVE_LRAND48
+	srand48_r(time.tv_sec, &state->data);
+#endif
+}
+
+void destroy_random(randdata_t *rd)
+{
+	free(rd->mt);
+}
+
+/*
+ * I've taken the liberty of slightly redesigning this stuff.
+ * Instead of simply getting the full word of random bits
+ * and throwing away most of it using the mod operator,
+ * we should only get byte-sized chunks of random bits and
+ * construct our random number that way with less wasteage - SR
+ */
+uint32_t getrandom(randdata_t *state, uint32_t mod)
+{
+
+    uint8_t bytes[4] = { 0, 0, 0, 0 };
+    uint32_t ret;
+    int num_bytes = 4;
+    int i;
+
+    if ((mod == 0) || (mod == 1))
+	    return 0;
+
+    if (!(mod >> 8))
+	    num_bytes = 1;
+    else if (!(mod >> 16))
+	    num_bytes = 2;
+    else if (!(mod >> 24))
+	    num_bytes = 3;
+
+    for (i = 0; i < num_bytes; i++)
+	    bytes[i] = genrand8(state);
+
+    ret = (bytes[3] << 24) + (bytes[2] << 16) + (bytes[1] << 8) + bytes[0];
+
+    return ret % mod;
+}
+
+uint64_t getllrandom(randdata_t *state, uint64_t mod)
+{
+	uint64_t result = 0;
+	uint64_t high   = 0;
+	uint32_t low    = 0;
+
+	if (mod == 0)
+		return 0;
+
+	/* ULONG_MAX comes from limits.h */
+	if (mod < ULONG_MAX)
+		return (uint64_t)getrandom(state, (uint32_t)mod);
+
+	high = genrand32(state);
+
+	low  = genrand32(state);
+
+	result = high << 32;
+	result |= (uint64_t)low;
+
+	assert(result != 0);
+	assert(result > 0);
+
+	return result % mod;
+}
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/rand.h b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/rand.h
new file mode 100644
index 0000000..1321551
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/rand.h
@@ -0,0 +1,60 @@
+/*
+ *   Copyright (c) International Business Machines Corp., 2001-2004
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+#ifndef _MTINT_H_
+#define _MTINT_H_
+
+#include "config.h"
+
+#include <stdlib.h>
+#include <sys/types.h>
+#include <inttypes.h>
+
+/* A guess of how many random bytes (not bits) */
+/* will be consumed per iteration */
+/* This is multiplied by the iteration count */
+/* to get the size of the array in init_random() */
+#define AVG_ITR_RNDBTS 2
+
+/* Set a cap on the size of the array, note this */
+/* is multiplied by AVG_ITR_RNDBTS */
+#define MAX_RANDBUF_SIZE (10 * 1024)
+
+#define MIN_RANDBUF_SIZE 1024
+
+
+typedef struct randdata {
+	int size;
+	uint8_t *mt; /* the array of random bits  */
+	int mti; /* mti==N+1 means mt[N] is not initialized */
+
+	/* fallback random source, lrand48_r() */
+#ifdef HAVE_LRAND48_R
+	struct drand48_data data;
+#endif
+} randdata_t;
+
+uint32_t getrandom(randdata_t *rd, uint32_t mod);
+uint64_t getllrandom(randdata_t *rd, uint64_t mod);
+
+/* pass in thread-local state, and est. number of "uses" */
+/* pass in 0 for size if size is unknown/not important */
+void init_random(randdata_t *state, uint32_t size);
+void destroy_random(randdata_t *rd);
+void randcleanup(void);
+
+#endif
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/rbt.c b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/rbt.c
new file mode 100644
index 0000000..b8147f3
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/rbt.c
@@ -0,0 +1,1040 @@
+/*
+ *   Copyright (c) International Business Machines Corp., 2001-2004
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <assert.h>
+#include "rbt.h"
+
+/*
+ * ***********************************************
+ *
+ * D.H. IBM, S. Rao
+ *
+ * Module: Operations executed on red-black struct
+ *
+ * ***********************************************
+ */
+
+/* Construct a red-black tree node */
+
+rb_node *rbnode_construct(datatype object, rb_color color)
+{
+	rb_node *node = (rb_node *) malloc(sizeof(rb_node));
+	if (!node) {
+		fprintf(stderr, "Memory Shortage - No Execution Possible\n");
+		return NULL;
+	}
+	node->object = object;
+	node->color = color;
+	node->parent = node->right = node->left = NULL;
+	return node;
+}
+
+/* Destructor of a red-black tree node */
+
+void rbnode_destruct(rb_node *node, destructor d)
+{
+	if (!node)
+		return;
+	if (d != NULL)
+		d(node->object);
+	rbnode_destruct(node->right, d);
+	rbnode_destruct(node->left, d);
+	free(node);
+}
+
+/* Determine the depth of the subtree spanned by a given node */
+
+int rbnode_depth(rb_node *node)
+{
+	/* Recursively determine the depth of the left and right
+	 * subtrees
+	 */
+	int  irightdepth = (node->right) ? rbnode_depth(node->right) : 0;
+	int  ileftdepth = (node->left) ? rbnode_depth(node->left) : 0;
+
+	/* Return the maximal child depth + 1 (the current node) */
+	return ((irightdepth > ileftdepth) ? (irightdepth + 1) : (ileftdepth + 1));
+}
+
+/* Return the leftmost leaf in the tree */
+
+rb_node *rbnode_minimum(rb_node *node)
+{
+	while (node->left)
+		node = node->left;
+	return node;
+}
+
+/* Return the rightmost leaf in the tree */
+
+rb_node *rbnode_maximum(rb_node *node)
+{
+	while (node->right)
+		node = node->right;
+	return node;
+}
+
+/* Replace an object */
+
+void rbnode_replace(rb_node *node, datatype object)
+{
+	/* Make sure the replacement does not violate the tree order
+	 * Replace the object at the node
+	 */
+	node->object = object;
+}
+
+/* Get the next node in the tree (according to the tree order) */
+
+rb_node *rbnode_successor(rb_node *node)
+{
+	rb_node *succ_node;
+
+	if (node->right) {
+
+		/* If there is a right child, the successor is the
+		 * minimal object in the sub-tree spanned by this
+		 * child.
+		 */
+
+		succ_node = node->right;
+		while (succ_node->left)
+			succ_node = succ_node->left;
+	} else {
+
+		/* Otherwise, go up the tree until reaching the parent
+		 * from the left direction.
+		 */
+
+		rb_node *prev_node = node;
+		succ_node = node->parent;
+		while (succ_node && prev_node == succ_node->right) {
+			prev_node = succ_node;
+			succ_node = succ_node->parent;
+		}
+	}
+
+	return (succ_node);
+}
+
+/* Get the previous node in the tree (according to the tree order) */
+
+rb_node *rbnode_predecessor(rb_node *node)
+{
+	rb_node *pred_node;
+
+	if (node->left) {
+
+		/* If there is a left child, the predecessor is the
+		 * maximal object in the sub-tree spanned by this
+		 * child.
+		 */
+
+		pred_node = node->left;
+		while (pred_node->right)
+			pred_node = pred_node->right;
+	} else {
+
+		/* Otherwise, go up the tree until reaching the parent
+		 * from the right direction.
+		 */
+
+		rb_node *prev_node = node;
+		pred_node = node->parent;
+		while (pred_node && prev_node == pred_node->left) {
+			prev_node = pred_node;
+			pred_node = pred_node->parent;
+		}
+	}
+
+  return (pred_node);
+}
+
+/* Return a pointer to a duplication of the given node */
+
+rb_node *rbnode_duplicate(rb_node *node)
+{
+	/* Create a node of the same color, containing the same
+	 * object
+	 */
+	rb_node *dup_node = rbnode_construct(node->object, node->color);
+	if (!dup_node)
+		return NULL;
+
+	/* Duplicate the children recursively */
+	if (node->right) {
+		dup_node->right = rbnode_duplicate(node->right);
+		dup_node->right->parent = dup_node;
+	} else {
+		dup_node->right = NULL;
+	}
+
+	if (node->left) {
+		dup_node->left = rbnode_duplicate(node->left);
+		dup_node->left->parent = dup_node;
+	} else {
+		dup_node->left = NULL;
+	}
+
+	return dup_node; /* Return the duplicated node */
+}
+
+/* Traverse a red-black subtree */
+
+void rbnode_traverse(rb_node *node, opr *op)
+{
+	if (!node)
+		return;
+	rbnode_traverse(node->left, op);
+	op(node->object);
+	rbnode_traverse(node->right, op);
+}
+
+/*
+ * ***********************************
+ *
+ * Operations on rb_tree struct
+ *
+ * ***********************************
+ */
+
+/* Intialize a tree */
+void rbtree_init(rb_tree *tree)
+{
+/*   tree->comp = comp; */
+	tree->isize = 0;
+	tree->root = NULL;
+}
+
+/* Construct a tree given a comparison function */
+
+rb_tree *rbtree_construct()
+{
+	rb_tree *tree = (rb_tree *) malloc(sizeof(rb_tree));
+	if (!tree) {
+		fprintf(stderr, "Memory Issue - Shortge Exists!\n");
+		return NULL;
+	}
+	rbtree_init(tree);
+	return tree;
+}
+
+/* Remove all objects from a black-red tree */
+
+void rbtree_clean(rb_tree *tree, destructor d)
+{
+	if (tree->root)
+		rbnode_destruct(tree->root, d);
+	tree->root = NULL;
+	tree->isize = 0;
+}
+
+/* Destruct a red-black tree */
+
+void rbtree_destruct(rb_tree *tree, destructor d)
+{
+	rbtree_clean(tree, d);
+	free(tree);
+}
+
+/* Returns the size of the tree */
+
+int rbtree_size(rb_tree *tree)
+{
+	return tree->isize;
+}
+
+/* Returns the depth of the tree */
+
+int rbtree_depth(rb_tree *tree)
+{
+	if (!(tree->root))
+		return 0;
+	return rbnode_depth(tree->root);
+}
+
+/* Check whether the tree contains a certain object */
+
+int rbtree_contains(rb_tree *tree, datatype object)
+{
+	return (rbtree_find(tree, object) != NULL);
+}
+
+/* Insert an object into the rb-tree */
+
+rb_node *rbtree_insert(rb_tree *tree, datatype object)
+{
+	rb_node *cur_node;
+	rb_node *new_node;
+	int comp_result = 0;
+
+	if (!(tree->root)) {
+		/* Assign a new root node (the root is always
+		 * black)
+		 */
+		new_node = rbnode_construct(object, black);
+		if (!new_node)
+			return NULL;
+		tree->root = new_node;
+		tree->isize = 1;
+		return new_node;
+	}
+
+	/* Find a spot for the new object, insert the object as a red
+	 * leaf
+	 */
+
+	cur_node = tree->root;
+	new_node = rbnode_construct(object, red);
+	if (!new_node)
+		return NULL;
+
+	while (cur_node) {
+		/* Compare inserted object with the object stored in
+		 * the current node
+		 */
+		comp_result = COMP_NODES(object, cur_node->object);
+		if (comp_result == 0) {
+			printf("Attempted to insert duplicate node, aborting\n");
+			free(new_node);
+			return NULL;
+		}
+		if (comp_result > 0) {
+			if (!(cur_node->left)) {
+				/* Insert the new leaf as the left
+				 * child of the current node
+				 */
+				cur_node->left = new_node;
+				new_node->parent = cur_node;
+				cur_node = NULL; /* Terminate the while loop */
+			} else {
+				 /* Go to the left subtree */
+				cur_node = cur_node->left;
+			}
+		} else {
+			if (!(cur_node->right)) {
+				/* Insert the new leaf as the right
+				 * child of the current node
+				 */
+				cur_node->right = new_node;
+				new_node->parent = cur_node;
+				cur_node = NULL; /* Terminate the while loop */
+			} else {
+				/* Go to the right subtree */
+				cur_node = cur_node->right;
+			}
+		}
+	}
+
+	/* Mark the fact that a new node was added */
+	tree->isize++;
+
+	/* Fix the tree properties */
+	rbtree_insert_fixup(tree, new_node);
+
+	return new_node;
+}
+
+/* Insert a new object to the tree as the a successor of a given
+ * node
+ */
+
+rb_node *insert_successor_at(rb_tree *tree, rb_node *at_node, datatype object)
+{
+	rb_node *parent;
+	rb_node *new_node;
+
+	if (!(tree->root)) {
+		/* Assign a new root node (the root is always
+		 * black)
+		 */
+		new_node = rbnode_construct(object, black);
+		if (!new_node)
+			return NULL;
+		tree->root = new_node;
+		tree->isize = 1;
+		return new_node;
+	}
+
+	/* Insert the new object as a red leaf, being the successor of
+	 * node
+	 */
+	new_node = rbnode_construct(object, red);
+	if (!new_node)
+		return NULL;
+
+	if (!at_node) {
+		/* The new node should become the tree's minimum Place
+		 * is as the left child of the current minimal leaf
+		*/
+		parent = rbnode_minimum(tree->root);
+		parent->left = new_node;
+	} else {
+		/* Make sure the insertion does not violate the tree
+		 * order In case given node has no right child, place
+		 * the new node as its right child. Otherwise, place
+		 * it at the leftmost position at the sub-tree rooted
+		 * at its right side.
+		 */
+		if (!at_node->right) {
+			parent = at_node;
+			parent->right = new_node;
+		} else {
+			parent = rbnode_minimum(at_node->right);
+			parent->left = new_node;
+		}
+	}
+
+	new_node->parent = parent;
+
+	/* Mark that a new node was added */
+	tree->isize++;
+
+	/* Fix the tree properties */
+	rbtree_insert_fixup(tree, new_node);
+
+	return new_node;
+}
+
+/* Insert a new object to the tree as the a predecessor of a given node */
+
+rb_node *insert_predecessor_at(rb_tree *tree, rb_node *at_node, datatype object)
+{
+	rb_node *parent;
+	rb_node *new_node;
+
+	if (!(tree->root)) {
+		/* Assign a new root node (the root is always
+		 * black)
+		 */
+		new_node = rbnode_construct(object, black);
+		if (!new_node)
+			return NULL;
+		tree->root = new_node;
+		tree->isize = 1;
+		return new_node;
+	}
+
+	/* Insert the new object as a red leaf, being the predecessor
+	 * of at_node
+	 */
+	new_node = rbnode_construct(object, red);
+	if (!new_node)
+		return NULL;
+
+	if (!at_node) {
+		/* The new node should become the tree maximum. Place
+		 * is as the right child of the current maximal leaf
+		 */
+		parent = rbnode_maximum(tree->root);
+		parent->right = new_node;
+	} else {
+		/* Make sure the insertion does not violate the tree
+		 * order In case given node has no left child, place
+		 * the new node as its left child. Otherwise, place it
+		 * at the rightmost position at the sub-tree rooted at
+		 * its left side.
+		 */
+		if (!(at_node->left)) {
+			parent = at_node;
+			parent->left = new_node;
+		} else {
+			parent = rbnode_maximum(at_node->left);
+			parent->right = new_node;
+		}
+	}
+
+	new_node->parent = parent;
+
+	/* Mark that a new node was added */
+	tree->isize++;
+
+	/* Fix the tree properties */
+	rbtree_insert_fixup(tree, new_node);
+
+	return new_node;
+}
+
+/* Remove an object from the tree */
+
+void rbtree_remove(rb_tree *tree, datatype object, destructor d)
+{
+	rb_node *node = rbtree_find(tree, object); /* Find the node */
+	rbtree_remove_at(tree, node, d);           /* Remove the node */
+}
+
+/* Remove the object pointed by the given node. */
+
+void rbtree_remove_at(rb_tree *tree, rb_node *node, destructor d)
+{
+	rb_node *child = NULL;
+
+	/* In case of deleting the single object stored in the tree,
+	 * free the root, thus emptying the tree
+	 */
+	if (tree->isize == 1) {
+		rbnode_destruct(tree->root, d);
+		tree->root = NULL;
+		tree->isize = 0;
+		return;
+	}
+
+	/* Remove the given node from the tree */
+	if (node->left && node->right) {
+		/* If the node we want to remove has two children,
+		 * find its successor, which is the leftmost child in
+		 * its right sub-tree and has at most one child (it
+		 * may have a right child).
+		 */
+		rb_node *succ_node = rbnode_minimum(node->right);
+
+		/* Now physically swap node and its successor. Notice
+		 * this may temporarily violate the tree properties,
+		 * but we are going to remove node anyway.  This way
+		 * we have moved node to a position were it is more
+		 * convinient to delete it.
+		 */
+		int immediate_succ = (node->right == succ_node);
+		rb_node *succ_parent = succ_node->parent;
+		rb_node *succ_left = succ_node->left;
+		rb_node *succ_right = succ_node->right;
+		rb_color succ_color = succ_node->color;
+
+		succ_node->parent = node->parent;
+		succ_node->left = node->left;
+		succ_node->right = immediate_succ ? node : node->right;
+		succ_node->color = node->color;
+
+		node->parent = immediate_succ ? succ_node : succ_parent;
+		node->left = succ_left;
+		node->right = succ_right;
+		node->color = succ_color;
+
+		if (!immediate_succ) {
+			if (succ_node == node->parent->left)
+				node->parent->left = node;
+			else
+				node->parent->right = node;
+		}
+
+		if (node->left)
+			node->left->parent = node;
+		if (node->right)
+			node->right->parent = node;
+
+		if (succ_node->parent) {
+			if (node == succ_node->parent->left)
+				succ_node->parent->left = succ_node;
+			else
+				succ_node->parent->right = succ_node;
+		} else {
+			tree->root = succ_node;
+		}
+
+		if (succ_node->left)
+			succ_node->left->parent = succ_node;
+		if (succ_node->right)
+			succ_node->right->parent = succ_node;
+	}
+
+	/* At this stage, the node we are going to remove has at most
+	 * one child
+	 */
+	child = (node->left) ? node->left : node->right;
+
+	/* Splice out the node to be removed, by linking its parent
+	 * straight to the removed node's single child.
+	 */
+	if (child)
+		child->parent = node->parent;
+
+	if (!(node->parent)) {
+		/* If we are deleting the root, make the child the new
+		 * tree node
+		 */
+		tree->root = child;
+	} else {
+		/* Link the removed node parent to its child */
+		if (node == node->parent->left)
+			node->parent->left = child;
+		else
+			node->parent->right = child;
+	}
+
+	/* Fix-up the red-black properties that may have been damaged:
+	 * If we have just removed a black node, the black-depth
+	 * property is no longer valid
+	 */
+	if (node->color == black && child)
+		rbtree_remove_fixup(tree, child);
+
+	/* Delete the un-necessary node (nullify both its children
+	 * because the node's destructor is recursive).
+	 */
+	node->left = NULL;
+	node->right = NULL;
+	free(node);
+
+	/* Decrease the number of objects in the tree */
+	tree->isize--;
+}
+
+/* Get the tree minimum */
+
+rb_node *rbtree_minimum(rb_tree *tree)
+{
+	if (!(tree->root))
+		return NULL;
+
+	/* Return the leftmost leaf in the tree */
+	return rbnode_minimum(tree->root);
+}
+
+/* Get the tree maximum */
+
+rb_node *rbtree_maximum(rb_tree *tree)
+{
+	if (!(tree->root))
+		return NULL;
+
+	/* Return the rightmost leaf in the tree */
+	return rbnode_maximum(tree->root);
+}
+
+/* Return a pointer to the node containing the given object */
+
+rb_node *rbtree_find(rb_tree *tree, datatype object)
+{
+	rb_node *cur_node = tree->root;
+	int comp_result;
+
+	while (cur_node) {
+		comp_result = COMP_NODES(object, cur_node->object);
+		/* In case of equality, we can return the current
+		 * node.
+		 */
+		if (comp_result == 0)
+			return cur_node;
+		/* Go down to the left or right child. */
+		cur_node = (comp_result > 0) ? cur_node->left : cur_node->right;
+	}
+
+	/* If we get here, the object is not in the tree */
+	return NULL;
+}
+
+void rbtree_rotate_left(rb_tree *tree, rb_node *x_node)
+{
+	/* Get the right child of the node */
+	rb_node *y_node = x_node->right;
+
+	/* Change its left subtree (T2) to x's right subtree */
+	x_node->right = y_node->left;
+
+	/* Link T2 to its new parent x */
+	if (y_node->left != NULL)
+		y_node->left->parent = x_node;
+
+	/* Assign x's parent to be y's parent */
+	y_node->parent = x_node->parent;
+
+	if (!(x_node->parent)) {
+		/* Make y the new tree root */
+		tree->root = y_node;
+	} else  {
+		/* Assign a pointer to y from x's parent */
+		if (x_node == x_node->parent->left)
+			x_node->parent->left = y_node;
+		else
+			x_node->parent->right = y_node;
+	}
+
+	/* Assign x to be y's left child */
+	y_node->left = x_node;
+	x_node->parent = y_node;
+}
+
+/* Right-rotate the sub-tree spanned by the given node */
+
+void rbtree_rotate_right(rb_tree *tree, rb_node *y_node)
+{
+	/* Get the left child of the node */
+	rb_node *x_node = y_node->left;
+
+	/* Change its right subtree (T2) to y's left subtree */
+	y_node->left = x_node->right;
+
+	/* Link T2 to its new parent y */
+	if (x_node->right != NULL)
+		x_node->right->parent = y_node;
+
+	/* Assign y's parent to be x's parent */
+	x_node->parent = y_node->parent;
+
+	if (!(y_node->parent)) {
+		/* Make x the new tree root */
+		tree->root = x_node;
+	} else  {
+		/* Assign a pointer to x from y's parent */
+		if (y_node == y_node->parent->left)
+			y_node->parent->left = x_node;
+		else
+			y_node->parent->right = x_node;
+	}
+
+	/* Assign y to be x's right child */
+	x_node->right = y_node;
+	y_node->parent = x_node;
+}
+
+/* Fix the tree so it maintains the red-black properties after an insert */
+
+void rbtree_insert_fixup(rb_tree *tree, rb_node *node)
+{
+	/* Fix the red-black propreties. We may have inserted a red
+	 * leaf as the child of a red parent - so we have to fix the
+	 * coloring of the parent recursively.
+	 */
+	rb_node *curr_node = node;
+	rb_node *grandparent;
+	rb_node *uncle;
+
+	assert(node && node->color == red);
+
+	while (curr_node != tree->root && curr_node->parent->color == red) {
+		/* Get a pointer to the current node's grandparent
+		 * (the root is always black, so the red parent must
+		 * have a parent).
+		 */
+
+		grandparent = curr_node->parent->parent;
+
+		if (curr_node->parent == grandparent->left) {
+			/* If the red parent is a left child, the
+			* uncle is the right child of the grandparent.
+			*/
+			uncle = grandparent->right;
+
+			if (uncle && uncle->color == red) {
+
+				/* If both parent and uncle are red,
+				 * color them black and color the
+				 * grandparent red. In case of a NULL
+				 * uncle, treat it as a black node
+				 */
+				curr_node->parent->color = black;
+				uncle->color = black;
+				grandparent->color = red;
+
+				/* Move to the grandparent */
+				curr_node = grandparent;
+			} else {
+				/* Make sure the current node is a
+				* right child. If not, left-rotate the
+				* parent's sub-tree so the parent
+				* becomes the right child of the
+				* current node (see _rotate_left).
+				*/
+				if (curr_node == curr_node->parent->right) {
+					curr_node = curr_node->parent;
+					rbtree_rotate_left(tree, curr_node);
+				}
+
+				/* Color the parent black and the
+				 * grandparent red
+				 */
+				curr_node->parent->color = black;
+				grandparent->color = red;
+
+				/* Right-rotate the grandparent's
+				 * sub-tree
+				 */
+				rbtree_rotate_right(tree, grandparent);
+			}
+		} else {
+			/* If the red parent is a right child, the
+			 * uncle is the left child of the grandparent.
+			 */
+			uncle = grandparent->left;
+
+			if (uncle && uncle->color == red) {
+				/* If both parent and uncle are red,
+				 * color them black and color the
+				 * grandparent red. In case of a NULL
+				 * uncle, treat it as a black node
+				 */
+				curr_node->parent->color = black;
+				uncle->color = black;
+				grandparent->color = red;
+
+				/* Move to the grandparent */
+				curr_node = grandparent;
+			} else {
+				/* Make sure the current node is a
+				 * left child. If not, right-rotate
+				 * the parent's sub-tree so the parent
+				 * becomes the left child of the
+				 * current node.
+				*/
+				if (curr_node == curr_node->parent->left) {
+					curr_node = curr_node->parent;
+					rbtree_rotate_right(tree, curr_node);
+				}
+
+				/* Color the parent black and the
+				 * grandparent red
+				 */
+				curr_node->parent->color = black;
+				grandparent->color = red;
+
+				/* Left-rotate the grandparent's
+				 * sub-tree
+				 */
+				rbtree_rotate_left(tree, grandparent);
+			}
+		}
+	}
+
+	/* Make sure that the root is black */
+	tree->root->color = black;
+}
+
+void rbtree_remove_fixup(rb_tree *tree, rb_node *node)
+{
+	rb_node *curr_node = node;
+	rb_node *sibling;
+
+	while (curr_node != tree->root && curr_node->color == black) {
+		/* Get a pointer to the current node's sibling (notice
+		 * that the node's parent must exist, since the node
+		 * is not the root).
+		 */
+		if (curr_node == curr_node->parent->left) {
+			/* If the current node is a left child, its
+			 * sibling is the right child of the parent.
+			 */
+			sibling = curr_node->parent->right;
+
+			/* Check the sibling's color. Notice that NULL
+			 * nodes are treated as if they are colored
+			 * black.
+			 */
+			if (sibling && sibling->color == red) {
+				/* In case the sibling is red, color
+				 * it black and rotate.  Then color
+				 * the parent red (the grandparent is
+				 * now black)
+				 */
+				sibling->color = black;
+				curr_node->parent->color = red;
+				rbtree_rotate_left(tree, curr_node->parent);
+				sibling = curr_node->parent->right;
+			}
+
+			if (sibling &&
+			    (!(sibling->left) || sibling->left->color == black) &&
+			    (!(sibling->right) || sibling->right->color == black)) {
+				/* If the sibling has two black
+				 * children, color it red
+				 */
+				sibling->color = red;
+				if (curr_node->parent->color == red) {
+					/* If the parent is red, we
+					 * can safely color it black
+					 * and terminate the fix
+					 * process.
+					 */
+					curr_node->parent->color = black;
+					/* In order to stop the while loop */
+					curr_node = tree->root;
+				} else {
+					/* The black depth of the
+					* entire sub-tree rooted at
+					* the parent is now too small
+					* - fix it up recursively.
+					 */
+					curr_node = curr_node->parent;
+				}
+			} else {
+				if (!sibling) {
+					/* Take special care of the
+					 * case of a NULL sibling
+					 */
+					if (curr_node->parent->color == red) {
+						curr_node->parent->color = black;
+						/* In order to stop
+						 * the while loop */
+						curr_node = tree->root;
+					} else {
+						curr_node = curr_node->parent;
+					}
+				} else {
+					/* In this case, at least one
+					 * of the sibling's children
+					 * is red.  It is therfore
+					 * obvious that the sibling
+					 * itself is black.
+					 */
+					if (sibling->right && sibling->right->color == red) {
+						/* If the right child
+						 * of the sibling is
+						 * red, color it black
+						 * and rotate around
+						 * the current parent.
+						 */
+						sibling->right->color = black;
+						rbtree_rotate_left(tree, curr_node->parent);
+					} else {
+						/* If the left child
+						 * of the sibling is
+						 * red, rotate around
+						 * the sibling, then
+						 * rotate around the
+						 * new sibling of our
+						 * current node.
+						  */
+						rbtree_rotate_right(tree, sibling);
+						sibling = curr_node->parent->right;
+						rbtree_rotate_left(tree, sibling);
+					}
+
+					/* It is now safe to color the
+					 * parent black and to
+					 * terminate the fix process.
+					 */
+					if (curr_node->parent->parent)
+						curr_node->parent->parent->color = curr_node->parent->color;
+					curr_node->parent->color = black;
+					/* In order to stop the while loop */
+					curr_node = tree->root;
+				}
+			}
+		} else {
+			/* If the current node is a right child, its
+			 * sibling is the left child of the parent.
+			 */
+			sibling = curr_node->parent->left;
+
+			/* Check the sibling's color. Notice that NULL
+			 * nodes are treated as if they are colored
+			 * black.
+			 */
+			if (sibling && sibling->color == red) {
+				/* In case the sibling is red, color
+				 * it black and rotate.  Then color
+				 * the parent red (the grandparent is
+				 * now black).
+				 */
+				sibling->color = black;
+				curr_node->parent->color = red;
+				rbtree_rotate_right(tree, curr_node->parent);
+
+				sibling = curr_node->parent->left;
+			}
+
+			if (sibling &&
+			    (!(sibling->left) || sibling->left->color == black) &&
+			    (!(sibling->right) || sibling->right->color == black)) {
+				/* If the sibling has two black children, color it red */
+				sibling->color = red;
+				if (curr_node->parent->color == red) {
+					/* If the parent is red, we
+					 * can safely color it black
+					 * and terminate the fix-up
+					 * process.
+					 */
+					curr_node->parent->color = black;
+					/* In order to stop the while
+					 * loop
+					 */
+					curr_node = tree->root;
+				} else {
+					/* The black depth of the
+					 * entire sub-tree rooted at
+					 * the parent is now too small
+					 * - fix it up recursively.
+					 */
+					curr_node = curr_node->parent;
+				}
+			} else {
+				if (!sibling) {
+					/* Take special care of the
+					 * case of a NULL sibling */
+					if (curr_node->parent->color == red) {
+						curr_node->parent->color = black;
+						/* In order to stop
+						 * the while loop */
+						curr_node = tree->root;
+					} else {
+						curr_node = curr_node->parent;
+					}
+				} else {
+					/* In this case, at least one
+					* of the sibling's children is
+					* red.  It is therfore obvious
+					* that the sibling itself is
+					* black.
+					*/
+					if (sibling->left && sibling->left->color == red) {
+						/* If the left child
+						* of the sibling is
+						* red, color it black
+						* and rotate around
+						* the current parent
+						*/
+						sibling->left->color = black;
+						rbtree_rotate_right(tree, curr_node->parent);
+					} else {
+						/* If the right child
+						 * of the sibling is
+						 * red, rotate around
+						 * the sibling, then
+						 * rotate around the
+						 * new sibling of our
+						 * current node
+						 */
+						rbtree_rotate_left(tree, sibling);
+						sibling = curr_node->parent->left;
+						rbtree_rotate_right(tree, sibling);
+					}
+
+					/* It is now safe to color the
+					 * parent black and to
+					 * terminate the fix process.
+					 */
+					if (curr_node->parent->parent)
+						curr_node->parent->parent->color = curr_node->parent->color;
+					curr_node->parent->color = black;
+					/* In order to stop the while loop */
+					curr_node = tree->root;
+				}
+			}
+		}
+	}
+
+	/* The root can always be colored black */
+	curr_node->color = black;
+}
+
+/* Traverse a red-black tree */
+
+void rbtree_traverse(rb_tree *tree, opr *op)
+{
+	rbnode_traverse(tree->root, op);
+}
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/rbt.h b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/rbt.h
new file mode 100644
index 0000000..415890e
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/rbt.h
@@ -0,0 +1,316 @@
+/*
+ *   Copyright (c) International Business Machines Corp., 2001-2004
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+#ifndef RED_BLACK_TREE_H
+#define RED_BLACK_TREE_H
+
+/*
+ * ***************************************************************************
+ *
+ * Container class for a red-black tree ......
+ *
+ * A binary tree that satisfies the following properties:
+ *
+ * 1. Every node is either red or black
+ * 2. The root node is black
+ * 3. Every leaf (NIL) is black
+ * 4. If a node is red, both its children are black
+ * 5. For each node, all paths from the node to descendant leaf nodes
+ *    contain the same number of black nodes
+ *
+ * Due to points 4 & 5, the depth of a red-black tree containing n nodes
+ * is bounded by 2*log2(n+1) (WC).
+ *
+ *
+ * The rb_tree template requires two additional parmeters:
+ *
+ * - The contained TYPE class represents the objects stored in the tree.
+ *   It has to support the copy constructor and the assignment operator (opr)
+ * - cmp is a functor used to define the order of objects of class TYPE:
+ *   This class has to support an operator() that recieves two objects from
+ *   the TYPE class and returns a negative, 0, or a positive integer,
+ *   depending on the comparison result.
+ *
+ * Dominique Heger, S. Rao
+ *
+ * ***************************************************************************
+ */
+
+/* Color enumeration for nodes of red-black tree */
+/* ********************************************* */
+
+#include "filelist.h"
+
+typedef struct ffsb_file *datatype;
+
+#define COMP_NODES(a, b) ((a)->num - (b)->num)
+
+typedef enum red_black_color {red, black} rb_color;
+
+/*! Representation of a node in a red-black tree */
+typedef struct red_black_node {
+	datatype object;                      /* the stored object */
+	rb_color color;                       /* the color of the node */
+	struct red_black_node *parent;       /* points to the parent node */
+	struct red_black_node *right;        /* points to the right child */
+	struct red_black_node *left;         /* points to the left child */
+} rb_node;
+
+typedef int(cmp)(datatype, datatype);
+typedef void(opr)(void *);
+typedef void(destructor)(datatype);
+
+/* Construct of a red-black tree node
+ * - The object stored in the node
+ * - The color of the node
+ */
+
+extern rb_node *rbnode_construct(datatype object, rb_color color);
+
+/* Recursive destructor for the entire sub-tree */
+/* ******************************************** */
+
+extern void rbnode_destruct(rb_node *node, destructor d);
+
+/* Calculate the depth of the sub-tree spanned by the given node
+ * - The sub-tree root
+ * - The sub-tree depth
+ */
+
+extern int rbnode_depth(rb_node *node);
+
+/* Get the leftmost node in the sub-tree spanned by the given node
+ * - The sub-tree root
+ * - The sub-tree minimum
+ */
+
+extern rb_node *rbnode_minimum(rb_node *node);
+
+/* Get the rightmost node in the sub-tree spanned by the given node
+ * - The sub-tree root
+ * - The sub-tree maximum
+ */
+
+extern rb_node *rbnode_maximum(rb_node *node);
+
+/* Replace the object */
+/* ****************** */
+
+extern void rbnode_replace(rb_node *node, datatype object);
+
+/* Get the next node in the tree (according to the tree order)
+ * - The current node
+ * - The successor node, or NULL if node is the tree maximum
+ */
+
+extern rb_node *rbnode_successor(rb_node *node);
+
+/* Get the previous node in the tree (according to the tree order)
+ * - The current node
+ * - The predecessor node, or NULL if node is the tree minimum
+ */
+
+extern rb_node *rbnode_predecessor(rb_node *node);
+
+/* Duplicate the entire sub-tree rooted at the given node
+ * - The sub-tree root
+ * - A pointer to the duplicated sub-tree root
+ */
+
+extern rb_node *rbnode_duplicate(rb_node *node);
+
+/* Traverse a red-black sub-tree
+ * - The sub-tree root
+ * - The operation to perform on each object in the sub-tree
+ */
+extern void rbnode_traverse(rb_node *node, opr *op);
+
+/* Representation of a red-black tree */
+/* ********************************** */
+
+typedef struct red_black_tree {
+	rb_node *root;                /* pointer to the tree root */
+	int isize;                     /* number of objects stored */
+	/*   cmp * comp; */                   /* compare function */
+} rb_tree;
+
+/* Initialize a red-black tree with a comparision function
+ * - The tree
+ * - The comparision function
+ */
+
+void rbtree_init(rb_tree *tree);
+
+/* Construct a red-black tree with a comparison object
+ * - A pointer to the comparison object to be used by the tree
+ * - The newly constructed  tree
+ */
+
+rb_tree *rbtree_construct(void);
+
+/* Clean a red-black tree [takes O(n) operations]
+ * - The tree
+ */
+
+extern void rbtree_clean(rb_tree *tree, destructor d);
+
+/* Destruct a red-black tree
+ * - The tree
+ */
+
+extern void rbtree_destruct(rb_tree *tree, destructor d);
+
+/* Get the size of the tree [takes O(1) operations]
+ * - The tree
+ * - The number of objects stored in the tree
+ */
+
+extern int rbtree_size(rb_tree *tree);
+
+/* Get the depth of the tree [takes O(n) operations]
+ * - The tree
+ * - The length of the longest path from the root to a leaf node
+ */
+
+extern int rbtree_depth(rb_tree *tree);
+
+/* Check whether the tree contains an object [takes O(log n) operations]
+ * - The tree
+ * - The query object
+ * - (true) if an equal object is found in the tree, otherwise (false)
+ */
+
+extern int rbtree_contains(rb_tree *tree, datatype object);
+
+/* Insert an object to the tree [takes O(log n) operations]
+ * - The tree
+ * - The object to be inserted
+ * - Return the inserted object node
+ */
+
+extern rb_node *rbtree_insert(rb_tree *tree, datatype object);
+
+/* Insert a new object to the tree as the a successor of a given node
+ * - The tree
+ * - The new node
+ */
+
+extern rb_node *insert_successor_at(rb_tree *tree, rb_node *at_node,
+				    datatype object);
+
+/* Insert a new object to the tree as the a predecessor of a given node
+ * - The tree
+ * - The new node
+ */
+
+extern rb_node *insert_predecessor_at(rb_tree *tree, rb_node *at_node,
+				      datatype object);
+
+/* Remove an object from the tree [takes O(log n) operations]
+ * - The tree
+ * - The object to be removed
+ * - The object should be contained in the tree
+ */
+
+extern void rbtree_remove(rb_tree *tree, datatype object, destructor d);
+
+/* Get a handle to the tree minimum [takes O(log n) operations]
+ * - The tree
+ * - Return the minimal object in the tree, or a NULL if the tree is empty
+ */
+
+extern rb_node *rbtree_minimum(rb_tree *tree);
+
+/* Get a handle to the tree maximum [takes O(log n) operations]
+ * - The tree
+ * - Return the maximal object in the tree, or a NULL if the tree is empty
+ */
+
+extern rb_node *rbtree_maximum(rb_tree *tree);
+
+/* Get the next node in the tree (according to the tree order)
+ * - [takes O(log n) operations at worst-case, but only O(1) amortized]
+ * - The tree
+ * - The current object
+ * - The successor node, or a NULL, if we are at the tree maximum
+ */
+extern rb_node *rbtree_successor(rb_tree *tree, rb_node *node);
+
+/* Get the previous node in the tree (according to the tree order)
+ * - [takes O(log n) operations at worst-case, but only O(1) amortized]
+ * - The tree
+ * - The current object
+ * - The predecessor node, or a NULL, if we are at the tree minimum
+ */
+
+extern rb_node *rbtree_predecessor(rb_tree *tree, rb_node *node);
+
+/* Find a node that contains the given object
+ * - The tree
+ * - The desired object
+ * - Return a node that contains the given object, or NULL if no such object
+ *   is found in the tree
+ */
+
+extern rb_node *rbtree_find(rb_tree *tree, datatype object);
+
+/* Remove the object stored in the given tree node
+ * - The tree
+ * - The node storing the object to be removed from the tree
+ */
+
+extern void rbtree_remove_at(rb_tree *tree, rb_node *node, destructor d);
+
+/* Left-rotate the sub-tree spanned by the given node
+ * - The tree
+ * - The sub-tree root
+ */
+
+extern void rbtree_rotate_left(rb_tree *tree, rb_node *node);
+
+/* Right-rotate the sub-tree spanned by the given node
+ * - The tree
+ * - The sub-tree root
+ */
+
+extern void rbtree_rotate_right(rb_tree *tree, rb_node *node);
+
+/*
+ * Fix the red-black tree properties after an insertion operation
+ * - The tree
+ * - The node that has just been inserted to the tree
+ * - The color of node must be red
+ */
+
+extern void rbtree_insert_fixup(rb_tree *tree, rb_node *node);
+
+/* Fix the red-black tree properties after a removal operation
+ * - The tree
+ * - The child of the node that has just been removed from the tree
+ */
+
+extern void rbtree_remove_fixup(rb_tree *tree, rb_node *node);
+
+/* Traverse a red-black tree
+ * - The tree
+ * - The operation to perform on every object of the tree (according to
+ *   the tree order)
+ */
+
+extern void rbtree_traverse(rb_tree *tree, opr *op);
+
+#endif
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/registration-description b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/registration-description
new file mode 100644
index 0000000..fd181e2
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/registration-description
@@ -0,0 +1,7 @@
+The Flexible Filesystem Benchmark (FFSB) is a filesystem performance measurement tool.  It is a multi-threaded application (using pthreads), written entirely in C with cross-platform portability in 
mind.  It differs from other filesystem benchmarks in that the user may supply a profile to create custom workloads, while most other filesystem benchmarks use a fixed set of workloads.
+
+It is currently known to support Linux, AIX, and Solaris, although almost all development and testing has occurred on Linux.  We intend to add support for HP-UX, IRIX, and possibly others in the near 
future.
+
+FFSB is currently at version 5.0, and has been an internal tool at IBM for about four years.  I has already been used to conduct a study of Linux Kernel 2.6 IO-schedulers, and a great deal of future 
filesystem performance work is planned with FFSB as the primary tool.
+
+In version 5.0, it supports six different basic operations, support for multiple groups of threads with different operation mixtures, support for operation across multiple filesystems, and support 
for filesystem aging prior to benchmarking.
\ No newline at end of file
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/rwlock.c b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/rwlock.c
new file mode 100644
index 0000000..56430c2
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/rwlock.c
@@ -0,0 +1,109 @@
+/*
+ *   Copyright (c) International Business Machines Corp., 2001-2004
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+#include <pthread.h>
+#include <stdlib.h>
+#include <stdio.h>
+
+/* #define RWDEBUG 1 */
+#include "config.h"
+#include "rwlock.h"
+
+void init_rwlock(struct rwlock *rw)
+{
+	rw->n_readers = 0;
+	pthread_mutex_init(&rw->plock, NULL);
+	pthread_cond_init(&rw->pcond, NULL);
+#ifdef RWDEBUG
+	rw->n_write_waiting = 0;
+	rw->n_read_waiting  = 0;
+	rw->writer_tid      = -1;
+#endif
+}
+
+
+void rw_lock_read(struct rwlock *rw)
+{
+	pthread_mutex_lock(&rw->plock);
+#ifdef RWDEBUG
+	rw->n_read_waiting++;
+#endif
+	while (rw->n_readers < 0)
+		pthread_cond_wait(&rw->pcond, &rw->plock);
+	rw->n_readers++;
+#ifdef RWDEBUG
+	rw->n_read_waiting--;
+#endif
+	pthread_mutex_unlock(&rw->plock);
+}
+
+void rw_lock_write(struct rwlock *rw)
+{
+	pthread_mutex_lock(&rw->plock);
+#ifdef RWDEBUG
+	rw->n_write_waiting++;
+#endif
+	while (rw->n_readers != 0)
+		pthread_cond_wait(&rw->pcond, &rw->plock);
+	rw->n_readers = -1;
+#ifdef RWDEBUG
+	rw->n_write_waiting--;
+	rw->writer_tid = (int)pthread_self();
+#endif
+	pthread_mutex_unlock(&rw->plock);
+
+}
+
+void rw_unlock_read(struct rwlock *rw)
+{
+	pthread_mutex_lock(&rw->plock);
+	rw->n_readers -= 1 ;
+	pthread_cond_signal(&rw->pcond);
+	pthread_mutex_unlock(&rw->plock);
+}
+
+void rw_unlock_write(struct rwlock *rw)
+{
+	pthread_mutex_lock(&rw->plock);
+	rw->n_readers = 0 ;
+	pthread_cond_broadcast(&rw->pcond);
+	pthread_mutex_unlock(&rw->plock);
+}
+
+int rw_trylock_read(struct rwlock *rw)
+{
+	int ret = 1;
+	pthread_mutex_lock(&rw->plock);
+	if (rw->n_readers >= 0) {
+		rw->n_readers++;
+		ret = 0;
+	}
+	pthread_mutex_unlock(&rw->plock);
+	return ret;
+}
+
+int rw_trylock_write(struct rwlock *rw)
+{
+	int ret = 1;
+	pthread_mutex_lock(&rw->plock);
+	if (rw->n_readers == 0) {
+		ret = 0;
+		rw->n_readers = -1;
+	}
+	pthread_mutex_unlock(&rw->plock);
+	return ret;
+}
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/rwlock.h b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/rwlock.h
new file mode 100644
index 0000000..4392b41
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/rwlock.h
@@ -0,0 +1,51 @@
+/*
+ *   Copyright (c) International Business Machines Corp., 2001-2004
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+#ifndef _RWLOCK_H
+#define _RWLOCK_H
+
+#include <pthread.h>
+
+/* #define RWDEBUG 1 */
+
+/* n_readers >= 0 means 0 or more readers */
+/* n_readers < 0 means a writer */
+struct rwlock {
+	pthread_mutex_t plock;
+	int n_readers;
+	pthread_cond_t pcond;
+#ifdef RWDEBUG
+  int writer_tid;
+  int n_read_waiting;
+  int n_write_waiting;
+#endif
+};
+
+void init_rwlock(struct rwlock *rw);
+
+void rw_lock_read(struct rwlock *rw);
+void rw_lock_write(struct rwlock *rw);
+
+void rw_unlock_read(struct rwlock *rw);
+void rw_unlock_write(struct rwlock *rw);
+
+int rw_trylock_read(struct rwlock *rw);
+int rw_trylock_write(struct rwlock *rw);
+
+
+
+#endif
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/stamp-h.in b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/stamp-h.in
new file mode 100644
index 0000000..9788f70
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/stamp-h.in
@@ -0,0 +1 @@
+timestamp
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/util.c b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/util.c
new file mode 100644
index 0000000..df5d755
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/util.c
@@ -0,0 +1,351 @@
+/*
+ *   Copyright (c) International Business Machines Corp., 2001-2004
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/resource.h>
+#include <sys/wait.h>
+#include <sys/time.h>
+#include <sys/select.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <assert.h>
+#include <string.h>
+#include <limits.h>
+#include <errno.h>
+#include <pthread.h>
+
+#include "config.h"
+#include "fh.h"
+#include "util.h"
+
+uint64_t ffsb_get_filesize(char *name)
+{
+#ifndef HAVE_STAT64
+ #define STAT(a, b) do { stat((a), (b)); } while (0)
+	struct stat filestat;
+#else
+ #define STAT(a, b) do { stat64((a), (b)); } while (0)
+	struct stat64 filestat;
+#endif
+
+
+	STAT(name, &filestat);
+	return (uint64_t)filestat.st_size;
+#undef STAT
+}
+
+
+void *ffsb_malloc(size_t size)
+{
+	void *ptr = malloc((size));
+	assert(ptr != NULL);
+	memset(ptr, 0, size);
+	return ptr;
+}
+
+void *ffsb_realloc(void *ptr, size_t size)
+{
+	void *tmp ;
+	/* printf("ffsb_realloc: ptr = %p  size = %ld\n",ptr,size); */
+
+	if (ptr == NULL)
+		return ffsb_malloc(size);
+
+	tmp = realloc(ptr, size);
+	assert(ptr != NULL);
+	ptr = tmp;
+	return ptr;
+}
+
+void *ffsb_align_4k(void *ptr)
+{
+	unsigned long mask = ~(0xfff); /* 12 zeros at the end */
+	void *ret = (void *)((unsigned long)ptr & mask);
+	/* printf("align_4k got %p returning %p\n",ptr,ret); */
+	return ret;
+}
+
+char *ffsb_strdup(const char *str)
+{
+	int len = strlen(str);
+	char *dup = ffsb_malloc(len + 1);
+	/* !!! am I off by one here ?? */
+	strncpy(dup, str, len+1);
+	return dup;
+}
+
+size_t ffsb_strnlen(const char *str, size_t maxlen)
+{
+	size_t index = 0;
+
+	while (index < maxlen) {
+		if (str[index] == '\0')
+			break;
+		index++;
+	}
+	return index;
+}
+
+/* not perfect, in case we are somehow interrupted it's borked */
+void ffsb_sleep(unsigned secs)
+{
+	struct timeval tv = { 0 , 0 };
+	tv.tv_sec = secs;
+	select(0, NULL, NULL, NULL, &tv);
+}
+
+
+char *ffsb_printsize(char *buf, double size, int bufsize)
+{
+	if (size >= 1024 * 1024 * 1024)
+		snprintf(buf, bufsize, "%.3gGB", size / (1024 * 1024 * 1024));
+	else if (size >= 1024 * 1024)
+		snprintf(buf, bufsize, "%.3gMB", size / (1024 * 1024));
+	else if (size >= 1024)
+		snprintf(buf, bufsize, "%.3gKB", size/1024);
+	else
+		snprintf(buf, bufsize, "%.3gB", size);
+
+	return buf;
+}
+
+void ffsb_mkdir(char *dirname)
+{
+	if (mkdir(dirname, S_IRWXU) < 0) {
+		fprintf(stderr, "Error creating %s\n", dirname);
+		perror("mkdir");
+		exit(1);
+	}
+}
+
+struct timeval tvsub(struct timeval t1, struct timeval t0)
+{
+	struct timeval tdiff;
+	tdiff.tv_sec = t1.tv_sec - t0.tv_sec;
+	tdiff.tv_usec = t1.tv_usec - t0.tv_usec;
+	if (tdiff.tv_usec < 0)
+		tdiff.tv_sec--, tdiff.tv_usec += 1000000;
+	return tdiff;
+}
+
+struct timeval tvadd(struct timeval t1, struct timeval t0)
+{
+	struct timeval tdiff;
+	tdiff.tv_sec = t1.tv_sec + t0.tv_sec;
+	tdiff.tv_usec = t1.tv_usec + t0.tv_usec;
+	if (tdiff.tv_usec > 1000000)
+		tdiff.tv_sec++, tdiff.tv_usec -= 1000000;
+	return tdiff;
+}
+
+double tvtodouble(struct timeval *t)
+{
+	return ((double)t->tv_sec*(1000000.0f) + (double)t->tv_usec) /
+		1000000.0f;
+}
+
+double cpu_so_far(void)
+{
+	struct rusage rusage;
+
+	getrusage(RUSAGE_SELF, &rusage);
+
+	return
+		((double) rusage.ru_utime.tv_sec) +
+		(((double) rusage.ru_utime.tv_usec) / 1000000.0) +
+		((double) rusage.ru_stime.tv_sec) +
+		(((double) rusage.ru_stime.tv_usec) / 1000000.0);
+}
+
+double cpu_so_far_children(void)
+{
+	struct rusage rusage;
+
+	getrusage(RUSAGE_CHILDREN, &rusage);
+
+	return
+		((double) rusage.ru_utime.tv_sec) +
+		(((double) rusage.ru_utime.tv_usec) / 1000000.0) +
+		((double) rusage.ru_stime.tv_sec) +
+		(((double) rusage.ru_stime.tv_usec) / 1000000.0);
+}
+
+
+/* !!!! check portability */
+float getfsutil(char *dirname)
+{
+	struct statvfs64 fsdata;
+
+	statvfs64(dirname, &fsdata);
+
+/* 	return (float)(fsdata.f_blocks-fsdata.f_bfree)/ */
+/* 		(float)(fsdata.f_blocks-fsdata.f_bfree+fsdata.f_bavail); */
+	return (float) (((float)(fsdata.f_blocks - fsdata.f_bfree)) /
+			((float)fsdata.f_blocks));
+}
+
+uint64_t getfsutil_size(char *dirname)
+{
+	struct statvfs64 fsdata;
+	statvfs64(dirname, &fsdata);
+
+	return (fsdata.f_blocks - fsdata.f_bfree) * fsdata.f_bsize;
+}
+
+int ffsb_system(char *command)
+{
+	int pid=0, status;
+	extern char **environ;
+
+	if (command == NULL)
+		return 1;
+	pid = fork();
+	if (pid == -1)
+		return -1;
+	if (pid == 0) {
+		char *argv[4];
+		argv[0] = "sh";
+		argv[1] = "-c";
+		argv[2] = command;
+		argv[3] = 0;
+		execve("/bin/sh", argv, environ);
+		exit(127);
+	}
+	do {
+		if (waitpid(pid, &status, 0) == -1) {
+			if (errno != EINTR)
+				return -1;
+		}
+		else
+			return status;
+	} while (1);
+}
+
+void ffsb_sync()
+{
+	struct timeval starttime, endtime, difftime;
+	printf("Syncing()...");
+	fflush(stdout);
+	gettimeofday(&starttime, NULL);
+	sync();
+	gettimeofday(&endtime, NULL);
+	timersub(&endtime, &starttime, &difftime);
+	printf("%ld sec\n", difftime.tv_sec);
+}
+
+void ffsb_getrusage(struct rusage *ru_self, struct rusage *ru_children)
+{
+	int ret = 0;
+/* 	printf("cpu_so_far is %lf\n",cpu_so_far()); */
+/* 	printf("cpu_so_far_children is %lf\n",cpu_so_far_children()); */
+	ret = getrusage(RUSAGE_SELF, ru_self);
+	if (ret < 0)
+		perror("getrusage self");
+
+/* 	printf("self returned %d\n",ret); */
+	ret = getrusage(RUSAGE_CHILDREN, ru_children);
+	if (ret < 0)
+		perror("getrusage children");
+/* 	printf("children returned %d\n",ret); */
+}
+
+void ffsb_milli_sleep(unsigned time)
+{
+	struct timeval tv = { 0 , 0 };
+	if (!time)
+		return;
+	tv.tv_usec = time * 1000;
+	select(0, NULL, NULL, NULL, &tv);
+}
+
+void ffsb_micro_sleep(unsigned time)
+{
+	struct timeval tv = { 0 , 0 };
+	if (!time)
+		return;
+	tv.tv_usec = time ;
+	select(0, NULL, NULL, NULL, &tv);
+}
+
+
+void ffsb_barrier_init(ffsb_barrier_t *fb, unsigned count)
+{
+	memset(fb, 0, sizeof(*fb));
+	pthread_mutex_init(&fb->plock, NULL);
+	pthread_cond_init(&fb->pcond, NULL);
+	fb->required_count = count;
+}
+
+void ffsb_barrier_wait(ffsb_barrier_t *fb)
+{
+	pthread_mutex_lock(&fb->plock);
+
+	fb->current_count++;
+
+	if (fb->current_count == fb->required_count)
+		pthread_cond_broadcast(&fb->pcond);
+	else
+		while (fb->current_count != fb->required_count)
+			pthread_cond_wait(&fb->pcond, &fb->plock);
+
+	pthread_mutex_unlock(&fb->plock);
+}
+
+void ffsb_unbuffer_stdout(void)
+{
+#ifndef SETVBUF_REVERSED
+	setvbuf(stdout, NULL, _IONBF, 0);
+#else
+	setvbuf(stdout, _IONBF, NULL, 0);
+#endif
+}
+
+void ffsb_bench_gettimeofday(void)
+{
+	unsigned long i = 0;
+	uint64_t total_usec;
+	uint64_t average = 0;
+	struct timeval starttime, endtime, junk, difftime;
+	gettimeofday(&starttime, NULL);
+	for (i = 0; i < 1000000; i++)
+		gettimeofday(&junk, NULL);
+	gettimeofday(&endtime, NULL);
+	timersub(&endtime, &starttime, &difftime);
+	total_usec = difftime.tv_sec * 1000000;
+	total_usec += difftime.tv_usec;
+	average = total_usec / 1000ull;
+	printf("average time for gettimeofday(): %llu nsec\n", average);
+}
+
+void ffsb_bench_getpid(void)
+{
+	unsigned long i = 0;
+	uint64_t total_usec;
+	uint64_t average = 0;
+	struct timeval starttime, endtime, difftime;
+	gettimeofday(&starttime, NULL);
+	for (i = 0; i < 1000000; i++)
+		getpid();
+	gettimeofday(&endtime, NULL);
+	timersub(&endtime, &starttime, &difftime);
+	total_usec = difftime.tv_sec * 1000000;
+	total_usec += difftime.tv_usec;
+	average = total_usec / 1000ull;
+	printf("average time for getpid(): %llu nsec\n", average);
+}
diff --git a/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/util.h b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/util.h
new file mode 100644
index 0000000..c1f5798
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/util.h
@@ -0,0 +1,94 @@
+/*
+ *   Copyright (c) International Business Machines Corp., 2001-2006
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+#ifndef _UTIL_H_
+#define _UTIL_H_
+
+#include "config.h"
+
+#include <sys/time.h>
+#include <sys/resource.h>
+
+#ifdef HAVE_SYS_VFS_H
+#include <sys/vfs.h>
+#endif
+#include <sys/statvfs.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <assert.h>
+#include <string.h>
+#include <pthread.h>
+
+
+void ffsb_sleep(unsigned secs);
+void *ffsb_malloc(size_t size);
+void *ffsb_realloc(void *ptr, size_t size);
+char *ffsb_strdup(const char *str);
+size_t ffsb_strnlen(const char *str, size_t maxlen);
+
+void ffsb_mkdir(char *dirname);
+void ffsb_getrusage(struct rusage *ru_self, struct rusage *ru_children);
+void ffsb_sync(void);
+void *ffsb_align_4k(void *ptr);
+char *ffsb_printsize(char *buf, double size, int bufsize);
+
+int ffsb_system(char *command);
+void ffsb_milli_sleep(unsigned time);
+void ffsb_micro_sleep(unsigned time);
+void ffsb_unbuffer_stdout(void);
+void ffsb_bench_gettimeofday(void);
+void ffsb_bench_getpid(void);
+
+uint64_t ffsb_get_filesize(char *name);
+
+typedef struct {
+	unsigned required_count;
+	unsigned current_count;
+	pthread_mutex_t plock;
+	pthread_cond_t pcond;
+} ffsb_barrier_t ;
+
+void ffsb_barrier_init(ffsb_barrier_t *fb, unsigned count);
+void ffsb_barrier_wait(ffsb_barrier_t *fb);
+
+double cpu_so_far(void);
+double time_so_far(void);
+double cpu_so_far_children(void);
+float getfsutil(char *dirname);
+uint64_t getfsutil_size(char *dirname);
+
+struct timeval tvsub(struct timeval t1, struct timeval t0);
+struct timeval tvadd(struct timeval t1, struct timeval t0);
+double tvtodouble(struct timeval *t);
+
+
+#define max(a, b) (((a) > (b)) ? (a) : (b))
+
+#ifndef timersub
+#define timersub(a, b, result)                                          \
+	do {           	                                                \
+		(result)->tv_sec = (a)->tv_sec - (b)->tv_sec;		\
+		(result)->tv_usec = (a)->tv_usec - (b)->tv_usec;	\
+									\
+		if ((result)->tv_usec < 0) {				\
+			(result)->tv_sec--;				\
+			(result)->tv_usec += 1000000;			\
+		}							\
+	} while (0)
+#endif /* timersub */
+
+#endif /* _UTIL_H_ */
diff --git a/testcases/kernel/fs/ext4-new-features/run_ext4_test.sh b/testcases/kernel/fs/ext4-new-features/run_ext4_test.sh
new file mode 100644
index 0000000..534d2b9
--- /dev/null
+++ b/testcases/kernel/fs/ext4-new-features/run_ext4_test.sh
@@ -0,0 +1,179 @@
+#! /bin/bash
+
+################################################################################
+#                                                                              #
+# Copyright (c) 2009 FUJITSU LIMITED                                           #
+#                                                                              #
+# This program is free software;  you can redistribute it and#or modify        #
+# it under the terms of the GNU General Public License as published by         #
+# the Free Software Foundation; either version 2 of the License, or            #
+# (at your option) any later version.                                          #
+#                                                                              #
+# This program is distributed in the hope that it will be useful, but          #
+# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY   #
+# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License     #
+# for more details.                                                            #
+#                                                                              #
+# You should have received a copy of the GNU General Public License            #
+# along with this program;  if not, write to the Free Software                 #
+# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA      #
+#                                                                              #
+################################################################################
+# Name Of File: run_ext4_test.sh                                               #
+#                                                                              #
+# Description: This file runs the tests for ext4 filesystem's new features.    #
+#                                                                              #
+# Precaution:   In order to avoid destroying the important data on the disk,   #
+#               specify a free partition to be used for test please.           #
+#                                                                              #
+# Author:       Li Zefan    <lizf@cn.fujitsu.com>                              #
+#                                                                              #
+# History:                                                                     #
+#                                                                              #
+#  DATE      NAME        EMAIL                    DESC                         #
+#                                                                              #
+#  09/10/08  Li Zefan    <lizf@cn.fujitsu.com>    Created this test            #
+#  08/25/09  Miao Xie    <miaox@cn.fujitsu.com>   Moved to LTP                 #
+#                                                                              #
+################################################################################
+
+source ext4_funcs.sh;
+
+export TCID="ext4_new_feature"
+export TST_TOTAL=1
+export TST_COUNT=1
+
+tst_kvercmp 2 6 31
+if [ $? -eq 0 ]; then
+	tst_brkm TCONF ignored "kernel is below 2.6.31"
+	exit 0
+fi
+
+if [ "$USER" != root ]; then
+	tst_brkm TCONF ignored "Test must be run as root"
+	exit 0
+fi
+
+EXT4_SUPPORT1=`grep -w ext4 /proc/filesystems | cut -f2`
+EXT4_SUPPORT2=`grep -w ext4 /proc/modules | cut -f1`
+if [  "$EXT4_SUPPORT1" != "ext4" ] && [ "$EXT4_SUPPORT2" != "ext4" ]; then
+	tst_brkm TCONF ignored "Ext4 is not supported"
+	exit 0
+fi
+
+if [ ! -f "ffsb" ]; then
+	tst_brkm TCONF ignored "ffsb does not exist.Please check whether ffsb was configed and compiled"
+	exit 0
+fi
+
+if [ ! -f "ext4-test-config" ]; then
+	tst_brkm TCONF ignored "Config file ext4-test-config does not exist. Please check whether the configure wan ran"
+	exit 0
+fi
+
+cd $LTPROOT/testcases/bin/
+
+RET=0
+
+echo "EXT4 NEW FEATURE TESTING";
+echo "TEST STARTED: Please avoid using system while this test executes";
+
+echo " "
+echo "Ext4 block allocation test"
+if [ -f "ext4-alloc-test.sh" ]; then
+	./ext4-alloc-test.sh ./ext4-test-config
+	if [ $? -ne 0 ]; then
+		RET=1
+	fi
+else
+	echo "Shell file is not installed..Please check Makefile..."
+	RET=1
+fi
+
+echo " "
+echo "Ext4 journal checksum test"
+if [ -f "ext4_journal_checksum.sh" ]; then
+	./ext4_journal_checksum.sh ./ext4-test-config
+	if [ $? -ne 0 ]; then
+		RET=1
+	fi
+else
+	echo "Shell file is not installed..Please check Makefile..."
+	RET=1
+fi
+
+echo " "
+echo "Ext4 subdir limit test"
+if [ -f "ext4_subdir_limit_test.sh" ]; then
+	./ext4_subdir_limit_test.sh ./ext4-test-config
+	if [ $? -ne 0 ]; then
+		RET=1
+	fi
+else
+	echo "Shell file is not installed..Please check Makefile..."
+	RET=1
+fi
+
+echo " "
+echo "Ext4 nanosecond timestamp test"
+if [ -f "ext4_nsec_timestamps_test.sh" ]; then
+	./ext4_nsec_timestamps_test.sh ./ext4-test-config
+	if [ $? -ne 0 ]; then
+		RET=1
+	fi
+else
+	echo "Shell file is not installed..Please check Makefile..."
+	RET=1
+fi
+
+echo " "
+echo "Ext4 persist prealloc test"
+if [ -f "ext4_persist_prealloc_test.sh" ]; then
+	./ext4_persist_prealloc_test.sh ./ext4-test-config
+	if [ $? -ne 0 ]; then
+		RET=1
+	fi
+else
+	echo "Shell file is not installed..Please check Makefile..."
+	RET=1
+fi
+
+echo " "
+echo "Ext4 inode version test"
+if [ -f "ext4_inode_version_test.sh" ]; then
+	./ext4_inode_version_test.sh ./ext4-test-config
+	if [ $? -ne 0 ]; then
+		RET=1
+	fi
+else
+	echo "Shell file is not installed..Please check Makefile..."
+	RET=1
+fi
+
+echo " "
+echo "Ext4 uninit groups test"
+if [ -f "ext4_uninit_groups_test.sh" ]; then
+	./ext4_uninit_groups_test.sh ./ext4-test-config
+	if [ $? -ne 0 ]; then
+		RET=1
+	fi
+else
+	echo "Shell file is not installed..Please check Makefile..."
+	RET=1
+fi
+
+echo " "
+echo "Ext4 online defrag test"
+echo "The output of defrag program is in the file"\
+	"LTPROOT/output/ext4_online_defrag.txt"
+if [ -f "ext4_online_defrag_test.sh" ]; then
+	./ext4_online_defrag_test.sh ./ext4-test-config
+	if [ $? -ne 0 ]; then
+		RET=1
+	fi
+else
+	echo "Shell file is not installed..Please check Makefile..."
+	RET=1
+fi
+
+exit $RET
-- 
1.6.4.3


------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
