From: Xie Ziyao <xieziyao@huawei.com>
Date: Tue, 8 Jun 2021 21:57:17 +0800
Subject: [LTP] [PATCH 3/4 v2] syscalls/io_submit: Add io_submit02 test for
 native AIO
In-Reply-To: <20210608135718.36579-1-xieziyao@huawei.com>
References: <20210608135718.36579-1-xieziyao@huawei.com>
Message-ID: <20210608135718.36579-4-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test io_submit invoked via syscall(2):
1. io_submit() returns the number of iocbs submitted.
2. io_submit() returns 0 if nr is zero.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
v1->v2:
1. Split io_submit02 into two, one for negative and one for positive cases.
2. Print values not variable names in TST_EXP_PASS().
3. Add .needs_kconfig in this test.

 runtest/syscalls                              |  1 +
 .../kernel/syscalls/io_submit/.gitignore      |  1 +
 .../kernel/syscalls/io_submit/io_submit02.c   | 89 +++++++++++++++++++
 3 files changed, 91 insertions(+)
 create mode 100644 testcases/kernel/syscalls/io_submit/io_submit02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index d1ec32754..9c4c64fa3 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -616,6 +616,7 @@ io_pgetevents02 io_pgetevents02
 io_setup01 io_setup01
 io_setup02 io_setup02
 io_submit01 io_submit01
+io_submit02 io_submit02

 keyctl01 keyctl01
 keyctl02 keyctl02
diff --git a/testcases/kernel/syscalls/io_submit/.gitignore b/testcases/kernel/syscalls/io_submit/.gitignore
index cac043b6c..5f2a2cff2 100644
--- a/testcases/kernel/syscalls/io_submit/.gitignore
+++ b/testcases/kernel/syscalls/io_submit/.gitignore
@@ -1 +1,2 @@
 /io_submit01
+/io_submit02
diff --git a/testcases/kernel/syscalls/io_submit/io_submit02.c b/testcases/kernel/syscalls/io_submit/io_submit02.c
new file mode 100644
index 000000000..b0ed35eec
--- /dev/null
+++ b/testcases/kernel/syscalls/io_submit/io_submit02.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Crackerjack Project., 2007
+ * Ported from Crackerjack to LTP by Masatake YAMATO <yamato@redhat.com>
+ * Copyright (c) 2011-2017 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) 2021 Xie Ziyao <xieziyao@huawei.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Test io_submit invoked via syscall(2):
+ *
+ * 1. io_submit() returns the number of iocbs submitted.
+ * 2. io_submit() returns 0 if nr is zero.
+ */
+
+#include <linux/aio_abi.h>
+
+#include "config.h"
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+
+#define TEST_FILE "test_file"
+#define MODE 0777
+
+static int fd;
+static char buf[100];
+
+static aio_context_t ctx;
+static struct iocb iocb;
+static struct iocb *iocbs[] = {&iocb};
+
+static struct tcase {
+	aio_context_t *ctx;
+	long nr;
+	struct iocb **iocbs;
+	const char *desc;
+} tc[] = {
+	{&ctx, 1, iocbs, "returns the number of iocbs submitted"},
+	{&ctx, 0, NULL, "returns 0 if nr is zero"},
+};
+
+static inline void io_prep_option(struct iocb *cb, int fd, void *buf,
+			size_t count, long long offset, unsigned opcode)
+{
+	memset(cb, 0, sizeof(*cb));
+	cb->aio_fildes = fd;
+	cb->aio_lio_opcode = opcode;
+	cb->aio_buf = (uint64_t)buf;
+	cb->aio_offset = offset;
+	cb->aio_nbytes = count;
+}
+
+static void setup(void)
+{
+	TST_EXP_PASS_SILENT(tst_syscall(__NR_io_setup, 1, &ctx));
+	fd = SAFE_OPEN(TEST_FILE, O_RDONLY | O_CREAT, MODE);
+	io_prep_option(&iocb, fd, buf, 0, 0, IOCB_CMD_PREAD);
+}
+
+static void cleanup(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+	TST_EXP_PASS_SILENT(tst_syscall(__NR_io_destroy, ctx));
+}
+
+static void run(unsigned int i)
+{
+	TEST(tst_syscall(__NR_io_submit, *tc[i].ctx, tc[i].nr, tc[i].iocbs));
+
+	if (TST_RET == tc[i].nr)
+		tst_res(TPASS, "io_submit() %s", tc[i].desc);
+	else
+		tst_res(TFAIL, "io_submit() returns %ld, expected %ld", TST_RET, tc[i].nr);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tc),
+	.needs_tmpdir = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_AIO=y",
+		NULL
+	},
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = run,
+};
--
2.17.1

