From: yangj <yangj.fnst@cn.fujitsu.com>
Date: Tue, 15 Jan 2019 10:08:46 +0800
Subject: [LTP] [PATCH] change ip command of route6-change-gw
Message-ID: <20190115020846.625-1-yangj.fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

when useing old ip commond to test,it will get the following
 error:

RTNETLINK answers: File exists

So I changed this case like the ip command of route4-change-gw
Signed-off-by:jian yang <yangj.fnst@cn.fujitsu.com>
---
 testcases/network/stress/route/route6-change-gw | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/testcases/network/stress/route/route6-change-gw b/testcases/network/stress/route/route6-change-gw
index 96fd7ee66..05e45b907 100644
--- a/testcases/network/stress/route/route6-change-gw
+++ b/testcases/network/stress/route/route6-change-gw
@@ -245,8 +245,7 @@ test_body()
 	    route -A inet6 del ${dst_network}/64 gw ${IPV6_NETWORK}:${pre_rhost_part_hex} dev $lhost_ifname
 	    ;;
 	    2)
-	    ip -f inet6 route add ${dst_network}/64 via ${IPV6_NETWORK}:${rhost_part_hex} dev $lhost_ifname
-	    ip -f inet6 route del ${dst_network}/64 via ${IPV6_NETWORK}:${pre_rhost_part_hex} dev $lhost_ifname
+	    ip -f inet6 route change ${dst_network}/64 via ${IPV6_NETWORK}:${rhost_part_hex} dev $lhost_ifname
 	    ;;
 	esac
 	if [ $? -ne 0 ]; then
-- 
2.17.0



