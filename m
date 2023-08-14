Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58479C001DB
	for <ltp@archiver.kernel.org>; Mon, 14 Aug 2023 11:31:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8BEDD3CCE37
	for <ltp@archiver.kernel.org>; Mon, 14 Aug 2023 13:31:43 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 93FF23C65F4
 for <ltp@lists.linux.it>; Mon, 14 Aug 2023 13:31:30 +0200 (CEST)
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com
 [207.54.90.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D2F2D20093E
 for <ltp@lists.linux.it>; Mon, 14 Aug 2023 13:31:29 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="127921051"
X-IronPort-AV: E=Sophos;i="6.01,172,1684767600"; d="scan'208";a="127921051"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2023 20:31:27 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id A7760D501A
 for <ltp@lists.linux.it>; Mon, 14 Aug 2023 20:31:24 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id F2ABCCFAB1
 for <ltp@lists.linux.it>; Mon, 14 Aug 2023 20:31:23 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 77BD170B2E;
 Mon, 14 Aug 2023 20:31:23 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Mon, 14 Aug 2023 19:30:48 +0800
Message-Id: <1692012648-1970-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1692012648-1970-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1692012648-1970-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27812.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27812.006
X-TMASE-Result: 10--14.939500-10.000000
X-TMASE-MatchedRID: UHPlrx36cywAzT8btdR146zGfgakLdjaCZa9cSpBObmkob0Y35+HFI3c
 eRXYSJoDIvrftAIhWmLP85tlrdTfE4+kj9iRsuif7TovvZPhLcB1zSnwpu89bft9kl8N0Ihcj3d
 ZSyALReJZZO2km095FRza9vQBPvMp2FMcgddyBa+RgPzABkqxIJ+Z30eyNnRTTPm/MsQarwOTwS
 +tHNykeFCEg9OsBDUFoWjx8y7f3ImcfX6Ug1yFMJUXYcPwQc2nOA3W7N7dBgnfc2Xd6VJ+yodG5
 Deyz2OttFyW7k8xSBFS4pfvQyHLzGj+Msn9Q6VoqNtC2YatSIlpkBMYDn8FeE2q2vj1g2Nh4Wj9
 iaClAkk4Bt3LKju+riXHp1pX6kfOCtNdSL7NMxQF7cpFXK76TReK/B+WKxKsvlNWrA7PGPyg6SD
 UFo25mqsislIb+lkwoWjx8y7f3InSJlb/fq4fiqz+FzWjUOLzfrTt+hmA5bKMltxkB8Rw01sraq
 YpRpfWRAP285T1SE41wOHlbbYzTQlEXXe75zyCi95/KnWCU3Q217sBakpdK33lj93joBiubWqU+
 jtUG9Mqtq5d3cxkNUhQ9pL/1/Lzz4MJY7Stj4kI2VmCkd9zAn8dEvpWbRtSXBv9skmsTTI=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/3] syscalls/setgroups03: Convert to new API
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1737529510=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1737529510==
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit

1.merge setgroups04 to setgroups03
2.use safe_macro macro

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                              |   2 -
 .../kernel/syscalls/setgroups/.gitignore      |   2 -
 .../kernel/syscalls/setgroups/setgroups03.c   | 247 ++++--------------
 .../kernel/syscalls/setgroups/setgroups04.c   | 163 ------------
 4 files changed, 56 insertions(+), 358 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/setgroups/setgroups04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 1028e45fc..119710d63 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1331,8 +1331,6 @@ setgroups02 setgroups02
 setgroups02_16 setgroups02_16
 setgroups03 setgroups03
 setgroups03_16 setgroups03_16
-setgroups04 setgroups04
-setgroups04_16 setgroups04_16
 
 sethostname01 sethostname01
 sethostname02 sethostname02
diff --git a/testcases/kernel/syscalls/setgroups/.gitignore b/testcases/kernel/syscalls/setgroups/.gitignore
index 0649a3425..9de928241 100644
--- a/testcases/kernel/syscalls/setgroups/.gitignore
+++ b/testcases/kernel/syscalls/setgroups/.gitignore
@@ -4,5 +4,3 @@
 /setgroups02_16
 /setgroups03
 /setgroups03_16
-/setgroups04
-/setgroups04_16
diff --git a/testcases/kernel/syscalls/setgroups/setgroups03.c b/testcases/kernel/syscalls/setgroups/setgroups03.c
index 490b06996..d0331b216 100644
--- a/testcases/kernel/syscalls/setgroups/setgroups03.c
+++ b/testcases/kernel/syscalls/setgroups/setgroups03.c
@@ -1,222 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
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
+ * Copyright (C) Bull S.A. 2001
+ * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) Linux Test Project, 2003-2023
+ * 07/2001 Ported by Wayne Boyer
+ * 05/2002 Ported by AndrĂ© Merlier
  */
 
-/*
- * Test Name: setgroups03
- *
- * Test Description:
- *  Verify that,
- *   1. setgroups() fails with -1 and sets errno to EINVAL if the size
- *      argument value is > NGROUPS
- *   2. setgroups() fails with -1 and sets errno to EPERM if the
- *	calling process is not super-user.
+/*\
+ * [Description]
  *
- * Expected Result:
- *  setgroups() should fail with return value -1 and set expected errno.
+ * Test for EINVAL, EPERM, EFAULT errors.
  *
- * Algorithm:
- *  Setup:
- *   Setup signal handling.
- *   Pause for SIGUSR1 if option specified.
+ * - setgroups() fails with EINVAL if the size argument value is > NGROUPS.
  *
- *  Test:
- *   Loop if the proper options are given.
- *   Execute system call
- *   Check return code, if system call failed (return=-1)
- *   	if errno set == expected errno
- *   		Issue sys call fails with expected return value and errno.
- *   	Otherwise,
- *		Issue sys call fails with unexpected errno.
- *   Otherwise,
- *	Issue sys call returns unexpected value.
- *
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
- *
- * Usage:  <for command-line>
- *  setgroups03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS:
- *  This test should be executed by 'non-super-user' only.
+ * - setgroups() fails with EPERM if the calling process is not super-user.
  *
+ * - setgroups() fails with EFAULT if the list has an invalid address.
  */
-#include <limits.h>
-#include <sys/types.h>
-#include <unistd.h>
-#include <errno.h>
-#include <pwd.h>
-#include <grp.h>
 
-#include "test.h"
+#include <pwd.h>
+#include <stdlib.h>
 
-#include "compat_16.h"
+#include "tst_test.h"
+#include "compat_tst_16.h"
 
 #define TESTUSER	"nobody"
 
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
-
-TCID_DEFINE(setgroups03);
-int TST_TOTAL = 2;
-
-GID_T *groups_list;		/* Array to hold gids for getgroups() */
+static GID_T *glist1, *glist2, *glist3;
+static struct passwd *user_info;
 
-int setup1();			/* setup function to test error EPERM */
-void setup();			/* setup function for the test */
-void cleanup();			/* cleanup function for the test */
-
-struct test_case_t {		/* test case struct. to hold ref. test cond's */
-	size_t gsize_add;
-	int list;
-	char *desc;
+static struct tcase {
+	int gsize;
+	GID_T **glist;
 	int exp_errno;
-	int (*setupfunc) ();
-} Test_cases[] = {
-	{
-	1, 1, "Size is > sysconf(_SC_NGROUPS_MAX)", EINVAL, NULL}, {
-	0, 2, "Permission denied, not super-user", EPERM, setup1}
+} tcases[] = {
+	{NGROUPS + 1, &glist1, EINVAL},
+	{NGROUPS, &glist2, EPERM},
+	{NGROUPS, &glist3, EFAULT},
 };
 
-int main(int ac, char **av)
+static void verify_setgroups(unsigned int i)
 {
-	int lc;
-	int gidsetsize;		/* total no. of groups */
-	int i;
-	char *test_desc;	/* test specific error message */
-	int ngroups_max = sysconf(_SC_NGROUPS_MAX);	/* max no. of groups in the current system */
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	groups_list = malloc(ngroups_max * sizeof(GID_T));
-	if (groups_list == NULL) {
-		tst_brkm(TBROK, NULL, "malloc failed to alloc %zu errno "
-			 " %d ", ngroups_max * sizeof(GID_T), errno);
-	}
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
-			if (Test_cases[i].setupfunc != NULL) {
-				Test_cases[i].setupfunc();
-			}
+	struct tcase *tc = &tcases[i];
 
-			gidsetsize = ngroups_max + Test_cases[i].gsize_add;
-			test_desc = Test_cases[i].desc;
+	if (tc->exp_errno == EPERM)
+		SAFE_SETEUID(user_info->pw_uid);
 
-			/*
-			 * Call setgroups() to test different test conditions
-			 * verify that it fails with -1 return value and
-			 * sets appropriate errno.
-			 */
-			TEST(SETGROUPS(cleanup, gidsetsize, groups_list));
+	TST_EXP_FAIL(SETGROUPS(tc->gsize, *tc->glist), tc->exp_errno,
+		     "setgroups(%d, groups_list)", tc->gsize);
 
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "setgroups(%d) returned %ld, "
-					 "expected -1, errno=%d", gidsetsize,
-					 TEST_RETURN, Test_cases[i].exp_errno);
-				continue;
-			}
-
-			if (TEST_ERRNO == Test_cases[i].exp_errno) {
-				tst_resm(TPASS,
-					 "setgroups(%d) fails, %s, errno=%d",
-					 gidsetsize, test_desc, TEST_ERRNO);
-			} else {
-				tst_resm(TFAIL, "setgroups(%d) fails, %s, "
-					 "errno=%d, expected errno=%d",
-					 gidsetsize, test_desc, TEST_ERRNO,
-					 Test_cases[i].exp_errno);
-			}
-		}
-
-	}
-
-	cleanup();
-
-	tst_exit();
+	if (tc->exp_errno == EPERM)
+		SAFE_SETEUID(0);
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- *
- *  Call individual test specific setup functions.
- */
-void setup(void)
+static void setup(void)
 {
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	glist1 = SAFE_MALLOC((NGROUPS + 1) * sizeof(GID_T));
 
-	TEST_PAUSE;
+	user_info = SAFE_GETPWNAM(TESTUSER);
+	GID16_CHECK(user_info->pw_gid, getpwnam);
+	glist2 = (GID_T *)&(user_info->pw_gid);
 
+	glist3 = tst_get_bad_addr(NULL);
 }
 
-/*
- * setup1 -  Setup function to test setgroups() which returns -1
- *	     and sets errno to EPERM.
- *
- *  Get the user info. from /etc/passwd file.
- *  This function returns 0 on success.
- */
-int setup1(void)
+static void cleanup(void)
 {
-	struct passwd *user_info;	/* struct. to hold test user info */
-
-/* Switch to nobody user for correct error code collection */
-	ltpuser = getpwnam(nobody_uid);
-	if (seteuid(ltpuser->pw_uid) == -1) {
-		tst_resm(TINFO, "setreuid failed to "
-			 "to set the effective uid to %d", ltpuser->pw_uid);
-		perror("setreuid");
-	}
-
-	if ((user_info = getpwnam(TESTUSER)) == NULL) {
-		tst_brkm(TFAIL, cleanup, "getpwnam(2) of %s Failed", TESTUSER);
-	}
-
-	if (!GID_SIZE_CHECK(user_info->pw_gid)) {
-		tst_brkm(TBROK,
-			 cleanup,
-			 "gid returned from getpwnam is too large for testing setgroups16");
-	}
-	groups_list[0] = user_info->pw_gid;
-	return 0;
+	if (glist1)
+		free(glist1);
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- */
-void cleanup(void)
-{
-
-}
+static struct tst_test test = {
+	.test = verify_setgroups,
+	.tcnt = ARRAY_SIZE(tcases),
+	.bufs = (struct tst_buffers []) {
+		{&glist1, .size = sizeof(GID_T)},
+		{&glist2, .size = sizeof(GID_T)},
+		{&glist3, .size = sizeof(GID_T)},
+		{&user_info, .size = sizeof(struct passwd)},
+		{},
+	},
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+};
diff --git a/testcases/kernel/syscalls/setgroups/setgroups04.c b/testcases/kernel/syscalls/setgroups/setgroups04.c
deleted file mode 100644
index 971c86bd2..000000000
--- a/testcases/kernel/syscalls/setgroups/setgroups04.c
+++ /dev/null
@@ -1,163 +0,0 @@
-/*
- *   Copyright (C) Bull S.A. 2001
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
- * Test Name: setgroups04
- *
- * Test Description:
- *  Verify that, setgroups() fails with -1 and sets errno to EFAULT if the list has an invalid address.
- *
- * Expected Result:
- *  setgroups() should fail with return value -1 and set expected errno.
- *
- * Algorithm:
- *  Setup:
- *   Setup signal handling.
- *   Pause for SIGUSR1 if option specified.
- *
- *  Test:
- *   Loop if the proper options are given.
- *   Execute system call
- *   Check return code, if system call failed (return=-1)
- *   	if errno set == expected errno
- *   		Issue sys call fails with expected return value and errno.
- *   	Otherwise,
- *		Issue sys call fails with unexpected errno.
- *   Otherwise,
- *	Issue sys call returns unexpected value.
- *
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
- *
- * Usage:  <for command-line>
- *  setgroups04 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	05/2002 Ported by Andr� Merlier
- *
- * RESTRICTIONS:
- *  none.
- *
- */
-#include <sys/types.h>
-#include <sys/param.h>
-#include <unistd.h>
-#include <errno.h>
-#include <pwd.h>
-#include <grp.h>
-
-#include "test.h"
-
-#include "compat_16.h"
-
-TCID_DEFINE(setgroups04);
-int TST_TOTAL = 1;
-
-GID_T groups_list[NGROUPS];
-
-void setup();			/* setup function for the test */
-void cleanup();			/* cleanup function for the test */
-
-#if !defined(UCLINUX)
-
-int main(int ac, char **av)
-{
-	int lc;
-	int gidsetsize;		/* total no. of groups */
-	char *test_desc;	/* test specific error message */
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	/* Perform setup for test */
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		gidsetsize = NGROUPS;
-		test_desc = "EFAULT";
-
-		/*
-		 * Call setgroups() to test condition
-		 * verify that it fails with -1 return value and
-		 * sets appropriate errno.
-		 */
-		TEST(SETGROUPS(cleanup, gidsetsize, sbrk(0)));
-
-		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "setgroups() returned %ld, "
-				 "expected -1, errno=%d", TEST_RETURN,
-				 EFAULT);
-		} else {
-
-			if (TEST_ERRNO == EFAULT) {
-				tst_resm(TPASS,
-					 "setgroups() fails with expected "
-					 "error EFAULT errno:%d", TEST_ERRNO);
-			} else {
-				tst_resm(TFAIL, "setgroups() fails, %s, "
-					 "errno=%d, expected errno=%d",
-					 test_desc, TEST_ERRNO, EFAULT);
-			}
-		}
-
-	}
-
-	cleanup();
-	tst_exit();
-
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
- * setup()
- */
-void setup(void)
-{
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-}
-
-/*
- * cleanup()
- */
-void cleanup(void)
-{
-
-}
-- 
2.39.1


--===============1737529510==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1737529510==--
