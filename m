Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D3ABC433FE
	for <ltp@archiver.kernel.org>; Wed, 23 Nov 2022 16:13:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 18EBC3CC9EF
	for <ltp@archiver.kernel.org>; Wed, 23 Nov 2022 17:13:30 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F2C433CB765
 for <ltp@lists.linux.it>; Wed, 23 Nov 2022 17:13:20 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B29501A0066D
 for <ltp@lists.linux.it>; Wed, 23 Nov 2022 17:13:19 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A012F1F88D
 for <ltp@lists.linux.it>; Wed, 23 Nov 2022 16:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1669219998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1ODTqk03SqcFsGDLlEiqQJkOp+73dsezyTBuxVZG1wg=;
 b=KvNdl/xGdPh4WIbPgq+E22SSWZmU/aeTt7eceGfyujgq43AQpBmXWpBuUDRvaYNtXJiUlL
 7m0+uNrAMck7WrxV+mIDNU2hO2sXrVzgmBp4vjVfHE3AGR+/jiGOTSBQvJbuQ/6smVaa7f
 b61dou7Eq3qOUWMsXrqyvDlsyG+zRVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1669219998;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1ODTqk03SqcFsGDLlEiqQJkOp+73dsezyTBuxVZG1wg=;
 b=ej5ZKCrhJ2nNTZv8qS68SvAjxJ5F/9bBdpQTjNokwbdQIW12z9AG02aDyybdtICccqsOeR
 wElT1V/tFgvCNsDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D29313A37
 for <ltp@lists.linux.it>; Wed, 23 Nov 2022 16:13:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id z1jLM51GfmPjVgAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Wed, 23 Nov 2022 16:13:17 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Wed, 23 Nov 2022 21:43:15 +0530
Message-Id: <20221123161315.7891-1-akumar@suse.de>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] statfs03: Rewrite using new LTP API
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
 testcases/kernel/syscalls/statfs/statfs03.c | 173 +++-----------------
 1 file changed, 27 insertions(+), 146 deletions(-)

diff --git a/testcases/kernel/syscalls/statfs/statfs03.c b/testcases/kernel/syscalls/statfs/statfs03.c
index 32aaf830e..2afdbbf04 100644
--- a/testcases/kernel/syscalls/statfs/statfs03.c
+++ b/testcases/kernel/syscalls/statfs/statfs03.c
@@ -1,165 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
 /*
- *
  *   Copyright (C) Bull S.A. 2001
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
+ *		05/2002 Ported by Jacky Malcles
+ *   Copyright (c) 2022 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
 
-/*
- * NAME
- *	statfs03.c
- *
- * DESCRIPTION
- *	Testcase to check that statfs(2) sets errno to EACCES when
- *	search permission is denied for a component of the path prefix of path.
- *
- * ALGORITHM
- *	 Use a component of the pathname, where search permission
- *	 is denied for a component of the path prefix of path.
- *
- * USAGE:  <for command-line>
- *  statfs03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * HISTORY
- *	05/2002 Ported by Jacky Malcles
- *
- * RESTRICTIONS
- *	NONE
+/*\
+ * [Description]
  *
+ * Verify that statfs(2) fails with errno EACCES when search permission
+ * is denied for a component of the path prefix of path.
  */
-#include <sys/types.h>
-#include <sys/statfs.h>
-#include <sys/stat.h>
-#include <sys/vfs.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <stdio.h>
-#include "test.h"
-#include "safe_macros.h"
-#include <pwd.h>
-
-char *TCID = "statfs03";
-int TST_TOTAL = 1;
-int fileHandle = 0;
 
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
-
-char fname[30] = "testfile";
-char path[50];
-struct statfs buf;
+#include <pwd.h>
+#include "tst_test.h"
 
-void setup(void);
-void cleanup(void);
+#define TEMP_DIR "testdir"
+#define TEMP_DIR2 TEMP_DIR"/subdir"
 
-int main(int ac, char **av)
+static void setup(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
+	struct passwd *ltpuser;
 
-		TEST(statfs(path, &buf));
+	SAFE_MKDIR(TEMP_DIR, 0444);
+	SAFE_MKDIR(TEMP_DIR2, 0444);
 
-		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "call succeeded unexpectedly");
-
-		} else {
-
-			if (TEST_ERRNO == EACCES) {
-				tst_resm(TPASS, "expected failure - "
-					 "errno = %d : %s", TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			} else {
-				tst_resm(TFAIL, "unexpected error - %d : %s - "
-					 "expected %d", TEST_ERRNO,
-					 strerror(TEST_ERRNO), EACCES);
-			}
-		}
-	}
-
-	cleanup();
-	tst_exit();
+	ltpuser = SAFE_GETPWNAM("nobody");
+	SAFE_SETEUID(ltpuser->pw_uid);
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
+static void run(void)
 {
+	struct statfs buf;
 
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	/* make a temporary directory and cd to it */
-	tst_tmpdir();
-	SAFE_CHMOD(cleanup, tst_get_tmpdir(), S_IRWXU);
-
-	/* create a test file */
-	sprintf(fname, "%s.%d", fname, getpid());
-	if (mkdir(fname, 0444) == -1) {
-		tst_resm(TFAIL, "creat(2) FAILED to creat temp file");
-	} else {
-		sprintf(path, "%s/%s", fname, fname);
-		if ((fileHandle = creat(path, 0444)) == -1)
-			tst_brkm(TFAIL | TERRNO, cleanup, "creat failed");
-	}
-
-	ltpuser = getpwnam(nobody_uid);
-	if (ltpuser == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup, "getpwnam failed");
-	if (seteuid(ltpuser->pw_uid) == -1) {
-		tst_resm(TINFO | TERRNO, "seteuid failed to "
-			 "to set the effective uid to %d", ltpuser->pw_uid);
-	}
-
+	TST_EXP_FAIL(statfs(TEMP_DIR2, &buf), EACCES);
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- */
-void cleanup(void)
-{
-	/* reset the process ID to the saved ID (root) */
-	if (setuid(0) == -1) {
-		tst_resm(TINFO, "setuid(0) failed");
-	}
-
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
-	close(fileHandle);
-
-	/* delete the test directory created in setup() */
-	tst_rmdir();
-
-}
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.needs_tmpdir = 1,
+	.needs_root = 1
+};
-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
