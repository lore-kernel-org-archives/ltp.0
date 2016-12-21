From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 22 Dec 2016 00:04:21 +0100
Subject: [LTP] [PATCH 2/3] test_net.sh: delete netns before testing
In-Reply-To: <20161221230422.26696-1-pvorel@suse.cz>
References: <20161221230422.26696-1-pvorel@suse.cz>
Message-ID: <20161221230422.26696-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Tested with (second run breaks it):
TST_USE_NETNS=1 ./testscripts/network.sh -6

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
It shouldn't be a problem as 'export TST_INIT_NETNS="no"' help us not to
redefine each time test_net.sh is loaded.
---
 testcases/lib/test_net.sh | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index 7d82e8962..535a2abb3 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -25,11 +25,10 @@ init_ltp_netspace()
 	LHOST_IFACES=${LHOST_IFACES:-"ltp_ns_veth2"}
 	RHOST_IFACES=${RHOST_IFACES:-"ltp_ns_veth1"}
 
-	if [ ! -f /var/run/netns/ltp_ns ]; then
-		ROD ip net add ltp_ns
-		ROD ip li add name $RHOST_IFACES type veth peer name $LHOST_IFACES
-		ROD ip li set dev $RHOST_IFACES netns ltp_ns
-	fi
+	ip netns del ltp_ns 2>/dev/null
+	ROD ip net add ltp_ns
+	ROD ip li add name $RHOST_IFACES type veth peer name $LHOST_IFACES
+	ROD ip li set dev $RHOST_IFACES netns ltp_ns
 
 	export TST_INIT_NETNS="no"
 	export LTP_NETNS=${LTP_NETNS:-"ip netns exec ltp_ns"}
-- 
2.11.0

