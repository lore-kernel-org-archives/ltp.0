From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 15 Apr 2016 14:09:13 +0200
Subject: [LTP] [PATCH v3 1/4] tst_atomic: make tst_atomic_inc take a signed
	integer
Message-ID: <9daf43fcf4de400240ca0fea83d0a63d2473a046.1460721164.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is a preparation for upcoming patches, which add atomic_add_return(),
based on kernel function of same name. Kernel's atomic_t is int based,
so let's match that.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 doc/test-writing-guidelines.txt |  2 +-
 include/tst_atomic.h            |  2 +-
 lib/newlib_tests/test08.c       |  2 +-
 lib/tst_test.c                  | 16 ++++++++--------
 4 files changed, 11 insertions(+), 11 deletions(-)

Changes in v3:
- no changes

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index d0b14084c90b..c0ef33afd5bb 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -780,7 +780,7 @@ the user supplied cleanup to the test library.
 
 static void cleanup(void)
 {
-	static unsigned int flag;
+	static int flag;
 
 	if (tst_atomic_inc(&flag) != 1)
 		pthread_exit(NULL);
diff --git a/include/tst_atomic.h b/include/tst_atomic.h
index 75c713d38d2a..2ec9f91318ea 100644
--- a/include/tst_atomic.h
+++ b/include/tst_atomic.h
@@ -18,7 +18,7 @@
 #ifndef TST_ATOMIC_H__
 #define TST_ATOMIC_H__
 
-static inline unsigned int tst_atomic_inc(unsigned int *v)
+static inline int tst_atomic_inc(int *v)
 {
 	return __sync_add_and_fetch(v, 1);
 }
diff --git a/lib/newlib_tests/test08.c b/lib/newlib_tests/test08.c
index 3d872e2af0f9..ea8dd02d8942 100644
--- a/lib/newlib_tests/test08.c
+++ b/lib/newlib_tests/test08.c
@@ -35,7 +35,7 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	static unsigned int flag;
+	static int flag;
 
 	/* Avoid subsequent threads to enter the cleanup */
 	if (tst_atomic_inc(&flag) != 1)
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 37265fe50951..b8ec246414d1 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -43,10 +43,10 @@ static float duration = -1;
 static pid_t main_pid;
 
 struct results {
-	unsigned int passed;
-	unsigned int skipped;
-	unsigned int failed;
-	unsigned int warnings;
+	int passed;
+	int skipped;
+	int failed;
+	int warnings;
 };
 
 static struct results *results;
@@ -442,10 +442,10 @@ static void do_exit(void)
 	int ret = 0;
 
 	printf("\nSummary:\n");
-	printf("passed   %u\n", results->passed);
-	printf("failed   %u\n", results->failed);
-	printf("skipped  %u\n", results->skipped);
-	printf("warnings %u\n", results->warnings);
+	printf("passed   %d\n", results->passed);
+	printf("failed   %d\n", results->failed);
+	printf("skipped  %d\n", results->skipped);
+	printf("warnings %d\n", results->warnings);
 
 	if (results->failed)
 		ret |= TFAIL;
-- 
1.8.3.1

