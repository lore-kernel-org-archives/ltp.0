Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <miaox@cn.fujitsu.com>) id 1NEws3-0006cd-Qg
	for ltp-list@lists.sourceforge.net; Mon, 30 Nov 2009 03:24:15 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NEwrs-0001OM-9L
	for ltp-list@lists.sourceforge.net; Mon, 30 Nov 2009 03:24:15 +0000
Message-ID: <4B133BC1.5020109@cn.fujitsu.com>
Date: Mon, 30 Nov 2009 11:28:01 +0800
From: Miao Xie <miaox@cn.fujitsu.com>
MIME-Version: 1.0
References: <4AE54BCA.7060104@cn.fujitsu.com>	
	<1256563577.4929.35.camel@subratamodak.linux.ibm.com>	
	<C3A9583B-F6C5-4BCC-8D7E-876FA4D62D57@sun.com>	
	<1256650551.4957.33.camel@subratamodak.linux.ibm.com>	
	<1256841114.5210.25.camel@subratamodak.linux.ibm.com>
	<1257170360.4977.58.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1257170360.4977.58.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [PATCH] Add new testcases for ext4 new features - V3
Reply-To: miaox@cn.fujitsu.com
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
To: subrata@linux.vnet.ibm.com
Cc: LTP-ML <ltp-list@lists.sourceforge.net>, Miao Xie <miaox@cn.fujitsu.com>

Hi, Subrata

I'm sorry. There is something wrong in the patch that I sent on 2009-11-26. So
I made a new patch to instead of it.

And Subrata, I didn't find these failure about online defrag on my box.
The attached patch opens the verbose mode of e4defrag to get more information later, it is
useful to find the problem of online defrag. So, Could you test it again and send the output
info to me?

This patch can fix the following problem:
-- delete the code of setting the test_fs flag
-- open the verbose mode of e4defrag, it is useful to find the problem of online defrag
-- fix some bug of the Makefile
-- throw the utilities version info away
-- delete two unnecessary testcases about ext4 subdir limit test

Signed-off-by: Miao Xie <miaox@cn.fujitsu.com>
---
  testcases/kernel/fs/ext4-new-features/Makefile     |   20 ++++++++++----
  testcases/kernel/fs/ext4-new-features/README       |    7 +----
  .../ext4-delalloc-mballoc/ext4-alloc-test.sh       |   15 ++++------
  .../ext4-inode-version/ext4_get_inode_version.sh   |    2 +-
  .../ext4-inode-version/ext4_inode_version_test.sh  |   10 +++----
  .../ext4-journal-checksum/ext4_journal_checksum.sh |   12 ++++----
  .../ext4_nsec_timestamps_test.sh                   |    8 ++---
  .../ext4-online-defrag/ext4_online_defrag_test.sh  |   28 ++++++++++++-------
  .../ext4_persist_prealloc_test.sh                  |    4 +-
  .../ext4-subdir-limit/ext4_subdir_limit_test.sh    |   17 +++++++-----
  .../ext4-uninit-groups/ext4_uninit_groups_test.sh  |   22 +++++++++------
  11 files changed, 78 insertions(+), 67 deletions(-)

diff --git a/testcases/kernel/fs/ext4-new-features/Makefile b/testcases/kernel/fs/ext4-new-features/Makefile
index 0e09dd6..208b8a6 100644
--- a/testcases/kernel/fs/ext4-new-features/Makefile
+++ b/testcases/kernel/fs/ext4-new-features/Makefile
@@ -22,17 +22,25 @@ top_srcdir              ?= ../../../..

  include $(top_srcdir)/include/mk/env_pre.mk

-INSTALL_TARGETS		:= *.sh
-INSTALL_TARGETS		:= ext4-test-config
-INSTALL_TARGETS		:= ffsb-6.0-rc2/ffsb
+INSTALL_TARGETS		+= ffsb
+INSTALL_TARGETS		+= run_ext4_test.sh
+INSTALL_TARGETS		+= ext4_funcs.sh
+INSTALL_TARGETS		+= ext4-test-config

-FILTER_OUT_DIRS		:= ffsb-6.0-rc2
+FFSBDIR			:= ffsb-6.0-rc2
+FILTER_OUT_DIRS		:= $(FFSBDIR)
+FFSB			:= $(FFSBDIR)/ffsb

-trunk-all: ffsb-6.0-rc2
+$(FFSB): $(FFSBDIR)
+	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
+	cp $(FFSBDIR)/ffsb ffsb
+
+trunk-all: $(FFSB)

  trunk-clean:: | ffsb-clean

-ffsb-clean:: ffsb-6.0-rc2
+ffsb-clean:: $(FFSBDIR)
  	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
+	rm -rf ffsb

  include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/fs/ext4-new-features/README b/testcases/kernel/fs/ext4-new-features/README
index 0ea0460..bda16e5 100644
--- a/testcases/kernel/fs/ext4-new-features/README
+++ b/testcases/kernel/fs/ext4-new-features/README
@@ -9,7 +9,7 @@ with increasing disk capacities and state-of-the-art feature requirements. More
  extensive information of ext4 can be found at the ext4 wiki site at the URL:
  http://ext4.wiki.kernel.org

-There are total 119 testcases for ext4 new features test that have been added.
+There are total 117 testcases for ext4 new features test that have been added.
  Now, these testcases can test multi-block alloc/delayed alloc, inode version
  field on disk, journal checksumming, nanosec timestamps, online defrag, persist
  prealloc, subdirectory limit and uninit groups of ext4.
@@ -111,11 +111,6 @@ Directory containing the shell script which is used to test subdirectory limit
  of ext4. According to the kernel documentation, we create more than 32000
  subdirectorys on the ext4 filesystem.

-But, when then block size is small, such as 1024, and the name of every
-subdirectory is very long, such as every name is 255 bytes, we can just create
-less than 20000 subdirectory. In this test suite, there is two FAIL cases by
-reason of it.
-
  ext4-uninit-groups
  ------------------
  Directory containing the shell script which is used to test uninitialized groups
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh b/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh
index ec2f389..be7b074 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh
@@ -37,14 +37,12 @@ read_config $1
  # Case 17: mount ext4 partition to ext3
  ext4_test_remount()
  {
-	mkfs.ext3 -I 256 -b 1024 $EXT4_DEV > /dev/null
+	mkfs.ext3 -I 256 -b 1024 $EXT4_DEV &> /dev/null
  	if [ $? -ne 0 ]; then
  		tst_resm TFAIL "failed to create ext4 filesystem"
  		return 1
  	fi

-	tune2fs -E test_fs $EXT4_DEV
-
  	mount -t ext4 -o delalloc,auto_da_alloc $EXT4_DEV mnt_point
  	if [ $? -ne 0 ]; then
  		tst_resm TFAIL "failed to mount ext4 filesystem"
@@ -71,7 +69,7 @@ ext4_test_remount()
  	fi
  	umount mnt_point

-	fsck -p $EXT4_DEV
+	fsck -p $EXT4_DEV &> /dev/null
  	if [ $? -ne 0 ]; then
  		tst_resm TFAIL "fsck returned failure"
  		return 1
@@ -87,16 +85,15 @@ ext4_test_remount()
  # $4: auto_da_alloc
  ext4_test_delalloc_mballoc()
  {
-	tst_resm TINFO "isDelalloc: $1, isDirectIO: $2, Blocksize: $3, \
-		isAuto_da_alloc: $4"
+	tst_resm TINFO "isDelalloc: $1, isDirectIO: $2, Blocksize: $3, isAuto_da_alloc: $4"

-	mkfs.ext4 -I 256 -b $3 /$EXT4_DEV > /dev/null
+	mkfs.ext4 -I 256 -b $3 /$EXT4_DEV &> /dev/null
  	if [ $? -ne 0 ]; then
  		tst_resm TFAIL "failed to create ext4 filesystem"
  		return 1
  	fi

-	tune2fs -E test_fs -O extents $EXT4_DEV
+	tune2fs -O extents $EXT4_DEV &> /dev/null

  	mount -t ext4 -o $1,$4 $EXT4_DEV mnt_point
  	if [ $? -ne 0 ]; then
@@ -117,7 +114,7 @@ ext4_test_delalloc_mballoc()
  		return 1
  	fi

-	fsck -p $EXT4_DEV
+	fsck -p $EXT4_DEV &> /dev/null
  	if [ $? -ne 0 ]; then
  		tst_resm TFAIL "fsck returned failure"
  		return 1
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_get_inode_version.sh b/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_get_inode_version.sh
index 8f5c907..0e7a8b6 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_get_inode_version.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_get_inode_version.sh
@@ -24,7 +24,7 @@
  #$2: 1  - return inode version by return value
  #    !1 - writting inode version to stddev

-inode_version=`debugfs -R "stat $1" $EXT4_DEV | grep 'Version' | awk '{
+inode_version=`debugfs -R "stat $1" $EXT4_DEV 2> /dev/null | grep 'Version' | awk '{
  print $NF }'`

  # The inode_version's format: '0x0000000a' or '0x00000000:0000000a',
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh
index f27248b..4a58b36 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh
@@ -41,13 +41,13 @@ ext4_test_128_inode_version()
  {
  	tst_resm TINFO "Test inode version is 32 bits with 128 inode size"

-	mkfs.ext4 -I 128 $EXT4_DEV > /dev/null
+	mkfs.ext4 -I 128 $EXT4_DEV &> /dev/null
  	if [ $? -ne 0 ]; then
  		tst_resm TFAIL "failed to create ext4 filesystem"
  		return 1
  	fi

-	tune2fs -E test_fs -O extents $EXT4_DEV
+	tune2fs -O extents $EXT4_DEV &> /dev/null

  	mount -t ext4 -o i_version $EXT4_DEV mnt_point
  	if [ $? -ne 0 ]; then
@@ -67,7 +67,7 @@ ext4_test_128_inode_version()
  	fi

  	# inode version is 32 bits: 0x00000000
-	version=`debugfs $EXT4_DEV -R "stat tmp_file" | grep 'Version'`
+	version=`debugfs $EXT4_DEV -R "stat tmp_file" 2> /dev/null | grep 'Version'`
  	version=`echo $version | awk '{ print $NF }'`
  	version=`echo $version | sed 's/^0x//'`
  	len=${#version}
@@ -91,14 +91,12 @@ ext4_test_128_inode_version()
  # $1: file operation
  test_inode_version()
  {
-	mkfs.ext3 -I 256 $EXT4_DEV > /dev/null
+	mkfs.ext3 -I 256 $EXT4_DEV &> /dev/null
  	if [ $? -ne 0 ]; then
  		tst_resm TFAIL "failed to create ext4 filesystem"
  		return 1
  	fi

-	tune2fs -E test_fs $EXT4_DEV > /dev/null
-
  	mount -t ext4 -o i_version $EXT4_DEV mnt_point
  	if [ $? -ne 0 ]; then
  		tst_resm TFAIL "failed to mount ext4 filesystem"
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh b/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh
index 550afa1..eb72b5d 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh
@@ -59,17 +59,17 @@ ext4_test_journal_checksum()
  		async_commit="Used"
  	fi

-	tst_resm TINFO "journal mode: $1, commit interval: $2, \
-		journal_checksum: $checksum, \
-		journal_async_commit: $async_commit, barrier: $5"
+	tst_resm TINFO "journal mode: $1, commit interval: $2, " \
+		"journal_checksum: $checksum, " \
+		"journal_async_commit: $async_commit, barrier: $5"

-	mkfs.ext4 -I 256 $EXT4_DEV > /dev/null
+	mkfs.ext4 -I 256 $EXT4_DEV &> /dev/null
  	if [ $? -ne 0 ]; then
  		tst_resm TFAIL "failed to create ext4 filesystem"
  		return 1
  	fi

-	tune2fs -E test_fs -O extents $EXT4_DEV
+	tune2fs -O extents $EXT4_DEV &> /dev/null

  	mount -t ext4 -o data=$1,commit=$2,$3,$4,barrier=$5 $EXT4_DEV mnt_point
  	if [ $? -ne 0 ]; then
@@ -90,7 +90,7 @@ ext4_test_journal_checksum()
  		return 1
  	fi

-	e2fsck -p $EXT4_DEV
+	e2fsck -p $EXT4_DEV &> /dev/null
  	if [ $? -ne 0 ]; then
  		tst_resm TFAIL "fsck returned failure"
  		return 1
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
index ced6576..cc00507 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
@@ -41,13 +41,13 @@ ext4_test_sec_timestamps()
  {
  	tst_resm TINFO "Test timestamps with 128 inode size"

-	mkfs.ext4 -I 128 $EXT4_DEV > /dev/null
+	mkfs.ext4 -I 128 $EXT4_DEV &> /dev/null
  	if [ $? -ne 0 ]; then
  		tst_resm TFAIL "failed to create ext4 filesystem"
  		return 1
  	fi

-	tune2fs -E test_fs -O extents $EXT4_DEV
+	tune2fs -O extents $EXT4_DEV &> /dev/null

  	mount -t ext4 $EXT4_DEV mnt_point
  	if [ $? -ne 0 ]; then
@@ -82,14 +82,12 @@ ext4_test_nsec_timestamps()
  {
  	tst_resm TINFO "Test timestamps with 256 inode size"

-	mkfs.ext3 -I 256 $EXT4_DEV > /dev/null
+	mkfs.ext3 -I 256 $EXT4_DEV &> /dev/null
  	if [ $? -ne 0 ]; then
  		tst_resm TFAIL "failed to create ext4 filesystem"
  		return 1
  	fi

-	tune2fs -E test_fs $EXT4_DEV
-
  	mount -t ext4 $EXT4_DEV mnt_point
  	if [ $? -ne 0 ]; then
  		tst_resm TFAIL "failed to mount ext4 filesystem"
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-online-defrag/ext4_online_defrag_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-online-defrag/ext4_online_defrag_test.sh
index 84613c8..7b4dda3 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-online-defrag/ext4_online_defrag_test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-online-defrag/ext4_online_defrag_test.sh
@@ -94,23 +94,23 @@ my_e4defrag()
  {
  	if [ $1 -eq $FILE ]; then
  		if [ $2 -eq $SMALL ]; then
-			./e4defrag mnt_point/data0/
+			./e4defrag -v mnt_point/data0/
  			return $?
  		# EMPTY or LARGE
  		else
-			./e4defrag mnt_point/tmp_file
+			./e4defrag -v mnt_point/tmp_file
  			return $?
  		fi
  	elif [ $1 -eq $DIR ]; then
  		if [ $2 -eq $SMALL ]; then
-			./e4defrag mnt_point/data0/
+			./e4defrag -v mnt_point/data0/
  			return $?
  		else
-			./e4defrag mnt_point/tmp_dir
+			./e4defrag -v mnt_point/tmp_dir
  			return $?
  		fi
  	else
-		./e4defrag $EXT4_DEV
+		./e4defrag -v $EXT4_DEV
  		return $?
  	fi
  }
@@ -121,15 +121,20 @@ my_e4defrag()
  # $3: block size
  ext4_test_online_defrag()
  {
+	echo Test $TST_COUNT start >> \
+		 $LTPROOT/output/ext4_online_defrag_result.txt
+
  	tst_resm TINFO "defrag type: $1, defrag obj: $2, block size: $3"

-	mkfs.ext4 -m 0 -b $3 -O ^flex_bg $EXT4_DEV > /dev/null
+	mkfs.ext4 -m 0 -b $3 -O ^flex_bg $EXT4_DEV >> \
+		$LTPROOT/output/ext4_online_defrag_result.txt 2>&1
  	if [ $? -ne 0 ]; then
  		tst_resm TFAIL "failed to create ext4 filesystem"
  		return 1
  	fi

-	tune2fs -E test_fs -O extents $EXT4_DEV
+	tune2fs -O extents $EXT4_DEV >> \
+		 $LTPROOT/output/ext4_online_defrag_result.txt 2>&1

  	mount -t ext4 -o nodelalloc $EXT4_DEV mnt_point
  	if [ $? -ne 0 ]; then
@@ -137,7 +142,7 @@ ext4_test_online_defrag()
  		return 1
  	fi

-	age_filesystem $2 $1
+	age_filesystem $2 $1 >> $LTPROOT/output/ext4_online_defrag_result.txt 2>&1

  	my_e4defrag $1 $2 >> $LTPROOT/output/ext4_online_defrag_result.txt
  	if [ $? -ne 0 ]; then
@@ -152,18 +157,21 @@ ext4_test_online_defrag()
  		return 1
  	fi

-	e2fsck -p $EXT4_DEV
+	e2fsck -p $EXT4_DEV >> \
+		 $LTPROOT/output/ext4_online_defrag_result.txt 2>&1
  	if [ $? -ne 0 ]; then
  		tst_resm TFAIL "fsck returned failure"
  		return 1
  	fi

-	tst_resm TPASS "ext4 online defrag test pass(defrag type: $1, Aging: $2, block size: $3)"
+	tst_resm TPASS "ext4 online defrag test pass"
  }

  # main
  ext4_setup

+rm -f $LTPROOT/output/ext4_online_defrag_result.txt
+
  DEFRAG=( $FILE $DIR $FILESYSTEM )
  AGING=( $EMPTY $SMALL $LARGE )
  BLOCK_SIZE=( 1024 4096 )
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh
index 0d293e8..e895d25 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-persist-prealloc/ext4_persist_prealloc_test.sh
@@ -43,7 +43,7 @@ export TDIRECTORY=$PWD/mnt_point/
  # $1: 1024 or 4096
  ext4_test_persist_prealloc()
  {
-	mkfs.ext4 -I 256 -b $1 $EXT4_DEV > /dev/null
+	mkfs.ext4 -I 256 -b $1 $EXT4_DEV &> /dev/null
  	if [ $? -ne 0 ]; then
  		tst_resm TFAIL "failed to create ext4 filesystem"
  		return 1
@@ -81,7 +81,7 @@ ext4_test_persist_prealloc()
  		return 1
  	fi

-	e2fsck -p $EXT4_DEV
+	e2fsck -p $EXT4_DEV &> /dev/null
  	if [ $? -ne 0 ]; then
  		tst_resm TFAIL "fsck returned failure"
  		return 1
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh
index 42c4336..5631fe5 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh
@@ -28,7 +28,7 @@ cd $LTPROOT/testcases/bin
  . ./ext4_funcs.sh

  export TCID="ext4-subdir-limit"
-export TST_TOTAL=12
+export TST_TOTAL=10
  export TST_COUNT=1

  # $1: the test config
@@ -59,20 +59,20 @@ ext4_run_case()
  		dir_name_len="long name"
  	fi

-	tst_resm TINFO "Num of dirs to create: $1, Dir name len: $dir_name_len \
-			Parent dir: $3, Block size: $4"
+	tst_resm TINFO "Num of dirs to create: $1, Dir name len: $dir_name_len, " \
+			"Parent dir: $3, Block size: $4"

  	# only mkfs if block size has been changed,
  	# or previous case failed
  	if [ $prev_result -ne $PASS -o $4 -ne $prev_block_size ]; then
-		mkfs.ext4 -b $4 -I 256 $EXT4_DEV > /dev/null
+		mkfs.ext4 -b $4 -I 256 $EXT4_DEV &> /dev/null
  		if [ $? -ne 0 ]; then
  			tst_resm TFAIL "failed to create ext4 filesystem"
  			return 1
  		fi
  		prev_block_size=$4

-		tune2fs -E test_fs -O extents $EXT4_DEV
+		tune2fs -O extents $EXT4_DEV &> /dev/null
  	fi

  	prev_result=$FAIL
@@ -120,14 +120,14 @@ ext4_run_case()
  	fi

  	# run fsck to make sure the filesystem has no errors
-	e2fsck -p $EXT4_DEV
+	e2fsck -p $EXT4_DEV &> /dev/null
  	if [ $? -ne 0 ]; then
  		tst_resm TFAIL "fsck: the filesystem has errors"
  		return 1
  	fi

  	# check dir_nlink is set
-	dumpe2fs $EXT4_DEV | grep '^Filesystem features' | grep -q dir_nlink
+	dumpe2fs $EXT4_DEV 2> /dev/null | grep '^Filesystem features' | grep -q dir_nlink
  	if [ $? -ne 0 ]; then
  		tst_resm TFAIL "feature dir_nlink is not set"
  		return 1
@@ -152,6 +152,9 @@ for ((i = 0; i < 3; i++))
  	{
  		for ((k = 0; k < 2; k++))
  		{
+			if [ $i -eq $LONG_DIR -a $k -eq 1024 ]; then
+				continue
+			fi
  			ext4_run_case 65537 ${DIR_LEN[$k]} ${PARENT_DIR[$j]} \
  					${BLOCK_SIZE[$i]}
  			if [ $? -ne 0 ]; then
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh
index 27cbb5f..b479c8f 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh
@@ -40,8 +40,8 @@ LARGE=3
  # filesystem free size in bytes: blocks_size * free_blocks
  filesystem_free_size()
  {
-	bsize=`dumpe2fs -h $EXT4_DEV | grep 'Block size' | awk '{ print $2 }'`
-	blocks=`dumpe2fs -h $EXT4_DEV | grep 'Free blocks'| awk '{ print $2 }'`
+	bsize=`dumpe2fs -h $EXT4_DEV 2> /dev/null | grep 'Block size' | awk '{ print $2 }'`
+	blocks=`dumpe2fs -h $EXT4_DEV 2> /dev/null | grep 'Free blocks'| awk '{ print $2 }'`

  	echo $bsize * $blocks
  }
@@ -61,9 +61,9 @@ age_filesystem()
  		}
  	elif [ $1 -eq $LARGE ]; then
  		rm -rf mnt_point/*
-		bsize=`dumpe2fs -h $EXT4_DEV | grep 'Block size'`
+		bsize=`dumpe2fs -h $EXT4_DEV 2> /dev/null | grep 'Block size'`
  		bsize=`echo $bsize | awk '{ print $3 }'`
-		bcount=`dumpe2fs -h $EXT4_DEV | grep 'Free blocks'`
+		bcount=`dumpe2fs -h $EXT4_DEV 2> /dev/null | grep 'Free blocks'`
  		bcount=`echo $bcount | awk '{ print $3 }'`
  		dd if=/dev/zero of=mnt_point/tmp_dir bs=$bsize count=$bcount
  	else
@@ -80,7 +80,9 @@ age_filesystem()
  # $4: age filesystem: $EMPTY, $SMALL, $LARGE
  ext4_test_uninit_groups()
  {
-	mkfs.ext4 -I 256 -m 0 $EXT4_DEV > /dev/null
+	echo "Test $TST_COUNT" >> $LTPROOT/output/ext4_uninit_groups_result.txt
+
+	mkfs.ext4 -I 256 -m 0 $EXT4_DEV &> /dev/null
  	if [ $? -ne 0 ]; then
  		tst_resm TFAIL "failed to create ext4 filesystem"
  		return 1
@@ -92,10 +94,10 @@ ext4_test_uninit_groups()
  		flag=$3
  	fi

-	tune2fs -E test_fs -O extents,uninit_groups,$flag $EXT4_DEV
+	tune2fs -O extents,uninit_groups,$flag $EXT4_DEV &> /dev/null

  	# Must run fsck after setting uninit_groups
-	fsck -p $EXT4_DEV > /dev/null
+	fsck -p $EXT4_DEV &> /dev/null

  	mount -t ext4 -o $1,$2 $EXT4_DEV mnt_point
  	if [ $? -ne 0 ]; then
@@ -103,7 +105,7 @@ ext4_test_uninit_groups()
  		return 1
  	fi

-	age_filesystem $4
+	age_filesystem $4 >> $LTPROOT/output/ext4_uninit_groups_result.txt 2>&1
  	if [ $? -ne 0 ]; then
  		tst_resm TFAIL "age filesystem failed"
  		umount mnt_point
@@ -116,7 +118,7 @@ ext4_test_uninit_groups()
  		return 1
  	fi

-	fsck -p $EXT4_DEV
+	fsck -p $EXT4_DEV &> /dev/null
  	if [ $? -ne 0 ]; then
  		tst_resm TFAIL "fsck returned failure"
  		return 1
@@ -135,6 +137,8 @@ AGING=( $EMPTY $SMALL $LARGE )

  RET=0

+rm -f $LTPROOT/output/ext4_uninit_groups_result.txt
+
  for ((i = 0; i < 2; i++))
  {
  	for ((j = 0; j < 2; j++))
-- 
1.6.5.2


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
