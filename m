From: Petr Vorel <pvorel@suse.cz>
Date: Sat,  3 Jun 2017 14:00:20 +0200
Subject: [LTP] [RFC PATCH v6 09/11] network/stress: Fix and cleanup route
	IPv4 tests
In-Reply-To: <20170603120022.13415-1-pvorel@suse.cz>
References: <20170603120022.13415-1-pvorel@suse.cz>
Message-ID: <20170603120022.13415-10-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Fix test for netns based testing.
* Remove rsh dependency.
* Create shell library route4-lib.sh (route IPv4 specific) to reduce
  duplicity in tests. Library uses test_stress_net.sh (and therefore test_net.sh).
* Stop using TST_COUNT, simplify TCID
* Cleanup code, fix typos, update doc.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/stress/ns-tools/initialize_if    |   3 -
 testcases/network/stress/route/00_Descriptions.txt |  23 +-
 testcases/network/stress/route/route4-change-dst   | 287 ++---------------
 testcases/network/stress/route/route4-change-gw    | 308 +++---------------
 testcases/network/stress/route/route4-change-if    | 348 +++------------------
 testcases/network/stress/route/route4-ifdown       | 298 ++++--------------
 testcases/network/stress/route/route4-lib.sh       | 252 +++++++++++++++
 testcases/network/stress/route/route4-redirect     | 232 +++-----------
 testcases/network/stress/route/route4-rmmod        | 329 +++++--------------
 testcases/network/stress/route/route6-change-dst   |   2 +-
 10 files changed, 585 insertions(+), 1497 deletions(-)
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
index 3c85555be..26510bc8b 100644
--- a/testcases/network/stress/route/route4-change-dst
+++ b/testcases/network/stress/route/route4-change-dst
@@ -1,276 +1,51 @@
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
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
-# Network portion of the IPv4 address
-IPV4_NETWORK=${IPV4_NETWORK:-"10.0.0"}
+export TST_TOTAL=2
 
-# Netmask of for the tested network
-IPV4_NETMASK="255.255.255.0"
-IPV4_NETMASK_NUM=24
+. `dirname $0`/route4-lib.sh
 
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
+	# Initialize the interfaces of the remote host
+	tst_init_iface rhost $LINK_NUM
 
-    tst_resm TINFO "Verify the kernel is not crashed when the destination of an IPv4 route is changed frequently by $test_command command in $NS_TIMES times"
+	set_ipv4addr_check rhost $LINK_NUM $IPV4_NETWORK $RHOST_IPV4_HOST
 
-    # Initialize the interface of the local host
-    initialize_if lhost ${LINK_NUM}
+	# IPv4 address of the remote host (gateway)
+	rhost_ipv4addr="${IPV4_NETWORK}.${RHOST_IPV4_HOST}"
 
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
+	lhost_ifname=$(tst_iface lhost $LINK_NUM)
+	rhost_ifname=$(tst_iface rhost $LINK_NUM)
 }
 
+do_setup
 
-#-----------------------------------------------------------------------
-#
-# Main
-#
-# Exit Value:
-#   The number of the failure
-#
-#-----------------------------------------------------------------------
+for cmd_name in rt_cmd ip_cmd; do
+	do_test_common "dst" $cmd_name $LINK_NUM 1 $lhost_ifname $rhost_ipv4addr
+done
 
-RC=0
-do_setup
-test_body 1 || RC=`expr $RC + 1`      # Case of route command
-test_body 2 || RC=`expr $RC + 1`      # Case of ip command
-do_cleanup
+do_cleanup_common
 
-exit $RC
+tst_exit
diff --git a/testcases/network/stress/route/route4-change-gw b/testcases/network/stress/route/route4-change-gw
index a9a91cca6..00773f676 100644
--- a/testcases/network/stress/route/route4-change-gw
+++ b/testcases/network/stress/route/route4-change-gw
@@ -1,292 +1,64 @@
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
-
-# Total number of the test case
-TST_TOTAL=2
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
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
-# Network portion of the IPv4 address
-IPV4_NETWORK=${IPV4_NETWORK:-"10.0.0"}
+export TST_TOTAL=2
 
-# Netmask of for the tested network
-IPV4_NETMASK_NUM=24
+. `dirname $0`/route4-lib.sh
 
-# Broadcast address of the tested network
-IPV4_BROADCAST=${IPV4_NETWORK}.255
+# gateway
+RHOST_IPV4_HOST_TOP=${RHOST_IPV4_HOST_TOP:-10}
 
-# Host portion of the IPv4 address
-LHOST_IPV4_HOST=${LHOST_IPV4_HOST:-"1"}	# src
-RHOST_IPV4_HOST_TOP="10"	# gateway
-RHOST_IPV4_HOST_LAST=19
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
+	lhost_ifname=$(tst_iface lhost $LINK_NUM)
+	rhost_ifname=$(tst_iface rhost $LINK_NUM)
+
+	# Initialize the interfaces of the remote host
+	tst_init_iface rhost $LINK_NUM
+
+	# Set IPv4 address to the interface of the remote host
+	rhost_part=$RHOST_IPV4_HOST_TOP
+	while [ $rhost_part -le $RHOST_IPV4_HOST_LAST ]; do
+		tst_rhost_run -s -c "ip addr add ${IPV4_NETWORK}.${rhost_part}/$IPV4_NETMASK_NUM broadcast $IPV4_BROADCAST dev $rhost_ifname"
+		rhost_part=$(($rhost_part + 1))
+	done
 }
 
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
-
-    # Set the variables regarding the destination host
-    dst_addr=${DST_NETWORK}.${DST_HOST}
-    dst_network=${DST_NETWORK}.0
-
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
+	killall_sighup ns_udpsender
+	do_cleanup_common
 }
 
+do_setup
 
-#-----------------------------------------------------------------------
-#
-# Main
-#
-# Exit Value:
-#   The number of the failure
-#
-#-----------------------------------------------------------------------
+for cmd_name in rt_cmd ip_cmd; do
+	do_test_common "gw" $cmd_name $LINK_NUM 1 $lhost_ifname "${IPV4_NETWORK}.$RHOST_IPV4_HOST_TOP" $RHOST_IPV4_HOST_TOP $RHOST_IPV4_HOST_LAST
+done
 
-RC=0
-do_setup
-test_body 1 || RC=`expr $RC + 1`      # Case of route command
-test_body 2 || RC=`expr $RC + 1`      # Case of ip command
 do_cleanup
 
-exit $RC
+tst_exit
diff --git a/testcases/network/stress/route/route4-change-if b/testcases/network/stress/route/route4-change-if
index 33fc3755c..3e0c25915 100644
--- a/testcases/network/stress/route/route4-change-if
+++ b/testcases/network/stress/route/route4-change-if
@@ -1,324 +1,78 @@
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
-
-# Total number of the test case
-TST_TOTAL=2
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
-
-# Netmask of for the gateway
-IPV4_NETMASK_NUM=24
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
-# Host portion of the IPv4 address
-LHOST_IPV4_HOST=${LHOST_IPV4_HOST:-"2"}	# src
-RHOST_IPV4_HOST=${RHOST_IPV4_HOST:-"1"}	# gateway
+export TST_TOTAL=2
 
-# The destination network
-DST_NETWORK="10.10.0"	# destination network would be 10.10.0.0/24
-DST_HOST="5"
-DST_PORT="7"
+. `dirname $0`/route4-lib.sh
 
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
-
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
-
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
+	link_total=$(echo $LHOST_HWADDRS | wc -w)
+	rhost_link_total=$(echo $RHOST_HWADDRS | wc -w)
 
-	# Get the Interface names of the remote host
-	rhost_ifname=`get_ifname rhost ${link_num}`
-	if [ $? -ne 0 ]; then
-	    tst_resm TBROK "Failed to get the interface name at the remote host"
-	    exit $TST_TOTAL
+	if [ $link_total -ne $rhost_link_total ]; then
+		tst_brkm TBROK "the number of element in LHOST_HWADDRS differs from RHOST_HWADDRS"
 	fi
-	rhost_ifname_array="$rhost_ifname_array $rhost_ifname"
-
-	# Initialize the interfaces of the remote host
-	initialize_if rhost ${link_num}
 
-	# Set IPv4 address to the interface of the remote host
-	set_ipv4addr rhost ${link_num} "${IPV4_NETWORK_PRE}.${link_num}" ${RHOST_IPV4_HOST}
-	if [ $? -ne 0 ]; then
-	    tst_resm TBROK "Failed to assign IP address to the interface $rhost_ifname at the remote host"
-	    exit $TST_TOTAL
+	if [ $link_total -lt 2 ]; then
+		tst_brkm TCONF "this test case requires more than one test link in LHOST_HWADDRS variable"
 	fi
 
-	link_num=`expr $link_num + 1`
-    done
-}
-
+	lhost_ifname_array=""
+	rhost_ifname_array=""
+	link_num=0
+	while [ $link_num -lt $link_total ]; do
+		lhost_ifname=$(tst_iface lhost $link_num)
+		rhost_ifname=$(tst_iface rhost $link_num)
+		lhost_ifname_array="$lhost_ifname_array $lhost_ifname"
+		rhost_ifname_array="$rhost_ifname_array $rhost_ifname"
 
+		# Initialize the interfaces of the remote host
+		tst_init_iface rhost $link_num
 
+		# Set IPv4 address to the interface of the remote host
+		set_ipv4addr_check rhost ${link_num} "${IPV4_NETWORK_PRE}.${link_num}" ${RHOST_IPV4_HOST}
 
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
+		link_num=$(( $link_num + 1 ))
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
-#       1 - route command case
-#       2 - ip command case
-#
-#-----------------------------------------------------------------------
-test_body()
+do_cleanup()
 {
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
+	killall_sighup ns_udpsender
+
+	# Initialize the interfaces
+	link_num=0
+	while [ $link_num -lt $link_total ]; do
+		init_if_lhost_rhost $link_num
+		link_num=$(( $link_num + 1 ))
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
+for cmd_name in rt_cmd ip_cmd; do
+	do_test_common "if" $cmd_name $LINK_NUM $link_total $lhost_ifname $IPV4_NETWORK_PRE
+done
 do_cleanup
-
-exit $RC
+tst_exit
diff --git a/testcases/network/stress/route/route4-ifdown b/testcases/network/stress/route/route4-ifdown
index e7ce1b4fe..1c81a1f74 100644
--- a/testcases/network/stress/route/route4-ifdown
+++ b/testcases/network/stress/route/route4-ifdown
@@ -1,261 +1,95 @@
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
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
-# Host portion of the IPv4 address
-LHOST_IPV4_HOST=${LHOST_IPV4_HOST:-"2"}	# src
-RHOST_IPV4_HOST=${RHOST_IPV4_HOST:-"1"}	# gateway
+export TST_TOTAL=2
 
-# The destination network
-DST_NETWORK="10.10.10"	# destination network would be 10.10.10.0/24
-DST_HOST="5"
-DST_PORT="7"
+. `dirname $0`/route4-lib.sh
 
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
+	do_cleanup_common
 
-    # Assign IPv4 address to the interface of the local host
-    set_ipv4addr lhost ${LINK_NUM} ${IPV4_NETWORK} ${LHOST_IPV4_HOST}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to assign an IPv4 address at the local host"
-	return 1
-    fi
-    lhost_ipv4addr="${IPV4_NETWORK}.${LHOST_IPV4_HOST}"
+	set_ipv4addr_check rhost ${LINK_NUM} ${IPV4_NETWORK} ${RHOST_IPV4_HOST}
+	rhost_ipv4addr="${IPV4_NETWORK}.${RHOST_IPV4_HOST}"
 
-    # Get the Interface names
-    lhost_ifname=`get_ifname lhost ${LINK_NUM}`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the local host"
-	exit $TST_TOTAL
-    fi
+	set_ipv4addr_check lhost ${LINK_NUM} ${IPV4_NETWORK} ${LHOST_IPV4_HOST}
+	lhost_ipv4addr="${IPV4_NETWORK}.${LHOST_IPV4_HOST}"
 
-    rhost_ifname=`get_ifname rhost ${LINK_NUM}`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the remote host"
-	exit $TST_TOTAL
-    fi
+	lhost_ifname=$(tst_iface lhost $LINK_NUM)
+	rhost_ifname=$(tst_iface rhost $LINK_NUM)
 
-    # Set the variables for destination network
-    dst_addr=${DST_NETWORK}.${DST_HOST}
-    dst_network=${DST_NETWORK}.0
+	# Set the variables for destination network
+	dst_addr=${DST_NETWORK}.${DST_HOST}
+	dst_network=${DST_NETWORK}.0
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
+	local cmd_name_route="`get_cmd $cmd_type`"
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
+	tst_resm TINFO "verify the kernel is not crashed when IPv4 route is added and deleted by '$cmd_name_route' command $NS_TIMES times"
 
-	# Load the route with UDP datagram
-	ns-udpsender -f 4 -D $dst_addr -p $DST_PORT -o -s 1472
-	if [ $? -ne 0 ]; then
-	    tst_resm TFAIL "Failed to run a UDP datagram sender"
-	    return 1
-	fi
+	while [ $cnt -lt $NS_TIMES ]; do
+		check_connectivity $lhost_ifname $rhost_ipv4addr $cnt
 
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
+		# Add the route
+		manipulate_route $cmd_name_route 'add' $dst_network $IPV4_NETMASK_NUM $IPV4_NETMASK $rhost_ipv4addr $lhost_ifname
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL "failed to add the route to ${dst_network}/$IPV4_NETMASK_NUM"
+			return
+		fi
 
-	cnt=`expr $cnt + 1`
-    done
+		# Load the route with UDP datagram
+		ns-udpsender -f 4 -D $dst_addr -p $DST_PORT -o -s 1472
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL "failed to run a UDP datagram sender"
+			return
+		fi
 
-    tst_resm TPASS "Test is finished correctly."
-    return 0
-}
+		# Down then up the interface
+		run_cmd "$cmd_iface_down"
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
-
-exit $RC
+test_body 'rt_cmd'
+test_body 'ip_cmd'
+do_cleanup_common
+tst_exit
diff --git a/testcases/network/stress/route/route4-lib.sh b/testcases/network/stress/route/route4-lib.sh
new file mode 100644
index 000000000..e1823b8f1
--- /dev/null
+++ b/testcases/network/stress/route/route4-lib.sh
@@ -0,0 +1,252 @@
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
+export TCID="`basename $0`"
+
+. test_stress_net.sh
+
+# The first 2 ocnted of the Network portion of the gateway address
+# FIXME: calculate it from IPV4_NETWORK variable as test expects IPV4_NETWORK
+# to be 10.0.0 and prefix 24.
+IPV4_NETWORK_PRE=${IPV4_NETWORK_PRE:-"10.0"}
+
+# The destination network
+# FIXME: generate DST_NETWORK_PREFIX randomly based on IPV4_NETWORK variable as
+# test expects IPV4_NETWORK to be 10.0.0 and prefix 24.
+DST_NETWORK_PREFIX="10.10" # 10.10.n.0/24
+DST_NETWORK="${DST_NETWORK_PREFIX}.0" # 10.10.0.0/24
+DST_HOST=5
+DST_PORT=7
+
+do_cleanup_common()
+{
+    init_if_lhost_rhost $LINK_NUM
+}
+
+prepare_connectivity()
+{
+	local lhost_ifname=$1
+	local link_num=$2
+	local network_part="$3"
+	local host_part="$4"
+	local rhost_addr="$5"
+	local type="lhost"
+
+	tst_init_iface $type $link_num
+	set_ipv4addr_check $type $link_num $network_part $host_part
+	check_connectivity $lhost_ifname $rhost_addr
+}
+
+get_lhost_ifname_loop()
+{
+	local field=$(($1 + 1))
+	echo $lhost_ifname_array | cut -d ' ' -f $field
+}
+
+run_cmd()
+{
+	local cmd="$@"
+	local ret
+
+	sh -c "$cmd"
+	ret=$?
+	[ $ret -ne 0 ] && tst_resm TWARN "'$cmd' failed: $ret"
+	return $ret
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
+	local lhost_ifname=$7
+	# not required params
+	local gateway2=$8
+	local lhost_ifname2=$9
+
+	local ret t
+
+	[ "$task" = "add" ] || [ "$task" = "del" ] || [ "$task" = "change" ] || \
+		tst_brkm TBROK "wrong task: '$task'"
+
+	if [ "$cmd_name" = "ip" ]; then
+		run_cmd "$cmd_name route $task $network/$prefix via $gateway dev $lhost_ifname"
+		ret=$?
+	else
+		t="$task"
+		# route doesn't have change command
+		[ "$task" = "change" ] && t="add"
+		run_cmd "$cmd_name $t -net $network netmask $netmask gw $gateway dev $lhost_ifname"
+		ret=$?
+
+		if [ "$task" = "change" ]; then
+			run_cmd "$cmd_name del -net $network netmask $netmask gw $gateway2 dev $lhost_ifname2"
+			ret=$?
+		fi
+	fi
+
+	return $ret
+}
+
+# Load the route with UDP traffic.
+run_ns_udpsender()
+{
+	local dst_addr=$1
+	local run_in_background=$2
+	local params="-o"
+
+	if [ "$run_in_background" = true ]; then
+		# daemon is already running
+		ps auxw | grep -q [n]s-udpsender && return 0
+		params="-b"
+	fi
+
+	ns-udpsender -f 4 -D $dst_addr -p $DST_PORT -s 1472 $params
+	[ $? -ne 0 ] && tst_brkm TBROK "failed to run a UDP datagram sender"
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
+do_test_common()
+{
+	local test_field=$1
+	local cmd_type=$2
+	local link_num=$3
+	local link_total=$4
+	local lhost_ifname=$5
+	local rhost_addr="$6"
+	# not required params
+	local rhost_part_first=$7
+	local rhost_part_last=$8
+
+	local run_in_background=true
+	local cnt=0
+	local dst_addr dst_network dst_network_postfix ipv4_network_loop gateway2 lhost_ifname2 rhost_part task test_field_name
+	local cmd_name="`get_cmd $cmd_type`"
+	local gateway="$rhost_addr"
+
+	case $test_field in
+	dst) test_field_name='destination' ;;
+	gw) test_field_name='gateway' ;;
+	if) test_field_name='interface' ;;
+	*) tst_brkm TBROK "Unknown test parameter '$test_field'"
+	esac
+
+	tst_resm TINFO "verify the kernel is not crashed when the $test_field_name of an IPv4 route is changed frequently by '$cmd_name' command $NS_TIMES times"
+
+	if [ "$test_field" = "if" ]; then
+		link_num=0
+		tst_resm TINFO "preparing connectivity $link_total times"
+		while [ $link_num -lt $link_total ]; do
+			lhost_ifname="$(get_lhost_ifname_loop $link_num)"
+			ipv4_network_loop="${rhost_addr}.${link_num}"
+			prepare_connectivity $lhost_ifname $link_num $ipv4_network_loop $LHOST_IPV4_HOST "$ipv4_network_loop.${LHOST_IPV4_HOST}"
+		done
+		link_num=0
+		lhost_ifname="`get_lhost_ifname_loop $link_num`"
+		gateway="${IPV4_NETWORK_PRE}.${link_num}.${RHOST_IPV4_HOST}"
+	else
+		tst_resm TINFO "preparing connectivity"
+		if [ "$test_field" = "gw" ]; then
+			rhost_part=$rhost_part_first
+			gateway="${IPV4_NETWORK}.${rhost_part}"
+		fi
+		prepare_connectivity $lhost_ifname $link_num $IPV4_NETWORK $LHOST_IPV4_HOST $gateway
+	fi
+
+	if [ "$test_field" != "dst" ]; then
+		tst_resm TINFO "adding first route"
+		dst_addr=${DST_NETWORK}.${DST_HOST}
+		dst_network=${DST_NETWORK}.0
+
+		manipulate_route $cmd_name add $dst_network $IPV4_NETMASK_NUM $IPV4_NETMASK $gateway $lhost_ifname
+		if [ $? -ne 0 ]; then
+			tst_brkm TBROK "failed to add the gateway to $gateway"
+			return
+		fi
+		run_ns_udpsender $dst_addr yes
+	fi
+
+	tst_resm TINFO "manipulate route $NS_TIMES times"
+	while [ $cnt -lt $NS_TIMES ]; do
+		lhost_ifname2="$lhost_ifname"
+		gateway2="$gateway"
+		if [ "$test_field" = "dst" ]; then
+			run_in_background=
+			task="add"
+			# Define the destination IP address
+			dst_network_postfix="$(($cnt % 255))"
+			dst_addr="${DST_NETWORK_PREFIX}.${dst_network_postfix}.${DST_HOST}"
+			dst_network="${DST_NETWORK_PREFIX}.${dst_network_postfix}.0"
+		elif [ "$test_field" = "if" ]; then
+			link_num=$(($link_num + 1))
+			[ $link_num -ge $link_total ] && link_num=0
+			lhost_ifname="$(get_lhost_ifname_loop $link_num)"
+			gateway="${IPV4_NETWORK_PRE}.${link_num}.${RHOST_IPV4_HOST}"
+			task="change"
+		elif [ "$test_field" = "gw" ]; then
+			pre_rhost_part=$rhost_part
+			rhost_part=$(($rhost_part + 1))
+			[ $rhost_part -gt $rhost_part_last ] && rhost_part=$rhost_part_first
+			gateway="${IPV4_NETWORK}.${rhost_part}"
+			gateway2="${IPV4_NETWORK}.${pre_rhost_part}"
+			task="change"
+		fi
+
+		manipulate_route $cmd_name $task $dst_network $IPV4_NETMASK_NUM $IPV4_NETMASK $gateway $lhost_ifname $gateway2 $lhost_ifname2
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL "failed to change the gateway to $gateway"
+			return
+		fi
+
+		run_ns_udpsender $dst_addr $run_in_background
+
+		if [ "$test_field" = "dst" ]; then
+			task="del"
+			manipulate_route $cmd_name $task $dst_network $IPV4_NETMASK_NUM $IPV4_NETMASK $gateway $lhost_ifname $gateway2 $lhost_ifname2
+			if [ $? -ne 0 ]; then
+				tst_resm TFAIL "failed to delete the gateway to $gateway"
+				return
+			fi
+		fi
+
+		cnt=$(($cnt + 1))
+	done
+
+	killall_sighup ns_udpsender
+
+	tst_resm TPASS "test is finished correctly"
+}
diff --git a/testcases/network/stress/route/route4-redirect b/testcases/network/stress/route/route4-redirect
index 9eb8a4624..718c96b33 100644
--- a/testcases/network/stress/route/route4-redirect
+++ b/testcases/network/stress/route/route4-redirect
@@ -1,212 +1,82 @@
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
-
-# The test case ID, the test case count and the total number of test case
-TCID=route4-redirect01
-TST_TOTAL=1
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
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
-# Broadcast address of the tested network
-IPV4_BROADCAST=${IPV4_NETWORK}.255
+export TST_TOTAL=1
 
-# Host portion of the IPv4 address
-LHOST_IPV4_HOST=${LHOST_IPV4_HOST:-"1"}	# src
-RHOST_IPV4_HOST="2"	# gateway
+. `dirname $0`/route4-lib.sh
 
-# The destination network
-DST_NETWORK="10.10.0"   # destination network would be 10.10.0.0/24
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
 do_cleanup()
 {
-    # Kill the redirector utility
-    $LTP_RSH $RHOST killall -SIGHUP ns-icmp_redirector >/dev/null 2>&1
-
-    # Initialize the interfaces
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
+	killall_sighup_rhost ns_udpsender
+	do_cleanup_common
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
+	do_cleanup
 
-    # Get the Interface name of remote host
-    rhost_ifname=`get_ifname rhost ${LINK_NUM}`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the remote host"
-	exit $TST_TOTAL
-    fi
+	lhost_ifname=$(tst_iface lhost $LINK_NUM)
+	rhost_ifname=$(tst_iface rhost $LINK_NUM)
 
-    # Remove the link-local address of the remote host
-    sleep 3
-    $LTP_RSH $RHOST "ip addr flush dev $rhost_ifname" > /dev/null
+	tst_resm TINFO "remove the link-local address of the remote host"
+	sleep 3
+	tst_rhost_run -s -c "ip addr flush dev $rhost_ifname"
 
-    # Assign IPv4 address to the interface of the local host
-    set_ipv4addr lhost ${LINK_NUM} ${IPV4_NETWORK} ${LHOST_IPV4_HOST}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to assign an IPv4 address at the local host"
-	return 1
-    fi
+	set_ipv4addr_check lhost $LINK_NUM $IPV4_NETWORK $LHOST_IPV4_HOST
 
-    # Add route to the initial gateway
-    route add -net ${DST_NETWORK}.0 netmask 255.255.255.0 gw ${IPV4_NETWORK}.${RHOST_IPV4_HOST} dev $lhost_ifname
+	tst_resm TINFO "add route to the initial gateway"
+	manipulate_route "route" "add" ${DST_NETWORK}.0 $IPV4_NETMASK_NUM $IPV4_NETMASK ${IPV4_NETWORK}.${RHOST_IPV4_HOST} $lhost_ifname
+	if [ $? -ne 0 ]; then
+		tst_brkm TBROK "failed to add the gateway to $gateway"
+		return
+	fi
 
-    # Make sure the sysctl value is set for accepting the redirect
-    sysctl -w net.ipv4.conf.${lhost_ifname}.accept_redirects=1 >/dev/null
-    sysctl -w net.ipv4.conf.${lhost_ifname}.secure_redirects=0 >/dev/null
+	# Make sure the sysctl value is set for accepting the redirect
+	sysctl -qw net.ipv4.conf.${lhost_ifname}.accept_redirects=1
+	sysctl -qw net.ipv4.conf.${lhost_ifname}.secure_redirects=0
 
-    # Run the redirector utility at the remote host
-    ret=`$LTP_RSH $RHOST "${LTPROOT}/testcases/bin/ns-icmp_redirector -I $rhost_ifname -b ; "'echo $?'`
-    if [ $ret -ne 0 ]; then
-	tst_resm TBROK "Failed to run icmp redirector at the remote host"
-	exit $TST_TOTAL
-    fi
+	# Run the redirector utility at the remote host
+	tst_rhost_run -s -c "ns-icmp_redirector -I $rhost_ifname -b"
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
-
-    tst_resm TPASS "Test is finished correctly."
-    return 0
+	local cnt=0
+	while [ $cnt -lt $NS_TIMES ]; do
+		ns-udpsender -f 4 -D ${DST_NETWORK}.${DST_HOST} -p $DST_PORT -o -s 8
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL "failed to run udp packet sender"
+			return
+		fi
+		cnt=$(($cnt + 1))
+	done
+
+	tst_resm TPASS "test is finished correctly"
 }
 
 
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
+test_body
 do_cleanup
-
-exit $RC
+tst_exit
diff --git a/testcases/network/stress/route/route4-rmmod b/testcases/network/stress/route/route4-rmmod
index 36c8c970d..45ab0dd67 100644
--- a/testcases/network/stress/route/route4-rmmod
+++ b/testcases/network/stress/route/route4-rmmod
@@ -1,280 +1,115 @@
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
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
-# The destination network
-DST_NETWORK="10.10.10"	# destination network would be 10.10.10.0/24
-DST_HOST="5"
-DST_PORT="7"
+export TST_TOTAL=2
 
+. `dirname $0`/route4-lib.sh
 
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
+	# Make sure to load the network driver
+	if [ -n "${lhost_module:-}" ]; then
+		modprobe $lhost_module
+	fi
+	do_cleanup_common
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
+	tst_check_cmds ethtool
+	do_cleanup
+
+	set_lhost_rhost_ipv4addr $LINK_NUM $IPV4_NETWORK $LHOST_IPV4_HOST $RHOST_IPV4_HOST
+	lhost_ipv4addr="${IPV4_NETWORK}.${LHOST_IPV4_HOST}"
+	rhost_ipv4addr="${IPV4_NETWORK}.${RHOST_IPV4_HOST}"
+	lhost_ifname=$(tst_iface lhost $LINK_NUM)
+	rhost_ifname=$(tst_iface rhost $LINK_NUM)
+
+	# Get the module name of the interface at the local host
+	lhost_module=`ethtool -i $lhost_ifname | grep driver | sed "s/driver:[[:blank:]]*//"`
+
+	# Check the other active interface uses the same driver
+	for ifname in `ifconfig | grep ^eth | awk '{ print $1}'`; do
+		if [ $lhost_ifname = $ifname ]; then
+			continue
+		fi
+
+		module=`ethtool -i $ifname | grep driver | sed "s/driver:[[:blank:]]*//"`
+		if [ $lhost_module = $module ]; then
+			tst_brkm TBROK "an active interface $ifname uses the same network driver $module with the test intreface"
+			return
+		fi
+	done
+
+	# Set the variables for destination network
+	dst_addr=${DST_NETWORK}.${DST_HOST}
+	dst_network=${DST_NETWORK}.0
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
+	local cnt=0
+	local cmd_name="`get_cmd $cmd_type`"
 
-    TCID=route4-rmmod0${test_type}
-    TST_COUNT=$test_type
+	tst_resm TINFO "verify the kernel is not crashed when IPv4 route is add by '$cmd_name' command and then it is deleted by removing network driver $NS_TIMES times"
 
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
+		check_connectivity $lhost_ifname $rhost_ipv4addr $cnt
 
-    # Start the loop
-    cnt=0
-    while [ $cnt -lt $NS_TIMES ]; do
-	# Check the connectivity to the gateway
-	check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr
-	if [ $? -ne 0 ]; then
-	    tst_resm TBROK "Test Link $LINK_NUM is somthing wrong."
-	    return 1
-	fi
+		# Add the route
+		manipulate_route $cmd_name 'add' $dst_network $IPV4_NETMASK_NUM $IPV4_NETMASK $rhost_ipv4addr $lhost_ifname
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL "failed to add the route to ${dst_network}/$IPV4_NETMASK_NUM"
+			return
+		fi
 
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
+		# Load the route with UDP datagram
+		ns-udpsender -f 4 -D $dst_addr -p $DST_PORT -o -s 1472
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL "failed to run a UDP datagram sender"
+			return
+		fi
 
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
 
-	# Remove and reload the network driver
-	rmmod $lhost_module && modprobe $lhost_module
-	if [ $? -ne 0 ]; then
-	    tst_resm TFAIL "Failed to unload/reload the network driver"
-	    return 1
-	fi
+		# if we use netns we need to reset it as unloading driver breaks it
+		reset_ltp_netspace
 
-	# Make sure to assing the IPv4 address
-	set_ipv4addr lhost ${LINK_NUM} ${IPV4_NETWORK} ${LHOST_IPV4_HOST} >/dev/null 2>&1
+		set_ipv4addr_check lhost $LINK_NUM $IPV4_NETWORK $LHOST_IPV4_HOST
 
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
+test_body 'rt_cmd'
+test_body 'ip_cmd'
 do_cleanup
-
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
2.12.2

