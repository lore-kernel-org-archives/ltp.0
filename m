Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C4BEB64DA
	for <ltp@archiver.kernel.org>; Wed, 19 Jul 2023 10:00:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A44E73CB0DA
	for <ltp@archiver.kernel.org>; Wed, 19 Jul 2023 12:00:28 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C9AF93CD7BD
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 11:59:51 +0200 (CEST)
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com
 [139.138.36.223])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7DBB61A00E78
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 11:59:50 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="113314152"
X-IronPort-AV: E=Sophos;i="6.01,216,1684767600"; d="scan'208";a="113314152"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2023 18:59:49 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 275C7D29E5
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 18:59:47 +0900 (JST)
Received: from aks-ab2.gw.nic.fujitsu.com (aks-ab2.gw.nic.fujitsu.com
 [192.51.207.12])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 45EEED5017
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 18:59:46 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by aks-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id 7E3D986F10;
 Wed, 19 Jul 2023 18:59:45 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Wed, 19 Jul 2023 17:59:16 +0800
Message-Id: <1689760756-865-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1689760756-865-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1689760756-865-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27760.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27760.006
X-TMASE-Result: 10--15.891500-10.000000
X-TMASE-MatchedRID: FZCdsg6QV/gwRe7LbjTDMbnHu4BcYSmtlwT0XposETW+f7ap9DJaDb8F
 Hrw7frluf146W0iUu2sZhhkmdi0+GY+kj9iRsuif7TovvZPhLcB1zSnwpu89bft9kl8N0Ihcj3d
 ZSyALReJZZO2km095FRza9vQBPvMp2FMcgddyBa+RgPzABkqxIJ+Z30eyNnRTTPm/MsQarwO+Yp
 N3FsaosrX80TaNz00Ya+2/ArDz7UE7K/upbxRpcsQ4mpKyfkqZBGvINcfHqhcli8Y5a0svLxduD
 +Mmm6Q2gC3FH2GME0bQsefS5WLXUwD+B72U7cPskCThXPqsqitmBQnSpa7MZ3QWhLVqLFM1GDgw
 bW2mvUnu0B/FdumjzomOtzN0vuEC0MWGhVp0M3FtN2GsBybzwvlSepWcgdLP6Mw4RnkAvRKsjtK
 TB43968E7g37/WNVyS71vrLFKyHdDQYe+1GQPNV2FnJp+A+KrdMgI4ShLsETfUY2boz4kpMNG97
 DfmZl7F3HVowaEntRHMt8ySqQ9KY0GdWKgGbBhi95/KnWCU3T9dtnJpUGwcdYUIz+YZAib0DgaR
 5Nqry/nzlXMYw4XMD3Al4zalJpFvECLuM+h4RB+3BndfXUhXQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] syscalls/getgroups03: Convert to new API
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
Content-Type: multipart/mixed; boundary="===============1333745384=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1333745384==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

1.merge setgroups04 to setgroups03
2.use safe_macro macro

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                                  |   2 -
 testcases/kernel/syscalls/setgroups/.gitignore    |   2 -
 testcases/kernel/syscalls/setgroups/setgroups03.c | 251 ++++++----------------
 testcases/kernel/syscalls/setgroups/setgroups04.c | 163 --------------
 4 files changed, 61 insertions(+), 357 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/setgroups/setgroups04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index b291511..150ddbd 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1325,8 +1325,6 @@ setgroups02 setgroups02
 setgroups02_16 setgroups02_16
 setgroups03 setgroups03
 setgroups03_16 setgroups03_16
-setgroups04 setgroups04
-setgroups04_16 setgroups04_16
 
 sethostname01 sethostname01
 sethostname02 sethostname02
diff --git a/testcases/kernel/syscalls/setgroups/.gitignore b/testcases/kernel/syscalls/setgroups/.gitignore
index 0649a34..9de9282 100644
--- a/testcases/kernel/syscalls/setgroups/.gitignore
+++ b/testcases/kernel/syscalls/setgroups/.gitignore
@@ -4,5 +4,3 @@
 /setgroups02_16
 /setgroups03
 /setgroups03_16
-/setgroups04
-/setgroups04_16
diff --git a/testcases/kernel/syscalls/setgroups/setgroups03.c b/testcases/kernel/syscalls/setgroups/setgroups03.c
index 490b069..c12d612 100644
--- a/testcases/kernel/syscalls/setgroups/setgroups03.c
+++ b/testcases/kernel/syscalls/setgroups/setgroups03.c
@@ -1,222 +1,93 @@
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
+ * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) Linux Test Project, 2003-2023
+ * 07/2001 Ported by Wayne Boyer
+ * 05/2002 Ported by AndrÃ© Merlier
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
- *
- * Expected Result:
- *  setgroups() should fail with return value -1 and set expected errno.
- *
- * Algorithm:
- *  Setup:
- *   Setup signal handling.
- *   Pause for SIGUSR1 if option specified.
+/*\
+ * [Description]
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
+ * Test for EINVAL, EPERM, EFAULT errors.
  *
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
+ * 1) setgroups() fails with EINVAL if the size argument value is > NGROUPS.
  *
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
+ * 2) setgroups() fails with EPERM if the calling process is not super-user.
  *
+ * 3) setgroups() fails with EFAULT if the list has an invalid address.
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
+static GID_T *glist1, *glist2, *glist3;
 
-TCID_DEFINE(setgroups03);
-int TST_TOTAL = 2;
+static struct tcase {
+	int gsize;
+	GID_T **glist;
+	int exp_errno;
+} tcases[] = {
+	{NGROUPS + 1, &glist1, EINVAL},
+	{NGROUPS, &glist2, EPERM},
+	{NGROUPS, &glist3, EFAULT},
+};
 
-GID_T *groups_list;		/* Array to hold gids for getgroups() */
+static void change_uid(void)
+{
+	struct passwd *ltpuser, *user_info;
 
-int setup1();			/* setup function to test error EPERM */
-void setup();			/* setup function for the test */
-void cleanup();			/* cleanup function for the test */
+	ltpuser = SAFE_GETPWNAM(TESTUSER);
+	SAFE_SETEUID(ltpuser->pw_uid);
 
-struct test_case_t {		/* test case struct. to hold ref. test cond's */
-	size_t gsize_add;
-	int list;
-	char *desc;
-	int exp_errno;
-	int (*setupfunc) ();
-} Test_cases[] = {
-	{
-	1, 1, "Size is > sysconf(_SC_NGROUPS_MAX)", EINVAL, NULL}, {
-	0, 2, "Permission denied, not super-user", EPERM, setup1}
-};
+	user_info = SAFE_GETPWNAM(TESTUSER);
+	GID16_CHECK(user_info->pw_gid, getpwnam);
+	glist2 = (GID_T *)&(user_info->pw_gid);
+}
 
-int main(int ac, char **av)
+static void restore_uid(void)
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
-
-			gidsetsize = ngroups_max + Test_cases[i].gsize_add;
-			test_desc = Test_cases[i].desc;
-
-			/*
-			 * Call setgroups() to test different test conditions
-			 * verify that it fails with -1 return value and
-			 * sets appropriate errno.
-			 */
-			TEST(SETGROUPS(cleanup, gidsetsize, groups_list));
-
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
+	struct passwd *root_info;
+
+	root_info = SAFE_GETPWNAM("root");
+	SAFE_SETEUID(root_info->pw_uid);
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- *
- *  Call individual test specific setup functions.
- */
-void setup(void)
+static void verify_setgroups(unsigned int i)
 {
-	tst_require_root();
+	struct tcase *tc = &tcases[i];
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	if (tc->exp_errno == EPERM)
+		change_uid();
 
-	TEST_PAUSE;
+	TST_EXP_FAIL(SETGROUPS(tc->gsize, *tc->glist), tc->exp_errno,
+		     "setgroups(%d, groups_list)", tc->gsize);
 
+	if (tc->exp_errno == EPERM)
+		restore_uid();
 }
 
-/*
- * setup1 -  Setup function to test setgroups() which returns -1
- *	     and sets errno to EPERM.
- *
- *  Get the user info. from /etc/passwd file.
- *  This function returns 0 on success.
- */
-int setup1(void)
+static void setup(void)
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
+	glist1 = SAFE_MALLOC(NGROUPS * sizeof(GID_T));
+	glist3 = sbrk(0);
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- */
-void cleanup(void)
+static void cleanup(void)
 {
-
+	if (glist1)
+		free(glist1);
 }
+
+static struct tst_test test = {
+	.test = verify_setgroups,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+};
diff --git a/testcases/kernel/syscalls/setgroups/setgroups04.c b/testcases/kernel/syscalls/setgroups/setgroups04.c
deleted file mode 100644
index 971c86b..0000000
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
- *	05/2002 Ported by André Merlier
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
1.8.3.1


--===============1333745384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1333745384==--
