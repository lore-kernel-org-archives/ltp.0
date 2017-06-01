From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  1 Jun 2017 12:47:18 +0200
Subject: [LTP] [PATCH] [COMMITTED] io_submit01: Rewrite & fix.
Message-ID: <20170601104718.13459-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Rewrite the test to the new API

* Drop uninitialized iocb test since that
  one invokes undefined behavior and may
  fail with pretty much any error

* Add a few more cases
  - write request for readonly file -- EBADFD
  - read request for writeonly file -- EBADFD

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/io_submit/io_submit01.c | 269 +++++++++-------------
 1 file changed, 106 insertions(+), 163 deletions(-)

diff --git a/testcases/kernel/syscalls/io_submit/io_submit01.c b/testcases/kernel/syscalls/io_submit/io_submit01.c
index fd01e6ede..9baf520b8 100644
--- a/testcases/kernel/syscalls/io_submit/io_submit01.c
+++ b/testcases/kernel/syscalls/io_submit/io_submit01.c
@@ -1,32 +1,27 @@
 /*
+ * Copyright (c) Crackerjack Project., 2007
+ * Copyright (c) 2011-2017 Cyril Hrubis <chrubis@suse.cz>
  *
- *   Copyright (c) Crackerjack Project., 2007
- *   Copyright (c) 2011 Cyril Hrubis <chrubis@suse.cz>
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /* Porting from Crackerjack to LTP is done
    by Masatake YAMATO <yamato@redhat.com> */
 
 #include "config.h"
-#include "test.h"
-
-char *TCID = "io_submit01";
-
-int TST_TOTAL = 3;
+#include "tst_test.h"
 
 #ifdef HAVE_LIBAIO_H
 #include <libaio.h>
@@ -34,167 +29,115 @@ int TST_TOTAL = 3;
 #include <string.h>
 #include <fcntl.h>
 
-#define TESTFILE	"testfile"
-
-static void cleanup(void)
-{
-	tst_rmdir();
-}
+static io_context_t ctx;
+static io_context_t invalid_ctx;
+
+static struct iocb iocb;
+static struct iocb *iocbs[] = {&iocb};
+
+static struct iocb inv_fd_iocb;
+static struct iocb *inv_fd_iocbs[] = {&inv_fd_iocb};
+
+static int rdonly_fd;
+static struct iocb rdonly_fd_iocb;
+static struct iocb *rdonly_fd_iocbs[] = {&rdonly_fd_iocb};
+
+static int wronly_fd;
+static struct iocb wronly_fd_iocb;
+static struct iocb *wronly_fd_iocbs[] = {&wronly_fd_iocb};
+
+static struct iocb zero_buf_iocb;
+static struct iocb *zero_buf_iocbs[] = {&zero_buf_iocb};
+
+static struct iocb *zero_iocbs[1];
+
+static char buf[100];
+
+static struct tcase {
+	io_context_t *ctx;
+	long nr;
+	struct iocb **iocbs;
+	int exp_errno;
+	const char *desc;
+} tcases[] = {
+	/* Invalid ctx */
+	{&invalid_ctx, 1, iocbs, -EINVAL, "invalid ctx"},
+	/* Invalid nr */
+	{&ctx, -1, iocbs, -EINVAL, "invalid nr"},
+	/* Invalid pointer */
+	{&ctx, 1, (void*)-1, -EFAULT, "invalid iocbpp pointer"},
+	{&ctx, 1, zero_iocbs, -EFAULT, "NULL iocb pointers"},
+	/* Invalid fd */
+	{&ctx, 1, inv_fd_iocbs, -EBADF, "invalid fd"},
+	{&ctx, 1, rdonly_fd_iocbs, -EBADF, "readonly fd for write"},
+	{&ctx, 1, wronly_fd_iocbs, -EBADF, "writeonly fd for read"},
+	/* No-op but should work fine */
+	{&ctx, 1, zero_buf_iocbs, 1, "zero buf size"},
+	{&ctx, 0, NULL, 0, "zero nr"},
+};
 
 static void setup(void)
 {
-	int fd;
+	int rval;
+
+	rval = io_setup(1, &ctx);
+	if (rval)
+		tst_brk(TBROK | TERRNO, "io_setup() returned %d", rval);
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	io_prep_pread(&inv_fd_iocb, -1, buf, sizeof(buf), 0);
 
-	TEST_PAUSE;
+	rdonly_fd = SAFE_OPEN("rdonly_file", O_RDONLY | O_CREAT, 0777);
+	io_prep_pwrite(&rdonly_fd_iocb, rdonly_fd, buf, sizeof(buf), 0);
 
-	tst_tmpdir();
+	io_prep_pread(&zero_buf_iocb, rdonly_fd, buf, 0, 0);
 
-	fd = open(TESTFILE, O_CREAT | O_RDWR, 0755);
-	if (fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "open");
-	if (close(fd) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "close");
+	wronly_fd = SAFE_OPEN("wronly_file", O_WRONLY | O_CREAT, 0777);
+	io_prep_pread(&wronly_fd_iocb, wronly_fd, buf, sizeof(buf), 0);
 }
 
-static void check_result(long exp, long act)
+static void cleanup(void)
 {
-	if (exp >= 0) {
-		if (act == exp)
-			tst_resm(TPASS, "expected success - "
-				 "returned value = %ld", act);
-		else
-			tst_resm(TFAIL, "unexpected failure - "
-				 "returned value = %ld : %s",
-				 act, strerror(-1 * act));
-		return;
-	}
+	if (rdonly_fd > 0)
+		SAFE_CLOSE(rdonly_fd);
 
-	/* if return value is expected to be < 0 */
-	if (act == exp)
-		tst_resm(TPASS, "expected failure - "
-			 "returned value = %ld : %s", act, strerror(-1 * act));
-	else if (act == 0)
-		tst_resm(TFAIL, "call succeeded unexpectedly");
-	else
-		tst_resm(TFAIL, "unexpected failure - "
-			 "returned value = %ld : %s, "
-			 "expected value = %ld : %s",
-			 act, strerror(-1 * act), exp, strerror(-1 * exp));
+	if (wronly_fd > 0)
+		SAFE_CLOSE(wronly_fd);
 }
 
-int main(int argc, char *argv[])
+static const char *errno_name(int err)
 {
-	int lc;
-
-	int rval, fd;
-	char buf[256];
-	struct iocb iocb;
-	struct iocb *iocbs[1];
-	io_context_t ctx;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		/* 1 - EINVAL */
-		/* 1.1 - EINVAL: invalid ctx */
-		memset(&ctx, 0, sizeof(ctx));
-		TEST(io_submit(ctx, 0, NULL));
-		check_result(-EINVAL, TEST_RETURN);
-
-		/* 1.2 - EINVAL: invalid nr */
-		rval = io_setup(1, &ctx);
-		if (rval != 0)
-			tst_brkm(TBROK, cleanup, "io_setup failed: %d", rval);
-		TEST(io_submit(ctx, -1, NULL));
-		check_result(-EINVAL, TEST_RETURN);
-
-		/* 1.3 - EINVAL: uninitialized iocb */
-		iocbs[0] = &iocb;
-
-		/* There are multiple checks we can hit with uninitialized
-		 * iocb, but with "random" data it's not 100%. Make sure we
-		 * fail eventually in opcode check. */
-		iocb.aio_lio_opcode = -1;
-
-		TEST(io_submit(ctx, 1, iocbs));
-		switch (TEST_RETURN) {
-		case -EINVAL:
-		case -EBADF:
-		case -EFAULT:
-			tst_resm(TPASS, "expected failure - "
-				 "returned value = %ld : %s",
-				 TEST_RETURN, strerror(-1 * TEST_RETURN));
-			break;
-		default:
-			tst_resm(TFAIL, "unexpected failure - "
-				 "returned value = %ld : %s, "
-				 "expected one of -EINVAL, -EBADF, -EFAULT",
-				 TEST_RETURN, strerror(-1 * TEST_RETURN));
-		}
-
-		/* 2 - EFAULT: iocb points to invalid data */
-		TEST(io_submit(ctx, 1, (struct iocb **)-1));
-		check_result(-EFAULT, TEST_RETURN);
-
-		/*
-		 * 3 - Special case EFAULT or EINVAL (indetermination)
-		 *
-		 * The errno depends on the per architecture implementation
-		 * of io_submit. On the architecture using compat_sys_io_submit
-		 * as its implementation, errno is set to -EINVAL.
-		 */
-		TEST(io_submit(ctx, -1, (struct iocb **)-1));
-		if (TEST_RETURN == 0)
-			tst_resm(TFAIL, "call succeeded unexpectedly");
-		else if (TEST_RETURN == -EFAULT || TEST_RETURN == -EINVAL)
-			tst_resm(TPASS, "expected failure - "
-				 "returned value = %ld : %s",
-				 TEST_RETURN, strerror(-1 * TEST_RETURN));
-		else
-			tst_resm(TFAIL, "unexpected failure - "
-				 "returned value = %ld : %s, "
-				 "expected = %d : %s or %d : %s",
-				 TEST_RETURN, strerror(-1 * TEST_RETURN),
-				 -EFAULT, strerror(EFAULT),
-				 -EINVAL, strerror(EINVAL));
-
-		/*
-		 * 4 - EBADF: fd in iocb is invalid
-		 */
-		io_prep_pread(&iocb, -1, buf, sizeof(buf), 0);
-		iocbs[0] = &iocb;
-		TEST(io_submit(ctx, 1, iocbs));
-		check_result(-EBADF, TEST_RETURN);
-
-		/* 5 - Positive test: nr == 0 */
-		TEST(io_submit(ctx, 0, NULL));
-		check_result(0, TEST_RETURN);
-
-		/* 6 - Positive test: valid fd */
-		fd = open(TESTFILE, O_RDONLY);
-		if (fd == -1)
-			tst_resm(TBROK | TERRNO, "open");
-		io_prep_pread(&iocb, fd, buf, sizeof(buf), 0);
-		iocbs[0] = &iocb;
-		TEST(io_submit(ctx, 1, iocbs));
-		check_result(1, TEST_RETURN);
-		if (close(fd) == -1)
-			tst_resm(TBROK | TERRNO, "close");
+	if (err <= 0)
+		return tst_strerrno(-err);
 
+	return "SUCCESS";
+}
+
+static void verify_io_submit(unsigned int n)
+{
+	struct tcase *t = &tcases[n];
+	int ret;
+
+	ret = io_submit(*t->ctx, t->nr, t->iocbs);
+
+	if (ret == t->exp_errno) {
+		tst_res(TPASS, "io_submit() with %s failed with %s",
+			t->desc, errno_name(t->exp_errno));
+		return;
 	}
-	cleanup();
 
-	tst_exit();
+	tst_res(TFAIL, "io_submit() returned %i(%s), expected %s(%i)",
+		ret, ret < 0 ? tst_strerrno(-ret) : "SUCCESS",
+		errno_name(t->exp_errno), t->exp_errno);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = verify_io_submit,
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_tmpdir = 1,
+};
+
 #else
-int main(int argc, char *argv[])
-{
-	tst_brkm(TCONF, NULL, "System doesn't support execution of the test");
-}
+	TST_TEST_TCONF("libaio.h was mission upon compilation");
 #endif
-- 
2.13.0

