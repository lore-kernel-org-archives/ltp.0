From: QI Fuli <fukuri.sai@gmail.com>
Date: Sat, 27 Mar 2021 19:32:22 +0900
Subject: [LTP] [PATCH 2/6] syscalls/swapon/swapon01: Convert swapon01 to the
 new API
In-Reply-To: <20210327103226.99073-1-qi.fuli@fujitsu.com>
References: <20210327103226.99073-1-qi.fuli@fujitsu.com>
Message-ID: <20210327103226.99073-3-qi.fuli@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: QI Fuli <qi.fuli@fujitsu.com>

Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
---
 testcases/kernel/syscalls/swapon/Makefile   |  4 +-
 testcases/kernel/syscalls/swapon/swapon01.c | 83 +++++----------------
 2 files changed, 22 insertions(+), 65 deletions(-)

diff --git a/testcases/kernel/syscalls/swapon/Makefile b/testcases/kernel/syscalls/swapon/Makefile
index 57ec45d48..53c795090 100644
--- a/testcases/kernel/syscalls/swapon/Makefile
+++ b/testcases/kernel/syscalls/swapon/Makefile
@@ -8,10 +8,10 @@ endif
 
 top_srcdir		?= ../../../..
 
-LTPLIBS = ltpswapon
+LTPLIBS = ltpswap
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-LTPLDLIBS  = -lltpswapon
+LTPLDLIBS  = -lltpswap
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/swapon/swapon01.c b/testcases/kernel/syscalls/swapon/swapon01.c
index aff842e4c..332e139b3 100644
--- a/testcases/kernel/syscalls/swapon/swapon01.c
+++ b/testcases/kernel/syscalls/swapon/swapon01.c
@@ -1,88 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
  */
 
- /*
-  * Checks that swapon() succeds with swapfile.
-  */
+/*
+ * Checks that swapon() succeds with swapfile.
+ */
 
 #include <unistd.h>
 #include <errno.h>
 #include <stdlib.h>
-#include "test.h"
-#include "lapi/syscalls.h"
-#include "libswapon.h"
 
-static void setup(void);
-static void cleanup(void);
-
-char *TCID = "swapon01";
-int TST_TOTAL = 1;
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+#include "libswap.h"
 
 static void verify_swapon(void)
 {
-	TEST(ltp_syscall(__NR_swapon, "./swapfile01", 0));
+	TEST(tst_syscall(__NR_swapon, "./swapfile01", 0));
 
-	if (TEST_RETURN == -1) {
-		tst_resm(TFAIL | TTERRNO, "Failed to turn on swapfile");
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "Failed to turn on swapfile");
 	} else {
-		tst_resm(TPASS, "Succeeded to turn on swapfile");
+		tst_res(TPASS, "Succeeded to turn on swapfile");
 		/*we need to turn this swap file off for -i option */
-		if (ltp_syscall(__NR_swapoff, "./swapfile01") != 0) {
-			tst_brkm(TBROK, cleanup, "Failed to turn off swapfile,"
+		if (tst_syscall(__NR_swapoff, "./swapfile01") != 0) {
+			tst_brk(TBROK, "Failed to turn off swapfile,"
 			         " system reboot after execution of LTP "
 				 "test suite is recommended.");
 		}
 	}
 }
 
-int main(int ac, char **av)
-{
-
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		verify_swapon();
-	}
-
-	cleanup();
-	tst_exit();
-}
-
 static void setup(void)
 {
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	tst_require_root();
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	is_swap_supported(cleanup, "./tstswap");
-
-	make_swapfile(cleanup, "swapfile01", 0);
+	is_swap_supported("./tstswap");
+	make_swapfile("swapfile01", 0);
 }
 
-static void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.test_all = verify_swapon,
+	.setup = setup
+};
-- 
2.30.2

