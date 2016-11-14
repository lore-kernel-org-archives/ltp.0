From: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
Date: Mon, 14 Nov 2016 13:13:32 +0100
Subject: [LTP] [PATCH v4 3/5] llistxattr: improved code readability and
	stability
In-Reply-To: <1479125614-24731-1-git-send-email-dejan.jovicevic@rt-rk.com>
References: <1479125614-24731-1-git-send-email-dejan.jovicevic@rt-rk.com>
Message-ID: <1479125614-24731-4-git-send-email-dejan.jovicevic@rt-rk.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Changed bits of code, such as hardcoded magic constants,
unnecessary else branches, way of passing array size to
a function, removed unnecessary comments, moved to using
macros instead of string literals where seemed to be fit.

This was done to make the code easier to read and understand,
and make it easier to maintain in case of changes

Signed-off-by: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
---
 .../kernel/syscalls/llistxattr/llistxattr01.c      | 30 ++++++++++++----------
 .../kernel/syscalls/llistxattr/llistxattr02.c      | 23 ++++++++---------
 .../kernel/syscalls/llistxattr/llistxattr03.c      | 12 ++++-----
 3 files changed, 32 insertions(+), 33 deletions(-)

diff --git a/testcases/kernel/syscalls/llistxattr/llistxattr01.c b/testcases/kernel/syscalls/llistxattr/llistxattr01.c
index f352032..0176893 100644
--- a/testcases/kernel/syscalls/llistxattr/llistxattr01.c
+++ b/testcases/kernel/syscalls/llistxattr/llistxattr01.c
@@ -37,11 +37,14 @@
 
 #ifdef HAVE_SYS_XATTR_H
 
-#define SECURITY_KEY1	"security.ltptest1"
-#define SECURITY_KEY2	"security.ltptest2"
-#define VALUE	"test"
-#define VALUE_SIZE	4
-#define KEY_SIZE    17
+#define SECURITY_KEY1   "security.ltptest1"
+#define SECURITY_KEY2   "security.ltptest2"
+#define VALUE           "test"
+#define VALUE_SIZE      (sizeof(VALUE) - 1)
+#define KEY_SIZE        (sizeof(SECURITY_KEY1) - 1)
+#define TESTFILE        "testfile"
+#define SYMLINK         "symlink"
+
 
 static int has_attribute(const char *list, int llen, const char *attr)
 {
@@ -56,22 +59,21 @@ static int has_attribute(const char *list, int llen, const char *attr)
 
 static void verify_llistxattr(void)
 {
-	int size = 64;
-	char buf[size];
+	char buf[64];
 
-	TEST(llistxattr("symlink", buf, size));
+	TEST(llistxattr(SYMLINK, buf, sizeof(buf)));
 	if (TEST_RETURN == -1) {
 		tst_res(TFAIL | TTERRNO, "llistxattr() failed");
 		return;
 	}
 
-	if (has_attribute(buf, size, SECURITY_KEY1)) {
+	if (has_attribute(buf, sizeof(buf), SECURITY_KEY1)) {
 		tst_res(TFAIL, "get file attribute %s unexpectlly",
 			 SECURITY_KEY1);
 		return;
 	}
 
-	if (!has_attribute(buf, size, SECURITY_KEY2)) {
+	if (!has_attribute(buf, sizeof(buf), SECURITY_KEY2)) {
 		tst_res(TFAIL, "missing attribute %s", SECURITY_KEY2);
 		return;
 	}
@@ -81,13 +83,13 @@ static void verify_llistxattr(void)
 
 static void setup(void)
 {
-	SAFE_TOUCH("testfile", 0644, NULL);
+	SAFE_TOUCH(TESTFILE, 0644, NULL);
 
-	SAFE_SYMLINK("testfile", "symlink");
+	SAFE_SYMLINK(TESTFILE, SYMLINK);
 
-	SAFE_LSETXATTR("testfile", SECURITY_KEY1, VALUE, VALUE_SIZE, XATTR_CREATE);
+	SAFE_LSETXATTR(TESTFILE, SECURITY_KEY1, VALUE, VALUE_SIZE, XATTR_CREATE);
 
-	SAFE_LSETXATTR("symlink", SECURITY_KEY2, VALUE, VALUE_SIZE, XATTR_CREATE);
+	SAFE_LSETXATTR(SYMLINK, SECURITY_KEY2, VALUE, VALUE_SIZE, XATTR_CREATE);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/llistxattr/llistxattr02.c b/testcases/kernel/syscalls/llistxattr/llistxattr02.c
index 2812838..ed3ace3 100644
--- a/testcases/kernel/syscalls/llistxattr/llistxattr02.c
+++ b/testcases/kernel/syscalls/llistxattr/llistxattr02.c
@@ -41,20 +41,19 @@
 
 #ifdef HAVE_SYS_XATTR_H
 
-#define SECURITY_KEY	"security.ltptest"
-#define VALUE	"test"
-#define VALUE_SIZE	4
+#define SECURITY_KEY    "security.ltptest"
+#define VALUE           "test"
+#define VALUE_SIZE      (sizeof(VALUE) - 1)
+#define TESTFILE        "testfile"
+#define SYMLINK         "symlink"
 
 static struct test_case {
 	const char *path;
 	size_t size;
 	int exp_err;
 } tc[] = {
-	/* test1 */
-	{"symlink", 1, ERANGE},
-	/* test2 */
+	{SYMLINK, 1, ERANGE},
 	{"", 20, ENOENT},
-	/* test3 */
 	{(char *)-1, 20, EFAULT}
 };
 
@@ -63,8 +62,8 @@ static void verify_llistxattr(unsigned int n)
 	struct test_case *t = tc + n;
 	char buf[t->size];
 
-	TEST(llistxattr(t->path, buf, t->size));
-	if (TEST_RETURN != -1) {
+	TEST(llistxattr(t->path, buf, sizeof(buf)));
+	if (TEST_RETURN == 0) {
 		tst_res(TFAIL, "llistxattr() succeeded unexpectedly");
 	} else {
 		if (TEST_ERRNO != t->exp_err) {
@@ -80,11 +79,11 @@ static void verify_llistxattr(unsigned int n)
 
 static void setup(void)
 {
-	SAFE_TOUCH("testfile", 0644, NULL);
+	SAFE_TOUCH(TESTFILE, 0644, NULL);
 
-	SAFE_SYMLINK("testfile", "symlink");
+	SAFE_SYMLINK(TESTFILE, SYMLINK);
 
-	SAFE_LSETXATTR("symlink", SECURITY_KEY, VALUE, VALUE_SIZE, XATTR_CREATE);
+	SAFE_LSETXATTR(SYMLINK, SECURITY_KEY, VALUE, VALUE_SIZE, XATTR_CREATE);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/llistxattr/llistxattr03.c b/testcases/kernel/syscalls/llistxattr/llistxattr03.c
index 475375e..6a1cb6b 100644
--- a/testcases/kernel/syscalls/llistxattr/llistxattr03.c
+++ b/testcases/kernel/syscalls/llistxattr/llistxattr03.c
@@ -36,8 +36,8 @@
 #ifdef HAVE_SYS_XATTR_H
 
 #define SECURITY_KEY	"security.ltptest"
-#define VALUE	"test"
-#define VALUE_SIZE	4
+#define VALUE           "test"
+#define VALUE_SIZE      (sizeof(VALUE) - 1)
 
 static const char *filename[] = {"testfile1", "testfile2"};
 
@@ -46,11 +46,9 @@ static int check_suitable_buf(const char *name, long size)
 	int n;
 	char buf[size];
 
-	n = llistxattr(name, buf, size);
-	if (n == -1)
-		return 0;
-	else
-		return 1;
+	n = llistxattr(name, buf, sizeof(buf));
+
+	return n != -1;
 }
 
 static void verify_llistxattr(unsigned int n)
-- 
1.9.1

