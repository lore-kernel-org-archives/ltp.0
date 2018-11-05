From: Sandeep Patil <sspatil@google.com>
Date: Mon,  5 Nov 2018 15:50:19 -0800
Subject: [LTP] [PATCH 5/5] syscalls/posix_fadvise0[13]: Start using new
	library.
In-Reply-To: <20181105235019.254846-1-sspatil@google.com>
References: <20181105235019.254846-1-sspatil@google.com>
Message-ID: <20181105235019.254846-6-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Use SPDX-Licence-Identifier and delete dead comments / code while at it.
Make sure the tests can work on any system by creating its own file
and using it for testing.

Signed-off-by: Sandeep Patil <sspatil@google.com>
---
 .../kernel/syscalls/fadvise/posix_fadvise01.c | 135 ++++-----------
 .../kernel/syscalls/fadvise/posix_fadvise03.c | 163 ++++--------------
 2 files changed, 68 insertions(+), 230 deletions(-)

diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise01.c b/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
index c12f0563c..ad139a66b 100644
--- a/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
+++ b/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
@@ -1,20 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- *
  *   Copyright (c) Red Hat Inc., 2007
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
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
@@ -34,15 +20,13 @@
  *	None
  */
 
-#define _XOPEN_SOURCE 600
 #include <fcntl.h>
 
 #include <unistd.h>
 #include <signal.h>
 #include <errno.h>
 
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 
 #include "lapi/syscalls.h"
 #ifndef _FILE_OFFSET_BITS
@@ -53,15 +37,8 @@
 #define __NR_fadvise64 0
 #endif
 
-void setup();
-void cleanup();
-
-TCID_DEFINE(posix_fadvise01);
-
-char fname[] = "/bin/cat";	/* test executable to open */
-int fd = -1;			/* initialized in open */
-
-int expected_return = 0;
+const char *fname = "testfile";
+int fd = -1;
 
 int defined_advise[] = {
 	POSIX_FADV_NORMAL,
@@ -72,91 +49,41 @@ int defined_advise[] = {
 	POSIX_FADV_DONTNEED,
 };
 
-#define defined_advise_total ARRAY_SIZE(defined_advise)
-
-int TST_TOTAL = defined_advise_total;
-
-int main(int ac, char **av)
+void test_posix_fadvise(unsigned int nr)
 {
-	int lc;
-	int i;
-
-	/* Check this system has fadvise64 system which is used
-	   in posix_fadvise. */
-	if ((_FILE_OFFSET_BITS != 64) && (__NR_fadvise64 == 0)) {
-		tst_resm(TWARN,
-			 "This test can only run on kernels that implements ");
-		tst_resm(TWARN, "fadvise64 which is used from posix_fadvise");
-		exit(0);
+	TEST(posix_fadvise(fd, 0, 0, defined_advise[nr]));
+	if (TST_RET == 0) {
+		tst_res(TPASS, "call succeeded expectedly");
+	} else {
+		tst_res(TFAIL, "unexpected return - %ld w/ advise %d",
+				TST_RET, defined_advise[nr]);
 	}
-
-	/*
-	 * parse standard options
-	 */
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	/*
-	 * perform global setup for test
-	 */
-	setup();
-
-	/*
-	 * check looping state if -i option given on the command line
-	 */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		/* loop through the test cases */
-		for (i = 0; i < defined_advise_total; i++) {
-
-			TEST(posix_fadvise(fd, 0, 0, defined_advise[i]));
-
-			/* Man page says:
-			   "On error, an error number is returned." */
-			if (TEST_RETURN == expected_return) {
-				tst_resm(TPASS, "call succeeded expectedly");
-			} else {
-				tst_resm(TFAIL,
-					 "unexpected return value - %ld : %s, advise %d - "
-					 "expected %d",
-					 TEST_RETURN,
-					 strerror(TEST_RETURN),
-					 defined_advise[i], expected_return);
-			}
-		}
-	}
-
-	/*
-	 * cleanup and exit
-	 */
-	cleanup();
-
-	tst_exit();
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
 void setup(void)
 {
+	unsigned long pagesz = getpagesize();
+	char buf[10 * pagesz];
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	/* Check this system has fadvise64 system which is used
+	   in posix_fadvise. */
+	if ((_FILE_OFFSET_BITS != 64) && (__NR_fadvise64 == 0)) {
+		tst_brk(TCONF,
+			"This test can only run on kernels that implements "
+			"fadvise64 which is used from posix_fadvise");
+	}
 
-	TEST_PAUSE;
+	/* create 10 x pagesize file to be used for fadvise checks */
+	fd = SAFE_CREAT(fname, 0644);
+	SAFE_WRITE(1, fd, buf, 10 * pagesz);
+	SAFE_CLOSE(fd);
 
-	fd = SAFE_OPEN(cleanup, fname, O_RDONLY);
+	fd = SAFE_OPEN(fname, O_RDONLY);
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- */
-void cleanup(void)
-{
-
-	if (fd != -1) {
-		close(fd);
-	}
-
-}
+struct tst_test test = {
+	.tcnt = ARRAY_SIZE(defined_advise),
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.test = test_posix_fadvise,
+};
diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise03.c b/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
index 4aa3a8cd1..ffb196743 100644
--- a/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
+++ b/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
@@ -1,20 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- *
  *   Copyright (c) Red Hat Inc., 2007
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
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
@@ -34,14 +20,12 @@
  *	None
  */
 
-#define _XOPEN_SOURCE 600
 #include <fcntl.h>
 #include <unistd.h>
 #include <signal.h>
 #include <errno.h>
 #include <limits.h>
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 
 #include "lapi/syscalls.h"
 #ifndef _FILE_OFFSET_BITS
@@ -52,14 +36,10 @@
 #define __NR_fadvise64 0
 #endif
 
-void setup();
-void cleanup();
-
-TCID_DEFINE(posix_fadvise03);
-
-char fname[] = "/bin/cat";	/* test executable to open */
-int fd = -1;			/* initialized in open */
+#define ADVISE_LIMIT	(32)
 
+const char *fname = "testfile";
+int fd = -1;
 int expected_error = EINVAL;
 
 int defined_advise[] = {
@@ -87,24 +67,10 @@ int defined_advise[] = {
 #endif
 };
 
-#define defined_advise_total ARRAY_SIZE(defined_advise)
-
-#if 0
-/* Too many test cases. */
-int TST_TOTAL = (INT_MAX - defined_advise_total);
-int advise_limit = INT_MAX;
-#else
-int TST_TOTAL = (32 - defined_advise_total);
-int advise_limit = 32;
-#endif /* 0 */
-
-/* is_defined_advise:
-   Return 1 if advise is in defined_advise.
-   Return 0 if not. */
 static int is_defined_advise(int advise)
 {
 	int i;
-	for (i = 0; i < defined_advise_total; i++) {
+	for (i = 0; i < ARRAY_SIZE(defined_advise); i++) {
 		if (defined_advise[i] == advise)
 			return 1;
 	}
@@ -112,101 +78,46 @@ static int is_defined_advise(int advise)
 	return 0;
 }
 
-int main(int ac, char **av)
+int test_posix_fadvise(unsigned int nr)
 {
-	int lc;
-	int advise;
-
-	/* Check this system has fadvise64 system which is used
-	   in posix_fadvise. */
-	if ((_FILE_OFFSET_BITS != 64) && (__NR_fadvise64 == 0)) {
-		tst_resm(TWARN,
-			 "This test can only run on kernels that implements ");
-		tst_resm(TWARN, "fadvise64 which is used from posix_fadvise");
-		exit(0);
+	int advise = nr;
+	
+	/* Don't use defined advise as an argument. */
+	if (is_defined_advise(advise)) {
+		return;
 	}
 
-	/*
-	 * parse standard options
-	 */
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	/*
-	 * perform global setup for test
-	 */
-	setup();
-
-	/*
-	 * check looping state if -i option given on the command line
-	 */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		/* loop through the test cases */
-		for (advise = 0; advise < advise_limit; advise++) {
-
-			/* Don't use defiend advise as an argument. */
-			if (is_defined_advise(advise)) {
-				continue;
-			}
-
-			TEST(posix_fadvise(fd, 0, 0, advise));
-
-			if (TEST_RETURN == 0) {
-				tst_resm(TFAIL, "call succeeded unexpectedly");
-				continue;
-			}
-
-			/* Man page says:
-			   "On error, an error number is returned." */
-			if (TEST_RETURN == expected_error) {
-				tst_resm(TPASS,
-					 "expected failure - "
-					 "returned value = %ld, advise = %d : %s",
-					 TEST_RETURN,
-					 advise, strerror(TEST_RETURN));
-			} else {
-				tst_resm(TFAIL,
-					 "unexpected return value - %ld : %s, advise %d - "
-					 "expected %d",
-					 TEST_RETURN,
-					 strerror(TEST_RETURN),
-					 advise, expected_error);
-			}
-		}
+	TEST(posix_fadvise(fd, 0, 0, advise));
+	if (TST_RET == 0) {
+		tst_res(TFAIL, "call succeeded unexpectedly");
+		return;
 	}
 
-	/*
-	 * cleanup and exit
-	 */
-	cleanup();
-
-	tst_exit();
+	if (TST_RET == expected_error) {
+		tst_res(TPASS, "expected failure - returned %ld for advise %d",
+				TST_RET, advise);
+	} else {
+		tst_res(TFAIL, "unexpected return - %ld for advise %d",
+				TST_RET, advise);
+	}
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
 void setup(void)
 {
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	fd = SAFE_OPEN(cleanup, fname, O_RDONLY);
-}
-
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- */
-void cleanup(void)
-{
-
-	if (fd != -1) {
-		close(fd);
+	/* Check this system has fadvise64 system which is used
+	   in posix_fadvise. */
+	if ((_FILE_OFFSET_BITS != 64) && (__NR_fadvise64 == 0)) {
+		tst_brk(TCONF,
+			"This test can only run on kernels that implements "
+			"fadvise64 which is used from posix_fadvise");
 	}
 
+	fd = SAFE_OPEN(, fname, O_RDONLY);
 }
+
+struct tst_test test = {
+	.tcnt = ADVISE_LIMIT,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.test = test_posix_fadvise,
+};
-- 
2.19.1.930.g4563a0d9d0-goog

