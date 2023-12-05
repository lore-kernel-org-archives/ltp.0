Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A684CC4167B
	for <ltp@archiver.kernel.org>; Tue,  5 Dec 2023 18:10:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4057C3CC1DB
	for <ltp@archiver.kernel.org>; Tue,  5 Dec 2023 19:10:33 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F8A93CC0A4
 for <ltp@lists.linux.it>; Tue,  5 Dec 2023 19:10:10 +0100 (CET)
Received: from 66-220-144-178.mail-mxout.facebook.com
 (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EEEF714002D3
 for <ltp@lists.linux.it>; Tue,  5 Dec 2023 19:10:09 +0100 (CET)
Received: by devbig1114.prn1.facebook.com (Postfix, from userid 425415)
 id BAE501067A2F2; Tue,  5 Dec 2023 10:09:54 -0800 (PST)
From: Stefan Roesch <shr@devkernel.io>
To: kernel-team@fb.com
Date: Tue,  5 Dec 2023 10:09:52 -0800
Message-Id: <20231205180952.3843711-3-shr@devkernel.io>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231205180952.3843711-1-shr@devkernel.io>
References: <20231205180952.3843711-1-shr@devkernel.io>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/2] add ksm test for smart-scan feature
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
 runtest/mm                       |   1 +
 testcases/kernel/mem/.gitignore  |   1 +
 testcases/kernel/mem/ksm/ksm07.c | 113 +++++++++++++++++++++++++++++++
 3 files changed, 115 insertions(+)
 create mode 100644 testcases/kernel/mem/ksm/ksm07.c

diff --git a/runtest/mm b/runtest/mm
index f288fed36..d859b331c 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -70,6 +70,7 @@ ksm05 ksm05 -I 10
 ksm06 ksm06
 ksm06_1 ksm06 -n 10
 ksm06_2 ksm06 -n 8000
+ksm07 ksm07
 
 cpuset01 cpuset01
 
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
diff --git a/testcases/kernel/mem/ksm/ksm07.c b/testcases/kernel/mem/ksm/ksm07.c
new file mode 100644
index 000000000..1ae5e9cd8
--- /dev/null
+++ b/testcases/kernel/mem/ksm/ksm07.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2010-2023  Red Hat, Inc.
+ */
+/*\
+ * [Description]
+ *
+ * Kernel Samepage Merging (KSM) for smart scan feature
+ *
+ * Test allocates a page and fills it with 'a' characters. It captures the
+ * pages_skipped counter, waits for a few  iterations and captures the
+ * pages_skipped counter again. The expectation  is that over 50% of the page
+ * scans are skipped. (There is only one page that has KSM enabled and it gets
+ * scanned during each iteration and it cannot be de-duplicated.)
+ *
+ * Smart scan feature was added in kernel v6.7.
+ *
+ * [Prerequisites]
+ *
+ * ksm and ksmtuned daemons need to be disabled. Otherwise, it could
+ * distrub the testing as they also change some ksm tunables depends
+ * on current workloads.
+ */
+#include <sys/wait.h>
+#include "mem.h"
+
+/* This test allocates one page, fills the page with a's, captures the
+ * full_scan and pages_skipped counters. Then it makes sure at least 3
+ * full scans have been performed and measures the above counters again.
+ * The expectation is that at least 50% of the pages are skipped.
+ *
+ * To wait for at least 3 scans it uses the wait_ksmd_full_scan() function. In
+ * reality, it will be a lot more scans as the wait_ksmd_full_scan() function
+ * sleeps for one second.
+ */
+static void verify_ksm(void)
+{
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
+	memory = SAFE_MMAP(NULL, page_size, PROT_READ|PROT_WRITE,
+					   MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+#ifdef HAVE_DECL_MADV_MERGEABLE
+	if (madvise(memory, page_size, MADV_MERGEABLE) == -1)
+		tst_brk(TBROK|TERRNO, "madvise");
+#endif
+	memset(memory, 'a', page_size);
+
+	tst_res(TINFO, "KSM merging");
+
+	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
+		SAFE_FILE_PRINTF(PATH_KSM "run", "2");
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
+	tst_res(TINFO, "stop KSM");
+	SAFE_FILE_PRINTF(PATH_KSM "run", "0");
+
+	SAFE_FILE_SCANF(PATH_KSM "full_scans", "%d", &full_scans_end);
+	SAFE_FILE_SCANF(PATH_KSM "pages_skipped", "%d", &pages_skipped_end);
+	diff_pages = pages_skipped_end - pages_skipped_begin;
+	diff_scans = full_scans_end - full_scans_begin;
+
+	if (diff_pages < diff_scans * 50 / 100) {
+		tst_res(TINFO, "number of pages %d", diff_pages);
+		tst_res(TINFO, "number of scans %d", diff_scans);
+		tst_res(TFAIL, "not enough pages have been skipped by smart_scan.");
+	} else {
+		tst_res(TPASS, "smart_scan skipped more than 50%% of the pages.");
+	}
+
+#ifdef HAVE_DECL_MADV_MERGEABLE
+	if (madvise(memory, page_size, MADV_UNMERGEABLE) == -1)
+		tst_brk(TBROK|TERRNO, "madvise");
+#endif
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.options = (struct tst_option[]) {
+		{}
+	},
+	.save_restore = (const struct tst_path_val[]) {
+		{PATH_KSM "pages_skipped", NULL, TST_SR_TCONF},
+		{PATH_KSM "run", NULL, TST_SR_TCONF},
+		{PATH_KSM "sleep_millisecs", NULL, TST_SR_TCONF},
+		{PATH_KSM "smart_scan", "1",
+			TST_SR_SKIP_MISSING | TST_SR_TCONF},
+		{}
+	},
+	.needs_kconfigs = (const char *const[]){
+		"CONFIG_KSM=y",
+		NULL
+	},
+	.test_all = verify_ksm,
+};
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
