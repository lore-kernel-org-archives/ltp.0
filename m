Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDD8C77B73
	for <ltp@archiver.kernel.org>; Mon,  5 Jun 2023 09:55:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9805C3CCB72
	for <ltp@archiver.kernel.org>; Mon,  5 Jun 2023 11:55:10 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C9EB93CBCFB
 for <ltp@lists.linux.it>; Mon,  5 Jun 2023 11:55:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 99EC61A0015C
 for <ltp@lists.linux.it>; Mon,  5 Jun 2023 11:54:59 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C277021B04
 for <ltp@lists.linux.it>; Mon,  5 Jun 2023 09:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1685958898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XGGwhdd9z4DbDN8JmsadeS5Vo/3mPNpAB7rcUBdYlbM=;
 b=MOxBEVe/Dz8Yl2QxAUTJwbX0E0JudMX3Y83F+iCtdjyt1NUzm1lbgT5jpn1grfyJ5uR0XR
 vHeLazpwDdcvkjIF6sKpZXG0YsJ9s7WvU15LAX28Cg4LN32/k8s1PJAc0uliUudO7Upq21
 dl/lLEIvR6bNKvlhbYt7/XlUehZ6xZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1685958898;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XGGwhdd9z4DbDN8JmsadeS5Vo/3mPNpAB7rcUBdYlbM=;
 b=WTQSRZ/O+esRbZ2JJ4j5DyoaOxg8i3skihk/UL2WHOEFJCIOUMSME/h/9HKpejE01h2U9S
 iNKrPmN0gFt3SuCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 48AA4139C7
 for <ltp@lists.linux.it>; Mon,  5 Jun 2023 09:54:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id D62yA/KwfWTLNwAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Mon, 05 Jun 2023 09:54:58 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Mon,  5 Jun 2023 15:24:55 +0530
Message-Id: <20230605095455.32711-1-akumar@suse.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <CAEemH2fGD8TaG8j1ETydgjCfSjaHM-VeRkfAd2wMg09sTqFd_A@mail.gmail.com>
References: <CAEemH2fGD8TaG8j1ETydgjCfSjaHM-VeRkfAd2wMg09sTqFd_A@mail.gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] fcntl30.c: Convert the test to new LTP API
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
 testcases/kernel/syscalls/fcntl/fcntl30.c | 111 ++++++----------------
 1 file changed, 31 insertions(+), 80 deletions(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl30.c b/testcases/kernel/syscalls/fcntl/fcntl30.c
index c4c3f81f1..d5edbd885 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl30.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl30.c
@@ -1,103 +1,54 @@
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
 
-
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
-
-static void setup(void);
-static void cleanup(void);
+static int fds[2];
+static int max_size_unpriv;
 
-int main(int ac, char **av)
+static void run(void)
 {
-	int lc;
-	int pipe_fds[2], test_fd;
-	int orig_pipe_size, new_pipe_size;
+	SAFE_PIPE(fds);
 
+	TST_EXP_POSITIVE(fcntl(fds[1], F_GETPIPE_SZ));
 
-	tst_parse_opts(ac, av, NULL, NULL);
+	TST_EXP_POSITIVE(fcntl(fds[1], F_SETPIPE_SZ, max_size_unpriv));
+	TST_EXP_POSITIVE(fcntl(fds[1], F_GETPIPE_SZ));
+	TST_EXP_EXPR(TST_RET >= max_size_unpriv,
+				"new pipe size (%ld) >= requested size (%d)",
+				TST_RET, max_size_unpriv);
 
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		SAFE_PIPE(cleanup, pipe_fds);
-		test_fd = pipe_fds[1];
-
-		TEST(fcntl(test_fd, F_GETPIPE_SZ));
-		if (TEST_RETURN < 0) {
-			tst_brkm(TFAIL | TTERRNO, cleanup,
-				 "fcntl get pipe size failed");
-		}
-
-		orig_pipe_size = TEST_RETURN;
-		new_pipe_size = orig_pipe_size * 2;
-		TEST(fcntl(test_fd, F_SETPIPE_SZ, new_pipe_size));
-		if (TEST_RETURN < 0) {
-			tst_brkm(TFAIL | TTERRNO, cleanup,
-				 "fcntl test F_SETPIPE_SZ failed");
-		}
-
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
