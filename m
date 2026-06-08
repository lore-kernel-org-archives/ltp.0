Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D6CCD8C92
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 02:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780887178; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=M2E1EL6tH1wa3P2YcHC2/lA2MwbbvMsdkSQ9FyXtqRs=;
 b=EFBYTmL6EyqCxByGzq1djYoY4HELKnijeNCBtsj5B/qaQ5RZlMVFdhBZCAeSjSR6oxnl+
 zDNzULpTjh2lcR7+38SF11183D7AlcBTFMYeKTIxZrQw2DIHQG9k4mvPkBIAcmZ8fYIEvGp
 tURU3gD4zWK3cJjwjFrX6YfEGyMSQJc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 391F53C29B6
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 04:52:58 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B16A3C22A5
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 04:52:38 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9A6481A000F7
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 04:52:37 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-490b2b037d2so32822585e9.3
 for <ltp@lists.linux.it>; Sun, 07 Jun 2026 19:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780887157; x=1781491957; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AGU/0OHn8bOdcRXiX7sGV507ZypGy6Ip1xwLmx+aL5k=;
 b=bXfVj/5KW65AIjYnVP23+oQlZfy7fW3/ZVerxIYyTTsm6Ckxr/qn630iyLIRLivtix
 jzaItw+fYuHMlKhVEhjMwS3TQMVd1x35/GGi0dmAVJGuHR6TcOha9Uz6RkA2t9uNVyQt
 dSpllB9D4bIyB+G6W7CpngmN/cJsVNaD7V8KT3cCtRUTEVP7/l13t+uvG+OgHgwgwloo
 aQ9CbweLJhJcdw9nnmv4XgYxS/LBihaJ2JDJ1tB5zisG1BHBps2Os0Hwp6f6OrNJ8pOk
 t7jhaA4K/bdsSNe78/J+u6iPDCypjmLXHSQT1LZO3KIaekoFbYem2ktsjsXA7eb0p18E
 jN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780887157; x=1781491957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AGU/0OHn8bOdcRXiX7sGV507ZypGy6Ip1xwLmx+aL5k=;
 b=UpBcqZCAxGptOWuJJiXnkZh49PzPKYJxy5VdYYTNo+SwNA121FFNWBf40IcBJncsly
 DybcqoCzgGtPhRi0QXuPoNYeH72fnKAWW7lEaZvPG7F3QMKo2l8gZVg65qXyiDKzoxU+
 Qo2xXYNY3os6+9ZcPrlfMZXkrVGvI6Pr1rk29u4IRS/3hq+TEV8NBJTIM3/kf4tmO8nC
 SBy9sNRCqkzJAN7Iie73Oi9I7tXwEE1nnze+UP0mYGa6JHPzmdL37Y86gPLY6xFQVs9R
 HY27fQ/2MS0uS63pL3rOyabJZ9Ga0MtviYUhNiqv0dgD7ot6nxMBo/pTpRmqsoRy6pO1
 +mCg==
X-Gm-Message-State: AOJu0Yy3m+DhRgOYQ/5eeqrIjB+Rru4ePUIq+WhTBY01btEfDy9SZVs4
 cFamzedQKSBSvgp4F+pY7Ph7VX0kUDp7yawRISnAUPr7qAvSBKtoVqC4CDPYwrLqF03qz4uHs3o
 1qpo=
X-Gm-Gg: Acq92OG3xchQlQFBDIuZdtEoR42oEqZgNEpJWZIqc+pRYfQQhNwHyslrz4yaUgwb0l3
 e8ft2O1lyue83M+NS7cmGS7fgo5PVp2BhyFWaXv/onbEI3eUifq9MLYIprrYisbcYGGiZ6UTiZz
 gZVPImmdOcJogb8cUgEbvhyKf/ThNU8MdfneBtfQwx/wVqf1CSlmynQh9jo1xOUCM1Z9QDnnhQu
 qyqrvGY24HaxORTEeilYQ0TjBksWk61GgVKf9dgIS3uhQBmoFdel8mDS1G/lYzJbTq/GZUJFQt/
 BiKPRbFUwvI/quVemxX+YYSlVcjQNmtIzAwwFcR/mS7xeCYrigoKMzEmiL+WTLHutQ3eer7lVjA
 lUCC/KMpKIBr7/9npBclN5ZOjJz/0mbQY+zuSAMCoJvP+29hBywWepIeE9vL3IO0JFoJ2CmjoHU
 4YaNvVYDdB5LFLy7SQJH4QFQ==
X-Received: by 2002:a05:600c:3515:b0:490:b5d0:598e with SMTP id
 5b1f17b1804b1-490c2604783mr211560315e9.21.1780887156851; 
 Sun, 07 Jun 2026 19:52:36 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-4601f351d69sm86753422f8f.29.2026.06.07.19.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 19:52:36 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon,  8 Jun 2026 02:52:05 +0000
Message-ID: <20260608025234.1117-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260607045219.32729-1-wegao@suse.com>
References: <20260607045219.32729-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] mmapstress06: Convert to new API
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

v4->v5:
- Dropping the redundant SAFE_CG_PRINTF(tst_cg_drain, ...)

 runtest/mm                                    |   2 +-
 .../kernel/mem/mmapstress/mmapstress06.c      | 193 ++++++++++--------
 2 files changed, 104 insertions(+), 91 deletions(-)

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
index 37b7edc84..56f562139 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress06.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress06.c
@@ -1,116 +1,129 @@
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
