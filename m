From: Joerg Vehlow <lkml@jv-coder.de>
Date: Mon, 16 Nov 2020 13:46:10 +0100
Subject: [LTP] [PATCH 2/3] network/stress/multicast/query-flood: Convert to
 tst_net.sh
In-Reply-To: <20201116124611.16919-1-lkml@jv-coder.de>
References: <20201116124611.16919-1-lkml@jv-coder.de>
Message-ID: <20201116124611.16919-3-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 .../multicast/query-flood/mcast4-queryfld01   | 153 ++++-----------
 .../multicast/query-flood/mcast4-queryfld02   | 145 ++++----------
 .../multicast/query-flood/mcast4-queryfld03   | 142 ++++----------
 .../multicast/query-flood/mcast4-queryfld04   | 148 ++++----------
 .../multicast/query-flood/mcast4-queryfld05   | 181 ++++++------------
 .../multicast/query-flood/mcast4-queryfld06   | 166 +++++-----------
 .../multicast/query-flood/mcast6-queryfld01   | 144 ++++----------
 .../multicast/query-flood/mcast6-queryfld02   | 140 ++++----------
 .../multicast/query-flood/mcast6-queryfld03   | 144 ++++----------
 .../multicast/query-flood/mcast6-queryfld04   | 147 ++++----------
 .../multicast/query-flood/mcast6-queryfld05   | 180 ++++++-----------
 .../multicast/query-flood/mcast6-queryfld06   | 177 ++++++-----------
 12 files changed, 503 insertions(+), 1364 deletions(-)

diff --git a/testcases/network/stress/multicast/query-flood/mcast4-queryfld01 b/testcases/network/stress/multicast/query-flood/mcast4-queryfld01
index 992cf423e..a659db387 100644
--- a/testcases/network/stress/multicast/query-flood/mcast4-queryfld01
+++ b/testcases/network/stress/multicast/query-flood/mcast4-queryfld01
@@ -42,40 +42,18 @@
 #trace_logic=${trace_logic:-"set -x"}
 $trace_logic
 
-# The test case ID, the test case count and the total number of test case
-TCID=mcast4-queryfld01
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
-NS_DURATION=${NS_DURATION:-3600}	# 1 hour
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
 # Prefix of the Multicast Address
 MCAST_ADDR_PREFIX=224.10
 
+. tst_net.sh
 
 #-----------------------------------------------------------------------
 #
@@ -87,13 +65,9 @@ MCAST_ADDR_PREFIX=224.10
 #-----------------------------------------------------------------------
 do_cleanup()
 {
-    # Make sure to kill the multicast receiver and sender
-    killall -SIGHUP ns-mcast_join >/dev/null 2>&1
-    $LTP_RSH $RHOST killall -SIGHUP ns-igmp_querier >/dev/null 2>&1
-
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
+	# Make sure to kill the multicast receiver and sender
+	killall -SIGHUP ns-mcast_join >/dev/null 2>&1
+	tst_rhost_run -c "killall -SIGHUP ns-igmp_querier >/dev/null 2>&1"
 }
 
 
@@ -107,59 +81,17 @@ do_cleanup()
 #-----------------------------------------------------------------------
 do_setup()
 {
-    # Initialize the system configuration
-    do_cleanup
-
-    # Call do_cleanup function before exit
-    trap do_cleanup 0
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
+	local lhost_ifname=$(tst_iface lhost ${LINK_NUM})
+
+	# Make sure the sysctl values
+	sysctl -w net.ipv4.igmp_max_memberships=20 >/dev/null
+	if [ $? -ne 0 ]; then
+		tst_brk TBROK "Failed to set the sysctl value regarding multicast"
+	fi
+
+	sysctl -w net.ipv4.igmp_max_msf=10 >/dev/null
+	sysctl -w net.ipv4.conf.${lhost_ifname}.force_igmp_version=0 >/dev/null
+	sysctl -w net.ipv4.conf.all.force_igmp_version=0 >/dev/null
 }
 
 
@@ -169,31 +101,24 @@ do_setup()
 #
 #
 
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed when joining an IPv4 multicast group on a single socket, then receiving a large number of General Query in $NS_DURATION [sec]"
-
-do_setup
-
-# Run a multicast join tool
-ns-mcast_join -f 4 -I $lhost_ifname -n 1 -p $MCAST_ADDR_PREFIX >/dev/null
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to start multicast joining tool Please check the environment"
-    exit 1
-fi
-
-# Send IGMP General Query from the remote host
-ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-igmp_querier -I $rhost_ifname -t $NS_DURATION -r 0' ; echo $?'`
-if [ $ret -ne 0 ]; then
-    tst_resm TBROK "Failed to start IGMP querier"
-    exit 1
-fi
-
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
-
-killall -SIGHUP ns-mcast_join >/dev/null 2>&1
-tst_resm TPASS "Test is finished successfully."
+test_body()
+{
+	local lhost_ifname=$(tst_iface lhost ${LINK_NUM})
+	local rhost_ifname=$(tst_iface rhost ${LINK_NUM})
+
+	# Test description
+	tst_res TINFO "Verify that the kernel is not crashed when joining an IPv4 multicast group on a single socket, then receiving a large number of General Query in $NS_DURATION [sec]"
+
+	# Run a multicast join tool
+	ns-mcast_join -f 4 -I $lhost_ifname -n 1 -p $MCAST_ADDR_PREFIX >/dev/null
+	if [ $? -ne 0 ]; then
+		tst_brk TBROK "Failed to start multicast joining tool Please check the environment"
+	fi
+
+	# Send IGMP General Query from the remote host
+	tst_rhost_run -s -c "ns-igmp_querier -I $rhost_ifname -t $NS_DURATION -r 0"
+	
+	tst_res TPASS "Test is finished successfully."
+}
 
-exit 0
+tst_run
diff --git a/testcases/network/stress/multicast/query-flood/mcast4-queryfld02 b/testcases/network/stress/multicast/query-flood/mcast4-queryfld02
index b731e0218..d71650acf 100644
--- a/testcases/network/stress/multicast/query-flood/mcast4-queryfld02
+++ b/testcases/network/stress/multicast/query-flood/mcast4-queryfld02
@@ -43,43 +43,22 @@
 #trace_logic=${trace_logic:-"set -x"}
 $trace_logic
 
-# The test case ID, the test case count and the total number of test case
-TCID=mcast4-queryfld02
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
-NS_DURATION=${NS_DURATION:-3600}	# 1 hour
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
 # Prefix of the Multicast Address
 MCAST_ADDR_PREFIX=224.10
 
 # Multicast Address
 MCAST_ADDR=224.10.0.1	# If you modify this, please refer ns-mcast_join.c
 
+. tst_net.sh
+
 #-----------------------------------------------------------------------
 #
 # Function: do_cleanup
@@ -90,13 +69,9 @@ MCAST_ADDR=224.10.0.1	# If you modify this, please refer ns-mcast_join.c
 #-----------------------------------------------------------------------
 do_cleanup()
 {
-    # Make sure to kill the multicast receiver and sender
-    killall -SIGHUP ns-mcast_join >/dev/null 2>&1
-    $LTP_RSH $RHOST killall -SIGHUP ns-igmp_querier >/dev/null 2>&1
-
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
+	# Make sure to kill the multicast receiver and sender
+	killall -SIGHUP ns-mcast_join >/dev/null 2>&1
+	tst_rhost_run -c "killall -SIGHUP ns-igmp_querier >/dev/null 2>&1"
 }
 
 
@@ -110,59 +85,17 @@ do_cleanup()
 #-----------------------------------------------------------------------
 do_setup()
 {
-    # Initialize the system configuration
-    do_cleanup
-
-    # Call do_cleanup function before exit
-    trap do_cleanup 0
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
+	local lhost_ifname=$(tst_iface lhost ${LINK_NUM})
+
+	# Make sure the sysctl values
+	sysctl -w net.ipv4.igmp_max_memberships=20 >/dev/null
+	if [ $? -ne 0 ]; then
+		tst_brk TBROK "Failed to set the sysctl value regarding multicast"
+	fi
+
+	sysctl -w net.ipv4.igmp_max_msf=10 >/dev/null
+	sysctl -w net.ipv4.conf.${lhost_ifname}.force_igmp_version=0 >/dev/null
+	sysctl -w net.ipv4.conf.all.force_igmp_version=0 >/dev/null
 }
 
 
@@ -172,31 +105,25 @@ do_setup()
 #
 #
 
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed when joining an IPv4 multicast group on a single socket, then receiving a large number of Multicast Address Specific Query in $NS_DURATION [sec]"
+test_body()
+{
+	local lhost_ifname=$(tst_iface lhost ${LINK_NUM})
+	local rhost_ifname=$(tst_iface rhost ${LINK_NUM})
 
-do_setup
+	# Test description
+	tst_res TINFO "Verify that the kernel is not crashed when joining an IPv4 multicast group on a single socket, then receiving a large number of Multicast Address Specific Query in $NS_DURATION [sec]"
 
-# Run a multicast join tool
-ns-mcast_join -f 4 -I $lhost_ifname -n 1 -p $MCAST_ADDR_PREFIX >/dev/null
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to start multicast joining tool Please check the environment"
-    exit 1
-fi
+	# Run a multicast join tool
+	ns-mcast_join -f 4 -I $lhost_ifname -n 1 -p $MCAST_ADDR_PREFIX >/dev/null
+	if [ $? -ne 0 ]; then
+		tst_brk TBROK "Failed to start multicast joining tool Please check the environment"
+	fi
 
-# Send IGMP Multicast Address Specific Query from the remote host
-ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-igmp_querier -I $rhost_ifname -m $MCAST_ADDR -t $NS_DURATION -r 0' ; echo $?'`
-if [ $ret -ne 0 ]; then
-    tst_resm TBROK "Failed to start IGMP querier"
-    exit 1
-fi
+	# Send IGMP Multicast Address Specific Query from the remote host
+	tst_rhost_run -s -c "ns-igmp_querier -I $rhost_ifname -m $MCAST_ADDR -t $NS_DURATION -r 0"
 
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
 
-killall -SIGHUP ns-mcast_join >/dev/null 2>&1
-tst_resm TPASS "Test is finished successfully."
+	tst_res TPASS "Test is finished successfully."
+}
 
-exit 0
+tst_run
diff --git a/testcases/network/stress/multicast/query-flood/mcast4-queryfld03 b/testcases/network/stress/multicast/query-flood/mcast4-queryfld03
index 568178b32..a3e05a61e 100644
--- a/testcases/network/stress/multicast/query-flood/mcast4-queryfld03
+++ b/testcases/network/stress/multicast/query-flood/mcast4-queryfld03
@@ -43,37 +43,14 @@
 #trace_logic=${trace_logic:-"set -x"}
 $trace_logic
 
-# The test case ID, the test case count and the total number of test case
-TCID=mcast4-queryfld03
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
-NS_DURATION=${NS_DURATION:-3600}	# 1 hour
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
 # Prefix of the Multicast Address
 MCAST_ADDR_PREFIX=224.10
 
@@ -86,6 +63,8 @@ SRC_ADDR=10.10.10.1
 # Filter Mode
 FILTER_MODE="include"
 
+. tst_net.sh
+
 #-----------------------------------------------------------------------
 #
 # Function: do_cleanup
@@ -96,13 +75,9 @@ FILTER_MODE="include"
 #-----------------------------------------------------------------------
 do_cleanup()
 {
-    # Make sure to kill the multicast receiver and sender
-    killall -SIGHUP ns-mcast_join >/dev/null 2>&1
-    $LTP_RSH $RHOST killall -SIGHUP ns-igmp_querier >/dev/null 2>&1
-
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
+	# Make sure to kill the multicast receiver and sender
+	killall -SIGHUP ns-mcast_join >/dev/null 2>&1
+	tst_rhost_run -c "killall -SIGHUP ns-igmp_querier >/dev/null 2>&1"
 }
 
 
@@ -116,59 +91,17 @@ do_cleanup()
 #-----------------------------------------------------------------------
 do_setup()
 {
-    # Initialize the system configuration
-    do_cleanup
-
-    # Call do_cleanup function before exit
-    trap do_cleanup 0
+	local lhost_ifname=$(tst_iface lhost ${LINK_NUM})
 
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
+	# Make sure the sysctl values
+	sysctl -w net.ipv4.igmp_max_memberships=20 >/dev/null
+	if [ $? -ne 0 ]; then
+		tst_brk TBROK "Failed to set the sysctl value regarding multicast"
+	fi
 
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
+	sysctl -w net.ipv4.igmp_max_msf=10 >/dev/null
+	sysctl -w net.ipv4.conf.${lhost_ifname}.force_igmp_version=0 >/dev/null
+	sysctl -w net.ipv4.conf.all.force_igmp_version=0 >/dev/null
 }
 
 
@@ -178,31 +111,24 @@ do_setup()
 #
 #
 
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed when joining an IPv4 multicast group on a single socket, then receiving a large number of Multicast Address and Source Specific Query in $NS_DURATION [sec]"
-
-do_setup
+test_body()
+{
+	local lhost_ifname=$(tst_iface lhost ${LINK_NUM})
+	local rhost_ifname=$(tst_iface rhost ${LINK_NUM})
 
-# Run a multicast join tool
-ns-mcast_join -f 4 -I $lhost_ifname -n 1 -p $MCAST_ADDR_PREFIX -s $SRC_ADDR -F $FILTER_MODE >/dev/null
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to start multicast joining tool Please check the environment"
-    exit 1
-fi
+	# Test description
+	tst_res TINFO "Verify that the kernel is not crashed when joining an IPv4 multicast group on a single socket, then receiving a large number of Multicast Address and Source Specific Query in $NS_DURATION [sec]"
 
-# Send IGMP Multicast Address and Source Specific Query from the remote host
-ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-igmp_querier -I $rhost_ifname -m $MCAST_ADDR -s $SRC_ADDR -t $NS_DURATION -r 0' ; echo $?'`
-if [ $ret -ne 0 ]; then
-    tst_resm TBROK "Failed to start IGMP querier"
-    exit 1
-fi
+    # Run a multicast join tool
+    ns-mcast_join -f 4 -I $lhost_ifname -n 1 -p $MCAST_ADDR_PREFIX -s $SRC_ADDR -F $FILTER_MODE >/dev/null
+    if [ $? -ne 0 ]; then
+        tst_brk TBROK "Failed to start multicast joining tool Please check the environment"
+    fi
 
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
+    # Send IGMP Multicast Address and Source Specific Query from the remote host
+    tst_rhost_run -s -c "ns-igmp_querier -I $rhost_ifname -m $MCAST_ADDR -s $SRC_ADDR -t $NS_DURATION -r 0"
 
-killall -SIGHUP ns-mcast_join >/dev/null 2>&1
-tst_resm TPASS "Test is finished successfully."
+    tst_res TPASS "Test is finished successfully."
+}
 
-exit 0
+tst_run
diff --git a/testcases/network/stress/multicast/query-flood/mcast4-queryfld04 b/testcases/network/stress/multicast/query-flood/mcast4-queryfld04
index f89393ffc..74e8bf489 100644
--- a/testcases/network/stress/multicast/query-flood/mcast4-queryfld04
+++ b/testcases/network/stress/multicast/query-flood/mcast4-queryfld04
@@ -42,43 +42,18 @@
 #trace_logic=${trace_logic:-"set -x"}
 $trace_logic
 
-# The test case ID, the test case count and the total number of test case
-TCID=mcast4-queryfld04
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
-NS_DURATION=${NS_DURATION:-3600}	# 1 hour
-
-# Number of the multicast to join
-MCASTNUM_NORMAL=${MCASTNUM_NORMAL:-20}
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
 # Prefix of the Multicast Address
 MCAST_ADDR_PREFIX=224.10
 
+. tst_net.sh
 
 #-----------------------------------------------------------------------
 #
@@ -90,13 +65,9 @@ MCAST_ADDR_PREFIX=224.10
 #-----------------------------------------------------------------------
 do_cleanup()
 {
-    # Make sure to kill the multicast receiver and sender
-    killall -SIGHUP ns-mcast_join >/dev/null 2>&1
-    $LTP_RSH $RHOST killall -SIGHUP ns-igmp_querier >/dev/null 2>&1
-
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
+	# Make sure to kill the multicast receiver and sender
+	killall -SIGHUP ns-mcast_join >/dev/null 2>&1
+	tst_rhost_run -c "killall -SIGHUP ns-igmp_querier >/dev/null 2>&1"
 }
 
 
@@ -110,59 +81,17 @@ do_cleanup()
 #-----------------------------------------------------------------------
 do_setup()
 {
-    # Initialize the system configuration
-    do_cleanup
-
-    # Call do_cleanup function before exit
-    trap do_cleanup 0
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
+	local lhost_ifname=$(tst_iface lhost ${LINK_NUM})
+
+	# Make sure the sysctl values
+	sysctl -w net.ipv4.igmp_max_memberships=20 >/dev/null
+	if [ $? -ne 0 ]; then
+		tst_brk TBROK "Failed to set the sysctl value regarding multicast"
+	fi
+
+	sysctl -w net.ipv4.igmp_max_msf=10 >/dev/null
+	sysctl -w net.ipv4.conf.${lhost_ifname}.force_igmp_version=0 >/dev/null
+	sysctl -w net.ipv4.conf.all.force_igmp_version=0 >/dev/null
 }
 
 
@@ -172,31 +101,24 @@ do_setup()
 #
 #
 
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed when joining $MCASTNUM_NORMAL IPv4 multicast groups on separate sockets, then receiving a large number of General Query in $NS_DURATION [sec]"
-
-do_setup
+test_body()
+{
+	local lhost_ifname=$(tst_iface lhost ${LINK_NUM})
+	local rhost_ifname=$(tst_iface rhost ${LINK_NUM})
 
-# Run a multicast join tool
-ns-mcast_join -f 4 -I $lhost_ifname -n $MCASTNUM_NORMAL -p $MCAST_ADDR_PREFIX >/dev/null
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to start multicast joining tool Please check the environment"
-    exit 1
-fi
+	# Test description
+	tst_res TINFO "Verify that the kernel is not crashed when joining $MCASTNUM_NORMAL IPv4 multicast groups on separate sockets, then receiving a large number of General Query in $NS_DURATION [sec]"
 
-# Send IGMP General Query from the remote host
-ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-igmp_querier -I $rhost_ifname -t $NS_DURATION -r 0' ; echo $?'`
-if [ $ret -ne 0 ]; then
-    tst_resm TBROK "Failed to start IGMP querier"
-    exit 1
-fi
+	# Run a multicast join tool
+	ns-mcast_join -f 4 -I $lhost_ifname -n $MCASTNUM_NORMAL -p $MCAST_ADDR_PREFIX >/dev/null
+	if [ $? -ne 0 ]; then
+		tst_brk TBROK "Failed to start multicast joining tool Please check the environment"
+	fi
 
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
+	# Send IGMP General Query from the remote host
+	tst_rhost_run -s -c "ns-igmp_querier -I $rhost_ifname -t $NS_DURATION -r 0"
 
-killall -SIGHUP ns-mcast_join >/dev/null 2>&1
-tst_resm TPASS "Test is finished successfully."
+	tst_res TPASS "Test is finished successfully."
+}
 
-exit 0
+tst_run
diff --git a/testcases/network/stress/multicast/query-flood/mcast4-queryfld05 b/testcases/network/stress/multicast/query-flood/mcast4-queryfld05
index 6d73027a6..0ef1f9add 100644
--- a/testcases/network/stress/multicast/query-flood/mcast4-queryfld05
+++ b/testcases/network/stress/multicast/query-flood/mcast4-queryfld05
@@ -43,23 +43,10 @@
 #trace_logic=${trace_logic:-"set -x"}
 $trace_logic
 
-# The test case ID, the test case count and the total number of test case
-TCID=mcast4-queryfld05
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
-NS_DURATION=${NS_DURATION:-3600}	# 1 hour
+TST_TESTFUNC=test_body
+TST_NEEDS_ROOT=1
+TST_SETUP=do_setup
+TST_CLEANUP=do_cleanup
 
 # Number of the multicast to join
 MCASTNUM_NORMAL=${MCASTNUM_NORMAL:-20}
@@ -67,19 +54,11 @@ MCASTNUM_NORMAL=${MCASTNUM_NORMAL:-20}
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
 # Prefix of the Multicast Address
 MCAST_ADDR_PREFIX=224.10
 
+. tst_net.sh
+
 #-----------------------------------------------------------------------
 #
 # Function: do_cleanup
@@ -90,13 +69,9 @@ MCAST_ADDR_PREFIX=224.10
 #-----------------------------------------------------------------------
 do_cleanup()
 {
-    # Make sure to kill the multicast receiver and sender
-    killall -SIGHUP ns-mcast_join >/dev/null 2>&1
-    $LTP_RSH $RHOST killall -SIGHUP ns-igmp_querier >/dev/null 2>&1
-
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
+	# Make sure to kill the multicast receiver and sender
+	killall -SIGHUP ns-mcast_join >/dev/null 2>&1
+	tst_rhost_run -c "killall -SIGHUP ns-igmp_querier >/dev/null 2>&1"
 }
 
 
@@ -110,59 +85,17 @@ do_cleanup()
 #-----------------------------------------------------------------------
 do_setup()
 {
-    # Initialize the system configuration
-    do_cleanup
-
-    # Call do_cleanup function before exit
-    trap do_cleanup 0
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
+	local lhost_ifname=$(tst_iface lhost ${LINK_NUM})
+
+	# Make sure the sysctl values
+	sysctl -w net.ipv4.igmp_max_memberships=20 >/dev/null
+	if [ $? -ne 0 ]; then
+		tst_brk TBROK "Failed to set the sysctl value regarding multicast"
+	fi
+
+	sysctl -w net.ipv4.igmp_max_msf=10 >/dev/null
+	sysctl -w net.ipv4.conf.${lhost_ifname}.force_igmp_version=0 >/dev/null
+	sysctl -w net.ipv4.conf.all.force_igmp_version=0 >/dev/null
 }
 
 
@@ -172,42 +105,40 @@ do_setup()
 #
 #
 
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed when joining $MCASTNUM_NORMAL IPv4 multicast groups on separate sockets, then receiving a large number of Multicast Address Specific Query in $NS_DURATION [sec]"
-
-do_setup
-
-# Run a multicast join tool
-ns-mcast_join -f 4 -I $lhost_ifname -n $MCASTNUM_NORMAL -p $MCAST_ADDR_PREFIX > /dev/null
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to start multicast joining tool Please check the environment"
-    exit 1
-fi
-
-# Send IGMP Multicast Address Specific Query from the remote host
-querier_num=0
-while [ $querier_num -lt $MCASTNUM_NORMAL ]; do
-    # Define the multicast address
-    x=`expr $querier_num \/ 254`
-    y=`expr $querier_num % 254 + 1`
-    if [ $x -gt 254 ]; then
-	tst_resm TINFO "The number of the connection is less than $querier_num"
-	break
-    fi
-    mcast_addr=${MCAST_ADDR_PREFIX}.${x}.${y}
-
-    $LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-igmp_querier -I $rhost_ifname -m $mcast_addr -t $NS_DURATION -r 0 -b
-
-    querier_num=`expr $querier_num + 1`
-done
-sleep $NS_DURATION
-
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
-
-do_cleanup
-tst_resm TPASS "Test is finished successfully."
+test_body()
+{
+	local lhost_ifname=$(tst_iface lhost ${LINK_NUM})
+	local rhost_ifname=$(tst_iface rhost ${LINK_NUM})
+
+	# Test description
+	tst_res TINFO "Verify that the kernel is not crashed when joining $MCASTNUM_NORMAL IPv4 multicast groups on separate sockets, then receiving a large number of Multicast Address Specific Query in $NS_DURATION [sec]"
+
+	# Run a multicast join tool
+	ns-mcast_join -f 4 -I $lhost_ifname -n $MCASTNUM_NORMAL -p $MCAST_ADDR_PREFIX > /dev/null
+	if [ $? -ne 0 ]; then
+		tst_brk TBROK "Failed to start multicast joining tool Please check the environment"
+	fi
+
+	# Send IGMP Multicast Address Specific Query from the remote host
+	querier_num=0
+	while [ $querier_num -lt $MCASTNUM_NORMAL ]; do
+		# Define the multicast address
+		x=`expr $querier_num \/ 254`
+		y=`expr $querier_num % 254 + 1`
+		if [ $x -gt 254 ]; then
+			tst_res TINFO "The number of the connection is less than $querier_num"
+			break
+		fi
+		mcast_addr=${MCAST_ADDR_PREFIX}.${x}.${y}
+
+		tst_rhost_run -c "ns-igmp_querier -I $rhost_ifname -m $mcast_addr -t $NS_DURATION -r 0 -b"
+
+		querier_num=`expr $querier_num + 1`
+	done
+
+	sleep $NS_DURATION
+
+	tst_res TPASS "Test is finished successfully."
+}
 
-exit 0
+tst_run
diff --git a/testcases/network/stress/multicast/query-flood/mcast4-queryfld06 b/testcases/network/stress/multicast/query-flood/mcast4-queryfld06
index b45162045..b2b8ef3d4 100644
--- a/testcases/network/stress/multicast/query-flood/mcast4-queryfld06
+++ b/testcases/network/stress/multicast/query-flood/mcast4-queryfld06
@@ -43,23 +43,10 @@
 #trace_logic=${trace_logic:-"set -x"}
 $trace_logic
 
-# The test case ID, the test case count and the total number of test case
-TCID=mcast4-queryfld06
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
-NS_DURATION=${NS_DURATION:-3600}	# 1 hour
+TST_TESTFUNC=test_body
+TST_NEEDS_ROOT=1
+TST_SETUP=do_setup
+TST_CLEANUP=do_cleanup
 
 # Number of the multicast to join
 MCASTNUM_NORMAL=${MCASTNUM_NORMAL:-20}
@@ -67,16 +54,6 @@ MCASTNUM_NORMAL=${MCASTNUM_NORMAL:-20}
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
 # Prefix of the Multicast Address
 MCAST_ADDR_PREFIX=224.10
 
@@ -86,6 +63,8 @@ SRC_ADDR=10.10.10.1
 # Filter Mode
 FILTER_MODE="include"
 
+. tst_net.sh
+
 #-----------------------------------------------------------------------
 #
 # Function: do_cleanup
@@ -96,13 +75,9 @@ FILTER_MODE="include"
 #-----------------------------------------------------------------------
 do_cleanup()
 {
-    # Make sure to kill the multicast receiver and sender
-    killall -SIGHUP ns-mcast_join >/dev/null 2>&1
-    $LTP_RSH $RHOST killall -SIGHUP ns-igmp_querier >/dev/null 2>&1
-
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
+	# Make sure to kill the multicast receiver and sender
+	killall -SIGHUP ns-mcast_join >/dev/null 2>&1
+	tst_rhost_run -c "killall -SIGHUP ns-igmp_querier >/dev/null 2>&1"
 }
 
 
@@ -116,59 +91,17 @@ do_cleanup()
 #-----------------------------------------------------------------------
 do_setup()
 {
-    # Initialize the system configuration
-    do_cleanup
-
-    # Call do_cleanup function before exit
-    trap do_cleanup 0
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
+	local lhost_ifname=$(tst_iface lhost ${LINK_NUM})
 
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
+	# Make sure the sysctl values
+	sysctl -w net.ipv4.igmp_max_memberships=20 >/dev/null
+	if [ $? -ne 0 ]; then
+		tst_brk TBROK "Failed to set the sysctl value regarding multicast"
+	fi
 
-    sysctl -w net.ipv4.igmp_max_msf=10 >/dev/null
-    sysctl -w net.ipv4.conf.${lhost_ifname}.force_igmp_version=0 >/dev/null
-    sysctl -w net.ipv4.conf.all.force_igmp_version=0 >/dev/null
+	sysctl -w net.ipv4.igmp_max_msf=10 >/dev/null
+	sysctl -w net.ipv4.conf.${lhost_ifname}.force_igmp_version=0 >/dev/null
+	sysctl -w net.ipv4.conf.all.force_igmp_version=0 >/dev/null
 }
 
 
@@ -178,42 +111,39 @@ do_setup()
 #
 #
 
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed when joining $MCASTNUM_NORMAL IPv4 multicast groups on separate sockets, then receiving a large number of Multicast Address and Source Specific Query in $NS_DURATION [sec]"
-
-do_setup
-
-# Run a multicast join tool
-ns-mcast_join -f 4 -I $lhost_ifname -n $MCASTNUM_NORMAL -p $MCAST_ADDR_PREFIX -s $SRC_ADDR -F $FILTER_MODE > /dev/null
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to start multicast joining tool Please check the environment"
-    exit 1
-fi
-
-# Send IGMP Multicast Address Specific Query from the remote host
-querier_num=0
-while [ $querier_num -lt $MCASTNUM_NORMAL ]; do
-    # Define the multicast address
-    x=`expr $querier_num \/ 254`
-    y=`expr $querier_num % 254 + 1`
-    if [ $x -gt 254 ]; then
-	tst_resm TINFO "The number of the connection is less than $querier_num"
-	break
+test_body()
+{
+	local lhost_ifname=$(tst_iface lhost ${LINK_NUM})
+	local rhost_ifname=$(tst_iface rhost ${LINK_NUM})
+
+	# Test description
+	tst_res TINFO "Verify that the kernel is not crashed when joining $MCASTNUM_NORMAL IPv4 multicast groups on separate sockets, then receiving a large number of Multicast Address and Source Specific Query in $NS_DURATION [sec]"
+
+    # Run a multicast join tool
+    ns-mcast_join -f 4 -I $lhost_ifname -n $MCASTNUM_NORMAL -p $MCAST_ADDR_PREFIX -s $SRC_ADDR -F $FILTER_MODE > /dev/null
+    if [ $? -ne 0 ]; then
+        tst_brk TBROK "Failed to start multicast joining tool Please check the environment"
     fi
-    mcast_addr=${MCAST_ADDR_PREFIX}.${x}.${y}
 
-    $LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-igmp_querier -I $rhost_ifname -m $mcast_addr -s $SRC_ADDR -t $NS_DURATION -r 0 -b
+    # Send IGMP Multicast Address Specific Query from the remote host
+    querier_num=0
+    while [ $querier_num -lt $MCASTNUM_NORMAL ]; do
+        # Define the multicast address
+        x=`expr $querier_num \/ 254`
+        y=`expr $querier_num % 254 + 1`
+        if [ $x -gt 254 ]; then
+            tst_res TINFO "The number of the connection is less than $querier_num"
+        fi
+        mcast_addr=${MCAST_ADDR_PREFIX}.${x}.${y}
 
-    querier_num=`expr $querier_num + 1`
-done
-sleep $NS_DURATION
+        tst_rhost_run -c "ns-igmp_querier -I $rhost_ifname -m $mcast_addr -s $SRC_ADDR -t $NS_DURATION -r 0 -b"
 
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
+        querier_num=`expr $querier_num + 1`
+    done
 
-do_cleanup
-tst_resm TPASS "Test is finished successfully."
+    sleep $NS_DURATION
+
+    tst_res TPASS "Test is finished successfully."
+}
 
-exit 0
+tst_run
diff --git a/testcases/network/stress/multicast/query-flood/mcast6-queryfld01 b/testcases/network/stress/multicast/query-flood/mcast6-queryfld01
index 8c09d4897..4c3f31938 100644
--- a/testcases/network/stress/multicast/query-flood/mcast6-queryfld01
+++ b/testcases/network/stress/multicast/query-flood/mcast6-queryfld01
@@ -42,37 +42,19 @@
 #trace_logic=${trace_logic:-"set -x"}
 $trace_logic
 
-# The test case ID, the test case count and the total number of test case
-TCID=mcast6-queryfld01
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
-NS_DURATION=${NS_DURATION:-3600}	# 1 hour
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
 # Prefix of the Multicast Address
 MCAST_ADDR_PREFIX=ff0e:
 
+. tst_net.sh
 
 #-----------------------------------------------------------------------
 #
@@ -84,13 +66,9 @@ MCAST_ADDR_PREFIX=ff0e:
 #-----------------------------------------------------------------------
 do_cleanup()
 {
-    # Make sure to kill the multicast receiver and sender
-    killall -SIGHUP ns-mcast_join >/dev/null 2>&1
-    $LTP_RSH $RHOST killall -SIGHUP ns-icmpv6_sender >/dev/null 2>&1
-
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
+	# Make sure to kill the multicast receiver and sender
+	killall -SIGHUP ns-mcast_join >/dev/null 2>&1
+	tst_rhost_run -c "ns-icmpv6_sender >/dev/null 2>&1"
 }
 
 
@@ -104,59 +82,16 @@ do_cleanup()
 #-----------------------------------------------------------------------
 do_setup()
 {
-    # Initialize the system configuration
-    do_cleanup
-
-    # Call do_cleanup function before exit
-    trap do_cleanup 0
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
-    rhost_linklocal="fe80:${RHOST_HOST_PART}"
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
+	local lhost_ifname=$(tst_iface lhost ${LINK_NUM})
+
+	# Make sure the sysctl values
+	sysctl -w net.ipv6.conf.all.force_mld_version=0 >/dev/null
+	if [ $? -ne 0 ]; then
+		tst_brk TBROK "Failed to set the sysctl value regarding multicast"
+	fi
+
+	sysctl -w net.ipv6.conf.${lhost_ifname}.force_mld_version=0 >/dev/null
+	sysctl -w net.ipv6.mld_max_msf=10 >/dev/null
 }
 
 
@@ -166,32 +101,25 @@ do_setup()
 #
 #
 
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed when joining an IPv6 multicast group on a single socket, then receiving a large number of General Query in $NS_DURATION [sec]"
-
-do_setup
+test_body()
+{
+	local lhost_ifname=$(tst_iface lhost ${LINK_NUM})
+	local rhost_ifname=$(tst_iface rhost ${LINK_NUM})
+	local rhost_linklocal=$(tst_ipaddr lhost ${LINK_NUM})
 
-# Run a multicast join tool
-ns-mcast_join -f 6 -I $lhost_ifname -n 1 -p $MCAST_ADDR_PREFIX >/dev/null
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to start multicast joining tool Please check the environment"
-    exit 1
-fi
+	# Test description
+	tst_res TINFO "Verify that the kernel is not crashed when joining an IPv6 multicast group on a single socket, then receiving a large number of General Query in $NS_DURATION [sec]"
 
-# Send MLD General Query from the remote host
-ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-icmpv6_sender -I $rhost_ifname -S $rhost_linklocal -m -r 0 -t $NS_DURATION' ; echo $?'`
+	# Run a multicast join tool
+	ns-mcast_join -f 6 -I $lhost_ifname -n 1 -p $MCAST_ADDR_PREFIX >/dev/null
+	if [ $? -ne 0 ]; then
+		tst_brk TBROK "Failed to start multicast joining tool Please check the environment"
+	fi
 
-if [ $ret -ne 0 ]; then
-    tst_resm TBROK "Failed to start MLD querier"
-    exit 1
-fi
+	# Send MLD General Query from the remote host
+	tst_rhost_run -s -c "ns-icmpv6_sender -I $rhost_ifname -S $rhost_linklocal -m -r 0 -t $NS_DURATION"
 
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
-
-killall -SIGHUP ns-mcast_join >/dev/null 2>&1
-tst_resm TPASS "Test is finished successfully."
+	tst_res TPASS "Test is finished successfully."
+}
 
-exit 0
+tst_run
diff --git a/testcases/network/stress/multicast/query-flood/mcast6-queryfld02 b/testcases/network/stress/multicast/query-flood/mcast6-queryfld02
index 17cdae75d..e6b9cec06 100644
--- a/testcases/network/stress/multicast/query-flood/mcast6-queryfld02
+++ b/testcases/network/stress/multicast/query-flood/mcast6-queryfld02
@@ -43,40 +43,23 @@
 #trace_logic=${trace_logic:-"set -x"}
 $trace_logic
 
-# The test case ID, the test case count and the total number of test case
-TCID=mcast6-queryfld02
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
-NS_DURATION=${NS_DURATION:-3600}	# 1 hour
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
 # Prefix of the Multicast Address
 MCAST_ADDR_PREFIX=ff0e:
 
 # Multicast Address
 MCAST_ADDR=ff0e::1	# If you modify this, please refer ns-mcast_join.c
 
+. tst_net.sh
+
 #-----------------------------------------------------------------------
 #
 # Function: do_cleanup
@@ -87,13 +70,9 @@ MCAST_ADDR=ff0e::1	# If you modify this, please refer ns-mcast_join.c
 #-----------------------------------------------------------------------
 do_cleanup()
 {
-    # Make sure to kill the multicast receiver and sender
-    killall -SIGHUP ns-mcast_join >/dev/null 2>&1
-    $LTP_RSH $RHOST killall -SIGHUP ns-icmpv6_sender >/dev/null 2>&1
-
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
+	# Make sure to kill the multicast receiver and sender
+	killall -SIGHUP ns-mcast_join >/dev/null 2>&1
+	tst_rhost_run -c "ns-icmpv6_sender >/dev/null 2>&1"
 }
 
 
@@ -107,59 +86,16 @@ do_cleanup()
 #-----------------------------------------------------------------------
 do_setup()
 {
-    # Initialize the system configuration
-    do_cleanup
-
-    # Call do_cleanup function before exit
-    trap do_cleanup 0
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
+	local lhost_ifname=$(tst_iface lhost ${LINK_NUM})
 
-    add_ipv6addr rhost $LINK_NUM $NETWORK_PART $RHOST_HOST_PART
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add any IP address at the remote host"
-	exit 1
-    fi
-
-    # IPv6 address of the local/remote host
-    lhost_addr="${NETWORK_PART}:${LHOST_HOST_PART}"
-    rhost_addr="${NETWORK_PART}:${RHOST_HOST_PART}"
-    rhost_linklocal="fe80:${RHOST_HOST_PART}"
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
+	# Make sure the sysctl values
+	sysctl -w net.ipv6.conf.all.force_mld_version=0 >/dev/null
+	if [ $? -ne 0 ]; then
+		tst_brk TBROK "Failed to set the sysctl value regarding multicast"
+	fi
 
-    sysctl -w net.ipv6.conf.${lhost_ifname}.force_mld_version=0 >/dev/null
-    sysctl -w net.ipv6.mld_max_msf=10 >/dev/null
+	sysctl -w net.ipv6.conf.${lhost_ifname}.force_mld_version=0 >/dev/null
+	sysctl -w net.ipv6.mld_max_msf=10 >/dev/null
 }
 
 
@@ -169,31 +105,25 @@ do_setup()
 #
 #
 
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed when joining an IPv6 multicast group on a single socket, then receiving a large number of Multicast Address Specific Query in $NS_DURATION [sec]"
-
-do_setup
+test_body()
+{
+	local lhost_ifname=$(tst_iface lhost ${LINK_NUM})
+	local rhost_ifname=$(tst_iface rhost ${LINK_NUM})
+	local rhost_linklocal=$(tst_ipaddr lhost ${LINK_NUM})
 
-# Run a multicast join tool
-ns-mcast_join -f 6 -I $lhost_ifname -n 1 -p $MCAST_ADDR_PREFIX >/dev/null
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to start multicast joining tool Please check the environment"
-    exit 1
-fi
+	# Test description
+	tst_res TINFO "Verify that the kernel is not crashed when joining an IPv6 multicast group on a single socket, then receiving a large number of Multicast Address Specific Query in $NS_DURATION [sec]"
 
-# Send MLD Multicast Address Specific Query from the remote host
-ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-icmpv6_sender -I $rhost_ifname -S $rhost_linklocal -m -D $MCAST_ADDR -r 0 -t $NS_DURATION' ; echo $?'`
-if [ $ret -ne 0 ]; then
-    tst_resm TBROK "Failed to start MLD querier"
-    exit 1
-fi
+    # Run a multicast join tool
+    ns-mcast_join -f 6 -I $lhost_ifname -n 1 -p $MCAST_ADDR_PREFIX >/dev/null
+    if [ $? -ne 0 ]; then
+        tst_brk TBROK "Failed to start multicast joining tool Please check the environment"
+    fi
 
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
+    # Send MLD Multicast Address Specific Query from the remote host
+    tst_rhost_run -s -c "ns-icmpv6_sender -I $rhost_ifname -S $rhost_linklocal -m -D $MCAST_ADDR -r 0 -t $NS_DURATION"
 
-killall -SIGHUP ns-mcast_join >/dev/null 2>&1
-tst_resm TPASS "Test is finished successfully."
+    tst_res TPASS "Test is finished successfully."
+}
 
-exit 0
+tst_run
diff --git a/testcases/network/stress/multicast/query-flood/mcast6-queryfld03 b/testcases/network/stress/multicast/query-flood/mcast6-queryfld03
index bac7726a9..5b39b0875 100644
--- a/testcases/network/stress/multicast/query-flood/mcast6-queryfld03
+++ b/testcases/network/stress/multicast/query-flood/mcast6-queryfld03
@@ -43,34 +43,15 @@
 #trace_logic=${trace_logic:-"set -x"}
 $trace_logic
 
-# The test case ID, the test case count and the total number of test case
-TCID=mcast6-queryfld03
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
-NS_DURATION=${NS_DURATION:-3600}	# 1 hour
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
 # Prefix of the Multicast Address
 MCAST_ADDR_PREFIX=ff0e:
 
@@ -83,6 +64,8 @@ SRC_ADDR=fec0:100:100:100::1
 # Filter Mode
 FILTER_MODE="include"
 
+. tst_net.sh
+
 #-----------------------------------------------------------------------
 #
 # Function: do_cleanup
@@ -93,13 +76,9 @@ FILTER_MODE="include"
 #-----------------------------------------------------------------------
 do_cleanup()
 {
-    # Make sure to kill the multicast receiver and sender
-    killall -SIGHUP ns-mcast_join >/dev/null 2>&1
-    $LTP_RSH $RHOST killall -SIGHUP ns-icmpv6_sender >/dev/null 2>&1
-
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
+	# Make sure to kill the multicast receiver and sender
+	killall -SIGHUP ns-mcast_join >/dev/null 2>&1
+	tst_rhost_run -c "ns-icmpv6_sender >/dev/null 2>&1"
 }
 
 
@@ -113,59 +92,16 @@ do_cleanup()
 #-----------------------------------------------------------------------
 do_setup()
 {
-    # Initialize the system configuration
-    do_cleanup
-
-    # Call do_cleanup function before exit
-    trap do_cleanup 0
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
-    rhost_linklocal="fe80:${RHOST_HOST_PART}"
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
+	local lhost_ifname=$(tst_iface lhost ${LINK_NUM})
+
+	# Make sure the sysctl values
+	sysctl -w net.ipv6.conf.all.force_mld_version=0 >/dev/null
+	if [ $? -ne 0 ]; then
+		tst_brk TBROK "Failed to set the sysctl value regarding multicast"
+	fi
+
+	sysctl -w net.ipv6.conf.${lhost_ifname}.force_mld_version=0 >/dev/null
+	sysctl -w net.ipv6.mld_max_msf=10 >/dev/null
 }
 
 
@@ -175,31 +111,25 @@ do_setup()
 #
 #
 
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed when joining an IPv6 multicast group on a single socket, then receiving a large number of Multicast Address and Source Specific Query in $NS_DURATION [sec]"
+test_body()
+{
+	local lhost_ifname=$(tst_iface lhost ${LINK_NUM})
+	local rhost_ifname=$(tst_iface rhost ${LINK_NUM})
+	local rhost_linklocal=$(tst_ipaddr lhost ${LINK_NUM})
 
-do_setup
+	# Test description
+	tst_res TINFO "Verify that the kernel is not crashed when joining an IPv6 multicast group on a single socket, then receiving a large number of Multicast Address and Source Specific Query in $NS_DURATION [sec]"
 
-# Run a multicast join tool
-ns-mcast_join -f 6 -I $lhost_ifname -n 1 -p $MCAST_ADDR_PREFIX -s $SRC_ADDR -F $FILTER_MODE >/dev/null
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to start multicast joining tool Please check the environment"
-    exit 1
-fi
+	# Run a multicast join tool
+	ns-mcast_join -f 6 -I $lhost_ifname -n 1 -p $MCAST_ADDR_PREFIX -s $SRC_ADDR -F $FILTER_MODE >/dev/null
+	if [ $? -ne 0 ]; then
+		tst_brk TBROK "Failed to start multicast joining tool Please check the environment"
+	fi
 
-# Send MLD Multicast Address and Source Specific Query from the remote host
-ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-icmpv6_sender -I $rhost_ifname -S $rhost_linklocal -m -D $MCAST_ADDR -a $SRC_ADDR -r 0 -t $NS_DURATION' ; echo $?'`
-if [ $ret -ne 0 ]; then
-    tst_resm TBROK "Failed to start MLD querier"
-    exit 1
-fi
+	# Send MLD Multicast Address and Source Specific Query from the remote host
+	tst_rhost_run -s -c "ns-icmpv6_sender -I $rhost_ifname -S $rhost_linklocal -m -D $MCAST_ADDR -a $SRC_ADDR -r 0 -t $NS_DURATION"
 
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
-
-killall -SIGHUP ns-mcast_join >/dev/null 2>&1
-tst_resm TPASS "Test is finished successfully."
+	tst_res TPASS "Test is finished successfully."
+}
 
-exit 0
+tst_run
diff --git a/testcases/network/stress/multicast/query-flood/mcast6-queryfld04 b/testcases/network/stress/multicast/query-flood/mcast6-queryfld04
index cd56d4b40..75b10b801 100644
--- a/testcases/network/stress/multicast/query-flood/mcast6-queryfld04
+++ b/testcases/network/stress/multicast/query-flood/mcast6-queryfld04
@@ -42,40 +42,19 @@
 #trace_logic=${trace_logic:-"set -x"}
 $trace_logic
 
-# The test case ID, the test case count and the total number of test case
-TCID=mcast6-queryfld04
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
-NS_DURATION=${NS_DURATION:-3600}	# 1 hour
-
-# Number of the multicast to join
-MCASTNUM_NORMAL=${MCASTNUM_NORMAL:-20}
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
 # Prefix of the Multicast Address
 MCAST_ADDR_PREFIX=ff0e:
 
+. tst_net.sh
 
 #-----------------------------------------------------------------------
 #
@@ -87,16 +66,13 @@ MCAST_ADDR_PREFIX=ff0e:
 #-----------------------------------------------------------------------
 do_cleanup()
 {
-    # Make sure to kill the multicast receiver and sender
-    killall -SIGHUP ns-mcast_join >/dev/null 2>&1
-    $LTP_RSH $RHOST killall -SIGHUP ns-icmpv6_sender >/dev/null 2>&1
-
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
+	# Make sure to kill the multicast receiver and sender
+	killall -SIGHUP ns-mcast_join >/dev/null 2>&1
+	tst_rhost_run -c "ns-icmpv6_sender >/dev/null 2>&1"
 }
 
 
+
 #-----------------------------------------------------------------------
 #
 # Function: do_setup
@@ -107,59 +83,16 @@ do_cleanup()
 #-----------------------------------------------------------------------
 do_setup()
 {
-    # Initialize the system configuration
-    do_cleanup
-
-    # Call do_cleanup function before exit
-    trap do_cleanup 0
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
-    rhost_linklocal="fe80:${RHOST_HOST_PART}"
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
+	local lhost_ifname=$(tst_iface lhost ${LINK_NUM})
+
+	# Make sure the sysctl values
+	sysctl -w net.ipv6.conf.all.force_mld_version=0 >/dev/null
+	if [ $? -ne 0 ]; then
+		tst_brk TBROK "Failed to set the sysctl value regarding multicast"
+	fi
+
+	sysctl -w net.ipv6.conf.${lhost_ifname}.force_mld_version=0 >/dev/null
+	sysctl -w net.ipv6.mld_max_msf=10 >/dev/null
 }
 
 
@@ -169,31 +102,25 @@ do_setup()
 #
 #
 
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed when joining $MCASTNUM_NORMAL IPv6 multicast groups on separate sockets, then receiving a large number of General Query in $NS_DURATION [sec]"
-
-do_setup
+test_body()
+{
+	local lhost_ifname=$(tst_iface lhost ${LINK_NUM})
+	local rhost_ifname=$(tst_iface rhost ${LINK_NUM})
+	local rhost_linklocal=$(tst_ipaddr lhost ${LINK_NUM})
 
-# Run a multicast join tool
-ns-mcast_join -f 6 -I $lhost_ifname -n $MCASTNUM_NORMAL -p $MCAST_ADDR_PREFIX >/dev/null
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to start multicast joining tool Please check the environment"
-    exit 1
-fi
+	# Test description
+	tst_res TINFO "Verify that the kernel is not crashed when joining $MCASTNUM_NORMAL IPv6 multicast groups on separate sockets, then receiving a large number of General Query in $NS_DURATION [sec]"
 
-# Send MLD General Query from the remote host
-ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-icmpv6_sender -I $rhost_ifname -S $rhost_linklocal -m -r 0 -t $NS_DURATION' ; echo $?'`
-if [ $ret -ne 0 ]; then
-    tst_resm TBROK "Failed to start MLD querier"
-    exit 1
-fi
+	# Run a multicast join tool
+	ns-mcast_join -f 6 -I $lhost_ifname -n $MCASTNUM_NORMAL -p $MCAST_ADDR_PREFIX >/dev/null
+	if [ $? -ne 0 ]; then
+		tst_brk TBROK "Failed to start multicast joining tool Please check the environment"
+	fi
 
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
+	# Send MLD General Query from the remote host
+	tst_rhost_run -s -c "ns-icmpv6_sender -I $rhost_ifname -S $rhost_linklocal -m -r 0 -t $NS_DURATION"
 
-killall -SIGHUP ns-mcast_join >/dev/null 2>&1
-tst_resm TPASS "Test is finished successfully."
+	tst_res TPASS "Test is finished successfully."
+}
 
-exit 0
+tst_run
diff --git a/testcases/network/stress/multicast/query-flood/mcast6-queryfld05 b/testcases/network/stress/multicast/query-flood/mcast6-queryfld05
index 84c2ee109..5cae71ed3 100644
--- a/testcases/network/stress/multicast/query-flood/mcast6-queryfld05
+++ b/testcases/network/stress/multicast/query-flood/mcast6-queryfld05
@@ -43,40 +43,20 @@
 #trace_logic=${trace_logic:-"set -x"}
 $trace_logic
 
-# The test case ID, the test case count and the total number of test case
-TCID=mcast6-queryfld05
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
-NS_DURATION=${NS_DURATION:-3600}	# 1 hour
-
-# Number of the multicast to join
-MCASTNUM_NORMAL=${MCASTNUM_NORMAL:-20}
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
 # Prefix of the Multicast Address
 MCAST_ADDR_PREFIX=ff0e:
 
+. tst_net.sh
+
 #-----------------------------------------------------------------------
 #
 # Function: do_cleanup
@@ -87,13 +67,9 @@ MCAST_ADDR_PREFIX=ff0e:
 #-----------------------------------------------------------------------
 do_cleanup()
 {
-    # Make sure to kill the multicast receiver and sender
-    killall -SIGHUP ns-mcast_join >/dev/null 2>&1
-    $LTP_RSH $RHOST killall -SIGHUP ns-icmpv6_sender >/dev/null 2>&1
-
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
+	# Make sure to kill the multicast receiver and sender
+	killall -SIGHUP ns-mcast_join >/dev/null 2>&1
+	tst_rhost_run -c "ns-icmpv6_sender >/dev/null 2>&1"
 }
 
 
@@ -107,59 +83,16 @@ do_cleanup()
 #-----------------------------------------------------------------------
 do_setup()
 {
-    # Initialize the system configuration
-    do_cleanup
-
-    # Call do_cleanup function before exit
-    trap do_cleanup 0
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
-    rhost_linklocal="fe80:${RHOST_HOST_PART}"
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
+	local lhost_ifname=$(tst_iface lhost ${LINK_NUM})
+
+	# Make sure the sysctl values
+	sysctl -w net.ipv6.conf.all.force_mld_version=0 >/dev/null
+	if [ $? -ne 0 ]; then
+		tst_brk TBROK "Failed to set the sysctl value regarding multicast"
+	fi
+
+	sysctl -w net.ipv6.conf.${lhost_ifname}.force_mld_version=0 >/dev/null
+	sysctl -w net.ipv6.mld_max_msf=10 >/dev/null
 }
 
 
@@ -169,41 +102,40 @@ do_setup()
 #
 #
 
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed when joining $MCASTNUM_NORMAL IPv6 multicast groups on separate sockets, then receiving a large number of Multicast Address Specific Query in $NS_DURATION [sec]"
-
-do_setup
-
-# Run a multicast join tool
-ns-mcast_join -f 6 -I $lhost_ifname -n $MCASTNUM_NORMAL -p $MCAST_ADDR_PREFIX > /dev/null
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to start multicast joining tool Please check the environment"
-    exit 1
-fi
-
-# Send MLD Multicast Address Specific Query from the remote host
-querier_num=0
-while [ $querier_num -lt $MCASTNUM_NORMAL ]; do
-    # Define the multicast address
-    if [ $querier_num -gt 65535 ]; then
-	tst_resm TINFO "The number of the querier is less than 65535"
-	break
-    fi
-    querier_num_hex=`printf "%x" $querier_num`
-    mcast_addr=${MCAST_ADDR_PREFIX}:${querier_num_hex}
-
-    $LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-icmpv6_sender -I $rhost_ifname -S $rhost_linklocal -m -D $mcast_addr -r 0 -t $NS_DURATION -b
-
-    querier_num=`expr $querier_num + 1`
-done
-sleep $NS_DURATION
-
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
-
-do_cleanup
-tst_resm TPASS "Test is finished successfully."
+test_body()
+{
+	local lhost_ifname=$(tst_iface lhost ${LINK_NUM})
+	local rhost_ifname=$(tst_iface rhost ${LINK_NUM})
+	local rhost_linklocal=$(tst_ipaddr lhost ${LINK_NUM})
+
+	# Test description
+	tst_res TINFO "Verify that the kernel is not crashed when joining $MCASTNUM_NORMAL IPv6 multicast groups on separate sockets, then receiving a large number of Multicast Address Specific Query in $NS_DURATION [sec]"
+
+	# Run a multicast join tool
+	ns-mcast_join -f 6 -I $lhost_ifname -n $MCASTNUM_NORMAL -p $MCAST_ADDR_PREFIX > /dev/null
+	if [ $? -ne 0 ]; then
+		tst_brk TBROK "Failed to start multicast joining tool Please check the environment"
+	fi
+
+	# Send MLD Multicast Address Specific Query from the remote host
+	querier_num=0
+	while [ $querier_num -lt $MCASTNUM_NORMAL ]; do
+		# Define the multicast address
+		if [ $querier_num -gt 65535 ]; then
+			tst_res TINFO "The number of the querier is less than 65535"
+			break
+		fi
+		querier_num_hex=`printf "%x" $querier_num`
+		mcast_addr=${MCAST_ADDR_PREFIX}:${querier_num_hex}
+
+		tst_rhost_run -c "ns-icmpv6_sender -I $rhost_ifname -S $rhost_linklocal -m -D $mcast_addr -r 0 -t $NS_DURATION -b"
+
+		querier_num=`expr $querier_num + 1`
+	done
+
+	sleep $NS_DURATION
+
+	tst_res TPASS "Test is finished successfully."
+}
 
-exit 0
+tst_run
diff --git a/testcases/network/stress/multicast/query-flood/mcast6-queryfld06 b/testcases/network/stress/multicast/query-flood/mcast6-queryfld06
index d94a78efe..507037ab0 100644
--- a/testcases/network/stress/multicast/query-flood/mcast6-queryfld06
+++ b/testcases/network/stress/multicast/query-flood/mcast6-queryfld06
@@ -43,37 +43,15 @@
 #trace_logic=${trace_logic:-"set -x"}
 $trace_logic
 
-# The test case ID, the test case count and the total number of test case
-TCID=mcast6-queryfld06
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
-NS_DURATION=${NS_DURATION:-3600}	# 1 hour
-
-# Number of the multicast to join
-MCASTNUM_NORMAL=${MCASTNUM_NORMAL:-20}
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
 # Prefix of the Multicast Address
 MCAST_ADDR_PREFIX=ff0e:
 
@@ -83,6 +61,8 @@ SRC_ADDR=fec0:100:100:100::1
 # Filter Mode
 FILTER_MODE="include"
 
+. tst_net.sh
+
 #-----------------------------------------------------------------------
 #
 # Function: do_cleanup
@@ -93,16 +73,11 @@ FILTER_MODE="include"
 #-----------------------------------------------------------------------
 do_cleanup()
 {
-    # Make sure to kill the multicast receiver and sender
-    killall -SIGHUP ns-mcast_join >/dev/null 2>&1
-    $LTP_RSH $RHOST killall -SIGHUP ns-icmpv6_sender >/dev/null 2>&1
-
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
+	# Make sure to kill the multicast receiver and sender
+	killall -SIGHUP ns-mcast_join >/dev/null 2>&1
+	tst_rhost_run -c "ns-icmpv6_sender >/dev/null 2>&1"
 }
 
-
 #-----------------------------------------------------------------------
 #
 # Function: do_setup
@@ -113,59 +88,16 @@ do_cleanup()
 #-----------------------------------------------------------------------
 do_setup()
 {
-    # Initialize the system configuration
-    do_cleanup
-
-    # Call do_cleanup function before exit
-    trap do_cleanup 0
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
-    rhost_linklocal="fe80:${RHOST_HOST_PART}"
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
+	local lhost_ifname=$(tst_iface lhost ${LINK_NUM})
+
+	# Make sure the sysctl values
+	sysctl -w net.ipv6.conf.all.force_mld_version=0 >/dev/null
+	if [ $? -ne 0 ]; then
+		tst_brk TBROK "Failed to set the sysctl value regarding multicast"
+	fi
+
+	sysctl -w net.ipv6.conf.${lhost_ifname}.force_mld_version=0 >/dev/null
+	sysctl -w net.ipv6.mld_max_msf=10 >/dev/null
 }
 
 
@@ -175,39 +107,38 @@ do_setup()
 #
 #
 
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed when joining $MCASTNUM_NORMAL IPv6 multicast groups on separate sockets, then receiving a large number of Multicast Address and Source Specific Query in $NS_DURATION [sec]"
-
-do_setup
-
-# Run a multicast join tool
-ns-mcast_join -f 6 -I $lhost_ifname -n $MCASTNUM_NORMAL -p $MCAST_ADDR_PREFIX -s $SRC_ADDR -F $FILTER_MODE > /dev/null
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to start multicast joining tool Please check the environment"
-    exit 1
-fi
-
-# Send MLD Multicast Address Specific Query from the remote host
-querier_num=0
-while [ $querier_num -lt $MCASTNUM_NORMAL ]; do
-    if [ $querier_num -gt 65535 ]; then
-	tst_resm TINFO "The number of the querier is less than 65535"
-	break
-    fi
-    querier_num_hex=`printf "%x" $querier_num`
-    mcast_addr=${MCAST_ADDR_PREFIX}:${querier_num_hex}
-
-    $LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-icmpv6_sender -I $rhost_ifname -S $rhost_linklocal -m -D $mcast_addr -a $SRC_ADDR -r 0 -t $NS_DURATION -b
-    querier_num=`expr $querier_num + 1`
-done
-sleep $NS_DURATION
-
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
-
-do_cleanup
-tst_resm TPASS "Test is finished successfully."
+test_body()
+{
+	local lhost_ifname=$(tst_iface lhost ${LINK_NUM})
+	local rhost_ifname=$(tst_iface rhost ${LINK_NUM})
+	local rhost_linklocal=$(tst_ipaddr lhost ${LINK_NUM})
+
+	# Test description
+	tst_res TINFO "Verify that the kernel is not crashed when joining $MCASTNUM_NORMAL IPv6 multicast groups on separate sockets, then receiving a large number of Multicast Address and Source Specific Query in $NS_DURATION [sec]"
+
+	# Run a multicast join tool
+	ns-mcast_join -f 6 -I $lhost_ifname -n $MCASTNUM_NORMAL -p $MCAST_ADDR_PREFIX -s $SRC_ADDR -F $FILTER_MODE > /dev/null
+	if [ $? -ne 0 ]; then
+		tst_brk TBROK "Failed to start multicast joining tool Please check the environment"
+	fi
+
+	# Send MLD Multicast Address Specific Query from the remote host
+	querier_num=0
+	while [ $querier_num -lt $MCASTNUM_NORMAL ]; do
+		if [ $querier_num -gt 65535 ]; then
+			tst_res TINFO "The number of the querier is less than 65535"
+			break
+		fi
+		querier_num_hex=`printf "%x" $querier_num`
+		mcast_addr=${MCAST_ADDR_PREFIX}:${querier_num_hex}
+
+		tst_rhost_run -c "ns-icmpv6_sender -I $rhost_ifname -S $rhost_linklocal -m -D $mcast_addr -a $SRC_ADDR -r 0 -t $NS_DURATION -b"
+		querier_num=`expr $querier_num + 1`
+	done
+
+	sleep $NS_DURATION
+
+	tst_res TPASS "Test is finished successfully."
+}
 
-exit 0
+tst_run
-- 
2.25.1

