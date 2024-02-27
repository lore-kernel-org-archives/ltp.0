Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE706C5478C
	for <ltp@archiver.kernel.org>; Tue, 27 Feb 2024 08:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1709023453; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=VFFd3byePFbXvT95uWHJ++ajOcVKjQ2A6gI1gKsuvHI=;
 b=BzsLwI+d6LPaq/ALCRlQVv2ZHT/uayBGEG/xTIjrUCK3nhAlsHUrIiHt/0uwI5aXr4Xae
 LGUJ7raPDmcF2gcA/4nnx6+3ImGUpZ6zm2ojGNxHxdGhfj4jz2i74s75GmKgUfz6fYYR7BF
 wIDTvpvxITueX+W17X0hk3yTVnPAaFQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D9EC3CEFBC
	for <ltp@archiver.kernel.org>; Tue, 27 Feb 2024 09:44:13 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6DA2D3CEEEE
 for <ltp@lists.linux.it>; Tue, 27 Feb 2024 09:43:13 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.139.130;
 helo=esa5.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com
 [68.232.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7230F207232
 for <ltp@lists.linux.it>; Tue, 27 Feb 2024 09:43:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1709023392; x=1740559392;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gJUnAigX5nKtd54zEPgjjXFh+Ss7T0L1OF+G3JWROdA=;
 b=grdC5ddR/2bZlV3RFkBcaouWlV9R0zx74qLU3SqpEKGd76F5lPLxL8/f
 +psAq2SWpXJ2c8yAz4DVmupSRA0KirRs4B8WAKZ2RQww+dDR2nZtfr30G
 ptxAyXiYgVDbg8cSjfQtmOav/LHSeVfOkbUZVEMrZaa7nOxD1whY9X8W0
 yvaCilLzttHBy7GQ7z4NfpJzVp5UuX9wOtn281EQjAEmHY76UMN1m3ROc
 kkoSYn5zhXNVuEl5lKSudaBH52YzFSqKRLNgX7qAITufplksLCW/wVwYB
 dIKqqns/gKSXEQf1wvZMOVUsPYzh1eZb1jkz2oS3a0w8qblXxDcCF4gvo g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="150004308"
X-IronPort-AV: E=Sophos;i="6.06,187,1705330800"; d="scan'208";a="150004308"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
 by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2024 17:43:10 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 1857BD9F0C
 for <ltp@lists.linux.it>; Tue, 27 Feb 2024 17:43:08 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 4E72AD7B6F
 for <ltp@lists.linux.it>; Tue, 27 Feb 2024 17:43:07 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id D3BF141055
 for <ltp@lists.linux.it>; Tue, 27 Feb 2024 17:43:06 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 681BD1A006A;
 Tue, 27 Feb 2024 16:43:06 +0800 (CST)
To: ltp@lists.linux.it
Date: Tue, 27 Feb 2024 03:42:44 -0500
Message-Id: <20240227084244.33662-3-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240227084244.33662-1-xuyang2018.jy@fujitsu.com>
References: <20240227084244.33662-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28216.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28216.006
X-TMASE-Result: 10--16.057600-10.000000
X-TMASE-MatchedRID: GyhbhdD5alRa6JkWul/UfE7nLUqYrlslFIuBIWrdOeOjEIt+uIPPOJBF
 C/PvU/lgmHD/QEfzXMflgC90JZPVsI0zxJrF5VMZypiC33/79mcL//VMxXlyE97p0Ru8jKvF/9T
 DS4zEk/zv3R81Uj/6vMjhLggtE8XmxB13Y/+OC6ap3Btb1bH20Gvaomg0i4KN/5o9BPVzGUaRh2
 fOTp3PtlLawnkOVilWcfLMR+KlDOzzXojwcywrzPZNLVgVojn/l9q75JzWJRNujEcOZiInj5/bu
 mQx78u3gvoA8cGUyvoOe6UQgyI8ebd2u9fM9Zt+8IK7yRWPRNGBs03RHrzjM4qyjcQ3p/0Mj+B3
 qsDdCHyipw58JSX3jHy8s7RgoirCxnDmzSiE8O17TXnCjI8t9ki8rgutezVpPZSk8XZgZOGXidr
 9etFZ1oAAzcwNZpHF0a+qS+HYqZWfLxf8NKOlfG03YawHJvPC+LidURF+DB2chtWeykcDiuafUx
 jZqZZRb7vhAFDgsdM0D0Peqz8C66ceJlSdtw9ELTHwnYOikQ3vFrxMChrhqfI8LsVQUyaIObTpJ
 WONTOHi8zVgXoAltsIJ+4gwXrEtvECLuM+h4RB+3BndfXUhXQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/3] mremap04: Convert to new API
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
From: Yang Xu via ltp <ltp@lists.linux.it>
Reply-To: Yang Xu <xuyang2018.jy@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/mremap/Makefile   |   4 +-
 testcases/kernel/syscalls/mremap/mremap04.c | 269 ++++----------------
 2 files changed, 53 insertions(+), 220 deletions(-)

diff --git a/testcases/kernel/syscalls/mremap/Makefile b/testcases/kernel/syscalls/mremap/Makefile
index 190b7659d..f286dd9bf 100644
--- a/testcases/kernel/syscalls/mremap/Makefile
+++ b/testcases/kernel/syscalls/mremap/Makefile
@@ -3,10 +3,10 @@
 
 top_srcdir		?= ../../../..
 
-LTPLIBS = ltpipc
+LTPLIBS = ltpnewipc
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-mremap04: LTPLDLIBS  = -lltpipc
+mremap04: LTPLDLIBS  = -lltpnewipc
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/mremap/mremap04.c b/testcases/kernel/syscalls/mremap/mremap04.c
index 53902df73..8d819184e 100644
--- a/testcases/kernel/syscalls/mremap/mremap04.c
+++ b/testcases/kernel/syscalls/mremap/mremap04.c
@@ -1,245 +1,78 @@
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
+ * Copyright (c) Linux Test Project, 2001-2024
+ * 07/2001 Ported by Wayne Boyer
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
+/*\
+ * [Description]
  *
- *      11/09/2001 Manoj Iyer (manjo@austin.ibm.com)
- *      Modified.
- *      - #include <linux/mman.h> should not be included as per man page for
- *        mremap, #include <sys/mman.h> alone should do the job. But inorder
- *        to include definition of MREMAP_MAYMOVE defined in bits/mman.h
- *        (included by sys/mman.h) __USE_GNU needs to be defined.
- *        There may be a more elegant way of doing this...
+ * Test for ENOMEM error.
  *
- *      26/02/2008 Renaud Lottiaux (Renaud.Lottiaux@kerlabs.com)
- *      - Fix concurrency issue. Use a shm key from getipckey instead of
- *        a fixed hard-coded value.
- *
- * RESTRICTIONS:
- *  None.
+ * - mremap fail when the memory area cannot be expanded at the current virtual address
+ *   and MREMAP_MAYMOVE flag not set
  */
+
 #define _GNU_SOURCE
-#include <errno.h>
-#include <unistd.h>
-#include <sys/mman.h>
 #include <sys/ipc.h>
 #include <sys/shm.h>
+#include "tst_test.h"
+#include "libnewipc.h"
+#include "tst_safe_sysv_ipc.h"
 
-#include "test.h"
-
-#define SHM_MODE	(SHM_R | SHM_W)	/* mode permissions of shared memory */
+#define SHM_MODE (SHM_R | SHM_W)
 
-char *TCID = "mremap04";
-int TST_TOTAL = 1;
-char *addr;			/* addr of memory mapped region */
-char *shmaddr;			/* pointer to shared memory segment */
-int shmid;			/* shared memory identifier. */
-int memsize;			/* memory mapped size */
-int newsize;			/* new size of virtual memory block */
+static char *addr;
+static char *shmaddr;
+static int shm_id;
+static int memsize;
+static int newsize;
 
-void setup();			/* Main setup function of test */
-void cleanup();			/* cleanup function for the test */
-
-extern int getipckey();
-
-int main(int ac, char **av)
+static void verify_mremap(void)
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
+	errno = 0;
+	addr = mremap(shmaddr, memsize, newsize, 0);
+	TST_ERR = errno;
 
-		if (TEST_ERRNO == ENOMEM) {
-			tst_resm(TPASS, "mremap() failed, "
-				 "'MREMAP_MAYMOVE flag unset', "
-				 "errno %d", TEST_ERRNO);
-		} else {
-			tst_resm(TFAIL, "mremap() failed, "
-				 "Unexpected errno %d", TEST_ERRNO);
-		}
+	if (addr != MAP_FAILED) {
+		tst_res(TFAIL | TTERRNO,
+			 "mremap returned invalid value, expected: -1");
 	}
 
-	cleanup();
-	tst_exit();
-
+	if (TST_ERR == ENOMEM) {
+		tst_res(TPASS | TTERRNO, "mremap() failed, "
+			 "'MREMAP_MAYMOVE flag unset', "
+			 "errno %d", TST_ERR);
+	} else {
+		tst_res(TFAIL | TTERRNO, "mremap() failed, "
+			 "Unexpected errno %d", TST_ERR);
+	}
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
+static void setup(void)
 {
 	key_t shmkey;
 
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
+	memsize = SAFE_SYSCONF(_SC_PAGESIZE);
 	newsize = (memsize * 2);
-
-	/* get an IPC resource key */
-	shmkey = getipckey();
-
-	/*
-	 * Create a shared memory segment represented by SHMKEY of
-	 * specified size 'newsize' and mode permissions 'SHM_MODE'.
-	 */
-	shmid = shmget(shmkey, newsize, IPC_CREAT | SHM_MODE);
-	if (shmid == -1) {
-		tst_brkm(TBROK, NULL, "shmget() Failed to create a shared "
-			 "memory, error:%d", errno);
-	}
-
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
+	shmkey = GETIPCKEY();
+	shm_id = SAFE_SHMGET(shmkey, newsize, IPC_CREAT | SHM_MODE);
+	shmaddr = SAFE_SHMAT(shm_id, NULL, 0);
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
+	SAFE_SHMDT(shmaddr);
+	SAFE_SHMCTL(shm_id, IPC_RMID, 0);
 
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
+	.needs_tmpdir = 1,
+	.test_all = verify_mremap,
+};
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
