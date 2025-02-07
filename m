Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A569C02194
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 14:52:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C8503C9230
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 15:52:05 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 332803C9396
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 15:50:38 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 52485100035C
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 15:50:37 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 217A31F44E
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 14:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738939836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LwpPAfhgNTCqg2WyeqHvm+ld8eX+pCkXntlILiEi2d4=;
 b=yaj15Z+JxSJ2VftPmxzntMcqFfgWb7H9KjsVykRCnnnBYLrz4LlYTUOcXlKrRO48N0rdoh
 4+s4XPmc4Rw2eLwKMI9MONZ2wERaQbtA9o8TlKDN6MgGS2/8NiKn99WuLEocXEPNxXyRu5
 OaIvxZahAhe0CPkI91uj70QVujmWdDQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738939836;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LwpPAfhgNTCqg2WyeqHvm+ld8eX+pCkXntlILiEi2d4=;
 b=GQG8o7VDW0urks0RzeOh1Cy9B2ngkyWUOc6bhY2bqe15HToc5MXjXeg3XU0nDHf6ettdlW
 XsPb4g7CbbRkbbDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738939836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LwpPAfhgNTCqg2WyeqHvm+ld8eX+pCkXntlILiEi2d4=;
 b=yaj15Z+JxSJ2VftPmxzntMcqFfgWb7H9KjsVykRCnnnBYLrz4LlYTUOcXlKrRO48N0rdoh
 4+s4XPmc4Rw2eLwKMI9MONZ2wERaQbtA9o8TlKDN6MgGS2/8NiKn99WuLEocXEPNxXyRu5
 OaIvxZahAhe0CPkI91uj70QVujmWdDQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738939836;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LwpPAfhgNTCqg2WyeqHvm+ld8eX+pCkXntlILiEi2d4=;
 b=GQG8o7VDW0urks0RzeOh1Cy9B2ngkyWUOc6bhY2bqe15HToc5MXjXeg3XU0nDHf6ettdlW
 XsPb4g7CbbRkbbDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0574413AC0
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 14:50:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eFVCO7sdpmcdQgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Fri, 07 Feb 2025 14:50:35 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 07 Feb 2025 15:50:30 +0100
MIME-Version: 1.0
Message-Id: <20250207-mmap_suite_refactoring-v1-1-d006d921e4d5@suse.com>
References: <20250207-mmap_suite_refactoring-v1-0-d006d921e4d5@suse.com>
In-Reply-To: <20250207-mmap_suite_refactoring-v1-0-d006d921e4d5@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738939835; l=8939;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=xURJaHhUf8QNL/7VZoOlqPRySmR3n5V1h7wt1zIs0Gs=;
 b=vFV/zfOshCO9b9W2C6mLIDRHwfQOd0U4M04gwvNEHOJQ3O8WH0S9xlEGvZI80j0knegPXwIXS
 tJ2B3yUU4oACT9nAIkaKeIFBOr7ua1cUv3XaH2hGnLGYN4BMcOsmzui
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/8] Refactor mmap03 test
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/mmap/mmap03.c | 265 +++++++++-----------------------
 1 file changed, 71 insertions(+), 194 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap03.c b/testcases/kernel/syscalls/mmap/mmap03.c
index 9d94d2653661387d22f811cd959a87b8112c1167..f22365b259dac4e99bf8ced7f952bbc3696da509 100644
--- a/testcases/kernel/syscalls/mmap/mmap03.c
+++ b/testcases/kernel/syscalls/mmap/mmap03.c
@@ -1,230 +1,107 @@
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
+ *               07/2001 Ported by Wayne Boyer
+ * Copyright (C) 2025 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
-/*
- * Test Description:
- *  Call mmap() to map a file creating a mapped region with execute access
- *  under the following conditions -
- *	- The prot parameter is set to PROT_EXE
- *	- The file descriptor is open for read
- *	- The file being mapped has execute permission bit set.
- *	- The minimum file permissions should be 0555.
+/*\
+ * [Description]
+ *
+ * Map a file with mmap() syscall, creating a mapped region with execute access
+ * under the following conditions:
  *
- *  The call should succeed to map the file creating mapped memory with the
- *  required attributes.
+ * - file descriptor is open for read
+ * - minimum file permissions should be 0555
+ * - file being mapped has PROT_EXEC execute permission bit set
  *
- * Expected Result:
- *  mmap() should succeed returning the address of the mapped region,
- *  and the mapped region should contain the contents of the mapped file.
- *  but with ia64 and PARISC/hppa,
- *  an attempt to access the contents of the mapped region should give
- *  rise to the signal SIGSEGV.
+ * mmap() should succeed returning the address of the mapped region
+ * and the mapped region should contain the contents of the mapped file.
  *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
+ * With ia64 and PARISC/hppa, an attempt to access the contents of the
+ * mapped region should rise signal SIGSEGV.
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
-#include <setjmp.h>
 
-#include "test.h"
+#include "tst_test.h"
 
-#define TEMPFILE	"mmapfile"
-
-char *TCID = "mmap03";
-int TST_TOTAL = 1;
+#define TEMPFILE "mmapfile"
 
+static void *addr;
+static char *tmpdata;
 static size_t page_sz;
-static char *addr;
-static char *dummy;
-static int fildes;
-static volatile int pass = 0;
-static sigjmp_buf env;
-
-static void setup(void);
-static void cleanup(void);
-static void sig_handler(int sig);
+static int fdesc = -1;
 
-int main(int ac, char **av)
+static void run_child(void)
 {
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
-		 * with execute access.
-		 */
-		errno = 0;
-		addr = mmap(0, page_sz, PROT_EXEC,
-			    MAP_FILE | MAP_SHARED, fildes, 0);
-
-		/* Check for the return value of mmap() */
-		if (addr == MAP_FAILED) {
-			tst_resm(TFAIL | TERRNO, "mmap() failed on %s",
-				 TEMPFILE);
-			continue;
-		}
-
-		/*
-		 * Read the file contents into the dummy
-		 * variable.
-		 */
-		if (read(fildes, dummy, page_sz) < 0) {
-			tst_brkm(TFAIL | TERRNO, cleanup,
-				 "reading %s failed", TEMPFILE);
-		}
-
-		/*
-		 * Check whether the mapped memory region
-		 * has the file contents.
-		 *
-		 * with ia64 and PARISC/hppa, this should
-		 * generate a SIGSEGV which will be caught below.
-		 *
-		 */
-
-		if (sigsetjmp(env, 1) == 0) {
-			if (memcmp(dummy, addr, page_sz)) {
-				tst_resm(TFAIL,
-					 "mapped memory region "
-					 "contains invalid data");
-			} else {
-				tst_resm(TPASS,
-					 "mmap() functionality is "
-					 "correct");
-			}
-		}
-#if defined(__ia64__) || defined(__hppa__) || defined(__mips__)
-		if (pass) {
-			tst_resm(TPASS, "Got SIGSEGV as expected");
-		} else {
-			tst_resm(TFAIL, "Mapped memory region with NO "
-				 "access is accessible");
-		}
-#endif
+	char *data;
 
-		/* Clean up things in case we are looping */
-		/* Unmap the mapped memory */
-		if (munmap(addr, page_sz) != 0) {
-			tst_brkm(TFAIL | TERRNO, cleanup,
-				 "failed to unmap the mmapped pages");
-		}
-		pass = 0;
+	tst_res(TINFO, "Map temporary file in memory with PROT_EXEC");
 
-	}
-
-	cleanup();
-	tst_exit();
-}
+	addr = SAFE_MMAP(0, page_sz, PROT_EXEC,
+		  MAP_FILE | MAP_SHARED, fdesc, 0);
 
-static void setup(void)
-{
-	char *tst_buff;
+	data = SAFE_MALLOC(page_sz);
+	memset(data, 0, page_sz);
 
-	tst_sig(NOFORK, sig_handler, cleanup);
+	tst_res(TINFO, "Read data back from mapped file");
 
-	TEST_PAUSE;
-
-	page_sz = getpagesize();
-
-	/* Allocate space for the test buffer */
-	if ((tst_buff = calloc(page_sz, sizeof(char))) == NULL) {
-		tst_brkm(TFAIL, NULL, "calloc failed (tst_buff)");
-	}
+	SAFE_READ(0, fdesc, data, page_sz);
+	SAFE_LSEEK(fdesc, 0, SEEK_SET);
 
-	/* Fill the test buffer with the known data */
-	memset(tst_buff, 'A', page_sz);
+	TST_EXP_EQ_LI(memcmp(data, tmpdata, page_sz), 0);
 
-	tst_tmpdir();
+	SAFE_MUNMAP(addr, page_sz);
+	free(data);
+}
 
-	/* Creat a temporary file used for mapping */
-	if ((fildes = open(TEMPFILE, O_WRONLY | O_CREAT, 0666)) < 0) {
-		free(tst_buff);
-		tst_brkm(TFAIL | TERRNO, cleanup, "opening %s failed",
-			 TEMPFILE);
-	}
+static void run(void)
+{
+	pid_t pid;
+	int status;
 
-	/* Write test buffer contents into temporary file */
-	if (write(fildes, tst_buff, page_sz) < (long)page_sz) {
-		free(tst_buff);
-		tst_brkm(TFAIL | TERRNO, cleanup, "writing to %s failed",
-			 TEMPFILE);
+	pid = SAFE_FORK();
+	if (!pid) {
+		run_child();
+		exit(0);
 	}
 
-	/* Free the memory allocated for test buffer */
-	free(tst_buff);
+	SAFE_WAITPID(pid, &status, 0);
 
-	/* Make sure proper permissions set on file */
-	if (fchmod(fildes, 0555) < 0) {
-		tst_brkm(TFAIL, cleanup, "fchmod of %s failed", TEMPFILE);
+#if defined(__ia64__) || defined(__hppa__) || defined(__mips__)
+	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
+		tst_res(TPASS, "SIGSEGV has been received");
+	} else {
+		tst_res(TFAIL, "Mapped memory region with NO "
+			"access is accessible");
 	}
+#endif
+}
 
-	/* Close the temporary file opened for write */
-	if (close(fildes) < 0) {
-		tst_brkm(TFAIL | TERRNO, cleanup, "closing %s failed",
-			 TEMPFILE);
-	}
+static void setup(void)
+{
+	page_sz = getpagesize();
 
-	/* Allocate and initialize dummy string of system page size bytes */
-	if ((dummy = calloc(page_sz, sizeof(char))) == NULL) {
-		tst_brkm(TFAIL, cleanup, "calloc failed (dummy)");
-	}
+	tmpdata = SAFE_MALLOC(page_sz);
+	memset(tmpdata, 'a', page_sz);
 
-	/* Open the temporary file again for reading */
-	if ((fildes = open(TEMPFILE, O_RDONLY)) < 0) {
-		tst_brkm(TFAIL | TERRNO, cleanup,
-			 "opening %s read-only failed", TEMPFILE);
-	}
-}
+	tst_res(TINFO, "Create temporary file");
 
-/*
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
-	} else
-		tst_brkm(TBROK, cleanup, "received an unexpected signal");
+	tst_fill_file(TEMPFILE, 'a', page_sz, 1);
+	fdesc = SAFE_OPEN(TEMPFILE, O_RDONLY, 0555);
 }
 
 static void cleanup(void)
 {
-	close(fildes);
-	free(dummy);
-	tst_rmdir();
+	free(tmpdata);
+
+	if (fdesc != -1)
+		SAFE_CLOSE(fdesc);
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
