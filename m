Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85F5C433F5
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 02:00:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 535D13CA69F
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 04:00:31 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 79E2E3CA635
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 04:00:16 +0200 (CEST)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 85028600BF9
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 04:00:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1651111214; i=@fujitsu.com;
 bh=asx8LfE1xpsSVFAn27e2p/iStcCyGR3SLHuFdQWdsgA=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=K5JJQBXmURbhH3WOhaaCODj+7fgK6ff25tJlDj5xA255I85bZ97ZKMhqtejhrTt42
 nCyUUwohc3Tto8PPcmNouHqgsw0ChkYC5yrCHeyTSR6u2gO0X2wE+7K8a8A0dU6a8O
 1qgeoO10jOCit/w0IQ1wKaNfisQDFEDRewm6d9XBbS1BcIAswevJIF5r/AIocLgv8Y
 mcA23MWTPZavYP3E4OK/pMwVeAl4/61bfN9ZTR5jhtraTk9o/yNW6f3EugFAaY8PBh
 VgtKjCy86eyjDDL+owfPySmm8tVBc4HJ9hCA1XKHKKGI05jUkeDuX9kiDoAoZjSrqC
 8CPLbRTuYcI4A==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRWlGSWpSXmKPExsViZ8ORqKv7NTP
 J4PgsaYsV33cwOjB67Pu9jjWAMYo1My8pvyKBNWPjroMsBa+dKtY0ajYwPjLtYuTiEBI4yyjR
 vLuJFcLZySRxdM4sZghnD6PEpkcnmLoYOTnYBDQlnnUuYAaxRQQkJDoa3rKD2MwCfhL77l4Fi
 wsLWEnsPzGVEcRmEVCVuHD2IVgvr4CHxMzmn2D1EgIKElMevger5xRQkVh+4CpYjZCAssTqaZ
 3MEPWCEidnPmGBmC8hcfDFC2aIXkWJSx3fGCHsColZs9qYIGw1iavnNjFPYBSchaR9FpL2BYx
 Mqxitk4oy0zNKchMzc3QNDQx0DQ1NdY2NdQ3NLfUSq3QT9VJLdctTi0t0jfQSy4v1UouL9Yor
 c5NzUvTyUks2MQLDOKVYcfMOxokrf+odYpTkYFIS5c2vz0wS4kvKT6nMSCzOiC8qzUktPsQow
 8GhJMF74iNQTrAoNT21Ii0zBxhTMGkJDh4lEd6SD0Bp3uKCxNzizHSI1ClGRSlxXrYvQAkBkE
 RGaR5cGyyOLzHKSgnzMjIwMAjxFKQW5WaWoMq/YhTnYFQS5uUFmcKTmVcCN/0V0GImoMUri8A
 WlyQipKQamBisSzprnLn2z734d/Juydgvc37rh26+tYd/iduE8xHx1zyYfivOyU9kvHRsyffM
 f47ZVdGT/2mJp94usWO+9ulKucYOtoPnbie2NijbTtx1g625YzvjSR9mQauQTfcZlI1eePqZG
 x/0jNzxSdPgedseh1tF//xlrt7fzyr7uKrdIOLQaiFbA+WUrOz9Ded8tlimcV3onr1oackPxS
 Vs5zPs4jvSk6Jv3yu7OksqZFaEvd9EPuvt/3erpWRo8t8N01ppxzqjqrOqZsfFVYvLfx79E//
 5wIu+OsM3BbzPjxcdsHB+vyUr0eAVYzpfbjnjnyc1jxYVsXj+89KIvfN93SfVg86X5wnO5t+y
 6GrkGiWW4oxEQy3mouJEAKChozteAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-16.tower-548.messagelabs.com!1651111213!20799!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.86.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 708 invoked from network); 28 Apr 2022 02:00:13 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-16.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 28 Apr 2022 02:00:13 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id DCDF7100190
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 03:00:12 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id B867C100182
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 03:00:12 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 28 Apr 2022 02:59:50 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Thu, 28 Apr 2022 10:59:57 +0800
Message-ID: <1651114797-2361-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <Ymld6Z6zaWVoz0T5@yuki>
References: <Ymld6Z6zaWVoz0T5@yuki>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/shmdt01: Convert into new api
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

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Liao Huangjie <liaohj.jy@fujitsu.com>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/ipc/shmdt/Makefile  |   7 +-
 testcases/kernel/syscalls/ipc/shmdt/shmdt01.c | 246 ++++--------------
 2 files changed, 57 insertions(+), 196 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/shmdt/Makefile b/testcases/kernel/syscalls/ipc/shmdt/Makefile
index 26b9f264d..a48dbf48f 100644
--- a/testcases/kernel/syscalls/ipc/shmdt/Makefile
+++ b/testcases/kernel/syscalls/ipc/shmdt/Makefile
@@ -3,10 +3,13 @@
 
 top_srcdir              ?= ../../../../..
 
-LTPLIBS = ltpipc
+LTPLIBS = ltpipc ltpnewipc
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-LTPLDLIBS  = -lltpipc
+shmdt01: LTPLDLIBS = -lltpnewipc
+shmdt02: LTPLDLIBS = -lltpipc
+
+LTPLDLIBS  = -lltpipc ltpnewipc
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/shmdt/shmdt01.c b/testcases/kernel/syscalls/ipc/shmdt/shmdt01.c
index 697613a47..551daac9c 100644
--- a/testcases/kernel/syscalls/ipc/shmdt/shmdt01.c
+++ b/testcases/kernel/syscalls/ipc/shmdt/shmdt01.c
@@ -1,223 +1,81 @@
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
- *	shmdt01.c
- *
- * DESCRIPTION
- *	shmdt01 - check that shared memory is detached correctly
- *
- * ALGORITHM
- *	create a shared memory resource of size sizeof(int)
- *	attach it to the current process and give it a value
- *	call shmdt() using the TEST macro
- *	check the return code
- *	  if failure, issue a FAIL message.
- *	otherwise,
- *	  if doing functionality testing
- *		attempt to write a value to the shared memory address
- *		this should generate a SIGSEGV which will be caught in
- *		    the signal handler
- *	  	if correct,
- *			issue a PASS message
- *		otherwise
- *			issue a FAIL message
- *	call cleanup
+/*\
+ * [Description]
  *
- * USAGE:  <for command-line>
- *  shmdt01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	03/2001 - Written by Wayne Boyer
- *
- *      06/03/2008 Renaud Lottiaux (Renaud.Lottiaux@kerlabs.com)
- *      - Fix wrong return value check on shmat system call (leading to
- *        segfault in case of error with this syscall).
- *
- * RESTRICTIONS
- *	none
+ * This case check whether we get SIGSEGV when write a value to a detached
+ * shared memory resource.
  */
 
+#include <sys/types.h>
+#include <sys/ipc.h>
+#include <sys/shm.h>
 #include <setjmp.h>
-#include "ipcshm.h"
+#include "tst_test.h"
+#include "libnewipc.h"
+#include "tst_safe_sysv_ipc.h"
 
-char *TCID = "shmdt01";
-int TST_TOTAL = 1;
+static int shm_id = -1, shm_key, pass;
+static int *shared;
+static sigjmp_buf env;
 
-void sighandler(int);
-struct shmid_ds buf;
-
-int shm_id_1 = -1;
-int *shared;			/* variable to use for shared memory attach */
-int new;
-int pass = 0;
-sigjmp_buf env;
-
-int main(int ac, char **av)
+static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
 {
-	int lc;
-	void check_functionality(void);
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
-		/*
-		 * Use TEST macro to make the shmdt() call
-		 */
-
-		TEST(shmdt((const void *)shared));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "%s call failed - errno = %d : %s",
-				 TCID, TEST_ERRNO, strerror(TEST_ERRNO));
-		} else {
-			check_functionality();
-		}
-
-		/* reattach the shared memory segment in case we are looping */
-		shared = shmat(shm_id_1, 0, 0);
-
-		if (shared == (void *)-1) {
-			tst_brkm(TBROK, cleanup, "memory reattach failed");
-		}
-
-		/* also reset pass */
-		pass = 0;
-	}
-
-	cleanup();
-
-	tst_exit();
+	pass = 1;
+	siglongjmp(env, 1);
 }
 
-/*
- * check_functionality() - make sure the memory is detached correctly
- */
-void check_functionality(void)
+static void check_functionality(void)
 {
-	/* stat the shared memory segment */
-	if (shmctl(shm_id_1, IPC_STAT, &buf) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "could not stat in signal handler");
+	struct shmid_ds buf;
 
-	if (buf.shm_nattch != 0) {
-		tst_resm(TFAIL, "# of attaches is incorrect");
+	SAFE_SHMCTL(shm_id, IPC_STAT, &buf);
+	TST_EXP_EQ_LI(buf.shm_nattch, 0);
+	if (buf.shm_nattch)
 		return;
-	}
 
-	/*
-	 * Try writing to the shared memory.  This should generate a
-	 * SIGSEGV which will be caught below.
-	 *
-	 * This is wrapped by the sigsetjmp() call that will take care of
-	 * restoring the program's context in an elegant way in conjunction
-	 * with the call to siglongjmp() in the signal handler.
-	 *
-	 * An attempt to do the assignment without using the sigsetjmp()
-	 * and siglongjmp() calls will result in an infinite loop.  Program
-	 * control is returned to the assignment statement after the execution
-	 * of the signal handler and another SIGSEGV will be generated.
-	 */
-
-	if (sigsetjmp(env, 1) == 0) {
+	if (sigsetjmp(env, 1) == 0)
 		*shared = 2;
-	}
-
-	if (pass) {
-		tst_resm(TPASS, "shared memory detached correctly");
-	} else {
-		tst_resm(TFAIL, "shared memory was not detached correctly");
-	}
-}
 
-void sighandler(int sig)
-{
-	/* if we have received a SIGSEGV, we are almost done */
-	if (sig == SIGSEGV) {
-		/* set the global variable and jump back */
-		pass = 1;
-		siglongjmp(env, 1);
-	} else
-		tst_brkm(TBROK, cleanup,
-			 "received an unexpected signal: %d", sig);
+	if (pass)
+		tst_res(TPASS, "shared memory detached correctly");
+	else
+		tst_res(TFAIL, "shared memory was not detached correctly");
 }
 
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
+static void verify_shmdt(void)
 {
-
-	tst_sig(NOFORK, sighandler, cleanup);
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
-	shmkey = getipckey();
-
-	/* create a shared memory resource with read and write permissions */
-	if ((shm_id_1 = shmget(shmkey, INT_SIZE, SHM_RW | IPC_CREAT |
-			       IPC_EXCL)) == -1) {
-		tst_brkm(TBROK, cleanup, "Failed to create shared memory "
-			 "resource in setup()");
-	}
-
-	/* attach the shared memory segment */
-	shared = shmat(shm_id_1, 0, 0);
-
-	if (shared == (void *)-1) {
-		tst_brkm(TBROK, cleanup, "Couldn't attach shared memory");
+	TST_EXP_PASS_SILENT(shmdt(shared));
+	if (TST_PASS) {
+		check_functionality();
+		shared = SAFE_SHMAT(shm_id, 0, 0);
 	}
 
-	/* give a value to the shared memory integer */
-	*shared = 4;
+	pass = 0;
 }
 
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
-void cleanup(void)
+static void setup(void)
 {
-	/* if it exists, delete the shared memory resource */
-	rm_shm(shm_id_1);
+	shm_key = GETIPCKEY();
+	shm_id = SAFE_SHMGET(shm_key, INT_SIZE, SHM_RW | IPC_CREAT | IPC_EXCL);
 
-	tst_rmdir();
+	SAFE_SIGNAL(SIGSEGV, sighandler);
+	shared = SAFE_SHMAT(shm_id, 0, 0);
+}
 
+static void cleanup(void)
+{
+	if (shm_id != -1)
+		SAFE_SHMCTL(shm_id, IPC_RMID, NULL);
 }
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_shmdt,
+};
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
