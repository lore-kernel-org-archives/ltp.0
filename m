From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 15 Sep 2017 12:06:14 +0800
Subject: [LTP] [PATCH 1/2] syscalls/io_setup01.c: Cleanup && Convert to new
	API
Message-ID: <1505448375-26764-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) remove duplicate code
2) add one test for EAGAIN

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/io_setup/io_setup01.c | 164 +++++++++---------------
 1 file changed, 63 insertions(+), 101 deletions(-)

diff --git a/testcases/kernel/syscalls/io_setup/io_setup01.c b/testcases/kernel/syscalls/io_setup/io_setup01.c
index 829cef5..2afa893 100644
--- a/testcases/kernel/syscalls/io_setup/io_setup01.c
+++ b/testcases/kernel/syscalls/io_setup/io_setup01.c
@@ -1,7 +1,7 @@
 /*
- *
  *   Copyright (c) Crackerjack Project., 2007
  *   Copyright (c) 2011 Cyril Hrubis <chrubis@suse.cz>
+ *   Copyright (c) 2017 Xiao Yang <yangx.jy@cn.fujitsu.com>
  *
  *   This program is free software;  you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -19,121 +19,83 @@
  */
 
 /* Porting from Crackerjack to LTP is done
-   by Masatake YAMATO <yamato@redhat.com> */
+ * by Masatake YAMATO <yamato@redhat.com>
+ *
+ * Description:
+ * 1) io_setup(2) succeeds if both nr_events and ctxp are valid.
+ * 2) io_setup(2) fails and returns -EINVAL if ctxp is not initialized to 0.
+ * 3) io_setup(2) fails and returns -EINVAL if nr_events is invalid.
+ * 4) io_setup(2) fails and returns -EFAULT if ctxp is NULL.
+ * 5) io_setup(2) fails and returns -EAGAIN if nr_events exceeds the limit
+ *    of available events.
+ */
 
+#include <errno.h>
+#include <string.h>
+#include <unistd.h>
 #include "config.h"
-#include "test.h"
-
-char *TCID = "io_setup01";
-
-int TST_TOTAL = 4;
+#include "tst_test.h"
 
 #ifdef HAVE_LIBAIO_H
 #include <libaio.h>
-#include <errno.h>
-#include <string.h>
 
-static void cleanup(void)
+static void verify_failure(unsigned int nr, io_context_t *ctx, int init_val, long exp_err)
 {
-}
-
-static void setup(void)
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	if (ctx)
+		memset(ctx, init_val, sizeof(*ctx));
+
+	TEST(io_setup(nr, ctx));
+	if (TEST_RETURN == 0) {
+		tst_res(TFAIL, "io_setup() passed unexpectedly");
+		io_destroy(*ctx);
+		return;
+	}
 
-	TEST_PAUSE;
+	if (TEST_RETURN == -exp_err) {
+		tst_res(TPASS, "io_setup() failed as expected, returned -%s",
+			tst_strerrno(exp_err));
+	} else {
+		tst_res(TFAIL, "io_setup() failed unexpectedly, returned -%s "
+			"expected -%s", tst_strerrno(-TEST_RETURN),
+			tst_strerrno(exp_err));
+	}
 }
 
-/*
-   DESCRIPTION
-   io_setup  creates  an asynchronous I/O context capable of receiving at
-   least nr_events.  ctxp must not point to an AIO context  that  already
-   exists, and must be initialized to 0 prior to the call.  On successful
-   creation of the AIO context, *ctxp is filled  in  with  the  resulting
-   handle.
- */
-int main(int argc, char *argv[])
+static void verify_success(unsigned int nr, io_context_t *ctx, int init_val)
 {
-	int lc;
-
-	io_context_t ctx;
-	int expected_return;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		memset(&ctx, 0, sizeof(ctx));
-		expected_return = 0;
-		TEST(io_setup(1, &ctx));
-
-		if (TEST_RETURN == expected_return) {
-			tst_resm(TPASS, "call succeeded expectedly");
-			io_destroy(ctx);
-		} else {
-			tst_resm(TFAIL, "unexpected returned value - %ld - "
-				 "expected %d", TEST_RETURN, expected_return);
-		}
-
-		memset(&ctx, 1, sizeof(ctx));
-		expected_return = -EINVAL;
-		TEST(io_setup(1, &ctx));
-
-		if (TEST_RETURN == 0) {
-			tst_resm(TFAIL, "call succeeded unexpectedly");
-			io_destroy(ctx);
-		} else if (TEST_RETURN == expected_return) {
-			tst_resm(TPASS, "expected failure - "
-				 "returned value = %ld : %s", TEST_RETURN,
-				 strerror(-1 * TEST_RETURN));
-		} else {
-			tst_resm(TFAIL, "unexpected returned value - %ld - "
-				 "expected %d", TEST_RETURN, expected_return);
-		}
-
-		memset(&ctx, 0, sizeof(ctx));
-		expected_return = -EINVAL;
-		TEST(io_setup(-1, &ctx));
-		if (TEST_RETURN == 0) {
-			tst_resm(TFAIL, "call succeeded unexpectedly");
-			io_destroy(ctx);
-		} else if (TEST_RETURN == expected_return) {
-			tst_resm(TPASS, "expected failure - "
-				 "returned value = %ld : %s", TEST_RETURN,
-				 strerror(-1 * TEST_RETURN));
-		} else {
-			tst_resm(TFAIL, "unexpected returned value - %ld - "
-				 "expected %d", TEST_RETURN, expected_return);
-		}
-
-		/*
-		   EFAULT An invalid pointer is passed for ctxp.
-		 */
-		expected_return = -EFAULT;
-		TEST(io_setup(1, NULL));
-		if (TEST_RETURN == 0) {
-			tst_resm(TFAIL, "call succeeded unexpectedly");
-			io_destroy(ctx);
-		} else if (TEST_RETURN == expected_return) {
-			tst_resm(TPASS, "expected failure - "
-				 "returned value = %ld : %s", TEST_RETURN,
-				 strerror(-1 * TEST_RETURN));
-		} else {
-			tst_resm(TFAIL, "unexpected returned value - %ld - "
-				 "expected %d", TEST_RETURN, expected_return);
-		}
+	memset(ctx, init_val, sizeof(*ctx));
 
+	TEST(io_setup(nr, ctx));
+	if (TEST_RETURN != 0) {
+		tst_res(TFAIL, "io_setup() failed unexpectedly");
+		return;
 	}
-	cleanup();
 
-	tst_exit();
+	tst_res(TPASS, "io_setup() passed as expected");
+	io_destroy(*ctx);
 }
-#else
-int main(int argc, char *argv[])
+static void verify_io_setup(void)
 {
-	tst_brkm(TCONF, NULL, "System doesn't support execution of the test");
+	io_context_t ctx;
+	unsigned int aio_max = 0;
+
+	verify_success(1, &ctx, 0);
+	verify_failure(1, &ctx, 1, EINVAL);
+	verify_failure(-1, &ctx, 0, EINVAL);
+	verify_failure(1, NULL, 0, EFAULT);
+
+	if (!access("/proc/sys/fs/aio-max-nr", F_OK)) {
+		SAFE_FILE_SCANF("/proc/sys/fs/aio-max-nr", "%u", &aio_max);
+		verify_failure(aio_max + 1, &ctx, 0, EAGAIN);
+	} else {
+		tst_res(TCONF, "the aio-max-nr file did not exist");
+	}
 }
+
+static struct tst_test test = {
+	.test_all = verify_io_setup,
+};
+
+#else
+	TST_TEST_TCONF("System doesn't support execution of the test");
 #endif
-- 
1.8.3.1



