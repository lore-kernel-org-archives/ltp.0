From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  5 Sep 2017 18:09:13 +0200
Subject: [LTP] [RFC] [PATCH 10/15] syscalls/setxattr01: Convert to the new
	library.
In-Reply-To: <20170905160918.6477-1-chrubis@suse.cz>
References: <20170905160918.6477-1-chrubis@suse.cz>
Message-ID: <20170905160918.6477-10-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/setxattr/setxattr01.c | 144 +++++++++---------------
 1 file changed, 52 insertions(+), 92 deletions(-)

diff --git a/testcases/kernel/syscalls/setxattr/setxattr01.c b/testcases/kernel/syscalls/setxattr/setxattr01.c
index 478f99408..86df7ba73 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr01.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr01.c
@@ -57,9 +57,7 @@
 #ifdef HAVE_SYS_XATTR_H
 # include <sys/xattr.h>
 #endif
-#include "test.h"
-
-char *TCID = "setxattr01";
+#include "tst_test.h"
 
 #ifdef HAVE_SYS_XATTR_H
 #define XATTR_NAME_MAX 255
@@ -68,162 +66,124 @@ char *TCID = "setxattr01";
 #define XATTR_TEST_KEY "user.testkey"
 #define XATTR_TEST_VALUE "this is a test value"
 #define XATTR_TEST_VALUE_SIZE 20
+#define FNAME "setxattr01testfile"
 
-static void setup(void);
-static void cleanup(void);
-
-char filename[BUFSIZ];
-char long_key[XATTR_NAME_LEN];
-char *long_value;
+static char long_key[XATTR_NAME_LEN];
+static char *long_value;
+static char *xattr_value = XATTR_TEST_VALUE;
 
 struct test_case {
-	char *fname;
 	char *key;
-	char *value;
+	char **value;
 	size_t size;
 	int flags;
 	int exp_err;
 };
 struct test_case tc[] = {
 	{			/* case 00, invalid flags */
-	 .fname = filename,
-	 .key = XATTR_TEST_KEY,
-	 .value = XATTR_TEST_VALUE,
+	 .key = long_key,
+	 .value = &xattr_value,
 	 .size = XATTR_TEST_VALUE_SIZE,
 	 .flags = ~0,
 	 .exp_err = EINVAL,
 	 },
 	{			/* case 01, replace non-existing attribute */
-	 .fname = filename,
 	 .key = XATTR_TEST_KEY,
-	 .value = XATTR_TEST_VALUE,
+	 .value = &xattr_value,
 	 .size = XATTR_TEST_VALUE_SIZE,
 	 .flags = XATTR_REPLACE,
 	 .exp_err = ENODATA,
 	 },
-	{			/* case 02, long key name, key will be set in setup() */
-	 .fname = filename,
-	 .key = NULL,
-	 .value = XATTR_TEST_VALUE,
+	{			/* case 02, long key name */
+	 .key = long_key,
+	 .value = &xattr_value,
 	 .size = XATTR_TEST_VALUE_SIZE,
 	 .flags = XATTR_CREATE,
 	 .exp_err = ERANGE,
 	 },
-	{			/* case 03, long value, value will be set in setup() */
-	 .fname = filename,
+	{			/* case 03, long value */
 	 .key = XATTR_TEST_KEY,
-	 .value = NULL,
+	 .value = &long_value,
 	 .size = XATTR_SIZE_MAX + 1,
 	 .flags = XATTR_CREATE,
 	 .exp_err = E2BIG,
 	 },
 	{			/* case 04, zero length value */
-	 .fname = filename,
 	 .key = XATTR_TEST_KEY,
-	 .value = XATTR_TEST_VALUE,
+	 .value = &xattr_value,
 	 .size = 0,
 	 .flags = XATTR_CREATE,
 	 .exp_err = 0,
 	 },
 	{			/* case 05, create existing attribute */
-	 .fname = filename,
 	 .key = XATTR_TEST_KEY,
-	 .value = XATTR_TEST_VALUE,
+	 .value = &xattr_value,
 	 .size = XATTR_TEST_VALUE_SIZE,
 	 .flags = XATTR_CREATE,
 	 .exp_err = EEXIST,
 	 },
 	{			/* case 06, replace existing attribute */
-	 .fname = filename,
 	 .key = XATTR_TEST_KEY,
-	 .value = XATTR_TEST_VALUE,
+	 .value = &xattr_value,
 	 .size = XATTR_TEST_VALUE_SIZE,
 	 .flags = XATTR_REPLACE,
 	 .exp_err = 0,
-	 },
+	},
 };
 
-int TST_TOTAL = sizeof(tc) / sizeof(tc[0]);
-
-int main(int argc, char *argv[])
+static void verify_setxattr(unsigned int i)
 {
-	int lc;
-	int i;
+	TEST(setxattr(FNAME, tc[i].key, *tc[i].value, tc[i].size, tc[i].flags));
 
-	tst_parse_opts(argc, argv, NULL, NULL);
+	if (TEST_RETURN == -1 && TEST_ERRNO == EOPNOTSUPP)
+		tst_brk(TCONF, "setxattr() not supported");
 
-	setup();
+	if (!tc[i].exp_err) {
+		if (TEST_RETURN) {
+			tst_res(TFAIL | TTERRNO,
+				"setxattr() failed with %li", TEST_RETURN);
+			return;
+		}
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
+		tst_res(TPASS, "setxattr() passed");
+		return;
+	}
 
-		for (i = 0; i < TST_TOTAL; i++) {
-			TEST(setxattr(tc[i].fname, tc[i].key, tc[i].value,
-				      tc[i].size, tc[i].flags));
+	if (TEST_RETURN == 0) {
+		tst_res(TFAIL, "setxattr() passed unexpectedly");
+		return;
+	}
 
-			if (TEST_ERRNO == tc[i].exp_err) {
-				tst_resm(TPASS | TTERRNO, "expected behavior");
-			} else {
-				tst_resm(TFAIL | TTERRNO, "unexpected behavior "
-					 "- expected errno %d - Got",
-					 tc[i].exp_err);
-			}
-		}
+	if (TEST_ERRNO != tc[i].exp_err) {
+		tst_res(TFAIL | TTERRNO, "setxattr() should fail with %s",
+			tst_strerrno(tc[i].exp_err));
+		return;
 	}
 
-	cleanup();
-	tst_exit();
+	tst_res(TPASS | TTERRNO, "setxattr() failed");
 }
 
 static void setup(void)
 {
-	int fd;
-
-	tst_require_root();
-
-	tst_tmpdir();
-
-	/* Test for xattr support */
-	fd = creat("testfile", 0644);
-	if (fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Create testfile failed");
-	close(fd);
-	if (setxattr("testfile", "user.test", "test", 4, XATTR_CREATE) == -1)
-		if (errno == ENOTSUP)
-			tst_brkm(TCONF, cleanup, "No xattr support in fs or "
-				 "mount without user_xattr option");
-
-	/* Create test file */
-	snprintf(filename, BUFSIZ, "setxattr01testfile");
-	fd = creat(filename, 0644);
-	if (fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Create test file(%s) failed",
-			 filename);
-	close(fd);
-
-	/* Prepare test cases */
+	SAFE_TOUCH(FNAME, 0644, NULL);
+
 	snprintf(long_key, 6, "%s", "user.");
 	memset(long_key + 5, 'k', XATTR_NAME_LEN - 5);
 	long_key[XATTR_NAME_LEN - 1] = '\0';
-	tc[2].key = long_key;
 
-	long_value = malloc(XATTR_SIZE_MAX + 2);
-	if (!long_value)
-		tst_brkm(TBROK | TERRNO, cleanup, "malloc failed");
+	long_value = SAFE_MALLOC(XATTR_SIZE_MAX + 2);
 	memset(long_value, 'v', XATTR_SIZE_MAX + 2);
 	long_value[XATTR_SIZE_MAX + 1] = '\0';
-	tc[3].value = long_value;
-
-	TEST_PAUSE;
 }
 
-static void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.setup = setup,
+	.test = verify_setxattr,
+	.tcnt = ARRAY_SIZE(tc),
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+};
+
 #else /* HAVE_SYS_XATTR_H */
-int main(int argc, char *argv[])
-{
-	tst_brkm(TCONF, NULL, "<sys/xattr.h> does not exist.");
-}
+TST_TEST_TCONF("<sys/xattr.h> does not exist");
 #endif
-- 
2.13.0

