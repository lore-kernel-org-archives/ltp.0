From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  6 Apr 2018 14:31:18 +0200
Subject: [LTP] [RFC PATCH v6 7/7] network/interface: Split tests to test
	only one command per test
In-Reply-To: <20180406123118.21309-1-pvorel@suse.cz>
References: <20180406123118.21309-1-pvorel@suse.cz>
Message-ID: <20180406123118.21309-8-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This change allows running tests based on ip command in case
ifconfig/route commands are not available (openSUSE/SLE removed long
time deprecated net-tools package).

Command is passed via -c parameter.

Introduce (again) if-lib.sh to reduce duplicity.

Minor syntax cleanup.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/net_stress.interface                       | 38 +++++++++-----
 testcases/network/stress/interface/if-addr-adddel  | 33 ++++--------
 .../network/stress/interface/if-addr-addlarge      | 32 ++++--------
 testcases/network/stress/interface/if-lib.sh       | 58 ++++++++++++++++++++++
 testcases/network/stress/interface/if-mtu-change   | 29 ++++-------
 testcases/network/stress/interface/if-route-adddel | 38 +++++---------
 .../network/stress/interface/if-route-addlarge     | 32 ++++--------
 testcases/network/stress/interface/if-updown       | 38 ++++----------
 8 files changed, 147 insertions(+), 151 deletions(-)
 create mode 100644 testcases/network/stress/interface/if-lib.sh

diff --git a/runtest/net_stress.interface b/runtest/net_stress.interface
index 97e9ce3bc..315f125d4 100644
--- a/runtest/net_stress.interface
+++ b/runtest/net_stress.interface
@@ -2,18 +2,30 @@
 # Stress test for interface
 #
 
-if4-addr-change if4-addr-change
+if4-addr-change_ifconfig if4-addr-change
 
-if4-updown if-updown
-if4-addr-adddel if-addr-adddel
-if4-addr-addlarge if-addr-addlarge
-if4-route-adddel if-route-adddel
-if4-route-addlarge if-route-addlarge
-if4-mtu-change if-mtu-change
+if4-updown_ip if-updown -c ip
+if4-updown_ifconfig if-updown -c ifconfig
+if4-addr-adddel_ip if-addr-adddel -c ip
+if4-addr-adddel_ifconfig if-addr-adddel -c ifconfig
+if4-addr-addlarge_ip if-addr-addlarge -c ip
+if4-addr-addlarge_ifconfig if-addr-addlarge -c ifconfig
+if4-route-adddel_ip if-route-adddel -c ip
+if4-route-adddel_route if-route-adddel -c route
+if4-route-addlarge_ip if-route-addlarge -c ip
+if4-route-addlarge_route if-route-addlarge -c route
+if4-mtu-change_ip if-mtu-change -c ip
+if4-mtu-change_ifconfig if-mtu-change -c ifconfig
 
-if6-updown if-updown -6
-if6-addr-adddel if-addr-adddel -6
-if6-addr-addlarge if-addr-addlarge -6
-if6-route-adddel if-route-adddel -6
-if6-route-addlarge if-route-addlarge -6
-if6-mtu-change if-mtu-change -6
+if6-updown_ip if-updown -6 -c ip
+if6-updown_ifconfig if-updown -6 -c ifconfig
+if6-addr-adddel_ip if-addr-adddel -6 -c ip
+if6-addr-adddel_ifconfig if-addr-adddel -6 -c ifconfig
+if6-addr-addlarge_ip if-addr-addlarge -6 -c ip
+if6-addr-addlarge_ifconfig if-addr-addlarge -6 -c ifconfig
+if6-route-adddel_ip if-route-adddel -6 -c ip
+if6-route-adddel_route if-route-adddel -6 -c route
+if6-route-addlarge_ip if-route-addlarge -6 -c ip
+if6-route-addlarge_route if-route-addlarge -6 -c route
+if6-mtu-change_ip if-mtu-change -6 -c ip
+if6-mtu-change_ifconfig if-mtu-change -6 -c ifconfig
diff --git a/testcases/network/stress/interface/if-addr-adddel b/testcases/network/stress/interface/if-addr-adddel
index 634e9d8a4..6728e2758 100644
--- a/testcases/network/stress/interface/if-addr-adddel
+++ b/testcases/network/stress/interface/if-addr-adddel
@@ -18,25 +18,15 @@
 #
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
-TST_CNT=2
-TST_SETUP="netstress_setup"
-TST_CLEANUP="netstress_cleanup"
-TST_TESTFUNC="test_if_ip"
-. tst_net_stress.sh
+IF_CMD='ifconfig'
+. if-lib.sh
 
 # The interval of the check interface activity
 CHECK_INTERVAL=${CHECK_INTERVAL:-$(($NS_TIMES / 20))}
 
 test_body()
 {
-	local cmd_type=$1
-
-	case $cmd_type in
-	if_cmd) local cmd_name='ifconfig' ;;
-	ip_cmd) local cmd_name='ip' ;;
-	*) tst_brk TBROK "Unknown test parameter '$cmd_type'"
-	esac
-
+	local cmd="$CMD"
 	local num=$(($(od -A n -t u1 -N 1 /dev/random) * 253 / 255 + 2 ))
 	local iface=$(tst_iface)
 	if [ "$TST_IPV6" ]; then
@@ -47,7 +37,7 @@ test_body()
 		local netmask=24
 	fi
 
-	tst_res TINFO "'$cmd_name' add/del IPv$ipver '$new_ip' $NS_TIMES times"
+	tst_res TINFO "'$cmd' add/del IPv$ipver '$new_ip' $NS_TIMES times"
 
 	if ! restore_ipaddr; then
 		tst_res TBROK "Failed to set default IP addresses"
@@ -58,15 +48,15 @@ test_body()
 	while [ $cnt -le $NS_TIMES ]; do
 		make_background_tcp_traffic
 
-		case $cmd_type in
-		if_cmd)
+		case $cmd in
+		ifconfig)
 			if [ "$TST_IPV6" ]; then
 				ifconfig $iface add $new_ip/$netmask
 			else
 				ifconfig $iface:1 $new_ip netmask 255.255.255.0
 			fi
 		;;
-		ip_cmd) ip addr add $new_ip/$netmask dev $iface ;;
+		ip) ip addr add $new_ip/$netmask dev $iface ;;
 		esac
 
 		if [ $? -ne 0 ]; then
@@ -85,19 +75,19 @@ test_body()
 
 		cnt=$(($cnt + 1))
 
-		case $cmd_type in
-		if_cmd)
+		case $cmd in
+		ifconfig)
 			if [ "$TST_IPV6" ]; then
 				ifconfig $iface del $new_ip/$netmask
 			else
 				ifconfig $iface:1 down
 			fi
 		;;
-		ip_cmd) ip addr del $new_ip/$netmask dev $iface ;;
+		ip) ip addr del $new_ip/$netmask dev $iface ;;
 		esac
 
 		if [ $? -ne 0 ]; then
-			tst_res TFAIL "delete command failed"
+			tst_res TFAIL " delete command failed".
 			return
 		fi
 
@@ -112,5 +102,4 @@ test_body()
 	tst_res TPASS "Test is finished correctly"
 }
 
-tst_check_cmds ifconfig
 tst_run
diff --git a/testcases/network/stress/interface/if-addr-addlarge b/testcases/network/stress/interface/if-addr-addlarge
index 5d1f63c12..b773dddf0 100644
--- a/testcases/network/stress/interface/if-addr-addlarge
+++ b/testcases/network/stress/interface/if-addr-addlarge
@@ -18,29 +18,20 @@
 #
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
-TST_CNT=2
-TST_SETUP="netstress_setup"
-TST_CLEANUP="netstress_cleanup"
-TST_TESTFUNC="test_if_ip"
-. tst_net_stress.sh
+IF_CMD='ifconfig'
+. if-lib.sh
 
 # The interval of the check interface activity
 CHECK_INTERVAL=${CHECK_INTERVAL:-$(($IP_TOTAL / 20))}
 
 test_body()
 {
-	local cmd_type=$1
-
-	case $cmd_type in
-	if_cmd) local cmd_name='ifconfig' ;;
-	ip_cmd) local cmd_name='ip' ;;
-	*) tst_brk TBROK "Unknown test parameter '$cmd_type'"
-	esac
+	local cmd="$CMD"
 
 	local iface=$(tst_iface)
 	[ "$TST_IPV6" ] && local netmask=64 || local netmask=16
 
-	tst_res TINFO "'$cmd_name' add $IP_TOTAL IPv$ipver addresses"
+	tst_res TINFO "'$cmd' add $IP_TOTAL IPv$ipver addresses"
 	tst_res TINFO "check interval that $iface is working: $CHECK_INTERVAL"
 
 	if ! restore_ipaddr; then
@@ -70,15 +61,15 @@ test_body()
 			local new_ip=${IPV4_NET16_UNUSED}.$x.$y
 		fi
 
-		case $cmd_type in
-		if_cmd)
+		case $cmd in
+		ifconfig)
 			if [ "$TST_IPV6" ]; then
 				ifconfig $iface add $new_ip/$netmask
 			else
 				ifconfig $iface:$x:$y $new_ip netmask 255.255.0.0
 			fi
 		;;
-		ip_cmd) ip addr add $new_ip/$netmask dev $iface ;;
+		ip) ip addr add $new_ip/$netmask dev $iface ;;
 		esac
 
 		if [ $? -ne 0 ]; then
@@ -95,19 +86,19 @@ test_body()
 
 		check_connectivity_interval $cnt || return
 
-		case $cmd_type in
-		if_cmd)
+		case $cmd in
+		ifconfig)
 			if [ "$TST_IPV6" ]; then
 				ifconfig $iface del $new_ip/$netmask
 			else
 				ifconfig $iface:$x:$y down
 			fi
 		;;
-		ip_cmd) ip addr del $new_ip/$netmask dev $iface ;;
+		ip) ip addr del $new_ip/$netmask dev $iface ;;
 		esac
 
 		if [ $? -ne 0 ]; then
-			tst_res TFAIL "delete command failed"
+			tst_res TFAIL " delete command failed".
 			return
 		fi
 
@@ -132,5 +123,4 @@ test_body()
 	tst_res TPASS "Test is finished correctly"
 }
 
-tst_check_cmds ifconfig
 tst_run
diff --git a/testcases/network/stress/interface/if-lib.sh b/testcases/network/stress/interface/if-lib.sh
new file mode 100644
index 000000000..b486c66d7
--- /dev/null
+++ b/testcases/network/stress/interface/if-lib.sh
@@ -0,0 +1,58 @@
+#!/bin/sh
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+# Author: Petr Vorel <pvorel@suse.cz>
+
+if_usage()
+{
+	echo "-c      Test command (ip, $IF_CMD)"
+}
+
+if_parse_args()
+{
+	case $1 in
+	c) CMD="$2";;
+	esac
+}
+
+if_setup()
+{
+	[ -n "$CMD" ] || tst_brk TBROK "IF_CMD variable not defined"
+	if [ "$CMD" != 'ip' -a "$CMD" != "$IF_CMD" ]; then
+		tst_brk TBROK "Missing or wrong -c parameter: '$CMD', use 'ip' or '$IF_CMD'"
+	fi
+
+	tst_check_cmds "$CMD"
+	netstress_setup
+}
+
+if_cleanup_restore()
+{
+	netstress_cleanup
+	restore_ipaddr
+	restore_ipaddr rhost
+}
+
+TST_CNT=2
+TST_SETUP="${TST_SETUP:-if_setup}"
+TST_CLEANUP="${TST_CLEANUP:-netstress_cleanup}"
+TST_TESTFUNC="test_body"
+TST_PARSE_ARGS="if_parse_args"
+TST_USAGE="if_usage"
+TST_OPTS="c:"
+
+. tst_net_stress.sh
diff --git a/testcases/network/stress/interface/if-mtu-change b/testcases/network/stress/interface/if-mtu-change
index 232372105..19bcffe1e 100644
--- a/testcases/network/stress/interface/if-mtu-change
+++ b/testcases/network/stress/interface/if-mtu-change
@@ -18,11 +18,10 @@
 #
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
-TST_CNT=2
+IF_CMD='ifconfig'
 TST_SETUP="do_setup"
 TST_CLEANUP="do_cleanup"
-TST_TESTFUNC="test_if_ip"
-. tst_net_stress.sh
+. if-lib.sh
 
 # The interval of the mtu change [second]
 CHANGE_INTERVAL=${CHANGE_INTERVAL:-5}
@@ -36,38 +35,28 @@ saved_mtu=
 do_setup()
 {
 	[ "$TST_IPV6" ] && CHANGE_VALUES=$CHANGE6_VALUES
-	netstress_setup
-	tst_check_cmds ifconfig
+	if_setup
 	saved_mtu="$(cat /sys/class/net/$(tst_iface)/mtu)"
 }
 
 do_cleanup()
 {
-	netstress_cleanup
+	if_cleanup_restore
 	if [ "$saved_mtu" ]; then
 		ip li set $(tst_iface) mtu $saved_mtu
 		tst_rhost_run -c "ip li set $(tst_iface rhost) mtu $saved_mtu"
 	fi
-	tst_restore_ipaddr
-	tst_restore_ipaddr rhost
-	tst_wait_ipv6_dad
 }
 
 test_body()
 {
-	local cmd_type=$1
-
-	case $cmd_type in
-	if_cmd) local cmd_name='ifconfig' ;;
-	ip_cmd) local cmd_name='ip' ;;
-	*) tst_brk TBROK "Unknown test parameter '$cmd_type'"
-	esac
+	local cmd="$CMD"
 
 	local iface=$(tst_iface)
 	local iface_rmt=$(tst_iface rhost)
 	[ "$TST_IPV6" ] && local netmask=64 || local netmask=16
 
-	tst_res TINFO "'$cmd_name changes MTU $MTU_CHANGE_TIMES times" \
+	tst_res TINFO "'$cmd' changes MTU $MTU_CHANGE_TIMES times" \
 	               "every $CHANGE_INTERVAL seconds"
 
 	mtu_array_len=$(echo $CHANGE_VALUES | wc -w)
@@ -83,11 +72,11 @@ test_body()
 
 		tst_res TINFO "set MTU to $mtu $cnt/$MTU_CHANGE_TIMES"
 		local ret=0
-		case $cmd_type in
-		if_cmd) ifconfig $iface mtu $mtu || ret=1
+		case $cmd in
+		ifconfig) ifconfig $iface mtu $mtu || ret=1
 			tst_rhost_run -c "ifconfig $iface_rmt mtu $mtu"
 		;;
-		ip_cmd) ip link set $iface mtu $mtu || ret=1
+		ip) ip link set $iface mtu $mtu || ret=1
 			tst_rhost_run -c "ip link set $iface_rmt mtu $mtu"
 		;;
 		esac
diff --git a/testcases/network/stress/interface/if-route-adddel b/testcases/network/stress/interface/if-route-adddel
index 9c25bf06b..4ca523e2f 100644
--- a/testcases/network/stress/interface/if-route-adddel
+++ b/testcases/network/stress/interface/if-route-adddel
@@ -18,24 +18,14 @@
 #
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
-TST_CNT=2
-TST_SETUP="netstress_setup"
-TST_CLEANUP="netstress_cleanup"
-TST_TESTFUNC="test_rt_ip"
-. tst_net_stress.sh
+IF_CMD='route'
+. if-lib.sh
 
 CHECK_INTERVAL=${CHECK_INTERVAL:-$(($NS_TIMES / 20))}
 
 test_body()
 {
-	local cmd_type=$1
-
-	case $cmd_type in
-	rt_cmd) local cmd_name='route' ;;
-	ip_cmd) local cmd_name='ip' ;;
-	*) tst_brk TBROK "Unknown test parameter '$cmd_type'"
-	esac
-
+	local cmd="$CMD"
 	local iface=$(tst_iface)
 	local inet="inet$TST_IPV6"
 	local new_rt=
@@ -45,13 +35,12 @@ test_body()
 		opt_rt="/64"
 	else
 		new_rt="$(tst_ipaddr_un 23)"
-		case $cmd_type in
-		rt_cmd) ;;
-		ip_cmd) opt_rt='/24' ;;
-		esac
+		if [ "$cmd" = "ip" ]; then
+			opt_rt='/24'
+		fi
 	fi
 
-	tst_res TINFO "'$cmd_name' add/del ${new_rt}${opt_rt} $NS_TIMES times"
+	tst_res TINFO "'$cmd' add/del ${new_rt}${opt_rt} $NS_TIMES times"
 
 	if ! restore_ipaddr; then
 		tst_res TBROK "Failed to set default IP addresses"
@@ -62,18 +51,18 @@ test_body()
 	while [ $cnt -le $NS_TIMES ]; do
 		make_background_tcp_traffic
 
-		case $cmd_type in
-		rt_cmd) route -A $inet add ${new_rt}${opt_rt} dev $iface ;;
-		ip_cmd) ip route add ${new_rt}${opt_rt} dev $iface ;;
+		case $cmd in
+		route) route -A $inet add ${new_rt}${opt_rt} dev $iface ;;
+		ip) ip route add ${new_rt}${opt_rt} dev $iface ;;
 		esac
 		if [ $? -ne 0 ]; then
 			tst_res TFAIL "Can't add route $new_rt to $iface"
 			return
 		fi
 
-		case $cmd_type in
-		rt_cmd) route -A $inet del ${new_rt}${opt_rt} dev $iface ;;
-		ip_cmd) ip route del ${new_rt}${opt_rt} dev $iface ;;
+		case $cmd in
+		route) route -A $inet del ${new_rt}${opt_rt} dev $iface ;;
+		ip) ip route del ${new_rt}${opt_rt} dev $iface ;;
 		esac
 		if [ $? -ne 0 ]; then
 			tst_res TFAIL "Can't del route $new_rt from $iface"
@@ -88,5 +77,4 @@ test_body()
 	tst_res TPASS "Test is finished correctly"
 }
 
-tst_check_cmds route
 tst_run
diff --git a/testcases/network/stress/interface/if-route-addlarge b/testcases/network/stress/interface/if-route-addlarge
index 675155088..ec22f9d2a 100644
--- a/testcases/network/stress/interface/if-route-addlarge
+++ b/testcases/network/stress/interface/if-route-addlarge
@@ -18,37 +18,24 @@
 #
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
-TST_CNT=2
-TST_SETUP="netstress_setup"
-TST_CLEANUP="netstress_cleanup"
-TST_TESTFUNC="test_rt_ip"
-. tst_net_stress.sh
+IF_CMD='route'
+. if-lib.sh
 
 CHECK_INTERVAL=${CHECK_INTERVAL:-$(($ROUTE_TOTAL / 20))}
 
 test_body()
 {
-	local cmd_type=$1
-
-	case $cmd_type in
-	rt_cmd) local cmd_name='route' ;;
-	ip_cmd) local cmd_name='ip' ;;
-	*) tst_brk TBROK "Unknown test parameter '$cmd_type'"
-	esac
-
+	local cmd="$CMD"
 	local iface=$(tst_iface)
 	local inet="inet$TST_IPV6"
 	local opt_rt=
 	if [ "$TST_IPV6" ]; then
 		opt_rt="/64"
-	else
-		case $cmd_type in
-		rt_cmd) ;;
-		ip_cmd) opt_rt='/32' ;;
-		esac
+	elif [ "$cmd" = "ip" ]; then
+		opt_rt='/32'
 	fi
 
-	tst_res TINFO "'$cmd_name' add IPv$ipver $ROUTE_TOTAL routes"
+	tst_res TINFO "'$cmd' add IPv$ipver $ROUTE_TOTAL routes"
 
 	if ! restore_ipaddr; then
 		tst_res TBROK "Failed to set default IP addresses"
@@ -77,9 +64,9 @@ test_body()
 			local new_rt=${IPV4_NET16_UNUSED}.$x.$y
 		fi
 
-		case $cmd_type in
-		rt_cmd) route -A $inet add ${new_rt}${opt_rt} dev $iface ;;
-		ip_cmd) ip route add ${new_rt}${opt_rt} dev $iface ;;
+		case $cmd in
+		route) route -A $inet add ${new_rt}${opt_rt} dev $iface ;;
+		ip) ip route add ${new_rt}${opt_rt} dev $iface ;;
 		esac
 		if [ $? -ne 0 ]; then
 			tst_res TFAIL "Can't add route $new_rt to $iface"
@@ -102,5 +89,4 @@ test_body()
 	tst_res TPASS "Test is finished correctly"
 }
 
-tst_check_cmds route
 tst_run
diff --git a/testcases/network/stress/interface/if-updown b/testcases/network/stress/interface/if-updown
index ddb75715e..d5f321821 100644
--- a/testcases/network/stress/interface/if-updown
+++ b/testcases/network/stress/interface/if-updown
@@ -18,49 +18,34 @@
 #
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
-TST_CNT=2
-TST_SETUP="netstress_setup"
-TST_CLEANUP="do_cleanup"
-TST_TESTFUNC="test_if_ip"
-. tst_net_stress.sh
+IF_CMD='ifconfig'
+TST_CLEANUP="if_cleanup_restore"
+. if-lib.sh
 
 CHECK_INTERVAL=${CHECK_INTERVAL:-$(($IF_UPDOWN_TIMES / 20))}
 
-do_cleanup()
-{
-	netstress_cleanup
-	restore_ipaddr
-}
-
 test_body()
 {
-	local cmd_type=$1
-
-	case $cmd_type in
-	if_cmd) local cmd_name='ifconfig' ;;
-	ip_cmd) local cmd_name='ip' ;;
-	*) tst_brk TBROK "Unknown test parameter '$cmd_type'"
-	esac
-
+	local cmd="$CMD"
 	local iface=$(tst_iface)
 
-	tst_res TINFO "'$cmd_name ups/downs $iface $IF_UPDOWN_TIMES times"
+	tst_res TINFO "'$cmd' ups/downs $iface $IF_UPDOWN_TIMES times"
 	tst_res TINFO "check connectivity interval is $CHECK_INTERVAL"
 
 	local cnt=1
 	while [ $cnt -le $IF_UPDOWN_TIMES ]; do
-		case $cmd_type in
-		if_cmd) ifconfig $iface down ;;
-		ip_cmd) ip link set $iface down ;;
+		case $cmd in
+		ifconfig) ifconfig $iface down ;;
+		ip) ip link set $iface down ;;
 		esac
 		if [ $? -ne 0 ]; then
 			tst_res TFAIL "Failed to down $iface"
 			return
 		fi
 
-		case $cmd_type in
-		if_cmd) ifconfig $iface up ;;
-		ip_cmd) ip link set $iface up ;;
+		case $cmd in
+		ifconfig) ifconfig $iface up ;;
+		ip) ip link set $iface up ;;
 		esac
 		if [ $? -ne 0 ]; then
 			tst_res TFAIL "Failed to up $iface"
@@ -75,5 +60,4 @@ test_body()
 	tst_res TPASS "Test is finished correctly"
 }
 
-tst_check_cmds ifconfig
 tst_run
-- 
2.16.2

