Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB53C43217
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 08:44:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B26203CC4AF
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 09:44:07 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE0E73CC45A
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 09:43:57 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D9DB61A01988
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 09:43:56 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CEC9721B1E
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 08:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1669884234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Awkjrf0jGBYrI0rB0dib++NB0OnNdKxBI2T8f9qWiZI=;
 b=W3qNOAy+MGB+IfPETAjpqEgNisENEk5VOnqFqOeSh5U3iVdRt5UsvwVOcTyOEtWXgpaqky
 cYdfpPGsB81T6B2DCadyDDMD2DRTKxjm6KUsPMMyuEhmdSG2L2qSbh55ouwh+zg0M+90mD
 sW86nRbXyllCFrPwybwWzHctRFLMgn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1669884234;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Awkjrf0jGBYrI0rB0dib++NB0OnNdKxBI2T8f9qWiZI=;
 b=YGI2WCEDt+bqymQIMm/T8JudcAtc4L6Y7I4ZSNcb27687F8qb7NBeAvN+oQ7aYPDD04vFW
 1GEkubNo+tLCBADg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A82113B4A
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 08:43:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2qgEA0ppiGM9FwAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Thu, 01 Dec 2022 08:43:54 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu,  1 Dec 2022 14:13:51 +0530
Message-Id: <20221201084351.31644-1-akumar@suse.de>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] statvfs01: Convert to new LTP API
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

Removed the TINFO statements,
Added a validation of statvfs.f_namemax field by trying to create
a file having name longer than max allowed.

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/statvfs/statvfs01.c | 100 +++++-------------
 1 file changed, 28 insertions(+), 72 deletions(-)

diff --git a/testcases/kernel/syscalls/statvfs/statvfs01.c b/testcases/kernel/syscalls/statvfs/statvfs01.c
index e3b356c93..3bed9a78e 100644
--- a/testcases/kernel/syscalls/statvfs/statvfs01.c
+++ b/testcases/kernel/syscalls/statvfs/statvfs01.c
@@ -1,92 +1,48 @@
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
- */
-/*
- *    DESCRIPTION
- *      This is a Phase I test for the statvfs(2) system call.
- *      It is intended to provide a limited exposure of the system call.
- *	This call behaves similar to statfs.
+ * Copyright (c) 2022 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
 
+/*\
+ * [Description]
+ *
+ * Verify that statvfs() executes successfully for all
+ * available filesystems. Verify statvfs.f_namemax field
+ * by trying to create a file having name longer than
+ * maximum allowed.
+ */
 #include <stdio.h>
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
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
+	char *toolong_fname;
 
-		TEST(statvfs(TEST_PATH, &buf));
+	TST_EXP_PASS(statvfs(TEST_PATH, &buf));
 
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TTERRNO, "statvfs(%s, ...) failed",
-				 TEST_PATH);
-		} else {
-			tst_resm(TPASS, "statvfs(%s, ...) passed", TEST_PATH);
-		}
+	toolong_fname = SAFE_MALLOC(buf.f_namemax + 1);
+	memset(toolong_fname, 'b', buf.f_namemax + 1);
 
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
+	TST_EXP_FAIL(creat(toolong_fname, 0444), ENAMETOOLONG);
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
