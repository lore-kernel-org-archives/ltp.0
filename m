Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XC2og-0005Se-PZ
	for ltp-list@lists.sourceforge.net; Tue, 29 Jul 2014 08:31:26 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XC2of-0001sN-Ca
	for ltp-list@lists.sourceforge.net; Tue, 29 Jul 2014 08:31:26 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s6T8VIMB026990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 29 Jul 2014 04:31:18 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id s6T8VHbK004550
	for <ltp-list@lists.sourceforge.net>; Tue, 29 Jul 2014 04:31:17 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 29 Jul 2014 10:31:13 +0200
Message-Id: <24aca741786196af9ca38705970289a66b12ab9b.1406622527.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] mem/oom: check for multiple outcomes if
	overcommit_memory is 0 or 1
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

There is no guarantee that mmap() will fail before OOM tries to kill the
process if overcommit is set to 0 or 1. So allow these tests to
PASS if child is killed or some operation fails with ENOMEM.

This patch is introducing extra parameter "outcome" to oom()/testoom().
It's an array of integers, which describe how child ended:
exited/signalled and contains ret code or signal number. If child state
matches any value in this array, it's considered as PASS.

Tests with overcommit_memory set to 2 are expected to fail with ENOMEM,
all others are expected to fail with ENOMEM or be killed by SIGKILL.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/mem/include/mem.h |   14 +++++-
 testcases/kernel/mem/lib/mem.c     |   95 ++++++++++++++++++++++++------------
 testcases/kernel/mem/oom/oom01.c   |    9 ++-
 testcases/kernel/mem/oom/oom02.c   |    6 +-
 testcases/kernel/mem/oom/oom03.c   |   10 ++--
 testcases/kernel/mem/oom/oom04.c   |    4 +-
 testcases/kernel/mem/oom/oom05.c   |    8 ++--
 7 files changed, 96 insertions(+), 50 deletions(-)

diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index 746164c..e7a8678 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -38,9 +38,19 @@ static inline void clean_node(unsigned long *array)
 #define MLOCK			3
 #define KSM			4
 
+/* oom/testoom outcomes */
+#define EXIT_FLAG 0x100
+#define SIGNAL_FLAG 0x200
+#define OUTCOME_MASK 0xff
+#define EXITED(n) (EXIT_FLAG + (n & OUTCOME_MASK))
+#define SIGNALLED(n) (SIGNAL_FLAG + (n & OUTCOME_MASK))
+
+extern int EXITED_ENOMEM[];
+extern int ENOMEM_OR_SIGKILL[];
+
 long overcommit;
-void oom(int testcase, int lite);
-void testoom(int mempolicy, int lite);
+void oom(int testcase, int lite, int outcome[]);
+void testoom(int mempolicy, int lite, int outcome[]);
 
 /* KSM */
 
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index c7910db..f207c58 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -25,52 +25,73 @@
 #include "numa_helper.h"
 
 /* OOM */
+int EXITED_ENOMEM[] = { EXITED(ENOMEM), 0 };
+int ENOMEM_OR_SIGKILL[] =  { EXITED(ENOMEM), SIGNALLED(SIGKILL), 0 };
 
 static int alloc_mem(long int length, int testcase)
 {
-	void *s;
+	char *s;
+	long i;
+	int pagesz = getpagesize();
 
 	tst_resm(TINFO, "allocating %ld bytes.", length);
+
 	s = mmap(NULL, length, PROT_READ | PROT_WRITE,
 		 MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
-	if (s == MAP_FAILED) {
-		if (testcase == OVERCOMMIT && errno == ENOMEM)
-			return 1;
-		else
-			tst_brkm(TBROK | TERRNO, cleanup, "mmap");
-	}
+	if (s == MAP_FAILED)
+		return errno;
+
 	if (testcase == MLOCK && mlock(s, length) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "mlock");
+		return errno;
 #ifdef HAVE_MADV_MERGEABLE
 	if (testcase == KSM && madvise(s, length, MADV_MERGEABLE) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "madvise");
+		return errno;
 #endif
-	memset(s, '\a', length);
+	for (i = 0; i < length; i += pagesz)
+		s[i] = '\a';
 
 	return 0;
 }
 
 static void test_alloc(int testcase, int lite)
 {
-	if (lite)
-		alloc_mem(TESTMEM + MB, testcase);
-	else
-		while (1)
-			if (alloc_mem(LENGTH, testcase))
-				return;
+	int ret;
+
+	if (lite) {
+		ret = alloc_mem(TESTMEM + MB, testcase);
+	} else {
+		ret = 0;
+		while (!ret)
+			ret = alloc_mem(LENGTH, testcase);
+	}
+	exit(ret);
 }
 
-void oom(int testcase, int lite)
+/*
+ * oom - allocates memory according to specified testcase and checks
+ *       desired outcome (e.g. child killed, operation failed with ENOMEM)
+ * @testcase: selects how child allocates memory
+ *            valid choices are: OVERCOMMIT, NORMAL, MLOCK and KSM
+ * @lite: if non-zero, child makes only single TESTMEM+MB allocation
+ *        if zero, child keeps allocating memory until it gets killed
+ *        or some operation fails
+ * @outcome: array of integeres describing expected states of child process
+ *           If child state matches any, it will report PASS.
+ *           Two bytes are used in each int, higher byte specifies how child
+ *           exited, lower byte is return code or signal number, see EXITED()
+ *           and SIGNALLED() macros in mem.h.
+ *           Last integer must be 0 to denote end of array.
+ */
+void oom(int testcase, int lite, int outcome[])
 {
 	pid_t pid;
-	int status;
+	int status, i = 0, n;
 
 	switch (pid = fork()) {
 	case -1:
 		tst_brkm(TBROK | TERRNO, cleanup, "fork");
 	case 0:
 		test_alloc(testcase, lite);
-		exit(0);
 	default:
 		break;
 	}
@@ -79,15 +100,27 @@ void oom(int testcase, int lite)
 	if (waitpid(-1, &status, 0) == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
 
-	if (testcase == OVERCOMMIT) {
-		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
-			tst_resm(TFAIL, "the victim unexpectedly failed: %d",
-				 status);
-	} else {
-		if (!WIFSIGNALED(status) || WTERMSIG(status) != SIGKILL)
-			tst_resm(TFAIL, "the victim unexpectedly failed: %d",
-				 status);
+	while (outcome[i]) {
+		n = outcome[i] & OUTCOME_MASK;
+		if ((outcome[i] & EXIT_FLAG) && WIFEXITED(status)
+			&& WEXITSTATUS(status) == n) {
+			tst_resm(TPASS, "victim retcode: (%d) %s",
+				n, strerror(n));
+			return;
+		} else if ((outcome[i] & SIGNAL_FLAG) && WIFSIGNALED(status)
+			&& WTERMSIG(status) == n) {
+			tst_resm(TPASS, "victim signalled: (%d) %s",
+				n, tst_strsig(n));
+			return;
+		}
+		i++;
 	}
+
+	tst_resm(TFAIL, "victim unexpectedly ended with status: %d", status);
+	if (WIFEXITED(status))
+		tst_resm(TFAIL, " retcode: %s",	strerror(WEXITSTATUS(status)));
+	if (WIFSIGNALED(status))
+		tst_resm(TFAIL, " termsig: %s",	tst_strsig(WTERMSIG(status)));
 }
 
 static void set_global_mempolicy(int mempolicy)
@@ -135,22 +168,22 @@ static void set_global_mempolicy(int mempolicy)
 #endif
 }
 
-void testoom(int mempolicy, int lite)
+void testoom(int mempolicy, int lite, int outcome[])
 {
 	set_global_mempolicy(mempolicy);
 
 	tst_resm(TINFO, "start normal OOM testing.");
-	oom(NORMAL, lite);
+	oom(NORMAL, lite, outcome);
 
 	tst_resm(TINFO, "start OOM testing for mlocked pages.");
-	oom(MLOCK, lite);
+	oom(MLOCK, lite, outcome);
 
 	if (access(PATH_KSM, F_OK) == -1) {
 		tst_resm(TINFO, "KSM configuration is not enabled, "
 			 "skip OOM test for KSM pags");
 	} else {
 		tst_resm(TINFO, "start OOM testing for KSM pages.");
-		oom(KSM, lite);
+		oom(KSM, lite, outcome);
 	}
 }
 
diff --git a/testcases/kernel/mem/oom/oom01.c b/testcases/kernel/mem/oom/oom01.c
index 076427c..c97fada 100644
--- a/testcases/kernel/mem/oom/oom01.c
+++ b/testcases/kernel/mem/oom/oom01.c
@@ -60,14 +60,17 @@ int main(int argc, char *argv[])
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		tst_count = 0;
 
+		/* we expect mmap to fail before OOM is hit */
 		set_sys_tune("overcommit_memory", 2, 1);
-		oom(OVERCOMMIT, 0);
+		oom(OVERCOMMIT, 0, EXITED_ENOMEM);
 
+		/* with overcommit_memory set to 0 or 1 there's no
+		 * guarantee that mmap fails before OOM */
 		set_sys_tune("overcommit_memory", 0, 1);
-		oom(OVERCOMMIT, 0);
+		oom(OVERCOMMIT, 0, ENOMEM_OR_SIGKILL);
 
 		set_sys_tune("overcommit_memory", 1, 1);
-		testoom(0, 0);
+		testoom(0, 0, ENOMEM_OR_SIGKILL);
 	}
 	cleanup();
 	tst_exit();
diff --git a/testcases/kernel/mem/oom/oom02.c b/testcases/kernel/mem/oom/oom02.c
index 3f17400..e3242fc 100644
--- a/testcases/kernel/mem/oom/oom02.c
+++ b/testcases/kernel/mem/oom/oom02.c
@@ -65,13 +65,13 @@ int main(int argc, char *argv[])
 		tst_count = 0;
 
 		tst_resm(TINFO, "OOM on MPOL_BIND mempolicy...");
-		testoom(MPOL_BIND, 0);
+		testoom(MPOL_BIND, 0, ENOMEM_OR_SIGKILL);
 
 		tst_resm(TINFO, "OOM on MPOL_INTERLEAVE mempolicy...");
-		testoom(MPOL_INTERLEAVE, 0);
+		testoom(MPOL_INTERLEAVE, 0, ENOMEM_OR_SIGKILL);
 
 		tst_resm(TINFO, "OOM on MPOL_PREFERRED mempolicy...");
-		testoom(MPOL_PREFERRED, 0);
+		testoom(MPOL_PREFERRED, 0, ENOMEM_OR_SIGKILL);
 	}
 	cleanup();
 	tst_exit();
diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
index dcb493c..a8cce9c 100644
--- a/testcases/kernel/mem/oom/oom03.c
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -66,7 +66,7 @@ int main(int argc, char *argv[])
 				 "%d", getpid());
 		SAFE_FILE_PRINTF(cleanup, MEMCG_LIMIT, "%ld", TESTMEM);
 
-		testoom(0, 0);
+		testoom(0, 0, ENOMEM_OR_SIGKILL);
 
 		if (access(MEMCG_SW_LIMIT, F_OK) == -1) {
 			if (errno == ENOENT)
@@ -77,15 +77,15 @@ int main(int argc, char *argv[])
 		} else {
 			SAFE_FILE_PRINTF(cleanup, MEMCG_SW_LIMIT,
 					 "%ld", TESTMEM);
-			testoom(0, 1);
+			testoom(0, 1, ENOMEM_OR_SIGKILL);
 		}
 
 		/* OOM for MEMCG with mempolicy */
 		if (is_numa(cleanup)) {
 			tst_resm(TINFO, "OOM on MEMCG & mempolicy...");
-			testoom(MPOL_BIND, 0);
-			testoom(MPOL_INTERLEAVE, 0);
-			testoom(MPOL_PREFERRED, 0);
+			testoom(MPOL_BIND, 0, ENOMEM_OR_SIGKILL);
+			testoom(MPOL_INTERLEAVE, 0, ENOMEM_OR_SIGKILL);
+			testoom(MPOL_PREFERRED, 0, ENOMEM_OR_SIGKILL);
 		}
 	}
 	cleanup();
diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
index 40360c3..0a74e89 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -65,7 +65,7 @@ int main(int argc, char *argv[])
 		tst_count = 0;
 
 		tst_resm(TINFO, "OOM on CPUSET...");
-		testoom(0, 0);
+		testoom(0, 0, ENOMEM_OR_SIGKILL);
 
 		if (is_numa(cleanup)) {
 			/*
@@ -76,7 +76,7 @@ int main(int argc, char *argv[])
 			write_cpuset_files(CPATH_NEW,
 					   "memory_migrate", "1");
 			tst_resm(TINFO, "OOM on CPUSET with mem migrate:");
-			testoom(0, 0);
+			testoom(0, 0, ENOMEM_OR_SIGKILL);
 		}
 	}
 	cleanup();
diff --git a/testcases/kernel/mem/oom/oom05.c b/testcases/kernel/mem/oom/oom05.c
index 7ca53ad..0992935 100644
--- a/testcases/kernel/mem/oom/oom05.c
+++ b/testcases/kernel/mem/oom/oom05.c
@@ -66,7 +66,7 @@ int main(int argc, char *argv[])
 		tst_count = 0;
 
 		tst_resm(TINFO, "OOM on CPUSET & MEMCG...");
-		testoom(0, 0);
+		testoom(0, 0, ENOMEM_OR_SIGKILL);
 
 		/*
 		 * Under NUMA system, the migration of cpuset's memory
@@ -77,7 +77,7 @@ int main(int argc, char *argv[])
 			write_cpuset_files(CPATH_NEW, "memory_migrate", "1");
 			tst_resm(TINFO, "OOM on CPUSET & MEMCG with "
 					"cpuset.memory_migrate=1");
-			testoom(0, 0);
+			testoom(0, 0, ENOMEM_OR_SIGKILL);
 		}
 
 		if (access(MEMCG_SW_LIMIT, F_OK) == -1) {
@@ -93,12 +93,12 @@ int main(int argc, char *argv[])
 			tst_resm(TINFO, "OOM on CPUSET & MEMCG with "
 					"special memswap limitation:");
 			SAFE_FILE_PRINTF(cleanup, MEMCG_SW_LIMIT, "%ld", TESTMEM);
-			testoom(0, 0);
+			testoom(0, 0, ENOMEM_OR_SIGKILL);
 
 			tst_resm(TINFO, "OOM on CPUSET & MEMCG with "
 					"disabled memswap limitation:");
 			SAFE_FILE_PRINTF(cleanup, MEMCG_SW_LIMIT, "-1");
-			testoom(0, 0);
+			testoom(0, 0, ENOMEM_OR_SIGKILL);
 		}
 	}
 
-- 
1.7.1


------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
