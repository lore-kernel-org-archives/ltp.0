Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1Y3Lrf-0005Fh-92
	for ltp-list@lists.sourceforge.net; Tue, 23 Dec 2014 09:34:51 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Y3Lrd-00018H-Lv
	for ltp-list@lists.sourceforge.net; Tue, 23 Dec 2014 09:34:51 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id sBN9XVch027045
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Dec 2014 17:33:31 +0800
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Tue, 23 Dec 2014 17:33:38 +0800
Message-ID: <1419327221-28508-9-git-send-email-zenglg.jy@cn.fujitsu.com>
In-Reply-To: <1419327221-28508-1-git-send-email-zenglg.jy@cn.fujitsu.com>
References: <1419327221-28508-1-git-send-email-zenglg.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 09/12] smack_set_netlabel.sh: Cleanup
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
 .../kernel/security/smack/smack_set_netlabel.sh    | 54 +++++++++++-----------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/testcases/kernel/security/smack/smack_set_netlabel.sh b/testcases/kernel/security/smack/smack_set_netlabel.sh
index 4c4a384..9689abf 100755
--- a/testcases/kernel/security/smack/smack_set_netlabel.sh
+++ b/testcases/kernel/security/smack/smack_set_netlabel.sh
@@ -10,39 +10,41 @@
 #	CAP_MAC_ADMIN
 #
 
-source smack_common.sh
+export TCID=smack_set_netlabel
+export TST_TOTAL=1
 
-RuleA="191.191.191.191 TheOne"
-RuleA1="191.191.191.191/32 TheOne"
-RuleB="191.190.190.0/24 TheOne"
+. test.sh
 
-Old32=`grep "^191.191.191.191/32" "$smackfsdir/netlabel" 2>/dev/null`
-Old24=`grep "^191.190.190.0/24" "$smackfsdir/netlabel" 2>/dev/null`
+. smack_common.sh
 
-echo -n "$RuleA" 2>/dev/null > "$smackfsdir/netlabel"
-New32=`grep "$RuleA1" $smackfsdir/netlabel 2>/dev/null`
-if [ "$New32" != "$RuleA1" ]; then
-	echo "Rule \"$RuleA\" did not get set."
-	exit 1
+rule_a="191.191.191.191 TheOne"
+rule_a1="191.191.191.191/32 TheOne"
+rule_b="191.190.190.0/24 TheOne"
+
+old32=$(grep "^191.191.191.191/32" "$smackfsdir/netlabel" 2>/dev/null)
+old24=$(grep "^191.190.190.0/24" "$smackfsdir/netlabel" 2>/dev/null)
+
+echo -n "$rule_a" 2>/dev/null > "$smackfsdir/netlabel"
+new32=$(grep "$rule_a1" $smackfsdir/netlabel 2>/dev/null)
+if [ "$new32" != "$rule_a1" ]; then
+	tst_brkm TFAIL "Rule \"$rule_a\" did not get set."
 fi
 
-echo -n "$RuleB" 2>/dev/null > "$smackfsdir/netlabel"
-New24=`grep "$RuleB" "$smackfsdir/netlabel" 2>/dev/null`
-if [ "$New24" != "$RuleB" ]; then
-	echo "Rule \"$RuleB\" did not get set."
-	exit 1
+echo -n "$rule_b" 2>/dev/null > "$smackfsdir/netlabel"
+new24=$(grep "$rule_b" "$smackfsdir/netlabel" 2>/dev/null)
+if [ "$new24" != "$rule_b" ]; then
+	tst_brkm TFAIL "Rule \"$rule_b\" did not get set."
 fi
 
-if [ "$Old24" != "$New24" ]; then
-	cat <<EOM
-Notice: Test access rule changed from
-"$Old24" to "$New24".
-EOM
+if [ "$old24" != "$new24" ]; then
+	tst_resm TINFO "Notice: Test access rule changed from \"$old24\" to" \
+		       "\"$new24\"."
 fi
 
-if [ "$Old32" != "$New32" ]; then
-	cat <<EOM
-Notice: Test access rule changed from
-"$Old32" to "$New32".
-EOM
+if [ "$old32" != "$new32" ]; then
+	tst_resm TINFO "Notice: Test access rule changed from \"$old32\" to \
+\"$new32\"."
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
