Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA1F0C433EF
	for <ltp@archiver.kernel.org>; Fri,  4 Feb 2022 13:14:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6783F3C9ACC
	for <ltp@archiver.kernel.org>; Fri,  4 Feb 2022 14:14:51 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 35BF53C9AE2
 for <ltp@lists.linux.it>; Fri,  4 Feb 2022 14:14:22 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C807510000D2
 for <ltp@lists.linux.it>; Fri,  4 Feb 2022 14:14:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643980460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pFg7/K5ihe6RhO3zesUadw+Eu6fOlkQrpIGnW8iU9/8=;
 b=IjcoscJt4cN5fGuSmy7dOY7sQP4h9d8dkvJklktw1+2SCbLuCVbtROGX3rC05E7PIKv2Kp
 9aS02kr6FwD7bDk/WioZ4AB+nC2P6JwmSt95OB1UCrqeWdcmL++3ZeYwyZ9IlrNX4DeRQc
 78XdPb9JFr+Z+RXm3iZ0iH481PBuKck=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-573-3Jco3FBOOGSNH2dgPERGRQ-1; Fri, 04 Feb 2022 08:14:19 -0500
X-MC-Unique: 3Jco3FBOOGSNH2dgPERGRQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 240E3839A45
 for <ltp@lists.linux.it>; Fri,  4 Feb 2022 13:14:18 +0000 (UTC)
Received: from janakin.usersys.redhat.com (unknown [10.40.192.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 793D822DEC
 for <ltp@lists.linux.it>; Fri,  4 Feb 2022 13:14:17 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Fri,  4 Feb 2022 14:14:02 +0100
Message-Id: <c59ce5a253c3c8022fe465027c9310c29827ffa6.1643980361.git.jstancek@redhat.com>
In-Reply-To: <cover.1643980361.git.jstancek@redhat.com>
References: <cover.1643980361.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] syscalls/mkdir09: rewrite in new LTP API
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

'jump' variable is not initialized, which I suspect is behind
rare failures of this test. The original test is using longjmp,
processes and signals to sychronize couple processes that
exercise mkdir/rmdir calls.

Rewrite it using threads and new LTP API, drop all parameters,
because no runtest is using them, and make new default test time
just 1 second.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/mkdir/Makefile  |   2 +
 testcases/kernel/syscalls/mkdir/mkdir09.c | 494 ++++------------------
 2 files changed, 93 insertions(+), 403 deletions(-)

diff --git a/testcases/kernel/syscalls/mkdir/Makefile b/testcases/kernel/syscalls/mkdir/Makefile
index 044619fb8724..881b087c6c1a 100644
--- a/testcases/kernel/syscalls/mkdir/Makefile
+++ b/testcases/kernel/syscalls/mkdir/Makefile
@@ -3,6 +3,8 @@
 
 top_srcdir		?= ../../../..
 
+mkdir09: CFLAGS += -pthread
+
 include $(top_srcdir)/include/mk/testcases.mk
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/mkdir/mkdir09.c b/testcases/kernel/syscalls/mkdir/mkdir09.c
index 88034d29ed89..a2870ae94df8 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir09.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir09.c
@@ -1,460 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *
- *   Copyright (c) International Business Machines  Corp., 2002
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
+ * Copyright (c) Linux Test Project, 2022
  */
 
-/* 06/30/2001	Port to Linux	nsharoff@us.ibm.com */
-/* 10/30/2002	Port to LTP	dbarrera@us.ibm.com */
-
-/*
- * Stress test of mkdir call.
- *
- * ALGORITHM
- *	Create multiple processes which create subdirectories in the
- *	same directory multiple times. On exit of all child processes,
- *	make sure all subdirectories can be removed.
- *
- *      USAGE: mkdir09 -c # -t # -d #
- *              -c = number of children groups
- *              -t = number of seconds to run test
- *              -d = number of directories created in test directory
+/*\
+ * [Description]
  *
+ * Create multiple processes which create subdirectories in the
+ * same directory multiple times within test time.
  */
 
 #include <stdio.h>
-#include <sys/wait.h>
-#include <sys/types.h>
 #include <sys/param.h>
-#include <sys/stat.h>
-#include <sys/mman.h>
-#include <errno.h>
-#include <signal.h>
-#include <unistd.h>
-#include <setjmp.h>
-#include "test.h"
-
-#include <stdlib.h>
-#include <stdlib.h>
-#include <string.h>
-
-#define NCHILD		3
+#include "tst_test.h"
+#include "tst_safe_pthread.h"
 
+#define MNTPOINT	"mntpoint"
 #define MODE_RWX	07770
-#define DIR_NAME	"./X.%d"
-
-char *TCID = "mkdir09";
-int TST_TOTAL = 1;
-
-char testdir[MAXPATHLEN];
-int parent_pid, sigchld, sigterm, jump;
-void term(int sig);
-void chld(int sig);
-int *pidlist, child_count;
-jmp_buf env_buf;
-
-int getchild(int group, int child, int children);
-int dochild1(void);
-int dochild2(void);
-int dochild3(int group);
-int massmurder(void);
-int runtest(void);
-void setup(void);
-void cleanup(void);
+#define DIR_NAME	MNTPOINT "/X.%d"
+#define DIR_NAME_GROUP	MNTPOINT "/X.%d.%d"
+#define NCHILD		3
 
 static int child_groups = 2;
-static int test_time = 5;
+static int test_time = 1;
 static int nfiles = 5;
+static volatile int done;
 
-static char *opt_child_groups;
-static char *opt_test_time;
-static char *opt_nfiles;
-
-static option_t options[] = {
-	{"c:", NULL, &opt_child_groups},
-	{"t:", NULL, &opt_test_time},
-	{"d:", NULL, &opt_nfiles},
-	{NULL, NULL, NULL}
-};
-
-static void usage(void)
-{
-	printf("  -c      Child groups\n");
-	printf("  -t      Test runtime\n");
-	printf("  -d      Directories\n");
-}
-
-int main(int argc, char *argv[])
-{
-	tst_parse_opts(argc, argv, options, usage);
-
-	if (opt_child_groups)
-		child_groups = atoi(opt_child_groups);
-
-	if (opt_test_time)
-		test_time = atoi(opt_test_time);
-
-	if (opt_nfiles)
-		nfiles = atoi(opt_nfiles);
-
-	setup();
-
-	if (signal(SIGTERM, term) == SIG_ERR) {
-		tst_brkm(TFAIL, cleanup,
-			 "Error setting up SIGTERM signal, ERRNO = %d", errno);
-
-	}
-
-	if (signal(SIGCHLD, chld) == SIG_ERR) {
-		tst_brkm(TFAIL, cleanup,
-			 "Error setting up SIGCHLD signal, ERRNO = %d", errno);
-
-	}
-
-	runtest();
-	cleanup();
-	tst_exit();
-}
-
-int runtest(void)
-{
-	int i, j;
-	int count, child, status;
-	char tmpdir[MAXPATHLEN];
-
-	/* Create permanent directories with holes in directory structure */
-
-	for (j = 0; j < nfiles; j++) {
-		sprintf(tmpdir, DIR_NAME, j);
-		TEST(mkdir(tmpdir, MODE_RWX));
-
-		if (TEST_RETURN < 0) {
-			tst_brkm(TFAIL, cleanup,
-				 "Error creating permanent directories, ERRNO = %d",
-				 TEST_ERRNO);
-		}
-		if ((j % NCHILD) != 0) {
-			if (rmdir(tmpdir) < 0) {
-				tst_brkm(TFAIL, cleanup,
-					 "Error removing directory, ERRNO = %d",
-					 errno);
-			}
-		}
-	}
-
-	parent_pid = getpid();
-
-	/* allocate space for list of child pid's */
-
-	if ((pidlist = malloc((child_groups * NCHILD) * sizeof(int))) ==
-	    NULL) {
-		tst_brkm(TWARN, NULL,
-			 "\tMalloc failed (may be OK if under stress)");
-	}
-
-	child_count = 0;
-	for (j = 0; j < child_groups; j++) {
-		for (i = 0; i < NCHILD; i++) {
-			getchild(j, i, child_count);
-			child_count++;
-		}
-	}
-
-	/* If signal already received, skip to cleanup */
-
-	if (!sigchld && !sigterm) {
-		if (test_time) {
-			/* To get out of sleep if signal caught */
-			if (!setjmp(env_buf)) {
-				jump++;
-				sleep(test_time);
-			}
-		} else {
-			pause();
-		}
-	}
-
-	/* Reset signals since we are about to clean-up and to avoid
-	 * problem with wait call *               $
-	 * */
-
-	if (signal(SIGTERM, SIG_IGN) == SIG_ERR) {
-		tst_brkm(TFAIL, cleanup,
-			 "Error resetting SIGTERM signal, ERRNO = %d", errno);
-	}
-	if (signal(SIGCHLD, SIG_DFL) == SIG_ERR) {
-		tst_brkm(TFAIL, cleanup,
-			 "Error resetting SIGCHLD signal, ERRNO = %d", errno);
-	}
-
-	if (test_time) {
-		sleep(test_time);
-	}
-
-	/* Clean up children */
-	massmurder();
-	/*
-	 * Watch children finish and show returns.
-	 */
-
-	count = 0;
-	while (1) {
-		if ((child = wait(&status)) > 0) {
-			if (status != 0) {
-				tst_brkm(TWARN,
-					 NULL,
-					 "\tChild{%d} exited status = %0x",
-					 child, status);
-			}
-			count++;
-		} else {
-			if (errno != EINTR) {
-				break;
-			}
-			tst_resm(TINFO, "\tSignal detected during wait");
-		}
-	}
-
-	/*
-	 * Make sure correct number of children exited.
-	 */
-
-	if (count != child_count) {
-		tst_resm(TWARN, "\tWrong number of children waited on!");
-		tst_brkm(TWARN, NULL, "\tSaw %d, expected %d", count,
-			 NCHILD);
-	}
-
-	/* Check for core file in test directory. */
-
-	if (access("core", 0) == 0) {
-		tst_brkm(TWARN, NULL, "\tCore file found in test directory.");
-	}
-
-	/* Remove expected files */
-
-	for (j = 0; j < nfiles; j += NCHILD) {
-		sprintf(tmpdir, DIR_NAME, j);
-		if (rmdir(tmpdir) < 0) {
-			tst_brkm(TWARN,
-				 NULL,
-				 "\tError removing expected directory, ERRNO = %d",
-				 errno);
-		}
-	}
-
-	tst_resm(TPASS, "PASS");
-
-	return 0;
-}
-
-int getchild(int group, int child, int children)
-{
-	int pid;
-
-	pid = FORK_OR_VFORK();
-
-	if (pid < 0) {
-
-		massmurder();	/* kill the kids */
-		tst_brkm(TBROK, cleanup,
-			 "\tFork failed (may be OK if under stress)");
-	} else if (pid == 0) {	/* child does this */
-		switch (children % NCHILD) {
-		case 0:
-			dochild1();	/* create existing directories */
-			break;	/* so lint won't complain */
-		case 1:
-			dochild2();	/* remove nonexistant directories */
-			break;
-		case 2:
-			dochild3(group);	/* create/delete directories */
-			break;
-		default:
-			tst_brkm(TFAIL, cleanup,
-				 "Test not inplemented for child %d", child);
-			exit(1);
-			break;
-		}
-		exit(1);	/* If child gets here, something wrong */
-	}
-	pidlist[children] = pid;
-	return 0;
-}
-
-void term(int sig)
-{
-	/* Routine to handle SIGTERM signal. */
-
-	if (parent_pid == getpid()) {
-		tst_brkm(TWARN, NULL, "\tsignal SIGTERM received by parent.");
-	}
-	sigterm++;
-	if (jump) {
-		longjmp(env_buf, 1);
-	}
-}
-
-void chld(int sig)
-{
-	/* Routine to handle SIGCHLD signal. */
-
-	sigchld++;
-	if (jump) {
-		longjmp(env_buf, 1);
-	}
-}
-
-int dochild1(void)
+/*
+ * Routine which attempts to create directories in the test
+ * directory that already exist.
+ */
+static void test1(int child_num)
 {
-	/* Child routine which attempts to create directories in the test
-	 * directory that already exist. Runs until a SIGTERM signal is
-	 * received. Will exit with an error if it is able to create the
-	 * directory or if the expected error is not received.
-	 */
-
 	int j;
 	char tmpdir[MAXPATHLEN];
 
-	while (!sigterm) {
+	while (!done) {
 		for (j = 0; j < nfiles; j += NCHILD) {
 			sprintf(tmpdir, DIR_NAME, j);
-			TEST(mkdir(tmpdir, MODE_RWX));
-
-			if (TEST_RETURN < 0) {
-
-				if (TEST_ERRNO != EEXIST) {
-					tst_brkm(TFAIL, cleanup,
-						 "MKDIR %s, errno = %d; Wrong error detected.",
-						 tmpdir, TEST_ERRNO);
-					exit(1);
-				}
-			} else {
-				tst_brkm(TFAIL, cleanup,
-					 "MKDIR %s succeded when it shoud have failed.",
-					 tmpdir);
-				exit(1);
-			}
+			TST_EXP_FAIL_SILENT(mkdir(tmpdir, MODE_RWX), EEXIST);
+			if (!TST_PASS)
+				break;
 		}
 	}
-	exit(0);
+	tst_res(TPASS, "[%d] create dirs that already exist", child_num);
 }
 
-int dochild2(void)
+/*
+ * Child routine which attempts to remove directories from the
+ * test directory which do not exist.
+ */
+static void test2(int child_num)
 {
-	/* Child routine which attempts to remove directories from the
-	 * test directory which do not exist. Runs until a SIGTERM
-	 * signal is received. Exits with an error if the proper
-	 * error is not detected or if the remove operation is
-	 * successful.
-	 */
 
 	int j;
 	char tmpdir[MAXPATHLEN];
 
-	while (!sigterm) {
+	while (!done) {
 		for (j = 1; j < nfiles; j += NCHILD) {
 			sprintf(tmpdir, DIR_NAME, j);
-			if (rmdir(tmpdir) < 0) {
-				if (errno != ENOENT) {
-					tst_brkm(TFAIL, cleanup,
-						 "RMDIR %s, errno = %d; Wrong error detected.",
-						 tmpdir, errno);
-					exit(1);
-				}
-			} else {
-				tst_brkm(TFAIL, cleanup,
-					 "RMDIR %s succeded when it should have failed.",
-					 tmpdir);
-				exit(1);
-			}
+			TST_EXP_FAIL_SILENT(rmdir(tmpdir), ENOENT);
+			if (!TST_PASS)
+				break;
 		}
 	}
-	exit(0);
-	return 0;
+	tst_res(TPASS, "[%d] remove dirs that do not exist", child_num);
 }
 
-int dochild3(int group)
+/*
+ * Child routine which creates and deletes directories in the
+ * test directory.
+ */
+static void test3(int child_num)
 {
-	/* Child routine which creates and deletes directories in the
-	 * test directory. Runs until a SIGTERM signal is received, then
-	 * cleans up and exits. Detects error if the expected condition
-	 * is not encountered.
-	 */
 
 	int j;
-
 	char tmpdir[MAXPATHLEN];
-	char tmp[MAXPATHLEN];
 
-	while (!sigterm) {
+	while (!done) {
 		for (j = 2; j < nfiles; j += NCHILD) {
-			strcpy(tmp, DIR_NAME);
-			strcat(tmp, ".%d");
-			sprintf(tmpdir, tmp, j, group);
-
-			TEST(mkdir(tmpdir, MODE_RWX));
-
-			if (TEST_RETURN < 0) {
-				tst_brkm(TFAIL, cleanup,
-					 "MKDIR %s, errno = %d; Wrong error detected.",
-					 tmpdir, TEST_ERRNO);
-				exit(1);
-			}
+			sprintf(tmpdir, DIR_NAME_GROUP, j, child_num / NCHILD);
+			TST_EXP_PASS_SILENT(mkdir(tmpdir, MODE_RWX));
+			if (!TST_PASS)
+				break;
 		}
 		for (j = 2; j < nfiles; j += NCHILD) {
-			strcpy(tmp, DIR_NAME);
-			strcat(tmp, ".%d");
-			sprintf(tmpdir, tmp, j, group);
-			if (rmdir(tmpdir) < 0) {
-				tst_brkm(TFAIL, cleanup,
-					 "RMDIR %s, errno = %d; Wrong error detected.",
-					 tmpdir, errno);
-				exit(1);
-			}
+			sprintf(tmpdir, DIR_NAME_GROUP, j, child_num / NCHILD);
+			TST_EXP_PASS_SILENT(rmdir(tmpdir));
+			if (!TST_PASS)
+				break;
 		}
 	}
-	exit(0);
+	tst_res(TPASS, "[%d] create/remove dirs", child_num);
 }
 
-int massmurder(void)
+static void *child_thread_func(void *arg)
 {
-	register int j;
-	for (j = 0; j < child_count; j++) {
-		if (pidlist[j] > 0) {
-			if (kill(pidlist[j], SIGTERM) < 0) {
-				tst_brkm(TFAIL, cleanup,
-					 "Error killing child %d, ERRNO = %d",
-					 j, errno);
-			}
-		}
-	}
-	return 0;
+	void (*tests[NCHILD])(int) = { test1, test2, test3 };
+	int child_num = (long)arg;
+
+	tests[child_num % NCHILD](child_num);
+
+	/* if any thread failed, make other finish as well */
+	done = 1;
+
+	return NULL;
 }
 
-void setup(void)
+static void verify_mkdir(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	pthread_t child_thread[NCHILD * child_groups];
+	long i;
+
+	done = 0;
+	for (i = 0; i < child_groups * NCHILD; i++) {
+		SAFE_PTHREAD_CREATE(&child_thread[i], NULL,
+			child_thread_func, (void *)i);
+	}
 
-	TEST_PAUSE;
+	sleep(test_time);
+	done = 1;
 
-	tst_tmpdir();
+	for (i = 0; i < child_groups * NCHILD; i++)
+		SAFE_PTHREAD_JOIN(child_thread[i], NULL);
 }
 
-void cleanup(void)
+static void setup(void)
 {
-	tst_rmdir();
+	int j;
+	char tmpdir[MAXPATHLEN];
+
+	for (j = 0; j < nfiles; j += NCHILD) {
+		sprintf(tmpdir, DIR_NAME, j);
+		SAFE_MKDIR(tmpdir, MODE_RWX);
+	}
 }
+
+static struct tst_test test = {
+	.test_all = verify_mkdir,
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.setup = setup,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1,
+};
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
