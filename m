From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 29 Dec 2015 18:20:31 +0800
Subject: [LTP] [PATCH] pwritev/pwritev02.c: add new testcase
In-Reply-To: <1451384431-29742-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1451384431-29742-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1451384431-29742-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) pwritev(2) fails if iov_len is invalid and set errno to EINVAL.
2) pwritev(2) fails if the vector count is less than zero set errno to EINVAL.
3) pwritev(2) fails if offset is negative and set errno to EINVAL.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/ltplite                               |   1 +
 runtest/stress.part3                          |   1 +
 runtest/syscalls                              |   2 +
 testcases/kernel/syscalls/.gitignore          |   2 +
 testcases/kernel/syscalls/pwritev/pwritev02.c | 126 ++++++++++++++++++++++++++
 5 files changed, 132 insertions(+)
 create mode 100644 testcases/kernel/syscalls/pwritev/pwritev02.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 1aa93e6..5356cf3 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -609,6 +609,7 @@ pwrite02_64 pwrite02_64
 pwrite04_64 pwrite04_64
 
 pwritev01 pwritev01
+pwritev02 pwritev02
 
 read01 read01
 read02 read02
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 87f42ea..68bacff 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -518,6 +518,7 @@ pwrite02_64 pwrite02_64
 pwrite04_64 pwrite04_64
 
 pwritev01 pwritev01
+pwritev02 pwritev02
 
 read01 read01
 read02 read02
diff --git a/runtest/syscalls b/runtest/syscalls
index 7173f22..9158f39 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -815,6 +815,8 @@ pwrite04_64 pwrite04_64
 
 pwritev01 pwritev01
 pwritev01_64 pwritev01_64
+pwritev02 pwritev02
+pwritev02_64 pwritev02_64
 
 quotactl01 quotactl01
 quotactl02 quotactl02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index d5f21ef..423ad55 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -680,6 +680,8 @@
 /pwrite/pwrite04_64
 /pwritev/pwritev01
 /pwritev/pwritev01_64
+/pwritev/pwritev02
+/pwritev/pwritev02_64
 /quotactl/quotactl01
 /quotactl/quotactl02
 /read/read01
diff --git a/testcases/kernel/syscalls/pwritev/pwritev02.c b/testcases/kernel/syscalls/pwritev/pwritev02.c
new file mode 100644
index 0000000..0c8e436
--- /dev/null
+++ b/testcases/kernel/syscalls/pwritev/pwritev02.c
@@ -0,0 +1,126 @@
+/*
+* Copyright (c) 2015 Fujitsu Ltd.
+* Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+*
+* This program is free software; you can redistribute it and/or modify it
+* under the terms of version 2 of the GNU General Public License as
+* published by the Free Software Foundation.
+*
+* This program is distributed in the hope that it would be useful, but
+* WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+*
+* You should have received a copy of the GNU General Public License
+* alone with this program.
+*/
+
+/*
+* Test Name: pwritev02
+*
+* Description:
+* 1) pwritev(2) fails if iov_len is invalid.
+* 2) pwritev(2) fails if the vector count iovcnt is less than zero.
+* 3) pwritev(2) fails if offset is negative.
+*
+* Expected Result:
+* 1) pwritev(2) should return -1 and set errno to EINVAL.
+* 2) pwritev(2) should return -1 and set errno to EINVAL.
+* 3) pwritev(2) should return -1 and set errno to EINVAL.
+*/
+
+#include <errno.h>
+
+#include "test.h"
+#include "pwritev.h"
+#include "safe_macros.h"
+
+#define CHUNK           64
+
+static int fd;
+static char buf[CHUNK];
+
+static struct iovec wr_iovec1[] = {
+	{buf, -1},
+};
+
+static struct iovec wr_iovec2[] = {
+	{buf, CHUNK},
+};
+
+static struct test_case_t {
+	struct iovec *name;
+	int count;
+	off_t offset;
+} tc[] = {
+	/* test1 */
+	{wr_iovec1, 1, 0},
+	/* test2 */
+	{wr_iovec2, -1, 0},
+	/* test3 */
+	{wr_iovec2, 1, -1}
+};
+
+void verify_pwritev(struct test_case_t *tc);
+void setup(void);
+void cleanup(void);
+
+char *TCID = "pwritev02";
+int TST_TOTAL = ARRAY_SIZE(tc);
+
+int main(int ac, char **av)
+{
+	int lc;
+	int i;
+
+	tst_parse_opts(ac, av, NULL, NULL);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+		for (i = 0; i < TST_TOTAL; i++)
+			verify_pwritev(&tc[i]);
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+void verify_pwritev(struct test_case_t *tc)
+{
+	TEST(pwritev(fd, tc->name, tc->count, tc->offset));
+	if (TEST_RETURN == 0) {
+		tst_resm(TFAIL, "pwritev(2) succeed unexpectedly");
+	} else {
+		if (TEST_ERRNO == EINVAL) {
+			tst_resm(TPASS | TTERRNO, "pwritev(2) fails as expected");
+		} else {
+			tst_resm(TFAIL | TTERRNO, "pwritev(2) fails unexpectedly,"
+				 " expected errno is EINVAL");
+		}
+	}
+}
+
+void setup(void)
+{
+	if ((tst_kvercmp(2, 6, 30)) < 0) {
+		tst_brkm(TCONF, NULL, "This test can only run on kernels"
+			 " that are 2.6.30 or higher.");
+	}
+
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+
+	tst_tmpdir();
+
+	fd = SAFE_OPEN(cleanup, "file", O_RDWR | O_CREAT, 0644);
+}
+
+void cleanup(void)
+{
+	if (fd > 0 && close(fd))
+		tst_resm(TWARN | TERRNO, "failed to close file");
+
+	tst_rmdir();
+}
-- 
1.8.3.1



