From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  3 Apr 2018 17:47:17 +0200
Subject: [LTP] [RFC PATCH v3 5/5] net: Migrate test_net_stress.sh and it's
	dependencies to new shell API
In-Reply-To: <20180403154717.22491-1-pvorel@suse.cz>
References: <20180403154717.22491-1-pvorel@suse.cz>
Message-ID: <20180403154717.22491-6-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ rename it to tst_net_stress.sh, The new name states that library
supports new API.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/stress/interface/if-addr-adddel  | 33 ++++++++----------
 .../network/stress/interface/if-addr-addlarge      | 39 ++++++++++------------
 testcases/network/stress/interface/if-mtu-change   | 26 ++++++---------
 testcases/network/stress/interface/if-route-adddel | 29 +++++++---------
 .../network/stress/interface/if-route-addlarge     | 31 ++++++++---------
 testcases/network/stress/interface/if-updown       | 29 +++++++---------
 testcases/network/stress/interface/if4-addr-change | 24 +++++++------
 .../grp-operation/mcast-group-multiple-socket      | 16 +++++----
 .../multicast/grp-operation/mcast-group-same-group | 17 +++++++---
 .../grp-operation/mcast-group-single-socket        | 17 +++++++---
 .../grp-operation/mcast-group-source-filter        | 17 +++++++---
 .../stress/multicast/grp-operation/mcast-lib.sh    | 17 +++++-----
 .../{test_net_stress.sh => tst_net_stress.sh}      | 25 +++++++++++---
 13 files changed, 165 insertions(+), 155 deletions(-)
 rename testcases/network/stress/ns-tools/{test_net_stress.sh => tst_net_stress.sh} (90%)

diff --git a/testcases/network/stress/interface/if-addr-adddel b/testcases/network/stress/interface/if-addr-adddel
index 4a0501e09..64954c37f 100644
--- a/testcases/network/stress/interface/if-addr-adddel
+++ b/testcases/network/stress/interface/if-addr-adddel
@@ -1,5 +1,6 @@
 #!/bin/sh
 # Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2017-2018 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) International Business Machines  Corp., 2005
 #
 # This program is free software; you can redistribute it and/or
@@ -17,11 +18,11 @@
 #
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
-TST_TOTAL=2
-
+TST_CNT=2
+TST_SETUP="netstress_setup"
 TST_CLEANUP="netstress_cleanup"
-
-. test_net_stress.sh
+TST_TESTFUNC="test_if_ip"
+. tst_net_stress.sh
 
 # The interval of the check interface activity
 CHECK_INTERVAL=${CHECK_INTERVAL:-$(($NS_TIMES / 20))}
@@ -33,7 +34,7 @@ test_body()
 	case $cmd_type in
 	if_cmd) local cmd_name='ifconfig' ;;
 	ip_cmd) local cmd_name='ip' ;;
-	*) tst_brkm TBROK "Unknown test parameter '$cmd_type'"
+	*) tst_brk TBROK "Unknown test parameter '$cmd_type'"
 	esac
 
 	local num=$(($(od -A n -t u1 -N 1 /dev/random) * 253 / 255 + 2 ))
@@ -46,10 +47,10 @@ test_body()
 		local netmask=24
 	fi
 
-	tst_resm TINFO "'$cmd_name' add/del IPv$ipver '$new_ip' $NS_TIMES times"
+	tst_res TINFO "'$cmd_name' add/del IPv$ipver '$new_ip' $NS_TIMES times"
 
 	if ! restore_ipaddr; then
-		tst_resm TBROK "Failed to set default IP addresses"
+		tst_res TBROK "Failed to set default IP addresses"
 		return
 	fi
 
@@ -69,14 +70,14 @@ test_body()
 		esac
 
 		if [ $? -ne 0 ]; then
-			tst_resm TFAIL "command failed to add $new_ip to $iface"
+			tst_res TFAIL "command failed to add $new_ip to $iface"
 			return
 		fi
 
 		ip addr show $iface | grep -q $new_ip
 		if [ $? -ne 0 ]; then
 			ip addr show $iface
-			tst_resm TFAIL "$new_ip not configured"
+			tst_res TFAIL "$new_ip not configured"
 			return
 		fi
 
@@ -96,26 +97,20 @@ test_body()
 		esac
 
 		if [ $? -ne 0 ]; then
-			tst_resm TFAIL " delete command failed".
+			tst_res TFAIL " delete command failed".
 			return
 		fi
 
 		ip addr show $iface | grep -q $new_ip
 		if [ $? -eq 0 ]; then
 			ip addr show $iface
-			tst_resm TFAIL "Failed to remove '$new_ip' address"
+			tst_res TFAIL "Failed to remove '$new_ip' address"
 			return
 		fi
 	done
 
-	tst_resm TPASS "Test is finished correctly"
+	tst_res TPASS "Test is finished correctly"
 }
 
-netstress_setup
-
 tst_check_cmds ifconfig
-
-test_body 'if_cmd'
-test_body 'ip_cmd'
-
-tst_exit
+tst_run
diff --git a/testcases/network/stress/interface/if-addr-addlarge b/testcases/network/stress/interface/if-addr-addlarge
index a81cf6129..4ef7c8bc1 100644
--- a/testcases/network/stress/interface/if-addr-addlarge
+++ b/testcases/network/stress/interface/if-addr-addlarge
@@ -1,5 +1,6 @@
 #!/bin/sh
 # Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2017-2018 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) International Business Machines  Corp., 2005
 #
 # This program is free software; you can redistribute it and/or
@@ -17,11 +18,11 @@
 #
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
-TST_TOTAL=2
-
+TST_CNT=2
+TST_SETUP="netstress_setup"
 TST_CLEANUP="netstress_cleanup"
-
-. test_net_stress.sh
+TST_TESTFUNC="test_if_ip"
+. tst_net_stress.sh
 
 # The interval of the check interface activity
 CHECK_INTERVAL=${CHECK_INTERVAL:-$(($IP_TOTAL / 20))}
@@ -33,17 +34,17 @@ test_body()
 	case $cmd_type in
 	if_cmd) local cmd_name='ifconfig' ;;
 	ip_cmd) local cmd_name='ip' ;;
-	*) tst_brkm TBROK "Unknown test parameter '$cmd_type'"
+	*) tst_brk TBROK "Unknown test parameter '$cmd_type'"
 	esac
 
 	local iface=$(tst_iface)
 	[ "$TST_IPV6" ] && local netmask=64 || local netmask=16
 
-	tst_resm TINFO "'$cmd_name' add $IP_TOTAL IPv$ipver addresses"
-	tst_resm TINFO "check interval that $iface is working: $CHECK_INTERVAL"
+	tst_res TINFO "'$cmd_name' add $IP_TOTAL IPv$ipver addresses"
+	tst_res TINFO "check interval that $iface is working: $CHECK_INTERVAL"
 
 	if ! restore_ipaddr; then
-		tst_resm TBROK "Failed to set default IP addresses"
+		tst_res TBROK "Failed to set default IP addresses"
 		return
 	fi
 
@@ -54,7 +55,7 @@ test_body()
 	[ "$TST_IPV6" ] && local xymax=65535 || xymax=254
 
 	if [ $IP_TOTAL -gt $((xymax * xymax)) ]; then
-		tst_resm TWARN "set IP_TOTAL to $xymax * $xymax"
+		tst_res TWARN "set IP_TOTAL to $xymax * $xymax"
 		IP_TOTAL=$((xymax * xymax))
 	fi
 
@@ -81,14 +82,14 @@ test_body()
 		esac
 
 		if [ $? -ne 0 ]; then
-			tst_resm TFAIL "command failed to add $new_ip to $iface"
+			tst_res TFAIL "command failed to add $new_ip to $iface"
 			return
 		fi
 
 		ip addr show $iface | grep -q $new_ip
 		if [ $? -ne 0 ]; then
 			ip addr show $iface
-			tst_resm TFAIL "$new_ip not configured"
+			tst_res TFAIL "$new_ip not configured"
 			return
 		fi
 
@@ -106,14 +107,14 @@ test_body()
 		esac
 
 		if [ $? -ne 0 ]; then
-			tst_resm TFAIL " delete command failed".
+			tst_res TFAIL " delete command failed".
 			return
 		fi
 
 		ip addr show $iface | grep -q $new_ip
 		if [ $? -eq 0 ]; then
 			ip addr show $iface
-			tst_resm TFAIL "Failed to remove '$new_ip' address"
+			tst_res TFAIL "Failed to remove '$new_ip' address"
 			return
 		fi
 
@@ -123,19 +124,13 @@ test_body()
 			y=1
 			x=$(($x + 1))
 			if [ $x -gt $xymax ]; then
-				tst_brkm TBROK "Too large $IP_TOTAL"
+				tst_brk TBROK "Too large $IP_TOTAL"
 			fi
 		fi
 	done
 
-	tst_resm TPASS "Test is finished correctly"
+	tst_res TPASS "Test is finished correctly"
 }
 
-netstress_setup
-
 tst_check_cmds ifconfig
-
-test_body 'if_cmd'
-test_body 'ip_cmd'
-
-tst_exit
+tst_run
diff --git a/testcases/network/stress/interface/if-mtu-change b/testcases/network/stress/interface/if-mtu-change
index 15293c4a9..7982347ae 100644
--- a/testcases/network/stress/interface/if-mtu-change
+++ b/testcases/network/stress/interface/if-mtu-change
@@ -1,5 +1,6 @@
 #!/bin/sh
 # Copyright (c) 2015-2017 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2017-2018 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) International Business Machines  Corp., 2005
 #
 # This program is free software; you can redistribute it and/or
@@ -17,11 +18,11 @@
 #
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
-TST_TOTAL=2
-
+TST_CNT=2
+TST_SETUP="netstress_setup"
 TST_CLEANUP="do_cleanup"
-
-. test_net_stress.sh
+TST_TESTFUNC="test_if_ip"
+. tst_net_stress.sh
 
 # The interval of the mtu change [second]
 CHANGE_INTERVAL=${CHANGE_INTERVAL:-5}
@@ -52,14 +53,14 @@ test_body()
 	case $cmd_type in
 	if_cmd) local cmd_name='ifconfig' ;;
 	ip_cmd) local cmd_name='ip' ;;
-	*) tst_brkm TBROK "Unknown test parameter '$cmd_type'"
+	*) tst_brk TBROK "Unknown test parameter '$cmd_type'"
 	esac
 
 	local iface=$(tst_iface)
 	local iface_rmt=$(tst_iface rhost)
 	[ "$TST_IPV6" ] && local netmask=64 || local netmask=16
 
-	tst_resm TINFO "'$cmd_name changes MTU $MTU_CHANGE_TIMES times" \
+	tst_res TINFO "'$cmd_name changes MTU $MTU_CHANGE_TIMES times" \
 	               "every $CHANGE_INTERVAL seconds"
 
 	mtu_array_len=$(echo $CHANGE_VALUES | wc -w)
@@ -73,7 +74,7 @@ test_body()
 
 		make_background_tcp_traffic
 
-		tst_resm TINFO "set MTU to $mtu $cnt/$MTU_CHANGE_TIMES"
+		tst_res TINFO "set MTU to $mtu $cnt/$MTU_CHANGE_TIMES"
 		local ret=0
 		case $cmd_type in
 		if_cmd) ifconfig $iface mtu $mtu || ret=1
@@ -85,7 +86,7 @@ test_body()
 		esac
 
 		if [ $? -ne 0 -o $ret -ne 0 ]; then
-			tst_resm TFAIL "Failed to change the mtu at $cnt time"
+			tst_res TFAIL "Failed to change the mtu at $cnt time"
 			return
 		fi
 
@@ -95,13 +96,6 @@ test_body()
 	done
 }
 
-netstress_setup
-
 tst_check_cmds ifconfig
-
 saved_mtu="$(cat /sys/class/net/$(tst_iface)/mtu)"
-
-test_body 'if_cmd'
-test_body 'ip_cmd'
-
-tst_exit
+tst_run
diff --git a/testcases/network/stress/interface/if-route-adddel b/testcases/network/stress/interface/if-route-adddel
index 8c1dfeee2..dfb517cb9 100644
--- a/testcases/network/stress/interface/if-route-adddel
+++ b/testcases/network/stress/interface/if-route-adddel
@@ -1,5 +1,6 @@
 #!/bin/sh
 # Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2017-2018 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) International Business Machines  Corp., 2005
 #
 # This program is free software; you can redistribute it and/or
@@ -17,11 +18,11 @@
 #
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
-TST_TOTAL=2
-
+TST_CNT=2
+TST_SETUP="netstress_setup"
 TST_CLEANUP="netstress_cleanup"
-
-. test_net_stress.sh
+TST_TESTFUNC="test_rt_ip"
+. tst_net_stress.sh
 
 CHECK_INTERVAL=${CHECK_INTERVAL:-$(($NS_TIMES / 20))}
 
@@ -32,7 +33,7 @@ test_body()
 	case $cmd_type in
 	rt_cmd) local cmd_name='route' ;;
 	ip_cmd) local cmd_name='ip' ;;
-	*) tst_brkm TBROK "Unknown test parameter '$cmd_type'"
+	*) tst_brk TBROK "Unknown test parameter '$cmd_type'"
 	esac
 
 	local iface=$(tst_iface)
@@ -50,10 +51,10 @@ test_body()
 		esac
 	fi
 
-	tst_resm TINFO "'$cmd_name' add/del ${new_rt}${opt_rt} $NS_TIMES times"
+	tst_res TINFO "'$cmd_name' add/del ${new_rt}${opt_rt} $NS_TIMES times"
 
 	if ! restore_ipaddr; then
-		tst_resm TBROK "Failed to set default IP addresses"
+		tst_res TBROK "Failed to set default IP addresses"
 		return
 	fi
 
@@ -66,7 +67,7 @@ test_body()
 		ip_cmd) ip route add ${new_rt}${opt_rt} dev $iface ;;
 		esac
 		if [ $? -ne 0 ]; then
-			tst_resm TFAIL "Can't add route $new_rt to $iface"
+			tst_res TFAIL "Can't add route $new_rt to $iface"
 			return
 		fi
 
@@ -75,7 +76,7 @@ test_body()
 		ip_cmd) ip route del ${new_rt}${opt_rt} dev $iface ;;
 		esac
 		if [ $? -ne 0 ]; then
-			tst_resm TFAIL "Can't del route $new_rt from $iface"
+			tst_res TFAIL "Can't del route $new_rt from $iface"
 			return
 		fi
 
@@ -84,14 +85,8 @@ test_body()
 		cnt=$(($cnt + 1))
 	done
 
-	tst_resm TPASS "Test is finished correctly"
+	tst_res TPASS "Test is finished correctly"
 }
 
-netstress_setup
-
 tst_check_cmds route
-
-test_body 'rt_cmd'
-test_body 'ip_cmd'
-
-tst_exit
+tst_run
diff --git a/testcases/network/stress/interface/if-route-addlarge b/testcases/network/stress/interface/if-route-addlarge
index eee0959c8..0162addf0 100644
--- a/testcases/network/stress/interface/if-route-addlarge
+++ b/testcases/network/stress/interface/if-route-addlarge
@@ -1,5 +1,6 @@
 #!/bin/sh
 # Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2017-2018 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) International Business Machines  Corp., 2005
 #
 # This program is free software; you can redistribute it and/or
@@ -17,11 +18,11 @@
 #
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
-TST_TOTAL=2
-
+TST_CNT=2
+TST_SETUP="netstress_setup"
 TST_CLEANUP="netstress_cleanup"
-
-. test_net_stress.sh
+TST_TESTFUNC="test_rt_ip"
+. tst_net_stress.sh
 
 CHECK_INTERVAL=${CHECK_INTERVAL:-$(($ROUTE_TOTAL / 20))}
 
@@ -32,7 +33,7 @@ test_body()
 	case $cmd_type in
 	rt_cmd) local cmd_name='route' ;;
 	ip_cmd) local cmd_name='ip' ;;
-	*) tst_brkm TBROK "Unknown test parameter '$cmd_type'"
+	*) tst_brk TBROK "Unknown test parameter '$cmd_type'"
 	esac
 
 	local iface=$(tst_iface)
@@ -47,10 +48,10 @@ test_body()
 		esac
 	fi
 
-	tst_resm TINFO "'$cmd_name' add IPv$ipver $ROUTE_TOTAL routes"
+	tst_res TINFO "'$cmd_name' add IPv$ipver $ROUTE_TOTAL routes"
 
 	if ! restore_ipaddr; then
-		tst_resm TBROK "Failed to set default IP addresses"
+		tst_res TBROK "Failed to set default IP addresses"
 		return
 	fi
 
@@ -61,7 +62,7 @@ test_body()
 	[ "$TST_IPV6" ] && local xymax=65535 || xymax=254
 
 	if [ $ROUTE_TOTAL -gt $((xymax * xymax)) ]; then
-		tst_resm TWARN "set ROUTE_TOTAL to $xymax * $xymax"
+		tst_res TWARN "set ROUTE_TOTAL to $xymax * $xymax"
 		ROUTE_TOTAL=$((xymax * xymax))
 	fi
 
@@ -81,7 +82,7 @@ test_body()
 		ip_cmd) ip route add ${new_rt}${opt_rt} dev $iface ;;
 		esac
 		if [ $? -ne 0 ]; then
-			tst_resm TFAIL "Can't add route $new_rt to $iface"
+			tst_res TFAIL "Can't add route $new_rt to $iface"
 			return
 		fi
 
@@ -93,19 +94,13 @@ test_body()
 			y=1
 			x=$(($x + 1))
 			if [ $x -gt $xymax ]; then
-				tst_brkm TBROK "Too large $ROUTE_TOTAL"
+				tst_brk TBROK "Too large $ROUTE_TOTAL"
 			fi
 		fi
 	done
 
-	tst_resm TPASS "Test is finished correctly"
+	tst_res TPASS "Test is finished correctly"
 }
 
-netstress_setup
-
 tst_check_cmds route
-
-test_body 'rt_cmd'
-test_body 'ip_cmd'
-
-tst_exit
+tst_run
diff --git a/testcases/network/stress/interface/if-updown b/testcases/network/stress/interface/if-updown
index 264331adb..07061f6eb 100644
--- a/testcases/network/stress/interface/if-updown
+++ b/testcases/network/stress/interface/if-updown
@@ -1,5 +1,6 @@
 #!/bin/sh
 # Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2017-2018 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) International Business Machines  Corp., 2005
 #
 # This program is free software; you can redistribute it and/or
@@ -17,11 +18,11 @@
 #
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
-TST_TOTAL=2
-
+TST_CNT=2
+TST_SETUP="netstress_setup"
 TST_CLEANUP="netstress_cleanup"
-
-. test_net_stress.sh
+TST_TESTFUNC="test_if_ip"
+. tst_net_stress.sh
 
 CHECK_INTERVAL=${CHECK_INTERVAL:-$(($IF_UPDOWN_TIMES / 20))}
 
@@ -32,13 +33,13 @@ test_body()
 	case $cmd_type in
 	if_cmd) local cmd_name='ifconfig' ;;
 	ip_cmd) local cmd_name='ip' ;;
-	*) tst_brkm TBROK "Unknown test parameter '$cmd_type'"
+	*) tst_brk TBROK "Unknown test parameter '$cmd_type'"
 	esac
 
 	local iface=$(tst_iface)
 
-	tst_resm TINFO "'$cmd_name ups/downs $iface $IF_UPDOWN_TIMES times"
-	tst_resm TINFO "check connectivity interval is $CHECK_INTERVAL"
+	tst_res TINFO "'$cmd_name ups/downs $iface $IF_UPDOWN_TIMES times"
+	tst_res TINFO "check connectivity interval is $CHECK_INTERVAL"
 
 	local cnt=1
 	while [ $cnt -le $IF_UPDOWN_TIMES ]; do
@@ -47,7 +48,7 @@ test_body()
 		ip_cmd) ip link set $iface down ;;
 		esac
 		if [ $? -ne 0 ]; then
-			tst_resm TFAIL "Failed to down $iface"
+			tst_res TFAIL "Failed to down $iface"
 			return
 		fi
 
@@ -56,7 +57,7 @@ test_body()
 		ip_cmd) ip link set $iface up ;;
 		esac
 		if [ $? -ne 0 ]; then
-			tst_resm TFAIL "Failed to up $iface"
+			tst_res TFAIL "Failed to up $iface"
 			return
 		fi
 
@@ -65,14 +66,8 @@ test_body()
 		cnt=$(($cnt + 1))
 	done
 
-	tst_resm TPASS "Test is finished correctly"
+	tst_res TPASS "Test is finished correctly"
 }
 
-netstress_setup
-
 tst_check_cmds ifconfig
-
-test_body 'if_cmd'
-test_body 'ip_cmd'
-
-tst_exit
+tst_run
diff --git a/testcases/network/stress/interface/if4-addr-change b/testcases/network/stress/interface/if4-addr-change
index a2cf12dab..9f9fb25d7 100644
--- a/testcases/network/stress/interface/if4-addr-change
+++ b/testcases/network/stress/interface/if4-addr-change
@@ -18,24 +18,29 @@
 #
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
-TST_TOTAL=1
+TST_CNT=1
 TCID=if4-addr-change
+TST_SETUP="do_setup"
 TST_CLEANUP="do_cleanup"
-
-TST_USE_LEGACY_API=1
+TST_TESTFUNC="test_body"
 . tst_net.sh
 
 CHECK_INTERVAL=${CHECK_INTERVAL:-$(($NS_TIMES / 20))}
 # Maximum host portion of the IPv4 address on the local host
 LHOST_IPV4_HOST_MAX="254"
 
+do_setup()
+{
+	tst_check_cmds ifconfig
+}
+
 do_cleanup()
 {
 	tst_restore_ipaddr
 	tst_wait_ipv6_dad
 }
 
-trap "tst_brkm TBROK 'test interrupted'" INT
+trap "tst_brk TBROK 'test interrupted'" INT
 
 test_body()
 {
@@ -43,7 +48,7 @@ test_body()
 	local num=1
 	local add_to_net=
 
-	tst_resm TINFO "ifconfig changes IPv4 address $NS_TIMES times"
+	tst_res TINFO "ifconfig changes IPv4 address $NS_TIMES times"
 
 	while [ $cnt -lt $NS_TIMES ]; do
 		# Define the network portion
@@ -55,7 +60,7 @@ test_body()
 		# check prefix and fix values for prefix != 24
 		add_to_net=
 		if [ $IPV4_LPREFIX -lt 8 -o $IPV4_LPREFIX -ge 32 ] ; then
-			tst_brkm TCONF "test must be with prefix >= 8 and prefix < 32 ($IPV4_LPREFIX)"
+			tst_brk TCONF "test must be with prefix >= 8 and prefix < 32 ($IPV4_LPREFIX)"
 		elif [ $IPV4_LPREFIX -lt 16 ]; then # N.x.x.num
 			add_to_net=".0.1"
 		elif [ $IPV4_LPREFIX -lt 24 ]; then # N.N.x.num
@@ -71,14 +76,11 @@ test_body()
 		[ $CHECK_INTERVAL -eq 0 ] && continue
 		[ $(($cnt % $CHECK_INTERVAL)) -ne 0 ] && continue
 
-		tst_resm TINFO "ping $(tst_ipaddr):$(tst_ipaddr rhost) ${cnt}/$NS_TIMES"
+		tst_res TINFO "ping $(tst_ipaddr):$(tst_ipaddr rhost) ${cnt}/$NS_TIMES"
 		tst_ping
 	done
 
 	tst_ping
 }
 
-tst_check_cmds ifconfig
-test_body
-
-tst_exit
+tst_run
diff --git a/testcases/network/stress/multicast/grp-operation/mcast-group-multiple-socket b/testcases/network/stress/multicast/grp-operation/mcast-group-multiple-socket
index 84700a5d8..c928bf4a0 100644
--- a/testcases/network/stress/multicast/grp-operation/mcast-group-multiple-socket
+++ b/testcases/network/stress/multicast/grp-operation/mcast-group-multiple-socket
@@ -1,6 +1,6 @@
 #!/bin/sh
 # Copyright (c) International Business Machines  Corp., 2006
-# Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2017-2018 Petr Vorel <pvorel@suse.cz>
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License as
@@ -21,19 +21,21 @@
 
 . mcast-lib.sh
 
-tst_resm TINFO "joining $MCASTNUM_HEAVY IPv$ipver multicast groups on multiple sockets"
-
 do_setup()
 {
 	# Increase the maximum number of open file descriptors
 	if [ $(ulimit -n) -lt $MCASTNUM_HEAVY ]; then
-		ulimit -n $MCASTNUM_HEAVY || tst_brkm TCONF \
+		ulimit -n $MCASTNUM_HEAVY || tst_brk TCONF \
 			"Failed to set the maximum number of open file descriptors to $MCASTNUM_HEAVY"
 	fi
 
 	mcast_setup $MCASTNUM_HEAVY
 }
 
-do_setup
-do_multicast_test_multiple_join $MCASTNUM_HEAVY true
-tst_exit
+do_test()
+{
+	tst_res TINFO "joining $MCASTNUM_HEAVY IPv$ipver multicast groups on multiple sockets"
+	do_multicast_test_multiple_join $MCASTNUM_HEAVY true
+}
+
+tst_run
diff --git a/testcases/network/stress/multicast/grp-operation/mcast-group-same-group b/testcases/network/stress/multicast/grp-operation/mcast-group-same-group
index 876c395bb..0a0e968a7 100644
--- a/testcases/network/stress/multicast/grp-operation/mcast-group-same-group
+++ b/testcases/network/stress/multicast/grp-operation/mcast-group-same-group
@@ -1,6 +1,6 @@
 #!/bin/sh
 # Copyright (c) International Business Machines  Corp., 2006
-# Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2017-2018 Petr Vorel <pvorel@suse.cz>
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License as
@@ -21,8 +21,15 @@
 
 . mcast-lib.sh
 
-tst_resm TINFO "joining and leaving the same IPv$ipver multicast group on $MCASTNUM_NORMAL sockets in $NS_TIMES times"
+do_setup()
+{
+	mcast_setup $MCASTNUM_NORMAL
+}
 
-mcast_setup $MCASTNUM_NORMAL
-do_multicast_test_join_leave $MCASTNUM_NORMAL
-tst_exit
+do_test()
+{
+	tst_res TINFO "joining and leaving the same IPv$ipver multicast group on $MCASTNUM_NORMAL sockets in $NS_TIMES times"
+	do_multicast_test_join_leave $MCASTNUM_NORMAL
+}
+
+tst_run
diff --git a/testcases/network/stress/multicast/grp-operation/mcast-group-single-socket b/testcases/network/stress/multicast/grp-operation/mcast-group-single-socket
index d6b3363db..e7cad75a7 100644
--- a/testcases/network/stress/multicast/grp-operation/mcast-group-single-socket
+++ b/testcases/network/stress/multicast/grp-operation/mcast-group-single-socket
@@ -1,6 +1,6 @@
 #!/bin/sh
 # Copyright (c) International Business Machines  Corp., 2006
-# Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2017-2018 Petr Vorel <pvorel@suse.cz>
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License as
@@ -21,8 +21,15 @@
 
 . mcast-lib.sh
 
-tst_resm TINFO "joining $MCASTNUM_HEAVY IPv$ipver multicast groups on a single socket"
+do_setup()
+{
+	mcast_setup $MCASTNUM_HEAVY
+}
 
-mcast_setup $MCASTNUM_HEAVY
-do_multicast_test_multiple_join $MCASTNUM_HEAVY
-tst_exit
+do_test()
+{
+	tst_res TINFO "joining $MCASTNUM_HEAVY IPv$ipver multicast groups on a single socket"
+	do_multicast_test_multiple_join $MCASTNUM_HEAVY
+}
+
+tst_run
diff --git a/testcases/network/stress/multicast/grp-operation/mcast-group-source-filter b/testcases/network/stress/multicast/grp-operation/mcast-group-source-filter
index 34ed143af..d73b5494f 100644
--- a/testcases/network/stress/multicast/grp-operation/mcast-group-source-filter
+++ b/testcases/network/stress/multicast/grp-operation/mcast-group-source-filter
@@ -1,6 +1,6 @@
 #!/bin/sh
 # Copyright (c) International Business Machines  Corp., 2006
-# Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2017-2018 Petr Vorel <pvorel@suse.cz>
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License as
@@ -21,8 +21,15 @@
 
 . mcast-lib.sh
 
-tst_resm TINFO "joining and leaving the same IPv$ipver multicast group with a different source filters on $MCASTNUM_NORMAL sockets in $NS_TIMES times"
+do_setup()
+{
+	mcast_setup $MCASTNUM_NORMAL
+}
 
-mcast_setup $MCASTNUM_NORMAL
-do_multicast_test_join_leave $MCASTNUM_NORMAL true
-tst_exit
+do_test()
+{
+	tst_res TINFO "joining and leaving the same IPv$ipver multicast group with a different source filters on $MCASTNUM_NORMAL sockets in $NS_TIMES times"
+	do_multicast_test_join_leave $MCASTNUM_NORMAL true
+}
+
+tst_run
diff --git a/testcases/network/stress/multicast/grp-operation/mcast-lib.sh b/testcases/network/stress/multicast/grp-operation/mcast-lib.sh
index 6cc2922f2..65033e884 100644
--- a/testcases/network/stress/multicast/grp-operation/mcast-lib.sh
+++ b/testcases/network/stress/multicast/grp-operation/mcast-lib.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # Copyright (c) International Business Machines  Corp., 2006
-# Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2017-2018 Petr Vorel <pvorel@suse.cz>
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License as
@@ -19,10 +19,12 @@
 #
 # Setup script for multicast stress tests.
 
-TST_TOTAL=1
+TST_CNT=1
+TST_SETUP="do_setup"
 TST_CLEANUP="mcast_cleanup"
-
-. test_net_stress.sh
+TST_TESTFUNC="do_test"
+TST_NEEDS_TMPDIR=1
+. tst_net_stress.sh
 
 MCAST_LCMD="ns-mcast_join -f $ipver -I $(tst_iface)"
 
@@ -39,7 +41,7 @@ mcast_setup4()
 	SYSFS_FORCE_IGMP_VERSION=$(sysctl -b net.ipv4.conf.$(tst_iface).force_igmp_version)
 	SYSFS_ALL_FORCE_IGMP_VERSION=$(sysctl -b net.ipv4.conf.all.force_igmp_version)
 
-	[ "$igmp_max_memberships" -gt 5459 ] && tst_resm TWARN \
+	[ "$igmp_max_memberships" -gt 5459 ] && tst_res TWARN \
 		"\$1 shouldn't be set higher than 5459 as it's used to set /proc/sys/net/ipv4/igmp_max_memberships"
 
 	ROD sysctl -qw net.ipv4.igmp_max_memberships=$igmp_max_memberships
@@ -67,7 +69,6 @@ mcast_setup()
 	local max="$1"
 
 	netstress_setup
-	tst_tmpdir
 
 	[ "$TST_IPV6" ] && mcast_setup6 || mcast_setup4 $max
 }
@@ -110,7 +111,7 @@ do_multicast_test_multiple_join()
 	# Run a multicast join tool
 	tmpfile=$$
 	EXPECT_PASS $MCAST_LCMD $param_multi_socket -n $num -p $mprefix \> $tmpfile
-	tst_resm TINFO "joined $(grep groups $tmpfile)"
+	tst_res TINFO "joined $(grep groups $tmpfile)"
 
 	# Send MLD / IGMP General Query from the remote host
 	if [ "$TST_IPV6" ]; then
@@ -150,5 +151,5 @@ do_multicast_test_join_leave()
 
 	wait
 
-	tst_resm TPASS "test is finished successfully"
+	tst_res TPASS "test is finished successfully"
 }
diff --git a/testcases/network/stress/ns-tools/test_net_stress.sh b/testcases/network/stress/ns-tools/tst_net_stress.sh
similarity index 90%
rename from testcases/network/stress/ns-tools/test_net_stress.sh
rename to testcases/network/stress/ns-tools/tst_net_stress.sh
index d71762972..86ccb87e1 100644
--- a/testcases/network/stress/ns-tools/test_net_stress.sh
+++ b/testcases/network/stress/ns-tools/tst_net_stress.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # Copyright (c) International Business Machines  Corp., 2006
 # Copyright (c) 2015-2017 Oracle and/or its affiliates. All Rights Reserved.
-# Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2017-2018 Petr Vorel <pvorel@suse.cz>
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License as
@@ -25,7 +25,6 @@
 
 export TCID="${TCID:-$(basename $0)}"
 
-TST_USE_LEGACY_API=1
 . tst_net.sh
 
 ipver=${TST_IPV6:-4}
@@ -43,9 +42,9 @@ MCAST_IPV6_ADDR="${MCAST_IPV6_ADDR_PREFIX}:1"
 # Setup for tests using netstress.
 netstress_setup()
 {
-	tst_require_root
+	TST_NEEDS_ROOT=1
 	tst_check_cmds pgrep pkill
-	trap "tst_brkm TBROK 'test interrupted'" INT
+	trap "tst_brk TBROK 'test interrupted'" INT
 }
 
 # Cleanup for tests using netstress.
@@ -86,7 +85,7 @@ check_connectivity()
 
 	[ -n "$cnt" ] && cnt_msg=" (step $cnt)"
 
-	tst_resm TINFO "ping through $src_iface iface to ${dst_addr}$cnt_msg"
+	tst_res TINFO "ping through $src_iface iface to ${dst_addr}$cnt_msg"
 
 	tst_ping $src_iface $dst_addr
 }
@@ -125,3 +124,19 @@ make_background_tcp_traffic()
 	netstress -R 3 -g $port > /dev/null 2>&1 &
 	tst_rhost_run -b -c "netstress -l -H $ip -g $port"
 }
+
+test_if_ip()
+{
+	case $1 in
+	1) test_body 'if_cmd';;
+	2) test_body 'ip_cmd';;
+	esac
+}
+
+test_rt_ip()
+{
+	case $1 in
+	1) test_body 'rt_cmd';;
+	2) test_body 'ip_cmd';;
+	esac
+}
-- 
2.16.2

