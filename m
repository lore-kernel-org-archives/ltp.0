Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1XmHUL-0003yd-3P
	for ltp-list@lists.sourceforge.net; Thu, 06 Nov 2014 07:28:13 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XmHUJ-0005pm-3N
	for ltp-list@lists.sourceforge.net; Thu, 06 Nov 2014 07:28:13 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id sA67RJXG026335
	for <ltp-list@lists.sourceforge.net>; Thu, 6 Nov 2014 15:27:19 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Thu, 6 Nov 2014 15:24:34 +0800
Message-ID: <1415258674-17261-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] containers: fix exit status in netns_netlink.c
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

In iproute2 whose version is earlier than v2.6.29-1,
ip command doesn't support tuntap object. This leads
to the case (netns_netlink.c) failure with TFAIL status.
It is not suitable, so fix this case' exit status with
TCONF in the above condition.

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 testcases/kernel/containers/netns/netns_netlink.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/testcases/kernel/containers/netns/netns_netlink.c b/testcases/kernel/containers/netns/netns_netlink.c
index 08caa98..ae57ecd 100644
--- a/testcases/kernel/containers/netns/netns_netlink.c
+++ b/testcases/kernel/containers/netns/netns_netlink.c
@@ -126,6 +126,16 @@ static void test(void)
 {
 	pid_t pid;
 	int status;
+	int ret;
+
+	/* check if ip command supports tuntap object */
+	ret = WEXITSTATUS(system("ip help 2>&1 | grep -w tuntap &>/dev/null"));
+	if (ret == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "system failed");
+	if (ret == 1) {
+		tst_resm(TCONF, "ip command doesn't support tuntap object");
+		return;
+	}
 
 	/* unshares the network namespace */
 	if (unshare(CLONE_NEWNET) == -1)
-- 
1.9.3


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
