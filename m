Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cuibixuan@huawei.com>) id 1YlSfp-0001QH-8Q
	for ltp-list@lists.sourceforge.net; Fri, 24 Apr 2015 01:44:57 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YlSfj-0000z3-EC
	for ltp-list@lists.sourceforge.net; Fri, 24 Apr 2015 01:44:57 +0000
From: Cui Bixuan <cuibixuan@huawei.com>
Date: Fri, 24 Apr 2015 01:44:28 +0000
Message-ID: <1429839868-2011-1-git-send-email-cuibixuan@huawei.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH v3] mv/mv_tests.sh: Add test02 to test 'mv -b'
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
Cc: ""@oracle.com, , huawei.com.lijinyue@huawei.com.alexey.kodanev, zhuyanpeng@huawei.com.zhanyongming

Add a new case to test 'mv -b':
* Create file1 and file2
* Mv -b file1 to file2
* Check backup file of file2

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
Helped-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
v3: Add helped-by message.
v2: Changing the commit message and check the patch with 'checkpatch.pl' script

 .../commands/fileutils/mv/00_Descriptions.txt      |    3 +-
 testcases/commands/fileutils/mv/mv_tests.sh        |   84 ++++++++++++++++++++
 2 files changed, 86 insertions(+), 1 deletions(-)

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
index 207e945..cda9901 100755
--- a/testcases/commands/fileutils/mv/mv_tests.sh
+++ b/testcases/commands/fileutils/mv/mv_tests.sh
@@ -24,6 +24,8 @@
 # Description:  Test basic functionality of mv command
 #				- Test #1:  mv <dir1> <dir2> will move dir1 to dir2 and all its
 #				            contents.
+#				- Test #2:  mv -b <file1> <file2> will move file1 to file2 and
+#					    backup the file2.
 #
 # Author:       Manoj Iyer, manjo@mail.utexas.edu
 #
@@ -238,6 +240,79 @@ test01()
 	return $RC
 }
 
+# Function:             test02
+#
+# Description   - Test #2: Test that mv -b <file1> <file2> will move
+#                 file1 to file2 and backup the file2.
+#               - create file1 and file2.
+#               - get the MD5 message of file2.
+#               - mv -b file1 to file2
+#               - get the MD5 message of backup file2.
+#               - compare  with MD5 messages.
+#
+# Return                - zero on success
+#               - non zero on failure. return value from commands ($RC)
+
+test02()
+{
+	RC=0                    # Return value from commands.
+	export TCID=mv02        # Name of the test case.
+	export TST_COUNT=1      # Test number.
+
+	tmpfile1=$LTPTMP/tst_mv.tmp/tmpfile1
+	tmpfile2=$LTPTMP/tst_mv.tmp/tmpfile2
+	backup_tmpfile2=$LTPTMP/tst_mv.tmp/tmpfile2~
+
+	$LTPBIN/tst_resm TINFO \
+		"Test #2: mv -b <file1> <file2> will move dir1 to dir2"
+
+	touch $tmpfile1 $tmpfile2 > $LTPTMP/tst_mv.err 2>&1 || RC=$?
+	if [ $RC -ne 0 ]
+	then
+		$LTPBIN/tst_brk TBROK $LTPTMP/tst_mv.err NULL \
+			"Test #2: can not touch file1 and file2. Reason:"
+		return $RC
+	fi
+
+	MD5_old=`md5sum $tmpfile2 |awk '{print $1}'` > $LTPTMP/tst_mv.err \
+		2>&1 || RC=$?
+	if [ $RC -ne 0 ]
+	then
+		$LTPBIN/tst_brk TBROK $LTPTMP/tst_mv.err NULL \
+			"Test #2: can't get the MD5 message of file2. Reason:"
+		return $RC
+	fi
+
+	mv -b $tmpfile1 $tmpfile2  > $LTPTMP/tst_mv.err 2>&1 || RC=$?
+	if [ $RC -ne 0 ]
+	then
+		$LTPBIN/tst_brk TBROK $LTPTMP/tst_mv.err NULL \
+			"Test #2: mv -b file1 file2 failed. Reason:"
+		return $RC
+	fi
+
+	# if mv  -b file1 file2 succeed,there will be "file2~" file
+
+	MD5_backup=`md5sum $tmpfile2 |awk '{print $1}'` > $LTPTMP/tst_mv.err \
+		2>&1 || RC=$?
+	if [ $RC -ne 0 ]
+	then
+		$LTPBIN/tst_brk TBROK $LTPTMP/tst_mv.err NULL \
+		"Test #2: can not get the MD5 message of backup file2. Reason:"
+		return $RC
+	fi
+
+	if [ "$MD5_old" != "$MD5_backup" ]
+	then
+		$LTPBIN/tst_resm TFAIL \
+			"Test #2: mv -b failed"
+		return $(($RC+1))
+	else
+		$LTPBIN/tst_resm TPASS "Test #2: mv -b success"
+	fi
+
+	return $RC
+}
 
 # Function:		main
 #
@@ -258,6 +333,15 @@ then
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
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
