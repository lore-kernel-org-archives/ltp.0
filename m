Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1Z4qUt-0007vA-1w
	for ltp-list@lists.sourceforge.net; Tue, 16 Jun 2015 13:01:47 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Z4qUo-0003pB-Tb
	for ltp-list@lists.sourceforge.net; Tue, 16 Jun 2015 13:01:47 +0000
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Tue, 16 Jun 2015 20:24:39 +0800
Message-ID: <1434457479-20493-7-git-send-email-zenglg.jy@cn.fujitsu.com>
In-Reply-To: <1434457479-20493-1-git-send-email-zenglg.jy@cn.fujitsu.com>
References: <5572ED1E.1020203@oracle.com>
	<1434457479-20493-1-git-send-email-zenglg.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v3 7/7] ipv6_lib: Add it into default
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
To: alexey.kodanev@oracle.com
Cc: ltp-list@lists.sourceforge.net

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 scenario_groups/default | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scenario_groups/default b/scenario_groups/default
index 3a55702..60b1b27 100644
--- a/scenario_groups/default
+++ b/scenario_groups/default
@@ -32,3 +32,4 @@ dma_thread_diotest
 cpuacct
 can
 cpuhotplug
+ipv6_lib
-- 
1.9.3


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
