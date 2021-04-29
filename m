From: Xie Ziyao <xieziyao@huawei.com>
Date: Thu, 29 Apr 2021 19:50:21 +0800
Subject: [LTP] [PATCH 3/3] syscalls/io_submit: Convert libaio wrapper
 function to kernel syscall
In-Reply-To: <20210429115021.24128-1-xieziyao@huawei.com>
References: <20210429115021.24128-1-xieziyao@huawei.com>
Message-ID: <20210429115021.24128-4-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Instead of using the libaio wrapper function, the system call is changed to be invoked via syscall(2).

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 .../kernel/syscalls/io_submit/io_submit01.c   | 110 ++++++++----------
 1 file changed, 48 insertions(+), 62 deletions(-)

diff --git a/testcases/kernel/syscalls/io_submit/io_submit01.c b/testcases/kernel/syscalls/io_submit/io_submit01.c
index bbbbc9101..702a7721b 100644
--- a/testcases/kernel/syscalls/io_submit/io_submit01.c
+++ b/testcases/kernel/syscalls/io_submit/io_submit01.c
@@ -1,24 +1,29 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Crackerjack Project., 2007
+ * Ported from Crackerjack to LTP by Masatake YAMATO <yamato@redhat.com>
  * Copyright (c) 2011-2017 Cyril Hrubis <chrubis@suse.cz>
  */

-/* Porting from Crackerjack to LTP is done
-   by Masatake YAMATO <yamato@redhat.com> */
+/*\
+ * [Description]
+ *
+ * - io_submit(2) fails and returns EINVAL if ctx is invalid;
+ * - io_submit(2) fails and returns EINVAL if nr is invalid;
+ * - io_submit(2) fails and returns EFAULT if iocbpp pointer is invalid;
+ * - io_submit(2) fails and returns EBADF if fd is invalid;
+ * - io_submit(2) should work fine if no-op;
+ */

-#include <errno.h>
-#include <string.h>
-#include <fcntl.h>
+#include <linux/aio_abi.h>

 #include "config.h"
 #include "tst_test.h"
+#include "lapi/syscalls.h"

-#ifdef HAVE_LIBAIO
-#include <libaio.h>
-
-static io_context_t ctx;
-static io_context_t invalid_ctx;
+static aio_context_t ctx;
+static aio_context_t invalid_ctx;
+static char buf[100];

 static struct iocb iocb;
 static struct iocb *iocbs[] = {&iocb};
@@ -39,93 +44,74 @@ static struct iocb *zero_buf_iocbs[] = {&zero_buf_iocb};

 static struct iocb *zero_iocbs[1];

-static char buf[100];
-
 static struct tcase {
-	io_context_t *ctx;
+	aio_context_t *ctx;
 	long nr;
 	struct iocb **iocbs;
 	int exp_errno;
 	const char *desc;
-} tcases[] = {
+} tc[] = {
 	/* Invalid ctx */
-	{&invalid_ctx, 1, iocbs, -EINVAL, "invalid ctx"},
+	{&invalid_ctx, 1, iocbs, EINVAL, "invalid ctx"},
 	/* Invalid nr */
-	{&ctx, -1, iocbs, -EINVAL, "invalid nr"},
+	{&ctx, -1, iocbs, EINVAL, "invalid nr"},
 	/* Invalid pointer */
-	{&ctx, 1, (void*)-1, -EFAULT, "invalid iocbpp pointer"},
-	{&ctx, 1, zero_iocbs, -EFAULT, "NULL iocb pointers"},
+	{&ctx, 1, (void*)-1, EFAULT, "invalid iocbpp pointer"},
+	{&ctx, 1, zero_iocbs, EFAULT, "NULL iocb pointers"},
 	/* Invalid fd */
-	{&ctx, 1, inv_fd_iocbs, -EBADF, "invalid fd"},
-	{&ctx, 1, rdonly_fd_iocbs, -EBADF, "readonly fd for write"},
-	{&ctx, 1, wronly_fd_iocbs, -EBADF, "writeonly fd for read"},
+	{&ctx, 1, inv_fd_iocbs, EBADF, "invalid fd"},
+	{&ctx, 1, rdonly_fd_iocbs, EBADF, "readonly fd for write"},
+	{&ctx, 1, wronly_fd_iocbs, EBADF, "writeonly fd for read"},
 	/* No-op but should work fine */
-	{&ctx, 1, zero_buf_iocbs, 1, "zero buf size"},
+	{&ctx, 1, zero_buf_iocbs, 0, "zero buf size"},
 	{&ctx, 0, NULL, 0, "zero nr"},
 };

-static void setup(void)
+static inline void io_prep_option(struct iocb *cb, int fd, void *buf,
+			size_t count, long long offset, unsigned opcode)
 {
-	TEST(io_setup(1, &ctx));
-	if (TST_RET == -ENOSYS)
-		tst_brk(TCONF | TRERRNO, "io_setup(): AIO not supported by kernel");
-	else if (TST_RET)
-		tst_brk(TBROK | TRERRNO, "io_setup() failed");
+	memset(cb, 0, sizeof(*cb));
+	cb->aio_fildes = fd;
+	cb->aio_lio_opcode = opcode;
+	cb->aio_buf = (uint64_t)buf;
+	cb->aio_offset = offset;
+	cb->aio_nbytes = count;
+}

-	io_prep_pread(&inv_fd_iocb, -1, buf, sizeof(buf), 0);
+static void setup(void)
+{
+	TST_EXP_PASS(tst_syscall(__NR_io_setup, 1, &ctx));
+	io_prep_option(&inv_fd_iocb, -1, buf, sizeof(buf), 0, IOCB_CMD_PREAD);

 	rdonly_fd = SAFE_OPEN("rdonly_file", O_RDONLY | O_CREAT, 0777);
-	io_prep_pwrite(&rdonly_fd_iocb, rdonly_fd, buf, sizeof(buf), 0);
+	io_prep_option(&rdonly_fd_iocb, rdonly_fd, buf, sizeof(buf), 0, IOCB_CMD_PWRITE);

-	io_prep_pread(&zero_buf_iocb, rdonly_fd, buf, 0, 0);
+	io_prep_option(&zero_buf_iocb, rdonly_fd, buf, 0, 0, IOCB_CMD_PREAD);

 	wronly_fd = SAFE_OPEN("wronly_file", O_WRONLY | O_CREAT, 0777);
-	io_prep_pread(&wronly_fd_iocb, wronly_fd, buf, sizeof(buf), 0);
+	io_prep_option(&wronly_fd_iocb, wronly_fd, buf, sizeof(buf), 0, IOCB_CMD_PREAD);
 }

 static void cleanup(void)
 {
 	if (rdonly_fd > 0)
 		SAFE_CLOSE(rdonly_fd);
-
 	if (wronly_fd > 0)
 		SAFE_CLOSE(wronly_fd);
 }

-static const char *errno_name(int err)
+static void run(unsigned int i)
 {
-	if (err <= 0)
-		return tst_strerrno(-err);
-
-	return "SUCCESS";
-}
-
-static void verify_io_submit(unsigned int n)
-{
-	struct tcase *t = &tcases[n];
-	int ret;
-
-	ret = io_submit(*t->ctx, t->nr, t->iocbs);
-
-	if (ret == t->exp_errno) {
-		tst_res(TPASS, "io_submit() with %s failed with %s",
-			t->desc, errno_name(t->exp_errno));
-		return;
-	}
-
-	tst_res(TFAIL, "io_submit() returned %i(%s), expected %s(%i)",
-		ret, ret < 0 ? tst_strerrno(-ret) : "SUCCESS",
-		errno_name(t->exp_errno), t->exp_errno);
+	TEST(tst_syscall(__NR_io_submit, *tc[i].ctx, tc[i].nr, tc[i].iocbs));
+	tst_res(TST_ERR == tc[i].exp_errno ? TPASS : TFAIL,
+		"io_submit(2) with %s returns %s, expected %s",
+		tc[i].desc, tst_strerrno(TST_ERR), tst_strerrno(tc[i].exp_errno));
 }

 static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
-	.test = verify_io_submit,
-	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+	.tcnt = ARRAY_SIZE(tc),
 	.needs_tmpdir = 1,
 };
-
-#else
-	TST_TEST_TCONF("test requires libaio and it's development packages");
-#endif
--
2.17.1

