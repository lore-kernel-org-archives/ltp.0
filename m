Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08046C433EF
	for <ltp@archiver.kernel.org>; Thu,  7 Jul 2022 11:04:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F66A3C972D
	for <ltp@archiver.kernel.org>; Thu,  7 Jul 2022 13:04:51 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E44A83C9834
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 13:03:44 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A4C10200C28
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 13:03:43 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 05F0F221CF
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 11:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657191823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E7SVjTHTN+Rkwsj7SMO6ROYNKw9n4S4gDk7e6SVppOg=;
 b=BfBYyuVOyrpp/iZfYxEB6pnIaQcMEq0GXry5GqNC30HxSqSh5aZmXMEhWU6WsgdUGqmYb0
 lKXq56QAySaMBkpVKc9p3hynnvZJQSvt0E4jFayHQH+Wg6+1pKSA0nOZ+260nd/PVXNdss
 UvzzQFzv8NuS67m2KrBxtVS289aHMjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657191823;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E7SVjTHTN+Rkwsj7SMO6ROYNKw9n4S4gDk7e6SVppOg=;
 b=Yg8v4BZp6/Q1vcNK0vC8PtginZ2aYeJEhM+rqiOvngoocoz9S0jDCHXF0qx52DMOaSSYRu
 KGOJvXdfVeMkdZAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 79E4B13A33
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 11:03:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iqUDD469xmJ3RwAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Thu, 07 Jul 2022 11:03:42 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu,  7 Jul 2022 16:33:16 +0530
Message-Id: <20220707110319.24665-7-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220707110319.24665-1-akumar@suse.de>
References: <20220707110319.24665-1-akumar@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 6/9] Rewrite rename06.c using new LTP API
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
 testcases/kernel/syscalls/rename/rename06.c | 182 +++-----------------
 1 file changed, 23 insertions(+), 159 deletions(-)

diff --git a/testcases/kernel/syscalls/rename/rename06.c b/testcases/kernel/syscalls/rename/rename06.c
index e415b4158..5cbc3b25b 100644
--- a/testcases/kernel/syscalls/rename/rename06.c
+++ b/testcases/kernel/syscalls/rename/rename06.c
@@ -1,173 +1,37 @@
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
- *	rename06
- *
- * DESCRIPTION
- *	This test will verify that rename(2) failed in EINVAL
- *
- * ALGORITHM
- *	Setup:
- *		Setup signal handling.
- *		Create temporary directory.
- *		Pause for SIGUSR1 if option specified.
- *              create the "old" directory
- *              create the "new" directory under the "old" directory
- *
- *	Test:
- *		Loop if the proper options are given.
- *                  rename the "old" to the "new" directory
- *                  verify rename() failed and returned EINVAL
- *
- *	Cleanup:
- *		Print errno log and/or timing stats if options given
- *		Delete the temporary directory created.
- *
- * USAGE
- *	rename06 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
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
+ * Verify that rename(2) fails with EINVAL when
+ * an attempt is made to make a directory a subdirectory of itself.
  */
-#include <sys/types.h>
-#include <fcntl.h>
-#include <sys/stat.h>
-#include <unistd.h>
-#include <errno.h>
-
-#include "test.h"
-#include "safe_macros.h"
-
-void setup();
-void cleanup();
 
-char *TCID = "rename06";
-int TST_TOTAL = 1;
+#include <stdio.h>
+#include "tst_test.h"
 
-int fd;
-char fdir[255], mdir[255];
-struct stat buf1, buf2;
-dev_t olddev, olddev1;
-ino_t oldino, oldino1;
+#define DIR1 "dir1"
+#define DIR2 DIR1"/dir2"
 
-int main(int ac, char **av)
+static void setup(void)
 {
-	int lc;
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
-		/* rename a directory to a subdirectory of itself */
-		/* Call rename(2) */
-		TEST(rename(fdir, mdir));
-
-		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "rename(%s, %s) succeed unexpected",
-				 fdir, mdir);
-			continue;
-		}
-
-		if (errno != EINVAL) {
-			tst_resm(TFAIL, "Expected EINVAL got %d", TEST_ERRNO);
-		} else {
-			tst_resm(TPASS, "rename() returned EINVAL");
-		}
-	}
-
-	cleanup();
-	tst_exit();
-
+	SAFE_MKDIR(DIR1, 00770);
+	SAFE_MKDIR(DIR2, 00770);
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
-	sprintf(fdir, "./tdir_%d", getpid());
-	sprintf(mdir, "%s/rndir_%d", fdir, getpid());
-
-	/* create "old" directory */
-	if (stat(fdir, &buf1) != -1) {
-		tst_brkm(TBROK, cleanup, "tmp directory %s found!", fdir);
-	}
-	SAFE_MKDIR(cleanup, fdir, 00770);
-	SAFE_STAT(cleanup, fdir, &buf1);
-	/* save "old"'s dev and ino */
-	olddev = buf1.st_dev;
-	oldino = buf1.st_ino;
-
-	/* create another directory */
-	if (stat(mdir, &buf2) != -1) {
-		tst_brkm(TBROK, cleanup, "tmp directory %s found!", mdir);
-	}
-	SAFE_MKDIR(cleanup, mdir, 00770);
-
-	SAFE_STAT(cleanup, mdir, &buf2);
-
-	/* save "new"'s dev and ino */
-	olddev1 = buf2.st_dev;
-	oldino1 = buf2.st_ino;
+	TST_EXP_FAIL(rename(DIR1, DIR2),
+				EINVAL);
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
