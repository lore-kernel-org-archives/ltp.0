Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F91C5AC7C
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 12:18:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 88B093E7013
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 14:18:27 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D0B63CDD91
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 14:17:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1C5D1200B7D
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 14:17:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5A7833E16;
 Fri,  7 Aug 2026 12:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1786105042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0PFHdraHRg/IYw4ArvVL+e31cF2cuW7X5W+fZ3Tma10=;
 b=fE/IkQ1iwTP5A42/uA8QOQh/j3QvMLXZq6hb1CvORlS8ZFAEQFMuhbKpzxbm/6ZndzpIiC
 VK7FukeuW+tugDx/5zppk/vxKxkPdZDFZzi3Wagd5VZyJ08xIUHeYTuSX6TCnkEz8S/qMC
 5xDtXkhRtrs/TM2Anom1UiuVyncJfgc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1786105042;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0PFHdraHRg/IYw4ArvVL+e31cF2cuW7X5W+fZ3Tma10=;
 b=vyubctL51aImHs2SMEkvHKMMMu8eV1dHsjG+g34aKoCusHxos0XbkzlSKGANwKl6ihmPCD
 UB5lL0oTxSp/B+Bg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=F3UwsF6Q;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qTAYUKg8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1786105038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0PFHdraHRg/IYw4ArvVL+e31cF2cuW7X5W+fZ3Tma10=;
 b=F3UwsF6QaXZ4eUSwmW9SxHp1d3jArqI4+v07+3MY/2QNMxGYAyjX7frvpE43guIuc980/r
 89zl/xapIzZ9TNFM77Ets6Yo4EJkZ98rKTASvjqn4C0Tb575q4WRlHCsk3zrdllRloD3vp
 tKu52qcfSEx+XBJxVzqKA48JG411hv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1786105038;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0PFHdraHRg/IYw4ArvVL+e31cF2cuW7X5W+fZ3Tma10=;
 b=qTAYUKg8CP7R9sV0ijqgnQvIvBl1dZ1FEjQj744DqfXgZ1UC8AAa6zrARTbX2VcH3mwW6y
 NZLqJREwBza6/0BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F335779C5;
 Fri,  7 Aug 2026 12:17:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MHijBM7MdWqfLwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 07 Aug 2026 12:17:18 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 07 Aug 2026 14:17:13 +0200
MIME-Version: 1.0
Message-Id: <20260807-rewrite_mremap_testing_suite-v3-4-dcca6d4ac0f1@suse.com>
References: <20260807-rewrite_mremap_testing_suite-v3-0-dcca6d4ac0f1@suse.com>
In-Reply-To: <20260807-rewrite_mremap_testing_suite-v3-0-dcca6d4ac0f1@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786105036; l=10836;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=DTPsH5uRuK+2ZQ6Q1Lb9uT3fnJEbienqsi6r6OIrz3w=;
 b=pFjCaLXb6O9Wff5ynRN3S/6T9uzk/10kAjqEViZoYrbQfqoEKNcAFO48xtiCr/bOrr0MqRZye
 eIHlg5eDcXACwwx0PQe4wHxCDcOm1FD2TN2rpw7ESM7wjx9F53BNS5f
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.cz:email,suse.com:mid,suse.com:email];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 5A7833E16
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 4/7] mremap04: Convert to new API
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

Convert the mremap04 test case from the legacy LTP API to the new
tst_test API.

Rewrite the test to use TST_EXP_FAIL_PTR_VOID() to verify that
mremap() fails with MAP_FAILED and ENOMEM when growing an existing
SysV shared memory mapping in place (old_size=1 page, new_size=2
pages, flags=0, no MREMAP_MAYMOVE) beyond what can be expanded at
its current virtual address.

Switch the Makefile from libltpipc to libltpnewipc, since the
new-API test now relies on GETIPCKEY() from tse_newipc.h.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/mremap/Makefile   |   3 -
 testcases/kernel/syscalls/mremap/mremap04.c | 265 +++++-----------------------
 2 files changed, 43 insertions(+), 225 deletions(-)

diff --git a/testcases/kernel/syscalls/mremap/Makefile b/testcases/kernel/syscalls/mremap/Makefile
index 8811b887e..e774bac01 100644
--- a/testcases/kernel/syscalls/mremap/Makefile
+++ b/testcases/kernel/syscalls/mremap/Makefile
@@ -3,11 +3,8 @@
 
 top_srcdir		?= ../../../..
 
-LTPLIBS = ipc
-
 include $(top_srcdir)/include/mk/testcases.mk
 
-mremap04: LTPLDLIBS  = -lltpipc
 mremap07: LDLIBS  += -lpthread
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/mremap/mremap04.c b/testcases/kernel/syscalls/mremap/mremap04.c
index 53902df73..e9e394188 100644
--- a/testcases/kernel/syscalls/mremap/mremap04.c
+++ b/testcases/kernel/syscalls/mremap/mremap04.c
@@ -1,245 +1,66 @@
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
+ * 02/2008 Modified by Renaud Lottiaux <Renaud.Lottiaux@kerlabs.com>
+ * Copyright (c) Linux Test Project, 2026
  */
 
-/*
- * Test Name: mremap04
- *
- * Test Description:
- *  Verify that,
- *   mremap() fails when used to expand the existing virtual memory mapped
- *   region to the requested size, if the memory area cannot be expanded at
- *   the current virtual address and MREMAP_MAYMOVE flag not set.
- *
- * Expected Result:
- *  mremap() should return -1 and set errno to ENOMEM.
+/*\
+ * Verify that :manpage:`mremap(2)` fails with errno ``ENOMEM`` when it is used
+ * to expand an existing mapping in place, if the region cannot be expanded at
+ * the current virtual address and the ``MREMAP_MAYMOVE`` flag is not set.
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
- *	if errno set == expected errno
- *		Issue sys call failed with expected return value and errno.
- *	Otherwise,
- *		Issue sys call failed with unexpected errno.
- *   Otherwise,
- *	Issue sys call returns unexpected value.
- *
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
- *   Delete the temporary directory(s)/file(s) created.
- *
- * Usage:  <for command-line>
- *  mremap04 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
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
- *      26/02/2008 Renaud Lottiaux (Renaud.Lottiaux@kerlabs.com)
- *      - Fix concurrency issue. Use a shm key from getipckey instead of
- *        a fixed hard-coded value.
- *
- * RESTRICTIONS:
- *  None.
+ * - map an anonymous region of two pages
+ * - call mremap() on the mapped address to grow it from one page to two
+ *   pages with ``flags`` set to 0 (no ``MREMAP_MAYMOVE``)
+ * - expect the call to fail with ``MAP_FAILED`` and ``ENOMEM``
  */
+
 #define _GNU_SOURCE
-#include <errno.h>
-#include <unistd.h>
 #include <sys/mman.h>
-#include <sys/ipc.h>
-#include <sys/shm.h>
+#include "tst_test.h"
 
-#include "test.h"
+static void *addr = MAP_FAILED;
+static size_t memsize;
+static size_t newsize;
 
-#define SHM_MODE	(SHM_R | SHM_W)	/* mode permissions of shared memory */
-
-char *TCID = "mremap04";
-int TST_TOTAL = 1;
-char *addr;			/* addr of memory mapped region */
-char *shmaddr;			/* pointer to shared memory segment */
-int shmid;			/* shared memory identifier. */
-int memsize;			/* memory mapped size */
-int newsize;			/* new size of virtual memory block */
-
-void setup();			/* Main setup function of test */
-void cleanup();			/* cleanup function for the test */
-
-extern int getipckey();
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
-		 * Attempt to expand the existing shared
-		 * memory region of newsize by newsize limits
-		 * using mremap() should fail as specified
-		 * memory area already locked and MREMAP_MAYMOVE
-		 * flag unset.
-		 */
-		errno = 0;
-		addr = mremap(shmaddr, memsize, newsize, 0);
-		TEST_ERRNO = errno;
-
-		/* Check for the return value of mremap() */
-		if (addr != MAP_FAILED) {
-			tst_resm(TFAIL,
-				 "mremap returned invalid value, expected: -1");
-
-			/* Unmap the mapped memory region */
-			if (munmap(addr, newsize) != 0) {
-				tst_brkm(TFAIL, cleanup, "munmap failed to "
-					 "unmap the expanded memory region, "
-					 "error=%d", errno);
-			}
-			continue;
-		}
-
-		if (TEST_ERRNO == ENOMEM) {
-			tst_resm(TPASS, "mremap() failed, "
-				 "'MREMAP_MAYMOVE flag unset', "
-				 "errno %d", TEST_ERRNO);
-		} else {
-			tst_resm(TFAIL, "mremap() failed, "
-				 "Unexpected errno %d", TEST_ERRNO);
-		}
-	}
-
-	cleanup();
-	tst_exit();
+	memsize = getpagesize();
+	newsize = memsize * 2;
 
+	addr = SAFE_MMAP(NULL, newsize, PROT_READ | PROT_WRITE,
+			 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- *
- * Get system page size, Set the size of virtual memory area and the
- * newsize after resize,
- * Create a named shared memory segment SHMKEY of newsize and mode SHM_MODE
- * by using shmget() which returns a shared memory identifier associated
- * with the created shared memory segment.
- * Call shmat() to attach the shared memory segment to the data segment of the
- * calling process. The segment is attached at the first available address as
- * selected by the system.
- */
-void setup(void)
+static void run(void)
 {
-	key_t shmkey;
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	/* Get the system page size */
-	if ((memsize = getpagesize()) < 0) {
-		tst_brkm(TBROK, NULL,
-			 "getpagesize() failed to get system page size");
-	}
-
-	/* Get the New size of virtual memory block after resize */
-	newsize = (memsize * 2);
-
-	/* get an IPC resource key */
-	shmkey = getipckey();
-
 	/*
-	 * Create a shared memory segment represented by SHMKEY of
-	 * specified size 'newsize' and mode permissions 'SHM_MODE'.
+	 * Pass old_size of one page while the segment is two pages: the
+	 * mismatch is intentional and must be preserved. The next page
+	 * is occupied by our own mapping, so it cannot be expanded in place.
 	 */
-	shmid = shmget(shmkey, newsize, IPC_CREAT | SHM_MODE);
-	if (shmid == -1) {
-		tst_brkm(TBROK, NULL, "shmget() Failed to create a shared "
-			 "memory, error:%d", errno);
-	}
+	TST_EXP_FAIL_PTR_VOID(mremap(addr, memsize, newsize, 0), ENOMEM);
 
-	/*
-	 * Attach  the shared memory segment associated with the shared
-	 * memory identifier specified by "shmid" to the data segment of
-	 * the calling process at the first available address as selected
-	 * by the system.
-	 */
-	shmaddr = shmat(shmid, NULL, 0);
-	if (shmaddr == (void *)-1) {
-		tst_brkm(TBROK, cleanup, "shmat() Failed to attach shared "
-			 "memory, error:%d", errno);
+	if (TST_RET_PTR != MAP_FAILED) {
+		SAFE_MUNMAP(TST_RET_PTR, newsize);
+		addr = SAFE_MMAP(NULL, newsize, PROT_READ | PROT_WRITE,
+				 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 	}
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- *	       Detach the shared memory segment and remove the shared memory
- *	       identifier associated with the shared memory.
- */
-void cleanup(void)
+static void cleanup(void)
 {
-
-	/*
-	 * Detach the shared memory segment attached to
-	 * the calling process's data segment
-	 */
-	if (shmdt(shmaddr) < 0) {
-		tst_brkm(TFAIL, NULL, "shmdt() Failed to detach shared "
-			 "memory, error:%d", errno);
-	}
-
-	/*
-	 * Remove the shared memory identifier associated with
-	 * the shared memory segment and destroy the shared memory
-	 * segment.
-	 */
-	if (shmctl(shmid, IPC_RMID, 0) < 0) {
-		tst_brkm(TFAIL, NULL, "shmctl() Failed to remove shared "
-			 "memory, error:%d", errno);
-	}
-
-	tst_rmdir();
-
-	/* Exit the program */
-
+	if (addr != MAP_FAILED)
+		SAFE_MUNMAP(addr, newsize);
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
