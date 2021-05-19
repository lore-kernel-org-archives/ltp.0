From: Xie Ziyao <xieziyao@huawei.com>
Date: Wed, 19 May 2021 16:46:55 +0800
Subject: [LTP] [PATCH 2/2] syscalls/sendfile: Convert sendfile09 to the new
 API
In-Reply-To: <20210519084655.52780-1-xieziyao@huawei.com>
References: <20210519084655.52780-1-xieziyao@huawei.com>
Message-ID: <20210519084655.52780-3-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1. Convert sendfile09 to the new API;
2. Bugfix for running with option "-i":
   * OFF_T offset = tc[i].offset;
   Use offset instead of tc[i].offset when calling sendfile(2).

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 .../kernel/syscalls/sendfile/sendfile09.c     | 234 ++++++------------
 1 file changed, 72 insertions(+), 162 deletions(-)

diff --git a/testcases/kernel/syscalls/sendfile/sendfile09.c b/testcases/kernel/syscalls/sendfile/sendfile09.c
index b9d9c8407..3d8a6b6e8 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile09.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile09.c
@@ -1,74 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *
- *   Copyright (c) International Business Machines  Corp., 2014
- *
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
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc.
+ * Copyright (c) International Business Machines  Corp., 2014
  */
-/*
- * NAME
- *        sendfile09.c
+
+/*\
+ * [Description]
  *
- * DESCRIPTION
- *        Testcase copied from sendfile02.c to test the basic functionality of
- *        the sendfile(2) system call on large file. There is a kernel bug which
- *        introduced by commit 8f9c0119d7ba and fixed by commit 5d73320a96fcc.
+ * Testcase copied from sendfile02.c to test the basic functionality of
+ * the sendfile(2) system call on large file. There is a kernel bug which
+ * introduced by commit 8f9c0119d7ba and fixed by commit 5d73320a96fcc.
  *
- * ALGORITHM
- *        1. call sendfile(2) with offset at 0
- *        2. call sendfile(2) with offset at 3GB
+ * [Algorithm]
  *
- * USAGE:  <for command-line>
- *  sendfile09 [-c n] [-i n] [-I x] [-P x] [-t]
- *     where,
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
+ * 1. Call sendfile(2) with offset at 0;
+ * 2. Call sendfile(2) with offset at 3GB.
  *
+ * [Restrictions]
  *
- * RESTRICTIONS
- *        Only supports 64bit systems and kernel 2.6.33 or above
+ * Only supports 64bit systems and kernel 2.6.33 or above.
  */
-#include <stdio.h>
-#include <errno.h>
+
 #include <fcntl.h>
 #include <sys/stat.h>
 #include <sys/sendfile.h>
 #include <sys/types.h>
 #include <unistd.h>
 #include <inttypes.h>
-#include "test.h"
-#include "safe_macros.h"
-#include "lapi/abisize.h"

-#ifndef OFF_T
-#define OFF_T off_t
-#endif /* Not def: OFF_T */
+#include "tst_test.h"

-TCID_DEFINE(sendfile09);
-
-static char *in_file = "in";
-static char *out_file = "out";
-static int fd;
-static int in_fd;
-static int out_fd;
+#ifdef TST_ABI32
+tst_brkm(TCONF, "This test is only for 64bit");
+#endif

-static void cleanup(void);
-static void setup(void);
+#ifndef OFF_T
+#define OFF_T off_t
+#endif

-#define ONE_GB (INT64_C(1) << 30)
+#define ONE_GB		(INT64_C(1) << 30)
+#define IN_FILE		"in_file"
+#define OUT_FILE	"out_file"

 static struct test_case_t {
 	char *desc;
@@ -76,124 +47,63 @@ static struct test_case_t {
 	int64_t count;
 	int64_t exp_retval;
 	int64_t exp_updated_offset;
-} testcases[] = {
-	{ "Test sendfile(2) with offset at 0",
-		0, ONE_GB, ONE_GB, ONE_GB},
-	{ "Test sendfile(2) with offset at 3GB",
-		3*ONE_GB, ONE_GB, ONE_GB, 4*ONE_GB}
+} tc[] = {
+	{ "offset at 0", 0, ONE_GB, ONE_GB, ONE_GB },
+	{ "offset@3GB", 3 * ONE_GB, ONE_GB, ONE_GB, 4 * ONE_GB }
 };

-static int TST_TOTAL = ARRAY_SIZE(testcases);
-
-void do_sendfile(struct test_case_t *t)
-{
-	off_t before_pos, after_pos;
-
-	out_fd = SAFE_OPEN(cleanup, out_file, O_WRONLY);
-	in_fd = SAFE_OPEN(cleanup, in_file, O_RDONLY);
-	before_pos = SAFE_LSEEK(cleanup, in_fd, 0, SEEK_CUR);
-
-	TEST(sendfile(out_fd, in_fd, &t->offset, t->count));
-	if (TEST_RETURN == -1)
-		tst_brkm(TBROK | TTERRNO, cleanup, "sendfile(2) failed");
-
-	after_pos = SAFE_LSEEK(cleanup, in_fd, 0, SEEK_CUR);
-
-	if (TEST_RETURN != t->exp_retval) {
-		tst_resm(TFAIL, "sendfile(2) failed to return "
-			"expected value, expected: %" PRId64 ", "
-			"got: %ld", t->exp_retval,
-			TEST_RETURN);
-	} else if (t->offset != t->exp_updated_offset) {
-		tst_resm(TFAIL, "sendfile(2) failed to update "
-			"OFFSET parameter to expected value, "
-			"expected: %" PRId64 ", got: %" PRId64,
-			t->exp_updated_offset,
-			(int64_t) t->offset);
-	} else if (before_pos != after_pos) {
-		tst_resm(TFAIL, "sendfile(2) updated the file position "
-			" of in_fd unexpectedly, expected file position: %"
-			PRId64 ", " " actual file position %" PRId64,
-			(int64_t) before_pos, (int64_t) after_pos);
-	} else {
-		tst_resm(TPASS, "%s", t->desc);
-	}
-
-	close(in_fd);
-	close(out_fd);
-}
-
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
+static void setup(void)
 {
-	int i;
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
-
-	/* make a temporary directory and cd to it */
-	tst_tmpdir();
-
-	if (!tst_fs_has_free(NULL, ".", 5, TST_GB))
-		tst_brkm(TCONF, cleanup, "sendfile(2) on large file"
-			" needs 5G free space.");
+	if (!tst_fs_has_free(".", 5, TST_GB))
+		tst_brk(TCONF, "Test on large file needs 5G free space");

-	/* create a 4G file */
-	fd = SAFE_CREAT(cleanup, in_file, 00700);
-	for (i = 1; i <= (4 * 1024); i++) {
-		SAFE_LSEEK(cleanup, fd, 1024 * 1024 - 1, SEEK_CUR);
-		SAFE_WRITE(cleanup, 1, fd, "C", 1);
+	int fd = SAFE_CREAT(IN_FILE, 00700);
+	for (int i = 1; i <= (4 * 1024); ++i) {
+		SAFE_LSEEK(fd, 1024 * 1024 - 1, SEEK_CUR);
+		SAFE_WRITE(1, fd, "C", 1);
 	}
-	close(fd);
+	SAFE_CLOSE(fd);

-	fd = SAFE_CREAT(cleanup, out_file, 00700);
-	close(fd);
+	fd = SAFE_CREAT(OUT_FILE, 00700);
+	SAFE_CLOSE(fd);
 }

-void cleanup(void)
+static void run(unsigned int i)
 {
-	if (fd > 0)
-		close(fd);
+	int in_fd = SAFE_OPEN(IN_FILE, O_RDONLY);
+	int out_fd = SAFE_OPEN(OUT_FILE, O_WRONLY);
+	OFF_T offset = tc[i].offset;

-	if (in_fd > 0)
-		close(in_fd);
-
-	if (out_fd > 0)
-		close(out_fd);
-
-	tst_rmdir();
+	off_t before_pos, after_pos;
+	before_pos = SAFE_LSEEK(in_fd, 0, SEEK_CUR);
+
+	TEST(sendfile(out_fd, in_fd, &offset, tc[i].count));
+	after_pos = SAFE_LSEEK(in_fd, 0, SEEK_CUR);
+
+	if (TST_RET != tc[i].exp_retval)
+		tst_res(TFAIL, "sendfile(2) failed to return expected value, "
+			       "expected: %" PRId64 ", got: %ld",
+			tc[i].exp_retval, TST_RET);
+	else if (offset != tc[i].exp_updated_offset)
+		tst_res(TFAIL, "sendfile(2) failed to update OFFSET parameter to "
+			       "expected value, expected: %" PRId64 ", got: %" PRId64,
+			tc[i].exp_updated_offset, (int64_t)(offset));
+	else if (before_pos != after_pos)
+		tst_res(TFAIL, "sendfile(2) updated the file position of in_fd "
+			       "unexpectedly, expected file position: %" PRId64
+			       ", actual file position %" PRId64,
+			(int64_t)(before_pos), (int64_t)(after_pos));
+	else
+		tst_res(TPASS, "sendfile(2) with %s", tc[i].desc);
+
+	SAFE_CLOSE(in_fd);
+	SAFE_CLOSE(out_fd);
 }

-int main(int ac, char **av)
-{
-	int i;
-	int lc;
-
-#ifdef TST_ABI32
-	tst_brkm(TCONF, NULL, "This test is only for 64bit");
-#endif
-
-	if (tst_kvercmp(2, 6, 33) < 0) {
-		tst_resm(TINFO, "sendfile(2) on large file "
-			"skipped for kernels < 2.6.33");
-		return 0;
-	}
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	/*
-	 * The following loop checks looping state if -c option given
-	 */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		for (i = 0; i < TST_TOTAL; ++i)
-			do_sendfile(&testcases[i]);
-	}
-
-	cleanup();
-	tst_exit();
-}
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.test = run,
+	.tcnt = ARRAY_SIZE(tc),
+	.min_kver = "2.6.33",
+};
--
2.17.1

