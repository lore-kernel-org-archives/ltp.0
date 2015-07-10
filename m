Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mawentao@inspur.com>) id 1ZDNS0-0000kq-Pz
	for ltp-list@lists.sourceforge.net; Fri, 10 Jul 2015 01:50:04 +0000
Received: from vip.corpemail.net ([162.243.126.186])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZDNRu-0001AU-PJ
	for ltp-list@lists.sourceforge.net; Fri, 10 Jul 2015 01:50:04 +0000
Received: from sg02.corpemail.net ([128.199.154.28])
	by vip.corpemail.net ((O)) with ESMTP (SSL) id XYV00025
	for <ltp-list@lists.sourceforge.net>; Fri, 10 Jul 2015 09:37:25 +0800
Received: from bgp253.corp-email.cn ([112.65.243.253])
	by sg02.corpemail.net ((B_Out)) with ESMTP (SSL) id XYV00113
	for <ltp-list@lists.sourceforge.net>; Fri, 10 Jul 2015 09:37:13 +0800
Received: from ([218.57.135.44])
	by bgp253.corp-email.cn (Antispam) with ASMTP (SSL) id XIU63649
	for <ltp-list@lists.sourceforge.net>; Fri, 10 Jul 2015 09:36:49 +0800
From: Wentao Ma <mawentao@inspur.com>
Date: Fri, 10 Jul 2015 09:36:41 +0800
Message-ID: <1436492201-17837-1-git-send-email-mawentao@inspur.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] netns_two_children_ns: solve a problem from
	netns_two_children_ns
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
To: ltp-list@lists.sourceforge.net, yanxiaofeng@inspur.com, wunan@inspur.com

The failed information is as follow:
Cannot find device "veth16@veth15"
netns_child_1.sh 1 TFAIL : FAIL: Unable to ping the Parent1 from Child1
WARNING: kernel is not very fresh, upgrade is recommended.
netns_child_2.sh 1 TFAIL : FAIL: Unable to ping Child1NS from Child2NS !
netns_child_1.sh 2 TFAIL : CHILD2 is unable to reach CHILD1
netns_2children    1  TFAIL  :  netns_two_children_ns.c:126:
waitpid() returns 150757, errno 255

this is caused by the wrong device name like"veth16@veth15"
so correct the device name.

Signed-off-by: Wentao Ma <mawentao@inspur.com>
---
 testcases/kernel/containers/netns/netns_parent_1.sh | 4 ++--
 testcases/kernel/containers/netns/netns_parent_2.sh | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/containers/netns/netns_parent_1.sh b/testcases/kernel/containers/netns/netns_parent_1.sh
index 9398459..bc0f702 100755
--- a/testcases/kernel/containers/netns/netns_parent_1.sh
+++ b/testcases/kernel/containers/netns/netns_parent_1.sh
@@ -36,8 +36,8 @@ export TST_TOTAL
     echo 1 > /proc/sys/net/ipv4/ip_forward
     echo 1 > /proc/sys/net/ipv4/conf/$netdev/proxy_arp
     create_veth
-    vnet0=$dev0
-    vnet1=$dev1
+    vnet0=`echo $dev0 | awk -F@ '{print $1}'`
+    vnet1=`echo $dev1 | awk -F@ '{print $1}'`
     if [ -z "$vnet0" -o -z "$vnet1" ] ; then
         tst_resm TFAIL  "Error: unable to create veth pair in $0"
         exit 1
diff --git a/testcases/kernel/containers/netns/netns_parent_2.sh b/testcases/kernel/containers/netns/netns_parent_2.sh
index 349cf9e..fcee38b 100755
--- a/testcases/kernel/containers/netns/netns_parent_2.sh
+++ b/testcases/kernel/containers/netns/netns_parent_2.sh
@@ -32,8 +32,8 @@ export TST_TOTAL
 . netns_initialize.sh
 
     create_veth
-    vnet2=$dev0
-    vnet3=$dev1
+    vnet2=`echo $dev0 | awk -F@ '{print $1}'`
+    vnet3=`echo $dev1 | awk -F@ '{print $1}'`
 
     if [ -z "$vnet2" -o -z "$vnet3" ] ; then
         tst_resm TFAIL  "Error: unable to create veth pair in $0"
-- 
1.8.3.1


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
