From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 11 Dec 2019 15:25:58 +0800
Subject: [LTP] [PATCH 1/2] syscalls/capget01: Cleanup & convert to new
 library
Message-ID: <1576049159-14014-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test capget() syscall on three versions and check the result buf.
I don't want to use ".need_root", so we only can test Effective
set by using ltp capability  library code.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/capget/capget01.c | 161 ++++++--------------
 1 file changed, 49 insertions(+), 112 deletions(-)

diff --git a/testcases/kernel/syscalls/capget/capget01.c b/testcases/kernel/syscalls/capget/capget01.c
index 8a2a8921a..743e307c5 100644
--- a/testcases/kernel/syscalls/capget/capget01.c
+++ b/testcases/kernel/syscalls/capget/capget01.c
@@ -1,127 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
+ *  Author: Saji Kumar.V.R <saji.kumar@wipro.com>
  *
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
+ * Description:
+ * This case tests capget() syscall whether works well on three versions.
+ * Also, it checks the results buffer.
  */
-/**********************************************************
- *
- *    TEST IDENTIFIER	: capget01
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Basic test for capget(2)
- *
- *    TEST CASE TOTAL	: 1
- *
- *    AUTHOR		: Saji Kumar.V.R <saji.kumar@wipro.com>
- *
- *    SIGNALS
- * 	Uses SIGUSR1 to pause before test if option set.
- * 	(See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *	This is a Phase I test for the capget(2) system call.
- *	It is intended to provide a limited exposure of the system call.
- *
- * 	Setup:
- * 	  Setup signal handling.
- *	  Pause for SIGUSR1 if option specified.
- *
- * 	Test:
- *	 Loop if the proper options are given.
- * 	  call capget()
- *	  if return value == 0
- *		Test passed
- *	  Otherwise
- *		Test failed
- *
- * 	Cleanup:
- * 	  Print errno log and/or timing stats if options given
- *
- * USAGE:  <for command-line>
- * capget01 [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-h] [-f] [-p]
- *			where,  -c n : Run n copies concurrently.
- *				-e   : Turn on errno logging.
- *				-h   : Show help screen
- *				-f   : Turn off functional testing
- *				-i n : Execute test n times.
- *				-I x : Execute test for x seconds.
- *				-p   : Pause for SIGUSR1 before starting
- *				-P x : Pause for x seconds between iterations.
- *				-t   : Turn on syscall timing.
- ****************************************************************/
-
-#include <errno.h>
-#include <unistd.h>
-#include "test.h"
+#include <sys/types.h>
+#include "tst_test.h"
 #include "lapi/syscalls.h"
-
 #include <linux/capability.h>
 
-static void setup();
-static void cleanup();
-
-char *TCID = "capget01";
-int TST_TOTAL = 1;
+static pid_t pid;
 
-static struct __user_cap_header_struct header;	/* cap_user_header_t is a pointer
-						   to __user_cap_header_struct */
+static struct tcase {
+	int version;
+	char *message;
+} tcases[] = {
+	{0x19980330, "Test on LINUX_CAPABILITY_VERSION_1"},
+	{0x20071026, "Test on LINUX_CAPABILITY_VERSION_2"},
+	{0x20080522, "Test on LINUX_CAPABILITY_VERSION_3"},
+};
 
-static struct __user_cap_data_struct data;	/* cap_user_data_t is a pointer to
-						   __user_cap_data_struct */
-
-int main(int ac, char **av)
+static void verify_capget(unsigned int n)
 {
-
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	/* header.version must be _LINUX_CAPABILITY_VERSION */
-	header.version = _LINUX_CAPABILITY_VERSION;
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		TEST(ltp_syscall(__NR_capget, &header, &data));
-
-		if (TEST_RETURN == 0) {
-			tst_resm(TPASS, "capget() returned %ld", TEST_RETURN);
-		} else {
-			tst_resm(TFAIL | TTERRNO,
-				 "Test Failed, capget() returned %ld",
-				 TEST_RETURN);
-		}
-	}
-
-	cleanup();
-
-	tst_exit();
+	struct tcase *tc = &tcases[n];
+	struct __user_cap_header_struct hdr = {
+		.version = tc->version,
+		.pid = pid,
+	};
+
+	struct __user_cap_data_struct data;
+
+	tst_res(TINFO, "%s", tc->message);
+
+	TEST(tst_syscall(__NR_capget, &hdr, &data));
+	if (TST_RET == 0)
+		tst_res(TPASS, "capget() returned %ld", TST_RET);
+	else
+		tst_res(TFAIL | TTERRNO, "Test Failed, capget() returned %ld",
+				TST_RET);
+
+	if (data.effective & 1 << CAP_NET_RAW)
+		tst_res(TFAIL, "capget() gets CAP_NET_RAW unexpectedly in pE");
+	else
+		tst_res(TPASS, "capget() doesn't get CAP_NET_RAW as expected in PE");
 }
 
-void setup(void)
+static void setup(void)
 {
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
+	pid = getpid();
 }
 
-void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.setup = setup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_capget,
+	.caps = (struct tst_cap []) {
+		TST_CAP(TST_CAP_DROP, CAP_NET_RAW),
+		{}
+	},
+};
-- 
2.18.0



