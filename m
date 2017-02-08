From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed,  8 Feb 2017 18:07:38 +0300
Subject: [LTP] [PATCH 3/3] net: interfaces: various fixes
In-Reply-To: <1486566458-18921-1-git-send-email-alexey.kodanev@oracle.com>
References: <1486566458-18921-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1486566458-18921-3-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* if4-addr-change: fix 'local: can only be used in a function' error;

* call tst_wait_ipv6_dad() after restoring interface configuration and
  brining up interface in 'if-updown' tests;

* remove tst_restore_ipaddr() from tests which don't change IP addresses
  or routes;

* if-mtu-change:
  * save MTU before test and restore in cleanup;
  * change MTU on both ends;
  * tst_sleep (change inerval) right after changing MTU and before tst_ping;
  * use 552 as a minimum mtu for IPv4 (net.ipv4.route.min_pmtu);
  * pass different message sizes to tst_ping in order to test fragmentation;

* change check interval calculation, allow to have up to 20 intervals, not 100;

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/stress/interface/if-addr-adddel  |   14 ++++-
 .../network/stress/interface/if-addr-addlarge      |   16 ++++--
 testcases/network/stress/interface/if-lib.sh       |   16 +++++-
 testcases/network/stress/interface/if-mtu-change   |   54 ++++++++++++--------
 testcases/network/stress/interface/if-route-adddel |   14 ++++-
 .../network/stress/interface/if-route-addlarge     |   15 ++++-
 testcases/network/stress/interface/if-updown       |    6 +--
 testcases/network/stress/interface/if4-addr-change |   30 +++++------
 8 files changed, 109 insertions(+), 56 deletions(-)

diff --git a/testcases/network/stress/interface/if-addr-adddel b/testcases/network/stress/interface/if-addr-adddel
index 0a069ef..569c36d 100644
--- a/testcases/network/stress/interface/if-addr-adddel
+++ b/testcases/network/stress/interface/if-addr-adddel
@@ -22,8 +22,16 @@ TCID=if-addr-adddel
 
 . if-lib.sh
 
+TST_CLEANUP="do_cleanup"
+
 # The interval of the check interface activity (check ten times)
-CHECK_INTERVAL=${CHECK_INTERVAL:-$(($NS_TIMES / 100))}
+CHECK_INTERVAL=${CHECK_INTERVAL:-$(($NS_TIMES / 20))}
+
+do_cleanup()
+{
+	cleanup
+	restore_ipaddr
+}
 
 test_body()
 {
@@ -47,8 +55,10 @@ test_body()
 
 	tst_resm TINFO "'$cmd_name' add/del IPv$ipver '$new_ip' $NS_TIMES times"
 
-	tst_restore_ipaddr || \
+	if ! restore_ipaddr; then
 		tst_resm TBROK "Failed to set default IP addresses"
+		return
+	fi
 
 	make_background_tcp_traffic
 
diff --git a/testcases/network/stress/interface/if-addr-addlarge b/testcases/network/stress/interface/if-addr-addlarge
index a6b841d..d5cb83b 100644
--- a/testcases/network/stress/interface/if-addr-addlarge
+++ b/testcases/network/stress/interface/if-addr-addlarge
@@ -22,8 +22,16 @@ TCID=if-addr-addlarge
 
 . if-lib.sh
 
+TST_CLEANUP="do_cleanup"
+
 # The interval of the check interface activity (check ten times)
-CHECK_INTERVAL=${CHECK_INTERVAL:-$(($IP_TOTAL / 100))}
+CHECK_INTERVAL=${CHECK_INTERVAL:-$(($IP_TOTAL / 20))}
+
+do_cleanup()
+{
+	cleanup
+	restore_ipaddr
+}
 
 test_body()
 {
@@ -41,8 +49,10 @@ test_body()
 	tst_resm TINFO "'$cmd_name' add $IP_TOTAL IPv$ipver addresses"
 	tst_resm TINFO "check interval that $iface is working: $CHECK_INTERVAL"
 
-	tst_restore_ipaddr || \
+	if ! restore_ipaddr; then
 		tst_resm TBROK "Failed to set default IP addresses"
+		return
+	fi
 
 	make_background_tcp_traffic
 
@@ -67,8 +77,6 @@ test_body()
 			local new_ip=${IPV4_NET16_UNUSED}.$x.$y
 		fi
 
-		tst_resm TINFO "set new ip $new_ip"
-
 		case $cmd_type in
 		if_cmd)
 			if [ "$TST_IPV6" ]; then
diff --git a/testcases/network/stress/interface/if-lib.sh b/testcases/network/stress/interface/if-lib.sh
index 363c18d..4168dd0 100644
--- a/testcases/network/stress/interface/if-lib.sh
+++ b/testcases/network/stress/interface/if-lib.sh
@@ -37,7 +37,6 @@ cleanup()
 	# Stop the background TCP traffic
 	pkill -13 -x netstress
 	tst_rhost_run -c "pkill -13 -x netstress"
-	tst_restore_ipaddr
 }
 
 make_background_tcp_traffic()
@@ -49,15 +48,26 @@ make_background_tcp_traffic()
 
 check_connectivity()
 {
-	local cnt=$1
+	local cnt="$1"
+	local restore="$2"
+
 	[ $CHECK_INTERVAL -eq 0 ] && return
 	[ $(($cnt % $CHECK_INTERVAL)) -ne 0 ] && return
 
 	tst_resm TINFO "check connectivity through $(tst_iface) on step $cnt"
-	check_icmpv${ipver}_connectivity $(tst_iface) $(tst_ipaddr rhost)
+
+	[ -n "$restore" ] && restore_ipaddr
+
+	tst_ping
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "$(tst_iface) is broken"
 		return 1
 	fi
 	return 0
 }
+
+restore_ipaddr()
+{
+	tst_restore_ipaddr || return $?
+	tst_wait_ipv6_dad
+}
diff --git a/testcases/network/stress/interface/if-mtu-change b/testcases/network/stress/interface/if-mtu-change
index 6c6ac25..637fa63 100644
--- a/testcases/network/stress/interface/if-mtu-change
+++ b/testcases/network/stress/interface/if-mtu-change
@@ -1,5 +1,5 @@
 #!/bin/sh
-# Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2015-2017 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2005
 #
 # This program is free software; you can redistribute it and/or
@@ -22,13 +22,28 @@ TCID=if-mtu-change
 
 . if-lib.sh
 
+TST_CLEANUP="do_cleanup"
+
 # The interval of the mtu change [second]
 CHANGE_INTERVAL=${CHANGE_INTERVAL:-5}
-CHECK_INTERVAL=${CHECK_INTERVAL:-$(($MTU_CHANGE_TIMES / 100))}
 # The array of the value which MTU is changed into sequentially
-CHANGE_VALUES="784 1142 426 1500 68 1500 68 748 68 1142 1500"
+# 552 - net.ipv4.route.min_pmtu
+CHANGE_VALUES="784 1142 552 1500 552 1500 552 748 552 1142 1500"
 CHANGE6_VALUES="1280 1445 1335 1390 1500 1280 1500 1280 1335 1500"
 [ "$TST_IPV6" ] && CHANGE_VALUES=$CHANGE6_VALUES
+saved_mtu=
+
+do_cleanup()
+{
+	cleanup
+	if [ "$saved_mtu" ]; then
+		ip li set $(tst_iface) mtu $saved_mtu
+		tst_rhost_run -c "ip li set $(tst_iface rhost) mtu $saved_mtu"
+	fi
+	tst_restore_ipaddr
+	tst_restore_ipaddr rhost
+	tst_wait_ipv6_dad
+}
 
 test_body()
 {
@@ -41,57 +56,54 @@ test_body()
 	esac
 
 	local iface=$(tst_iface)
+	local iface_rmt=$(tst_iface rhost)
 	[ "$TST_IPV6" ] && local netmask=64 || local netmask=16
 
 	tst_resm TINFO "'$cmd_name changes MTU $MTU_CHANGE_TIMES times " \
 	               "every $CHANGE_INTERVAL seconds"
 
-	tst_restore_ipaddr || \
-		tst_resm TBROK "Failed to set default IP addresses"
-
 	make_background_tcp_traffic
 
 	mtu_array_len=$(echo $CHANGE_VALUES | wc -w)
 	local cnt=0
 	while [ $cnt -lt $MTU_CHANGE_TIMES ]; do
-		sleep $CHANGE_INTERVAL
 		local nth=$(($cnt % $mtu_array_len))
 		field=$(($nth + 1))
 		cnt=$(($cnt + 1))
 		mtu=$(echo $CHANGE_VALUES | cut -d ' ' -f $field)
-		[ $cnt -eq $MTU_CHANGE_TIMES ] && mtu=1500
+		[ $cnt -eq $MTU_CHANGE_TIMES ] && mtu="$saved_mtu"
 
 		tst_resm TINFO "set MTU to $mtu $cnt/$MTU_CHANGE_TIMES"
+		local ret=0
 		case $cmd_type in
-		if_cmd) ifconfig $iface mtu $mtu ;;
-		ip_cmd) ip link set $iface mtu $mtu ;;
+		if_cmd) ifconfig $iface mtu $mtu || ret=1
+			tst_rhost_run -c "ifconfig $iface_rmt mtu $mtu"
+		;;
+		ip_cmd) ip link set $iface mtu $mtu || ret=1
+			tst_rhost_run -c "ip link set $iface_rmt mtu $mtu"
+		;;
 		esac
 
-		if [ $? -ne 0 ]; then
+		if [ $? -ne 0 -o $ret -ne 0 ]; then
 			tst_resm TFAIL "Failed to change the mtu at $cnt time"
 			return
 		fi
 
-		check_connectivity $cnt || return
+		tst_sleep $CHANGE_INTERVAL
+
+		EXPECT_PASS tst_ping $(tst_ipaddr) $(tst_ipaddr rhost) "1 1000 65507"
 
 		# Check the background TCP traffic
 		pgrep -x netstress > /dev/null || make_background_tcp_traffic
 	done
-
-	tst_resm TINFO "check connectivity through $iface"
-	check_icmpv${ipver}_connectivity $iface $(tst_ipaddr rhost)
-	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "$iface is broken"
-		return
-	fi
-
-	tst_resm TPASS "Test is finished correctly"
 }
 
 setup
 
 tst_check_cmds ifconfig
 
+saved_mtu="$(cat /sys/class/net/$(tst_iface)/mtu)"
+
 test_body 'if_cmd'
 test_body 'ip_cmd'
 
diff --git a/testcases/network/stress/interface/if-route-adddel b/testcases/network/stress/interface/if-route-adddel
index ac15b5e..4516741 100644
--- a/testcases/network/stress/interface/if-route-adddel
+++ b/testcases/network/stress/interface/if-route-adddel
@@ -22,7 +22,15 @@ TCID=if-route-adddel
 
 . if-lib.sh
 
-CHECK_INTERVAL=${CHECK_INTERVAL:-$(($NS_TIMES / 100))}
+TST_CLEANUP="do_cleanup"
+
+CHECK_INTERVAL=${CHECK_INTERVAL:-$(($NS_TIMES / 20))}
+
+do_cleanup()
+{
+	cleanup
+	restore_ipaddr
+}
 
 test_body()
 {
@@ -51,8 +59,10 @@ test_body()
 
 	tst_resm TINFO "'$cmd_name' add/del ${new_rt}${opt_rt} $NS_TIMES times"
 
-	tst_restore_ipaddr || \
+	if ! restore_ipaddr; then
 		tst_resm TBROK "Failed to set default IP addresses"
+		return
+	fi
 
 	make_background_tcp_traffic
 
diff --git a/testcases/network/stress/interface/if-route-addlarge b/testcases/network/stress/interface/if-route-addlarge
index 43a0599..e83cf60 100644
--- a/testcases/network/stress/interface/if-route-addlarge
+++ b/testcases/network/stress/interface/if-route-addlarge
@@ -19,11 +19,18 @@
 
 TST_TOTAL=2
 TCID=if-route-addlarge
-TST_CLEANUP="cleanup"
 
 . if-lib.sh
 
-CHECK_INTERVAL=${CHECK_INTERVAL:-$(($ROUTE_TOTAL / 100))}
+TST_CLEANUP="do_cleanup"
+
+CHECK_INTERVAL=${CHECK_INTERVAL:-$(($ROUTE_TOTAL / 20))}
+
+do_cleanup()
+{
+	cleanup
+	restore_ipaddr
+}
 
 test_body()
 {
@@ -49,8 +56,10 @@ test_body()
 
 	tst_resm TINFO "'$cmd_name' add IPv$ipver $ROUTE_TOTAL routes"
 
-	tst_restore_ipaddr || \
+	if ! restore_ipaddr; then
 		tst_resm TBROK "Failed to set default IP addresses"
+		return
+	fi
 
 	make_background_tcp_traffic
 
diff --git a/testcases/network/stress/interface/if-updown b/testcases/network/stress/interface/if-updown
index b18aa0d..deefef6 100644
--- a/testcases/network/stress/interface/if-updown
+++ b/testcases/network/stress/interface/if-updown
@@ -22,7 +22,7 @@ TCID=if-updown
 
 . if-lib.sh
 
-CHECK_INTERVAL=${CHECK_INTERVAL:-$(($IF_UPDOWN_TIMES / 100))}
+CHECK_INTERVAL=${CHECK_INTERVAL:-$(($IF_UPDOWN_TIMES / 20))}
 
 test_body()
 {
@@ -38,8 +38,6 @@ test_body()
 
 	tst_resm TINFO "'$cmd_name ups/downs $iface $IF_UPDOWN_TIMES times"
 	tst_resm TINFO "check connectivity interval is $CHECK_INTERVAL"
-	tst_restore_ipaddr || \
-		tst_resm TBROK "Failed to set default IP addresses"
 
 	local cnt=1
 	while [ $cnt -le $IF_UPDOWN_TIMES ]; do
@@ -61,7 +59,7 @@ test_body()
 			return
 		fi
 
-		check_connectivity $cnt || return
+		check_connectivity $cnt restore_ip || return
 
 		cnt=$(($cnt + 1))
 	done
diff --git a/testcases/network/stress/interface/if4-addr-change b/testcases/network/stress/interface/if4-addr-change
index f569202..5599b08 100644
--- a/testcases/network/stress/interface/if4-addr-change
+++ b/testcases/network/stress/interface/if4-addr-change
@@ -1,5 +1,5 @@
 #!/bin/sh
-# Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2015-2016 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2005
 #
 # This program is free software; you can redistribute it and/or
@@ -19,27 +19,28 @@
 
 TST_TOTAL=1
 TCID=if4-addr-change
-TST_CLEANUP="tst_restore_ipaddr"
+TST_CLEANUP="do_cleanup"
 
 . test_net.sh
 
 # Broadcast address of the tested network
-CHECK_INTERVAL=${CHECK_INTERVAL:-$(($NS_TIMES / 100))}
+CHECK_INTERVAL=${CHECK_INTERVAL:-$(($NS_TIMES / 20))}
 # Maximum host portion of the IPv4 address on the local host
 LHOST_IPV4_HOST_MAX="254"
 
+do_cleanup()
+{
+	tst_restore_ipaddr
+	tst_wait_ipv6_dad
+}
+
 trap "tst_brkm TBROK 'test interrupted'" INT
 
 tst_check_cmds ifconfig
 
 tst_resm TINFO "ifconfig changes IPv4 address $NS_TIMES times"
 
-tst_restore_ipaddr
-
-check_icmpv4_connectivity $(tst_iface) $(tst_ipaddr rhost) || \
-	tst_brkm TBROK "Failed to ping to $(tst_ipaddr rhost)"
-
-local cnt=0
+cnt=0
 num=1
 while [ $cnt -lt $NS_TIMES ]; do
 	# Define the network portion
@@ -60,15 +61,10 @@ while [ $cnt -lt $NS_TIMES ]; do
 	[ $CHECK_INTERVAL -eq 0 ] && continue
 	[ $(($cnt % $CHECK_INTERVAL)) -ne 0 ] && continue
 
-	tst_resm TINFO "ping from $lhost_ipv4addr to $(tst_ipaddr rhost)"
-	check_icmpv4_connectivity $(tst_iface) $(tst_ipaddr rhost) || \
-		tst_brkm TFAIL "$(tst_iface) link broken after ${cnt} times"
+	tst_resm TINFO "ping $(tst_ipaddr):$(tst_ipaddr rhost) ${cnt}/$NS_TIMES"
+	EXPECT_PASS tst_ping
 done
 
-tst_resm TINFO "ping from $lhost_ipv4addr to $(tst_ipaddr rhost)"
-check_icmpv4_connectivity $(tst_iface) $(tst_ipaddr rhost) || \
-	tst_brkm TFAIL "$(tst_iface) is broken"
-
-tst_resm TPASS "Test is finished successfully"
+EXPECT_PASS tst_ping
 
 tst_exit
-- 
1.7.1

