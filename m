Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA15EC6FD1D
	for <ltp@archiver.kernel.org>; Mon, 20 Mar 2023 06:31:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B54D13CD34D
	for <ltp@archiver.kernel.org>; Mon, 20 Mar 2023 07:31:45 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 62E813CD351
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 07:31:08 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5F45410000EA
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 07:31:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1679293866; i=@fujitsu.com;
 bh=xBO8VUwX9WtlxHrNBGeGehiYqaToKwMI9lnjfu4MH9s=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type:Content-Transfer-Encoding;
 b=kG5n3tnHmpWMes6uSUtVXIeel+P8yGG8A/JO7aA9LFMBPsnlwYjzCuXgE7bZ+FNqK
 Pf9x1l1CeX6JK8jGlRkIBOl9bEurtxeAkSAY+9r8qykG+3pUFAK7vaIlM4bNdr3xTK
 IvHuWiqL5bRDHoEW9emD/HjIfzTt53wXaOpDZKf+65whNfIAGQfidoMI+UyYWfYPoM
 cM0gvldHhsERyflhbgNZi1WGSaxLfN72+B96zyccGi3a3/+n+cz9Ccuby73Ol+RU48
 S884/pNvtuS7QnxS7QhfKUXUN3FsM+0QfkqfQ3deffqaJjaXk9Oucfut2GT/0Otm56
 Jya9cw4ck5dqg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRWlGSWpSXmKPExsViZ8MxSXflX/E
 Ug5VLDCxWfN/B6MDose/3OtYAxijWzLyk/IoE1ozzaxuYCtaZVrQ9Ws3cwLhYu4uRi0NI4Cyj
 xKbj95m6GDmBnANMEsunK0Ek9jJKbLvZzgySYBPQlHjWuQDMFhGQkOhoeMsOYjMLqEssn/QLq
 JmDQ1jAXOL7qhCQMIuAqsTz7iY2EJtXwFPi5K9OMFtCQEFiysP3YGM4Bbwkdr37wQyx11Pi2N
 VfUPWCEidnPmGBGK8q0X3kKROELS/RvHU2M8QcJYm21iusEHaFROP0Q0wQtprE1XObmCcwCs1
 CMmoWklGzkIxawMi8itGsOLWoLLVI19BML6koMz2jJDcxM0cvsUo3US+1VLc8tbhE10gvsbxY
 L7W4WK+4Mjc5J0UvL7VkEyMw1FOK1d13MB7p+6t3iFGSg0lJlPf4G/EUIb6k/JTKjMTijPii0
 pzU4kOMMhwcShK8R38B5QSLUtNTK9Iyc4BxB5OW4OBREuG1/gSU5i0uSMwtzkyHSJ1iVJQS5/
 3/GyghAJLIKM2Da4PF+iVGWSlhXkYGBgYhnoLUotzMElT5V4ziHIxKwrwfQabwZOaVwE1/BbS
 YCWjx/UkiIItLEhFSUg1M1W1lHDsezLTte9m9eFm82WKBmWfVbWcfeiR2IXD2b6VrHec13rx4
 fi1xrQXn/kutlTorVf5xLz7xWC5RfKpW6gtt556ZwrnRYtf+uynVB3765MVx81Hszs0V2zd+E
 tvH+cZz07GW7F3O3HxXPVgXfwo+bMc66aBzTJ5u3bI5pz5dr30pmTZ3jfX30Fz7+dof+9w/7R
 FJfexdzjXziN4PBs8VrxODmZt3+3/OTuf4LPuH+0+83avfJcdrb87x2NI60+6ErX7LnyutbDc
 VjZX27F6kn/asbWJvUN3l4MBl3Z1VMu4151f8+NG7mSVwy4vIAypfMxsiDKVjXzDv1s47obnS
 tnJ9YMrUiZNCIzP/KLEUZyQaajEXFScCABI2JFRwAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-4.tower-548.messagelabs.com!1679293865!141890!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 9611 invoked from network); 20 Mar 2023 06:31:05 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-4.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 20 Mar 2023 06:31:05 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 7E8E71000E7
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 06:31:05 +0000 (GMT)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121
 [10.183.43.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 717041000DC
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 06:31:05 +0000 (GMT)
Received: from localhost.localdomain (10.167.215.131) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Mon, 20 Mar 2023 06:31:03 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 20 Mar 2023 14:30:22 +0800
Message-ID: <1679293822-19378-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1679293822-19378-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1679293822-19378-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.215.131]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/4] ipc/semget05: Convert into new api
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
Content-Type: multipart/mixed; boundary="===============0595069368=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0595069368==
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit

Use the same logic as shmget03 and msget02 to trigger ENOSPC error.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/ipc/semget/Makefile |   5 +-
 .../kernel/syscalls/ipc/semget/semget05.c     | 187 ++++++------------
 2 files changed, 59 insertions(+), 133 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/semget/Makefile b/testcases/kernel/syscalls/ipc/semget/Makefile
index 2f98c36ca..b1201281d 100644
--- a/testcases/kernel/syscalls/ipc/semget/Makefile
+++ b/testcases/kernel/syscalls/ipc/semget/Makefile
@@ -3,11 +3,10 @@
 
 top_srcdir              ?= ../../../../..
 
-LTPLIBS = ltpipc ltpnewipc
+LTPLIBS = ltpnewipc
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-semget01 semget02: LTPLDLIBS = -lltpnewipc
-semget05: LTPLDLIBS = -lltpipc
+LTPLDLIBS = -lltpnewipc
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/semget/semget05.c b/testcases/kernel/syscalls/ipc/semget/semget05.c
index f801cb8ed..38b0fad3c 100644
--- a/testcases/kernel/syscalls/ipc/semget/semget05.c
+++ b/testcases/kernel/syscalls/ipc/semget/semget05.c
@@ -1,152 +1,79 @@
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
- *	semget05.c
+/*\
+ * [Description]
  *
- * DESCRIPTION
- *	semget05 - test for ENOSPC error
+ * Test for ENOSPC error.
  *
- * ALGORITHM
- *	create semaphore sets in a loop until the system limit is reached
- *	loop if that option was specified
- *	attempt to create yet another semaphore set
- *	check the errno value
- *	  issue a PASS message if we get ENOSPC
- *	otherwise, the tests fails
- *	  issue a FAIL message
- *	call cleanup
- *
- * USAGE:  <for command-line>
- * HISTORY
- *	03/2001 - Written by Wayne Boyer
- *      07/2006 - Changes By Michael Reed
- *                - Changed the value of MAXIDS for the specific machine by reading
- *                  the system limit for SEMMNI - The maximum number of sempahore sets
- *      03/2008 - Matthieu Fertré  (mfertre@irisa.fr)
- *                - Fix concurrency issue. Create private semaphores to
- *                  avoid conflict with concurrent processes.
- *
- * RESTRICTIONS
- *	none
+ * ENOSPC - a semaphore set exceed the maximum number of semaphore sets(SEMMNI)
  */
 
-#include "ipcsem.h"
-
-char *TCID = "semget05";
-int TST_TOTAL = 1;
-
-/*
- * The MAXIDS value is somewhat arbitrary and may need to be increased
- * depending on the system being tested.
- */
-
-int MAXIDS = 2048;
-
-int *sem_id_arr = NULL;
-int num_sems = 0;		/* count the semaphores created */
-
-int main(int ac, char **av)
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/ipc.h>
+#include "lapi/sem.h"
+#include "tst_test.h"
+#include "libnewipc.h"
+#include "tst_safe_sysv_ipc.h"
+
+static int *sem_id_arr;
+static int maxsems, array_cnt, used_cnt;
+static key_t semkey;
+
+static void verify_semget(void)
 {
-	int lc;
-	FILE *fp;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	/* Set the MAXIDS for the specific machine by reading the system limit
-	 * for SEMMNI - The maximum number of sempahore sets
-	 */
-	fp = fopen("/proc/sys/kernel/sem", "r");
-	if (fp != NULL) {
-		int getmaxid;
-		if (fscanf(fp, "%*d %*d %*d %d", &getmaxid) == 1)
-			MAXIDS = getmaxid + 1;
-		fclose(fp);
-	}
-
-	sem_id_arr = malloc(sizeof(int) * MAXIDS);
-	if (sem_id_arr == NULL)
-		tst_brkm(TBROK, cleanup, "malloc failed");
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-
-		TEST(semget(IPC_PRIVATE, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA));
-		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "call succeeded when error expected");
-			continue;
-		}
-
-		switch (TEST_ERRNO) {
-		case ENOSPC:
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
+	TST_EXP_FAIL2(semget(semkey + maxsems, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA),
+		ENOSPC, "semget(%i, %i, %i)", semkey + maxsems, PSEMS,
+		IPC_CREAT | IPC_EXCL | SEM_RA);
 }
 
-void setup(void)
+static void setup(void)
 {
-	int sem_q;
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	int res, num;
 
-	TEST_PAUSE;
+	semkey = GETIPCKEY();
+	used_cnt = GET_USED_ARRAYS();
+	tst_res(TINFO, "Current environment %d semaphore arrays are already in use",
+		used_cnt);
+	SAFE_FILE_SCANF("/proc/sys/kernel/sem", "%*d %*d %*d %d", &maxsems);
 
-	tst_tmpdir();
-
-	while ((sem_q = semget(IPC_PRIVATE, PSEMS, IPC_CREAT | IPC_EXCL)) != -1) {
-		sem_id_arr[num_sems++] = sem_q;
-		if (num_sems == MAXIDS) {
-			tst_brkm(TBROK, cleanup, "The maximum number of "
-				 "semaphore ID's has been\n\t reached.  Please "
-				 "increase the MAXIDS value in the test.");
-		}
-	}
+	sem_id_arr = SAFE_MALLOC((maxsems - used_cnt) * sizeof(int));
+	for (num = 0; num < maxsems - used_cnt; num++) {
+		res = semget(semkey + num, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA);
+		if (res == -1)
+			tst_brk(TBROK | TERRNO, "semget failed unexpectedly");
 
-	if (errno != ENOSPC) {
-		tst_brkm(TBROK, cleanup, "Didn't get ENOSPC in test setup"
-			 " - errno = %d : %s", errno, strerror(errno));
+		sem_id_arr[array_cnt++] = res;
 	}
+	tst_res(TINFO, "The maximum number of semaphore arrays (%d) has been reached",
+		maxsems);
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
-	int i;
+	int num;
 
-	for (i = 0; i < num_sems; i++) {
-		rm_sema(sem_id_arr[i]);
-	}
+	if (!sem_id_arr)
+		return;
+
+	for (num = 0; num < array_cnt; num++)
+		SAFE_SEMCTL(sem_id_arr[num], PSEMS, IPC_RMID);
 
 	free(sem_id_arr);
-	tst_rmdir();
 }
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_semget,
+	.save_restore = (const struct tst_path_val[]){
+		{"/proc/sys/kernel/sem", NULL, TST_SR_TCONF},
+		{}
+	}
+};
-- 
2.39.1


--===============0595069368==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0595069368==--
