Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF2DC7113B
	for <ltp@archiver.kernel.org>; Thu, 24 Aug 2023 07:44:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CCB453CC53C
	for <ltp@archiver.kernel.org>; Thu, 24 Aug 2023 09:44:42 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2CCCD3C2A04
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 09:44:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 277051A0193E
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 09:44:11 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 61DAA22CAE
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 07:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692863049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=n0FLqPX6dy+g+QUi1m/wSDXOukvoc1NBrxt9YoTKuq0=;
 b=ZIde866N9iSJ1u1IhPQ9RKnkojFC2MVqnteoJAMmYrqgo02bZFrNN8yaRvVBJ5Rm4yNOmv
 FCHUzjt7BNeHyV5Zb8ElXX7xga3T0Y/9Plx8bBkWv/mcBt0EdTqP/pNlgw8PLdyw4MjJFb
 tkQ9syecHR3Oktfjc1+4uCN7qFa5OEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692863049;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=n0FLqPX6dy+g+QUi1m/wSDXOukvoc1NBrxt9YoTKuq0=;
 b=+rqLSb6UkFY0djMPxTRtiVlKxf1VqRkjI+22kgrSLHG8WsHs/SDRAG77DgvcNgs6QDHJ9W
 AdEw9mDsieobdoCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE2D1139BC
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 07:44:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IqJ5LkgK52TpKQAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 07:44:08 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu, 24 Aug 2023 13:08:41 +0530
Message-ID: <20230824074406.1129-1-akumar@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] syscalls/mmap05: Rewrite the test using new LTP
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

old test had the condition of file descriptor being opened only in
readonly mode, but to test SIGSEGV signal with PROT_NONE, file
descriptor does not need to be opened with readonly mode, I changed the
test to use file descriptor which is open with read-write mode.


PS: usage of SAFE_CALLOC is based on the patch sent earlier[1]

[1] https://lore.kernel.org/ltp/20230818112023.18159-1-akumar@suse.de/

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/mmap/mmap05.c | 223 ++++++------------------
 1 file changed, 51 insertions(+), 172 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap05.c b/testcases/kernel/syscalls/mmap/mmap05.c
index 82f122543..35e8b47ef 100644
--- a/testcases/kernel/syscalls/mmap/mmap05.c
+++ b/testcases/kernel/syscalls/mmap/mmap05.c
@@ -1,205 +1,84 @@
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
- *  Call mmap() to map a file creating mapped memory with no access under
- *  the following conditions -
- *	- The prot parameter is set to PROT_NONE
- *	- The file descriptor is open for read(any mode other than write)
- *	- The minimum file permissions should be 0444.
- *
- *  The call should succeed to map the file creating mapped memory with the
- *  required attributes.
- *
- * Expected Result:
- *  mmap() should succeed returning the address of the mapped region,
- *  and an attempt to access the contents of the mapped region should give
- *  rise to the signal SIGSEGV.
+/*\
+ * [Description]
  *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
+ * Verify that, mmap() call with 'PROT_NONE' and a file descriptor which is
+ * open for read and write, succeeds to map the file creating mapped memory,
+ * but any attempt to access the contents of the mapped region causes the
+ * SIGSEGV signal.
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
+#include "tst_test.h"
 
-#include "test.h"
-
-#define TEMPFILE	"mmapfile"
-
-char *TCID = "mmap05";
-int TST_TOTAL = 1;
-
+#define TEMPFILE "mmapfile"
 static size_t page_sz;
 static volatile char *addr;
-static int fildes;
-static volatile int pass = 0;
+static int fd;
+static volatile int sig_flag;
 static sigjmp_buf env;
 
-static void setup(void);
-static void cleanup(void);
-static void sig_handler(int sig);
-
-int main(int ac, char **av)
+static void sig_handler(int sig)
 {
-	int lc;
-	char file_content;
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
-		 * with no access.
-		 */
-		errno = 0;
-		addr = mmap(0, page_sz, PROT_NONE,
-			    MAP_FILE | MAP_SHARED, fildes, 0);
-		TEST_ERRNO = errno;
-
-		/* Check for the return value of mmap() */
-		if (addr == MAP_FAILED) {
-			tst_resm(TFAIL | TERRNO, "mmap() failed on %s",
-				 TEMPFILE);
-			continue;
-		}
-
-		/*
-		 * Try to access the mapped region.  This should
-		 * generate a SIGSEGV which will be caught below.
-		 *
-		 * This is wrapped by the sigsetjmp() call that will
-		 * take care of restoring the program's context in an
-		 * elegant way in conjunction with the call to
-		 * siglongjmp() in the signal handler.
-		 */
-		if (sigsetjmp(env, 1) == 0) {
-			file_content = addr[0];
-		}
-
-		if (pass) {
-			tst_resm(TPASS, "Got SIGSEGV as expected");
-		} else {
-			tst_resm(TFAIL, "Mapped memory region with NO "
-				 "access is accessible");
-		}
-
-		/* Unmap mapped memory and reset pass in case we are looping */
-		if (munmap((void *)addr, page_sz) != 0) {
-			tst_brkm(TFAIL | TERRNO, cleanup, "munmap failed");
-		}
-		pass = 0;
-
-	}
-
-	cleanup();
-	tst_exit();
+	if (sig == SIGSEGV) {
+		sig_flag = 1;
+		siglongjmp(env, 1);
+	} else
+		tst_brk(TBROK, "Received an unexpected signal: %d", sig);
 }
 
 static void setup(void)
 {
-	char *tst_buff;
-
-	tst_sig(NOFORK, sig_handler, cleanup);
+	char *buf;
 
-	TEST_PAUSE;
+	SAFE_SIGNAL(SIGSEGV, sig_handler);
 
 	page_sz = getpagesize();
+	buf = SAFE_CALLOC(page_sz, sizeof(char));
+	memset(buf, 'A', page_sz);
 
-	/* Allocate space for the test buffer */
-	if ((tst_buff = calloc(page_sz, sizeof(char))) == NULL) {
-		tst_brkm(TFAIL, NULL, "calloc failed (tst_buff)");
-	}
-
-	/* Fill the test buffer with the known data */
-	memset(tst_buff, 'A', page_sz);
-
-	tst_tmpdir();
-
-	/* Creat a temporary file used for mapping */
-	if ((fildes = open(TEMPFILE, O_WRONLY | O_CREAT, 0666)) < 0) {
-		free(tst_buff);
-		tst_brkm(TFAIL | TERRNO, cleanup, "opening %s failed",
-			 TEMPFILE);
-	}
+	fd = SAFE_OPEN(TEMPFILE, O_RDWR | O_CREAT, 0666);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, page_sz);
+	free(buf);
+}
 
-	/* Write test buffer contents into temporary file */
-	if (write(fildes, tst_buff, page_sz) != (int)page_sz) {
-		free(tst_buff);
-		tst_brkm(TFAIL, cleanup, "writing to %s failed", TEMPFILE);
+static void run(void)
+{
+	addr = mmap(0, page_sz, PROT_NONE, MAP_FILE | MAP_SHARED, fd, 0);
+	if (addr == MAP_FAILED) {
+		tst_res(TFAIL | TERRNO, "mmap() of %s failed", TEMPFILE);
+		return;
 	}
 
-	/* Free the memory allocated for test buffer */
-	free(tst_buff);
+	if (sigsetjmp(env, 1) == 0)
+		tst_res(TINFO, "Trying to access mapped region: %c", addr[0]);
 
-	/* Make sure proper permissions set on file */
-	if (fchmod(fildes, 0444) < 0) {
-		tst_brkm(TFAIL | TERRNO, cleanup, "fchmod of %s failed",
-			 TEMPFILE);
-	}
+	if (sig_flag)
+		tst_res(TPASS, "Received SIGSEGV signal as expected");
+	else
+		tst_res(TFAIL, "SIGSEGV signal not received");
 
-	/* Close the temporary file opened for write */
-	if (close(fildes) < 0) {
-		tst_brkm(TFAIL | TERRNO, cleanup, "closing %s failed",
-			 TEMPFILE);
-	}
+	SAFE_MUNMAP((char *)addr, page_sz);
 
-	/* Open the temporary file again for reading */
-	if ((fildes = open(TEMPFILE, O_RDONLY)) < 0) {
-		tst_brkm(TFAIL | TERRNO, cleanup, "opening %s readonly failed",
-			 TEMPFILE);
-	}
-}
-
-/*
- * sig_handler() - Signal Catching function.
- *   This function gets executed when the test process receives
- *   the signal SIGSEGV while trying to access the contents of memory which
- *   is not accessible.
- */
-static void sig_handler(int sig)
-{
-	if (sig == SIGSEGV) {
-		/* set the global variable and jump back */
-		pass = 1;
-		siglongjmp(env, 1);
-	} else {
-		tst_brkm(TBROK, cleanup, "received an unexpected signal: %d",
-			 sig);
-	}
+	sig_flag = 0;
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
