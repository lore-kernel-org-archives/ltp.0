From: Chen Rong <rongx.a.chen@intel.com>
Date: Mon, 12 Feb 2018 10:21:47 +0800
Subject: [LTP] [PATCH] testcases/lib/test_net.sh: Fix test rpc_clnt_broadcast
Message-ID: <1518402107-4307-1-git-send-email-rongx.a.chen@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

rpc_clnt_broadcast will return timeout if broadcast not set

Signed-off-by: Chen Rong <rongx.a.chen@intel.com>
---
 testcases/lib/test_net.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index 1e001f7..8626d27 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -327,23 +327,25 @@ tst_add_ipaddr()
 	local type="${1:-lhost}"
 	local link_num="${2:-0}"
 	local mask
+	local broadcast_option
 
 	if [ "$TST_IPV6" ]; then
 		[ "$type" = "lhost" ] && mask=$IPV6_LPREFIX || mask=$IPV6_RPREFIX
 	else
 		[ "$type" = "lhost" ] && mask=$IPV4_LPREFIX || mask=$IPV4_RPREFIX
+		broadcast_option="broadcast $IPV4_BROADCAST"
 	fi
 
 	local iface=$(tst_iface $type $link_num)
 
 	if [ $type = "lhost" ]; then
 		tst_resm TINFO "set local addr $(tst_ipaddr)/$mask"
-		ip addr add $(tst_ipaddr)/$mask dev $iface
+		ip addr add $(tst_ipaddr)/$mask $broadcast_option dev $iface
 		return $?
 	fi
 
 	tst_resm TINFO "set remote addr $(tst_ipaddr rhost)/$mask"
-	tst_rhost_run -c "ip addr add $(tst_ipaddr rhost)/$mask dev $iface"
+	tst_rhost_run -c "ip addr add $(tst_ipaddr rhost)/$mask $broadcast_option dev $iface"
 }
 
 # tst_restore_ipaddr [TYPE] [LINK]
@@ -616,6 +618,7 @@ export LTP_RSH="${LTP_RSH:-rsh -n}"
 # but if you use IP/prefix form, /prefix will be removed by tst_net_vars.
 IPV4_LHOST="${IPV4_LHOST:-10.0.0.2/24}"
 IPV4_RHOST="${IPV4_RHOST:-10.0.0.1/24}"
+IPV4_BROADCAST="${IPV4_BROADCAST:-10.0.0.255}"
 IPV6_LHOST="${IPV6_LHOST:-fd00:1:1:1::2/64}"
 IPV6_RHOST="${IPV6_RHOST:-fd00:1:1:1::1/64}"
 
-- 
2.7.4

