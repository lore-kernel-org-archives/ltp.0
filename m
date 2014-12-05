Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1XwmwD-0002da-HN
	for ltp-list@lists.sourceforge.net; Fri, 05 Dec 2014 07:04:25 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XwmwC-0000Su-Ft
	for ltp-list@lists.sourceforge.net; Fri, 05 Dec 2014 07:04:25 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id sB573vle026309
	for <ltp-list@lists.sourceforge.net>; Fri, 5 Dec 2014 15:03:57 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Fri, 5 Dec 2014 15:00:58 +0800
Message-ID: <1417762858-18686-2-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1417762858-18686-1-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1415258674-17261-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<1417762858-18686-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v3 2/2] containers: fix exit status in
	netns/netns_netlink.c
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

In iproute2 whose version is earlier than v2.6.34,
ip command doesn't support tuntap object. This leads
to the case (netns_netlink.c) failure with TFAIL status.
It is not suitable, so fix this case' exit status with
TCONF in the above condition.

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 testcases/kernel/containers/netns/netns_netlink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/containers/netns/netns_netlink.c b/testcases/kernel/containers/netns/netns_netlink.c
index 08caa98..29b7488 100644
--- a/testcases/kernel/containers/netns/netns_netlink.c
+++ b/testcases/kernel/containers/netns/netns_netlink.c
@@ -47,6 +47,8 @@
 
 
 #define MAX_TRIES 1000
+#define IP_TUNTAP_MIN_VER 100519
+
 char *TCID	= "netns_netlink";
 int TST_TOTAL	= 1;
 struct tst_checkpoint checkpoint;
@@ -60,6 +62,7 @@ static void cleanup(void)
 static void setup(void)
 {
 	tst_require_root(NULL);
+	check_iproute(IP_TUNTAP_MIN_VER);
 	check_netns();
 	tst_tmpdir();
 	TST_CHECKPOINT_CREATE(&checkpoint);
-- 
1.9.3


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
