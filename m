Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BEBDC43334
	for <ltp@archiver.kernel.org>; Tue, 12 Jul 2022 15:36:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7D633CA771
	for <ltp@archiver.kernel.org>; Tue, 12 Jul 2022 17:35:59 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 94DB23CA25D
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 17:34:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EB00C600944
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 17:34:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 43B5422A79
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 15:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657640085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dpCk4BE2+utaujLpgELEsJcFf2tnc4mhjWG43gFyoeg=;
 b=zc2NcOIFE/cjsSlCbES2IduShjhvmjRIzJJbqf/YCDLnuDym8AB+cvvR2ahYJXS3lcyW+/
 uBSx/fNZ/ch5aBBa+kMSaJwulF/GNQZwW1tIpJcvc7Xuz5GiY1ZtzpGS+DJyaitGEfLRtU
 jSgzCtR+MfMfapL+gSn0cGCZZz4WZsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657640085;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dpCk4BE2+utaujLpgELEsJcFf2tnc4mhjWG43gFyoeg=;
 b=Zma8JfJN7xMMilvfZ/HDU1zNONXQhVNHHb0ZncJ3VdsRLWpCRkaJoptgXp5OlvVlajx2Ey
 vVpzBWhBSZp86SAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B342313A94
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 15:34:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /xjDHJSUzWJHfAAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 15:34:44 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Tue, 12 Jul 2022 21:04:15 +0530
Message-Id: <20220712153417.14551-8-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220712153417.14551-1-akumar@suse.de>
References: <20220712153417.14551-1-akumar@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 7/9] Rewrite rename07.c using new LTP API
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
 testcases/kernel/syscalls/rename/rename07.c | 171 ++++----------------
 1 file changed, 30 insertions(+), 141 deletions(-)

diff --git a/testcases/kernel/syscalls/rename/rename07.c b/testcases/kernel/syscalls/rename/rename07.c
index 5b95f84bb..51338dbf4 100644
--- a/testcases/kernel/syscalls/rename/rename07.c
+++ b/testcases/kernel/syscalls/rename/rename07.c
@@ -1,154 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * NAME
- *	rename07
- *
- * DESCRIPTION
- *	This test will verify that rename(2) failed in ENOTDIR
- *
- * CALLS
- *	stat,open,rename,mkdir,close
- *
- * ALGORITHM
- *	Setup:
- *		Setup signal handling.
- *		Create temporary directory.
- *		Pause for SIGUSR1 if option specified.
- *              create the "old" directory and the "new" file
- *              rename the "old" directory to the "new" file
- *
- *	Test:
- *		Loop if the proper options are given.
- *                  verify rename() failed and returned ENOTDIR
- *
- *	Cleanup:
- *		Print errno log and/or timing stats if options given
- *		Delete the temporary directory created.*
- * USAGE
- *	rename07 [-c n] [-e] [-i n] [-I x] [-p x] [-t]
- *	where,  -c n : Run n copies concurrently.
- *		-e   : Turn on errno logging.
- *		-i n : Execute test n times.
- *		-I x : Execute test for x seconds.
- *		-P x : Pause for x seconds between iterations.
- *		-t   : Turn on syscall timing.
+ * Copyright (c) International Business Machines  Corp., 2001
+ *  07/2001 Ported by Wayne Boyer
+ * Copyright (c) 2022 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
+ */
+
+/*\
+ * [Description]
  *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
+ * Verify that rename(2) fails with ENOTDIR, when
+ * oldpath is a directory and newpath exists but is not a directory.
  *
- * RESTRICTIONS
- *	None.
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
 
-char *TCID = "rename07";
-int TST_TOTAL = 1;
+#include <stdio.h>
+#include "tst_test.h"
 
-int fd;
-char mname[255], fdir[255];
-struct stat buf1, buf2;
-dev_t olddev, olddev1;
-ino_t oldino, oldino1;
+#define MNT_POINT "mntpoint"
+#define TEMP_DIR "tmpdir"
+#define TEMP_FILE "tmpfile"
 
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
-		/* rename a directory to a file */
-		/* Call rename(2) */
-		TEST(rename(fdir, mname));
-
-		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "rename(%s, %s) succeeded unexpectedly",
-				 fdir, mname);
-			continue;
-		}
-
-		if (TEST_ERRNO != ENOTDIR) {
-			tst_resm(TFAIL, "Expected ENOTDIR got %d", TEST_ERRNO);
-		} else {
-			tst_resm(TPASS, "rename() returned ENOTDIR");
-		}
-	}
-
-	cleanup();
-	tst_exit();
-
+	SAFE_CHDIR(MNT_POINT);
+	SAFE_MKDIR(TEMP_DIR, 00770);
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
-	sprintf(fdir, "./rndir_%d", getpid());
-	sprintf(mname, "./tfile_%d", getpid());
-
-	/* create "old" directory */
-	if (stat(fdir, &buf1) != -1) {
-		tst_brkm(TBROK, cleanup, "tmp directory %s found!", fdir);
-	}
-
-	SAFE_MKDIR(cleanup, fdir, 00770);
-
-	SAFE_STAT(cleanup, fdir, &buf1);
-
-	/* save "old"'s dev and ino */
-	olddev = buf1.st_dev;
-	oldino = buf1.st_ino;
-
-	SAFE_TOUCH(cleanup, mname, 0700, NULL);
-
-	SAFE_STAT(cleanup, mname, &buf2);
-
-	/* save "new"'s dev and ino */
-	olddev1 = buf2.st_dev;
-	oldino1 = buf2.st_ino;
+	TST_EXP_FAIL(rename(TEMP_DIR, TEMP_FILE),
+				ENOTDIR);
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
