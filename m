Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1ZRdS3-0006bi-2i
	for ltp-list@lists.sourceforge.net; Tue, 18 Aug 2015 09:45:03 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZRdS1-00048l-9u
	for ltp-list@lists.sourceforge.net; Tue, 18 Aug 2015 09:45:03 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t7I9ipm1006827
	for <ltp-list@lists.sourceforge.net>; Tue, 18 Aug 2015 17:44:51 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Tue, 18 Aug 2015 17:32:25 +0800
Message-ID: <1439890345-20039-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] netns: adjust the code corresponding to new version
	iproute's output format
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

In RHEL7.1GA, 'ip link show' gives(iproute-3.10.0-21.el7.x86_64):
3: veth0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT qlen 1000
    link/ether 36:24:b9:e2:99:44 brd ff:ff:ff:ff:ff:ff
4: veth1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT qlen 1000
    link/ether 46:e7:39:82:80:b4 brd ff:ff:ff:ff:ff:ff
But in RHEL7.2Alpha, 'ip link show' gives(iproute-3.10.0-46.el7.x86_64):
3: veth0@veth1: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN mode DEFAULT qlen 1000
    link/ether da:01:6a:91:78:06 brd ff:ff:ff:ff:ff:ff
4: veth1@veth0: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN mode DEFAULT qlen 1000
    link/ether b2:6a:0a:32:35:e3 brd ff:ff:ff:ff:ff:ff

This difference will make create_veth() generate wrong device name, fix this.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 testcases/kernel/containers/netns/netns_initialize.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/containers/netns/netns_initialize.sh b/testcases/kernel/containers/netns/netns_initialize.sh
index d44a02b..28f4015 100755
--- a/testcases/kernel/containers/netns/netns_initialize.sh
+++ b/testcases/kernel/containers/netns/netns_initialize.sh
@@ -112,7 +112,7 @@ create_veth()
     ip link add type veth
     sleep 1
     ip link show > /tmp/net2
-    eval `diff /tmp/net1 /tmp/net2 | awk -F": "  '/^> [0-9]*:/ { print "dev" i+0 "=" $2; i++  }'`
+    eval `diff /tmp/net1 /tmp/net2 | awk -F": " '/^> [0-9]*:/ {print "dev" i+0 "=" $2; i++}' | awk -F'@' '{print $1}'`
 }
 
 # return 1 if disabled originally, 0 for enabled originally.
-- 
1.8.2.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
