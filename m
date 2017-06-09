From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Fri, 9 Jun 2017 18:56:01 +0800
Subject: [LTP] [PATCH 2/2] syscalls/open02: Cleanup && convert to new library
In-Reply-To: <1497005761-1215-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1497005761-1215-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <1497005761-1215-2-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/open/open02.c | 92 ++++++++++++---------------------
 1 file changed, 33 insertions(+), 59 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open02.c b/testcases/kernel/syscalls/open/open02.c
index 30f8472..518f0f0 100644
--- a/testcases/kernel/syscalls/open/open02.c
+++ b/testcases/kernel/syscalls/open/open02.c
@@ -1,6 +1,7 @@
 /*
  * Copyright (c) International Business Machines  Corp., 2001
  *	07/2001 Ported by Wayne Boyer
+ *	06/2017 Modified by Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
  *
  * This program is free software;  you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -31,91 +32,64 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <pwd.h>
-#include "test.h"
-#include "safe_macros.h"
-#include "lapi/fcntl.h"
+#include "tst_test.h"
 
 #define TEST_FILE	"test_file"
 #define TEST_FILE2	"test_file2"
 
-char *TCID = "open02";
-
-static void cleanup(void);
-static void setup(void);
-
-static struct test_case_t {
+static struct tcase {
 	char *filename;
 	int flag;
 	int exp_errno;
-} test_cases[] = {
+} tcases[] = {
 	{TEST_FILE, O_RDWR, ENOENT},
 	{TEST_FILE2, O_RDONLY | O_NOATIME, EPERM},
 };
 
-int TST_TOTAL = ARRAY_SIZE(test_cases);
-static void open_verify(const struct test_case_t *);
-
-int main(int ac, char **av)
-{
-	int lc;
-	int i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		for (i = 0; i < TST_TOTAL; i++)
-			open_verify(&test_cases[i]);
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-static void setup(void)
+void setup(void)
 {
 	struct passwd *ltpuser;
 
-	tst_require_root();
+	SAFE_TOUCH(TEST_FILE2, 0644, NULL);
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	ltpuser = SAFE_GETPWNAM("nobody");
 
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	SAFE_TOUCH(cleanup, TEST_FILE2, 0644, NULL);
-
-	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
-
-	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
+	SAFE_SETEUID(ltpuser->pw_uid);
 }
 
-static void open_verify(const struct test_case_t *test)
+static void verify_open(unsigned int n)
 {
-	TEST(open(test->filename, test->flag, 0444));
+	struct tcase *tc = &tcases[n];
+
+	TEST(open(tc->filename, tc->flag, 0444));
 
 	if (TEST_RETURN != -1) {
-		tst_resm(TFAIL, "open(%s) succeeded unexpectedly",
-			 test->filename);
+		tst_res(TFAIL, "open(%s) succeeded unexpectedly",
+			tc->filename);
 		return;
 	}
 
-	if (TEST_ERRNO != test->exp_errno) {
-		tst_resm(TFAIL | TTERRNO,
-			 "open() failed unexpectedly; expected: %d - %s",
-			 test->exp_errno, strerror(test->exp_errno));
-	} else {
-		tst_resm(TPASS | TTERRNO, "open() failed as expected");
+	if (tc->exp_errno != TEST_ERRNO) {
+		tst_res(TFAIL | TTERRNO,
+			"open() should fail with %s",
+			tst_strerrno(tc->exp_errno));
+		return;
 	}
+
+	tst_res(TPASS | TTERRNO, "open() failed as expected");
 }
 
-static void cleanup(void)
+void cleanup(void)
 {
-	if (seteuid(0))
-		tst_resm(TWARN | TERRNO, "seteuid(0) failed");
-
-	tst_rmdir();
+	SAFE_SETEUID(0);
 }
+
+static struct tst_test test = {
+	.tid = "open02",
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = verify_open,
+};
-- 
1.8.4.2



