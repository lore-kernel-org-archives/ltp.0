Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xiaofeng_yan2006@126.com>) id 1ZClXl-0005jk-5f
	for ltp-list@lists.sourceforge.net; Wed, 08 Jul 2015 09:21:31 +0000
Received: from m50-110.126.com ([123.125.50.110])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZClXg-0002Ro-SL
	for ltp-list@lists.sourceforge.net; Wed, 08 Jul 2015 09:21:29 +0000
From: Changsheng Liu <liuchangsheng@inspur.com>
Date: Wed,  8 Jul 2015 17:20:59 +0800
Message-Id: <1436347259-942-1-git-send-email-liuchangsheng@inspur.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] netns,
	make a verfication to name of virtul network interface card
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
Cc: wunan@inspur.com

The current ltp version get name of virtul network interface card
with "veth62@veth63" in the newest kernel version,
But we need a file name with "veth62".

Signed-off-by: Changsheng Liu <liuchangsheng@inspur.com>
---
 testcases/kernel/containers/netns/netns_paripv6.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/containers/netns/netns_paripv6.sh b/testcases/kernel/containers/netns/netns_paripv6.sh
index 9f2270a..6d2f48d 100755
--- a/testcases/kernel/containers/netns/netns_paripv6.sh
+++ b/testcases/kernel/containers/netns/netns_paripv6.sh
@@ -47,8 +47,8 @@ status=0
     echo 1 > /proc/sys/net/ipv4/ip_forward
     echo 1 > /proc/sys/net/ipv4/conf/$netdev/proxy_arp
     create_veth
-    vnet0=$dev0
-    vnet1=$dev1
+    vnet0=$(echo $dev0 | awk -F'@' '{ print $1}')
+    vnet1=$(echo $dev1 | awk -F'@' '{ print $1}')
     if [ -z "$vnet0" -o -z "$vnet1" ] ; then
         tst_resm TFAIL "Error: unable to create veth pair"
         exit 1
-- 
1.9.1



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
