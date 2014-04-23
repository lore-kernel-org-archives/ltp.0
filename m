Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WctLW-0000eK-Eq
	for ltp-list@lists.sourceforge.net; Wed, 23 Apr 2014 09:20:02 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WctLR-00047q-SH
	for ltp-list@lists.sourceforge.net; Wed, 23 Apr 2014 09:20:01 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s3N9JoXd027306
	for <ltp-list@lists.sourceforge.net>; Wed, 23 Apr 2014 17:19:50 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Wed, 23 Apr 2014 17:17:45 +0800
Message-ID: <1398244665-9574-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] fs/ext4-new-features: cleanup
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
To: ltp-list@lists.sourceforge.net

Using the tst_* interface provided by shell library test.sh and
do some bashism fixes.

Update README.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 testcases/kernel/fs/ext4-new-features/README       | 34 ++--------
 .../ext4-delalloc-mballoc/ext4-alloc-test.sh       | 47 +++++--------
 .../ext4-inode-version/ext4_inode_version_test.sh  | 76 +++++-----------------
 .../ext4-journal-checksum/ext4_journal_checksum.sh | 32 +++------
 .../ext4_nsec_timestamps_test.sh                   | 71 ++++++++------------
 .../ext4-online-defrag/ext4_online_defrag_test.sh  | 54 +++++----------
 .../ext4_persist_prealloc_test.sh                  | 42 +++---------
 .../ext4-subdir-limit/ext4_subdir_limit_test.sh    | 39 ++++-------
 .../ext4-uninit-groups/ext4_uninit_groups_test.sh  | 47 ++++---------
 .../kernel/fs/ext4-new-features/ext4_funcs.sh      | 17 +++--
 10 files changed, 137 insertions(+), 322 deletions(-)

diff --git a/testcases/kernel/fs/ext4-new-features/README b/testcases/kernel/fs/ext4-new-features/README
index bda16e5..2470d24 100644
--- a/testcases/kernel/fs/ext4-new-features/README
+++ b/testcases/kernel/fs/ext4-new-features/README
@@ -24,24 +24,21 @@ The aim of the tests is to test ext4 new features.
 
 TEST STEPS:
 # cd LTPROOT/testcases/kernel/fs/ext4-new-features
-# ./configure
 # make
 # make install
 # cd LTPROOT
-# ./runltp -f fs_ext4
-
-**This testsuite wouldn't be built when doing LTP default build. We MUST do it
-  by ourself.
+# ./runltp -f fs_ext4 -z 'big unmounted block device partition'
 
 
 NOTE:
 
 1. This test can be run by root only.
-2. Your MUST run *configure* in this directory to config the tool of ffsb and
-   specify a partition to be used for test before compiling the tool, and be
-   CAREFUL the data on the specified partition would be DESTROYED. It is better
-   that the size of partition is between 5G and 10G. If the partition is too
-   big, the test will spend much time. It is unnecessary.
+2. These ext4 new features tests need a big unmounted block device partition, so
+   you MUST run runltp with "-z" option to specify such a big block device, if not,
+   these tests will exit with TCONF simply and be CAREFUL the data on the specified
+   partition would be DESTROYED. It is better that the size of partition is between
+   5G and 10G. If the partition is too big, the test will spend much time. It is
+   unnecessary.
 3. Before starting test ext4 new features, please check whether ext4 filesystem
    is compiled into the kernel or not, and the kernel version is *2.6.31* or
    above.
@@ -65,12 +62,6 @@ NOTE:
 
 FILES DESCRIPTION:
 
-configure
----------
-This is a config script that is used to configure the ffsb tool and specify a
-partition for test. And the data on the specified partition would be destroyed.
-Be careful! Beside that, you MUST run this script before compile the testcases.
-
 ext4-delalloc-mballoc
 ---------------------
 Directory containing the shell script which is used to test multi-block
@@ -116,21 +107,11 @@ ext4-uninit-groups
 Directory containing the shell script which is used to test uninitialized groups
 feature of ext4.
 
-ffsb-6.0-rc2
-------------
-This directory contains The Flexible Filesystem Benchmark (FFSB) tool. We use
-this tool to create some files to fill the test partition. This tool was written
-by Sonny Rao(raosanth@us.ibm.com).
-
 ext4_funcs.sh
 -------------
 This script contains some functions for ext4 new features test script.
 such as: ext4_setup, ext4_cleanup
 
-run_ext4_test.sh
-----------------
-This script runs all the 119 testcases.
-
 Makefile
 --------
 Each directory in this directory has its usual makefile, it is for its
@@ -139,4 +120,3 @@ directory.
 README
 ------
 The one you have gone through.
-
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh b/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh
index 55ea6ae..1ffba13 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh
@@ -20,16 +20,10 @@
 #                                                                              #
 ################################################################################
 
-cd $LTPROOT/testcases/bin
-
-. ./ext4_funcs.sh
-
 export TCID="ext4-delalloc-mballoc"
 export TST_TOTAL=17
-export TST_COUNT=1
-
-export TEST_DIR=$PWD
 
+. ext4_funcs.sh
 
 # Case 17: mount ext4 partition to ext3
 ext4_test_remount()
@@ -37,20 +31,20 @@ ext4_test_remount()
 	mkfs.ext3 -I 256 -b 1024 $EXT4_DEV &> /dev/null
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "failed to create ext4 filesystem"
-		return 1
+		return
 	fi
 
 	mount -t ext4 -o delalloc,auto_da_alloc $EXT4_DEV mnt_point
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "failed to mount ext4 filesystem"
-		return 1
+		return
 	fi
 
-	./ffsb ffsb-config0 > /dev/null
+	ffsb ffsb-config0 > /dev/null
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "ffsb returned failure"
 		umount mnt_point
-		return 1
+		return
 	fi
 
 	umount mnt_point
@@ -62,14 +56,14 @@ ext4_test_remount()
 	mount -t ext3 $EXT4_DEV mnt_point
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "failed to mount to ext3"
-		return 1
+		return
 	fi
 	umount mnt_point
 
 	fsck -p $EXT4_DEV &> /dev/null
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "fsck returned failure"
-		return 1
+		return
 	fi
 
 	tst_resm TPASS "remount test pass"
@@ -87,7 +81,7 @@ ext4_test_delalloc_mballoc()
 	mkfs.ext4 -I 256 -b $3 /$EXT4_DEV &> /dev/null
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "failed to create ext4 filesystem"
-		return 1
+		return
 	fi
 
 	tune2fs -O extents $EXT4_DEV &> /dev/null
@@ -95,26 +89,26 @@ ext4_test_delalloc_mballoc()
 	mount -t ext4 -o $1,$4 $EXT4_DEV mnt_point
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "failed to mount ext4 filesystem"
-		return 1
+		return
 	fi
 
-	./ffsb ffsb-config$2 > /dev/null
+	ffsb ffsb-config$2 > /dev/null
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "ffsb returned failure"
 		umount mnt_point
-		return 1
+		return
 	fi
 
 	umount mnt_point
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "failed to umount ext4 filesystem"
-		return 1
+		return
 	fi
 
 	fsck -p $EXT4_DEV &> /dev/null
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "fsck returned failure"
-		return 1
+		return
 	fi
 
 	tst_resm TPASS "delalloc/mballoc test pass"
@@ -123,13 +117,13 @@ ext4_test_delalloc_mballoc()
 # main
 ext4_setup
 
+tst_check_cmds ffsb
+
 DELALLOC=( "delalloc" "nodelalloc" )
 DIRECT_IO=( 0 1 )
 BLOCK_SIZE=( 1024 4096 )
 BLOCK_AUTO_DA_ALLOC=( "auto_da_alloc=1" "noauto_da_alloc" )
 
-RET=0
-
 for ((i = 0; i < 2; i++))
 {
 	for ((j = 0; j < 2; j++))
@@ -142,20 +136,11 @@ for ((i = 0; i < 2; i++))
 						${DIRECT_IO[$j]} \
 						${BLOCK_SIZE[$i]} \
 						${BLOCK_AUTO_DA_ALLOC[$l]}
-				if [ $? -ne 0 ]; then
-					RET=1
-				fi
-				: $((TST_COUNT++))
 			}
 		}
 	}
 }
 
 ext4_test_remount
-if [ $? -ne 0 ]; then
-	RET=1
-fi
-
-ext4_cleanup
 
-exit $RET
+tst_exit
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh
index 18c1d20..ac8f021 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh
@@ -23,15 +23,10 @@
 ##                                                                            ##
 ################################################################################
 
-cd $LTPROOT/testcases/bin
-
-. ./ext4_funcs.sh
-
 export TCID="ext4-inode-version"
 export TST_TOTAL=8
-export TST_COUNT=1
 
-export TEST_DIR=$PWD
+. ext4_funcs.sh
 
 # Test that inode version is not 32 bits with 128 inode size
 ext4_test_128_inode_version()
@@ -41,7 +36,7 @@ ext4_test_128_inode_version()
 	mkfs.ext4 -I 128 $EXT4_DEV &> /dev/null
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "failed to create ext4 filesystem"
-		return 1
+		return
 	fi
 
 	tune2fs -O extents $EXT4_DEV &> /dev/null
@@ -49,18 +44,18 @@ ext4_test_128_inode_version()
 	mount -t ext4 -o i_version $EXT4_DEV mnt_point
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "failed to mount ext4 filesystem"
-		return 1
+		return
 	fi
 
 	# inode version > 0
 	touch mnt_point/tmp_file
 	sync
-	version=`./ext4_get_inode_version.sh tmp_file`
+	version=`ext4_get_inode_version.sh tmp_file`
 
 	if [ $version -lt 1 ]; then
 		tst_resm TFAIL "inode version is smaller than 1"
 		umount mnt_point
-		return 1
+		return
 	fi
 
 	# inode version is 32 bits: 0x00000000
@@ -72,13 +67,13 @@ ext4_test_128_inode_version()
 	if [ $len -ne 8 ]; then
 		tst_resm TFAIL "inode version is not 32 bits"
 		umount mnt_point
-		return 1
+		return
 	fi
 
 	umount mnt_point
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "failed to umount ext4 filesystem"
-		return 1
+		return
 	fi
 
 	tst_resm TPASS "32 bits inode version with 128 inode size test pass"
@@ -91,50 +86,50 @@ test_inode_version()
 	mkfs.ext3 -I 256 $EXT4_DEV &> /dev/null
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "failed to create ext4 filesystem"
-		return 1
+		return
 	fi
 
 	mount -t ext4 -o i_version $EXT4_DEV mnt_point
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "failed to mount ext4 filesystem"
-		return 1
+		return
 	fi
 
 	# Check the inode version after some file operation
-	old_version=`./ext4_test_inode_version $1 mnt_point/tmp_file tmp_file`
+	old_version=`ext4_test_inode_version $1 mnt_point/tmp_file tmp_file`
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "inode version is wrong"
 		umount mnt_point
-		return 1
+		return
 	fi
 
 	umount mnt_point
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "failed to umount ext4 filesystem"
-		return 1
+		return
 	fi
 
 	# Test mount to ext3 and then mount back to ext4
 	mount -t ext3 $EXT4_DEV mnt_point
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "failed to mount to ext3"
-		return 1
+		return
 	fi
 	umount mnt_point
 
 	mount -t ext4 $EXT4_DEV mnt_point
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "failed to mount back to ext4"
-		return 1
+		return
 	fi
 
-	version=`./ext4_get_inode_version.sh tmp_file`
+	version=`ext4_get_inode_version.sh tmp_file`
 #	echo "remount: old - $old_version"
 #	echo "remount: new - $version"
 	if [ $old_version -ne $version ]; then
 		tst_resm TFAIL "inode version has changed unexpected"
 		umount mnt_point
-		return 1
+		return
 	else
 		tst_resm TPASS "inode version with 256 inode size test pass"
 		umount mnt_point
@@ -144,57 +139,20 @@ test_inode_version()
 # main
 ext4_setup
 
-RET=0
-
 ext4_test_128_inode_version
-if [ $? -ne 0 ]; then
-	RET=1
-fi
-: $((TST_COUNT++))
 
 test_inode_version create
-if [ $? -ne 0 ]; then
-	RET=1
-fi
-: $((TST_COUNT++))
 
 test_inode_version chmod
-if [ $? -ne 0 ]; then
-	RET=1
-fi
-: $((TST_COUNT++))
 
 test_inode_version chown
-if [ $? -ne 0 ]; then
-	RET=1
-fi
-: $((TST_COUNT++))
 
 test_inode_version read
-if [ $? -ne 0 ]; then
-	RET=1
-fi
-: $((TST_COUNT++))
 
 test_inode_version write
-if [ $? -ne 0 ]; then
-	RET=1
-fi
-: $((TST_COUNT++))
 
 test_inode_version mmap_read
-if [ $? -ne 0 ]; then
-	RET=1
-fi
-: $((TST_COUNT++))
 
 test_inode_version mmap_write
-if [ $? -ne 0 ]; then
-	RET=1
-fi
-: $((TST_COUNT++))
-
-ext4_cleanup
-
-exit $RET
 
+tst_exit
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh b/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh
index 3a0f26a..c776fc9 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh
@@ -23,16 +23,11 @@
 ##                                                                            ##
 ################################################################################
 
-cd $LTPROOT/testcases/bin
-
-. ./ext4_funcs.sh
 
 export TCID="ext4-journal-checksum"
 export TST_TOTAL=36
-export TST_COUNT=1
-
-export TEST_DIR=$PWD
 
+. ext4_funcs.sh
 
 # Use ffsb to test journal checksumming
 # $1: journal mode: writeback, ordered, journal
@@ -63,7 +58,7 @@ ext4_test_journal_checksum()
 	mkfs.ext4 -I 256 $EXT4_DEV &> /dev/null
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "failed to create ext4 filesystem"
-		return 1
+		return
 	fi
 
 	tune2fs -O extents $EXT4_DEV &> /dev/null
@@ -71,26 +66,26 @@ ext4_test_journal_checksum()
 	mount -t ext4 -o data=$1,commit=$2,$3,$4,barrier=$5 $EXT4_DEV mnt_point
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "failed to mount ext4 filesystem"
-		return 1
+		return
 	fi
 
-	./ffsb ffsb-config2 > /dev/null
+	ffsb ffsb-config2 > /dev/null
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "ffsb returned failure"
 		umount mnt_point
-		return 1
+		return
 	fi
 
 	umount mnt_point
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "failed to umount ext4 filesystem"
-		return 1
+		return
 	fi
 
 	e2fsck -p $EXT4_DEV &> /dev/null
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "fsck returned failure"
-		return 1
+		return
 	fi
 
 	tst_resm TPASS "ext4 journal checksum test pass"
@@ -99,14 +94,14 @@ ext4_test_journal_checksum()
 # main
 ext4_setup
 
+tst_check_cmds ffsb
+
 DATA=( "writeback" "ordered" "journal" )
 COMMIT=( 1 100 )
 JOURNAL_CHECKSUM=( "journal_checksum" "" )
 JOURNAL_ASYNC_COMMIT=( "journal_async_commit" "" )
 BARRIER=( 0 1 )
 
-RET=0
-
 for ((i = 0; i < 2; i++))
 {
 	for ((j = 0; j < 2; j++))
@@ -129,17 +124,10 @@ for ((i = 0; i < 2; i++))
 						"${JOURNAL_CHECKSUM[$k]}" \
 						"${JOURNAL_ASYNC_COMMIT[$j]}" \
 						${BARRIER[$i]}
-					if [ $? -ne 0 ]; then
-						RET=1
-					fi
-
-					: $((TST_COUNT++))
 				}
 			}
 		}
 	}
 }
 
-ext4_cleanup
-
-exit $RET
+tst_exit
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
index 0730e87..ec1c6a3 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
@@ -23,16 +23,10 @@
 ##                                                                            ##
 ################################################################################
 
-cd $LTPROOT/testcases/bin
-
-. ./ext4_funcs.sh
-
 export TCID="ext4-nsec-timestamps"
 export TST_TOTAL=2
-export TST_COUNT=1
-
 
-TEST_DIR=$PWD
+. ext4_funcs.sh
 
 # Test that file timestamps is second with 128 inode size
 ext4_test_sec_timestamps()
@@ -42,7 +36,7 @@ ext4_test_sec_timestamps()
 	mkfs.ext4 -I 128 $EXT4_DEV &> /dev/null
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "failed to create ext4 filesystem"
-		return 1
+		return
 	fi
 
 	tune2fs -O extents $EXT4_DEV &> /dev/null
@@ -50,26 +44,26 @@ ext4_test_sec_timestamps()
 	mount -t ext4 $EXT4_DEV mnt_point
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "failed to mount ext4 filesystem"
-		return 1
+		return
 	fi
 
 	touch mnt_point/tmp_file
 
-	atime=`./ext4_file_time mnt_point/tmp_file atime nsec`
-	mtime=`./ext4_file_time mnt_point/tmp_file mtime nsec`
-	ctime=`./ext4_file_time mnt_point/tmp_file ctime nsec`
+	atime=`ext4_file_time mnt_point/tmp_file atime nsec`
+	mtime=`ext4_file_time mnt_point/tmp_file mtime nsec`
+	ctime=`ext4_file_time mnt_point/tmp_file ctime nsec`
 
 	if [ $atime -ne 0 -o $mtime -ne 0 -o $ctime -ne 0 ]; then
 		tst_resm TFAIL "Timestamp is not second(atime: $atime, mtime: \
 				$mtime, ctime: $ctime)"
 		umount mnt_point
-		return 1
+		return
 	fi
 
 	umount mnt_point
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "failed to umount ext4 filesystem"
-		return 1
+		return
 	fi
 
 	tst_resm TPASS "Ext4 nanosecond timestamps test with 128 inode size pass"
@@ -83,13 +77,13 @@ ext4_test_nsec_timestamps()
 	mkfs.ext3 -I 256 $EXT4_DEV &> /dev/null
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "failed to create ext4 filesystem"
-		return 1
+		return
 	fi
 
 	mount -t ext4 $EXT4_DEV mnt_point
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "failed to mount ext4 filesystem"
-		return 1
+		return
 	fi
 
 	# Create file
@@ -103,19 +97,19 @@ ext4_test_nsec_timestamps()
 	sec=`echo $cur_time | awk {'print $1'}`
 	nsec=`echo $cur_time | awk {'print $2'}`
 
-	sec_atime=`./ext4_file_time mnt_point/tmp_file atime sec`
-	sec_mtime=`./ext4_file_time mnt_point/tmp_file mtime sec`
-	sec_ctime=`./ext4_file_time mnt_point/tmp_file ctime sec`
-	nsec_atime=`./ext4_file_time mnt_point/tmp_file atime nsec`
-	nsec_mtime=`./ext4_file_time mnt_point/tmp_file mtime nsec`
-	nsec_ctime=`./ext4_file_time mnt_point/tmp_file ctime nsec`
+	sec_atime=`ext4_file_time mnt_point/tmp_file atime sec`
+	sec_mtime=`ext4_file_time mnt_point/tmp_file mtime sec`
+	sec_ctime=`ext4_file_time mnt_point/tmp_file ctime sec`
+	nsec_atime=`ext4_file_time mnt_point/tmp_file atime nsec`
+	nsec_mtime=`ext4_file_time mnt_point/tmp_file mtime nsec`
+	nsec_ctime=`ext4_file_time mnt_point/tmp_file ctime nsec`
 
 	# Test nanosecond
 	if [ $nsec_atime -eq 0 -a $nsec_mtime -eq 0 -a $nsec_ctime -eq 0 ]
 	then
 		tst_resm TFAIL "The timestamp is not nanosecond(nsec_atime: $nsec_atime, nsec_mtime: $nsec_mtime, nsec_ctime: $nsec_ctime)"
 		umount mnt_point
-		return 1
+		return
 	fi
 
 	diff1=$(( $sec_atime - $sec ))
@@ -129,32 +123,32 @@ ext4_test_nsec_timestamps()
 			sec_mtime: $sec_mtime, sec_ctime: $sec_ctime, \
 			cur_time[s]: $sec)"
 		umount mnt_point
-		return 1
+		return
 	fi
 
 	umount mnt_point
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "failed to umount ext4 filesystem"
-		return 1
+		return
 	fi
 
 	# Test mount to ext3 and then mount back to ext4
 	mount -t ext3 $EXT4_DEV mnt_point
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "failed to mount to ext3"
-		return 1
+		return
 	fi
 	umount mnt_point
 
 	mount -t ext4 $EXT4_DEV mnt_point
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "failed to mount back to ext4"
-		return 1
+		return
 	fi
 
-	nsec_atime2=`./ext4_file_time mnt_point/tmp_file atime nsec`
-	nsec_mtime2=`./ext4_file_time mnt_point/tmp_file mtime nsec`
-	nsec_ctime2=`./ext4_file_time mnt_point/tmp_file mtime nsec`
+	nsec_atime2=`ext4_file_time mnt_point/tmp_file atime nsec`
+	nsec_mtime2=`ext4_file_time mnt_point/tmp_file mtime nsec`
+	nsec_ctime2=`ext4_file_time mnt_point/tmp_file mtime nsec`
 
 	if [ $nsec_atime -ne $nsec_atime2 -o $nsec_ctime -ne $nsec_ctime2 -o \
 	     $nsec_mtime -ne $nsec_mtime2 ]; then
@@ -163,7 +157,7 @@ ext4_test_nsec_timestamps()
 			$nsec_mtime $nsec_ctime, After[atime mtime ctime]: \
 			$nsec_atime2 $nsec_mtime2 $nsec_ctime2)"
 		umount mnt_point
-		return 1
+		return
 	fi
 
 	umount mnt_point
@@ -173,20 +167,7 @@ ext4_test_nsec_timestamps()
 # main
 ext4_setup
 
-RET=0
-
 ext4_test_sec_timestamps
-if [ $? -ne 0 ]; then
-	RET=1
-fi
-: $((TST_COUNT++))
-
 ext4_test_nsec_timestamps
-if [ $? -ne 0 ]; then
-	RET=1
-fi
-: $((TST_COUNT++))
-
-ext4_cleanup
-exit $RET
 
+tst_exit
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-online-defrag/ext4_online_defrag_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-online-defrag/ext4_online_defrag_test.sh
index 28ba161..ab450a8 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-online-defrag/ext4_online_defrag_test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-online-defrag/ext4_online_defrag_test.sh
@@ -20,15 +20,10 @@
 #                                                                              #
 ################################################################################
 
-cd $LTPROOT/testcases/bin
-
-. ./ext4_funcs.sh
-
 export TCID="ext4-online-defrag"
 export TST_TOTAL=18
-export TST_COUNT=1
 
-export TEST_DIR=$PWD
+. ext4_funcs.sh
 
 # How to age filesystem
 EMPTY=1
@@ -39,11 +34,9 @@ LARGE=3
 FILE=1
 DIR=2
 FILESYSTEM=3
+
+tst_check_cmds e4defrag
 E4DEFRAG=`which e4defrag`
-if [ -z $E4DEFRAG ]; then
-	echo "Please install the e2fsprogs, for the e4defrag command."
-	exit 1
-fi
 
 age_filesystem()
 {
@@ -65,7 +58,7 @@ age_filesystem()
 		# age filesystem from 0.0 to 0.2 -> 0.4 -> 0.6 -> 0.8 -> 1.0
 		for ((idx = 3; idx < 8; idx++))
 		{
-			./ffsb ffsb-config$idx > /dev/null
+			ffsb ffsb-config$idx > /dev/null
 			dirId=$((idx - 3))
 			mv mnt_point/data mnt_point/data$dirId
 		}
@@ -123,47 +116,43 @@ my_e4defrag()
 # $3: block size
 ext4_test_online_defrag()
 {
-	echo Test $TST_COUNT start >> \
-		 $LTPROOT/output/ext4_online_defrag_result.txt
+	echo Test $TST_COUNT start >> ext4_online_defrag_result.txt
 
 	tst_resm TINFO "defrag type: $1, defrag obj: $2, block size: $3"
 
-	mkfs.ext4 -m 0 -b $3 -O ^flex_bg $EXT4_DEV >> \
-		$LTPROOT/output/ext4_online_defrag_result.txt 2>&1
+	mkfs.ext4 -m 0 -b $3 -O ^flex_bg $EXT4_DEV >> ext4_online_defrag_result.txt 2>&1
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "failed to create ext4 filesystem"
-		return 1
+		return
 	fi
 
-	tune2fs -O extents $EXT4_DEV >> \
-		 $LTPROOT/output/ext4_online_defrag_result.txt 2>&1
+	tune2fs -O extents $EXT4_DEV >> ext4_online_defrag_result.txt 2>&1
 
 	mount -t ext4 -o nodelalloc $EXT4_DEV mnt_point
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL"failed to mount ext4 filesystem"
-		return 1
+		return
 	fi
 
-	age_filesystem $2 $1 >> $LTPROOT/output/ext4_online_defrag_result.txt 2>&1
+	age_filesystem $2 $1 >> ext4_online_defrag_result.txt 2>&1
 
-	my_e4defrag $1 $2 >> $LTPROOT/output/ext4_online_defrag_result.txt
+	my_e4defrag $1 $2 >> ext4_online_defrag_result.txt
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "e4defrag returned failure"
 		umount mnt_point
-		return 1
+		return
 	fi
 
 	umount mnt_point
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "failed to umount ext4 filesystem"
-		return 1
+		return
 	fi
 
-	e2fsck -p $EXT4_DEV >> \
-		 $LTPROOT/output/ext4_online_defrag_result.txt 2>&1
+	e2fsck -p $EXT4_DEV >> ext4_online_defrag_result.txt 2>&1
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "fsck returned failure"
-		return 1
+		return
 	fi
 
 	tst_resm TPASS "ext4 online defrag test pass"
@@ -172,14 +161,12 @@ ext4_test_online_defrag()
 # main
 ext4_setup
 
-rm -f $LTPROOT/output/ext4_online_defrag_result.txt
+tst_check_cmds ffsb
 
 DEFRAG=( $FILE $DIR $FILESYSTEM )
 AGING=( $EMPTY $SMALL $LARGE )
 BLOCK_SIZE=( 1024 4096 )
 
-RET=0
-
 for ((i = 0; i < 2; i++))
 {
 	for ((j = 0; j < 3; j++))
@@ -188,15 +175,8 @@ for ((i = 0; i < 2; i++))
 		{
 			ext4_test_online_defrag ${DEFRAG[$j]} ${AGING[$k]} \
 						${BLOCK_SIZE[$i]}
-			if [ $? -ne 0 ]; then
-				RET=1
-			fi
-			: $((TST_COUNT++))
 		}
 	}
 }
 
-ext4_cleanup
-
-exit $RET
-
+tst_exit
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh
index 92b27c1..20b66f8 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh
@@ -23,18 +23,10 @@
 ##                                                                            ##
 ################################################################################
 
-cd $LTPROOT/testcases/bin
-
-. ./ext4_funcs.sh
-
 export TCID="ext4-persistent-preallocation"
 export TST_TOTAL=2
-export TST_COUNT=1
 
-export TEST_DIR=$PWD
-
-# The test path of fallocate
-export TMPDIR=$PWD/mnt_point/
+. ext4_funcs.sh
 
 # Use ltp's syscall/fallocate to test this feature
 # $1: 1024 or 4096
@@ -43,45 +35,45 @@ ext4_test_persist_prealloc()
 	mkfs.ext4 -I 256 -b $1 $EXT4_DEV &> /dev/null
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "failed to create ext4 filesystem"
-		return 1
+		return
 	fi
 
 	mount -t ext4 $EXT4_DEV mnt_point
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "failed to mount ext4 filesystem"
-		return 1
+		return
 	fi
 
 	ret=1
 
 	for ((i = 1; i <= 3; i++))
 	{
-		if [ ! -f fallocate0${i} ];  then
+		if ! command -v fallocate0${i} > /dev/null 2>&1; then
 			tst_resm TFAIL "file - fallocate0${i} doesn't exist. Please \
 				check whether it was compiled and installed.\
 				(Path: LTPROOT/testcases/kernel/syscalls/fallocate)"
 			umount mnt_point
-			return 1
+			return
 		fi
 
-		./fallocate0${i} | grep -q "CONF"
+		fallocate0${i} | grep -q "CONF"
 		if [ $? -ne $ret ]; then
 			tst_resm TFAIL "fallocate's return value is not expected"
 			umount mnt_point
-			return 1
+			return
 		fi
 	}
 
 	umount mnt_point
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "failed to umount ext4 filesystem"
-		return 1
+		return
 	fi
 
 	e2fsck -p $EXT4_DEV &> /dev/null
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "fsck returned failure"
-		return 1
+		return
 	fi
 
 	tst_resm TPASS "ext4 persistent preallocation test pass"
@@ -90,21 +82,7 @@ ext4_test_persist_prealloc()
 # main
 ext4_setup
 
-RET=0
-
 ext4_test_persist_prealloc 1024
-if [ $? -ne 0 ]; then
-	RET=1;
-fi
-: $((TST_COUNT++))
-
 ext4_test_persist_prealloc 4096
-if [ $? -ne 0 ]; then
-	RET=1;
-fi
-: $((TST_COUNT++))
-
-ext4_cleanup
-
-exit $RET
 
+tst_exit
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh
index 47807b1..3162d67 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh
@@ -23,16 +23,12 @@
 ##                                                                            ##
 ################################################################################
 
-cd $LTPROOT/testcases/bin
-
-. ./ext4_funcs.sh
 
 export TCID="ext4-subdir-limit"
 export TST_TOTAL=10
-export TST_COUNT=1
 
+. ext4_funcs.sh
 
-TEST_DIR=$PWD
 SHORT_DIR=1
 LONG_DIR=2
 
@@ -66,7 +62,7 @@ ext4_run_case()
 		mkfs.ext4 -b $4 -I 256 $EXT4_DEV &> /dev/null
 		if [ $? -ne 0 ]; then
 			tst_resm TFAIL "failed to create ext4 filesystem"
-			return 1
+			return
 		fi
 		prev_block_size=$4
 
@@ -79,23 +75,23 @@ ext4_run_case()
 	mount -t ext4 $EXT4_DEV mnt_point
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "failed to mount ext4 filesystem"
-		return 1
+		return
 	fi
 
 	# create directories
 	mkdir -p $3 2> /dev/null
 
 	if [ $2 -eq $SHORT_DIR ]; then
-		./create_short_dirs $1 $3
+		create_short_dirs $1 $3
 	else
-		./create_long_dirs $1 $3
+		create_long_dirs $1 $3
 	fi
 
 	if [ $? -ne 0 ]; then
 		nr_dirs=`ls $3 | wc -l`
 		tst_resm TFAIL "failed to create directories - $nr_dirs"
 		umount mnt_point
-		return 1
+		return
 	fi
 
 	# delete directories
@@ -103,32 +99,31 @@ ext4_run_case()
 	ls | xargs rmdir
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "failed to remove directories"
-
-		cd $TEST_DIR
+		cd -
 		umount mnt_point
-		return 1
+		return
 	fi
-	cd $TEST_DIR
+	cd -
 
 	# unmount ext4 filesystem
 	umount mnt_point
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "failed to umount ext4 filesystem"
-		return 1
+		return
 	fi
 
 	# run fsck to make sure the filesystem has no errors
 	e2fsck -p $EXT4_DEV &> /dev/null
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "fsck: the filesystem has errors"
-		return 1
+		return
 	fi
 
 	# check dir_nlink is set
 	dumpe2fs $EXT4_DEV 2> /dev/null | grep '^Filesystem features' | grep -q dir_nlink
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "feature dir_nlink is not set"
-		return 1
+		return
 	fi
 
 	prev_result=$PASS
@@ -142,8 +137,6 @@ DIR_LEN=( $SHORT_DIR $LONG_DIR )
 PARENT_DIR=( "mnt_point" "mnt_point/sub" )
 BLOCK_SIZE=( 1024 2048 4096 )
 
-RET=0
-
 for ((i = 0; i < 3; i++))
 {
 	for ((j = 0; j < 2; j++))
@@ -156,14 +149,8 @@ for ((i = 0; i < 3; i++))
 			fi
 			ext4_run_case 65537 ${DIR_LEN[$k]} ${PARENT_DIR[$j]} \
 					${BLOCK_SIZE[$i]}
-			if [ $? -ne 0 ]; then
-				RET=1
-			fi
-			: $((TST_COUNT++))
 		}
 	}
 }
 
-ext4_cleanup
-
-exit $RET
+tst_exit
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh
index b21d262..c8de206 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh
@@ -20,41 +20,27 @@
 #                                                                              #
 ################################################################################
 
-cd $LTPROOT/testcases/bin
-
-. ./ext4_funcs.sh
-
 export TCID="ext4-uninit-groups"
 export TST_TOTAL=24
-export TST_COUNT=1
 
-export TEST_DIR=$PWD
+. ext4_funcs.sh
 
 # How to age filesystem
 EMPTY=1
 SMALL=2
 LARGE=3
 
-# filesystem free size in bytes: blocks_size * free_blocks
-filesystem_free_size()
-{
-	bsize=`dumpe2fs -h $EXT4_DEV 2> /dev/null | grep 'Block size' | awk '{ print $2 }'`
-	blocks=`dumpe2fs -h $EXT4_DEV 2> /dev/null | grep 'Free blocks'| awk '{ print $2 }'`
-
-	echo $bsize * $blocks
-}
-
 age_filesystem()
 {
 	if [ $1 -eq $EMPTY ]; then
 		# aging, then del
-		./ffsb ffsb-config3 > /dev/null
+		ffsb ffsb-config3 > /dev/null
 		rm -rf mnt_point/*
 	elif [ $1 -eq $SMALL ]; then
 		# age filesystem from 0.0 to 0.2 -> 0.4 -> 0.6 -> 0.8 -> 1.0
 		for ((n = 3; n < 8; n++))
 		{
-			./ffsb ffsb-config$n > /dev/null
+			ffsb ffsb-config$n > /dev/null
 			mv mnt_point/data mnt_point/data$n
 		}
 	elif [ $1 -eq $LARGE ]; then
@@ -78,12 +64,12 @@ age_filesystem()
 # $4: age filesystem: $EMPTY, $SMALL, $LARGE
 ext4_test_uninit_groups()
 {
-	echo "Test $TST_COUNT" >> $LTPROOT/output/ext4_uninit_groups_result.txt
+	echo "Test $TST_COUNT" >> ext4_uninit_groups_result.txt
 
 	mkfs.ext4 -I 256 -m 0 $EXT4_DEV &> /dev/null
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "failed to create ext4 filesystem"
-		return 1
+		return
 	fi
 
 	if [ $3 == "no_flex_bg" ]; then
@@ -100,26 +86,26 @@ ext4_test_uninit_groups()
 	mount -t ext4 -o $1,$2 $EXT4_DEV mnt_point
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "failed to mount ext4 filesystem"
-		return 1
+		return
 	fi
 
-	age_filesystem $4 >> $LTPROOT/output/ext4_uninit_groups_result.txt 2>&1
+	age_filesystem $4 >> ext4_uninit_groups_result.txt 2>&1
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "age filesystem failed"
 		umount mnt_point
-		return 1
+		return
 	fi
 
 	umount mnt_point
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "failed to umount ext4 filesystem"
-		return 1
+		return
 	fi
 
 	fsck -p $EXT4_DEV &> /dev/null
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "fsck returned failure"
-		return 1
+		return
 	fi
 
 	tst_resm TPASS "ext4 uninit groups test pass"
@@ -128,14 +114,13 @@ ext4_test_uninit_groups()
 # main
 ext4_setup
 
+tst_check_cmds ffsb
+
 ORLOV=( "orlov" "oldalloc" )
 DELALLOC=( "delalloc" "nodelalloc" )
 FLEX_BG=( "flex_bg" "no_flex_bg" )
 AGING=( $EMPTY $SMALL $LARGE )
 
-RET=0
-
-rm -f $LTPROOT/output/ext4_uninit_groups_result.txt
 
 for ((i = 0; i < 2; i++))
 {
@@ -149,15 +134,9 @@ for ((i = 0; i < 2; i++))
 							${DELALLOC[$j]} \
 							${FLEX_BG[$k]} \
 							${AGING[$l]}
-				if [ $? -ne 0 ]; then
-					RET=1
-				fi
-				: $((TST_COUNT++))
 			}
 		}
 	}
 }
 
-ext4_cleanup
-
-exit $RET
+tst_exit
diff --git a/testcases/kernel/fs/ext4-new-features/ext4_funcs.sh b/testcases/kernel/fs/ext4-new-features/ext4_funcs.sh
index db289ca..0ae534a 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4_funcs.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4_funcs.sh
@@ -23,14 +23,13 @@
 ##                                                                            ##
 ################################################################################
 
-. cmdlib.sh
+. test.sh
 
 ext4_setup()
 {
 	tst_kvercmp 2 6 31
 	if [ $? -eq 0 ]; then
-		tst_brkm TCONF ignored "kernel is below 2.6.31"
-		exit 0
+		tst_brkm TCONF "kernel is below 2.6.31"
 	fi
 
 	tst_require_root
@@ -39,24 +38,24 @@ ext4_setup()
 	if [ "$EXT4_KERNEL_SUPPORT" != "ext4" ]; then
 		modprobe ext4 > /dev/null 2>&1
 		if [ $? -ne 0 ]; then
-			tst_brkm TCONF ignored "Ext4 is not supported"
-			exit 0
+			tst_brkm TCONF "Ext4 is not supported"
 		fi
 	fi
 
-	exists ffsb
-
 	if [ -z "$LTP_BIG_DEV" ];then
-		tst_brkm TCONF ignored "tests need a big block device(5G-10G)"
-		exit 0
+		tst_brkm TCONF "tests need a big block device(5G-10G)"
 	else
 		EXT4_DEV=$LTP_BIG_DEV
 	fi
 
+	tst_tmpdir
+	TST_CLEANUP=ext4_cleanup
+
 	mkdir mnt_point
 }
 
 ext4_cleanup()
 {
 	rm -rf mnt_point
+	tst_rmdir
 }
-- 
1.8.2.1


------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
