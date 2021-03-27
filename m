From: QI Fuli <fukuri.sai@gmail.com>
Date: Sat, 27 Mar 2021 19:32:25 +0900
Subject: [LTP] [PATCH 5/6] syscalls/swapoff/swapoff01: Convert swapoff01 to
 the new API
In-Reply-To: <20210327103226.99073-1-qi.fuli@fujitsu.com>
References: <20210327103226.99073-1-qi.fuli@fujitsu.com>
Message-ID: <20210327103226.99073-6-qi.fuli@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: QI Fuli <qi.fuli@fujitsu.com>

Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
---
 testcases/kernel/syscalls/swapoff/Makefile    |  4 +-
 testcases/kernel/syscalls/swapoff/swapoff01.c | 94 +++++--------------
 2 files changed, 27 insertions(+), 71 deletions(-)

diff --git a/testcases/kernel/syscalls/swapoff/Makefile b/testcases/kernel/syscalls/swapoff/Makefile
index a74374605..6954112a8 100644
--- a/testcases/kernel/syscalls/swapoff/Makefile
+++ b/testcases/kernel/syscalls/swapoff/Makefile
@@ -3,10 +3,10 @@
 
 top_srcdir		?= ../../../..
 
-LTPLIBS = ltpswapon
+LTPLIBS = ltpswap
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-LTPLDLIBS  = -lltpswapon
+LTPLDLIBS  = -lltpswap
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/swapoff/swapoff01.c b/testcases/kernel/syscalls/swapoff/swapoff01.c
index 1a707625a..6ef01c7be 100644
--- a/testcases/kernel/syscalls/swapoff/swapoff01.c
+++ b/testcases/kernel/syscalls/swapoff/swapoff01.c
@@ -1,18 +1,6 @@
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
 
 /*
@@ -20,81 +8,49 @@
  */
 
 #include <unistd.h>
-#include "test.h"
 #include <errno.h>
 #include <stdlib.h>
-#include "config.h"
-#include "lapi/syscalls.h"
-#include "libswapon.h"
-
-static void setup(void);
-static void cleanup(void);
-static void verify_swapoff(void);
-
-char *TCID = "swapoff01";
-int TST_TOTAL = 1;
-
-int main(int ac, char **av)
-{
-	int lc;
 
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		verify_swapoff();
-	}
-
-	cleanup();
-	tst_exit();
-}
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+#include "libswap.h"
 
 static void verify_swapoff(void)
 {
-	if (ltp_syscall(__NR_swapon, "./swapfile01", 0) != 0) {
-		tst_resm(TBROK, "Failed to turn on the swap file"
+	if (tst_syscall(__NR_swapon, "./swapfile01", 0) != 0) {
+		tst_res(TFAIL, "Failed to turn on the swap file"
 			 ", skipping test iteration");
 		return;
 	}
 
-	TEST(ltp_syscall(__NR_swapoff, "./swapfile01"));
+	TEST(tst_syscall(__NR_swapoff, "./swapfile01"));
 
-	if (TEST_RETURN == -1) {
-		tst_resm(TFAIL | TTERRNO, "Failed to turn off swapfile,"
-		         " system reboot after execution of LTP "
-			 "test suite is recommended.");
-	} else {
-		tst_resm(TPASS, "Succeeded to turn off swapfile");
-	}
+	if (TST_RET == -1)
+		tst_res(TFAIL | TTERRNO, "Failed to turn off swapfile,"
+			" system reboot after execution of LTP "
+			"test suite is recommended.");
+	else
+		tst_res(TPASS, "Succeeded to turn off swapfile");
 }
 
 static void setup(void)
 {
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	tst_require_root();
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
+	is_swap_supported("./tstswap");
 
-	is_swap_supported(cleanup, "./tstswap");
-
-	if (!tst_fs_has_free(NULL, ".", 64, TST_MB)) {
-		tst_brkm(TBROK, cleanup,
-			 "Insufficient disk space to create swap file");
-	}
+	if (!tst_fs_has_free(".", 64, TST_MB))
+		tst_brk(TBROK,
+			"Insufficient disk space to create swap file");
 
 	if (tst_fill_file("swapfile01", 0x00, 1024, 65536))
-		tst_brkm(TBROK, cleanup, "Failed to create file for swap");
+		tst_brk(TBROK, "Failed to create file for swap");
 
 	if (system("mkswap swapfile01 > tmpfile 2>&1") != 0)
-		tst_brkm(TBROK, cleanup, "Failed to make swapfile");
+		tst_brk(TBROK, "Failed to make swapfile");
 }
 
-static void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.test_all = verify_swapoff,
+	.setup = setup
+};
-- 
2.30.2

