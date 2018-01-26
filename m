From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 26 Jan 2018 11:31:40 +0800
Subject: [LTP] [PATCH 4/4] syscalls/sysctl04,05: Enable && Cleanup
In-Reply-To: <1516937500-16475-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1516937500-16475-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1516937500-16475-4-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) Undefined __NR_sysctl always skips the test even though CONFIG_SYSCTL_SYSCALL
   is built, so enable it by correct __NR__sysctl.
2) Convert to new API.
3) Merge sysctl05 into sysctl04.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/ltplite                             |   1 -
 runtest/stress.part3                        |   1 -
 runtest/syscalls                            |   1 -
 testcases/kernel/syscalls/.gitignore        |   1 -
 testcases/kernel/syscalls/sysctl/sysctl04.c | 192 ++++++++-------------------
 testcases/kernel/syscalls/sysctl/sysctl05.c | 193 ----------------------------
 6 files changed, 51 insertions(+), 338 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/sysctl/sysctl05.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 5418495..49d2b11 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -915,7 +915,6 @@ sysconf01 sysconf01
 sysctl01 sysctl01
 sysctl03 sysctl03
 sysctl04 sysctl04
-sysctl05 sysctl05
 
 sysfs01 sysfs01
 sysfs02 sysfs02
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 242b696..004bbad 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -804,7 +804,6 @@ sysconf01 sysconf01
 sysctl01 sysctl01
 sysctl03 sysctl03
 sysctl04 sysctl04
-sysctl05 sysctl05
 
 sysfs01 sysfs01
 sysfs02 sysfs02
diff --git a/runtest/syscalls b/runtest/syscalls
index 2a4fad0..ca84c10 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1316,7 +1316,6 @@ sysconf01 sysconf01
 sysctl01 sysctl01
 sysctl03 sysctl03
 sysctl04 sysctl04
-sysctl05 sysctl05
 
 sysfs01 sysfs01
 sysfs02 sysfs02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 67211ca..684f5e7 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -1037,7 +1037,6 @@
 /sysctl/sysctl01
 /sysctl/sysctl03
 /sysctl/sysctl04
-/sysctl/sysctl05
 /sysfs/sysfs01
 /sysfs/sysfs02
 /sysfs/sysfs03
diff --git a/testcases/kernel/syscalls/sysctl/sysctl04.c b/testcases/kernel/syscalls/sysctl/sysctl04.c
index 6339bf2..dff61f8 100644
--- a/testcases/kernel/syscalls/sysctl/sysctl04.c
+++ b/testcases/kernel/syscalls/sysctl/sysctl04.c
@@ -1,166 +1,76 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 200i1
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
- *	sysctl04.c
- *
  * DESCRIPTION
- *	Testcase to check that sysctl(2) sets errno to ENOTDIR
- *
- * ALGORITHM
- *	1. Call sysctl(2) with sc_nlen set to 0, and expect ENOTDIR to be set.
- *	2. Call sysctl(2) with sc_nlen greater than CTL_MAXNAME, and expect
- *	   ENOTDIR to be set in the errno.
- *
- * USAGE:  <for command-line>
- *  sysctl04 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
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
- *	None
+ * 1) Call sysctl(2) with nlen set to 0, and expect ENOTDIR.
+ * 2) Call sysctl(2) with nlen greater than CTL_MAXNAME, and expect ENOTDIR.
+ * 3) Call sysctl(2) with the address of oldname outside the address space of
+ *    the process, and expect EFAULT.
+ * 4) Call sysctl(2) with the address of soldval outside the address space of
+ *    the process, and expect EFAULT.
  */
 
-#include "test.h"
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
 #include <linux/unistd.h>
 #include <linux/sysctl.h>
 
-char *TCID = "sysctl04";
-
-/* This is an older/deprecated syscall that newer arches are omitting */
-#ifdef __NR_sysctl
-
-int TST_TOTAL = 2;
+#include "tst_test.h"
+#include "lapi/syscalls.h"
 
-int sysctl(int *name, int nlen, void *oldval, size_t * oldlenp,
-	   void *newval, size_t newlen)
-{
-	struct __sysctl_args args =
-	    { name, nlen, oldval, oldlenp, newval, newlen };
-	return syscall(__NR__sysctl, &args);
-}
+static char osname[BUFSIZ];
+static size_t length = BUFSIZ;
 
-#define OSNAMESZ 100
-
-void setup(void);
-void cleanup(void);
-
-struct test_case_t {
-	int size;
-	int error;
+static struct test_case_t {
+	int name[2];
+	int nlen;
+	void *oldval;
+	size_t *oldlen;
+	int exp_err;
 } TC[] = {
-	/* comment goes here */
-	{
-	0, ENOTDIR},
-	    /* comment goes here */
-	{
-	CTL_MAXNAME + 1, ENOTDIR}
+	{{CTL_KERN, KERN_OSREV}, 0, osname, &length, ENOTDIR},
+	{{CTL_KERN, KERN_OSREV}, CTL_MAXNAME + 1, osname, &length, ENOTDIR},
+	{{CTL_KERN, KERN_OSRELEASE}, 2, (void *) -1, &length, EFAULT},
+	{{CTL_KERN, KERN_VERSION}, 2, osname, (void *) -1, EFAULT},
 };
 
-int main(int ac, char **av)
+static void verify_sysctl(unsigned int n)
 {
-	int lc;
-
-	char osname[OSNAMESZ];
-	int i;
-	size_t osnamelth;
-	int name[] = { CTL_KERN, KERN_OSREV };
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	osnamelth = sizeof(osname);
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		/* loop through the test cases */
-		for (i = 0; i < TST_TOTAL; i++) {
-
-			TEST(sysctl(name, 0, osname, &osnamelth, 0, 0));
-
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "call succeeded unexpectedly");
-				continue;
-			}
-
-			if (TEST_ERRNO == TC[i].error) {
-				tst_resm(TPASS, "expected failure - "
-					 "errno = %d : %s", TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			} else if (TEST_ERRNO == ENOSYS) {
-				tst_resm(TCONF,
-					 "You may need to make CONFIG_SYSCTL_SYSCALL=y"
-					 " to your kernel config.");
-			} else {
-				tst_resm(TFAIL, "unexpected error - %d : %s - "
-					 "expected %d", TEST_ERRNO,
-					 strerror(TEST_ERRNO), TC[i].error);
-			}
-		}
+	struct test_case_t *tc = &TC[n];
+	struct __sysctl_args args = {
+		.name = tc->name,
+		.nlen = tc->nlen,
+		.oldval = tc->oldval,
+		.oldlenp = tc->oldlen,
+	};
+
+	TEST(tst_syscall(__NR__sysctl, &args));
+	if (TEST_RETURN != -1) {
+		tst_res(TFAIL, "sysctl(2) succeeded unexpectedly");
+		return;
 	}
-	cleanup();
-
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
-}
-
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- */
-void cleanup(void)
-{
 
+	if (TEST_ERRNO == tc->exp_err)
+		tst_res(TPASS | TTERRNO, "Got expected error");
+	else
+		tst_res(TFAIL | TTERRNO, "Got unexpected error");
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
+	.tcnt = ARRAY_SIZE(TC),
+	.test = verify_sysctl,
+};
diff --git a/testcases/kernel/syscalls/sysctl/sysctl05.c b/testcases/kernel/syscalls/sysctl/sysctl05.c
deleted file mode 100644
index 85030e7..0000000
--- a/testcases/kernel/syscalls/sysctl/sysctl05.c
+++ /dev/null
@@ -1,193 +0,0 @@
-/*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
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
- */
-
-/*
- * NAME
- *	sysctl05.c
- *
- * DESCRIPTION
- *	Testcase to check that sysctl(2) sets errno to EFAULT
- *
- * ALGORITHM
- *	1. Call sysctl(2) with the address of sc_oldname outside the address
- *	   space of the process, and expect EFAULT.
- *	2. Call sysctl(2) with the address of sc_oldval outside the address
- *	   space of the process, and expect EFAULT.
- *
- * USAGE:  <for command-line>
- *  sysctl05 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
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
- *	None
- */
-
-#include "test.h"
-#include <stdio.h>
-#include <unistd.h>
-#include <linux/unistd.h>
-#include <linux/sysctl.h>
-#include <linux/version.h>
-#include <errno.h>
-
-char *TCID = "sysctl05";
-
-/* This is an older/deprecated syscall that newer arches are omitting */
-#ifdef __NR_sysctl
-
-int TST_TOTAL = 2;
-
-int sysctl(int *name, int nlen, void *oldval, size_t * oldlenp,
-	   void *newval, size_t newlen)
-{
-	struct __sysctl_args args =
-	    { name, nlen, oldval, oldlenp, newval, newlen };
-	return syscall(__NR__sysctl, &args);
-}
-
-char osname[BUFSIZ];
-size_t osnamelth;
-
-void setup(void);
-void cleanup(void);
-
-struct testcases {
-	char *desc;
-	int name[2];
-	int size;
-	void *oldval;
-	size_t *oldlen;
-	void *newval;
-	int newlen;
-	int (*cleanup) ();
-	int exp_retval;
-	int exp_errno;
-} testcases[] = {
-	{
-		"Test for EFAULT: invalid oldlen", {
-	CTL_KERN, KERN_OSRELEASE},
-		    2, osname, (void *)-1, NULL, 0, NULL, -1, EFAULT}, {
-		"Test for EFAULT: invalid oldval", {
-	CTL_KERN, KERN_VERSION},
-		    2, (void *)-1, &osnamelth, NULL, 0, NULL, -1, EFAULT}
-};
-
-#if !defined(UCLINUX)
-
-int main(int ac, char **av)
-{
-	int lc;
-	int i;
-	int ret = 0;
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
-			TEST(sysctl(testcases[i].name, testcases[i].size,
-				    testcases[i].oldval, testcases[i].oldlen,
-				    testcases[i].newval, testcases[i].newlen));
-
-			if (TEST_RETURN != testcases[i].exp_retval) {
-				tst_resm(TFAIL, "sysctl(2) returned unexpected "
-					 "retval, expected: %d, got: %d",
-					 testcases[i].exp_retval, ret);
-				continue;
-			}
-
-			if (TEST_ERRNO == ENOSYS) {
-				tst_resm(TCONF,
-					 "You may need to make CONFIG_SYSCTL_SYSCALL=y"
-					 " to your kernel config.");
-			} else if (TEST_ERRNO != testcases[i].exp_errno) {
-				tst_resm(TFAIL, "sysctl(2) returned unexpected "
-					 "errno, expected: %d, got: %d",
-					 testcases[i].exp_errno, errno);
-			} else {
-				tst_resm(TPASS, "sysctl(2) set errno correctly "
-					 "to %d", testcases[i].exp_errno);
-			}
-
-			if (testcases[i].cleanup) {
-				(void)testcases[i].cleanup();
-			}
-		}
-	}
-	cleanup();
-
-	tst_exit();
-}
-
-#else
-
-int main(void)
-{
-	tst_resm(TINFO, "test is not available on uClinux");
-	tst_exit();
-}
-
-#endif /* if !defined(UCLINUX) */
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
-}
-
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- */
-void cleanup(void)
-{
-
-}
-
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
-- 
1.8.3.1



