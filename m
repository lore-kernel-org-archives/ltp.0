From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Mon, 14 Nov 2016 17:44:53 +0800
Subject: [LTP] [PATCH 3/4] syscalls/setpriority01: Cleanup && Convert to new
	API
In-Reply-To: <1479116694-23167-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1479116694-23167-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <1479116694-23167-3-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* add tests for PRIO_PGRP and PRIO_USER flag.

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 .../kernel/syscalls/setpriority/setpriority01.c    | 120 +++++++++------------
 1 file changed, 50 insertions(+), 70 deletions(-)

diff --git a/testcases/kernel/syscalls/setpriority/setpriority01.c b/testcases/kernel/syscalls/setpriority/setpriority01.c
index 664c78e..2c0c6f4 100644
--- a/testcases/kernel/syscalls/setpriority/setpriority01.c
+++ b/testcases/kernel/syscalls/setpriority/setpriority01.c
@@ -1,95 +1,75 @@
 /*
  * Copyright (c) International Business Machines  Corp., 2001
- *	03/2001 - Written by Wayne Boyer
+ *  03/2001 Written by Wayne Boyer
+ *  11/2016 Modified by Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
  *
- * This program is free software;  you can redistribute it and/or modify
+ * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
- * DESCRIPTION
- *	setpriority01 - set the priority for the test process lower.
+ * Verify that setpriority(2) succeeds set the scheduling priority of
+ * the current process, process group or user.
  */
 
-#include "test.h"
-
 #include <errno.h>
-#include <sys/time.h>
 #include <sys/resource.h>
+#include <sys/time.h>
+#include "tst_test.h"
 
-static void cleanup(void);
-static void setpriority_verify(const int);
-static void setup(void);
-
-char *TCID = "setpriority01";
-int TST_TOTAL = 40;
-
-int main(int ac, char **av)
-{
-	int lc;
-	int new_val;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		for (new_val = -20; new_val < 20; new_val++)
-			setpriority_verify(new_val);
-	}
-
-	cleanup();
-	tst_exit();
-
-}
-
-static void setup(void)
-{
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-}
+static struct tcase {
+	int which;
+} tcases[] = {
+	{PRIO_PROCESS},
+	{PRIO_PGRP},
+	{PRIO_USER}
+};
 
-static void setpriority_verify(const int new_prio)
+static void verify_setpriority(unsigned int n)
 {
-	int priority;
-	TEST(setpriority(PRIO_PROCESS, 0, new_prio));
-
-	if (TEST_RETURN != 0) {
-		tst_resm(TFAIL | TTERRNO, "setpriority(%d) failed", new_prio);
-		return;
-	}
-
-	priority = getpriority(PRIO_PROCESS, 0);
-	if (errno == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "getpriority call failed - errno = %d - %s", errno,
-			 strerror(errno));
+	struct tcase *tc = &tcases[n];
+	int new_prio, cur_prio;
+	int failflag = 0;
+
+	for (new_prio = -20; new_prio < 20; new_prio++) {
+		TEST(setpriority(tc->which, 0, new_prio));
+
+		if (TEST_RETURN != 0) {
+			tst_res(TFAIL | TTERRNO,
+				"setpriority(%d, 0, %d) failed",
+				tc->which, new_prio);
+			failflag = 1;
+			continue;
+		}
+
+		cur_prio = SAFE_GETPRIORITY(tc->which, 0);
+
+		if (cur_prio != new_prio) {
+			tst_res(TFAIL, "current priority(%d) and "
+				"new priority(%d) do not match",
+				cur_prio, new_prio);
+			failflag = 1;
+		}
 	}
 
-	if (priority == new_prio) {
-		tst_resm(TPASS, "setpriority(%d) succeeded", new_prio);
-	} else {
-		tst_resm(TFAIL,
-			 "current priority-%d and new priority-%d do not match",
-			 priority, new_prio);
-	}
+	if (!failflag)
+		tst_res(TPASS, "setpriority(%d, 0, -20..19) succeeded",
+			tc->which);
 }
 
-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.tid = "setpriority01",
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_root = 1,
+	.test = verify_setpriority,
+};
-- 
1.8.4.2



