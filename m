Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B018C678DC
	for <ltp@archiver.kernel.org>; Fri, 18 Aug 2023 11:21:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 363AB3CCAB1
	for <ltp@archiver.kernel.org>; Fri, 18 Aug 2023 13:21:13 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9206C3CCADB
 for <ltp@lists.linux.it>; Fri, 18 Aug 2023 13:20:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 57F561A000A2
 for <ltp@lists.linux.it>; Fri, 18 Aug 2023 13:20:34 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D74E62188A
 for <ltp@lists.linux.it>; Fri, 18 Aug 2023 11:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692357633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x0rtRXkrnLNrOxiZ8FlZiW2KK2abIQIEUiKi/7EOryU=;
 b=DrhZOSSZ6BuIpIz05JzB2SQ1eyHXVtN9Td4fww1J3gyRkd9LWtHvo25UczAZ1YyEaMHxQd
 pynIErUqfKZ+w4yPdu5Nd/8U/KSZuTYiH9ehmNPbzuLuhcsRJ4I/KJO/wqRMTPLFUC4vLN
 cTfLeDh/m4xU0+67TMH3Dq1Ng23Jihg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692357633;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x0rtRXkrnLNrOxiZ8FlZiW2KK2abIQIEUiKi/7EOryU=;
 b=rLqQACosGF41HUatjPOgemJH4ixv6zjieM6SOyLtW2WmNc3StlAJYDyehyIobVT2lvgqTQ
 jFtxqA+AMwak3DCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7AC7813441
 for <ltp@lists.linux.it>; Fri, 18 Aug 2023 11:20:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4CaNEwFU32TEYQAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Fri, 18 Aug 2023 11:20:33 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Fri, 18 Aug 2023 16:50:17 +0530
Message-ID: <20230818112023.18159-4-akumar@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230818112023.18159-1-akumar@suse.de>
References: <20230818112023.18159-1-akumar@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/4] syscalls/mmap04: Rewrite the test using new LTP
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
 testcases/kernel/syscalls/mmap/mmap04.c | 200 ++++++------------------
 1 file changed, 46 insertions(+), 154 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap04.c b/testcases/kernel/syscalls/mmap/mmap04.c
index 43f7b7525..b818a5917 100644
--- a/testcases/kernel/syscalls/mmap/mmap04.c
+++ b/testcases/kernel/syscalls/mmap/mmap04.c
@@ -1,185 +1,77 @@
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
- *  Call mmap() to map a file creating a mapped region with read/exec access
- *  under the following conditions -
- *	- The prot parameter is set to PROT_READ|PROT_EXEC
- *	- The file descriptor is open for read
- *	- The file being mapped has read and execute permission bit set.
- *	- The minimum file permissions should be 0555.
- *
- *  The call should succeed to map the file creating mapped memory with the
- *  required attributes.
+/*\
+ * [Description]
  *
- * Expected Result:
- *  mmap() should succeed returning the address of the mapped region,
- *  and the mapped region should contain the contents of the mapped file.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
+ * Verify that, mmap() call with 'PROT_READ | PROT_EXEC; and file descriptor
+ * which is open for read only and has read and execute permission bits set,
+ * succeeds to map a file creating mapped memory with read/exec access.
  */
 
-#include <stdio.h>
 #include <stdlib.h>
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
-
-char *TCID = "mmap04";
-int TST_TOTAL = 1;
+#include "tst_test.h"
 
+#define TEMPFILE "mmapfile"
 static size_t page_sz;
+static int fd;
 static char *addr;
 static char *dummy;
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
-		 * with read and execute access.
-		 */
-		errno = 0;
-		addr = mmap(0, page_sz, PROT_READ | PROT_EXEC,
-			    MAP_FILE | MAP_SHARED, fildes, 0);
-
-		/* Check for the return value of mmap() */
-		if (addr == MAP_FAILED) {
-			tst_resm(TFAIL | TERRNO, "mmap of %s failed", TEMPFILE);
-			continue;
-		}
-
-		/*
-		 * Read the file contents into the dummy
-		 * variable.
-		 */
-		if (read(fildes, dummy, page_sz) < 0) {
-			tst_brkm(TFAIL, cleanup, "reading %s failed",
-				 TEMPFILE);
-		}
-
-		/*
-		 * Check whether the mapped memory region
-		 * has the file contents.
-		 */
-		if (memcmp(dummy, addr, page_sz)) {
-			tst_resm(TFAIL,
-				 "mapped memory region contains invalid "
-				 "data");
-		} else {
-			tst_resm(TPASS,
-				 "Functionality of mmap() successful");
-		}
-
-		/* Clean up things in case we are looping. */
-		/* Unmap the mapped memory */
-		if (munmap(addr, page_sz) != 0) {
-			tst_brkm(TFAIL, cleanup, "munmapping failed");
-		}
-	}
-
-	cleanup();
-	tst_exit();
-}
 
 static void setup(void)
 {
-	char *tst_buff;
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	char *tst_buf;
 
 	page_sz = getpagesize();
+	tst_buf = SAFE_CALLOC(page_sz, sizeof(char));
+	memset(tst_buf, 'A', page_sz);
 
-	if ((tst_buff = calloc(page_sz, sizeof(char))) == NULL) {
-		tst_brkm(TFAIL, NULL, "calloc failed (tst_buff)");
-	}
-
-	/* Fill the test buffer with the known data */
-	memset(tst_buff, 'A', page_sz);
+	fd = SAFE_OPEN(TEMPFILE, O_RDWR | O_CREAT, 0666);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, tst_buf, page_sz);
+	free(tst_buf);
 
-	tst_tmpdir();
+	SAFE_FCHMOD(fd, 0555);
+	SAFE_CLOSE(fd);
 
-	/* Creat a temporary file used for mapping */
-	if ((fildes = open(TEMPFILE, O_WRONLY | O_CREAT, 0666)) < 0) {
-		free(tst_buff);
-		tst_brkm(TFAIL, cleanup, "opening %s failed", TEMPFILE);
-	}
-
-	/* Write test buffer contents into temporary file */
-	if (write(fildes, tst_buff, page_sz) < (ssize_t)page_sz) {
-		free(tst_buff);
-		tst_brkm(TFAIL, cleanup, "writing to %s failed", TEMPFILE);
-	}
+	fd = SAFE_OPEN(TEMPFILE, O_RDONLY);
+	dummy = SAFE_CALLOC(page_sz, sizeof(char));
+}
 
-	/* Free the memory allocated for test buffer */
-	free(tst_buff);
+static void run(void)
+{
+	addr = mmap(0, page_sz, PROT_READ | PROT_EXEC, MAP_FILE | MAP_SHARED, fd, 0);
 
-	/* Make sure proper permissions set on file */
-	if (fchmod(fildes, 0555) < 0) {
-		tst_brkm(TFAIL, cleanup, "fchmod of %s failed", TEMPFILE);
+	if (addr == MAP_FAILED) {
+		tst_res(TFAIL | TERRNO, "mmap() of %s failed", TEMPFILE);
+		return;
 	}
 
-	/* Close the temporary file opened for write */
-	if (close(fildes) < 0) {
-		tst_brkm(TFAIL, cleanup, "closing %s failed", TEMPFILE);
-	}
+	SAFE_READ(1, fd, dummy, page_sz);
+	SAFE_LSEEK(fd, 0, SEEK_SET);
 
-	/* Allocate and initialize dummy string of system page size bytes */
-	if ((dummy = calloc(page_sz, sizeof(char))) == NULL) {
-		tst_brkm(TFAIL, cleanup, "calloc failed (dummy)");
-	}
+	if (memcmp(dummy, addr, page_sz) == 0)
+		tst_res(TPASS, "mmap() functionality successful");
+	else
+		tst_res(TFAIL, "mapped memory region contains invalid data");
 
-	/* Open the temporary file again for reading */
-	if ((fildes = open(TEMPFILE, O_RDONLY)) < 0) {
-		tst_brkm(TFAIL, cleanup,
-			 "opening %s read-only failed", TEMPFILE);
-	}
+	SAFE_MUNMAP(addr, page_sz);
 }
 
 static void cleanup(void)
 {
-	close(fildes);
-	free(dummy);
-	tst_rmdir();
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+	if (dummy)
+		free(dummy);
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
