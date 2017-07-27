From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 27 Jul 2017 10:14:37 +0200
Subject: [LTP] [PATCH] [RFC] tst_test: Add support for array of test
	functions
Message-ID: <20170727081437.27995-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This commits add third option for specifying the test functions in an
NULL terminated array of function pointers + converts two testcases.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_test.h                            | 11 ++++----
 lib/tst_test.c                                | 38 ++++++++++++++++++++++-----
 testcases/kernel/syscalls/syscall/syscall01.c | 20 +++++---------
 testcases/kernel/syscalls/waitpid/waitpid09.c | 12 +++------
 4 files changed, 47 insertions(+), 34 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index c1eab3294..aa1554d34 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -140,17 +140,18 @@ struct tst_test {
 	/* override default timeout per test run */
 	unsigned int timeout;
 
+	/* NULL terminated array of resource file names */
+	const char *const *resource_files;
+
 	void (*setup)(void);
 	void (*cleanup)(void);
 
-	void (*test)(unsigned int test_nr);
-	void (*test_all)(void);
-
 	/* Sampling function for timer measurement testcases */
 	int (*sample)(int clk_id, long long usec);
 
-	/* NULL terminated array of resource file names */
-	const char *const *resource_files;
+	void (*test)(unsigned int test_nr);
+	void (*test_all)(void);
+	void (**tests)(void);
 };
 
 /*
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 16ea64fe9..f482de116 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -649,6 +649,15 @@ static void assert_test_fn(void)
 	if (tst_test->sample)
 		cnt++;
 
+	if (tst_test->tests) {
+		cnt++;
+
+		if (!tst_test->tests[0]) {
+			tst_brk(TBROK,
+				"The tests[] must have at least one function");
+		}
+	}
+
 	if (!cnt)
 		tst_brk(TBROK, "No test function speficied");
 
@@ -763,22 +772,39 @@ static void do_cleanup(void)
 
 static void run_tests(void)
 {
-	unsigned int i;
+	unsigned int i = 0, go = 1;
 	struct results saved_results;
 
-	if (!tst_test->test) {
+
+	while (go) {
 		saved_results = *results;
-		tst_test->test_all();
 
-		if (getpid() != main_pid) {
-			exit(0);
+		if (tst_test->test_all) {
+			tst_test->test_all();
+			go = 0;
 		}
 
+		if (tst_test->test) {
+			tst_test->test(i);
+
+			if (++i >= tst_test->tcnt)
+				go = 0;
+		}
+
+		if (tst_test->tests) {
+			tst_test->tests[i]();
+
+			if (!tst_test->tests[++i])
+				go = 0;
+		}
+
+		if (getpid() != main_pid)
+			exit(0);
+
 		tst_reap_children();
 
 		if (results_equal(&saved_results, results))
 			tst_brk(TBROK, "Test haven't reported results!");
-		return;
 	}
 
 	for (i = 0; i < tst_test->tcnt; i++) {
diff --git a/testcases/kernel/syscalls/syscall/syscall01.c b/testcases/kernel/syscalls/syscall/syscall01.c
index 728f538cc..98a381b9b 100644
--- a/testcases/kernel/syscalls/syscall/syscall01.c
+++ b/testcases/kernel/syscalls/syscall/syscall01.c
@@ -75,20 +75,12 @@ static void verify_getgid(void)
 	}
 }
 
-
-static void (*tcases[])(void) = {
-	verify_getpid,
-	verify_getuid,
-	verify_getgid,
-};
-
-static void verify_syscall(unsigned int n)
-{
-	tcases[n]();
-}
-
 static struct tst_test test = {
-	.test = verify_syscall,
-	.tcnt = ARRAY_SIZE(tcases),
+	.tests = (void (*[])(void)) {
+		verify_getpid,
+		verify_getuid,
+		verify_getgid,
+		NULL,
+	}
 };
 
diff --git a/testcases/kernel/syscalls/waitpid/waitpid09.c b/testcases/kernel/syscalls/waitpid/waitpid09.c
index 78119379f..8d3b2e40b 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid09.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid09.c
@@ -162,16 +162,10 @@ static void case3(void)
 	tst_res(TPASS, "waitpid(-1, WNOHANG) = -1 with ECHILD if no children");
 }
 
-static void (*tests[])(void) = { case0, case1, case2, case3 };
-
-static void waitpid09_test(unsigned int id)
-{
-	tests[id]();
-}
-
 static struct tst_test test = {
 	.forks_child = 1,
 	.needs_checkpoints = 1,
-	.test = waitpid09_test,
-	.tcnt = ARRAY_SIZE(tests),
+	.tests = (void (*[])(void)) {
+		case0, case1, case2, case3, NULL,
+	}
 };
-- 
2.13.0

