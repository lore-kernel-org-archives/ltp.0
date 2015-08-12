Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liuhangbin@gmail.com>) id 1ZPM1W-0007Ex-Vy
	for ltp-list@lists.sourceforge.net; Wed, 12 Aug 2015 02:44:15 +0000
Received: from mail-pa0-f48.google.com ([209.85.220.48])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZPM1U-0005ut-Tq
	for ltp-list@lists.sourceforge.net; Wed, 12 Aug 2015 02:44:14 +0000
Received: by pacgr6 with SMTP id gr6so3791431pac.2
	for <ltp-list@lists.sourceforge.net>;
	Tue, 11 Aug 2015 19:44:07 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Wed, 12 Aug 2015 10:43:53 +0800
Message-Id: <1439347433-5102-1-git-send-email-liuhangbin@gmail.com>
Subject: [LTP]  [PATCH] containers: fix dev name in create_veth()
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
To: LTP List <ltp-list@lists.sourceforge.net>

The new version of iproute2 will show veth device like veth0@veth1, but we
won't get a dev proc entry like this. Fix the dev name to avoid error like
/proc/sys/net/ipv4/conf/veth0@veth1/proxy_arp: No such file or directory

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 testcases/kernel/containers/netns/netns_initialize.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/containers/netns/netns_initialize.sh b/testcases/kernel/containers/netns/netns_initialize.sh
index d44a02b..71d935a 100755
--- a/testcases/kernel/containers/netns/netns_initialize.sh
+++ b/testcases/kernel/containers/netns/netns_initialize.sh
@@ -113,6 +113,8 @@ create_veth()
     sleep 1
     ip link show > /tmp/net2
     eval `diff /tmp/net1 /tmp/net2 | awk -F": "  '/^> [0-9]*:/ { print "dev" i+0 "=" $2; i++  }'`
+    dev0=$(echo $dev0 | cut -f1 -d'@')
+    dev1=$(echo $dev1 | cut -f1 -d'@')
 }
 
 # return 1 if disabled originally, 0 for enabled originally.
-- 
1.9.3


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
