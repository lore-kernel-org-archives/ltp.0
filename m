From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 21 Jul 2017 06:04:04 +0200
Subject: [LTP] [RFC PATCH v7 08/11] network/stress: Fix and cleanup route
	IPv4 tests
In-Reply-To: <20170721040407.868-1-pvorel@suse.cz>
References: <20170721040407.868-1-pvorel@suse.cz>
Message-ID: <20170721040407.868-9-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Fix test for netns based testing (route4-change-if requires to have
  manually set another pair of interfaces).
* Remove rsh dependency.
* Create shell library route4-lib.sh (route IPv4 specific) to reduce
  duplicity in tests. Library uses test_stress_net.sh (and therefore test_net.sh).
* Stop using TST_COUNT, simplify TCID
* Cleanup code, fix typos, update doc.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/stress/ns-tools/initialize_if    |   3 -
 .../network/stress/ns-tools/test_net_stress.sh     |   9 +-
 testcases/network/stress/route/00_Descriptions.txt |  23 +-
 testcases/network/stress/route/route4-change-dst   | 283 ++---------------
 testcases/network/stress/route/route4-change-gw    | 302 ++----------------
 testcases/network/stress/route/route4-change-if    | 336 +++------------------
 testcases/network/stress/route/route4-ifdown       | 283 ++++-------------
 testcases/network/stress/route/route4-lib.sh       | 206 +++++++++++++
 testcases/network/stress/route/route4-redirect     | 220 +++-----------
 testcases/network/stress/route/route4-rmmod        | 314 +++++--------------
 testcases/network/stress/route/route6-change-dst   |   2 +-
 11 files changed, 480 insertions(+), 1501 deletions(-)
 create mode 100644 testcases/network/stress/route/route4-lib.sh

diff --git a/testcases/network/stress/ns-tools/initialize_if b/testcases/network/stress/ns-tools/initialize_if
index d64203e4c..23bf68bc0 100644
--- a/testcases/network/stress/ns-tools/initialize_if
+++ b/testcases/network/stress/ns-tools/initialize_if
@@ -69,9 +69,6 @@ fi
 # Define the interface name
 ifname=`get_ifname $host_type $link_num` || exit 1
 
-# Initialize the specified interface
-command="ifconfig $ifname down mtu 1500 ; ip route flush dev $ifname ; ip addr flush dev $ifname ; ifconfig $ifname up"
-
 if [ $host_type = lhost ]; then
     ( ifconfig $ifname down && \
     ip link set mtu 1500 dev $ifname && \
diff --git a/testcases/network/stress/ns-tools/test_net_stress.sh b/testcases/network/stress/ns-tools/test_net_stress.sh
index 5ab3304db..d112286bd 100644
--- a/testcases/network/stress/ns-tools/test_net_stress.sh
+++ b/testcases/network/stress/ns-tools/test_net_stress.sh
@@ -31,7 +31,6 @@ export TCID="${TCID:-$(basename $0)}"
 # Netmask of for the tested network
 IPV4_NETMASK="255.255.255.0"
 IPV4_NETMASK_NUM=24
-IPV4_BROADCAST=${IPV4_NET16_UNUSED}.0.255
 
 # Prefix of the Multicast Address
 MCAST_IPV4_ADDR_PREFIX="224.10"
@@ -64,16 +63,16 @@ netstress_cleanup()
 }
 
 # Set an IPv4 address on local/remote interface.
-# tst_add_ipaddr_stress [TYPE] [LINK] [IP]
+# tst_add_ipaddr_stress [TYPE] [IP] [LINK]
 # TYPE: { lhost | rhost }; Default value is 'lhost'.
-# LINK: link number starting from 0. Default value is '0'.
 # IP: IP address to be set; Default value is $LHOST_IPV4_UNUSED (for lhost)
 # or $RHOST_IPV4_UNUSED (for rhost).
+# LINK: link number starting from 0. Default value is '0'.
 tst_add_ipaddr_stress()
 {
 	local type="${1:-lhost}"
-	local link_num="${2:-0}"
-	local ip="${3:-}"
+	local ip="${2:-}"
+	local link_num="${3:-0}"
 	local mask=$IPV4_NETMASK_NUM
 	local iface=$(tst_iface $type $link_num)
 
diff --git a/testcases/network/stress/route/00_Descriptions.txt b/testcases/network/stress/route/00_Descriptions.txt
index 9bcbc5f05..3d3d26999 100644
--- a/testcases/network/stress/route/00_Descriptions.txt
+++ b/testcases/network/stress/route/00_Descriptions.txt
@@ -1,48 +1,47 @@
-route4-change-dst01
+route4-change-dst 1
 	Verify the kernel is not crashed when the destination of an IPv4 route
 	is changed frequently by route command
 
-route4-change-dst02
+route4-change-dst 2
 	Verify the kernel is not crashed when the destination of an IPv4 route
 	is changed frequently by ip command
 
-route4-change-gw01
+route4-change-gw 1
 	Verify the kernel is not crashed when the gateway of an IPv4 route is
 	changed frequently by route command
 
-route4-change-gw02
+route4-change-gw 2
 	Verify the kernel is not crashed when the gateway of an IPv4 route is
 	changed frequently by ip command
 
-route4-change-if01
+route4-change-if 1
 	Verify the kernel is not crashed when the interface of an IPv4 route is
 	changed frequently by route command
 
-route4-change-if02
+route4-change-if 2
 	Verify the kernel is not crashed when the interface of an IPv4 route is
 	changed frequently by ip command
 
-route4-redirect01
+route4-redirect 1
 	Verify the kernel is not crashed when the IPv4 route is modified by
 	ICMP Redirects frequently
 
-route4-ifdown01
+route4-ifdown 1
 	Verify the kernel is not crashed when IPv4 route is add by route command
 	then it is deleted by the interface down with ifconfig command
 
-route4-ifdown02
+route4-ifdown 2
 	Verify the kernel is not crashed when IPv4 route is add by ip command
 	then it is deleted by the interface down with ip command
 
-route4-rmmod01
+route4-rmmod 1
 	Verify the kernel is not crashed when IPv4 route is add by route command
 	then it is deleted by the removing network driver
 
-route4-rmmod02
+route4-rmmod 2
 	Verify the kernel is not crashed when IPv4 route is add by ip command
 	then it is deleted by the removing network driver
 
-
 route6-change-dst01
 	Verify the kernel is not crashed when the destination of an IPv6 route
 	is changed frequently by route command
diff --git a/testcases/network/stress/route/route4-change-dst b/testcases/network/stress/route/route4-change-dst
index 3c85555be..89a925715 100644
--- a/testcases/network/stress/route/route4-change-dst
+++ b/testcases/network/stress/route/route4-change-dst
@@ -1,276 +1,43 @@
 #!/bin/sh
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
+# Copyright (c) International Business Machines  Corp., 2006
+# Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
 #
-# File:
-#   route4-change-dst
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
-# Description:
-#   Verify the kernel is not crashed when the destination of an IPv4 route is
-#   changed frequently
-#    test01 - by route command
-#    test02 - by ip command
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
 #
-# Setup:
-#   See ltp-yyyymmdd/testcases/network/stress/README
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
 #
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
+# Verify the kernel is not crashed when the destination of an IPv4 route is
+# changed frequently.
 #
-# History:
-#	Mar 16 2006 - Created (Mitsuru Chinen)
+# Setup: testcases/network/stress/README
 #
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../ ; pwd)`}
-export LTPROOT
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
-# Total number of the test case
 TST_TOTAL=2
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
 
-# Netmask of for the tested network
-IPV4_NETMASK="255.255.255.0"
-IPV4_NETMASK_NUM=24
+. route4-lib.sh
 
-# Broadcast address of the tested network
-IPV4_BROADCAST=${IPV4_NETWORK}.255
+TST_CLEANUP="netstress_cleanup"
 
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
 do_setup()
 {
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
+	route_setup
+	tst_add_ipaddr_stress rhost $RHOST_IPV4_UNUSED
 }
 
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
-	    tst_resm TFAIL "Cannot delte the route to ${ADDDEL_ROUTE}"
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
 do_setup
-test_body 1 || RC=`expr $RC + 1`      # Case of route command
-test_body 2 || RC=`expr $RC + 1`      # Case of ip command
-do_cleanup
 
-exit $RC
+for cmd_name in rt_cmd ip_cmd; do
+	route_test_change "dst" $cmd_name
+done
+
+tst_exit
diff --git a/testcases/network/stress/route/route4-change-gw b/testcases/network/stress/route/route4-change-gw
index a9a91cca6..9801d0906 100644
--- a/testcases/network/stress/route/route4-change-gw
+++ b/testcases/network/stress/route/route4-change-gw
@@ -1,292 +1,52 @@
 #!/bin/sh
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
+# Copyright (c) International Business Machines  Corp., 2006
+# Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
 #
-# File:
-#   route4-change-gw
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
-# Description:
-#   Verify the kernel is not crashed when the gateway of an IPv4 route is
-#   changed frequently
-#    test01 - by route command
-#    test02 - by ip command
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
 #
-# Setup:
-#   See ltp-yyyymmdd/testcases/network/stress/README
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
 #
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
+# Verify the kernel is not crashed when the gateway of an IPv4 route is
+# changed frequently.
 #
-# History:
-#	Mar 16 2006 - Created (Mitsuru Chinen)
+# Setup: testcases/network/stress/README
 #
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../ ; pwd)`}
-export LTPROOT
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
-# Total number of the test case
 TST_TOTAL=2
-export TST_TOTAL
-
-# Default of the test case ID and the test case count
-TCID=route4-change-gw
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
 
-# Netmask of for the tested network
-IPV4_NETMASK_NUM=24
+. route4-lib.sh
 
-# Broadcast address of the tested network
-IPV4_BROADCAST=${IPV4_NETWORK}.255
+TST_CLEANUP="netstress_cleanup"
 
-# Host portion of the IPv4 address
-LHOST_IPV4_HOST=${LHOST_IPV4_HOST:-"1"}	# src
-RHOST_IPV4_HOST_TOP="10"	# gateway
-RHOST_IPV4_HOST_LAST=19
+RHOST_IPV4_HOST_TOP=${RHOST_IPV4_HOST_TOP:-10} # gateway
+RHOST_IPV4_HOST_LAST=${RHOST_IPV4_HOST_LAST:-19}
 
-# The destination network
-DST_NETWORK="10.10.0"	# destination network would be 10.10.0.0/24
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
 do_setup()
 {
-    TCID=route4-change-gw
-    TST_COUNT=0
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
-
-    # Initialize the interfaces of the remote host
-    initialize_if rhost ${LINK_NUM}
-
-    # Set IPv4 address to the interface of the remote host
-    rhost_part=$RHOST_IPV4_HOST_TOP
-    while [ $rhost_part -le $RHOST_IPV4_HOST_LAST ]; do
-	ret=`$LTP_RSH $RHOST '( PATH=/sbin:/usr/sbin:$PATH ; ip addr add '${IPV4_NETWORK}.${rhost_part}/${IPV4_NETMASK_NUM}' broadcast '${IPV4_NETWORK}'.255 dev '$rhost_ifname' ) > /dev/null ; echo $?'`
-	if [ $ret -ne 0 ]; then
-	    tst_resm TBROK "Failed to assign IP address to the interface at the remote host"
-	    exit $TST_TOTAL
-	fi
-	rhost_part=`expr $rhost_part + 1`
-    done
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
-    killall -SIGHUP ns-udpsender >/dev/null 2>&1
-
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
-    TCID=route4-change-gw0${test_type}
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
-    tst_resm TINFO "Verify the kernel is not crashed when the gateway of an IPv4 route is changed frequently by $test_command command in $NS_TIMES times"
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
-
-    # Check the connectivity to the gateway
-    rhost_part=$RHOST_IPV4_HOST_TOP
-    check_icmpv4_connectivity $lhost_ifname ${IPV4_NETWORK}.${rhost_part}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Test Link $LINK_NUM is somthing wrong."
-	return 1
-    fi
+	local rhost_part=$RHOST_IPV4_HOST_TOP
 
-    # Set the variables regarding the destination host
-    dst_addr=${DST_NETWORK}.${DST_HOST}
-    dst_network=${DST_NETWORK}.0
+	route_setup
 
-    # Set the first route
-    case $test_type in
-	1)
-	route add -net $dst_network netmask 255.255.255.0 gw ${IPV4_NETWORK}.${rhost_part} dev $lhost_ifname
-	;;
-	2)
-	ip route add ${dst_network}/24 via ${IPV4_NETWORK}.${rhost_part} dev $lhost_ifname
-	;;
-    esac
-
-    # Load the route with UDP traffic
-    ns-udpsender -f 4 -D $dst_addr -p $DST_PORT -b -s 1472
-    if [ $? -ne 0 ]; then
-	tst_resm TFAIL "Failed to run a UDP datagram sender"
-	return 1
-    fi
-
-    # Loop for changing the route
-    cnt=0
-    while [ $cnt -lt $NS_TIMES ]; do
-	pre_rhost_part=$rhost_part
-	rhost_part=`expr $rhost_part + 1`
-	if [ $rhost_part -gt $RHOST_IPV4_HOST_LAST ]; then
-	    rhost_part=$RHOST_IPV4_HOST_TOP
-	fi
-
-	case $test_type in
-	    1)
-	    route add -net $dst_network netmask 255.255.255.0 gw ${IPV4_NETWORK}.${rhost_part} dev $lhost_ifname
-	    route del -net $dst_network netmask 255.255.255.0 gw ${IPV4_NETWORK}.${pre_rhost_part} dev $lhost_ifname
-	    ;;
-	    2)
-	    ip route change ${dst_network}/24 via ${IPV4_NETWORK}.${rhost_part} dev $lhost_ifname
-	    ;;
-	esac
-	if [ $? -ne 0 ]; then
-	    tst_resm TFAIL "Failed to change the gateway to ${IPV4_NETWORK}.${rhost_part}"
-	    return 1
-	fi
-
-	# Rerun if udp datagram sender is dead
-	ps auxw | fgrep -v grep | grep ns-udpsender > /dev/null
-	if [ $? -ne 0 ]; then
-	    ns-udpsender -f 4 -D $dst_addr -p $DST_PORT -b -s 1472
-	    if [ $? -ne 0 ]; then
-		tst_resm TFAIL "Failed to run a UDP datagram sender"
-		return 1
-	    fi
-	fi
-
-	cnt=`expr $cnt + 1`
-    done
-
-    # Kill the udp datagram sender
-    killall -SIGHUP ns-udpsender >/dev/null 2>&1
-
-    tst_resm TPASS "Test is finished correctly."
-    return 0
+	while [ $rhost_part -le $RHOST_IPV4_HOST_LAST ]; do
+		tst_add_ipaddr_stress rhost ${IPV4_NET16_UNUSED}.${OCTET_3_IPV4_UNUSED}.${rhost_part}
+		rhost_part=$(($rhost_part + 1))
+	done
 }
 
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
 do_setup
-test_body 1 || RC=`expr $RC + 1`      # Case of route command
-test_body 2 || RC=`expr $RC + 1`      # Case of ip command
-do_cleanup
 
-exit $RC
+for cmd_name in rt_cmd ip_cmd; do
+	route_test_change "gw" $cmd_name
+done
+
+tst_exit
diff --git a/testcases/network/stress/route/route4-change-if b/testcases/network/stress/route/route4-change-if
index 33fc3755c..0b2c8ac2d 100644
--- a/testcases/network/stress/route/route4-change-if
+++ b/testcases/network/stress/route/route4-change-if
@@ -1,324 +1,72 @@
 #!/bin/sh
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
+# Copyright (c) International Business Machines  Corp., 2006
+# Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
 #
-# File:
-#   route4-change-if
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
-# Description:
-#   Verify the kernel is not crashed when the interface of an IPv4 route is
-#   changed frequently
-#    test01 - by route command
-#    test02 - by ip command
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
 #
-# Setup:
-#   See ltp-yyyymmdd/testcases/network/stress/README
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
 #
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
+# Verify the kernel is not crashed when the interface of an IPv4 route is
+# changed frequently.
 #
-# History:
-#	Mar 17 2006 - Created (Mitsuru Chinen)
+# Setup: testcases/network/stress/README
 #
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../ ; pwd)`}
-export LTPROOT
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
-# Total number of the test case
 TST_TOTAL=2
-export TST_TOTAL
-
-# Default of the test case ID and the test case count
-TCID=route4-change-if
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
-# The first 2 ocnted of the Network portion of the gateway address
-IPV4_NETWORK_PRE=${IPV4_NETWORK_PRE:-"10.0"}
 
-# Netmask of for the gateway
-IPV4_NETMASK_NUM=24
+. route4-lib.sh
 
-# Host portion of the IPv4 address
-LHOST_IPV4_HOST=${LHOST_IPV4_HOST:-"2"}	# src
-RHOST_IPV4_HOST=${RHOST_IPV4_HOST:-"1"}	# gateway
+TST_CLEANUP="do_cleanup"
 
-# The destination network
-DST_NETWORK="10.10.0"	# destination network would be 10.10.0.0/24
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
 do_setup()
 {
-    TCID=route4-change-if
-    TST_COUNT=0
+	local link_num=0
+	local lhost_ip rhost_ip
 
-    # Get the number of the test links
-    link_total=`echo $LHOST_HWADDRS | wc -w`
-    rhost_link_total=`echo $RHOST_HWADDRS | wc -w`
-    if [ $link_total -ne $rhost_link_total ]; then
-	tst_resm TBROK "The number of element in LHOST_HWADDRS differs from RHOST_HWADDRS"
-	exit $TST_TOTAL
-    fi
-    if [ $link_total -lt 2 ]; then
-	tst_resm TBROK "This test case requires plural Test Links"
-	exit $TST_TOTAL
-    fi
+	route_setup
 
-    lhost_ifname_array=""
-    rhost_ifname_array=""
-    link_num=0
-    while [ $link_num -lt $link_total ]; do
-	# Get the Interface names of the local host
-	lhost_ifname=`get_ifname lhost ${link_num}`
-	if [ $? -ne 0 ]; then
-	    tst_resm TBROK "Failed to get the interface name at the local host"
-	    exit $TST_TOTAL
-	fi
-	lhost_ifname_array="$lhost_ifname_array $lhost_ifname"
+	[ $LINK_TOTAL -lt 2 ] && \
+		tst_brkm TCONF "this test case requires more than one test link in LHOST_HWADDRS variable"
 
-	# Get the Interface names of the remote host
-	rhost_ifname=`get_ifname rhost ${link_num}`
-	if [ $? -ne 0 ]; then
-	    tst_resm TBROK "Failed to get the interface name at the remote host"
-	    exit $TST_TOTAL
-	fi
-	rhost_ifname_array="$rhost_ifname_array $rhost_ifname"
+	while [ $link_num -lt $LINK_TOTAL ]; do
+		lhost_ip="${IPV4_NET16_UNUSED}.${link_num}.${OCTET_4_LHOST_IPV4_HOST_UNUSED}"
+		rhost_ip="${IPV4_NET16_UNUSED}.${link_num}.${OCTET_4_RHOST_IPV4_HOST_UNUSED}"
 
-	# Initialize the interfaces of the remote host
-	initialize_if rhost ${link_num}
+		tst_add_ipaddr_stress lhost $lhost_ip $link_num
+		tst_add_ipaddr_stress rhost $rhost_ip $link_num
 
-	# Set IPv4 address to the interface of the remote host
-	set_ipv4addr rhost ${link_num} "${IPV4_NETWORK_PRE}.${link_num}" ${RHOST_IPV4_HOST}
-	if [ $? -ne 0 ]; then
-	    tst_resm TBROK "Failed to assign IP address to the interface $rhost_ifname at the remote host"
-	    exit $TST_TOTAL
-	fi
+		check_connectivity $(tst_iface lhost $link_num) $rhost_ip
 
-	link_num=`expr $link_num + 1`
-    done
+		link_num=$(($link_num + 1))
+	done
 }
 
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
 do_cleanup()
 {
-    # Make sure to kill the udp datagram sender
-    killall -SIGHUP ns-udpsender >/dev/null 2>&1
-
-    # Initialize the interfaces
-    link_num=0
-    while [ $link_num -lt $link_total ]; do
-	initialize_if lhost ${link_num}
-	initialize_if rhost ${link_num}
-	link_num=`expr $link_num + 1`
-    done
-}
+	local link_num=0
 
+	route_cleanup
 
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
-    TCID=route4-change-if0${test_type}
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
-    tst_resm TINFO "Verify the kernel is not crashed when the interface of an IPv4 route is changed frequently by $test_command command in $NS_TIMES times"
-
-    link_num=0
-    while [ $link_num -lt $link_total ]; do
-	# Initialize the interface of the local host
-	initialize_if lhost ${link_num}
-
-	# Assign IPv4 address to the interface of the local host
-	set_ipv4addr lhost ${link_num} "${IPV4_NETWORK_PRE}.${link_num}" ${LHOST_IPV4_HOST}
-	if [ $? -ne 0 ]; then
-	    tst_resm TBROK "Failed to assign an IPv4 address at the local host"
-	    return 1
-	fi
-
-	# Check the connectivity to the gateway
-	field=`expr $link_num + 1`
-	lhost_ifname=`echo $lhost_ifname_array | cut -d ' ' -f $field`
-	check_icmpv4_connectivity $lhost_ifname "${IPV4_NETWORK_PRE}.${link_num}.${LHOST_IPV4_HOST}"
-	if [ $? -ne 0 ]; then
-	    tst_resm TBROK "Test Link $link_num is somthing wrong."
-	    return 1
-	fi
-	link_num=`expr $link_num + 1`
-    done
-
-    # Set the variables regarding the destination host
-    dst_addr=${DST_NETWORK}.${DST_HOST}
-    dst_network=${DST_NETWORK}.0
-
-    # Set the first route
-    link_num=0
-    field=`expr $link_num + 1`
-    lhost_ifname=`echo $lhost_ifname_array | cut -d ' ' -f $field`
-    gateway="${IPV4_NETWORK_PRE}.${link_num}.${RHOST_IPV4_HOST}"
-    case $test_type in
-	1)
-	route add -net $dst_network netmask 255.255.255.0 gw $gateway dev $lhost_ifname
-	;;
-	2)
-	ip route add ${dst_network}/24 via $gateway dev $lhost_ifname
-	;;
-    esac
-
-    # Load the route with UDP traffic
-    ns-udpsender -f 4 -D $dst_addr -p $DST_PORT -b -s 1472
-    if [ $? -ne 0 ]; then
-	tst_resm TFAIL "Failed to run a UDP datagram sender"
-	return 1
-    fi
-
-    # Loop for changing the route
-    cnt=0
-    while [ $cnt -lt $NS_TIMES ]; do
-	link_num=`expr $link_num + 1`
-	if [ $link_num -ge $link_total ]; then
-	    link_num=0
-	fi
-
-	pre_lhost_ifname=$lhost_ifname
-	pre_gateway=$gateway
-
-	field=`expr $link_num + 1`
-	lhost_ifname=`echo $lhost_ifname_array | cut -d ' ' -f $field`
-	gateway="${IPV4_NETWORK_PRE}.${link_num}.${RHOST_IPV4_HOST}"
-
-	case $test_type in
-	    1)
-	    route add -net $dst_network netmask 255.255.255.0 gw $gateway dev $lhost_ifname
-	    route del -net $dst_network netmask 255.255.255.0 gw $pre_gateway dev $pre_lhost_ifname
-	    ;;
-	    2)
-	    ip route change ${dst_network}/24 via $gateway dev $lhost_ifname
-	    ;;
-	esac
-	if [ $? -ne 0 ]; then
-	    tst_resm TFAIL "Failed to change the gateway to $gateway"
-	    return 1
-	fi
-
-	# Rerun if udp datagram sender is dead
-	ps auxw | fgrep -v grep | grep ns-udpsender > /dev/null
-	if [ $? -ne 0 ]; then
-	    ns-udpsender -f 4 -D $dst_addr -p $DST_PORT -b -s 1472
-	    if [ $? -ne 0 ]; then
-		tst_resm TFAIL "Failed to run a UDP datagram sender"
-		return 1
-	    fi
-	fi
-
-	cnt=`expr $cnt + 1`
-    done
-
-    # Kill the udp datagram sender
-    killall -SIGHUP ns-udpsender
-
-    tst_resm TPASS "Test is finished correctly."
-    return 0
+	while [ $link_num -lt $LINK_TOTAL ]; do
+		restore_ipaddr lhost $link_num
+		restore_ipaddr rhost $link_num
+		link_num=$(($link_num + 1))
+	done
 }
 
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
 do_setup
-test_body 1 || RC=`expr $RC + 1`      # Case of route command
-test_body 2 || RC=`expr $RC + 1`      # Case of ip command
-do_cleanup
+for cmd_name in rt_cmd ip_cmd; do
+	route_test_change "if" $cmd_name
+done
 
-exit $RC
+tst_exit
diff --git a/testcases/network/stress/route/route4-ifdown b/testcases/network/stress/route/route4-ifdown
index e7ce1b4fe..60d19babb 100644
--- a/testcases/network/stress/route/route4-ifdown
+++ b/testcases/network/stress/route/route4-ifdown
@@ -1,261 +1,80 @@
 #!/bin/sh
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
+# Copyright (c) International Business Machines  Corp., 2006
+# Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
 #
-# Description:
-#   Verify the kernel is not crashed when IPv4 route is add then it is deleted
-#   by the interface down
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
-# Setup:
-#   See ltp-yyyymmdd/testcases/network/stress/README
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
 #
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
 #
-# History:
-#	Apr 8 2006 - Created (Mitsuru Chinen)
+# Setup: testcases/network/stress/README
 #
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../ ; pwd)`}
-export LTPROOT
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
-# Total number of the test case
 TST_TOTAL=2
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
 
-# The destination network
-DST_NETWORK="10.10.10"	# destination network would be 10.10.10.0/24
-DST_HOST="5"
-DST_PORT="7"
+. route4-lib.sh
 
+TST_CLEANUP="netstress_cleanup"
 
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
 do_setup()
 {
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
+	route_setup
 
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
+	tst_add_ipaddr_stress
+	tst_add_ipaddr_stress rhost
 }
 
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
 test_body()
 {
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
+	local cmd_type=$1
+	local cmd_name_iface cmd_iface_down
+	local cmd_name_route="$(get_cmd $cmd_type)"
+	local lhost_ifname="$(tst_iface)"
+	local dst_addr="${DST_NETWORK}.${DST_HOST}"
+	local dst_network="${DST_NETWORK}.0"
+	local cnt=0
+
+	if [ "$cmd_type" = 'rt_cmd' ]; then
+		cmd_name_iface='ifconfig'
+		cmd_iface_down="$cmd_name_iface $lhost_ifname down && ifconfig $lhost_ifname up"
+	else
+		cmd_name_iface=$cmd_name_route
+		cmd_iface_down="$cmd_name_iface link set down dev $lhost_ifname && ip link set up dev $lhost_ifname"
 	fi
 
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
+	tst_resm TINFO "IPv4 route is added and deleted by '$cmd_name_route' command $NS_TIMES times"
 
-	# Load the route with UDP datagram
-	ns-udpsender -f 4 -D $dst_addr -p $DST_PORT -o -s 1472
-	if [ $? -ne 0 ]; then
-	    tst_resm TFAIL "Failed to run a UDP datagram sender"
-	    return 1
-	fi
+	while [ $cnt -lt $NS_TIMES ]; do
+		make_background_tcp_traffic $LHOST_IPV4_UNUSED
 
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
+		manipulate_route $cmd_name_route 'add' $dst_network $IPV4_NETMASK_NUM $IPV4_NETMASK $RHOST_IPV4_UNUSED $lhost_ifname
 
-	cnt=`expr $cnt + 1`
-    done
+		check_connectivity_interval $cnt false $lhost_ifname $RHOST_IPV4_UNUSED
 
-    tst_resm TPASS "Test is finished correctly."
-    return 0
-}
+		# Down then up the interface
+		sh -c "$cmd_iface_down"
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL "failed to down/up the interface"
+			return
+		fi
 
+		cnt=$(($cnt + 1))
+	done
 
-#-----------------------------------------------------------------------
-#
-# Main
-#
-# Exit Value:
-#   The number of the failure
-#
-#-----------------------------------------------------------------------
+	tst_resm TPASS "test is finished correctly"
+}
 
-RC=0
 do_setup
-test_body 1 || RC=`expr $RC + 1`      # Case of route command
-test_body 2 || RC=`expr $RC + 1`      # Case of ip command
-do_cleanup
+test_body 'rt_cmd'
+test_body 'ip_cmd'
 
-exit $RC
+tst_exit
diff --git a/testcases/network/stress/route/route4-lib.sh b/testcases/network/stress/route/route4-lib.sh
new file mode 100644
index 000000000..1f0047f68
--- /dev/null
+++ b/testcases/network/stress/route/route4-lib.sh
@@ -0,0 +1,206 @@
+#!/bin/sh
+# Copyright (c) International Business Machines  Corp., 2006
+# Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
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
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
+#
+# Setup script for route4-* tests.
+#
+# More information about network parameters can be found
+# in the following document: testcases/network/stress/README
+#
+# Author: Petr Vorel <pvorel@suse.cz>
+
+. test_net_stress.sh
+
+tst_check_cmds ip pgrep route
+
+CHECK_INTERVAL=${CHECK_INTERVAL:-$(($NS_TIMES / 20))}
+
+# The destination network
+# NOTE: DST_NETWORK expects NETMASK IPV4_NETMASK_NUM=24
+DST_NETWORK="${IPV4_NET16_UNUSED}.${OCTET_3_IPV4_UNUSED}"
+DST_HOST=5
+DST_PORT=7
+
+route_cleanup()
+{
+	netstress_cleanup
+	restore_ipaddr
+	restore_ipaddr rhost
+}
+
+route_ns_udpsender_cleanup()
+{
+	stop_ns_udpsender
+	restore_ipaddr
+	restore_ipaddr rhost
+}
+
+route_setup()
+{
+	netstress_setup
+	tst_check_cmds route
+	route_cleanup
+}
+
+manipulate_route()
+{
+	local cmd_name=$1
+	local task=$2
+	local network=$3
+	local prefix=$4
+	local netmask=$5
+	local gateway=$6
+	local ifname=$7
+
+	[ "$task" = "add" ] || [ "$task" = "del" ] || \
+		[ "$cmd_name" = "ip" -a "$task" = "append" ] || tst_brkm TBROK "wrong task: '$task'"
+
+	[ "$cmd_name" = "ip" -a "$task" = "add" ] && task="append"
+	if [ "$cmd_name" = "ip" ]; then
+		ROD "$cmd_name route $task $network/$prefix via $gateway dev $ifname"
+	else
+		ROD "$cmd_name $task -net $network netmask $netmask gw $gateway dev $ifname"
+	fi
+}
+
+# Load the route with UDP traffic.
+run_ns_udpsender()
+{
+	local dst_addr=$1
+	local run_in_background=$2
+	local udp_size="${3:-1472}"
+	local params="-o"
+
+	if [ "$run_in_background" = true ]; then
+		# daemon is already running
+		pgrep -x ns-udpsender > /dev/null && return 0
+		params="-b"
+	fi
+
+	ROD ns-udpsender -f 4 -D $dst_addr -p $DST_PORT -s $udp_size $params
+}
+
+stop_ns_udpsender()
+{
+	local type="${1:-lhost}"
+	kill_daemon ns-udpsender $type
+}
+
+get_cmd()
+{
+	local cmd_type=$1
+
+	case $cmd_type in
+	rt_cmd) echo 'route' ;;
+	ip_cmd) echo 'ip' ;;
+	*) tst_brkm TBROK "Unknown test parameter '$cmd_type'"
+	esac
+}
+
+route_test_change()
+{
+	local test_field=$1
+	local cmd_type=$2
+
+	local rhost_ip="$RHOST_IPV4_UNUSED"
+	local lhost_ifname=$(tst_iface)
+	local rhost_part_first=$RHOST_IPV4_HOST_TOP
+	local rhost_part_last=$RHOST_IPV4_HOST_LAST
+	local cnt=0
+	local link_num=0
+	local first_route_net=${DST_NETWORK}.0
+	local cmd_name="$(get_cmd $cmd_type)"
+	local gateway="$rhost_ip"
+	local dst_addr dst_network dst_network_postfix gateway2 lhost_ifname2 rhost_part test_field_name
+
+	case $test_field in
+	dst) test_field_name='destination' ;;
+	gw) test_field_name='gateway' ;;
+	if) test_field_name='interface' ;;
+	*) tst_brkm TBROK "Unknown test parameter '$test_field'"
+	esac
+
+	tst_resm TINFO "the $test_field_name of an IPv4 route is changed by '$cmd_name' command $NS_TIMES times"
+
+	if [ "$test_field" = "if" ]; then
+		while [ $link_num -lt $LINK_TOTAL ]; do
+			rhost_ip="${IPV4_NET16_UNUSED}.${link_num}.${OCTET_4_RHOST_IPV4_HOST_UNUSED}"
+			check_connectivity $(tst_iface lhost $link_num) $rhost_ip
+			link_num=$(($link_num + 1))
+		done
+		link_num=0
+		lhost_ifname="$(tst_iface lhost $link_num)"
+		gateway="${IPV4_NET16_UNUSED}.${link_num}.${RHOST_IPV4_HOST}"
+	else
+		if [ "$test_field" = "gw" ]; then
+			rhost_ip="${IPV4_NET16_UNUSED}.${OCTET_3_IPV4_UNUSED}.$RHOST_IPV4_HOST_TOP"
+			rhost_part=$rhost_part_first
+			gateway="${IPV4_NET16_UNUSED}.${OCTET_3_IPV4_UNUSED}.${rhost_part}"
+		fi
+		tst_add_ipaddr_stress
+		check_connectivity $(tst_iface) $rhost_ip
+	fi
+
+	if [ "$test_field" != "dst" ]; then
+		dst_addr=${DST_NETWORK}.${DST_HOST}
+		dst_network=$first_route_net
+
+		tst_resm TINFO "adding first route"
+		ROD manipulate_route $cmd_name 'add' $first_route_net $IPV4_NETMASK_NUM $IPV4_NETMASK $gateway $lhost_ifname
+	fi
+
+	while [ $cnt -lt $NS_TIMES ]; do
+		lhost_ifname2="$lhost_ifname"
+		gateway2="$gateway"
+
+		make_background_tcp_traffic $LHOST_IPV4_UNUSED
+
+		if [ "$test_field" = "dst" ]; then
+			dst_network_postfix="$(($cnt % 255))"
+			dst_addr="${IPV4_NET16_UNUSED}.${dst_network_postfix}.${DST_HOST}"
+			dst_network="${IPV4_NET16_UNUSED}.${dst_network_postfix}.0"
+		elif [ "$test_field" = "gw" ]; then
+			pre_rhost_part=$rhost_part
+			rhost_part=$(($rhost_part + 1))
+			[ $rhost_part -gt $rhost_part_last ] && rhost_part=$rhost_part_first
+			gateway="${IPV4_NET16_UNUSED}.${OCTET_3_IPV4_UNUSED}.${rhost_part}"
+			gateway2="${IPV4_NET16_UNUSED}.${OCTET_3_IPV4_UNUSED}.${pre_rhost_part}"
+		elif [ "$test_field" = "if" ]; then
+			link_num=$(($link_num + 1))
+			[ $link_num -ge $LINK_TOTAL ] && link_num=0
+			lhost_ifname="$(tst_iface lhost $link_num)"
+			gateway="${IPV4_NET16_UNUSED}.${link_num}.${RHOST_IPV4_HOST}"
+			rhost_ip="${IPV4_NET16_UNUSED}.${link_num}.${OCTET_4_RHOST_IPV4_HOST_UNUSED}"
+		fi
+
+		manipulate_route $cmd_name 'add' $dst_network $IPV4_NETMASK_NUM $IPV4_NETMASK $gateway $lhost_ifname
+		manipulate_route $cmd_name 'del' $dst_network $IPV4_NETMASK_NUM $IPV4_NETMASK $gateway2 $lhost_ifname2
+
+		check_connectivity_interval $cnt false $lhost_ifname $rhost_ip || return
+
+		cnt=$(($cnt + 1))
+	done
+
+	if [ "$test_field" != "dst" ]; then
+		ROD manipulate_route $cmd_name del $first_route_net $IPV4_NETMASK_NUM $IPV4_NETMASK $gateway $lhost_ifname
+	fi
+
+	if [ "$test_field" != "if" ]; then
+		restore_ipaddr
+	fi
+
+	tst_resm TPASS "test is finished correctly"
+}
diff --git a/testcases/network/stress/route/route4-redirect b/testcases/network/stress/route/route4-redirect
index 9eb8a4624..714e0af25 100644
--- a/testcases/network/stress/route/route4-redirect
+++ b/testcases/network/stress/route/route4-redirect
@@ -1,212 +1,72 @@
 #!/bin/sh
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
+# Copyright (c) International Business Machines  Corp., 2006
+# Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
 #
-# File:
-#   route4-redirect
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
-# Description:
-#   Verify the kernel is not crashed when the IPv4 route is modified by
-#   ICMP Redirects frequently
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
 #
-# Setup:
-#   See ltp-yyyymmdd/testcases/network/stress/README
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
 #
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
+# Verify the kernel is not crashed when the IPv4 route is modified by
+# ICMP Redirects frequently.
 #
-# History:
-#	Apr 07 2006 - Created (Mitsuru Chinen)
+# Setup: testcases/network/stress/README
 #
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
-# The test case ID, the test case count and the total number of test case
-TCID=route4-redirect01
 TST_TOTAL=1
-TST_COUNT=1
-export TCID
-export TST_COUNT
-export TST_TOTAL
-
-# Test description
-tst_resm TINFO "Verify the kernel is not crashed when the IPv4 route is modified by  ICMP Redirects frequently"
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../.. ; pwd)`}
-export LTPROOT
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
-IPV4_NETMASK_NUM=24
 
-# Broadcast address of the tested network
-IPV4_BROADCAST=${IPV4_NETWORK}.255
+. route4-lib.sh
 
-# Host portion of the IPv4 address
-LHOST_IPV4_HOST=${LHOST_IPV4_HOST:-"1"}	# src
-RHOST_IPV4_HOST="2"	# gateway
+TST_CLEANUP="do_cleanup"
 
-# The destination network
-DST_NETWORK="10.10.0"   # destination network would be 10.10.0.0/24
-DST_HOST="5"
-DST_PORT="7"
+SYSFS_ACCEPT_REDIRECTS=
+SYSFS_SECURE_REDIRECTS=
 
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
 do_cleanup()
 {
-    # Kill the redirector utility
-    $LTP_RSH $RHOST killall -SIGHUP ns-icmp_redirector >/dev/null 2>&1
-
-    # Initialize the interfaces
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
+	route_ns_udpsender_cleanup
+	kill_daemon ns-icmp_redirector remote
+	[ -n "$SYSFS_ACCEPT_REDIRECTS" ] && sysctl -qw net.ipv4.conf.$(tst_iface).accept_redirects=$SYSFS_ACCEPT_REDIRECTS
+	[ -n "$SYSFS_SECURE_REDIRECTS" ] && sysctl -qw net.ipv4.conf.$(tst_iface).secure_redirects=$SYSFS_SECURE_REDIRECTS
 }
 
-
-#-----------------------------------------------------------------------
-#
-# NAME:
-#   do_setup
-#
-# DESCRIPTION:
-#   Set the initial route and start icmp redirect on the remote host
-#
-# SET VALUES:
-#   rhost_ipv4addr      - IPv4 Address of the remote host
-#   lhost_ifname        - Interface name of the local host
-#   rhost_ifname        - Interface name of the remote host
-#
-#-----------------------------------------------------------------------
 do_setup()
 {
-    # Make sure to clean up
-    do_cleanup
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
+	route_setup
 
-    # Remove the link-local address of the remote host
-    sleep 3
-    $LTP_RSH $RHOST "ip addr flush dev $rhost_ifname" > /dev/null
+	SYSFS_ACCEPT_REDIRECTS=$(sysctl -b net.ipv4.conf.$(tst_iface).accept_redirects)
+	SYSFS_SECURE_REDIRECTS=$(sysctl -b net.ipv4.conf.$(tst_iface).secure_redirects)
 
-    # Assign IPv4 address to the interface of the local host
-    set_ipv4addr lhost ${LINK_NUM} ${IPV4_NETWORK} ${LHOST_IPV4_HOST}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to assign an IPv4 address at the local host"
-	return 1
-    fi
+	tst_add_ipaddr_stress
 
-    # Add route to the initial gateway
-    route add -net ${DST_NETWORK}.0 netmask 255.255.255.0 gw ${IPV4_NETWORK}.${RHOST_IPV4_HOST} dev $lhost_ifname
+	tst_resm TINFO "add route to the initial gateway"
+	ROD manipulate_route "route" "add" ${DST_NETWORK}.0 $IPV4_NETMASK_NUM $IPV4_NETMASK $RHOST_IPV4_UNUSED $(tst_iface)
 
-    # Make sure the sysctl value is set for accepting the redirect
-    sysctl -w net.ipv4.conf.${lhost_ifname}.accept_redirects=1 >/dev/null
-    sysctl -w net.ipv4.conf.${lhost_ifname}.secure_redirects=0 >/dev/null
-
-    # Run the redirector utility at the remote host
-    ret=`$LTP_RSH $RHOST "${LTPROOT}/testcases/bin/ns-icmp_redirector -I $rhost_ifname -b ; "'echo $?'`
-    if [ $ret -ne 0 ]; then
-	tst_resm TBROK "Failed to run icmp redirector at the remote host"
-	exit $TST_TOTAL
-    fi
+	# Run the redirector utility at the remote host
+	tst_rhost_run -s -c "ns-icmp_redirector -I $(tst_iface rhost) -b"
 }
 
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
-#   None
-#
-#-----------------------------------------------------------------------
 test_body()
 {
-    # Loop for changing the route
-    cnt=0
-    while [ $cnt -lt $NS_TIMES ]; do
-	ns-udpsender -f 4 -D ${DST_NETWORK}.${DST_HOST} -p $DST_PORT -o -s 8
-	if [ $? -ne 0 ]; then
-	    tst_resm TBROK "Failed to run udp packet sender"
-	    return 1
-	fi
-	cnt=`expr $cnt + 1`
-    done
+	local cnt=0
+	while [ $cnt -lt $NS_TIMES ]; do
+		run_ns_udpsender ${DST_NETWORK}.${DST_HOST} no 8
+		cnt=$(($cnt + 1))
+	done
 
-    tst_resm TPASS "Test is finished correctly."
-    return 0
+	tst_resm TPASS "test is finished correctly"
 }
 
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-# Exit Value:
-#   The number of the failure
-#
-#-----------------------------------------------------------------------
-RC=0
 do_setup
-test_body || RC=`expr $RC + 1`
-do_cleanup
+test_body
 
-exit $RC
+tst_exit
diff --git a/testcases/network/stress/route/route4-rmmod b/testcases/network/stress/route/route4-rmmod
index 36c8c970d..70a6e3745 100644
--- a/testcases/network/stress/route/route4-rmmod
+++ b/testcases/network/stress/route/route4-rmmod
@@ -1,280 +1,104 @@
 #!/bin/sh
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
+# Copyright (c) International Business Machines  Corp., 2006
+# Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
 #
-# Description:
-#   Verify the kernel is not crashed when IPv4 route is add then it is deleted
-#   by the removing network driver
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
-# Setup:
-#   See ltp-yyyymmdd/testcases/network/stress/README
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
 #
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
 #
-# History:
-#	Apr 8 2006 - Created (Mitsuru Chinen)
+# Setup: testcases/network/stress/README
 #
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../ ; pwd)`}
-export LTPROOT
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
-# Total number of the test case
 TST_TOTAL=2
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
 
-# The destination network
-DST_NETWORK="10.10.10"	# destination network would be 10.10.10.0/24
-DST_HOST="5"
-DST_PORT="7"
+. route4-lib.sh
 
+TST_CLEANUP="do_cleanup"
 
-#-----------------------------------------------------------------------
-#
-# NAME:
-#   do_cleanup
-#
-# DESCRIPTION:
-#   Recover the tested interfaces
-#
-#-----------------------------------------------------------------------
 do_cleanup()
 {
-    # Make sure to load the network driver
-    if [ x${lhost_module} != x ]; then
-	modprobe $lhost_module
-    fi
-
-    # Initialize the interfaces
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
+	if [ -n "${lhost_module}" ]; then
+		modprobe $lhost_module
+		tst_sleep 100ms
+	fi
+	netstress_cleanup
+	restore_ipaddr
 }
 
 
-#-----------------------------------------------------------------------
-#
-# NAME:
-#   do_setup
-#
-# DESCRIPTION:
-#   Make a IPv4 connectivity
-#
-#-----------------------------------------------------------------------
 do_setup()
 {
-    # Check the local host has ethtool utility
-    which ethtool >/dev/null
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "This test case requires ethtool utility"
-	exit $TST_TOTAL
-    fi
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
+	route_setup
+	tst_check_cmds ethtool
+
+	tst_add_ipaddr_stress
+
+	# Get the module name of the interface at the local host
+	lhost_module=$(ethtool -i $(tst_iface) | grep driver | sed "s/driver:[[:blank:]]*//")
+
+	# Check the other active interface uses the same driver
+	for ifname in $(ifconfig | grep ^eth | awk '{ print $1}'); do
+		if [ "$(tst_iface)" = "$ifname" ]; then
+			continue
+		fi
+
+		module=$(ethtool -i $ifname | grep driver | sed "s/driver:[[:blank:]]*//")
+		if [ $lhost_module = $module ]; then
+			tst_resm TBROK "an active interface '$ifname' uses the same network driver '$module' with the test intreface"
+			return
+		fi
+	done
 }
 
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
 test_body()
 {
-    test_type=$1
+	local cmd_type=$1
+	local cmd_name="$(get_cmd $cmd_type)"
+	local dst_addr=${DST_NETWORK}.${DST_HOST}
+	local dst_network=${DST_NETWORK}.0
+	local cnt=0
 
-    TCID=route4-rmmod0${test_type}
-    TST_COUNT=$test_type
+	tst_resm TINFO "IPv4 route is added by '$cmd_name' command and then deleted by removing network driver $NS_TIMES times"
 
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
+	while [ $cnt -lt $NS_TIMES ]; do
+		make_background_tcp_traffic $LHOST_IPV4_UNUSED
 
-    # Start the loop
-    cnt=0
-    while [ $cnt -lt $NS_TIMES ]; do
-	# Check the connectivity to the gateway
-	check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr
-	if [ $? -ne 0 ]; then
-	    tst_resm TBROK "Test Link $LINK_NUM is somthing wrong."
-	    return 1
-	fi
+		check_connectivity_interval $cnt false $(tst_iface) $RHOST_IPV4_UNUSED || return
 
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
+		# Add the route
+		ROD manipulate_route $cmd_name 'add' $dst_network $IPV4_NETMASK_NUM $IPV4_NETMASK $RHOST_IPV4_UNUSED $(tst_iface)
 
-	# Load the route with UDP datagram
-	ns-udpsender -f 4 -D $dst_addr -p $DST_PORT -o -s 1472
-	if [ $? -ne 0 ]; then
-	    tst_resm TFAIL "Failed to run a UDP datagram sender"
-	    return 1
-	fi
+		# Remove and reload the network driver
+		rmmod $lhost_module && modprobe $lhost_module
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL "failed to unload/reload the network driver '$lhost_module'"
+			return
+		fi
+		tst_sleep 100ms
 
-	# Remove and reload the network driver
-	rmmod $lhost_module && modprobe $lhost_module
-	if [ $? -ne 0 ]; then
-	    tst_resm TFAIL "Failed to unload/reload the network driver"
-	    return 1
-	fi
+		# If we use netns we need to reset it as unloading kernel module breaks it
+		reset_ltp_netspace
 
-	# Make sure to assing the IPv4 address
-	set_ipv4addr lhost ${LINK_NUM} ${IPV4_NETWORK} ${LHOST_IPV4_HOST} >/dev/null 2>&1
+		tst_add_ipaddr_stress
 
-	cnt=`expr $cnt + 1`
-    done
+		cnt=$(($cnt + 1))
+	done
 
-    tst_resm TPASS "Test is finished correctly."
-    return 0
+	tst_resm TPASS "test is finished correctly"
 }
 
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
 do_setup
-test_body 1 || RC=`expr $RC + 1`      # Case of route command
-test_body 2 || RC=`expr $RC + 1`      # Case of ip command
-do_cleanup
+test_body 'rt_cmd'
+test_body 'ip_cmd'
 
-exit $RC
+tst_exit
diff --git a/testcases/network/stress/route/route6-change-dst b/testcases/network/stress/route/route6-change-dst
index 33e89e985..649f0cc00 100644
--- a/testcases/network/stress/route/route6-change-dst
+++ b/testcases/network/stress/route/route6-change-dst
@@ -242,7 +242,7 @@ test_body()
 	    ;;
 	esac
 	if [ $? -ne 0 ]; then
-	    tst_resm TFAIL "Cannot delte the route to ${ADDDEL_ROUTE}"
+	    tst_resm TFAIL "Cannot delete the route to ${ADDDEL_ROUTE}"
 	    return 1
 	fi
 
-- 
2.13.2

