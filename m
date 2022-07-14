Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B807AC43334
	for <ltp@archiver.kernel.org>; Thu, 14 Jul 2022 11:08:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A5D743CA94F
	for <ltp@archiver.kernel.org>; Thu, 14 Jul 2022 13:08:25 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 816813CA1DB
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 13:08:15 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 44E366011EA
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 13:08:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 847921FAF1
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 11:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657796893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=unQqieMeQMoZ5c7GV8CXm2c9ETESBk2aeZ/3c4QR5aA=;
 b=u26jVAVNEVnKGC4Vw9odcVgSVs5Mg/DGeHsT8+l7x/iJpGIgUPgTSwTnuJlfvOB8ff06c+
 LQaIvRc00V3i0ae7KImKSpJrvbUL4tm9OmFAKNS84G/mKd5HPvNZnbA0Nmun4ibj27Psoy
 c1Am1sp4Yvz5ob0uhJFVS6jju6fCJXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657796893;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=unQqieMeQMoZ5c7GV8CXm2c9ETESBk2aeZ/3c4QR5aA=;
 b=++47KmeN4ATZDIBcWt2eSeNMm0JEm26OyhZtN/dNYpXcIznZjYBPJL2q23Wt4sgm277PL2
 0UJRE0APoqgdIqCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 020DF13A61
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 11:08:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xWZQLRz5z2JTVwAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 11:08:12 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu, 14 Jul 2022 16:38:10 +0530
Message-Id: <20220714110810.2783-1-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] open06.c: convert to new LTP API
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
 testcases/kernel/syscalls/open/open06.c | 92 +++++--------------------
 1 file changed, 18 insertions(+), 74 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open06.c b/testcases/kernel/syscalls/open/open06.c
index 6c774ce84..96bdd5fa2 100644
--- a/testcases/kernel/syscalls/open/open06.c
+++ b/testcases/kernel/syscalls/open/open06.c
@@ -1,90 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
 /*
- *
  *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ *   Copyright (c) 2022 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
 
 /*
- * DESCRIPTION
- *	Testcase to check open(2) sets errno to ENXIO correctly.
+ * [Description]
  *
- * ALGORITHM
- *	Create a named pipe using mknod(2).  Attempt to
- *	open(2) the pipe for writing. The open(2) should
- *	fail with ENXIO.
+ * Verify that open(2) fails with ENXIO when
+ * O_NONBLOCK | O_WRONLY is set, the named file is a FIFO,
+ * and no process has the FIFO open for reading.
  */
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <unistd.h>
-#include "test.h"
-
-char *TCID = "open06";
-int TST_TOTAL = 1;
-
-static void setup(void);
-static void cleanup(void);
-
-static char fname[100] = "fifo";
-
-int main(int ac, char **av)
-{
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
 
-	setup();
+#include "tst_test.h"
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		TEST(open(fname, O_NONBLOCK | O_WRONLY));
-		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "open(2) succeeded unexpectedly");
-			continue;
-		}
-
-		if (TEST_ERRNO != ENXIO)
-			tst_resm(TFAIL, "Expected ENXIO got %d", TEST_ERRNO);
-		else
-			tst_resm(TPASS, "call returned expected ENXIO error");
-	}
-
-	cleanup();
-	tst_exit();
-}
+#define TEMP_FIFO "tmpfile"
 
 static void setup(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	sprintf(fname, "%s.%d", fname, getpid());
-
-	if (mknod(fname, S_IFIFO | 0644, 0) == -1)
-		tst_brkm(TBROK, cleanup, "mknod FAILED");
+	SAFE_MKFIFO(TEMP_FIFO, 0644);
 }
 
-static void cleanup(void)
+static void run(void)
 {
-	unlink(fname);
-
-	tst_rmdir();
+	TST_EXP_FAIL2(open(TEMP_FIFO, O_NONBLOCK | O_WRONLY), ENXIO);
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.needs_tmpdir = 1
+};
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
