Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VP8qx-0003sT-UU
	for ltp-list@lists.sourceforge.net; Thu, 26 Sep 2013 10:31:23 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VP8qm-0008MP-2A
	for ltp-list@lists.sourceforge.net; Thu, 26 Sep 2013 10:31:23 +0000
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 26 Sep 2013 14:30:37 +0400
Message-Id: <1380191440-18171-5-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1380191440-18171-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1380191440-18171-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 4/7] cpuset/cpuset_lib: cpuinfo.c compiled incorrectly
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
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com, miaox@cn.fujitsu.com

Because of lack of '#include "config.h"' cpuinfo.c file
was compiled incorrectly (i.e. final lib libcpu_set.a didn't contain
the functions/variables from cpuinfo.c)

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../kernel/controllers/cpuset/cpuset_lib/cpuinfo.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_lib/cpuinfo.c b/testcases/kernel/controllers/cpuset/cpuset_lib/cpuinfo.c
index 65c5072..3e7961f 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_lib/cpuinfo.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_lib/cpuinfo.c
@@ -1,3 +1,4 @@
+#include "config.h"
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-- 
1.7.1


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60133471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
