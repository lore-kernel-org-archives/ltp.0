From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Wed,  8 Aug 2018 22:22:12 -0300
Subject: [LTP] [PATCH] syscalls/setxattr: fix iterations and missing coverage
Message-ID: <20180809012212.1884-1-rafael.tinoco@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

During issue #274 resolution, the following was observed:

setxattr(2) tests are not considering iterations on files that are not
re-created in between subsequent iterations. This leads to false results
due to existing attributes not cleaned in between the calls.

setxattr(2) tests were not considering 2 cases, now added:
  - new attr with a key with length 0
  - new attr with a key that is NULL

This commit makes setxattr(2) tests to behave like newly created
fsetxattr(2) tests.

Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
---
 .../kernel/syscalls/setxattr/setxattr01.c     | 61 ++++++++++++++++---
 .../kernel/syscalls/setxattr/setxattr02.c     | 45 +++++++++++---
 2 files changed, 89 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/syscalls/setxattr/setxattr01.c b/testcases/kernel/syscalls/setxattr/setxattr01.c
index b9797df2c..c1ac84846 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr01.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr01.c
@@ -41,6 +41,10 @@
  *    setxattr(2) should return -1 and set errno to EEXIST
  * 7. Replace attr value with XATTR_REPLACE flag being set,
  *    setxattr(2) should succeed
+ * 8. Create new attr whose key length is zero,
+ *    setxattr(2) should return -1 and set errno to ERANGE
+ * 9. Create new attr whose key is NULL,
+ *    setxattr(2) should return -1 and set errno to EFAULT
  */
 
 #include "config.h"
@@ -79,10 +83,11 @@ struct test_case {
 	size_t size;
 	int flags;
 	int exp_err;
+	int keyneeded;
 };
 struct test_case tc[] = {
 	{			/* case 00, invalid flags */
-	 .key = long_key,
+	 .key = XATTR_TEST_KEY,
 	 .value = &xattr_value,
 	 .size = XATTR_TEST_VALUE_SIZE,
 	 .flags = ~0,
@@ -122,6 +127,7 @@ struct test_case tc[] = {
 	 .size = XATTR_TEST_VALUE_SIZE,
 	 .flags = XATTR_CREATE,
 	 .exp_err = EEXIST,
+	 .keyneeded = 1,
 	 },
 	{			/* case 06, replace existing attribute */
 	 .key = XATTR_TEST_KEY,
@@ -129,43 +135,77 @@ struct test_case tc[] = {
 	 .size = XATTR_TEST_VALUE_SIZE,
 	 .flags = XATTR_REPLACE,
 	 .exp_err = 0,
+	 .keyneeded = 1,
+	},
+	{			/* case 07, zero length key */
+	 .key = "",
+	 .value = &xattr_value,
+	 .size = XATTR_TEST_VALUE_SIZE,
+	 .flags = XATTR_CREATE,
+	 .exp_err = ERANGE,
+	},
+	{			/* case 08, NULL key */
+	 .value = &xattr_value,
+	 .size = XATTR_TEST_VALUE_SIZE,
+	 .flags = XATTR_CREATE,
+	 .exp_err = EFAULT,
 	},
 };
 
 static void verify_setxattr(unsigned int i)
 {
+	/* some tests might require existing keys for each iteration */
+	if (tc[i].keyneeded) {
+		SAFE_SETXATTR(FNAME, tc[i].key, tc[i].value, tc[i].size,
+				XATTR_CREATE);
+	}
+
 	TEST(setxattr(FNAME, tc[i].key, *tc[i].value, tc[i].size, tc[i].flags));
 
 	if (TST_RET == -1 && TST_ERR == EOPNOTSUPP)
-		tst_brk(TCONF, "setxattr() not supported");
+		tst_brk(TCONF, "setxattr(2) not supported");
+
+	/* success */
 
 	if (!tc[i].exp_err) {
 		if (TST_RET) {
 			tst_res(TFAIL | TTERRNO,
-				"setxattr() failed with %li", TST_RET);
+				"setxattr(2) failed with %li", TST_RET);
 			return;
 		}
 
-		tst_res(TPASS, "setxattr() passed");
+		/* this is needed for subsequent iterations */
+		SAFE_REMOVEXATTR(FNAME, tc[i].key);
+
+		tst_res(TPASS, "setxattr(2) passed");
+
 		return;
 	}
 
 	if (TST_RET == 0) {
-		tst_res(TFAIL, "setxattr() passed unexpectedly");
+		tst_res(TFAIL, "setxattr(2) passed unexpectedly");
 		return;
 	}
 
-	if (TST_ERR != tc[i].exp_err) {
-		tst_res(TFAIL | TTERRNO, "setxattr() should fail with %s",
+	/* error */
+
+	if (tc[i].exp_err != TST_ERR) {
+		tst_res(TFAIL | TTERRNO, "setxattr(2) should fail with %s",
 			tst_strerrno(tc[i].exp_err));
 		return;
 	}
 
-	tst_res(TPASS | TTERRNO, "setxattr() failed");
+	/* key might have been added AND test might have failed, remove it */
+	if (tc[i].keyneeded)
+		SAFE_REMOVEXATTR(FNAME, tc[i].key);
+
+	tst_res(TPASS | TTERRNO, "setxattr(2) failed");
 }
 
 static void setup(void)
 {
+	size_t i = 0;
+
 	snprintf(long_key, 6, "%s", "user.");
 	memset(long_key + 5, 'k', XATTR_NAME_LEN - 5);
 	long_key[XATTR_NAME_LEN - 1] = '\0';
@@ -175,6 +215,11 @@ static void setup(void)
 	long_value[XATTR_SIZE_MAX + 1] = '\0';
 
 	SAFE_TOUCH(FNAME, 0644, NULL);
+
+	for (i = 0; i < ARRAY_SIZE(tc); i++) {
+		if (!tc[i].key)
+			tc[i].key = tst_get_bad_addr(NULL);
+	}
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/setxattr/setxattr02.c b/testcases/kernel/syscalls/setxattr/setxattr02.c
index aa80c1e5e..b947990b6 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr02.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr02.c
@@ -64,6 +64,7 @@
 #define XATTR_TEST_VALUE "this is a test value"
 #define XATTR_TEST_VALUE_SIZE 20
 
+#define OFFSET    10
 #define FILENAME "setxattr02testfile"
 #define DIRNAME  "setxattr02testdir"
 #define SYMLINK  "setxattr02symlink"
@@ -79,6 +80,7 @@ struct test_case {
 	size_t size;
 	int flags;
 	int exp_err;
+	int needskeyset;
 };
 static struct test_case tc[] = {
 	{			/* case 00, set attr to reg */
@@ -104,6 +106,7 @@ static struct test_case tc[] = {
 	 .size = XATTR_TEST_VALUE_SIZE,
 	 .flags = XATTR_CREATE,
 	 .exp_err = EEXIST,
+	 .needskeyset = 1,
 	 },
 	{			/* case 03, set attr to fifo */
 	 .fname = FIFO,
@@ -141,34 +144,58 @@ static struct test_case tc[] = {
 
 static void verify_setxattr(unsigned int i)
 {
-	TEST(setxattr(tc[i].fname, tc[i].key, tc[i].value, tc[i].size, tc[i].flags));
+	/* some tests might require existing keys for each iteration */
+	if (tc[i].needskeyset) {
+		SAFE_SETXATTR(tc[i].fname, tc[i].key, tc[i].value, tc[i].size,
+				XATTR_CREATE);
+	}
+
+	TEST(setxattr(tc[i].fname, tc[i].key, tc[i].value, tc[i].size,
+			tc[i].flags));
 
 	if (TST_RET == -1 && TST_ERR == EOPNOTSUPP)
-		tst_brk(TCONF, "setxattr() not supported");
+		tst_brk(TCONF, "setxattr(2) not supported");
+
+	/* success */
 
 	if (!tc[i].exp_err) {
 		if (TST_RET) {
 			tst_res(TFAIL | TTERRNO,
-				"setxattr() failed with %li", TST_RET);
+				"setxattr(2) on %s failed with %li",
+				tc[i].fname + OFFSET, TST_RET);
 			return;
 		}
 
-		tst_res(TPASS, "setxattr() passed");
+		/* this is needed for subsequent iterations */
+		SAFE_REMOVEXATTR(tc[i].fname, tc[i].key);
+
+		tst_res(TPASS, "setxattr(2) on %s passed",
+				tc[i].fname + OFFSET);
 		return;
 	}
 
 	if (TST_RET == 0) {
-		tst_res(TFAIL, "setxattr() passed unexpectedly");
+		tst_res(TFAIL, "setxattr(2) on %s passed unexpectedly",
+				tc[i].fname + OFFSET);
 		return;
 	}
 
-	if (TST_ERR != tc[i].exp_err) {
-		tst_res(TFAIL | TTERRNO, "setxattr() should fail with %s",
-			tst_strerrno(tc[i].exp_err));
+	/* fail */
+
+	if (tc[i].exp_err != TST_ERR) {
+		tst_res(TFAIL | TTERRNO,
+				"setxattr(2) on %s should have failed with %s",
+				tc[i].fname + OFFSET,
+				tst_strerrno(tc[i].exp_err));
 		return;
 	}
 
-	tst_res(TPASS | TTERRNO, "setxattr() failed");
+	/* key might have been added AND test might have failed, remove it */
+	if (tc[i].needskeyset)
+		SAFE_REMOVEXATTR(tc[i].fname, tc[i].key);
+
+	tst_res(TPASS | TTERRNO, "setxattr(2) on %s failed",
+			tc[i].fname + OFFSET);
 }
 
 static void setup(void)
-- 
2.18.0

