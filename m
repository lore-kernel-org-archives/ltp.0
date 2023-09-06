Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA4FEB8FD3
	for <ltp@archiver.kernel.org>; Wed,  6 Sep 2023 13:45:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1FA853C0609
	for <ltp@archiver.kernel.org>; Wed,  6 Sep 2023 15:45:08 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BFE5D3C0609
 for <ltp@lists.linux.it>; Wed,  6 Sep 2023 15:44:56 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 738DB10002BE
 for <ltp@lists.linux.it>; Wed,  6 Sep 2023 15:44:54 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 52583223D1;
 Wed,  6 Sep 2023 13:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694007893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kItcdEjgUpbIY/peVavRagKA02/blV2f5pz2jlXAzNo=;
 b=K4miTBmmcwY2Z6oinBLrbqg4bjgTIpTuy0mMteUEx07QSMe8HNBRISoU+LMqIAMSUxn4nY
 ZrrwXU/NBejwWlWMODil1oTYE+mgaVnzyE9+M2/naJjJXnRK41b7uOsnHY3OfH+HD9TYSY
 /7Bk7lozjh0Ns6rCjwFq3que4tbTALI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694007893;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kItcdEjgUpbIY/peVavRagKA02/blV2f5pz2jlXAzNo=;
 b=MzO2FQX5REaetm1QZs9KXg/Hbpu9Pu5QSU14xsK7sU/2ZPgw9tL+YxNyigjNUMxqZgnYlW
 bO8Vohxgwz2EI4Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 372DE1333E;
 Wed,  6 Sep 2023 13:44:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YzMSDFWC+GQTJgAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Wed, 06 Sep 2023 13:44:53 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Wed,  6 Sep 2023 15:44:52 +0200
Message-Id: <20230906134452.9792-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Rewrite fork04 test
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

The old test was outdated, so it has been rewritten from scratch
keeping the idea behind it. Now the test verifies that parent process
shares environment variables with a child process and that child process
doesn't change parent process environment variables.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/fork/fork04.c | 361 +++++-------------------
 1 file changed, 63 insertions(+), 298 deletions(-)

diff --git a/testcases/kernel/syscalls/fork/fork04.c b/testcases/kernel/syscalls/fork/fork04.c
index 5e5e42c4e..307845c92 100644
--- a/testcases/kernel/syscalls/fork/fork04.c
+++ b/testcases/kernel/syscalls/fork/fork04.c
@@ -1,328 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
- *
- *
- *    OS Test - Silicon Graphics, Inc.
- *    TEST IDENTIFIER	: fork04
- *    TEST TITLE	: Child inheritance of Environment Variables after fork()
- *    PARENT DOCUMENT	: frktds01
- *    TEST CASE TOTAL	: 3
- *    WALL CLOCK TIME	: 1
- *    CPU TYPES		: ALL
- *    AUTHOR		: Kathy Olmsted
- *    CO-PILOT		: Steve Shaw
- *    DATE STARTED	: 06/17/92
- *    INITIAL RELEASE	: UNICOS 7.0
- *
- *    TEST CASES
- *       Test these environment variables correctly inherited by child:
- *       1. TERM
- *       2. NoTSetzWq
- *       3. TESTPROG
- *
- *    INPUT SPECIFICATIONS
- * 	The standard options for system call tests are accepted.
- *	(See the parse_opts(3) man page).
- *
- *    DURATION
- * 	Terminates - with frequency and infinite modes.
- *
- *    SIGNALS
- * 	Uses SIGUSR1 to pause before test if option set.
- * 	(See the parse_opts(3) man page).
- *
- *    ENVIRONMENTAL NEEDS
- *      No run-time environmental needs.
- *
- *    DETAILED DESCRIPTION
- *
- * 	Setup:
- * 	  Setup signal handling.
- *        Make and change to a temporary directory.
- *	  Pause for SIGUSR1 if option specified.
- *        Add TESTPROG variable to the environment
- *
- * 	Test:
- *	 Loop if the proper options are given.
- *	 fork()
- *	 Check return code, if system call failed (return=-1)
- *		Log the errno
- *	   CHILD:
- *              open a temp file
- *		Determine environment values and write to file
- *		close file containing test values.
- *		exit.
- *	    PARENT:
- *		Wait for child to exit.
- *              Verify exit status
- *		Open file containing test values.
- *		For each test case:
- *			Read the value from the file.
- *			Determine and report PASS/FAIL result.
+ * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+/*\
+ *[Description]
  *
- * 	Cleanup:
- * 	  Print errno log and/or timing stats if options given
- *        Remove the temporary directory and exit.
+ * This test verifies that parent process shares environ variables with the
+ * child and that child doesn't change parent's environ variables.
  */
 
 #include <stdlib.h>
-#include <sys/types.h>
-#include <sys/wait.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <string.h>
-#include <sys/param.h>
-#include <signal.h>
-#include <errno.h>
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "fork04";
-
-#define	KIDEXIT	42
-#define MAX_LINE_LENGTH 256
-#define OUTPUT_FILE  "env.out"
-#define ENV_NOT_SET  "getenv() does not find variable set"
+#include "tst_test.h"
 
-/* list of environment variables to test */
-char *environ_list[] = { "TERM", "NoTSetzWq", "TESTPROG" };
+#define ENV_KEY "LTP_FORK04"
+#define ENV_VAL0 "PASS"
+#define ENV_VAL1 "FAIL"
 
-#define NUMBER_OF_ENVIRON (sizeof(environ_list)/sizeof(char *))
-int TST_TOTAL = NUMBER_OF_ENVIRON;
-
-static void cleanup(void)
+static void run_child(void)
 {
-	tst_rmdir();
-}
+	const char *val;
 
-static void setup(void)
-{
+	val = getenv(ENV_KEY);
+	if (!val)
+		tst_brk(TBROK, "Can't find %s environ variable", ENV_KEY);
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
-	tst_tmpdir();
+	TST_EXP_EXPR(strcmp(ENV_VAL0, val) == 0,
+		"%s environ variable has been inherited by the child",
+		ENV_KEY)
 
-	/* add a variable to the environment */
-	putenv("TESTPROG=FRKTCS04");
-}
+	tst_res(TINFO, "Unset %s environ variable inside child", ENV_KEY);
 
-static void child_environment(void)
-{
-
-	int fildes;
-	int index;
-	char msg[MAX_LINE_LENGTH];
-	char *var;
+	if (unsetenv(ENV_KEY) == -1)
+		tst_brk(TBROK, "Can't unset %s environ variable", ENV_KEY);
 
-	fildes = creat(OUTPUT_FILE, 0700);
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
-	for (index = 0; index < (int)NUMBER_OF_ENVIRON; index++) {
-		memset(msg, 0, MAX_LINE_LENGTH);
+	tst_res(TINFO, "Set %s=%s environ variable inside child", ENV_KEY, ENV_VAL1);
 
-		var = getenv(environ_list[index]);
-		if (var == NULL)
-			(void)sprintf(msg, "%s:%s", environ_list[index],
-				      ENV_NOT_SET);
-		else
-			(void)sprintf(msg, "%s:%s", environ_list[index], var);
-		/* includes extra null chars */
-		write(fildes, msg, sizeof(msg));
-	}
+	SAFE_SETENV(ENV_KEY, ENV_VAL1, 0);
 
-	close(fildes);
+	TST_CHECKPOINT_WAKE(0);
 }
 
-/*
- * Compare parent env string to child's string.
- * Each string is in the format:  <env var>:<value>
- */
-static int cmp_env_strings(char *pstring, char *cstring)
+static void run(void)
 {
-	char *penv, *cenv, *pvalue, *cvalue;
+	const char *val;
 
-	/*
-	 * Break pstring into env and value
-	 */
-	penv = pstring;
-	pvalue = strchr(pstring, ':');
-	if (pvalue == NULL) {
-		tst_resm(TBROK,
-			 "internal error - parent's env string not in correct format:'%s'",
-			 pstring);
-		return -1;
-	} else {
-		*pvalue = '\0';
-		pvalue++;
-		if (*pvalue == '\0') {
-			tst_resm(TBROK,
-				 "internal error - missing parent's env value");
-			return -1;
-		}
-	}
+	tst_res(TINFO,
+		"Set %s=%s environ variable inside parent",
+		ENV_KEY, ENV_VAL0);
 
-	/*
-	 * Break cstring into env and value
-	 */
-	cenv = cstring;
-	cvalue = strchr(cstring, ':');
-	if (cvalue == NULL) {
-		tst_resm(TBROK,
-			 "internal error - parent's env string not in correct format:'%s'",
-			 cstring);
-		return -1;
-	} else {
-		*cvalue = '\0';
-		cvalue++;
-		if (*cvalue == '\0') {
-			tst_resm(TBROK,
-				 "internal error - missing child's env value");
-			return -1;
-		}
-	}
+	SAFE_SETENV(ENV_KEY, ENV_VAL0, 0);
 
-	if (strcmp(penv, cenv) != 0) {
-		tst_resm(TBROK, "internal error - parent(%s) != child (%s) env",
-			 penv, cenv);
-		return -1;
-	}
+	tst_res(TINFO, "Spawning child");
 
-	if (strcmp(pvalue, cvalue) != 0) {
-		tst_resm(TFAIL,
-			 "Env var %s changed after fork(), parent's %s, child's %s",
-			 penv, pvalue, cvalue);
-	} else {
-		tst_resm(TPASS, "Env var %s unchanged after fork(): %s",
-			 penv, cvalue);
+	if (!SAFE_FORK()) {
+		run_child();
+		exit(0);
 	}
-	return 0;
-
-}
-
-/***************************************************************
- * parent_environment - the parent side of the environment tests
- *        determine values for the variables
- *        read the values determined by the child
- *        compare values
- ***************************************************************/
-void parent_environment(void)
-{
-
-	int fildes;
-	char tmp_line[MAX_LINE_LENGTH];
-	char parent_value[MAX_LINE_LENGTH];
-	unsigned int index;
-	int ret;
-	char *var;
-
-	fildes = SAFE_OPEN(cleanup, OUTPUT_FILE, O_RDWR);
-	for (index = 0; index < NUMBER_OF_ENVIRON; index++) {
-		ret = read(fildes, tmp_line, MAX_LINE_LENGTH);
-		if (ret == 0) {
-			tst_resm(TBROK,
-				 "fork() test. parent_environment: failed to read from file with %d (%s)",
-				 errno, strerror(errno));
-		} else {
 
-			var = getenv(environ_list[index]);
-			if (var == NULL)
-				sprintf(parent_value, "%s:%s",
-					environ_list[index], ENV_NOT_SET);
-			else
-				sprintf(parent_value, "%s:%s",
-					environ_list[index], var);
+	TST_CHECKPOINT_WAIT(0);
 
-			cmp_env_strings(parent_value, tmp_line);
-
-		}
+	val = getenv(ENV_KEY);
+	if (!val) {
+		tst_res(TFAIL,
+			"%s environ variable has been unset inside parent",
+			ENV_KEY);
+	} else {
+		TST_EXP_EXPR(strcmp(ENV_VAL0, val) == 0,
+			"%s environ variable is still present inside parent",
+			ENV_KEY)
 	}
 
-	close(fildes);
-}
-
-int main(int ac, char **av)
-{
-	int lc;
-	int kid_status;
-	int wait_status;
-	int fails;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		fails = 0;
-
-		TEST(fork());
-
-		if (TEST_RETURN == -1) {
-			/* fork failed */
-			tst_brkm(TFAIL, cleanup,
-				 "fork() failed with %d (%s)",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-		} else if (TEST_RETURN == 0) {
-			/* child */
-			/* determine environment variables */
-			child_environment();
-			/* exit with known value */
-			exit(KIDEXIT);
-		} else {
-			/* parent of successful fork */
-			/* wait for the child to complete */
-			wait_status = waitpid(TEST_RETURN, &kid_status, 0);
-			/* validate the child exit status */
-			if (wait_status == TEST_RETURN) {
-				if (kid_status != KIDEXIT << 8) {
-					tst_brkm(TBROK, cleanup,
-						 "fork(): Incorrect child status returned on wait(): %d",
-						 kid_status);
-					fails++;
-				}
-			} else {
-				tst_brkm(TBROK, cleanup,
-					 "fork(): wait() for child status failed with %d errno: %d : %s",
-					 wait_status, errno,
-					 strerror(errno));
-				fails++;
-			}
-
-			if (fails == 0) {
-				/* verification tests */
-				parent_environment();
-			}
-		}
-
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
+
+	val = getenv(ENV_KEY);
+	if (!val)
+		tst_res(TFAIL,
+			"%s environ variable has been unset inside parent",
+			ENV_KEY);
+	else {
+		TST_EXP_EXPR(strcmp(ENV_VAL0, val) == 0,
+			"%s environ variable didn't change inside parent",
+			ENV_KEY)
 	}
-
-	cleanup();
-	tst_exit();
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
