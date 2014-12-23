Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1Y3LrY-0005EY-EF
	for ltp-list@lists.sourceforge.net; Tue, 23 Dec 2014 09:34:44 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Y3Lr5-00018H-Ph
	for ltp-list@lists.sourceforge.net; Tue, 23 Dec 2014 09:34:44 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id sBN9XOpl027018
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Dec 2014 17:33:25 +0800
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Tue, 23 Dec 2014 17:33:30 +0800
Message-ID: <1419327221-28508-1-git-send-email-zenglg.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 01/12] smack_common.sh: Cleanup
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

* On some systems 'smackfs' mounts aren't listed in the output from 'df',
  so we switch to the '/proc/mounts' instead.

* Use 'tst_brkm'.

* Use '$()' instead of '``'.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/security/smack/smack_common.sh | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/security/smack/smack_common.sh b/testcases/kernel/security/smack/smack_common.sh
index 5d7f112..d4165d1 100755
--- a/testcases/kernel/security/smack/smack_common.sh
+++ b/testcases/kernel/security/smack/smack_common.sh
@@ -27,20 +27,20 @@
 
 smackfsdir=${smackfsdir:=/smack}
 
-check_mounted() {
-	if ! expr "$smackfsdir" : "$(df -P | awk "\$NF == \"$smackfsdir\""'{ print $NF }')"; then
-		echo "smackfs not mounted at $smackfsdir"
-		exit 1
+check_mounted()
+{
+	grep -q $smackfsdir /proc/mounts
+	if [ $? -ne 0 ]; then
+		tst_brkm TCONF "smackfs not mounted at \"$smackfsdir\""
 	fi
 }
 
-check_onlycap() {
-	onlycap=`cat "$smackfsdir/onlycap" 2>/dev/null`
-	if [ "$onlycap" != "" ]; then
-		cat <<EOM
-The smack label reported for $smackfsdir/onlycap is "$onlycap", not the expected "".
-EOM
-		exit 1
+check_onlycap()
+{
+	onlycap=$(cat "$smackfsdir/onlycap" 2>/dev/null)
+	if [ -n "$onlycap" ]; then
+		tst_brkm TCONF "\"$smackfsdir/onlycap\" is \"$onlycap\", not" \
+			       "the expected \"\"."
 	fi
 }
 
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
