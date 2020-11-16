From: Joerg Vehlow <lkml@jv-coder.de>
Date: Mon, 16 Nov 2020 13:46:09 +0100
Subject: [LTP] [PATCH 1/3] network/stress/mutlicast/packet-flood: Update to
 tst_net.sh
In-Reply-To: <20201116124611.16919-1-lkml@jv-coder.de>
References: <20201116124611.16919-1-lkml@jv-coder.de>
Message-ID: <20201116124611.16919-2-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 .../multicast/packet-flood/mcast4-pktfld01    | 114 ++++-------------
 .../multicast/packet-flood/mcast4-pktfld02    | 116 ++++--------------
 .../multicast/packet-flood/mcast6-pktfld01    | 112 ++++-------------
 .../multicast/packet-flood/mcast6-pktfld02    | 114 ++++-------------
 4 files changed, 85 insertions(+), 371 deletions(-)

diff --git a/testcases/network/stress/multicast/packet-flood/mcast4-pktfld01 b/testcases/network/stress/multicast/packet-flood/mcast4-pktfld01
index c1ee513d4..20284569d 100644
--- a/testcases/network/stress/multicast/packet-flood/mcast4-pktfld01
+++ b/testcases/network/stress/multicast/packet-flood/mcast4-pktfld01
@@ -42,41 +42,20 @@
 #trace_logic=${trace_logic:-"set -x"}
 $trace_logic
 
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
+TST_TESTFUNC=test_body
+TST_NEEDS_ROOT=1
+TST_SETUP=do_setup
+TST_CLEANUP=do_cleanup
 
 # The number of the test link where tests run
 LINK_NUM=${LINK_NUM:-0}
 
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
 # Multicast Address
 MCAST_ADDR=224.10.0.1
 
 
+. tst_net.sh
+
 #-----------------------------------------------------------------------
 #
 # Function: do_cleanup
@@ -89,11 +68,7 @@ do_cleanup()
 {
     # Make sure to kill the multicast receiver and sender
     killall -SIGHUP ns-mcast_receiver >/dev/null 2>&1
-    $LTP_RSH $RHOST killall -SIGHUP ns-udpsender >/dev/null 2>&1
-
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
+	tst_rhost_run -c "killall -SIGHUP ns-udpsender >/dev/null 2>&1"
 }
 
 
@@ -107,57 +82,15 @@ do_cleanup()
 #-----------------------------------------------------------------------
 do_setup()
 {
-    # Initialize the system configuration
-    do_cleanup
-
-    # Call do_cleanup function before exit
-    trap do_cleanup 0
+	local lhost_ifname=$(tst_iface lhost ${LINK_NUM})
 
     # Unset the maximum number of processes
     ulimit -u unlimited
 
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
     # Make sure the sysctl values
     sysctl -w net.ipv4.igmp_max_memberships=20 >/dev/null
     if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to set the sysctl value regarding multicast"
-	exit $TST_TOTAL
+		tst_brk TBROK "Failed to set the sysctl value regarding multicast"
     fi
 
     sysctl -w net.ipv4.igmp_max_msf=10 >/dev/null
@@ -173,35 +106,30 @@ do_setup()
 #
 
 # Test description
-tst_resm TINFO "Verify that the kernel is not crashed when joining a IPv4 multicast group a single socket, then receiving a large number of UDP packets at the socket in $NS_DURATION [sec]"
 
-do_setup
+test_body()
+{
+	local lhost_ifname=$(tst_iface lhost ${LINK_NUM})
+	local rhost_ifname=$(tst_iface rhost ${LINK_NUM})
+
+	tst_res TINFO "Verify that the kernel is not crashed when joining a IPv4 multicast group a single socket, then receiving a large number of UDP packets at the socket in $NS_DURATION [sec]"
 
 # Find the available consecutive ports
 mcast_port=`find_portbundle udp 1025 1`
 if [ $? -ne 0 ]; then
-    tst_resm TBROK "No port is available."
-    exit 1
+		tst_brk TBROK "No port is available."
 fi
 
 # Run a receiver
 ns-mcast_receiver -f 4 -I $lhost_ifname -m $MCAST_ADDR -p $mcast_port -b
 if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to start multicast receiver"
-    exit 1
+		tst_brk TBROK "Failed to start multicast receiver"
 fi
 
 # Run a sender
-ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-udpsender -D $MCAST_ADDR -f 4 -p $mcast_port -s 32767 -m -I $rhost_ifname -t $NS_DURATION' ; echo $?'`
-if [ $ret -ne 0 ]; then
-    tst_resm TBROK "Failed to start multicast sender"
-    exit 1
-fi
+	tst_rhost_run -s -c "ns-udpsender -D $MCAST_ADDR -f 4 -p $mcast_port -s 32767 -m -I $rhost_ifname -t $NS_DURATION"
 
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
+	tst_res TPASS "Test is finished successfully."
+}
 
-tst_resm TPASS "Test is finished successfully."
-exit 0
+tst_run
diff --git a/testcases/network/stress/multicast/packet-flood/mcast4-pktfld02 b/testcases/network/stress/multicast/packet-flood/mcast4-pktfld02
index b3b6134c3..ac591fce1 100644
--- a/testcases/network/stress/multicast/packet-flood/mcast4-pktfld02
+++ b/testcases/network/stress/multicast/packet-flood/mcast4-pktfld02
@@ -43,42 +43,18 @@
 #trace_logic=${trace_logic:-"set -x"}
 $trace_logic
 
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
+TST_TESTFUNC=test_body
+TST_NEEDS_ROOT=1
+TST_SETUP=do_setup
+TST_CLEANUP=do_cleanup
 
 # The number of the test link where tests run
 LINK_NUM=${LINK_NUM:-0}
 
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
 # Prefix of the multicast address
 MCAST_ADDR_PREFIX=224.10
 
-# Number of the multicast connection
-MCASTNUM_NORMAL=${MCASTNUM_NORMAL:-20}
-
+. tst_net.sh
 
 #-----------------------------------------------------------------------
 #
@@ -92,11 +68,7 @@ do_cleanup()
 {
     # Make sure to kill the multicast receiver and sender
     killall -SIGHUP ns-mcast_receiver >/dev/null 2>&1
-    $LTP_RSH $RHOST killall -SIGHUP ns-udpsender >/dev/null 2>&1
-
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
+	tst_rhost_run -c "killall -SIGHUP ns-udpsender >/dev/null 2>&1"
 }
 
 
@@ -110,57 +82,15 @@ do_cleanup()
 #-----------------------------------------------------------------------
 do_setup()
 {
-    # Initialize the system configuration
-    do_cleanup
-
-    # Call do_cleanup function before exit
-    trap do_cleanup 0
+	local lhost_ifname=$(tst_iface lhost ${LINK_NUM})
 
     # Unset the maximum number of processes
     ulimit -u unlimited
 
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
     # Make sure the sysctl values
     sysctl -w net.ipv4.igmp_max_memberships=$MCASTNUM_NORMAL >/dev/null
     if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to set the sysctl value regarding multicast"
-	exit $TST_TOTAL
+		tst_brk TBROK "Failed to set the sysctl value regarding multicast"
     fi
 
     sysctl -w net.ipv4.igmp_max_msf=10 >/dev/null
@@ -176,16 +106,18 @@ do_setup()
 #
 
 # Test description
-tst_resm TINFO "Verify that the kernel is not crashed when joining $MCASTNUM_NORMAL IPv4 multicast groups on separate sockets, then receiving a large number of UDP packets at the each socket in $NS_DURATION [sec]"
 
-# Make sure the value of LTPROOT
-do_setup
+test_body()
+{
+	local lhost_ifname=$(tst_iface lhost ${LINK_NUM})
+	local rhost_ifname=$(tst_iface rhost ${LINK_NUM})
+
+	tst_res TINFO "Verify that the kernel is not crashed when joining $MCASTNUM_NORMAL IPv4 multicast groups on separate sockets, then receiving a large number of UDP packets at the each socket in $NS_DURATION [sec]"
 
 mcastnum=0
 mcast_port_range=`find_portbundle udp 1025 $MCASTNUM_NORMAL`
 if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to get enough port"
-    exit 1
+		tst_brk TBROK "Failed to get enough port"
 fi
 mcast_port_top=`echo $mcast_port_range | cut -f 1 -d '-'`
 
@@ -194,8 +126,7 @@ while [ $mcastnum -lt $MCASTNUM_NORMAL ]; do
     x=`expr $mcastnum \/ 254`
     y=`expr $mcastnum % 254 + 1`
     if [ $x -gt 254 ]; then
-	tst_resm TINFO "The number of the connection is less than $mcastnum"
-	break
+			tst_res TINFO "The number of the connection is less than $mcastnum"
     fi
     mcast_addr=${MCAST_ADDR_PREFIX}.${x}.${y}
 
@@ -203,23 +134,18 @@ while [ $mcastnum -lt $MCASTNUM_NORMAL ]; do
     mcast_port=`expr $mcast_port_top + $mcastnum`
     ns-mcast_receiver -f 4 -I $lhost_ifname -m $mcast_addr -p $mcast_port -b
     if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to start multicast receiver"
-	exit 1
+			tst_brk TBROK "Failed to start multicast receiver"
     fi
 
     # Run a sender
-    $LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-udpsender -D $mcast_addr -f 4 -p $mcast_port -m -I $rhost_ifname -b -t $NS_DURATION
+		tst_rhost_run -s -c "ns-udpsender -D $mcast_addr -f 4 -p $mcast_port -m -I $rhost_ifname -b -t $NS_DURATION"
 
     mcastnum=`expr $mcastnum + 1`
 done
 
 sleep $NS_DURATION
-do_cleanup
 
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
+	tst_res TPASS "Test is finished successfully."
+}
 
-tst_resm TPASS "Test is finished successfully."
-exit 0
+tst_run
diff --git a/testcases/network/stress/multicast/packet-flood/mcast6-pktfld01 b/testcases/network/stress/multicast/packet-flood/mcast6-pktfld01
index e9d932b43..bd20b2b07 100644
--- a/testcases/network/stress/multicast/packet-flood/mcast6-pktfld01
+++ b/testcases/network/stress/multicast/packet-flood/mcast6-pktfld01
@@ -42,37 +42,19 @@
 #trace_logic=${trace_logic:-"set -x"}
 $trace_logic
 
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
+TST_TESTFUNC=test_body
+TST_NEEDS_ROOT=1
+TST_IPV6=6
+TST_SETUP=do_setup
+TST_CLEANUP=do_cleanup
 
 # The number of the test link where tests run
 LINK_NUM=${LINK_NUM:-0}
 
-# Network portion of the IPv6 address
-NETWORK_PART="fec0:1:1:1"
-
-# Host portion of the IPv6 address
-LHOST_HOST_PART=":2"     # local host
-RHOST_HOST_PART=":1"     # remote host
-
 # Multicast Address
 MCAST_ADDR=ff0e::1111:1
 
+. tst_net.sh
 
 #-----------------------------------------------------------------------
 #
@@ -86,11 +68,7 @@ do_cleanup()
 {
     # Make sure to kill the multicast receiver and sender
     killall -SIGHUP ns-mcast_receiver >/dev/null 2>&1
-    $LTP_RSH $RHOST killall -SIGHUP ns-udpsender >/dev/null 2>&1
-
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
+	tst_rhost_run -c "killall -SIGHUP ns-udpsender >/dev/null 2>&1"
 }
 
 
@@ -104,57 +82,15 @@ do_cleanup()
 #-----------------------------------------------------------------------
 do_setup()
 {
-    # Initialize the system configuration
-    do_cleanup
-
-    # Call do_cleanup function before exit
-    trap do_cleanup 0
+	local lhost_ifname=$(tst_iface lhost ${LINK_NUM})
 
     # Unset the maximum number of processes
     ulimit -u unlimited
 
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
     # Make sure the sysctl values
     sysctl -w net.ipv6.conf.all.force_mld_version=0 >/dev/null
     if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to set the sysctl value regarding multicast"
-	exit $TST_TOTAL
+		tst_brk TBROK "Failed to set the sysctl value regarding multicast"
     fi
 
     sysctl -w net.ipv6.conf.${lhost_ifname}.force_mld_version=0 >/dev/null
@@ -168,36 +104,30 @@ do_setup()
 #
 #
 
+test_body()
+{
+	local lhost_ifname=$(tst_iface lhost ${LINK_NUM})
+	local rhost_ifname=$(tst_iface rhost ${LINK_NUM})
+	
 # Test description
-tst_resm TINFO "Verify that the kernel is not crashed when joining a IPv6 multicast group a single socket, then receiving a large number of UDP packets at the socket in $NS_DURATION [sec]"
-
-do_setup
+	tst_res TINFO "Verify that the kernel is not crashed when joining a IPv6 multicast group a single socket, then receiving a large number of UDP packets at the socket in $NS_DURATION [sec]"
 
 # Find the available consecutive ports
 mcast_port=`find_portbundle udp 1025 1`
 if [ $? -ne 0 ]; then
-    tst_resm TBROK "No port is available."
-    exit 1
+		tst_brk TBROK "No port is available."
 fi
 
 # Run a receiver
 ns-mcast_receiver -f 6 -I $lhost_ifname -m $MCAST_ADDR -p $mcast_port -b
 if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to start multicast receiver"
-    exit 1
+		tst_brk TBROK "Failed to start multicast receiver"
 fi
 
 # Run a sender
-ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-udpsender -D $MCAST_ADDR -f 6 -p $mcast_port -s 32767 -m -I $rhost_ifname -t $NS_DURATION' ; echo $?'`
-if [ $ret -ne 0 ]; then
-    tst_resm TBROK "Failed to start multicast sender"
-    exit 1
-fi
+	tst_rhost_run -s -c "ns-udpsender -D $MCAST_ADDR -f 6 -p $mcast_port -s 32767 -m -I $rhost_ifname -t $NS_DURATION"
 
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
+	tst_res TPASS "Test is finished successfully."
+}
 
-tst_resm TPASS "Test is finished successfully."
-exit 0
+tst_run
diff --git a/testcases/network/stress/multicast/packet-flood/mcast6-pktfld02 b/testcases/network/stress/multicast/packet-flood/mcast6-pktfld02
index e8187b1a6..201a63a05 100644
--- a/testcases/network/stress/multicast/packet-flood/mcast6-pktfld02
+++ b/testcases/network/stress/multicast/packet-flood/mcast6-pktfld02
@@ -43,39 +43,19 @@
 #trace_logic=${trace_logic:-"set -x"}
 $trace_logic
 
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
+TST_TESTFUNC=test_body
+TST_NEEDS_ROOT=1
+TST_IPV6=6
+TST_SETUP=do_setup
+TST_CLEANUP=do_cleanup
 
 # The number of the test link where tests run
 LINK_NUM=${LINK_NUM:-0}
 
-# Network portion of the IPv6 address
-NETWORK_PART="fec0:1:1:1"
-
-# Host portion of the IPv6 address
-LHOST_HOST_PART=":2"	# local host
-RHOST_HOST_PART=":1"	# remote host
-
 # Prefix of the multicast address
 MCAST_ADDR_PREFIX=ff0e::1111
 
-# Number of the multicast connection
-MCASTNUM_NORMAL=${MCASTNUM_NORMAL:-20}
-
+. tst_net.sh
 
 #-----------------------------------------------------------------------
 #
@@ -89,11 +69,7 @@ do_cleanup()
 {
     # Make sure to kill the multicast receiver and sender
     killall -SIGHUP ns-mcast_receiver >/dev/null 2>&1
-    $LTP_RSH $RHOST killall -SIGHUP ns-udpsender >/dev/null 2>&1
-
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
+	tst_rhost_run -c "killall -SIGHUP ns-udpsender >/dev/null 2>&1"
 }
 
 
@@ -107,57 +83,15 @@ do_cleanup()
 #-----------------------------------------------------------------------
 do_setup()
 {
-    # Initialize the system configuration
-    do_cleanup
-
-    # Call do_cleanup function before exit
-    trap do_cleanup 0
+	local lhost_ifname=$(tst_iface lhost ${LINK_NUM})
 
     # Unset the maximum number of processes
     ulimit -u unlimited
 
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
     # Make sure the sysctl values
     sysctl -w net.ipv6.conf.all.force_mld_version=0 >/dev/null
     if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to set the sysctl value regarding multicast"
-	exit $TST_TOTAL
+		tst_brk TBROK "Failed to set the sysctl value regarding multicast"
     fi
 
     sysctl -w net.ipv6.conf.${lhost_ifname}.force_mld_version=0 >/dev/null
@@ -171,24 +105,25 @@ do_setup()
 #
 #
 
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed when joining $MCASTNUM_NORMAL IPv6 multicast groups on separate sockets, then receiving a large number of UDP packets at the each socket in $NS_DURATION [sec]"
+test_body()
+{
+	local lhost_ifname=$(tst_iface lhost ${LINK_NUM})
+	local rhost_ifname=$(tst_iface rhost ${LINK_NUM})
 
-# Make sure the value of LTPROOT
-do_setup
+# Test description
+	tst_res TINFO "Verify that the kernel is not crashed when joining $MCASTNUM_NORMAL IPv6 multicast groups on separate sockets, then receiving a large number of UDP packets at the each socket in $NS_DURATION [sec]"
 
 mcastnum=0
 mcast_port_range=`find_portbundle udp 1025 $MCASTNUM_NORMAL`
 if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to get enough port"
-    exit 1
+		tst_brk TBROK "Failed to get enough port"
 fi
 mcast_port_top=`echo $mcast_port_range | cut -f 1 -d '-'`
 
 while [ $mcastnum -lt $MCASTNUM_NORMAL ]; do
     # Define the multicast address
     if [ $mcastnum -gt 65535 ]; then
-	tst_resm TINFO "The number of the connection is less than 65535"
+			tst_res TINFO "The number of the connection is less than 65535"
 	break
     fi
     mcastnum_hex=`printf "%x" $mcastnum`
@@ -198,23 +133,18 @@ while [ $mcastnum -lt $MCASTNUM_NORMAL ]; do
     mcast_port=`expr $mcast_port_top + $mcastnum`
     ns-mcast_receiver -f 6 -I $lhost_ifname -m $mcast_addr -p $mcast_port -b
     if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to start multicast receiver"
-	exit 1
+			tst_brk TBROK "Failed to start multicast receiver"
     fi
 
     # Run a sender
-    $LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-udpsender -D $mcast_addr -f 6 -p $mcast_port -m -I $rhost_ifname -b -t $NS_DURATION
+		tst_rhost_run -s -c "ns-udpsender -D $mcast_addr -f 6 -p $mcast_port -m -I $rhost_ifname -b -t $NS_DURATION"
 
     mcastnum=`expr $mcastnum + 1`
 done
 
 sleep $NS_DURATION
-do_cleanup
 
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
+	tst_res TPASS "Test is finished successfully."
+}
 
-tst_resm TPASS "Test is finished successfully."
-exit 0
+tst_run
-- 
2.25.1

