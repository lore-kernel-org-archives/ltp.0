Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cuibixuan@huawei.com>) id 1YgBJN-00015r-Sn
	for ltp-list@lists.sourceforge.net; Thu, 09 Apr 2015 12:11:57 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YgBJJ-0004Cf-3Y
	for ltp-list@lists.sourceforge.net; Thu, 09 Apr 2015 12:11:57 +0000
From: Cui Bixuan <cuibixuan@huawei.com>
Date: Thu, 9 Apr 2015 12:11:21 +0000
Message-ID: <1428581481-192136-1-git-send-email-cuibixuan@huawei.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH] mv/mv_tests.sh: Add test02 to test "mv -b"
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
Cc: , huawei.com.zhuyanpeng@huawei.com, zhanyongming@huawei.com.lijinyue

Add test02 to test "mv -b".
Run it in ubuntu 12.02:

<<<test_start>>>
tag=mv_tests01 stime=1428322533
cmdline="mv_tests.sh"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
mv          0  TINFO  :  INIT: Inititalizing tests.
mv01        0  TINFO  :  Test #1: mv <dir1> <dir2> will move dir1 to dir2 and all its contents
mv01        0  TINFO  :  Test #1: Creating 10 directories.
mv01        0  TINFO  :  Test #1: filling each dir with 10 files.
mv01        0  TINFO  :  Test #1: creating output file
mv01        0  TINFO  :  Test #1: creating expected output file
mv01        0  TINFO  :  Test #1: comparing expected out and actual output file
mv01        0  TINFO  :  Test #1: expected same as actual
mv01        1  TPASS  :  Test #1: mv success
mv          0  TINFO  :  INIT: Inititalizing tests.
mv02        0  TINFO  :  Test #2: mv -b <file1> <file2> will move dir1 to dir2 and backup the file2
mv02        1  TPASS  :  Test #2: mv -b success
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=1 cstime=8
<<<test_end>>>
---
 .../commands/fileutils/mv/00_Descriptions.txt      |    3 +-
 testcases/commands/fileutils/mv/mv_tests.sh        |   82 +++++++++++++++++++-
 2 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/testcases/commands/fileutils/mv/00_Descriptions.txt b/testcases/commands/fileutils/mv/00_Descriptions.txt
index 6d52868..57199bf 100644
--- a/testcases/commands/fileutils/mv/00_Descriptions.txt
+++ b/testcases/commands/fileutils/mv/00_Descriptions.txt
@@ -1,3 +1,4 @@
 test01
 	mv <dir1> <dir2> will move dir1 to dir2 and all its contents.
-
+test02
+	mv -b <file1> <file2> will move file1 to file2 and backup the file2.
diff --git a/testcases/commands/fileutils/mv/mv_tests.sh b/testcases/commands/fileutils/mv/mv_tests.sh
index 207e945..80f7507 100755
--- a/testcases/commands/fileutils/mv/mv_tests.sh
+++ b/testcases/commands/fileutils/mv/mv_tests.sh
@@ -24,7 +24,8 @@
 # Description:  Test basic functionality of mv command
 #				- Test #1:  mv <dir1> <dir2> will move dir1 to dir2 and all its
 #				            contents.
-#
+#				- Test #2:  mv -b <file1> <file2> will move file1 to file2 and
+#					    backup the file2.
 # Author:       Manoj Iyer, manjo@mail.utexas.edu
 #
 # History:      Feb 03 2003 - Created - Manoj Iyer.
@@ -238,6 +239,76 @@ test01()
 	return $RC
 }
 
+# Function:             test02
+#
+# Description   - Test #2: Test that mv -b <file1> <file2> will move
+#                 file1 to file2 and backup the file2.
+#               - create file1 and file2.
+#               - get the MD5 message of file2.
+#               - mv -b dir1 to dir2
+#               - get the MD5 message of backup file2.
+#               - compare  with MD5 messages.
+#
+# Return                - zero on success
+#               - non zero on failure. return value from commands ($RC)
+
+test02()
+{
+	RC=0                    # Return value from commands.
+        export TCID=mv02        # Name of the test case.
+        export TST_COUNT=1      # Test number.
+       
+	tmpfile1=$LTPTMP/tst_mv.tmp/tmpfile1
+	tmpfile2=$LTPTMP/tst_mv.tmp/tmpfile2
+	backup_tmpfile2=$LTPTMP/tst_mv.tmp/tmpfile2~
+       
+	$LTPBIN/tst_resm TINFO \
+		"Test #2: mv -b <file1> <file2> will move dir1 to dir2 and backup the file2"
+
+	touch $tmpfile1 $tmpfile2 > $LTPTMP/tst_mv.err 2>&1 || RC=$?
+	if [ $RC -ne 0 ]
+	then
+        	$LTPBIN/tst_brk TBROK $LTPTMP/tst_mv.err NULL \
+        	"Test #2: can not touch file1 and file2. Reason:"
+        	return $RC
+	fi
+
+	MD5_old=`md5sum $tmpfile2 |awk '{print $1}'` > $LTPTMP/tst_mv.err 2>&1 || RC=$?
+	if [ $RC -ne 0 ]
+	then
+        	$LTPBIN/tst_brk TBROK $LTPTMP/tst_mv.err NULL \
+        	"Test #2: can not get the MD5 message of file2. Reason:"
+        	return $RC
+	fi
+
+	mv -b $tmpfile1 $tmpfile2  > $LTPTMP/tst_mv.err 2>&1 || RC=$?
+	if [ $RC -ne 0 ]
+	then
+        	$LTPBIN/tst_brk TBROK $LTPTMP/tst_mv.err NULL \
+        	"Test #2: mv -b file1 file2 failed. Reason:"
+        	return $RC
+	fi
+
+	# if mv  -b file1 file2 succeed,there will be "file2~" file
+
+	MD5_backup=`md5sum $tmpfile2 |awk '{print $1}'` > $LTPTMP/tst_mv.err 2>&1 || RC=$?
+	if [ $RC -ne 0 ]
+	then
+        	$LTPBIN/tst_brk TBROK $LTPTMP/tst_mv.err NULL \
+        	"Test #2: can not get the MD5 message of backup file2. Reason:"
+        	return $RC
+	fi
+
+	if [ "$MD5_old" != "$MD5_backup" ]
+	then
+        	$LTPBIN/tst_resm TFAIL "Test #2: the MD5 number of file2 is not equal to MD5 number of backup file2"
+        	return $(($RC+1))
+	else
+        	$LTPBIN/tst_resm TPASS "Test #2: mv -b success"
+	fi
+
+	return $RC
+}
 
 # Function:		main
 #
@@ -258,6 +329,15 @@ then
 	TFAILCNT=$(($TFAILCNT+1))
 fi
 
+rm -fr $LTPTMP/tst_mv.*
+
+init || return $RC      # Exit if initializing testcases fails.
+
+test02 || RC=$?
+if [ $RC -ne 0 ]
+then
+	TFAILCNT=$(($TFAILCNT+1))
+fi
 
 rm -fr $LTPTMP/tst_mv.*
 
-- 
1.6.0.2


------------------------------------------------------------------------------
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
