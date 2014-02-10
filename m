Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WCq1R-0007nI-Ag
	for ltp-list@lists.sourceforge.net; Mon, 10 Feb 2014 12:31:37 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WCq1O-00083Y-DF
	for ltp-list@lists.sourceforge.net; Mon, 10 Feb 2014 12:31:37 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s1ABI01w004561
	for <ltp-list@lists.sourceforge.net>; Mon, 10 Feb 2014 19:18:04 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Mon, 10 Feb 2014 19:16:39 +0800
Message-Id: <1392030999-4431-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1392030999-4431-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <1392030999-4431-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH v3 2/2] fs/ext4-new-features: add ext4-new-features
	tests to default
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Remove run_ext4_test.sh which calls all feature tests directly.
Now we treat every feature as a signle test in fs_ext4 runtest file,
keep one entry per test.
Like that:
	ext4-nsec-timestamps    ext4_nsec_timestamps_test.sh
	ext4-uninit-groups      ext4_uninit_groups_test.sh

Configure script has been removed and ffsb has been moved to utils directory.

If want to run these tests, user should specify a big block device
when running runltp script.

Currently enable ext4-nsec-timestamps, ext4-persist-prealloc,
ext4-subdir-limit, ext4-uninit-groups test.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 runtest/fs_ext4                                    |   5 +-
 scenario_groups/default                            |   1 +
 .../ext4-delalloc-mballoc/ext4-alloc-test.sh       |   3 -
 .../ext4-inode-version/ext4_inode_version_test.sh  |   3 -
 .../ext4-journal-checksum/ext4_journal_checksum.sh |   3 -
 .../ext4_nsec_timestamps_test.sh                   |   2 -
 .../ext4-online-defrag/ext4_online_defrag_test.sh  |   3 -
 .../ext4_persist_prealloc_test.sh                  |   3 -
 .../ext4-subdir-limit/ext4_subdir_limit_test.sh    |   2 -
 .../ext4-uninit-groups/ext4_uninit_groups_test.sh  |   2 -
 .../kernel/fs/ext4-new-features/ext4_funcs.sh      |  41 +++--
 .../kernel/fs/ext4-new-features/run_ext4_test.sh   | 179 ---------------------
 12 files changed, 32 insertions(+), 215 deletions(-)
 delete mode 100755 testcases/kernel/fs/ext4-new-features/run_ext4_test.sh

diff --git a/runtest/fs_ext4 b/runtest/fs_ext4
index c65ebab..35697c5 100644
--- a/runtest/fs_ext4
+++ b/runtest/fs_ext4
@@ -1 +1,4 @@
-ext4_new_feature_test	run_ext4_test.sh
+ext4-nsec-timestamps	ext4_nsec_timestamps_test.sh
+ext4-uninit-groups	ext4_uninit_groups_test.sh
+ext4-persist-prealloc	ext4_persist_prealloc_test.sh
+ext4-subdir-limit	ext4_subdir_limit_test.sh
diff --git a/scenario_groups/default b/scenario_groups/default
index 9eca8ad..893909c 100644
--- a/scenario_groups/default
+++ b/scenario_groups/default
@@ -25,3 +25,4 @@ hugetlb
 commands
 hyperthreading
 kernel_misc
+fs_ext4
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh b/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh
index dfa34c4..55ea6ae 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh
@@ -28,11 +28,8 @@ export TCID="ext4-delalloc-mballoc"
 export TST_TOTAL=17
 export TST_COUNT=1
 
-# $1: the test config
-
 export TEST_DIR=$PWD
 
-read_config $1
 
 # Case 17: mount ext4 partition to ext3
 ext4_test_remount()
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh
index 998c3e4..18c1d20 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh
@@ -33,9 +33,6 @@ export TST_COUNT=1
 
 export TEST_DIR=$PWD
 
-# $1: the test config
-read_config $1
-
 # Test that inode version is not 32 bits with 128 inode size
 ext4_test_128_inode_version()
 {
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh b/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh
index 1fd9bba..3a0f26a 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh
@@ -31,11 +31,8 @@ export TCID="ext4-journal-checksum"
 export TST_TOTAL=36
 export TST_COUNT=1
 
-# $1: the test config
-
 export TEST_DIR=$PWD
 
-read_config $1
 
 # Use ffsb to test journal checksumming
 # $1: journal mode: writeback, ordered, journal
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
index c91c1af..0730e87 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
@@ -31,8 +31,6 @@ export TCID="ext4-nsec-timestamps"
 export TST_TOTAL=2
 export TST_COUNT=1
 
-# $1: the test config
-read_config $1
 
 TEST_DIR=$PWD
 
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-online-defrag/ext4_online_defrag_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-online-defrag/ext4_online_defrag_test.sh
index 2aa3e5b..28ba161 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-online-defrag/ext4_online_defrag_test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-online-defrag/ext4_online_defrag_test.sh
@@ -30,9 +30,6 @@ export TST_COUNT=1
 
 export TEST_DIR=$PWD
 
-# $1: the test config
-read_config $1
-
 # How to age filesystem
 EMPTY=1
 SMALL=2
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh
index e41b104..92b27c1 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh
@@ -33,9 +33,6 @@ export TST_COUNT=1
 
 export TEST_DIR=$PWD
 
-# $1: the test config
-read_config $1
-
 # The test path of fallocate
 export TMPDIR=$PWD/mnt_point/
 
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh
index fdb6a08..47807b1 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh
@@ -31,8 +31,6 @@ export TCID="ext4-subdir-limit"
 export TST_TOTAL=10
 export TST_COUNT=1
 
-# $1: the test config
-read_config $1
 
 TEST_DIR=$PWD
 SHORT_DIR=1
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh
index e6d49e1..b21d262 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh
@@ -29,8 +29,6 @@ export TST_TOTAL=24
 export TST_COUNT=1
 
 export TEST_DIR=$PWD
-# $1: the test config
-read_config $1
 
 # How to age filesystem
 EMPTY=1
diff --git a/testcases/kernel/fs/ext4-new-features/ext4_funcs.sh b/testcases/kernel/fs/ext4-new-features/ext4_funcs.sh
index b469bab..9909054 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4_funcs.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4_funcs.sh
@@ -23,25 +23,38 @@
 ##                                                                            ##
 ################################################################################
 
+. cmdlib.sh
+
 ext4_setup()
 {
+	tst_kvercmp 2 6 31
+	if [ $? -eq 0 ]; then
+		tst_brkm TCONF ignored "kernel is below 2.6.31"
+		exit 0
+	fi
+
+	tst_require_root
+
+	EXT4_SUPPORT1=`grep -w ext4 /proc/filesystems | cut -f2`
+	EXT4_SUPPORT2=`grep -w ext4 /proc/modules | cut -f1`
+	if [ "$EXT4_SUPPORT1" != "ext4" ] && [ "$EXT4_SUPPORT2" != "ext4" ];then
+		tst_brkm TCONF ignored "Ext4 is not supported"
+		exit 0
+	fi
+
+	exists ffsb
+
+	if [ -z "$LTP_BIG_DEV" ];then
+		tst_brkm TCONF ignored "tests need a big block device(5G-10G)"
+		exit 0
+	else
+		EXT4_DEV=$LTP_BIG_DEV
+	fi
+
 	mkdir mnt_point
 }
 
 ext4_cleanup()
 {
-	rmdir mnt_point
+	rm -rf mnt_point
 }
-
-# $1: the config file
-read_config()
-{
-	while read config
-	do
-		echo $config | grep -q -E ".*=.*"
-		if [ $? -eq 0 ]; then
-			export $config
-		fi
-	done < $1
-}
-
diff --git a/testcases/kernel/fs/ext4-new-features/run_ext4_test.sh b/testcases/kernel/fs/ext4-new-features/run_ext4_test.sh
deleted file mode 100755
index bfbd844..0000000
--- a/testcases/kernel/fs/ext4-new-features/run_ext4_test.sh
+++ /dev/null
@@ -1,179 +0,0 @@
-#! /bin/bash
-
-################################################################################
-#                                                                              #
-# Copyright (c) 2009 FUJITSU LIMITED                                           #
-#                                                                              #
-# This program is free software;  you can redistribute it and#or modify        #
-# it under the terms of the GNU General Public License as published by         #
-# the Free Software Foundation; either version 2 of the License, or            #
-# (at your option) any later version.                                          #
-#                                                                              #
-# This program is distributed in the hope that it will be useful, but          #
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY   #
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License     #
-# for more details.                                                            #
-#                                                                              #
-# You should have received a copy of the GNU General Public License            #
-# along with this program;  if not, write to the Free Software                 #
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA      #
-#                                                                              #
-################################################################################
-# Name Of File: run_ext4_test.sh                                               #
-#                                                                              #
-# Description: This file runs the tests for ext4 filesystem's new features.    #
-#                                                                              #
-# Precaution:   In order to avoid destroying the important data on the disk,   #
-#               specify a free partition to be used for test please.           #
-#                                                                              #
-# Author:       Li Zefan    <lizf@cn.fujitsu.com>                              #
-#                                                                              #
-# History:                                                                     #
-#                                                                              #
-#  DATE      NAME        EMAIL                    DESC                         #
-#                                                                              #
-#  09/10/08  Li Zefan    <lizf@cn.fujitsu.com>    Created this test            #
-#  08/25/09  Miao Xie    <miaox@cn.fujitsu.com>   Moved to LTP                 #
-#                                                                              #
-################################################################################
-
-source ext4_funcs.sh;
-
-export TCID="ext4_new_feature"
-export TST_TOTAL=1
-export TST_COUNT=1
-
-tst_kvercmp 2 6 31
-if [ $? -eq 0 ]; then
-	tst_brkm TCONF ignored "kernel is below 2.6.31"
-	exit 0
-fi
-
-if [ "$USER" != root ]; then
-	tst_brkm TCONF ignored "Test must be run as root"
-	exit 0
-fi
-
-EXT4_SUPPORT1=`grep -w ext4 /proc/filesystems | cut -f2`
-EXT4_SUPPORT2=`grep -w ext4 /proc/modules | cut -f1`
-if [  "$EXT4_SUPPORT1" != "ext4" ] && [ "$EXT4_SUPPORT2" != "ext4" ]; then
-	tst_brkm TCONF ignored "Ext4 is not supported"
-	exit 0
-fi
-
-if [ ! -f "ffsb" ]; then
-	tst_brkm TCONF ignored "ffsb does not exist.Please check whether ffsb was configed and compiled"
-	exit 0
-fi
-
-if [ ! -f "ext4-test-config" ]; then
-	tst_brkm TCONF ignored "Config file ext4-test-config does not exist. Please check whether the configure wan ran"
-	exit 0
-fi
-
-cd $LTPROOT/testcases/bin/
-
-RET=0
-
-echo "EXT4 NEW FEATURE TESTING";
-echo "TEST STARTED: Please avoid using system while this test executes";
-
-echo " "
-echo "Ext4 block allocation test"
-if [ -f "ext4-alloc-test.sh" ]; then
-	./ext4-alloc-test.sh ./ext4-test-config
-	if [ $? -ne 0 ]; then
-		RET=1
-	fi
-else
-	echo "Shell file is not installed..Please check Makefile..."
-	RET=1
-fi
-
-echo " "
-echo "Ext4 journal checksum test"
-if [ -f "ext4_journal_checksum.sh" ]; then
-	./ext4_journal_checksum.sh ./ext4-test-config
-	if [ $? -ne 0 ]; then
-		RET=1
-	fi
-else
-	echo "Shell file is not installed..Please check Makefile..."
-	RET=1
-fi
-
-echo " "
-echo "Ext4 subdir limit test"
-if [ -f "ext4_subdir_limit_test.sh" ]; then
-	./ext4_subdir_limit_test.sh ./ext4-test-config
-	if [ $? -ne 0 ]; then
-		RET=1
-	fi
-else
-	echo "Shell file is not installed..Please check Makefile..."
-	RET=1
-fi
-
-echo " "
-echo "Ext4 nanosecond timestamp test"
-if [ -f "ext4_nsec_timestamps_test.sh" ]; then
-	./ext4_nsec_timestamps_test.sh ./ext4-test-config
-	if [ $? -ne 0 ]; then
-		RET=1
-	fi
-else
-	echo "Shell file is not installed..Please check Makefile..."
-	RET=1
-fi
-
-echo " "
-echo "Ext4 persist prealloc test"
-if [ -f "ext4_persist_prealloc_test.sh" ]; then
-	./ext4_persist_prealloc_test.sh ./ext4-test-config
-	if [ $? -ne 0 ]; then
-		RET=1
-	fi
-else
-	echo "Shell file is not installed..Please check Makefile..."
-	RET=1
-fi
-
-echo " "
-echo "Ext4 inode version test"
-if [ -f "ext4_inode_version_test.sh" ]; then
-	./ext4_inode_version_test.sh ./ext4-test-config
-	if [ $? -ne 0 ]; then
-		RET=1
-	fi
-else
-	echo "Shell file is not installed..Please check Makefile..."
-	RET=1
-fi
-
-echo " "
-echo "Ext4 uninit groups test"
-if [ -f "ext4_uninit_groups_test.sh" ]; then
-	./ext4_uninit_groups_test.sh ./ext4-test-config
-	if [ $? -ne 0 ]; then
-		RET=1
-	fi
-else
-	echo "Shell file is not installed..Please check Makefile..."
-	RET=1
-fi
-
-echo " "
-echo "Ext4 online defrag test"
-echo "The output of defrag program is in the file"\
-	"LTPROOT/output/ext4_online_defrag.txt"
-if [ -f "ext4_online_defrag_test.sh" ]; then
-	./ext4_online_defrag_test.sh ./ext4-test-config
-	if [ $? -ne 0 ]; then
-		RET=1
-	fi
-else
-	echo "Shell file is not installed..Please check Makefile..."
-	RET=1
-fi
-
-exit $RET
-- 
1.8.2.1


------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121051231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
