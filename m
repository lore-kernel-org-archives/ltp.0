Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE00C43334
	for <ltp@archiver.kernel.org>; Thu,  7 Jul 2022 11:03:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BEBFF3C97F8
	for <ltp@archiver.kernel.org>; Thu,  7 Jul 2022 13:03:51 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCCBE3C004D
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 13:03:26 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4996A600E32
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 13:03:25 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ABE781F975
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 11:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657191805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Od2t0mU8ceCxJI+Jm/ogVHbMplTR7QHet+qjt116wY=;
 b=U3QxPyrLr6Fq/m7KkAohirVT72MFXp4FluqFfBCiLqpdw6sx8tBPI55sMAO6Ak01tBBTEJ
 EbuQyva8076ERkLUq/XFZlB8AGPYFCq5hr9Tls4eM0wantLuikjiolxsDt8JzgdzSIfRBv
 5yDJLSxOugxOAdxDTJ2ZCP77lOVoRlk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657191805;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Od2t0mU8ceCxJI+Jm/ogVHbMplTR7QHet+qjt116wY=;
 b=+2zj81rovy5Tgw1j6LbunkeQPRGfMWZb/4/zlW6zMbL/717Oezl9cRRNS6R5qeSBp6KH1D
 qkMux14VmBXaffCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2BAD913A33
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 11:03:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id j/yKN3y9xmJKRwAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Thu, 07 Jul 2022 11:03:24 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu,  7 Jul 2022 16:33:11 +0530
Message-Id: <20220707110319.24665-2-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220707110319.24665-1-akumar@suse.de>
References: <20220707110319.24665-1-akumar@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/9] Rewrite rename01.c using new LTP API
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
 testcases/kernel/syscalls/rename/rename01.c | 259 +++++---------------
 1 file changed, 58 insertions(+), 201 deletions(-)

diff --git a/testcases/kernel/syscalls/rename/rename01.c b/testcases/kernel/syscalls/rename/rename01.c
index e7de18ff4..695d85c57 100644
--- a/testcases/kernel/syscalls/rename/rename01.c
+++ b/testcases/kernel/syscalls/rename/rename01.c
@@ -1,218 +1,75 @@
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
- *	rename01
- *
- * DESCRIPTION
- *	This test will verify the rename(2) syscall basic functionality.
- *	Verify rename() works when the "new" file or directory does not exist.
+/*\
+ * [Description]
  *
- * ALGORITHM
- *	Setup:
- *		Setup signal handling.
- *		Create temporary directory.
- *		Pause for SIGUSR1 if option specified.
- *
- *	Test:
- *		Loop if the proper options are given.
- *              1.  "old" is plain file, new does not exists
- *                  create the "old" file, make sure the "new" file
- *                  dose not exist
- *                  rename the "old" to the "new" file
- *                  verify the "new" file points to the "old" file
- *                  verify the "old" file does not exist
- *
- *              2.  "old" is a directory,"new" does not exists
- *                  create the "old" directory, make sure "new"
- *                  dose not exist
- *                  rename the "old" to the "new"
- *                  verify the "new" points to the "old"
- *                  verify the "old" does not exist
- *	Cleanup:
- *		Print errno log and/or timing stats if options given
- *		Delete the temporary directory created.
- *
- * USAGE
- *	rename01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *	where,  -c n : Run n copies concurrently.
- *		-f   : Turn off functionality Testing.
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
+ * Verify rename() when the newpath file or directory does not exist.
  */
-#include <sys/types.h>
-#include <fcntl.h>
-#include <sys/stat.h>
-#include <unistd.h>
-#include <errno.h>
 
-#include "test.h"
-#include "safe_macros.h"
-
-void setup();
-void cleanup();
+#include <sys/stat.h>
+#include <stdio.h>
+#include "tst_test.h"
 
-char *TCID = "rename01";
-int TST_TOTAL = 2;
+#define SWAP(a, b) do { \
+		const char *tmp__ = a; \
+		a = b; \
+		b = tmp__; \
+} while (0)
 
-char fname[255], mname[255];
-char fdir[255], mdir[255];
-struct stat buf1;
-dev_t f_olddev, d_olddev;
-ino_t f_oldino, d_oldino;
+static const char *old_file_name = "oldfile";
+static const char *old_dir_name = "olddir";
+static const char *new_file_name = "newfile";
+static const char *new_dir_name = "newdir";
 
-struct test_case_t {
-	char *name1;
-	char *name2;
-	char *desc;
-	dev_t *olddev;
-	ino_t *oldino;
-} TC[] = {
-	/* comment goes here */
-	{
-	fname, mname, "file", &f_olddev, &f_oldino},
-	    /* comment goes here */
-	{
-	fdir, mdir, "directory", &d_olddev, &d_oldino}
-};
+static struct stat old_file_st, old_dir_st, new_file_st, new_dir_st;
 
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
-			TEST(rename(TC[i].name1, TC[i].name2));
-
-			if (TEST_RETURN == -1) {
-				tst_resm(TFAIL, "call failed unexpectedly");
-				continue;
-			}
-
-			SAFE_STAT(cleanup, TC[i].name2, &buf1);
-
-			/*
-			 * verify the new file or directory is the
-			 * same as the old one
-			 */
-			if (buf1.st_dev != *TC[i].olddev ||
-			    buf1.st_ino != *TC[i].oldino) {
-				tst_resm(TFAIL, "rename() failed: the "
-					 "new %s points to a different "
-					 "inode/location", TC[i].desc);
-				continue;
-			}
-			/*
-			 * verify that the old file or directory
-			 * does not exist
-			 */
-			if (stat(fname, &buf1) != -1) {
-				tst_resm(TFAIL, "the old %s still "
-					 "exists", TC[i].desc);
-				continue;
-			}
-
-			tst_resm(TPASS, "functionality is correct "
-				 "for renaming a %s", TC[i].desc);
-		}
-		/* reset things in case we are looping */
-		SAFE_RENAME(cleanup, mname, fname);
-
-		SAFE_RENAME(cleanup, mdir, fdir);
-	}
-
-	cleanup();
-	tst_exit();
+	SAFE_TOUCH(old_file_name, 0700, NULL);
+	SAFE_MKDIR(old_dir_name, 00770);
 
+	SAFE_STAT(old_file_name, &old_file_st);
+	SAFE_STAT(old_dir_name, &old_dir_st);
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
-	sprintf(mname, "./rnfile_%d", getpid());
-	sprintf(fdir, "./tdir_%d", getpid());
-	sprintf(mdir, "./rndir_%d", getpid());
-
-	SAFE_TOUCH(cleanup, fname, 0700, NULL);
-
-	SAFE_STAT(cleanup, fname, &buf1);
-
-	f_olddev = buf1.st_dev;
-	f_oldino = buf1.st_ino;
-
-	/* create "old" directory */
-	SAFE_MKDIR(cleanup, fdir, 00770);
-
-	SAFE_STAT(cleanup, fdir, &buf1);
-
-	d_olddev = buf1.st_dev;
-	d_oldino = buf1.st_ino;
+	TST_EXP_PASS(rename(old_file_name, new_file_name),
+						"rename(%s, %s)",
+						old_file_name, new_file_name);
+	TST_EXP_PASS(rename(old_dir_name, new_dir_name),
+						"rename(%s, %s)",
+						old_dir_name, new_dir_name);
+
+	SAFE_STAT(new_file_name, &new_file_st);
+	SAFE_STAT(new_dir_name, &new_dir_st);
+
+	TST_EXP_EQ_LI(old_file_st.st_dev, new_file_st.st_dev);
+	TST_EXP_EQ_LI(old_file_st.st_ino, new_file_st.st_ino);
+
+	TST_EXP_EQ_LI(old_dir_st.st_dev, new_dir_st.st_dev);
+	TST_EXP_EQ_LI(old_dir_st.st_ino, new_dir_st.st_ino);
+
+	TST_EXP_FAIL(stat(old_file_name, &old_file_st),
+				ENOENT,
+				"stat(%s, &old_file_st)",
+				old_file_name);
+	TST_EXP_FAIL(stat(old_dir_name, &old_dir_st),
+				ENOENT,
+				"stat(%s, &old_dir_st)",
+				old_dir_name);
+
+	SWAP(old_file_name, new_file_name);
+	SWAP(old_dir_name, new_dir_name);
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
