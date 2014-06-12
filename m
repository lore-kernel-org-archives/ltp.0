Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WuvVt-0000EY-E9
	for ltp-list@lists.sourceforge.net; Thu, 12 Jun 2014 03:17:17 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WuvVq-0002HJ-W8
	for ltp-list@lists.sourceforge.net; Thu, 12 Jun 2014 03:17:17 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s5C3H7mh027515
	for <ltp-list@lists.sourceforge.net>; Thu, 12 Jun 2014 11:17:07 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Thu, 12 Jun 2014 11:14:25 +0800
Message-ID: <1402542865-6508-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2] containers/netns: enable IPv6 address
	autoconfiguration for veth interfaces
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
To: ltp-list@lists.sourceforge.net

In some linux distributions, such as RHEL7U0RC1, when we create a veth pair
by "ip link add type veth", the ipv6 address for veth interfaces won't be
automatically generated, so the "par_chld_ipv6" test case in containers test
will fail. This is because in these distirbutions, the "/proc/sys/net/ipv6/
conf/veth*/disable_ipv6" is true for veth interfaces. Please see kernel
"Documentation/networking/ip-sysctl.txt" for more detailed information.

In this patch, we will enable IPv6 address autoconfiguration for veth interfaces
if disabled.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 testcases/kernel/containers/netns/childipv6.sh  |  8 ++++++
 testcases/kernel/containers/netns/initialize.sh | 33 +++++++++++++++++++++++++
 testcases/kernel/containers/netns/paripv6.sh    |  5 ++++
 3 files changed, 46 insertions(+)

diff --git a/testcases/kernel/containers/netns/childipv6.sh b/testcases/kernel/containers/netns/childipv6.sh
index 073c2be..ccc43d6 100755
--- a/testcases/kernel/containers/netns/childipv6.sh
+++ b/testcases/kernel/containers/netns/childipv6.sh
@@ -45,6 +45,9 @@ status=0
 
     # waiting for the virt-eth devname and IPv6 addr from parent
     vnet1=`cat /tmp/FIFO2`
+    enable_veth_ipv6 $vnet1
+    vnet1_orig_status=$?
+
     # Assigning the dev addresses
     ifconfig $vnet1 $IP2/24 up > /dev/null 2>&1
     ifconfig lo up
@@ -75,6 +78,11 @@ status=0
                status=1
             fi
     echo $status > /tmp/FIFO6
+
+    if [ $vnet1_orig_status -eq 1 ];then
+       disable_veth_ipv6 $vnet1
+    fi
+
     debug "INFO: Done with executing child script $0"
     cleanup $sshpid $vnet1
     exit $status
diff --git a/testcases/kernel/containers/netns/initialize.sh b/testcases/kernel/containers/netns/initialize.sh
index a2c3f47..5333e7b 100755
--- a/testcases/kernel/containers/netns/initialize.sh
+++ b/testcases/kernel/containers/netns/initialize.sh
@@ -114,3 +114,36 @@ create_veth()
     ip link show > /tmp/net2
     eval `diff /tmp/net1 /tmp/net2 | awk -F": "  '/^> [0-9]*:/ { print "dev" i+0 "=" $2; i++  }'`
 }
+
+# return 1 if disabled originally, 0 for enabled originally.
+enable_veth_ipv6()
+{
+    local veth=$1
+    local veth_ipv6_status=$(cat /proc/sys/net/ipv6/conf/$veth/disable_ipv6)
+    if [ -z "$veth_ipv6_status" ];then
+        tst_resm TFAIL "Error: cat /proc/sys/net/ipv6/conf/$veth/disable_ipv6"\
+            "failed"
+        exit 1
+    elif [ "$veth_ipv6_status" = "1" ]; then
+        echo 0 > /proc/sys/net/ipv6/conf/$veth/disable_ipv6
+        if [ $? -ne 0 ];then
+            tst_resm TFAIL "Error: set " \
+                "/proc/sys/net/ipv6/conf/$veth/disable_ipv6 to 0 failed"
+            exit 1
+        fi
+        return 1
+    else
+        return 0
+    fi
+}
+
+disable_veth_ipv6()
+{
+    local veth=$1
+    echo 1 > /proc/sys/net/ipv6/conf/$veth/disable_ipv6
+    if [ $? -ne 0 ];then
+        tst_resm TFAIL "Error: set " \
+            "/proc/sys/net/ipv6/conf/$veth/disable_ipv6 to 1 failed"
+        exit 1
+    fi
+}
diff --git a/testcases/kernel/containers/netns/paripv6.sh b/testcases/kernel/containers/netns/paripv6.sh
index ac8ee57..2b02ab2 100755
--- a/testcases/kernel/containers/netns/paripv6.sh
+++ b/testcases/kernel/containers/netns/paripv6.sh
@@ -56,6 +56,8 @@ status=0
         debug "INFO: vnet0 = $vnet0 , vnet1 = $vnet1"
     fi
 
+    enable_veth_ipv6 $vnet0
+    vnet0_orig_status=$?
 
     ifconfig $vnet0 $IP1/24 up > /dev/null 2>&1
     route add -host $IP2 dev $vnet0
@@ -89,5 +91,8 @@ status=0
         status=$ret
     fi
 
+    if [ $vnet0_orig_status -eq 1 ];then
+       disable_veth_ipv6 $vnet0
+    fi
 debug "INFO: Done with executing parent script $0 "
 exit $status
-- 
1.8.2.1


------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
