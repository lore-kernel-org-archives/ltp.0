Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC81E706F8
	for <ltp@archiver.kernel.org>; Thu, 21 Sep 2023 09:07:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 79E803CE3A1
	for <ltp@archiver.kernel.org>; Thu, 21 Sep 2023 11:07:15 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 61AA63CDE8D
 for <ltp@lists.linux.it>; Thu, 21 Sep 2023 11:07:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7DFFE616643
 for <ltp@lists.linux.it>; Thu, 21 Sep 2023 11:07:03 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AE4EB22640;
 Thu, 21 Sep 2023 09:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695287222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eZHG13KZQg5ZDU3NZN0UoXF2/0TeMxLE2meVUcxsZ2k=;
 b=m87tICW6dfao/EUmhJIszBH5MM4x+ylKuoBop9snMuxKfOZoutM7VVbLucr85ufx5Dthwv
 i11zogSd747ZiknR04NhNCquSMpF180pYNY35Uzsve3BkXUOJBG1/IA0uRyV/jp5ACpcEs
 GBCExOouE5uUFEGBnTiiYuyxJFPnhhQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695287222;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eZHG13KZQg5ZDU3NZN0UoXF2/0TeMxLE2meVUcxsZ2k=;
 b=dMGOK39IGfasRnr7/IdJCfctOMtPqoDwzDPenOFJ3wYQ3emvzqywv4lFmBhQN7YS+IQT1A
 cf4BFfus8avMirCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9A81213513;
 Thu, 21 Sep 2023 09:07:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BzbOJLYHDGWzLQAAMHmgww
 (envelope-from <mkittler@suse.de>); Thu, 21 Sep 2023 09:07:02 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Thu, 21 Sep 2023 11:06:58 +0200
Message-ID: <20230921090658.11224-1-mkittler@suse.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Port getxattr03.c to new test API
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

* Utilize `all_filesystems = 1`-mechanism to test on various file
  systems instead of relying on the temporary directory's file system
  to support xattr (which it probably does not as it is commonly a
  tmpfs)
* Simplify code and description

Signed-off-by: Marius Kittler <mkittler@suse.de>
---
 .../kernel/syscalls/getxattr/getxattr03.c     | 133 +++++-------------
 1 file changed, 38 insertions(+), 95 deletions(-)

diff --git a/testcases/kernel/syscalls/getxattr/getxattr03.c b/testcases/kernel/syscalls/getxattr/getxattr03.c
index b6ea14287..78ec79e5c 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr03.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr03.c
@@ -1,117 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (C) 2012 Red Hat, Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it
- * is free of the rightful claim of any third person regarding
- * infringement or the like.  Any license provided herein, whether
- * implied or otherwise, applies only to this software file.  Patent
- * licenses, if any, provided herein do not apply to combinations of
- * this program with other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
+ * Copyright (C) 2012  Red Hat, Inc.
+ * Copyright (c) 2023 Marius Kittler <mkittler@suse.de>
  */
 
-/*
- * An empty buffer of size zero can be passed into getxattr(2) to return
- * the current size of the named extended attribute.
+/*\
+ * [Description]
+ *
+ * An empty buffer of size zero can be passed into getxattr(2) to
+ * return the current size of the named extended attribute.
  */
 
 #include "config.h"
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/wait.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include <signal.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#ifdef HAVE_SYS_XATTR_H
-# include <sys/xattr.h>
-#endif
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "getxattr03";
+#include "tst_test.h"
 
 #ifdef HAVE_SYS_XATTR_H
+#include <sys/xattr.h>
+#include "tst_safe_macros.h"
+
+#define MNTPOINT "mntpoint"
+#define FNAME MNTPOINT"/getxattr03testfile"
 #define XATTR_TEST_KEY "user.testkey"
 #define XATTR_TEST_VALUE "test value"
 #define XATTR_TEST_VALUE_SIZE (sizeof(XATTR_TEST_VALUE) - 1)
-#define TESTFILE "getxattr03testfile"
-
-static void setup(void);
-static void cleanup(void);
 
-int TST_TOTAL = 1;
-
-int main(int argc, char *argv[])
+static void run(void)
 {
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		TEST(getxattr(TESTFILE, XATTR_TEST_KEY, NULL, 0));
-
-		if (TEST_RETURN == XATTR_TEST_VALUE_SIZE)
-			tst_resm(TPASS, "getxattr(2) returned correct value");
-		else
-			tst_resm(TFAIL | TTERRNO, "getxattr(2) failed");
-	}
-
-	cleanup();
-	tst_exit();
+	TST_EXP_VAL(getxattr(FNAME, XATTR_TEST_KEY, NULL, 0),
+				XATTR_TEST_VALUE_SIZE);
 }
 
 static void setup(void)
 {
-	int fd;
-
-	tst_require_root();
-
-	tst_tmpdir();
-
 	/* Test for xattr support and set attr value */
-	fd = SAFE_CREAT(cleanup, TESTFILE, 0644);
-	close(fd);
-
-	if (setxattr(TESTFILE, XATTR_TEST_KEY, XATTR_TEST_VALUE,
-		     XATTR_TEST_VALUE_SIZE, XATTR_CREATE) == -1) {
-		if (errno == ENOTSUP)
-			tst_brkm(TCONF, cleanup, "No xattr support in fs or "
-				 "fs mounted without user_xattr option");
-		else
-			tst_brkm(TBROK | TERRNO, cleanup, "setxattr %s failed",
-				 TESTFILE);
-	}
-
-	TEST_PAUSE;
+	SAFE_TOUCH(FNAME, 0644, NULL);
+	SAFE_SETXATTR(FNAME, XATTR_TEST_KEY, XATTR_TEST_VALUE,
+		     XATTR_TEST_VALUE_SIZE, XATTR_CREATE);
 }
 
-static void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.all_filesystems = 1,
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.mount_device = 1,
+	.skip_filesystems = (const char *const []) {
+			"exfat",
+			"tmpfs",
+			"ramfs",
+			"nfs",
+			"vfat",
+			NULL
+	},
+	.setup = setup,
+	.test_all = run,
+};
+
 #else /* HAVE_SYS_XATTR_H */
-int main(int argc, char *argv[])
-{
-	tst_brkm(TCONF, NULL, "<sys/xattr.h> does not exist.");
-}
+TST_TEST_TCONF("System doesn't have <sys/xattr.h>");
 #endif
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
