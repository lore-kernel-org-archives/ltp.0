Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2BCEC7113B
	for <ltp@archiver.kernel.org>; Thu, 24 Aug 2023 07:44:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3BE023CC556
	for <ltp@archiver.kernel.org>; Thu, 24 Aug 2023 09:44:56 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 948D23CC4C0
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 09:44:16 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0C51B1000947
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 09:44:15 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8E6F020EB1
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 07:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692863055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dKW9wJ4aq6THeSRN/kLZgAU8zioMu14gO2M/dWaPjHM=;
 b=o3pKKSF1dNPix67mqgjpQqhACjTOfhni4qby7dZtpyD0NvX9N/oQOxL6MakHmjVkt1PT5L
 odoRDiaigXG1sj3q1GDm+SSmGCdbwACT5He18N3bK3oq9llJIeXW6hO0obM6KtqfkM/ng1
 6qxhOBOrckuRhVPS5XUD5gHOGR7C0HU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692863055;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dKW9wJ4aq6THeSRN/kLZgAU8zioMu14gO2M/dWaPjHM=;
 b=tMHkh6CsHiAEEHNTSG/Vyr92QdqdHrZgpcRbK0XGM84u8h4NqdhBkbzHru8HNCm7cjyMks
 2k0aQ4DWNpLUk3Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2A549139BC
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 07:44:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SFeqOk4K52T4KQAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 07:44:14 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu, 24 Aug 2023 13:08:43 +0530
Message-ID: <20230824074406.1129-3-akumar@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824074406.1129-1-akumar@suse.de>
References: <20230824074406.1129-1-akumar@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] syscalls/mmap07: Remove the test
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

As we are testing for EACCES in this test also when file descriptor is
not open for reading, I have moved this scenario to mmap06.c along with
other EACCES tests, so I guess it's safe to remove this one.

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 runtest/syscalls                          |   1 -
 testcases/kernel/syscalls/mmap/.gitignore |   1 -
 testcases/kernel/syscalls/mmap/mmap07.c   | 146 ----------------------
 3 files changed, 148 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/mmap/mmap07.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 1028e45fc..4bacb4017 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -785,7 +785,6 @@ mmap03 mmap03
 mmap04 mmap04
 mmap05 mmap05
 mmap06 mmap06
-mmap07 mmap07
 mmap08 mmap08
 mmap09 mmap09
 mmap12 mmap12
diff --git a/testcases/kernel/syscalls/mmap/.gitignore b/testcases/kernel/syscalls/mmap/.gitignore
index 569a76ac1..4591fdbb9 100644
--- a/testcases/kernel/syscalls/mmap/.gitignore
+++ b/testcases/kernel/syscalls/mmap/.gitignore
@@ -5,7 +5,6 @@
 /mmap04
 /mmap05
 /mmap06
-/mmap07
 /mmap08
 /mmap09
 /mmap10
diff --git a/testcases/kernel/syscalls/mmap/mmap07.c b/testcases/kernel/syscalls/mmap/mmap07.c
deleted file mode 100644
index 682e527aa..000000000
--- a/testcases/kernel/syscalls/mmap/mmap07.c
+++ /dev/null
@@ -1,146 +0,0 @@
-/*
- * Copyright (c) International Business Machines  Corp., 2001
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
- */
-
-/*
- * Test Description:
- *  Call mmap() to map a file creating a mapped region with read access
- *  under the following conditions -
- *	- The prot parameter is set to PROT_WRITE
- *	- The file descriptor is open for writing.
- *	- The flags parameter has MAP_PRIVATE set.
- *
- *  The call should fail to map the file.
- *
- * Expected Result:
- *  mmap() should fail returning -1 and errno should get set to EACCES.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- */
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
-
-char *TCID = "mmap07";
-int TST_TOTAL = 1;
-
-static size_t page_sz;
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
-		 * with write access.
-		 */
-		errno = 0;
-		addr = mmap(0, page_sz, PROT_WRITE,
-			    MAP_FILE | MAP_PRIVATE, fildes, 0);
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
-
-	}
-	cleanup();
-	tst_exit();
-
-}
-
-static void setup(void)
-{
-	char *tst_buff;
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	page_sz = getpagesize();
-
-	/* Allocate space for the test buffer */
-	if ((tst_buff = calloc(page_sz, sizeof(char))) == NULL) {
-		tst_brkm(TFAIL, NULL,
-			 "calloc() failed to allocate space for tst_buff");
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
-		tst_brkm(TFAIL, cleanup, "open() on %s failed", TEMPFILE);
-	}
-
-	/* Write test buffer contents into temporary file */
-	if (write(fildes, tst_buff, page_sz) < (int)page_sz) {
-		free(tst_buff);
-		tst_brkm(TFAIL, cleanup, "writing to %s failed", TEMPFILE);
-	}
-
-	free(tst_buff);
-}
-
-static void cleanup(void)
-{
-	close(fildes);
-	tst_rmdir();
-}
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
