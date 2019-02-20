From: Matthias Maennich <maennich@google.com>
Date: Wed, 20 Feb 2019 15:20:25 +0000
Subject: [LTP] [PATCH v3 3/3] aio_tio: convert to new lib
In-Reply-To: <20190220152025.261625-1-maennich@google.com>
References: <20190111085326.171826-1-maennich@google.com>
 <20190220152025.261625-1-maennich@google.com>
Message-ID: <20190220152025.261625-4-maennich@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Convert to the new test lib and perform various cleanups.
Also refactor the test definition for readability.

Signed-off-by: Matthias Maennich <maennich@google.com>
---
 testcases/kernel/io/aio/aio02/Makefile  |  24 +--
 testcases/kernel/io/aio/aio02/aio_tio.c | 201 +++++++++++++-----------
 testcases/kernel/io/aio/aio02/common.h  |  28 ----
 testcases/kernel/io/aio/aio02/main.c    |  37 -----
 4 files changed, 106 insertions(+), 184 deletions(-)
 delete mode 100644 testcases/kernel/io/aio/aio02/common.h
 delete mode 100644 testcases/kernel/io/aio/aio02/main.c

diff --git a/testcases/kernel/io/aio/aio02/Makefile b/testcases/kernel/io/aio/aio02/Makefile
index a99807c26..629aa9a58 100644
--- a/testcases/kernel/io/aio/aio02/Makefile
+++ b/testcases/kernel/io/aio/aio02/Makefile
@@ -1,36 +1,14 @@
-#
-#    kernel/io/aio/aio2 testcase Makefile.
+// SPDX-License-Identifier: GPL-2.0-or-later
 #
 #    Copyright (C) 2009, Cisco Systems Inc.
 #
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
 
 top_srcdir		?= ../../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-# Needed for common.h...
 CPPFLAGS		+= -D_GNU_SOURCE
 
 LDLIBS			+= $(AIO_LIBS)
 
-FILTER_OUT_MAKE_TARGETS	:= main
-
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-
-$(MAKE_TARGETS): %: %.o main.o
diff --git a/testcases/kernel/io/aio/aio02/aio_tio.c b/testcases/kernel/io/aio/aio02/aio_tio.c
index db6fa2688..a55ff2663 100644
--- a/testcases/kernel/io/aio/aio02/aio_tio.c
+++ b/testcases/kernel/io/aio/aio02/aio_tio.c
@@ -1,64 +1,59 @@
-/*************************************************************************************
-*
-*  Copyright (c) International Business Machines  Corp., 2003
-*
-*  This program is free software;  you can redistribute it and/or modify
-*  it under the terms of the GNU General Public License as published by
-*  the Free Software Foundation; either version 2 of the License, or
-*  (at your option) any later version.
-*
-*  This program is distributed in the hope that it will be useful,
-*  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-*  the GNU General Public License for more details.
-*
-*  You should have received a copy of the GNU General Public License
-*  along with this program;  if not, write to the Free Software
-*  Foundation,
-*
-*  FILE        : aio_tio
-*  USAGE       : ./aio_tio
-*
-*  DESCRIPTION : This program will test Asynchronous I/O for 2.5 Kernel infrastructure
-*  REQUIREMENTS:
-*                1) libaio-0.3.92 or up for 2.5 kernal
-*                2) glibc 2.1.91 or up
-*  HISTORY     :
-*      11/03/2003 Kai Zhao (ltcd3@cn.ibm.com)
-*
-*  CODE COVERAGE:
-*                 68.3% - fs/aio.c
-*
-************************************************************************************/
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  Copyright (c) International Business Machines Corp., 2003
+ *
+ *  AUTHORS
+ *   Kai Zhao (ltcd3@cn.ibm.com)
+ *
+ *  DESCRIPTION : Test Asynchronous I/O for 2.5 Kernel Infrastructure
+ *
+ *  REQUIREMENTS:
+ *   1) libaio-0.3.92 or up for 2.5 kernel
+ *   2) glibc 2.1.91 or up
+ */
 
 #include "config.h"
-#include "common.h"
-#include "test.h"
-#include "safe_macros.h"
-#include <string.h>
+#include "tst_test.h"
 #include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
 
 #ifdef HAVE_LIBAIO
+#include <libaio.h>
 
 #define AIO_MAXIO 32
 #define AIO_BLKSIZE (64*1024)
 
 static int wait_count = 0;
 
+/*
+ * Fatal error handler
+ */
+void io_error(const char *func, int rc)
+{
+	if (rc == -ENOSYS)
+		tst_brk(TCONF, "AIO not in this kernel\n");
+	else if (rc < 0)
+		tst_brk(TFAIL, "%s: %s\n", func, strerror(-rc));
+	else
+		tst_brk(TFAIL, "%s: error %d\n", func, rc);
+}
+
 /*
  * write work done
  */
 static void work_done(io_context_t ctx, struct iocb *iocb, long res, long res2)
 {
+	(void) ctx;  // silence compiler warning (-Wunused)
 
 	if (res2 != 0) {
 		io_error("aio write", res2);
 	}
 
-	if (res != iocb->u.c.nbytes) {
-		fprintf(stderr, "write missed bytes expect %lu got %ld\n",
+	if (res != (long)iocb->u.c.nbytes) {
+		tst_brk(TFAIL, "write missed bytes expect %lu got %ld\n",
 			iocb->u.c.nbytes, res);
-		exit(1);
 	}
 	wait_count--;
 }
@@ -66,7 +61,7 @@ static void work_done(io_context_t ctx, struct iocb *iocb, long res, long res2)
 /*
  * io_wait_run() - wait for an io_event and then call the callback.
  */
-int io_wait_run(io_context_t ctx, struct timespec *to)
+static int io_wait_run(io_context_t ctx, struct timespec *to)
 {
 	struct io_event events[AIO_MAXIO];
 	struct io_event *ep;
@@ -88,7 +83,7 @@ int io_wait_run(io_context_t ctx, struct timespec *to)
 	return ret;
 }
 
-int io_tio(char *pathname, int flag, int n, int operation)
+static int io_tio(char *pathname, int flag, int n, int operation)
 {
 	int res, fd = 0, i = 0;
 	void *bufptr = NULL;
@@ -101,31 +96,26 @@ int io_tio(char *pathname, int flag, int n, int operation)
 	struct iocb iocb_array[AIO_MAXIO];
 	struct iocb *iocbps[AIO_MAXIO];
 
-	fd = open(pathname, flag, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
-	if (fd <= 0) {
-		printf("open for %s failed: %s\n", pathname, strerror(errno));
-		return -1;
-	}
+	fd = SAFE_OPEN(pathname, flag, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
 	/* determine the alignment from the blksize of the underlying fs */
-	SAFE_FSTAT(NULL, fd, &fi_stat);
+	SAFE_FSTAT(fd, &fi_stat);
 	alignment = fi_stat.st_blksize;
 
 	res = io_queue_init(n, &myctx);
-	//printf (" res = %d \n", res);
 
 	for (i = 0; i < AIO_MAXIO; i++) {
 
 		switch (operation) {
 		case IO_CMD_PWRITE:
 			if (posix_memalign(&bufptr, alignment, AIO_BLKSIZE)) {
-				perror(" posix_memalign failed ");
+				tst_brk(TBROK | TERRNO, "posix_memalign failed");
 				return -1;
 			}
 			memset(bufptr, 0, AIO_BLKSIZE);
 
 			io_prep_pwrite(&iocb_array[i], fd, bufptr,
-				       AIO_BLKSIZE, offset);
+					   AIO_BLKSIZE, offset);
 			io_set_callback(&iocb_array[i], work_done);
 			iocbps[i] = &iocb_array[i];
 			offset += AIO_BLKSIZE;
@@ -133,13 +123,13 @@ int io_tio(char *pathname, int flag, int n, int operation)
 			break;
 		case IO_CMD_PREAD:
 			if (posix_memalign(&bufptr, alignment, AIO_BLKSIZE)) {
-				perror(" posix_memalign failed ");
+				tst_brk(TBROK | TERRNO, "posix_memalign failed");
 				return -1;
 			}
 			memset(bufptr, 0, AIO_BLKSIZE);
 
 			io_prep_pread(&iocb_array[i], fd, bufptr,
-				      AIO_BLKSIZE, offset);
+					  AIO_BLKSIZE, offset);
 			io_set_callback(&iocb_array[i], work_done);
 			iocbps[i] = &iocb_array[i];
 			offset += AIO_BLKSIZE;
@@ -148,9 +138,7 @@ int io_tio(char *pathname, int flag, int n, int operation)
 		case IO_CMD_NOOP:
 			break;
 		default:
-			tst_resm(TFAIL,
-				 "Command failed; opcode returned: %d\n",
-				 operation);
+			tst_res(TFAIL, "Command failed; opcode returned: %d\n", operation);
 			return -1;
 			break;
 		}
@@ -164,8 +152,8 @@ int io_tio(char *pathname, int flag, int n, int operation)
 	}
 
 	/*
-	 * We have submitted all the i/o requests. Wait for at least one to complete
-	 * and call the callbacks.
+	 * We have submitted all the i/o requests. Wait for@least one to
+	 * complete and call the callbacks.
 	 */
 	wait_count = AIO_MAXIO;
 
@@ -185,7 +173,7 @@ int io_tio(char *pathname, int flag, int n, int operation)
 		break;
 	}
 
-	close(fd);
+	SAFE_CLOSE(fd);
 
 	for (i = 0; i < AIO_MAXIO; i++) {
 		if (iocb_array[i].u.c.buf != NULL) {
@@ -198,49 +186,70 @@ int io_tio(char *pathname, int flag, int n, int operation)
 	return 0;
 }
 
-int test_main(void)
+static void test_main(void)
 {
-	int status = 0;
-
-	tst_resm(TINFO, "Running test 1\n");
-	status = io_tio("file1",
-			O_TRUNC | O_DIRECT | O_WRONLY | O_CREAT | O_LARGEFILE,
-			AIO_MAXIO, IO_CMD_PWRITE);
-	if (status) {
-		return status;
-	}
+	struct testcase {
+		const char *description;
+		int flags;
+		int operation;
+	} testcases[] = {
+		{ .description =
+		    "WRITE: O_WRONLY | O_TRUNC | O_DIRECT | O_LARGEFILE | O_CREAT",
+		  .flags =  O_WRONLY | O_TRUNC | O_DIRECT | O_LARGEFILE | O_CREAT,
+		  .operation = IO_CMD_PWRITE
+		},
+		{ .description =
+		    "WRITE: O_RDONLY           | O_DIRECT | O_LARGEFILE",
+		  .flags =  O_RDONLY           | O_DIRECT | O_LARGEFILE,
+		  .operation = IO_CMD_PREAD
+		},
+		{ .description =
+		    "WRITE: O_RDWR   | O_TRUNC",
+		  .flags =  O_RDWR   | O_TRUNC,
+		  .operation = IO_CMD_PWRITE
+		},
+		{ .description =
+		    "READ : O_RDWR",
+		  .flags =  O_RDWR,
+		  .operation = IO_CMD_PREAD
+		},
+		{ .description =
+		    "WRITE: O_WRONLY | O_TRUNC",
+		  .flags =  O_WRONLY | O_TRUNC,
+		  .operation = IO_CMD_PWRITE
+		},
+		{ .description =
+		    "READ : O_RDONLY",
+		  .flags =  O_RDONLY,
+		  .operation = IO_CMD_PREAD
+		},
+	};
 
-	tst_resm(TINFO, "Running test 2\n");
-	status = io_tio("file1", O_RDONLY | O_DIRECT | O_LARGEFILE,
-			AIO_MAXIO, IO_CMD_PREAD);
-	if (status) {
-		return status;
-	}
-
-	tst_resm(TINFO, "Running test 3\n");
-	status = io_tio("file1", O_TRUNC | O_RDWR, AIO_MAXIO, IO_CMD_PWRITE);
-	if (status) {
-		return status;
-	}
-
-	tst_resm(TINFO, "Running test 4\n");
-	status = io_tio("file1", O_RDWR, AIO_MAXIO, IO_CMD_PREAD);
-	if (status) {
-		return status;
-	}
+	int status = 0;
 
-	tst_resm(TINFO, "Running test 5\n");
-	status = io_tio("file1", O_TRUNC | O_WRONLY, AIO_MAXIO, IO_CMD_PWRITE);
-	if (status) {
-		return status;
+	for (size_t i = 0; i < ARRAY_SIZE(testcases); ++i) {
+		tst_res(TINFO, "%s", testcases[i].description);
+		status = io_tio("file", testcases[i].flags, AIO_MAXIO,
+				testcases[i].operation);
+		if (status) {
+			tst_res(TFAIL, "%s, status = %d",
+					testcases[i].description, status);
+		} else {
+			tst_res(TPASS, "%s", testcases[i].description);
+		}
 	}
+}
 
-	tst_resm(TINFO, "Running test 6 \n");
-	status = io_tio("file1", O_RDONLY, AIO_MAXIO, IO_CMD_PREAD);
-	if (status) {
-		return status;
-	}
+#else
 
-	return status;
+static void test_main(void)
+{
+	tst_brk(TCONF, "test requires libaio and it's development packages");
 }
+
 #endif
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.test_all = test_main
+};
diff --git a/testcases/kernel/io/aio/aio02/common.h b/testcases/kernel/io/aio/aio02/common.h
deleted file mode 100644
index 4b80761a6..000000000
--- a/testcases/kernel/io/aio/aio02/common.h
+++ /dev/null
@@ -1,28 +0,0 @@
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <sys/param.h>
-#include <errno.h>
-#include <stdlib.h>
-#include <sys/select.h>
-#if HAVE_LIBAIO_H
-#include <libaio.h>
-#endif
-#include <sys/uio.h>
-#include <assert.h>
-#include <unistd.h>
-#include <stdio.h>
-#include <string.h>
-
-/* Fatal error handler */
-static void io_error(const char *func, int rc)
-{
-	if (rc == -ENOSYS)
-		fprintf(stderr, "AIO not in this kernel\n");
-	else if (rc < 0)
-		fprintf(stderr, "%s: %s\n", func, strerror(-rc));
-	else
-		fprintf(stderr, "%s: error %d\n", func, rc);
-
-	exit(1);
-}
diff --git a/testcases/kernel/io/aio/aio02/main.c b/testcases/kernel/io/aio/aio02/main.c
deleted file mode 100644
index 7b157f31b..000000000
--- a/testcases/kernel/io/aio/aio02/main.c
+++ /dev/null
@@ -1,37 +0,0 @@
-#include <stdio.h>
-#include <errno.h>
-#include <assert.h>
-#include <stdlib.h>
-#include <fcntl.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <unistd.h>
-
-#include "config.h"
-#include "test.h"
-
-#define TEST_NAME "aio_tio"
-
-char *TCID = "aio02/" TEST_NAME;
-int TST_TOTAL = 0;
-
-#ifdef HAVE_LIBAIO
-#include <libaio.h>
-
-int test_main(void);
-
-int main(void)
-{
-	tst_tmpdir();
-
-	test_main();
-
-	tst_rmdir();
-	tst_exit();
-}
-#else
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "test requires libaio and it's development packages");
-}
-#endif
-- 
2.21.0.rc0.258.g878e2cd30e-goog

