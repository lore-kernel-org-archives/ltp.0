Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D36C7EE29
	for <ltp@archiver.kernel.org>; Thu,  1 Jun 2023 11:22:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E01C43CEA54
	for <ltp@archiver.kernel.org>; Thu,  1 Jun 2023 13:22:29 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6736A3CCF04
 for <ltp@lists.linux.it>; Thu,  1 Jun 2023 13:22:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 98E8A1000D23
 for <ltp@lists.linux.it>; Thu,  1 Jun 2023 13:22:19 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 458931F86C
 for <ltp@lists.linux.it>; Thu,  1 Jun 2023 11:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1685618538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yZbej2OTEWnQNgVYDG++9TOXQck1L91xPkeGhwFJUx4=;
 b=XXGOolmEffrGdPSXACVgpxdFUjS5eLzZ1E1dwXKxTm92wmvLocznCpDrpwpT+QCYkLZcjk
 s4WFpdHiRitTBHLpXhnn296fMd1mW0yb8L7Gohnwpd7lDsIeHexCg0LU1agQU9BWZd2keg
 p0slIrQyd7xGMcjB/3/kgB/+sT6f6wE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1685618538;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yZbej2OTEWnQNgVYDG++9TOXQck1L91xPkeGhwFJUx4=;
 b=fBsDwo424vzXRBKpnFB9cXmtnC4S1a5/xrCG3yYnWz9Mte8ELdwktzpoHKDOvGF6WxGSk9
 acVlyIezQlJUwXBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BFC1313441
 for <ltp@lists.linux.it>; Thu,  1 Jun 2023 11:22:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4Z6QIGl/eGS5ZQAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Thu, 01 Jun 2023 11:22:17 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu,  1 Jun 2023 16:52:14 +0530
Message-Id: <20230601112214.18193-1-akumar@suse.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fcntl30.c: Convert the test to new LTP API
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
 testcases/kernel/syscalls/fcntl/fcntl30.c | 112 +++++++---------------
 1 file changed, 36 insertions(+), 76 deletions(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl30.c b/testcases/kernel/syscalls/fcntl/fcntl30.c
index c4c3f81f1..62cc39e73 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl30.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl30.c
@@ -1,103 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2014 Fujitsu Ltd.
  * Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
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
+ * Copyright (c) 2023 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
 
-/*
- * Description:
- * Verify that,
- *     Basic test for fcntl(2) using F_SETPIPE_SZ, F_GETPIPE_SZ argument.
+/*\
+ * [Description]
+ *
+ * Verify that, fetching and changing the capacity of a pipe works as
+ * expected with fcntl(2) syscall using F_GETPIPE_SZ, F_SETPIPE_SZ arguments.
  */
 
 
-#include <stdio.h>
-#include <errno.h>
-#include <unistd.h>
-#include <string.h>
-#include <signal.h>
-#include <sys/types.h>
-#include <pwd.h>
-
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 #include "lapi/fcntl.h"
 
-char *TCID = "fcntl30";
-int TST_TOTAL = 1;
+static int fds[2];
+static int max_size_unpriv;
 
-static void setup(void);
-static void cleanup(void);
-
-int main(int ac, char **av)
+static void run(void)
 {
-	int lc;
-	int pipe_fds[2], test_fd;
-	int orig_pipe_size, new_pipe_size;
-
-
-	tst_parse_opts(ac, av, NULL, NULL);
+	int orig_size, new_size;
 
-	setup();
+	SAFE_PIPE(fds);
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
+	TST_EXP_POSITIVE(fcntl(fds[1], F_GETPIPE_SZ));
 
-		SAFE_PIPE(cleanup, pipe_fds);
-		test_fd = pipe_fds[1];
+	orig_size = TST_RET;
+	new_size = orig_size * 2;
 
-		TEST(fcntl(test_fd, F_GETPIPE_SZ));
-		if (TEST_RETURN < 0) {
-			tst_brkm(TFAIL | TTERRNO, cleanup,
-				 "fcntl get pipe size failed");
-		}
+	if (new_size > max_size_unpriv)
+		tst_brk(TBROK, "Requested pipe size above the allowed limit %d", max_size_unpriv);
 
-		orig_pipe_size = TEST_RETURN;
-		new_pipe_size = orig_pipe_size * 2;
-		TEST(fcntl(test_fd, F_SETPIPE_SZ, new_pipe_size));
-		if (TEST_RETURN < 0) {
-			tst_brkm(TFAIL | TTERRNO, cleanup,
-				 "fcntl test F_SETPIPE_SZ failed");
-		}
+	TST_EXP_POSITIVE(fcntl(fds[1], F_SETPIPE_SZ, new_size));
+	TST_EXP_POSITIVE(fcntl(fds[1], F_GETPIPE_SZ));
+	TST_EXP_EXPR(TST_RET >= new_size,
+				"new pipe size (%ld) >= requested size (%d)",
+				TST_RET, new_size);
 
-		TEST(fcntl(test_fd, F_GETPIPE_SZ));
-		if (TEST_RETURN < 0) {
-			tst_brkm(TFAIL | TTERRNO, cleanup,
-				 "fcntl test F_GETPIPE_SZ failed");
-		}
-		tst_resm(TINFO, "orig_pipe_size: %d new_pipe_size: %d",
-			 orig_pipe_size, new_pipe_size);
-		if (TEST_RETURN >= new_pipe_size) {
-			tst_resm(TPASS, "fcntl test F_GETPIPE_SZ and F_SETPIPE_SZ passed");
-		} else {
-			tst_resm(TFAIL, "fcntl test F_GETPIPE_SZ and F_SETPIPE_SZ failed");
-		}
-		SAFE_CLOSE(cleanup, pipe_fds[0]);
-		SAFE_CLOSE(cleanup, pipe_fds[1]);
-	}
-
-	cleanup();
-	tst_exit();
+	SAFE_CLOSE(fds[0]);
+	SAFE_CLOSE(fds[1]);
 }
 
 static void setup(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	SAFE_FILE_SCANF("/proc/sys/fs/pipe-max-size", "%d",	&max_size_unpriv);
 }
 
 static void cleanup(void)
 {
+	if (fds[0] > 0)
+		SAFE_CLOSE(fds[0]);
+	if (fds[1] > 0)
+		SAFE_CLOSE(fds[1]);
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup
+};
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
