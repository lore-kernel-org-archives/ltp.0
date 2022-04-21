Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2451C433EF
	for <ltp@archiver.kernel.org>; Thu, 21 Apr 2022 12:34:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A43903CA6EC
	for <ltp@archiver.kernel.org>; Thu, 21 Apr 2022 14:34:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F30D3C6934
 for <ltp@lists.linux.it>; Thu, 21 Apr 2022 14:33:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DC44C200B63
 for <ltp@lists.linux.it>; Thu, 21 Apr 2022 14:33:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 31E2921115
 for <ltp@lists.linux.it>; Thu, 21 Apr 2022 12:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1650544432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fdV+rKy0GK0w9NEpNCvtqnVvbITLK7bfgyliXUIr6Xc=;
 b=R172fG9MK57FAwKelDsSo2SBEqBjlqPkE+B+kCsLEQ/h3Zo1Ff6sG84HxwK3DNtnFuxlxL
 uAhTDpJgwGevjb4QhkbFuy+BU60VCW4a1yX7jMA7vK68xpwtTz+kt/74K0wZJx4FDkszaG
 bu4GSvVfU62kl2hP5ormCwFHarRcdyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1650544432;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fdV+rKy0GK0w9NEpNCvtqnVvbITLK7bfgyliXUIr6Xc=;
 b=taVP7AQJPFgkFFuTePFfVIHV+psWFQlg/QrnXWSVf/pDjQEwbiHn+4c316SmfYlD8HmYQB
 C+0lxuHg8/6BqCCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1EE9713AAE
 for <ltp@lists.linux.it>; Thu, 21 Apr 2022 12:33:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id yFG8BjBPYWL/GgAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 21 Apr 2022 12:33:52 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 21 Apr 2022 14:33:51 +0200
Message-Id: <20220421123351.17645-3-mdoucha@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220421123351.17645-1-mdoucha@suse.cz>
References: <20220421123351.17645-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] Add test for CVE 2021-38198
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

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1:
- Updated .save_restore metadata to the new structure
- Use tst_parse_int() instead of sscanf()

Changes since v2: None

 runtest/kvm                            |   1 +
 testcases/kernel/kvm/.gitignore        |   1 +
 testcases/kernel/kvm/kvm_pagefault01.c | 234 +++++++++++++++++++++++++
 3 files changed, 236 insertions(+)
 create mode 100644 runtest/kvm
 create mode 100644 testcases/kernel/kvm/.gitignore
 create mode 100644 testcases/kernel/kvm/kvm_pagefault01.c

diff --git a/runtest/kvm b/runtest/kvm
new file mode 100644
index 000000000..16e7c07ff
--- /dev/null
+++ b/runtest/kvm
@@ -0,0 +1 @@
+kvm_pagefault01 kvm_pagefault01
diff --git a/testcases/kernel/kvm/.gitignore b/testcases/kernel/kvm/.gitignore
new file mode 100644
index 000000000..349260359
--- /dev/null
+++ b/testcases/kernel/kvm/.gitignore
@@ -0,0 +1 @@
+/kvm_pagefault01
diff --git a/testcases/kernel/kvm/kvm_pagefault01.c b/testcases/kernel/kvm/kvm_pagefault01.c
new file mode 100644
index 000000000..e355fa448
--- /dev/null
+++ b/testcases/kernel/kvm/kvm_pagefault01.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020 SUSE LLC
+ * Author: Nicolai Stange <nstange@suse.de>
+ * LTP port: Martin Doucha <mdoucha@suse.cz>
+ */
+
+/*\
+ * CVE 2021-38198
+ *
+ * Check that x86_64 KVM correctly enforces (lack of) write permissions
+ * in 4-level and 5-level memory page table mode. Missing page faults fixed in:
+ *
+ *  commit b1bd5cba3306691c771d558e94baa73e8b0b96b7
+ *  Author: Lai Jiangshan <laijs@linux.alibaba.com>
+ *  Date:   Thu Jun 3 13:24:55 2021 +0800
+ *
+ *  KVM: X86: MMU: Use the correct inherited permissions to get shadow page
+ */
+
+#include "kvm_test.h"
+
+#ifdef COMPILE_PAYLOAD
+#ifdef __x86_64__
+
+#include "kvm_x86.h"
+
+#define PTE_BITMASK 0x1ff
+#define PAGESIZE 0x1000
+
+int handle_page_fault(void *userdata, struct kvm_interrupt_frame *ifrm,
+	unsigned long errcode)
+{
+	struct kvm_cregs buf;
+
+	kvm_read_cregs(&buf);
+
+	/* Check that the page fault was caused by write to *readonly below */
+	if (buf.cr2 == (uintptr_t)userdata) {
+		tst_res(TPASS, "KVM enforces memory write permissions");
+		kvm_exit();
+	}
+
+	/* Unexpected page fault, fall back to default handler */
+	return 0;
+}
+
+void main(void)
+{
+	uintptr_t tmp;
+	struct page_table_entry_pae *subpte, *pte = kvm_pagetable;
+	int val, *writable, *readonly, *cacher1, *cacher2;
+
+	if (!(kvm_rdmsr(MSR_EFER) & EFER_LMA))
+		tst_brk(TBROK, "Bootstrap did not enable 64bit paging");
+
+	/*
+	 * Find the first page table entry which branches. This entry was
+	 * configured by bootstrap as follows:
+	 * 0x00000000 - 0x3fffffff in pte[0] (identity mapped)
+	 * 0x40000000 - 0x7fffffff in pte[1] (identity mapped)
+	 * 0x80000000 - 0xbfffffff in pte[2] (unmapped)
+	 * 0xc0000000 - 0xffffffff in pte[3] (only last page identity mapped)
+	 */
+	while (!pte[1].present) {
+		tmp = kvm_get_page_address_pae(pte);
+		pte = (struct page_table_entry_pae *)tmp;
+	}
+
+	/*
+	 * Setup mapping above the 32bit address space. The test needs two
+	 * different unused 1GB chunks of address space. Remapping part of
+	 * the lower 4GB address space would make it harder to reproduce
+	 * the bug because any memory access in the same 1GB chunk (even
+	 * fetching instructions by the CPU) could evict entries from page
+	 * table cache and force the bypassable write permission check
+	 * to happen even on buggy kernels.
+	 *
+	 * Allocate 3 pages for page table + 2 pages for data
+	 */
+	writable = tst_heap_alloc_aligned(5 * PAGESIZE, PAGESIZE);
+	memset(writable, 0, 5 * PAGESIZE);
+	tmp = (uintptr_t)writable;
+	pte[4].address = tmp >> 12;
+	pte[4].user_access = 1;
+	pte[4].writable = 1;
+	pte[4].present = 1;
+	pte[5] = pte[4];
+	pte[5].writable = 0;
+
+	subpte = (struct page_table_entry_pae *)tmp;
+	subpte[0].address = (tmp + PAGESIZE) >> 12;
+	subpte[0].user_access = 1;
+	subpte[0].writable = 0;
+	subpte[0].present = 1;
+	subpte[1].address = (tmp + 2 * PAGESIZE) >> 12;
+	subpte[1].user_access = 1;
+	subpte[1].writable = 1;
+	subpte[1].present = 1;
+
+	subpte = (struct page_table_entry_pae *)(tmp + PAGESIZE);
+	subpte[0].address = (tmp + 3 * PAGESIZE) >> 12;
+	subpte[0].user_access = 1;
+	subpte[0].writable = 1;
+	subpte[0].present = 1;
+
+	subpte = (struct page_table_entry_pae *)(tmp + 2 * PAGESIZE);
+	subpte[0].address = (tmp + 4 * PAGESIZE) >> 12;
+	subpte[0].user_access = 1;
+	subpte[0].writable = 1;
+	subpte[0].present = 1;
+
+	/* Create pointers into the new mapping */
+	cacher1 = (int *)0x100000000ULL;
+	writable = (int *)0x100200000ULL;
+	cacher2 = (int *)0x140000000ULL;
+	readonly = (int *)0x140200000ULL;
+	tst_set_interrupt_callback(INTR_PAGE_FAULT, handle_page_fault,
+		readonly);
+
+	/* Fill page table cache */
+	val = *cacher1;
+	*writable = val;
+	val = *cacher2;
+
+	/* Trigger page fault (unless the kernel is vulnerable) */
+	*readonly = val;
+
+	/* This line should be unreachable */
+	tst_res(TFAIL, "Write to read-only address did not page fault");
+}
+
+#else /* __x86_64__ */
+TST_TEST_TCONF("Test supported only on x86_64");
+#endif /* __x86_64__ */
+
+#else /* COMPILE_PAYLOAD */
+
+#include <ctype.h>
+#include <stdio.h>
+#include <unistd.h>
+#include "tst_module.h"
+
+#define TDP_MMU_SYSFILE "/sys/module/kvm/parameters/tdp_mmu"
+#define TDP_AMD_SYSFILE "/sys/module/kvm_amd/parameters/npt"
+#define TDP_INTEL_SYSFILE "/sys/module/kvm_intel/parameters/ept"
+
+#define BUF_SIZE 64
+
+static int read_bool_sys_param(const char *filename)
+{
+	char buf[BUF_SIZE];
+	int i, fd, ret;
+
+	fd = open(filename, O_RDONLY);
+
+	if (fd < 0)
+		return -1;
+
+	ret = read(fd, buf, BUF_SIZE - 1);
+	SAFE_CLOSE(fd);
+
+	if (ret < 1)
+		return -1;
+
+	buf[ret] = '\0';
+
+	for (i = 0; buf[i] && !isspace(buf[i]); i++)
+		;
+
+	buf[i] = '\0';
+
+	if (isdigit(buf[0])) {
+		tst_parse_int(buf, &ret, INT_MIN, INT_MAX);
+		return ret;
+	}
+
+	if (!strcasecmp(buf, "N"))
+		return 0;
+
+	/* Assume that any other value than 0 or N means the param is enabled */
+	return 1;
+}
+
+static void reload_module(const char *module, char *arg)
+{
+	const char *const argv[] = {"modprobe", module, arg, NULL};
+
+	tst_res(TINFO, "Reloading module %s with parameter %s", module, arg);
+	tst_module_unload(module);
+	tst_cmd(argv, NULL, NULL, 0);
+}
+
+static void disable_tdp(void)
+{
+	if (!access(TDP_MMU_SYSFILE, F_OK)) {
+		/* FIXME: Is setting tdp_mmu=0 sufficient to disable TDP? */
+		return;
+	}
+
+	if (read_bool_sys_param(TDP_AMD_SYSFILE) > 0)
+		reload_module("kvm_amd", "npt=0");
+
+	if (read_bool_sys_param(TDP_INTEL_SYSFILE) > 0)
+		reload_module("kvm_intel", "ept=0");
+}
+
+static void setup(void)
+{
+	disable_tdp();
+	tst_kvm_setup();
+}
+
+static struct tst_test test = {
+	.test_all = tst_kvm_run,
+	.setup = setup,
+	.cleanup = tst_kvm_cleanup,
+	.needs_root = 1,
+	.save_restore = (const struct tst_path_val[]) {
+		{"?/sys/module/kvm/parameters/tdp_mmu", "0"},
+		{}
+	},
+	.supported_archs = (const char *const []) {
+		"x86_64",
+		NULL
+	},
+	.tags = (struct tst_tag[]){
+		{"linux-git", "b1bd5cba3306"},
+		{"CVE", "2021-38198"},
+		{}
+	}
+};
+
+#endif /* COMPILE_PAYLOAD */
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
