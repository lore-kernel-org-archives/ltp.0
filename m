Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3100C4167B
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 21:10:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 10E733CF638
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 22:10:24 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B51DF3CD315
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 22:09:51 +0100 (CET)
Received: from 66-220-144-179.mail-mxout.facebook.com
 (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A24D71A01963
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 22:09:50 +0100 (CET)
Received: by devbig1114.prn1.facebook.com (Postfix, from userid 425415)
 id 934B01034048C; Fri,  1 Dec 2023 13:09:34 -0800 (PST)
From: Stefan Roesch <shr@devkernel.io>
To: kernel-team@fb.com
Date: Fri,  1 Dec 2023 13:09:30 -0800
Message-Id: <20231201210930.2651725-3-shr@devkernel.io>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231201210930.2651725-1-shr@devkernel.io>
References: <20231201210930.2651725-1-shr@devkernel.io>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] add ksm test for smart-scan feature
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
Cc: linux-mm@kvack.org, david@redhat.com, oliver.sang@intel.com,
 shr@devkernel.io, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This adds a new ksm (kernel samepage merging) test to evaluate the new
smart scan feature. It allocates a page and fills it with 'a'
characters. It captures the pages_skipped counter, waits for a few
iterations and captures the pages_skipped counter again. The expectation
is that over 50% of the page scans are skipped (There is only one page
that has KSM enabled and it gets scanned during each iteration and it
cannot be de-duplicated).

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 testcases/kernel/mem/.gitignore    |  1 +
 testcases/kernel/mem/include/mem.h |  1 +
 testcases/kernel/mem/ksm/ksm07.c   | 69 +++++++++++++++++++++++++++++
 testcases/kernel/mem/lib/mem.c     | 70 ++++++++++++++++++++++++++++++
 4 files changed, 141 insertions(+)
 create mode 100644 testcases/kernel/mem/ksm/ksm07.c

diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 7258489ed..c96fe8bfc 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -53,6 +53,7 @@
 /ksm/ksm04
 /ksm/ksm05
 /ksm/ksm06
+/ksm/ksm07
 /mem/mem02
 /mmapstress/mmap-corruption01
 /mmapstress/mmapstress01
diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index cdc3ca146..dbc3eb9ec 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -48,6 +48,7 @@ void testoom(int mempolicy, int lite, int retcode, int allow_sigkill);
 /* KSM */
 
 void create_same_memory(int size, int num, int unit);
+void create_memory_for_smartscan(void);
 void test_ksm_merge_across_nodes(unsigned long nr_pages);
 void ksm_group_check(int run, int pg_shared, int pg_sharing, int pg_volatile,
                      int pg_unshared, int sleep_msecs, int pages_to_scan);
diff --git a/testcases/kernel/mem/ksm/ksm07.c b/testcases/kernel/mem/ksm/ksm07.c
new file mode 100644
index 000000000..9cde64c82
--- /dev/null
+++ b/testcases/kernel/mem/ksm/ksm07.c
@@ -0,0 +1,69 @@
+/*
+ * Copyright (C) 2010-2017  Red Hat, Inc.
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
+ *
+ * Kernel Samepage Merging (KSM)
+ *
+ * This adds a new ksm (kernel samepage merging) test to evaluate the new
+ * smart scan feature. It allocates a page and fills it with 'a'
+ * characters. It captures the pages_skipped counter, waits for a few
+ * iterations and captures the pages_skipped counter again. The expectation
+ * is that over 50% of the page scans are skipped (There is only one page
+ * that has KSM enabled and it gets scanned during each iteration and it
+ * cannot be de-duplicated).
+ *
+ * Prerequisites:
+ *
+ * 1) ksm and ksmtuned daemons need to be disabled. Otherwise, it could
+ *    distrub the testing as they also change some ksm tunables depends
+ *    on current workloads.
+ *
+ */
+
+#include <sys/types.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include "../include/mem.h"
+#include "ksm_common.h"
+
+static void verify_ksm(void)
+{
+	create_memory_for_smartscan();
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.forks_child = 1,
+	.options = (struct tst_option[]) {
+		{}
+	},
+	.save_restore = (const struct tst_path_val[]) {
+		{"/sys/kernel/mm/ksm/run", NULL, TST_SR_TBROK},
+		{"/sys/kernel/mm/ksm/sleep_millisecs", NULL, TST_SR_TBROK},
+		{"/sys/kernel/mm/ksm/smart_scan", "1",
+			TST_SR_SKIP_MISSING | TST_SR_TBROK_RO},
+		{}
+	},
+	.needs_kconfigs = (const char *const[]){
+		"CONFIG_KSM=y",
+		NULL
+	},
+	.test_all = verify_ksm,
+};
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index fbfeef026..b27a017fc 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -438,6 +438,76 @@ static void resume_ksm_children(int *child, int num)
 	fflush(stdout);
 }
 
+/* This test allocates one page, fills the page with a's, captures the
+ * full_scan and pages_skipped counters. Then it makes sure at least 3
+ * full scans have been performed and measures the above counters again.
+ * The expectation is that at least 50% of the pages are skipped.
+ *
+ * To wait for at least 3 scans it uses the wait_ksmd_full_scan() function. In
+ * reality, it will be a lot more scans as the wait_ksmd_full_scan() function
+ * sleeps for one second.
+ */
+void create_memory_for_smartscan(void)
+{
+	int status;
+	int full_scans_begin;
+	int full_scans_end;
+	int pages_skipped_begin;
+	int pages_skipped_end;
+	int diff_pages;
+	int diff_scans;
+	unsigned long page_size;
+	char *memory;
+
+	/* Apply for the space for memory. */
+	page_size = sysconf(_SC_PAGE_SIZE);
+	memory = SAFE_MALLOC(page_size);
+
+	for (int i = 0; i < 1; i++) {
+		memory = SAFE_MMAP(NULL, page_size, PROT_READ|PROT_WRITE,
+			MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+#ifdef HAVE_DECL_MADV_MERGEABLE
+		if (madvise(memory, page_size, MADV_MERGEABLE) == -1)
+			tst_brk(TBROK|TERRNO, "madvise");
+#endif
+	}
+	memset(memory, 'a', page_size);
+
+	tst_res(TINFO, "KSM merging...");
+	if (access(PATH_KSM "max_page_sharing", F_OK) == 0) {
+		SAFE_FILE_PRINTF(PATH_KSM "run", "2");
+	}
+
+	/* Set defalut ksm scan values. */
+	SAFE_FILE_PRINTF(PATH_KSM "run", "1");
+	SAFE_FILE_PRINTF(PATH_KSM "pages_to_scan", "%ld", 100l);
+	SAFE_FILE_PRINTF(PATH_KSM "sleep_millisecs", "0");
+
+	/* Measure pages skipped aka "smart scan". */
+	SAFE_FILE_SCANF(PATH_KSM "full_scans", "%d", &full_scans_begin);
+	SAFE_FILE_SCANF(PATH_KSM "pages_skipped", "%d", &pages_skipped_begin);
+	wait_ksmd_full_scan();
+
+	tst_res(TINFO, "stop KSM.");
+	SAFE_FILE_PRINTF(PATH_KSM "run", "0");
+
+	SAFE_FILE_SCANF(PATH_KSM "full_scans", "%d", &full_scans_end);
+	SAFE_FILE_SCANF(PATH_KSM "pages_skipped", "%d", &pages_skipped_end);
+	diff_pages = pages_skipped_end - pages_skipped_begin;
+	diff_scans = full_scans_end - full_scans_begin;
+
+	if (diff_pages < diff_scans * 50 / 100) {
+		tst_res(TFAIL, "not enough pages have been skipped by smart_scan.");
+	} else {
+		tst_res(TPASS, "smart_scan skipped more than 50%% of the pages.");
+	}
+
+	while (waitpid(-1, &status, 0) > 0)
+		if (WEXITSTATUS(status) != 0)
+			tst_res(TFAIL, "child exit status is %d",
+					WEXITSTATUS(status));
+}
+
 void create_same_memory(int size, int num, int unit)
 {
 	int i, j, status, *child;
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
