From: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
Date: Tue,  4 Oct 2016 11:14:00 +0200
Subject: [LTP]  [PATCH v2] Allow usage of <sys/xattr.h> header.
Message-ID: <1475572440-24827-1-git-send-email-dejan.jovicevic@rt-rk.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

v1 -> v2:
	- made the appropriate changes for completley
	  switching from using <attr/xattr.h> header
	  to <sys/xattr.h> header.

Agreed that using the glibc header (<sys/xattr.h>)
only, instead the both headers combined, opts to a
cleaner and less buggy code.

LTP tests that use the xattr.h header can now compile
and run without any problems.

Signed-off-by: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
---
 configure.ac                                          |  2 +-
 testcases/kernel/syscalls/getxattr/getxattr01.c       | 14 +++++++-------
 testcases/kernel/syscalls/getxattr/getxattr02.c       | 10 +++++-----
 testcases/kernel/syscalls/getxattr/getxattr03.c       | 10 +++++-----
 testcases/kernel/syscalls/lgetxattr/lgetxattr01.c     | 10 +++++-----
 testcases/kernel/syscalls/lgetxattr/lgetxattr02.c     | 14 +++++++-------
 testcases/kernel/syscalls/llistxattr/llistxattr01.c   | 10 +++++-----
 testcases/kernel/syscalls/llistxattr/llistxattr02.c   | 10 +++++-----
 testcases/kernel/syscalls/llistxattr/llistxattr03.c   | 10 +++++-----
 testcases/kernel/syscalls/open/open13.c               | 10 +++++-----
 testcases/kernel/syscalls/removexattr/removexattr01.c | 12 ++++++------
 testcases/kernel/syscalls/removexattr/removexattr02.c | 14 +++++++-------
 testcases/kernel/syscalls/setxattr/setxattr01.c       | 14 +++++++-------
 testcases/kernel/syscalls/setxattr/setxattr02.c       | 10 +++++-----
 testcases/kernel/syscalls/setxattr/setxattr03.c       | 10 +++++-----
 15 files changed, 80 insertions(+), 80 deletions(-)

diff --git a/configure.ac b/configure.ac
index 9901612..6941e0e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -36,7 +36,7 @@ AC_CHECK_HEADERS([ \
     libaio.h \
     mm.h \
     pthread.h \
-    attr/xattr.h \
+    sys/xattr.h \
     linux/genetlink.h \
     linux/mempolicy.h \
     linux/module.h \
diff --git a/testcases/kernel/syscalls/getxattr/getxattr01.c b/testcases/kernel/syscalls/getxattr/getxattr01.c
index f99ed24..ce19f1b 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr01.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr01.c
@@ -28,7 +28,7 @@
  *
  * There are 4 test cases:
  * 1. Get an non-existing attribute,
- *    getxattr(2) should return -1 and set errno to ENOATTR
+ *    getxattr(2) should return -1 and set errno to ENODATA
  * 2. Buffer size is smaller than attribute value size,
  *    getxattr(2) should return -1 and set errno to ERANGE
  * 3. Get attribute, getxattr(2) should succeed
@@ -44,14 +44,14 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#ifdef HAVE_ATTR_XATTR_H
-#include <attr/xattr.h>
+#ifdef HAVE_SYS_XATTR_H
+#include <sys/xattr.h>
 #endif
 #include "test.h"
 
 char *TCID = "getxattr01";
 
-#ifdef HAVE_ATTR_XATTR_H
+#ifdef HAVE_SYS_XATTR_H
 #define XATTR_TEST_KEY "user.testkey"
 #define XATTR_TEST_VALUE "this is a test value"
 #define XATTR_TEST_VALUE_SIZE 20
@@ -75,7 +75,7 @@ struct test_case tc[] = {
 	 .key = "user.nosuchkey",
 	 .value = NULL,
 	 .size = BUFFSIZE - 1,
-	 .exp_err = ENOATTR,
+	 .exp_err = ENODATA,
 	 },
 	{			/* case 01, small value buffer */
 	 .fname = filename,
@@ -171,9 +171,9 @@ static void cleanup(void)
 {
 	tst_rmdir();
 }
-#else /* HAVE_ATTR_XATTR_H */
+#else /* HAVE_SYS_XATTR_H */
 int main(int argc, char *argv[])
 {
-	tst_brkm(TCONF, NULL, "<attr/xattr.h> does not exist.");
+	tst_brkm(TCONF, NULL, "<sys/xattr.h> does not exist.");
 }
 #endif
diff --git a/testcases/kernel/syscalls/getxattr/getxattr02.c b/testcases/kernel/syscalls/getxattr/getxattr02.c
index 8c5be0f..d77e40c 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr02.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr02.c
@@ -49,14 +49,14 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#ifdef HAVE_ATTR_XATTR_H
-#include <attr/xattr.h>
+#ifdef HAVE_SYS_XATTR_H
+#include <sys/xattr.h>
 #endif
 #include "test.h"
 
 char *TCID = "getxattr02";
 
-#ifdef HAVE_ATTR_XATTR_H
+#ifdef HAVE_SYS_XATTR_H
 #define XATTR_TEST_KEY "user.testkey"
 
 #define FIFO "getxattr02fifo"
@@ -160,9 +160,9 @@ static void cleanup(void)
 {
 	tst_rmdir();
 }
-#else /* HAVE_ATTR_XATTR_H */
+#else /* HAVE_SYS_XATTR_H */
 int main(int argc, char *argv[])
 {
-	tst_brkm(TCONF, NULL, "<attr/xattr.h> does not exist.");
+	tst_brkm(TCONF, NULL, "<sys/xattr.h> does not exist.");
 }
 #endif
diff --git a/testcases/kernel/syscalls/getxattr/getxattr03.c b/testcases/kernel/syscalls/getxattr/getxattr03.c
index 75339f7..7192402 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr03.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr03.c
@@ -38,14 +38,14 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#ifdef HAVE_ATTR_XATTR_H
-#include <attr/xattr.h>
+#ifdef HAVE_SYS_XATTR_H
+#include <sys/xattr.h>
 #endif
 #include "test.h"
 
 char *TCID = "getxattr03";
 
-#ifdef HAVE_ATTR_XATTR_H
+#ifdef HAVE_SYS_XATTR_H
 #define XATTR_TEST_KEY "user.testkey"
 #define XATTR_TEST_VALUE "test value"
 #define XATTR_TEST_VALUE_SIZE (sizeof(XATTR_TEST_VALUE) - 1)
@@ -110,9 +110,9 @@ static void cleanup(void)
 {
 	tst_rmdir();
 }
-#else /* HAVE_ATTR_XATTR_H */
+#else /* HAVE_SYS_XATTR_H */
 int main(int argc, char *argv[])
 {
-	tst_brkm(TCONF, NULL, "<attr/xattr.h> does not exist.");
+	tst_brkm(TCONF, NULL, "<sys/xattr.h> does not exist.");
 }
 #endif
diff --git a/testcases/kernel/syscalls/lgetxattr/lgetxattr01.c b/testcases/kernel/syscalls/lgetxattr/lgetxattr01.c
index b9afc9a..4a12f0a 100644
--- a/testcases/kernel/syscalls/lgetxattr/lgetxattr01.c
+++ b/testcases/kernel/syscalls/lgetxattr/lgetxattr01.c
@@ -29,13 +29,13 @@
 #include <sys/types.h>
 #include <string.h>
 
-#ifdef HAVE_ATTR_XATTR_H
-# include <attr/xattr.h>
+#ifdef HAVE_SYS_XATTR_H
+# include <sys/xattr.h>
 #endif
 
 #include "tst_test.h"
 
-#ifdef HAVE_ATTR_XATTR_H
+#ifdef HAVE_SYS_XATTR_H
 
 #define SECURITY_KEY1   "security.ltptest1"
 #define SECURITY_KEY2   "security.ltptest2"
@@ -113,5 +113,5 @@ static struct tst_test test = {
 };
 
 #else
-	TST_TEST_TCONF("<attr/xattr.h> does not exist.");
-#endif /* HAVE_ATTR_XATTR_H */
+	TST_TEST_TCONF("<sys/xattr.h> does not exist.");
+#endif /* HAVE_SYS_XATTR_H */
diff --git a/testcases/kernel/syscalls/lgetxattr/lgetxattr02.c b/testcases/kernel/syscalls/lgetxattr/lgetxattr02.c
index 53b7f50..e50bd94 100644
--- a/testcases/kernel/syscalls/lgetxattr/lgetxattr02.c
+++ b/testcases/kernel/syscalls/lgetxattr/lgetxattr02.c
@@ -25,7 +25,7 @@
 * 3) lgetxattr(2) fails when attemptes to read from a invalid address.
 *
 * Expected Result:
-* 1) lgetxattr(2) should return -1 and set errno to ENOATTR.
+* 1) lgetxattr(2) should return -1 and set errno to ENODATA.
 * 2) lgetxattr(2) should return -1 and set errno to ERANGE.
 * 3) lgetxattr(2) should return -1 and set errno to EFAULT.
 */
@@ -35,13 +35,13 @@
 #include <sys/types.h>
 #include <string.h>
 
-#ifdef HAVE_ATTR_XATTR_H
-# include <attr/xattr.h>
+#ifdef HAVE_SYS_XATTR_H
+# include <sys/xattr.h>
 #endif
 
 #include "tst_test.h"
 
-#ifdef HAVE_ATTR_XATTR_H
+#ifdef HAVE_SYS_XATTR_H
 
 #define SECURITY_KEY	"security.ltptest"
 #define VALUE	"this is a test value"
@@ -51,7 +51,7 @@ static struct test_case {
 	size_t size;
 	int exp_err;
 } tcase[] = {
-	{"testfile", sizeof(VALUE), ENOATTR},
+	{"testfile", sizeof(VALUE), ENODATA},
 	{"symlink", 1, ERANGE},
 	{(char *)-1, sizeof(VALUE), EFAULT}
 };
@@ -103,6 +103,6 @@ static struct tst_test test = {
 	.setup = setup
 };
 
-#else /* HAVE_ATTR_XATTR_H */
-	TST_TEST_TCONF("<attr/xattr.h> does not exist.");
+#else /* HAVE_SYS_XATTR_H */
+	TST_TEST_TCONF("<sys/xattr.h> does not exist.");
 #endif
diff --git a/testcases/kernel/syscalls/llistxattr/llistxattr01.c b/testcases/kernel/syscalls/llistxattr/llistxattr01.c
index f543a97..03d7f85 100644
--- a/testcases/kernel/syscalls/llistxattr/llistxattr01.c
+++ b/testcases/kernel/syscalls/llistxattr/llistxattr01.c
@@ -29,13 +29,13 @@
 #include <sys/types.h>
 #include <string.h>
 
-#ifdef HAVE_ATTR_XATTR_H
-# include <attr/xattr.h>
+#ifdef HAVE_SYS_XATTR_H
+# include <sys/xattr.h>
 #endif
 
 #include "tst_test.h"
 
-#ifdef HAVE_ATTR_XATTR_H
+#ifdef HAVE_SYS_XATTR_H
 
 #define SECURITY_KEY1	"security.ltptest1"
 #define SECURITY_KEY2	"security.ltptest2"
@@ -120,6 +120,6 @@ static struct tst_test test = {
 };
 
 #else
-	TST_TEST_TCONF("<attr/xattr.h> does not exist.");
-#endif /* HAVE_ATTR_XATTR_H */
+	TST_TEST_TCONF("<sys/xattr.h> does not exist.");
+#endif /* HAVE_SYS_XATTR_H */
 
diff --git a/testcases/kernel/syscalls/llistxattr/llistxattr02.c b/testcases/kernel/syscalls/llistxattr/llistxattr02.c
index 6aede03..ec4ba6e 100644
--- a/testcases/kernel/syscalls/llistxattr/llistxattr02.c
+++ b/testcases/kernel/syscalls/llistxattr/llistxattr02.c
@@ -33,13 +33,13 @@
 #include <errno.h>
 #include <sys/types.h>
 
-#ifdef HAVE_ATTR_XATTR_H
-# include <attr/xattr.h>
+#ifdef HAVE_SYS_XATTR_H
+# include <sys/xattr.h>
 #endif
 
 #include "tst_test.h"
 
-#ifdef HAVE_ATTR_XATTR_H
+#ifdef HAVE_SYS_XATTR_H
 
 #define SECURITY_KEY	"security.ltptest"
 #define VALUE	"test"
@@ -106,6 +106,6 @@ static struct tst_test test = {
 	.setup = setup,
 };
 
-#else /* HAVE_ATTR_XATTR_H */
-	TST_TEST_TCONF("<attr/xattr.h> does not exist.");
+#else /* HAVE_SYS_XATTR_H */
+	TST_TEST_TCONF("<sys/xattr.h> does not exist.");
 #endif
diff --git a/testcases/kernel/syscalls/llistxattr/llistxattr03.c b/testcases/kernel/syscalls/llistxattr/llistxattr03.c
index a371632..9b65de9 100644
--- a/testcases/kernel/syscalls/llistxattr/llistxattr03.c
+++ b/testcases/kernel/syscalls/llistxattr/llistxattr03.c
@@ -27,13 +27,13 @@
 #include <errno.h>
 #include <sys/types.h>
 
-#ifdef HAVE_ATTR_XATTR_H
-# include <attr/xattr.h>
+#ifdef HAVE_SYS_XATTR_H
+#include <sys/xattr.h>
 #endif
 
 #include "tst_test.h"
 
-#ifdef HAVE_ATTR_XATTR_H
+#ifdef HAVE_SYS_XATTR_H
 
 #define SECURITY_KEY	"security.ltptest"
 #define VALUE	"test"
@@ -97,6 +97,6 @@ static struct tst_test test = {
 	.setup = setup,
 };
 
-#else /* HAVE_ATTR_XATTR_H */
-	TST_TEST_TCONF("<attr/xattr.h> does not exist.");
+#else /* HAVE_SYS_XATTR_H */
+	TST_TEST_TCONF("<sys/xattr.h> does not exist.");
 #endif
diff --git a/testcases/kernel/syscalls/open/open13.c b/testcases/kernel/syscalls/open/open13.c
index 1342dc2..3838221 100644
--- a/testcases/kernel/syscalls/open/open13.c
+++ b/testcases/kernel/syscalls/open/open13.c
@@ -30,9 +30,9 @@
 #include "config.h"
 
 #include <errno.h>
-#ifdef HAVE_ATTR_XATTR_H
+#ifdef HAVE_SYS_XATTR_H
 #include <sys/types.h>
-#include <attr/xattr.h>
+#include <sys/xattr.h>
 #endif
 
 #include "test.h"
@@ -47,7 +47,7 @@ static void verify_read(void);
 static void verify_write(void);
 static void verify_fchmod(void);
 static void verify_fchown(void);
-#ifdef HAVE_ATTR_XATTR_H
+#ifdef HAVE_SYS_XATTR_H
 static void verify_fgetxattr(void);
 #endif
 static void check_result(const char *call_name);
@@ -60,7 +60,7 @@ static void (*test_func[])(void) = {
 	verify_write,
 	verify_fchmod,
 	verify_fchown,
-#ifdef HAVE_ATTR_XATTR_H
+#ifdef HAVE_SYS_XATTR_H
 	verify_fgetxattr
 #endif
 };
@@ -135,7 +135,7 @@ static void verify_fchown(void)
 	check_result("fchown(2)");
 }
 
-#ifdef HAVE_ATTR_XATTR_H
+#ifdef HAVE_SYS_XATTR_H
 static void verify_fgetxattr(void)
 {
 	TEST(fgetxattr(fd, "tkey", NULL, 1));
diff --git a/testcases/kernel/syscalls/removexattr/removexattr01.c b/testcases/kernel/syscalls/removexattr/removexattr01.c
index 224065a..62a6df9 100644
--- a/testcases/kernel/syscalls/removexattr/removexattr01.c
+++ b/testcases/kernel/syscalls/removexattr/removexattr01.c
@@ -27,8 +27,8 @@
 #include <errno.h>
 #include <sys/types.h>
 
-#ifdef HAVE_ATTR_XATTR_H
-#include <attr/xattr.h>
+#ifdef HAVE_SYS_XATTR_H
+#include <sys/xattr.h>
 #endif
 
 #include "test.h"
@@ -36,7 +36,7 @@
 
 char *TCID = "removexattr01";
 
-#ifdef HAVE_ATTR_XATTR_H
+#ifdef HAVE_SYS_XATTR_H
 #define USER_KEY	"user.test"
 #define VALUE	"test"
 #define VALUE_SIZE	(sizeof(VALUE) - 1)
@@ -93,7 +93,7 @@ static void verify_removexattr(void)
 		return;
 	}
 
-	if (errno != ENOATTR) {
+	if (errno != ENODATA) {
 		tst_resm(TFAIL | TTERRNO, "getxattr() failed unexpectedly");
 	} else {
 		tst_resm(TPASS, "removexattr() succeeded");
@@ -116,9 +116,9 @@ static void cleanup(void)
 	tst_rmdir();
 }
 
-#else /* HAVE_ATTR_XATTR_H */
+#else /* HAVE_SYS_XATTR_H */
 int main(int ac, char **av)
 {
-	tst_brkm(TCONF, NULL, "<attr/xattr.h> does not exist.");
+	tst_brkm(TCONF, NULL, "<sys/xattr.h> does not exist.");
 }
 #endif
diff --git a/testcases/kernel/syscalls/removexattr/removexattr02.c b/testcases/kernel/syscalls/removexattr/removexattr02.c
index e811db2..38f2955 100644
--- a/testcases/kernel/syscalls/removexattr/removexattr02.c
+++ b/testcases/kernel/syscalls/removexattr/removexattr02.c
@@ -23,7 +23,7 @@
 * 3) removexattr(2) fails when attempted to read from a invalid address.
 *
 * Expected Result:
-* 1) removexattr(2) should return -1 and set errno to ENOATTR.
+* 1) removexattr(2) should return -1 and set errno to ENODATA.
 * 2) removcxattr(2) should return -1 and set errno to ENOENT.
 * 3) removexattr(2) should return -1 and set errno to EFAULT.
 */
@@ -32,8 +32,8 @@
 #include <errno.h>
 #include <sys/types.h>
 
-#ifdef HAVE_ATTR_XATTR_H
-#include <attr/xattr.h>
+#ifdef HAVE_SYS_XATTR_H
+#include <sys/xattr.h>
 #endif
 
 #include "test.h"
@@ -41,7 +41,7 @@
 
 char *TCID = "removexattr02";
 
-#ifdef HAVE_ATTR_XATTR_H
+#ifdef HAVE_SYS_XATTR_H
 
 static struct test_case {
 	const char *path;
@@ -49,7 +49,7 @@ static struct test_case {
 	int exp_err;
 } tc[] = {
 	/* test1 */
-	{"testfile", "user.test", ENOATTR},
+	{"testfile", "user.test", ENODATA},
 	/* test2 */
 	{"", "user.test", ENOENT},
 	/* test3 */
@@ -120,9 +120,9 @@ static void cleanup(void)
 	tst_rmdir();
 }
 
-#else /* HAVE_ATTR_XATTR_H */
+#else /* HAVE_SYS_XATTR_H */
 int main(int ac, char **av)
 {
-	tst_brkm(TCONF, NULL, "<attr/xattr.h> does not exist.");
+	tst_brkm(TCONF, NULL, "<sys/xattr.h> does not exist.");
 }
 #endif
diff --git a/testcases/kernel/syscalls/setxattr/setxattr01.c b/testcases/kernel/syscalls/setxattr/setxattr01.c
index 9f3af6e..7f1d593 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr01.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr01.c
@@ -30,7 +30,7 @@
  * 1. Any other flags being set except XATTR_CREATE and XATTR_REPLACE,
  *    setxattr(2) should return -1 and set errno to EINVAL
  * 2. With XATTR_REPLACE flag set but the attribute does not exist,
- *    setxattr(2) should return -1 and set errno to ENOATTR
+ *    setxattr(2) should return -1 and set errno to ENODATA
  * 3. Create new attr with name length greater than XATTR_NAME_MAX(255)
  *    setxattr(2) should return -1 and set errno to ERANGE
  * 4. Create new attr whose value length is greater than XATTR_SIZE_MAX(65536)
@@ -54,14 +54,14 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#ifdef HAVE_ATTR_XATTR_H
-#include <attr/xattr.h>
+#ifdef HAVE_SYS_XATTR_H
+#include <sys/xattr.h>
 #endif
 #include "test.h"
 
 char *TCID = "setxattr01";
 
-#ifdef HAVE_ATTR_XATTR_H
+#ifdef HAVE_SYS_XATTR_H
 #define XATTR_NAME_MAX 255
 #define XATTR_NAME_LEN (XATTR_NAME_MAX + 2)
 #define XATTR_SIZE_MAX 65536
@@ -99,7 +99,7 @@ struct test_case tc[] = {
 	 .value = XATTR_TEST_VALUE,
 	 .size = XATTR_TEST_VALUE_SIZE,
 	 .flags = XATTR_REPLACE,
-	 .exp_err = ENOATTR,
+	 .exp_err = ENODATA,
 	 },
 	{			/* case 02, long key name, key will be set in setup() */
 	 .fname = filename,
@@ -221,9 +221,9 @@ static void cleanup(void)
 {
 	tst_rmdir();
 }
-#else /* HAVE_ATTR_XATTR_H */
+#else /* HAVE_SYS_XATTR_H */
 int main(int argc, char *argv[])
 {
-	tst_brkm(TCONF, NULL, "<attr/xattr.h> does not exist.");
+	tst_brkm(TCONF, NULL, "<sys/xattr.h> does not exist.");
 }
 #endif
diff --git a/testcases/kernel/syscalls/setxattr/setxattr02.c b/testcases/kernel/syscalls/setxattr/setxattr02.c
index 0ae0b3f..dcb0515 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr02.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr02.c
@@ -53,14 +53,14 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#ifdef HAVE_ATTR_XATTR_H
-#include <attr/xattr.h>
+#ifdef HAVE_SYS_XATTR_H
+#include <sys/xattr.h>
 #endif
 #include "test.h"
 
 char *TCID = "setxattr02";
 
-#ifdef HAVE_ATTR_XATTR_H
+#ifdef HAVE_SYS_XATTR_H
 #define XATTR_TEST_KEY "user.testkey"
 #define XATTR_TEST_VALUE "this is a test value"
 #define XATTR_TEST_VALUE_SIZE 20
@@ -234,9 +234,9 @@ static void cleanup(void)
 {
 	tst_rmdir();
 }
-#else /* HAVE_ATTR_XATTR_H */
+#else /* HAVE_SYS_XATTR_H */
 int main(int argc, char *argv[])
 {
-	tst_brkm(TCONF, NULL, "<attr/xattr.h> does not exist.");
+	tst_brkm(TCONF, NULL, "<sys/xattr.h> does not exist.");
 }
 #endif
diff --git a/testcases/kernel/syscalls/setxattr/setxattr03.c b/testcases/kernel/syscalls/setxattr/setxattr03.c
index edf5c96..0e82c95 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr03.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr03.c
@@ -44,8 +44,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#ifdef HAVE_ATTR_XATTR_H
-#include <attr/xattr.h>
+#ifdef HAVE_SYS_XATTR_H
+#include <sys/xattr.h>
 #endif
 #include <linux/fs.h>
 
@@ -53,7 +53,7 @@
 
 char *TCID = "setxattr03";
 
-#if defined HAVE_ATTR_XATTR_H && defined HAVE_FS_IOC_FLAGS
+#if defined HAVE_SYS_XATTR_H && defined HAVE_FS_IOC_FLAGS
 #define XATTR_TEST_KEY "user.testkey"
 #define XATTR_TEST_VALUE "this is a test value"
 #define XATTR_TEST_VALUE_SIZE (sizeof(XATTR_TEST_VALUE) - 1)
@@ -213,7 +213,7 @@ static void cleanup(void)
 #else
 int main(void)
 {
-	tst_brkm(TCONF, NULL, "<attr/xattr.h> not present or FS_IOC_FLAGS "
+	tst_brkm(TCONF, NULL, "<sys/xattr.h> not present or FS_IOC_FLAGS "
 		 "missing in <linux/fs.h>");
 }
-#endif /* defined HAVE_ATTR_XATTR_H && defined HAVE_FS_IOC_FLAGS */
+#endif /* defined HAVE_SYS_XATTR_H && defined HAVE_FS_IOC_FLAGS */
-- 
1.9.1

