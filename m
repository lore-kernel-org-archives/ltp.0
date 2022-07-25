Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61F8C433EF
	for <ltp@archiver.kernel.org>; Mon, 25 Jul 2022 17:38:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF7903C97DD
	for <ltp@archiver.kernel.org>; Mon, 25 Jul 2022 19:38:34 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 639053C04EF
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 19:38:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A9A6E140020C
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 19:38:23 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0406F34ACE
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 17:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1658770703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LUh3lK/WIIKgmcBjKrUo3gBhoyvWrldrxd64/da+beI=;
 b=kNaiBjYcna4bdbsjlg46/7ESJLe+Msg6w34sPxMHMnJ2lukwf4HxbZGdQQ7sRI2NMkhU24
 aV74UoPKwGY/4DbeJM1Y1op2M3ZUMpCfKWFHr8HhED+rcsxWiBVzjFoyTuU8esHRrski+6
 VxiEtaxLkkbrqQPOcAxUWUFK26HVhP0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1658770703;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LUh3lK/WIIKgmcBjKrUo3gBhoyvWrldrxd64/da+beI=;
 b=VcWa2GF78mpctJIXb84M9dCzn8vcgKSHY0qgSRSNTyZBMhhgv+NMWi4IkKwFZjBXlF6EW2
 6SICdb2qBgcoRcDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7181C13ABB
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 17:38:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XZgyDA7V3mJEZwAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 17:38:22 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Mon, 25 Jul 2022 23:08:19 +0530
Message-Id: <20220725173819.9669-1-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] rename13.c: Convert to new LTP API
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

Rewrite test using new LTP API and enable on all supporting filesystems

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/rename/rename13.c | 206 ++++----------------
 1 file changed, 37 insertions(+), 169 deletions(-)

diff --git a/testcases/kernel/syscalls/rename/rename13.c b/testcases/kernel/syscalls/rename/rename13.c
index 07a90c4d1..51490db75 100644
--- a/testcases/kernel/syscalls/rename/rename13.c
+++ b/testcases/kernel/syscalls/rename/rename13.c
@@ -1,186 +1,54 @@
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
- *	rename13
- *
- * DESCRIPTION
- *	Verify rename() return successfully and performs no other action
- *      when "old" file and "new" file link to the same file.
- *
- * ALGORITHM
- *	Setup:
- *		Setup signal handling.
- *		Create temporary directory.
- *		Pause for SIGUSR1 if option specified.
- *
- *	Test:
- *		Loop if the proper options are given.
- *                  create the "old" file
- *                  link the "new" file to the "old" file
- *                  rename the "old" to the "new" file
- *                  verify the "new" file points to the original file
- *                  verify the "old" file exists and points to
- *                         the original file
- *	Cleanup:
- *		Print errno log and/or timing stats if options given
- *		Delete the temporary directory created.
- *
- * USAGE
- *	rename13 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *	where,  -c n : Run n copies concurrently.
- *		-f   : Turn off functionality Testing.
- *		-i n : Execute test n times.
- *		-I x : Execute test for x seconds.
- *		-P x : Pause for x seconds between iterations.
- *		-t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
+/*\
+ * [Description]
  *
- * RESTRICTIONS
- *	None.
+ * Verify that rename() does nothing and returns a success status when
+ * oldpath and newpath are existing hard links referring to the same file.
  */
-#include <sys/types.h>
-#include <fcntl.h>
-#include <sys/stat.h>
-#include <unistd.h>
-#include <errno.h>
 
-#include "test.h"
-#include "safe_macros.h"
+#include <stdio.h>
+#include "tst_test.h"
 
-void setup();
-void cleanup();
+#define MNT_POINT "mntpoint"
+#define TEMP_FILE1 MNT_POINT"/tmpfile1"
+#define TEMP_FILE2 MNT_POINT"/tmpfile2"
 
-char *TCID = "rename13";
-int TST_TOTAL = 1;
+static struct stat buf1, buf2;
 
-int fd;
-char fname[255], mname[255];
-struct stat buf1, buf2;
-dev_t olddev;
-ino_t oldino;
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
-		/*
-		 * TEST rename()works when
-		 * both old file and new file link to the same file
-		 */
-
-		/* Call rename(2) */
-		TEST(rename(fname, mname));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "rename(%s, %s) failed", fname, mname);
-			continue;
-		}
-
-		/* check the existence of "new", and get the status */
-		SAFE_STAT(cleanup, mname, &buf2);
-
-		/* check the existence of "old", and get the status */
-		SAFE_STAT(cleanup, fname, &buf1);
-
-		/* verify the new file is the same as the original */
-		if (buf2.st_dev != olddev || buf2.st_ino != oldino) {
-			tst_resm(TFAIL,
-				 "rename() failed: new file does "
-				 "not point to the same file as old "
-				 "file");
-			continue;
-		}
-
-		/* verify the old file is unchanged */
-		if (buf1.st_dev != olddev || buf1.st_ino != oldino) {
-			tst_resm(TFAIL,
-				 "rename() failed: old file does "
-				 "not point to the original file");
-			continue;
-		}
-
-		tst_resm(TPASS, "functionality of rename() is correct");
-	}
-
-	cleanup();
-	tst_exit();
+	SAFE_TOUCH(TEMP_FILE1, 0700, NULL);
+	SAFE_STAT(TEMP_FILE1, &buf1);
+	SAFE_LINK(TEMP_FILE1, TEMP_FILE2);
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
+static void run(void)
 {
+	TST_EXP_PASS(rename(TEMP_FILE1, TEMP_FILE1));
+	if (TST_RET != 0)
+		return;
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	/* Create a temporary directory and make it current. */
-	tst_tmpdir();
-
-	sprintf(fname, "./tfile_%d", getpid());
-	sprintf(mname, "./rnfile_%d", getpid());
-
-	SAFE_TOUCH(cleanup, fname, 0700, NULL);
-
-	SAFE_STAT(cleanup, fname, &buf1);
-
-	/* save the dev and inode */
-	olddev = buf1.st_dev;
-	oldino = buf1.st_ino;
-
-	/* link the "new" file to the "old" file */
-	SAFE_LINK(cleanup, fname, mname);
+	SAFE_STAT(TEMP_FILE2, &buf2);
+	TST_EXP_EQ_LU(buf1.st_dev, buf2.st_dev);
+	TST_EXP_EQ_LU(buf1.st_ino, buf2.st_ino);
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
-
-}
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.needs_root = 1,
+	.mntpoint = MNT_POINT,
+	.mount_device = 1,
+	.all_filesystems = 1,
+	.skip_filesystems = (const char *const[]){
+		"exfat",
+		"vfat",
+		NULL
+	},
+};
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
