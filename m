Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WpSog-0003Eg-1q
	for ltp-list@lists.sourceforge.net; Wed, 28 May 2014 01:38:06 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WpSod-00005B-L5
	for ltp-list@lists.sourceforge.net; Wed, 28 May 2014 01:38:06 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s4S1brMD026648
	for <ltp-list@lists.sourceforge.net>; Wed, 28 May 2014 09:37:54 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Wed, 28 May 2014 09:35:26 +0800
Message-ID: <1401240926-4204-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] containers/netns: enable IPv6 address
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
 testcases/kernel/containers/netns/initialize.sh | 18 ++++++++++++++++++
 testcases/kernel/containers/netns/paripv6.sh    |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/testcases/kernel/containers/netns/initialize.sh b/testcases/kernel/containers/netns/initialize.sh
index a2c3f47..9270f60 100755
--- a/testcases/kernel/containers/netns/initialize.sh
+++ b/testcases/kernel/containers/netns/initialize.sh
@@ -114,3 +114,21 @@ create_veth()
     ip link show > /tmp/net2
     eval `diff /tmp/net1 /tmp/net2 | awk -F": "  '/^> [0-9]*:/ { print "dev" i+0 "=" $2; i++  }'`
 }
+
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
+                "/proc/sys/net/ipv6/conf/$veth/disable_ipv6 to 1 failed"
+            exit 1
+        fi
+    fi
+}
diff --git a/testcases/kernel/containers/netns/paripv6.sh b/testcases/kernel/containers/netns/paripv6.sh
index ac8ee57..25d780a 100755
--- a/testcases/kernel/containers/netns/paripv6.sh
+++ b/testcases/kernel/containers/netns/paripv6.sh
@@ -55,6 +55,8 @@ status=0
     else
         debug "INFO: vnet0 = $vnet0 , vnet1 = $vnet1"
     fi
+    enable_veth_ipv6 $vnet0
+    enable_veth_ipv6 $vnet1
 
 
     ifconfig $vnet0 $IP1/24 up > /dev/null 2>&1
-- 
1.8.2.1


------------------------------------------------------------------------------
Time is money. Stop wasting it! Get your web API in 5 minutes.
www.restlet.com/download
http://p.sf.net/sfu/restlet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
