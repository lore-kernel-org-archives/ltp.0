From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 27 Nov 2020 17:31:49 +0100
Subject: [LTP] [PATCH 1/2] lib: tst_test.c: Add TBROK counter.
In-Reply-To: <20201127163150.22903-1-chrubis@suse.cz>
References: <20201127163150.22903-1-chrubis@suse.cz>
Message-ID: <20201127163150.22903-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This ensures that TBROK is never lost.

If test process forks a child and the child calls SAFE_MACRO() the
failure will be lost unless the test process handles the exit value
properly and propagates the TBROK.

It is also strange that TBROK is the only return value that is solely
propagated by the exit value and not by the counters. This has been
mistake to begin with.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/newlib_tests/.gitignore |  1 +
 lib/newlib_tests/test22.c   | 34 ++++++++++++++++++++++++++++++++++
 lib/tst_test.c              | 13 +++++++++++--
 3 files changed, 46 insertions(+), 2 deletions(-)
 create mode 100644 lib/newlib_tests/test22.c

diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index ac1d19be0..6fc549cf2 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -25,6 +25,7 @@ test18
 test19
 test20
 test21
+test22
 tst_expiration_timer
 test_assert
 test_timer
diff --git a/lib/newlib_tests/test22.c b/lib/newlib_tests/test22.c
new file mode 100644
index 000000000..520b8dad8
--- /dev/null
+++ b/lib/newlib_tests/test22.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*
+ * Test that TBROK is propagated correctly to the results even if we wait on
+ * child and throw away the status.
+ */
+#include "tst_test.h"
+
+static void do_test(void)
+{
+	int pid = SAFE_FORK();
+
+	if (pid) {
+		tst_res(TPASS, "Test main pid");
+		SAFE_WAITPID(pid, NULL, 0);
+		return;
+	}
+
+	if (tst_variant == 1)
+		tst_brk(TBROK, "Test child!");
+	else
+		tst_brk(TCONF, "Test child!");
+
+	tst_res(TPASS, "Test child");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.test_variants = 2,
+	.forks_child = 1,
+};
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 535c0ff4c..128058e6e 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -56,6 +56,7 @@ struct results {
 	int skipped;
 	int failed;
 	int warnings;
+	int broken;
 	unsigned int timeout;
 };
 
@@ -179,6 +180,9 @@ static void update_results(int ttype)
 	case TFAIL:
 		tst_atomic_inc(&results->failed);
 	break;
+	case TBROK:
+		tst_atomic_inc(&results->broken);
+	break;
 	}
 }
 
@@ -368,10 +372,8 @@ static void check_child_status(pid_t pid, int status)
 	ret = WEXITSTATUS(status);
 	switch (ret) {
 	case TPASS:
-	break;
 	case TBROK:
 	case TCONF:
-		tst_brk(ret, "Reported by child (%i)", pid);
 	break;
 	default:
 		tst_brk(TBROK, "Invalid child (%i) exit value %i", pid, ret);
@@ -698,9 +700,13 @@ static void do_exit(int ret)
 		if (results->warnings)
 			ret |= TWARN;
 
+		if (results->broken)
+			ret |= TBROK;
+
 		printf("\nSummary:\n");
 		printf("passed   %d\n", results->passed);
 		printf("failed   %d\n", results->failed);
+		printf("broken   %d\n", results->broken);
 		printf("skipped  %d\n", results->skipped);
 		printf("warnings %d\n", results->warnings);
 	}
@@ -737,6 +743,9 @@ static int results_equal(struct results *a, struct results *b)
 	if (a->skipped != b->skipped)
 		return 0;
 
+	if (a->broken != b->broken)
+		return 0;
+
 	return 1;
 }
 
-- 
2.26.2

