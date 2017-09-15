From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 15 Sep 2017 12:06:15 +0800
Subject: [LTP] [PATCH 2/2] syscalls/io_destroy01.c: Cleanup && Convert to
	new API
In-Reply-To: <1505448375-26764-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1505448375-26764-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1505448375-26764-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 .../kernel/syscalls/io_destroy/io_destroy01.c      | 99 ++++++----------------
 1 file changed, 28 insertions(+), 71 deletions(-)

diff --git a/testcases/kernel/syscalls/io_destroy/io_destroy01.c b/testcases/kernel/syscalls/io_destroy/io_destroy01.c
index 9de4987..279cdb6 100644
--- a/testcases/kernel/syscalls/io_destroy/io_destroy01.c
+++ b/testcases/kernel/syscalls/io_destroy/io_destroy01.c
@@ -1,7 +1,7 @@
 /*
- *
  *   Copyright (c) Crackerjack Project., 2007
  *   Copyright (c) 2011 Cyril Hrubis <chrubis@suse.cz>
+ *   Copyright (c) 2017 Xiao Yang <yangx.jy@cn.fujitsu.com>
  *
  *   This program is free software;  you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -19,89 +19,46 @@
  */
 
 /* Porting from Crackerjack to LTP is done
-   by Masatake YAMATO <yamato@redhat.com> */
+ * by Masatake YAMATO <yamato@redhat.com>
+ *
+ * Description:
+ * io_destroy(2) fails and returns -EINVAL if ctx is invalid.
+ */
 
+#include <errno.h>
+#include <string.h>
 #include "config.h"
-#include "test.h"
-
-char *TCID = "io_destroy01";
-
-int TST_TOTAL = 1;
+#include "tst_test.h"
 
 #ifdef HAVE_LIBAIO_H
 #include <libaio.h>
-#include <errno.h>
-#include <string.h>
-
-static void cleanup(void)
-{
-}
 
-static void setup(void)
+static void verify_io_destroy(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-}
-
-/*
-  DESCRIPTION
-       io_destroy  removes  the asynchronous I/O context from the list of I/O
-       contexts and then destroys it.  io_destroy can also  cancel  any  out-
-       standing asynchronous I/O actions on ctx and block on completion.
-
- RETURN VALUE
-       io_destroy returns 0 on success.
-
- ERRORS
-       EINVAL The AIO context specified by ctx is invalid.
-*/
-
-#define EXP_RET (-EINVAL)
-
-int main(int argc, char *argv[])
-{
-	int lc;
-
 	io_context_t ctx;
 
 	memset(&ctx, 0xff, sizeof(ctx));
 
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		TEST(io_destroy(ctx));
-
-		switch (TEST_RETURN) {
-		case 0:
-			tst_resm(TFAIL, "call succeeded unexpectedly");
-			break;
-		case EXP_RET:
-			tst_resm(TPASS, "expected failure - "
-				 "returned value = %ld : %s", TEST_RETURN,
-				 strerror(-TEST_RETURN));
-			break;
-		case -ENOSYS:
-			tst_resm(TCONF, "io_cancel returned ENOSYS");
-			break;
-		default:
-			tst_resm(TFAIL, "unexpected returned value - %s (%i) - "
-				 "expected %s (%i)", strerror(-TEST_RETURN),
-				 (int)TEST_RETURN, strerror(-EXP_RET), EXP_RET);
-			break;
-		}
+	TEST(io_destroy(ctx));
+	if (TEST_RETURN == 0) {
+		tst_res(TFAIL, "io_destroy() succeeded unexpectedly");
+		return;
 	}
 
-	cleanup();
-	tst_exit();
+	if (TEST_RETURN == -EINVAL) {
+		tst_res(TPASS,
+			"io_destroy() failed as expected, returned -EINVAL");
+	} else {
+		tst_res(TFAIL, "io_destroy() failed unexpectedly, "
+			"returned -%s expected -EINVAL",
+			tst_strerrno(-TEST_RETURN));
+	}
 }
+
+static struct tst_test test = {
+	.test_all = verify_io_destroy,
+};
+
 #else
-int main(int argc, char *argv[])
-{
-	tst_brkm(TCONF, NULL, "System doesn't support execution of the test");
-}
+	TST_TEST_TCONF("System doesn't support execution of the test");
 #endif
-- 
1.8.3.1



