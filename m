Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E41C9C4452F
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 12:41:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 373833E1C66
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 14:41:54 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DECFB3E6202
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 14:41:16 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6B7281400998
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 14:41:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 648B83E09;
 Tue, 21 Jul 2026 12:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784637663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5wlXKHE/9uWNuKOGW+wszI9Zpkz0zorJ+kKE5fpiotQ=;
 b=PNSvwAcXkzSv9HwWZO1NIUGzTXhH+PwmvIni+WtlbUeKM7T0eUJTVJLP9odt+ST2AQ7O6B
 gK//W9VRw2peq68XODopAaFuUz2RoRD1IzGnLT3PZ0kho37NIN71QvEekR9YBfEsPf373k
 XG0BOQfd0oPM9lCwOOyrnkJDR5yu4Hg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784637663;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5wlXKHE/9uWNuKOGW+wszI9Zpkz0zorJ+kKE5fpiotQ=;
 b=5Eb3gpKWdVGXJyIGw7kwx3rIzZxFFoIxzbDTvl7/0Iy6mcm4UedNSgQqpKKHzE8WayDx3l
 +VNF8XGDbDFH8pAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PNSvwAcX;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5Eb3gpKW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784637663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5wlXKHE/9uWNuKOGW+wszI9Zpkz0zorJ+kKE5fpiotQ=;
 b=PNSvwAcXkzSv9HwWZO1NIUGzTXhH+PwmvIni+WtlbUeKM7T0eUJTVJLP9odt+ST2AQ7O6B
 gK//W9VRw2peq68XODopAaFuUz2RoRD1IzGnLT3PZ0kho37NIN71QvEekR9YBfEsPf373k
 XG0BOQfd0oPM9lCwOOyrnkJDR5yu4Hg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784637663;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5wlXKHE/9uWNuKOGW+wszI9Zpkz0zorJ+kKE5fpiotQ=;
 b=5Eb3gpKWdVGXJyIGw7kwx3rIzZxFFoIxzbDTvl7/0Iy6mcm4UedNSgQqpKKHzE8WayDx3l
 +VNF8XGDbDFH8pAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DC48779AA;
 Tue, 21 Jul 2026 12:41:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8PpYDN9oX2plWgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 21 Jul 2026 12:41:03 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 21 Jul 2026 14:41:02 +0200
MIME-Version: 1.0
Message-Id: <20260721-rewrite_mremap_testing_suite-v1-2-ec2c3cff6ea4@suse.com>
References: <20260721-rewrite_mremap_testing_suite-v1-0-ec2c3cff6ea4@suse.com>
In-Reply-To: <20260721-rewrite_mremap_testing_suite-v1-0-ec2c3cff6ea4@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784637662; l=7609;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=7/pjqmTtkdvpX+QFtOQsZ8v2XNe6ilIEn5KDm2oQp3g=;
 b=4sChwt0TbROxVegzY76MSNqowjllwQqdSZAf1rfKstFwEYyF1UKNonFiUSe0/pPlnVM3LVr7t
 6ygGfEpZVgdAYaZGxpD7jAwlJuSAbX+cBvUqb5U3iZhTTS15ioLSIiH
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 648B83E09
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/5] mremap02: Convert to new API
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

Convert the mremap02 test case from the legacy LTP API to the new
tst_test API.

Rewrite the test to explicitly construct a genuinely non-page-aligned
old_address by mapping a single anonymous page and offsetting it by one
byte, replacing the original's reliance on an uninitialized global
pointer. Use TST_EXP_FAIL_PTR_VOID() to verify that mremap() fails with
MAP_FAILED and EINVAL when expanding the mapping.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/mremap/mremap02.c | 197 ++++++----------------------
 1 file changed, 40 insertions(+), 157 deletions(-)

diff --git a/testcases/kernel/syscalls/mremap/mremap02.c b/testcases/kernel/syscalls/mremap/mremap02.c
index 2dabc68472a2686a83b7ab7bb2fdd92611a6e8de..7fe699285325748ac3ed985585a2fd7afc348fba 100644
--- a/testcases/kernel/syscalls/mremap/mremap02.c
+++ b/testcases/kernel/syscalls/mremap/mremap02.c
@@ -1,178 +1,61 @@
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
+ * 11/2001 Modified by Manoj Iyer <manjo@austin.ibm.com>
+ * Copyright (c) Linux Test Project, 2026
  */
 
-/*
- * Test Name: mremap02
- *
- * Test Description:
- *  Verify that,
- *   mremap() fails when used to expand the existing virtual memory mapped
- *   region to the requested size, if the virtual memory area previously
- *   mapped was not page aligned or invalid argument specified.
- *
- * Expected Result:
- *  mremap() should return -1 and set errno to EINVAL.
- *
- * Algorithm:
- *  Setup:
- *   Setup signal handling.
- *   Pause for SIGUSR1 if option specified.
- *
- *  Test:
- *   Loop if the proper options are given.
- *   Execute system call
- *   Check return code, if system call failed (return=-1)
- *	if errno set == expected errno
- *		Issue sys call fails with expected return value and errno.
- *	Otherwise,
- *		Issue sys call fails with unexpected errno.
- *   Otherwise,
- *	Issue sys call returns unexpected value.
+/*\
+ * Verify that :manpage:`mremap(2)` fails with errno ``EINVAL`` when it is used
+ * to expand an existing mapping while the passed ``old_address`` is not page
+ * aligned.
  *
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
+ * [Algorithm]
  *
- * Usage:  <for command-line>
- *  mremap02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *	       -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -p x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- *      11/09/2001 Manoj Iyer (manjo@austin.ibm.com)
- *      Modified.
- *      - #include <linux/mman.h> should not be included as per man page for
- *        mremap, #include <sys/mman.h> alone should do the job. But inorder
- *        to include definition of MREMAP_MAYMOVE defined in bits/mman.h
- *        (included by sys/mman.h) __USE_GNU needs to be defined.
- *        There may be a more elegant way of doing this...
- *
- *
- * RESTRICTIONS:
- *  None.
+ * - Map a single anonymous page.
+ * - Call mremap() to grow it to two pages with ``MREMAP_MAYMOVE``, passing a
+ *   deliberately misaligned ``old_address`` (mapping start + 1 byte).
+ * - Expect the call to fail with ``MAP_FAILED`` and ``EINVAL``.
  */
+
 #define _GNU_SOURCE
-#include <errno.h>
-#include <unistd.h>
-#include <fcntl.h>
 #include <sys/mman.h>
+#include "tst_test.h"
 
-#include "test.h"
+static long page_size;
+static size_t new_size;
+static void *page;
+static void *bad_addr;
 
-char *TCID = "mremap02";
-int TST_TOTAL = 1;
-char *addr;			/* addr of memory mapped region */
-int memsize;			/* memory mapped size */
-int newsize;			/* new size of virtual memory block */
-
-void setup();			/* Main setup function of test */
-void cleanup();			/* cleanup function for the test */
-
-int main(int ac, char **av)
+static void setup(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
+	page_size = getpagesize();
+	new_size = page_size * 2;
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		/*
-		 * Attempt to expand the existing mapped
-		 * memory region (memsize) by newsize limits using
-		 * mremap() should fail as old virtual address is not
-		 * page aligned.
-		 */
-		errno = 0;
-		addr = mremap(addr, memsize, newsize, MREMAP_MAYMOVE);
-		TEST_ERRNO = errno;
-
-		/* Check for the return value of mremap() */
-		if (addr != MAP_FAILED) {
-			tst_resm(TFAIL,
-				 "mremap returned invalid value, expected: -1");
-
-			/* Unmap the mapped memory region */
-			if (munmap(addr, newsize) != 0) {
-				tst_brkm(TBROK, cleanup, "munmap fails to "
-					 "unmap the expanded memory region, "
-					 "error=%d", errno);
-			}
-			continue;
-		}
-
-		if (errno == EINVAL) {
-			tst_resm(TPASS, "mremap() Failed, 'invalid argument "
-				 "specified' - errno %d", TEST_ERRNO);
-		} else {
-			tst_resm(TFAIL, "mremap() Failed, "
-				 "'Unexpected errno %d", TEST_ERRNO);
-		}
-	}
-
-	cleanup();
-	tst_exit();
+	page = SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE,
+			 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 
+	/* Force a non-page-aligned old_address, the invalid argument. */
+	bad_addr = (char *)page + 1;
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- *
- * Get system page size, Set the size of virtual memory area and the
- * new size after resize, Set the virtual memory address such that it
- * is not aligned.
- */
-void setup(void)
+static void run(void)
 {
+	TST_EXP_FAIL_PTR_VOID(mremap(bad_addr, page_size, new_size,
+				     MREMAP_MAYMOVE), EINVAL);
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	/* Get the system page size */
-	if ((memsize = getpagesize()) < 0) {
-		tst_brkm(TFAIL, NULL,
-			 "getpagesize() fails to get system page size");
-	}
-
-	/* Get the New size of virtual memory block after resize */
-	newsize = (memsize * 2);
-
-	/* Set the old virtual memory address */
-	addr = (char *)(addr + (memsize - 1));
+	if (TST_RET_PTR != MAP_FAILED)
+		SAFE_MUNMAP(TST_RET_PTR, new_size);
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- */
-void cleanup(void)
+static void cleanup(void)
 {
-
-	/* Exit the program */
-
+	SAFE_MUNMAP(page, page_size);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
