Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B5AC6FD1D
	for <ltp@archiver.kernel.org>; Mon, 20 Mar 2023 06:31:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6479B3CCC4E
	for <ltp@archiver.kernel.org>; Mon, 20 Mar 2023 07:31:21 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E109D3CCD08
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 07:31:03 +0100 (CET)
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com
 [195.245.230.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0C1176005CE
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 07:31:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1679293861; i=@fujitsu.com;
 bh=7/PNSiKoucwdc4h2hJW3ym+Xg5A9iVsCaXIWBoT+I30=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=Gf6eppQlFo0ndNvILKNBLn9ACSh4Ovvb1e39jxlpu0OrqUpZpzKiBzV1gBJdnKWcE
 FAhKgTHDch+Vqk30hKHg9ZQ6N/HuaHl2IOvvJT6ZLf8ut5jOgi99mrH+e6CfXqA1HI
 Zzzg+GIUyT3XbZKzmtLOizI0goUVceIPy0hvIpUKoB5xTt+6O+Chz0SuK5qw+rII5q
 /T0t/owYMPR/fGjCGCQz3zCwsNjbECcO175Mqx6V+LJhGgwb6G9PcApW4x7kkWrWCd
 0XNNtJGcZWtGynYOXahBmPy0+qrXy5f3yXIJvMK428inEeXv0jHTsfZ0nobGUXj30t
 vQmBpEFxWaYTg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRWlGSWpSXmKPExsViZ8ORqLvkr3i
 KwYFjihYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8ap6VOYC3Y3MFbMfvSdpYGxOa2LkYtDSOAs
 o8TC++fYIJwDTBKfdjUyQzh7GSV61qwBcjg52AQ0JZ51LgCzRQQkJDoa3rKD2MwC6hLLJ/1iA
 rGFBWwlDq44yQZiswioSkxsew5Uw8HBK+ApsWtiAkhYQkBBYsrD92BjOAW8JHa9+wFmCwGVHL
 v6C6yVV0BQ4uTMJywQ4yUkDr54wQzRqyTR1nqFFcKukGicfogJwlaTuHpuE/MERsFZSNpnIWl
 fwMi0itGsOLWoLLVI19BAL6koMz2jJDcxM0cvsUo3US+1VLc8tbhE11AvsbxYL7W4WK+4Mjc5
 J0UvL7VkEyMwfFOKGZN3MF7t+6t3iFGSg0lJlPf4G/EUIb6k/JTKjMTijPii0pzU4kOMMhwcS
 hK8R38B5QSLUtNTK9Iyc4CxBJOW4OBREuG1/gSU5i0uSMwtzkyHSJ1iVJQS5/3/GyghAJLIKM
 2Da4PF7yVGWSlhXkYGBgYhnoLUotzMElT5V4ziHIxKwrwfQabwZOaVwE1/BbSYCWjx/UkiIIt
 LEhFSUg1MvbVB8k933kiTSokwK0q2erNywYW5nDy83+ZzbTmxufTb0/tGliW6pmlm1zUMrrzz
 3Scecy/q8Kbmnx8/Rv+Z29tU8MPwg0ioT+zehAfXp509xmCzIcD8wNtvV1cwnTzk+SHKf2m17
 sRendDpb8/LljBN4y5pPqf2588dHVsh+VWzlwf3TNXTdrM7Y6q3/LiNRbjUxoNLTu80b6tcFl
 Lvq1V0q+617tQP7x5EnklX99O+W3PO14zFO2KbGfulJp+JjgZMJtNu1ls/3Cq7etLy7S1eNr8
 tnCYbsy+/K3NfS7945roMjbXeOlw/FN9FVX2cU7joQeSmXt6bDPkR3r3ccpfYtj+61cgl0rHl
 5bYyJZbijERDLeai4kQAZDPs9loDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-11.tower-585.messagelabs.com!1679293860!161281!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 15172 invoked from network); 20 Mar 2023 06:31:00 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-11.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 20 Mar 2023 06:31:00 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 27D401001A6
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 06:31:00 +0000 (GMT)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121
 [10.183.43.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 257CC1001A3
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 06:31:00 +0000 (GMT)
Received: from localhost.localdomain (10.167.215.131) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Mon, 20 Mar 2023 06:30:58 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 20 Mar 2023 14:30:20 +0800
Message-ID: <1679293822-19378-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1679293822-19378-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1679293822-19378-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.215.131]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/4] ipc/semget02,03,06: Convert into new api
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged semget03.c and semget06.c into semget02.c.

Also use SEMMSL macro instead of 32000 and add EINVAL
error test when key exists but nsems is larger than old.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                              |   2 -
 runtest/syscalls-ipc                          |   2 -
 .../kernel/syscalls/ipc/semget/.gitignore     |   2 -
 testcases/kernel/syscalls/ipc/semget/Makefile |   4 +-
 .../kernel/syscalls/ipc/semget/semget02.c     | 221 +++++++-----------
 .../kernel/syscalls/ipc/semget/semget03.c     | 133 -----------
 .../kernel/syscalls/ipc/semget/semget06.c     | 143 ------------
 7 files changed, 81 insertions(+), 426 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/ipc/semget/semget03.c
 delete mode 100644 testcases/kernel/syscalls/ipc/semget/semget06.c

diff --git a/runtest/syscalls b/runtest/syscalls
index b9d4a43c8..9c96f57f7 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1237,9 +1237,7 @@ semctl09 semctl09
 
 semget01 semget01
 semget02 semget02
-semget03 semget03
 semget05 semget05
-semget06 semget06
 
 semop01 semop01
 semop02 semop02
diff --git a/runtest/syscalls-ipc b/runtest/syscalls-ipc
index b758158c3..df41140a7 100644
--- a/runtest/syscalls-ipc
+++ b/runtest/syscalls-ipc
@@ -41,9 +41,7 @@ semctl09 semctl09
 
 semget01 semget01
 semget02 semget02
-semget03 semget03
 semget05 semget05
-semget06 semget06
 
 semop01 semop01
 semop02 semop02
diff --git a/testcases/kernel/syscalls/ipc/semget/.gitignore b/testcases/kernel/syscalls/ipc/semget/.gitignore
index ce26c93b0..4519b30d2 100644
--- a/testcases/kernel/syscalls/ipc/semget/.gitignore
+++ b/testcases/kernel/syscalls/ipc/semget/.gitignore
@@ -1,5 +1,3 @@
 /semget01
 /semget02
-/semget03
 /semget05
-/semget06
diff --git a/testcases/kernel/syscalls/ipc/semget/Makefile b/testcases/kernel/syscalls/ipc/semget/Makefile
index c41744764..2f98c36ca 100644
--- a/testcases/kernel/syscalls/ipc/semget/Makefile
+++ b/testcases/kernel/syscalls/ipc/semget/Makefile
@@ -7,7 +7,7 @@ LTPLIBS = ltpipc ltpnewipc
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-semget01: LTPLDLIBS = -lltpnewipc
-semget02 semget03 semget04 semget05 semget06: LTPLDLIBS = -lltpipc
+semget01 semget02: LTPLDLIBS = -lltpnewipc
+semget05: LTPLDLIBS = -lltpipc
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/semget/semget02.c b/testcases/kernel/syscalls/ipc/semget/semget02.c
index 4124514c2..4273c84c7 100644
--- a/testcases/kernel/syscalls/ipc/semget/semget02.c
+++ b/testcases/kernel/syscalls/ipc/semget/semget02.c
@@ -1,165 +1,102 @@
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
+ * Copyright (c) International Business Machines Corp., 2001
  */
 
-/*
- * NAME
- *	semget02.c
+/*\
+ * [Description]
  *
- * DESCRIPTION
- *	semget02 - test for EACCES and EEXIST errors
+ * This basic error handing of the semget syscall.
  *
- * ALGORITHM
- *	create a semaphore set without read or alter permissions
- *	loop if that option was specified
- *	call semget() using two different invalid cases
- *	check the errno value
- *	  issue a PASS message if we get EACCES or EEXIST
- *	otherwise, the tests fails
- *	  issue a FAIL message
- *	call cleanup
- *
- * USAGE:  <for command-line>
- *  semget02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	03/2001 - Written by Wayne Boyer
- *
- * RESTRICTIONS
- *	none
+ * - EACCES - a semaphore set exists for key, but the calling process does not
+ *   have permission to access the set
+ * - EEXIST - a semaphore set already exists for key and IPC_CREAT | IPC_EXCL
+ *   is given
+ * - ENOENT - No semaphore set exists for key and semflg did not specify
+ *   IPC_CREAT
+ * - EINVAL - nsems is less than 0 or greater than the limit on the number of
+ *   semaphores per semaphore set(SEMMSL)
+ * - EINVAL - a semaphore set corresponding to key already exists, but nsems is
+ *   larger than the number of semaphores in that set
  */
-#include <pwd.h>
-
-#include "ipcsem.h"
 
-char *TCID = "semget02";
-int TST_TOTAL = 2;
-
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
-
-int sem_id_1 = -1;
-
-struct test_case_t {
+#include <stdlib.h>
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/ipc.h>
+#include <sys/types.h>
+#include <pwd.h>
+#include "tst_test.h"
+#include "tst_safe_sysv_ipc.h"
+#include "libnewipc.h"
+#include "lapi/sem.h"
+
+static int sem_id = -1;
+static key_t semkey, semkey1;
+static struct passwd *pw;
+static struct tcase {
+	int *key;
+	int nsems;
 	int flags;
-	int error;
-} TC[] = {
-	/* EACCES - the semaphore has no read or alter permissions */
-	{
-	SEM_RA, EACCES},
-	    /* EEXIST - the semaphore id exists and semget() was called with  */
-	    /* IPC_CREAT and IPC_EXCL                                         */
-	{
-	IPC_CREAT | IPC_EXCL, EEXIST}
+	int exp_err;
+	/*1: nobody expected, 0: root expected */
+	int exp_user;
+} tcases[] = {
+	{&semkey, PSEMS, SEM_RA, EACCES, 1},
+	{&semkey, PSEMS, IPC_CREAT | IPC_EXCL, EEXIST, 0},
+	{&semkey1, PSEMS, SEM_RA, ENOENT, 0},
+	{&semkey1, -1, IPC_CREAT | IPC_EXCL, EINVAL, 0},
+	{&semkey1, SEMMSL + 1, IPC_CREAT | IPC_EXCL, EINVAL, 0},
+	{&semkey, PSEMS + 1, SEM_RA, EINVAL, 0},
 };
 
-int main(int ac, char **av)
+static void verify_semget(struct tcase *tc)
 {
-	int lc;
-	int i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();		/* global setup */
-
-	/* The following loop checks looping state if -i option given */
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
-			/* use the TEST macro to make the call */
-
-			TEST(semget(semkey, PSEMS, TC[i].flags));
-
-			if (TEST_RETURN != -1) {
-				sem_id_1 = TEST_RETURN;
-				tst_resm(TFAIL, "call succeeded");
-				continue;
-			}
+	TST_EXP_FAIL2(semget(*tc->key, tc->nsems, tc->flags), tc->exp_err,
+			"semget(%i, %i, %i)", *tc->key, tc->nsems, tc->flags);
+}
 
-			if (TEST_ERRNO == TC[i].error) {
-				tst_resm(TPASS, "expected failure - errno "
-					 "= %d : %s", TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			} else {
-				tst_resm(TFAIL, "unexpected error - %d : %s",
-					 TEST_ERRNO, strerror(TEST_ERRNO));
-			}
+static void do_test(unsigned int n)
+{
+	pid_t pid;
+	struct tcase *tc = &tcases[n];
+
+	if (tc->exp_user == 0) {
+		verify_semget(tc);
+	} else {
+		pid = SAFE_FORK();
+		if (pid) {
+			tst_reap_children();
+		} else {
+			SAFE_SETUID(pw->pw_uid);
+			verify_semget(tc);
+			exit(0);
 		}
 	}
-
-	cleanup();
-
-	tst_exit();
 }
 
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
+static void setup(void)
 {
-	tst_require_root();
-
-	/* Switch to nobody user for correct error code collection */
-	ltpuser = getpwnam(nobody_uid);
-	if (seteuid(ltpuser->pw_uid) == -1) {
-		tst_resm(TINFO, "setreuid failed to "
-			 "to set the effective uid to %d", ltpuser->pw_uid);
-		perror("setreuid");
-	}
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	semkey = GETIPCKEY();
+	semkey1 = GETIPCKEY();
 
-	TEST_PAUSE;
+	sem_id = SAFE_SEMGET(semkey, PSEMS, IPC_CREAT | IPC_EXCL);
 
-	/*
-	 * Create a temporary directory and cd into it.
-	 * This helps to ensure that a unique msgkey is created.
-	 * See libs/libltpipc/libipc.c for more information.
-	 */
-	tst_tmpdir();
-
-	/* get an IPC resource key */
-	semkey = getipckey();
-
-	/* create a semaphore set without read or alter permissions */
-	if ((sem_id_1 = semget(semkey, PSEMS, IPC_CREAT | IPC_EXCL)) == -1) {
-		tst_brkm(TBROK, cleanup, "couldn't create semaphore in setup");
-	}
+	pw = SAFE_GETPWNAM("nobody");
 }
 
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
-void cleanup(void)
+static void cleanup(void)
 {
-	/* if it exists, remove the semaphore resource */
-	rm_sema(sem_id_1);
-
-	tst_rmdir();
-
+	if (sem_id != -1)
+		SAFE_SEMCTL(sem_id, PSEMS, IPC_RMID);
 }
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.forks_child = 1,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = do_test,
+};
diff --git a/testcases/kernel/syscalls/ipc/semget/semget03.c b/testcases/kernel/syscalls/ipc/semget/semget03.c
deleted file mode 100644
index 995b4bd3a..000000000
--- a/testcases/kernel/syscalls/ipc/semget/semget03.c
+++ /dev/null
@@ -1,133 +0,0 @@
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
- *	semget03.c
- *
- * DESCRIPTION
- *	semget03 - test for ENOENT error
- *
- * ALGORITHM
- *	loop if that option was specified
- *	call semget() with a valid key but with no associated semaphore set
- *	   and IPC_CREAT is not asserted
- *	check the errno value
- *	  issue a PASS message if we get ENOENT
- *	otherwise, the tests fails
- *	  issue a FAIL message
- *	call cleanup
- *
- * USAGE:  <for command-line>
- *  semget03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	03/2001 - Written by Wayne Boyer
- *
- * RESTRICTIONS
- *	none
- */
-
-#include "ipcsem.h"
-
-char *TCID = "semget03";
-int TST_TOTAL = 1;
-
-int sem_id_1 = -1;
-
-int main(int ac, char **av)
-{
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();		/* global setup */
-
-	/* The following loop checks looping state if -i option given */
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		/* use the TEST macro to make the call */
-
-		TEST(semget(semkey, PSEMS, SEM_RA));
-
-		if (TEST_RETURN != -1) {
-			sem_id_1 = TEST_RETURN;
-			tst_resm(TFAIL, "call succeeded when error expected");
-			continue;
-		}
-
-		switch (TEST_ERRNO) {
-		case ENOENT:
-			tst_resm(TPASS, "expected failure - errno "
-				 "= %d : %s", TEST_ERRNO, strerror(TEST_ERRNO));
-			break;
-		default:
-			tst_resm(TFAIL, "unexpected error - %d : %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-			break;
-		}
-	}
-
-	cleanup();
-
-	tst_exit();
-}
-
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
-{
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	/*
-	 * Create a temporary directory and cd into it.
-	 * This helps to ensure that a unique msgkey is created.
-	 * See libs/libltpipc/libipc.c for more information.
-	 */
-	tst_tmpdir();
-
-	/* get an IPC resource key */
-	semkey = getipckey();
-}
-
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
-void cleanup(void)
-{
-	/* if it exists, remove the semaphore resource */
-	rm_sema(sem_id_1);
-
-	tst_rmdir();
-
-}
diff --git a/testcases/kernel/syscalls/ipc/semget/semget06.c b/testcases/kernel/syscalls/ipc/semget/semget06.c
deleted file mode 100644
index 52297c010..000000000
--- a/testcases/kernel/syscalls/ipc/semget/semget06.c
+++ /dev/null
@@ -1,143 +0,0 @@
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
- *	semget06.c
- *
- * DESCRIPTION
- *	semget06 - test for EINVAL error
- *
- * ALGORITHM
- *	loop if that option was specified
- *	call semget() using two different invalid cases - too many and too
- *	   few primitive semaphores
- *	check the errno value
- *	  issue a PASS message if we get EINVAL
- *	otherwise, the tests fails
- *	  issue a FAIL message
- *	call cleanup
- *
- * USAGE:  <for command-line>
- *  semget06 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	03/2001 - Written by Wayne Boyer
- *
- * RESTRICTIONS
- *	none
- */
-
-#include "ipcsem.h"
-
-char *TCID = "semget06";
-int TST_TOTAL = 2;
-
-#define LARGENUM	1024 * 32
-#define SMALLNUM	-1
-
-int sem_id_1 = -1;
-
-int num_sems[] = { LARGENUM, SMALLNUM };
-
-int main(int ac, char **av)
-{
-	int lc;
-	int i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();		/* global setup */
-
-	/* The following loop checks looping state if -i option given */
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		/* loop through the test cases */
-
-		for (i = 0; i < TST_TOTAL; i++) {
-			TEST(semget(semkey, num_sems[i],
-				    IPC_CREAT | IPC_EXCL | SEM_RA));
-
-			if (TEST_RETURN != -1) {
-				sem_id_1 = TEST_RETURN;
-				tst_resm(TFAIL, "call succeeded");
-				continue;
-			}
-
-			switch (TEST_ERRNO) {
-			case EINVAL:
-				tst_resm(TPASS, "expected failure - errno "
-					 "= %d : %s", TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-				break;
-			default:
-				tst_resm(TFAIL, "unexpected error - %d : %s",
-					 TEST_ERRNO, strerror(TEST_ERRNO));
-				break;
-			}
-		}
-	}
-
-	cleanup();
-
-	tst_exit();
-}
-
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
-{
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	/*
-	 * Create a temporary directory and cd into it.
-	 * This helps to ensure that a unique msgkey is created.
-	 * See libs/libltpipc/libipc.c for more information.
-	 */
-	tst_tmpdir();
-
-	/* get an IPC resource key */
-	semkey = getipckey();
-}
-
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
-void cleanup(void)
-{
-	/* if it exists, remove the semaphore resource */
-	rm_sema(sem_id_1);
-
-	tst_rmdir();
-
-}
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
