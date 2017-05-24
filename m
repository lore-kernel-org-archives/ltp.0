From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 24 May 2017 11:40:28 +0300
Subject: [LTP] [PATCH 2/4] net: remove EXPECT_PASS usage with tst_ping()
In-Reply-To: <1495615230-29045-1-git-send-email-alexey.kodanev@oracle.com>
References: <1495615230-29045-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1495615230-29045-3-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 .../network/stress/broken_ip/broken_ip4-checksum   |    2 +-
 .../network/stress/broken_ip/broken_ip4-dstaddr    |    2 +-
 .../network/stress/broken_ip/broken_ip4-fragment   |    2 +-
 testcases/network/stress/broken_ip/broken_ip4-ihl  |    2 +-
 .../network/stress/broken_ip/broken_ip4-protcol    |    2 +-
 .../network/stress/broken_ip/broken_ip4-totlen     |    2 +-
 .../network/stress/broken_ip/broken_ip4-version    |    2 +-
 .../network/stress/broken_ip/broken_ip6-dstaddr    |    2 +-
 .../network/stress/broken_ip/broken_ip6-nexthdr    |    2 +-
 testcases/network/stress/broken_ip/broken_ip6-plen |    2 +-
 .../network/stress/broken_ip/broken_ip6-version    |    2 +-
 testcases/network/stress/icmp/icmp-uni-basic.sh    |    5 -----
 testcases/network/stress/icmp/icmp-uni-vti.sh      |    2 +-
 testcases/network/stress/interface/if-lib.sh       |    7 +------
 testcases/network/stress/interface/if-mtu-change   |    2 +-
 testcases/network/stress/interface/if4-addr-change |    4 ++--
 16 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/testcases/network/stress/broken_ip/broken_ip4-checksum b/testcases/network/stress/broken_ip/broken_ip4-checksum
index 33667ba..ff30fbf 100644
--- a/testcases/network/stress/broken_ip/broken_ip4-checksum
+++ b/testcases/network/stress/broken_ip/broken_ip4-checksum
@@ -27,6 +27,6 @@ tst_resm TINFO "Sending ICMPv4 with wrong chksum field for $NS_DURATION sec"
 
 tst_icmp -t $NS_DURATION -s "0 100 500 1000 1472" -c
 
-EXPECT_PASS tst_ping
+tst_ping
 
 tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip4-dstaddr b/testcases/network/stress/broken_ip/broken_ip4-dstaddr
index b4b676e..eb236f2 100644
--- a/testcases/network/stress/broken_ip/broken_ip4-dstaddr
+++ b/testcases/network/stress/broken_ip/broken_ip4-dstaddr
@@ -27,6 +27,6 @@ tst_resm TINFO "Sending ICMPv4 with wrong dst address for $NS_DURATION sec"
 
 tst_icmp -t $NS_DURATION -s "0 100 500 1000 1472" -i
 
-EXPECT_PASS tst_ping
+tst_ping
 
 tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip4-fragment b/testcases/network/stress/broken_ip/broken_ip4-fragment
index dbef193..8f2aca9 100644
--- a/testcases/network/stress/broken_ip/broken_ip4-fragment
+++ b/testcases/network/stress/broken_ip/broken_ip4-fragment
@@ -27,6 +27,6 @@ tst_resm TINFO "Sending ICMPv4 with wrong frag. info for $NS_DURATION sec"
 
 tst_icmp -t $NS_DURATION -s "0 100 500 1000 1472" -f
 
-EXPECT_PASS tst_ping
+tst_ping
 
 tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip4-ihl b/testcases/network/stress/broken_ip/broken_ip4-ihl
index 48deb3b..2e136a5 100644
--- a/testcases/network/stress/broken_ip/broken_ip4-ihl
+++ b/testcases/network/stress/broken_ip/broken_ip4-ihl
@@ -27,6 +27,6 @@ tst_resm TINFO "Sending ICMPv4 with wrong header len field for $NS_DURATION sec"
 
 tst_icmp -t $NS_DURATION -s "0 100 500 1000 1472" -l
 
-EXPECT_PASS tst_ping
+tst_ping
 
 tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip4-protcol b/testcases/network/stress/broken_ip/broken_ip4-protcol
index b4b767c..a57ce61 100644
--- a/testcases/network/stress/broken_ip/broken_ip4-protcol
+++ b/testcases/network/stress/broken_ip/broken_ip4-protcol
@@ -27,6 +27,6 @@ tst_resm TINFO "Sending ICMPv4 with wrong proto field for $NS_DURATION sec"
 
 tst_icmp -t $NS_DURATION -s "0 100 500 1000 1472" -p
 
-EXPECT_PASS tst_ping
+tst_ping
 
 tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip4-totlen b/testcases/network/stress/broken_ip/broken_ip4-totlen
index 051d969..4466487 100644
--- a/testcases/network/stress/broken_ip/broken_ip4-totlen
+++ b/testcases/network/stress/broken_ip/broken_ip4-totlen
@@ -27,6 +27,6 @@ tst_resm TINFO "Sending ICMPv4 with wrong total len field for $NS_DURATION sec"
 
 tst_icmp -t $NS_DURATION -s "0 100 500 1000 1472" -L
 
-EXPECT_PASS tst_ping
+tst_ping
 
 tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip4-version b/testcases/network/stress/broken_ip/broken_ip4-version
index c3ccf7f..83cf568 100644
--- a/testcases/network/stress/broken_ip/broken_ip4-version
+++ b/testcases/network/stress/broken_ip/broken_ip4-version
@@ -27,6 +27,6 @@ tst_resm TINFO "Sending ICMPv4 with wrong version field for $NS_DURATION sec"
 
 tst_icmp -t $NS_DURATION -s "0 100 500 1000 1472" -v
 
-EXPECT_PASS tst_ping
+tst_ping
 
 tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip6-dstaddr b/testcases/network/stress/broken_ip/broken_ip6-dstaddr
index 5da38ab..ea7d66d 100644
--- a/testcases/network/stress/broken_ip/broken_ip6-dstaddr
+++ b/testcases/network/stress/broken_ip/broken_ip6-dstaddr
@@ -27,6 +27,6 @@ tst_resm TINFO "Sending ICMPv6 with wrong dst address for $NS_DURATION sec"
 
 tst_icmp -t $NS_DURATION -s "0 100 500 1000 1452" -i
 
-EXPECT_PASS tst_ping
+tst_ping
 
 tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip6-nexthdr b/testcases/network/stress/broken_ip/broken_ip6-nexthdr
index bb1bdcb..ebbef5e 100644
--- a/testcases/network/stress/broken_ip/broken_ip6-nexthdr
+++ b/testcases/network/stress/broken_ip/broken_ip6-nexthdr
@@ -27,6 +27,6 @@ tst_resm TINFO "Sending ICMPv4 with wrong next header for $NS_DURATION sec"
 
 tst_icmp -t $NS_DURATION -s "0 100 500 1000 1452" -n
 
-EXPECT_PASS tst_ping
+tst_ping
 
 tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip6-plen b/testcases/network/stress/broken_ip/broken_ip6-plen
index 8eacbf4..e93cdcc 100644
--- a/testcases/network/stress/broken_ip/broken_ip6-plen
+++ b/testcases/network/stress/broken_ip/broken_ip6-plen
@@ -27,6 +27,6 @@ tst_resm TINFO "Sending ICMPv4 with wrong payload len for $NS_DURATION sec"
 
 tst_icmp -t $NS_DURATION -s "0 100 500 1000 1452" -L
 
-EXPECT_PASS tst_ping
+tst_ping
 
 tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip6-version b/testcases/network/stress/broken_ip/broken_ip6-version
index cdce71f..3eff2d7 100644
--- a/testcases/network/stress/broken_ip/broken_ip6-version
+++ b/testcases/network/stress/broken_ip/broken_ip6-version
@@ -27,6 +27,6 @@ tst_resm TINFO "Sending ICMPv6 with wrong version field for $NS_DURATION sec"
 
 tst_icmp -t $NS_DURATION -s "0 100 500 1000 1452" -v
 
-EXPECT_PASS tst_ping
+tst_ping
 
 tst_exit
diff --git a/testcases/network/stress/icmp/icmp-uni-basic.sh b/testcases/network/stress/icmp/icmp-uni-basic.sh
index 2aae945..7e50386 100755
--- a/testcases/network/stress/icmp/icmp-uni-basic.sh
+++ b/testcases/network/stress/icmp/icmp-uni-basic.sh
@@ -57,10 +57,5 @@ if $DO_IPSEC ; then
 fi
 
 tst_ping $lhost_ifname $rhost_addr $IPSEC_SIZE_ARRAY
-if [ $? -ne 0 ]; then
-	tst_resm TFAIL "Checked IPv${TST_IPV6:-4} $IPSEC_PROTO $IPSEC_MODE"
-else
-	tst_resm TPASS "Checked IPv${TST_IPV6:-4} $IPSEC_PROTO $IPSEC_MODE"
-fi
 
 tst_exit
diff --git a/testcases/network/stress/icmp/icmp-uni-vti.sh b/testcases/network/stress/icmp/icmp-uni-vti.sh
index a19c869..b9a1034 100755
--- a/testcases/network/stress/icmp/icmp-uni-vti.sh
+++ b/testcases/network/stress/icmp/icmp-uni-vti.sh
@@ -27,7 +27,7 @@ do_test()
 	IPSEC_SIZE_ARRAY="${IPSEC_SIZE_ARRAY:-10 100 1000 10000 65507}"
 
 	tst_resm TINFO "Sending ICMP messages..."
-	EXPECT_PASS tst_ping $tst_vti $ip_rmt_tun $IPSEC_SIZE_ARRAY
+	tst_ping $tst_vti $ip_rmt_tun $IPSEC_SIZE_ARRAY
 }
 
 tst_ipsec_setup_vti
diff --git a/testcases/network/stress/interface/if-lib.sh b/testcases/network/stress/interface/if-lib.sh
index 4168dd0..000f742 100644
--- a/testcases/network/stress/interface/if-lib.sh
+++ b/testcases/network/stress/interface/if-lib.sh
@@ -58,12 +58,7 @@ check_connectivity()
 
 	[ -n "$restore" ] && restore_ipaddr
 
-	tst_ping
-	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "$(tst_iface) is broken"
-		return 1
-	fi
-	return 0
+	tst_ping || return 1
 }
 
 restore_ipaddr()
diff --git a/testcases/network/stress/interface/if-mtu-change b/testcases/network/stress/interface/if-mtu-change
index 637fa63..01cbec6 100644
--- a/testcases/network/stress/interface/if-mtu-change
+++ b/testcases/network/stress/interface/if-mtu-change
@@ -91,7 +91,7 @@ test_body()
 
 		tst_sleep $CHANGE_INTERVAL
 
-		EXPECT_PASS tst_ping $(tst_ipaddr) $(tst_ipaddr rhost) "1 1000 65507"
+		tst_ping $(tst_ipaddr) $(tst_ipaddr rhost) "1 1000 65507"
 
 		# Check the background TCP traffic
 		pgrep -x netstress > /dev/null || make_background_tcp_traffic
diff --git a/testcases/network/stress/interface/if4-addr-change b/testcases/network/stress/interface/if4-addr-change
index 54b8fd5..cbe22ce 100644
--- a/testcases/network/stress/interface/if4-addr-change
+++ b/testcases/network/stress/interface/if4-addr-change
@@ -61,9 +61,9 @@ while [ $cnt -lt $NS_TIMES ]; do
 	[ $(($cnt % $CHECK_INTERVAL)) -ne 0 ] && continue
 
 	tst_resm TINFO "ping $(tst_ipaddr):$(tst_ipaddr rhost) ${cnt}/$NS_TIMES"
-	EXPECT_PASS tst_ping
+	tst_ping
 done
 
-EXPECT_PASS tst_ping
+tst_ping
 
 tst_exit
-- 
1.7.1

