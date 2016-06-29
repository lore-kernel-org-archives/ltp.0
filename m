From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Wed, 29 Jun 2016 10:53:41 +0800
Subject: [LTP] [PATCH] syscalls/access03: reconstruct and convert to new API
Message-ID: <1467168821-14045-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* take use of some SAFE Marcos
* add test as root and nobody respectively

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 include/tst_test.h                          |   3 +
 testcases/kernel/syscalls/access/access03.c | 142 ++++++++++++++--------------
 2 files changed, 74 insertions(+), 71 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index 7d0cff8..265e84a 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -33,6 +33,9 @@
 #include "tst_atomic.h"
 #include "tst_kvercmp.h"
 
+/* lib/get_high_address.c */
+char *get_high_address(void);
+
 /*
  * Reports testcase result.
  */
diff --git a/testcases/kernel/syscalls/access/access03.c b/testcases/kernel/syscalls/access/access03.c
index 6f5fa70..ff93fe2 100644
--- a/testcases/kernel/syscalls/access/access03.c
+++ b/testcases/kernel/syscalls/access/access03.c
@@ -23,101 +23,101 @@
  */
 
 /*
- * access(2) test for errno(s) EFAULT.
+ * access(2) test for errno(s) EFAULT as root and nobody respectively.
  */
 
 #include <errno.h>
-#include <string.h>
-#include <signal.h>
-
 #include <unistd.h>
-#include <sys/mman.h>
-#include "test.h"
-
-static void setup(void);
-static void cleanup(void);
-
-char *TCID = "access03";
-int TST_TOTAL = 8;
+#include <sys/types.h>
+#include <pwd.h>
+#include "tst_test.h"
 
+#ifndef UCLINUX
+static uid_t uid;
 /* XXX (garrcoop): uh, this isn't a bad address yo. */
 static void *low_addr;
 static void *high_addr;
 
-#if !defined(UCLINUX)
-
-int main(int ac, char **av)
+static struct tcase {
+	void **addr;
+	int mode;
+	char *name;
+} tcases[] = {
+	{&low_addr, F_OK, "F_OK"},
+	{&low_addr, R_OK, "R_OK"},
+	{&low_addr, W_OK, "W_OK"},
+	{&low_addr, X_OK, "X_OK"},
+	{&high_addr, F_OK, "F_OK"},
+	{&high_addr, R_OK, "R_OK"},
+	{&high_addr, W_OK, "W_OK"},
+	{&high_addr, X_OK, "X_OK"}
+};
+
+static void access_test(struct tcase *tc, const char *user)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-#define TEST_ACCESS(addr, mode) \
-{ \
-	if (access(low_addr, mode) == -1) { \
-		if (errno == EFAULT) { \
-			tst_resm(TPASS, \
-			    "access(%p, %s) failed as expected with EFAULT", \
-			    addr, #mode); \
-		} else { \
-			tst_resm(TFAIL|TERRNO, \
-			    "access(%p, %s) failed unexpectedly; " \
-			    "expected (EFAULT)", addr, #mode); \
-		} \
-	} else { \
-		tst_resm(TFAIL, \
-		    "access(%p, %s) succeeded unexpectedly", addr, #mode); \
-	} \
-}
+	TEST(access(*tc->addr, tc->mode));
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		TEST_ACCESS(low_addr, R_OK);
-		TEST_ACCESS(low_addr, W_OK);
-		TEST_ACCESS(low_addr, X_OK);
-		TEST_ACCESS(low_addr, F_OK);
+	if (TEST_RETURN != -1) {
+		tst_res(TFAIL, "access(%p, %s) as %s succeeded unexpectedly",
+			*tc->addr, tc->name, user);
+		return;
+	}
 
-		TEST_ACCESS(high_addr, R_OK);
-		TEST_ACCESS(high_addr, W_OK);
-		TEST_ACCESS(high_addr, X_OK);
-		TEST_ACCESS(high_addr, F_OK);
+	if (TEST_ERRNO != EFAULT) {
+		tst_res(TFAIL | TTERRNO,
+			"access(%p, %s) as %s should fail with EFAULT",
+			*tc->addr, tc->name, user);
+		return;
 	}
 
-	cleanup();
-	tst_exit();
+	tst_res(TPASS | TTERRNO, "access(%p, %s) as %s",
+		*tc->addr, tc->name, user);
+}
+
+static void verify_access(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	pid_t pid;
+
+	/* test as root */
+	access_test(tc, "root");
+
+	/* test as nobody */
+	pid = SAFE_FORK();
+	if (pid) {
+		SAFE_WAITPID(pid, NULL, 0);
+	} else {
+		SAFE_SETUID(uid);
+		access_test(tc, "nobody");
+	}
 }
 
 static void setup(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
+	struct passwd *pw;
+
+	pw = SAFE_GETPWNAM("nobody");
+
+	uid = pw->pw_uid;
 
-	low_addr = mmap(0, 1, PROT_NONE,
-			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
-	if (low_addr == MAP_FAILED)
-		tst_brkm(TBROK | TERRNO, NULL, "mmap failed");
+	low_addr = SAFE_MMAP(0, 1, PROT_NONE,
+		MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 
 	high_addr = get_high_address();
 	if (high_addr == NULL)
-		tst_brkm(TBROK | TERRNO, NULL, "get_high_address failed");
+		tst_brk(TBROK | TERRNO, "get_high_address failed");
 	high_addr++;
-
-	tst_tmpdir();
 }
 
-static void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.tid = "access03",
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_root = 1,
+	.forks_child = 1,
+	.setup = setup,
+	.test = verify_access,
+};
 
 #else
-
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "test not available on UCLINUX");
-}
-
-#endif /* if !defined(UCLINUX) */
+	TST_TEST_TCONF("test not available on UCLINUX");
+#endif /* UCLINUX */
-- 
1.8.4.2



