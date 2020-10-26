From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 26 Oct 2020 08:00:06 +0100
Subject: [LTP] [PATCH 1/1] net: Remove legacy tests from runtest
Message-ID: <20201026070006.25298-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Remove all network stress tests which haven't been rewritten to the new
API yet from the runtest file (mostly multicast tests + some route tests).
These tests use check_envval and other deprecated tools.

See also:
https://github.com/linux-test-project/ltp/issues/310
https://github.com/linux-test-project/ltp/issues/440

Suggested-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/net_stress.multicast | 16 ----------------
 runtest/net_stress.route     |  4 ----
 2 files changed, 20 deletions(-)

diff --git a/runtest/net_stress.multicast b/runtest/net_stress.multicast
index d2288df62..463fe17ab 100644
--- a/runtest/net_stress.multicast
+++ b/runtest/net_stress.multicast
@@ -6,24 +6,8 @@ mcast4-group-single-socket mcast-group-single-socket
 mcast4-group-multiple-socket mcast-group-multiple-socket
 mcast4-group-same-group mcast-group-same-group
 mcast4-group-source-filter mcast-group-source-filter
-mcast4-pktfld01 mcast4-pktfld01
-mcast4-pktfld02 mcast4-pktfld02
-mcast4-queryfld01 mcast4-queryfld01
-mcast4-queryfld02 mcast4-queryfld02
-mcast4-queryfld03 mcast4-queryfld03
-mcast4-queryfld04 mcast4-queryfld04
-mcast4-queryfld05 mcast4-queryfld05
-mcast4-queryfld06 mcast4-queryfld06
 
 mcast6-group-single-socket mcast-group-single-socket -6
 mcast6-group-multiple-socket mcast-group-multiple-socket -6
 mcast6-group-same-group mcast-group-same-group -6
 mcast6-group-source-filter mcast-group-source-filter -6
-mcast6-pktfld01 mcast6-pktfld01
-mcast6-pktfld02 mcast6-pktfld02
-mcast6-queryfld01 mcast6-queryfld01
-mcast6-queryfld02 mcast6-queryfld02
-mcast6-queryfld03 mcast6-queryfld03
-mcast6-queryfld04 mcast6-queryfld04
-mcast6-queryfld05 mcast6-queryfld05
-mcast6-queryfld06 mcast6-queryfld06
diff --git a/runtest/net_stress.route b/runtest/net_stress.route
index 8755ef0be..b60e55bd6 100644
--- a/runtest/net_stress.route
+++ b/runtest/net_stress.route
@@ -5,8 +5,6 @@ route4-change-if route-change-if.sh
 route4-change-netlink-dst route-change-netlink-dst.sh
 route4-change-netlink-gw route-change-netlink-gw.sh
 route4-change-netlink-if route-change-netlink-if.sh
-route4-redirect route4-redirect
-route4-rmmod route4-rmmod
 
 route6-change-dst route-change-dst.sh -6
 route6-change-gw route-change-gw.sh -6
@@ -14,5 +12,3 @@ route6-change-if route-change-if.sh -6
 route6-change-netlink-dst route-change-netlink-dst.sh -6
 route6-change-netlink-gw route-change-netlink-gw.sh -6
 route6-change-netlink-if route-change-netlink-if.sh -6
-route6-redirect route6-redirect
-route6-rmmod route6-rmmod
-- 
2.28.0

