Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C36DECAAA1
	for <ltp@archiver.kernel.org>; Tue, 30 Aug 2022 07:20:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA35B3CA65D
	for <ltp@archiver.kernel.org>; Tue, 30 Aug 2022 09:20:44 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E2743CA1E0
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 09:20:33 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C5C961400C5D
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 09:20:32 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 858821F90B
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 07:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1661844031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+Qa0Va4jUroCoBNGD/kdkENe+9XWtzOWjlfgZScBV6A=;
 b=maX+YlX9SJcnr9oHyGhVYfbPUCLZVM/4aYIa8wgybjmhpNtmx6y2LAizplqtfLssH1oAw6
 1rPH2f3xOVc57Kq9Ug3HJw8L1cOU+ZstogcpFiBT/rJbtAJKjGTOrDso1CzSkAz1uxh75D
 yeUNfuL3/N0bBe4C47bk3elIYsFhluY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1661844031;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+Qa0Va4jUroCoBNGD/kdkENe+9XWtzOWjlfgZScBV6A=;
 b=yUPa4bVxY+8LUc5ZjOs+qu1k/R/lVkcUH1DzaNQ5V6GuPmzx2S0cGx9B2od+rlREXaMy8k
 9TNiEHqUCSKrefAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0326A13ACF
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 07:20:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 5LCcLT66DWOAMgAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 07:20:30 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Tue, 30 Aug 2022 12:50:28 +0530
Message-Id: <20220830072028.1115-1-akumar@suse.de>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] getsid01.c: Convert to new LTP API
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

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/getsid/getsid01.c | 164 +++-----------------
 1 file changed, 23 insertions(+), 141 deletions(-)

diff --git a/testcases/kernel/syscalls/getsid/getsid01.c b/testcases/kernel/syscalls/getsid/getsid01.c
index 0857468f1..2bcc10e70 100644
--- a/testcases/kernel/syscalls/getsid/getsid01.c
+++ b/testcases/kernel/syscalls/getsid/getsid01.c
@@ -1,159 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *
  *   Copyright (c) International Business Machines  Corp., 2001
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
+ *		07/2001 Ported by Wayne Boyer
+ *   Copyright (c) 2022 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
 
-/*
- * NAME
- *	getsid01.c
- *
- * DESCRIPTION
- *	getsid01 - call getsid() and make sure it succeeds
- *
- * ALGORITHM
- *	loop if that option was specified
- *	issue the system call
- *	check the return value
- *	if return value == -1
- *	  issue a FAIL message, break remaining tests and cleanup
- *	if we are doing functional testing
- *	  save the return value from the getsid() call - the session ID
- *	  fork a child and get the child's session ID
- *	  if the child's session ID == the parent's session ID
- *	    issue a PASS message
- *	  else
- *	    issue a FAIL message
- *	else issue a PASS message
- *	call cleanup
- *
- * USAGE:  <for command-line>
- *  getsid01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
+/*\
+ * [Description]
  *
- * RESTRICTIONS
- *	none
+ * Verify that session IDs returned by getsid() (with argument pid=0)
+ * are same in parent and child process.
  */
-#define _GNU_SOURCE 1
 
-#include <errno.h>
-#include <sys/wait.h>
-#include <unistd.h>
-#include "test.h"
 
-void cleanup(void);
-void setup(void);
+#include "tst_test.h"
 
-char *TCID = "getsid01";
-int TST_TOTAL = 1;
+static pid_t p_sid;
 
-pid_t p_sid;
-
-int main(int ac, char **av)
+static void run(void)
 {
-	int lc;
-	pid_t pid, c_pid, c_sid;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();		/* global setup */
-
-	/* The following loop checks looping state if -i option given */
+	pid_t pid, c_sid;
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
+	TEST(getsid(0));
+	p_sid = TST_RET;
 
-		/* call the system call with the TEST() macro */
+	pid = SAFE_FORK();
 
+	if (pid == 0) {
 		TEST(getsid(0));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "call failed - errno = %d "
-				 "- %s", TEST_ERRNO, strerror(TEST_ERRNO));
-			continue;
-		}
-
-		/* save the return value in a global variable */
-		p_sid = TEST_RETURN;
-
-		if ((pid = FORK_OR_VFORK()) == -1) {
-			tst_brkm(TBROK, cleanup, "could not fork");
-		}
-
-		if (pid == 0) {	/* child */
-			if ((c_pid = getpid()) == -1) {
-				tst_resm(TINFO, "getpid failed in "
-					 "functionality test");
-				exit(1);
-			}
-
-			/*
-			 * if the session ID of the child is the
-			 * same as the parent then things look good
-			 */
-
-			if ((c_sid = getsid(0)) == -1) {
-				tst_resm(TINFO, "getsid failed in "
-					 "functionality test");
-				exit(2);
-			}
-
-			if (c_sid == p_sid) {
-				tst_resm(TPASS, "session ID is "
-					 "correct");
-			} else {
-				tst_resm(TFAIL, "session ID is "
-					 "not correct");
-			}
-			exit(0);
-
-		} else {
-			waitpid(pid, NULL, 0);
-		}
+		c_sid = TST_RET;
+		TST_EXP_EQ_LI(p_sid, c_sid);
+	} else {
+		SAFE_WAITPID(pid, NULL, 0);
 	}
-
-	cleanup();
-	tst_exit();
 }
 
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
-{
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-}
-
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
-void cleanup(void)
-{
-
-}
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1
+};
-- 
2.37.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
