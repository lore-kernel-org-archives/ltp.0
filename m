From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 15 Mar 2019 12:50:42 +0100
Subject: [LTP] [PATCH v4 2/3] aio_tio: convert to new lib
In-Reply-To: <20190226170243.134366-3-maennich@google.com>
References: <20190111085326.171826-1-maennich@google.com>
 <20190226170243.134366-1-maennich@google.com>
 <20190226170243.134366-3-maennich@google.com>
Message-ID: <20190315115042.GA8210@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Matthias,

> Convert to the new test lib and perform various cleanups.
> Also refactor the test definition for readability.

Thanks for your work, whole patchset pushed, with following fixes and further
cleanup.

Defining struct tst_test after HAVE_LIBAIO guard lead to build failures
on distros without libaio.


Kind regards,
Petr

diff --git testcases/kernel/io/aio/Makefile testcases/kernel/io/aio/Makefile
index 13ed4a395..32cad5215 100644
--- testcases/kernel/io/aio/Makefile
+++ testcases/kernel/io/aio/Makefile
@@ -1,14 +1,11 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 
 top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
 CPPFLAGS		+= -D_GNU_SOURCE
-
 LDLIBS			+= $(AIO_LIBS)
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git testcases/kernel/io/aio/aio02.c testcases/kernel/io/aio/aio02.c
index be53ace68..e283afba9 100644
--- testcases/kernel/io/aio/aio02.c
+++ testcases/kernel/io/aio/aio02.c
@@ -1,25 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *  Copyright (c) International Business Machines Corp., 2003
+ * Copyright (c) International Business Machines Corp., 2003
+ * Copyright (c) Linux Test Project, 2004-2019
  *
  *  AUTHORS
  *   Kai Zhao (ltcd3@cn.ibm.com)
- *
- *  DESCRIPTION : Test Asynchronous I/O for 2.5 Kernel Infrastructure
- *
- *  REQUIREMENTS:
- *   1) libaio-0.3.92 or up for 2.5 kernel
- *   2) glibc 2.1.91 or up
  */
 
 #include "config.h"
 #include "tst_test.h"
-#include <errno.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
 
 #ifdef HAVE_LIBAIO
+#include <errno.h>
+#include <stdlib.h>
 #include <libaio.h>
 
 #define AIO_MAXIO 32
@@ -27,37 +20,31 @@
 
 static int wait_count = 0;
 
-/*
- * test case definition
- */
+#define DESC_FLAGS_OPR(x, y) .desc = (x == IO_CMD_PWRITE ? "WRITE: " #y: "READ : " #y), \
+	.flags = y, .operation = x
+
 struct testcase {
-	const char *description;
+	const char *desc;
 	int flags;
 	int operation;
 } testcases[] = {
-	{"WRITE: O_WRONLY | O_TRUNC | O_DIRECT | O_LARGEFILE | O_CREAT",
-	         O_WRONLY | O_TRUNC | O_DIRECT | O_LARGEFILE | O_CREAT,
-	  IO_CMD_PWRITE
+	{
+		DESC_FLAGS_OPR(IO_CMD_PWRITE, O_WRONLY | O_TRUNC | O_DIRECT | O_LARGEFILE | O_CREAT),
 	},
-	{"WRITE: O_RDONLY           | O_DIRECT | O_LARGEFILE",
-	         O_RDONLY           | O_DIRECT | O_LARGEFILE,
-	 IO_CMD_PREAD
+	{
+		DESC_FLAGS_OPR(IO_CMD_PREAD, O_RDONLY | O_DIRECT | O_LARGEFILE),
 	},
-	{"WRITE: O_RDWR   | O_TRUNC",
-	         O_RDWR   | O_TRUNC,
-	 IO_CMD_PWRITE
+	{
+		DESC_FLAGS_OPR(IO_CMD_PWRITE, O_RDWR | O_TRUNC),
 	},
-	{"READ : O_RDWR",
-	         O_RDWR,
-	 IO_CMD_PREAD
+	{
+		DESC_FLAGS_OPR(IO_CMD_PREAD, O_RDWR),
 	},
-	{"WRITE: O_WRONLY | O_TRUNC",
-	         O_WRONLY | O_TRUNC,
-	 IO_CMD_PWRITE
+	{
+		DESC_FLAGS_OPR(IO_CMD_PWRITE, O_WRONLY | O_TRUNC),
 	},
-	{"READ : O_RDONLY",
-	         O_RDONLY,
-	 IO_CMD_PREAD
+	{
+		DESC_FLAGS_OPR(IO_CMD_PREAD, O_RDONLY),
 	},
 };
 
@@ -167,9 +154,6 @@ static int io_tio(char *pathname, int flag, int operation)
 			iocbps[i] = &iocb_array[i];
 			offset += AIO_BLKSIZE;
 			break;
-		case IO_CMD_POLL:
-		case IO_CMD_NOOP:
-			break;
 		default:
 			tst_res(TFAIL, "Command failed; opcode returned: %d\n", operation);
 			return -1;
@@ -222,25 +206,19 @@ static void test_io(unsigned int n)
 	int status;
 	struct testcase *tc = testcases + n;
 
-	tst_res(TINFO, "%s", tc->description);
 	status = io_tio("file", tc->flags, tc->operation);
 	if (status)
-		tst_res(TFAIL, "%s, status = %d", tc->description, status);
+		tst_res(TFAIL, "%s, status = %d", tc->desc, status);
 	else
-		tst_res(TPASS, "%s", tc->description);
+		tst_res(TPASS, "%s", tc->desc);
 }
 
-#else
-
-static void test_main(void)
-{
-	tst_brk(TCONF, "test requires libaio and its development packages");
-}
-
-#endif
-
 static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.test = test_io,
 	.tcnt = ARRAY_SIZE(testcases),
 };
+
+#else
+TST_TEST_TCONF("test requires libaio and its development packages");
+#endif
