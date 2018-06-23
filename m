From: Sun Lianwen <sunlw.fnst@cn.fujitsu.com>
Date: Sat, 23 Jun 2018 10:07:09 +0800
Subject: [LTP] [PATCH] route: fix double add the same route
Message-ID: <20180623020709.3575-1-sunlw.fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

"route -A inet6 add ${dst_network}/64 gw ${IPV6_NETWORK}:${rhost_part_hex} dev $lhost_ifname
route -A inet6 del ${dst_network}/64 gw ${IPV6_NETWORK}:${pre_rhost_part_hex} dev $lhost_ifname"
can't complete delete the have already added test route, This can result to add the same route
when exec "ip -f inet6 route add ${dst_network}/64 via ${IPV6_NETWORK}:${rhost_part_hex} dev
$lhost_ifname" and report error "RTNETLINK answers: File exists"

Signed-off-by: Sun Lianwen <sunlw.fnst@cn.fujitsu.com>
---
 testcases/network/stress/route/route6-change-gw | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/testcases/network/stress/route/route6-change-gw b/testcases/network/stress/route/route6-change-gw
index 96fd7ee66..be819f1c2 100644
--- a/testcases/network/stress/route/route6-change-gw
+++ b/testcases/network/stress/route/route6-change-gw
@@ -245,8 +245,7 @@ test_body()
 	    route -A inet6 del ${dst_network}/64 gw ${IPV6_NETWORK}:${pre_rhost_part_hex} dev $lhost_ifname
 	    ;;
 	    2)
-	    ip -f inet6 route add ${dst_network}/64 via ${IPV6_NETWORK}:${rhost_part_hex} dev $lhost_ifname
-	    ip -f inet6 route del ${dst_network}/64 via ${IPV6_NETWORK}:${pre_rhost_part_hex} dev $lhost_ifname
+		ip -f inet6 route change ${dst_network}/64 via ${IPV6_NETWORK}:${rhost_part_hex} dev $lhost_ifname
 	    ;;
 	esac
 	if [ $? -ne 0 ]; then
-- 
2.17.1



