Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1Xnkex-0000lv-Nw
	for ltp-list@lists.sourceforge.net; Mon, 10 Nov 2014 08:49:15 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Xnkew-0004es-QH
	for ltp-list@lists.sourceforge.net; Mon, 10 Nov 2014 08:49:15 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id sAA8mthW014931
	for <ltp-list@lists.sourceforge.net>; Mon, 10 Nov 2014 16:48:55 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Mon, 10 Nov 2014 16:46:04 +0800
Message-ID: <1415609164-10297-2-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1415609164-10297-1-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1415258674-17261-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<1415609164-10297-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 2/2] containers: fix exit status in
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
 testcases/kernel/containers/netns/netns_netlink.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/testcases/kernel/containers/netns/netns_netlink.c b/testcases/kernel/containers/netns/netns_netlink.c
index 08caa98..d271124 100644
--- a/testcases/kernel/containers/netns/netns_netlink.c
+++ b/testcases/kernel/containers/netns/netns_netlink.c
@@ -47,6 +47,8 @@
 
 
 #define MAX_TRIES 1000
+#define IP_TUNTAP_MIN_VER 100519
+
 char *TCID	= "netns_netlink";
 int TST_TOTAL	= 1;
 struct tst_checkpoint checkpoint;
@@ -60,6 +62,10 @@ static void cleanup(void)
 static void setup(void)
 {
 	tst_require_root(NULL);
+	if (check_iproute(IP_TUNTAP_MIN_VER) == -1) {
+		tst_brkm(TCONF, NULL,
+			"ip command in iproute tools do not support tuntap object");
+	}
 	check_netns();
 	tst_tmpdir();
 	TST_CHECKPOINT_CREATE(&checkpoint);
-- 
1.9.3


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
