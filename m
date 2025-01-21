Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5004DC02182
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 16:47:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D103C3C2A8C
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 17:47:28 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 522BF3C29D3
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 17:44:31 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 310131BCC25E
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 17:44:29 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 59BF81F450
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 16:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737477869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vYC0PSA/gxGdWEyjqowaQOtUIsQX2PhkDPkGVpDQcYc=;
 b=w9rI6EQllnyC73El7c9oBTgOvi5dRljYxiPLUCoHeT/d834v2zbd6xJzl74/f70737XHUf
 N86BqvVyVBE/Ri5V6+nAk9SW7IBpZQc8FDTZai6xQoBZXOy0ETgBXPpPgbaZZEeZusxn5D
 Y7MpC6puzIRvFTYHBze6jbaJ7g2kH+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737477869;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vYC0PSA/gxGdWEyjqowaQOtUIsQX2PhkDPkGVpDQcYc=;
 b=Zn1xsqjiJ6q5VekCrLke8rP1M5TrxunQ3tW8M2FzclhTQD9++ZgYCTic98Vdf5uPe9mYMs
 Khk2pGRMW4pPeICQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737477869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vYC0PSA/gxGdWEyjqowaQOtUIsQX2PhkDPkGVpDQcYc=;
 b=w9rI6EQllnyC73El7c9oBTgOvi5dRljYxiPLUCoHeT/d834v2zbd6xJzl74/f70737XHUf
 N86BqvVyVBE/Ri5V6+nAk9SW7IBpZQc8FDTZai6xQoBZXOy0ETgBXPpPgbaZZEeZusxn5D
 Y7MpC6puzIRvFTYHBze6jbaJ7g2kH+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737477869;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vYC0PSA/gxGdWEyjqowaQOtUIsQX2PhkDPkGVpDQcYc=;
 b=Zn1xsqjiJ6q5VekCrLke8rP1M5TrxunQ3tW8M2FzclhTQD9++ZgYCTic98Vdf5uPe9mYMs
 Khk2pGRMW4pPeICQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B2B613AF1
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 16:44:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0BzPEe3Oj2erPQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 16:44:29 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 21 Jan 2025 17:44:20 +0100
Message-ID: <20250121164426.27977-7-mdoucha@suse.cz>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250121164426.27977-1-mdoucha@suse.cz>
References: <20250121164426.27977-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 06/10] KVM: Add helper functions for nested Intel VMX
 virtualization
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
 testcases/kernel/kvm/bootstrap_x86.S       |  64 +++
 testcases/kernel/kvm/bootstrap_x86_64.S    |  54 +++
 testcases/kernel/kvm/include/kvm_x86_vmx.h | 201 +++++++++
 testcases/kernel/kvm/lib_x86.c             | 488 +++++++++++++++++++++
 4 files changed, 807 insertions(+)
 create mode 100644 testcases/kernel/kvm/include/kvm_x86_vmx.h

diff --git a/testcases/kernel/kvm/bootstrap_x86.S b/testcases/kernel/kvm/bootstrap_x86.S
index f08282461..f19a9ea55 100644
--- a/testcases/kernel/kvm/bootstrap_x86.S
+++ b/testcases/kernel/kvm/bootstrap_x86.S
@@ -11,6 +11,9 @@
 
 .set MSR_VM_HSAVE_PA, 0xc0010117
 
+.set VMX_VMCS_HOST_RSP, 0x6c14
+.set VMX_VMCS_HOST_RIP, 0x6c16
+
 /*
  * This section will be allocated at address 0x1000 and
  * jumped to from the reset stub provided by kvm_run.
@@ -451,6 +454,67 @@ kvm_svm_vmrun:
 	pop %edi
 	ret
 
+.global kvm_vmx_vmlaunch
+kvm_vmx_vmlaunch:
+	push %edi
+	mov 8(%esp), %edi
+	push %ebx
+	push %esi
+	push %ebp
+	push %edi
+
+	mov $VMX_VMCS_HOST_RSP, %eax
+	vmwrite %esp, %eax
+	jna vmx_vmwrite_error
+	mov $VMX_VMCS_HOST_RIP, %eax
+	lea vmx_vm_exit, %ebx
+	vmwrite %ebx, %eax
+	jna vmx_vmwrite_error
+
+	load_vcpu_regs
+	vmlaunch
+	jmp vmx_vm_exit
+
+.global kvm_vmx_vmresume
+kvm_vmx_vmresume:
+	push %edi
+	mov 8(%esp), %edi
+	push %ebx
+	push %esi
+	push %ebp
+	push %edi
+
+	mov $VMX_VMCS_HOST_RSP, %eax
+	vmwrite %esp, %eax
+	jna vmx_vmwrite_error
+	mov $VMX_VMCS_HOST_RIP, %eax
+	lea vmx_vm_exit, %ebx
+	vmwrite %ebx, %eax
+	jna vmx_vmwrite_error
+
+	load_vcpu_regs
+	vmresume
+
+vmx_vm_exit:
+	jna vmx_vmentry_error
+	save_vcpu_regs
+	xorl %eax, %eax
+
+vmx_vm_ret:
+	pop %edi
+	pop %ebp
+	pop %esi
+	pop %ebx
+	pop %edi
+	ret
+
+vmx_vmwrite_error:
+	movl $2, %eax
+	jmp vmx_vm_ret
+
+vmx_vmentry_error:
+	movl $1, %eax
+	jmp vmx_vm_ret
 
 .section .bss.pgtables, "aw", @nobits
 .global kvm_pagetable
diff --git a/testcases/kernel/kvm/bootstrap_x86_64.S b/testcases/kernel/kvm/bootstrap_x86_64.S
index 1e0a2952d..d4b501280 100644
--- a/testcases/kernel/kvm/bootstrap_x86_64.S
+++ b/testcases/kernel/kvm/bootstrap_x86_64.S
@@ -12,6 +12,9 @@
 
 .set MSR_VM_HSAVE_PA, 0xc0010117
 
+.set VMX_VMCS_HOST_RSP, 0x6c14
+.set VMX_VMCS_HOST_RIP, 0x6c16
+
 /*
  * This section will be allocated at address 0x1000 and
  * jumped to from the reset stub provided by kvm_run.
@@ -587,6 +590,57 @@ kvm_svm_vmrun:
 	pop_local
 	retq
 
+.global kvm_vmx_vmlaunch
+kvm_vmx_vmlaunch:
+	push_local
+	pushq %rdi
+
+	mov $VMX_VMCS_HOST_RSP, %rax
+	vmwrite %rsp, %rax
+	jna vmx_vmwrite_error
+	mov $VMX_VMCS_HOST_RIP, %rax
+	lea vmx_vm_exit, %rbx
+	vmwrite %rbx, %rax
+	jna vmx_vmwrite_error
+
+	load_vcpu_regs
+	vmlaunch
+	jmp vmx_vm_exit
+
+.global kvm_vmx_vmresume
+kvm_vmx_vmresume:
+	push_local
+	pushq %rdi
+
+	movq $VMX_VMCS_HOST_RSP, %rax
+	vmwrite %rsp, %rax
+	jna vmx_vmwrite_error
+	movq $VMX_VMCS_HOST_RIP, %rax
+	lea vmx_vm_exit, %rbx
+	vmwrite %rbx, %rax
+	jna vmx_vmwrite_error
+
+	load_vcpu_regs
+	vmresume
+
+vmx_vm_exit:
+	jna vmx_vmentry_error
+	save_vcpu_regs
+	xorq %rax, %rax
+
+vmx_vm_ret:
+	popq %rdi
+	pop_local
+	retq
+
+vmx_vmwrite_error:
+	movq $2, %rax
+	jmp vmx_vm_ret
+
+vmx_vmentry_error:
+	movq $1, %rax
+	jmp vmx_vm_ret
+
 .section .bss.pgtables, "aw", @nobits
 .global kvm_pagetable
 kvm_pagetable:
diff --git a/testcases/kernel/kvm/include/kvm_x86_vmx.h b/testcases/kernel/kvm/include/kvm_x86_vmx.h
new file mode 100644
index 000000000..180a114e7
--- /dev/null
+++ b/testcases/kernel/kvm/include/kvm_x86_vmx.h
@@ -0,0 +1,201 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2024 SUSE LLC <mdoucha@suse.cz>
+ *
+ * x86-specific KVM helper functions and structures for Intel VMX
+ */
+
+#ifndef KVM_X86_VMX_H_
+#define KVM_X86_VMX_H_
+
+#include "kvm_x86.h"
+
+/* CPUID_GET_MODEL_INFO flags returned in ECX */
+#define CPUID_MODEL_VMX (1 << 5)
+#define CPUID_MODEL_SMX (1 << 6)
+
+#define MSR_IA32_VMX_BASIC 0x480
+#define MSR_IA32_VMX_PINX_MASK 0x481
+#define MSR_IA32_VMX_EXECCTL_MASK 0x482
+#define MSR_IA32_VMX_EXITCTL_MASK 0x483
+#define MSR_IA32_VMX_ENTRYCTL_MASK 0x484
+#define MSR_IA32_VMX_CR0_FIXED0 0x486
+#define MSR_IA32_VMX_CR0_FIXED1 0x487
+#define MSR_IA32_VMX_CR4_FIXED0 0x488
+#define MSR_IA32_VMX_CR4_FIXED1 0x489
+#define MSR_IA32_VMX_EXECCTL2_MASK 0x48b
+#define MSR_IA32_VMX_PINX_MASK2 0x48d
+#define MSR_IA32_VMX_EXECCTL_MASK2 0x48e
+#define MSR_IA32_VMX_EXITCTL_MASK2 0x48f
+#define MSR_IA32_VMX_ENTRYCTL_MASK2 0x490
+
+#define IA32FC_LOCK (1 << 0)
+#define IA32FC_VMXON_SMX (1 << 1)
+#define IA32FC_VMXON_NORMAL (1 << 2)
+
+#define IA32_VMXBASIC_USELESS_CTL_MASKS (1ULL << 55)
+
+#define VMX_VMCS_GUEST_ES	0x800
+#define VMX_VMCS_GUEST_CS	0x802
+#define VMX_VMCS_GUEST_SS	0x804
+#define VMX_VMCS_GUEST_DS	0x806
+#define VMX_VMCS_GUEST_FS	0x808
+#define VMX_VMCS_GUEST_GS	0x80a
+#define VMX_VMCS_GUEST_LDTR	0x80c
+#define VMX_VMCS_GUEST_TR	0x80e
+#define VMX_VMCS_GUEST_INTR	0x810
+#define VMX_VMCS_HOST_ES	0xc00
+#define VMX_VMCS_HOST_CS	0xc02
+#define VMX_VMCS_HOST_SS	0xc04
+#define VMX_VMCS_HOST_DS	0xc06
+#define VMX_VMCS_HOST_FS	0xc08
+#define VMX_VMCS_HOST_GS	0xc0a
+#define VMX_VMCS_HOST_TR	0xc0c
+
+#define VMX_VMCS_LINK_POINTER	0x2800
+
+#define VMX_VMCS_GUEST_ES_LIMIT		0x4800
+#define VMX_VMCS_GUEST_CS_LIMIT		0x4802
+#define VMX_VMCS_GUEST_SS_LIMIT		0x4804
+#define VMX_VMCS_GUEST_DS_LIMIT		0x4806
+#define VMX_VMCS_GUEST_FS_LIMIT		0x4808
+#define VMX_VMCS_GUEST_GS_LIMIT		0x480a
+#define VMX_VMCS_GUEST_LDTR_LIMIT	0x480c
+#define VMX_VMCS_GUEST_TR_LIMIT		0x480e
+#define VMX_VMCS_GUEST_GDTR_LIMIT	0x4810
+#define VMX_VMCS_GUEST_IDTR_LIMIT	0x4812
+#define VMX_VMCS_GUEST_ES_ACCESS	0x4814
+#define VMX_VMCS_GUEST_CS_ACCESS	0x4816
+#define VMX_VMCS_GUEST_SS_ACCESS	0x4818
+#define VMX_VMCS_GUEST_DS_ACCESS	0x481a
+#define VMX_VMCS_GUEST_FS_ACCESS	0x481c
+#define VMX_VMCS_GUEST_GS_ACCESS	0x481e
+#define VMX_VMCS_GUEST_LDTR_ACCESS	0x4820
+#define VMX_VMCS_GUEST_TR_ACCESS	0x4822
+#define VMX_VMCS_GUEST_INTR_STATE	0x4824
+#define VMX_VMCS_GUEST_ACT_STATE	0x4826
+#define VMX_VMCS_GUEST_SMBASE		0x4828
+#define VMX_VMCS_GUEST_SYSENTER_CS	0x482a
+#define VMX_VMCS_HOST_SYSENTER_CS	0x4c00
+
+#define VMX_VMCS_GUEST_CR0		0x6800
+#define VMX_VMCS_GUEST_CR3		0x6802
+#define VMX_VMCS_GUEST_CR4		0x6804
+#define VMX_VMCS_GUEST_ES_BASE		0x6806
+#define VMX_VMCS_GUEST_CS_BASE		0x6808
+#define VMX_VMCS_GUEST_SS_BASE		0x680a
+#define VMX_VMCS_GUEST_DS_BASE		0x680c
+#define VMX_VMCS_GUEST_FS_BASE		0x680e
+#define VMX_VMCS_GUEST_GS_BASE		0x6810
+#define VMX_VMCS_GUEST_LDTR_BASE	0x6812
+#define VMX_VMCS_GUEST_TR_BASE		0x6814
+#define VMX_VMCS_GUEST_GDTR_BASE	0x6816
+#define VMX_VMCS_GUEST_IDTR_BASE	0x6818
+#define VMX_VMCS_GUEST_DR7		0x681a
+#define VMX_VMCS_GUEST_RSP		0x681c
+#define VMX_VMCS_GUEST_RIP		0x681e
+#define VMX_VMCS_GUEST_RFLAGS		0x6820
+#define VMX_VMCS_GUEST_DEBUG_EXC	0x6822
+#define VMX_VMCS_GUEST_SYSENTER_ESP	0x6824
+#define VMX_VMCS_GUEST_SYSENTER_EIP	0x6826
+#define VMX_VMCS_HOST_CR0		0x6c00
+#define VMX_VMCS_HOST_CR3		0x6c02
+#define VMX_VMCS_HOST_CR4		0x6c04
+#define VMX_VMCS_HOST_FS_BASE		0x6c06
+#define VMX_VMCS_HOST_GS_BASE		0x6c08
+#define VMX_VMCS_HOST_TR_BASE		0x6c0a
+#define VMX_VMCS_HOST_GDTR_BASE		0x6c0c
+#define VMX_VMCS_HOST_IDTR_BASE		0x6c0e
+#define VMX_VMCS_HOST_SYSENTER_ESP	0x6c10
+#define VMX_VMCS_HOST_SYSENTER_EIP	0x6c12
+#define VMX_VMCS_HOST_RSP		0x6c14
+#define VMX_VMCS_HOST_RIP		0x6c16
+
+#define VMX_VMCS_VMPINX_CTL		0x4000
+#define VMX_VMCS_VMEXEC_CTL		0x4002
+#define VMX_VMCS_VMEXIT_CTL		0x400c
+#define VMX_VMCS_VMEXIT_MSR_STORE	0x400e
+#define VMX_VMCS_VMEXIT_MSR_LOAD	0x4010
+#define VMX_VMCS_VMENTRY_CTL		0x4012
+#define VMX_VMCS_VMENTRY_MSR_LOAD	0x4014
+#define VMX_VMCS_VMENTRY_INTR		0x4016
+#define VMX_VMCS_VMENTRY_EXC		0x4018
+#define VMX_VMCS_VMENTRY_INST_LEN	0x401a
+#define VMX_VMCS_VMEXEC_CTL2		0x401e
+
+#define VMX_VMCS_VMINST_ERROR		0x4400
+#define VMX_VMCS_EXIT_REASON		0x4402
+#define VMX_VMCS_VMEXIT_INTR_INFO	0x4404
+#define VMX_VMCS_VMEXIT_INTR_ERRNO	0x4406
+#define VMX_VMCS_IDTVEC_INFO		0x4408
+#define VMX_VMCS_IDTVEC_ERRNO		0x440a
+#define VMX_VMCS_VMEXIT_INST_LEN	0x440c
+#define VMX_VMCS_VMEXIT_INST_INFO	0x440e
+#define VMX_VMCS_EXIT_QUALIFICATION	0x6400
+
+#define VMX_INTERCEPT_HLT (1 << 7)
+#define VMX_EXECCTL_ENABLE_CTL2 (1 << 31)
+
+#define VMX_EXECCTL2_SHADOW_VMCS (1 << 14)
+
+#define VMX_EXITCTL_SAVE_DR (1 << 2)
+#define VMX_EXITCTL_X64 (1 << 9)
+
+#define VMX_ENTRYCTL_LOAD_DR (1 << 2)
+#define VMX_ENTRYCTL_X64 (1 << 9)
+
+#define VMX_SHADOW_VMCS 0x80000000
+#define VMX_VMCSFIELD_64BIT 0x2000
+#define VMX_VMCSFIELD_SIZE_MASK 0x6000
+
+#define VMX_INVALID_VMCS 0xffffffffffffffffULL
+
+#define VMX_EXIT_HLT 12
+#define VMX_EXIT_FAILED_ENTRY 0x80000000
+
+struct kvm_vmcs {
+	uint32_t version;
+	uint32_t abort;
+	uint8_t data[4088];
+};
+
+struct kvm_vmx_vcpu {
+	struct kvm_vmcs *vmcs;
+	struct kvm_regs64 regs;
+	int launched;
+};
+
+/* Intel VMX virtualization helper functions */
+int kvm_is_vmx_supported(void);
+void kvm_set_vmx_state(int enabled);
+struct kvm_vmcs *kvm_alloc_vmcs(void);
+
+/* Copy GDT entry to given fields of the current VMCS */
+void kvm_vmcs_copy_gdt_descriptor(unsigned int gdt_id,
+	unsigned long vmcs_selector, unsigned long vmcs_flags,
+	unsigned long vmcs_limit, unsigned long vmcs_baseaddr);
+void kvm_init_vmx_vcpu(struct kvm_vmx_vcpu *cpu, uint16_t ss, void *rsp,
+	int (*guest_main)(void));
+struct kvm_vmx_vcpu *kvm_create_vmx_vcpu(int (*guest_main)(void),
+	int alloc_stack);
+
+/* Set the VMCS as current and update the host state fields */
+void kvm_vmx_activate_vcpu(struct kvm_vmx_vcpu *cpu);
+void kvm_vmx_vmrun(struct kvm_vmx_vcpu *cpu);
+
+void kvm_vmx_vmclear(struct kvm_vmcs *buf);
+void kvm_vmx_vmptrld(struct kvm_vmcs *buf);
+uint64_t kvm_vmx_vmptrst(void);
+uint64_t kvm_vmx_vmread(unsigned long var_id);
+void kvm_vmx_vmwrite(unsigned long var_id, uint64_t value);
+int kvm_vmx_vmlaunch(struct kvm_vmx_vcpu *buf);
+int kvm_vmx_vmresume(struct kvm_vmx_vcpu *buf);
+
+/* Read last VMX instruction error from current VMCS */
+int kvm_vmx_inst_errno(void);
+/* Get VMX instruction error description */
+const char *kvm_vmx_inst_strerr(int vmx_errno);
+/* Get description of last VMX instruction error in current VMCS */
+const char *kvm_vmx_inst_err(void);
+
+#endif /* KVM_X86_VMX_H_ */
diff --git a/testcases/kernel/kvm/lib_x86.c b/testcases/kernel/kvm/lib_x86.c
index 266d7195c..e6acc0797 100644
--- a/testcases/kernel/kvm/lib_x86.c
+++ b/testcases/kernel/kvm/lib_x86.c
@@ -6,6 +6,9 @@
  */
 
 #include "kvm_x86_svm.h"
+#include "kvm_x86_vmx.h"
+
+#define VMX_VMINST_ERR_COUNT 29
 
 void kvm_svm_guest_entry(void);
 
@@ -84,6 +87,38 @@ static uintptr_t intr_handlers[] = {
 	0
 };
 
+static const char *vmx_error_description[VMX_VMINST_ERR_COUNT] = {
+	"Success",
+	"VMCALL executed in VMX root",
+	"VMCLEAR on invalid pointer",
+	"VMCLEAR on VMXON pointer",
+	"VMLAUNCH with non-clear VMCS",
+	"VMRESUME with non-launched VMCS",
+	"VMRESUME after VMXOFF",
+	"VM entry with invalid VMCS control fields",
+	"VM entry with invalid VMCS host state",
+	"VMPTRLD with invalid pointer",
+	"VMPTRLD with VMXON pointer",
+	"VMPTRLD with incorrect VMCS version field",
+	"Invalid VMCS field code",
+	"VMWRITE to read-only VMCS field",
+	"Unknown error",
+	"VMXON called twice",
+	"VM entry with invalid executive VMCS pointer",
+	"VM entry with non-launched executive VMCS",
+	"VM entry with executive VMCS pointer != VMXON pointer",
+	"VMCALL with non-clear VMCS",
+	"VMCALL with invalid VMCS exit control fields",
+	"Unknown error",
+	"VMCALL with incorrect MSEG revision ID",
+	"VMXOFF under dual-monitor SMIs and SMM",
+	"VMCALL with invalid SMM-monitor features",
+	"VM entry with invalid executive VMCS execution control fields",
+	"VM entry with events blocked by MOV SS",
+	"Unknown error",
+	"Invalid operand to INVEPT/INVVPID"
+};
+
 static void kvm_set_intr_handler(unsigned int id, uintptr_t func)
 {
 	memset(kvm_idt + id, 0, sizeof(kvm_idt[0]));
@@ -438,3 +473,456 @@ void kvm_svm_vmsave(struct kvm_vmcb *buf)
 		: "a" (buf)
 	);
 }
+
+int kvm_is_vmx_supported(void)
+{
+	struct kvm_cpuid buf;
+
+	kvm_get_cpuid(CPUID_GET_MODEL_INFO, 0, &buf);
+	return buf.ecx & CPUID_MODEL_VMX;
+}
+
+void kvm_vmx_vmclear(struct kvm_vmcs *buf)
+{
+	uint64_t tmp = (uintptr_t)buf;
+
+	asm goto(
+		"vmclear (%0)\n"
+		"jna %l[error]\n"
+		:
+		: "r" (&tmp)
+		: "cc", "memory"
+		: error
+	);
+
+	return;
+
+error:
+	tst_brk(TBROK, "VMCLEAR(%p) failed", buf);
+}
+
+void kvm_vmx_vmptrld(struct kvm_vmcs *buf)
+{
+	uint64_t tmp = (uintptr_t)buf;
+
+	asm goto(
+		"vmptrld (%0)\n"
+		"jna %l[error]\n"
+		:
+		: "r" (&tmp)
+		: "cc"
+		: error
+	);
+
+	return;
+
+error:
+	tst_brk(TBROK, "VMPTRLD(%p) failed", buf);
+}
+
+uint64_t kvm_vmx_vmptrst(void)
+{
+	uint64_t ret;
+
+	asm (
+		"vmptrst (%0)\n"
+		:
+		: "r" (&ret)
+		: "cc", "memory"
+	);
+
+	return ret;
+}
+
+uint64_t kvm_vmx_vmread(unsigned long var_id)
+{
+	uint64_t ret = 0;
+	unsigned long tmp;
+
+#ifndef __x86_64__
+	if ((var_id & VMX_VMCSFIELD_SIZE_MASK) == VMX_VMCSFIELD_64BIT) {
+		asm goto(
+			"vmread %1, (%0)\n"
+			"jna %l[error]\n"
+			:
+			: "r" (&tmp), "r" (var_id + 1)
+			: "cc", "memory"
+			: error
+		);
+
+		ret = tmp;
+		ret <<= 32;
+	}
+#endif /* __x86_64__ */
+
+	asm goto(
+		"vmread %1, (%0)\n"
+		"jna %l[error]\n"
+		:
+		: "r" (&tmp), "r" (var_id)
+		: "cc", "memory"
+		: error
+	);
+
+	ret |= tmp;
+	return ret;
+
+error:
+	tst_brk(TBROK, "VMREAD(%lx) failed", var_id);
+}
+
+void kvm_vmx_vmwrite(unsigned long var_id, uint64_t value)
+{
+	unsigned long tmp = value;
+
+	asm goto(
+		"vmwrite %0, %1\n"
+		"jna %l[error]\n"
+		:
+		: "r" (tmp), "r" (var_id)
+		: "cc"
+		: error
+	);
+
+#ifndef __x86_64__
+	if ((var_id & VMX_VMCSFIELD_SIZE_MASK) == VMX_VMCSFIELD_64BIT) {
+		tmp = value >> 32;
+
+		asm goto(
+			"vmwrite %0, %1\n"
+			"jna %l[error]\n"
+			:
+			: "r" (tmp), "r" (var_id + 1)
+			: "cc"
+			: error
+		);
+
+	}
+#endif /* __x86_64__ */
+
+	return;
+
+error:
+	tst_brk(TBROK, "VMWRITE(%lx, %llx) failed", var_id, value);
+}
+
+static void kvm_vmx_vmxon(struct kvm_vmcs *buf)
+{
+	uint64_t tmp = (uintptr_t)buf;
+
+	asm goto(
+		"vmxon (%0)\n"
+		"jna %l[error]\n"
+		:
+		: "r" (&tmp)
+		: "cc"
+		: error
+	);
+
+	return;
+
+error:
+	tst_brk(TBROK, "VMXON(%p) failed", buf);
+}
+
+static void kvm_vmx_vmxoff(void)
+{
+	asm goto(
+		"vmxoff\n"
+		"jna %l[error]\n"
+		:
+		:
+		: "cc"
+		: error
+	);
+
+	return;
+
+error:
+	tst_brk(TBROK, "VMXOFF failed");
+}
+
+struct kvm_vmcs *kvm_alloc_vmcs(void)
+{
+	struct kvm_vmcs *ret;
+
+	ret = tst_heap_alloc_aligned(sizeof(struct kvm_vmcs), PAGESIZE);
+	memset(ret, 0, sizeof(struct kvm_vmcs));
+	ret->version = (uint32_t)kvm_rdmsr(MSR_IA32_VMX_BASIC);
+	return ret;
+}
+
+void kvm_set_vmx_state(int enabled)
+{
+	static struct kvm_vmcs *vmm_buf;
+	uint64_t value;
+	struct kvm_cregs cregs;
+
+	if (!kvm_is_vmx_supported())
+		tst_brk(TCONF, "CPU does not support VMX");
+
+	kvm_read_cregs(&cregs);
+	kvm_set_cr0(cregs.cr0 | CR0_NE);
+	kvm_set_cr4(cregs.cr4 | CR4_VMXE);
+	value = kvm_rdmsr(MSR_IA32_FEATURE_CONTROL);
+	value |= IA32FC_LOCK | IA32FC_VMXON_NORMAL;
+	kvm_wrmsr(MSR_IA32_FEATURE_CONTROL, value);
+
+	if (!vmm_buf)
+		vmm_buf = kvm_alloc_vmcs();
+
+	if (enabled)
+		kvm_vmx_vmxon(vmm_buf);
+	else
+		kvm_vmx_vmxoff();
+}
+
+void kvm_vmcs_copy_gdt_descriptor(unsigned int gdt_id,
+	unsigned long vmcs_selector, unsigned long vmcs_flags,
+	unsigned long vmcs_limit, unsigned long vmcs_baseaddr)
+{
+	uint64_t baseaddr;
+	uint32_t limit;
+	unsigned int flags;
+
+	if (gdt_id >= KVM_GDT_SIZE)
+		tst_brk(TBROK, "GDT descriptor ID out of range");
+
+	kvm_parse_segment_descriptor(kvm_gdt + gdt_id, &baseaddr, &limit,
+		&flags);
+
+	if (!(flags & SEGFLAG_PRESENT)) {
+		gdt_id = 0;
+		baseaddr = 0;
+		flags = 0x10000;
+		limit = 0;
+	} else if (flags & SEGFLAG_PAGE_LIMIT) {
+		limit = (limit << 12) | 0xfff;
+	}
+
+	if (!(flags & 0x10000)) {
+		// insert the reserved limit bits and force accessed bit to 1
+		flags = ((flags & 0xf00) << 4) | (flags & 0xff) | 0x1;
+	}
+
+	kvm_vmx_vmwrite(vmcs_selector, gdt_id << 3);
+	kvm_vmx_vmwrite(vmcs_flags, flags);
+	kvm_vmx_vmwrite(vmcs_limit, limit);
+	kvm_vmx_vmwrite(vmcs_baseaddr, baseaddr);
+}
+
+void kvm_init_vmx_vcpu(struct kvm_vmx_vcpu *cpu, uint16_t ss, void *rsp,
+	int (*guest_main)(void))
+{
+	uint64_t old_vmcs, pinxctl, execctl, entryctl, exitctl;
+	unsigned long crx;
+	struct kvm_cregs cregs;
+	struct kvm_sregs sregs;
+
+	kvm_read_cregs(&cregs);
+	kvm_read_sregs(&sregs);
+
+	/* Clear cpu->vmcs first in case it's the current VMCS */
+	kvm_vmx_vmclear(cpu->vmcs);
+	memset(&cpu->regs, 0, sizeof(struct kvm_regs64));
+	cpu->launched = 0;
+	old_vmcs = kvm_vmx_vmptrst();
+	kvm_vmx_vmptrld(cpu->vmcs);
+
+	/* Configure VM execution control fields */
+	if (kvm_rdmsr(MSR_IA32_VMX_BASIC) & IA32_VMXBASIC_USELESS_CTL_MASKS) {
+		pinxctl = (uint32_t)kvm_rdmsr(MSR_IA32_VMX_PINX_MASK2);
+		execctl = (uint32_t)kvm_rdmsr(MSR_IA32_VMX_EXECCTL_MASK2);
+		exitctl = (uint32_t)kvm_rdmsr(MSR_IA32_VMX_EXITCTL_MASK2);
+		entryctl = (uint32_t)kvm_rdmsr(MSR_IA32_VMX_ENTRYCTL_MASK2);
+	} else {
+		pinxctl = (uint32_t)kvm_rdmsr(MSR_IA32_VMX_PINX_MASK);
+		execctl = (uint32_t)kvm_rdmsr(MSR_IA32_VMX_EXECCTL_MASK);
+		exitctl = (uint32_t)kvm_rdmsr(MSR_IA32_VMX_EXITCTL_MASK);
+		entryctl = (uint32_t)kvm_rdmsr(MSR_IA32_VMX_ENTRYCTL_MASK);
+	}
+
+	execctl |= VMX_INTERCEPT_HLT;
+
+	if (kvm_rdmsr(MSR_EFER) & EFER_LME) {
+		entryctl |= VMX_ENTRYCTL_X64;
+		exitctl |= VMX_EXITCTL_X64;
+	}
+
+	kvm_vmx_vmwrite(VMX_VMCS_VMPINX_CTL, pinxctl);
+	kvm_vmx_vmwrite(VMX_VMCS_VMEXEC_CTL, execctl);
+	kvm_vmx_vmwrite(VMX_VMCS_VMENTRY_CTL, entryctl);
+	kvm_vmx_vmwrite(VMX_VMCS_VMEXIT_CTL, exitctl);
+	kvm_vmx_vmwrite(VMX_VMCS_LINK_POINTER, VMX_INVALID_VMCS);
+	kvm_vmcs_copy_gdt_descriptor(sregs.es >> 3, VMX_VMCS_GUEST_ES,
+		VMX_VMCS_GUEST_ES_ACCESS, VMX_VMCS_GUEST_ES_LIMIT,
+		VMX_VMCS_GUEST_ES_BASE);
+	kvm_vmcs_copy_gdt_descriptor(sregs.cs >> 3, VMX_VMCS_GUEST_CS,
+		VMX_VMCS_GUEST_CS_ACCESS, VMX_VMCS_GUEST_CS_LIMIT,
+		VMX_VMCS_GUEST_CS_BASE);
+	kvm_vmcs_copy_gdt_descriptor(ss, VMX_VMCS_GUEST_SS,
+		VMX_VMCS_GUEST_SS_ACCESS, VMX_VMCS_GUEST_SS_LIMIT,
+		VMX_VMCS_GUEST_SS_BASE);
+	kvm_vmcs_copy_gdt_descriptor(sregs.ds >> 3, VMX_VMCS_GUEST_DS,
+		VMX_VMCS_GUEST_DS_ACCESS, VMX_VMCS_GUEST_DS_LIMIT,
+		VMX_VMCS_GUEST_DS_BASE);
+	kvm_vmcs_copy_gdt_descriptor(sregs.fs >> 3, VMX_VMCS_GUEST_FS,
+		VMX_VMCS_GUEST_FS_ACCESS, VMX_VMCS_GUEST_FS_LIMIT,
+		VMX_VMCS_GUEST_FS_BASE);
+	kvm_vmcs_copy_gdt_descriptor(sregs.gs >> 3, VMX_VMCS_GUEST_GS,
+		VMX_VMCS_GUEST_GS_ACCESS, VMX_VMCS_GUEST_GS_LIMIT,
+		VMX_VMCS_GUEST_GS_BASE);
+	kvm_vmcs_copy_gdt_descriptor(sregs.tr >> 3, VMX_VMCS_GUEST_TR,
+		VMX_VMCS_GUEST_TR_ACCESS, VMX_VMCS_GUEST_TR_LIMIT,
+		VMX_VMCS_GUEST_TR_BASE);
+	kvm_vmx_vmwrite(VMX_VMCS_GUEST_LDTR, 0);
+	kvm_vmx_vmwrite(VMX_VMCS_GUEST_LDTR_ACCESS, 0x10000);
+	kvm_vmx_vmwrite(VMX_VMCS_GUEST_LDTR_LIMIT, 0);
+	kvm_vmx_vmwrite(VMX_VMCS_GUEST_LDTR_BASE, 0);
+	kvm_vmx_vmwrite(VMX_VMCS_GUEST_GDTR_BASE, (uintptr_t)kvm_gdt);
+	kvm_vmx_vmwrite(VMX_VMCS_GUEST_GDTR_LIMIT,
+		(KVM_GDT_SIZE * sizeof(struct segment_descriptor)) - 1);
+	kvm_vmx_vmwrite(VMX_VMCS_GUEST_IDTR_BASE, (uintptr_t)kvm_idt);
+	kvm_vmx_vmwrite(VMX_VMCS_GUEST_IDTR_LIMIT,
+		(X86_INTR_COUNT * sizeof(struct intr_descriptor)) - 1);
+
+	crx = cregs.cr0 & kvm_rdmsr(MSR_IA32_VMX_CR0_FIXED1);
+	crx |= kvm_rdmsr(MSR_IA32_VMX_CR0_FIXED0);
+	kvm_vmx_vmwrite(VMX_VMCS_GUEST_CR0, crx);
+	kvm_vmx_vmwrite(VMX_VMCS_GUEST_CR3, cregs.cr3);
+	crx = cregs.cr4 & kvm_rdmsr(MSR_IA32_VMX_CR4_FIXED1);
+	crx |= kvm_rdmsr(MSR_IA32_VMX_CR4_FIXED0);
+	kvm_vmx_vmwrite(VMX_VMCS_GUEST_CR4, crx);
+	kvm_vmx_vmwrite(VMX_VMCS_GUEST_RSP, (uintptr_t)rsp);
+	kvm_vmx_vmwrite(VMX_VMCS_GUEST_RIP, (uintptr_t)kvm_svm_guest_entry);
+	kvm_vmx_vmwrite(VMX_VMCS_GUEST_RFLAGS, 0x202); /* Interrupts enabled */
+	kvm_vmx_vmwrite(VMX_VMCS_GUEST_SYSENTER_ESP, 0);
+	kvm_vmx_vmwrite(VMX_VMCS_GUEST_SYSENTER_EIP, 0);
+	cpu->regs.rax = (uintptr_t)guest_main;
+
+	/* Reactivate previous VMCS (if any) */
+	if (old_vmcs != VMX_INVALID_VMCS)
+		kvm_vmx_vmptrld((struct kvm_vmcs *)(uintptr_t)old_vmcs);
+}
+
+struct kvm_vmx_vcpu *kvm_create_vmx_vcpu(int (*guest_main)(void),
+	int alloc_stack)
+{
+	uint16_t ss = 0;
+	char *stack = NULL;
+	struct kvm_vmcs *vmcs;
+	struct kvm_vmx_vcpu *ret;
+
+	vmcs = kvm_alloc_vmcs();
+
+	if (alloc_stack) {
+		stack = tst_heap_alloc_aligned(2 * PAGESIZE, PAGESIZE);
+		ss = kvm_create_stack_descriptor(kvm_gdt, KVM_GDT_SIZE, stack);
+		stack += 2 * PAGESIZE;
+	}
+
+	ret = tst_heap_alloc(sizeof(struct kvm_vmx_vcpu));
+	memset(ret, 0, sizeof(struct kvm_vmx_vcpu));
+	ret->vmcs = vmcs;
+	kvm_init_vmx_vcpu(ret, ss, stack, guest_main);
+	return ret;
+}
+
+void kvm_vmx_activate_vcpu(struct kvm_vmx_vcpu *cpu)
+{
+	struct kvm_cregs cregs;
+	struct kvm_sregs sregs;
+	uint64_t baseaddr;
+
+	kvm_read_cregs(&cregs);
+	kvm_read_sregs(&sregs);
+
+	kvm_vmx_vmptrld(cpu->vmcs);
+	kvm_vmx_vmwrite(VMX_VMCS_HOST_ES, sregs.es);
+	kvm_vmx_vmwrite(VMX_VMCS_HOST_CS, sregs.cs);
+	kvm_vmx_vmwrite(VMX_VMCS_HOST_SS, sregs.ss);
+	kvm_vmx_vmwrite(VMX_VMCS_HOST_DS, sregs.ds);
+	kvm_vmx_vmwrite(VMX_VMCS_HOST_FS, sregs.fs);
+	kvm_vmx_vmwrite(VMX_VMCS_HOST_GS, sregs.gs);
+	kvm_vmx_vmwrite(VMX_VMCS_HOST_TR, sregs.tr);
+
+	kvm_vmx_vmwrite(VMX_VMCS_HOST_CR0, cregs.cr0);
+	kvm_vmx_vmwrite(VMX_VMCS_HOST_CR3, cregs.cr3);
+	kvm_vmx_vmwrite(VMX_VMCS_HOST_CR4, cregs.cr4);
+	kvm_parse_segment_descriptor(kvm_gdt + (sregs.fs >> 3), &baseaddr,
+		NULL, NULL);
+	kvm_vmx_vmwrite(VMX_VMCS_HOST_FS_BASE, baseaddr);
+	kvm_parse_segment_descriptor(kvm_gdt + (sregs.gs >> 3), &baseaddr,
+		NULL, NULL);
+	kvm_vmx_vmwrite(VMX_VMCS_HOST_GS_BASE, baseaddr);
+	kvm_parse_segment_descriptor(kvm_gdt + (sregs.tr >> 3), &baseaddr,
+		NULL, NULL);
+	kvm_vmx_vmwrite(VMX_VMCS_HOST_TR_BASE, baseaddr);
+	kvm_vmx_vmwrite(VMX_VMCS_HOST_GDTR_BASE, (uintptr_t)kvm_gdt);
+	kvm_vmx_vmwrite(VMX_VMCS_HOST_IDTR_BASE, (uintptr_t)kvm_idt);
+}
+
+void kvm_vmx_vmrun(struct kvm_vmx_vcpu *cpu)
+{
+	int ret, err;
+	uint64_t reason;
+
+	kvm_vmx_activate_vcpu(cpu);
+
+	if (cpu->launched) {
+		ret = kvm_vmx_vmresume(cpu);
+	} else {
+		ret = kvm_vmx_vmlaunch(cpu);
+		cpu->launched = 1;
+	}
+
+	if (ret) {
+		err = kvm_vmx_inst_errno();
+		tst_brk(TBROK, "VMLAUNCH/VMRESUME failed: %s (%d)",
+			kvm_vmx_inst_strerr(err), err);
+	}
+
+	reason = kvm_vmx_vmread(VMX_VMCS_EXIT_REASON);
+
+	if (reason & VMX_EXIT_FAILED_ENTRY) {
+		tst_brk(TBROK, "VM entry failed. Reason: %llu, qualif.: %llu",
+			reason & 0xffff,
+			kvm_vmx_vmread(VMX_VMCS_EXIT_QUALIFICATION));
+	}
+}
+
+int kvm_vmx_inst_errno(void)
+{
+	unsigned long ret, var_id = VMX_VMCS_VMINST_ERROR;
+
+	/* Do not use kvm_vmx_vmread() to avoid tst_brk() on failure */
+	asm goto(
+		"vmread %1, (%0)\n"
+		"jna %l[error]\n"
+		:
+		: "r" (&ret), "r" (var_id)
+		: "cc", "memory"
+		: error
+	);
+
+	return ret;
+
+error:
+	return -1;
+}
+
+const char *kvm_vmx_inst_strerr(int vmx_errno)
+{
+	if (vmx_errno < 0)
+		return "Cannot read VM errno - invalid current VMCS?";
+
+	if (vmx_errno >= VMX_VMINST_ERR_COUNT)
+		return "Unknown error";
+
+	return vmx_error_description[vmx_errno];
+}
+
+const char *kvm_vmx_inst_err(void)
+{
+	return kvm_vmx_inst_strerr(kvm_vmx_inst_errno());
+}
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
