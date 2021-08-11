From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 Aug 2021 14:11:41 +0200
Subject: [LTP] [PATCH v2 1/4] syscalls/chmod01: Convert to new API and
 add directory tests
In-Reply-To: <20210810151518.27618-1-zhanglianjie@uniontech.com>
References: <20210810151518.27618-1-zhanglianjie@uniontech.com>
Message-ID: <YRO+fX/4VUxyCc9J@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a minor changes, thanks.

full diff:

diff --git a/testcases/kernel/syscalls/chmod/chmod01.c b/testcases/kernel/syscalls/chmod/chmod01.c
index 4dd39efca..9f5ec4c67 100644
--- a/testcases/kernel/syscalls/chmod/chmod01.c
+++ b/testcases/kernel/syscalls/chmod/chmod01.c
@@ -1,22 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
- *   07/2001 Ported by Wayne Boyer
- *
+ * Copyright (c) International Business Machines  Corp., 2001
+ *  07/2001 Ported by Wayne Boyer
  */
 
 /*\
  * [Description]
  *
- * Test Description:
- *  Verify that, chmod(2) succeeds when used to change the mode permissions
- *  of a file or directory.
- *
- * Expected Result:
- *  chmod(2) should return 0 and the mode permissions set on file should match
- *  the specified mode.
- *
+ * Verify that chmod(2) succeeds when used to change the mode permissions
+ * of a file or directory.
  */
 
 #include "tst_test.h"
@@ -25,7 +17,7 @@
 #define TESTFILE	"testfile"
 #define TESTDIR		"testdir_1"
 
-static int modes[] = { 0, 07, 070, 0700, 0777, 02777, 04777, 06777 };
+static int modes[] = {0, 07, 070, 0700, 0777, 02777, 04777, 06777};
 
 static struct variant {
 	char *name;
@@ -43,24 +35,27 @@ static void verify_chmod(unsigned int n)
 	struct variant *tc = &variants[tst_variant];
 
 	TST_EXP_PASS(chmod(tc->name, mode), "chmod(%s, %04o)",
-	tc->name, mode);
+	             tc->name, mode);
+
 	if (!TST_PASS)
 		return;
 
 	SAFE_STAT(tc->name, &stat_buf);
 	stat_buf.st_mode &= ~tc->mode_mask;
 
-	if (stat_buf.st_mode == (unsigned int)mode)
+	if (stat_buf.st_mode == (unsigned int)mode) {
 		tst_res(TPASS, "stat(%s) mode=%04o",
 				tc->name, stat_buf.st_mode);
-	else
+	} else {
 		tst_res(TFAIL, "stat(%s) mode=%04o",
 				tc->name, stat_buf.st_mode);
+	}
 }
 
 static void setup(void)
 {
 	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
+
 	if (tst_variant)
 		SAFE_MKDIR(variants[tst_variant].name, MODE);
 	else
@@ -74,4 +69,3 @@ static struct tst_test test = {
 	.test = verify_chmod,
 	.needs_tmpdir = 1,
 };
-

-- 
Cyril Hrubis
chrubis@suse.cz
