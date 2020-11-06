From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 6 Nov 2020 14:50:14 +0800
Subject: [LTP] [PATCH 2/2] syscalls/uname02: Convert to new API and cleanup
In-Reply-To: <20201106065014.1118435-1-yangx.jy@cn.fujitsu.com>
References: <20201106065014.1118435-1-yangx.jy@cn.fujitsu.com>
Message-ID: <20201106065014.1118435-2-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/uname/uname02.c | 121 +++-------------------
 1 file changed, 17 insertions(+), 104 deletions(-)

diff --git a/testcases/kernel/syscalls/uname/uname02.c b/testcases/kernel/syscalls/uname/uname02.c
index 8b45a763d..ae888224a 100644
--- a/testcases/kernel/syscalls/uname/uname02.c
+++ b/testcases/kernel/syscalls/uname/uname02.c
@@ -1,119 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
- *   Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) International Business Machines  Corp., 2001
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * Basic test for uname():
+ * Calling uname() with invalid buf got EFAULT.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
-/*
- * NAME
- *	uname02.c
- *
- * DESCRIPTION
- *	uname02 - call uname() with an invalid address to produce a failure
- *
- * ALGORITHM
- *	loop if that option was specified
- *	issue the system call
- *	check the errno value
- *	  issue a PASS message if we get EFAULT - errno 14
- *	otherwise, the tests fails
- *	  issue a FAIL message
- *	  break any remaining tests
- *	  call cleanup
- *
- * USAGE:  <for command-line>
- *  uname02 [-c n] [-e] [-i n] [-I x] [-p x] [-t]
- *		where,  -c n : Run n copies concurrently.
- *			-e   : Turn on errno logging.
- *			-i n : Execute test n times.
- *			-I x : Execute test for x seconds.
- *			-P x : Pause for x seconds between iterations.
- *			-t   : Turn on syscall timing.
- *
- * History
- *	07/2001 John George
- *		-Ported
- *
- * Restrictions
- *	none
- */
-
-#include "test.h"
-
 #include <errno.h>
 #include <sys/utsname.h>
+#include "tst_test.h"
 
-void cleanup(void);
-void setup(void);
-
-char *TCID = "uname02";
-int TST_TOTAL = 1;
-
-#if !defined(UCLINUX)
-
-int main(int ac, char **av)
+static void verify_uname(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();		/* global setup */
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		/*
-		 * call the system call with the TEST() macro
-		 * send -1 for an illegal address
-		 */
-
-		TEST(uname((struct utsname *)-1));
-
-		if (TEST_RETURN == 0)
-			tst_resm(TFAIL, "call succeed when failure expected");
-
-		switch (TEST_ERRNO) {
-		case EFAULT:
-			tst_resm(TPASS | TTERRNO, "uname failed as expected");
-			break;
-		default:
-			tst_resm(TFAIL | TTERRNO, "uname failed unexpectedly");
-		}
+	TEST(uname((struct utsname *)-1));
+	if (TST_RET == 0) {
+		tst_res(TFAIL, "uname() succeed when failure expected");
+		return;
 	}
 
-	cleanup();
-
-	tst_exit();
+	if (TST_ERR == EFAULT)
+		tst_res(TPASS, "uname() got EFAULT as expected");
+	else
+		tst_res(TFAIL | TTERRNO, "uname() failed unexpectedly");
 
 }
 
-void setup(void)
-{
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-}
-
-void cleanup(void)
-{
-}
-#else
-int main(void)
-{
-	tst_resm(TCONF, NULL, "test is not available on uClinux");
-}
-#endif /* if !defined(UCLINUX) */
+static struct tst_test test = {
+	.test_all = verify_uname,
+};
-- 
2.25.1



