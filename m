Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD65EC77B6E
	for <ltp@archiver.kernel.org>; Fri, 14 Apr 2023 04:03:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 101DE3CC57C
	for <ltp@archiver.kernel.org>; Fri, 14 Apr 2023 06:03:19 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2CF8A3CC3F4
 for <ltp@lists.linux.it>; Fri, 14 Apr 2023 06:03:05 +0200 (CEST)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 80A3B6008FB
 for <ltp@lists.linux.it>; Fri, 14 Apr 2023 06:03:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1681444983; i=@fujitsu.com;
 bh=WCRaNjIGtWodGNiJUFoq2IVVfjMwy+pENzFzCTXYNAQ=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type:Content-Transfer-Encoding;
 b=bhzrXkF3yXhWFF8Gbd77mdzEkVbKhGrJK+CNob1oeV/4BF127tNNaxIVeq4H7ZYI7
 O6rMOlB0qfeCR4KRAleOtzrInfYx7BfYK8MCcn2c1+VWw/QDRehlGIg4fygjHZuBiC
 0wp05f+SibG+dfcHbzaBWPplIUaKDYJTAdSmA48sOZIQhfYqS8vmad7NEw3F6CrpNO
 j9hMkgKvgKTAcRo6AA81rlxqMtFXG7XteSOHoE7Nkm+AaZHss3Rs+MzNtYE8E4B43Y
 YfanPm2SwKmx7U2bcMyoaVZkK9St4I7ud3wkHBlXHTXEHFlwlR3EKrTAbcagpew0ku
 Inf8BHQ7/dn1w==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRWlGSWpSXmKPExsViZ8MxSbfsgkW
 Kwb1rShYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa0Zb4z3WgnWmFS19r1kbGBdrdzFycggJnGWU
 WPU/o4uRC8g+yCTxeMoJJghnH6PEhmmv2ECq2AQ0JZ51LmAGsUUEJCQ6Gt6yg9jMAuoSyyf9A
 mrg4BAWMJG4udYfJMwioCqxbB1ECa+Ap0TTmklgtoSAgsSUh+/BxnAKBEo8mrKfFeKIAIlVHx
 cyQ9QLSpyc+YQFYrymROv231Cr5CWat85mhpijJNHWeoUVwq6UaP3wiwXCVpO4em4T8wRGoVl
 IRs1CMmoWklELGJlXMZoWpxaVpRbpmuglFWWmZ5TkJmbm6CVW6SbqpZbqlqcWl+ga6SWWF+ul
 FhfrFVfmJuek6OWllmxiBAZ6SrHisR2M/3r/6h1ilORgUhLlLT5ikSLEl5SfUpmRWJwRX1Sak
 1p8iFGGg0NJgjfmLFBOsCg1PbUiLTMHGHUwaQkOHiUR3iiQVt7igsTc4sx0iNQpRkUpcd4H54
 ESAiCJjNI8uDZYpF9ilJUS5mVkYGAQ4ilILcrNLEGVf8UozsGoJMzLegJoCk9mXgnc9FdAi5m
 AFlfrgi0uSURISTUwLXzvee20xebfq6In1+kdlnoT0KLb28t9NWPv7y8iDOvF6y1O7lQ83a92
 cmeq6sktBoKlz39zLp4lftJ+4aMNmgpiF7WbZmqF71OLk/TXFnug/94/9bxfo1lZ2AppY3uNI
 +knS5SfXAzsvPf25YR28aUnDl9vntG1RENu2tHWOVUnTr1tLDv89Jg5g9+bi3MO/FvBwHB1vv
 yMX/pxfzXcj0vs+3z+/4TCjh4fzfnXVJ+yXPkwf8OWj8zWezf2+0x4KhZ29HVWaKSp1smfF++
 80e57s223YnFH8bSHVnOqHM/JdrrFB/FHVoo+r5fPmFyRdXy7+1PxCGBKctI+VnfshHOQrxVD
 pSCjj+yF779+KrEUZyQaajEXFScCAONVw+hvAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-23.tower-571.messagelabs.com!1681444982!204998!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 32023 invoked from network); 14 Apr 2023 04:03:02 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-23.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 14 Apr 2023 04:03:02 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 3929E100467
 for <ltp@lists.linux.it>; Fri, 14 Apr 2023 05:03:02 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223
 [10.182.185.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 2D12F1000D7
 for <ltp@lists.linux.it>; Fri, 14 Apr 2023 05:03:02 +0100 (BST)
Received: from localhost.localdomain (10.167.215.131) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Fri, 14 Apr 2023 05:03:00 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Fri, 14 Apr 2023 12:02:40 +0800
Message-ID: <1681444960-20143-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <CAEemH2eTxhuQ+5YGMVbQwf9ZY1ttOHZxCySux-s0sDjXvhC4zw@mail.gmail.com>
References: <CAEemH2eTxhuQ+5YGMVbQwf9ZY1ttOHZxCySux-s0sDjXvhC4zw@mail.gmail.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.215.131]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RESEND] ipc/semget05: Convert into new api
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
Content-Type: multipart/mixed; boundary="===============1991168225=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1991168225==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Use the same logic as shmget03 and msget03 to trigger ENOSPC error.

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


--===============1991168225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1991168225==--
