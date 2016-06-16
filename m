From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 16 Jun 2016 20:32:00 +0300
Subject: [LTP] [PATCH v2] network/ip_route.sh: fix test,
	use dummy/lo interfaces in test-cases
Message-ID: <1466098320-14604-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes:
* 'ip neigh replace' will require lladdr, if the same entry exists, fix it;
* don't add/del neighbour with 127.0.0.1, as it might affect other tests
  (this address won't be reachable);
* don't set mtu to 300, IPv6 requires 1280 bytes as a minimum, so setting
  less can cause removing of already added IPv6 addresses. Though it's not
  so important right now as the patch use dummy interface for mtu setting;
* use ROD library functions;
* replace 'ifconfig' command with 'ip';
* adding new route from not used address range.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
v2: test04: 127.0.0.1 -> 127.6.6.6

 testcases/network/iproute/ip_tests.sh |  101 +++++++++++---------------------
 1 files changed, 35 insertions(+), 66 deletions(-)

diff --git a/testcases/network/iproute/ip_tests.sh b/testcases/network/iproute/ip_tests.sh
index 384633e..cb42e7a 100755
--- a/testcases/network/iproute/ip_tests.sh
+++ b/testcases/network/iproute/ip_tests.sh
@@ -1,5 +1,5 @@
 #! /bin/sh
-# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2014-2016 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2001
 #
 # This program is free software; you can redistribute it and/or
@@ -26,21 +26,22 @@ TCID="ip_tests"
 
 . test_net.sh
 
+rm_dummy=
+
 init()
 {
 	tst_resm TINFO "inititalizing tests"
 	tst_require_root
 	tst_tmpdir
-	tst_check_cmds cat awk ip ifconfig diff
+	tst_check_cmds cat awk ip diff
 
-	tst_resm TINFO "aliasing $iface to ${iface}:1 10.1.1.12"
-	ifconfig ${iface}:1 10.1.1.12 || \
-		tst_brkm TBROK "failed aliasing"
+	iface=ltp_dummy
+	lsmod | grep -q dummy || rm_dummy=1
 
-	route add -host 10.1.1.12 dev ${iface}:1 || \
-		tst_brkm TBROK "failed adding route to 10.1.1.12"
+	ROD ip li add $iface type dummy
 
-	tst_resm TINFO "alias $iface:1 added"
+	ip4_addr=${IPV4_NET16_UNUSED}.6.6
+	ROD ip a add ${ip4_addr}/24 dev $iface
 
 	cat > tst_ip02.exp <<-EOF
 	1:
@@ -58,62 +59,53 @@ init()
 
 cleanup()
 {
-	ifconfig ${iface}:1 > /dev/null && ifconfig ${iface}:1 down
-
 	tst_rmdir
 
-	# test #2
-	lsmod | grep dummy > /dev/null && rmmod dummy
+	[ -n "$iface" -a -d /sys/class/net/$iface ] && ip li del $iface
+
+	[ "$rm_dummy" ] && modprobe -r dummy
 
 	# test #5
-	ip route show | grep "10.6.6.6" && ip route del 10.6.6.6
+	ip route show | grep $ip4_addr && ip route del $ip4_addr
 }
 
 test01()
 {
 	tst_resm TINFO "test 'ip link set' command"
-	tst_resm TINFO "changing mtu size of ${iface}:1 device"
+	tst_resm TINFO "changing mtu size of $iface device"
 
 	MTUSZ_BAK=$(cat /sys/class/net/${iface}/mtu)
-	ip link set ${iface}:1 mtu 300
+	ip link set ${iface} mtu 1281
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "ip command failed"
 		return
 	fi
 
 	MTUSZ=$(cat /sys/class/net/${iface}/mtu)
-	if [ $MTUSZ -eq 300 ]; then
+	if [ $MTUSZ -eq 1281 ]; then
 		tst_resm TPASS "successfully changed mtu size"
-		ip link set ${iface}:1 mtu $MTUSZ_BAK
+		ip link set $iface mtu $MTUSZ_BAK
 	else
-		tst_resm TFAIL "MTU value not set to 300"
-		tst_resm TINFO "ifconfig returned: $MTUSZ"
+		tst_resm TFAIL "MTU value set to $MTUSZ, but expected 1281"
 	fi
 }
 
 test02()
 {
 	tst_resm TINFO "test 'ip link show' command (list device attributes)"
-	tst_resm TINFO "installing 'dummy' kernel module"
 
-	modprobe dummy
+	ip link show $iface | grep $iface > /dev/null
 	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "modprobe failed to load 'dummy'"
+		tst_resm TFAIL "'ip link show $iface' command failed"
 		return
 	fi
 
-	ip link show dummy0 | grep dummy0 > /dev/null
-	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "'ip link show dummy0' command failed"
-		return
-	fi
-
-	tst_resm TPASS "$iface:1 listed, correct attr returned"
+	tst_resm TPASS "$iface correctly listed"
 }
 
 test03()
 {
-	tst_resm TINFO "test 'ip addr' command"
+	tst_resm TINFO "test 'ip addr' command with loopback dev"
 	tst_resm TINFO "add a new protocol address to the device"
 
 	ip addr add 127.6.6.6/24 dev lo
@@ -149,7 +141,7 @@ test04()
 {
 	tst_resm TINFO "test 'ip neigh' command"
 	tst_resm TINFO "add a new neighbor (or replace existed)"
-	ip neigh replace 127.0.0.1 dev lo nud reachable
+	ip neigh replace 127.6.6.6 lladdr 00:00:00:00:00:00 dev lo nud reachable
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "'ip neigh replace' command failed"
 		return
@@ -157,10 +149,10 @@ test04()
 
 	tst_resm TINFO "show all neighbor entries in arp tables"
 	cat > tst_ip.exp <<-EOF
-127.0.0.1 dev lo lladdr 00:00:00:00:00:00 REACHABLE
+127.6.6.6 dev lo lladdr 00:00:00:00:00:00 REACHABLE
 	EOF
 
-	ip neigh show 127.0.0.1 | head -n1 > tst_ip.out 2>&1
+	ip neigh show 127.6.6.6 | head -n1 > tst_ip.out 2>&1
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "'ip neigh show' command failed"
 		return
@@ -174,15 +166,15 @@ test04()
 
 	tst_resm TINFO "delete neighbor from the arp table"
 
-	ip neigh del 127.0.0.1 dev lo
+	ip neigh del 127.6.6.6 dev lo
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "'ip neigh del' command failed"
 		return
 	fi
 
-	ip neigh show | grep 127.0.0.1 | grep -v " FAILED\$" > /dev/null
+	ip neigh show | grep 127.6.6.6 | grep -v ' FAILED$' > /dev/null
 	if [ $? -eq 0 ]; then
-		tst_resm TFAIL "127.0.0.1 still listed in arp"
+		tst_resm TFAIL "127.6.6.6 still listed in arp"
 		return
 	fi
 
@@ -192,28 +184,17 @@ test04()
 test05()
 {
 	tst_resm TINFO "test 'ip route add/del' commands"
-	tst_resm TINFO "create an iface with 10.6.6.6 alias to $iface"
-
-	ifconfig ${iface}:1 10.6.6.6 netmask 255.255.255.0
-	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "unable to create alias"
-		return
-	fi
 
-	ip route add 10.6.6.6 via 127.0.0.1
-	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "ip route add command failed"
-		return
-	fi
+	ROD ip route add $ip4_addr via 127.0.0.1
 
 	tst_resm TINFO "show all route entries in route table"
 
 	# create expected output file.
 	cat > tst_ip.exp <<-EOF
-10.6.6.6 via 127.0.0.1 dev lo
+$ip4_addr via 127.0.0.1 dev lo
 	EOF
 
-	ip route show | grep "10.6.6.6 via 127.0.0.1 dev lo" > tst_ip.out 2>&1
+	ip route show | grep "$ip4_addr via 127.0.0.1 dev lo" > tst_ip.out 2>&1
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "'ip route show' command failed"
 		return
@@ -227,11 +208,7 @@ test05()
 
 	tst_resm TINFO "delete route from the route table"
 
-	ip route del 10.6.6.6 via 127.0.0.1
-	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "'ip route del' command failed"
-		return
-	fi
+	ROD ip route del $ip4_addr via 127.0.0.1
 
 	ip route show | grep 127.0.0.1 > /dev/null
 	if [ $? -eq 0 ]; then
@@ -247,13 +224,7 @@ test06()
 	tst_resm TINFO "test 'ip maddr add/del' commands"
 	tst_resm TINFO "adding a new multicast addr"
 
-	ifconfig ${iface}:1 10.6.6.6 netmask 255.255.255.0
-	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "unable to create ${iface}:1 10.6.6.6"
-		return
-	fi
-
-	ip maddr add 66:66:00:00:00:66 dev ${iface}:1
+	ip maddr add 66:66:00:00:00:66 dev $iface
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "ip maddr add command failed"
 		return
@@ -273,13 +244,13 @@ test06()
 
 	diff -iwB tst_ip.out tst_ip.exp
 	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "multicast addr not added to $iface:1"
+		tst_resm TFAIL "multicast addr not added to $iface"
 		return
 	fi
 
 	tst_resm TINFO "delete multicast address"
 
-	ip maddr del 66:66:00:00:00:66 dev ${iface}:1
+	ip maddr del 66:66:00:00:00:66 dev $iface
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "'ip maddr del' command failed"
 		return
@@ -294,8 +265,6 @@ test06()
 	tst_resm TPASS "'ip maddr' command successfully tested"
 }
 
-iface=$(tst_iface)
-
 init
 
 test01
-- 
1.7.1

