From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue,  8 Dec 2020 19:24:39 +0300
Subject: [LTP] [PATCH 1/2] lib/tst_net.sh: add getopts to tst_ping()
Message-ID: <20201208162440.14538-1-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Replace '-i 0' with '-f'

* Add similar checks for the flood and interval options as
  in ping02 test

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/tst_net.sh                      | 55 +++++++++++++------
 testcases/network/mpls/mpls02.sh              |  2 +-
 testcases/network/mpls/mpls_lib.sh            |  4 +-
 .../network/stress/icmp/icmp-uni-basic.sh     |  2 +-
 testcases/network/stress/icmp/icmp-uni-vti.sh |  2 +-
 .../network/stress/interface/if-mtu-change.sh |  2 +-
 .../network/stress/ns-tools/tst_net_stress.sh |  2 +-
 7 files changed, 45 insertions(+), 24 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 46d3fb88e..ef9354903 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -800,37 +800,58 @@ tst_netload_compare()
 	tst_res_ TPASS "$msg, in range [${threshold_low}:${threshold_hi}]%"
 }
 
-# tst_ping [IFACE] [DST ADDR] [MESSAGE SIZE ARRAY]
+tst_ping_opt_unsupported()
+{
+	ping $@ 2>&1 | grep -q "invalid option"
+}
+
+# tst_ping -c COUNT -s MESSAGE_SIZES -p PATTERN -I IFACE -H HOST
 # Check icmp connectivity
 # IFACE: source interface name or IP address
-# DST ADDR: destination IPv4 or IPv6 address
-# MESSAGE SIZE ARRAY: message size array
+# HOST: destination IPv4 or IPv6 address
+# MESSAGE_SIZES: message size array
 tst_ping()
 {
 	# The max number of ICMP echo request
-	PING_MAX="${PING_MAX:-500}"
-
-	local src_iface="${1:-$(tst_iface)}"
-	local dst_addr="${2:-$(tst_ipaddr rhost)}"; shift $(( $# >= 2 ? 2 : 0 ))
-	local msg_sizes="$*"
-	local msg="tst_ping $dst_addr iface/saddr $src_iface, msg_size"
+	local ping_count="${PING_MAX:-500}"
+	local flood_opt="-f"
+	local pattern_opt
+	local msg_sizes
+	local src_iface="$(tst_iface)"
+	local dst_addr="$(tst_ipaddr rhost)"
 	local cmd="ping"
 	local ret=0
+	local opts
+
+	local OPTIND
+	while getopts c:s:p:I:H: opt; do
+		case "$opt" in
+		c) ping_count="$OPTARG";;
+		s) msg_sizes="$OPTARG";;
+		p) pattern_opt="-p $OPTARG";;
+		I) src_iface="$OPTARG";;
+		H) dst_addr="$OPTARG";;
+		*) tst_brk_ TBROK "tst_ping: unknown option: $OPTARG";;
+		esac
+	done
 
 	echo "$dst_addr" | grep -q ':' && cmd="ping6"
 	tst_require_cmds $cmd
 
+	if tst_ping_opt_unsupported $flood_opt; then
+		flood_opt="-i 0.01"
+		[ "$pattern_opt" ] && pattern_opt="-p aa"
+
+		tst_ping_opt_unsupported -i $pattern_opt && \
+			tst_brk_ TCONF "unsupported ping version (old busybox?)"
+	fi
+
 	# ping cmd use 56 as default message size
 	for size in ${msg_sizes:-"56"}; do
-		$cmd -I $src_iface -c $PING_MAX $dst_addr \
-			-s $size -i 0 > /dev/null 2>&1
+		EXPECT_PASS $cmd -I $src_iface -c $ping_count -s $size \
+			$flood_opt $pattern_opt $dst_addr \>/dev/null
 		ret=$?
-		if [ $ret -eq 0 ]; then
-			tst_res_ TPASS "$msg $size: pass"
-		else
-			tst_res_ TFAIL "$msg $size: fail"
-			break
-		fi
+		[ "$ret" -ne 0 ] && break
 	done
 	return $ret
 }
diff --git a/testcases/network/mpls/mpls02.sh b/testcases/network/mpls/mpls02.sh
index c263f8aa8..2fd3ec5bf 100755
--- a/testcases/network/mpls/mpls02.sh
+++ b/testcases/network/mpls/mpls02.sh
@@ -43,7 +43,7 @@ do_test()
 	local max_size=$TST_NET_MAX_PKT
 
 	if [ "$type" = "icmp" ]; then
-		tst_ping $ip_loc $ip_rmt 10 100 1000 2000 $max_size
+		tst_ping -I $ip_loc -H $ip_rmt -s "10 100 1000 2000 $max_size"
 	else
 		tst_netload -S $ip_loc -H $ip_rmt -T $type -n 10 -N 10
 		tst_netload -S $ip_loc -H $ip_rmt -T $type -A $max_size
diff --git a/testcases/network/mpls/mpls_lib.sh b/testcases/network/mpls/mpls_lib.sh
index 8ebedba0f..30e069581 100755
--- a/testcases/network/mpls/mpls_lib.sh
+++ b/testcases/network/mpls/mpls_lib.sh
@@ -87,8 +87,8 @@ mpls_virt_test()
 	local max_size=$TST_NET_MAX_PKT
 
 	if [ "$type" = "icmp" ]; then
-		tst_ping $ip_virt_local $ip_virt_remote 10 100 1000 2000 $max_size
-		tst_ping $ip6_virt_local $ip6_virt_remote 10 100 1000 2000 $max_size
+		tst_ping -I $ip_virt_local -H $ip_virt_remote -s "10 100 1000 2000 $max_size"
+		tst_ping -I $ip6_virt_local -H $ip6_virt_remote -s "10 100 1000 2000 $max_size"
 	else
 		tst_netload -S $ip_virt_local -H $ip_virt_remote -T $type -n 10 -N 10
 		tst_netload -S $ip6_virt_local -H $ip6_virt_remote -T $type -n 10 -N 10
diff --git a/testcases/network/stress/icmp/icmp-uni-basic.sh b/testcases/network/stress/icmp/icmp-uni-basic.sh
index 5980b81e5..2ae616cc3 100755
--- a/testcases/network/stress/icmp/icmp-uni-basic.sh
+++ b/testcases/network/stress/icmp/icmp-uni-basic.sh
@@ -19,7 +19,7 @@ do_setup()
 
 do_test()
 {
-	tst_ping $(tst_iface) $(tst_ipaddr rhost) $2
+	tst_ping -s $2
 }
 
 tst_run
diff --git a/testcases/network/stress/icmp/icmp-uni-vti.sh b/testcases/network/stress/icmp/icmp-uni-vti.sh
index 24eca177c..18bc71cfb 100755
--- a/testcases/network/stress/icmp/icmp-uni-vti.sh
+++ b/testcases/network/stress/icmp/icmp-uni-vti.sh
@@ -18,7 +18,7 @@ do_setup()
 
 do_test()
 {
-	tst_ping $tst_vti $ip_rmt_tun $2
+	tst_ping -I $tst_vti -H $ip_rmt_tun -s $2
 }
 
 tst_run
diff --git a/testcases/network/stress/interface/if-mtu-change.sh b/testcases/network/stress/interface/if-mtu-change.sh
index b945fb6ce..8112cdf0e 100755
--- a/testcases/network/stress/interface/if-mtu-change.sh
+++ b/testcases/network/stress/interface/if-mtu-change.sh
@@ -77,7 +77,7 @@ test_body()
 
 		tst_sleep $CHANGE_INTERVAL
 
-		tst_ping $(tst_ipaddr) $(tst_ipaddr rhost) "1 1000 65507"
+		tst_ping -s "1 1000 65507"
 	done
 }
 
diff --git a/testcases/network/stress/ns-tools/tst_net_stress.sh b/testcases/network/stress/ns-tools/tst_net_stress.sh
index ae040bcf1..4b00ee7f8 100644
--- a/testcases/network/stress/ns-tools/tst_net_stress.sh
+++ b/testcases/network/stress/ns-tools/tst_net_stress.sh
@@ -69,7 +69,7 @@ check_connectivity()
 
 	tst_res TINFO "ping through $src_iface iface to ${dst_addr}$cnt_msg"
 
-	tst_ping $src_iface $dst_addr
+	tst_ping -I $src_iface -H $dst_addr
 }
 
 # check_connectivity_interval CNT [RESTORE] [SRC_IFACE] [DST_ADDR]
-- 
2.20.1

