Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CAF6C3DA66
	for <ltp@archiver.kernel.org>; Fri, 25 Aug 2023 06:39:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED14F3CC3FA
	for <ltp@archiver.kernel.org>; Fri, 25 Aug 2023 08:39:48 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E8C283CC35A
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 08:39:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 15B31600922
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 08:39:35 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F16E5206F1
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 06:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692945574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=L3cITqC7AsP9Cd24C9jTgJNkFL/1f4G0shPPOm4fMAc=;
 b=JC80FOhBLYOZlgnnCLz7WAaZ13JLedDY42+xv4MP1hQv0V6i4B+D4uTDkDYD7Q7m2roROZ
 rhEymTFTL7dJcACv4pACIlmW1z6Cc5Kcluot3qLsVK9sj4joo98xnR+HZPONxBCDFUzq+N
 eK7PVAIBpx9dQ8xn+lL7tjhnvVzP1eU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692945574;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=L3cITqC7AsP9Cd24C9jTgJNkFL/1f4G0shPPOm4fMAc=;
 b=/bAsGittIqMBLCKD23I6/7f/bD/QBWlty8kefnktA+TTJCdsJXwWfdv9prERLv0NFaEHo5
 ynHKlhkE5IpVX5Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F1DA138F9
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 06:39:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GT3SF6ZM6GR0LwAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 06:39:34 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Fri, 25 Aug 2023 12:08:38 +0530
Message-ID: <20230825063932.30875-1-akumar@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/5] syscalls/mmap08: Rewrite the test using new LTP
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

Usage of SAFE_CALLOC is based on the patch sent earlier[1]

Signed-off-by: Avinesh Kumar <akumar@suse.de>

[1] https://lore.kernel.org/ltp/20230818112023.18159-1-akumar@suse.de/
---
 testcases/kernel/syscalls/mmap/mmap08.c | 159 ++++++------------------
 1 file changed, 39 insertions(+), 120 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap08.c b/testcases/kernel/syscalls/mmap/mmap08.c
index f2daf45a3..226c6b5a4 100644
--- a/testcases/kernel/syscalls/mmap/mmap08.c
+++ b/testcases/kernel/syscalls/mmap/mmap08.c
@@ -1,142 +1,61 @@
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
- *  Verify that mmap() fails to map a file creating a mapped region
- *  when the file specified by file descriptor is not valid.
+/*\
+ * [Description]
  *
- * Expected Result:
- *  mmap() should fail returning -1 and errno should get set to EBADF.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
+ * verify that, mmap() calls fails with errno EBADF when a file mapping
+ * is requested but the fd is not a valid file descriptor.
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
-
-#include "test.h"
-
-#define TEMPFILE	"mmapfile"
 
-char *TCID = "mmap08";
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
-		 * which is already closed. so, fildes is not valid.
-		 */
-		errno = 0;
-		addr = mmap(0, page_sz, PROT_WRITE,
-			    MAP_FILE | MAP_SHARED, fildes, 0);
-		TEST_ERRNO = errno;
-
-		/* Check for the return value of mmap() */
-		if (addr != MAP_FAILED) {
-			tst_resm(TFAIL, "mmap() didn't fail (%p != %p)",
-				 addr, MAP_FAILED);
-			/* Unmap the mapped memory */
-			if (munmap(addr, page_sz) != 0) {
-				tst_brkm(TBROK, cleanup, "munmap() failed");
-			}
-			continue;
-		}
-		if (TEST_ERRNO == EBADF) {
-			tst_resm(TPASS, "mmap failed with EBADF");
-		} else {
-			tst_resm(TFAIL | TERRNO,
-				 "mmap failed with an invalid errno");
-		}
-	}
-
-	cleanup();
-	tst_exit();
-}
+static int fd;
 
 static void setup(void)
 {
-	char *tst_buff;
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	char *buf;
 
 	page_sz = getpagesize();
 
-	if ((tst_buff = calloc(page_sz, sizeof(char))) == NULL) {
-		tst_brkm(TFAIL, NULL,
-			 "calloc() failed to allocate space for tst_buff");
-	}
+	buf = SAFE_CALLOC(page_sz, sizeof(char));
+	memset(buf, 'A', page_sz);
 
-	/* Fill the test buffer with the known data */
-	memset(tst_buff, 'A', page_sz);
-
-	tst_tmpdir();
-
-	/* Creat a temporary file used for mapping */
-	if ((fildes = open(TEMPFILE, O_WRONLY | O_CREAT, 0666)) < 0) {
-		free(tst_buff);
-		tst_brkm(TFAIL, cleanup, "opening %s failed", TEMPFILE);
-	}
-
-	/* Write test buffer contents into temporary file */
-	if (write(fildes, tst_buff, page_sz) != (int)page_sz) {
-		free(tst_buff);
-		tst_brkm(TFAIL, cleanup, "writing to %s failed", TEMPFILE);
-	}
-
-	/* Free the memory allocated for test buffer */
-	free(tst_buff);
+	fd = SAFE_OPEN(TEMPFILE, O_RDWR | O_CREAT, 0666);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, page_sz);
+	free(buf);
+	SAFE_CLOSE(fd);
+}
 
-	/* Close the temporary file opened for writing */
-	if (close(fildes) < 0) {
-		tst_brkm(TFAIL, cleanup, "closing %s failed", TEMPFILE);
-	}
+static void run(void)
+{
+	TESTPTR(mmap(0, page_sz, PROT_WRITE, MAP_FILE | MAP_SHARED, fd, 0));
+
+	if (TST_RET_PTR != MAP_FAILED) {
+		tst_res(TFAIL, "mmap() passed unexpectedly");
+		SAFE_MUNMAP(TST_RET_PTR, page_sz);
+	} else if (TST_ERR == EBADF)
+		tst_res(TPASS, "mmap() failed with EBADF");
+	else
+		tst_res(TFAIL | TERRNO, "mmap() failed with an invalid errno");
 }
 
 static void cleanup(void)
 {
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
