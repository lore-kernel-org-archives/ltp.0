Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mmarhefk@redhat.com>) id 1Y1wlP-00020B-6w
	for ltp-list@lists.sourceforge.net; Fri, 19 Dec 2014 12:34:35 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Y1wlM-0002Lj-RR
	for ltp-list@lists.sourceforge.net; Fri, 19 Dec 2014 12:34:35 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sBJCYPOL025636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Fri, 19 Dec 2014 07:34:26 -0500
Received: from cc-vtoe10.lab.eng.brq.redhat.com ([10.34.89.68])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id sBJCYOEU020207
	for <ltp-list@lists.sourceforge.net>; Fri, 19 Dec 2014 07:34:25 -0500
From: Matus Marhefka <mmarhefk@redhat.com>
Date: Fri, 19 Dec 2014 13:34:17 +0100
Message-Id: <1418992457-13602-1-git-send-email-mmarhefk@redhat.com>
Subject: [LTP] [PATCH] containers: added timeouting for all netns test cases
	FIFO operations
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

In certain situations (failing to start sshd or pinging parent
namespace) there was a possibility of deadlock in a communication
over named pipes in network namespaces tests.

All test cases in netns/ directory now use tst_timeout
for timeouting all FIFO operations to prevent possible deadlocks.

Signed-off-by: Matus Marhefka <mmarhefk@redhat.com>
---
 testcases/kernel/containers/netns/netns_ch_ftp.sh  |  5 +++-
 testcases/kernel/containers/netns/netns_child_1.sh | 21 ++++++++++----
 testcases/kernel/containers/netns/netns_child_2.sh | 22 +++++++++++----
 .../containers/netns/netns_child_propagate.sh      | 10 +++++--
 .../kernel/containers/netns/netns_childipv6.sh     | 25 ++++++++++++----
 testcases/kernel/containers/netns/netns_childns.sh | 10 +++++--
 .../kernel/containers/netns/netns_delchild.sh      | 12 ++++++--
 .../kernel/containers/netns/netns_initialize.sh    | 16 +++++++----
 testcases/kernel/containers/netns/netns_par_ftp.sh | 12 ++++++--
 .../kernel/containers/netns/netns_parent_1.sh      | 10 +++++--
 .../kernel/containers/netns/netns_parent_2.sh      | 10 +++++--
 .../kernel/containers/netns/netns_parent_view.sh   | 10 +++++--
 .../kernel/containers/netns/netns_parentns.sh      | 10 +++++--
 testcases/kernel/containers/netns/netns_paripv6.sh | 33 +++++++++++++++++-----
 .../kernel/containers/netns/netns_rename_net.sh    | 20 ++++++++++---
 15 files changed, 175 insertions(+), 51 deletions(-)

diff --git a/testcases/kernel/containers/netns/netns_ch_ftp.sh b/testcases/kernel/containers/netns/netns_ch_ftp.sh
index 1e7f6d8..1ec733b 100755
--- a/testcases/kernel/containers/netns/netns_ch_ftp.sh
+++ b/testcases/kernel/containers/netns/netns_ch_ftp.sh
@@ -41,4 +41,7 @@ export TST_TOTAL
             status=1
         fi
     fi
-    echo $status > /tmp/FIFO6
+    tst_timeout "echo $status > /tmp/FIFO6" $NETNS_TIMEOUT
+    if [ $? -ne 0 ]; then
+        tst_brkm TBROK "timeout reached!"
+    fi
diff --git a/testcases/kernel/containers/netns/netns_child_1.sh b/testcases/kernel/containers/netns/netns_child_1.sh
index 7c1b50c..85f380e 100755
--- a/testcases/kernel/containers/netns/netns_child_1.sh
+++ b/testcases/kernel/containers/netns/netns_child_1.sh
@@ -33,10 +33,16 @@ export TST_TOTAL
 status=0
 
     # Writing child PID number into /tmp/FIFO
-    echo $$ > /tmp/FIFO2
+    tst_timeout "echo $$ > /tmp/FIFO2" $NETNS_TIMEOUT
+    if [ $? -ne 0 ]; then
+        tst_brkm TBROK "timeout reached!"
+    fi
 
     # Reading device name from parent
-    vnet1=`cat /tmp/FIFO1`;
+    vnet1=$(tst_timeout "cat /tmp/FIFO1" $NETNS_TIMEOUT)
+    if [ $? -ne 0 ]; then
+        tst_brkm TBROK "timeout reached!"
+    fi
     debug "INFO: CHILD1: Network dev name received $vnet1";
 
     # By now network is working
@@ -60,13 +66,16 @@ status=0
     fi
 
     # Waiting for CHILD2
-    ret=`cat /tmp/FIFO5`
+    ret=$(tst_timeout "cat /tmp/FIFO5" $NETNS_TIMEOUT)
+    if [ $? -ne 0 ]; then
+        tst_brkm TBROK "timeout reached!"
+    fi
 
-    if [ $ret -eq 0 ]; then
+    if [ "$ret" = "0" ]; then
         # Pinging CHILD2 from CHILD1
-        debug "INFO: Trying for pinging CHILD2..."
+        debug "INFO: Trying to ping CHILD2..."
         ping -qc 2 $IP4 > /dev/null
-        if [ $? = 0 ];
+        if [ $? -eq 0 ];
         then
             tst_resm TINFO "PASS: Child2 is pinging from CHILD1 !"
         else
diff --git a/testcases/kernel/containers/netns/netns_child_2.sh b/testcases/kernel/containers/netns/netns_child_2.sh
index 5e3566f..1e16624 100755
--- a/testcases/kernel/containers/netns/netns_child_2.sh
+++ b/testcases/kernel/containers/netns/netns_child_2.sh
@@ -32,10 +32,16 @@ export TST_TOTAL
 status=0
 
     # Writing child PID number into /tmp/FIFO4
-    echo $$ > /tmp/FIFO4
+    tst_timeout "echo $$ > /tmp/FIFO4" $NETNS_TIMEOUT
+    if [ $? -ne 0 ]; then
+        tst_brkm TBROK "timeout reached!"
+    fi
 
     # Reading device name from parent
-    vnet2=`cat /tmp/FIFO3`;
+    vnet2=$(tst_timeout "cat /tmp/FIFO3" $NETNS_TIMEOUT)
+    if [ $? -ne 0 ]; then
+        tst_brkm TBROK "timeout reached!"
+    fi
     debug "INFO: CHILD2: Network dev name received $vnet2";
 
     # By now networking is working
@@ -58,17 +64,23 @@ status=0
         status=-1
     fi
     # Pinging CHILD1 from CHILD2
-    debug "INFO: Trying for pinging CHILD1..."
+    debug "INFO: Trying to ping CHILD1..."
 
     ping -qc 2 $IP2 > /dev/null
     if [ $? -eq 0 ]; then
         tst_resm TINFO "PASS: CHILD1 is pinging from CHILD2 ! "
         # Using /tmp/FIFO5 to synchronize with CHILD1
-        echo 0 > /tmp/FIFO5
+        tst_timeout "echo 0 > /tmp/FIFO5" $NETNS_TIMEOUT
+        if [ $? -ne 0 ]; then
+           tst_brkm TBROK "timeout reached!"
+        fi
         sleep 2
     else
         tst_resm TFAIL "FAIL: Unable to ping Child1NS from Child2NS !"
-        echo 1 > /tmp/FIFO5
+        tst_timeout "echo 1 > /tmp/FIFO5" $NETNS_TIMEOUT
+        if [ $? -ne 0 ]; then
+           tst_brkm TBROK "timeout reached!"
+        fi
         status=-1
     fi
 
diff --git a/testcases/kernel/containers/netns/netns_child_propagate.sh b/testcases/kernel/containers/netns/netns_child_propagate.sh
index 9b508c5..420c324 100755
--- a/testcases/kernel/containers/netns/netns_child_propagate.sh
+++ b/testcases/kernel/containers/netns/netns_child_propagate.sh
@@ -35,7 +35,10 @@ export TST_COUNT
 export TST_TOTAL
 
     ret=0
-    PROPAGATE=`cat /tmp/FIFO4`
+    PROPAGATE=$(tst_timeout "cat /tmp/FIFO4" $NETNS_TIMEOUT)
+    if [ $? -ne 0 ]; then
+        tst_brkm TBROK "timeout reached!"
+    fi
     debug "INFO: CHILD propagated.."
     mount -t sysfs none /sys || ret=1
     mkdir -p /tmp/mnt/sys || ret=1
@@ -48,7 +51,10 @@ export TST_TOTAL
     fi
     #Capture childs sysfs contents
     ls /sys/class/net > /tmp/child_sysfs
-    echo propagated > /tmp/FIFO5
+    tst_timeout "echo 'propagated' > /tmp/FIFO5" $NETNS_TIMEOUT
+    if [ $? -ne 0 ]; then
+        tst_brkm TBROK "timeout reached!"
+    fi
 
     #Capture parent sysfs in child
     ls /tmp/par_sysfs/class/net > /tmp/parent_sysfs_in_child
diff --git a/testcases/kernel/containers/netns/netns_childipv6.sh b/testcases/kernel/containers/netns/netns_childipv6.sh
index 248f1db..f41dcc2 100755
--- a/testcases/kernel/containers/netns/netns_childipv6.sh
+++ b/testcases/kernel/containers/netns/netns_childipv6.sh
@@ -41,10 +41,16 @@ export TST_TOTAL
 status=0
 
     # Passing the PID of child
-    echo $$ > /tmp/FIFO1
+    tst_timeout "echo $$ > /tmp/FIFO1" $NETNS_TIMEOUT
+    if [ $? -ne 0 ]; then
+        tst_brkm TBROK "timeout reached!"
+    fi
 
     # waiting for the virt-eth devname and IPv6 addr from parent
-    vnet1=`cat /tmp/FIFO2`
+    vnet1=$(tst_timeout "cat /tmp/FIFO2" $NETNS_TIMEOUT)
+    if [ $? -ne 0 ]; then
+        tst_brkm TBROK "timeout reached!"
+    fi
     enable_veth_ipv6 $vnet1
     vnet1_orig_status=$?
 
@@ -64,9 +70,15 @@ status=0
     fi
 
     childIPv6=`ip -6 addr show dev $vnet1 | awk ' /inet6/ { print $2 } ' | awk -F"/" ' { print $1 } '`
-    echo $childIPv6 >> /tmp/FIFO3
+    tst_timeout "echo $childIPv6 >> /tmp/FIFO3" $NETNS_TIMEOUT
+    if [ $? -ne 0 ]; then
+        tst_brkm TBROK "timeout reached!"
+    fi
 
-    parIPv6=`cat /tmp/FIFO4`
+    parIPv6=$(tst_timeout "cat /tmp/FIFO4" $NETNS_TIMEOUT)
+    if [ $? -ne 0 ]; then                       
+        tst_brkm TBROK "timeout reached!"
+    fi
     debug "INFO: Received the Ipv6 addr $parIPv6"
 
     # checking if parent ns responding
@@ -77,7 +89,10 @@ status=0
                tst_resm TFAIL "IPv6: Pinging Parent from Child: FAIL"
                status=1
             fi
-    echo $status > /tmp/FIFO6
+    tst_timeout "echo $status > /tmp/FIFO6" $NETNS_TIMEOUT
+    if [ $? -ne 0 ]; then
+        tst_brkm TBROK "timeout reached!"
+    fi
 
     if [ $vnet1_orig_status -eq 1 ];then
        disable_veth_ipv6 $vnet1
diff --git a/testcases/kernel/containers/netns/netns_childns.sh b/testcases/kernel/containers/netns/netns_childns.sh
index 9ad9190..7f196fb 100755
--- a/testcases/kernel/containers/netns/netns_childns.sh
+++ b/testcases/kernel/containers/netns/netns_childns.sh
@@ -48,10 +48,16 @@ if [ $# -eq 1 ] ; then
 fi
 
 # Passing the PID of child
-echo "child ready" > /tmp/FIFO1;
+tst_timeout "echo 'child ready' > /tmp/FIFO1" $NETNS_TIMEOUT
+if [ $? -ne 0 ]; then
+    tst_brkm TBROK "timeout reached!"
+fi
 
 # waiting for the device name from parent
-vnet1=`cat /tmp/FIFO2`;
+vnet1=$(tst_timeout "cat /tmp/FIFO2" $NETNS_TIMEOUT)
+if [ $? -ne 0 ]; then
+    tst_brkm TBROK "timeout reached!"
+fi
 debug "INFO: network dev name received $vnet1";
 # Assigning the dev addresses
 if ! ifconfig $vnet1 $IP2/24 up > /dev/null 2>&1 ; then
diff --git a/testcases/kernel/containers/netns/netns_delchild.sh b/testcases/kernel/containers/netns/netns_delchild.sh
index 1bf4de7..ae83f0e 100755
--- a/testcases/kernel/containers/netns/netns_delchild.sh
+++ b/testcases/kernel/containers/netns/netns_delchild.sh
@@ -36,12 +36,18 @@ export TCID
 export TST_COUNT
 export TST_TOTAL
 
-    sshpid=`cat /tmp/FIFO3`
+    sshpid=$(tst_timeout "cat /tmp/FIFO3" $NETNS_TIMEOUT)
+    if [ $? -ne 0 ]; then
+       tst_brkm TBROK "timeout reached!"
+    fi
     debug "INFO: ssh pid is  $sshpid"
-    newnet=`cat /tmp/FIFO4`
+    newnet=$(tst_timeout "cat /tmp/FIFO4" $NETNS_TIMEOUT)
+    if [ $? -ne 0 ]; then
+        tst_brkm TBROK "timeout reached!"
+    fi
     debug "INFO: new dev is  $newnet"
 
-    if [ $newnet = -1 ] ; then
+    if [ "$newnet" = "-1" ] ; then
         status=-1
     fi
 
diff --git a/testcases/kernel/containers/netns/netns_initialize.sh b/testcases/kernel/containers/netns/netns_initialize.sh
index 2df8c24..d44a02b 100755
--- a/testcases/kernel/containers/netns/netns_initialize.sh
+++ b/testcases/kernel/containers/netns/netns_initialize.sh
@@ -42,6 +42,9 @@ PORT=7890
 PORT2=9876
 DEBUG=0
 
+# Maximum amount of time (in seconds) to wait for FIFO read/write operations
+NETNS_TIMEOUT=60
+
 # set the LTPROOT directory
 cd "$(dirname "$0")"
 if [ -n "${LTPROOT:-}" ]; then
@@ -137,10 +140,13 @@ enable_veth_ipv6()
 disable_veth_ipv6()
 {
     local veth=$1
-    echo 1 > /proc/sys/net/ipv6/conf/$veth/disable_ipv6
-    if [ $? -ne 0 ];then
-        tst_resm TFAIL "Error: set " \
-            "/proc/sys/net/ipv6/conf/$veth/disable_ipv6 to 1 failed"
-        exit 1
+    veth_exist=$(ip a | grep $veth)
+    if [ -n "$veth_exist" ]; then
+        echo 1 > /proc/sys/net/ipv6/conf/$veth/disable_ipv6
+        if [ $? -ne 0 ];then
+            tst_resm TFAIL "Error: set " \
+                "/proc/sys/net/ipv6/conf/$veth/disable_ipv6 to 1 failed"
+            exit 1
+        fi
     fi
 }
diff --git a/testcases/kernel/containers/netns/netns_par_ftp.sh b/testcases/kernel/containers/netns/netns_par_ftp.sh
index 111cdf6..848d051 100755
--- a/testcases/kernel/containers/netns/netns_par_ftp.sh
+++ b/testcases/kernel/containers/netns/netns_par_ftp.sh
@@ -42,9 +42,15 @@ export TST_TOTAL
         tst_resm TFAIL "Error: Unable to ping ChildNS from ParentNS"
         status=-1
     fi
-    stat=`cat /tmp/FIFO6`
-    if [ $stat != 0 ] ; then
-        status=$stat
+    stat=$(tst_timeout "cat /tmp/FIFO6" $NETNS_TIMEOUT)
+    if [ $? -ne 0 ]; then
+        tst_brkm TBROK "timeout reached!"
+    fi
+    if [ -z "$stat" ]; then
+        stat="-1"
+    fi
+    if [ "$stat" != "0" ] ; then
+        status=$(expr "$stat")
     fi
 
     exit $status
diff --git a/testcases/kernel/containers/netns/netns_parent_1.sh b/testcases/kernel/containers/netns/netns_parent_1.sh
index e68636e..9398459 100755
--- a/testcases/kernel/containers/netns/netns_parent_1.sh
+++ b/testcases/kernel/containers/netns/netns_parent_1.sh
@@ -49,10 +49,16 @@ export TST_TOTAL
     route add -host $IP2 dev $vnet0
     echo 1 > /proc/sys/net/ipv4/conf/$vnet0/proxy_arp
 
-    pid=`cat /tmp/FIFO2`
+    pid=$(tst_timeout "cat /tmp/FIFO2" $NETNS_TIMEOUT)
+    if [ $? -ne 0 ]; then
+        tst_brkm TBROK "timeout reached!"
+    fi
     debug "INFO: The pid of CHILD1 is $pid"
     ip link set $vnet1 netns $pid
-    echo $vnet1 > /tmp/FIFO1
+    tst_timeout "echo $vnet1 > /tmp/FIFO1" $NETNS_TIMEOUT
+    if [ $? -ne 0 ]; then
+        tst_brkm TBROK "timeout reached!"
+    fi
 
     debug "INFO: PARENT_1: End of $0"
     exit 0
diff --git a/testcases/kernel/containers/netns/netns_parent_2.sh b/testcases/kernel/containers/netns/netns_parent_2.sh
index ea4d5d2..349cf9e 100755
--- a/testcases/kernel/containers/netns/netns_parent_2.sh
+++ b/testcases/kernel/containers/netns/netns_parent_2.sh
@@ -45,10 +45,16 @@ export TST_TOTAL
     route add -host $IP4 dev $vnet2
     echo 1 > /proc/sys/net/ipv4/conf/$vnet2/proxy_arp
 
-    pid=`cat /tmp/FIFO4`
+    pid=$(tst_timeout "cat /tmp/FIFO4" $NETNS_TIMEOUT)
+    if [ $? -ne 0 ]; then
+        tst_brkm TBROK "timeout reached!"
+    fi
     debug "INFO: The pid of CHILD2 is $pid"
     ip link set $vnet3 netns $pid
-    echo $vnet3 > /tmp/FIFO3
+    tst_timeout "echo $vnet3 > /tmp/FIFO3" $NETNS_TIMEOUT
+    if [ $? -ne 0 ]; then
+        tst_brkm TBROK "timeout reached!"
+    fi
 
     debug "INFO: PARENT-2: End of $0"
     exit 0
diff --git a/testcases/kernel/containers/netns/netns_parent_view.sh b/testcases/kernel/containers/netns/netns_parent_view.sh
index 04ebe08..3c85d50 100755
--- a/testcases/kernel/containers/netns/netns_parent_view.sh
+++ b/testcases/kernel/containers/netns/netns_parent_view.sh
@@ -36,9 +36,15 @@ export TST_TOTAL
 
     debug "INFO: Parent SYSFS view"
     ls /sys/class/net > /tmp/parent_sysfs
-    echo PROPAGATE > /tmp/FIFO4
+    tst_timeout "echo 'PROPAGATE' > /tmp/FIFO4" $NETNS_TIMEOUT
+    if [ $? -ne 0 ]; then
+        tst_brkm TBROK "timeout reached!"
+    fi
 
-    PROPAGATED=`cat /tmp/FIFO5`
+    PROPAGATED=$(tst_timeout "cat /tmp/FIFO5" $NETNS_TIMEOUT)
+    if [ $? -ne 0 ]; then
+        tst_brkm TBROK "timeout reached!"
+    fi
     ls /tmp/mnt/sys/class/net > /tmp/child_sysfs_in_parent
     diff /tmp/child_sysfs_in_parent /tmp/child_sysfs
     if [ $? -eq 0 ]
diff --git a/testcases/kernel/containers/netns/netns_parentns.sh b/testcases/kernel/containers/netns/netns_parentns.sh
index 281347d..7bcde12 100755
--- a/testcases/kernel/containers/netns/netns_parentns.sh
+++ b/testcases/kernel/containers/netns/netns_parentns.sh
@@ -75,7 +75,10 @@ status=0
     echo 1 > /proc/sys/net/ipv4/conf/$vnet0/proxy_arp
 
     # Waits for the Child-NS to get created and reads the PID
-    tmp=`cat /tmp/FIFO1`;
+    tmp=$(tst_timeout "cat /tmp/FIFO1" $NETNS_TIMEOUT)
+    if [ $? -ne 0 ]; then
+        tst_brkm TBROK "timeout reached!"
+    fi
     pid=$2;
     debug "INFO: the pid of child is $pid"
     ip link set $vnet1 netns $pid
@@ -84,7 +87,10 @@ status=0
     fi
 
     # Passes the device name to Child NS
-    echo $vnet1 > /tmp/FIFO2
+    tst_timeout "echo $vnet1 > /tmp/FIFO2" $NETNS_TIMEOUT
+    if [ $? -ne 0 ]; then
+        tst_brkm TBROK "timeout reached!"
+    fi
 
     # Executes the script if it is passed as an argument.
     if [ ! -z $scrpt ] && [ -f $scrpt ] ;  then
diff --git a/testcases/kernel/containers/netns/netns_paripv6.sh b/testcases/kernel/containers/netns/netns_paripv6.sh
index 181e724..9f2270a 100755
--- a/testcases/kernel/containers/netns/netns_paripv6.sh
+++ b/testcases/kernel/containers/netns/netns_paripv6.sh
@@ -64,18 +64,30 @@ status=0
     echo 1 > /proc/sys/net/ipv4/conf/$vnet0/proxy_arp
 
     # Waits for the Child-NS to get created and reads the PID
-    pid=`cat /tmp/FIFO1`
+    pid=$(tst_timeout "cat /tmp/FIFO1" $NETNS_TIMEOUT)
+    if [ $? -ne 0 ]; then
+        tst_brkm TBROK "timeout reached!"
+    fi
     debug "INFO: the pid of child is $pid"
     ip link set $vnet1 netns $pid
 
-    echo $vnet1 > /tmp/FIFO2
+    tst_timeout "echo $vnet1 > /tmp/FIFO2" $NETNS_TIMEOUT
+    if [ $? -ne 0 ]; then
+        tst_brkm TBROK "timeout reached!"
+    fi
 
-    childIPv6=`cat /tmp/FIFO3`
+    childIPv6=$(tst_timeout "cat /tmp/FIFO3" $NETNS_TIMEOUT)
+    if [ $? -ne 0 ]; then
+        tst_brkm TBROK "timeout reached!"
+    fi
     debug "INFO: The ipv6 addr of child is $childIPv6"
     # Passes the IPv6 addr to Child NS
     parIPv6=`ip -6 addr show dev $vnet0 | awk ' /inet6/ { print $2 } ' | awk -F"/" ' { print $1 } '`
 
-    echo $parIPv6 > /tmp/FIFO4
+    tst_timeout "echo $parIPv6 > /tmp/FIFO4" $NETNS_TIMEOUT
+    if [ $? -ne 0 ]; then
+        tst_brkm TBROK "timeout reached!"
+    fi
     ping6 -I $vnet0 -qc 2 $childIPv6 >/dev/null 2>&1
 
     if [ $? = 0 ] ; then
@@ -86,9 +98,16 @@ status=0
        status=-1
 
     fi
-    ret=`cat /tmp/FIFO6`
-    if [ $ret != 0 ] ; then
-        status=$ret
+    ret=$(tst_timeout "cat /tmp/FIFO6" $NETNS_TIMEOUT)
+    if [ $? -ne 0 ]; then
+        tst_brkm TBROK "timeout reached!"
+    fi
+    if [ -z "$ret" ]; then
+        ret="-1"
+    fi
+
+    if [ "$ret" != "0" ] ; then
+        status=$(expr "$ret")
     fi
 
     if [ $vnet0_orig_status -eq 1 ];then
diff --git a/testcases/kernel/containers/netns/netns_rename_net.sh b/testcases/kernel/containers/netns/netns_rename_net.sh
index 02a444b..cceb975 100755
--- a/testcases/kernel/containers/netns/netns_rename_net.sh
+++ b/testcases/kernel/containers/netns/netns_rename_net.sh
@@ -57,9 +57,21 @@ export TST_TOTAL
     fi
 
     if [ $status = 0 ] ; then
-        echo $sshpid > /tmp/FIFO3
-        echo $newdev > /tmp/FIFO4
+        tst_timeout "echo $sshpid > /tmp/FIFO3" $NETNS_TIMEOUT
+	if [ $? -ne 0 ]; then
+            tst_brkm TBROK "timeout reached!"
+        fi
+        tst_timeout "echo $newdev > /tmp/FIFO4" $NETNS_TIMEOUT
+	if [ $? -ne 0 ]; then
+            tst_brkm TBROK "timeout reached!"
+        fi
     else
-        echo FAIL > /tmp/FIFO3
-        echo -1 > /tmp/FIFO4
+        tst_timeout "echo 'FAIL' > /tmp/FIFO3" $NETNS_TIMEOUT
+	if [ $? -ne 0 ]; then
+            tst_brkm TBROK "timeout reached!"
+        fi
+        tst_timeout "echo -1 > /tmp/FIFO4" $NETNS_TIMEOUT
+	if [ $? -ne 0 ]; then
+            tst_brkm TBROK "timeout reached!"
+        fi
     fi
-- 
1.8.3.1


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
