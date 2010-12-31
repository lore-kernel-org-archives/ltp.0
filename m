Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PYcGB-0006f5-Qx
	for ltp-list@lists.sourceforge.net; Fri, 31 Dec 2010 10:30:59 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PYcGA-0005iY-PN
	for ltp-list@lists.sourceforge.net; Fri, 31 Dec 2010 10:30:59 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oBVAUq6j019427
	for <ltp-list@lists.sourceforge.net>; Fri, 31 Dec 2010 05:30:53 -0500
Date: Fri, 31 Dec 2010 05:30:52 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <1919722358.101361.1293791452948.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] oom: fix build failure and NUMA lib
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
To: ltp-list <ltp-list@lists.sourceforge.net>

This should apply after the previous all 5 oom patches.

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 testcases/kernel/mem/oom/Makefile  |    1 +
 testcases/kernel/mem/oom/lib/oom.c |    9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/mem/oom/Makefile b/testcases/kernel/mem/oom/Makefile
index cfce410..01c0546 100644
--- a/testcases/kernel/mem/oom/Makefile
+++ b/testcases/kernel/mem/oom/Makefile
@@ -24,6 +24,7 @@ LDLIBS			+= $(NUMA_LIBS) -loom
 LIBDIR			:= lib
 LIB			:= $(LIBDIR)/liboom.a
 FILTER_OUT_DIRS		:= $(LIBDIR)
+LDFLAGS			+= -L$(LIBDIR)
 
 $(LIBDIR):
 	mkdir -p "$@"
diff --git a/testcases/kernel/mem/oom/lib/oom.c b/testcases/kernel/mem/oom/lib/oom.c
index 0c44959..f0f1dac 100644
--- a/testcases/kernel/mem/oom/lib/oom.c
+++ b/testcases/kernel/mem/oom/lib/oom.c
@@ -8,11 +8,15 @@
 #include <errno.h>
 #include <stdio.h>
 #include <string.h>
-#include <numaif.h>
 #include <stdarg.h>
 #include "test.h"
 #include "usctest.h"
 #include "oom.h"
+#include "config.h"
+#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
+	&& HAVE_MPOL_CONSTANTS
+#include <numaif.h>
+#endif
 
 void oom(int testcase, int mempolicy, int lite)
 {
@@ -24,10 +28,13 @@ void oom(int testcase, int mempolicy, int lite)
 	case -1:
 		tst_brkm(TBROK|TERRNO, cleanup, "fork");
 	case 0:
+#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
+	&& HAVE_MPOL_CONSTANTS
 		if (mempolicy)
 			if (set_mempolicy(MPOL_BIND, &nmask, MAXNODES) == -1)
 				tst_brkm(TBROK|TERRNO, cleanup,
 					"set_mempolicy");
+#endif
 		test_alloc(testcase, lite);
 		exit(0);
 	default:
-- 
1.7.3.2

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
