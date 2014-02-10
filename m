Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WCq1N-0006WY-H9
	for ltp-list@lists.sourceforge.net; Mon, 10 Feb 2014 12:31:33 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WCq1K-00083Y-Fs
	for ltp-list@lists.sourceforge.net; Mon, 10 Feb 2014 12:31:33 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s1ABI01v004561
	for <ltp-list@lists.sourceforge.net>; Mon, 10 Feb 2014 19:18:03 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Mon, 10 Feb 2014 19:16:38 +0800
Message-Id: <1392030999-4431-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH v3 1/2] testcases/lib/cmdlib.sh: add
	tst_require_root() function
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Replace is_root() with tst_require_root().

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 testcases/commands/sssd/sssd-lib.sh                        | 2 +-
 testcases/kernel/security/integrity/ima/tests/ima_setup.sh | 6 +-----
 testcases/kernel/syscalls/syslog/syslog-lib.sh             | 2 +-
 testcases/lib/cmdlib.sh                                    | 7 +++++--
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/testcases/commands/sssd/sssd-lib.sh b/testcases/commands/sssd/sssd-lib.sh
index d63ed6d..9c84729 100755
--- a/testcases/commands/sssd/sssd-lib.sh
+++ b/testcases/commands/sssd/sssd-lib.sh
@@ -73,7 +73,7 @@ cleanup()
 
 setup()
 {
-	is_root || exit 1
+	tst_require_root
 
 	trap '	disable_traps
 		tst_resm TBROK "Testing is terminating due to a signal"
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 33dd8b2..4013e1f 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -95,11 +95,7 @@ setup()
 		PATH=$PATH:$LTPBIN
 	fi
 
-	# Must be root
-	if ! is_root; then
-		tst_resm TCONF "You must be root to execute this test"
-		return 1
-	fi
+	tst_require_root
 
 	# create the temporary directory used by this testcase
 	LTPIMA=$LTPTMP/ima
diff --git a/testcases/kernel/syscalls/syslog/syslog-lib.sh b/testcases/kernel/syscalls/syslog/syslog-lib.sh
index b656515..b67a8f2 100755
--- a/testcases/kernel/syscalls/syslog/syslog-lib.sh
+++ b/testcases/kernel/syscalls/syslog/syslog-lib.sh
@@ -59,7 +59,7 @@ cleanup()
 
 setup()
 {
-	is_root || exit 1
+	tst_require_root
 
 	trap '	disable_traps
 		tst_resm TBROK "Testing is terminating due to a signal"
diff --git a/testcases/lib/cmdlib.sh b/testcases/lib/cmdlib.sh
index d6f43d2..09d2cf1 100644
--- a/testcases/lib/cmdlib.sh
+++ b/testcases/lib/cmdlib.sh
@@ -114,9 +114,12 @@ incr_tst_count()
     : $(( TST_COUNT += 1 ))
 }
 
-is_root()
+tst_require_root()
 {
-    [ "x$(id -ru)" = x0 ]
+	if [ "x$(id -u)" != "x0" ]; then
+		tst_resm TCONF "You must be root to execute this test"
+		exit 0
+	fi
 }
 
 #
-- 
1.8.2.1


------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121051231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
