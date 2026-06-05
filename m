Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3CE1CD6E74
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 04:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780633807; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=JtI430WnjjcbqlkQQ0+e8siFiw03awTlPkllT4+UEvQ=;
 b=ln3E9Hn3YdI5ZyVZB364dNRCb8Jx61HFV9L2QnYFhtqFCJGZ3f9zTqXKuNR61B+GQ3Exc
 ZKshjVVMEML47HKLGTq2TEi0A848GjGRpeH8j3iXanNdgmxKZ6R2npSsxH2A3VDdF+afQqn
 X1zQFXznl+XlM64L62atNPs39BW60To=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D4963E267E
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 06:30:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 00F223CCAFE
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 06:29:46 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 772701000A02
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 06:29:45 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4908b92904fso16596015e9.0
 for <ltp@lists.linux.it>; Thu, 04 Jun 2026 21:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780633785; x=1781238585; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x4A2QZCpdw2iaK+kkNuW9Y6R9BqnFJbHqoUD8ruv2FQ=;
 b=HjNGyYcfBHxTfFTAEX+E9zPzmj032bZ3Gu1x9EZ8Mcqqs9AN9YZvFW1+lzfLfGAZX/
 DUv+Tkt0lF8sGSYx7TVnRKCHaAN4IxOUd/K0d3rlF8vMMeRwt9TMDWIcTef7GPcxydZH
 P+b6aWJkSDzuCZSr0OAybWF9myjnTvYutLvIB1EQvapSqqzMxcXKqiFriJ8iZebPG2AD
 s0Rzq8wnxSxX3VE7i96uLuwoJ3hEFAal+qrENf9z9ucXsNqlFm0MRi9hyg+6k/ON3gBW
 1Ro1XyoW2ztoSfvk7Zg8uLud6DgYQB/EzTm7Nltr+oD7Bscjz5iKUHVPb01R4JX2EsUn
 4Pyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780633785; x=1781238585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x4A2QZCpdw2iaK+kkNuW9Y6R9BqnFJbHqoUD8ruv2FQ=;
 b=Y6suGLR7cEaZ9Yrtc2tU1mZIz5Nni2CalbXYPm9kfZzqPxugJHeTpgjkKCRVrHooeU
 utxI8xTxodxKcbdyXNK0/SLbrQZYOmHhhLwt8cig/wfkScfXwxarzyhE/5ZpBG4blUcy
 0c6eyYg2OUiaxvN4YKRTLRTjfqjLu2aZoahgabMJLQzr5vhrvSXRHVqdR10fu0PBRkMK
 2HtYOvcUdTIDZWsIko6oL0M9xEKrwKOTNo3ljqJk7IbM1T/Pcjq3k2MaKeQ5cwuvv20E
 81NjaF16sxg+IasdYpSheOZ23OmY0DfMXNCw07e0I7jxW/nM43P7Nu/1i7Eg3j+82p7P
 Ti4w==
X-Gm-Message-State: AOJu0Yw52alrVY20yb5/lD8G2NYHiZgU/+QIV+FsQLkO3ypH4kbIgjr5
 1cOcbA58FgrWFci7H4N3qPetTd6MHxHRMH/NTJhj8c/4FBeK+WqC+j2YNV9lu/py7Vb+X6LFrSs
 iHp4=
X-Gm-Gg: Acq92OFKbJeRT8soBFV+3YQCRP/UvQnO1uHYHpuHOxUPppTCK5ZixlkfeSFplBcXDUg
 D7VEpcEBpROhyrEuFnTxOppogdCR5XNBX6KbNNALlXQxnNSNvzNJz7M700ASsDjGgUSe4KywlML
 /5+EyJlwvUAEYrFGzFiO/QxqFgildC9kLkQtwCFwXy58re2gTwaRbtElJwipVEiZHPMzQtyJFWf
 MI4ifgZ6+uAF+pv4cD1oO9/sYpf3Y2SedarneClCsLb17w8Rhm1+XTy9laoXi1wl31KXH+eyg4Q
 kJNdqURR4ZoSPMv8LwecPmIGN6g64kgw5XaDxQucnhB3J1bnHsyivMSM40EL/hLRcyuRKfJnKKE
 3BbQucT0F+1dqgzgdGOIs9dsMg2NTyT8uFzJJjQOg6hAkkhk8SWG5h0x94PaCdfEqSTTSER1gN2
 Zex6VhqhgJAyMAKe2ocOT0Ow==
X-Received: by 2002:a05:600c:674f:b0:490:6e11:c303 with SMTP id
 5b1f17b1804b1-490c25ed266mr23062695e9.13.1780633784795; 
 Thu, 04 Jun 2026 21:29:44 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-490bc3e59f5sm123050015e9.14.2026.06.04.21.29.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 21:29:44 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri,  5 Jun 2026 04:29:27 +0000
Message-ID: <20260605042942.30480-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427115941.31945-1-wegao@suse.com>
References: <20260427115941.31945-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] mmapstress06: Convert to new API
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
  constrained memory stress test under cgroup v2.
- Dirties all pages of the 1GB shared anonymous mapping inside the
  child cgroup, forcing the kernel to swap out exactly 500MB of memory.
  This large page pool avoids premature cgroup OOM-kills on systems
  with larger page sizes (like 64KB on ppc64le), while keeping the total
  swap usage lightweight and safe.
- Added CONFIG_SWAP=y and CONFIG_MEMCG=y kernel configuration checks.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 runtest/mm                                    |   2 +-
 .../kernel/mem/mmapstress/mmapstress06.c      | 200 ++++++++++--------
 2 files changed, 111 insertions(+), 91 deletions(-)

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
index 37b7edc84..f1500eb6c 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress06.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress06.c
@@ -1,116 +1,136 @@
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
+ * Test ``:manpage:`mmap(2)``` with swap behavior.
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
+#include <sys/sysinfo.h>
 #include <unistd.h>
 #include <stdio.h>
 #include <errno.h>
+#include <stdlib.h>
+#include "tst_test.h"
+#include "tst_safe_macros.h"
 
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
+	int status;
 
-int anyfail();
-void ok_exit();
-/*****	**	**	*****/
+	cg_child = tst_cg_group_mk(tst_cg, "child");
 
-#define ANON_GRAN_PAGES_MAX	(32U)
+	/* Set memory limit to force swapping of the mapping */
+	SAFE_CG_PRINTF(cg_child, "memory.max", "%lu", (unsigned long)mem_limit);
+	SAFE_CG_PRINT(cg_child, "memory.swap.max", "max");
 
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
+		for (size_t i = 0; i < map_size; i += page_size)
+			mmapaddr[i] = 'a';
+
+		SAFE_CG_SCANF(cg_child, "memory.swap.current", "%lu", &cg_swap_after);
+
+		tst_res(TINFO, "Cgroup swap: %lu MB -> %lu MB",
+			cg_swap_before / TST_MB, cg_swap_after / TST_MB);
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
+	SAFE_WAITPID(child_pid, &status, 0);
+	child_pid = -1;
+
+	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
+		tst_res(TFAIL, "Child process failed (status: %d)", status);
+
+	cg_child = tst_cg_group_rm(cg_child);
 }
 
-/*****	LTP Port	*****/
-void ok_exit(void)
+static void setup(void)
 {
-	tst_resm(TPASS, "Test passed");
-	tst_exit();
+	struct sysinfo s;
+	unsigned long long total_swap;
+
+	if (!SAFE_CG_HAS(tst_cg, "memory.swap.max"))
+		tst_brk(TCONF, "Cgroup swap controller is not enabled/supported");
+
+	page_size = getpagesize();
+
+	mem_limit = 500 * TST_MB;
+	map_size = 1000 * TST_MB;
+
+	sysinfo(&s);
+	total_swap = (unsigned long long)s.totalswap * s.mem_unit;
+
+	if (total_swap < map_size) {
+		tst_brk(TCONF, "System swap size (%llu MB) is too small, need %llu MB",
+			total_swap / TST_MB, (unsigned long long)map_size / TST_MB);
+	}
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
+	.needs_cgroup_ver = TST_CG_V2,
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
