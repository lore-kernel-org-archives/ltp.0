From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu,  4 Aug 2016 17:16:31 +0300
Subject: [LTP] [PATCH V3 2/6] tst_test: make reap_children() part of the
	test API
In-Reply-To: <1470320195-22145-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1470320195-22145-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1470320195-22145-2-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
This is a new patch in this series.

doc/test-writing-guidelines.txt |   12 ++++++++++++
 include/tst_test.h              |    6 ++++++
 lib/tst_test.c                  |    6 +++---
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 68b4602..6ae27b6 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -653,6 +653,18 @@ exit uncleanly all you need to do is to wait for such children from the
 'test()' function so that it's reaped before the main test exits the 'test()'
 function.
 
+[source,c]
+-------------------------------------------------------------------------------
+#include "tst_test.h"
+
+void tst_reap_children(void);
+-------------------------------------------------------------------------------
+
+The 'tst_reap_children()' function makes the process wait for all of its
+children and exits with 'tst_brk(TBROK, ...)' if any of them returned
+a non zero exit code. This function may be called only from the main
+test process.
+
 2.2.9 Fork() and Parent-child synchronization
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/include/tst_test.h b/include/tst_test.h
index b02168a..7e4997f 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -64,6 +64,12 @@ pid_t safe_fork(const char *filename, unsigned int lineno);
 #include "tst_safe_net.h"
 #include "tst_safe_pthread.h"
 
+/*
+ * Wait for all children and exit with TBROK if
+ * any of them returned a non-zero exit status.
+ */
+void tst_reap_children(void);
+
 struct tst_option {
 	char *optstr;
 	char **arg;
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 6c93152..6f635ec 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -287,7 +287,7 @@ static void check_child_status(pid_t pid, int status)
 	}
 }
 
-static void reap_children(void)
+void tst_reap_children(void)
 {
 	int status;
 	pid_t pid;
@@ -644,7 +644,7 @@ static void run_tests(void)
 			exit(0);
 		}
 
-		reap_children();
+		tst_reap_children();
 
 		if (results_equal(&saved_results, results))
 			tst_brk(TBROK, "Test haven't reported results!");
@@ -659,7 +659,7 @@ static void run_tests(void)
 			exit(0);
 		}
 
-		reap_children();
+		tst_reap_children();
 
 		if (results_equal(&saved_results, results))
 			tst_brk(TBROK, "Test %i haven't reported results!", i);
-- 
1.7.1

