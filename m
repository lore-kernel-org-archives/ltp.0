Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C36FAC10DAA
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 14:01:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C7DBC3CF674
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 15:00:58 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AFCD83CC2BC
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 15:00:48 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 73C8E601238
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 15:00:47 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 650C22192D;
 Wed, 29 Nov 2023 14:00:44 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4860A1376F;
 Wed, 29 Nov 2023 14:00:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id HTg0EAxEZ2V0KAAAn2gu4w
 (envelope-from <mkittler@suse.de>); Wed, 29 Nov 2023 14:00:44 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Wed, 29 Nov 2023 15:00:37 +0100
Message-ID: <20231129140037.22041-1-mkittler@suse.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Bar: ++++++++
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de; dkim=none;
 spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither
 permitted nor denied by domain of mkittler@suse.de)
 smtp.mailfrom=mkittler@suse.de; 
 dmarc=fail reason="No valid SPF,
 No valid DKIM" header.from=suse.de (policy=none)
X-Rspamd-Queue-Id: 650C22192D
X-Spamd-Result: default: False [8.29 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 R_SPF_SOFTFAIL(4.60)[~all:c]; NEURAL_HAM_SHORT(-0.18)[-0.915];
 RCVD_COUNT_THREE(0.00)[3]; MX_GOOD(-0.01)[];
 RCPT_COUNT_TWO(0.00)[2]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.de:email];
 NEURAL_HAM_LONG(-0.32)[-0.318];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(2.20)[]; MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%];
 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6] Port getxattr02.c to new test API
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
  to support xattr (which is commonly a tmpfs and tmpfs only got xattrs
  support in Linux 6.6)
* Improve error handling
* Simplify code and description

Signed-off-by: Marius Kittler <mkittler@suse.de>
---
 .../kernel/syscalls/getxattr/getxattr02.c     | 203 +++++++-----------
 1 file changed, 82 insertions(+), 121 deletions(-)

diff --git a/testcases/kernel/syscalls/getxattr/getxattr02.c b/testcases/kernel/syscalls/getxattr/getxattr02.c
index a42057d0a..b532304b6 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr02.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr02.c
@@ -1,64 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0-only
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
+ * Copyright (c) 2014-2017 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) 2023 Marius Kittler <mkittler@suse.de>
  */
 
-/*
+/*\
+ * [Description]
+ *
  * In the user.* namespace, only regular files and directories can
  * have extended attributes. Otherwise getxattr(2) will return -1
  * and set errno to ENODATA.
  *
  * There are 4 test cases:
- * 1. Get attribute from a FIFO, setxattr(2) should return -1 and
+ *
+ * - Get attribute from a FIFO, setxattr(2) should return -1 and
  *    set errno to ENODATA
- * 2. Get attribute from a char special file, setxattr(2) should
+ * - Get attribute from a char special file, setxattr(2) should
  *    return -1 and set errno to ENODATA
- * 3. Get attribute from a block special file, setxattr(2) should
+ * - Get attribute from a block special file, setxattr(2) should
  *    return -1 and set errno to ENODATA
- * 4. Get attribute from a UNIX domain socket, setxattr(2) should
+ * - Get attribute from a UNIX domain socket, setxattr(2) should
  *    return -1 and set errno to ENODATA
  */
 
 #include "config.h"
 #include <sys/types.h>
-#include <sys/stat.h>
 #include <sys/sysmacros.h>
-#include <sys/wait.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include <signal.h>
+#include <sys/xattr.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <string.h>
-#ifdef HAVE_SYS_XATTR_H
-# include <sys/xattr.h>
-#endif
-#include "test.h"
-#include "safe_macros.h"
 
-char *TCID = "getxattr02";
+#include "tst_res_flags.h"
+#include "tst_test.h"
+#include "tst_test_macros.h"
 
-#ifdef HAVE_SYS_XATTR_H
+#define MNTPOINT "mntpoint"
+#define FNAME MNTPOINT"/getxattr02"
 #define XATTR_TEST_KEY "user.testkey"
 
 #define FIFO "getxattr02fifo"
@@ -66,94 +44,77 @@ char *TCID = "getxattr02";
 #define BLK  "getxattr02blk"
 #define SOCK "getxattr02sock"
 
-static void setup(void);
-static void cleanup(void);
-
-static char *tc[] = {
-	FIFO,			/* case 00, get attr from fifo */
-	CHR,			/* case 01, get attr from char special */
-	BLK,			/* case 02, get attr from block special */
-	SOCK,			/* case 03, get attr from UNIX domain socket */
+static struct test_case {
+	const char *desc;
+	char *fname;
+	int mode;
+} tcases[] = {
+	{
+	 .desc = "get attr from fifo",
+	 .fname = FNAME FIFO,
+	 .mode = S_IFIFO,
+	},
+	{
+	 .desc = "get attr from char special",
+	 .fname = FNAME CHR,
+	 .mode = S_IFCHR,
+	},
+	{
+	 .desc = "get attr from block special",
+	 .fname = FNAME BLK,
+	 .mode = S_IFBLK,
+	},
+	{
+	 .desc = "get attr from UNIX domain socket",
+	 .fname = FNAME SOCK,
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
 	char buf[BUFSIZ];
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
-		}
-	}
-
-	cleanup();
-	tst_exit();
+	struct test_case *tc = &tcases[i];
+	dev_t dev = tc->mode == S_IFCHR ? makedev(1, 3) : 0u;
+
+	unlink(tc->fname); /* allow executing test n times via `-i n` */
+	if (mknod(tc->fname, tc->mode | 0777, dev) < 0)
+		tst_brk(TBROK | TERRNO, "create %s (mode %i) failed (%s)",
+				tc->fname, tc->mode, tc->desc);
+
+	TEST(getxattr(tc->fname, XATTR_TEST_KEY, buf, BUFSIZ));
+	if (TST_RET == -1 && TST_ERR == ENODATA)
+		tst_res(TPASS | TTERRNO, "%s: expected return value",
+				tc->desc);
+	else
+		tst_res(TFAIL | TTERRNO, "%s: unexpected return value"
+				" - expected errno %d - got", tc->desc, ENODATA);
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
+	/* assert xattr support in the current filesystem */
+	SAFE_TOUCH(FNAME, 0644, NULL);
+	TEST(setxattr(FNAME, "user.test", "test", 4, XATTR_CREATE));
+	if (TST_ERR == ENOTSUP)
+		tst_brk(TCONF,
+			"No xattr support in fs or mount without user_xattr "
+			"option");
+	else if (TST_RET != 0)
+		tst_brk(TBROK | TTERRNO, "setxattr failed");
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
-#endif
+static struct tst_test test = {
+	.all_filesystems = 1,
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.mount_device = 1,
+	.skip_filesystems = (const char *const []) {
+			"ramfs",
+			"nfs",
+			NULL
+	},
+	.setup = setup,
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases)
+};
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
