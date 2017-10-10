From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 10 Oct 2017 09:52:51 +0800
Subject: [LTP] [PATCH v2 2/2] syscalls/setrlimit03.c: Cleanup && Convert to
	new API
In-Reply-To: <1507600371-29126-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20171009142304.GB25633@rei.lan>
 <1507600371-29126-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1507600371-29126-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) take use of safe macros
2) add a test for EINVAL

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/setrlimit/setrlimit03.c | 143 ++++++++--------------
 1 file changed, 53 insertions(+), 90 deletions(-)

diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit03.c b/testcases/kernel/syscalls/setrlimit/setrlimit03.c
index e0beb17..d551c90 100644
--- a/testcases/kernel/syscalls/setrlimit/setrlimit03.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit03.c
@@ -1,116 +1,79 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) 2017 Xiao Yang <yangx.jy@cn.fujitsu.com>
  *
- *   Copyright (c) International Business Machines  Corp., 2001
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
- * NAME
- *	setrlimit03.c
- *
  * DESCRIPTION
- *	Test for EPERM when the super-user tries to increase RLIMIT_NOFILE
- *	beyond the system limit.
- *
- * USAGE:  <for command-line>
- *  setrlimit03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- *	Must run test as root.
+ *  1) Test for EPERM when the super-user tries to increase RLIMIT_NOFILE
+ *     beyond the system limit.
+ *  2) Test for EINVAL when rlim->rlim_cur is greater than rlim->rlim_max.
  */
+
+#include <errno.h>
 #include <sys/time.h>
 #include <sys/resource.h>
-#include <unistd.h>
-#include <errno.h>
-#include "test.h"
 #include <linux/fs.h>
-
-char *TCID = "setrlimit03";
-int TST_TOTAL = 1;
+#include "tst_test.h"
 
 #if !defined(NR_OPEN)
-//Taken from definition in /usr/include/linux/fs.h
-#define NR_OPEN (1024*1024)
+// Taken from definition in /usr/include/linux/fs.h
+# define NR_OPEN (1024*1024)
 #endif
 
-void setup();
-void cleanup();
-
-int main(int ac, char **av)
-{
-	int lc;
-	struct rlimit rlim;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+static struct rlimit rlim1, rlim2;
 
-		tst_count = 0;
+static struct tcase {
+	struct rlimit *rlimt;
+	int exp_err;
+} tcases[] = {
+	{&rlim1, EPERM},
+	{&rlim2, EINVAL}
+};
 
-		if (getrlimit(RLIMIT_NOFILE, &rlim) != 0)
-			tst_brkm(TFAIL, cleanup, "getrlimit failed, "
-				 "errno = %d", errno);
-		rlim.rlim_max = NR_OPEN + 1;
-
-		TEST(setrlimit(RLIMIT_NOFILE, &rlim));
-
-		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "call succeeded unexpectedly");
-			continue;
-		}
+static void verify_setrlimit(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
 
-		if (TEST_ERRNO != EPERM) {
-			tst_resm(TFAIL, "Expected EPERM, got %d", TEST_ERRNO);
-		} else {
-			tst_resm(TPASS, "got expected EPERM error");
-		}
+	TEST(setrlimit(RLIMIT_NOFILE, tc->rlimt));
+	if (TEST_RETURN != -1) {
+		tst_res(TFAIL, "call succeeded unexpectedly");
+		return;
 	}
-	cleanup();
-	tst_exit();
 
+	if (TEST_ERRNO != tc->exp_err) {
+		tst_res(TFAIL | TTERRNO, "setrlimit() should fail with %s, got",
+			tst_strerrno(tc->exp_err));
+	} else {
+		tst_res(TPASS | TTERRNO, "setrlimit() failed as expected");
+	}
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
+static void setup(void)
 {
-	tst_require_root();
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	SAFE_GETRLIMIT(RLIMIT_NOFILE, &rlim1);
+	rlim2.rlim_max = rlim1.rlim_cur;
+	rlim2.rlim_cur = rlim1.rlim_max + 1;
+	rlim1.rlim_max = NR_OPEN + 1;
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- */
-void cleanup(void)
-{
-
-}
+static struct tst_test test = {
+	.setup = setup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_setrlimit,
+	.needs_root = 1
+};
-- 
1.8.3.1



