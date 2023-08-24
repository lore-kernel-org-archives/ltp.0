Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D46A0C3DA6F
	for <ltp@archiver.kernel.org>; Thu, 24 Aug 2023 07:44:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3FC873CC522
	for <ltp@archiver.kernel.org>; Thu, 24 Aug 2023 09:44:26 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1FE323C2A04
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 09:44:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C13CB1400B76
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 09:44:12 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6595D22CAF
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 07:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692863052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0v6qxTVDqZBWagSgW9Qsogb/8kZwDFUhxvNnQFEHqIw=;
 b=t4JG4pZXm6LNHkrCvUxR/WZZeftGjJshQFT7Me4PFOcmfc8GH43AWIWLPTtGmA9FX68hde
 7Z0uvJaV40yO7OKSQhSGVhRhmT88l+Lsj92cmBpxQQcms7vv8Esz1S5RdrsCdfSDHAiots
 8VSYtfw1jOzA7TSkBQEZVdy52Nr7g1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692863052;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0v6qxTVDqZBWagSgW9Qsogb/8kZwDFUhxvNnQFEHqIw=;
 b=S8n+OaROSjKXPSXN5D9nFG8VozLnDrEcIMH/lCySZkN022XX3yXlMGHx8Y3vtkX/etRkcx
 +9gXoDUwMIGY+XBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F0C47139BC
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 07:44:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cTgUL0sK52TxKQAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 07:44:11 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu, 24 Aug 2023 13:08:42 +0530
Message-ID: <20230824074406.1129-2-akumar@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824074406.1129-1-akumar@suse.de>
References: <20230824074406.1129-1-akumar@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] syscalls/mmap06: Refactor and add scenarios for
 EACCES test
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

As mmap() should always result in EACCES when a file mapping is
requested but the file descriptor is not open for reading, I've added
few possible combinations for prot and flags arguments to test for
EACCES.

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/mmap/mmap06.c | 171 +++++++-----------------
 1 file changed, 51 insertions(+), 120 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap06.c b/testcases/kernel/syscalls/mmap/mmap06.c
index fb7c49257..05e0ffc69 100644
--- a/testcases/kernel/syscalls/mmap/mmap06.c
+++ b/testcases/kernel/syscalls/mmap/mmap06.c
@@ -1,143 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2001
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
+ *  07/2001 Ported by Wayne Boyer
+ * Copyright (c) 2023 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
 
-/*
- * Test Description:
- *  Call mmap() to map a file creating a mapped region with read access
- *  under the following conditions -
- *	- The prot parameter is set to PROT_READ
- *	- The file descriptor is open for writing.
+/*\
+ * [Description]
  *
- *  The call should fail to map the file.
- *
- * Expected Result:
- *  mmap() should fail returning -1 and errno should get set to EACCES.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
+ * Verify that, mmap() call fails when a file mapping is requested but the
+ * file descriptor is not open for reading, and errno is set to EACCES.
  */
-#include <stdio.h>
-#include <stdlib.h>
-#include <sys/types.h>
-#include <errno.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <string.h>
-#include <signal.h>
-#include <sys/stat.h>
-#include <sys/mman.h>
 
-#include "test.h"
-
-#define TEMPFILE	"mmapfile"
-
-char *TCID = "mmap06";
-int TST_TOTAL = 1;
+#include <stdlib.h>
+#include "tst_test.h"
 
+#define TEMPFILE "mmapfile"
 static size_t page_sz;
-static char *addr;
-static int fildes;
-
-static void setup(void);
-static void cleanup(void);
-
-int main(int ac, char **av)
-{
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		/*
-		 * Call mmap to map the temporary file 'TEMPFILE'
-		 * with read access.
-		 */
-		errno = 0;
-		addr = mmap(0, page_sz, PROT_READ,
-			    MAP_FILE | MAP_SHARED, fildes, 0);
-		TEST_ERRNO = errno;
-
-		/* Check for the return value of mmap() */
-		if (addr != MAP_FAILED) {
-			tst_resm(TFAIL | TERRNO,
-				 "mmap() returned invalid value, expected: %p",
-				 MAP_FAILED);
-			/* Unmap the mapped memory */
-			if (munmap(addr, page_sz) != 0) {
-				tst_resm(TBROK, "munmap() failed");
-				cleanup();
-			}
-			continue;
-		}
-		if (TEST_ERRNO == EACCES) {
-			tst_resm(TPASS, "mmap failed with EACCES");
-		} else {
-			tst_resm(TFAIL | TERRNO,
-				 "mmap failed with unexpected errno");
-		}
-	}
-	cleanup();
-	tst_exit();
-
-}
+static int fd;
+
+static struct tcase {
+	int prot;
+	int flags;
+} tcases[] = {
+	{PROT_WRITE, MAP_FILE | MAP_PRIVATE},
+	{PROT_WRITE, MAP_FILE | MAP_SHARED},
+	{PROT_READ, MAP_FILE | MAP_PRIVATE},
+	{PROT_READ, MAP_FILE | MAP_SHARED},
+	{PROT_READ | PROT_WRITE, MAP_FILE | MAP_PRIVATE},
+	{PROT_READ | PROT_WRITE, MAP_FILE | MAP_SHARED}
+};
 
 static void setup(void)
 {
-	char *tst_buff;
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	char *buf;
 
 	page_sz = getpagesize();
+	buf = SAFE_CALLOC(page_sz, sizeof(char));
+	memset(buf, 'A', page_sz);
 
-	/* Allocate space for the test buffer */
-	if ((tst_buff = calloc(page_sz, sizeof(char))) == NULL) {
-		tst_brkm(TFAIL, NULL, "calloc() failed (tst_buff)");
-	}
-
-	/* Fill the test buffer with the known data */
-	memset(tst_buff, 'A', page_sz);
-
-	tst_tmpdir();
+	fd = SAFE_OPEN(TEMPFILE, O_WRONLY | O_CREAT, 0666);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, page_sz);
+	free(buf);
+}
 
-	/* Creat a temporary file used for mapping */
-	if ((fildes = open(TEMPFILE, O_WRONLY | O_CREAT, 0666)) < 0) {
-		free(tst_buff);
-		tst_brkm(TFAIL, cleanup, "opening %s failed", TEMPFILE);
-	}
+static void run(unsigned int i)
+{
+	struct tcase *tc = &tcases[i];
 
-	/* Write test buffer contents into temporary file */
-	if (write(fildes, tst_buff, page_sz) < (ssize_t)page_sz) {
-		free(tst_buff);
-		tst_brkm(TFAIL, cleanup, "writing to %s failed", TEMPFILE);
-	}
+	TESTPTR(mmap(0, page_sz, tc->prot, tc->flags, fd, 0));
 
-	free(tst_buff);
+	if (TST_RET_PTR != MAP_FAILED) {
+		tst_res(TFAIL | TERRNO, "mmap() was successful unexpectedly");
+		SAFE_MUNMAP(TST_RET_PTR, page_sz);
+	} else if (TST_ERR == EACCES)
+		tst_res(TPASS, "mmap() failed with errno EACCES");
+	else
+		tst_res(TFAIL | TERRNO, "mmap() failed but unexpected errno");
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
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_tmpdir = 1
+};
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
