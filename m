Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mqhjw-0004Uy-Td
	for ltp-list@lists.sourceforge.net; Thu, 24 Sep 2009 06:23:40 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mqhjs-0007fh-5Y
	for ltp-list@lists.sourceforge.net; Thu, 24 Sep 2009 06:23:40 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8O6GMbr029323
	for <ltp-list@lists.sourceforge.net>; Thu, 24 Sep 2009 02:16:22 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8O6NU3E254984
	for <ltp-list@lists.sourceforge.net>; Thu, 24 Sep 2009 02:23:30 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8O6NUup031490
	for <ltp-list@lists.sourceforge.net>; Thu, 24 Sep 2009 02:23:30 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4ABACAA3.2020206@cn.fujitsu.com>
References: <4ABACAA3.2020206@cn.fujitsu.com>
Date: Thu, 24 Sep 2009 11:53:18 +0530
Message-Id: <1253773400.8507.9.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Add new testcases for ext4 new features
Reply-To: subrata@linux.vnet.ibm.com
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
To: Miao Xie <miaox@cn.fujitsu.com>
Cc: LTP-ML <ltp-list@lists.sourceforge.net>

On Thu, 2009-09-24 at 10:25 +0900, Miao Xie wrote:
> This is the patch of testcases for the ext4 new features test.
> It contains multi-block alloc/delayed alloc test, inode version test, journal
> checksumming test, nanosec timestamps test, online defrag test, persist
> prealloc test, subdirectory limit test and uninit groups test of ext4.
> 
> In this test suite, there is two FAIL in the subdirectory limit test.
> It is because we cann't create more than 32000 subdirectory when block size is
> small, such as 1024, and the name of every subdirectory is very long, such as 
> every name is 255 bytes. I think it is the bug of the ext4.
> 
> Note: Your MUST run configure in the directory
> 	testcases/kernel/fs/ext4-new-features
>        to config the tool of ffsb, and specify a partition to be used for test
>        before compiling the tool. The data on the specified partition would be
>        DESTROYED.
> 
> Signed-off-by: Miao Xie <miaox@cn.fujitsu.com>

Thank you very much for these tests. I will test it and let you know
comments, if any. I will try hard to include this in September 2009 LTP
month-end release for the community to start using them.

Regards--
Subrata

> ---
>   runtest/fs_ext4                                    |    1 +
>   testcases/kernel/fs/Makefile                       |    2 +-
>   testcases/kernel/fs/ext4-new-features/Makefile     |   24 +
>   testcases/kernel/fs/ext4-new-features/README       |  112 +
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
>   .../fs/ext4-new-features/ffsb-6.0-rc2/install-sh   |  251 +
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
>   94 files changed, 27281 insertions(+), 1 deletions(-)
>   create mode 100644 runtest/fs_ext4
>   create mode 100644 testcases/kernel/fs/ext4-new-features/Makefile
>   create mode 100644 testcases/kernel/fs/ext4-new-features/README
>   create mode 100755 testcases/kernel/fs/ext4-new-features/configure
>   create mode 100644 
> testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/Makefile
>   create mode 100755 
> testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/Makefile
>   create mode 100644 
> testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config0
>   create mode 100644 
> testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config1
>   create mode 100644 
> testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config2
>   create mode 100644 
> testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config3
>   create mode 100644 
> testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config4
>   create mode 100644 
> testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config5
>   create mode 100644 
> testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config6
>   create mode 100644 
> testcases/kernel/fs/ext4-new-features/ext4-ffsb-config/ffsb-config7
>   create mode 100644 
> testcases/kernel/fs/ext4-new-features/ext4-inode-version/Makefile
>   create mode 100755 
> testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_get_inode_version.sh
>   create mode 100755 
> testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh
>   create mode 100644 
> testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_test_inode_version.c
>   create mode 100644 
> testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/Makefile
>   create mode 100755 
> testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh
>   create mode 100644 
> testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/Makefile
>   create mode 100644 
> testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_file_time.c
>   create mode 100755 
> testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
>   create mode 100644 
> testcases/kernel/fs/ext4-new-features/ext4-online-defrag/Makefile
>   create mode 100644 
> testcases/kernel/fs/ext4-new-features/ext4-online-defrag/e4defrag.c
>   create mode 100755 
> testcases/kernel/fs/ext4-new-features/ext4-online-defrag/ext4_online_defrag_test.sh
>   create mode 100644 
> testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/Makefile
>   create mode 100755 
> testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh
>   create mode 100644 
> testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/Makefile
>   create mode 100644 
> testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/create_long_dirs.c
>   create mode 100644 
> testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/create_short_dirs.c
>   create mode 100755 
> testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh
>   create mode 100644 
> testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/Makefile
>   create mode 100755 
> testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh
>   create mode 100755 testcases/kernel/fs/ext4-new-features/ext4_funcs.sh
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/AUTHORS
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/COPYING
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ChangeLog
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/INSTALL
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/LICENSE
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/Makefile.am
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/Makefile.in
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/NEWS
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/README
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/aclocal.m4
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/cirlist.c
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/cirlist.h
>   create mode 100755 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/config.guess
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/config.h.in
>   create mode 100755 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/config.sub
>   create mode 100755 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/configure
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/configure.in
>   create mode 100755 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/depcomp
>   create mode 100644 
> testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/examples/profile_everything
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
>   create mode 100644 
> testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_thread.c
>   create mode 100644 
> testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/ffsb_thread.h
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
>   create mode 100644 
> testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/mkinstalldirs
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/parser.c
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/parser.h
>   create mode 100644 
> testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/public-description
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/rand.c
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/rand.h
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/rbt.c
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/rbt.h
>   create mode 100644 
> testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/registration-description
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/rwlock.c
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/rwlock.h
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/stamp-h.in
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/util.c
>   create mode 100644 testcases/kernel/fs/ext4-new-features/ffsb-6.0-rc2/util.h
>   create mode 100755 testcases/kernel/fs/ext4-new-features/run_ext4_test.sh



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
