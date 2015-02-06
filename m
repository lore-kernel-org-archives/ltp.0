Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1YJeYD-0004r5-3r
	for ltp-list@lists.sourceforge.net; Fri, 06 Feb 2015 08:46:09 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YJeYC-0007eM-57
	for ltp-list@lists.sourceforge.net; Fri, 06 Feb 2015 08:46:09 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t168ivi1028874
	for <ltp-list@lists.sourceforge.net>; Fri, 6 Feb 2015 16:44:57 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Fri, 6 Feb 2015 16:41:30 +0800
Message-ID: <1423212090-24164-6-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1423212090-24164-1-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1423212090-24164-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 6/6] power_management: add it into default
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

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 scenario_groups/default | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scenario_groups/default b/scenario_groups/default
index 0b82e5b..1e9de48 100644
--- a/scenario_groups/default
+++ b/scenario_groups/default
@@ -31,3 +31,5 @@ dma_thread_diotest
 cpuacct
 can
 cpuhotplug
+power_management_tests
+power_management_tests_exclusive
-- 
1.9.3


------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
