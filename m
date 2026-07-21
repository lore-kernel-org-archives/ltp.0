Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC22C4451C
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 12:42:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B7FE13C5E50
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 14:42:28 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 304383E2136
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 14:41:28 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 66E46200919
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 14:41:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D58883E1F;
 Tue, 21 Jul 2026 12:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784637664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TY/XmspsO9Zv/cwJyhse05KlkpAhnraPvqVXXwYpZPI=;
 b=U/i3sGhaMITiR4N2I3gqi4YUQZKuxSANguAx7+sXbnSUHsBpyaDWsfMfNzasxDyG22bngz
 DeS0cbJgFIW8Ru7QoaNq4AyjqtxWZwanR2hUquA5wIx6xvyj9NX8x7YnueJ4cRi6Ydx4zG
 zDuW6Pwqvzuojv6qvsluvjpl1JscTW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784637664;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TY/XmspsO9Zv/cwJyhse05KlkpAhnraPvqVXXwYpZPI=;
 b=pcEylgrAu9MAqANb3LRqn3I15ZSbXEkUCu78Z0A5bHKf40A/mvALnKHcukotCLl9hwokzs
 7UMj/TO3hEKnavCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hfqovHvc;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xo4iE8RM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784637663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TY/XmspsO9Zv/cwJyhse05KlkpAhnraPvqVXXwYpZPI=;
 b=hfqovHvcDBz35FOGs63yb/Gt8q+xfNzyzPgJoGOprrupe7ZYQv/YUQYAN13/Qav3weCgyf
 F9VW3rRlPUB/werjs6PhoZiPb5sSRbIcZme6gzsvzP0lNPcz7Pap0lN2S+uqf6jem1fkdz
 muuKKWl+HtwkRf8Kiy0RZSOXS93q/ig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784637663;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TY/XmspsO9Zv/cwJyhse05KlkpAhnraPvqVXXwYpZPI=;
 b=xo4iE8RM2mB1Z9W0rWJiADKpx1HBnyJJhcSqGFuSinefRlt3wJGqaNst3qYffoamLOpvz/
 urtfeL8gLlLMpgCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF80A779AA;
 Tue, 21 Jul 2026 12:41:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aMQeKN9oX2plWgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 21 Jul 2026 12:41:03 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 21 Jul 2026 14:41:04 +0200
MIME-Version: 1.0
Message-Id: <20260721-rewrite_mremap_testing_suite-v1-4-ec2c3cff6ea4@suse.com>
References: <20260721-rewrite_mremap_testing_suite-v1-0-ec2c3cff6ea4@suse.com>
In-Reply-To: <20260721-rewrite_mremap_testing_suite-v1-0-ec2c3cff6ea4@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784637662; l=11023;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=AGuLOL5WhJdJM9Cal7sSO6s8SZCbGIXJNK5dmkbd+dA=;
 b=Idbg27PUQF9CCotMIF35r1S9h9ti8RVqvQRH+gBv0aKAL5qQb6hwcmbPXN6GyVNTRCPb91RLe
 OYXfy6yXOxOBptOZLj9YJJCmBnZJYNinFoxUcniGo3rfnBu4gXCLiAz
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D58883E1F
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/5] mremap04: Convert to new API
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/mremap/Makefile   |   4 +-
 testcases/kernel/syscalls/mremap/mremap04.c | 268 +++++-----------------------
 2 files changed, 51 insertions(+), 221 deletions(-)

diff --git a/testcases/kernel/syscalls/mremap/Makefile b/testcases/kernel/syscalls/mremap/Makefile
index 8811b887e34ff4aa8e372548e10006621cb3ad07..4c8990ea8257f7b96334c312a906ba6cb3814501 100644
--- a/testcases/kernel/syscalls/mremap/Makefile
+++ b/testcases/kernel/syscalls/mremap/Makefile
@@ -3,11 +3,11 @@
 
 top_srcdir		?= ../../../..
 
-LTPLIBS = ipc
+LTPLIBS = newipc
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-mremap04: LTPLDLIBS  = -lltpipc
+mremap04: LTPLDLIBS  = -lltpnewipc
 mremap07: LDLIBS  += -lpthread
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/mremap/mremap04.c b/testcases/kernel/syscalls/mremap/mremap04.c
index 53902df73f0ed177acfa064e7e15c1f9f321c9d2..fd8b8255b7de574db22a9d228d15c9637ba7efc4 100644
--- a/testcases/kernel/syscalls/mremap/mremap04.c
+++ b/testcases/kernel/syscalls/mremap/mremap04.c
@@ -1,245 +1,75 @@
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
- *
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
+/*\
+ * Verify that :manpage:`mremap(2)` fails with errno ``ENOMEM`` when it is used
+ * to expand an existing mapping in place, if the region cannot be expanded at
+ * the current virtual address and the ``MREMAP_MAYMOVE`` flag is not set.
  *
- *      26/02/2008 Renaud Lottiaux (Renaud.Lottiaux@kerlabs.com)
- *      - Fix concurrency issue. Use a shm key from getipckey instead of
- *        a fixed hard-coded value.
+ * [Algorithm]
  *
- * RESTRICTIONS:
- *  None.
+ * - create a SysV shared memory segment of two pages and attach it with
+ *   :manpage:`shmat(2)`
+ * - call mremap() on the attached address to grow it from one page to two
+ *   pages with ``flags`` set to 0 (no ``MREMAP_MAYMOVE``)
+ * - expect the call to fail with ``MAP_FAILED`` and ``ENOMEM``
  */
+
 #define _GNU_SOURCE
-#include <errno.h>
-#include <unistd.h>
 #include <sys/mman.h>
 #include <sys/ipc.h>
 #include <sys/shm.h>
+#include "tst_test.h"
+#include "tse_newipc.h"
+#include "tst_safe_sysv_ipc.h"
 
-#include "test.h"
-
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
+static char *shmaddr;
+static int shmid = -1;
+static size_t memsize;
+static size_t newsize;
 
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
+	key_t shmkey;
 
-	cleanup();
-	tst_exit();
+	memsize = getpagesize();
+	newsize = memsize * 2;
 
+	shmkey = GETIPCKEY();
+	shmid = SAFE_SHMGET(shmkey, newsize, IPC_CREAT | SHM_RW);
+	shmaddr = SAFE_SHMAT(shmid, NULL, 0);
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
+	 * mismatch is intentional and must be preserved.
 	 */
-	shmid = shmget(shmkey, newsize, IPC_CREAT | SHM_MODE);
-	if (shmid == -1) {
-		tst_brkm(TBROK, NULL, "shmget() Failed to create a shared "
-			 "memory, error:%d", errno);
-	}
+	TST_EXP_FAIL_PTR_VOID(mremap(shmaddr, memsize, newsize, 0), ENOMEM);
 
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
-	}
+	if (TST_RET_PTR != MAP_FAILED)
+		SAFE_MUNMAP(TST_RET_PTR, newsize);
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
+	if (shmaddr)
+		SAFE_SHMDT(shmaddr);
 
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
+	if (shmid != -1)
+		SAFE_SHMCTL(shmid, IPC_RMID, NULL);
 }
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
