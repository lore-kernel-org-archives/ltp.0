From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  3 Sep 2019 16:16:08 +0200
Subject: [LTP] [PATCH v4 5/7] network/route: Rewrite route{4,
 6}-change-dst into new shell API
In-Reply-To: <20190903141610.28887-1-pvorel@suse.cz>
References: <20190903141610.28887-1-pvorel@suse.cz>
Message-ID: <20190903141610.28887-6-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Drop route command (use just ip command), support both IPv4 and IPv6
* Add route-lib.sh (will be used in other route-change-*)
* Use unused network range to avoid clash with real network
* Add verification with ping (previous version sent UDP datagram with
ns-udpsender, but didn't verify receiving it on rhost and didn't setup
rhost ip at all)

Suggested-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/net_stress.route                      |   7 +-
 .../network/stress/route/00_Descriptions.txt  |  18 +-
 .../network/stress/route/route-change-dst.sh  |  34 +++
 testcases/network/stress/route/route-lib.sh   |  17 ++
 .../network/stress/route/route4-change-dst    | 276 ------------------
 .../network/stress/route/route6-change-dst    | 272 -----------------
 6 files changed, 56 insertions(+), 568 deletions(-)
 create mode 100755 testcases/network/stress/route/route-change-dst.sh
 create mode 100644 testcases/network/stress/route/route-lib.sh
 delete mode 100644 testcases/network/stress/route/route4-change-dst
 delete mode 100644 testcases/network/stress/route/route6-change-dst

diff --git a/runtest/net_stress.route b/runtest/net_stress.route
index 266ef0383..5ffd57b12 100644
--- a/runtest/net_stress.route
+++ b/runtest/net_stress.route
@@ -1,14 +1,11 @@
-#
 # Stress test for routing table
-#
-
-route4-change-dst route4-change-dst
+route4-change-dst route-change-dst.sh
 route4-change-gw route4-change-gw
 route4-change-if route4-change-if
 route4-redirect route4-redirect
 route4-rmmod route4-rmmod
 
-route6-change-dst route6-change-dst
+route6-change-dst route-change-dst.sh -6
 route6-change-gw route6-change-gw
 route6-change-if route6-change-if
 route6-redirect route6-redirect
diff --git a/testcases/network/stress/route/00_Descriptions.txt b/testcases/network/stress/route/00_Descriptions.txt
index 2a871fdae..d8a83b327 100644
--- a/testcases/network/stress/route/00_Descriptions.txt
+++ b/testcases/network/stress/route/00_Descriptions.txt
@@ -1,10 +1,6 @@
-route4-change-dst01
-	Verify the kernel is not crashed when the destination of an IPv4 route
-	is changed frequently by route command
-
-route4-change-dst02
-	Verify the kernel is not crashed when the destination of an IPv4 route
-	is changed frequently by ip command
+route{4,6}-change-dst
+	Verify the IPv4/IPv6 is not broken when ip command changes route
+	destination many times
 
 route4-change-gw01
 	Verify the kernel is not crashed when the gateway of an IPv4 route is
@@ -35,14 +31,6 @@ route4-rmmod02
 	then it is deleted by the removing network driver
 
 
-route6-change-dst01
-	Verify the kernel is not crashed when the destination of an IPv6 route
-	is changed frequently by route command
-
-route6-change-dst02
-	Verify the kernel is not crashed when the destination of an IPv6 route
-	is changed frequently by ip command
-
 route6-change-gw01
 	Verify the kernel is not crashed when the gateway of an IPv6 route is
 	changed frequently by route command
diff --git a/testcases/network/stress/route/route-change-dst.sh b/testcases/network/stress/route/route-change-dst.sh
new file mode 100755
index 000000000..beec2dfad
--- /dev/null
+++ b/testcases/network/stress/route/route-change-dst.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) International Business Machines Corp., 2006
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
+# Rewrite into new shell API: Petr Vorel
+#
+# Change route destination
+# lhost: 10.0.0.2, rhost: 10.23.x.1
+
+TST_TESTFUNC="test_dst"
+. route-lib.sh
+
+setup()
+{
+	tst_res TINFO "change IPv$TST_IPVER route destination $NS_TIMES times"
+}
+
+test_dst()
+{
+	local iface="$(tst_iface)"
+	local rt="$(tst_ipaddr_un -p $1)"
+	local rhost="$(tst_ipaddr_un $1 1)"
+
+	tst_res TINFO "testing route '$rt'"
+
+	tst_add_ipaddr -s -a $rhost rhost
+	ROD ip route add $rt dev $iface
+	EXPECT_PASS ping$TST_IPV6 -c1 -I $(tst_ipaddr) $rhost \>/dev/null
+	ROD ip route del $rt dev $iface
+	tst_del_ipaddr -s -a $rhost rhost
+}
+
+tst_run
diff --git a/testcases/network/stress/route/route-lib.sh b/testcases/network/stress/route/route-lib.sh
new file mode 100644
index 000000000..4afbe6323
--- /dev/null
+++ b/testcases/network/stress/route/route-lib.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
+
+TST_NEEDS_ROOT=1
+TST_SETUP="setup"
+TST_CLEANUP="route_cleanup"
+TST_NEEDS_CMDS="ip"
+TST_CNT=$NS_TIMES
+
+. tst_net.sh
+
+route_cleanup()
+{
+	tst_restore_ipaddr
+	tst_restore_ipaddr rhost
+}
diff --git a/testcases/network/stress/route/route4-change-dst b/testcases/network/stress/route/route4-change-dst
deleted file mode 100644
index 8ec606152..000000000
--- a/testcases/network/stress/route/route4-change-dst
+++ /dev/null
@@ -1,276 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2006                 ##
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
-##                                                                            ##
-################################################################################
-#
-# File:
-#   route4-change-dst
-#
-# Description:
-#   Verify the kernel is not crashed when the destination of an IPv4 route is
-#   changed frequently
-#    test01 - by route command
-#    test02 - by ip command
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Mar 16 2006 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../ ; pwd)`}
-export LTPROOT
-
-# Total number of the test case
-TST_TOTAL=2
-export TST_TOTAL
-
-# Default of the test case ID and the test case count
-TCID=route4-change-dst
-TST_COUNT=0
-export TCID
-export TST_COUNT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# The number of times where route is changed
-NS_TIMES=${NS_TIMES:-10000}
-
-# The number of the test link where tests run
-LINK_NUM=${LINK_NUM:-0}
-
-# Network portion of the IPv4 address
-IPV4_NETWORK=${IPV4_NETWORK:-"10.0.0"}
-
-# Netmask of for the tested network
-IPV4_NETMASK="255.255.255.0"
-IPV4_NETMASK_NUM=24
-
-# Broadcast address of the tested network
-IPV4_BROADCAST=${IPV4_NETWORK}.255
-
-# Host portion of the IPv4 address
-LHOST_IPV4_HOST=${LHOST_IPV4_HOST:-"2"}	# src
-RHOST_IPV4_HOST=${RHOST_IPV4_HOST:-"1"}	# gateway
-
-# The destination network
-DST_NETWORK_PREFIX="10.10"	# destination network would be 10.10.n.0/24
-DST_HOST="5"
-DST_PORT="7"
-
-
-#-----------------------------------------------------------------------
-#
-# NAME:
-#   do_setup
-#
-# DESCRIPTION:
-#   Make a IPv4 connectivity
-#
-# SET VALUES:
-#   rhost_ipv4addr	- IPv4 Address of the remote host
-#   lhost_ifname	- Interface name of the local host
-#   rhost_ifname	- Interface name of the remote host
-#
-#-----------------------------------------------------------------------
-do_setup()
-{
-    TCID=route4-change-dst
-    TST_COUNT=0
-
-    # Initialize the interfaces of the remote host
-    initialize_if rhost ${LINK_NUM}
-
-    # Set IPv4 address to the interfaces
-    set_ipv4addr rhost ${LINK_NUM} ${IPV4_NETWORK} ${RHOST_IPV4_HOST}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add an IPv4 address the remote host"
-	exit $TST_TOTAL
-    fi
-
-    # IPv4 address of the remote host (gateway)
-    rhost_ipv4addr="${IPV4_NETWORK}.${RHOST_IPV4_HOST}"
-
-    # Get the Interface name of local host
-    lhost_ifname=`get_ifname lhost ${LINK_NUM}`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the local host"
-	exit $TST_TOTAL
-    fi
-
-    # Get the Interface name of remote host
-    rhost_ifname=`get_ifname rhost ${LINK_NUM}`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the remote host"
-	exit $TST_TOTAL
-    fi
-}
-
-
-
-#-----------------------------------------------------------------------
-#
-# NAME:
-#   do_cleanup
-#
-# DESCRIPTION:
-#   Recover the tested interfaces
-#
-#-----------------------------------------------------------------------
-do_cleanup()
-{
-    # Initialize the interfaces
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
-
-
-#-----------------------------------------------------------------------
-#
-# FUNCTION:
-#   test_body
-#
-# DESCRIPTION:
-#   main code of the test
-#
-# Arguments:
-#   $1: define the test type
-#       1 - route command case
-#       2 - ip command case
-#
-#-----------------------------------------------------------------------
-test_body()
-{
-    test_type=$1
-
-    TCID=route4-change-dst0${test_type}
-    TST_COUNT=$test_type
-
-    case $test_type in
-	1)
-	test_command="route"
-	;;
-	2)
-	test_command="ip"
-	;;
-	*)
-	tst_resm TBROK "unspecified case"
-	return 1
-	;;
-    esac
-
-    tst_resm TINFO "Verify the kernel is not crashed when the destination of an IPv4 route is changed frequently by $test_command command in $NS_TIMES times"
-
-    # Initialize the interface of the local host
-    initialize_if lhost ${LINK_NUM}
-
-    # Assign IPv4 address to the interface of the local host
-    set_ipv4addr lhost ${LINK_NUM} ${IPV4_NETWORK} ${LHOST_IPV4_HOST}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to assign an IPv4 address at the local host"
-	return 1
-    fi
-    lhost_ipv4addr="${IPV4_NETWORK}.${LHOST_IPV4_HOST}"
-
-    # Check the connectivity to the gateway
-    check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Test Link $LINK_NUM is somthing wrong."
-	return 1
-    fi
-
-    # Start the loop
-    cnt=0
-    while [ $cnt -lt $NS_TIMES ]; do
-	# Define the destination IP address
-	dst_network_postfix=`expr $cnt % 255`
-	dst_addr=${DST_NETWORK_PREFIX}.${dst_network_postfix}.${DST_HOST}
-	dst_network=${DST_NETWORK_PREFIX}.${dst_network_postfix}.0
-
-	# Add the route
-	case $test_type in
-	    1)
-	    route add -net $dst_network netmask 255.255.255.0 gw $rhost_ipv4addr dev $lhost_ifname
-	    ;;
-	    2)
-	    ip route add ${dst_network}/24 via $rhost_ipv4addr dev $lhost_ifname
-	    ;;
-	esac
-	if [ $? -ne 0 ]; then
-	    tst_resm TFAIL "Failed to add the route to ${dst_network}/24"
-	    return 1
-	fi
-
-	# Load the route with UDP datagram
-	ns-udpsender -f 4 -D $dst_addr -p $DST_PORT -o -s 1472
-	if [ $? -ne 0 ]; then
-	    tst_resm TFAIL "Failed to run a UDP datagram sender"
-	    return 1
-	fi
-
-	# Delete the route
-	case $test_type in
-	    1)
-	    route del -net $dst_network netmask 255.255.255.0 gw $rhost_ipv4addr dev $lhost_ifname
-	    ;;
-	    2)
-	    ip route del ${dst_network}/24 via $rhost_ipv4addr dev $lhost_ifname
-	    ;;
-	esac
-	if [ $? -ne 0 ]; then
-	    tst_resm TFAIL "Cannot delete the route to ${ADDDEL_ROUTE}"
-	    return 1
-	fi
-
-	cnt=`expr $cnt + 1`
-    done
-
-    tst_resm TPASS "Test is finished correctly."
-    return 0
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-# Exit Value:
-#   The number of the failure
-#
-#-----------------------------------------------------------------------
-
-RC=0
-do_setup
-test_body 1 || RC=`expr $RC + 1`      # Case of route command
-test_body 2 || RC=`expr $RC + 1`      # Case of ip command
-do_cleanup
-
-exit $RC
diff --git a/testcases/network/stress/route/route6-change-dst b/testcases/network/stress/route/route6-change-dst
deleted file mode 100644
index 2aa953396..000000000
--- a/testcases/network/stress/route/route6-change-dst
+++ /dev/null
@@ -1,272 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2006                 ##
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
-##                                                                            ##
-################################################################################
-#
-# File:
-#   route6-change-dst
-#
-# Description:
-#   Verify the kernel is not crashed when the destination of an IPv6 route is
-#   changed frequently
-#    test01 - by route command
-#    test02 - by ip command
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Mar 16 2006 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../ ; pwd)`}
-export LTPROOT
-
-# Total number of the test case
-TST_TOTAL=2
-export TST_TOTAL
-
-# Default of the test case ID and the test case count
-TCID=route6-change-dst
-TST_COUNT=0
-export TCID
-export TST_COUNT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# The number of times where route is changed
-NS_TIMES=${NS_TIMES:-10000}
-
-# The number of the test link where tests run
-LINK_NUM=${LINK_NUM:-0}
-
-# Network portion of the IPv6 address
-IPV6_NETWORK="fec0:1:1:1"
-
-# Netmask of for the tested network
-IPV6_NETMASK_NUM=64
-
-# Host portion of the IPv6 address
-LHOST_IPV6_HOST=":2"	# src
-RHOST_IPV6_HOST=":3"	# gateway
-
-# The destination network
-DST_NETWORK_PREFIX="fd00:100:1"	# dest network would be fd00:100:1:n:::/64
-DST_HOST="5"
-DST_PORT="7"
-
-
-#-----------------------------------------------------------------------
-#
-# NAME:
-#   do_setup
-#
-# DESCRIPTION:
-#   Make a IPv6 connectivity
-#
-# SET VALUES:
-#   rhost_ipv6addr	- IPv6 Address of the remote host
-#   lhost_ifname	- Interface name of the local host
-#   rhost_ifname	- Interface name of the remote host
-#
-#-----------------------------------------------------------------------
-do_setup()
-{
-    TCID=route6-change-dst
-    TST_COUNT=0
-
-    # Initialize the interfaces of the remote host
-    initialize_if rhost ${LINK_NUM}
-
-    # Set IPv6 address to the interfaces
-    add_ipv6addr rhost ${LINK_NUM} ${IPV6_NETWORK} ${RHOST_IPV6_HOST}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add an IPv6 address the remote host"
-	exit $TST_TOTAL
-    fi
-
-    # IPv6 address of the remote host (gateway)
-    rhost_ipv6addr="${IPV6_NETWORK}:${RHOST_IPV6_HOST}"
-
-    # Get the Interface name of local host
-    lhost_ifname=`get_ifname lhost ${LINK_NUM}`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the local host"
-	exit $TST_TOTAL
-    fi
-
-    # Get the Interface name of remote host
-    rhost_ifname=`get_ifname rhost ${LINK_NUM}`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the remote host"
-	exit $TST_TOTAL
-    fi
-}
-
-
-#-----------------------------------------------------------------------
-#
-# NAME:
-#   do_cleanup
-#
-# DESCRIPTION:
-#   Recover the tested interfaces
-#
-#-----------------------------------------------------------------------
-do_cleanup()
-{
-    # Initialize the interfaces
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
-
-
-#-----------------------------------------------------------------------
-#
-# FUNCTION:
-#   test_body
-#
-# DESCRIPTION:
-#   main code of the test
-#
-# Arguments:
-#   $1: define the test type
-#       1 - route command case
-#       2 - ip command case
-#
-#-----------------------------------------------------------------------
-test_body()
-{
-    test_type=$1
-
-    TCID=route6-change-dst0${test_type}
-    TST_COUNT=$test_type
-
-    case $test_type in
-	1)
-	test_command="route"
-	;;
-	2)
-	test_command="ip"
-	;;
-	*)
-	tst_resm TBROK "unspecified case"
-	return 1
-	;;
-    esac
-
-    tst_resm TINFO "Verify the kernel is not crashed when the destination of an IPv6 route is changed frequently by $test_command command in $NS_TIMES times"
-
-    # Initialize the interface of the local host
-    initialize_if lhost ${LINK_NUM}
-
-    # Assign IPv6 address to the interface of the local host
-    add_ipv6addr lhost ${LINK_NUM} ${IPV6_NETWORK} ${LHOST_IPV6_HOST}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to assign an IPv6 address at the local host"
-	return 1
-    fi
-    lhost_ipv6addr="${IPV6_NETWORK}:${LHOST_IPV6_HOST}"
-
-    # Check the connectivity to the gateway
-    check_icmpv6_connectivity $lhost_ifname $rhost_ipv6addr
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Test Link $LINK_NUM is something wrong."
-	return 1
-    fi
-
-    # Start the loop
-    cnt=0
-    while [ $cnt -lt $NS_TIMES ]; do
-	# Define the destination IP address
-	tmp_postfix=`expr $cnt % 65535`
-	dst_network_postfix=`printf "%x" $tmp_postfix`
-	dst_addr=${DST_NETWORK_PREFIX}:${dst_network_postfix}::${DST_HOST}
-	dst_network=${DST_NETWORK_PREFIX}:${dst_network_postfix}::
-
-	# Add the route
-	case $test_type in
-	    1)
-	    route -A inet6 add ${dst_network}/64 gw $rhost_ipv6addr dev $lhost_ifname
-	    ;;
-	    2)
-	    ip -f inet6 route add ${dst_network}/64 via $rhost_ipv6addr dev $lhost_ifname
-	    ;;
-	esac
-	if [ $? -ne 0 ]; then
-	    tst_resm TFAIL "Failed to add the route to ${dst_network}/64"
-	    return 1
-	fi
-
-	# Load the route with UDP datagram
-	ns-udpsender -f 6 -D $dst_addr -p $DST_PORT -o -s 1452
-	if [ $? -ne 0 ]; then
-	    tst_resm TFAIL "Failed to run a UDP datagram sender"
-	    return 1
-	fi
-
-	# Delete the route
-	case $test_type in
-	    1)
-	    route -A inet6 del ${dst_network}/64 gw $rhost_ipv6addr dev $lhost_ifname
-	    ;;
-	    2)
-	    ip -f inet6 route del ${dst_network}/64 via $rhost_ipv6addr dev $lhost_ifname
-	    ;;
-	esac
-	if [ $? -ne 0 ]; then
-	    tst_resm TFAIL "Cannot delete the route to ${ADDDEL_ROUTE}"
-	    return 1
-	fi
-
-	cnt=`expr $cnt + 1`
-    done
-
-    tst_resm TPASS "Test is finished correctly."
-    return 0
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-# Exit Value:
-#   The number of the failure
-#
-#-----------------------------------------------------------------------
-
-RC=0
-do_setup
-test_body 1 || RC=`expr $RC + 1`      # Case of route command
-test_body 2 || RC=`expr $RC + 1`      # Case of ip command
-do_cleanup
-
-exit $RC
-- 
2.22.1

