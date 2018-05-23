From: Anton Smorodskyi <asmorodskyi@suse.com>
Date: Wed, 23 May 2018 15:24:32 +0200
Subject: [LTP] [PATCH v4 1/1] ipneigh : Use new API
Message-ID: <20180523132432.20681-1-asmorodskyi@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Besides all obvious changes for moving to new API,
also was done :
1. more generic variable names
2. add check for del command failure
3. add input parameter "-c" which allows to control
which command will be used
---
 runtest/net.ipv6                                |  2 +-
 runtest/net.tcp_cmds                            |  3 +-
 testcases/network/tcp_cmds/ipneigh/ipneigh01.sh | 86 +++++++++++++++----------
 3 files changed, 54 insertions(+), 37 deletions(-)

diff --git a/runtest/net.ipv6 b/runtest/net.ipv6
index d8f85cc31..261a7254c 100644
--- a/runtest/net.ipv6
+++ b/runtest/net.ipv6
@@ -7,4 +7,4 @@ tracepath601 tracepath01.sh -6
 traceroute601 traceroute01.sh -6
 dhcpd6 dhcpd_tests.sh -6
 dnsmasq6 dnsmasq_tests.sh -6
-ipneigh601 ipneigh01.sh -6
+ipneigh6_ip ipneigh01.sh -6 -c ip
diff --git a/runtest/net.tcp_cmds b/runtest/net.tcp_cmds
index 859f48127..cfeacee5b 100644
--- a/runtest/net.tcp_cmds
+++ b/runtest/net.tcp_cmds
@@ -2,7 +2,8 @@
 #
 # PLEASE READ THE README FILE IN /tcp_cmds BEFORE RUNNING THESE.
 #
-ipneigh01 ipneigh01.sh
+ipneigh01_arp ipneigh01.sh -c arp
+ipneigh01_ip ipneigh01.sh -c ip
 arping01 arping01.sh
 clockdiff01 clockdiff01.sh
 ftp export TCbin=$LTPROOT/testcases/network/tcp_cmds/ftp; ftp01
diff --git a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
index 9af3aa31e..61e107a22 100755
--- a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
+++ b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
@@ -1,4 +1,5 @@
 #!/bin/sh
+# Copyright (c) 2018 SUSE Linux GmbH
 # Copyright (c) 2016 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2000
 # This program is free software; you can redistribute it and/or
@@ -16,29 +17,58 @@
 #
 # Test basic functionality of 'arp' and 'ip neigh'.
 
-TCID=ipneigh01
 NUMLOOPS=${NUMLOOPS:-50}
-TST_TOTAL=2
-TST_USE_LEGACY_API=1
+TST_TESTFUNC=do_test
+TST_SETUP=do_setup
+TST_OPTS="c:"
+TST_PARSE_ARGS="parse_args"
+TST_USAGE="usage"
+TST_NEEDS_ROOT=1
 . tst_net.sh
 
 do_setup()
 {
-	tst_require_root
-	tst_check_cmds arp grep ping$TST_IPV6
+	tst_check_cmds $CMD ping$TST_IPV6
 }
 
-do_test()
+usage()
 {
-	local arp_show_cmd="$1"
-	local arp_del_cmd="$2"
+	echo "-c [ arp | ip ] Test command"
+}
 
-	local entry_name
-	[ "$TST_IPV6" ] && entry_name="NDISC" || entry_name="ARP"
+parse_args()
+{
+	case $1 in
+	c) CMD="$2" ;;
+	esac
+}
 
-	tst_resm TINFO "Stress auto-creation of $entry_name cache entry"
-	tst_resm TINFO "by pinging '$rhost' and deleting entry again"
-	tst_resm TINFO "with '$arp_del_cmd'"
+do_test()
+{
+	local rhost=$(tst_ipaddr rhost)
+	case $CMD in
+	ip)
+		local show_cmd="ip neigh show"
+		local del_cmd="ip neigh del $rhost dev $(tst_iface)"
+		;;
+	arp)
+		if [ -n "$TST_IPV6" ]; then
+			tst_res TCONF "'arp cmd doesn't support IPv6, skipping test-case"
+			return 1
+		fi
+		local show_cmd="arp -a"
+		local del_cmd="arp -d $rhost"
+		;;
+	*)
+		tst_res TBROK "-c is missing or have value not from list [ arp | ip ]"
+		return 1
+		;;
+	esac
+
+	local entry_name="ARP"
+	[ "$TST_IPV6" ] && entry_name="NDISC"
+
+	tst_res TINFO "Stress auto-creation of $entry_name cache entry $NUMLOOPS times"
 
 	for i in $(seq 1 $NUMLOOPS); do
 
@@ -46,9 +76,8 @@ do_test()
 
 		local k
 		local ret=1
-		# wait for arp entry at least 3 seconds
 		for k in $(seq 1 30); do
-			$arp_show_cmd | grep -q $rhost
+			$show_cmd | grep -q $rhost
 			if [ $? -eq 0 ]; then
 				ret=0
 				break;
@@ -57,28 +86,15 @@ do_test()
 		done
 
 		[ "$ret" -ne 0 ] && \
-			tst_brkm TFAIL "$entry_name entry '$rhost' not listed"
+			tst_brk TFAIL "$entry_name entry '$rhost' not listed"
+		$del_cmd || tst_brk TFAIL "fail to delete entry"
 
-		$arp_del_cmd
-
-		$arp_show_cmd | grep -q "${rhost}.*$(tst_hwaddr rhost)" && \
-			tst_brkm TFAIL "'$arp_del_cmd' failed, entry has " \
-				       "$(tst_hwaddr rhost)' $i/$NUMLOOPS"
+		$show_cmd | grep -q "${rhost}.*$(tst_hwaddr rhost)" && \
+			tst_brk TFAIL "'$del_cmd' failed, entry has " \
+				"$(tst_hwaddr rhost)' $i/$NUMLOOPS"
 	done
 
-	tst_resm TPASS "verified adding/removing of $entry_name cache entry"
+	tst_res TPASS "verified adding/removing of $entry_name cache entry"
 }
 
-do_setup
-
-rhost=$(tst_ipaddr rhost)
-
-if [ -z "$TST_IPV6" ]; then
-	do_test "arp -a" "arp -d $rhost"
-else
-	tst_resm TCONF "'arp cmd doesn't support IPv6, skipping test-case"
-fi
-
-do_test "ip neigh show" "ip neigh del $rhost dev $(tst_iface)"
-
-tst_exit
+tst_run
-- 
2.13.6

