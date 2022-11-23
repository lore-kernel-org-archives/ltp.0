Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBF9C433FE
	for <ltp@archiver.kernel.org>; Wed, 23 Nov 2022 14:27:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A0283CCA2B
	for <ltp@archiver.kernel.org>; Wed, 23 Nov 2022 15:27:31 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D01613C1B75
 for <ltp@lists.linux.it>; Wed, 23 Nov 2022 15:27:21 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EF97B1400444
 for <ltp@lists.linux.it>; Wed, 23 Nov 2022 15:27:20 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A99621F8B2
 for <ltp@lists.linux.it>; Wed, 23 Nov 2022 14:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1669213639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9t8OUpk6Wy4Wgo9T+9Kr5P2X1PtmWn1b1fXjmqRpH2w=;
 b=lY4bgvrrC3hqEdQHpBGtQl2UDpFWxE8VFOKhzko85hq0D0FZpyvWN9oNT6gQz+8hTQFRt9
 CZzCk0IGjP2GMEWuohG1tX2Zh/4wGrqxFzS0oM1NNtTLh1Ok8OuhE1Avd/QfSC9LKpQEvZ
 jk+I5I7Cg8ngOr2tagFuxz76T0SU6nc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1669213639;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9t8OUpk6Wy4Wgo9T+9Kr5P2X1PtmWn1b1fXjmqRpH2w=;
 b=rXSWNfW4tSvQGaYDXOZl0P68C5o9FiuHaazcxNUBksLpwmYLyCkBpnXuvH9iuSozss6xMf
 J94y3y9+kEsgmsDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 274EB13AE7
 for <ltp@lists.linux.it>; Wed, 23 Nov 2022 14:27:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BAthNsYtfmONIgAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Wed, 23 Nov 2022 14:27:18 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Wed, 23 Nov 2022 19:57:16 +0530
Message-Id: <20221123142716.1336-1-akumar@suse.de>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fstatfs01: Convert to new API and enable for all
 filesystems
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
 testcases/kernel/syscalls/fstatfs/fstatfs01.c | 126 +++++-------------
 1 file changed, 35 insertions(+), 91 deletions(-)

diff --git a/testcases/kernel/syscalls/fstatfs/fstatfs01.c b/testcases/kernel/syscalls/fstatfs/fstatfs01.c
index b06652dd5..6b14fd0d6 100644
--- a/testcases/kernel/syscalls/fstatfs/fstatfs01.c
+++ b/testcases/kernel/syscalls/fstatfs/fstatfs01.c
@@ -1,57 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
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
- *
- */
-/*
- * DETAILED DESCRIPTION
- *   This is a Phase I test for the fstatfs(2) system call.  It is intended
- *   to provide a limited exposure of the system call, for now.  It
- *   should/will be extended when full functional tests are written for
- *   fstatfs(2).
+ * Copyright (c) 2022 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
 
-#include <sys/types.h>
-#include <fcntl.h>
-#include <sys/statfs.h>
-#include <errno.h>
-#include <signal.h>
-#include <string.h>
+/*\
+ * [Description]
+ *
+ * Verify that fstatfs() syscall executes successfully for all
+ * available filesystems.
+ */
 
-#include "test.h"
-#include "safe_macros.h"
 
-static void setup(void);
-static void cleanup(void);
+#include <stdio.h>
+#include "tst_test.h"
 
-char *TCID = "fstatfs01";
+#define MNT_POINT "mntpoint"
+#define TEMP_FILE MNT_POINT"/test_file"
 
 static int file_fd;
 static int pipe_fd;
@@ -59,65 +24,44 @@ static int pipe_fd;
 static struct tcase {
 	int *fd;
 	const char *msg;
-} tcases[2] = {
+} tcases[] = {
 	{&file_fd, "fstatfs() on a file"},
 	{&pipe_fd, "fstatfs() on a pipe"},
 };
 
-int TST_TOTAL = ARRAY_SIZE(tcases);
-
-int main(int ac, char **av)
+static void run(unsigned int i)
 {
-	int lc, i;
-	struct statfs stats;
+	struct tcase *tc = &tcases[i];
+	struct statfs buf;
 
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
-			TEST(fstatfs(*tcases[i].fd, &stats));
-
-			if (TEST_RETURN == -1) {
-				tst_resm(TFAIL | TTERRNO, "%s", tcases[i].msg);
-			} else {
-				tst_resm(TPASS, "%s - f_type=%lx",
-				         tcases[i].msg, stats.f_type);
-			}
-		}
-	}
-
-	cleanup();
-	tst_exit();
+	TST_EXP_PASS(fstatfs(*tc->fd, &buf), "%s", tc->msg);
 }
 
 static void setup(void)
 {
 	int pipe[2];
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	file_fd = SAFE_OPEN(cleanup, "test_file", O_RDWR | O_CREAT, 0700);
-
-	SAFE_PIPE(cleanup, pipe);
+	file_fd = SAFE_OPEN(TEMP_FILE, O_RDWR | O_CREAT, 0700);
+	SAFE_PIPE(pipe);
 	pipe_fd = pipe[0];
-	SAFE_CLOSE(cleanup, pipe[1]);
+	SAFE_CLOSE(pipe[1]);
 }
 
 static void cleanup(void)
 {
-	if (file_fd > 0 && close(file_fd))
-		tst_resm(TWARN | TERRNO, "close(file_fd) failed");
-
-	if (pipe_fd > 0 && close(pipe_fd))
-		tst_resm(TWARN | TERRNO, "close(pipe_fd) failed");
-
-	tst_rmdir();
+	if (file_fd > 0)
+		SAFE_CLOSE(file_fd);
+	if (pipe_fd > 0)
+		SAFE_CLOSE(pipe_fd);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+	.mount_device = 1,
+	.mntpoint = MNT_POINT,
+	.all_filesystems = 1,
+	.needs_root = 1
+};
-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
