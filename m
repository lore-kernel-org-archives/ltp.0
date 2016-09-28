From: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
Date: Wed, 28 Sep 2016 13:53:07 +0200
Subject: [LTP]  [PATCH] Allow usage of <sys/xattr.h> header.
Message-ID: <1475063587-24552-1-git-send-email-dejan.jovicevic@rt-rk.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

<sys/xattr.h> is nowdays much more common than <attr/xattr.h>. Man
pages also list <sys/xattr.h> as needed header for syscalls getxattr,
setxattr, lgetxattr, llistxattr and removexattr.

Currently, related ltp tests are disabled if <attr/xattr.h> is not
found during configuration process. This patch allows compilation
if <attr/xattr.h> is not present, but <sys/xattr.h> is present. If
<sys/xattr.h> is not present, configuration and compilation will
remain unchanged.

Also, occurances of error code ENOATTR are replaced with ENODATA.
They are defined as the same value in linux kernel source code,
but ENODATA is visible to user mode application. For example,
/include/uapi/asm-generic/errno.h defines ENODATA but not ENOATTR.
Therefore, ENODATA is a better choice.

Signed-off-by: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
---
 configure.ac                                          |  1 +
 testcases/kernel/syscalls/getxattr/getxattr01.c       | 12 +++++++-----
 testcases/kernel/syscalls/getxattr/getxattr02.c       | 10 ++++++----
 testcases/kernel/syscalls/getxattr/getxattr03.c       | 10 ++++++----
 testcases/kernel/syscalls/lgetxattr/lgetxattr01.c     | 12 +++++++-----
 testcases/kernel/syscalls/lgetxattr/lgetxattr02.c     | 14 ++++++++------
 testcases/kernel/syscalls/llistxattr/llistxattr01.c   | 12 +++++++-----
 testcases/kernel/syscalls/llistxattr/llistxattr02.c   | 12 +++++++-----
 testcases/kernel/syscalls/llistxattr/llistxattr03.c   | 12 +++++++-----
 testcases/kernel/syscalls/open/open13.c               | 11 +++++++----
 testcases/kernel/syscalls/removexattr/removexattr01.c | 12 +++++++-----
 testcases/kernel/syscalls/removexattr/removexattr02.c | 12 +++++++-----
 testcases/kernel/syscalls/setxattr/setxattr01.c       | 12 +++++++-----
 testcases/kernel/syscalls/setxattr/setxattr02.c       | 10 ++++++----
 testcases/kernel/syscalls/setxattr/setxattr03.c       | 10 ++++++----
 15 files changed, 96 insertions(+), 66 deletions(-)

diff --git a/configure.ac b/configure.ac
index 9901612..37ee6b9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -36,6 +36,7 @@ AC_CHECK_HEADERS([ \
     libaio.h \
     mm.h \
     pthread.h \
+    sys/xattr.h \
     attr/xattr.h \
     linux/genetlink.h \
     linux/mempolicy.h \
diff --git a/testcases/kernel/syscalls/getxattr/getxattr01.c b/testcases/kernel/syscalls/getxattr/getxattr01.c
index f99ed24..fe1f28c 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr01.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr01.c
@@ -44,14 +44,16 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#ifdef HAVE_ATTR_XATTR_H
+#ifdef HAVE_SYS_XATTR_H
+#include <sys/xattr.h>
+#elif HAVE_ATTR_XATTR_H
 #include <attr/xattr.h>
 #endif
 #include "test.h"
 
 char *TCID = "getxattr01";
 
-#ifdef HAVE_ATTR_XATTR_H
+#if defined(HAVE_SYS_XATTR_H) || defined(HAVE_ATTR_XATTR_H)
 #define XATTR_TEST_KEY "user.testkey"
 #define XATTR_TEST_VALUE "this is a test value"
 #define XATTR_TEST_VALUE_SIZE 20
@@ -75,7 +77,7 @@ struct test_case tc[] = {
 	 .key = "user.nosuchkey",
 	 .value = NULL,
 	 .size = BUFFSIZE - 1,
-	 .exp_err = ENOATTR,
+	 .exp_err = ENODATA,
 	 },
 	{			/* case 01, small value buffer */
 	 .fname = filename,
@@ -171,9 +173,9 @@ static void cleanup(void)
 {
 	tst_rmdir();
 }
-#else /* HAVE_ATTR_XATTR_H */
+#else /* HAVE_SYS_XATTR_H or HAVE_ATTR_XATTR_H */
 int main(int argc, char *argv[])
 {
-	tst_brkm(TCONF, NULL, "<attr/xattr.h> does not exist.");
+	tst_brkm(TCONF, NULL, "neither <sys/xattr.h> nor <attr/xattr.h> does not exist.");
 }
 #endif
diff --git a/testcases/kernel/syscalls/getxattr/getxattr02.c b/testcases/kernel/syscalls/getxattr/getxattr02.c
index 8c5be0f..742d743 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr02.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr02.c
@@ -49,14 +49,16 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#ifdef HAVE_ATTR_XATTR_H
+#ifdef HAVE_SYS_XATTR_H
+#include <sys/xattr.h>
+#elif HAVE_ATTR_XATTR_H
 #include <attr/xattr.h>
 #endif
 #include "test.h"
 
 char *TCID = "getxattr02";
 
-#ifdef HAVE_ATTR_XATTR_H
+#if defined(HAVE_SYS_XATTR_H) || defined(HAVE_ATTR_XATTR_H)
 #define XATTR_TEST_KEY "user.testkey"
 
 #define FIFO "getxattr02fifo"
@@ -160,9 +162,9 @@ static void cleanup(void)
 {
 	tst_rmdir();
 }
-#else /* HAVE_ATTR_XATTR_H */
+#else /* HAVE_SYS_XATTTR_H or HAVE_ATTR_XATTR_H */
 int main(int argc, char *argv[])
 {
-	tst_brkm(TCONF, NULL, "<attr/xattr.h> does not exist.");
+	tst_brkm(TCONF, NULL, "neither <sys/xattr.h> nor <attr/xattr.h> does not exist.");
 }
 #endif
diff --git a/testcases/kernel/syscalls/getxattr/getxattr03.c b/testcases/kernel/syscalls/getxattr/getxattr03.c
index 75339f7..1a09fb7 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr03.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr03.c
@@ -38,14 +38,16 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#ifdef HAVE_ATTR_XATTR_H
+#ifdef HAVE_SYS_XATTR_H
+#include <sys/xattr.h>
+#elif HAVE_ATTR_XATTR_H
 #include <attr/xattr.h>
 #endif
 #include "test.h"
 
 char *TCID = "getxattr03";
 
-#ifdef HAVE_ATTR_XATTR_H
+#if defined(HAVE_SYS_XATTR_H) || defined(HAVE_ATTR_XATTR_H)
 #define XATTR_TEST_KEY "user.testkey"
 #define XATTR_TEST_VALUE "test value"
 #define XATTR_TEST_VALUE_SIZE (sizeof(XATTR_TEST_VALUE) - 1)
@@ -110,9 +112,9 @@ static void cleanup(void)
 {
 	tst_rmdir();
 }
-#else /* HAVE_ATTR_XATTR_H */
+#else /* HAVE_SYS_XATTR_H or HAVE_ATTR_XATTR_H */
 int main(int argc, char *argv[])
 {
-	tst_brkm(TCONF, NULL, "<attr/xattr.h> does not exist.");
+	tst_brkm(TCONF, NULL, "neither <sys/xattr.h> nor <attr/xattr.h> does not exist.");
 }
 #endif
diff --git a/testcases/kernel/syscalls/lgetxattr/lgetxattr01.c b/testcases/kernel/syscalls/lgetxattr/lgetxattr01.c
index b9afc9a..c4e0b37 100644
--- a/testcases/kernel/syscalls/lgetxattr/lgetxattr01.c
+++ b/testcases/kernel/syscalls/lgetxattr/lgetxattr01.c
@@ -29,13 +29,15 @@
 #include <sys/types.h>
 #include <string.h>
 
-#ifdef HAVE_ATTR_XATTR_H
-# include <attr/xattr.h>
+#ifdef HAVE_SYS_XATTR_H
+#include <sys/xattr.h>
+#elif HAVE_ATTR_XATTR_H
+#include <attr/xattr.h>
 #endif
 
 #include "tst_test.h"
 
-#ifdef HAVE_ATTR_XATTR_H
+#if defined(HAVE_SYS_XATTR_H) || defined(HAVE_ATTR_XATTR_H)
 
 #define SECURITY_KEY1   "security.ltptest1"
 #define SECURITY_KEY2   "security.ltptest2"
@@ -113,5 +115,5 @@ static struct tst_test test = {
 };
 
 #else
-	TST_TEST_TCONF("<attr/xattr.h> does not exist.");
-#endif /* HAVE_ATTR_XATTR_H */
+	TST_TEST_TCONF("neither <sys/xattr.h> nor <attr/xattr.h> does not exist.");
+#endif /* HAVE_SYS_XATTR_H or HAVE_ATTR_XATTR_H */
diff --git a/testcases/kernel/syscalls/lgetxattr/lgetxattr02.c b/testcases/kernel/syscalls/lgetxattr/lgetxattr02.c
index 53b7f50..18f83fb 100644
--- a/testcases/kernel/syscalls/lgetxattr/lgetxattr02.c
+++ b/testcases/kernel/syscalls/lgetxattr/lgetxattr02.c
@@ -35,13 +35,15 @@
 #include <sys/types.h>
 #include <string.h>
 
-#ifdef HAVE_ATTR_XATTR_H
-# include <attr/xattr.h>
+#ifdef HAVE_SYS_XATTR_H
+#include <sys/xattr.h>
+#elif HAVE_ATTR_XATTR_H
+#include <attr/xattr.h>
 #endif
 
 #include "tst_test.h"
 
-#ifdef HAVE_ATTR_XATTR_H
+#if defined(HAVE_SYS_XATTR_H) || defined(HAVE_ATTR_XATTR_H)
 
 #define SECURITY_KEY	"security.ltptest"
 #define VALUE	"this is a test value"
@@ -51,7 +53,7 @@ static struct test_case {
 	size_t size;
 	int exp_err;
 } tcase[] = {
-	{"testfile", sizeof(VALUE), ENOATTR},
+	{"testfile", sizeof(VALUE), ENODATA},
 	{"symlink", 1, ERANGE},
 	{(char *)-1, sizeof(VALUE), EFAULT}
 };
@@ -103,6 +105,6 @@ static struct tst_test test = {
 	.setup = setup
 };
 
-#else /* HAVE_ATTR_XATTR_H */
-	TST_TEST_TCONF("<attr/xattr.h> does not exist.");
+#else /* HAVE_SYS_XATTR_H or HAVE_ATTR_XATTR_H */
+	TST_TEST_TCONF("neither <sys/xattr.h> nor <attr/xattr.h> does not exist.");
 #endif
diff --git a/testcases/kernel/syscalls/llistxattr/llistxattr01.c b/testcases/kernel/syscalls/llistxattr/llistxattr01.c
index f543a97..beb021d 100644
--- a/testcases/kernel/syscalls/llistxattr/llistxattr01.c
+++ b/testcases/kernel/syscalls/llistxattr/llistxattr01.c
@@ -29,13 +29,15 @@
 #include <sys/types.h>
 #include <string.h>
 
-#ifdef HAVE_ATTR_XATTR_H
-# include <attr/xattr.h>
+#ifdef HAVE_SYS_XATTR_H
+#include <sys/xattr.h>
+#elif HAVE_ATTR_XATTR_H
+#include <attr/xattr.h>
 #endif
 
 #include "tst_test.h"
 
-#ifdef HAVE_ATTR_XATTR_H
+#if defined(HAVE_SYS_XATTR_H) || defined(HAVE_ATTR_XATTR_H)
 
 #define SECURITY_KEY1	"security.ltptest1"
 #define SECURITY_KEY2	"security.ltptest2"
@@ -120,6 +122,6 @@ static struct tst_test test = {
 };
 
 #else
-	TST_TEST_TCONF("<attr/xattr.h> does not exist.");
-#endif /* HAVE_ATTR_XATTR_H */
+	TST_TEST_TCONF("neither <sys/xattr.h> nor <attr/xattr.h> does not exist.");
+#endif /* HAVE_SYS_XATTR_H or HAVE_ATTR_XATTR_H */
 
diff --git a/testcases/kernel/syscalls/llistxattr/llistxattr02.c b/testcases/kernel/syscalls/llistxattr/llistxattr02.c
index 6aede03..2287438 100644
--- a/testcases/kernel/syscalls/llistxattr/llistxattr02.c
+++ b/testcases/kernel/syscalls/llistxattr/llistxattr02.c
@@ -33,13 +33,15 @@
 #include <errno.h>
 #include <sys/types.h>
 
-#ifdef HAVE_ATTR_XATTR_H
-# include <attr/xattr.h>
+#ifdef HAVE_SYS_XATTR_H
+#include <sys/xattr.h>
+#elif HAVE_ATTR_XATTR_H
+#include <attr/xattr.h>
 #endif
 
 #include "tst_test.h"
 
-#ifdef HAVE_ATTR_XATTR_H
+#if defined(HAVE_SYS_XATTR_H) || defined(HAVE_ATTR_XATTR_H)
 
 #define SECURITY_KEY	"security.ltptest"
 #define VALUE	"test"
@@ -106,6 +108,6 @@ static struct tst_test test = {
 	.setup = setup,
 };
 
-#else /* HAVE_ATTR_XATTR_H */
-	TST_TEST_TCONF("<attr/xattr.h> does not exist.");
+#else /* HAVE_SYS_XATTR_H HAVE_ATTR_XATTR_H */
+	TST_TEST_TCONF("neither <sys/xattr.h> nor <attr/xattr.h> does not exist.");
 #endif
diff --git a/testcases/kernel/syscalls/llistxattr/llistxattr03.c b/testcases/kernel/syscalls/llistxattr/llistxattr03.c
index 5513019..7e07901 100644
--- a/testcases/kernel/syscalls/llistxattr/llistxattr03.c
+++ b/testcases/kernel/syscalls/llistxattr/llistxattr03.c
@@ -27,13 +27,15 @@
 #include <errno.h>
 #include <sys/types.h>
 
-#ifdef HAVE_ATTR_XATTR_H
-# include <attr/xattr.h>
+#ifdef HAVE_SYS_XATTR_H
+#include <sys/xattr.h>
+#elif HAVE_ATTR_XATTR_H
+#include <attr/xattr.h>
 #endif
 
 #include "tst_test.h"
 
-#ifdef HAVE_ATTR_XATTR_H
+#if defined(HAVE_SYS_XATTR_H) || defined(HAVE_ATTR_XATTR_H)
 
 #define SECURITY_KEY	"security.ltptest"
 #define VALUE	"test"
@@ -97,6 +99,6 @@ static struct tst_test test = {
 	.setup = setup,
 };
 
-#else /* HAVE_ATTR_XATTR_H */
-	TST_TEST_TCONF("<attr/xattr.h> does not exist.");
+#else /* HAVE_SYS_XATTR_H or HAVE_ATTR_XATTR_H */
+	TST_TEST_TCONF("neither <sys/xattr.h> nor <attr/xattr.h> does not exist.");
 #endif
diff --git a/testcases/kernel/syscalls/open/open13.c b/testcases/kernel/syscalls/open/open13.c
index 1342dc2..5eab950 100644
--- a/testcases/kernel/syscalls/open/open13.c
+++ b/testcases/kernel/syscalls/open/open13.c
@@ -30,7 +30,10 @@
 #include "config.h"
 
 #include <errno.h>
-#ifdef HAVE_ATTR_XATTR_H
+#ifdef HAVE_SYS_XATTR_H
+#include <sys/types.h>
+#include <sys/xattr.h>
+#elif HAVE_ATTR_XATTR_H
 #include <sys/types.h>
 #include <attr/xattr.h>
 #endif
@@ -47,7 +50,7 @@ static void verify_read(void);
 static void verify_write(void);
 static void verify_fchmod(void);
 static void verify_fchown(void);
-#ifdef HAVE_ATTR_XATTR_H
+#if defined(HAVE_SYS_XATTR_H) || defined(HAVE_ATTR_XATTR_H)
 static void verify_fgetxattr(void);
 #endif
 static void check_result(const char *call_name);
@@ -60,7 +63,7 @@ static void (*test_func[])(void) = {
 	verify_write,
 	verify_fchmod,
 	verify_fchown,
-#ifdef HAVE_ATTR_XATTR_H
+#if defined(HAVE_SYS_XATTR_H) || defined(HAVE_ATTR_XATTR_H)
 	verify_fgetxattr
 #endif
 };
@@ -135,7 +138,7 @@ static void verify_fchown(void)
 	check_result("fchown(2)");
 }
 
-#ifdef HAVE_ATTR_XATTR_H
+#if defined(HAVE_SYS_XATTR_H) || defined(HAVE_ATTR_XATTR_H)
 static void verify_fgetxattr(void)
 {
 	TEST(fgetxattr(fd, "tkey", NULL, 1));
diff --git a/testcases/kernel/syscalls/removexattr/removexattr01.c b/testcases/kernel/syscalls/removexattr/removexattr01.c
index 224065a..2e7b200 100644
--- a/testcases/kernel/syscalls/removexattr/removexattr01.c
+++ b/testcases/kernel/syscalls/removexattr/removexattr01.c
@@ -27,7 +27,9 @@
 #include <errno.h>
 #include <sys/types.h>
 
-#ifdef HAVE_ATTR_XATTR_H
+#ifdef HAVE_SYS_XATTR_H
+#include <sys/xattr.h>
+#elif HAVE_ATTR_XATTR_H
 #include <attr/xattr.h>
 #endif
 
@@ -36,7 +38,7 @@
 
 char *TCID = "removexattr01";
 
-#ifdef HAVE_ATTR_XATTR_H
+#if defined(HAVE_SYS_XATTR_H) || defined(HAVE_ATTR_XATTR_H)
 #define USER_KEY	"user.test"
 #define VALUE	"test"
 #define VALUE_SIZE	(sizeof(VALUE) - 1)
@@ -93,7 +95,7 @@ static void verify_removexattr(void)
 		return;
 	}
 
-	if (errno != ENOATTR) {
+	if (errno != ENODATA) {
 		tst_resm(TFAIL | TTERRNO, "getxattr() failed unexpectedly");
 	} else {
 		tst_resm(TPASS, "removexattr() succeeded");
@@ -116,9 +118,9 @@ static void cleanup(void)
 	tst_rmdir();
 }
 
-#else /* HAVE_ATTR_XATTR_H */
+#else /* HAVE_SYS_XATTR_H or HAVE_ATTR_XATTR_H */
 int main(int ac, char **av)
 {
-	tst_brkm(TCONF, NULL, "<attr/xattr.h> does not exist.");
+	tst_brkm(TCONF, NULL, "neither <sys/xattr.h> nor <attr/xattr.h> does not exist.");
 }
 #endif
diff --git a/testcases/kernel/syscalls/removexattr/removexattr02.c b/testcases/kernel/syscalls/removexattr/removexattr02.c
index e811db2..07a26f3 100644
--- a/testcases/kernel/syscalls/removexattr/removexattr02.c
+++ b/testcases/kernel/syscalls/removexattr/removexattr02.c
@@ -32,7 +32,9 @@
 #include <errno.h>
 #include <sys/types.h>
 
-#ifdef HAVE_ATTR_XATTR_H
+#ifdef HAVE_SYS_XATTR_H
+#include <sys/xattr.h>
+#elif HAVE_ATTR_XATTR_H
 #include <attr/xattr.h>
 #endif
 
@@ -41,7 +43,7 @@
 
 char *TCID = "removexattr02";
 
-#ifdef HAVE_ATTR_XATTR_H
+#if defined(HAVE_SYS_XATTR_H) || defined(HAVE_ATTR_XATTR_H)
 
 static struct test_case {
 	const char *path;
@@ -49,7 +51,7 @@ static struct test_case {
 	int exp_err;
 } tc[] = {
 	/* test1 */
-	{"testfile", "user.test", ENOATTR},
+	{"testfile", "user.test", ENODATA},
 	/* test2 */
 	{"", "user.test", ENOENT},
 	/* test3 */
@@ -120,9 +122,9 @@ static void cleanup(void)
 	tst_rmdir();
 }
 
-#else /* HAVE_ATTR_XATTR_H */
+#else /* HAVE_SYS_XATTR_H or HAVE_ATTR_XATTR_H */
 int main(int ac, char **av)
 {
-	tst_brkm(TCONF, NULL, "<attr/xattr.h> does not exist.");
+	tst_brkm(TCONF, NULL, "neither <sys/xattr.h> nor <attr/xattr.h> does not exist.");
 }
 #endif
diff --git a/testcases/kernel/syscalls/setxattr/setxattr01.c b/testcases/kernel/syscalls/setxattr/setxattr01.c
index 9f3af6e..0d18bff 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr01.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr01.c
@@ -54,14 +54,16 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#ifdef HAVE_ATTR_XATTR_H
+#ifdef HAVE_SYS_XATTR_H
+#include <sys/xattr.h>
+#elif HAVE_ATTR_XATTR_H
 #include <attr/xattr.h>
 #endif
 #include "test.h"
 
 char *TCID = "setxattr01";
 
-#ifdef HAVE_ATTR_XATTR_H
+#if defined(HAVE_SYS_XATTR_H) || defined(HAVE_ATTR_XATTR_H)
 #define XATTR_NAME_MAX 255
 #define XATTR_NAME_LEN (XATTR_NAME_MAX + 2)
 #define XATTR_SIZE_MAX 65536
@@ -99,7 +101,7 @@ struct test_case tc[] = {
 	 .value = XATTR_TEST_VALUE,
 	 .size = XATTR_TEST_VALUE_SIZE,
 	 .flags = XATTR_REPLACE,
-	 .exp_err = ENOATTR,
+	 .exp_err = ENODATA,
 	 },
 	{			/* case 02, long key name, key will be set in setup() */
 	 .fname = filename,
@@ -221,9 +223,9 @@ static void cleanup(void)
 {
 	tst_rmdir();
 }
-#else /* HAVE_ATTR_XATTR_H */
+#else /* HAVE_SYS_XATTR_H or HAVE_ATTR_XATTR_H */
 int main(int argc, char *argv[])
 {
-	tst_brkm(TCONF, NULL, "<attr/xattr.h> does not exist.");
+	tst_brkm(TCONF, NULL, "neither <sys/xattr.h> nor <attr/xattr.h> does not exist.");
 }
 #endif
diff --git a/testcases/kernel/syscalls/setxattr/setxattr02.c b/testcases/kernel/syscalls/setxattr/setxattr02.c
index 0ae0b3f..762ce6b 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr02.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr02.c
@@ -53,14 +53,16 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#ifdef HAVE_ATTR_XATTR_H
+#ifdef HAVE_SYS_XATTR_H
+#include <sys/xattr.h>
+#elif HAVE_ATTR_XATTR_H
 #include <attr/xattr.h>
 #endif
 #include "test.h"
 
 char *TCID = "setxattr02";
 
-#ifdef HAVE_ATTR_XATTR_H
+#if defined(HAVE_SYS_XATTR_H) || defined(HAVE_ATTR_XATTR_H)
 #define XATTR_TEST_KEY "user.testkey"
 #define XATTR_TEST_VALUE "this is a test value"
 #define XATTR_TEST_VALUE_SIZE 20
@@ -234,9 +236,9 @@ static void cleanup(void)
 {
 	tst_rmdir();
 }
-#else /* HAVE_ATTR_XATTR_H */
+#else /* HAVE_SYS_XATTR_H or HAVE_ATTR_XATTR_H */
 int main(int argc, char *argv[])
 {
-	tst_brkm(TCONF, NULL, "<attr/xattr.h> does not exist.");
+	tst_brkm(TCONF, NULL, "neither <sys/xattr.h> nor <attr/xattr.h> does not exist.");
 }
 #endif
diff --git a/testcases/kernel/syscalls/setxattr/setxattr03.c b/testcases/kernel/syscalls/setxattr/setxattr03.c
index edf5c96..4c2595b 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr03.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr03.c
@@ -44,7 +44,9 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#ifdef HAVE_ATTR_XATTR_H
+#ifdef HAVE_SYS_XATTR_H
+#include <sys/xattr.h>
+#elif HAVE_ATTR_XATTR_H
 #include <attr/xattr.h>
 #endif
 #include <linux/fs.h>
@@ -53,7 +55,7 @@
 
 char *TCID = "setxattr03";
 
-#if defined HAVE_ATTR_XATTR_H && defined HAVE_FS_IOC_FLAGS
+#if (defined HAVE_ATTR_XATTR_H || defined HAVE_SYS_XATTR_H) && defined HAVE_FS_IOC_FLAGS
 #define XATTR_TEST_KEY "user.testkey"
 #define XATTR_TEST_VALUE "this is a test value"
 #define XATTR_TEST_VALUE_SIZE (sizeof(XATTR_TEST_VALUE) - 1)
@@ -213,7 +215,7 @@ static void cleanup(void)
 #else
 int main(void)
 {
-	tst_brkm(TCONF, NULL, "<attr/xattr.h> not present or FS_IOC_FLAGS "
+	tst_brkm(TCONF, NULL, "neither <sys/xattr.h> nor<attr/xattr.h> are not present or FS_IOC_FLAGS "
 		 "missing in <linux/fs.h>");
 }
-#endif /* defined HAVE_ATTR_XATTR_H && defined HAVE_FS_IOC_FLAGS */
+#endif /* (defined HAVE_ATTR_XATTR_H || defined HAVE_SYS_XATTR_H) && defined HAVE_FS_IOC_FLAGS */
-- 
1.9.1

