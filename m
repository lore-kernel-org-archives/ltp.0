From: Joerg Vehlow <lkml@jv-coder.de>
Date: Mon, 16 Nov 2020 13:46:11 +0100
Subject: [LTP] [PATCH 3/3] network/stress/route: Convert to tst_net.sh
In-Reply-To: <20201116124611.16919-1-lkml@jv-coder.de>
References: <20201116124611.16919-1-lkml@jv-coder.de>
Message-ID: <20201116124611.16919-4-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 .../network/stress/route/route4-redirect      | 155 +++++-------------
 .../network/stress/route/route6-redirect      | 143 ++++------------
 2 files changed, 74 insertions(+), 224 deletions(-)

diff --git a/testcases/network/stress/route/route4-redirect b/testcases/network/stress/route/route4-redirect
index 53df9abf2..8c0b09347 100644
--- a/testcases/network/stress/route/route4-redirect
+++ b/testcases/network/stress/route/route4-redirect
@@ -42,26 +42,10 @@
 #trace_logic=${trace_logic:-"set -x"}
 $trace_logic
 
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
+TST_TESTFUNC=test_body
+TST_NEEDS_ROOT=1
+TST_SETUP=do_setup
+TST_CLEANUP=do_cleanup
 
 # The number of the test link where tests run
 LINK_NUM=${LINK_NUM:-0}
@@ -69,14 +53,7 @@ LINK_NUM=${LINK_NUM:-0}
 # Network portion of the IPv4 address
 IPV4_NETWORK=${IPV4_NETWORK:-"10.0.0"}
 
-# Netmask of for the tested network
-IPV4_NETMASK_NUM=24
-
-# Broadcast address of the tested network
-IPV4_BROADCAST=${IPV4_NETWORK}.255
-
 # Host portion of the IPv4 address
-LHOST_IPV4_HOST=${LHOST_IPV4_HOST:-"1"}	# src
 RHOST_IPV4_HOST="2"	# gateway
 
 # The destination network
@@ -84,24 +61,12 @@ DST_NETWORK="10.10.0"   # destination network would be 10.10.0.0/24
 DST_HOST="5"
 DST_PORT="7"
 
+. tst_net.sh
 
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
+	# Kill the redirector utility
+	tst_rhost_run -c "killall -SIGHUP ns-icmp_redirector >/dev/null 2>&1"
 }
 
 
@@ -113,55 +78,25 @@ do_cleanup()
 # DESCRIPTION:
 #   Set the initial route and start icmp redirect on the remote host
 #
-# SET VALUES:
-#   rhost_ipv4addr      - IPv4 Address of the remote host
-#   lhost_ifname        - Interface name of the local host
-#   rhost_ifname        - Interface name of the remote host
-#
 #-----------------------------------------------------------------------
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
-
-    # Remove the link-local address of the remote host
-    sleep 3
-    $LTP_RSH $RHOST "ip addr flush dev $rhost_ifname" > /dev/null
-
-    # Assign IPv4 address to the interface of the local host
-    set_ipv4addr lhost ${LINK_NUM} ${IPV4_NETWORK} ${LHOST_IPV4_HOST}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to assign an IPv4 address at the local host"
-	return 1
-    fi
-
-    # Add route to the initial gateway
-    route add -net ${DST_NETWORK}.0 netmask 255.255.255.0 gw ${IPV4_NETWORK}.${RHOST_IPV4_HOST} dev $lhost_ifname
-
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
+	local lhost_ifname=$(tst_iface lhost ${LINK_NUM})
+	local rhost_ifname=$(tst_iface rhost ${LINK_NUM})
+
+	# Remove the link-local address of the remote host
+	sleep 3
+	tst_rhost_run -s -c "ip addr flush dev $rhost_ifname"
+
+	# Add route to the initial gateway
+	route add -net ${DST_NETWORK}.0 netmask 255.255.255.0 gw ${IPV4_NETWORK}.${RHOST_IPV4_HOST} dev $lhost_ifname
+
+	# Make sure the sysctl value is set for accepting the redirect
+	sysctl -w net.ipv4.conf.${lhost_ifname}.accept_redirects=1 >/dev/null
+	sysctl -w net.ipv4.conf.${lhost_ifname}.secure_redirects=0 >/dev/null
+
+	# Run the redirector utility at the remote host
+	tst_rhost_run -s -c "ns-icmp_redirector -I $rhost_ifname -b"
 }
 
 
@@ -180,33 +115,21 @@ do_setup()
 #-----------------------------------------------------------------------
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
+	# Test description
+	tst_resm TINFO "Verify the kernel is not crashed when the IPv4 route is modified by  ICMP Redirects frequently"
+	# Loop for changing the route
+	cnt=0
+	while [ $cnt -lt $NS_TIMES ]; do
+		ns-udpsender -f 4 -D ${DST_NETWORK}.${DST_HOST} -p $DST_PORT -o -s 8
+		if [ $? -ne 0 ]; then
+			tst_res TBROK "Failed to run udp packet sender"
+			return 1
+		fi
+		cnt=`expr $cnt + 1`
+	done
+
+	tst_res TPASS "Test is finished correctly."
+	return 0
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
-do_setup
-test_body || RC=`expr $RC + 1`
-do_cleanup
-
-exit $RC
+tst_run
diff --git a/testcases/network/stress/route/route6-redirect b/testcases/network/stress/route/route6-redirect
index e12c7c816..8ecbdd626 100644
--- a/testcases/network/stress/route/route6-redirect
+++ b/testcases/network/stress/route/route6-redirect
@@ -42,26 +42,11 @@
 #trace_logic=${trace_logic:-"set -x"}
 $trace_logic
 
-# The test case ID, the test case count and the total number of test case
-TCID=route6-redirect01
-TST_TOTAL=1
-TST_COUNT=1
-export TCID
-export TST_COUNT
-export TST_TOTAL
-
-# Test description
-tst_resm TINFO "Verify the kernel is not crashed when the IPv6 route is modified by  ICMP Redirects frequently"
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
+TST_TESTFUNC=test_body
+TST_NEEDS_ROOT=1
+TST_IPV6=1
+TST_SETUP=do_setup
+TST_CLEANUP=do_cleanup
 
 # The number of the test link where tests run
 LINK_NUM=${LINK_NUM:-0}
@@ -81,24 +66,11 @@ DST_NETWORK="fec0:100:100:100"   # destination network
 DST_HOST=":5"
 DST_PORT="7"
 
+. tst_net.sh
 
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
+	tst_rhost_run -c "killall -SIGHUP ns-icmp_redirector >/dev/null 2>&1"
 }
 
 
@@ -110,54 +82,25 @@ do_cleanup()
 # DESCRIPTION:
 #   Set the initial route and start icmp redirect on the remote host
 #
-# SET VALUES:
-#   rhost_ipv6addr      - IPv6 Address of the remote host
-#   lhost_ifname        - Interface name of the local host
-#   rhost_ifname        - Interface name of the remote host
-#
 #-----------------------------------------------------------------------
 do_setup()
 {
-    # Make sure to cleanup the test environment
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
-
-    # Remove the link-local address of the remote host
-    sleep 5
-    $LTP_RSH $RHOST "ip addr flush dev $rhost_ifname" > /dev/null
-
-    # Assign IPv6 address to the interface of the local host
-    add_ipv6addr lhost ${LINK_NUM} ${IPV6_NETWORK} ${LHOST_IPV6_HOST}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to assign an IPv6 address at the local host"
-	return 1
-    fi
-
-    # Add route to the initial gateway
-    route -A inet6 add ${DST_NETWORK}::/64 gw fe80:${RHOST_IPV6_HOST} dev $lhost_ifname
-
-    # Make sure the sysctl value is set for accepting the redirect
-    sysctl -w net.ipv6.conf.${lhost_ifname}.accept_redirects=1 >/dev/null
-
-    # Run the redirector utility at the remote host
-    ret=`$LTP_RSH $RHOST "${LTPROOT}/testcases/bin/ns-icmp_redirector -I $rhost_ifname -b ; "'echo $?'`
-    if [ $ret -ne 0 ]; then
-	tst_resm TBROK "Failed to run icmp redirector at the remote host"
-	exit $TST_TOTAL
-    fi
+	local lhost_ifname=$(tst_iface lhost ${LINK_NUM})
+	local rhost_ifname=$(tst_iface rhost ${LINK_NUM})
+	
+	# Remove the link-local address of the remote host
+	sleep 3
+	tst_rhost_run -s -c "ip addr flush dev $rhost_ifname"
+	tst_rhost_run -s -c "ip addr add ${IPV6_NETWORK}:${LHOST_IPV6_HOST}/${IPV6_NETMASK_NUM} dev ${rhost_ifname}"
+
+	# Add route to the initial gateway
+	route -A inet6 add ${DST_NETWORK}::/${IPV6_NETMASK_NUM} gw fe80:${RHOST_IPV6_HOST} dev $lhost_ifname
+
+	# Make sure the sysctl value is set for accepting the redirect
+	sysctl -w net.ipv6.conf.${lhost_ifname}.accept_redirects=1 >/dev/null
+
+	# Run the redirector utility at the remote host
+	tst_rhost_run -s -c "ns-icmp_redirector -I $rhost_ifname -b"
 }
 
 
@@ -175,33 +118,17 @@ do_setup()
 #-----------------------------------------------------------------------
 test_body()
 {
-    # Loop for changing the route
-    cnt=0
-    while [ $cnt -lt $NS_TIMES ]; do
-	ns-udpsender -f 6 -D ${DST_NETWORK}:${DST_HOST} -p $DST_PORT -o -s 8
-	if [ $? -ne 0 ]; then
-	    tst_resm TBROK "Failed to run udp packet sender"
-	    return 1
-	fi
-	cnt=`expr $cnt + 1`
-    done
-
-    tst_resm TPASS "Test is finished correctly."
-    return 0
+	# Loop for changing the route
+	cnt=0
+	while [ $cnt -lt $NS_TIMES ]; do
+		ns-udpsender -f 6 -D ${DST_NETWORK}:${DST_HOST} -p $DST_PORT -o -s 8
+		if [ $? -ne 0 ]; then
+			tst_brk TBROK "Failed to run udp packet sender"
+		fi
+		cnt=`expr $cnt + 1`
+	done
+
+	tst_res TPASS "Test is finished correctly."
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
-do_setup
-test_body || RC=`expr $RC + 1`
-do_cleanup
-
-exit $RC
+tst_run
-- 
2.25.1

