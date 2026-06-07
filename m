Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E285FCD8C8C
	for <ltp@archiver.kernel.org>; Sun,  7 Jun 2026 04:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780807964; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=U6ZkO90+Hsw1EfL7VIumHvs1rMtTu8CxQJufjiazyBo=;
 b=ourqZ7J29odAe9GWqRINnylmAqTAC2U5bT3LzQuuyH35hhFDJf488cqgPnVEiFxTf6S/u
 10L0esnJphecZYbyh/yicHqygHSshqmuVqYV8NK4YgUhHTccMVebkKtDbST1ZGWvhSoYcnU
 vyCtE7Fb10R9m2JierzJqJ4ha9cfYTk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B3763CA390
	for <ltp@archiver.kernel.org>; Sun,  7 Jun 2026 06:52:44 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB2B33C9450
 for <ltp@lists.linux.it>; Sun,  7 Jun 2026 06:52:23 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5AF8B10009BA
 for <ltp@lists.linux.it>; Sun,  7 Jun 2026 06:52:22 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-46019edc13dso1445272f8f.1
 for <ltp@lists.linux.it>; Sat, 06 Jun 2026 21:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780807941; x=1781412741; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fs5WT4FTup3Jfx3p4lANDNd7JOzBR6KzuaXccTo+9Ao=;
 b=U41NrFWZNXSOdIGJttJoghC31BRP6yXGU+B/v6fKU0xgbAhGYR+RSR6Gea71h+DOEG
 tZY8B4w/zI4RljSZGovgG9AJXSVGKoFOo5bQcd5UAAi+bI0fz/jEiI7QCMSJ1D+hFp8r
 M6/+gXGFRuEjZOJLlEGMTcBlTQq0mkK4WQgwgecImtAvrG7LJXfKcGniM9z91nrZ75GI
 KqD1RwVFJHcxa2fFRWto77SFjZBAZ0uiLQrHTJ0PdbQ+wIxQaFgtzvbncdrONdH1kZFj
 qhXVPijSenUuN6sg8eL3hf4YYGWLkACbmq5RJfGCDzGXswVGcK+xSDCzUsPJ51DIX7lc
 eUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780807941; x=1781412741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fs5WT4FTup3Jfx3p4lANDNd7JOzBR6KzuaXccTo+9Ao=;
 b=cS679kUuow58dU6v4E8qv5wjzTzoIkvXzvE1of3+dAoJkQk24YHl06LC7T0ApJGohg
 Gmpi4+lyMjPumt+ZTQrPJvfhdX65Ajzh0DqCFPYSBxpuLfs6KFeIH+FgRv2FissWNV4G
 usWh0dVcgfqMEPmODiew9j4EWwzMcBffjkhK1ygEDOrUb8Ed0ckJCbYfC2rwuogi+fzQ
 RUGf4x4iNsXvXqdHLjSkBgQqMD6SyAO157zgVdgpSVdZHOxz7icqR0Q6bDUbo4kMoBBj
 DJRqTgiBxUm/50GDwI1CoJFBm9JNFFoEc0qNHXCAor6Kmxz4EymI597t2TkomTnCHhFe
 BtXA==
X-Gm-Message-State: AOJu0YxQQVdND1Tp8pBNM1sgkoPtJFqAIqeY4XfP71ZQLIGkcMM7KjqV
 q99kJMzZHAmoHl1ODrOMnYZL26tFMPGfCwrIiA7z7nnL2t2at0elDAoJutQnOjkrLc8BRfELiOt
 b39c=
X-Gm-Gg: Acq92OHFOvNdc156rOkSCMpRz98f88IJRXdKEGMBZq3LsHVAsrvWwxm59IFdGEeUnnY
 IpI6ndhvPCTHwRacG647n7pofnimRu9q66cHujxlzybNA1VPc98tUb7BZiGPBcNp1GysdbAPKnN
 z8KR06ViQ0ZCGE0xGvGAniwbeR4rzhpiPfbOXaOFGbXd/Oz9tmiXNu8PmU1iij/VV7pPXLooBsG
 9e9iMAMtcTvcLFxzO6XDtku/0DtDGJSZviNpMf/UdGB5uYK72J/7VyzELlQgoQPG80nY8ik8hdA
 Jb0w+tTn5as4WUWzBQWYIlHzMd2tLbC7sVIWWdLg1LiBmIm3ApNIDfKfpuWYmxcfU/0X/cNzOgW
 hngHjXaNOaol9ebB9cNLMdcaXJaCRImoW0KgeCxNzQDBS+PUgS4Z00dzEKgp7DK+C452rYloGvu
 Cr3yOWwMX7g2/ie5WA7zxzpg==
X-Received: by 2002:a05:6000:480e:b0:45e:739b:3e3c with SMTP id
 ffacd0b85a97d-460301821b5mr17213154f8f.0.1780807941634; 
 Sat, 06 Jun 2026 21:52:21 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-4601f0a43e9sm40245834f8f.0.2026.06.06.21.52.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 21:52:21 -0700 (PDT)
To: ltp@lists.linux.it
Date: Sun,  7 Jun 2026 04:52:06 +0000
Message-ID: <20260607045219.32729-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260606100823.32067-1-wegao@suse.com>
References: <20260606100823.32067-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] mmapstress06: Convert to new API
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
- Disables Transparent Huge Pages (THP) on the mapping using
  madvise(..., MADV_NOHUGEPAGE) to avoid triggering cgroup OOM-kills.
- Added CONFIG_SWAP=y and CONFIG_MEMCG=y kernel configuration checks.
- Utilized declarative .min_mem_avail and .min_swap_avail for framework-level
  resource validation.

Signed-off-by: Wei Gao <wegao@suse.com>
---
v3->v4:
- removes duplicate failure checks in the parent

 runtest/mm                                    |   2 +-
 .../kernel/mem/mmapstress/mmapstress06.c      | 195 ++++++++++--------
 2 files changed, 106 insertions(+), 91 deletions(-)

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
index 37b7edc84..a4fda9683 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress06.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress06.c
@@ -1,116 +1,131 @@
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
+		/*
+		 * Disable Transparent Huge Pages (THP) for this mapping.
+		 * Under tight cgroup memory limits (128 MB), allocating huge
+		 * pages can easily trigger MemCG OOM-kills. Disabling THP forces
+		 * standard 4 KB pages, ensuring stable swapping and avoiding
+		 * premature OOM.
+		 */
+		if (madvise(mmapaddr, map_size, MADV_NOHUGEPAGE) < 0)
+			tst_res(TWARN | TERRNO, "madvise(MADV_NOHUGEPAGE) failed");
+
+		tst_res(TINFO, "Dirtying %zu bytes in child", map_size);
+
+		for (size_t i = 0; i < map_size; i += page_size)
+			mmapaddr[i] = 'a';
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
+	if (cg_child) {
+		SAFE_CG_PRINTF(tst_cg_drain, "cgroup.procs", "%d", getpid());
+		cg_child = tst_cg_group_rm(cg_child);
+	}
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
