From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 12 Apr 2018 19:09:12 +0300
Subject: [LTP] [PATCH 2/2] lib/tst_net.sh: use nodad in tst_add_ipaddr()
In-Reply-To: <1523549352-1794-1-git-send-email-alexey.kodanev@oracle.com>
References: <1523549352-1794-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1523549352-1794-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Save time when the tests run with netns and without network.sh.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/tst_net.sh |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 53f6277..a95eb33 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -126,8 +126,6 @@ init_ltp_netspace()
 
 	tst_restore_ipaddr
 	tst_restore_ipaddr rhost
-
-	tst_wait_ipv6_dad
 }
 
 # Run command on remote host.
@@ -389,9 +387,10 @@ tst_add_ipaddr()
 {
 	local type="${1:-lhost}"
 	local link_num="${2:-0}"
-	local mask
+	local mask dad
 
 	if [ "$TST_IPV6" ]; then
+		dad="nodad"
 		[ "$type" = "lhost" ] && mask=$IPV6_LPREFIX || mask=$IPV6_RPREFIX
 	else
 		[ "$type" = "lhost" ] && mask=$IPV4_LPREFIX || mask=$IPV4_RPREFIX
@@ -401,12 +400,12 @@ tst_add_ipaddr()
 
 	if [ $type = "lhost" ]; then
 		tst_res_ TINFO "set local addr $(tst_ipaddr)/$mask"
-		ip addr add $(tst_ipaddr)/$mask dev $iface
+		ip addr add $(tst_ipaddr)/$mask dev $iface $dad
 		return $?
 	fi
 
 	tst_res_ TINFO "set remote addr $(tst_ipaddr rhost)/$mask"
-	tst_rhost_run -c "ip addr add $(tst_ipaddr rhost)/$mask dev $iface"
+	tst_rhost_run -c "ip addr add $(tst_ipaddr rhost)/$mask dev $iface $dad"
 }
 
 # tst_restore_ipaddr [TYPE] [LINK]
-- 
1.7.1

