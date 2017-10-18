From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 18 Oct 2017 19:41:21 +0200
Subject: [LTP] [PATCH 1/1] doc,openposix: Fix typos in comments
Message-ID: <20171018174121.1091-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/test-writing-guidelines.txt                                       | 2 +-
 .../open_posix_testsuite/conformance/interfaces/pthread_exit/1-1.c    | 2 +-
 .../open_posix_testsuite/conformance/interfaces/pthread_join/2-1.c    | 2 +-
 .../conformance/interfaces/pthread_key_create/3-1.c                   | 4 ++--
 .../conformance/interfaces/pthread_key_delete/2-1.c                   | 4 ++--
 .../conformance/interfaces/pthread_rwlock_trywrlock/1-1.c             | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index edc1f602d..80a51296f 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -454,7 +454,7 @@ const char *tst_strstatus(int status);
 
 Returns string describing the status as returned by 'wait()'.
 
-WARNING: This funciton is not thread safe.
+WARNING: This function is not thread safe.
 
 [source,c]
 -------------------------------------------------------------------------------
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/1-1.c
index a5c76c0fa..a9db78023 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/1-1.c
@@ -64,7 +64,7 @@ int main(void)
 	}
 
 	/* Check to make sure that 'value_ptr' that was passed to pthread_join() and the
-	 * pthread_exit() return code that was used in the thread funciton are the same. */
+	 * pthread_exit() return code that was used in the thread function are the same. */
 	if ((long)value_ptr != RETURN_CODE) {
 		printf
 		    ("Test FAILED: pthread_exit() could not pass the return value of the thread in 'value_ptr' to pthread_join().\n");
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/2-1.c
index 1e9ea6cc6..c5359da16 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/2-1.c
@@ -68,7 +68,7 @@ int main(void)
 	/*
 	 * Check to make sure that 'value_ptr' that was passed to
 	 * pthread_join() and the pthread_exit() return code that
-	 * was used in the thread funciton are the same.
+	 * was used in the thread function are the same.
 	 */
 	if (value_ptr != RETURN_CODE) {
 		printf("Test FAILED: pthread_join() did not return the "
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_key_create/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_key_create/3-1.c
index ac96bd6f2..c6ec2f0df 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_key_create/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_key_create/3-1.c
@@ -31,7 +31,7 @@
 pthread_key_t key;
 int dest_cnt;
 
-/* Destructor funciton */
+/* Destructor function */
 void dest_func(void *p)
 {
 	dest_cnt++;
@@ -55,7 +55,7 @@ int main(void)
 {
 	pthread_t new_th;
 
-	/* Inialize the destructor flag */
+	/* Initialize the destructor flag */
 	dest_cnt = 0;
 
 	/* Create a key with a destructor function */
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_key_delete/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_key_delete/2-1.c
index 94734e5d3..77f52b15a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_key_delete/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_key_delete/2-1.c
@@ -29,7 +29,7 @@
 pthread_key_t key;
 int dest_cnt;
 
-/* Destructor funciton */
+/* Destructor function */
 void dest_func(void *p)
 {
 	dest_cnt++;
@@ -57,7 +57,7 @@ int main(void)
 {
 	pthread_t new_th;
 
-	/* Inialize the destructor flag */
+	/* Initialize the destructor flag */
 	dest_cnt = 0;
 
 	/* Create a key with a destructor function */
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_trywrlock/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_trywrlock/1-1.c
index 72eeddc7f..e0aadb14c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_trywrlock/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_trywrlock/1-1.c
@@ -7,7 +7,7 @@
  * Test pthread_rwlock_trywrlock(pthread_rwlock_t *rwlock)
  *
  * The function shall apply a write lock like the pthread_rwlock_wrlock(), with the exception
- * that the funciton shall fail if any thread currently holds rwlock(for reading and writing).
+ * that the function shall fail if any thread currently holds rwlock(for reading and writing).
  *
  * Steps:
  * 1.  Initialize a pthread_rwlock_t object 'rwlock' with pthread_rwlock_init()
-- 
2.14.2

