Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1XmG7H-0004q2-V3
	for ltp-list@lists.sourceforge.net; Thu, 06 Nov 2014 06:00:19 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XmG7G-0007EI-QB
	for ltp-list@lists.sourceforge.net; Thu, 06 Nov 2014 06:00:19 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id sA65YECE019098
	for <ltp-list@lists.sourceforge.net>; Thu, 6 Nov 2014 13:34:16 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Thu, 6 Nov 2014 13:31:29 +0800
Message-ID: <1415251889-10596-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] containers: fix three cases' exit status
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

In iproute2 whose version is earlier than v2.6.39, ip
command doesn't support netns object. In this condition,
running three cases (netns_devices.sh, netns_devices2.sh
and netns_isolation.sh) will exit with TFAIL. It is not
suitable, so fix these cases' exit status with TCONF.

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 testcases/kernel/containers/netns/netns_devices.sh   | 4 ++++
 testcases/kernel/containers/netns/netns_devices2.sh  | 4 ++++
 testcases/kernel/containers/netns/netns_isolation.sh | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/testcases/kernel/containers/netns/netns_devices.sh b/testcases/kernel/containers/netns/netns_devices.sh
index 7126267..990a74c 100755
--- a/testcases/kernel/containers/netns/netns_devices.sh
+++ b/testcases/kernel/containers/netns/netns_devices.sh
@@ -46,6 +46,10 @@ cleanup()
 # SETUP
 tst_require_root
 tst_check_cmds ip
+# check if ip command supports netns object
+ip help 2>&1 | grep -w netns &>/dev/null || \
+	tst_brkm TCONF "ip command does not support netns object"
+
 TST_CLEANUP=cleanup
 
 # creates a new network namespace "myns0" (man 8 ip-netns)
diff --git a/testcases/kernel/containers/netns/netns_devices2.sh b/testcases/kernel/containers/netns/netns_devices2.sh
index f0d0651..7e68eea 100755
--- a/testcases/kernel/containers/netns/netns_devices2.sh
+++ b/testcases/kernel/containers/netns/netns_devices2.sh
@@ -46,6 +46,10 @@ cleanup()
 # SETUP
 tst_require_root
 tst_check_cmds ip ifconfig
+# check if ip command supports netns object
+ip help 2>&1 | grep -w netns &>/dev/null || \
+	tst_brkm TCONF "ip command does not support netns object"
+
 TST_CLEANUP=cleanup
 
 # creates a new network namespace "myns0" (man 8 ip-netns)
diff --git a/testcases/kernel/containers/netns/netns_isolation.sh b/testcases/kernel/containers/netns/netns_isolation.sh
index f1ddf2c..127b07f 100755
--- a/testcases/kernel/containers/netns/netns_isolation.sh
+++ b/testcases/kernel/containers/netns/netns_isolation.sh
@@ -40,6 +40,10 @@ cleanup()
 # SETUP
 tst_require_root
 tst_check_cmds ip
+# check if ip command supports netns object
+ip help 2>&1 | grep -w netns &>/dev/null || \
+	tst_brkm TCONF "ip command does not support netns object"
+
 TST_CLEANUP=cleanup
 
 
-- 
1.9.3


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
