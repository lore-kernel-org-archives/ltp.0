Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <miaox@cn.fujitsu.com>) id 1NDczz-0001Rb-Ep
	for ltp-list@lists.sourceforge.net; Thu, 26 Nov 2009 11:58:59 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NDczx-00021d-4X
	for ltp-list@lists.sourceforge.net; Thu, 26 Nov 2009 11:58:59 +0000
Message-ID: <4B0E6E6D.1070700@cn.fujitsu.com>
Date: Thu, 26 Nov 2009 20:02:53 +0800
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
Cc: LTP-ML <ltp-list@lists.sourceforge.net>

Hi, Subrata

on 2009-11-2 21:59, Subrata Modak wrote:
>>>>> /dev/VG1_EXT4/LV1_EXT4: The test_fs flag is set (and ext4 is  
>>>>> available).
>>>>> CLEARED.
>>>> You don't need to set the test_fs flag for modern ext4.
>>> Can we change this ?

The attached patch can fix this problem.

>>> However, it is also accompanied by the following failures in the online-defrag part:
>>> ========================================================================================
>>> ext4-online-defrag    0  TINFO  :  defrag type: 1, defrag obj: 3, block size: 1024
[snip]
>>> ext4-online-defrag    3  TFAIL  :  e4defrag returned failure
[snip]
>>> ext4-online-defrag    0  TINFO  :  defrag type: 2, defrag obj: 3, block size: 1024
[snip]
>>> ext4-online-defrag    6  TFAIL  :  e4defrag returned failure
>>> ext4-online-defrag    0  TINFO  :  defrag type: 3, defrag obj: 1, block size: 1024
[snip]
>>> ext4-online-defrag    7  TFAIL  :  e4defrag returned failure
>>> ext4-online-defrag    0  TINFO  :  defrag type: 3, defrag obj: 2, block size: 1024
[snip]
>>> File is not regular file
>>>  "/dev/VG1_EXT4/LV1_EXT4"
>>> ext4-online-defrag    8  TFAIL  :  e4defrag returned failure
>>> ext4-online-defrag    0  TINFO  :  defrag type: 3, defrag obj: 3, block size: 1024
[snip]
>>> ext4-online-defrag    9  TFAIL  :  e4defrag returned failure
>>> ...
>>> ext4-online-defrag    0  TINFO  :  defrag type: 3, defrag obj: 2, block size: 4096
[snip]
>>> File is not regular file
>>>  "/dev/VG1_EXT4/LV1_EXT4"
>>> ext4-online-defrag   17  TFAIL  :  e4defrag returned failure
>>> ext4-online-defrag    0  TINFO  :  defrag type: 3, defrag obj: 3, block size: 4096
[snip]
>>> File is not regular file
>>>  "/dev/VG1_EXT4/LV1_EXT4"
>>> ext4-online-defrag   18  TFAIL  :  e4defrag returned failure
>>> incrementing stop
>>> ========================================================================================
>>> Did you see these failure on your machine ?
>> Your take on this ?

I didn't find these failure on my box.
The attached patch opens the verbose mode of e4defrag to get more information later, it is
useful to find the problem of online defrag.
So, Could you test it again and send the output info to me?

>>
>>> Some more points are:
>>>
>>>      1. Can you please run these tests against the backdrop of the
>>>         Makefile changes in LTP to see all the build/install/run are
>>>         executing fine,
>> Could you please verify this before this release. Let me know a patch if
>> you find any discrepancy :-)

The attached patch can fix this problem.

>>
>>> 2. Can you also please put all the utilities version info at the
>>>         beginning of the test rather than printing them again and
>>>         again(like mke2fs 1.41.9 (22-Aug-2009),tune2fs 1.41.9
>>>         (22-Aug-2009),dumpe2fs 1.41.9 (22-Aug-2009),dumpe2fs 1.41.9
>>>         (22-Aug-2009))
>> This can go in the next month release as well, if you do not have time
>> to fix now. Else, i have a bug mouth to eat this as well ;-)

The attached patch can fix this problem.


This patch can fix the following problem:
-- delete the code of setting the test_fs flag
-- open the verbose mode of e4defrag, it is useful to find the problem of online defrag
-- fix some bug of the Makefile
-- throw the utilities version info away

Signed-off-by: Miao Xie <miaox@cn.fujitsu.com>
---
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh b/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh
index 63c614c..be7b074 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh
@@ -85,8 +85,7 @@ ext4_test_remount()
  # $4: auto_da_alloc
  ext4_test_delalloc_mballoc()
  {
-	tst_resm TINFO "isDelalloc: $1, isDirectIO: $2, Blocksize: $3, \
-		isAuto_da_alloc: $4"
+	tst_resm TINFO "isDelalloc: $1, isDirectIO: $2, Blocksize: $3, isAuto_da_alloc: $4"

  	mkfs.ext4 -I 256 -b $3 /$EXT4_DEV &> /dev/null
  	if [ $? -ne 0 ]; then
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
index 4798e99..4a58b36 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh
@@ -67,7 +67,7 @@ ext4_test_128_inode_version()
  	fi

  	# inode version is 32 bits: 0x00000000
-	version=`debugfs $EXT4_DEV -R "stat tmp_file" | grep 'Version'`
+	version=`debugfs $EXT4_DEV -R "stat tmp_file" 2> /dev/null | grep 'Version'`
  	version=`echo $version | awk '{ print $NF }'`
  	version=`echo $version | sed 's/^0x//'`
  	len=${#version}
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh b/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh
index 310eaa0..eb72b5d 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh
@@ -59,9 +59,9 @@ ext4_test_journal_checksum()
  		async_commit="Used"
  	fi

-	tst_resm TINFO "journal mode: $1, commit interval: $2, \
-		journal_checksum: $checksum, \
-		journal_async_commit: $async_commit, barrier: $5"
+	tst_resm TINFO "journal mode: $1, commit interval: $2, " \
+		"journal_checksum: $checksum, " \
+		"journal_async_commit: $async_commit, barrier: $5"

  	mkfs.ext4 -I 256 $EXT4_DEV &> /dev/null
  	if [ $? -ne 0 ]; then
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-online-defrag/ext4_online_defrag_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-online-defrag/ext4_online_defrag_test.sh
index 3747783..c901758 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-online-defrag/ext4_online_defrag_test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-online-defrag/ext4_online_defrag_test.sh
@@ -126,13 +126,15 @@ ext4_test_online_defrag()

  	tst_resm TINFO "defrag type: $1, defrag obj: $2, block size: $3"

-	mkfs.ext4 -m 0 -b $3 -O ^flex_bg $EXT4_DEV &> /dev/null
+	mkfs.ext4 -m 0 -b $3 -O ^flex_bg $EXT4_DEV &>> \
+		$LTPROOT/output/ext4_online_defrag_result.txt
  	if [ $? -ne 0 ]; then
  		tst_resm TFAIL "failed to create ext4 filesystem"
  		return 1
  	fi

-	tune2fs -O extents $EXT4_DEV &> /dev/null
+	tune2fs -O extents $EXT4_DEV &>> \
+		 $LTPROOT/output/ext4_online_defrag_result.txt

  	mount -t ext4 -o nodelalloc $EXT4_DEV mnt_point
  	if [ $? -ne 0 ]; then
@@ -140,9 +142,9 @@ ext4_test_online_defrag()
  		return 1
  	fi

-	age_filesystem $2 $1 >> $LTPROOT/output/ext4_online_defrag_result.txt
+	age_filesystem $2 $1 &>> $LTPROOT/output/ext4_online_defrag_result.txt

-	my_e4defrag $1 $2 >> $LTPROOT/output/ext4_online_defrag_result.txt
+	my_e4defrag $1 $2 &>> $LTPROOT/output/ext4_online_defrag_result.txt
  	if [ $? -ne 0 ]; then
  		tst_resm TFAIL "e4defrag returned failure"
  		umount mnt_point
@@ -155,13 +157,14 @@ ext4_test_online_defrag()
  		return 1
  	fi

-	e2fsck -p $EXT4_DEV &> /dev/null
+	e2fsck -p $EXT4_DEV &>> \
+		 $LTPROOT/output/ext4_online_defrag_result.txt
  	if [ $? -ne 0 ]; then
  		tst_resm TFAIL "fsck returned failure"
  		return 1
  	fi

-	tst_resm TPASS "ext4 online defrag test pass(defrag type: $1, Aging: $2, block size: $3)"
+	tst_resm TPASS "ext4 online defrag test pass"
  }

  # main
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh
index 1483191..97b11ab 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh
@@ -59,8 +59,8 @@ ext4_run_case()
  		dir_name_len="long name"
  	fi

-	tst_resm TINFO "Num of dirs to create: $1, Dir name len: $dir_name_len \
-			Parent dir: $3, Block size: $4"
+	tst_resm TINFO "Num of dirs to create: $1, Dir name len: $dir_name_len, " \
+			"Parent dir: $3, Block size: $4"

  	# only mkfs if block size has been changed,
  	# or previous case failed
@@ -127,7 +127,7 @@ ext4_run_case()
  	fi

  	# check dir_nlink is set
-	dumpe2fs $EXT4_DEV | grep '^Filesystem features' | grep -q dir_nlink
+	dumpe2fs $EXT4_DEV 2> /dev/null | grep '^Filesystem features' | grep -q dir_nlink
  	if [ $? -ne 0 ]; then
  		tst_resm TFAIL "feature dir_nlink is not set"
  		return 1
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh
index 88fbfa9..c3fe386 100755
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
@@ -80,6 +80,8 @@ age_filesystem()
  # $4: age filesystem: $EMPTY, $SMALL, $LARGE
  ext4_test_uninit_groups()
  {
+	echo "Test $TST_COUNT" >> $LTPROOT/output/ext4_uninit_groups_result.txt
+
  	mkfs.ext4 -I 256 -m 0 $EXT4_DEV &> /dev/null
  	if [ $? -ne 0 ]; then
  		tst_resm TFAIL "failed to create ext4 filesystem"
@@ -103,7 +105,7 @@ ext4_test_uninit_groups()
  		return 1
  	fi

-	age_filesystem $4
+	age_filesystem $4 &>> $LTPROOT/output/ext4_uninit_groups_result.txt
  	if [ $? -ne 0 ]; then
  		tst_resm TFAIL "age filesystem failed"
  		umount mnt_point
@@ -135,6 +137,8 @@ AGING=( $EMPTY $SMALL $LARGE )

  RET=0

+rm -f $LTPROOT/output/ext4_uninit_groups_result.txt
+
  for ((i = 0; i < 2; i++))
  {
  	for ((j = 0; j < 2; j++))
--


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
