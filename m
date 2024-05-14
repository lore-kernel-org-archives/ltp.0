Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0321C25B75
	for <ltp@archiver.kernel.org>; Tue, 14 May 2024 12:08:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 094A33CDEA6
	for <ltp@archiver.kernel.org>; Tue, 14 May 2024 14:08:47 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A145C3C0562
 for <ltp@lists.linux.it>; Tue, 14 May 2024 14:08:14 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7CEC11000A5D
 for <ltp@lists.linux.it>; Tue, 14 May 2024 14:08:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7ACE321A52
 for <ltp@lists.linux.it>; Tue, 14 May 2024 12:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715688492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8KcQl+jR1KcP3BXr8QFepZGkKQ4gn/4tIRP/nKYj868=;
 b=AguaHoWetckxnsVgqxYkaBSkaZ87tTKkjMNcBsNZRva2tpXOCoN1gqkuLuuiJPO0F+mCF3
 f/ddZvqCdDnZNBDa9EMD/Mur0znsdLl8rPknQCAlFYUxdPISSlZl+nHuOuzDasAhy3nkAJ
 GYXLWuZn8F4x9mg9LfOR6D1EEhK5YpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715688492;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8KcQl+jR1KcP3BXr8QFepZGkKQ4gn/4tIRP/nKYj868=;
 b=zcX5zm+tF1prCtGC0flQMSd+f8I2n2Q6tXcqbAAKb4Fq6EbQFCxYwhVK68oT7diHASQw0c
 8f+U4PXRa4012nBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AguaHoWe;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zcX5zm+t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715688492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8KcQl+jR1KcP3BXr8QFepZGkKQ4gn/4tIRP/nKYj868=;
 b=AguaHoWetckxnsVgqxYkaBSkaZ87tTKkjMNcBsNZRva2tpXOCoN1gqkuLuuiJPO0F+mCF3
 f/ddZvqCdDnZNBDa9EMD/Mur0znsdLl8rPknQCAlFYUxdPISSlZl+nHuOuzDasAhy3nkAJ
 GYXLWuZn8F4x9mg9LfOR6D1EEhK5YpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715688492;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8KcQl+jR1KcP3BXr8QFepZGkKQ4gn/4tIRP/nKYj868=;
 b=zcX5zm+tF1prCtGC0flQMSd+f8I2n2Q6tXcqbAAKb4Fq6EbQFCxYwhVK68oT7diHASQw0c
 8f+U4PXRa4012nBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A4A713A67
 for <ltp@lists.linux.it>; Tue, 14 May 2024 12:08:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2OnJGSxUQ2bKEQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 14 May 2024 12:08:12 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 14 May 2024 14:07:11 +0200
Message-ID: <20240514120713.12308-5-mdoucha@suse.cz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240514120713.12308-1-mdoucha@suse.cz>
References: <20240514120713.12308-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7ACE321A52
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:dkim, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/4] KVM: Add functional test for VMSAVE/VMLOAD
 instructions
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

Changes since v1: None

 runtest/kvm                      |   1 +
 testcases/kernel/kvm/.gitignore  |   1 +
 testcases/kernel/kvm/kvm_svm04.c | 307 +++++++++++++++++++++++++++++++
 3 files changed, 309 insertions(+)
 create mode 100644 testcases/kernel/kvm/kvm_svm04.c

diff --git a/runtest/kvm b/runtest/kvm
index 9de846a09..74a517add 100644
--- a/runtest/kvm
+++ b/runtest/kvm
@@ -1,5 +1,6 @@
 kvm_svm01 kvm_svm01
 kvm_svm02 kvm_svm02
 kvm_svm03 kvm_svm03
+kvm_svm04 kvm_svm04
 # Tests below may interfere with bug reproducibility
 kvm_pagefault01 kvm_pagefault01
diff --git a/testcases/kernel/kvm/.gitignore b/testcases/kernel/kvm/.gitignore
index 9638a6fc7..661472cae 100644
--- a/testcases/kernel/kvm/.gitignore
+++ b/testcases/kernel/kvm/.gitignore
@@ -2,3 +2,4 @@
 /kvm_svm01
 /kvm_svm02
 /kvm_svm03
+/kvm_svm04
diff --git a/testcases/kernel/kvm/kvm_svm04.c b/testcases/kernel/kvm/kvm_svm04.c
new file mode 100644
index 000000000..e69f0d4be
--- /dev/null
+++ b/testcases/kernel/kvm/kvm_svm04.c
@@ -0,0 +1,307 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2023 SUSE LLC <mdoucha@suse.cz>
+ */
+
+/*\
+ * [Description]
+ *
+ * Functional test for VMSAVE/VMLOAD instructions in KVM environment. Verify
+ * that both instructions save/load the CPU state according to CPU
+ * documentation.
+ */
+
+#include "kvm_test.h"
+
+#ifdef COMPILE_PAYLOAD
+#if defined(__i386__) || defined(__x86_64__)
+
+#include "kvm_x86_svm.h"
+
+static struct kvm_vmcb *src_vmcb, *dest_vmcb, *msr_vmcb;
+static struct kvm_sregs sregs_buf;
+
+static int check_descriptor(const char *name,
+	const struct kvm_vmcb_descriptor *data,
+	const struct kvm_vmcb_descriptor *exp)
+{
+	int ret = 0;
+
+	if (data->selector != exp->selector) {
+		tst_res(TFAIL, "%s.selector = %hx (expected %hx)",
+			name, data->selector, exp->selector);
+		ret = 1;
+	}
+
+	if (data->attrib != exp->attrib) {
+		tst_res(TFAIL, "%s.attrib = 0x%hx (expected 0x%hx)",
+			name, data->attrib, exp->attrib);
+		ret = 1;
+	}
+
+	if (data->limit != exp->limit) {
+		tst_res(TFAIL, "%s.limit = 0x%x (expected 0x%x)",
+			name, data->limit, exp->limit);
+		ret = 1;
+	}
+
+	if (data->base != exp->base) {
+		tst_res(TFAIL, "%s.base = 0x%llx (expected 0x%llx)",
+			name, data->base, exp->base);
+		ret = 1;
+	}
+
+	return ret;
+}
+
+static int check_value(const char *name, uint64_t val, uint64_t exp,
+	uint64_t backup, uint64_t reg, uint64_t nested_val)
+{
+	int ret = 0;
+
+	if (exp != backup) {
+		tst_res(TFAIL, "%s source was modified (0x%llx != 0x%llx)",
+			name, exp, backup);
+		ret = 1;
+	}
+
+	if (reg != exp) {
+		tst_res(TFAIL, "%s was not loaded (0x%llx != 0x%llx)",
+			name, reg, exp);
+		ret = 1;
+	}
+
+	if (val != exp) {
+		tst_res(TFAIL, "%s was not saved (0x%llx != 0x%llx)",
+			name, val, exp);
+		ret = 1;
+	}
+
+	if (val != nested_val) {
+		tst_res(TFAIL, "Inconsistent %s on VM exit (0x%llx != 0x%llx)",
+			name, val, nested_val);
+		ret = 1;
+	}
+
+	if (!ret)
+		tst_res(TPASS, "%s has correct value 0x%llx", name, val);
+
+	return ret;
+}
+
+static int vmsave_copy(void)
+{
+	kvm_svm_vmload(src_vmcb);
+	kvm_read_sregs(&sregs_buf);
+	msr_vmcb->star = kvm_rdmsr(MSR_STAR);
+	msr_vmcb->lstar = kvm_rdmsr(MSR_LSTAR);
+	msr_vmcb->cstar = kvm_rdmsr(MSR_CSTAR);
+	msr_vmcb->sfmask = kvm_rdmsr(MSR_SFMASK);
+	msr_vmcb->fs.base = kvm_rdmsr(MSR_FS_BASE);
+	msr_vmcb->gs.base = kvm_rdmsr(MSR_GS_BASE);
+	msr_vmcb->kernel_gs_base = kvm_rdmsr(MSR_KERNEL_GS_BASE);
+	msr_vmcb->sysenter_cs = kvm_rdmsr(MSR_SYSENTER_CS);
+	msr_vmcb->sysenter_esp = kvm_rdmsr(MSR_SYSENTER_ESP);
+	msr_vmcb->sysenter_eip = kvm_rdmsr(MSR_SYSENTER_EIP);
+	kvm_svm_vmsave(dest_vmcb);
+	return 0;
+}
+
+static int check_vmsave_result(struct kvm_vmcb *copy_vmcb,
+	struct kvm_vmcb *nested_vmcb)
+{
+	int ret = 0;
+
+	/* Nested VMCB is only compared to dest VMCB, bypass the check */
+	if (!nested_vmcb)
+		nested_vmcb = dest_vmcb;
+
+	ret = check_descriptor("FS", &dest_vmcb->fs, &src_vmcb->fs);
+	ret = check_value("FS.selector", dest_vmcb->fs.selector,
+		src_vmcb->fs.selector, copy_vmcb->fs.selector,
+		sregs_buf.fs, nested_vmcb->fs.selector) || ret;
+	ret = check_descriptor("GS", &dest_vmcb->gs, &src_vmcb->gs) || ret;
+	ret = check_value("GS.selector", dest_vmcb->gs.selector,
+		src_vmcb->gs.selector, copy_vmcb->gs.selector,
+		sregs_buf.gs, nested_vmcb->gs.selector) || ret;
+	ret = check_descriptor("LDTR", &dest_vmcb->ldtr, &src_vmcb->ldtr) ||
+		ret;
+	ret = check_descriptor("TR", &dest_vmcb->tr, &src_vmcb->tr) || ret;
+	ret = check_value("STAR", dest_vmcb->star, src_vmcb->star,
+		copy_vmcb->star, msr_vmcb->star, nested_vmcb->star) || ret;
+	ret = check_value("LSTAR", dest_vmcb->lstar, src_vmcb->lstar,
+		copy_vmcb->lstar, msr_vmcb->lstar, nested_vmcb->lstar) || ret;
+	ret = check_value("CSTAR", dest_vmcb->cstar, src_vmcb->cstar,
+		copy_vmcb->cstar, msr_vmcb->cstar, nested_vmcb->cstar) || ret;
+	ret = check_value("SFMASK", dest_vmcb->sfmask, src_vmcb->sfmask,
+		copy_vmcb->sfmask, msr_vmcb->sfmask, nested_vmcb->sfmask) ||
+		ret;
+	ret = check_value("FS.base", dest_vmcb->fs.base, src_vmcb->fs.base,
+		copy_vmcb->fs.base, msr_vmcb->fs.base, nested_vmcb->fs.base) ||
+		ret;
+	ret = check_value("GS.base", dest_vmcb->gs.base, src_vmcb->gs.base,
+		copy_vmcb->gs.base, msr_vmcb->gs.base, nested_vmcb->gs.base) ||
+		ret;
+	ret = check_value("KernelGSBase", dest_vmcb->kernel_gs_base,
+		src_vmcb->kernel_gs_base, copy_vmcb->kernel_gs_base,
+		msr_vmcb->kernel_gs_base, nested_vmcb->kernel_gs_base) || ret;
+	ret = check_value("Sysenter_CS", dest_vmcb->sysenter_cs,
+		src_vmcb->sysenter_cs, copy_vmcb->sysenter_cs,
+		msr_vmcb->sysenter_cs, nested_vmcb->sysenter_cs) || ret;
+	ret = check_value("Sysenter_ESP", dest_vmcb->sysenter_esp,
+		src_vmcb->sysenter_esp, copy_vmcb->sysenter_esp,
+		msr_vmcb->sysenter_esp, nested_vmcb->sysenter_esp) || ret;
+	ret = check_value("Sysenter_EIP", dest_vmcb->sysenter_eip,
+		src_vmcb->sysenter_eip, copy_vmcb->sysenter_eip,
+		msr_vmcb->sysenter_eip, nested_vmcb->sysenter_eip) || ret;
+
+	return ret;
+}
+
+static int create_segment_descriptor(uint64_t baseaddr, uint32_t limit,
+	unsigned int flags)
+{
+	int ret = kvm_find_free_descriptor(kvm_gdt, KVM_GDT_SIZE);
+
+	if (ret < 0)
+		tst_brk(TBROK, "Descriptor table is full");
+
+	kvm_set_segment_descriptor(kvm_gdt + ret, baseaddr, limit, flags);
+	return ret;
+}
+
+static void dirty_vmcb(struct kvm_vmcb *buf)
+{
+	buf->fs.selector = 0x60;
+	buf->fs.attrib = SEGTYPE_RWDATA | SEGFLAG_PRESENT;
+	buf->fs.limit = 0xffff;
+	buf->fs.base = 0xfff000;
+	buf->gs.selector = 0x68;
+	buf->gs.attrib = SEGTYPE_RWDATA | SEGFLAG_PRESENT;
+	buf->gs.limit = 0xffff;
+	buf->gs.base = 0xfff000;
+	buf->ldtr.selector = 0x70;
+	buf->ldtr.attrib = SEGTYPE_LDT | SEGFLAG_PRESENT;
+	buf->ldtr.limit = 0xffff;
+	buf->ldtr.base = 0xfff000;
+	buf->tr.selector = 0x78;
+	buf->tr.attrib = SEGTYPE_TSS | SEGFLAG_PRESENT;
+	buf->tr.limit = 0xffff;
+	buf->tr.base = 0xfff000;
+	buf->star = 0xffff;
+	buf->lstar = 0xffff;
+	buf->cstar = 0xffff;
+	buf->sfmask = 0xffff;
+	buf->fs.base = 0xffff;
+	buf->gs.base = 0xffff;
+	buf->kernel_gs_base = 0xffff;
+	buf->sysenter_cs = 0xffff;
+	buf->sysenter_esp = 0xffff;
+	buf->sysenter_eip = 0xffff;
+}
+
+void main(void)
+{
+	uint16_t ss;
+	uint64_t rsp;
+	struct kvm_svm_vcpu *vcpu;
+	int data_seg1, data_seg2, ldt_seg, task_seg;
+	struct segment_descriptor *ldt;
+	struct kvm_vmcb *backup_vmcb, *zero_vmcb;
+	unsigned int ldt_size = KVM_GDT_SIZE*sizeof(struct segment_descriptor);
+
+	kvm_init_svm();
+
+	src_vmcb = kvm_alloc_vmcb();
+	dest_vmcb = kvm_alloc_vmcb();
+	msr_vmcb = kvm_alloc_vmcb();
+	backup_vmcb = kvm_alloc_vmcb();
+	zero_vmcb = kvm_alloc_vmcb();
+
+	vcpu = kvm_create_svm_vcpu(vmsave_copy, 1);
+	kvm_vmcb_set_intercept(vcpu->vmcb, SVM_INTERCEPT_VMLOAD, 0);
+	kvm_vmcb_set_intercept(vcpu->vmcb, SVM_INTERCEPT_VMSAVE, 0);
+	/* Save allocated stack for later VM reinit */
+	ss = vcpu->vmcb->ss.selector >> 3;
+	rsp = vcpu->vmcb->rsp;
+
+	ldt = tst_heap_alloc_aligned(ldt_size, 8);
+	memset(ldt, 0, ldt_size);
+	data_seg1 = create_segment_descriptor(0xda7a1000, 0x1000,
+		SEGTYPE_RODATA | SEGFLAG_PRESENT);
+	data_seg2 = create_segment_descriptor(0xda7a2000, 2,
+		SEGTYPE_RWDATA | SEGFLAG_PRESENT | SEGFLAG_PAGE_LIMIT);
+	ldt_seg = create_segment_descriptor((uintptr_t)ldt, ldt_size,
+		SEGTYPE_LDT | SEGFLAG_PRESENT);
+	task_seg = create_segment_descriptor(0x7a53000, 0x1000,
+		SEGTYPE_TSS | SEGFLAG_PRESENT);
+	kvm_vmcb_copy_gdt_descriptor(&src_vmcb->fs, data_seg1);
+	kvm_vmcb_copy_gdt_descriptor(&src_vmcb->gs, data_seg2);
+	kvm_vmcb_copy_gdt_descriptor(&src_vmcb->ldtr, ldt_seg);
+	kvm_vmcb_copy_gdt_descriptor(&src_vmcb->tr, task_seg);
+
+	src_vmcb->star = 0x5742;
+	src_vmcb->lstar = 0x15742;
+	src_vmcb->cstar = 0xc5742;
+	src_vmcb->sfmask = 0xf731;
+	src_vmcb->fs.base = 0xf000;
+	src_vmcb->gs.base = 0x10000;
+	src_vmcb->kernel_gs_base = 0x20000;
+	src_vmcb->sysenter_cs = 0x595c5;
+	src_vmcb->sysenter_esp = 0x595e50;
+	src_vmcb->sysenter_eip = 0x595e10;
+
+	memcpy(backup_vmcb, src_vmcb, sizeof(struct kvm_vmcb));
+	tst_res(TINFO, "VMLOAD/VMSAVE non-zero values");
+	vmsave_copy();
+	check_vmsave_result(backup_vmcb, NULL);
+
+	memset(src_vmcb, 0, sizeof(struct kvm_vmcb));
+	tst_res(TINFO, "VMLOAD/VMSAVE zero values");
+	dirty_vmcb(dest_vmcb);
+	vmsave_copy();
+	check_vmsave_result(zero_vmcb, NULL);
+
+	memcpy(src_vmcb, backup_vmcb, sizeof(struct kvm_vmcb));
+	tst_res(TINFO, "Nested VMLOAD/VMSAVE non-zero values");
+	dirty_vmcb(vcpu->vmcb);
+	memset(dest_vmcb, 0, sizeof(struct kvm_vmcb));
+	kvm_svm_vmrun(vcpu);
+
+	if (vcpu->vmcb->exitcode != SVM_EXIT_HLT)
+		tst_brk(TBROK, "Nested VM exited unexpectedly");
+
+	check_vmsave_result(backup_vmcb, vcpu->vmcb);
+
+	memset(src_vmcb, 0, sizeof(struct kvm_vmcb));
+	tst_res(TINFO, "Nested VMLOAD/VMSAVE zero values");
+	kvm_init_guest_vmcb(vcpu->vmcb, 1, ss, (void *)rsp, vmsave_copy);
+	kvm_vmcb_set_intercept(vcpu->vmcb, SVM_INTERCEPT_VMLOAD, 0);
+	kvm_vmcb_set_intercept(vcpu->vmcb, SVM_INTERCEPT_VMSAVE, 0);
+	dirty_vmcb(vcpu->vmcb);
+	kvm_svm_vmrun(vcpu);
+
+	if (vcpu->vmcb->exitcode != SVM_EXIT_HLT)
+		tst_brk(TBROK, "Nested VM exited unexpectedly");
+
+	check_vmsave_result(zero_vmcb, vcpu->vmcb);
+}
+
+#else /* defined(__i386__) || defined(__x86_64__) */
+TST_TEST_TCONF("Test supported only on x86");
+#endif /* defined(__i386__) || defined(__x86_64__) */
+
+#else /* COMPILE_PAYLOAD */
+
+static struct tst_test test = {
+	.test_all = tst_kvm_run,
+	.setup = tst_kvm_setup,
+	.cleanup = tst_kvm_cleanup,
+	.supported_archs = (const char *const []) {
+		"x86_64",
+		"x86",
+		NULL
+	},
+};
+
+#endif /* COMPILE_PAYLOAD */
-- 
2.44.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
