Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EA1606A31A
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 03:20:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 95B973EA3C9
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 04:20:02 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D4A513E60DD
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 04:19:43 +0100 (CET)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D54FA1400E1A
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 04:19:38 +0100 (CET)
X-UUID: b4e930f4d41011f19a56ed5b684f684d-20261030
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME,
 HR_CTE_8B
 HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
 HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
 HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
 HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_LOWREP, SRC_LOWREP
 SA_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS
 DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF
 GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:c61d0b93-2a09-4cc7-9054-64f83063c804, IP:10,
 URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:10
X-CID-INFO: VERSION:1.3.19, REQID:c61d0b93-2a09-4cc7-9054-64f83063c804, IP:10,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:10
X-CID-META: VersionHash:7db8b62, CLOUDID:6b5d795d3016754c8d2448ae2f4f755b,
 BulkI
 D:261030111929DT478PTQ,BulkQuantity:0,SF:17|19|38|66|78|102|127|850|865|89
 8,TC:nil,Content:0|15|50|99,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS
 :nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
 RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b4e930f4d41011f19a56ed5b684f684d-20261030
X-User: wangxuewen@kylinos.cn
Received: from localhost.localdomain [(114.244.3.119)] by mailgw.kylinos.cn
 (envelope-from <wangxuewen@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1180764828; Fri, 30 Oct 2026 11:19:24 +0800
From: Xuewen Wang <wangxuewen@kylinos.cn>
To: chrubis@suse.cz, pvorel@suse.cz, andrea.cervesato@suse.com,
 li.wang@linux.dev
Date: Fri, 30 Oct 2026 11:19:19 +0800
Message-Id: <20261030031919.3383729-1-wangxuewen@kylinos.cn>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] madvise13: Add test for MADV_COLLAPSE
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: wangxuewen_ky@163.com, Xuewen Wang <wangxuewen@kylinos.cn>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add a test verifying that MADV_COLLAPSE synchronously collapses
PMD-sized windows of base pages into PMD-mapped anonymous THPs,
covering the error paths (EINVAL, ENOMEM), the no-op ranges and the
clamping of a page-aligned but not PMD-aligned range.

khugepaged is quiesced for the duration of the run, as it can
legally collapse the THP-eligible windows before the test does.

Tested on x86_64 and arm64, THP sysfs mode always/madvise/never: 28/28 TPASS
on 6.6.160 and 7.3.0-rc3, including 12x -i 100 with khugepaged
scan_sleep_millisecs=1 and mTHP enabled.

Signed-off-by: Xuewen Wang <wangxuewen@kylinos.cn>
---
 include/lapi/mmap.h                           |   4 +
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/madvise/.gitignore  |   1 +
 testcases/kernel/syscalls/madvise/madvise13.c | 376 ++++++++++++++++++
 4 files changed, 382 insertions(+)
 create mode 100644 testcases/kernel/syscalls/madvise/madvise13.c

diff --git a/include/lapi/mmap.h b/include/lapi/mmap.h
index f20eb3bd5..d0373d898 100644
--- a/include/lapi/mmap.h
+++ b/include/lapi/mmap.h
@@ -87,6 +87,10 @@
 # define MADV_PAGEOUT	21
 #endif
 
+#ifndef MADV_COLLAPSE
+# define MADV_COLLAPSE	25
+#endif
+
 #ifndef MAP_DROPPABLE
 # define MAP_DROPPABLE 0x08
 #endif
diff --git a/runtest/syscalls b/runtest/syscalls
index 4d3f53ecd..7e255c3bd 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1094,6 +1094,7 @@ madvise09 madvise09
 madvise10 madvise10
 madvise11 madvise11
 madvise12 madvise12
+madvise13 madvise13
 
 newuname01 newuname01
 
diff --git a/testcases/kernel/syscalls/madvise/.gitignore b/testcases/kernel/syscalls/madvise/.gitignore
index 758e601a9..3e7dbe653 100644
--- a/testcases/kernel/syscalls/madvise/.gitignore
+++ b/testcases/kernel/syscalls/madvise/.gitignore
@@ -9,3 +9,4 @@
 /madvise10
 /madvise11
 /madvise12
+/madvise13
diff --git a/testcases/kernel/syscalls/madvise/madvise13.c b/testcases/kernel/syscalls/madvise/madvise13.c
new file mode 100644
index 000000000..34159f922
--- /dev/null
+++ b/testcases/kernel/syscalls/madvise/madvise13.c
@@ -0,0 +1,376 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Xuewen Wang <wangxuewen@kylinos.cn>
+ */
+
+/*\
+ * Verify that MADV_COLLAPSE synchronously collapses a PMD-sized window of
+ * base pages into a PMD-mapped anonymous transparent hugepage.
+ *
+ * This is a test for feature implemented in
+ * 7d8faaf15545 ("mm/madvise: introduce MADV_COLLAPSE sync hugepage collapse")
+ *
+ * MADV_COLLAPSE ignores the system-wide THP sysfs mode and, unlike
+ * khugepaged, the max_ptes_none/max_ptes_swap limits.
+ *
+ * khugepaged is quiesced for the duration of the run, as it can legally
+ * collapse the THP-eligible windows before the test collapses them.
+ *
+ * [Algorithm]
+ *
+ * - carve PMD-aligned windows out of anonymous mappings
+ * - populate a window with base pages under MADV_NOHUGEPAGE (so that page
+ *   faults cannot install THPs upfront), verify that no THP is present
+ *   yet, then collapse it and verify the AnonHugePages counter in
+ *   /proc/self/smaps and the page contents
+ * - collapse the same window again (idempotency)
+ * - collapse a window with a single populated page and verify the page
+ *   content and the zero-fill of the unpopulated pages
+ * - verify the error paths (MADV_NOHUGEPAGE, untouched window, unmapped
+ *   page) and the no-op ranges (shorter than one PMD window, zero length)
+ * - verify that a page-aligned but not PMD-aligned start is clamped to
+ *   whole PMD windows instead of being rejected
+ * - discard the windows with MADV_DONTNEED at the start of each run, so
+ *   the test is safe to run repeatedly (-i)
+ */
+
+#define _GNU_SOURCE
+
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
+#include "tst_sysfs_assert.h"
+#include "tst_path_defs.h"
+#include "tst_memutils.h"
+#include "lapi/mmap.h"
+
+#define HPAGE_PMD_SYSFS PATH_MM_THP "/hpage_pmd_size"
+
+#define WIN_FULL    0
+#define WIN_PARTIAL 1
+#define WIN_NOHUGEP 2
+#define WIN_EMPTY   3
+
+static char *windows[4];
+static char *bases[4];
+static char *clamp_base;
+static char *clamp_first;
+static char *clamp_second;
+static size_t pmd_size;
+static unsigned long pmd_kb;
+static size_t page_size;
+
+/*
+ * Returns the AnonHugePages counter [kB] of the VMA which contains addr,
+ * or -1 if no such VMA exists or the smaps entry has no AnonHugePages
+ * field.  The bounds of the VMA are reported through vstart/vend.
+ */
+static long smaps_anon_huge(const void *addr, unsigned long *vstart,
+			    unsigned long *vend)
+{
+	FILE *f = SAFE_FOPEN("/proc/self/smaps", "r");
+	char line[512];
+	unsigned long start, end, val = 0;
+	int in_vma = 0, seen = 0;
+
+	while (fgets(line, sizeof(line), f)) {
+		if (sscanf(line, "%lx-%lx", &start, &end) == 2) {
+			if (in_vma)
+				break;
+			in_vma = (unsigned long)addr >= start &&
+				 (unsigned long)addr < end;
+			if (in_vma) {
+				*vstart = start;
+				*vend = end;
+			}
+			continue;
+		}
+
+		if (in_vma && sscanf(line, "AnonHugePages: %lu", &val) == 1) {
+			seen = 1;
+			break;
+		}
+	}
+
+	SAFE_FCLOSE(f);
+
+	if (!in_vma || !seen)
+		return -1;
+
+	return (long)val;
+}
+
+static void check_anon_huge(const char *desc, const void *addr,
+			    unsigned long expected)
+{
+	unsigned long vstart, vend;
+	long ahp = smaps_anon_huge(addr, &vstart, &vend);
+
+	if (ahp < 0) {
+		tst_res(TFAIL, "%s: no VMA/AnonHugePages entry for %p in smaps",
+			desc, addr);
+		return;
+	}
+
+	/*
+	 * The checked window must be an isolated VMA, otherwise the
+	 * AnonHugePages counter covers more than the window itself.
+	 */
+	if (vstart != (unsigned long)addr || vend - vstart != pmd_size)
+		tst_brk(TBROK, "%s: VMA %lx-%lx is not the isolated window %p",
+			desc, vstart, vend, addr);
+
+	if ((unsigned long)ahp == expected)
+		tst_res(TPASS, "%s: AnonHugePages %lu kB as expected", desc, expected);
+	else
+		tst_res(TFAIL, "%s: AnonHugePages %ld kB, expected %lu kB",
+			desc, ahp, expected);
+}
+
+static void populate_base(void *addr, size_t len, char c)
+{
+	TST_EXP_PASS(madvise(addr, pmd_size, MADV_NOHUGEPAGE));
+	memset(addr, c, len);
+	TST_EXP_PASS(madvise(addr, pmd_size, MADV_HUGEPAGE));
+}
+
+static char pattern_byte(size_t i)
+{
+	return (char)(i ^ (i >> 12));
+}
+
+static void fill_pattern(void *addr, size_t len)
+{
+	size_t i;
+
+	for (i = 0; i < len; i++)
+		((char *)addr)[i] = pattern_byte(i);
+}
+
+static void verify_pattern(const char *desc, void *addr, size_t len)
+{
+	size_t i, bad = 0, first = 0;
+
+	for (i = 0; i < len; i++) {
+		if (((char *)addr)[i] != pattern_byte(i)) {
+			if (!bad)
+				first = i;
+			bad++;
+		}
+	}
+
+	if (!bad) {
+		tst_res(TPASS, "%s: page contents preserved (%zu bytes)", desc, len);
+		return;
+	}
+
+	tst_res(TFAIL, "%s: %zu of %zu bytes corrupted, first at offset %zu",
+		desc, bad, len, first);
+}
+
+static void verify_zero(const char *desc, void *addr, size_t from, size_t len)
+{
+	size_t i;
+
+	for (i = from; i < from + len; i++) {
+		if (((char *)addr)[i]) {
+			tst_res(TFAIL, "%s: byte %zu is %d, expected zero fill",
+				desc, i, ((char *)addr)[i]);
+			return;
+		}
+	}
+
+	tst_res(TPASS, "%s: %zu bytes zero-filled as expected", desc, len);
+}
+
+static void setup(void)
+{
+	int i;
+
+	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
+
+	if (access(HPAGE_PMD_SYSFS, F_OK))
+		tst_brk(TCONF, "transparent hugepages not exposed (%s)",
+			HPAGE_PMD_SYSFS);
+
+	pmd_size = TST_SYSFS_READ_LI(HPAGE_PMD_SYSFS);
+	if (pmd_size < 2 * page_size || pmd_size % page_size)
+		tst_brk(TCONF, "unexpected PMD THP size %zu", pmd_size);
+
+	pmd_kb = pmd_size >> 10;
+	tst_res(TINFO, "PMD THP size: %zu kB", pmd_size >> 10);
+
+	/*
+	 * The static .min_mem_avail covers the usual 2 MB PMD size, this
+	 * runtime check additionally skips machines which could not hold
+	 * the test windows on architectures with larger PMD sizes.
+	 */
+	if (8 * pmd_size > (size_t)tst_available_mem() * 1024)
+		tst_brk(TCONF, "not enough free memory (PMD THP size %zu kB)",
+			pmd_size >> 10);
+
+	for (i = 0; i < 4; i++) {
+		bases[i] = SAFE_MMAP(NULL, 2 * pmd_size, PROT_READ | PROT_WRITE,
+				     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+		windows[i] = (char *)(((unsigned long)bases[i] + pmd_size - 1) &
+				      ~((unsigned long)pmd_size - 1));
+	}
+
+	/*
+	 * Dedicated 4*pmd mapping for the clamp checks: ranges starting one
+	 * page inside the first window provably stay within the mapping
+	 * regardless of where the mmap() base landed, so the result cannot
+	 * turn into an unmapped-gap ENOMEM.
+	 */
+	clamp_base = SAFE_MMAP(NULL, 4 * pmd_size, PROT_READ | PROT_WRITE,
+				MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	clamp_first = (char *)(((unsigned long)clamp_base + pmd_size - 1) &
+			       ~((unsigned long)pmd_size - 1));
+	clamp_second = clamp_first + pmd_size;
+}
+
+static void run(void)
+{
+	int i;
+
+	/*
+	 * Zap any THP and pages left over from a previous iteration, as
+	 * MADV_NOHUGEPAGE in populate_base() only flips VMA flags and does
+	 * not split an already PMD-mapped THP.
+	 */
+	for (i = 0; i < 4; i++) {
+		if (madvise(windows[i], pmd_size, MADV_DONTNEED))
+			tst_brk(TBROK | TERRNO,
+				"MADV_DONTNEED failed for window %d", i);
+	}
+
+	if (madvise(clamp_base, 4 * pmd_size, MADV_DONTNEED))
+		tst_brk(TBROK | TERRNO, "MADV_DONTNEED failed for clamp mapping");
+
+	/* fully populated window is collapsed into a single THP */
+	TST_EXP_PASS(madvise(windows[WIN_FULL], pmd_size, MADV_NOHUGEPAGE));
+	fill_pattern(windows[WIN_FULL], pmd_size);
+	/*
+	 * Check the baseline while MADV_NOHUGEPAGE still blocks khugepaged
+	 * from legally collapsing the fully populated window.
+	 */
+	check_anon_huge("base-page populated window before collapse",
+			windows[WIN_FULL], 0);
+	TST_EXP_PASS(madvise(windows[WIN_FULL], pmd_size, MADV_HUGEPAGE));
+
+	TST_EXP_PASS(madvise(windows[WIN_FULL], pmd_size, MADV_COLLAPSE));
+	check_anon_huge("window after MADV_COLLAPSE", windows[WIN_FULL], pmd_kb);
+	verify_pattern("window after MADV_COLLAPSE", windows[WIN_FULL], pmd_size);
+
+	/* collapsing an already PMD-mapped window is a no-op */
+	TST_EXP_PASS(madvise(windows[WIN_FULL], pmd_size, MADV_COLLAPSE));
+	check_anon_huge("window after repeated MADV_COLLAPSE", windows[WIN_FULL], pmd_kb);
+
+	/* window with a single resident page is collapsed as well */
+	populate_base(windows[WIN_PARTIAL], page_size, 'b');
+
+	TST_EXP_PASS(madvise(windows[WIN_PARTIAL], pmd_size, MADV_COLLAPSE));
+	check_anon_huge("partially populated window after MADV_COLLAPSE",
+			windows[WIN_PARTIAL], pmd_kb);
+
+	if (windows[WIN_PARTIAL][0] == 'b')
+		tst_res(TPASS, "page content preserved after collapse");
+	else
+		tst_res(TFAIL, "page content corrupted after collapse");
+
+	verify_zero("unpopulated pages zero-filled by collapse",
+		    windows[WIN_PARTIAL], page_size, pmd_size - page_size);
+
+	/* MADV_NOHUGEPAGE blocks the collapse */
+	TST_EXP_PASS(madvise(windows[WIN_NOHUGEP], pmd_size, MADV_NOHUGEPAGE));
+	memset(windows[WIN_NOHUGEP], 'c', pmd_size);
+
+	TST_EXP_FAIL(madvise(windows[WIN_NOHUGEP], pmd_size, MADV_COLLAPSE), EINVAL);
+	check_anon_huge("MADV_NOHUGEPAGE window after MADV_COLLAPSE",
+			windows[WIN_NOHUGEP], 0);
+
+	/* window without any resident page cannot be collapsed */
+	TST_EXP_FAIL(madvise(windows[WIN_EMPTY], pmd_size, MADV_COLLAPSE), EINVAL);
+
+	/*
+	 * Unmapped range: drop one page from the untouched mapping slack,
+	 * a standalone hole could be reused by the allocator.
+	 */
+	SAFE_MUNMAP(windows[WIN_EMPTY] + pmd_size, page_size);
+	TST_EXP_FAIL(madvise(windows[WIN_EMPTY] + pmd_size, page_size,
+			     MADV_COLLAPSE), ENOMEM);
+
+	/* range shorter than one PMD window is clamped into a no-op */
+	TST_EXP_PASS(madvise(windows[WIN_FULL], page_size, MADV_COLLAPSE));
+
+	/* zero-length range is a no-op */
+	TST_EXP_PASS(madvise(windows[WIN_FULL], 0, MADV_COLLAPSE));
+
+	/*
+	 * A page-aligned start which is not PMD-aligned is clamped to whole
+	 * PMD windows instead of being rejected.  Touch one page in the first
+	 * and third window first: the touch splits each window into a VMA of
+	 * its own, as smaps counts AnonHugePages per VMA and an untouched
+	 * window would share its VMA with the mapping slack.  It also
+	 * initializes the VMA's anon_vma, without which hugepage_vma_check()
+	 * rejects the whole call with EINVAL, even for a range which clamps
+	 * to an empty set.
+	 */
+	madvise(clamp_first, pmd_size, MADV_NOHUGEPAGE);
+	memset(clamp_first, 'e', page_size);
+	madvise(clamp_first, pmd_size, MADV_HUGEPAGE);
+
+	populate_base(clamp_second, pmd_size, 'd');
+
+	madvise(clamp_second + pmd_size, pmd_size, MADV_NOHUGEPAGE);
+	memset(clamp_second + pmd_size, 'f', page_size);
+	madvise(clamp_second + pmd_size, pmd_size, MADV_HUGEPAGE);
+
+	/* the range clamps to an empty set: nothing is collapsed */
+	TST_EXP_PASS(madvise(clamp_first + page_size, pmd_size, MADV_COLLAPSE));
+	check_anon_huge("range clamped to an empty set", clamp_second, 0);
+
+	/*
+	 * Only the fully covered second window is collapsed, the partial
+	 * first window is skipped by the clamp.
+	 */
+	TST_EXP_PASS(madvise(clamp_first + page_size, 2 * pmd_size, MADV_COLLAPSE));
+	check_anon_huge("window collapsed after clamping", clamp_second, pmd_kb);
+	check_anon_huge("partial window skipped by clamping", clamp_first, 0);
+}
+
+static void cleanup(void)
+{
+	int i;
+
+	for (i = 0; i < 4; i++) {
+		if (bases[i])
+			SAFE_MUNMAP(bases[i], 2 * pmd_size);
+	}
+
+	if (clamp_base)
+		SAFE_MUNMAP(clamp_base, 4 * pmd_size);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.min_kver = "6.1",
+	.min_mem_avail = 16,
+	.needs_root = 1,
+	.save_restore = (const struct tst_path_val[]) {
+		{PATH_MM_THP "/khugepaged/scan_sleep_millisecs", "30000"},
+		{}
+	},
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_TRANSPARENT_HUGEPAGE=y",
+		NULL
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "7d8faaf155454f8798ec56404faca29a82689c77"},
+		{}
+	},
+};
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
