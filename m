From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  1 Jun 2018 13:49:51 +0200
Subject: [LTP] [PATCH 2/7] tst_net.sh: Rename ipver to TST_IPVER
In-Reply-To: <20180601114956.17265-1-pvorel@suse.cz>
References: <20180601114956.17265-1-pvorel@suse.cz>
Message-ID: <20180601114956.17265-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ rename variable in network interface and multicast tests,
where it's used from tst_net.sh (other tests set it in setup functions,
these not changed).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh                                              | 4 ++--
 testcases/lib/tst_test.sh                                             | 2 +-
 testcases/network/stress/interface/if-addr-adddel                     | 2 +-
 testcases/network/stress/interface/if-addr-addlarge                   | 2 +-
 testcases/network/stress/interface/if-route-addlarge                  | 2 +-
 .../stress/multicast/grp-operation/mcast-group-multiple-socket        | 2 +-
 .../network/stress/multicast/grp-operation/mcast-group-same-group     | 2 +-
 .../network/stress/multicast/grp-operation/mcast-group-single-socket  | 2 +-
 .../network/stress/multicast/grp-operation/mcast-group-source-filter  | 2 +-
 testcases/network/stress/multicast/grp-operation/mcast-lib.sh         | 2 +-
 testcases/network/stress/ns-tools/tst_net_stress.sh                   | 2 +-
 11 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index fd2eacf2f..aad701952 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -29,12 +29,12 @@ TST_SETUP="tst_net_setup"
 
 # Blank for an IPV4 test; 6 for an IPV6 test.
 TST_IPV6=${TST_IPV6:-}
-ipver=${TST_IPV6:-4}
+TST_IPVER=${TST_IPV6:-4}
 
 tst_net_parse_args()
 {
 	case $1 in
-	6) TST_IPV6=6 ipver=6;;
+	6) TST_IPV6=6 TST_IPVER=6;;
 	*) $TST_PARSE_ARGS_CALLER "$1" "$2";;
 	esac
 }
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index d8d60c156..1130c462c 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -255,7 +255,7 @@ tst_run()
 			OPTS|USAGE|PARSE_ARGS|POS_ARGS);;
 			NEEDS_ROOT|NEEDS_TMPDIR|NEEDS_DEVICE|DEVICE);;
 			NEEDS_CMDS|NEEDS_MODULE|MODPATH|DATAROOT);;
-			IPV6);;
+			IPV6|IPVER);;
 			*) tst_res TWARN "Reserved variable TST_$tst_i used!";;
 			esac
 		done
diff --git a/testcases/network/stress/interface/if-addr-adddel b/testcases/network/stress/interface/if-addr-adddel
index 6728e2758..8e3990f93 100644
--- a/testcases/network/stress/interface/if-addr-adddel
+++ b/testcases/network/stress/interface/if-addr-adddel
@@ -37,7 +37,7 @@ test_body()
 		local netmask=24
 	fi
 
-	tst_res TINFO "'$cmd' add/del IPv$ipver '$new_ip' $NS_TIMES times"
+	tst_res TINFO "'$cmd' add/del IPv$TST_IPVER '$new_ip' $NS_TIMES times"
 
 	if ! restore_ipaddr; then
 		tst_res TBROK "Failed to set default IP addresses"
diff --git a/testcases/network/stress/interface/if-addr-addlarge b/testcases/network/stress/interface/if-addr-addlarge
index b773dddf0..78641e462 100644
--- a/testcases/network/stress/interface/if-addr-addlarge
+++ b/testcases/network/stress/interface/if-addr-addlarge
@@ -31,7 +31,7 @@ test_body()
 	local iface=$(tst_iface)
 	[ "$TST_IPV6" ] && local netmask=64 || local netmask=16
 
-	tst_res TINFO "'$cmd' add $IP_TOTAL IPv$ipver addresses"
+	tst_res TINFO "'$cmd' add $IP_TOTAL IPv$TST_IPVER addresses"
 	tst_res TINFO "check interval that $iface is working: $CHECK_INTERVAL"
 
 	if ! restore_ipaddr; then
diff --git a/testcases/network/stress/interface/if-route-addlarge b/testcases/network/stress/interface/if-route-addlarge
index ec22f9d2a..f522f9a16 100644
--- a/testcases/network/stress/interface/if-route-addlarge
+++ b/testcases/network/stress/interface/if-route-addlarge
@@ -35,7 +35,7 @@ test_body()
 		opt_rt='/32'
 	fi
 
-	tst_res TINFO "'$cmd' add IPv$ipver $ROUTE_TOTAL routes"
+	tst_res TINFO "'$cmd' add IPv$TST_IPVER $ROUTE_TOTAL routes"
 
 	if ! restore_ipaddr; then
 		tst_res TBROK "Failed to set default IP addresses"
diff --git a/testcases/network/stress/multicast/grp-operation/mcast-group-multiple-socket b/testcases/network/stress/multicast/grp-operation/mcast-group-multiple-socket
index 2939a68e6..7b79b42df 100644
--- a/testcases/network/stress/multicast/grp-operation/mcast-group-multiple-socket
+++ b/testcases/network/stress/multicast/grp-operation/mcast-group-multiple-socket
@@ -34,7 +34,7 @@ do_setup()
 
 do_test()
 {
-	tst_res TINFO "joining $MCASTNUM_HEAVY IPv$ipver multicast groups on multiple sockets"
+	tst_res TINFO "joining $MCASTNUM_HEAVY IPv$TST_IPVER multicast groups on multiple sockets"
 	do_multicast_test_multiple_join $MCASTNUM_HEAVY true
 }
 
diff --git a/testcases/network/stress/multicast/grp-operation/mcast-group-same-group b/testcases/network/stress/multicast/grp-operation/mcast-group-same-group
index cfdc114f4..e10f16c09 100644
--- a/testcases/network/stress/multicast/grp-operation/mcast-group-same-group
+++ b/testcases/network/stress/multicast/grp-operation/mcast-group-same-group
@@ -28,7 +28,7 @@ do_setup()
 
 do_test()
 {
-	tst_res TINFO "joining and leaving the same IPv$ipver multicast group on $MCASTNUM_NORMAL sockets in $NS_TIMES times"
+	tst_res TINFO "joining and leaving the same IPv$TST_IPVER multicast group on $MCASTNUM_NORMAL sockets in $NS_TIMES times"
 	do_multicast_test_join_leave $MCASTNUM_NORMAL
 }
 
diff --git a/testcases/network/stress/multicast/grp-operation/mcast-group-single-socket b/testcases/network/stress/multicast/grp-operation/mcast-group-single-socket
index 9334072fb..ff58152cb 100644
--- a/testcases/network/stress/multicast/grp-operation/mcast-group-single-socket
+++ b/testcases/network/stress/multicast/grp-operation/mcast-group-single-socket
@@ -28,7 +28,7 @@ do_setup()
 
 do_test()
 {
-	tst_res TINFO "joining $MCASTNUM_HEAVY IPv$ipver multicast groups on a single socket"
+	tst_res TINFO "joining $MCASTNUM_HEAVY IPv$TST_IPVER multicast groups on a single socket"
 	do_multicast_test_multiple_join $MCASTNUM_HEAVY
 }
 
diff --git a/testcases/network/stress/multicast/grp-operation/mcast-group-source-filter b/testcases/network/stress/multicast/grp-operation/mcast-group-source-filter
index a14bded29..df70344da 100644
--- a/testcases/network/stress/multicast/grp-operation/mcast-group-source-filter
+++ b/testcases/network/stress/multicast/grp-operation/mcast-group-source-filter
@@ -28,7 +28,7 @@ do_setup()
 
 do_test()
 {
-	tst_res TINFO "joining and leaving the same IPv$ipver multicast group with a different source filters on $MCASTNUM_NORMAL sockets in $NS_TIMES times"
+	tst_res TINFO "joining and leaving the same IPv$TST_IPVER multicast group with a different source filters on $MCASTNUM_NORMAL sockets in $NS_TIMES times"
 	do_multicast_test_join_leave $MCASTNUM_NORMAL true
 }
 
diff --git a/testcases/network/stress/multicast/grp-operation/mcast-lib.sh b/testcases/network/stress/multicast/grp-operation/mcast-lib.sh
index 6796f59f9..8e9420ed2 100644
--- a/testcases/network/stress/multicast/grp-operation/mcast-lib.sh
+++ b/testcases/network/stress/multicast/grp-operation/mcast-lib.sh
@@ -61,7 +61,7 @@ mcast_setup()
 {
 	local max="$1"
 
-	MCAST_LCMD="ns-mcast_join -f $ipver -I $(tst_iface)"
+	MCAST_LCMD="ns-mcast_join -f $TST_IPVER -I $(tst_iface)"
 
 	local cmd="ns-igmp_querier"
 	[ "$TST_IPV6" ] && cmd="ns-icmpv6_sender"
diff --git a/testcases/network/stress/ns-tools/tst_net_stress.sh b/testcases/network/stress/ns-tools/tst_net_stress.sh
index 9b02fd9ca..e5c2672a3 100644
--- a/testcases/network/stress/ns-tools/tst_net_stress.sh
+++ b/testcases/network/stress/ns-tools/tst_net_stress.sh
@@ -115,7 +115,7 @@ make_background_tcp_traffic()
 	pgrep -x netstress > /dev/null && return
 
 	local ip="${1:-$(tst_ipaddr)}"
-	local port=$(tst_get_unused_port ipv${ipver} stream)
+	local port=$(tst_get_unused_port ipv${TST_IPVER} stream)
 
 	netstress -R 3 -g $port > /dev/null 2>&1 &
 	tst_rhost_run -b -c "netstress -l -H $ip -g $port"
-- 
2.16.3

