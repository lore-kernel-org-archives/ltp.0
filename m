Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ABF3C61DA4
	for <ltp@archiver.kernel.org>; Wed, 22 Feb 2023 03:45:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 719783CBCA6
	for <ltp@archiver.kernel.org>; Wed, 22 Feb 2023 04:45:19 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 89DBC3CB030
 for <ltp@lists.linux.it>; Wed, 22 Feb 2023 04:45:07 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AE0B4600819
 for <ltp@lists.linux.it>; Wed, 22 Feb 2023 04:45:06 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E78B820509
 for <ltp@lists.linux.it>; Wed, 22 Feb 2023 03:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1677037504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eklLRud70dd3Zee+Zw2tz2sKbATDdVJ2AKiwu6bLE5w=;
 b=FMgNm48nGqHgDLdAVrIFXTNM0BDxcwUxshiiwZmEUMjBejKBPw7SKRR8QfPWi85cOm49sJ
 LY1e8YMZTLvYOATUAuOQEXJ47TpBi/TV3F7x1sxSOONFctAdGeDApsRJvKdBFcM0wV3A9Y
 dh1MOTYjgurV8SyIj1ZugwvENrEa2bI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1677037504;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eklLRud70dd3Zee+Zw2tz2sKbATDdVJ2AKiwu6bLE5w=;
 b=qo7YOqBk9lLpTRmQ/l3zSY0MbA6xqAleLxHljkt6Y/vKwFGBN67kmpdfjx8yQM+LBkmycu
 7imjScxTUnsHMxDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A31513467
 for <ltp@lists.linux.it>; Wed, 22 Feb 2023 03:45:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ySQXDMCP9WOJRgAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Wed, 22 Feb 2023 03:45:04 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Wed, 22 Feb 2023 09:15:01 +0530
Message-Id: <20230222034501.11800-1-akumar@suse.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] mknod01: Rewrite the test using new LTP API
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
 testcases/kernel/syscalls/mknod/mknod01.c | 137 ++++++----------------
 1 file changed, 33 insertions(+), 104 deletions(-)

diff --git a/testcases/kernel/syscalls/mknod/mknod01.c b/testcases/kernel/syscalls/mknod/mknod01.c
index f79e5fa42..d4b8c7bf8 100644
--- a/testcases/kernel/syscalls/mknod/mknod01.c
+++ b/testcases/kernel/syscalls/mknod/mknod01.c
@@ -1,123 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
- *  AUTHOR		: William Roske
- *  CO-PILOT		: Dave Fenner
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
+ *  AUTHOR: William Roske, CO-PILOT: Dave Fenner
+ * Copyright (c) 2023 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
+ */
+
+/*\
+ * [Description]
  *
+ * Verify that mknod(2) successfully creates a filesystem node with
+ * various modes.
  */
 
-#include <unistd.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include <sys/types.h>
-#include <sys/stat.h>
 #include <sys/sysmacros.h>
-
-#include "test.h"
-#include "safe_macros.h"
-
-static void setup(void);
-static void cleanup(void);
-
-char *TCID = "mknod01";
+#include "tst_test.h"
 
 #define PATH "test_node"
 
-int tcases[] = {		/* modes to give nodes created (1 per text case) */
-	S_IFREG | 0777,		/* ordinary file with mode 0777 */
-	S_IFIFO | 0777,		/* fifo special with mode 0777 */
-	S_IFCHR | 0777,		/* character special with mode 0777 */
-	S_IFBLK | 0777,		/* block special with mode 0777 */
+static int tcases[] = {
+	S_IFREG | 0777,
+	S_IFIFO | 0777,
+	S_IFCHR | 0777,
+	S_IFBLK | 0777,
 
-	S_IFREG | 04700,	/* ordinary file with mode 04700 (suid) */
-	S_IFREG | 02700,	/* ordinary file with mode 02700 (sgid) */
-	S_IFREG | 06700,	/* ordinary file with mode 06700 (sgid & suid) */
+	S_IFREG | 04700,
+	S_IFREG | 02700,
+	S_IFREG | 06700,
 };
 
-int TST_TOTAL = ARRAY_SIZE(tcases);
 
-int main(int ac, char **av)
+static void run(unsigned int i)
 {
-	int lc, i;
 	dev_t dev;
 
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
+	if (S_ISCHR(tcases[i]))
+		dev = makedev(1, 3);
+	else
+		dev = 0;
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
-			/*
-			 * overlayfs doesn't support mknod char device with
-			 * major 0 and minor 0, which is known as whiteout_dev
-			 */
-			if (S_ISCHR(tcases[i]))
-				dev = makedev(1, 3);
-			else
-				dev = 0;
-			TEST(mknod(PATH, tcases[i], dev));
-
-			if (TEST_RETURN == -1) {
-				tst_resm(TFAIL,
-					 "mknod(%s, %#o, %lu) failed, errno=%d : %s",
-					 PATH, tcases[i], dev, TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			} else {
-				tst_resm(TPASS,
-					 "mknod(%s, %#o, %lu) returned %ld",
-					 PATH, tcases[i], dev, TEST_RETURN);
-			}
-
-			SAFE_UNLINK(cleanup, PATH);
-		}
-
-	}
-
-	cleanup();
-	tst_exit();
+	TST_EXP_PASS(mknod(PATH, tcases[i], dev),
+				"mknod(PATH, %o, %ld)",
+				tcases[i], dev);
+	SAFE_UNLINK(PATH);
 }
 
-void setup(void)
-{
-	tst_require_root();
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-}
-
-void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_root = 1,
+	.needs_tmpdir = 1
+};
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
