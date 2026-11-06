Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D2C606A326
	for <ltp@archiver.kernel.org>; Fri,  6 Nov 2026 03:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=F5GW63v6
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 35E2A3CFD10
	for <ltp@archiver.kernel.org>; Fri,  6 Nov 2026 04:23:52 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 174A53CEF42
 for <ltp@lists.linux.it>; Fri,  6 Nov 2026 04:23:34 +0100 (CET)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0775D1A0048C
 for <ltp@lists.linux.it>; Fri,  6 Nov 2026 04:23:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=aE
 eK7oOUgTi47xxrsima/6dWGXY21ruP5kbAuAyH5ZU=; b=F5GW63v6usRDr1F7gM
 IcMrMM+pGGEq3kaQ6Dd4Re8E0wpgV13RzsoU2Tdg9v/ZKaBayMxNqHHTEFiOXGP/
 mQ154bg7zGWLkao0unYQni5T0HYG3XstqANDdVj1BLJfUV8K7gYmlA4RrNkgcstf
 UpdvXN/1P7cwy4SdRYpdzdbFg=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id
 _____wD3vzsdSO1qKPVzFw--.35620S2; 
 Fri, 06 Nov 2026 11:23:12 +0800 (CST)
From: Xuewen Wang <wangxuewen_ky@163.com>
To: ltp@lists.linux.it
Date: Fri,  6 Nov 2026 11:22:51 +0800
Message-Id: <20261106032251.62288-1-wangxuewen_ky@163.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID: _____wD3vzsdSO1qKPVzFw--.35620S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gw47Jr48KF4xZrWfKFy7trb_yoW3ZFWUpF
 s8W3WkArWqqFyxAa9xZFZ5CFyrCws5Z345K398u3Z3Jrs3Ar9rWrWkGrWjqF1UGrWxCryY
 9an8WFsak3yUXaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jkXo7UUUUU=
X-CM-SenderInfo: pzdqw5pxhzv0xbn1qiywtou0bp/xtbCzQEwGWrtSCEYAAAA3T
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] testcases: sysfs: Add sys_thp02
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Xuewen Wang <wangxuewen@kylinos.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Xuewen Wang <wangxuewen@kylinos.cn>

A test for the per-size mTHP attributes under
/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/. It iterates all
hugepages-<size>kB directories and checks the directory name structure,
the enabled/shmem_enabled choice files, the stats/ counters and that a
directory for the PMD-sized THP exists.

The set of mTHP attributes differs between kernel versions and
configurations, so missing attributes are skipped gracefully.

Tested on 6.6.160 (TCONF, no mTHP sizes) and 7.3.0-rc5, x86_64: 224/224
TPASS.

Signed-off-by: Xuewen Wang <wangxuewen@kylinos.cn>
---
Changes in v2 (addressing the AI review):

- Replace 'hugepages-*kB/' with 'hugepages-<size>kB/' in the doc comment
  and commit message to fix an unclosed reStructuredText emphasis
  start-string
- Move the TST_SYSFS_ASSERT_CHOICE() calls into the braced
  if (is_anon)/if (is_shmem) blocks and drop the duplicated bare
  if statements
- Reset found_pmd at the beginning of run() so it does not stay set
  across -i iterations

 runtest/sysfs                                 |   1 +
 .../kernel/mm/transparent_hugepage/.gitignore |   1 +
 .../mm/transparent_hugepage/sys_thp02.c       | 229 ++++++++++++++++++
 3 files changed, 231 insertions(+)
 create mode 100644 testcases/kernel/sysfs/kernel/mm/transparent_hugepage/sys_thp02.c

diff --git a/runtest/sysfs b/runtest/sysfs
index 5eb8f81f8..08763c21e 100644
--- a/runtest/sysfs
+++ b/runtest/sysfs
@@ -27,3 +27,4 @@ sys_hugepages02 sys_hugepages02
 sys_ksm01 sys_ksm01
 sys_mm_swap01 sys_mm_swap01
 sys_thp01 sys_thp01
+sys_thp02 sys_thp02
diff --git a/testcases/kernel/sysfs/kernel/mm/transparent_hugepage/.gitignore b/testcases/kernel/sysfs/kernel/mm/transparent_hugepage/.gitignore
index bdb564dfe..ede87c4c1 100644
--- a/testcases/kernel/sysfs/kernel/mm/transparent_hugepage/.gitignore
+++ b/testcases/kernel/sysfs/kernel/mm/transparent_hugepage/.gitignore
@@ -1 +1,2 @@
 /sys_thp01
+/sys_thp02
diff --git a/testcases/kernel/sysfs/kernel/mm/transparent_hugepage/sys_thp02.c b/testcases/kernel/sysfs/kernel/mm/transparent_hugepage/sys_thp02.c
new file mode 100644
index 000000000..530315565
--- /dev/null
+++ b/testcases/kernel/sysfs/kernel/mm/transparent_hugepage/sys_thp02.c
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Xuewen Wang <wangxuewen@kylinos.cn>
+ */
+
+/*\
+ * Sanity checks for the multi-size Transparent HugePage (mTHP) attributes
+ * exported under /sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/.
+ *
+ * Each THP size has its own hugepages-<size>kB directory with a per-size
+ * enabled flag and a stats/ subdirectory with a set of counters. For each
+ * such directory the test verifies that:
+ *
+ * - the size encoded in the directory name is a power of two, a power-of-two
+ *   multiple of the base page size, and strictly larger than the base page
+ *   size, or at least 4 pages for anonymous sizes
+ * - enabled selects one of always/inherit/madvise/never
+ * - shmem_enabled, if present, selects one of
+ *   always/inherit/within_size/advise/never
+ * - the stats counters are non-negative
+ * - nr_anon_partially_mapped is not larger than nr_anon
+ *
+ * After all directories are checked the test verifies that a directory for
+ * the PMD-sized THP exists, since the kernel always creates it.
+ *
+ * Attributes which are not present on the running kernel are skipped
+ * gracefully, since the set of mTHP stats differs between kernel versions
+ * and configurations (e.g. CONFIG_SHMEM).
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <dirent.h>
+#include <limits.h>
+#include "tst_test.h"
+#include "tst_sysfs_assert.h"
+#include "tst_path_defs.h"
+
+static const char *const enabled_allowed[] = {
+	"always", "inherit", "madvise", "never", NULL
+};
+
+static const char *const shmem_allowed[] = {
+	"always", "inherit", "within_size", "advise", "never", NULL
+};
+
+static const char *const any_stats[] = {
+	"split",
+	"split_failed",
+	"collapse_alloc",
+	"collapse_alloc_failed",
+	NULL
+};
+
+static const char *const anon_stats[] = {
+	"anon_fault_alloc",
+	"anon_fault_fallback",
+	"anon_fault_fallback_charge",
+	"split_deferred",
+	"nr_anon",
+	"nr_anon_partially_mapped",
+	"collapse_exceed_swap_pte",
+	"collapse_exceed_none_pte",
+	"collapse_exceed_shared_pte",
+	NULL
+};
+
+static const char *const swap_stats[] = {
+	"zswpout",
+	"swpin",
+	"swpin_fallback",
+	"swpin_fallback_charge",
+	"swpout",
+	"swpout_fallback",
+	NULL
+};
+
+static const char *const shmem_stats[] = {
+	"shmem_alloc",
+	"shmem_fallback",
+	"shmem_fallback_charge",
+	NULL
+};
+
+static long pagesize;
+static long pmd_kb;
+static int found_pmd;
+
+static void check_size(const char *dir, int is_anon)
+{
+	long size_kb, npages;
+
+	if (sscanf(dir, "hugepages-%ldkB", &size_kb) != 1) {
+		tst_res(TFAIL, "Malformed mTHP directory name '%s'", dir);
+		return;
+	}
+
+	if (size_kb <= 0 || size_kb & (size_kb - 1)) {
+		tst_res(TFAIL, "%s: size %ld kB is not a power of two", dir, size_kb);
+		return;
+	}
+
+	npages = size_kb * 1024 / pagesize;
+
+	if (npages < 2 || (npages & (npages - 1))) {
+		tst_res(TFAIL,
+			"%s: size %ld kB is not a power-of-two multiple of the page size",
+			dir, size_kb);
+		return;
+	}
+
+	if (is_anon && npages < 4) {
+		tst_res(TFAIL,
+			"%s: anonymous size %ld kB is smaller than 4 pages",
+			dir, size_kb);
+		return;
+	}
+
+	if (size_kb == pmd_kb)
+		found_pmd = 1;
+
+	tst_res(TPASS, "%s: size %ld kB is a valid mTHP size", dir, size_kb);
+}
+
+static void check_dir(const char *dir)
+{
+	size_t i;
+	int is_anon = tst_sysfs_exists(PATH_MM_THP "/%s/enabled", dir);
+	int is_shmem = tst_sysfs_exists(PATH_MM_THP "/%s/shmem_enabled", dir);
+
+	tst_res(TINFO, "Checking mTHP size '%s'", dir);
+
+	check_size(dir, is_anon);
+
+	for (i = 0; any_stats[i]; i++) {
+		TST_SYSFS_ASSERT_RANGEUU_SILENT(0, ULONG_MAX,
+						PATH_MM_THP "/%s/stats/%s",
+						dir, any_stats[i]);
+	}
+
+	if (is_anon) {
+		TST_SYSFS_ASSERT_CHOICE(enabled_allowed, NULL, 0,
+					PATH_MM_THP "/%s/enabled", dir);
+
+		for (i = 0; anon_stats[i]; i++) {
+			TST_SYSFS_ASSERT_RANGEUU_SILENT(0, ULONG_MAX,
+							PATH_MM_THP "/%s/stats/%s",
+							dir, anon_stats[i]);
+		}
+
+		TST_SYSFS_ASSERT_LE_SUFFIX_SILENT("/stats/nr_anon_partially_mapped",
+						  "/stats/nr_anon",
+						  PATH_MM_THP "/%s", dir);
+	}
+
+	if (is_shmem) {
+		TST_SYSFS_ASSERT_CHOICE(shmem_allowed, NULL, 0,
+					PATH_MM_THP "/%s/shmem_enabled", dir);
+
+		for (i = 0; shmem_stats[i]; i++) {
+			TST_SYSFS_ASSERT_RANGEUU_SILENT(0, ULONG_MAX,
+							PATH_MM_THP "/%s/stats/%s",
+							dir, shmem_stats[i]);
+		}
+	}
+
+	for (i = 0; swap_stats[i]; i++) {
+		TST_SYSFS_ASSERT_RANGEUU_SILENT(0, ULONG_MAX,
+						PATH_MM_THP "/%s/stats/%s",
+						dir, swap_stats[i]);
+	}
+}
+
+static void setup(void)
+{
+	long pmd_size;
+
+	pagesize = getpagesize();
+
+	if (access(PATH_MM_THP "/hpage_pmd_size", F_OK))
+		tst_brk(TCONF, PATH_MM_THP "/hpage_pmd_size does not exist");
+
+	pmd_size = TST_SYSFS_READ_LI(PATH_MM_THP "/hpage_pmd_size");
+
+	if (pmd_size <= 0 || pmd_size % 1024)
+		tst_brk(TCONF, "Unexpected hpage_pmd_size %ld", pmd_size);
+
+	pmd_kb = pmd_size / 1024;
+}
+
+static void run(void)
+{
+	DIR *d;
+	struct dirent *ent;
+	int found = 0;
+
+	found_pmd = 0;
+
+	d = TST_SYSFS_TRY_OPENDIR(PATH_MM_THP);
+
+	while ((ent = SAFE_READDIR(d))) {
+		if (strncmp(ent->d_name, "hugepages-", 10))
+			continue;
+
+		found = 1;
+		check_dir(ent->d_name);
+	}
+
+	SAFE_CLOSEDIR(d);
+
+	if (!found) {
+		tst_res(TCONF, "No mTHP sizes found");
+		return;
+	}
+
+	if (found_pmd)
+		tst_res(TPASS, "hugepages-%ldkB directory is present", pmd_kb);
+	else
+		tst_res(TFAIL, "hugepages-%ldkB directory is missing", pmd_kb);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.needs_kconfigs = (const char *const[]){
+		"CONFIG_TRANSPARENT_HUGEPAGE=y",
+		NULL
+	},
+};
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
