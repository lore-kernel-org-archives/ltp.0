From: Hangbin Liu <haliu@redhat.com>
Date: Mon,  7 Mar 2016 15:14:43 +0800
Subject: [LTP] [PATCH 3/3] network/stress/icmp: use ip xfrm for
	icmp4-uni-basic01 ipsec testing
In-Reply-To: <1457334883-11086-1-git-send-email-haliu@redhat.com>
References: <1457334883-11086-1-git-send-email-haliu@redhat.com>
Message-ID: <1457334883-11086-4-git-send-email-haliu@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Also check each msg_size in $ICMP_SIZE_ARRAY to make sure the connectvity.

Signed-off-by: Hangbin Liu <haliu@redhat.com>
---
 .../stress/icmp/uni-basic/icmp4-uni-basic01        | 66 ++++++++--------------
 1 file changed, 22 insertions(+), 44 deletions(-)

diff --git a/testcases/network/stress/icmp/uni-basic/icmp4-uni-basic01 b/testcases/network/stress/icmp/uni-basic/icmp4-uni-basic01
index b78ac8f..55ddff5 100644
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
 
@@ -104,12 +107,11 @@ do_cleanup()
     killall_icmp_traffic
 
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
 
 
@@ -127,7 +129,7 @@ tst_resm TINFO "- Version of IP is IPv${IP_VER}"
 tst_resm TINFO "- Size of packets are ( $ICMP_SIZE_ARRAY )"
 
 if $DO_IPSEC ; then
-    message=`check_setkey`
+    message=`ip xfrm state`
     if [ $? -ne 0 ]; then
 	tst_resm TBROK "$message"
 	exit 1
@@ -147,13 +149,13 @@ if $DO_IPSEC ; then
 fi
 
 # name of interface of the local/remote host
-lhost_ifname=`get_ifname lhost $LINK_NUM`
+lhost_ifname=`tst_iface lhost $LINK_NUM`
 if [ $? -ne 0 ]; then
     tst_resm TBROK "Failed to get the interface name at the local host"
     exit $TST_TOTAL
 fi
 
-rhost_ifname=`get_ifname rhost $LINK_NUM`
+rhost_ifname=`tst_iface rhost $LINK_NUM`
 if [ $? -ne 0 ]; then
     tst_resm TBROK "Failed to get the interface name at the remote host"
     exit $TST_TOTAL
@@ -232,58 +234,34 @@ esac
 
 # Configure SAD/SPD
 if $DO_IPSEC ; then
-    ipsec_log=`mktemp -p $TMPDIR`
-
-    output_ipsec_conf src \
-	$IPSEC_PROTO $IPSEC_MODE $SPI $lhost_addr $rhost_addr \
-	    |  setkey -c 2>&1 | tee $ipsec_log
-    if [ $? -ne 0 -o -s $ipsec_log ]; then
+    tst_ipsec src $IPSEC_PROTO $IPSEC_MODE $SPI $lhost_addr $rhost_addr
+    if [ $? -ne 0 ]; then
 	tst_resm TBROK "Failed to configure SAD/SPD on the local host."
-	rm -f $ipsec_log
 	exit 1
     fi
 
-    $LTP_RSH $RHOST ${LTPROOT}/testcases/bin/output_ipsec_conf dst $IPSEC_PROTO $IPSEC_MODE $SPI $lhost_addr $rhost_addr' | PATH=/sbin:/usr/sbin:$PATH setkey -c' 2>&1 | tee $ipsec_log
-    if [ $? -ne 0 -o -s $ipsec_log ]; then
+    tst_ipsec dst $IPSEC_PROTO $IPSEC_MODE $SPI $lhost_addr $rhost_addr
+    if [ $? -ne 0 ]; then
 	tst_resm TBROK "Failed to configure SAD/SPD on the remote host."
-	rm -f $ipsec_log
 	exit 1
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
+    tst_ping $rhost_ifname $lhost_addr $msg_size
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

