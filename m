From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 26 Jan 2018 11:31:38 +0800
Subject: [LTP] [PATCH 2/4] syscalls/sysctl01: Enable && Cleanup
In-Reply-To: <1516937500-16475-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1516937500-16475-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1516937500-16475-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) Undefined __NR_sysctl always skips the test even though CONFIG_SYSCTL_SYSCALL
   is built, so enable it by correct __NR__sysctl.
2) Convert to new API.
3) Fix compiler warnings.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/sysctl/sysctl01.c | 224 +++++++---------------------
 1 file changed, 57 insertions(+), 167 deletions(-)

diff --git a/testcases/kernel/syscalls/sysctl/sysctl01.c b/testcases/kernel/syscalls/sysctl/sysctl01.c
index c423f47..0a684d0 100644
--- a/testcases/kernel/syscalls/sysctl/sysctl01.c
+++ b/testcases/kernel/syscalls/sysctl/sysctl01.c
@@ -1,196 +1,86 @@
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
- *	sysctl01.c
- *
- * DESCRIPTION
- *	Testcase for testing the basic functionality of sysctl(2) system call.
- *	This testcase attempts to read the kernel parameters using
- *	sysctl({CTL_KERN, KERN_* }, ...) and compares it with the known
- *	values.
- *
- * USAGE:  <for command-line>
- *  sysctl01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- *	None
+ * DESCRIPTION:
+ * Testcase for testing the basic functionality of sysctl(2) system call.
+ * This testcase attempts to read the kernel parameters by using
+ * sysctl({CTL_KERN, KERN_* }, ...) and compares it with the known values.
  */
-#include "test.h"
-#include <stdio.h>
+
 #include <errno.h>
-#include <unistd.h>
+#include <stdio.h>
+#include <string.h>
 #include <linux/version.h>
 #include <sys/utsname.h>
 #include <linux/unistd.h>
 #include <linux/sysctl.h>
 
-char *TCID = "sysctl01";
-
-/* This is an older/deprecated syscall that newer arches are omitting */
-#ifdef __NR_sysctl
-
-int TST_TOTAL = 3;
+#include "tst_test.h"
+#include "lapi/syscalls.h"
 
-static int sysctl(int *name, int nlen, void *oldval, size_t * oldlenp,
-		  void *newval, size_t newlen)
-{
-	struct __sysctl_args args =
-	    { name, nlen, oldval, oldlenp, newval, newlen };
-	return syscall(__NR__sysctl, &args);
-}
-
-struct utsname buf;
-char osname[BUFSIZ];
-size_t osnamelth;
+static struct utsname buf;
 
-void setup(void);
-void cleanup(void);
-
-struct test_case_t {
+static struct test_case_t {
 	char *desc;
 	int name[2];
-	int size;
-	char *oldval;
-	size_t *oldlen;
-	void *newval;
-	int newlen;
-	int (*cleanup) ();
-	int exp_retval;
+	char *cmp_str;
 } TC[] = {
-	{
-		"Test for KERN_OSTYPE", {
-	CTL_KERN, KERN_OSTYPE}, 2, osname, &osnamelth, NULL, 0, NULL, 0}, {
-		"Test for KERN_OSRELEASE", {
-	CTL_KERN, KERN_OSRELEASE}, 2,
-		    osname, &osnamelth, NULL, 0, NULL, 0}, {
-		"Test for KERN_VERSION", {
-	CTL_KERN, KERN_VERSION}, 2, osname, &osnamelth, NULL, 0, NULL, 0}
+	{"KERN_OSTYPE", {CTL_KERN, KERN_OSTYPE}, buf.sysname},
+	{"KERN_OSRELEASE", {CTL_KERN, KERN_OSRELEASE}, buf.release},
+	{"KERN_VERSION", {CTL_KERN, KERN_VERSION}, buf.version},
 };
 
-int main(int ac, char **av)
+static void verify_sysctl(unsigned int n)
 {
-	int lc;
-	int i;
-	char *comp_string;
-
-	comp_string = NULL;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; ++i) {
-
-			osnamelth = sizeof(osname);
-
-			switch (i) {
-			case 0:
-				comp_string = buf.sysname;
-				break;
-			case 1:
-				comp_string = buf.release;
-				break;
-			case 2:
-				comp_string = buf.version;
-				break;
-			}
-
-			TEST(sysctl(TC[i].name, TC[i].size, TC[i].oldval,
-				    TC[i].oldlen, TC[i].newval, TC[i].newlen));
-
-			if (TEST_RETURN != 0) {
-				if (TEST_ERRNO == ENOSYS) {
-					tst_resm(TCONF,
-						 "You may need to make CONFIG_SYSCTL_SYSCALL=y"
-						 " to your kernel config.");
-				} else {
-					tst_resm(TFAIL,
-						 "sysctl(2) failed unexpectedly "
-						 "errno:%d", TEST_ERRNO);
-				}
-				continue;
-			}
-
-			if (strcmp(TC[i].oldval, comp_string) != 0) {
-				tst_resm(TFAIL, "strings don't match - %s : %s",
-					 TC[i].oldval, comp_string);
-			} else {
-				tst_resm(TPASS, "%s is correct", TC[i].desc);
-			}
-			if (TC[i].cleanup) {
-				(void)TC[i].cleanup();
-			}
-		}
+	char osname[BUFSIZ];
+	size_t length = BUFSIZ;
+	struct test_case_t *tc = &TC[n];
+
+	memset(osname, 0, BUFSIZ);
+
+	struct __sysctl_args args = {
+		.name = tc->name,
+		.nlen = ARRAY_SIZE(tc->name),
+		.oldval = osname,
+		.oldlenp = &length,
+	};
+
+	TEST(tst_syscall(__NR__sysctl, &args));
+	if (TEST_RETURN != 0) {
+		tst_res(TFAIL | TTERRNO, "sysctl() failed unexpectedly");
+		return;
 	}
 
-	cleanup();
-	tst_exit();
-}
-
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
-{
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	/* get kernel name and information */
-	if (uname(&buf) == -1) {
-		tst_brkm(TBROK, cleanup, "uname() failed");
+	if (strcmp(osname, tc->cmp_str)) {
+		tst_res(TFAIL, "Strings don't match %s : %s",
+			osname, tc->cmp_str);
+	} else {
+		tst_res(TPASS, "Test for %s is correct", tc->desc);
 	}
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- */
-void cleanup(void)
+static void setup(void)
 {
-
+	/* get kernel name and information */
+	if (uname(&buf) == -1)
+		tst_brk(TBROK | TERRNO, "uname() failed");
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
+	.setup = setup,
+	.tcnt = ARRAY_SIZE(TC),
+	.test = verify_sysctl,
+};
-- 
1.8.3.1



