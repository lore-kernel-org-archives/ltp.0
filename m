Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6690C4452F
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 12:41:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF2C23C26A0
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 14:41:38 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 75A113E1FFE
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 14:41:12 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B0770200919
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 14:41:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2ADC73DFE;
 Tue, 21 Jul 2026 12:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784637663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S2b0FyIQ8UDHPRzAzsx2w8EmBPrXv9XYlGJl1AyO8Oc=;
 b=pKJVB5cA/V5DYMLFVAIoV7MuFdsMKobqxKR9zHVvvUOMm4FuPEYGn2FG99GGVEUd+Ke69N
 a67vHM8Ncw2wY+Ob+QeQtAlsUVf9PE/PON0v96S7qeaCI7WodWTFJ7AvXFCtDui0CruJnA
 gZHPEjMjfjD6QAqg9vY1a+39o+avHlM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784637663;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S2b0FyIQ8UDHPRzAzsx2w8EmBPrXv9XYlGJl1AyO8Oc=;
 b=OEZLeFnp7J3xOEcL7tF23XnhyIUmalxYzWEJrhkDKdl4hBYmcVhU/CTKeFDfiFEOd/V4eh
 hQ15MXJkSO7aWXDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784637663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S2b0FyIQ8UDHPRzAzsx2w8EmBPrXv9XYlGJl1AyO8Oc=;
 b=pKJVB5cA/V5DYMLFVAIoV7MuFdsMKobqxKR9zHVvvUOMm4FuPEYGn2FG99GGVEUd+Ke69N
 a67vHM8Ncw2wY+Ob+QeQtAlsUVf9PE/PON0v96S7qeaCI7WodWTFJ7AvXFCtDui0CruJnA
 gZHPEjMjfjD6QAqg9vY1a+39o+avHlM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784637663;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S2b0FyIQ8UDHPRzAzsx2w8EmBPrXv9XYlGJl1AyO8Oc=;
 b=OEZLeFnp7J3xOEcL7tF23XnhyIUmalxYzWEJrhkDKdl4hBYmcVhU/CTKeFDfiFEOd/V4eh
 hQ15MXJkSO7aWXDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0399D779AB;
 Tue, 21 Jul 2026 12:41:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yDzGOd5oX2plWgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 21 Jul 2026 12:41:02 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 21 Jul 2026 14:41:01 +0200
MIME-Version: 1.0
Message-Id: <20260721-rewrite_mremap_testing_suite-v1-1-ec2c3cff6ea4@suse.com>
References: <20260721-rewrite_mremap_testing_suite-v1-0-ec2c3cff6ea4@suse.com>
In-Reply-To: <20260721-rewrite_mremap_testing_suite-v1-0-ec2c3cff6ea4@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784637662; l=11312;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=K+FJMNU9FUs8xIAwGry1rIEgwwYOJaSnPTd8Q7ZO6Cs=;
 b=VKEfasQSBg8aNZc75AN/Ovbn23+HePSL97dN6SUWZxV9WciCcq3dnPJUMpBfbbDn+uZUqSF+K
 SJZrgz1BuHdCRI4DlNlE4extjt+3E/F8BbdstJNeorbCqim1LFcqZZt
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/5] mremap01: Convert to new API
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

Convert the test to the new LTP API (tst_test.h) using a semantic
rewrite. The test verifies that mremap() with MREMAP_MAYMOVE can grow a
file-backed MAP_SHARED mapping, that the grown region is fully usable,
and that its contents synchronize to the backing file via msync().

The mapping work is performed per-iteration so that '-i' runs always
grow a freshly created mapping instead of an already-grown one.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/mremap/mremap01.c | 281 +++++++++-------------------
 1 file changed, 85 insertions(+), 196 deletions(-)

diff --git a/testcases/kernel/syscalls/mremap/mremap01.c b/testcases/kernel/syscalls/mremap/mremap01.c
index 8c241d45cb7b6127ea7cc25a519c73011b6ea7bc..2cb21835246bb32c59b1e2dd5b6041ae93a6aada 100644
--- a/testcases/kernel/syscalls/mremap/mremap01.c
+++ b/testcases/kernel/syscalls/mremap/mremap01.c
@@ -1,237 +1,126 @@
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
+ * Copyright (c) International Business Machines Corp., 2001
+ * 07/2001 Ported by Wayne Boyer
+ * Copyright (c) Linux Test Project, 2026
  */
 
-/*
- * Test Name: mremap01
- *
- * Test Description:
- *  Verify that, mremap() succeeds when used to expand the existing
- *  virtual memory mapped region to the requested size where the
- *  virtual memory area was previously mapped to a file using mmap().
+/*\
+ * Verify that :manpage:`mremap(2)` succeeds when used to expand an existing
+ * virtual memory region that was previously mapped to a file with
+ * :manpage:`mmap(2)`.
  *
- * Expected Result:
- *  mremap() should succeed returning the address of new virtual memory area.
- *  The expanded mapped memory region should be accessible and able to
- *  synchronize with the file.
+ * After growing the mapping with ``MREMAP_MAYMOVE``, the expanded region must
+ * be fully accessible and its contents must synchronize to the backing file
+ * with :manpage:`msync(2)`.
  *
- * Algorithm:
- *  Setup:
- *   Setup signal handling.
- *   Create temporary directory.
- *   Pause for SIGUSR1 if option specified.
+ * [Algorithm]
  *
- *  Test:
- *   Loop if the proper options are given.
- *   Execute system call
- *   Check return code, if system call failed (return=-1)
- *	Log the errno and Issue a FAIL message.
- *   Otherwise,
- *	Verify the Functionality of system call
- *      if successful,
- *		Issue Functionality-Pass message.
- *      Otherwise,
- *		Issue Functionality-Fail message.
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
- *   Delete the temporary directory created.
- *
- * Usage:  <for command-line>
- *  mremap01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
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
- *      11/09/2001 Manoj Iyer (manjo@austin.ibm.com)
- *	Modified.
- *	- #include <linux/mman.h> should not be included as per man page for
- *	  mremap, #include <sys/mman.h> alone should do the job. But inorder
- *	  to include definition of MREMAP_MAYMOVE defined in bits/mman.h
- *	  (included by sys/mman.h) __USE_GNU needs to be defined.
- *	  There may be a more elegant way of doing this...
- *
- * RESTRICTIONS:
- *  None.
+ * - create a temporary file and stretch it to the initial mapping size
+ * - map the file with ``MAP_SHARED`` and ``PROT_WRITE``
+ * - stretch the file to the new (larger) size before growing the mapping
+ * - grow the mapping with mremap() and ``MREMAP_MAYMOVE``
+ * - write every byte of the grown region to prove it is usable
+ * - synchronize the region to the backing file with ``MS_SYNC``
+ * - read the data back from the backing file to prove it was synchronized
  */
 
 #define _GNU_SOURCE
-#include <unistd.h>
 #include <errno.h>
 #include <sys/mman.h>
-#include <fcntl.h>
-
-#include "test.h"
-#include "tso_safe_macros.h"
+#include "tst_test.h"
+#include "tst_safe_prw.h"
 
 #define TEMPFILE	"mremapfile"
 
-char *TCID = "mremap01";
-int TST_TOTAL = 1;
-char *addr;			/* addr of memory mapped region */
-int memsize;			/* memory mapped size */
-int newsize;			/* new size of virtual memory block */
-int fildes;			/* file descriptor for tempfile */
-
-void setup();			/* Main setup function of test */
-void cleanup();			/* cleanup function for the test */
+static char *addr = MAP_FAILED;
+static size_t memsize;
+static size_t newsize;
+static int fildes = -1;
 
-int main(int ac, char **av)
+static void setup(void)
 {
-	int ind;		/* counter variable */
+	int pagesz = getpagesize();
 
-	tst_parse_opts(ac, av, NULL, NULL);
+	memsize = 1000 * pagesz;
+	newsize = memsize * 2;
 
-	tst_count = 0;
+	fildes = SAFE_OPEN(TEMPFILE, O_RDWR | O_CREAT, 0666);
+}
 
-	setup();
+static int verify_file(void)
+{
+	size_t offsets[3];
+	unsigned int i;
+	char got;
 
-	/*
-	 * Call mremap to expand the existing mapped
-	 * memory region (memsize) by newsize limits.
-	 */
-	addr = mremap(addr, memsize, newsize, MREMAP_MAYMOVE);
+	offsets[0] = 0;
+	offsets[1] = newsize / 2;
+	offsets[2] = newsize - 1;
 
-	/* Check for the return value of mremap() */
-	if (addr == MAP_FAILED)
-		tst_brkm(TFAIL | TERRNO, cleanup, "mremap failed");
+	for (i = 0; i < ARRAY_SIZE(offsets); i++) {
+		size_t off = offsets[i];
 
-	/*
-	 * Attempt to initialize the expanded memory
-	 * mapped region with data. If the map area
-	 * was bad, we'd get SIGSEGV.
-	 */
-	for (ind = 0; ind < newsize; ind++) {
-		addr[ind] = (char)ind;
-	}
+		SAFE_PREAD(1, fildes, &got, 1, (off_t)off);
 
-	/*
-	 * Memory mapped area is good. Now, attempt
-	 * to synchronize the mapped memory region
-	 * with the file.
-	 */
-	if (msync(addr, newsize, MS_SYNC) != 0) {
-		tst_resm(TFAIL | TERRNO, "msync failed to synch "
-			 "mapped file");
-	} else {
-		tst_resm(TPASS, "Functionality of "
-			 "mremap() is correct");
+		if (got != (char)off) {
+			tst_res(TFAIL, "file[%zu] == 0x%02x, expected 0x%02x",
+				off, (unsigned char)got, (unsigned char)off);
+			return 1;
+		}
 	}
 
-	cleanup();
-	tst_exit();
+	return 0;
 }
 
-/*
- * void
- * setup() - performs all ONE TIME setup for this test.
- *
- * Get system page size, Set the size of virtual memory area and the
- * new size after resize,
- * Creat a temporary directory and a file under it.
- * Stratch the file size to the size of virtual memory area and
- * write 1 byte (\0). Map the temporary file for the length of virtual
- * memory (memsize) into memory.
- */
-void setup(void)
+static void run(void)
 {
-	int pagesz;		/* system's page size */
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	/* Get the system page size */
-	if ((pagesz = getpagesize()) < 0) {
-		tst_brkm(TFAIL, NULL,
-			 "getpagesize failed to get system page size");
-	}
+	size_t ind;
 
-	/* Get the size of virtual memory area to be mapped */
-	memsize = (1000 * pagesz);
-
-	/* Get the New size of virtual memory block after resize */
-	newsize = (memsize * 2);
-
-	tst_tmpdir();
+	/*
+	 * Establish a fresh memsize mapping for every iteration so mremap()
+	 * always grows a newly created mapping instead of an already-grown one.
+	 */
+	SAFE_LSEEK(fildes, (off_t)memsize, SEEK_SET);
+	SAFE_WRITE(SAFE_WRITE_ALL, fildes, "\0", 1);
 
-	/* Creat a temporary file used for mapping */
-	if ((fildes = open(TEMPFILE, O_RDWR | O_CREAT, 0666)) < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "opening %s failed",
-			 TEMPFILE);
+	addr = SAFE_MMAP(0, memsize, PROT_READ | PROT_WRITE, MAP_SHARED,
+			 fildes, 0);
 
-	/* Stretch the file to the size of virtual memory area */
-	if (lseek(fildes, (off_t) memsize, SEEK_SET) != (off_t) memsize) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "lseeking to %d offset pos. failed", memsize);
-	}
+	SAFE_LSEEK(fildes, (off_t)newsize, SEEK_SET);
+	SAFE_WRITE(SAFE_WRITE_ALL, fildes, "\0", 1);
 
-	/* Write one byte data into temporary file */
-	if (write(fildes, "\0", 1) != 1) {
-		tst_brkm(TBROK, cleanup, "writing to %s failed", TEMPFILE);
-	}
+	TESTPTR(mremap(addr, memsize, newsize, MREMAP_MAYMOVE));
+	addr = TST_RET_PTR;
+	if (addr == MAP_FAILED)
+		tst_brk(TFAIL | TTERRNO, "mremap failed");
 
-	/*
-	 * Call mmap to map virtual memory (memsize bytes) from the
-	 * beginning of temporary file (offset is 0) into memory.
-	 */
-	addr = mmap(0, memsize, PROT_WRITE, MAP_SHARED, fildes, 0);
+	for (ind = 0; ind < newsize; ind++)
+		addr[ind] = (char)ind;
 
-	/* Check for the return value of mmap() */
-	if (addr == (char *)MAP_FAILED) {
-		tst_brkm(TBROK, cleanup, "mmaping Failed on %s", TEMPFILE);
-	}
+	SAFE_MSYNC(addr, newsize, MS_SYNC);
 
-	/* Stretch the file to newsize of virtual memory block */
-	if (lseek(fildes, (off_t) newsize, SEEK_SET) != (off_t) newsize) {
-		tst_brkm(TBROK, cleanup, "lseek() to %d offset pos. Failed, "
-			 "error=%d : %s", newsize, errno, strerror(errno));
-	}
+	if (verify_file())
+		tst_res(TFAIL, "mremap()'d region did not sync to the file");
+	else
+		tst_res(TPASS, "Functionality of mremap() is correct");
 
-	/* Write one byte data into temporary file */
-	if (write(fildes, "\0", 1) != 1) {
-		tst_brkm(TBROK | TERRNO, cleanup, "writing to %s failed",
-			 TEMPFILE);
-	}
+	SAFE_MUNMAP(addr, newsize);
+	addr = MAP_FAILED;
 }
 
-/*
- * void
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- *	       Unmap the mapped memory area done in the test.
- *	       Close the temporary file.
- *	       Remove the temporary directory.
- */
-void cleanup(void)
+static void cleanup(void)
 {
+	if (addr != MAP_FAILED)
+		SAFE_MUNMAP(addr, newsize);
 
-	/* Unmap the mapped memory */
-	if (munmap(addr, newsize) != 0)
-		tst_brkm(TBROK | TERRNO, NULL, "munmap failed");
-
-	/* Close the temporary file */
-	SAFE_CLOSE(NULL, fildes);
-
-	tst_rmdir();
+	if (fildes != -1)
+		SAFE_CLOSE(fildes);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+	.needs_tmpdir = 1,
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
