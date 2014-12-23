Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1Y3LrR-0007Mo-Ny
	for ltp-list@lists.sourceforge.net; Tue, 23 Dec 2014 09:34:37 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Y3LrQ-00013x-IC
	for ltp-list@lists.sourceforge.net; Tue, 23 Dec 2014 09:34:37 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id sBN9XSsw027032
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Dec 2014 17:33:28 +0800
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Tue, 23 Dec 2014 17:33:34 +0800
Message-ID: <1419327221-28508-5-git-send-email-zenglg.jy@cn.fujitsu.com>
In-Reply-To: <1419327221-28508-1-git-send-email-zenglg.jy@cn.fujitsu.com>
References: <1419327221-28508-1-git-send-email-zenglg.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 05/12] smack_set_current.sh: Cleanup
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
 .../kernel/security/smack/smack_set_current.sh     | 40 ++++++++++++----------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/testcases/kernel/security/smack/smack_set_current.sh b/testcases/kernel/security/smack/smack_set_current.sh
index 28a1b1b..4e52c89 100755
--- a/testcases/kernel/security/smack/smack_set_current.sh
+++ b/testcases/kernel/security/smack/smack_set_current.sh
@@ -11,29 +11,31 @@
 #	/smack/onlycap unset
 #
 
-source smack_common.sh
+export TCID=smack_set_current
+export TST_TOTAL=1
 
-NotTheFloorLabel="XYZZY"
-StartLabel=`cat /proc/self/attr/current 2>/dev/null`
+. test.sh
 
-echo "$NotTheFloorLabel" 2>/dev/null > /proc/self/attr/current
+. smack_common.sh
 
-label=`cat /proc/self/attr/current 2>/dev/null`
-if [ "$label" != "$NotTheFloorLabel" ]; then
-	cat <<EOM
-The smack label reported for the current process is "$label",
-not the expected "$NotTheFloorLabel".
-EOM
-	exit 1
+not_floor_label="XYZZY"
+start_label=$(cat /proc/self/attr/current 2>/dev/null)
+
+echo "$not_floor_label" 2>/dev/null > /proc/self/attr/current
+
+label=$(cat /proc/self/attr/current 2>/dev/null)
+if [ "$label" != "$not_floor_label" ]; then
+	tst_brkm TFAIL "The smack label reported for the current process is" \
+		       "\"$label\", not the expected \"$not_floor_label\"."
 fi
 
-echo "$StartLabel" 2>/dev/null > /proc/self/attr/current
+echo "$start_label" 2>/dev/null > /proc/self/attr/current
 
-label=`cat /proc/self/attr/current > /dev/null`
-if [ "$label" != "$StartLabel" ]; then
-	cat <<EOM
-The smack label reported for the current process is "$label",
-not the expected "$StartLabel".
-EOM
-	exit 1
+label=$(cat /proc/self/attr/current 2> /dev/null)
+if [ "$label" != "$start_label" ]; then
+	tst_brkm TFAIL "The smack label reported for the current process is" \
+		       "\"$label\", not the expected \"$start_label\"."
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
