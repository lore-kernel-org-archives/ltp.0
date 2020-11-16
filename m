From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 16 Nov 2020 23:03:25 +0100
Subject: [LTP] [PATCH 1/1] net/route: Rewrite route-rmmod to new API
Message-ID: <20201116220325.413764-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Use network namespaces and veth only, therefore no need to use ethtool for
defining a driver.

Add reset_ltp_netspace() in tst_net.sh.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/net_stress.route                      |   2 +
 testcases/lib/tst_net.sh                      |  12 +-
 testcases/network/stress/route/route-rmmod.sh |  46 +++
 testcases/network/stress/route/route4-rmmod   | 283 ------------------
 testcases/network/stress/route/route6-rmmod   | 279 -----------------
 5 files changed, 59 insertions(+), 563 deletions(-)
 create mode 100644 testcases/network/stress/route/route-rmmod.sh
 delete mode 100644 testcases/network/stress/route/route4-rmmod
 delete mode 100644 testcases/network/stress/route/route6-rmmod

diff --git a/runtest/net_stress.route b/runtest/net_stress.route
index b60e55bd6..9e1343e0f 100644
--- a/runtest/net_stress.route
+++ b/runtest/net_stress.route
@@ -5,6 +5,7 @@ route4-change-if route-change-if.sh
 route4-change-netlink-dst route-change-netlink-dst.sh
 route4-change-netlink-gw route-change-netlink-gw.sh
 route4-change-netlink-if route-change-netlink-if.sh
+route4-rmmod route-rmmod.sh
 
 route6-change-dst route-change-dst.sh -6
 route6-change-gw route-change-gw.sh -6
@@ -12,3 +13,4 @@ route6-change-if route-change-if.sh -6
 route6-change-netlink-dst route-change-netlink-dst.sh -6
 route6-change-netlink-gw route-change-netlink-gw.sh -6
 route6-change-netlink-if route-change-netlink-if.sh -6
+route6-rmmod route-rmmod.sh -6
diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 46d3fb88e..30514ebaf 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
-# Copyright (c) 2016-2019 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2016-2020 Petr Vorel <pvorel@suse.cz>
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
 [ -n "$TST_LIB_NET_LOADED" ] && return 0
@@ -130,6 +130,16 @@ init_ltp_netspace()
 	tst_restore_ipaddr rhost
 }
 
+reset_ltp_netspace()
+{
+	tst_require_cmds pkill
+
+	rm -f /var/run/netns/ltp_ns
+	pkill ns_create
+	unset LTP_NETNS
+	init_ltp_netspace
+}
+
 # Run command on remote host.
 # tst_rhost_run -c CMD [-b] [-s] [-u USER]
 # Options:
diff --git a/testcases/network/stress/route/route-rmmod.sh b/testcases/network/stress/route/route-rmmod.sh
new file mode 100644
index 000000000..8067d9094
--- /dev/null
+++ b/testcases/network/stress/route/route-rmmod.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) International Business Machines Corp., 2006
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
+# Rewrite into new shell API: Petr Vorel
+
+TST_SETUP="setup"
+TST_CLEANUP="cleanup"
+TST_TESTFUNC="do_test"
+
+module='veth'
+TST_NEEDS_DRIVERS="$module"
+
+. route-lib.sh
+TST_CNT=$ROUTE_CHANGE_IP
+
+setup()
+{
+	tst_res TINFO "adding IPv$TST_IPVER route destination and delete network driver $ROUTE_CHANGE_IP times"
+}
+
+cleanup()
+{
+	modprobe $module
+	route_cleanup
+}
+
+do_test()
+{
+	local iface="$(tst_iface)"
+	local rt="$(tst_ipaddr_un -p $1)"
+	local rhost="$(tst_ipaddr_un $1 1)"
+
+	tst_res TINFO "testing route '$rt'"
+
+	tst_add_ipaddr -s -q -a $rhost rhost
+	ROD ip route add $rt dev $iface
+	EXPECT_PASS_BRK ping$TST_IPV6 -c1 -I $(tst_ipaddr) $rhost \>/dev/null
+
+	ROD rmmod $module
+	ROD modprobe $module
+	reset_ltp_netspace
+}
+
+tst_run
diff --git a/testcases/network/stress/route/route4-rmmod b/testcases/network/stress/route/route4-rmmod
deleted file mode 100644
index 7aa195810..000000000
--- a/testcases/network/stress/route/route4-rmmod
+++ /dev/null
@@ -1,283 +0,0 @@
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
-#   route4-rmmod
-#
-# Description:
-#   Verify the kernel is not crashed when IPv4 route is add then it is deleted
-#   by the removing network driver
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Apr 8 2006 - Created (Mitsuru Chinen)
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
-TCID=route4-rmmod
-TST_COUNT=0
-export TCID
-export TST_COUNT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# The number of times where IPv4 route is add/delete
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
-DST_NETWORK="10.10.10"	# destination network would be 10.10.10.0/24
-DST_HOST="5"
-DST_PORT="7"
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
-    # Make sure to load the network driver
-    if [ x${lhost_module} != x ]; then
-	modprobe $lhost_module
-    fi
-
-    # Initialize the interfaces
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
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
-#-----------------------------------------------------------------------
-do_setup()
-{
-    # Check the local host has ethtool utility
-    which ethtool >/dev/null
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "This test case requires ethtool utility"
-	exit $TST_TOTAL
-    fi
-
-    # The module name of the interface at the local host
-    lhost_module=
-
-    # Make sure to clean up
-    do_cleanup
-
-    # Set IPv4 address to the interfaces of the remote host
-    set_ipv4addr rhost ${LINK_NUM} ${IPV4_NETWORK} ${RHOST_IPV4_HOST}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add an IPv4 address the remote host"
-	exit $TST_TOTAL
-    fi
-    rhost_ipv4addr="${IPV4_NETWORK}.${RHOST_IPV4_HOST}"
-
-    # Assign IPv4 address to the interface of the local host
-    set_ipv4addr lhost ${LINK_NUM} ${IPV4_NETWORK} ${LHOST_IPV4_HOST}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to assign an IPv4 address at the local host"
-	return 1
-    fi
-    lhost_ipv4addr="${IPV4_NETWORK}.${LHOST_IPV4_HOST}"
-
-    # Get the Interface names
-    lhost_ifname=`get_ifname lhost ${LINK_NUM}`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the local host"
-	exit $TST_TOTAL
-    fi
-
-    rhost_ifname=`get_ifname rhost ${LINK_NUM}`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the remote host"
-	exit $TST_TOTAL
-    fi
-
-    # Get the module name of the interface at the local host
-    lhost_module=`ethtool -i $lhost_ifname | grep driver | sed "s/driver:[[:blank:]]*//"`
-
-    # Chack the other active interface uses the same driver
-    for ifname in `ifconfig | grep ^eth | awk '{ print $1}'`; do
-	if [ $lhost_ifname = $ifname ]; then
-	    continue
-	fi
-
-	module=`ethtool -i $ifname | grep driver | sed "s/driver:[[:blank:]]*//"`
-	if [ $lhost_module = $module ]; then
-	    tst_resm TBROK "An active interface $ifname uses the same network deriver $module with the test intreface."
-	    exit $TST_TOTAL
-	fi
-    done
-
-    # Set the variables for destination network
-    dst_addr=${DST_NETWORK}.${DST_HOST}
-    dst_network=${DST_NETWORK}.0
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
-#	1 - route command case
-#	2 - ip command case
-#
-#-----------------------------------------------------------------------
-test_body()
-{
-    test_type=$1
-
-    TCID=route4-rmmod0${test_type}
-    TST_COUNT=$test_type
-
-    case $test_type in
-	1)
-	tst_resm TINFO "Verify the kernel is not crashed when IPv4 route is add by route command then it is deleted by removing network driver in $NS_TIMES times"
-	;;
-	2)
-	tst_resm TINFO "Verify the kernel is not crashed when IPv4 route is add by ip command then it is deleted by removing network driver in $NS_TIMES times"
-	;;
-	*)
-	tst_resm TBROK "unspecified case"
-	return 1
-	;;
-    esac
-
-    # Start the loop
-    cnt=0
-    while [ $cnt -lt $NS_TIMES ]; do
-	# Check the connectivity to the gateway
-	check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr
-	if [ $? -ne 0 ]; then
-	    tst_resm TBROK "Test Link $LINK_NUM is somthing wrong."
-	    return 1
-	fi
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
-	# Remove and reload the network driver
-	rmmod $lhost_module && modprobe $lhost_module
-	if [ $? -ne 0 ]; then
-	    tst_resm TFAIL "Failed to unload/reload the network driver"
-	    return 1
-	fi
-
-	# Make sure to assing the IPv4 address
-	set_ipv4addr lhost ${LINK_NUM} ${IPV4_NETWORK} ${LHOST_IPV4_HOST} >/dev/null 2>&1
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
diff --git a/testcases/network/stress/route/route6-rmmod b/testcases/network/stress/route/route6-rmmod
deleted file mode 100644
index 765a57ae6..000000000
--- a/testcases/network/stress/route/route6-rmmod
+++ /dev/null
@@ -1,279 +0,0 @@
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
-#   route6-rmmod
-#
-# Description:
-#   Verify the kernel is not crashed when IPv6 route is add then it is deleted
-#   by the removing network driver
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Apr 8 2006 - Created (Mitsuru Chinen)
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
-TCID=route6-rmmod
-TST_COUNT=0
-export TCID
-export TST_COUNT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# The number of times where IPv6 route is add/delete
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
-RHOST_IPV6_HOST=":1"	# gateway
-
-# The destination network
-DST_NETWORK="fec0:100:100:100"  # destination network
-DST_HOST=":5"
-DST_PORT="7"
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
-    # Make sure to load the network driver
-    if [ x${lhost_module} != x ]; then
-	modprobe $lhost_module
-    fi
-
-    # Initialize the interfaces
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
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
-#-----------------------------------------------------------------------
-do_setup()
-{
-    # Check the local host has ethtool utility
-    which ethtool >/dev/null
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "This test case requires ethtool utility"
-	exit $TST_TOTAL
-    fi
-
-    # The module name of the interface at the local host
-    lhost_module=
-
-    # Make sure to clean up
-    do_cleanup
-
-    # Assign IPv6 address to the interface of the local host
-    add_ipv6addr lhost ${LINK_NUM} ${IPV6_NETWORK} ${LHOST_IPV6_HOST}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to assign an IPv6 address at the local host"
-	return 1
-    fi
-    lhost_ipv6addr="${IPV6_NETWORK}:${LHOST_IPV6_HOST}"
-
-    # Set IPv6 address to the interfaces of the remote host
-    add_ipv6addr rhost ${LINK_NUM} ${IPV6_NETWORK} ${RHOST_IPV6_HOST}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add an IPv6 address the remote host"
-	exit $TST_TOTAL
-    fi
-    rhost_ipv6addr="${IPV6_NETWORK}:${RHOST_IPV6_HOST}"
-
-    # Get the Interface names
-    lhost_ifname=`get_ifname lhost ${LINK_NUM}`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the local host"
-	exit $TST_TOTAL
-    fi
-
-    rhost_ifname=`get_ifname rhost ${LINK_NUM}`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the remote host"
-	exit $TST_TOTAL
-    fi
-
-    # Get the module name of the interface at the local host
-    lhost_module=`ethtool -i $lhost_ifname | grep driver | sed "s/driver:[[:blank:]]*//"`
-
-    # Chack the other active interface uses the same driver
-    for ifname in `ifconfig | grep ^eth | awk '{ print $1}'`; do
-	if [ $lhost_ifname = $ifname ]; then
-	    continue
-	fi
-
-	module=`ethtool -i $ifname | grep driver | sed "s/driver:[[:blank:]]*//"`
-	if [ $lhost_module = $module ]; then
-	    tst_resm TBROK "An active interface $ifname uses the same network deriver $module with the test intreface."
-	    exit $TST_TOTAL
-	fi
-    done
-
-    # Set the variables for destination network
-    dst_addr=${DST_NETWORK}:${DST_HOST}
-    dst_network=${DST_NETWORK}::
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
-#	1 - route command case
-#	2 - ip command case
-#
-#-----------------------------------------------------------------------
-test_body()
-{
-    test_type=$1
-
-    TCID=route6-rmmod0${test_type}
-    TST_COUNT=$test_type
-
-    case $test_type in
-	1)
-	tst_resm TINFO "Verify the kernel is not crashed when IPv6 route is add by route command then it is deleted by removing network driver in $NS_TIMES times"
-	;;
-	2)
-	tst_resm TINFO "Verify the kernel is not crashed when IPv6 route is add by ip command then it is deleted by removing network driver in $NS_TIMES times"
-	;;
-	*)
-	tst_resm TBROK "unspecified case"
-	return 1
-	;;
-    esac
-
-    # Start the loop
-    cnt=0
-    while [ $cnt -lt $NS_TIMES ]; do
-	# Check the connectivity to the gateway
-	check_icmpv6_connectivity $lhost_ifname $rhost_ipv6addr
-	if [ $? -ne 0 ]; then
-	    tst_resm TBROK "Test Link $LINK_NUM is somthing wrong."
-	    return 1
-	fi
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
-	# Remove and reload the network driver
-	rmmod $lhost_module && modprobe $lhost_module
-	if [ $? -ne 0 ]; then
-	    tst_resm TFAIL "Failed to unload/reload the network driver"
-	    return 1
-	fi
-
-	# Make sure to assing the IPv6 address
-	add_ipv6addr lhost ${LINK_NUM} ${IPV6_NETWORK} ${LHOST_IPV6_HOST} >/dev/null 2>&1
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
2.28.0

