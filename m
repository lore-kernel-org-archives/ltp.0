From: QI Fuli <fukuri.sai@gmail.com>
Date: Sat, 27 Mar 2021 19:32:23 +0900
Subject: [LTP] [PATCH 3/6] syscalls/swapon/swapon02: Convert swapon02 to the
 new API
In-Reply-To: <20210327103226.99073-1-qi.fuli@fujitsu.com>
References: <20210327103226.99073-1-qi.fuli@fujitsu.com>
Message-ID: <20210327103226.99073-4-qi.fuli@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: QI Fuli <qi.fuli@fujitsu.com>

Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
---
 testcases/kernel/syscalls/swapon/swapon02.c | 145 +++++++-------------
 1 file changed, 52 insertions(+), 93 deletions(-)

diff --git a/testcases/kernel/syscalls/swapon/swapon02.c b/testcases/kernel/syscalls/swapon/swapon02.c
index f0f99619d..070bc648b 100644
--- a/testcases/kernel/syscalls/swapon/swapon02.c
+++ b/testcases/kernel/syscalls/swapon/swapon02.c
@@ -1,18 +1,9 @@
-/* Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
  */
+
 /*
  * This test case checks whether swapon(2) system call  returns
  *  1. ENOENT when the path does not exist
@@ -21,41 +12,27 @@
  *  4. EBUSY when the specified path is already being used as a swap area
  */
 
-#include <unistd.h>
 #include <errno.h>
-#include <stdlib.h>
-#include <sys/types.h>
-#include <sys/wait.h>
-#include <sys/stat.h>
-#include <fcntl.h>
 #include <pwd.h>
-#include <string.h>
-#include <sys/utsname.h>
-#include <signal.h>
-#include "test.h"
+
+#include "tst_test.h"
 #include "lapi/syscalls.h"
-#include "safe_macros.h"
-#include "libswapon.h"
+#include "libswap.h"
 
-static void setup(void);
-static void cleanup(void);
 static void setup01(void);
 static void cleanup01(void);
 
-char *TCID = "swapon02";
-int TST_TOTAL = 4;
-
 static uid_t nobody_uid;
 static int do_swapoff;
 
-static struct test_case_t {
+static struct tcase {
 	char *err_desc;
 	int exp_errno;
 	char *exp_errval;
 	char *path;
 	void (*setup)(void);
 	void (*cleanup)(void);
-} testcases[] = {
+} tcases[] = {
 	{"Path does not exist", ENOENT, "ENOENT", "./doesnotexist", NULL, NULL},
 	{"Invalid path", EINVAL, "EINVAL", "./notswap", NULL, NULL},
 	{"Permission denied", EPERM, "EPERM", "./swapfile01",
@@ -63,87 +40,69 @@ static struct test_case_t {
 	{"File already used", EBUSY, "EBUSY", "./alreadyused", NULL, NULL},
 };
 
-static void verify_swapon(struct test_case_t *test)
-{
-	if (test->setup)
-		test->setup();
-
-	TEST(ltp_syscall(__NR_swapon, test->path, 0));
-
-	if (test->cleanup)
-		test->cleanup();
-
-	if (TEST_RETURN == -1 && TEST_ERRNO == test->exp_errno) {
-		tst_resm(TPASS, "swapon(2) expected failure;"
-			 " Got errno - %s : %s",
-			 test->exp_errval, test->err_desc);
-		return;
-	}
-
-	tst_resm(TFAIL, "swapon(2) failed to produce expected error:"
-	         " %d, errno: %s and got %d.", test->exp_errno,
-	         test->exp_errval, TEST_ERRNO);
-}
-
-int main(int ac, char **av)
-{
-	int lc, i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		for (i = 0; i < TST_TOTAL; i++)
-			verify_swapon(testcases + i);
-	}
-
-	cleanup();
-	tst_exit();
-}
-
 static void setup01(void)
 {
-	SAFE_SETEUID(cleanup, nobody_uid);
+	SAFE_SETEUID(nobody_uid);
 }
 
 static void cleanup01(void)
 {
-	SAFE_SETEUID(cleanup, 0);
+	SAFE_SETEUID(0);
 }
 
 static void setup(void)
 {
 	struct passwd *nobody;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	tst_require_root();
-
-	nobody = SAFE_GETPWNAM(cleanup, "nobody");
+	nobody = SAFE_GETPWNAM("nobody");
 	nobody_uid = nobody->pw_uid;
 
-	tst_tmpdir();
-
-	is_swap_supported(cleanup, "./tstswap");
+	is_swap_supported("./tstswap");
 
-	SAFE_TOUCH(cleanup, "notswap", 0777, NULL);
-	make_swapfile(cleanup, "swapfile01", 0);
-	make_swapfile(cleanup, "alreadyused", 0);
+	SAFE_TOUCH("notswap", 0777, NULL);
+	make_swapfile("swapfile01", 0);
+	make_swapfile("alreadyused", 0);
 
-	if (ltp_syscall(__NR_swapon, "alreadyused", 0))
-		tst_resm(TWARN | TERRNO, "swapon(alreadyused) failed");
+	if (tst_syscall(__NR_swapon, "alreadyused", 0))
+		tst_res(TWARN | TERRNO, "swapon(alreadyused) failed");
 	else
 		do_swapoff = 1;
-
-	TEST_PAUSE;
 }
 
 void cleanup(void)
 {
-	if (do_swapoff && ltp_syscall(__NR_swapoff, "alreadyused"))
-		tst_resm(TWARN | TERRNO, "swapoff(alreadyused) failed");
+	if (do_swapoff && tst_syscall(__NR_swapoff, "alreadyused"))
+		tst_res(TWARN | TERRNO, "swapoff(alreadyused) failed");
+}
 
-	tst_rmdir();
+static void verify_swapon(unsigned int i)
+{
+	struct tcase *tc = tcases + i;
+	if (tc->setup)
+		tc->setup();
+
+	TEST(tst_syscall(__NR_swapon, tc->path, 0));
+
+	if (tc->cleanup)
+		tc->cleanup();
+
+	if (TST_RET == -1 && TST_ERR == tc->exp_errno) {
+		tst_res(TPASS, "swapon(2) expected failure;"
+			 " Got errno - %s : %s",
+			 tc->exp_errval, tc->err_desc);
+		return;
+	}
+
+	tst_res(TFAIL, "swapon(2) failed to produce expected error:"
+	         " %d, errno: %s and got %d.", tc->exp_errno,
+	         tc->exp_errval, TST_ERR);
 }
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.test = verify_swapon,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup
+};
-- 
2.30.2

