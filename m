From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 17 Dec 2019 18:12:48 +0800
Subject: [LTP] [PATCH v1 1/4] syscalls/capset01: Cleanup & convert to new
 library
In-Reply-To: <1576577571-3668-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1576577571-3668-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1576577571-3668-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test capset() syscall on three versions.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/capset/capset01.c | 150 ++++----------------
 1 file changed, 29 insertions(+), 121 deletions(-)

diff --git a/testcases/kernel/syscalls/capset/capset01.c b/testcases/kernel/syscalls/capset/capset01.c
index 9c61773bb..75cdd83b9 100644
--- a/testcases/kernel/syscalls/capset/capset01.c
+++ b/testcases/kernel/syscalls/capset/capset01.c
@@ -1,142 +1,50 @@
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
- */
-/**********************************************************
- *
- *    TEST IDENTIFIER	: capset01
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Basic test for capset(2)
- *
- *    TEST CASE TOTAL	: 1
- *
  *    AUTHOR		: Saji Kumar.V.R <saji.kumar@wipro.com>
  *
- *    SIGNALS
- * 	Uses SIGUSR1 to pause before test if option set.
- * 	(See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *	This is a Phase I test for the capset(2) system call.
- *	It is intended to provide a limited exposure of the system call.
- *
- * 	Setup:
- * 	  Setup signal handling.
- *	  Pause for SIGUSR1 if option specified.
- *	  call capget() to save the current capability data
- *
- * 	Test:
- *	 Loop if the proper options are given.
- * 	  call capset() with the saved data
- *	  if return value == 0
- *		Test passed
- *	  Otherwise
- *		Test failed
- *
- * 	Cleanup:
- * 	  Print errno log and/or timing stats if options given
- *
- * USAGE:  <for command-line>
- * capset01 [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-h] [-f] [-p]
- *			where,  -c n : Run n copies concurrently.
- *				-e   : Turn on errno logging.
- *				-h   : Show help screen
- *				-f   : Turn off functional testing
- *				-i n : Execute test n times.
- *				-I x : Execute test for x seconds.
- *				-p   : Pause for SIGUSR1 before starting
- *				-P x : Pause for x seconds between iterations.
- *				-t   : Turn on syscall timing.
- *
  * CHANGES:
  *  2005/01/01: add an hint to a possible solution when test fails
  *              - Ricky Ng-Adam <rngadam@yahoo.com>
  ****************************************************************/
+#include <sys/types.h>
 #include <unistd.h>
-#include <errno.h>
-#include "test.h"
+#include "tst_test.h"
 #include "lapi/syscalls.h"
-
-/**************************************************************************/
-/*                                                                        */
-/*   Some archs do not have the manpage documented sys/capability.h file, */
-/*   and require the use of the line below                                */
-
 #include <linux/capability.h>
 
-/*   If you are having issues with including this file and have the sys/  */
-/*   version, then you may want to try switching to it. -Robbie W.        */
-/**************************************************************************/
+static struct tcase {
+	int version;
+	char *message;
+} tcases[] = {
+	{0x19980330, "Test on LINUX_CAPABILITY_VERSION_1"},
+	{0x20071026, "Test on LINUX_CAPABILITY_VERSION_2"},
+	{0x20080522, "Test on LINUX_CAPABILITY_VERSION_3"},
+};
 
-static void setup();
-static void cleanup();
 
-char *TCID = "capset01";
-int TST_TOTAL = 1;
-
-static struct __user_cap_header_struct header;	/* cap_user_header_t is a pointer
-						   to __user_cap_header_struct */
-
-static struct __user_cap_data_struct data;	/* cap_user_data_t is a pointer to
-						   __user_cap_data_struct */
-
-int main(int ac, char **av)
+static void verify_capset(unsigned int n)
 {
+	struct tcase *tc = &tcases[n];
+	struct __user_cap_header_struct header;
+	struct __user_cap_data_struct data[2];
 
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
+	tst_res(TINFO, "%s", tc->message);
+	header.version = tc->version;
+	header.pid = getpid();
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		TEST(ltp_syscall(__NR_capset, &header, &data));
-
-		if (TEST_RETURN == 0) {
-			tst_resm(TPASS, "capset() returned %ld", TEST_RETURN);
-		} else {
-			tst_resm(TFAIL | TTERRNO,
-				 "Test Failed, capset() returned %ld"
-				 " Maybe you need to do `modprobe capability`?",
-				 TEST_RETURN);
-		}
+	if (tst_syscall(__NR_capget, &header, data) == -1) {
+		tst_res(TFAIL | TTERRNO, "capget() failed");
+		return;
 	}
 
-	cleanup();
-
-	tst_exit();
+	TEST(tst_syscall(__NR_capset, &header, data));
+	if (TST_RET == 0)
+		tst_res(TPASS, "capset() returned %ld", TST_RET);
+	else
+		tst_res(TFAIL | TTERRNO, "Test Failed, capset() returned %ld", TST_RET);
 }
 
-void setup(void)
-{
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	header.version = _LINUX_CAPABILITY_VERSION;
-	header.pid = 0;
-	if (ltp_syscall(__NR_capget, &header, &data) == -1)
-		tst_brkm(TBROK | TERRNO, NULL, "capget() failed");
-}
-
-void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_capset,
+};
-- 
2.18.0



