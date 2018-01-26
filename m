From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 26 Jan 2018 11:31:39 +0800
Subject: [LTP] [PATCH 3/4] syscalls/sysctl03: Enable && Cleanup
In-Reply-To: <1516937500-16475-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1516937500-16475-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1516937500-16475-3-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) Undefined __NR_sysctl always skips the test even though CONFIG_SYSCTL_SYSCALL
   is built, so enable it by correct __NR__sysctl.
2) Convert to new API.
3) Fix compiler warnings and errors.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/sysctl/sysctl03.c | 236 ++++++++--------------------
 1 file changed, 67 insertions(+), 169 deletions(-)

diff --git a/testcases/kernel/syscalls/sysctl/sysctl03.c b/testcases/kernel/syscalls/sysctl/sysctl03.c
index 0c8e691..f235aac 100644
--- a/testcases/kernel/syscalls/sysctl/sysctl03.c
+++ b/testcases/kernel/syscalls/sysctl/sysctl03.c
@@ -1,67 +1,41 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) 2018 Xiao Yang <yangx.jy@cn.fujitsu.com>
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
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  */
 
 /*
- * NAME
- *	sysctl03.c
- *
  * DESCRIPTION
- *	Testcase to check that sysctl(2) sets errno to EPERM correctly.
+ * 1) Call sysctl(2) as a root user, and attempt to write data
+ *    to the kernel_table[]. Since the table does not have write
+ *    permissions even for the root, it should fail EPERM.
+ * 2) Call sysctl(2) as a non-root user, and attempt to write data
+ *    to the kernel_table[]. Since the table does not have write
+ *    permission for the regular user, it should fail with EPERM.
  *
- * ALGORITHM
- *	a.	Call sysctl(2) as a root user, and attempt to write data
- *		to the kernel_table[]. Since the table does not have write
- *		permissions even for the root, it should fail EPERM.
- *	b.	Call sysctl(2) as a non-root user, and attempt to write data
- *		to the kernel_table[]. Since the table does not have write
- *		permission for the regular user, it should fail with EPERM.
- *
- * NOTE: There is a documentation bug in 2.6.33-rc1 where unfortunately the
- * behavior of sysctl(2) isn't properly documented, as discussed in detail in
- * the following thread:
+ * NOTE: There is a documentation bug in 2.6.33-rc1 where unfortunately
+ * the behavior of sysctl(2) isn't properly documented, as discussed
+ * in detail in the following thread:
  * http://sourceforge.net/mailarchive/message.php?msg_name=4B7BA24F.2010705%40linux.vnet.ibm.com.
  *
  * The documentation bug is filed as:
- * https://bugzilla.kernel.org/show_bug.cgi?id=15446 . If you want the message
- * removed, please ask your fellow kernel maintainer to fix their documentation.
+ * https://bugzilla.kernel.org/show_bug.cgi?id=15446 . If you want the
+ * message removed, please ask your fellow kernel maintainer to fix their
+ * documentation.
  *
  * Thanks!
  * -Ngie
- *
- * USAGE:  <for command-line>
- *  sysctl03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *	02/2010 Updated by shiwh@cn.fujitsu.com
- *
- * RESTRICTIONS
- *	Test must be run as root.
  */
-#include "test.h"
-#include "safe_macros.h"
+
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <stdio.h>
@@ -71,141 +45,65 @@
 #include <linux/sysctl.h>
 #include <pwd.h>
 
-char *TCID = "sysctl03";
-
-/* This is an older/deprecated syscall that newer arches are omitting */
-#ifdef __NR_sysctl
+#include "tst_test.h"
+#include "lapi/syscalls.h"
 
-int TST_TOTAL = 2;
+static int exp_eno;
 
-int sysctl(int *name, int nlen, void *oldval, size_t * oldlenp,
-	   void *newval, size_t newlen)
+static void verify_sysctl(void)
 {
-	struct __sysctl_args args =
-	    { name, nlen, oldval, oldlenp, newval, newlen };
-	return syscall(__NR__sysctl, &args);
-}
-
-#define OSNAMESZ 100
+	char *osname = "Linux";
+	int name[] = {CTL_KERN, KERN_OSTYPE};
+	struct __sysctl_args args = {
+		.name = name,
+		.nlen = ARRAY_SIZE(name),
+		.newval = osname,
+		.newlen = sizeof(osname),
+	};
+
+	TEST(tst_syscall(__NR__sysctl, &args));
+	if (TEST_RETURN != -1) {
+		tst_res(TFAIL, "sysctl(2) succeeded unexpectedly");
+		return;
+	}
 
-void setup(void);
-void cleanup(void);
+	if (TEST_ERRNO == exp_eno)
+		tst_res(TPASS | TTERRNO, "Got expected error");
+	else
+		tst_res(TFAIL | TTERRNO, "Got unexpected error");
+}
 
-int main(int ac, char **av)
+static void setup(void)
 {
-	int exp_eno;
-	int lc;
-
-	char osname[OSNAMESZ];
-	int osnamelth, status;
-	int name[] = { CTL_KERN, KERN_OSTYPE };
-	pid_t pid;
-	struct passwd *ltpuser;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
 	if ((tst_kvercmp(2, 6, 32)) <= 0) {
 		exp_eno = EPERM;
 	} else {
-		/* ^^ Look above this warning. ^^ */
-		tst_resm(TINFO,
+		/* Look above this warning. */
+		tst_res(TINFO,
 			 "this test's results are based on potentially undocumented behavior in the kernel. read the NOTE in the source file for more details");
 		exp_eno = EACCES;
-		exp_enos[0] = EACCES;
 	}
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		strcpy(osname, "Linux");
-		osnamelth = sizeof(osname);
-
-		TEST(sysctl(name, ARRAY_SIZE(name), 0, 0, osname, osnamelth));
-
-		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "sysctl(2) succeeded unexpectedly");
-		} else {
-			if (TEST_ERRNO == exp_eno) {
-				tst_resm(TPASS | TTERRNO, "Got expected error");
-			} else if (errno == ENOSYS) {
-				tst_resm(TCONF,
-					 "You may need to make CONFIG_SYSCTL_SYSCALL=y"
-					 " to your kernel config.");
-			} else {
-				tst_resm(TFAIL | TTERRNO,
-					 "Got unexpected error");
-			}
-		}
-
-		osnamelth = sizeof(osname);
-		if ((ltpuser = getpwnam("nobody")) == NULL) {
-			tst_brkm(TBROK, cleanup, "getpwnam() failed");
-		}
-
-		/* set process ID to "ltpuser1" */
-		SAFE_SETEUID(cleanup, ltpuser->pw_uid);
-
-		if ((pid = FORK_OR_VFORK()) == -1) {
-			tst_brkm(TBROK, cleanup, "fork() failed");
-		}
-
-		if (pid == 0) {
-			TEST(sysctl(name, ARRAY_SIZE(name), 0, 0, osname, osnamelth));
-
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "call succeeded unexpectedly");
-			} else {
-				if (TEST_ERRNO == exp_eno) {
-					tst_resm(TPASS | TTERRNO,
-						 "Got expected error");
-				} else if (TEST_ERRNO == ENOSYS) {
-					tst_resm(TCONF,
-						 "You may need to make CONFIG_SYSCTL_SYSCALL=y"
-						 " to your kernel config.");
-				} else {
-					tst_resm(TFAIL | TTERRNO,
-						 "Got unexpected error");
-				}
-			}
-
-			cleanup();
-
-		} else {
-			/* wait for the child to finish */
-			wait(&status);
-		}
-
-		/* set process ID back to root */
-		SAFE_SETEUID(cleanup, 0);
-	}
-	cleanup();
-	tst_exit();
 }
 
-void setup(void)
+static void do_test(void)
 {
-	tst_require_root();
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-}
+	pid_t pid;
+	struct passwd *ltpuser;
 
-void cleanup(void)
-{
+	pid = SAFE_FORK();
+	if (!pid) {
+		ltpuser = SAFE_GETPWNAM("nobody");
+		SAFE_SETUID(ltpuser->pw_uid);
+		verify_sysctl();
+	} else {
+		SAFE_WAIT(NULL);
+		verify_sysctl();
+	}
 }
 
-#else
-int TST_TOTAL = 0;
-
-int main(void)
-{
-
-	tst_brkm(TCONF, NULL,
-		 "This test needs a kernel that has sysctl syscall.");
-}
-#endif
+static struct tst_test test = {
+	.needs_root = 1,
+	.forks_child = 1,
+	.setup = setup,
+	.test_all = do_test,
+};
-- 
1.8.3.1



