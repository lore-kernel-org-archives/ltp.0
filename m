From: Joerg Vehlow <lkml@jv-coder.de>
Date: Tue, 17 Nov 2020 13:43:18 +0100
Subject: [LTP] [PATCH v2 1/3] network/stress/multicast/packet-flood: Update
 to new API
Message-ID: <20201117124320.783802-1-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 runtest/net_stress.multicast                  |   4 +
 .../multicast/packet-flood/mcast-pktfld01.sh  |  43 ++++
 .../multicast/packet-flood/mcast-pktfld02.sh  |  60 +++++
 .../multicast/packet-flood/mcast4-pktfld01    | 207 ----------------
 .../multicast/packet-flood/mcast4-pktfld02    | 225 ------------------
 .../multicast/packet-flood/mcast6-pktfld01    | 203 ----------------
 .../multicast/packet-flood/mcast6-pktfld02    | 220 -----------------
 7 files changed, 107 insertions(+), 855 deletions(-)
 create mode 100755 testcases/network/stress/multicast/packet-flood/mcast-pktfld01.sh
 create mode 100755 testcases/network/stress/multicast/packet-flood/mcast-pktfld02.sh
 delete mode 100644 testcases/network/stress/multicast/packet-flood/mcast4-pktfld01
 delete mode 100644 testcases/network/stress/multicast/packet-flood/mcast4-pktfld02
 delete mode 100644 testcases/network/stress/multicast/packet-flood/mcast6-pktfld01
 delete mode 100644 testcases/network/stress/multicast/packet-flood/mcast6-pktfld02

diff --git a/runtest/net_stress.multicast b/runtest/net_stress.multicast
index 463fe17ab..fff5133f6 100644
--- a/runtest/net_stress.multicast
+++ b/runtest/net_stress.multicast
@@ -6,8 +6,12 @@ mcast4-group-single-socket mcast-group-single-socket
 mcast4-group-multiple-socket mcast-group-multiple-socket
 mcast4-group-same-group mcast-group-same-group
 mcast4-group-source-filter mcast-group-source-filter
+mcast4-pktfld01 mcast-pktfld01.sh
+mcast4-pktfld02 mcast-pktfld02.sh
 
 mcast6-group-single-socket mcast-group-single-socket -6
 mcast6-group-multiple-socket mcast-group-multiple-socket -6
 mcast6-group-same-group mcast-group-same-group -6
 mcast6-group-source-filter mcast-group-source-filter -6
+mcast6-pktfld01 mcast-pktfld01.sh -6
+mcast6-pktfld02 mcast-pktfld02.sh -6
diff --git a/testcases/network/stress/multicast/packet-flood/mcast-pktfld01.sh b/testcases/network/stress/multicast/packet-flood/mcast-pktfld01.sh
new file mode 100755
index 000000000..37e9b1004
--- /dev/null
+++ b/testcases/network/stress/multicast/packet-flood/mcast-pktfld01.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2006 International Business Machines  Corp.
+# Copyright (c) 2020 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
+#
+# Verify that the kernel is not crashed when joining a multicast group with
+# a single socket, then receiving a large number of UDP packets at the socket
+
+TST_NEEDS_ROOT=1
+. mcast-lib.sh
+
+do_setup()
+{
+	mcast_setup $MCASTNUM_NORMAL
+	MCAST_LCMD=ns-mcast_receiver
+	MCAST_RCMD=ns-udpsender
+}
+
+do_test()
+{
+	local mcast_addr="$MCAST_IPV4_ADDR"
+	[ "$TST_IPV6" ] && mcast_addr="$MCAST_IPV6_ADDR"
+
+	# Find the available consecutive ports
+	local mcast_port=$(find_portbundle udp 1025 1)
+	if [ $? -ne 0 ]; then
+		tst_brk TBROK "No free udp port available."
+	fi
+
+	# Run a receiver
+	ns-mcast_receiver -f $TST_IPVER -I $(tst_iface lhost) -m $mcast_addr -p $mcast_port -b
+	if [ $? -ne 0 ]; then
+		tst_brk TBROK "Failed to start multicast receiver"
+	fi
+
+	# Run a sender
+	tst_rhost_run -s -c "ns-udpsender -D $mcast_addr -f $TST_IPVER -p $mcast_port -s 32767 -m -I $(tst_iface rhost) -t $NS_DURATION"
+
+	tst_res TPASS "Test finished successfully."
+}
+
+tst_run
diff --git a/testcases/network/stress/multicast/packet-flood/mcast-pktfld02.sh b/testcases/network/stress/multicast/packet-flood/mcast-pktfld02.sh
new file mode 100755
index 000000000..4ffde186b
--- /dev/null
+++ b/testcases/network/stress/multicast/packet-flood/mcast-pktfld02.sh
@@ -0,0 +1,60 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2006 International Business Machines  Corp.
+# Copyright (c) 2020 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
+#
+# Verify that the kernel is not crashed when joining multiple multicast
+# groups on separate sockets, then receiving a large number of UDP
+# packets at each socket
+
+TST_NEEDS_ROOT=1
+. mcast-lib.sh
+
+do_setup()
+{
+	mcast_setup $MCASTNUM_NORMAL
+	MCAST_LCMD=ns-mcast_receiver
+	MCAST_RCMD=ns-udpsender
+}
+
+do_test()
+{
+	local mcast_port_range=$(find_portbundle udp 1025 $MCASTNUM_NORMAL)
+	if [ $? -ne 0 ]; then
+		tst_brk TBROK "Failed to find enough consecutive free udp ports."
+	fi
+	local mcast_port_top=$(echo $mcast_port_range | cut -f 1 -d '-')
+
+	local mcastnum=0
+	while [ $mcastnum -lt $MCASTNUM_NORMAL ]; do
+		local mcast_port=$((mcast_port_top + mcastnum))
+
+		# Define the multicast address
+		if [ "$TST_IPV6" ]; then
+    		local mcastnum_hex=$(printf "%x" $mcastnum)
+    		local mcast_addr=${MCAST_IPV6_ADDR_PREFIX}:${mcastnum_hex}
+		else
+			local x=$((mcastnum / 254))
+			local y=$((mcastnum % 254 + 1))
+			local mcast_addr=${MCAST_IPV4_ADDR_PREFIX}.${x}.${y}
+		fi
+
+		# Run a receiver
+		ns-mcast_receiver -f $TST_IPVER -I $(tst_iface lhost) -m $mcast_addr -p $mcast_port -b
+		if [ $? -ne 0 ]; then
+			tst_brk TBROK "Failed to start multicast receiver"
+		fi
+
+		# Run a sender
+		tst_rhost_run -s -c "ns-udpsender -D $mcast_addr -f $TST_IPVER -p $mcast_port -m -I $(tst_iface rhost) -b -t $NS_DURATION"
+
+		: $((mcastnum += 1))
+	done
+
+	sleep $NS_DURATION
+
+	tst_res TPASS "Test finished successfully."
+}
+
+tst_run
diff --git a/testcases/network/stress/multicast/packet-flood/mcast4-pktfld01 b/testcases/network/stress/multicast/packet-flood/mcast4-pktfld01
deleted file mode 100644
index c1ee513d4..000000000
--- a/testcases/network/stress/multicast/packet-flood/mcast4-pktfld01
+++ /dev/null
@@ -1,207 +0,0 @@
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
-#   mcast4-pktfld01
-#
-# Description:
-#   Verify that the kernel is not crashed when joining a IPv4 multicast group
-#   a single socket, then receiving a large number of UDP packets at the socket
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	May 1 2006 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-# The test case ID, the test case count and the total number of test case
-TCID=mcast4-pktfld01
-TST_TOTAL=1
-TST_COUNT=1
-export TCID
-export TST_COUNT
-export TST_TOTAL
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../.. ; pwd)`}
-export LTPROOT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# Dulation of the test [sec]
-NS_DURATION=${NS_DURATION:-3600}      # 1 hour
-
-# The number of the test link where tests run
-LINK_NUM=${LINK_NUM:-0}
-
-# Network portion of the IPv4 address
-NETWORK_PART=${IPV4_NETWORK:-"10.0.0"}
-
-# Netmask of the IPv4 network
-NETWORK_MASK=24
-
-# Host portion of the IPv4 address
-LHOST_HOST_PART=${LHOST_IPV4_HOST:-"2"}     # local host
-RHOST_HOST_PART=${RHOST_IPV4_HOST:-"1"}     # remote host
-
-# Multicast Address
-MCAST_ADDR=224.10.0.1
-
-
-#-----------------------------------------------------------------------
-#
-# Function: do_cleanup
-#
-# Description:
-#   Recover the system configuration
-#
-#-----------------------------------------------------------------------
-do_cleanup()
-{
-    # Make sure to kill the multicast receiver and sender
-    killall -SIGHUP ns-mcast_receiver >/dev/null 2>&1
-    $LTP_RSH $RHOST killall -SIGHUP ns-udpsender >/dev/null 2>&1
-
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Function: do_setup
-#
-# Description:
-#   Configure the ssystem for the test
-#
-#-----------------------------------------------------------------------
-do_setup()
-{
-    # Initialize the system configuration
-    do_cleanup
-
-    # Call do_cleanup function before exit
-    trap do_cleanup 0
-
-    # Unset the maximum number of processes
-    ulimit -u unlimited
-
-    # name of interface of the local/remote host
-    lhost_ifname=`get_ifname lhost $LINK_NUM`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the local host"
-	exit $TST_TOTAL
-    fi
-
-    rhost_ifname=`get_ifname rhost $LINK_NUM`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the remote host"
-	exit $TST_TOTAL
-    fi
-
-    # Set IPv4 addresses to the interfaces
-    set_ipv4addr lhost $LINK_NUM $NETWORK_PART $LHOST_HOST_PART
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add any IP address at the local host"
-	exit 1
-    fi
-
-    set_ipv4addr rhost $LINK_NUM $NETWORK_PART $RHOST_HOST_PART
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add any IP address at the remote host"
-	exit 1
-    fi
-
-    # IPv4 address of the local/remote host
-    lhost_addr="${NETWORK_PART}.${LHOST_HOST_PART}"
-    rhost_addr="${NETWORK_PART}.${RHOST_HOST_PART}"
-
-    # Make sure the connectvity
-    check_icmpv4_connectivity $lhost_ifname $rhost_addr
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "There is no IPv4 connectivity."
-	exit 1
-    fi
-
-    # Make sure the sysctl values
-    sysctl -w net.ipv4.igmp_max_memberships=20 >/dev/null
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to set the sysctl value regarding multicast"
-	exit $TST_TOTAL
-    fi
-
-    sysctl -w net.ipv4.igmp_max_msf=10 >/dev/null
-    sysctl -w net.ipv4.conf.${lhost_ifname}.force_igmp_version=0 >/dev/null
-    sysctl -w net.ipv4.conf.all.force_igmp_version=0 >/dev/null
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-#
-
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed when joining a IPv4 multicast group a single socket, then receiving a large number of UDP packets at the socket in $NS_DURATION [sec]"
-
-do_setup
-
-# Find the available consecutive ports
-mcast_port=`find_portbundle udp 1025 1`
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "No port is available."
-    exit 1
-fi
-
-# Run a receiver
-ns-mcast_receiver -f 4 -I $lhost_ifname -m $MCAST_ADDR -p $mcast_port -b
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to start multicast receiver"
-    exit 1
-fi
-
-# Run a sender
-ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-udpsender -D $MCAST_ADDR -f 4 -p $mcast_port -s 32767 -m -I $rhost_ifname -t $NS_DURATION' ; echo $?'`
-if [ $ret -ne 0 ]; then
-    tst_resm TBROK "Failed to start multicast sender"
-    exit 1
-fi
-
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
-
-tst_resm TPASS "Test is finished successfully."
-exit 0
diff --git a/testcases/network/stress/multicast/packet-flood/mcast4-pktfld02 b/testcases/network/stress/multicast/packet-flood/mcast4-pktfld02
deleted file mode 100644
index b3b6134c3..000000000
--- a/testcases/network/stress/multicast/packet-flood/mcast4-pktfld02
+++ /dev/null
@@ -1,225 +0,0 @@
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
-#   mcast4-pktfld02
-#
-# Description:
-#   Verify that the kernel is not crashed when joining plural IPv4 multicast
-#   groups on separate sockets, then receiving a large number of UDP packets at
-#   the each socket
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	May 1 2006 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-# The test case ID, the test case count and the total number of test case
-TCID=mcast4-pktfld02
-TST_TOTAL=1
-TST_COUNT=1
-export TCID
-export TST_COUNT
-export TST_TOTAL
-
-LTPROOT=${LTPROOT:-`(cd ../../../../.. ; pwd)`}
-export LTPROOT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# Dulation of the test [sec]
-NS_DURATION=${NS_DURATION:-3600}      # 1 hour
-
-# The number of the test link where tests run
-LINK_NUM=${LINK_NUM:-0}
-
-# Network portion of the IPv4 address
-NETWORK_PART=${IPV4_NETWORK:-"10.0.0"}
-
-# Netmask of the IPv4 network
-NETWORK_MASK=24
-
-# Host portion of the IPv4 address
-LHOST_HOST_PART=${LHOST_IPV4_HOST:-"2"}     # local host
-RHOST_HOST_PART=${RHOST_IPV4_HOST:-"1"}     # remote host
-
-# Prefix of the multicast address
-MCAST_ADDR_PREFIX=224.10
-
-# Number of the multicast connection
-MCASTNUM_NORMAL=${MCASTNUM_NORMAL:-20}
-
-
-#-----------------------------------------------------------------------
-#
-# Function: do_cleanup
-#
-# Description:
-#   Recover the system configuration
-#
-#-----------------------------------------------------------------------
-do_cleanup()
-{
-    # Make sure to kill the multicast receiver and sender
-    killall -SIGHUP ns-mcast_receiver >/dev/null 2>&1
-    $LTP_RSH $RHOST killall -SIGHUP ns-udpsender >/dev/null 2>&1
-
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Function: do_setup
-#
-# Description:
-#   Configure the ssystem for the test
-#
-#-----------------------------------------------------------------------
-do_setup()
-{
-    # Initialize the system configuration
-    do_cleanup
-
-    # Call do_cleanup function before exit
-    trap do_cleanup 0
-
-    # Unset the maximum number of processes
-    ulimit -u unlimited
-
-    # name of interface of the local/remote host
-    lhost_ifname=`get_ifname lhost $LINK_NUM`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the local host"
-	exit $TST_TOTAL
-    fi
-
-    rhost_ifname=`get_ifname rhost $LINK_NUM`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the remote host"
-	exit $TST_TOTAL
-    fi
-
-    # Set IPv4 addresses to the interfaces
-    set_ipv4addr lhost $LINK_NUM $NETWORK_PART $LHOST_HOST_PART
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add any IP address at the local host"
-	exit 1
-    fi
-
-    set_ipv4addr rhost $LINK_NUM $NETWORK_PART $RHOST_HOST_PART
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add any IP address at the remote host"
-	exit 1
-    fi
-
-    # IPv4 address of the local/remote host
-    lhost_addr="${NETWORK_PART}.${LHOST_HOST_PART}"
-    rhost_addr="${NETWORK_PART}.${RHOST_HOST_PART}"
-
-    # Make sure the connectvity
-    check_icmpv4_connectivity $lhost_ifname $rhost_addr
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "There is no IPv4 connectivity."
-	exit 1
-    fi
-
-    # Make sure the sysctl values
-    sysctl -w net.ipv4.igmp_max_memberships=$MCASTNUM_NORMAL >/dev/null
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to set the sysctl value regarding multicast"
-	exit $TST_TOTAL
-    fi
-
-    sysctl -w net.ipv4.igmp_max_msf=10 >/dev/null
-    sysctl -w net.ipv4.conf.${lhost_ifname}.force_igmp_version=0 >/dev/null
-    sysctl -w net.ipv4.conf.all.force_igmp_version=0 >/dev/null
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-#
-
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed when joining $MCASTNUM_NORMAL IPv4 multicast groups on separate sockets, then receiving a large number of UDP packets at the each socket in $NS_DURATION [sec]"
-
-# Make sure the value of LTPROOT
-do_setup
-
-mcastnum=0
-mcast_port_range=`find_portbundle udp 1025 $MCASTNUM_NORMAL`
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to get enough port"
-    exit 1
-fi
-mcast_port_top=`echo $mcast_port_range | cut -f 1 -d '-'`
-
-while [ $mcastnum -lt $MCASTNUM_NORMAL ]; do
-    # Define the multicast address
-    x=`expr $mcastnum \/ 254`
-    y=`expr $mcastnum % 254 + 1`
-    if [ $x -gt 254 ]; then
-	tst_resm TINFO "The number of the connection is less than $mcastnum"
-	break
-    fi
-    mcast_addr=${MCAST_ADDR_PREFIX}.${x}.${y}
-
-    # Run a receiver
-    mcast_port=`expr $mcast_port_top + $mcastnum`
-    ns-mcast_receiver -f 4 -I $lhost_ifname -m $mcast_addr -p $mcast_port -b
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to start multicast receiver"
-	exit 1
-    fi
-
-    # Run a sender
-    $LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-udpsender -D $mcast_addr -f 4 -p $mcast_port -m -I $rhost_ifname -b -t $NS_DURATION
-
-    mcastnum=`expr $mcastnum + 1`
-done
-
-sleep $NS_DURATION
-do_cleanup
-
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
-
-tst_resm TPASS "Test is finished successfully."
-exit 0
diff --git a/testcases/network/stress/multicast/packet-flood/mcast6-pktfld01 b/testcases/network/stress/multicast/packet-flood/mcast6-pktfld01
deleted file mode 100644
index e9d932b43..000000000
--- a/testcases/network/stress/multicast/packet-flood/mcast6-pktfld01
+++ /dev/null
@@ -1,203 +0,0 @@
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
-#   mcast6-pktfld01
-#
-# Description:
-#   Verify that the kernel is not crashed when joining a IPv6 multicast group
-#   a single socket, then receiving a large number of UDP packets at the socket
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	May 6 2006 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-# The test case ID, the test case count and the total number of test case
-TCID=mcast6-pktfld01
-TST_TOTAL=1
-TST_COUNT=1
-export TCID
-export TST_COUNT
-export TST_TOTAL
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../.. ; pwd)`}
-export LTPROOT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# Dulation of the test [sec]
-NS_DURATION=${NS_DURATION:-3600}      # 1 hour
-
-# The number of the test link where tests run
-LINK_NUM=${LINK_NUM:-0}
-
-# Network portion of the IPv6 address
-NETWORK_PART="fec0:1:1:1"
-
-# Host portion of the IPv6 address
-LHOST_HOST_PART=":2"     # local host
-RHOST_HOST_PART=":1"     # remote host
-
-# Multicast Address
-MCAST_ADDR=ff0e::1111:1
-
-
-#-----------------------------------------------------------------------
-#
-# Function: do_cleanup
-#
-# Description:
-#   Recover the system configuration
-#
-#-----------------------------------------------------------------------
-do_cleanup()
-{
-    # Make sure to kill the multicast receiver and sender
-    killall -SIGHUP ns-mcast_receiver >/dev/null 2>&1
-    $LTP_RSH $RHOST killall -SIGHUP ns-udpsender >/dev/null 2>&1
-
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Function: do_setup
-#
-# Description:
-#   Configure the ssystem for the test
-#
-#-----------------------------------------------------------------------
-do_setup()
-{
-    # Initialize the system configuration
-    do_cleanup
-
-    # Call do_cleanup function before exit
-    trap do_cleanup 0
-
-    # Unset the maximum number of processes
-    ulimit -u unlimited
-
-    # name of interface of the local/remote host
-    lhost_ifname=`get_ifname lhost $LINK_NUM`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the local host"
-	exit $TST_TOTAL
-    fi
-
-    rhost_ifname=`get_ifname rhost $LINK_NUM`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the remote host"
-	exit $TST_TOTAL
-    fi
-
-    # Set IPv6 addresses to the interfaces
-    add_ipv6addr lhost $LINK_NUM $NETWORK_PART $LHOST_HOST_PART
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add any IP address at the local host"
-	exit 1
-    fi
-
-    add_ipv6addr rhost $LINK_NUM $NETWORK_PART $RHOST_HOST_PART
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add any IP address at the remote host"
-	exit 1
-    fi
-
-    # IPv6 address of the local/remote host
-    lhost_addr="${NETWORK_PART}:${LHOST_HOST_PART}"
-    rhost_addr="${NETWORK_PART}:${RHOST_HOST_PART}"
-
-    # Make sure the connectvity
-    check_icmpv6_connectivity $lhost_ifname $rhost_addr
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "There is no IPv6 connectivity."
-	exit 1
-    fi
-
-    # Make sure the sysctl values
-    sysctl -w net.ipv6.conf.all.force_mld_version=0 >/dev/null
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to set the sysctl value regarding multicast"
-	exit $TST_TOTAL
-    fi
-
-    sysctl -w net.ipv6.conf.${lhost_ifname}.force_mld_version=0 >/dev/null
-    sysctl -w net.ipv6.mld_max_msf=10 >/dev/null
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-#
-
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed when joining a IPv6 multicast group a single socket, then receiving a large number of UDP packets at the socket in $NS_DURATION [sec]"
-
-do_setup
-
-# Find the available consecutive ports
-mcast_port=`find_portbundle udp 1025 1`
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "No port is available."
-    exit 1
-fi
-
-# Run a receiver
-ns-mcast_receiver -f 6 -I $lhost_ifname -m $MCAST_ADDR -p $mcast_port -b
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to start multicast receiver"
-    exit 1
-fi
-
-# Run a sender
-ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-udpsender -D $MCAST_ADDR -f 6 -p $mcast_port -s 32767 -m -I $rhost_ifname -t $NS_DURATION' ; echo $?'`
-if [ $ret -ne 0 ]; then
-    tst_resm TBROK "Failed to start multicast sender"
-    exit 1
-fi
-
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
-
-tst_resm TPASS "Test is finished successfully."
-exit 0
diff --git a/testcases/network/stress/multicast/packet-flood/mcast6-pktfld02 b/testcases/network/stress/multicast/packet-flood/mcast6-pktfld02
deleted file mode 100644
index e8187b1a6..000000000
--- a/testcases/network/stress/multicast/packet-flood/mcast6-pktfld02
+++ /dev/null
@@ -1,220 +0,0 @@
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
-#   mcast6-pktfld02
-#
-# Description:
-#   Verify that the kernel is not crashed when joining plural IPv6 multicast
-#   groups on separate sockets, then receiving a large number of UDP packets at
-#   the each socket
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	May 1 2006 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-# The test case ID, the test case count and the total number of test case
-TCID=mcast6-pktfld02
-TST_TOTAL=1
-TST_COUNT=1
-export TCID
-export TST_COUNT
-export TST_TOTAL
-
-LTPROOT=${LTPROOT:-`(cd ../../../../.. ; pwd)`}
-export LTPROOT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# Dulation of the test [sec]
-NS_DURATION=${NS_DURATION:-3600}      # 1 hour
-
-# The number of the test link where tests run
-LINK_NUM=${LINK_NUM:-0}
-
-# Network portion of the IPv6 address
-NETWORK_PART="fec0:1:1:1"
-
-# Host portion of the IPv6 address
-LHOST_HOST_PART=":2"	# local host
-RHOST_HOST_PART=":1"	# remote host
-
-# Prefix of the multicast address
-MCAST_ADDR_PREFIX=ff0e::1111
-
-# Number of the multicast connection
-MCASTNUM_NORMAL=${MCASTNUM_NORMAL:-20}
-
-
-#-----------------------------------------------------------------------
-#
-# Function: do_cleanup
-#
-# Description:
-#   Recover the system configuration
-#
-#-----------------------------------------------------------------------
-do_cleanup()
-{
-    # Make sure to kill the multicast receiver and sender
-    killall -SIGHUP ns-mcast_receiver >/dev/null 2>&1
-    $LTP_RSH $RHOST killall -SIGHUP ns-udpsender >/dev/null 2>&1
-
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Function: do_setup
-#
-# Description:
-#   Configure the ssystem for the test
-#
-#-----------------------------------------------------------------------
-do_setup()
-{
-    # Initialize the system configuration
-    do_cleanup
-
-    # Call do_cleanup function before exit
-    trap do_cleanup 0
-
-    # Unset the maximum number of processes
-    ulimit -u unlimited
-
-    # name of interface of the local/remote host
-    lhost_ifname=`get_ifname lhost $LINK_NUM`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the local host"
-	exit $TST_TOTAL
-    fi
-
-    rhost_ifname=`get_ifname rhost $LINK_NUM`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the remote host"
-	exit $TST_TOTAL
-    fi
-
-    # Set IPv6 addresses to the interfaces
-    add_ipv6addr lhost $LINK_NUM $NETWORK_PART $LHOST_HOST_PART
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add any IP address at the local host"
-	exit 1
-    fi
-
-    add_ipv6addr rhost $LINK_NUM $NETWORK_PART $RHOST_HOST_PART
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add any IP address at the remote host"
-	exit 1
-    fi
-
-    # IPv6 address of the local/remote host
-    lhost_addr="${NETWORK_PART}:${LHOST_HOST_PART}"
-    rhost_addr="${NETWORK_PART}:${RHOST_HOST_PART}"
-
-    # Make sure the connectvity
-    check_icmpv6_connectivity $lhost_ifname $rhost_addr
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "There is no IPv6 connectivity."
-	exit 1
-    fi
-
-    # Make sure the sysctl values
-    sysctl -w net.ipv6.conf.all.force_mld_version=0 >/dev/null
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to set the sysctl value regarding multicast"
-	exit $TST_TOTAL
-    fi
-
-    sysctl -w net.ipv6.conf.${lhost_ifname}.force_mld_version=0 >/dev/null
-    sysctl -w net.ipv6.mld_max_msf=10 >/dev/null
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-#
-
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed when joining $MCASTNUM_NORMAL IPv6 multicast groups on separate sockets, then receiving a large number of UDP packets at the each socket in $NS_DURATION [sec]"
-
-# Make sure the value of LTPROOT
-do_setup
-
-mcastnum=0
-mcast_port_range=`find_portbundle udp 1025 $MCASTNUM_NORMAL`
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to get enough port"
-    exit 1
-fi
-mcast_port_top=`echo $mcast_port_range | cut -f 1 -d '-'`
-
-while [ $mcastnum -lt $MCASTNUM_NORMAL ]; do
-    # Define the multicast address
-    if [ $mcastnum -gt 65535 ]; then
-	tst_resm TINFO "The number of the connection is less than 65535"
-	break
-    fi
-    mcastnum_hex=`printf "%x" $mcastnum`
-    mcast_addr=${MCAST_ADDR_PREFIX}:${mcastnum_hex}
-
-    # Run a receiver
-    mcast_port=`expr $mcast_port_top + $mcastnum`
-    ns-mcast_receiver -f 6 -I $lhost_ifname -m $mcast_addr -p $mcast_port -b
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to start multicast receiver"
-	exit 1
-    fi
-
-    # Run a sender
-    $LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-udpsender -D $mcast_addr -f 6 -p $mcast_port -m -I $rhost_ifname -b -t $NS_DURATION
-
-    mcastnum=`expr $mcastnum + 1`
-done
-
-sleep $NS_DURATION
-do_cleanup
-
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
-
-tst_resm TPASS "Test is finished successfully."
-exit 0
-- 
2.25.1

