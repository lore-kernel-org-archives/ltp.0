Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Z0UkD-0003gx-Cu
	for ltp-list@lists.sourceforge.net; Thu, 04 Jun 2015 12:59:37 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z0UkC-0003hN-42
	for ltp-list@lists.sourceforge.net; Thu, 04 Jun 2015 12:59:37 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 3ED0D2CAB24
	for <ltp-list@lists.sourceforge.net>;
	Thu,  4 Jun 2015 12:59:30 +0000 (UTC)
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id t54CxTvi023060
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Jun 2015 08:59:29 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Thu,  4 Jun 2015 14:59:26 +0200
Message-Id: <0412ecc6e0cec73921a692ba87443a486bc53193.1433422701.git.jstancek@redhat.com>
Subject: [LTP] [PATCH v2] mem/oom: allocate memory using multiple threads
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

This is to make testcase faster on big systems, for example,
on Lenovo X3950 X6, 256GB RAM, 240 CPUs, 8 NUMA nodes
oom01 testcase would previously take ~4 hours to complete.
With this patch it takes ~16 minutes.

This change spawns CPU-1 (or at least 1) thread(s), which
allocate / fault-in memory in same way as before.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/mem/include/libmem.mk |  2 +-
 testcases/kernel/mem/lib/mem.c         | 53 +++++++++++++++++++++++++++-------
 2 files changed, 43 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/mem/include/libmem.mk b/testcases/kernel/mem/include/libmem.mk
index 4503e78..dffa379 100644
--- a/testcases/kernel/mem/include/libmem.mk
+++ b/testcases/kernel/mem/include/libmem.mk
@@ -23,7 +23,7 @@ MEM_DIR			:= $(top_builddir)/testcases/kernel/mem
 LIBMEM_DIR		:= $(MEM_DIR)/lib
 LIBMEM			:= $(LIBMEM_DIR)/libmem.a
 FILTER_OUT_DIRS		:= $(LIBMEM_DIR)
-CFLAGS			+= -I$(MEM_SRCDIR)/include
+CFLAGS			+= -I$(MEM_SRCDIR)/include -lpthread
 LDLIBS			+= $(NUMA_LIBS) -lmem -lltp
 LDFLAGS			+= -L$(LIBMEM_DIR)
 
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 37cf18f..f0cd728 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -12,6 +12,7 @@
 #if HAVE_NUMAIF_H
 #include <numaif.h>
 #endif
+#include <pthread.h>
 #include <stdarg.h>
 #include <stdio.h>
 #include <string.h>
@@ -30,7 +31,8 @@ static int alloc_mem(long int length, int testcase)
 	char *s;
 	long i, pagesz = getpagesize();
 
-	tst_resm(TINFO, "allocating %ld bytes.", length);
+	tst_resm(TINFO, "thread (%lx), allocating %ld bytes.",
+		(unsigned long) pthread_self(), length);
 
 	s = mmap(NULL, length, PROT_READ | PROT_WRITE,
 		 MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
@@ -49,18 +51,46 @@ static int alloc_mem(long int length, int testcase)
 	return 0;
 }
 
-static void test_alloc(int testcase, int lite)
+static void *child_alloc_thread(void *args)
 {
-	int ret;
+	int ret = 0;
+
+	/* keep allocating until there's an error */
+	while (!ret)
+		ret = alloc_mem(LENGTH, (long)args);
+	exit(ret);
+}
+
+static void child_alloc(int testcase, int lite, int threads)
+{
+	int i;
+	pthread_t *th;
 
 	if (lite) {
-		ret = alloc_mem(TESTMEM + MB, testcase);
-	} else {
-		ret = 0;
-		while (!ret)
-			ret = alloc_mem(LENGTH, testcase);
+		int ret = alloc_mem(TESTMEM + MB, testcase);
+		exit(ret);
 	}
-	exit(ret);
+
+	th = malloc(sizeof(pthread_t) * threads);
+	if (!th) {
+		tst_resm(TINFO | TERRNO, "malloc");
+		goto out;
+	}
+
+	for (i = 0; i < threads; i++) {
+		TEST(pthread_create(&th[i], NULL, child_alloc_thread,
+			(void*)((long)testcase)));
+		if (TEST_RETURN) {
+			tst_resm(TINFO | TRERRNO, "pthread_create");
+			goto out;
+		}
+	}
+
+	/* wait for one of threads to exit whole process */
+	while (1)
+		sleep(1);
+out:
+	exit(1);
 }
 
 /*
@@ -81,13 +111,14 @@ static void test_alloc(int testcase, int lite)
 void oom(int testcase, int lite, int retcode, int allow_sigkill)
 {
 	pid_t pid;
-	int status;
+	int status, threads;
 
 	switch (pid = fork()) {
 	case -1:
 		tst_brkm(TBROK | TERRNO, cleanup, "fork");
 	case 0:
-		test_alloc(testcase, lite);
+		threads = MAX(1, tst_ncpus() - 1);
+		child_alloc(testcase, lite, threads);
 	default:
 		break;
 	}
-- 
1.8.3.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
