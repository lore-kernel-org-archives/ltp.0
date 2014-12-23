Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1Y3Lrc-0000RG-QL
	for ltp-list@lists.sourceforge.net; Tue, 23 Dec 2014 09:34:48 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Y3LrZ-00018H-Ax
	for ltp-list@lists.sourceforge.net; Tue, 23 Dec 2014 09:34:48 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id sBN9XUtR027042
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Dec 2014 17:33:30 +0800
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Tue, 23 Dec 2014 17:33:37 +0800
Message-ID: <1419327221-28508-8-git-send-email-zenglg.jy@cn.fujitsu.com>
In-Reply-To: <1419327221-28508-1-git-send-email-zenglg.jy@cn.fujitsu.com>
References: <1419327221-28508-1-git-send-email-zenglg.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 08/12] smack_set_load.sh: Cleanup
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

* Use '$()' instead of '``'.

* Some cleanup.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/security/smack/smack_set_load.sh | 55 ++++++++++++-----------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/testcases/kernel/security/smack/smack_set_load.sh b/testcases/kernel/security/smack/smack_set_load.sh
index 2dd4fbb..57c04c0 100755
--- a/testcases/kernel/security/smack/smack_set_load.sh
+++ b/testcases/kernel/security/smack/smack_set_load.sh
@@ -14,40 +14,43 @@
 #               1         2         3         4         5         6
 #      123456789012345678901234567890123456789012345678901234567890123456789
 
-source smack_common.sh
+export TCID=smack_set_load
+export TST_TOTAL=1
 
-RuleA="TheOne                  TheOther                rwxa"
-RuleB="TheOne                  TheOther                r---"
+. test.sh
 
-OldRule=`grep "^TheOne" "$smackfsdir/load" 2>/dev/null | grep ' TheOther '`
+. smack_common.sh
 
-echo -n "$RuleA" 2>/dev/null > "$smackfsdir/load"
-NewRule=`grep "^TheOne" "$smackfsdir/load" 2>/dev/null | grep ' TheOther '`
-if [ "$NewRule" = "" ]; then
-	echo "Rule did not get set."
-	exit 1
+rule_a="TheOne                  TheOther                rwxa"
+rule_b="TheOne                  TheOther                r---"
+
+old_rule=$(grep "^TheOne" "$smackfsdir/load" 2>/dev/null | grep ' TheOther ')
+
+echo -n "$rule_a" 2>/dev/null > "$smackfsdir/load"
+new_rule=$(grep "^TheOne" "$smackfsdir/load" 2>/dev/null | grep ' TheOther ')
+if [ "$new_rule" = "" ]; then
+	tst_brkm TFAIL "Rule did not get set."
 fi
-Mode=`echo "$NewRule" | sed -e 's/.* //'`
-if [ "$Mode" != "rwxa" ]; then
-	echo "Rule \"$NewRule\" is not set correctly."
+mode=$(echo "$new_rule" | sed -e 's/.* //')
+if [ "$mode" != "rwxa" ]; then
+	tst_brkm TFAIL "Rule \"$new_rule\" is not set correctly."
 	exit 1
 fi
 
-echo -n "$RuleB" 2>/dev/null > "$smackfsdir/load"
-NewRule=`grep "^TheOne" "$smackfsdir/load" 2>/dev/null | grep ' TheOther '`
-if [ "$NewRule" = "" ]; then
-	echo "Rule did not get set."
-	exit 1
+echo -n "$rule_b" 2>/dev/null > "$smackfsdir/load"
+new_rule=$(grep "^TheOne" "$smackfsdir/load" 2>/dev/null | grep ' TheOther ')
+if [ "$new_rule" = "" ]; then
+	tst_brkm TFAIL "Rule did not get set."
 fi
-Mode=`echo "$NewRule" | sed -e 's/.* //'`
-if [ "$Mode" != "r" ]; then
-	echo "Rule \"$NewRule\" is not set correctly."
-	exit 1
+mode=$(echo "$new_rule" | sed -e 's/.* //')
+if [ "$mode" != "r" ]; then
+	tst_brkm TFAIL "Rule \"$new_rule\" is not set correctly."
 fi
 
-if [ "$OldRule" != "$NewRule" ]; then
-	cat <<EOM
-Notice: Test access rule changed from
-"$OldRule" to "$NewRule".
-EOM
+if [ "$old_rule" != "$new_rule" ]; then
+	tst_resm TINFO "Notice: Test access rule changed from \"$old_rule\"" \
+		       "to \"$new_rule\"."
 fi
+
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
