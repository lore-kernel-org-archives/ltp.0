Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1UdAVN-00072t-O1
	for ltp-list@lists.sourceforge.net; Fri, 17 May 2013 02:34:49 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UdAVM-0004f2-Dj
	for ltp-list@lists.sourceforge.net; Fri, 17 May 2013 02:34:49 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r4H2YbJ7027932
	for <ltp-list@lists.sourceforge.net>; Fri, 17 May 2013 10:34:38 +0800
Message-ID: <519596B0.2010807@cn.fujitsu.com>
Date: Fri, 17 May 2013 10:32:16 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH] mem.c: check whether MADV_MERGEABLE is available
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
To: LTP list <ltp-list@lists.sourceforge.net>

Before using MADV_MERGEABLE, check whether it's available by macro
HAVE_MADV_MERGEABLE.

Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
---
 testcases/kernel/mem/lib/mem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 7cda3c5..9bc926e 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -494,8 +494,10 @@ void test_ksm_merge_across_nodes(unsigned long nr_pages)
 			    MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
 		if (memory[i] == MAP_FAILED)
 			tst_brkm(TBROK|TERRNO, tst_exit, "mmap");
+#ifdef HAVE_MADV_MERGEABLE
 		if (madvise(memory[i], length, MADV_MERGEABLE) == -1)
 			tst_brkm(TBROK|TERRNO, tst_exit, "madvise");
+#endif

 #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
 	&& HAVE_MPOL_CONSTANTS
-- 
1.7.11.rc0

------------------------------------------------------------------------------
AlienVault Unified Security Management (USM) platform delivers complete
security visibility with the essential security capabilities. Easily and
efficiently configure, manage, and operate all of your security controls
from a single console and one unified framework. Download a free trial.
http://p.sf.net/sfu/alienvault_d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
