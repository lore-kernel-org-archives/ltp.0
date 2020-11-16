From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 16 Nov 2020 17:01:20 +0800
Subject: [LTP] [PATCH 2/2] syscalls/truncate03: Convert to new API and
 cleanup
In-Reply-To: <20201116090120.31942-1-yangx.jy@cn.fujitsu.com>
References: <20201116090120.31942-1-yangx.jy@cn.fujitsu.com>
Message-ID: <20201116090120.31942-2-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 .../kernel/syscalls/truncate/truncate03.c     | 170 +++++++-----------
 1 file changed, 63 insertions(+), 107 deletions(-)

diff --git a/testcases/kernel/syscalls/truncate/truncate03.c b/testcases/kernel/syscalls/truncate/truncate03.c
index 401c16a8e..67b30a318 100644
--- a/testcases/kernel/syscalls/truncate/truncate03.c
+++ b/testcases/kernel/syscalls/truncate/truncate03.c
@@ -1,42 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *   Copyright (c) International Business Machines  Corp., 2001
- *   07/2001 John George
+ * Copyright (c) International Business Machines  Corp., 2001
+ * 07/2001 John George
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software Foundation,
- *   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-/*
- *   Test Description:
- *     Verify that,
- *     1) truncate(2) returns -1 and sets errno to EACCES if search/write
- *        permission denied for the process on the component of the path prefix
- *        or named file.
- *     2) truncate(2) returns -1 and sets errno to ENOTDIR if the component of
- *        the path prefix is not a directory.
- *     3) truncate(2) returns -1 and sets errno to EFAULT if pathname points
- *        outside user's accessible address space.
- *     4) truncate(2) returns -1 and sets errno to ENAMETOOLONG if the component
- *        of a pathname exceeded 255 characters or entire pathname exceeds 1023
- *        characters.
- *     5) truncate(2) returns -1 and sets errno to ENOENT if the named file
- *        does not exist.
- *     6) truncate(2) returns -1 and sets errno to EISDIR if the named file
- *        is a directory.
- *     7) truncate(2) returns -1 and sets errno to EFBIG if the argument length
- *        is larger than the maximum file size.
- *     8) truncate(2) returns -1 and sets errno to ELOOP if too many symbolic
- *        links were encountered in translating the pathname.
+ * Verify that,
+ * 1) truncate(2) returns -1 and sets errno to EACCES if search/write
+ *    permission denied for the process on the component of the path prefix
+ *    or named file.
+ * 2) truncate(2) returns -1 and sets errno to ENOTDIR if the component of
+ *    the path prefix is not a directory.
+ * 3) truncate(2) returns -1 and sets errno to EFAULT if pathname points
+ *    outside user's accessible address space.
+ * 4) truncate(2) returns -1 and sets errno to ENAMETOOLONG if the component
+ *    of a pathname exceeded 255 characters or entire pathname exceeds 1023
+ *    characters.
+ * 5) truncate(2) returns -1 and sets errno to ENOENT if the named file
+ *    does not exist.
+ * 6) truncate(2) returns -1 and sets errno to EISDIR if the named file
+ *    is a directory.
+ * 7) truncate(2) returns -1 and sets errno to EFBIG if the argument length
+ *    is larger than the maximum file size.
+ * 8) truncate(2) returns -1 and sets errno to ELOOP if too many symbolic
+ *    links were encountered in translating the pathname.
  */
 
 #define _GNU_SOURCE
@@ -52,8 +37,7 @@
 #include <pwd.h>
 #include <sys/resource.h>
 
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 
 #define TEST_FILE1	"testfile"
 #define TEST_FILE2	"t_file/testfile"
@@ -84,102 +68,74 @@ static struct test_case_t {
 	{ TEST_SYM1, TRUNC_LEN, ELOOP }
 };
 
-static void setup(void);
-static void cleanup(void);
-static void truncate_verify(struct test_case_t *);
-
-char *TCID = "truncate03";
-int TST_TOTAL = ARRAY_SIZE(test_cases);
-
-int main(int ac, char **av)
-{
-	int i, lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++)
-			truncate_verify(&test_cases[i]);
-
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-void setup(void)
+static void setup(void)
 {
 	struct passwd *ltpuser;
-	struct rlimit rlim;
+	struct rlimit rlim = {
+		.rlim_cur = MAX_FSIZE,
+		.rlim_max = MAX_FSIZE,
+	};
 	sigset_t signalset;
-	int n;
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	tst_require_root();
-
-	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
-	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
-
-	TEST_PAUSE;
+	unsigned int n;
 
-	tst_tmpdir();
+	ltpuser = SAFE_GETPWNAM("nobody");
+	SAFE_SETEUID(ltpuser->pw_uid);
 
-	SAFE_TOUCH(cleanup, TEST_FILE1, NEW_MODE, NULL);
+	SAFE_TOUCH(TEST_FILE1, NEW_MODE, NULL);
 
-	SAFE_TOUCH(cleanup, "t_file", FILE_MODE, NULL);
+	SAFE_TOUCH("t_file", FILE_MODE, NULL);
 
 	memset(long_pathname, 'a', PATH_MAX + 1);
 
-	SAFE_MKDIR(cleanup, TEST_DIR1, DIR_MODE);
+	SAFE_MKDIR(TEST_DIR1, DIR_MODE);
 
-	SAFE_TOUCH(cleanup, TEST_FILE3, FILE_MODE, NULL);
+	SAFE_TOUCH(TEST_FILE3, FILE_MODE, NULL);
 
-	SAFE_SYMLINK(cleanup, TEST_SYM1, TEST_SYM2);
-	SAFE_SYMLINK(cleanup, TEST_SYM2, TEST_SYM1);
+	SAFE_SYMLINK(TEST_SYM1, TEST_SYM2);
+	SAFE_SYMLINK(TEST_SYM2, TEST_SYM1);
 
-	rlim.rlim_cur = MAX_FSIZE;
-	rlim.rlim_max = MAX_FSIZE;
-	SAFE_SETRLIMIT(cleanup, RLIMIT_FSIZE, &rlim);
+	SAFE_SETRLIMIT(RLIMIT_FSIZE, &rlim);
 
-	sigemptyset(&signalset);
-	sigaddset(&signalset, SIGXFSZ);
-	TEST(sigprocmask(SIG_BLOCK, &signalset, NULL));
-	if (TEST_RETURN != 0)
-		tst_brkm(TBROK | TTERRNO, cleanup, "sigprocmask");
+	SAFE_SIGEMPTYSET(&signalset);
+	SAFE_SIGADDSET(&signalset, SIGXFSZ);
+	SAFE_SIGPROCMASK(SIG_BLOCK, &signalset, NULL);
 
-	for (n = 0; n < TST_TOTAL; n++) {
+	for (n = 0; n < ARRAY_SIZE(test_cases); n++) {
 		if (!test_cases[n].pathname)
-			test_cases[n].pathname = tst_get_bad_addr(cleanup);
+			test_cases[n].pathname = tst_get_bad_addr(NULL);
 	}
 
 }
 
-void truncate_verify(struct test_case_t *tc)
+static void verify_truncate(unsigned int n)
 {
+	struct test_case_t *tc = &test_cases[n];
+
 	TEST(truncate(tc->pathname, tc->length));
+	if (TST_RET == 0) {
+		tst_res(TFAIL, "truncate() succeeded when failure expected");
+		return;
+	}
 
-	if (TEST_RETURN != -1) {
-		tst_resm(TFAIL, "truncate() returned %ld, "
-			"expected -1, errno:%d", TEST_RETURN,
-			tc->exp_errno);
+	if (TST_RET != -1) {
+		tst_res(TFAIL, "truncate() returned invalid value %ld",
+			TST_RET);
 		return;
 	}
 
-	if (TEST_ERRNO == tc->exp_errno) {
-		tst_resm(TPASS | TTERRNO, "truncate() failed as expected");
+	if (TST_ERR == tc->exp_errno) {
+		tst_res(TPASS | TERRNO, "truncate() failed as expected");
 	} else {
-		tst_resm(TFAIL | TTERRNO,
+		tst_res(TFAIL | TTERRNO,
 			"truncate() failed unexpectedly; expected: %d - %s",
 			tc->exp_errno, strerror(tc->exp_errno));
 	}
 }
 
-void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.tcnt = ARRAY_SIZE(test_cases),
+	.test = verify_truncate,
+};
-- 
2.21.0



