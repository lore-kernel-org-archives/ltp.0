Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1VjShC-00065h-E3
	for ltp-list@lists.sourceforge.net; Thu, 21 Nov 2013 11:45:18 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VjSh8-0004AP-RO
	for ltp-list@lists.sourceforge.net; Thu, 21 Nov 2013 11:45:18 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id rALBj7xd017160
	for <ltp-list@lists.sourceforge.net>; Thu, 21 Nov 2013 19:45:07 +0800
Message-ID: <528DF23E.9080503@cn.fujitsu.com>
Date: Thu, 21 Nov 2013 19:45:02 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 3/3] fs/ext4-new-features: add ext4-new-features tests
 to the, default
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


currently enable ext4-nsec-timestamps, ext4-persist-prealloc,
ext4-subdir-limit, ext4-uninit-groups test.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 runtest/fs_ext4                                    |  5 ++-
 .../ext4-delalloc-mballoc/ext4-alloc-test.sh       |  5 +--
 .../ext4-inode-version/ext4_inode_version_test.sh  |  6 +---
 .../ext4-journal-checksum/ext4_journal_checksum.sh |  5 +--
 .../ext4_nsec_timestamps_test.sh                   |  4 +--
 .../ext4-online-defrag/ext4_online_defrag_test.sh  |  5 +--
 .../ext4_persist_prealloc_test.sh                  |  5 +--
 .../ext4-subdir-limit/ext4_subdir_limit_test.sh    |  4 +--
 .../ext4-uninit-groups/ext4_uninit_groups_test.sh  |  4 +--
 .../kernel/fs/ext4-new-features/ext4_funcs.sh      | 36 +++++++++++++---------
 10 files changed, 34 insertions(+), 45 deletions(-)

diff --git a/runtest/fs_ext4 b/runtest/fs_ext4
index c65ebab..35b38de 100644
--- a/runtest/fs_ext4
+++ b/runtest/fs_ext4
@@ -1 +1,4 @@
-ext4_new_feature_test	run_ext4_test.sh
+ext4-nsec-timestamps	ext4_nsec_timestamps_test.sh -D BIG_DEVICE
+ext4-uninit-groups	ext4_uninit_groups_test.sh -D BIG_DEVICE
+ext4-persist-prealloc	ext4_persist_prealloc_test.sh -D BIG_DEVICE
+ext4-subdir-limit	ext4_subdir_limit_test.sh -D BIG_DEVICE
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh b/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh
index dfa34c4..e40a1d1 100755
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
@@ -124,7 +121,7 @@ ext4_test_delalloc_mballoc()
 }
 
 # main
-ext4_setup
+ext4_setup "$@"
 
 DELALLOC=( "delalloc" "nodelalloc" )
 DIRECT_IO=( 0 1 )
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh
index 998c3e4..47e6d54 100755
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
@@ -111,7 +108,6 @@ test_inode_version()
 		return 1
 	fi
 
-	umount mnt_point
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "failed to umount ext4 filesystem"
 		return 1
@@ -145,7 +141,7 @@ test_inode_version()
 }
 
 # main
-ext4_setup
+ext4_setup "$@"
 
 RET=0
 
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh b/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh
index 1fd9bba..6a011b6 100755
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
@@ -100,7 +97,7 @@ ext4_test_journal_checksum()
 }
 
 # main
-ext4_setup
+ext4_setup "$@"
 
 DATA=( "writeback" "ordered" "journal" )
 COMMIT=( 1 100 )
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
index c91c1af..710bc00 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
@@ -31,8 +31,6 @@ export TCID="ext4-nsec-timestamps"
 export TST_TOTAL=2
 export TST_COUNT=1
 
-# $1: the test config
-read_config $1
 
 TEST_DIR=$PWD
 
@@ -173,7 +171,7 @@ ext4_test_nsec_timestamps()
 }
 
 # main
-ext4_setup
+ext4_setup "$@"
 
 RET=0
 
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-online-defrag/ext4_online_defrag_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-online-defrag/ext4_online_defrag_test.sh
index 2aa3e5b..9845404 100755
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
@@ -173,7 +170,7 @@ ext4_test_online_defrag()
 }
 
 # main
-ext4_setup
+ext4_setup "$@"
 
 rm -f $LTPROOT/output/ext4_online_defrag_result.txt
 
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh
index e41b104..a83a84f 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh
@@ -33,9 +33,6 @@ export TST_COUNT=1
 
 export TEST_DIR=$PWD
 
-# $1: the test config
-read_config $1
-
 # The test path of fallocate
 export TMPDIR=$PWD/mnt_point/
 
@@ -91,7 +88,7 @@ ext4_test_persist_prealloc()
 }
 
 # main
-ext4_setup
+ext4_setup "$@"
 
 RET=0
 
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh
index fdb6a08..e6ff372 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh
@@ -31,8 +31,6 @@ export TCID="ext4-subdir-limit"
 export TST_TOTAL=10
 export TST_COUNT=1
 
-# $1: the test config
-read_config $1
 
 TEST_DIR=$PWD
 SHORT_DIR=1
@@ -138,7 +136,7 @@ ext4_run_case()
 }
 
 # main
-ext4_setup
+ext4_setup "$@"
 
 DIR_LEN=( $SHORT_DIR $LONG_DIR )
 PARENT_DIR=( "mnt_point" "mnt_point/sub" )
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh
index e6d49e1..2f4911c 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh
@@ -29,8 +29,6 @@ export TST_TOTAL=24
 export TST_COUNT=1
 
 export TEST_DIR=$PWD
-# $1: the test config
-read_config $1
 
 # How to age filesystem
 EMPTY=1
@@ -128,7 +126,7 @@ ext4_test_uninit_groups()
 }
 
 # main
-ext4_setup
+ext4_setup "$@"
 
 ORLOV=( "orlov" "oldalloc" )
 DELALLOC=( "delalloc" "nodelalloc" )
diff --git a/testcases/kernel/fs/ext4-new-features/ext4_funcs.sh b/testcases/kernel/fs/ext4-new-features/ext4_funcs.sh
index b469bab..4bb3554 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4_funcs.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4_funcs.sh
@@ -26,22 +26,30 @@
 ext4_setup()
 {
 	mkdir mnt_point
-}
 
-ext4_cleanup()
-{
-	rmdir mnt_point
+	while getopts D:T: arg
+	do
+		case $arg in
+		D)
+			export EXT4_DEV=$OPTARG
+			;;
+		T)
+			export FILE_SYSTEM_TYPE=$OPTARG
+			;;
+		\?)
+			echo "not supproted option"
+			;;
+		esac
+	done
+
+	# "d" indicates a invalid block device(read runltp)
+	if [ "$EXT4_DEV" = "d" ];then
+		tst_brkm TCONF ignored "a block device must be specified"
+		exit 0
+	fi
 }
 
-# $1: the config file
-read_config()
+ext4_cleanup()
 {
-	while read config
-	do
-		echo $config | grep -q -E ".*=.*"
-		if [ $? -eq 0 ]; then
-			export $config
-		fi
-	done < $1
+	rm -rf mnt_point
 }
-
-- 
1.8.2.1



------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
