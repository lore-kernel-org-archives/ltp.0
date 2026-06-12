Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 191C2CD8CA8
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 05:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781241390; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=KmQM2vSd4b1TEOvdwVXBfGVarhOa4hEiLJ8XL/XtjlM=;
 b=UYxXcrKjbSAQ8QG/ZF8ZS9bU5aymGEN1P7WwhIkAyeSolhXcYuNgiefzKfl3J2rmv353Y
 dOqYKk4/BIeR+CNdzU2Zrkermox5Jrc0BUODoQJUGFx0BlgQ0W6Cjx9sSg8js17mdyccrpT
 fFJdUQH50QCVmwtH2aQEfQU42P5L0q8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 231FB3E1BF0
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 07:16:30 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 62FE43C19F0
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 07:16:09 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BDAEB200972
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 07:16:08 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-45f3cf907ceso254303f8f.2
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 22:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781241368; x=1781846168; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n9Ft02RHwnybEsTHPEdQjSDuDW4w9/5EjvD2OQdMR5s=;
 b=NSpvJ6EM7xjqgH0JZWufnauVPg8hPkvX7KfPXzYlTiCi93LDSTqf0+hLe9bxUXtfG8
 7LThEX+Dup7vHhDpF50nUNcCZ/0pXFEC6TLwih1WAZx+KJcyF19SQaREej+F3xZoi46H
 IzspdwVmn4boVzgqj8dq2P2Rwp1jpsRf5np/JWCPvFfTlty86sZvzac3xszvTJgU6xuX
 x5CXX5/4U/ZlznY+dX61cTKoyHyaMr28tkQsuSsPfbrZhq8vJbb95+Y+eyM/CUeokGmM
 M8S7rNTgKhdVIbIpdpuUTu8NdgfB4rcZ4AxKiSNZOPA4ZfI1cqNfqJ93QJoC9f9Baum8
 +wHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781241368; x=1781846168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n9Ft02RHwnybEsTHPEdQjSDuDW4w9/5EjvD2OQdMR5s=;
 b=AQOf1Wxp1VffDu+aA12+7h4eZnLAbq+EO1ftUTK9R2EUMMRAxrwWtYMosjVPI9RAre
 TSGDH/6IURA5TlngdBiZflgt0VMVGuhYC+RRKIF6XNSqbN+CrQdnaJj4sIpvqCMVXzr0
 HxDNB/mu+R1lqlhHvUUs7rvkpeq32wh2HxF0w336v+OwCOITglLl8wX/xLEdiLrLDP3a
 fDCbayJ6DSJVQGCqFlgDpvjBawDsOEdq4l9hoKPbIK2Q+jPPUZiuzDVCSZ1/QnSWGdoF
 lXOrgwchYnHYU1OnNUa1e72ggY7P/SJxzgN2am3DnTEGXPaEHZ+D7VTqUTGDz9+rpyyf
 H/Dw==
X-Gm-Message-State: AOJu0YxJOyZB+Ar2ZtlVs0mWHDtCR0crZm8zLg4wntP8U5WsvEe07k7p
 Lan83TbMssAwZvXezlUv1OLgybd+psH0PeIm2dZEeCVN4mgUMO8wZPnh1NH1Y6OOsOd/+wHoDbL
 kCg8=
X-Gm-Gg: Acq92OFAmReoK+HBlvyLfswtKB7Z2Xb1fJnO7yZSVu93agjG7YBfpSqO6IDMvOvkPHm
 LNsA0PZbR7RGdgNSGoPa3G9WtrVAMshLm/hhi+4jxYY4sE3v8FMFM26M4YNOjNuuNgYwVFsGWGv
 urwfiPwO4kI49ORQRW8L0w5MbyxiAOUG4qzpcC2r5UH0r6APm7E5JBUhkkkF69nDJgDzhRILQCK
 e7eqF+OZvYc7oiTxYN5Cq6OxjJxYLI2bC2D+i32mGKlz9HHiyC5y/CQyZt6ARxNszbF5jGssRhb
 xzaN10JOpiZ7p1TwHtcY5fRiCZ3QnKTVFTvVlzsOq2qwGIP2JVMBfaemPpJuWNFiYzRBFkBkUox
 MfBu9ABQCNA6n11AZUfHQuFfkKobPEExwrzcIyVulkgM9zOW1Vf+aZz5jqYc5BBDCBcSRVJNOWL
 DrdUho9p3SZs4=
X-Received: by 2002:a5d:5846:0:b0:460:660a:3647 with SMTP id
 ffacd0b85a97d-4606db9f166mr1566978f8f.25.1781241368102; 
 Thu, 11 Jun 2026 22:16:08 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-4606f2b0d70sm2252106f8f.19.2026.06.11.22.16.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 22:16:07 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 12 Jun 2026 05:15:50 +0000
Message-ID: <20260612051605.5385-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611030858.4109-1-wegao@suse.com>
References: <20260611030858.4109-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7] mmapstress06: Convert to new API
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Convert the mmapstress06 test case from the legacy LTP API to the new
tst_test API.

Refactor and redesign the test to be active instead of passive:
- Replaced the passive sleep-based synchronization with an active cgroup
  constrained memory stress test compatible with both cgroups v1 and v2.
- Dirties all pages of a 256MB shared anonymous mapping inside the
  child cgroup, forcing the kernel to swap out memory when hitting the
  128MB limit.
- Rate limits page dirtying by introducing a page-size independent
  1ms sleep every 2MB (i.e. usleep(1000) when i % 2MB == 0) to allow the
  kernel's asynchronous swap writeback to stably reclaim pages and prevent
  MemCG OOM-kills on all architectures (e.g. standard 4KB or 64KB page size)
  while optimizing execution speed.
- Added CONFIG_SWAP=y and CONFIG_MEMCG=y kernel configuration checks.
- Utilized declarative .min_mem_avail and .min_swap_avail for framework-level
  resource validation.

Suggested-by: Li Wang <li.wang@linux.dev>
Signed-off-by: Wei Gao <wegao@suse.com>
---

v6->v7:
- Change rate-limit sleep interval from 64KB to 2MB to optimize execution time.

 runtest/mm                                    |   2 +-
 .../kernel/mem/mmapstress/mmapstress06.c      | 186 +++++++++---------
 2 files changed, 97 insertions(+), 91 deletions(-)

diff --git a/runtest/mm b/runtest/mm
index 41d624ad8..7d75b65c8 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -41,7 +41,7 @@ mmapstress02 mmapstress02
 mmapstress03 mmapstress03
 mmapstress04 mmapstress04
 mmapstress05 mmapstress05
-mmapstress06 mmapstress06 20
+mmapstress06 mmapstress06
 mmapstress07 TMPFILE=`mktemp $TMPDIR/example.XXXXXXXXXXXX`; mmapstress07 $TMPFILE
 mmapstress08 mmapstress08
 mmapstress09 mmapstress09 -p 20 -t 0.2
diff --git a/testcases/kernel/mem/mmapstress/mmapstress06.c b/testcases/kernel/mem/mmapstress/mmapstress06.c
index 37b7edc84..4e6023399 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress06.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress06.c
@@ -1,116 +1,122 @@
-/* IBM Corporation */
-/* 01/02/2003	Port to LTP	avenkat@us.ibm.com */
-/* 06/30/2001	Port to Linux	nsharoff@us.ibm.com */
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *   Copyright (c) International Business Machines  Corp., 2003
- *
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * Copyright (c) International Business Machines Corp., 2003
+ * Copyright (c) 2026 Linux Test Project
+ */
+
+/*\
+ * Test :manpage:`mmap(2)` with swap behavior.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
+ * Mmap a large anonymous shared region and force it to be swapped out
+ * by setting memory limits using Cgroups and dirtying all pages.
  *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * This test requires root privileges because configuring cgroup memory
+ * limits requires administrative access.
  */
 
-/*
- * mfile_swap:
- * Mmap a large (> ANON_GRAN_PAGES_MAX) shared, anonymous region before
- * swapping to use the second half of the kernel primitive mfile_swap.
- * However, this test does _NOT_ cause swapping to occur.  Instead it should be
- * run with waves or at the same time as a test which does cause swapping (i.e.
- * vsswapin or vfork_swap)
- */
-#define _KMEMUSER
+#define _GNU_SOURCE
 #include <sys/types.h>
 #include <sys/mman.h>
+#include <sys/wait.h>
 #include <unistd.h>
 #include <stdio.h>
 #include <errno.h>
+#include <stdlib.h>
+#include "tst_test.h"
 
-/*****  LTP Port        *****/
-#include "test.h"
-#define FAILED 0
-#define PASSED 1
+static struct tst_cg_group *cg_child;
+static int page_size;
+static size_t map_size;
+static size_t mem_limit;
+static pid_t child_pid = -1;
 
-int local_flag = PASSED;
-char *TCID = "mmapstress06";	//mfile_swap
-FILE *temp;
-int TST_TOTAL = 1;
+static void run_test(void)
+{
+	cg_child = tst_cg_group_mk(tst_cg, "child");
 
-int anyfail();
-void ok_exit();
-/*****	**	**	*****/
+	/* Set memory limit to force swapping of the mapping */
+	SAFE_CG_PRINTF(cg_child, "memory.max", "%lu", (unsigned long)mem_limit);
 
-#define ANON_GRAN_PAGES_MAX	(32U)
+	if (TST_CG_VER_IS_V1(cg_child, "memory"))
+		SAFE_CG_PRINT(cg_child, "memory.swap.max", "-1");
+	else
+		SAFE_CG_PRINT(cg_child, "memory.swap.max", "max");
 
-extern time_t time(time_t *);
-extern char *ctime(const time_t *);
-extern int atoi(const char *);
+	child_pid = SAFE_FORK();
+	if (!child_pid) {
+		char *mmapaddr;
+		unsigned long cg_swap_before = 0, cg_swap_after = 0;
 
-#define NMFPTEPG		(1024)
-#define ERROR(M)	(void)fprintf(stderr, "%s: errno = %d; " M "\n", \
-				argv[0], errno);
+		/* Move child to the constrained cgroup */
+		SAFE_CG_PRINTF(cg_child, "cgroup.procs", "%d", getpid());
 
-int main(int argc, char *argv[])
-{
-	caddr_t mmapaddr;
-	size_t pagesize = sysconf(_SC_PAGE_SIZE);
-	time_t t;
-	int sleep_time = 0;
-
-	if (!argc) {
-		(void)fprintf(stderr, "argc == 0\n");
-		anyfail();
-	}
-	if (argc != 2 || !(sleep_time = atoi(argv[1]))) {
-		(void)fprintf(stderr, "usage: %s sleep_time\n", argv[0]);
-		anyfail();
-	}
-	(void)time(&t);
-//      (void)printf("%s: Started %s", argv[0], ctime(&t));  LTP Port
-	if (sbrk(pagesize - ((ulong) sbrk(0) & (pagesize - 1))) == (char *)-1) {
-		ERROR("couldn't round up brk");
-		anyfail();
-	}
-	if ((mmapaddr = sbrk(0)) == (char *)-1) {
-		ERROR("couldn't find top of brk");
-		anyfail();
-	}
-	/* mmapaddr is now on a page boundary after the brk segment */
-	if (mmap
-	    (mmapaddr, (ANON_GRAN_PAGES_MAX * NMFPTEPG + 1) * pagesize,
-	     PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_SHARED, 0,
-	     0) == (caddr_t) - 1) {
-		ERROR("large mmap failed");
-		printf("for this test to run, it needs a mmap space of\n");
-		printf("%d pages\n", (ANON_GRAN_PAGES_MAX * NMFPTEPG + 1));
-		return 1;
+		SAFE_CG_SCANF(cg_child, "memory.swap.current", "%lu", &cg_swap_before);
+
+		mmapaddr = SAFE_MMAP(NULL, map_size, PROT_READ | PROT_WRITE,
+				     MAP_ANONYMOUS | MAP_SHARED, -1, 0);
+
+		tst_res(TINFO, "Dirtying %zu bytes in child", map_size);
+
+		for (size_t i = 0; i < map_size; i += page_size) {
+			mmapaddr[i] = 'a';
+			if ((i % (2 * 1024 * 1024)) == 0)
+				usleep(1000);
+		}
+
+		SAFE_CG_SCANF(cg_child, "memory.swap.current", "%lu", &cg_swap_after);
+
+		if (cg_swap_after > cg_swap_before) {
+			tst_res(TPASS, "Cgroup swap usage increased from %lu MB to %lu MB",
+				cg_swap_before / TST_MB, cg_swap_after / TST_MB);
+		} else {
+			tst_res(TFAIL, "Cgroup swap usage did not increase (before: %lu B, after: %lu B)",
+				cg_swap_before, cg_swap_after);
+		}
+
+		SAFE_MUNMAP(mmapaddr, map_size);
+		exit(0);
 	}
-	(void)sleep(sleep_time);
-	(void)time(&t);
-//      (void)printf("%s: Finished %s", argv[0], ctime(&t)); LTP Port
-	ok_exit();
-	tst_exit();
+
+	SAFE_WAITPID(child_pid, NULL, 0);
+	child_pid = -1;
+
+	cg_child = tst_cg_group_rm(cg_child);
 }
 
-/*****	LTP Port	*****/
-void ok_exit(void)
+static void setup(void)
 {
-	tst_resm(TPASS, "Test passed");
-	tst_exit();
+	if (!SAFE_CG_HAS(tst_cg, "memory.swap.max"))
+		tst_brk(TCONF, "Cgroup swap controller is not enabled/supported");
+
+	page_size = getpagesize();
+
+	mem_limit = 128 * TST_MB;
+	map_size = 256 * TST_MB;
 }
 
-int anyfail(void)
+static void cleanup(void)
 {
-	tst_brkm(TFAIL, NULL, "Test failed");
+	if (child_pid > 0) {
+		SAFE_KILL(child_pid, SIGKILL);
+		SAFE_WAITPID(child_pid, NULL, 0);
+	}
+
+	if (cg_child)
+		cg_child = tst_cg_group_rm(cg_child);
 }
 
-/*****	**	**	*****/
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.forks_child = 1,
+	.needs_root = 1,
+	.needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
+	.min_mem_avail = 256,
+	.min_swap_avail = 128,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_SWAP=y",
+		"CONFIG_MEMCG=y",
+		NULL
+	},
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
