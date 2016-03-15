From: Hangbin Liu <haliu@redhat.com>
Date: Tue, 15 Mar 2016 17:50:39 +0800
Subject: [LTP] [PATCHv2 3/3] network/stress/icmp: use ip xfrm for
	icmp4-uni-basic01 ipsec testing
In-Reply-To: <1458035439-9143-1-git-send-email-haliu@redhat.com>
References: <1458035439-9143-1-git-send-email-haliu@redhat.com>
Message-ID: <1458035439-9143-4-git-send-email-haliu@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Also check each msg_size in $ICMP_SIZE_ARRAY to make sure the connectvity.

Signed-off-by: Hangbin Liu <haliu@redhat.com>
---
 .../stress/icmp/uni-basic/icmp4-uni-basic01        | 96 +++++++---------------
 1 file changed, 31 insertions(+), 65 deletions(-)

diff --git a/testcases/network/stress/icmp/uni-basic/icmp4-uni-basic01 b/testcases/network/stress/icmp/uni-basic/icmp4-uni-basic01
index b78ac8f..93ddbbb 100644
--- a/testcases/network/stress/icmp/uni-basic/icmp4-uni-basic01
+++ b/testcases/network/stress/icmp/uni-basic/icmp4-uni-basic01
@@ -50,10 +50,13 @@ $trace_logic
 TCID=${TCID:-icmp4-uni-basic01}
 TST_TOTAL=1
 TST_COUNT=1
+TST_CLEANUP="do_cleanup"
 export TCID
 export TST_COUNT
 export TST_TOTAL
 
+. ipsec_lib.sh
+
 # Test description
 tst_resm TINFO "Verify that the kernel is not crashed with receiving and sending various size of ICMP message with the following conditions"
 
@@ -100,16 +103,12 @@ ICMP_SIZE_ARRAY=${ICMP_SIZE_ARRAY:-"10 100 1000 10000 65507"}
 #-----------------------------------------------------------------------
 do_cleanup()
 {
-    # Kill the icmp traffic server
-    killall_icmp_traffic
-
     # Unset SAD/SPD
-    output_ipsec_conf flush | setkey -c >/dev/null 2>&1
-    $LTP_RSH $RHOST ${LTPROOT}/'testcases/bin/output_ipsec_conf flush | PATH=/sbin:/usr/sbin:$PATH setkey -c' >/dev/null 2>&1
+    tst_ipsec flush
 
     # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
+    tst_init_iface lhost ${LINK_NUM}
+    tst_init_iface rhost ${LINK_NUM}
 }
 
 
@@ -127,10 +126,9 @@ tst_resm TINFO "- Version of IP is IPv${IP_VER}"
 tst_resm TINFO "- Size of packets are ( $ICMP_SIZE_ARRAY )"
 
 if $DO_IPSEC ; then
-    message=`check_setkey`
+    message=`ip xfrm state`
     if [ $? -ne 0 ]; then
-	tst_resm TBROK "$message"
-	exit 1
+	tst_brkm TBROK "$message"
     fi
 
     case $IPSEC_PROTO in
@@ -147,16 +145,14 @@ if $DO_IPSEC ; then
 fi
 
 # name of interface of the local/remote host
-lhost_ifname=`get_ifname lhost $LINK_NUM`
+lhost_ifname=`tst_iface lhost $LINK_NUM`
 if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to get the interface name at the local host"
-    exit $TST_TOTAL
+    tst_brkm TBROK "Failed to get the interface name at the local host"
 fi
 
-rhost_ifname=`get_ifname rhost $LINK_NUM`
+rhost_ifname=`tst_iface rhost $LINK_NUM`
 if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to get the interface name at the remote host"
-    exit $TST_TOTAL
+    tst_brkm TBROK "Failed to get the interface name at the remote host"
 fi
 
 # Initialize the system configuration
@@ -181,14 +177,12 @@ case $IP_VER in
     # Set IPv4 addresses to the interfaces
     set_ipv4addr lhost $LINK_NUM $network_part $lhost_host_part
     if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add any IP address at the local host"
-	exit 1
+	tst_brkm TBROK "Failed to add any IP address at the local host"
     fi
 
     set_ipv4addr rhost $LINK_NUM $network_part $rhost_host_part
     if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add any IP address at the remote host"
-	exit 1
+	tst_brkm TBROK "Failed to add any IP address at the remote host"
     fi
 
     # IPv4 address of the local/remote host
@@ -210,14 +204,12 @@ case $IP_VER in
     # Set IPv6 addresses to the interfaces
     add_ipv6addr lhost $LINK_NUM $network_part $lhost_host_part
     if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add any IP address at the local host"
-	exit 1
+	tst_brkm TBROK "Failed to add any IP address at the local host"
     fi
 
     add_ipv6addr rhost $LINK_NUM $network_part $rhost_host_part
     if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add any IP address at the remote host"
-	exit 1
+	tst_brkm TBROK "Failed to add any IP address at the remote host"
     fi
 
     # IPv6 address of the local/remote host
@@ -232,58 +224,32 @@ esac
 
 # Configure SAD/SPD
 if $DO_IPSEC ; then
-    ipsec_log=`mktemp -p $TMPDIR`
-
-    output_ipsec_conf src \
-	$IPSEC_PROTO $IPSEC_MODE $SPI $lhost_addr $rhost_addr \
-	    |  setkey -c 2>&1 | tee $ipsec_log
-    if [ $? -ne 0 -o -s $ipsec_log ]; then
-	tst_resm TBROK "Failed to configure SAD/SPD on the local host."
-	rm -f $ipsec_log
-	exit 1
+    tst_ipsec src $IPSEC_PROTO $IPSEC_MODE $SPI $lhost_addr $rhost_addr
+    if [ $? -ne 0 ]; then
+	tst_brkm TBROK "Failed to configure SAD/SPD on the local host."
     fi
 
-    $LTP_RSH $RHOST ${LTPROOT}/testcases/bin/output_ipsec_conf dst $IPSEC_PROTO $IPSEC_MODE $SPI $lhost_addr $rhost_addr' | PATH=/sbin:/usr/sbin:$PATH setkey -c' 2>&1 | tee $ipsec_log
-    if [ $? -ne 0 -o -s $ipsec_log ]; then
-	tst_resm TBROK "Failed to configure SAD/SPD on the remote host."
-	rm -f $ipsec_log
-	exit 1
+    tst_ipsec dst $IPSEC_PROTO $IPSEC_MODE $SPI $lhost_addr $rhost_addr
+    if [ $? -ne 0 ]; then
+	tst_brkm TBROK "Failed to configure SAD/SPD on the remote host."
     fi
-    rm -f $ipsec_log
 fi
 
-# Make sure the connectvity
-case $IP_VER in
-    4)
-    ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv4_connectivity $rhost_ifname $lhost_addr' ; echo $?'`
-    if [ $ret -ne 0 ]; then
-	tst_resm TBROK "There is no IPv4 connectivity."
-	exit 1
-    fi
-    ;;
-
-    6)
-    ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv6_connectivity $rhost_ifname $lhost_addr' ; echo $?'`
-    if [ $ret -ne 0 ]; then
-	tst_resm TBROK "There is no IPv6 connectivity."
-	exit 1
-    fi
-    ;;
-esac
-
-
 #-----------------------------------------------------------------------
 #
 # Main
 #
 #
 
-# Run a client
-$LTP_RSH $RHOST "${LTPROOT}/testcases/bin/ns-echoclient -S $lhost_addr -f $IP_VER -s \"$ICMP_SIZE_ARRAY\"" &
-
-sleep $NS_DURATION
-killall_icmp_traffic
-wait
+# Make sure the connectvity
+for msg_size in $ICMP_SIZE_ARRAY; do
+    tst_ping $lhost_ifname $rhost_addr $msg_size
+    if [ $? -ne 0 ]; then
+        tst_brkm TBROK "There is no IPv$IP_VER connectivity with msg_size $msg_size"
+    else
+        tst_resm TPASS "There has IPv$IP_VER connectivity with msg_size $msg_size"
+    fi
+done
 
 #-----------------------------------------------------------------------
 #
-- 
2.5.0

