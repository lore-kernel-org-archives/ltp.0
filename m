Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CD8C3DA66
	for <ltp@archiver.kernel.org>; Fri, 25 Aug 2023 06:40:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F36973CC3E1
	for <ltp@archiver.kernel.org>; Fri, 25 Aug 2023 08:40:02 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB6273CC3EE
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 08:39:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A60111400990
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 08:39:38 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AC3A3224A8
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 06:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692945577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZypuDsbwz1kqVifiJXLyms8nCCERyyHvdbK3u2Jv/8Q=;
 b=blXkjt8LCIYJnsS0NZvGc+Sc35PTSFR/8pYh5Byru5v2BZ2Lr10nyhZzxkrdEmcUu+uZO0
 2b6zk8KlimmdiOTSWQ8ZYJB9BdM6X9zRoBhssWvnMgZc6qqdOt44vDCYr6Y2qarMP2iQZI
 CGasnYZmHafDJJSAwfe/eELhJx+BEPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692945577;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZypuDsbwz1kqVifiJXLyms8nCCERyyHvdbK3u2Jv/8Q=;
 b=DD5FXNraTx8BkvNuOuCtxWyKw5tJFlIEGHVjMit7WjuPMyE4Oa+E9PLxJQVy4XQA9d3nX1
 MGidUiRRZ/cNwxAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 484D2138F9
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 06:39:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id lrmLBqlM6GR7LwAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 06:39:37 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Fri, 25 Aug 2023 12:08:39 +0530
Message-ID: <20230825063932.30875-2-akumar@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825063932.30875-1-akumar@suse.de>
References: <20230825063932.30875-1-akumar@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/5] syscalls/mmap09: Rewrite the test using new LTP
 API
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
 testcases/kernel/syscalls/mmap/mmap09.c | 134 ++++++++----------------
 1 file changed, 45 insertions(+), 89 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap09.c b/testcases/kernel/syscalls/mmap/mmap09.c
index 4ab0da470..6f59baf4a 100644
--- a/testcases/kernel/syscalls/mmap/mmap09.c
+++ b/testcases/kernel/syscalls/mmap/mmap09.c
@@ -1,119 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2003
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Copyright (c) International Business Machines  Corp., 2001
+ *  04/2003 Written by Paul Larson
+ * Copyright (c) 2023 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
 
-/*
- * Test Description:
- *  Verify that truncating a mmaped file works correctly.
- *
- * Expected Result:
- *  ftruncate should be allowed to increase, decrease, or zero the
- *  size of a file that has been mmaped
+/*\
+ * [Description]
  *
- *  Test:
- *   Use ftruncate to shrink the file while it is mapped
- *   Use ftruncate to grow the file while it is mapped
- *   Use ftruncate to zero the size of the file while it is mapped
- *
- * HISTORY
- *	04/2003 Written by Paul Larson
+ * Verify that, once we have a file mapping created using mmap(), we can
+ * successfully shrink, grow or zero the size of the mapped file using
+ * ftruncate.
  */
-#include <stdio.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <sys/mman.h>
-#include <sys/types.h>
-#include "test.h"
 
-#define mapsize (1 << 14)
 
-char *TCID = "mmap09";
-int TST_TOTAL = 3;
+#include <stdlib.h>
+#include "tst_test.h"
 
+#define mapsize (1 << 14)
+#define TEMPFILE "mmapfile"
 static int fd;
-static char *maddr;
+static char *addr;
 
-static struct test_case_t {
+static struct tcase {
 	off_t newsize;
 	char *desc;
-} TC[] = {
-	{mapsize - 8192, "ftruncate mmaped file to a smaller size"},
-	{mapsize + 1024, "ftruncate mmaped file to a larger size"},
-	{0, "ftruncate mmaped file to 0 size"},
+} tcases[] = {
+	{mapsize - 8192, "ftruncate mapped file to a smaller size"},
+	{mapsize + 1024, "ftruncate mapped file to a bigger size"},
+	{0, "ftruncate mapped file to zero size"}
 };
 
-static void setup(void);
-static void cleanup(void);
-
-int main(int argc, char **argv)
+static void setup(void)
 {
-	int lc;
-	int i;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
+	fd = SAFE_OPEN(TEMPFILE, O_RDWR | O_CREAT, 0666);
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		for (i = 0; i < TST_TOTAL; i++) {
-			TEST(ftruncate(fd, TC[i].newsize));
+	SAFE_FTRUNCATE(fd, mapsize);
 
-			if (TEST_RETURN == -1) {
-				tst_resm(TFAIL | TTERRNO, "%s", TC[i].desc);
-			} else {
-				tst_resm(TPASS, "%s", TC[i].desc);
-			}
-		}
+	addr = mmap(0, mapsize, PROT_READ | PROT_WRITE, MAP_FILE | MAP_SHARED, fd, 0);
+	if (addr == MAP_FAILED)
+		tst_brk(TFAIL | TERRNO, "mmap() failed");
 
-	}
+	memset(addr, 'A', mapsize);
 
-	cleanup();
-	tst_exit();
 }
 
-static void setup(void)
+static void run(unsigned int i)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	struct stat stat_buf;
+	struct tcase *tc = &tcases[i];
 
-	tst_tmpdir();
+	TST_EXP_PASS(ftruncate(fd, tc->newsize), "%s", tc->desc);
 
-	if ((fd = open("mmaptest", O_RDWR | O_CREAT, 0666)) < 0)
-		tst_brkm(TFAIL | TERRNO, cleanup, "opening mmaptest failed");
+	SAFE_FSTAT(fd, &stat_buf);
+	TST_EXP_EQ_LI(stat_buf.st_size, tc->newsize);
 
-	/* ftruncate the file to 16k */
-	if (ftruncate(fd, mapsize) < 0)
-		tst_brkm(TFAIL | TERRNO, cleanup, "ftruncate file failed");
-
-	maddr = mmap(0, mapsize, PROT_READ | PROT_WRITE,
-		     MAP_FILE | MAP_SHARED, fd, 0);
-	if (maddr == MAP_FAILED)
-		tst_brkm(TFAIL | TERRNO, cleanup, "mmapping mmaptest failed");
-
-	/* fill up the file with A's */
-	memset(maddr, 'A', mapsize);
+	SAFE_FTRUNCATE(fd, mapsize);
 }
 
 static void cleanup(void)
 {
-	munmap(maddr, mapsize);
-	close(fd);
-	tst_rmdir();
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+	if (addr)
+		SAFE_MUNMAP(addr, mapsize);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_tmpdir = 1
+};
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
