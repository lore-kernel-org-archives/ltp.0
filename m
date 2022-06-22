Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCA6C433EF
	for <ltp@archiver.kernel.org>; Wed, 22 Jun 2022 07:03:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 65A713C94DB
	for <ltp@archiver.kernel.org>; Wed, 22 Jun 2022 09:03:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D35823C94B4
 for <ltp@lists.linux.it>; Wed, 22 Jun 2022 09:02:06 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CEC2C1A00995
 for <ltp@lists.linux.it>; Wed, 22 Jun 2022 09:02:05 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1C15721C45;
 Wed, 22 Jun 2022 07:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1655881325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QshzFe8CSVqRo8F3onX4FK6+jSdZmHxWGikI3kqVAKQ=;
 b=vqwydKMN5qDCC+dxJBZUqrASKqlMDoOwt6ZF8uFv4Eu3U41BE+RiibS+7IL6ctiZvoPUhh
 J94nZBifALcKeryDD/LJrla0LvR9tpsdLaWE5BXmbpJJPwh+LayLSzHxJoBo63KLQvPGN5
 Y3KKBkX+/ze2HOlbVrwuD3IIJn5i/NM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1655881325;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QshzFe8CSVqRo8F3onX4FK6+jSdZmHxWGikI3kqVAKQ=;
 b=vXKIPICzEy817zP+vnLLi6q5CjcroOmrWIQ9YlIKtvo6MQgJ5naHS8Y5AFP69sELOIXCoe
 PTA54HGLEumzhLDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B7724134A9;
 Wed, 22 Jun 2022 07:02:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8tnwImy+smLsWgAAMHmgww
 (envelope-from <akumar@suse.de>); Wed, 22 Jun 2022 07:02:04 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Wed, 22 Jun 2022 12:31:37 +0530
Message-Id: <20220622070137.24286-10-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622070137.24286-1-akumar@suse.de>
References: <20220622070137.24286-1-akumar@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 9/9] Rewrite rename10.c using new LTP API
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
 testcases/kernel/syscalls/rename/rename10.c | 182 +++-----------------
 1 file changed, 22 insertions(+), 160 deletions(-)

diff --git a/testcases/kernel/syscalls/rename/rename10.c b/testcases/kernel/syscalls/rename/rename10.c
index 4f0933320..0b6865857 100644
--- a/testcases/kernel/syscalls/rename/rename10.c
+++ b/testcases/kernel/syscalls/rename/rename10.c
@@ -1,175 +1,37 @@
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
+ * [DESCRIPTION]
  *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- *	None.
+ * Verify that rename(2) fails and errno is set to ENAMETOOLONG, when
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
+static char long_path[PATH_MAX + 2] = {[0 ... PATH_MAX + 1] = 'a'};
 
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
+	.needs_tmpdir = 1
+};
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
