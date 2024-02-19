Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41818C48BF8
	for <ltp@archiver.kernel.org>; Mon, 19 Feb 2024 15:30:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9CBFE3D1386
	for <ltp@archiver.kernel.org>; Mon, 19 Feb 2024 16:30:30 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D326B3D0476
 for <ltp@lists.linux.it>; Mon, 19 Feb 2024 16:30:15 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 974CB1000A2A
 for <ltp@lists.linux.it>; Mon, 19 Feb 2024 16:30:14 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 71C8C21E9E
 for <ltp@lists.linux.it>; Mon, 19 Feb 2024 15:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708356613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZGb59DJttwZLK+ggDfSzyVVUDbJGaed7D/3yi9Cg0Ik=;
 b=pB1DtmvkS2d0ZvhCp+4meHOpOdflYQqqWHjFiH8p3fUzlYQ23O+RHIGzNTAOs/cnV/isGJ
 0nepDNdwIVhebKsVadjutWlhqJyBbJyTBwNKf7oL32RukSfqcQs3puvMqLvEmx54iMWuj2
 2vfAd1tanz8G1w6KEDffOvELtQ+GhIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708356613;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZGb59DJttwZLK+ggDfSzyVVUDbJGaed7D/3yi9Cg0Ik=;
 b=sgiON91pJfufHPWo3pPOJzdd5QqTaL9nmykD1jXZYLtE3RiX0jFJAl03XT0o4kN8jA07MF
 LdVJKms8xg/Gg1AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708356613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZGb59DJttwZLK+ggDfSzyVVUDbJGaed7D/3yi9Cg0Ik=;
 b=pB1DtmvkS2d0ZvhCp+4meHOpOdflYQqqWHjFiH8p3fUzlYQ23O+RHIGzNTAOs/cnV/isGJ
 0nepDNdwIVhebKsVadjutWlhqJyBbJyTBwNKf7oL32RukSfqcQs3puvMqLvEmx54iMWuj2
 2vfAd1tanz8G1w6KEDffOvELtQ+GhIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708356613;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZGb59DJttwZLK+ggDfSzyVVUDbJGaed7D/3yi9Cg0Ik=;
 b=sgiON91pJfufHPWo3pPOJzdd5QqTaL9nmykD1jXZYLtE3RiX0jFJAl03XT0o4kN8jA07MF
 LdVJKms8xg/Gg1AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5DE1A13647
 for <ltp@lists.linux.it>; Mon, 19 Feb 2024 15:30:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lEsLFgV002VbcQAAD6G6ig
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Mon, 19 Feb 2024 15:30:13 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Mon, 19 Feb 2024 16:30:09 +0100
Message-ID: <20240219153012.3085-1-akumar@suse.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pB1Dtmvk;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sgiON91p
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_ONE(0.00)[1];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 TO_DN_NONE(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 71C8C21E9E
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] msync01: Rewrite using new LTP API
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

Also old test was broken for -i0

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/msync/msync01.c | 216 ++++------------------
 1 file changed, 40 insertions(+), 176 deletions(-)

diff --git a/testcases/kernel/syscalls/msync/msync01.c b/testcases/kernel/syscalls/msync/msync01.c
index 3c57ebb99..0d00438b4 100644
--- a/testcases/kernel/syscalls/msync/msync01.c
+++ b/testcases/kernel/syscalls/msync/msync01.c
@@ -1,201 +1,65 @@
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
+ * Copyright (c) 2024 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
 
-/*
- * Test Name: msync01
- *
- * Test Description:
- *  Verify that, msync() succeeds, when the region to synchronize, is part
- *  of, or all of a mapped region.
- *
- * Expected Result:
- *  msync() should succeed with a return value of 0, and successfully
- *  synchronize the memory region.  Data read from mapped region should be
- *  the same as the initialized data.
- *
- * Algorithm:
- *  Setup:
- *   Setup signal handling.
- *   Create temporary directory.
- *   Pause for SIGUSR1 if option specified.
+/*\
+ * [Description]
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
- *  msync01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
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
- *  None.
+ * Verify that, msync() successfully flushes the changes back to the
+ * filesystem for a file-backed mapping.
  */
-#include <errno.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <sys/mman.h>
 
-#include "test.h"
+#include "tst_test.h"
 
-#define TEMPFILE	"msync_file"
+#define TEMPFILE	"tempfile"
 #define BUF_SIZE	256
 
-char *TCID = "msync01";
-int TST_TOTAL = 1;
-
-char *addr;			/* addr of memory mapped region */
-size_t page_sz;			/* system page size */
-int fildes;			/* file descriptor for tempfile */
-char write_buf[BUF_SIZE];	/* buffer to hold data to be written */
+static char *addr;
+static size_t page_sz;
+static int fd;
+static const char write_buf[] = "Hello World!";
 
-void setup();			/* Main setup function of test */
-void cleanup();			/* cleanup function for the test */
-
-int main(int ac, char **av)
+static void run(void)
 {
-	int lc;
-	char read_buf[BUF_SIZE];	/* buffer to hold data read from file */
-	int nread = 0, count, err_flg = 0;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
+	char read_buf[BUF_SIZE];
 
-		setup();
+	addr = SAFE_MMAP(NULL, page_sz, PROT_WRITE, MAP_FILE | MAP_SHARED, fd, 0);
+	strcpy(addr + 100, write_buf);
 
-		TEST(msync(addr, page_sz, MS_ASYNC));
+	TST_EXP_PASS(msync(addr, page_sz, MS_SYNC));
 
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TTERRNO, "msync failed");
-			continue;
-		}
+	SAFE_LSEEK(fd, (off_t)100, SEEK_SET);
+	SAFE_READ(1, fd, read_buf, sizeof(write_buf));
 
-		if (lseek(fildes, (off_t) 100, SEEK_SET) != 100)
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "lseek failed");
+	if (memcmp(write_buf, read_buf, sizeof(write_buf)) != 0)
+		tst_res(TFAIL, "msync() failed");
+	else
+		tst_res(TPASS, "msync() successful");
 
-		/*
-		 * Seeking to specified offset. successful.
-		 * Now, read the data (256 bytes) and compare
-		 * them with the expected.
-		 */
-		nread = read(fildes, read_buf, sizeof(read_buf));
-		if (nread != BUF_SIZE)
-			tst_brkm(TBROK, cleanup, "read failed");
-		else {
-			/*
-			 * Check whether read data (from mapped
-			 * file) contains the expected data
-			 * which was initialised in the setup.
-			 */
-			for (count = 0; count < nread; count++)
-				if (read_buf[count] != 1)
-					err_flg++;
-		}
-
-		if (err_flg != 0)
-			tst_resm(TFAIL,
-				 "data read from file doesn't match");
-		else
-			tst_resm(TPASS,
-				 "Functionality of msync() successful");
-
-		cleanup();
-
-	}
-	tst_exit();
+	SAFE_MUNMAP(addr, page_sz);
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- *
- * Get system page size,
- * Creat a temporary directory and a file under it used for mapping.
- * Write 1 page size char data into file.
- * Initialize paged region (256 bytes) from the specified offset pos.
- */
-void setup(void)
+static void setup(void)
 {
-	size_t c_total = 0, nwrite = 0;	/* no. of bytes to be written */
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	page_sz = SAFE_SYSCONF(_SC_PAGESIZE);
 
-	page_sz = (size_t)getpagesize();
+	fd = SAFE_OPEN(TEMPFILE, O_RDWR | O_CREAT, 0666);
 
-	tst_tmpdir();
-
-	if ((fildes = open(TEMPFILE, O_RDWR | O_CREAT, 0666)) < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "open failed");
-
-	while (c_total < page_sz) {
-		nwrite = write(fildes, write_buf, sizeof(write_buf));
-		if (nwrite <= 0)
-			tst_brkm(TBROK | TERRNO, cleanup, "write failed");
-		else
-			c_total += nwrite;
-	}
-
-	/*
-	 * Call mmap to map virtual memory (mul. of page size bytes) from the
-	 * beginning of temporary file (offset is 0) into memory.
-	 */
-	addr = mmap(0, page_sz, PROT_READ | PROT_WRITE, MAP_FILE | MAP_SHARED,
-		    fildes, 0);
-
-	/* Check for the return value of mmap() */
-	if (addr == MAP_FAILED)
-		tst_brkm(TBROK | TERRNO, cleanup, "mmap failed");
-
-	/* Set 256 bytes, at 100 byte offset in the mapped region */
-	memset(addr + 100, 1, 256);
+	SAFE_LSEEK(fd, page_sz, SEEK_SET);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, "a", 1);
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
-	if (munmap(addr, page_sz) == -1)
-		tst_resm(TBROK | TERRNO, "munmap failed");
-
-	if (close(fildes) == -1)
-		tst_resm(TWARN | TERRNO, "close failed");
-
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
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
