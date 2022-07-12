Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4A7C433EF
	for <ltp@archiver.kernel.org>; Tue, 12 Jul 2022 15:34:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 94EB13CA607
	for <ltp@archiver.kernel.org>; Tue, 12 Jul 2022 17:34:57 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 134423CA588
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 17:34:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D46D21400DB8
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 17:34:25 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 13C7622A1B
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 15:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657640064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KjIpS9XtjMKRf3y+1UeZNbAdfMoN2Le3jQYRxDXczkI=;
 b=Utr0Xd2TvU495CAvj3iZwnhjgekNgxgGdez1o8I3bIW4cpG0upiQ5tnJxhIlX7ZFl5V1rW
 gUKFitexlAV8wNgqtNYHj6PrhVK+0N7Tj8kE9ScJkoSG4sk8BJIExQw0lG9X0SRRrhgD3W
 HRJE+2/cGPTbJISTWLzhkDfp3l5nt8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657640064;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KjIpS9XtjMKRf3y+1UeZNbAdfMoN2Le3jQYRxDXczkI=;
 b=yN0b9ZbXm4SfVA4srJ1rDnZ2NzWTli0p4eJVjpRROEQJth4ZV+TacMsvQiu6JDyOxbspRS
 vcaOUreYDtPGafCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7853613A94
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 15:34:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id DOE+Dn+UzWIofAAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 15:34:23 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Tue, 12 Jul 2022 21:04:09 +0530
Message-Id: <20220712153417.14551-2-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220712153417.14551-1-akumar@suse.de>
References: <20220712153417.14551-1-akumar@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/9] Rewrite rename01.c using new LTP API
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

Rewrite using new LTP API and enable the test to run on all filesystems

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/rename/rename01.c | 267 +++++---------------
 1 file changed, 66 insertions(+), 201 deletions(-)

diff --git a/testcases/kernel/syscalls/rename/rename01.c b/testcases/kernel/syscalls/rename/rename01.c
index e7de18ff4..159341d09 100644
--- a/testcases/kernel/syscalls/rename/rename01.c
+++ b/testcases/kernel/syscalls/rename/rename01.c
@@ -1,218 +1,83 @@
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
- *
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
+/*\
+ * [Description]
  *
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
- */
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
-
-char *TCID = "rename01";
-int TST_TOTAL = 2;
-
-char fname[255], mname[255];
-char fdir[255], mdir[255];
-struct stat buf1;
-dev_t f_olddev, d_olddev;
-ino_t f_oldino, d_oldino;
-
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
-
-int main(int ac, char **av)
-{
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
-
-}
-
-/*
- * setup() - performs all ONE TIME setup for this test.
+ * Verify rename() when the newpath file or directory does not exist.
  */
-void setup(void)
-{
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
-	TEST_PAUSE;
+#include <stdio.h>
+#include "tst_test.h"
 
-	/* Create a temporary directory and make it current. */
-	tst_tmpdir();
+#define MNT_POINT "mntpoint"
 
-	sprintf(fname, "./tfile_%d", getpid());
-	sprintf(mname, "./rnfile_%d", getpid());
-	sprintf(fdir, "./tdir_%d", getpid());
-	sprintf(mdir, "./rndir_%d", getpid());
+static const char *old_file_name = "oldfile";
+static const char *old_dir_name = "olddir";
+static const char *new_file_name = "newfile";
+static const char *new_dir_name = "newdir";
 
-	SAFE_TOUCH(cleanup, fname, 0700, NULL);
+static struct stat old_file_st, old_dir_st, new_file_st, new_dir_st;
 
-	SAFE_STAT(cleanup, fname, &buf1);
-
-	f_olddev = buf1.st_dev;
-	f_oldino = buf1.st_ino;
+static inline void swap(const char **a, const char **b)
+{
+	const char *tmp__ = *a;
+	*a = *b;
+	*b = tmp__;
+}
 
-	/* create "old" directory */
-	SAFE_MKDIR(cleanup, fdir, 00770);
+static void setup(void)
+{
+	SAFE_CHDIR(MNT_POINT);
 
-	SAFE_STAT(cleanup, fdir, &buf1);
+	SAFE_TOUCH(old_file_name, 0700, NULL);
+	SAFE_MKDIR(old_dir_name, 00770);
 
-	d_olddev = buf1.st_dev;
-	d_oldino = buf1.st_ino;
+	SAFE_STAT(old_file_name, &old_file_st);
+	SAFE_STAT(old_dir_name, &old_dir_st);
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- */
-void cleanup(void)
+static void run(void)
 {
-
-	/*
-	 * Remove the temporary directory.
-	 */
-	tst_rmdir();
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
+	TST_EXP_EQ_LU(old_file_st.st_dev, new_file_st.st_dev);
+	TST_EXP_EQ_LU(old_file_st.st_ino, new_file_st.st_ino);
+
+	TST_EXP_EQ_LU(old_dir_st.st_dev, new_dir_st.st_dev);
+	TST_EXP_EQ_LU(old_dir_st.st_ino, new_dir_st.st_ino);
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
+	/* reset between loops */
+	swap(&old_file_name, &new_file_name);
+	swap(&old_dir_name, &new_dir_name);
 }
+
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
