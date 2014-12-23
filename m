Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1Y3LrT-0000Qd-JA
	for ltp-list@lists.sourceforge.net; Tue, 23 Dec 2014 09:34:39 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Y3LrS-00013x-FY
	for ltp-list@lists.sourceforge.net; Tue, 23 Dec 2014 09:34:39 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id sBN9XSDX027035
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Dec 2014 17:33:28 +0800
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Tue, 23 Dec 2014 17:33:35 +0800
Message-ID: <1419327221-28508-6-git-send-email-zenglg.jy@cn.fujitsu.com>
In-Reply-To: <1419327221-28508-1-git-send-email-zenglg.jy@cn.fujitsu.com>
References: <1419327221-28508-1-git-send-email-zenglg.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 06/12] smack_set_direct.sh: Cleanup
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
 .../kernel/security/smack/smack_set_direct.sh      | 40 ++++++++++++----------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/testcases/kernel/security/smack/smack_set_direct.sh b/testcases/kernel/security/smack/smack_set_direct.sh
index 84135f5..9d27653 100755
--- a/testcases/kernel/security/smack/smack_set_direct.sh
+++ b/testcases/kernel/security/smack/smack_set_direct.sh
@@ -10,29 +10,31 @@
 #	CAP_MAC_ADMIN
 #
 
-source smack_common.sh
+export TCID=smack_set_direct
+export TST_TOTAL=1
 
-NotTheStartValue="17"
-StartValue=`cat "$smackfsdir/direct" 2>/dev/null`
+. test.sh
 
-echo "$NotTheStartValue" 2>/dev/null > "$smackfsdir/direct"
+. smack_common.sh
 
-DirectValue=`cat "$smackfsdir/direct" 2>/dev/null`
-if [ "$DirectValue" != "$NotTheStartValue" ]; then
-	cat <<EOM
-The CIPSO direct level reported is "$DirectValue",
-not the expected "$NotTheStartValue".
-EOM
-	exit 1
+not_start_value="17"
+start_value=$(cat "$smackfsdir/direct" 2>/dev/null)
+
+echo "$not_start_value" 2>/dev/null > "$smackfsdir/direct"
+
+direct_value=$(cat "$smackfsdir/direct" 2>/dev/null)
+if [ "$direct_value" != "$not_start_value" ]; then
+	tst_brkm TFAIL "The CIPSO direct level reported is \"$direct_value\"," \
+		       "not the expected \"$not_start_value\"."
 fi
 
-echo "$StartValue" 2>/dev/null> "$smackfsdir/direct"
+echo "$start_value" 2>/dev/null> "$smackfsdir/direct"
 
-DirectValue=`cat "$smackfsdir/direct" 2>/dev/null`
-if [ "$DirectValue" != "$StartValue" ]; then
-	cat <<EOM
-The CIPSO direct level reported is "$DirectValue",
-not the expected "$StartValue".
-EOM
-	exit 1
+direct_value=$(cat "$smackfsdir/direct" 2>/dev/null)
+if [ "$direct_value" != "$start_value" ]; then
+	tst_brkm TFAIL "The CIPSO direct level reported is \"$direct_value\"," \
+		       "not the expected \"$start_value\"."
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
