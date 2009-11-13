Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <liubo2009@cn.fujitsu.com>) id 1N8sMf-0007Ot-PY
	for ltp-list@lists.sourceforge.net; Fri, 13 Nov 2009 09:22:45 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N8sMX-0007AZ-RG
	for ltp-list@lists.sourceforge.net; Fri, 13 Nov 2009 09:22:45 +0000
Message-ID: <4AFD2579.6060107@cn.fujitsu.com>
Date: Fri, 13 Nov 2009 17:23:05 +0800
From: liubo <liubo2009@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] mem/hugetlb: fix failure of hugemmap04
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

Testcase hugemmap04 needs at least one hugepage to test,
so there needs a judgement of "number of hugepages".

This patch fixed the problems.

Signed-off-by: Liu Bo <liubo2009@cn.fujitsu.com>

---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
index 050a071..e67e43c 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
@@ -72,6 +72,7 @@
 
 #include "test.h"
 #include "usctest.h"
+#include "system_specific_hugepages_info.h"
 
 #define BUFFER_SIZE  256
 
@@ -124,6 +125,11 @@ main(int ac, char **av)
 		tst_exit();
 	}
 
+	/* Check number of hugepages */
+	if (get_no_of_hugepages() <= 0 || hugepages_size() <= 0)
+		tst_brkm(TBROK, cleanup, "Test cannot be continued owning to \
+				sufficient availability of Hugepages on the system");
+
 	/* Perform global setup for test */
 	setup();
 
-- 
1.6.2.2



------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
