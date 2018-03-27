From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 27 Mar 2018 17:55:40 +0200
Subject: [LTP] [COMMITTED 1/1] network/route: Remove route{4, 6}-ifdown tests
Message-ID: <20180327155540.21139-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

As they're duplicate of if-updown

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
As Alexey pointed it out in [1]:
> +		cmd="$cmd_name link set down dev $(tst_iface)"
> +		cmd2="$cmd_name link set up dev $(tst_iface)"
This test-case looks like duplicate of if-updown

[1] http://lists.linux.it/pipermail/ltp/2017-August/005336.html
---
 runtest/net_stress.route                           |   2 -
 testcases/network/stress/route/00_Descriptions.txt |  16 --
 testcases/network/stress/route/route4-ifdown       | 261 ---------------------
 testcases/network/stress/route/route6-ifdown       | 259 --------------------
 4 files changed, 538 deletions(-)
 delete mode 100644 testcases/network/stress/route/route4-ifdown
 delete mode 100644 testcases/network/stress/route/route6-ifdown

diff --git a/runtest/net_stress.route b/runtest/net_stress.route
index 00ce52fdc..266ef0383 100644
--- a/runtest/net_stress.route
+++ b/runtest/net_stress.route
@@ -6,12 +6,10 @@ route4-change-dst route4-change-dst
 route4-change-gw route4-change-gw
 route4-change-if route4-change-if
 route4-redirect route4-redirect
-route4-ifdown route4-ifdown
 route4-rmmod route4-rmmod
 
 route6-change-dst route6-change-dst
 route6-change-gw route6-change-gw
 route6-change-if route6-change-if
 route6-redirect route6-redirect
-route6-ifdown route6-ifdown
 route6-rmmod route6-rmmod
diff --git a/testcases/network/stress/route/00_Descriptions.txt b/testcases/network/stress/route/00_Descriptions.txt
index 9bcbc5f05..2a871fdae 100644
--- a/testcases/network/stress/route/00_Descriptions.txt
+++ b/testcases/network/stress/route/00_Descriptions.txt
@@ -26,14 +26,6 @@ route4-redirect01
 	Verify the kernel is not crashed when the IPv4 route is modified by
 	ICMP Redirects frequently
 
-route4-ifdown01
-	Verify the kernel is not crashed when IPv4 route is add by route command
-	then it is deleted by the interface down with ifconfig command
-
-route4-ifdown02
-	Verify the kernel is not crashed when IPv4 route is add by ip command
-	then it is deleted by the interface down with ip command
-
 route4-rmmod01
 	Verify the kernel is not crashed when IPv4 route is add by route command
 	then it is deleted by the removing network driver
@@ -71,14 +63,6 @@ route6-redirect01
 	Verify the kernel is not crashed when the IPv6 route is modified by
 	ICMP Redirects frequently
 
-route6-ifdown01
-	Verify the kernel is not crashed when IPv6 route is add by route command
-	then it is deleted by the interface down with ifconfig command
-
-route6-ifdown02
-	Verify the kernel is not crashed when IPv6 route is add by ip command
-	then it is deleted by the interface down with ip command
-
 route6-rmmod01
 	Verify the kernel is not crashed when IPv6 route is add by route command
 	then it is deleted by the removing network driver
diff --git a/testcases/network/stress/route/route4-ifdown b/testcases/network/stress/route/route4-ifdown
deleted file mode 100644
index 1cc8bf321..000000000
--- a/testcases/network/stress/route/route4-ifdown
+++ /dev/null
@@ -1,261 +0,0 @@
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
-#   route4-ifdown
-#
-# Description:
-#   Verify the kernel is not crashed when IPv4 route is add then it is deleted
-#   by the interface down
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
-TCID=route4-ifdown
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
-# SET VALUES:
-#   rhost_ipv4addr	- IPv4 Address of the remote host
-#   lhost_ifname	- Interface name of the local host
-#   rhost_ifname	- Interface name of the remote host
-#
-#-----------------------------------------------------------------------
-do_setup()
-{
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
-    TCID=route4-ifdown0${test_type}
-    TST_COUNT=$test_type
-
-    case $test_type in
-	1)
-	tst_resm TINFO "Verify the kernel is not crashed when IPv4 route is add by route command then it is deleted by the interface down with ifconfing command in $NS_TIMES times"
-	;;
-	2)
-	tst_resm TINFO "Verify the kernel is not crashed when IPv4 route is add by ip command then it is deleted by the interface down with ip command in $NS_TIMES times"
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
-	# Down then up the interface
-	case $test_type in
-	    1)
-	    ifconfig $lhost_ifname down && ifconfig $lhost_ifname up
-	    ;;
-	    2)
-	    ip link set down dev $lhost_ifname && ip link set up dev $lhost_ifname
-	    ;;
-	esac
-	if [ $? -ne 0 ]; then
-	    tst_resm TFAIL "Failed to down/up the interface"
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
diff --git a/testcases/network/stress/route/route6-ifdown b/testcases/network/stress/route/route6-ifdown
deleted file mode 100644
index 95d851ff9..000000000
--- a/testcases/network/stress/route/route6-ifdown
+++ /dev/null
@@ -1,259 +0,0 @@
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
-#   route6-ifdown
-#
-# Description:
-#   Verify the kernel is not crashed when IPv6 route is add then it is deleted
-#   by the interface down
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
-TCID=route6-ifdown
-TST_COUNT=0
-export TCID
-export TST_COUNT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# The number of times where route is add/delete
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
-DST_NETWORK="fec0:100:100:100"	# destination network
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
-# SET VALUES:
-#   rhost_ipv6addr	- IPv6 Address of the remote host
-#   lhost_ifname	- Interface name of the local host
-#   rhost_ifname	- Interface name of the remote host
-#
-#-----------------------------------------------------------------------
-do_setup()
-{
-    # Make sure to clean up
-    do_cleanup
-
-    # IP addres of the local host
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
-    TCID=route6-ifdown0${test_type}
-    TST_COUNT=$test_type
-
-    case $test_type in
-	1)
-	tst_resm TINFO "Verify the kernel is not crashed when IPv6 route is add by route command then it is deleted by the interface down with ifconfing command in $NS_TIMES times"
-	;;
-	2)
-	tst_resm TINFO "Verify the kernel is not crashed when IPv6 route is add by ip command then it is deleted by the interface down with ip command in $NS_TIMES times"
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
-	# Assign IPv6 address to the interface of the local host
-	add_ipv6addr lhost ${LINK_NUM} ${IPV6_NETWORK} ${LHOST_IPV6_HOST}
-	if [ $? -ne 0 ]; then
-	    tst_resm TBROK "Failed to assign an IPv6 address at the local host"
-	    return 1
-	fi
-
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
-	# Down then up the interface
-	case $test_type in
-	    1)
-	    ifconfig $lhost_ifname down && ifconfig $lhost_ifname up
-	    ;;
-	    2)
-	    ip link set down dev $lhost_ifname && ip link set up dev $lhost_ifname
-	    ;;
-	esac
-	if [ $? -ne 0 ]; then
-	    tst_resm TFAIL "Failed to down/up the interface"
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
2.16.2

