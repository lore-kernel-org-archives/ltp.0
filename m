From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 24 Sep 2020 10:17:40 +0300
Subject: [LTP] [PATCH 5/5] network/ipneigh01: use ROD when deleting the
 entries
In-Reply-To: <20200924071740.6963-1-alexey.kodanev@oracle.com>
References: <20200924071740.6963-1-alexey.kodanev@oracle.com>
Message-ID: <20200924071740.6963-5-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/tcp_cmds/ipneigh/ipneigh01.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
index e15dd708c..6ad987c49 100755
--- a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
+++ b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
@@ -20,14 +20,14 @@ do_setup()
 	case $CMD in
 	ip)
 		SHOW_CMD="ip neigh show"
-		DEL_CMD="ip neigh del $(tst_ipaddr rhost) dev $(tst_iface)"
+		DEL_CMD="ROD ip neigh del $(tst_ipaddr rhost) dev $(tst_iface)"
 		;;
 	arp)
 		if [ -n "$TST_IPV6" ]; then
 			tst_brk TCONF "'arp' doesn't support IPv6"
 		fi
 		SHOW_CMD="arp -a"
-		DEL_CMD="arp -d $(tst_ipaddr rhost) -i $(tst_iface)"
+		DEL_CMD="ROD arp -d $(tst_ipaddr rhost) -i $(tst_iface)"
 		;;
 	*)
 		tst_brk TBROK "unknown or missing command, use -c [ arp | ip ]"
@@ -75,7 +75,7 @@ do_test()
 		[ "$ret" -ne 0 ] && \
 			tst_brk TFAIL "$entry_name entry '$(tst_ipaddr rhost)' not listed"
 
-		$DEL_CMD || tst_brk TFAIL "fail to delete entry"
+		$DEL_CMD
 
 		$SHOW_CMD | grep -q "$(tst_ipaddr rhost).*$(tst_hwaddr rhost)" && \
 			tst_brk TFAIL "'$DEL_CMD' failed, entry has " \
-- 
2.20.1

