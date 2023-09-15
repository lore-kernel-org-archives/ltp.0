Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B759EE645C
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 13:58:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F56E3CE688
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 15:58:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5964F3CB13A
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 15:57:56 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 820D91009BD4
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 15:57:55 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D8A6C218BB;
 Fri, 15 Sep 2023 13:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694786274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=lj5tZmEraePQP1CbQoIu2wZSIp5P1j7ugIFsHxAJJhs=;
 b=LjQtWlzk41sF/l6P3YffkTIyBRRd7CDMjAT8cbf/KFEZRqfLIuChlsU7IWa2E+ZCDShuEr
 n9Rz7EUa7jWjb1vJNnLC747slWddN9DyZHjFmRLSakLQ5p0cnGmLnTM5CGRGaTOpb8Ww5w
 /wVsnK7sapU8SdUoaqVNuShPOYNkymM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694786274;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=lj5tZmEraePQP1CbQoIu2wZSIp5P1j7ugIFsHxAJJhs=;
 b=IdShu7Vj2HOutWDPd/ovKxHAUespPqL59pCaMo6M/6YyqnFaI8FEPk+vbKj+ZaVZD6SsVr
 zvOdCOj8etELYZCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C2EAD1358A;
 Fri, 15 Sep 2023 13:57:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BtO9LuJiBGVKbgAAMHmgww
 (envelope-from <mkittler@suse.de>); Fri, 15 Sep 2023 13:57:54 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Fri, 15 Sep 2023 15:57:52 +0200
Message-ID: <20230915135752.7275-1-mkittler@suse.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Port `getxattr02.c` to new test API
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
* Improve error handling
* Simplify code and description

Signed-off-by: Marius Kittler <mkittler@suse.de>
---
 .../kernel/syscalls/getxattr/getxattr02.c     | 197 ++++++++----------
 1 file changed, 87 insertions(+), 110 deletions(-)

diff --git a/testcases/kernel/syscalls/getxattr/getxattr02.c b/testcases/kernel/syscalls/getxattr/getxattr02.c
index a42057d0a..4060d55f7 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr02.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr02.c
@@ -1,28 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (C) 2011 Red Hat, Inc.
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
+ * Copyright (C) 2011  Red Hat, Inc.
+ * Copyright (c) 2023 Marius Kittler <mkittler@suse.de>
  */
 
-/*
+/*\
+ * [Description]
+ *
  * In the user.* namespace, only regular files and directories can
  * have extended attributes. Otherwise getxattr(2) will return -1
  * and set errno to ENODATA.
@@ -40,25 +24,17 @@
 
 #include "config.h"
 #include <sys/types.h>
-#include <sys/stat.h>
 #include <sys/sysmacros.h>
-#include <sys/wait.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <string.h>
 #ifdef HAVE_SYS_XATTR_H
 # include <sys/xattr.h>
 #endif
-#include "test.h"
-#include "safe_macros.h"
 
-char *TCID = "getxattr02";
+#include "tst_test.h"
+#include "tst_test_macros.h"
 
-#ifdef HAVE_SYS_XATTR_H
+#define MNTPOINT "mntpoint"
 #define XATTR_TEST_KEY "user.testkey"
 
 #define FIFO "getxattr02fifo"
@@ -66,94 +42,95 @@ char *TCID = "getxattr02";
 #define BLK  "getxattr02blk"
 #define SOCK "getxattr02sock"
 
-static void setup(void);
-static void cleanup(void);
+static char *workdir;
 
-static char *tc[] = {
-	FIFO,			/* case 00, get attr from fifo */
-	CHR,			/* case 01, get attr from char special */
-	BLK,			/* case 02, get attr from block special */
-	SOCK,			/* case 03, get attr from UNIX domain socket */
+struct test_case {
+	char *fname;
+	int mode;
+};
+struct test_case tcases[] = {
+	{ /* case 00, get attr from fifo */
+	 .fname = FIFO,
+	 .mode = S_IFIFO,
+	},
+	{ /* case 01, get attr from char special */
+	 .fname = CHR,
+	 .mode = S_IFCHR,
+	},
+	{ /* case 02, get attr from block special */
+	 .fname = BLK,
+	 .mode = S_IFBLK,
+	},
+	{ /* case 03, get attr from UNIX domain socket */
+	 .fname = SOCK,
+	 .mode = S_IFSOCK,
+	},
 };
 
-int TST_TOTAL = sizeof(tc) / sizeof(tc[0]);
-
-int main(int argc, char *argv[])
+static void run(unsigned int i)
 {
-	int lc;
-	int i;
-	int exp_eno;
-	char buf[BUFSIZ];
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		exp_eno = ENODATA;
-
-		for (i = 0; i < TST_TOTAL; i++) {
-			TEST(getxattr(tc[0], XATTR_TEST_KEY, buf, BUFSIZ));
-
-			if (TEST_RETURN == -1 && TEST_ERRNO == exp_eno)
-				tst_resm(TPASS | TTERRNO, "expected behavior");
-			else
-				tst_resm(TFAIL | TTERRNO, "unexpected behavior"
-					 " - expected errno %d - Got", exp_eno);
+#ifdef HAVE_SYS_XATTR_H
+	SAFE_CHDIR(workdir);
+
+	/* test for xattr support in the current filesystem */
+	if (i == 0) {
+		int fd = SAFE_CREAT("testfile", 0644);
+		close(fd);
+		TEST(setxattr("testfile", "user.test", "test", 4, XATTR_CREATE));
+		if (TST_RET < 0) {
+			if (TST_ERR == ENOTSUP)
+				tst_brk(TCONF, "no xattr support in filesystem");
+			tst_brk(TBROK | TTERRNO, "unexpected setxattr() return code");
+			return;
 		}
+		unlink("testfile");
 	}
 
-	cleanup();
-	tst_exit();
+	/* create test file */
+	struct test_case *tc = &tcases[i];
+	dev_t dev = tc->mode == S_IFCHR ? makedev(1, 3) : 0u;
+	if (mknod(tc->fname, tc->mode | 0777, dev) < 0)
+		tst_brk(TBROK | TERRNO, "create %s (mode %i) failed", tc->fname, tc->mode);
+
+	int exp_eno = ENODATA;
+	char buf[BUFSIZ];
+	TEST(getxattr(tc->fname, XATTR_TEST_KEY, buf, BUFSIZ));
+	if (TST_RET == -1 && TST_ERR == exp_eno)
+		tst_res(TPASS | TTERRNO, "expected return value");
+	else
+		tst_res(TFAIL | TTERRNO, "unexpected return value"
+				" - expected errno %d - got", exp_eno);
+#endif
 }
 
 static void setup(void)
 {
-	int fd;
-	dev_t dev;
-
-	tst_require_root();
-
-	tst_tmpdir();
-
-	/* Test for xattr support */
-	fd = SAFE_CREAT(cleanup, "testfile", 0644);
-	close(fd);
-	if (setxattr("testfile", "user.test", "test", 4, XATTR_CREATE) == -1)
-		if (errno == ENOTSUP)
-			tst_brkm(TCONF, cleanup, "No xattr support in fs or "
-				 "mount without user_xattr option");
-	unlink("testfile");
-
-	/* Create test files */
-	if (mknod(FIFO, S_IFIFO | 0777, 0) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Create FIFO(%s) failed",
-			 FIFO);
-
-	dev = makedev(1, 3);
-	if (mknod(CHR, S_IFCHR | 0777, dev) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Create char special(%s)"
-			 " failed", CHR);
-
-	if (mknod(BLK, S_IFBLK | 0777, 0) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Create block special(%s)"
-			 " failed", BLK);
-
-	if (mknod(SOCK, S_IFSOCK | 0777, 0) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Create socket(%s) failed",
-			 SOCK);
-
-	TEST_PAUSE;
+#ifdef HAVE_SYS_XATTR_H
+	char *cwd = SAFE_GETCWD(NULL, 0);
+	workdir = SAFE_MALLOC(strlen(cwd) + strlen(MNTPOINT) + 2);
+	sprintf(workdir, "%s/%s", cwd, MNTPOINT);
+	free(cwd);
+#else
+	tst_brk(TCONF, "<sys/xattr.h> does not exist.");
+#endif
 }
 
-static void cleanup(void)
-{
-	tst_rmdir();
-}
-#else /* HAVE_SYS_XATTR_H */
-int main(int argc, char *argv[])
-{
-	tst_brkm(TCONF, NULL, "<sys/xattr.h> does not exist.");
-}
+static struct tst_test test = {
+#ifdef HAVE_SYS_XATTR_H
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
 #endif
+	.setup = setup,
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases)
+};
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
