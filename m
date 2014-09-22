Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1XW0q7-0007da-5e
	for ltp-list@lists.sourceforge.net; Mon, 22 Sep 2014 10:27:27 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XW0q4-0007Rr-Vu
	for ltp-list@lists.sourceforge.net; Mon, 22 Sep 2014 10:27:27 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s8MARI2Q011072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Sep 2014 10:27:19 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s8MARI9l013843
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Sep 2014 10:27:18 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s8MARIIV013831
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Sep 2014 10:27:18 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 22 Sep 2014 14:29:00 +0400
Message-Id: <1411381740-31517-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] network/ip_route: cleanup test,
	use new library functions
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com

Minor additions:
* tc4: check that 127.0.0.1 neighbor doesn't exist before adding it
* cleanup: remove dummy kernel module on exit
* cleanup: remove added route on exit

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/iproute/ip_tests.sh |  693 +++++++++++----------------------
 1 files changed, 235 insertions(+), 458 deletions(-)

diff --git a/testcases/network/iproute/ip_tests.sh b/testcases/network/iproute/ip_tests.sh
index ed20540..d533867 100755
--- a/testcases/network/iproute/ip_tests.sh
+++ b/testcases/network/iproute/ip_tests.sh
@@ -1,132 +1,63 @@
 #! /bin/sh
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2001                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-################################################################################
+# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2001
 #
-# File :        ip_tests.sh
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
-# Description:  Test basic functionality of ip command in route2 package
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
 #
-# Author:       Manoj Iyer, manjo@mail.utexas.edu
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 #
-# History:      Feb 19 2003 - Created - Manoj Iyer.
-#               Feb 26 2003 - Added - test05, test06
-#                           - Commands mroute, tunnel, monitor and rtmon are
-#                             not covered by this testcase.
 #
-set +x
-
+# Description:  Test basic functionality of ip command in route2 package
+#
+# Author:       Manoj Iyer, manjo@mail.utexas.edu
 
-# Function:		init
+# Function: init
 #
-# Description:	- Check if command ip is available.
+# Description:  - Check if command ip is available.
 #               - Check if command ifconfig is available.
 #               - check if command awk is available.
 #               - alias eth0 to eth0:1 with IP 10.1.1.12
 #
-# Return		- zero on success
+# Return        - zero on success
 #               - non zero on failure. return value from commands ($RC)
-init()
-{
-
-	export TST_TOTAL=2			# total numner of tests in this file.
-	export TCID="ip_tests  "		# this is the init function.
-	export TST_COUNT=0			# init identifier,
-
-	if [ -z $TMP ]
-	then
-		LTPTMP=/tmp/tst_ip.$$/
-	else
-		LTPTMP=$TMP/tst_ip.$$/
-	fi
-
-	# Initialize cleanup function.
-	trap "cleanup" 0
-
-	# create the tmp directory for this testcase.
-	mkdir -p $LTPTMP/ >/dev/null 2>&1
-	RC=$?
-	if [ $RC -ne 0 ]
-	then
-		tst_brkm TBROK NULL "INIT: Unable to create temporary directory"
-		return $RC
-	fi
 
-	# Check to see if test harness functions are in the path.
-	which tst_resm  >$LTPTMP/tst_ip.err 2>&1
-	RC=$?
-	if [ $RC -ne 0 ]
-	then
-		tst_brkm TBROK NULL \
-			"INIT: USCTEST commands not found, set PATH correctly."
-		return $RC
-	fi
+TST_CLEANUP=cleanup
+TST_TOTAL=6
+TCID="ip_tests"
 
-	which awk  >$LTPTMP/tst_ip.err 2>&1
-	RC=$?
-	if [ $RC -ne 0 ]
-	then
-		tst_brkm TBROK NULL \
-			"INIT: command awk not found. Exiting test."
-		return $RC
-	fi
+. test_net.sh
 
-	which ip  >$LTPTMP/tst_ip.err 2>&1
-	RC=$?
-	if [ $RC -ne 0 ]
-	then
-		tst_brkm TBROK NULL \
-			"INIT: command ip not found. Exiting test."
-		return $RC
+init()
+{
+	tst_resm TINFO "INIT: Inititalizing tests"
+	tst_require_root
+	tst_tmpdir
+	tst_check_cmds awk ip ifconfig diff
+
+	tst_resm TINFO "Aliasing $iface to create private network"
+	ifconfig ${iface}:1 10.1.1.12 > /dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		tst_brkm TBROK "INIT: failed aliasing $iface:1 with IP 10.1.1.12"
 	fi
 
-	which ifconfig  >$LTPTMP/tst_ip.err 2>&1
-	RC=$?
-	if [ $RC -ne 0 ]
-	then
-		tst_brkm TBROK NULL \
-			"INIT: command awk not found. Exiting test."
-		return $RC
+	route add -host 10.1.1.12 dev ${iface}:1 > /dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		tst_brkm TBROK "INIT: failed adding route to 10.1.1.12"
 	fi
 
-	tst_resm TINFO "INIT: Inititalizing tests."
-
-	# Aliasing eth0 to create private network.
-	/sbin/ifconfig eth0:1 10.1.1.12 >$LTPTMP/tst_ip.err 2>&1
-	RC=$?
-	if [ $RC -ne 0 ]
-	then
-		tst_brk TBROK NULL NULL "INIT: failed aliasing eth0:1 with IP 10.1.1.12"
-		return $RC
-	else
-		/sbin/route add -host 10.1.1.12 dev eth0:1 >$LTPTMP/tst_ip.err 2>&1
-		RC=$?
-		if [ $RC -ne 0 ]
-		then
-			tst_brk TBROK NULL NULL "INIT: failed adding route to 10.1.1.12"
-			return $RC
-		else
-			tst_resm TINFO "INIT: added alias: `ifconfig eth0:1`"
-		fi
-	fi
+	tst_resm TINFO "INIT: alias $iface:1 added"
 
-	cat > $LTPTMP/tst_ip02.exp <<-EOF
+	cat > tst_ip02.exp <<-EOF
 	1:
 	link/loopback
 	2:
@@ -134,17 +65,12 @@ init()
 	3:
 	link/ether
 	EOF
-	RC=$?
-	if [ $RC -ne 0 ]
-	then
-		tst_brkm TBROK NULL "INIT: failed creating expected output for test02"
-		return $RC
-	fi
 
-	return $RC
+	if [ $? -ne 0 ]; then
+		tst_brkm TBROK "INIT: can't create expected output for test02"
+	fi
 }
 
-
 # Function:		cleanup
 #
 # Description	- remove temporary files and directories.
@@ -154,20 +80,18 @@ init()
 #               - non zero on failure. return value from commands ($RC)
 cleanup()
 {
-	TCID=dhcpd
-	TST_COUNT=0
-
-	/sbin/ifconfig eth0:1 >$LTPTMP/tst_ip.err 2>&1
-	RC=$?
-	if [ $RC -eq 0 ]
-	then
-		/sbin/ifconfig eth0:1 down >$LTPTMP/tst_ip.err 2>&1
+	ifconfig ${iface}:1 > /dev/null 2>&1
+	if [ $? -eq 0 ]; then
+		ifconfig ${iface}:1 down > /dev/null 2>&1
 	fi
+	tst_rmdir
 
-	rm -fr $LTPTMP
-	return $RC
-}
+	# test #2
+	lsmod | grep dummy > /dev/null 2>&1 && rmmod dummy > /dev/null 2>&1
 
+	# test #5
+	ip route show | grep "10.6.6.6" && ip route del 10.6.6.6
+}
 
 # Function:		test01
 #
@@ -180,42 +104,29 @@ cleanup()
 #
 # Return		- zero on success
 #               - non zero on failure. return value from commands ($RC)
-
 test01()
 {
-	TCID=ip01	    # Name of the test case.
-	TST_COUNT=1		# Test number.
-
-	tst_resm TINFO \
-	 "Test #1: ip link set DEVICE mtu MTU changes the device mtu size"
-
-	tst_resm TINFO "Test #1: changing mtu size of eth0:1 device."
-
-	MTUSZ_BAK=`ifconfig eth0:1 | grep -i MTU | sed "s/^.*MTU://" \
-		| awk '{print $1}'`
-	ip link set eth0:1 mtu 300 >$LTPTMP/tst_ip.err 2>&1
-	if [ $RC -ne 0 ]
-	then
-		tst_res TFAIL $LTPTMP/tst_ip.err \
-			"Test #1: ip command failed. Reason: "
-		return $RC
+	tst_resm TINFO "changing mtu size of ${iface}:1 device"
+
+	MTUSZ_BAK=$(ifconfig ${iface}:1 | grep -i MTU | sed "s/^.*MTU://" | \
+	            awk '{print $1}')
+	ip link set ${iface}:1 mtu 300 > /dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "ip command failed"
+		return
+	fi
+
+	MTUSZ=$(ifconfig ${iface}:1 | grep -i MTU | \
+	        sed "s/^.*MTU://" | awk '{print $1}')
+	if [ $MTUSZ -eq 300 ]; then
+		tst_resm TPASS "changing mtu size success"
+		ip link set ${iface}:1 mtu $MTUSZ_BAK > /dev/null 2>&1
 	else
-		MTUSZ=`ifconfig eth0:1 | grep -i MTU | sed "s/^.*MTU://" | awk '{print $1}'`
-		if [ $MTUSZ -eq 300 ]
-		then
-			tst_resm TPASS "Test #1: changing mtu size success"
-			ip link set eth0:1 mtu $MTUSZ_BAK \
-				>$LTPTMP/tst_ip.err 2>&1
-		else
-			tst_resm FAIL NULL \
-				"Test #1: MTU value not set to 300: ifconfig returned: $MTUSZ"
-			return $RC
-		fi
+		tst_resm TFAIL "MTU value not set to 300"
+		tst_resm TINFO "ifconfig returned: $MTUSZ"
 	fi
-	return $RC
 }
 
-
 # Function:		test02
 #
 # Description	- Test basic functionality of ip command
@@ -226,39 +137,24 @@ test01()
 #
 # Return		- zero on success
 #               - non zero on failure. return value from commands ($RC)
-
 test02()
 {
-	TCID=ip02	    # Name of the test case.
-	TST_COUNT=2		# Test number.
-
-	tst_resm TINFO \
-	 "Test #2: ip link show lists device attributes."
+	tst_resm TINFO "ip link show lists device attributes"
+	tst_resm TINFO "Installing dummy.o in kernel"
 
-
-	tst_resm TINFO \
-	 "Test #2: Installing dummy.o in kernel"
-
-	modprobe dummy >$LTPTMP/tst_ip.out 2>&1
-	RC=$?
-	if [ $RC -ne 0 ]
-	then
-		tst_brk TBROK $LTPTMP/tst_ip.out NULL \
-			"Test #2: modprobe failed to load dummy.o"
-		return $RC
+	modprobe dummy > /dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "modprobe failed to load dummy.o"
+		return
 	fi
 
-	ip link show dummy0 | grep dummy0 >$LTPTMP/tst_ip.err 2>&1
-	RC=$?
-	if [ $RC -ne 0 ]
-	then
-		tst_res TFAIL $LTPTMP/tst_ip.err "Test #2: ip command failed. Reason:"
-		return $RC
-	else
-		tst_resm TPASS \
-			"Test #2: Listed eth0:1 and returned correct attributes"
+	ip link show dummy0 | grep dummy0 > /dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "ip command failed"
+		return
 	fi
-	return $RC
+
+	tst_resm TPASS "Listed $iface:1 and returned correct attr"
 }
 
 
@@ -277,60 +173,37 @@ test02()
 #
 # Return		- zero on success
 #               - non zero on failure. return value from commands ($RC)
-
 test03()
 {
-	TCID=ip03	    # Name of the test case.
-	TST_COUNT=3		# Test number.
-
-	tst_resm TINFO \
-	 "Test #3: ip addr add - adds a new protolcol address to the device"
-
-	ip addr add 127.6.6.6 dev lo >$LTPTMP/tst_ip.err 2>&1
-	RC=$?
-	if [ $RC -ne 0 ]
-	then
-		tst_res TFAIL $LTPTMP/tst_ip.err \
-			"Test #3: ip addr add command failed. Reason:"
-		return $RC
-	else
-		tst_resm TINFO \
-		 "Test #3: ip addr show dev <device> - shows protocol address."
-		ip addr show dev lo | grep 127.6.6.6 >$LTPTMP/tst_ip.err 2>&1
-		RC=$?
-		if [ $RC -ne 0 ]
-		then
-			tst_res TFAIL $LTPTMP/tst_ip.err \
-				"Test #3: ip addr show dev: command failed. Reason:"
-			return $RC
-		fi
+	tst_resm TINFO "add a new protolcol address to the device"
 
-		tst_resm TINFO \
-		 "Test #3: ip addr del <ip> dev <device> - deletes protocol address."
-		ip addr del 127.6.6.6 dev lo >$LTPTMP/tst_ip.err 2>&1
-		RC=$?
-		if [ $RC -ne 0 ]
-		then
-			tst_res TFAIL $LTPTMP/tst_ip.err \
-				"Test #3: ip addr del command failed. Reason: "
-			return $RC
-		else
-			ip addr show dev lo | grep 127.6.6.6 >$LTPTMP/tst_ip.err 2>&1
-			RC=$?
-			if [ $RC -eq 0 ]
-			then
-				tst_res TFAIL $LTPTMP/tst_ip.err \
-				"Test #3: ip addr del command failed. Reason: "
-				return $(($RC+1))
-			else
-				RC=0
-			fi
-
-		tst_resm TPASS \
-			"Test #3: ip addr command tests successful"
-		fi
+	ip addr add 127.6.6.6 dev lo > /dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "ip addr add command failed"
+		return
+	fi
+
+	tst_resm TINFO "shows protocol address"
+	ip addr show dev lo | grep 127.6.6.6 > /dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "ip addr show dev: command failed"
+		return
+	fi
+
+	tst_resm TINFO "deletes protocol address"
+	ip addr del 127.6.6.6 dev lo > /dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "ip addr del command failed"
+		return
 	fi
-	return $RC
+
+	ip addr show dev lo | grep 127.6.6.6 > /dev/null 2>&1
+	if [ $? -eq 0 ]; then
+		tst_resm TFAIL "ip addr del command failed"
+		return
+	fi
+
+	tst_resm TPASS "ip addr command tests successful"
 }
 
 
@@ -347,76 +220,51 @@ test03()
 #
 # Return		- zero on success
 #               - non zero on failure. return value from commands ($RC)
-
 test04()
 {
-	TCID=ip04	    # Name of the test case.
-	TST_COUNT=4		# Test number.
-
-	tst_resm TINFO \
-	 "Test #4: ip neigh add - adds a new neighbour to arp tables."
-
-	ip neigh add 127.0.0.1 dev lo nud reachable >$LTPTMP/tst_ip.err 2>&1
-	RC=$?
-	if [ $RC -ne 0 ]
-	then
-		tst_res TFAIL $LTPTMP/tst_ip.err \
-			"Test #4: ip neigh add command failed. Reason:"
-		return $RC
-	else
-		tst_resm TINFO \
-		 "Test #4: ip neigh show - shows all neighbour entries in arp tables."
-
-		cat > $LTPTMP/tst_ip.exp <<-EOF
-		127.0.0.1 dev lo lladdr 00:00:00:00:00:00 REACHABLE
-		EOF
-
-		ip neigh show 127.0.0.1 | head -n1 >$LTPTMP/tst_ip.out 2>&1
-		RC=$?
-		if [ $RC -ne 0 ]
-		then
-			tst_res TFAIL $LTPTMP/tst_ip.err \
-				"Test #4: ip addr show dev: command failed. Reason:"
-			return $RC
-		else
-			diff -iwB  $LTPTMP/tst_ip.out $LTPTMP/tst_ip.exp \
-				>$LTPTMP/tst_ip.err 2>&1
-			RC=$?
-			if [ $RC -ne 0 ]
-			then
-				tst_res FAIL $LTPTMP/tst_ip.err \
-					"Test #4: expected out differs from actual output. Reason:"
-				return $RC
-			fi
+	tst_resm TINFO "add a new neighbour to arp tables"
+	ip neigh show dev lo | grep 127.0.0.1 > /dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		ip neigh add 127.0.0.1 dev lo nud reachable > /dev/null 2>&1
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL "ip neigh add command failed"
+			return
 		fi
+	fi
 
-		tst_resm TINFO \
-		 "Test #4: ip neigh del - deletes neighbour from the arp table."
-
-		ip neigh del 127.0.0.1 dev lo >$LTPTMP/tst_ip.err 2>&1
-		RC=$?
-		if [ $RC -ne 0 ]
-		then
-			tst_res TFAIL $LTPTMP/tst_ip.err \
-				"Test #4: ip neigh del command failed return = $RC. Reason: "
-			return $RC
-		else
-			ip neigh show | grep 127.0.0.1 | grep -v " FAILED$" >$LTPTMP/tst_ip.err 2>&1
-			RC=$?
-			if [ $RC -eq 0 ]
-			then
-				tst_res TFAIL $LTPTMP/tst_ip.err \
-				"Test #4: 127.0.0.1 still listed in arp. ip cmd Error Message:"
-				return $(($RC+1))
-			else
-				RC=0
-			fi
-		fi
+	tst_resm TINFO "shows all neighbour entries in arp tables"
+
+	cat > tst_ip.exp <<-EOF
+127.0.0.1 dev lo lladdr 00:00:00:00:00:00 REACHABLE
+	EOF
+
+	ip neigh show 127.0.0.1 | head -n1 > tst_ip.out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "ip addr show dev: command failed"
+		return
+	fi
+
+	diff -iwB tst_ip.out tst_ip.exp > /dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "expected out differs from actual output"
+		return
+	fi
+
+	tst_resm TINFO "deletes neighbour from the arp table"
+
+	ip neigh del 127.0.0.1 dev lo > /dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "ip neigh del command failed"
+		return
+	fi
 
-		tst_resm TPASS \
-			"Test #4: ip neigh command tests successful"
+	ip neigh show | grep 127.0.0.1 | grep -v " FAILED$" > /dev/null 2>&1
+	if [ $? -eq 0 ]; then
+		tst_resm TFAIL "127.0.0.1 still listed in arp"
+		return
 	fi
-	return $RC
+
+	tst_resm TPASS "ip neigh command tests successful"
 }
 
 
@@ -432,93 +280,58 @@ test04()
 #
 # Return		- zero on success
 #               - non zero on failure. return value from commands ($RC)
-
 test05()
 {
-	TCID=ip05	    # Name of the test case.
-	TST_COUNT=5		# Test number.
+	tst_resm TINFO "adds a new route to route tables"
+	tst_resm TINFO "create an iface with 10.6.6.6 alias to $iface"
 
-	tst_resm TINFO \
-	 "Test #5: ip route add - adds a new route to route tables."
+	ifconfig ${iface}:1 10.6.6.6 netmask 255.255.255.0 > /dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "unable to create alias"
+		return
+	fi
+
+	ip route add 10.6.6.6 via 127.0.0.1 > /dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "ip route add command failed"
+		return
+	fi
 
+	tst_resm TINFO "shows all route entries in route tables"
 
-	tst_resm TINFO \
-	 "Test #5: create an interface with inet 10.6.6.6 alias to eth0"
+	# create expected output file.
+	cat > tst_ip.exp <<-EOF
+10.6.6.6 via 127.0.0.1 dev lo
+	EOF
 
-	ifconfig eth0:1 10.6.6.6 netmask 255.255.255.0 >$LTPTMP/tst_ip.err 2>&1
-	RC=$?
-	if [ $RC -ne 0 ]
-	then
-		tst_brk TBROK $LTPTMP/tst_ip.err NULL \
-			"Test #5: unable to create interface eth0:1 inet 10.6.6.6. Reason:"
-		return $RC
+	ip route show | grep "10.6.6.6 via 127.0.0.1 dev lo" > tst_ip.out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "ip route show command failed"
+		return
 	fi
 
-	ip route add 10.6.6.6 via 127.0.0.1 >$LTPTMP/tst_ip.err 2>&1
-	RC=$?
-	if [ $RC -ne 0 ]
-	then
-		tst_res TFAIL $LTPTMP/tst_ip.err \
-			"Test #5: ip route add command failed. Reason:"
-		return $RC
-	else
-		tst_resm TINFO \
-		 "Test #5: ip route show - shows all route entries in route tables."
-
-		# create expected output file.
-		cat > $LTPTMP/tst_ip.exp <<-EOF
-		10.6.6.6 via 127.0.0.1 dev lo
-		EOF
-
-		ip route show | grep "10.6.6.6 via 127.0.0.1 dev lo" \
-			>$LTPTMP/tst_ip.out 2>&1
-		RC=$?
-		if [ $RC -ne 0 ]
-		then
-			tst_res TFAIL $LTPTMP/tst_ip.err \
-				"Test #5: ip route show command failed. Reason:"
-			return $RC
-		else
-			diff -iwB  $LTPTMP/tst_ip.out $LTPTMP/tst_ip.exp \
-				>$LTPTMP/tst_ip.err 2>&1
-			RC=$?
-			if [ $RC -ne 0 ]
-			then
-				tst_res FAIL $LTPTMP/tst_ip.err \
-					"Test #5: ip route show did not list new route. Details:"
-				return $RC
-			fi
-		fi
+	diff -iwB tst_ip.out tst_ip.exp > /dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "ip route show did not list new route"
+		return
+	fi
 
-		tst_resm TINFO \
-		 "Test #5: ip route del - deletes route from the route table."
-
-		ip route del 10.6.6.6 via 127.0.0.1 >$LTPTMP/tst_ip.err 2>&1
-		RC=$?
-		if [ $RC -ne 0 ]
-		then
-			tst_res TFAIL $LTPTMP/tst_ip.err \
-				"Test #5: ip route del command failed return = $RC. Reason: "
-			return $RC
-		else
-			ip route show | grep 127.0.0.1 >$LTPTMP/tst_ip.err 2>&1
-			RC=$?
-			if [ $RC -eq 0 ]
-			then
-				tst_res TFAIL $LTPTMP/tst_ip.err \
-				"Test #5: route not deleted. ip route show:"
-				return $(($RC+1))
-			else
-				RC=0
-			fi
-		fi
+	tst_resm TINFO "deletes route from the route table"
 
-		tst_resm TPASS \
-			"Test #5: ip route command tests successful"
+	ip route del 10.6.6.6 via 127.0.0.1 > /dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "ip route del command failed"
+		return
 	fi
-	return $RC
-}
 
+	ip route show | grep 127.0.0.1 > /dev/null 2>&1
+	if [ $? -eq 0 ]; then
+		tst_resm TFAIL "route not deleted"
+		return
+	fi
+
+	tst_resm TPASS "ip route command tests successful"
+}
 
 # Function:		test06
 #
@@ -532,102 +345,66 @@ test05()
 #
 # Return		- zero on success
 #               - non zero on failure. return value from commands ($RC)
-
 test06()
 {
-	TCID=ip06	    # Name of the test case.
-	TST_COUNT=6		# Test number.
-
-	tst_resm TINFO \
-	 "Test #6: ip maddr add - adds a new multicast addr"
-
-	ifconfig eth0:1 10.6.6.6 netmask 255.255.255.0 >$LTPTMP/tst_ip.err 2>&1
-	RC=$?
-	if [ $RC -ne 0 ]
-	then
-		tst_brk TBROK $LTPTMP/tst_ip.err NULL \
-			"Test #6: unable to create interface eth0:1 inet 10.6.6.6. Reason:"
-		return $RC
+	tst_resm TINFO "ip maddr add - adds a new multicast addr"
+
+	ifconfig ${iface}:1 10.6.6.6 netmask 255.255.255.0 > /dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "unable to create ${iface}:1 10.6.6.6"
+		return
 	fi
 
-	ip maddr add 66:66:00:00:00:66 dev eth0:1 >$LTPTMP/tst_ip.err 2>&1
-	RC=$?
-	if [ $RC -ne 0 ]
-	then
-		tst_res TFAIL $LTPTMP/tst_ip.err \
-			"Test #6: ip maddr add command failed. Reason:"
-		return $RC
-	else
-		tst_resm TINFO \
-		 "Test #6: ip maddr show - shows all multicast addr entries."
+	ip maddr add 66:66:00:00:00:66 dev ${iface}:1 > /dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "ip maddr add command failed"
+		return
+	fi
+
+	tst_resm TINFO "shows all multicast addr entries"
 
-		cat > $LTPTMP/tst_ip.exp <<-EOF
+	cat > tst_ip.exp <<-EOF
         link  66:66:00:00:00:66 static
-		EOF
-
-		ip maddr show | grep "66:66:00:00:00:66" >$LTPTMP/tst_ip.out 2>&1
-		RC=$?
-		if [ $RC -ne 0 ]
-		then
-			tst_res TFAIL $LTPTMP/tst_ip.err \
-				"Test #6: ip maddr show dev: command failed. Reason:"
-			return $RC
-		else
-			diff -iwB  $LTPTMP/tst_ip.out $LTPTMP/tst_ip.exp \
-				&>$LTPTMP/tst_ip.err
-			RC=$?
-			if [ $RC -ne 0 ]
-			then
-				tst_res FAIL $LTPTMP/tst_ip.err \
-					"Test #6: multicast addr not added to eth0:1. Details:"
-				return $RC
-			fi
-		fi
+	EOF
 
-		tst_resm TINFO \
-		 "Test #6: ip maddr del - deletes multicast addr."
-
-		ip maddr del 66:66:00:00:00:66 dev eth0:1 >$LTPTMP/tst_ip.err 2>&1
-		RC=$?
-		if [ $RC -ne 0 ]
-		then
-			tst_res TFAIL $LTPTMP/tst_ip.err \
-				"Test #6: ip maddr del command failed return = $RC. Reason: "
-			return $RC
-		else
-			ip maddr show | grep "66:66:00:00:00:66" &>$LTPTMP/tst_ip.err
-			RC=$?
-			if [ $RC -eq 0 ]
-			then
-				tst_res TFAIL $LTPTMP/tst_ip.err \
-				"Test #6: 66:66:00:00:00:66 is not deleted. Details:"
-				return $(($RC+1))
-			else
-				RC=0
-			fi
-		fi
+	ip maddr show | grep "66:66:00:00:00:66" > tst_ip.out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "ip maddr show dev: command failed"
+		return
+	fi
+
+	diff -iwB tst_ip.out tst_ip.exp > /dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "multicast addr not added to $iface:1"
+		return
+	fi
+
+	tst_resm TINFO "ip maddr del - deletes multicast addr"
 
-		tst_resm TPASS \
-			"Test #6: ip maddr command tests successful"
+	ip maddr del 66:66:00:00:00:66 dev ${iface}:1 > /dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "ip maddr del command failed"
+		return
 	fi
-	return $RC
+
+	ip maddr show | grep "66:66:00:00:00:66" > /dev/null 2>&1
+	if [ $? -eq 0 ]; then
+		tst_resm TFAIL "66:66:00:00:00:66 is not deleted"
+		return
+	fi
+
+	tst_resm TPASS "ip maddr command tests successful"
 }
 
-# Function:		main
-#
-# Description:	- Execute all tests, report results.
-#
-# Exit:			- zero on success
-# 				- non-zero on failure.
-TFAILCNT=0			# Set TFAILCNT to 0, increment on failure.
+iface=$(tst_iface)
 
-init || exit $RC
+init
 
-test01 || exit $RC
-test02 || exit $RC
-test03 || exit $RC
-test04 || exit $RC
-test05 || exit $RC
-test06 || exit $RC
+test01
+test02
+test03
+test04
+test05
+test06
 
-exit 0
+tst_exit
-- 
1.7.1


------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
