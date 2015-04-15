Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cuibixuan@huawei.com>) id 1YiLdZ-00050r-ME
	for ltp-list@lists.sourceforge.net; Wed, 15 Apr 2015 11:37:45 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YiLdT-0004Rj-0O
	for ltp-list@lists.sourceforge.net; Wed, 15 Apr 2015 11:37:45 +0000
Message-ID: <552E4D6A.3020309@huawei.com>
Date: Wed, 15 Apr 2015 19:37:14 +0800
From: Cui Bixuan <cuibixuan@huawei.com>
MIME-Version: 1.0
References: <1428581481-192136-1-git-send-email-cuibixuan@huawei.com>
	<5527D7D6.4030108@oracle.com>
In-Reply-To: <5527D7D6.4030108@oracle.com>
Subject: [LTP]  [PATCH v2] mv/mv_tests.sh: Add test02 to test 'mv -b'
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: zhuyanpeng@huawei.com, ltp-list@lists.sourceforge.net, zhanyongming@huawei.com

Add a new case to test 'mv -b':
* Create file1 and file2
* Mv -b file1 to file2
* Check backup file of file2

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>

---
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
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
