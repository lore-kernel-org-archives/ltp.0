Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA43C36010
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 14:25:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A3C583CB16B
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 16:25:55 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5091C3CB194
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 16:24:16 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AA1C41400980
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 16:24:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 171831F394
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 14:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744035840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mjbZwQaA4k/GmhbUu7cmNgdja2RAZaLIorz0HUmnSlY=;
 b=h3L77l1AufM6SRdGgSxhk2FNCryaVRVyg3FKH0mowsceNU/36Vgduw+qNN3bRe1lcwPKHJ
 S7EO5eXrFVKKw37cMrGYlicBMubzzoFVyUsvcDhANbKwdhBfcL1NI1WzavTL2ztQCwhKdi
 uK7MBjyh1FP3LTmv/SIIhOTwa4zVJy8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744035840;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mjbZwQaA4k/GmhbUu7cmNgdja2RAZaLIorz0HUmnSlY=;
 b=9UQ/HLuteT7GGQ9KBeXqgVKcd7tuX2nCM55bfSlYCBrf89bTuzSDqPx6KZRD6KvCu3QSTm
 JL5IFyvDfs/twjBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=h3L77l1A;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="9UQ/HLut"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744035840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mjbZwQaA4k/GmhbUu7cmNgdja2RAZaLIorz0HUmnSlY=;
 b=h3L77l1AufM6SRdGgSxhk2FNCryaVRVyg3FKH0mowsceNU/36Vgduw+qNN3bRe1lcwPKHJ
 S7EO5eXrFVKKw37cMrGYlicBMubzzoFVyUsvcDhANbKwdhBfcL1NI1WzavTL2ztQCwhKdi
 uK7MBjyh1FP3LTmv/SIIhOTwa4zVJy8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744035840;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mjbZwQaA4k/GmhbUu7cmNgdja2RAZaLIorz0HUmnSlY=;
 b=9UQ/HLuteT7GGQ9KBeXqgVKcd7tuX2nCM55bfSlYCBrf89bTuzSDqPx6KZRD6KvCu3QSTm
 JL5IFyvDfs/twjBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B99F213AD1
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 14:23:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oO8aLf/f82e5KAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 07 Apr 2025 14:23:59 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  7 Apr 2025 16:23:49 +0200
Message-ID: <20250407142351.25900-6-mdoucha@suse.cz>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407142351.25900-1-mdoucha@suse.cz>
References: <20250407142351.25900-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 171831F394
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.cz:dkim, suse.cz:mid, suse.cz:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/5] Add test for Intel VMX virtualized APIC
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
 runtest/kvm                      |   1 +
 testcases/kernel/kvm/.gitignore  |   1 +
 testcases/kernel/kvm/kvm_vmx02.c | 193 +++++++++++++++++++++++++++++++
 3 files changed, 195 insertions(+)
 create mode 100644 testcases/kernel/kvm/kvm_vmx02.c

diff --git a/runtest/kvm b/runtest/kvm
index 091bcd43e..5c285e656 100644
--- a/runtest/kvm
+++ b/runtest/kvm
@@ -3,5 +3,6 @@ kvm_svm02 kvm_svm02
 kvm_svm03 kvm_svm03
 kvm_svm04 kvm_svm04
 kvm_vmx01 kvm_vmx01
+kvm_vmx02 kvm_vmx02
 # Tests below may interfere with bug reproducibility
 kvm_pagefault01 kvm_pagefault01
diff --git a/testcases/kernel/kvm/.gitignore b/testcases/kernel/kvm/.gitignore
index c18a31792..f6935c17a 100644
--- a/testcases/kernel/kvm/.gitignore
+++ b/testcases/kernel/kvm/.gitignore
@@ -4,3 +4,4 @@
 /kvm_svm03
 /kvm_svm04
 /kvm_vmx01
+/kvm_vmx02
diff --git a/testcases/kernel/kvm/kvm_vmx02.c b/testcases/kernel/kvm/kvm_vmx02.c
new file mode 100644
index 000000000..3fcfebb3b
--- /dev/null
+++ b/testcases/kernel/kvm/kvm_vmx02.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC <mdoucha@suse.cz>
+ */
+
+/*\
+ * Verify that reads and writes to virtualized APIC in nested VM get
+ * redirected to the memory page selected by parent VM.
+ */
+
+#include "kvm_test.h"
+
+#ifdef COMPILE_PAYLOAD
+#if defined(__i386__) || defined(__x86_64__)
+
+#include "kvm_x86_vmx.h"
+
+#define TPR_OFFSET 0x80
+#define TPR_VALUE 0x7
+#define TPR_OLD_VALUE 0x9
+#define MSR_TPR 0x808
+
+static void *apic_base;
+
+int memapic_guest_main(void)
+{
+	int ret;
+	uint32_t *ptr;
+
+	ptr = apic_base + TPR_OFFSET;
+	ret = *ptr;
+	*ptr = TPR_VALUE;
+	return ret;
+}
+
+int msrapic_guest_main(void)
+{
+	int ret;
+
+	ret = kvm_rdmsr(MSR_TPR);
+	kvm_wrmsr(MSR_TPR, TPR_VALUE);
+	return ret;
+}
+
+int setup_vmcs(void *apic_ptr, void *msr_mask, uint64_t ec2_flags)
+{
+	uint32_t *tpr;
+	uint64_t val, mask, flags;
+
+	/* Check secondary VMCS execctl support */
+	mask = kvm_vmx_read_vmctl_mask(VMX_CTLMASK_EXECCTL);
+
+	if (!((mask >> 32) & VMX_EXECCTL_ENABLE_CTL2))
+		return 0;
+
+	/* Create and configure guest VMCS */
+	tpr = apic_ptr + TPR_OFFSET;
+	memset(apic_ptr, 0xa9, PAGESIZE);
+	memset(apic_base, 0xab, PAGESIZE);
+	*tpr = TPR_OLD_VALUE;
+	val = kvm_vmx_vmread(VMX_VMCS_VMEXEC_CTL);
+	flags = VMX_EXECCTL_TPR_SHADOW | VMX_EXECCTL_ENABLE_CTL2;
+	flags |= VMX_EXECCTL_MSR_BITMAP;
+	flags &= mask >> 32;
+	kvm_vmx_vmwrite(VMX_VMCS_VMEXEC_CTL, val | flags);
+
+	if (flags & VMX_EXECCTL_MSR_BITMAP) {
+		kvm_vmx_vmwrite(VMX_VMCS_MSR_BITMAP_POINTER,
+			(uintptr_t)msr_mask);
+	}
+
+	mask = kvm_vmx_read_vmctl_mask(VMX_CTLMASK_EXECCTL2);
+	ec2_flags &= mask >> 32;
+
+	if (!ec2_flags)
+		return 0;
+
+	val = ec2_flags | (uint32_t)mask;
+	kvm_vmx_vmwrite(VMX_VMCS_VMEXEC_CTL2, val);
+	kvm_vmx_vmwrite(VMX_VMCS_VIRT_APIC_POINTER, (uintptr_t)apic_ptr);
+	kvm_vmx_vmwrite(VMX_VMCS_VIRT_APIC_BASE, (uintptr_t)apic_base);
+	return 1;
+}
+
+void check_result(struct kvm_vmx_vcpu *vcpu, unsigned int tpr,
+	unsigned int tpr_b)
+{
+	/* Cast RAX value to int. The upper 32 bits may contain garbage. */
+	int tpr_orig = vcpu->regs.rax;
+
+	if (tpr_orig == TPR_OLD_VALUE)
+		tst_res(TPASS, "vTPR has correct value");
+	else
+		tst_res(TFAIL, "Unexpected vTPR value: %x", tpr_orig);
+
+	if (tpr == TPR_VALUE)
+		tst_res(TPASS, "vAPIC write was handled correctly");
+	else if (tpr_b == TPR_VALUE)
+		tst_res(TFAIL, "vAPIC write was stored to literal address");
+	else
+		tst_res(TFAIL, "vAPIC write may have overwritten host memory!");
+}
+
+void main(void)
+{
+	void *apic_ptr, *msr_mask;
+	struct kvm_vmx_vcpu *vcpu;
+	uintptr_t rsp;
+	uint32_t *tpr, *tpr_b;
+	uint64_t reason;
+	uint16_t ss;
+
+	kvm_set_vmx_state(1);
+
+	apic_ptr = tst_heap_alloc_aligned(2 * PAGESIZE, PAGESIZE);
+	apic_base = apic_ptr + PAGESIZE;
+	tpr = apic_ptr + TPR_OFFSET;
+	tpr_b = apic_base + TPR_OFFSET;
+	msr_mask = tst_heap_alloc_aligned(PAGESIZE, PAGESIZE);
+	memset(msr_mask, 0, PAGESIZE);
+	vcpu = kvm_create_vmx_vcpu(memapic_guest_main, 1);
+	kvm_vmx_vmptrld(vcpu->vmcs);
+	ss = kvm_vmx_vmread(VMX_VMCS_GUEST_SS) >> 3;
+	rsp = kvm_vmx_vmread(VMX_VMCS_GUEST_RSP);
+	tst_res(TINFO, "Testing memory-mapped APIC");
+
+	if (setup_vmcs(apic_ptr, msr_mask, VMX_EXECCTL2_VIRT_APIC)) {
+		kvm_vmx_vmrun(vcpu);
+		reason = kvm_vmx_vmread(VMX_VMCS_EXIT_REASON);
+
+		if (reason != VMX_EXIT_HLT) {
+			tst_res(TFAIL, "Unexpected guest exit reason %llx",
+				reason);
+		} else {
+			check_result(vcpu, *tpr, *tpr_b);
+		}
+	} else {
+		tst_res(TCONF, "CPU does not support memory mapped vAPIC");
+	}
+
+	tst_res(TINFO, "Testing MSR-based APIC");
+	kvm_init_vmx_vcpu(vcpu, ss, (void *)rsp, msrapic_guest_main);
+
+	if (setup_vmcs(apic_ptr, msr_mask, VMX_EXECCTL2_VIRT_X2APIC)) {
+		kvm_vmx_vmrun(vcpu);
+		reason = kvm_vmx_vmread(VMX_VMCS_EXIT_REASON);
+
+		if (reason == VMX_EXIT_RDMSR) {
+			tst_res(TCONF, "CPU does not support MSR bitmaps");
+		} else if (reason != VMX_EXIT_HLT) {
+			tst_res(TFAIL, "Unexpected guest exit reason %llx",
+				reason);
+		} else {
+			check_result(vcpu, *tpr, *tpr_b);
+		}
+	} else {
+		tst_res(TCONF, "CPU does not support MSR-based vAPIC");
+	}
+}
+
+#else /* defined(__i386__) || defined(__x86_64__) */
+TST_TEST_TCONF("Test supported only on x86");
+#endif /* defined(__i386__) || defined(__x86_64__) */
+
+#else /* COMPILE_PAYLOAD */
+
+#include "tst_module.h"
+
+#define NESTED_INTEL_SYSFILE "/sys/module/kvm_intel/parameters/nested"
+
+static void setup(void)
+{
+	if (!tst_read_bool_sys_param(NESTED_INTEL_SYSFILE)) {
+		tst_module_reload("kvm_intel",
+			(char *const[]){"nested=1", NULL});
+	}
+
+	tst_kvm_setup();
+}
+
+static struct tst_test test = {
+	.test_all = tst_kvm_run,
+	.setup = setup,
+	.cleanup = tst_kvm_cleanup,
+	.needs_root = 1,
+	.supported_archs = (const char *const []) {
+		"x86_64",
+		"x86",
+		NULL
+	},
+};
+
+#endif /* COMPILE_PAYLOAD */
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
