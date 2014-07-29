Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XC6aC-0003Xw-GT
	for ltp-list@lists.sourceforge.net; Tue, 29 Jul 2014 12:32:44 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XC6a9-0000Pa-Vj
	for ltp-list@lists.sourceforge.net; Tue, 29 Jul 2014 12:32:44 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s6TCWYFd023917
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 29 Jul 2014 08:32:34 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id s6TCWXxb024802
	for <ltp-list@lists.sourceforge.net>; Tue, 29 Jul 2014 08:32:33 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 29 Jul 2014 14:32:25 +0200
Message-Id: <3f8381b9a1e1fc43c1bc47d416045e1e6fe3ae69.1406637055.git.jstancek@redhat.com>
Subject: [LTP] [PATCH v2 1/2] mem/oom: check for multiple outcomes if
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
process if overcommit is set to 0 or 1. So allow such tests to
PASS if child is killed with SIGKILL.

This patch adds 2 parameters to oom()/testoom() functions:
  retcode       - expected child return code
  allow_sigkill - flag which specifies if child killed by SIGKILL
                  is also PASS result

Child process will return 0 if all allocations succeeded,
otherwise it returns last errno.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/mem/include/mem.h |    4 +-
 testcases/kernel/mem/lib/mem.c     |   78 +++++++++++++++++++++++------------
 testcases/kernel/mem/oom/oom01.c   |    9 +++-
 testcases/kernel/mem/oom/oom02.c   |    6 +-
 testcases/kernel/mem/oom/oom03.c   |   10 ++--
 testcases/kernel/mem/oom/oom04.c   |    4 +-
 testcases/kernel/mem/oom/oom05.c   |    8 ++--
 7 files changed, 73 insertions(+), 46 deletions(-)

diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index 746164c..8fa2094 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -39,8 +39,8 @@ static inline void clean_node(unsigned long *array)
 #define KSM			4
 
 long overcommit;
-void oom(int testcase, int lite);
-void testoom(int mempolicy, int lite);
+void oom(int testcase, int lite, int retcode, int allow_sigkill);
+void testoom(int mempolicy, int lite, int retcode, int allow_sigkill);
 
 /* KSM */
 
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index c7910db..61b1ee6 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -31,19 +31,17 @@ static int alloc_mem(long int length, int testcase)
 	void *s;
 
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
 	memset(s, '\a', length);
 
@@ -52,15 +50,34 @@ static int alloc_mem(long int length, int testcase)
 
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
+ * @retcode: expected return code of child process
+ *           if matches child ret code, this function reports PASS,
+ *           otherwise it reports FAIL
+ * @allow_sigkill: if zero and child is killed, this function reports FAIL
+ *                 if non-zero, then if child is killed by SIGKILL
+ *                 it is considered as PASS
+ */
+void oom(int testcase, int lite, int retcode, int allow_sigkill)
 {
 	pid_t pid;
 	int status;
@@ -70,7 +87,6 @@ void oom(int testcase, int lite)
 		tst_brkm(TBROK | TERRNO, cleanup, "fork");
 	case 0:
 		test_alloc(testcase, lite);
-		exit(0);
 	default:
 		break;
 	}
@@ -79,14 +95,22 @@ void oom(int testcase, int lite)
 	if (waitpid(-1, &status, 0) == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
 
-	if (testcase == OVERCOMMIT) {
-		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
-			tst_resm(TFAIL, "the victim unexpectedly failed: %d",
-				 status);
+	if (WIFSIGNALED(status)) {
+		if (allow_sigkill && WTERMSIG(status) == SIGKILL) {
+			tst_resm(TPASS, "victim signalled: (%d) %s",
+				SIGKILL,
+				tst_strsig(SIGKILL));
+		} else {
+			tst_resm(TFAIL, "victim signalled: (%d) %s",
+				WTERMSIG(status),
+				tst_strsig(WTERMSIG(status)));
+		}
+	} else	if (WIFEXITED(status) && WEXITSTATUS(status) == retcode) {
+		tst_resm(TPASS, "victim retcode: (%d) %s",
+				retcode, strerror(retcode));
 	} else {
-		if (!WIFSIGNALED(status) || WTERMSIG(status) != SIGKILL)
-			tst_resm(TFAIL, "the victim unexpectedly failed: %d",
-				 status);
+		tst_resm(TFAIL, "victim unexpectedly ended with retcode: %d, "
+				"expected: %d", WEXITSTATUS(status), retcode);
 	}
 }
 
@@ -135,22 +159,22 @@ static void set_global_mempolicy(int mempolicy)
 #endif
 }
 
-void testoom(int mempolicy, int lite)
+void testoom(int mempolicy, int lite, int retcode, int allow_sigkill)
 {
 	set_global_mempolicy(mempolicy);
 
 	tst_resm(TINFO, "start normal OOM testing.");
-	oom(NORMAL, lite);
+	oom(NORMAL, lite, retcode, allow_sigkill);
 
 	tst_resm(TINFO, "start OOM testing for mlocked pages.");
-	oom(MLOCK, lite);
+	oom(MLOCK, lite, retcode, allow_sigkill);
 
 	if (access(PATH_KSM, F_OK) == -1) {
 		tst_resm(TINFO, "KSM configuration is not enabled, "
 			 "skip OOM test for KSM pags");
 	} else {
 		tst_resm(TINFO, "start OOM testing for KSM pages.");
-		oom(KSM, lite);
+		oom(KSM, lite, retcode, allow_sigkill);
 	}
 }
 
diff --git a/testcases/kernel/mem/oom/oom01.c b/testcases/kernel/mem/oom/oom01.c
index 076427c..4f57a9a 100644
--- a/testcases/kernel/mem/oom/oom01.c
+++ b/testcases/kernel/mem/oom/oom01.c
@@ -60,14 +60,17 @@ int main(int argc, char *argv[])
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		tst_count = 0;
 
+		/* we expect mmap to fail before OOM is hit */
 		set_sys_tune("overcommit_memory", 2, 1);
-		oom(OVERCOMMIT, 0);
+		oom(OVERCOMMIT, 0, ENOMEM, 0);
 
+		/* with overcommit_memory set to 0 or 1 there's no
+		 * guarantee that mmap fails before OOM */
 		set_sys_tune("overcommit_memory", 0, 1);
-		oom(OVERCOMMIT, 0);
+		oom(OVERCOMMIT, 0, ENOMEM, 1);
 
 		set_sys_tune("overcommit_memory", 1, 1);
-		testoom(0, 0);
+		testoom(0, 0, ENOMEM, 1);
 	}
 	cleanup();
 	tst_exit();
diff --git a/testcases/kernel/mem/oom/oom02.c b/testcases/kernel/mem/oom/oom02.c
index 3f17400..7a726c8 100644
--- a/testcases/kernel/mem/oom/oom02.c
+++ b/testcases/kernel/mem/oom/oom02.c
@@ -65,13 +65,13 @@ int main(int argc, char *argv[])
 		tst_count = 0;
 
 		tst_resm(TINFO, "OOM on MPOL_BIND mempolicy...");
-		testoom(MPOL_BIND, 0);
+		testoom(MPOL_BIND, 0, ENOMEM, 1);
 
 		tst_resm(TINFO, "OOM on MPOL_INTERLEAVE mempolicy...");
-		testoom(MPOL_INTERLEAVE, 0);
+		testoom(MPOL_INTERLEAVE, 0, ENOMEM, 1);
 
 		tst_resm(TINFO, "OOM on MPOL_PREFERRED mempolicy...");
-		testoom(MPOL_PREFERRED, 0);
+		testoom(MPOL_PREFERRED, 0, ENOMEM, 1);
 	}
 	cleanup();
 	tst_exit();
diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
index dcb493c..dfc2a64 100644
--- a/testcases/kernel/mem/oom/oom03.c
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -66,7 +66,7 @@ int main(int argc, char *argv[])
 				 "%d", getpid());
 		SAFE_FILE_PRINTF(cleanup, MEMCG_LIMIT, "%ld", TESTMEM);
 
-		testoom(0, 0);
+		testoom(0, 0, ENOMEM, 1);
 
 		if (access(MEMCG_SW_LIMIT, F_OK) == -1) {
 			if (errno == ENOENT)
@@ -77,15 +77,15 @@ int main(int argc, char *argv[])
 		} else {
 			SAFE_FILE_PRINTF(cleanup, MEMCG_SW_LIMIT,
 					 "%ld", TESTMEM);
-			testoom(0, 1);
+			testoom(0, 1, ENOMEM, 1);
 		}
 
 		/* OOM for MEMCG with mempolicy */
 		if (is_numa(cleanup)) {
 			tst_resm(TINFO, "OOM on MEMCG & mempolicy...");
-			testoom(MPOL_BIND, 0);
-			testoom(MPOL_INTERLEAVE, 0);
-			testoom(MPOL_PREFERRED, 0);
+			testoom(MPOL_BIND, 0, ENOMEM, 1);
+			testoom(MPOL_INTERLEAVE, 0, ENOMEM, 1);
+			testoom(MPOL_PREFERRED, 0, ENOMEM, 1);
 		}
 	}
 	cleanup();
diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
index 40360c3..c0f1f92 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -65,7 +65,7 @@ int main(int argc, char *argv[])
 		tst_count = 0;
 
 		tst_resm(TINFO, "OOM on CPUSET...");
-		testoom(0, 0);
+		testoom(0, 0, ENOMEM, 1);
 
 		if (is_numa(cleanup)) {
 			/*
@@ -76,7 +76,7 @@ int main(int argc, char *argv[])
 			write_cpuset_files(CPATH_NEW,
 					   "memory_migrate", "1");
 			tst_resm(TINFO, "OOM on CPUSET with mem migrate:");
-			testoom(0, 0);
+			testoom(0, 0, ENOMEM, 1);
 		}
 	}
 	cleanup();
diff --git a/testcases/kernel/mem/oom/oom05.c b/testcases/kernel/mem/oom/oom05.c
index 7ca53ad..e12c2dd 100644
--- a/testcases/kernel/mem/oom/oom05.c
+++ b/testcases/kernel/mem/oom/oom05.c
@@ -66,7 +66,7 @@ int main(int argc, char *argv[])
 		tst_count = 0;
 
 		tst_resm(TINFO, "OOM on CPUSET & MEMCG...");
-		testoom(0, 0);
+		testoom(0, 0, ENOMEM, 1);
 
 		/*
 		 * Under NUMA system, the migration of cpuset's memory
@@ -77,7 +77,7 @@ int main(int argc, char *argv[])
 			write_cpuset_files(CPATH_NEW, "memory_migrate", "1");
 			tst_resm(TINFO, "OOM on CPUSET & MEMCG with "
 					"cpuset.memory_migrate=1");
-			testoom(0, 0);
+			testoom(0, 0, ENOMEM, 1);
 		}
 
 		if (access(MEMCG_SW_LIMIT, F_OK) == -1) {
@@ -93,12 +93,12 @@ int main(int argc, char *argv[])
 			tst_resm(TINFO, "OOM on CPUSET & MEMCG with "
 					"special memswap limitation:");
 			SAFE_FILE_PRINTF(cleanup, MEMCG_SW_LIMIT, "%ld", TESTMEM);
-			testoom(0, 0);
+			testoom(0, 0, ENOMEM, 1);
 
 			tst_resm(TINFO, "OOM on CPUSET & MEMCG with "
 					"disabled memswap limitation:");
 			SAFE_FILE_PRINTF(cleanup, MEMCG_SW_LIMIT, "-1");
-			testoom(0, 0);
+			testoom(0, 0, ENOMEM, 1);
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
