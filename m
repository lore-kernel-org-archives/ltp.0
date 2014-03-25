Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from
	<jbeckenbach=ltp-list=lists.sourceforge.net=jmtqtyzj@lancope.com>)
	id 1WSRb9-00011l-Fe
	for ltp-list@lists.sourceforge.net; Tue, 25 Mar 2014 13:40:59 +0000
Received: from smtp-out3.electric.net ([72.35.12.184])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WSRb8-0004Bk-5Z
	for ltp-list@lists.sourceforge.net; Tue, 25 Mar 2014 13:40:59 +0000
Received: from 1WSRb0-0001TI-Vz by out3d.electric.net with emc1-ok (Exim
	4.80.1) (envelope-from <jbeckenbach@lancope.com>) id 1WSRb1-0001VE-VA
	for ltp-list@lists.sourceforge.net; Tue, 25 Mar 2014 06:40:51 -0700
Received: from [209.182.184.2] (helo=LCHQEX03.lancope.local)
	by out3d.electric.net with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.80.1) (envelope-from <jbeckenbach@lancope.com>)
	id 1WSRb0-0001TI-Vz
	for ltp-list@lists.sourceforge.net; Tue, 25 Mar 2014 06:40:51 -0700
From: Joseph Beckenbach <jbeckenbach@lancope.com>
Date: Tue, 25 Mar 2014 13:42:44 +0000
Message-ID: <4506ACC2AE90484D87F9A883BA36C21C548CD0@LCHQEX03.lancope.local>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] Suggested patch for Debian distro testing, part 2 of 2
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Greetings, again!

Second part appended.

I'm pretty sure I can minimize these further, maybe eliminate, given Cyril's comment yesterday to Alexey:
>> +tdir="${LTPROOT}/testcases/bin/"
> I keep telling everybody that this path must be part of the $PATH to 
> run a LTP testcase so all binaries from it should be started just by 
> their filename.

If this addition to $PATH is necessary, perhaps the wrapping scripts should enforce it,
or the requirement noted in invocation instructions.  (So many invocation points, though ....)
That plus shebanging these scripts as /bin/bash would eliminate the rest of this patch.

Thoughts?  Thanks!

Joseph
Joseph Beckenbach, senior QA engineer : Automation
=====
diff --git a/testcases/kernel/containers/netns/child_1.sh b/testcases/kernel/containers/netns/child_1.sh
index 4cd3325..4e54136 100755
--- a/testcases/kernel/containers/netns/child_1.sh
+++ b/testcases/kernel/containers/netns/child_1.sh
@@ -29,7 +29,7 @@ export TCID
 export TST_COUNT
 export TST_TOTAL
 
-. initialize.sh
+. `dirname $0`/initialize.sh
 status=0
 
     # Writing child PID number into /tmp/FIFO
diff --git a/testcases/kernel/containers/netns/child_2.sh b/testcases/kernel/containers/netns/child_2.sh
index 29907cd..5f80893 100755
--- a/testcases/kernel/containers/netns/child_2.sh
+++ b/testcases/kernel/containers/netns/child_2.sh
@@ -28,7 +28,7 @@ TST_COUNT=1
 export TCID
 export TST_COUNT
 export TST_TOTAL
-. initialize.sh
+. `dirname $0`/initialize.sh
 status=0
 
     # Writing child PID number into /tmp/FIFO4
diff --git a/testcases/kernel/containers/netns/childipv6.sh b/testcases/kernel/containers/netns/childipv6.sh
index f5eda65..1046b84 100755
--- a/testcases/kernel/containers/netns/childipv6.sh
+++ b/testcases/kernel/containers/netns/childipv6.sh
@@ -37,7 +37,7 @@ TST_COUNT=1
 export TCID
 export TST_COUNT
 export TST_TOTAL
-.  initialize.sh
+.  `dirname $0`/initialize.sh
 status=0
 
     # Passing the PID of child
diff --git a/testcases/kernel/containers/netns/childns.sh b/testcases/kernel/containers/netns/childns.sh
index 5b428a6..e143606 100755
--- a/testcases/kernel/containers/netns/childns.sh
+++ b/testcases/kernel/containers/netns/childns.sh
@@ -33,9 +33,9 @@
 # The test case ID, the test case count and the total number of test case
 
 export TCID=${TCID:-childns.sh}
-. cmdlib.sh
+. `dirname $0`/cmdlib.sh
 exists awk grep ip ping sshd
-. initialize.sh
+. `dirname $0`/initialize.sh
 status=0
 
 SSHD=`which sshd`
diff --git a/testcases/kernel/containers/netns/initialize.sh b/testcases/kernel/containers/netns/initialize.sh
index 1e66dc5..b2ad642 100755
--- a/testcases/kernel/containers/netns/initialize.sh
+++ b/testcases/kernel/containers/netns/initialize.sh
@@ -49,13 +49,13 @@ if [ -n "${LTPROOT:-}" ]; then
     fi
 else
     tst_resm TFAIL "Please set the LTP root env variable, and retry again"
-    exit -1
+    exit 255
 fi
 
 IPver=`ip -V | awk  -F"-" ' { print $2 } '` ;
 if ! printf "%s\n%s\n" "ss080417" "$IPver" | sort -c ; then
     tst_resm  TINFO "ip version should be atleast ss080417"
-    exit -1
+    exit 255
 fi
 i=1
 while [ $i -le 6 ] ; do
@@ -68,7 +68,7 @@ netdev=`ip addr show | awk '/^[0-9]*:.*UP/ { a=$2 } /inet / { b=$2 ; \
 netdev=`basename $netdev ":"`
 if [ -z "$netdev" ] ; then
     tst_resm  TINFO "Not able to determine the ethernet dev name"
-    exit -1
+    exit 255
 fi
 
 # copying the values for restoring it later.
diff --git a/testcases/kernel/containers/netns/parent_1.sh b/testcases/kernel/containers/netns/parent_1.sh
index a170b4f..dc5b7d8 100755
--- a/testcases/kernel/containers/netns/parent_1.sh
+++ b/testcases/kernel/containers/netns/parent_1.sh
@@ -32,7 +32,7 @@ export TCID
 export TST_COUNT
 export TST_TOTAL
 
-    . initialize.sh
+    . `dirname $0`/initialize.sh
     echo 1 > /proc/sys/net/ipv4/ip_forward
     echo 1 > /proc/sys/net/ipv4/conf/$netdev/proxy_arp
     create_veth
@@ -40,7 +40,7 @@ export TST_TOTAL
     vnet1=$dev1
     if [ -z "$vnet0" -o -z "$vnet1" ] ; then
         tst_resm TFAIL  "Error: unable to create veth pair in $0"
-        exit -1
+        exit 255
     else
         debug "INFO: vnet0 = $vnet0 , vnet1 = $vnet1"
     fi
diff --git a/testcases/kernel/containers/netns/parent_2.sh b/testcases/kernel/containers/netns/parent_2.sh
index 3e1349f..d2fa19d 100755
--- a/testcases/kernel/containers/netns/parent_2.sh
+++ b/testcases/kernel/containers/netns/parent_2.sh
@@ -29,7 +29,7 @@ TST_COUNT=1
 export TCID
 export TST_COUNT
 export TST_TOTAL
-. initialize.sh
+. `dirname $0`/initialize.sh
 
     create_veth
     vnet2=$dev0
@@ -37,7 +37,7 @@ export TST_TOTAL
 
     if [ -z "$vnet2" -o -z "$vnet3" ] ; then
         tst_resm TFAIL  "Error: unable to create veth pair in $0"
-        exit -1
+        exit 255
     else
         debug "INFO: vnet2 = $vnet2 , vnet3 = $vnet3"
     fi
diff --git a/testcases/kernel/containers/netns/parent_share.sh b/testcases/kernel/containers/netns/parent_share.sh
index 158c530..0ce5ab8 100755
--- a/testcases/kernel/containers/netns/parent_share.sh
+++ b/testcases/kernel/containers/netns/parent_share.sh
@@ -36,7 +36,7 @@ export TCID
 export TST_COUNT
 export TST_TOTAL
 ret=0
-. initialize.sh
+. `dirname $0`/initialize.sh
 
     mkdir -p /tmp/par_sysfs /tmp/mnt || ret=1
     mount --bind /sys /tmp/par_sysfs || ret=1
@@ -47,5 +47,5 @@ ret=0
     $smount /tmp/mnt shared > /dev/null || ret=1
     if [ $ret -ne 0 ] ; then
         tst_resm TFAIL "Error while doing shared mount"
-        exit -1
+        exit 255
     fi
diff --git a/testcases/kernel/containers/netns/parentns.sh b/testcases/kernel/containers/netns/parentns.sh
index bb5e8ef..0ed11fb 100755
--- a/testcases/kernel/containers/netns/parentns.sh
+++ b/testcases/kernel/containers/netns/parentns.sh
@@ -39,7 +39,7 @@ export TCID
 export TST_COUNT
 export TST_TOTAL
 #set -x
-. initialize.sh
+. `dirname $0`/initialize.sh
 status=0
 
     # Checks if any script is passed as argument.
@@ -58,7 +58,7 @@ status=0
     vnet1=$dev1
     if [ -z "$vnet0" -o -z "$vnet1" ] ; then
         tst_resm TFAIL  "Error: unable to create veth pair"
-        exit -1
+        exit 255
     else
         debug "INFO: vnet0 = $vnet0 , vnet1 = $vnet1"
     fi
diff --git a/testcases/kernel/containers/netns/paripv6.sh b/testcases/kernel/containers/netns/paripv6.sh
index 8612560..78a88a2 100755
--- a/testcases/kernel/containers/netns/paripv6.sh
+++ b/testcases/kernel/containers/netns/paripv6.sh
@@ -39,7 +39,7 @@ TST_COUNT=1
 export TCID
 export TST_COUNT
 export TST_TOTAL
-. initialize.sh
+. `dirname $0`/initialize.sh
 status=0
 
     # Sets up the infrastructure for creating network NS
@@ -51,7 +51,7 @@ status=0
     vnet1=$dev1
     if [ -z "$vnet0" -o -z "$vnet1" ] ; then
         tst_resm TFAIL "Error: unable to create veth pair"
-        exit -1
+        exit 255
     else
         debug "INFO: vnet0 = $vnet0 , vnet1 = $vnet1"
     fi
diff --git a/testcases/kernel/containers/netns/runallnetworktests_child.sh b/testcases/kernel/containers/netns/runallnetworktests_child.sh
index 7bba33d..a2f3f5e 100755
--- a/testcases/kernel/containers/netns/runallnetworktests_child.sh
+++ b/testcases/kernel/containers/netns/runallnetworktests_child.sh
@@ -33,7 +33,7 @@ if [ $? -ne 0 ]; then
 	exit 1;
 fi
 
-. initialize.sh;
+. `dirname $0`/initialize.sh;
 
 /etc/init.d/xinetd restart;
 if [ $? -ne 0 ]; then
diff --git a/testcases/kernel/containers/netns/runnetnstest.sh b/testcases/kernel/containers/netns/runnetnstest.sh
index fb494a2..3eff4ef 100755
--- a/testcases/kernel/containers/netns/runnetnstest.sh
+++ b/testcases/kernel/containers/netns/runnetnstest.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 
 ################################################################################
 ##                                                                            ##
@@ -106,7 +106,7 @@ echo
 #fi
 #echo
 
-. cmdlib.sh
+. `dirname $0`/cmdlib.sh
 flag=0
 
 status_daemon vsftpd

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
