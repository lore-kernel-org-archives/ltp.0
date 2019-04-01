From: tarun <tarun@zilogic.com>
Date: Mon, 01 Apr 2019 16:52:46 -0000
Subject: [LTP] [PATCH v2] pwritev203.c: Testcase to test RWF_APPEND
Message-ID: <20190401165246.3552-1-tarun@zilogic.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


From: "Tarun.T.U" <tarun@zilogic.com>

    Suggested-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
    Signed-off-by: Tarun T U <tarun@zilogic.com>
---
 include/lapi/pwritev2.h                       |   7 ++
 runtest/syscalls                              |   2 +
 testcases/kernel/syscalls/pwritev2/.gitignore |   2 +
 .../kernel/syscalls/pwritev2/pwritev203.c     | 112 ++++++++++++++++++
 4 files changed, 123 insertions(+)
 create mode 100644 testcases/kernel/syscalls/pwritev2/pwritev203.c

diff --git a/include/lapi/pwritev2.h b/include/lapi/pwritev2.h
index 305e48e02..214279693 100644
--- a/include/lapi/pwritev2.h
+++ b/include/lapi/pwritev2.h
@@ -23,4 +23,11 @@ ssize_t pwritev2(int fd, const struct iovec *iov, int iovcnt, off_t offset,
 }
 #endif
 
+/*
+ * Flag for pwritev2
+ */
+#ifndef RWF_APPEND
+# define RWF_APPEND		0x00000010U
+#endif
+
 #endif /* PWRITEV2_H */
diff --git a/runtest/syscalls b/runtest/syscalls
index cf8189ebd..1a80c53ba 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -922,6 +922,8 @@ pwritev201 pwritev201
 pwritev201_64 pwritev201_64
 pwritev202 pwritev202
 pwritev202_64 pwritev202_64
+pwritev203 pwritev203
+pwritev203_64 pwritev203_64
 
 quotactl01 quotactl01
 quotactl02 quotactl02
diff --git a/testcases/kernel/syscalls/pwritev2/.gitignore b/testcases/kernel/syscalls/pwritev2/.gitignore
index 40030d9e5..9b440a879 100644
--- a/testcases/kernel/syscalls/pwritev2/.gitignore
+++ b/testcases/kernel/syscalls/pwritev2/.gitignore
@@ -2,3 +2,5 @@
 /pwritev201_64
 /pwritev202
 /pwritev202_64
+/pwritev203
+/pwritev203_64
diff --git a/testcases/kernel/syscalls/pwritev2/pwritev203.c b/testcases/kernel/syscalls/pwritev2/pwritev203.c
new file mode 100644
index 000000000..721b9777e
--- /dev/null
+++ b/testcases/kernel/syscalls/pwritev2/pwritev203.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Zilogic Systems Pvt. Ltd., 2019
+ * Email: code@zilogic.com
+ */
+
+/*
+ * Test pwritev2
+ *
+ * This code test the behaviour of  RWF_APPEND in pwritev2
+ *
+ * case 1:
+ * With offset of zero and RWF_APPEND in pwritev2
+ * Excepted result: Current file offset should not update.
+ *
+ * case 2:
+ * With offset of "5" and RWF_APPEND in pwritev2
+ * Excepted result: Current file offset should not update.
+ *
+ * case 3:
+ * With offset of -1 and RWF_APPEND in pwritev2
+ * Excepted result: Current file offset should get update to current value.
+ *
+ * Testcases:
+ * Test1: Getting offset value from written file.
+ * Test2: Getting written data from file to verify written data by using LSEEK.
+ *
+ * Minimum Kernel version required is 4.16.
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <sys/uio.h>
+
+#include <string.h>
+#include "tst_test.h"
+#include "lapi/pwritev2.h"
+
+#define TESTFILE0 "testfile0"
+#define TESTFILE1 "testfile1"
+#define TESTFILE2 "testfile2"
+#define MODE 0644
+#define OLD_OFFSET 14
+#define UPDATED_OFFSET 25
+
+static struct test_case {
+	char *filename;
+	off_t offset;
+	off_t exp_offset;
+
+} tcases[] = {
+	{.filename = TESTFILE0, .offset = 0, .exp_offset = OLD_OFFSET},
+	{.filename = TESTFILE1, .offset = 5, .exp_offset = OLD_OFFSET},
+	{.filename = TESTFILE2, .offset = -1, .exp_offset = UPDATED_OFFSET},
+};
+
+static void run_test(unsigned int i)
+{
+	struct iovec vector;
+	struct test_case *tc = &tcases[i];
+	char *std_data = "Linux Torvalds";
+	char *append_data = "Hello World";
+	char test_data[strlen(append_data) + 1];
+	off_t cur_offset;
+	int fd;
+
+	memset(test_data, 0, sizeof(test_data));
+
+	fd = SAFE_OPEN(tc->filename, O_RDWR | O_CREAT, MODE);
+	SAFE_WRITE(1, fd, std_data, strlen(std_data));
+
+	vector.iov_base = append_data;
+	vector.iov_len = strlen(append_data);
+
+	TEST(pwritev2(fd, &vector, 1, tc->offset, RWF_APPEND));
+
+	if (TST_ERR == EOPNOTSUPP) {
+		tst_brk(TBROK | TERRNO | TINFO,
+			"kernel is not supported for RWF_APPEND flag");
+	} else if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "pwritev2() returned with %ld",
+			TST_RET);
+		return;
+	}
+
+	cur_offset = SAFE_LSEEK(fd, 0, SEEK_CUR);
+	if (cur_offset != tc->exp_offset)
+		tst_brk(TFAIL,
+			"Returned offset %ld inspite of RWF_APPEND flag",
+			tc->exp_offset);
+	else
+		tst_res(TPASS, "Returned offset %ld as expected",
+			tc->exp_offset);
+
+
+	SAFE_LSEEK(fd, -(strlen(append_data)), SEEK_END);
+
+	SAFE_READ(0, fd, test_data, sizeof(test_data));
+	if (strcmp(append_data, test_data) != 0)
+		tst_brk(TFAIL, "Data not appended as expected");
+	else
+		tst_res(TPASS, "Data appended as expected");
+
+	SAFE_CLOSE(fd);
+	SAFE_UNLINK(tc->filename);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run_test,
+	.needs_tmpdir = 1,
+};
-- 
2.17.1

