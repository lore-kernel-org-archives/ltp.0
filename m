Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20759C43334
	for <ltp@archiver.kernel.org>; Tue, 12 Jul 2022 15:36:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C6C63CA834
	for <ltp@archiver.kernel.org>; Tue, 12 Jul 2022 17:36:24 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B22B33CA584
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 17:34:53 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E5E071400DA4
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 17:34:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 49D0A1F980
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 15:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657640092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dCy8kNQLeK3ujTfnYvOWx1qLJGhi4gcggxr0ViiC728=;
 b=bPGFW7F8ivf3zRCelEcL8OzE5pzNtLWzwfHjmhyIqB5qyPK0OLjH0PUWTYR3iIoHIHr6zX
 IeONcOg0gQ/FZ+i17BdvOMZ/BPmkLXX61EiRqZxu47yCvPkXcSLroHrHPBXXBxseJE2Cnl
 obSk137IF8bMrbPWRfKeJ4tOg92SjL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657640092;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dCy8kNQLeK3ujTfnYvOWx1qLJGhi4gcggxr0ViiC728=;
 b=6NcSwK8VMX4QyfVbeuHPRgvaMLxKnL9ZoWWLoehky6UK10CcbMcOpQ61bycAxyGGkRtwzX
 nxVCPhdVjx0fpIDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB79313A94
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 15:34:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rcDHHpuUzWJafAAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 15:34:51 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Tue, 12 Jul 2022 21:04:17 +0530
Message-Id: <20220712153417.14551-10-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220712153417.14551-1-akumar@suse.de>
References: <20220712153417.14551-1-akumar@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 9/9] Rewrite rename10.c using new LTP API
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

Rewrite using new LTP API and enable all filesystems

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/rename/rename10.c | 187 +++-----------------
 1 file changed, 27 insertions(+), 160 deletions(-)

diff --git a/testcases/kernel/syscalls/rename/rename10.c b/testcases/kernel/syscalls/rename/rename10.c
index 4f0933320..444f65366 100644
--- a/testcases/kernel/syscalls/rename/rename10.c
+++ b/testcases/kernel/syscalls/rename/rename10.c
@@ -1,175 +1,42 @@
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
+ *  07/2001 Ported by Wayne Boyer
+ * Copyright (c) 2022 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
 
-/*
- * NAME
- *	rename10
- *
- * DESCRIPTION
- *	This test will verify that rename(2) syscall fails with ENAMETOOLONG
- *      and ENOENT
- *
- * ALGORITHM
- *	Setup:
- *		Setup signal handling.
- *		Create temporary directory.
- *		Pause for SIGUSR1 if option specified.
- *              create the "old" file
- *
- *	Test:
- *		Loop if the proper options are given.
- *              1.  rename the "old" to the "new" file
- *                  verify rename() failed with error ENAMETOOLONG
- *
- *              2.  "new" path contains a directory that does not exist
- *                  rename the "old" to the "new"
- *                  verify rename() failed with error ENOENT
- *	Cleanup:
- *		Print errno log and/or timing stats if options given
- *		Delete the temporary directory created.*
- *
- * USAGE
- *	rename10 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *	where,  -c n : Run n copies concurrently.
- *		-e   : Turn on errno logging.
- *		-i n : Execute test n times.
- *		-I x : Execute test for x seconds.
- *		-P x : Pause for x seconds between iterations.
- *		-t   : Turn on syscall timing.
+/*\
+ * [Description]
  *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- *	None.
+ * Verify that rename(2) fails with ENAMETOOLONG, when
+ * oldpath or newpath is too long.
  */
-#include <sys/types.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include <errno.h>
-
-#include "test.h"
-
-void setup();
-void cleanup();
 
-char *TCID = "rename10";
-int TST_TOTAL = 2;
+#include <stdio.h>
+#include "tst_test.h"
 
-char badmname[] =
-    "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyz";
+#define MNT_POINT "mntpoint"
+#define TEMP_FILE "tmpfile"
 
-int fd;
-char fname[255], mname[255];
-char mdir[255];
-
-struct test_case_t {
-	char *fd1;
-	char *fd2;
-	int error;
-} TC[] = {
-	/* badmname is too long for a file name - ENAMETOOLONG */
-	{
-	fname, badmname, ENAMETOOLONG},
-	    /* mname contains a directory component which does not exist - ENOENT */
-	{
-	fname, mname, ENOENT}
-};
+static char long_path[NAME_MAX + 1] = {[0 ... NAME_MAX] = 'a'};
 
-int main(int ac, char **av)
+static void setup(void)
 {
-	int lc;
-	int i;
-
-	/*
-	 * parse standard options
-	 */
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	/*
-	 * perform global setup for test
-	 */
-	setup();
-
-	/*
-	 * check looping state if -i option given
-	 */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		/* loop through the test cases */
-		for (i = 0; i < TST_TOTAL; i++) {
-
-			TEST(rename(TC[i].fd1, TC[i].fd2));
-
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "call succeeded unexpectedly");
-				continue;
-			}
-
-			if (TEST_ERRNO == TC[i].error) {
-				tst_resm(TPASS, "expected failure - "
-					 "errno = %d : %s", TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			} else {
-				tst_resm(TFAIL, "unexpected error - %d : %s - "
-					 "expected %d", TEST_ERRNO,
-					 strerror(TEST_ERRNO), TC[i].error);
-			}
-		}
-	}
-
-	cleanup();
-	tst_exit();
-
+	SAFE_CHDIR(MNT_POINT);
+	SAFE_TOUCH(TEMP_FILE, 0700, NULL);
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
+static void run(void)
 {
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	/* Create a temporary directory and make it current. */
-	tst_tmpdir();
-
-	sprintf(fname, "./tfile_%d", getpid());
-	sprintf(mdir, "./rndir_%d", getpid());
-	sprintf(mname, "%s/rnfile_%d", mdir, getpid());
-
-	SAFE_TOUCH(cleanup, fname, 0700, NULL);
+	TST_EXP_FAIL(rename(TEMP_FILE, long_path),
+				ENAMETOOLONG);
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- */
-void cleanup(void)
-{
-
-	/*
-	 * Remove the temporary directory.
-	 */
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.needs_root = 1,
+	.mount_device = 1,
+	.mntpoint = MNT_POINT,
+	.all_filesystems = 1
+};
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
