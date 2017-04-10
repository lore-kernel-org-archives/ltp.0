From: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
Date: Mon, 10 Apr 2017 19:15:55 +0800
Subject: [LTP] [PATCH] syscalls/read02.c: Cleanup && convert to new API.
Message-ID: <1491822955-18333-1-git-send-email-huangjh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/read/read02.c | 122 +++++++++++++-------------------
 1 file changed, 49 insertions(+), 73 deletions(-)

diff --git a/testcases/kernel/syscalls/read/read02.c b/testcases/kernel/syscalls/read/read02.c
index 587b2ae..0e4776e 100644
--- a/testcases/kernel/syscalls/read/read02.c
+++ b/testcases/kernel/syscalls/read/read02.c
@@ -1,6 +1,8 @@
 /*
  * Copyright (c) International Business Machines  Corp., 2001
  *	07/2001 Ported by Wayne Boyer
+ * Copyright (c) 2017 Fujitsu Ltd.
+ *	04/2017 Modified by Jinhui Huang
  *
  * This program is free software;  you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -42,14 +44,9 @@
 #define _GNU_SOURCE
 
 #include <stdio.h>
+#include <stdlib.h>
 #include <errno.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <sys/mman.h>
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "read02";
+#include "tst_test.h"
 
 static int badfd = -1;
 static int fd2, fd3, fd4 = -1;
@@ -58,15 +55,14 @@ static void *bufaddr = buf;
 static void *outside_buf = (void *)-1;
 static void *addr4;
 static void *addr5;
-
 static long fs_type;
 
-static struct test_case_t {
+static struct tcase {
 	int *fd;
 	void **buf;
 	size_t count;
 	int exp_error;
-} TC[] = {
+} tcases[] = {
 	{&badfd, &bufaddr, 1, EBADF},
 	{&fd2, &bufaddr, 1, EISDIR},
 #ifndef UCLINUX
@@ -76,83 +72,56 @@ static struct test_case_t {
 	{&fd4, &addr5, 4096, EINVAL},
 };
 
-int TST_TOTAL = ARRAY_SIZE(TC);
-static void setup(void);
-static void cleanup(void);
-static void read_verify(const struct test_case_t *);
-
-int main(int ac, char **av)
+static void verify_read(unsigned int n)
 {
-	int i;
-	int lc;
+	struct tcase *tc = &tcases[n];
 
-	tst_parse_opts(ac, av, NULL, NULL);
+	if (tc->fd == &fd4 && *tc->fd == -1) {
+		tst_res(TCONF, "O_DIRECT not supported on %s filesystem",
+			tst_fs_type_name(fs_type));
+		return;
+	}
+
+	TEST(read(*tc->fd, *tc->buf, tc->count));
+
+	if (*tc->fd == fd4 && TEST_RETURN >= 0) {
+		tst_res(TPASS,
+			"O_DIRECT unaligned reads fallbacks to buffered I/O");
+		return;
+	}
 
-	setup();
+	if (TEST_RETURN != -1) {
+		tst_res(TFAIL, "read() succeeded unexpectedly");
+		return;
+	}
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		for (i = 0; i < TST_TOTAL; i++)
-			read_verify(&TC[i]);
+	if (TEST_ERRNO == tc->exp_error) {
+		tst_res(TPASS | TTERRNO, "read() failed as expected");
+	} else {
+		tst_res(TFAIL | TTERRNO, "read() failed unexpectedly, "
+			"expected %s", tst_strerrno(tc->exp_error));
 	}
-	cleanup();
-	tst_exit();
 }
 
 static void setup(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	fd2 = SAFE_OPEN(".", O_DIRECTORY);
 
-	tst_tmpdir();
+	SAFE_FILE_PRINTF("test_file", "A");
 
-	fd2 = SAFE_OPEN(cleanup, ".", O_DIRECTORY);
-
-	SAFE_FILE_PRINTF(cleanup, "test_file", "A");
-
-	fd3 = SAFE_OPEN(cleanup, "test_file", O_RDWR);
+	fd3 = SAFE_OPEN("test_file", O_RDWR);
 
 #if !defined(UCLINUX)
-	outside_buf = SAFE_MMAP(cleanup, 0, 1, PROT_NONE,
+	outside_buf = SAFE_MMAP(0, 1, PROT_NONE,
 				MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
 #endif
 
-	addr4 = SAFE_MEMALIGN(cleanup, getpagesize(), (4096 * 10));
+	addr4 = SAFE_MEMALIGN(getpagesize(), (4096 * 10));
 	addr5 = addr4 + 1;
 
-	fs_type = tst_fs_type(cleanup, ".");
+	fs_type = tst_fs_type(".");
 	if (fs_type != TST_TMPFS_MAGIC)
-		fd4 = SAFE_OPEN(cleanup, "test_file", O_RDWR | O_DIRECT);
-}
-
-static void read_verify(const struct test_case_t *test)
-{
-	if (test->fd == &fd4 && *test->fd == -1) {
-		tst_resm(TCONF, "O_DIRECT not supported on %s filesystem",
-		         tst_fs_type_name(fs_type));
-		return;
-	}
-
-	TEST(read(*test->fd, *test->buf, test->count));
-
-	if (*test->fd == fd4 && TEST_RETURN >= 0) {
-		tst_resm(TPASS,
-			 "O_DIRECT unaligned reads fallbacks to buffered I/O");
-		return;
-	}
-
-	if (TEST_RETURN != -1) {
-		tst_resm(TFAIL, "call succeeded unexpectedly");
-		return;
-	}
-
-	if (TEST_ERRNO == test->exp_error) {
-		tst_resm(TPASS | TTERRNO, "expected failure");
-	} else {
-		tst_resm(TFAIL | TTERRNO, "unexpected error expected %d",
-			 test->exp_error);
-	}
+		fd4 = SAFE_OPEN("test_file", O_RDWR | O_DIRECT);
 }
 
 static void cleanup(void)
@@ -160,13 +129,20 @@ static void cleanup(void)
 	free(addr4);
 
 	if (fd4 > 0)
-		close(fd4);
+		SAFE_CLOSE(fd4);
 
 	if (fd3 > 0)
-		close(fd3);
+		SAFE_CLOSE(fd3);
 
 	if (fd2 > 0)
-		close(fd2);
-
-	tst_rmdir();
+		SAFE_CLOSE(fd2);
 }
+
+static struct tst_test test = {
+	.tid = "read02",
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_read,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+};
-- 
1.8.3.1



