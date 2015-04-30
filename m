Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1YnkJb-0001Fp-Ub
	for ltp-list@lists.sourceforge.net; Thu, 30 Apr 2015 08:59:27 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YnkJa-0008Rx-Rz
	for ltp-list@lists.sourceforge.net; Thu, 30 Apr 2015 08:59:27 +0000
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Thu, 30 Apr 2015 16:58:07 +0800
Message-ID: <1430384287-16073-4-git-send-email-zenglg.jy@cn.fujitsu.com>
In-Reply-To: <1430384287-16073-1-git-send-email-zenglg.jy@cn.fujitsu.com>
References: <55418B02.3080104@huawei.com>
	<1430384287-16073-1-git-send-email-zenglg.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 3/3] commands/fileutils/mv: add new test for mv(1)
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
To: cuibixuan@huawei.com
Cc: ltp-list@lists.sourceforge.net

Add 'mv -b <file1> <file2>' test.

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/commands/fileutils/mv/mv_tests.sh | 40 ++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/testcases/commands/fileutils/mv/mv_tests.sh b/testcases/commands/fileutils/mv/mv_tests.sh
index 6c55d94..66f4056 100755
--- a/testcases/commands/fileutils/mv/mv_tests.sh
+++ b/testcases/commands/fileutils/mv/mv_tests.sh
@@ -23,10 +23,12 @@
 # Description:  Test basic functionality of mv command
 #		- Test #1:  mv <dir1> <dir2>
 #		  move dir1 to dir2 and all its contents.
+#		- Test #2:  mv -b <file1> <file2>
+#		  move file1 to file2 and backup the file2.
 #
 
 TCID=mv01
-TST_TOTAL=1
+TST_TOTAL=2
 . test.sh
 
 setup()
@@ -139,9 +141,45 @@ test01()
 	fi
 }
 
+test02()
+{
+	tst_resm TINFO "Test #2: mv -b <file1> <file2> will move dir1 to dir2"
+
+	ROD_SILENT touch tmpfile1 tmpfile2
+
+	MD5_old=$(md5sum tmpfile2 | awk '{print $1}')
+	if [ $? -ne 0 ]; then
+		tst_brkm TBROK "Test #2: can't get the MD5 message of file2."
+	fi
+
+	if [ -f "tmpfile2~" ]; then
+		tst_brkm TBROK "Test #2: file tmpfile2~ should not exists."
+	fi
+
+	mv -b tmpfile1 tmpfile2
+	if [ $? -ne 0 ]; then
+		tst_brkm TBROK "Test #2: 'mv -b tmpfile1 tmpfile2' failed."
+	fi
+
+	# if 'mv -b file1 file2' succeed, there will be "tmpfile2~" file.
+
+	MD5_backup=$(md5sum tmpfile2 | awk '{print $1}')
+	if [ $? -ne 0 ]; then
+		tst_brkm TBROK "Test #2: can not get the MD5 message of" \
+			       "backup file2."
+	fi
+
+	if [ "$MD5_old" == "$MD5_backup" -a -f "tmpfile2~" ]; then
+		tst_resm TPASS "Test #2: mv -b success"
+	else
+		tst_resm TFAIL "Test #2: mv -b failed"
+	fi
+}
+
 setup
 TST_CLEANUP=cleanup
 
 test01
+test02
 
 tst_exit
-- 
1.8.3.1


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
