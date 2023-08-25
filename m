Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B7D6C3DA66
	for <ltp@archiver.kernel.org>; Fri, 25 Aug 2023 06:40:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2777C3CC3B2
	for <ltp@archiver.kernel.org>; Fri, 25 Aug 2023 08:40:14 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5308E3CC3AB
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 08:39:42 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 212A8200C60
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 08:39:40 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6B3A3224A8
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 06:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692945580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tBdxX0Lt+4Or3J+dtux8eA7iHroMKZ8d5yqyjlzxyZQ=;
 b=W0rceVskHPgD2rJNQw89t5rkHhM0jvuWb2DGdDHOjID6MQWOP65UIV+DIoqCr+0sQW7Q1k
 Yu+MIm7yUslUReHyXfdJqF4qNS9rXUgf9GOV/FAebJ/xSMlXFmKmehEpwWhHhSVJHmGq8R
 KJaZirB7euDfAynVVtWvYBz5DU2HnvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692945580;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tBdxX0Lt+4Or3J+dtux8eA7iHroMKZ8d5yqyjlzxyZQ=;
 b=spvYg2HVNjTACkCZPqkYpGbUevXunh8PTa4JEci/BNGXJAtQ+1cZrbtRSlKYwOnGiqOg1w
 zQ9wmvCnJ3Df88Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 05B3C138F9
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 06:39:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zZd8MatM6GSBLwAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 06:39:39 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Fri, 25 Aug 2023 12:08:40 +0530
Message-ID: <20230825063932.30875-3-akumar@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825063932.30875-1-akumar@suse.de>
References: <20230825063932.30875-1-akumar@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/5] syscalls/mmap13: Rewrite the test using new API
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
 testcases/kernel/syscalls/mmap/mmap13.c | 174 +++++++++---------------
 1 file changed, 65 insertions(+), 109 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap13.c b/testcases/kernel/syscalls/mmap/mmap13.c
index c5a2058e9..5e18f24fe 100644
--- a/testcases/kernel/syscalls/mmap/mmap13.c
+++ b/testcases/kernel/syscalls/mmap/mmap13.c
@@ -1,142 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2013 FNST, DAN LI <li.dan@cn.fujitsu.com>
+ * Copyright (c) 2023 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
+ */
+
+/*\
+ * [Description]
  *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
+ * Verify that, mmap() call succeeds to create a file mapping with length
+ * argument greater than the file size but any attempt to reference the
+ * memory region which does not correspond to the file causes SIGBUS signal.
  *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
-/*
- * Test Description:
- *  Verify error signal SIGBUS.
- *  "Attempted access to a portion of the buffer that does not correspond
- *   to the file."
+ *                  mmap(0, 8192, prot, MAP_FILE | MAP_SHARED, fd, 0);
  *
- * Expected Result:
- *  mmap() should succeed returning the address of the mapped region,
- *  and an attempt to access the memory which does not correspond to the file
- *  should rise the signal SIGBUS.
+ *  byte offset:    0        2047 2048    4095 4096                8191 8192
+ *                  +------------+------------+------------------------+
+ *  Memory          |            |  remainder |                        |
+ *  region          |            | of page(0s)|                        |
+ *                  +------------+------------+------------------------+
+ *                  |<---------->|<---------->|<---------------------->|<--------------->
+ *                  | accessible,| accessible,        references            references
+ *                  |   mapped   | not mapped        yield SIGBUS          yield SIGSEGV
+ *                  |  to file   |  to file
+ *                  |            |
+ *                  +------------+
+ *  Mapped file     |            |
+ * (2048 bytes)     |            |
+ *                  +------------+
+ *  file offset:    0         2047
  */
-#include <stdio.h>
+
 #include <stdlib.h>
-#include <sys/types.h>
-#include <errno.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <string.h>
-#include <signal.h>
-#include <sys/stat.h>
-#include <sys/mman.h>
 #include <setjmp.h>
-
-#include "test.h"
+#include "tst_test.h"
 
 #define TEMPFILE	"mmapfile"
-
-char *TCID = "mmap13";
-int TST_TOTAL = 1;
-
 static size_t page_sz;
 static char *addr;
-static int fildes;
+static int fd;
 static volatile sig_atomic_t pass;
 static sigjmp_buf env;
 
-static void setup(void);
-static void cleanup(void);
-static void sig_handler(int sig);
-
-int main(int argc, char *argv[])
+static void sig_handler(int sig)
 {
-	int lc;
-	char *ch;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		addr = mmap(NULL, page_sz * 2, PROT_READ | PROT_WRITE,
-			    MAP_FILE | MAP_SHARED, fildes, 0);
-
-		if (addr == MAP_FAILED) {
-			tst_resm(TFAIL | TERRNO, "mmap() failed on %s",
-				 TEMPFILE);
-			continue;
-		}
-
-		if (sigsetjmp(env, 1) == 0) {
-			ch = addr + page_sz + 1;
-			*ch = 0;
-		}
-
-		if (pass)
-			tst_resm(TPASS, "Got SIGBUS "
-					"as expected");
-		else
-			tst_resm(TFAIL, "Invalid access not "
-						"rise SIGBUS");
-
-		if (munmap(addr, page_sz * 2) != 0)
-			tst_brkm(TFAIL | TERRNO, cleanup,
-				 "failed to unmap the mmapped pages");
-
-		pass = 0;
-	}
-
-	cleanup();
-	tst_exit();
+	if (sig == SIGBUS) {
+		pass = 1;
+		siglongjmp(env, 1);
+	} else
+		tst_brk(TBROK, "received an unexpected signal");
 }
 
 static void setup(void)
 {
-	tst_sig(NOFORK, sig_handler, cleanup);
-
-	TEST_PAUSE;
+	SAFE_SIGNAL(SIGBUS, sig_handler);
 
 	page_sz = getpagesize();
 
-	tst_tmpdir();
-
-	fildes = open(TEMPFILE, O_RDWR | O_CREAT, 0766);
-	if (fildes < 0)
-		tst_brkm(TFAIL | TERRNO, cleanup, "opening %s failed",
-			 TEMPFILE);
-
-	if (ftruncate(fildes, page_sz / 2) == -1)
-		tst_brkm(TFAIL | TERRNO, cleanup, "ftruncate %s failed",
-			 TEMPFILE);
+	fd = SAFE_OPEN(TEMPFILE, O_RDWR | O_CREAT, 0666);
+	SAFE_FTRUNCATE(fd, page_sz / 2);
 }
 
-/*
- *   This function gets executed when the test process receives
- *   the signal SIGBUS while trying to access the memory which
- *   does not correspond to the file.
- */
-static void sig_handler(int sig)
+static void run(void)
 {
-	if (sig == SIGBUS) {
-		pass = 1;
-		siglongjmp(env, 1);
-	} else {
-		tst_brkm(TBROK, cleanup, "received an unexpected signal");
+	char *ch;
+
+	addr = mmap(0, page_sz * 2, PROT_READ | PROT_WRITE, MAP_FILE | MAP_SHARED, fd, 0);
+	if (addr == MAP_FAILED) {
+		tst_res(TFAIL | TERRNO, "mmap() of %s failed", TEMPFILE);
+		return;
 	}
+
+	if (sigsetjmp(env, 1) == 0) {
+		ch = addr + page_sz + 1;
+		*ch = 0;
+	}
+
+	if (pass)
+		tst_res(TPASS, "Received SIGBUS signal as expected");
+	else
+		tst_res(TFAIL, "SIGBUS signal not received");
+
+	SAFE_MUNMAP(addr, page_sz * 2);
 }
 
 static void cleanup(void)
 {
-	close(fildes);
-	tst_rmdir();
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+	.needs_tmpdir = 1
+};
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
