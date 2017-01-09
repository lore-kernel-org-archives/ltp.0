From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon,  9 Jan 2017 16:36:09 +0300
Subject: [LTP] [COMMITTED][PATCH] test_net.sh: fix adding IP addresses in
	netns setup
Message-ID: <1483968969-5649-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When running LTP network tests for the first time with ./network.sh -6,
netns setup function in test_net.sh tries to add IPv6 addresses twice
because '-6' option passed to test_net.sh too.

Fix it by explicitly setting TST_IPV6 in netns setup when adding IPv4
addresses.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/test_net.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index 7fdbeb1..71df6be 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -38,8 +38,8 @@ init_ltp_netspace()
 	tst_init_iface
 	tst_init_iface rhost
 
-	tst_add_ipaddr
-	tst_add_ipaddr rhost
+	TST_IPV6= tst_add_ipaddr
+	TST_IPV6= tst_add_ipaddr rhost
 
 	TST_IPV6=6 tst_add_ipaddr
 	TST_IPV6=6 tst_add_ipaddr rhost
-- 
1.7.1

