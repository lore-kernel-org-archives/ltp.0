Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FAD6CA5531
	for <ltp@archiver.kernel.org>; Wed, 13 Sep 2023 10:08:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 602563CE778
	for <ltp@archiver.kernel.org>; Wed, 13 Sep 2023 12:08:21 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BCF43CB2BA
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 12:08:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 098906008F0
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 12:08:08 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8CEF11F390
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 10:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694599686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2UOVd2Q2Sr1m9DI0x5PEYDSORpbekkr4Wf/mZUNJFro=;
 b=VzKrsq1z1bV8XY6SgeEoQv0LLspl9zhWgiIScEpFySp/CDSXTtNokYcyTnDYtyhECIdRaL
 9CKsdfiD52lVpJxr6rsIXhnUyFk4sieycIbDfUZZ51q2G4H9Su/u9wVQbKsfVNWP1iM3yr
 V4KlWdbri4EFTwgdNZscoeV63tZOpbM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694599686;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2UOVd2Q2Sr1m9DI0x5PEYDSORpbekkr4Wf/mZUNJFro=;
 b=uOCLwXkzPcu5feAjYSZk1T4a5iqq9BsZNRw+jCbbNAYrim88JD+tKCLEAHPjxBGg65UeWg
 OjX0EogXzYbDeECw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B3C613440
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 10:08:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 5OcqAQaKAWXMWgAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 10:08:06 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Wed, 13 Sep 2023 15:38:01 +0530
Message-ID: <20230913100803.13756-1-akumar@suse.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] syscalls/munmap01: Refactor the test using new
 LTP API
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
 testcases/kernel/syscalls/munmap/munmap01.c | 272 ++++----------------
 1 file changed, 49 insertions(+), 223 deletions(-)

diff --git a/testcases/kernel/syscalls/munmap/munmap01.c b/testcases/kernel/syscalls/munmap/munmap01.c
index 2a5cfc90d..e8e510d77 100644
--- a/testcases/kernel/syscalls/munmap/munmap01.c
+++ b/testcases/kernel/syscalls/munmap/munmap01.c
@@ -1,249 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
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
+ * Copyright (c) International Business Machines  Corp., 2001
+ *  07/2001 Ported by Wayne Boyer
+ * Copyright (c) 2023 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
 
-/*
- * Test Name: munmap01
- *
- * Test Description:
- *  Verify that, munmap call will succeed to unmap a mapped file or
- *  anonymous shared memory region from the calling process's address space
- *  and after successful completion of munmap, the unmapped region is no
- *  longer accessible.
- *
- * Expected Result:
- *  munmap call should succeed to unmap a mapped file or anonymous shared
- *  memory region from the process's address space and it returns with a
- *  value 0, further reference to the unmapped region should result in a
- *  segmentation fault (SIGSEGV).
+/*\
+ * [Description]
  *
- * Algorithm:
- *  Setup:
- *   Setup signal handling.
- *   Create temporary directory.
- *   Pause for SIGUSR1 if option specified.
- *
- *  Test:
- *   Loop if the proper options are given.
- *   Execute system call
- *   Check return code, if system call failed (return=-1)
- *   	Log the errno and Issue a FAIL message.
- *   Otherwise,
- *   	Verify the Functionality of system call
- *      if successful,
- *      	Issue Functionality-Pass message.
- *      Otherwise,
- *		Issue Functionality-Fail message.
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
- *   Delete the temporary directory created.
- *
- * Usage:  <for command-line>
- *  munmap01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS:
- *  None.$
+ * Verify that, munmap() call successfully unmaps a mapped region from a
+ * file mapping, and any attempt to access the unmapped region generates
+ * SIGSEGV signal.
  */
-#include <errno.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <sys/stat.h>
-#include <sys/mman.h>
-
-#include "test.h"
-#include "safe_macros.h"
-
-#define TEMPFILE	"mmapfile"
 
-char *TCID = "munmap01";
-int TST_TOTAL = 1;
+#include "tst_test.h"
+#include <setjmp.h>
 
-char *addr;			/* addr of memory mapped region */
-int fildes;			/* file descriptor for tempfile */
-unsigned int map_len;		/* length of the region to be mapped */
+#define TEMPFILE "mmapfile"
+static char *addr;
+static int fd;
+static volatile int sig_flag;
+static sigjmp_buf env;
+static size_t page_sz;
 
-void setup();			/* Main setup function of test */
-void cleanup();			/* cleanup function for the test */
-void sig_handler();		/* signal catching function */
-
-int main(int ac, char **av)
+static void sig_handler(int sig)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		setup();
-
-		/*
-		 * Call munmap to unmap the mapped region of the
-		 * temporary file from the calling process's address space.
-		 */
-		TEST(munmap(addr, map_len));
-
-		/* Check for the return value of munmap() */
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "munmap() fails, errno=%d : %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-			continue;
-		}
-#ifdef UCLINUX
-		/*
-		 * No SIGSEGV on uClinux since
-		 * MMU not implemented on uClinux
-		 */
-		tst_resm(TPASS, "call succedded");
-#else
-		/*
-		 * Check whether further reference is possible
-		 * to the unmapped memory region by writing
-		 * to the first byte of region with
-		 * some arbitrary number.
-		 */
-		*addr = 50;
-
-		/* This message is printed if no SIGSEGV */
-		tst_resm(TFAIL, "process succeeds to refer unmapped "
-			 "memory region");
-#endif
-
-		cleanup();
-
+	if (sig == SIGSEGV) {
+		sig_flag = 1;
+		siglongjmp(env, 1);
 	}
-	tst_exit();
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- *
- * Set up signal handler to catch SIGSEGV.
- * Get system page size, create a temporary file for reading/writing,
- * write one byte data into it, map the open file for the specified
- * map length.
- */
-void setup(void)
+static void setup(void)
 {
-	size_t page_sz;
+	SAFE_SIGNAL(SIGSEGV, sig_handler);
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	/* call signal function to trap the signal generated */
-	if (signal(SIGSEGV, sig_handler) == SIG_ERR) {
-		tst_brkm(TBROK, cleanup, "signal fails to catch signal");
-	}
-
-	TEST_PAUSE;
-
-	/* Get the system page size */
 	page_sz = getpagesize();
+	fd = SAFE_OPEN(TEMPFILE, O_RDWR | O_CREAT, 0666);
 
-	/*
-	 * Get the length of the open file to be mapped into process
-	 * address space.
-	 */
-	map_len = 3 * page_sz;
-
-	tst_tmpdir();
+	SAFE_LSEEK(fd, page_sz * 2, SEEK_SET);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, "a", 1);
+}
 
-	/* Creat a temporary file used for mapping */
-	if ((fildes = open(TEMPFILE, O_RDWR | O_CREAT, 0666)) < 0) {
-		tst_brkm(TBROK, cleanup, "open() on %s Failed, errno=%d : %s",
-			 TEMPFILE, errno, strerror(errno));
-	}
+static void run(void)
+{
+	addr = SAFE_MMAP(NULL, page_sz, PROT_READ | PROT_WRITE, MAP_FILE | MAP_SHARED, fd, 0);
 
-	/*
-	 * move the file pointer to maplength position from the beginning
-	 * of the file.
-	 */
-	SAFE_LSEEK(cleanup, fildes, map_len, SEEK_SET);
+	TST_EXP_PASS(munmap(addr, page_sz));
+	if (TST_RET == -1)
+		return;
 
-	/* Write one byte into temporary file */
-	if (write(fildes, "a", 1) != 1) {
-		tst_brkm(TBROK, cleanup, "write() on %s Failed, errno=%d : %s",
-			 TEMPFILE, errno, strerror(errno));
-	}
+	if (sigsetjmp(env, 1) == 0)
+		*addr = 50;
 
-	/*
-	 * map the open file 'TEMPFILE' from its beginning up to the maplength
-	 * into the calling process's address space at the system choosen
-	 * with read/write permissions to the the mapped region.
-	 */
-#ifdef UCLINUX
-	/* MAP_SHARED is not implemented on uClinux */
-	addr = mmap(0, map_len, PROT_READ | PROT_WRITE,
-		    MAP_FILE | MAP_PRIVATE, fildes, 0);
-#else
-	addr = mmap(0, map_len, PROT_READ | PROT_WRITE,
-		    MAP_FILE | MAP_SHARED, fildes, 0);
-#endif
-
-	/* check for the return value of mmap system call */
-	if (addr == (char *)MAP_FAILED) {
-		tst_brkm(TBROK, cleanup, "mmap() Failed on %s, errno=%d : %s",
-			 TEMPFILE, errno, strerror(errno));
-	}
+	if (sig_flag == 1)
+		tst_res(TPASS, "Received SIGSEGV signal");
+	else
+		tst_res(TFAIL, "SIGSEGV signal not received");
 
+	sig_flag = 0;
 }
 
-/*
- * sig_handler() - signal catching function.
- *   This function is used to trap the signal generated when tried to read or
- *   write to the memory mapped region which is already detached from the
- *   calling process address space.
- *   this function is invoked when SIGSEGV generated and it calls test
- *   cleanup function and exit the program.
- */
-void sig_handler(void)
+static void cleanup(void)
 {
-	tst_resm(TPASS, "Functionality of munmap() successful");
-
-	/* Invoke test cleanup function and exit */
-	cleanup();
-
-	tst_exit();
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- *  	       Close the temporary file.
- *  	       Remove the temporary directory.
- */
-void cleanup(void)
-{
-
-	/* Close the temporary file */
-	if (close(fildes) < 0) {
-		tst_brkm(TFAIL, NULL, "close() on %s Failed, errno=%d : %s",
-			 TEMPFILE, errno, strerror(errno));
-	}
-
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+	.needs_tmpdir = 1
+};
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
