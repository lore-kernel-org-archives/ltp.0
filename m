Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1Y3LrP-0005Di-Q8
	for ltp-list@lists.sourceforge.net; Tue, 23 Dec 2014 09:34:35 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Y3Lr9-00013x-O7
	for ltp-list@lists.sourceforge.net; Tue, 23 Dec 2014 09:34:35 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id sBN9XP9C027021
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Dec 2014 17:33:25 +0800
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Tue, 23 Dec 2014 17:33:31 +0800
Message-ID: <1419327221-28508-2-git-send-email-zenglg.jy@cn.fujitsu.com>
In-Reply-To: <1419327221-28508-1-git-send-email-zenglg.jy@cn.fujitsu.com>
References: <1419327221-28508-1-git-send-email-zenglg.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 02/12] smack_file_access.sh: Cleanup
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

* Use 'test.sh' script and use 'tst_*'.

* Add 'TCID' and 'TST_TOTAL' global variables.

* Use '.' instead of 'source'.

* Use 'tst_tmpdir' and 'tst_rmdir'.

* Use '$()' instead of '``'.

* Some cleanup.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 .../kernel/security/smack/smack_file_access.sh     | 128 +++++++++------------
 1 file changed, 52 insertions(+), 76 deletions(-)

diff --git a/testcases/kernel/security/smack/smack_file_access.sh b/testcases/kernel/security/smack/smack_file_access.sh
index 61db065..a2d09c0 100755
--- a/testcases/kernel/security/smack/smack_file_access.sh
+++ b/testcases/kernel/security/smack/smack_file_access.sh
@@ -14,106 +14,82 @@
 #               1         2         3         4         5         6
 #      123456789012345678901234567890123456789012345678901234567890123456789
 
-source smack_common.sh
+export TCID=smack_file_access
+export TST_TOTAL=1
 
-RuleA="TheOne                  TheOther                r---"
-RuleB="TheOne                  TheOther                rw--"
+. test.sh
+
+. smack_common.sh
+
+cleanup()
+{
+	tst_rmdir
+}
+
+rule_a="TheOne                  TheOther                r---"
+rule_b="TheOne                  TheOther                rw--"
 
-Where="./testdir"
-What="testfile"
-TestFile="$Where/$What"
 CAT=/bin/cat
+testfile="testfile"
 
-if [ ! -d "$Where" ]; then
-	if [ -e "$Where" ]; then
-		echo "Test directory \"$Where\" exists but is not a directory."
-		exit 1
-	fi
-	mkdir -m 777 "$Where"
-	if [ ! -d "$Where" ]; then
-		echo "Test directory \"$Where\" can not be created."
-		exit 1
-	fi
-fi
+tst_tmpdir
+TST_CLEANUP=cleanup
+
+chmod 777 $(pwd)
 
-if [ ! -f "$TestFile" ]; then
-	if [ -e "$TestFile" ]; then
-		echo "Test file \"$TestFile\" exists but is not a file."
-		rm -rf "$Where"
-		exit 1
-	fi
-	./notroot /bin/sh -c "echo InitialData 2>/dev/null > $TestFile"
-	if [ ! -d "$TestFile" ]; then
-		echo "Test file \"$TestFile\" can not be created."
-		rm -rf "$Where"
-		exit 1
-	fi
+notroot /bin/sh -c "echo InitialData 2>/tmp/smack_fail.log > $testfile"
+if [ ! -f "$testfile" ]; then
+	tst_brkm TFAIL "Test file \"$testfile\" can not be created."
 fi
 
-setfattr --name=security.SMACK64 --value=TheOther "$TestFile"
-SetTo=`getfattr --only-values -n security.SMACK64 -e text $TestFile`
-SetTo=`echo $SetTo`
+setfattr --name=security.SMACK64 --value=TheOther "$testfile"
+setto=$(getfattr --only-values -n security.SMACK64 -e text $testfile)
 
-if [ "TheOther" != "$SetTo" ]; then
-	echo "Test file \"$TestFile\" labeled \"$SetTo\" incorrectly."
-	rm -rf "$Where"
-	exit 1
+if [ "TheOther" != "$setto" ]; then
+	tst_brkm TFAIL "Test file \"$testfile\" labeled \"$setto\" incorrectly."
 fi
 
-OldRule=`grep "^TheOne" "$smackfsdir/load" 2>/dev/null | grep ' TheOther '`
+old_rule=$(grep "^TheOne" "$smackfsdir/load" 2>/dev/null | grep ' TheOther ')
 
-echo -n "$RuleA" > "$smackfsdir/load"
-NewRule=`grep "^TheOne" "$smackfsdir/load" 2>/dev/null | grep ' TheOther '`
-if [ "$NewRule" = "" ]; then
-	echo "Rule did not get set."
-	rm -rf "$Where"
-	exit 1
+echo -n "$rule_a" > "$smackfsdir/load"
+new_rule=$(grep "^TheOne" "$smackfsdir/load" 2>/dev/null | grep ' TheOther ')
+if [ "$new_rule" = "" ]; then
+	tst_brkm TFAIL "Rule did not get set."
 fi
-Mode=`echo $NewRule | sed -e 's/.* //'`
-if [ "$Mode" != "r" ]; then
-	echo "Rule \"$NewRule\" is not set correctly."
-	rm -rf "$Where"
-	exit 1
+mode=$(echo $new_rule | sed -e 's/.* //')
+if [ "$mode" != "r" ]; then
+	tst_brkm TFAIL "Rule \"$new_rule\" is not set correctly."
 fi
 
-OldProc=`cat /proc/self/attr/current 2>/dev/null`
-
 echo TheOne 2>/dev/null > /proc/self/attr/current
-GotRead=`./notroot $CAT "$TestFile"`
+got_read=$(smack_notroot $CAT "$testfile")
 
-if [ "$GotRead" != "InitialData" ]; then
-	echo "Read failed for \"$TestFile\" labeled \"TheOther\"."
-	rm -rf "$Where"
-	exit 1
+if [ "$got_read" != "InitialData" ]; then
+	tst_brkm TFAIL "Read failed for \"$testfile\" labeled \"TheOther\"."
 fi
 
 echo NotTheOne 2>/dev/null > /proc/self/attr/current
-GotRead=`./notroot $CAT "$TestFile"`
+got_read=$(smack_notroot $CAT "$testfile" 2> /dev/null)
 
-if [ "$GotRead" = "InitialData" ]; then
-	echo "Read should have failed for \"$TestFile\" labeled \"TheOther\"."
-	rm -rf "$Where"
-	exit 1
+if [ "$got_read" = "InitialData" ]; then
+	tst_brkm TFAIL "Read should have failed for \"$testfile\" labeled" \
+		       "\"TheOther\"."
 fi
 
-echo -n "$RuleB" 2>/dev/null > "$smackfsdir/load"
-NewRule=`grep "^TheOne" $smackfsdir/load 2>/dev/null | grep ' TheOther '`
-if [ "$NewRule" = "" ]; then
-	echo "Rule did not get set."
-	rm -rf "$Where"
-	exit 1
+echo -n "$rule_b" 2>/dev/null > "$smackfsdir/load"
+new_rule=$(grep "^TheOne" $smackfsdir/load 2>/dev/null | grep ' TheOther ')
+if [ "$new_rule" = "" ]; then
+	tst_brkm TFAIL "Rule did not get set."
 fi
-Mode=`echo $NewRule | sed -e 's/.* //'`
-if [ "$Mode" != "rw" ]; then
-	echo "Rule \"$NewRule\" is not set correctly."
-	rm -rf "$Where"
-	exit 1
+mode=$(echo $new_rule | sed -e 's/.* //')
+if [ "$mode" != "rw" ]; then
+	tst_brkm TFAIL "Rule \"$new_rule\" is not set correctly."
 fi
 
-if [ "$OldRule" != "$NewRule" ]; then
-	cat <<EOM
-Notice: Test access rule changed from "$OldRule" to "$NewRule".
-EOM
+if [ "$old_rule" != "$new_rule" ]; then
+	tst_resm TINFO "Notice: Test access rule changed from \"$old_rule\"" \
+		       "to \"$new_rule\"."
 fi
 
-rm -rf "$Where"
+tst_resm TPASS "Test \"$TCID\" success."
+tst_exit
-- 
1.9.3


------------------------------------------------------------------------------
Dive into the World of Parallel Programming! The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
