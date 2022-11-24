Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00152C43219
	for <ltp@archiver.kernel.org>; Thu, 24 Nov 2022 11:42:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 913F93CC931
	for <ltp@archiver.kernel.org>; Thu, 24 Nov 2022 12:42:18 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A7F433C0123
 for <ltp@lists.linux.it>; Thu, 24 Nov 2022 12:42:09 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A05AC1A008A3
 for <ltp@lists.linux.it>; Thu, 24 Nov 2022 12:42:08 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9869221AA2
 for <ltp@lists.linux.it>; Thu, 24 Nov 2022 11:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1669290127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=BukxHopfHSSMjuVpx/XQdYmVE9DmN+7rxvQbVnz6Xek=;
 b=O/uEqN7b7qobC3VEJqKvbV0CLcxemzmeeVJSDSxfGyG+k9qeJz9A2KCajCUOSEwAvaj3za
 npXvrijjwH2aZkFswiCLWfbiRUbo8b6sS+ctQAf8T+tBm7Zct7T0tRoy0ZULWDdeL77us7
 HQ7WNwDqz1nIQ+WeBXlWpRxIORPVX/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1669290127;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=BukxHopfHSSMjuVpx/XQdYmVE9DmN+7rxvQbVnz6Xek=;
 b=LSwnDwfLDKJPJD/T89pZfxDu30fQYBzP572RBHHJfrMnDuIQlNShkvLhgcp69aOZc2xkq9
 4snb11txzUim4iDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1BB2213B4F
 for <ltp@lists.linux.it>; Thu, 24 Nov 2022 11:42:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id tHPfM45Yf2NTaQAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Thu, 24 Nov 2022 11:42:06 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu, 24 Nov 2022 17:12:04 +0530
Message-Id: <20221124114204.990-1-akumar@suse.de>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] statvfs01: Convert to new LTP API
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

Also I've removed the TINFO statements, I'm not sure if only
printing the data in logs is helpful in anyway.

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/statvfs/statvfs01.c | 96 +++++--------------
 1 file changed, 22 insertions(+), 74 deletions(-)

diff --git a/testcases/kernel/syscalls/statvfs/statvfs01.c b/testcases/kernel/syscalls/statvfs/statvfs01.c
index e3b356c93..89ca4e960 100644
--- a/testcases/kernel/syscalls/statvfs/statvfs01.c
+++ b/testcases/kernel/syscalls/statvfs/statvfs01.c
@@ -1,92 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) Wipro Technologies Ltd, 2005.  All Rights Reserved.
  *    AUTHOR: Prashant P Yendigeri <prashant.yendigeri@wipro.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
+ * Copyright (c) 2022 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
-/*
- *    DESCRIPTION
- *      This is a Phase I test for the statvfs(2) system call.
- *      It is intended to provide a limited exposure of the system call.
- *	This call behaves similar to statfs.
+
+/*\
+ * [Description]
+ *
+ * Verify that statvfs() executes successfully for all
+ * available filesystems.
  */
 
-#include <stdio.h>
-#include <unistd.h>
-#include <errno.h>
 #include <sys/statvfs.h>
-#include <stdint.h>
-
-#include "test.h"
-
-#define TEST_PATH "/"
+#include "tst_test.h"
 
-static void setup(void);
-static void cleanup(void);
+#define MNT_POINT "mntpoint"
+#define TEST_PATH MNT_POINT"/testfile"
 
-char *TCID = "statvfs01";
-int TST_TOTAL = 1;
-
-int main(int ac, char **av)
+static void run(void)
 {
 	struct statvfs buf;
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
 
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		TEST(statvfs(TEST_PATH, &buf));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TTERRNO, "statvfs(%s, ...) failed",
-				 TEST_PATH);
-		} else {
-			tst_resm(TPASS, "statvfs(%s, ...) passed", TEST_PATH);
-		}
-
-	}
-
-	tst_resm(TINFO, "This call is similar to statfs");
-	tst_resm(TINFO, "Extracting info about the '%s' file system",
-		 TEST_PATH);
-	tst_resm(TINFO, "file system block size = %lu bytes", buf.f_bsize);
-	tst_resm(TINFO, "file system fragment size = %lu bytes", buf.f_frsize);
-	tst_resm(TINFO, "file system free blocks = %ju",
-		 (uintmax_t) buf.f_bfree);
-	tst_resm(TINFO, "file system total inodes = %ju",
-		 (uintmax_t) buf.f_files);
-	tst_resm(TINFO, "file system free inodes = %ju",
-		 (uintmax_t) buf.f_ffree);
-	tst_resm(TINFO, "file system id = %lu", buf.f_fsid);
-	tst_resm(TINFO, "file system max filename length = %lu", buf.f_namemax);
-
-	cleanup();
-	tst_exit();
+	TST_EXP_PASS(statvfs(TEST_PATH, &buf));
 }
 
 static void setup(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	SAFE_TOUCH(TEST_PATH, 0666, NULL);
 }
 
-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.needs_root = 1,
+	.mount_device = 1,
+	.mntpoint = MNT_POINT,
+	.all_filesystems = 1
+};
-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
