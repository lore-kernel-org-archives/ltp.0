Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9232C43334
	for <ltp@archiver.kernel.org>; Wed, 22 Jun 2022 07:02:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 74C0D3C9511
	for <ltp@archiver.kernel.org>; Wed, 22 Jun 2022 09:02:53 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 283EA3C9501
 for <ltp@lists.linux.it>; Wed, 22 Jun 2022 09:01:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1C58F1400199
 for <ltp@lists.linux.it>; Wed, 22 Jun 2022 09:01:54 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 78E331FA12;
 Wed, 22 Jun 2022 07:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1655881314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FHIfR8xH+Wez7cl8UROzaKYsRSF4ygwxyLFSXJ6LXBk=;
 b=QlgYlegdfug1q7aBZ/p/5R8pI9j/3UW8tvWt97oU5KzEPTihFxjFbA8I0hr6Ukj/SiqEVi
 ejQWjMQZTGzvTOY4db+0bVWo0RYuJTPS7AJs0t3N9s3BrmtuuJ4emPkSS/w5oNbyu+eMVF
 AWqTufR9xUHGK0t5rvbsNGenaJSF6Tw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1655881314;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FHIfR8xH+Wez7cl8UROzaKYsRSF4ygwxyLFSXJ6LXBk=;
 b=YPPMnv3/Sg2oWNJBIGGMyIIgj0MlcFcB0lE4PyzPC0X6mpt06M7mZKQ1RODWyC90SkhAPP
 g5mSDw6W9BlAv9BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 21597134A9;
 Wed, 22 Jun 2022 07:01:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id C9SxOWG+smLNWgAAMHmgww
 (envelope-from <akumar@suse.de>); Wed, 22 Jun 2022 07:01:53 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Wed, 22 Jun 2022 12:31:33 +0530
Message-Id: <20220622070137.24286-6-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622070137.24286-1-akumar@suse.de>
References: <20220622070137.24286-1-akumar@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/9] Rewrite rename05.c using new LTP API
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
 testcases/kernel/syscalls/rename/rename05.c | 189 +++-----------------
 1 file changed, 23 insertions(+), 166 deletions(-)

diff --git a/testcases/kernel/syscalls/rename/rename05.c b/testcases/kernel/syscalls/rename/rename05.c
index db10720fe..6e9fb8a0d 100644
--- a/testcases/kernel/syscalls/rename/rename05.c
+++ b/testcases/kernel/syscalls/rename/rename05.c
@@ -1,179 +1,36 @@
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
- *	rename05
- *
- * DESCRIPTION
- *	This test will verify that rename(2) fails with EISDIR
- *
- * ALGORITHM
- *	Setup:
- *		Setup signal handling.
- *		Create temporary directory.
- *		Pause for SIGUSR1 if option specified.
- *              create the "old" file and the "new" directory
- *              rename the "old" file to the "new" directory
- *
- *	Test:
- *		Loop if the proper options are given.
- *                  verify rename() failed and returned EISDIR
- *
- *	Cleanup:
- *		Print errno log and/or timing stats if options given
- *		Delete the temporary directory created.
- *
- * USAGE
- *	rename05 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *	where,  -c n : Run n copies concurrently.
- *		-e   : Turn on errno logging.
- *		-i n : Execute test n times.
- *		-I x : Execute test for x seconds.
- *		-P x : Pause for x seconds between iterations.
- *		-t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- *	None.
+/*\
+ * [DESCRIPTION]
+ * Verify that rename(2) fails and errno is set to EISDIR when
+ * oldpath is not a directory and newpath is an existing directory.
  */
-#include <sys/types.h>
-#include <fcntl.h>
-#include <sys/stat.h>
-#include <unistd.h>
-#include <errno.h>
-
-#include "test.h"
-#include "safe_macros.h"
 
-void setup();
-void cleanup();
+#include <stdio.h>
+#include "tst_test.h"
 
-char *TCID = "rename05";
-int TST_TOTAL = 1;
+#define TEMP_FILE "tmpfile"
+#define TEMP_DIR "tmpdir"
 
-int fd;
-char fname[255], mdir[255];
-struct stat buf1, buf2;
-dev_t olddev, olddev1;
-ino_t oldino, oldino1;
-
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
-		/* attempt to rename a file to a directory */
-		/* Call rename(2) */
-		TEST(rename(fname, mdir));
-
-		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "rename(%s, %s) succeed unexpected",
-				 fname, mdir);
-			continue;
-		}
-
-		if (errno != EISDIR) {
-			tst_resm(TFAIL, "Expected EISDIR got %d", TEST_ERRNO);
-		} else {
-			tst_resm(TPASS, "rename() returned EISDIR");
-		}
-	}
-
-	/*
-	 * cleanup and exit
-	 */
-	cleanup();
-	tst_exit();
-
+	SAFE_TOUCH(TEMP_FILE, 0700, NULL);
+	SAFE_MKDIR(TEMP_DIR, 00770);
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
-	sprintf(mdir, "./rndir_%d", getpid());
-	sprintf(fname, "./tfile_%d", getpid());
-
-	/* create "old" file */
-	SAFE_TOUCH(cleanup, fname, 0700, NULL);
-	SAFE_STAT(cleanup, fname, &buf1);
-
-	/* save "old"'s dev and ino */
-	olddev = buf1.st_dev;
-	oldino = buf1.st_ino;
-
-	/* create another directory */
-	if (stat(mdir, &buf2) != -1) {
-		tst_brkm(TBROK, cleanup, "tmp directory %s found!", mdir);
-	}
-
-	SAFE_MKDIR(cleanup, mdir, 00770);
-
-	SAFE_STAT(cleanup, mdir, &buf2);
-
-	/* save "new"'s dev and ino */
-	olddev1 = buf2.st_dev;
-	oldino1 = buf2.st_ino;
+	TST_EXP_FAIL(rename(TEMP_FILE, TEMP_DIR),
+				EISDIR);
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *              completion or premature exit.
- */
-void cleanup(void)
-{
-
-	/*
-	 * Remove the temporary directory.
-	 */
-	tst_rmdir();
-
-	/*
-	 * Exit with return code appropriate for results.
-	 */
-
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
