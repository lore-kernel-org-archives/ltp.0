Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E016C5AC7A
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 12:18:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9CA063E7023
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 14:18:12 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 409523E7005
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 14:17:28 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7FA5A1A00FFD
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 14:17:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 114A23E11;
 Fri,  7 Aug 2026 12:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1786105042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bQ0byeY1Q5i6JqPQbfKBuAFy5mEQkEHHgsmXog1ZoOc=;
 b=SDt15W22YvoHt+uH/3O1AGauiNDazAdPzU5RM/OnFIc3DQroAWDPpSGO2CXV7uVtvGXP1M
 qgoNhESdKmcx71WSTVKz9WZx6z1DWYqxe4kVQcn8wsIcWfPSQzbiwIWaVZ2LqfRAdsZNrc
 1//acJvZ1Zucm1LQ8fTVWtfrT157WC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1786105042;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bQ0byeY1Q5i6JqPQbfKBuAFy5mEQkEHHgsmXog1ZoOc=;
 b=Vpso9cZD06/RIVMnDsxl00xqpmYLupmJDH8uGIwUm5Xeqp3wEH6qrQz6KV8O1AXLLUHu/B
 1chi1o9hVSgh3mBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1786105038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bQ0byeY1Q5i6JqPQbfKBuAFy5mEQkEHHgsmXog1ZoOc=;
 b=pmSswxeIcPJ2x4dTQWABtsT9pLww9PDPpSqoaSPg9dFH3p3q+qZ0lcbpdpNf0WlCT0eA54
 9PV5QuLN1WZD4L5BJAqoRnJh5UJR2Tc4Kp6q9Nfn5gsy9U+GT5WXC+VnDu730YqMJfSB/d
 Sb+Dev3kNK6NNn+k+CRfvJRNwNsU/Xs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1786105038;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bQ0byeY1Q5i6JqPQbfKBuAFy5mEQkEHHgsmXog1ZoOc=;
 b=TQ134+ZHwZa8SAv8D+hzUOY1+I/G5m2sGJbyFZMgfhFeioZZEfR1yks84Are5nfaqX8hm/
 8v2gzCBNWr9XbBDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4D6B779C3;
 Fri,  7 Aug 2026 12:17:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cJgVLc3MdWqfLwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 07 Aug 2026 12:17:17 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 07 Aug 2026 14:17:12 +0200
MIME-Version: 1.0
Message-Id: <20260807-rewrite_mremap_testing_suite-v3-3-dcca6d4ac0f1@suse.com>
References: <20260807-rewrite_mremap_testing_suite-v3-0-dcca6d4ac0f1@suse.com>
In-Reply-To: <20260807-rewrite_mremap_testing_suite-v3-0-dcca6d4ac0f1@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786105036; l=7456;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=+lvG+FrZ7kloFND856DHQaumQfppf3a1/30FSGE5EKw=;
 b=ajWZC7wGt/r/TpaRWXBHAeh4j+38GGA8iZxf+acKcl4UtdBRjRaEBSvUxQeE/UsHqASnOl6g9
 m+FIzmRxs3sC5w4w6YAImwXtCOSNsLXyt/IL42HimbTEWZugEzL8D1K
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, imap1.dmz-prg2.suse.org:helo,
 suse.com:email, suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/7] mremap03: Convert to new API
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

Convert the mremap03 test case from the legacy LTP API to the new
tst_test API.

Rewrite the test to use TST_EXP_FAIL_PTR_VOID() to verify that
mremap() fails with MAP_FAILED and EFAULT when growing a mapping
whose old_address refers to an unmapped region obtained via
tst_get_bad_addr().

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/mremap/mremap03.c | 203 +++++-----------------------
 1 file changed, 34 insertions(+), 169 deletions(-)

diff --git a/testcases/kernel/syscalls/mremap/mremap03.c b/testcases/kernel/syscalls/mremap/mremap03.c
index 02b79bc47..6003657d4 100644
--- a/testcases/kernel/syscalls/mremap/mremap03.c
+++ b/testcases/kernel/syscalls/mremap/mremap03.c
@@ -1,187 +1,52 @@
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
- * Test Name: mremap03
- *
- * Test Description:
- *  Verify that,
- *   mremap() fails when used to expand the existing virtual memory mapped
- *   region to the requested size, if there already exists mappings that
- *   cover the whole address space requsted or the old address specified was
- *   not mapped.
- *
- * Expected Result:
- *  mremap() should return -1 and set errno to EFAULT.
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
- *
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
+/*\
+ * Verify that :manpage:`mremap(2)` fails with errno ``EFAULT`` when it is used
+ * to expand a mapping whose ``old_address`` refers to a region that is not
+ * mapped.
  *
- * Usage:  <for command-line>
- *  mremap03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -p x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
+ * [Algorithm]
  *
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
+ * - Obtain an unmapped address via ``tst_get_bad_addr()``.
+ * - Call mremap() to grow it to twice its size with ``MREMAP_MAYMOVE``,
+ *   passing the unmapped ``old_address``.
+ * - Expect the call to fail with ``MAP_FAILED`` and ``EFAULT``.
  */
+
 #define _GNU_SOURCE
-#include <errno.h>
-#include <unistd.h>
-#include <fcntl.h>
 #include <sys/mman.h>
+#include "tst_test.h"
 
-#include "test.h"
-
-char *TCID = "mremap03";
-int TST_TOTAL = 1;
-static char *bad_addr;
-static char *addr;		/* addr of memory mapped region */
-int memsize;			/* memory mapped size */
-int newsize;			/* new size of virtual memory block */
+static long page_size;
+static size_t memsize;
+static size_t newsize;
+static void *bad_addr;
 
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
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		/*
-		 * Attempt to expand the existing mapped
-		 * memory region (memsize) by newsize limits
-		 * using mremap() should fail as specified old
-		 * virtual address was not mapped.
-		 */
-		errno = 0;
-		addr = mremap(bad_addr, memsize, newsize, MREMAP_MAYMOVE);
-		TEST_ERRNO = errno;
-
-		/* Check for the return value of mremap() */
-		if (addr != MAP_FAILED) {
-			tst_resm(TFAIL,
-				 "mremap returned invalid value, expected: -1");
-
-			/* Unmap the mapped memory region */
-			if (munmap(addr, newsize) != 0) {
-				tst_brkm(TFAIL, cleanup, "munmap fails to "
-					 "unmap the expanded memory region, "
-					 " error=%d", errno);
-			}
-			continue;
-		}
-
-		/* Check for the expected errno */
-		if (errno == EFAULT) {
-			tst_resm(TPASS, "mremap() Fails, 'old region not "
-				 "mapped', errno %d", TEST_ERRNO);
-		} else {
-			tst_resm(TFAIL, "mremap() Fails, "
-				 "'Unexpected errno %d", TEST_ERRNO);
-		}
-	}
-
-	cleanup();
-	tst_exit();
+	page_size = getpagesize();
+	memsize = 1000 * page_size;
+	newsize = 2 * memsize;
 
+	bad_addr = tst_get_bad_addr(NULL);
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- *
- * Get system page size.
- * Set the old address point some high address which is not mapped.
- */
-void setup(void)
+static void run(void)
 {
-	int page_sz;		/* system page size */
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	TST_EXP_FAIL_PTR_VOID(mremap(bad_addr, memsize, newsize,
+				     MREMAP_MAYMOVE), EFAULT);
 
-	/* Get the system page size */
-	if ((page_sz = getpagesize()) < 0) {
-		tst_brkm(TFAIL, NULL,
-			 "getpagesize() fails to get system page size");
-	}
-
-	/* Get the size of virtual memory area to be mapped */
-	memsize = (1000 * page_sz);
-
-	/* Get the New size of virtual memory block after resize */
-	newsize = (memsize * 2);
-
-	/*
-	 * Set the old virtual address point to some address
-	 * which is not mapped.
-	 */
-	bad_addr = tst_get_bad_addr(cleanup);
+	if (TST_RET_PTR != MAP_FAILED)
+		SAFE_MUNMAP(TST_RET_PTR, newsize);
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- */
-void cleanup(void)
-{
-
-	/* Exit the program */
-
-}
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
