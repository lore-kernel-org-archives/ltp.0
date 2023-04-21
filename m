Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C55E2C7618E
	for <ltp@archiver.kernel.org>; Fri, 21 Apr 2023 14:58:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5BDBD3CBEF0
	for <ltp@archiver.kernel.org>; Fri, 21 Apr 2023 16:58:46 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 462E13CBE81
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 16:57:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0E7A36008EC
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 16:57:47 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 830DF21963;
 Fri, 21 Apr 2023 14:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682089067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kNz0x58pf18SUxr8xtYk5zZ1Fp8PzjhIgXOzmWg1LH0=;
 b=FZUpzW1jfpDgv9473y2Af33VBtxvgQA5BTI7cZBDtlnncsn257PRXV9RiakoNGJqDk4LHT
 hANzznKpv4K2YsuynLwrvjP8zJC+S61WzdnHEBQDf83+5kB76nXTN3JdMiC+FfzhP0IpDt
 kFjcEhx+94GC1eWj7C0qcGElT7EpGj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682089067;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kNz0x58pf18SUxr8xtYk5zZ1Fp8PzjhIgXOzmWg1LH0=;
 b=WFLrs9yOsoepe/w8CtczBxuI9lKJ/sH6tdOKp99OQNx8GTYP2TIroYhRmOfGC9YJXj+v+c
 shjMHs34c4owEoCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E7931391A;
 Fri, 21 Apr 2023 14:57:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0LBFFmukQmRfDAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 21 Apr 2023 14:57:47 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: nstange@suse.de,
	ltp@lists.linux.it
Date: Fri, 21 Apr 2023 16:57:45 +0200
Message-Id: <20230421145746.5704-4-mdoucha@suse.cz>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421145746.5704-1-mdoucha@suse.cz>
References: <20230421145746.5704-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/5] Add KVM helper functions for AMD SVM
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
 doc/kvm-test-api.txt                       |  73 ++++++++++
 testcases/kernel/kvm/bootstrap_x86.S       |  79 +++++++++++
 testcases/kernel/kvm/bootstrap_x86_64.S    |  89 ++++++++++++
 testcases/kernel/kvm/include/kvm_x86.h     |  14 ++
 testcases/kernel/kvm/include/kvm_x86_svm.h | 157 +++++++++++++++++++++
 testcases/kernel/kvm/lib_x86.c             | 155 +++++++++++++++++++-
 6 files changed, 566 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/kvm/include/kvm_x86_svm.h

diff --git a/doc/kvm-test-api.txt b/doc/kvm-test-api.txt
index 0aede5eea..812e12b38 100644
--- a/doc/kvm-test-api.txt
+++ b/doc/kvm-test-api.txt
@@ -390,6 +390,79 @@ Developer's Manual, Volume 3, Chapter 4 for explanation of the fields.
 See Intel(R) 64 and IA-32 Architectures Software Developer's Manual
 for documentation of standard and model-specific x86 registers.
 
+3.5 AMD SVM helper functions
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+`#include "kvm_test.h"` +
+`#include "kvm_x86.h"` +
+`#include "kvm_x86_svm.h"`
+
+The KVM guest library provides basic helper functions for creating and running
+nested virtual machines using the AMD SVM technology.
+
+.Example code to execute nested VM
+[source,c]
+-------------------------------------------------------------------------------
+int guest_main(void)
+{
+	...
+	return 0;
+}
+
+void main(void)
+{
+	struct kvm_svm_vcpu *vm;
+
+	kvm_init_svm();
+	vm = kvm_create_svm_vcpu(guest_main, 1);
+	kvm_svm_vmrun(vm);
+}
+-------------------------------------------------------------------------------
+
+- `int kvm_is_svm_supported(void)` - Returns non-zero value if the CPU
+  supports AMD SVM, otherwise returns 0.
+
+- `int kvm_get_svm_state(void)` - Returns non-zero value if SVM is currently
+  enabled, otherwise returns 0.
+
+- `void kvm_set_svm_state(int enabled)` - Enable or disable SVM according
+  to argument. If SVM is disabled by host or not supported, the test will exit
+  with `TCONF`.
+
+- `void kvm_init_svm(void)` - Enable and fully initialize SVM, including
+  allocating and setting up host save area VMCB. If SVM is disabled by host or
+  not supported, the test will exit with `TCONF`.
+
+- `struct kvm_vmcb *kvm_alloc_vmcb(void)` - Allocate new VMCB structure
+  with correct memory alignment and fill it with zeroes.
+
+- `void kvm_vmcb_set_intercept(struct kvm_vmcb *vmcb, unsigned int id, unsigned int state)` -
+  Set SVM intercept bit `id` to given `state`.
+
+- `void kvm_init_guest_vmcb(struct kvm_vmcb *vmcb, uint32_t asid, uint16_t ss, void *rsp, int (*guest_main)(void))` -
+  Initialize new SVM virtual machine. The `asid` parameter is the nested
+  page table ID. The `ss` and `rsp` parameters set the stack segment and stack
+  pointer values, respectively. The `guest_main` parameter sets the code entry
+  point of the virtual machine. All control registers, segment registers
+  (except stack segment register), GDTR and IDTR will be copied
+  from the current CPU state.
+
+- `struct kvm_svm_vcpu *kvm_create_svm_vcpu(int (*guest_main)(void), int alloc_stack)` -
+  Convenience function for allocating and initializing new SVM virtual CPU.
+  The `guest_main` parameter is passed to `kvm_init_guest_vmcb()`,
+  the `alloc_stack` parameter controls whether a new 8KB stack will be
+  allocated and registered in GDT. Interception will be enabled for `VMSAVE`
+  and `HLT` instructions. If you set `alloc_stack` to zero, you must configure
+  the stack segment register and stack pointer manually.
+
+- `void kvm_svm_vmrun(struct kvm_svm_vcpu *cpu)` - Start or continue execution
+  of a nested virtual machine. Beware that FPU state is not saved.  Do not use
+  floating point types or values in nested guest code. Also do not use
+  `tst_res()` or `tst_brk()` functions in nested guest code.
+
+See AMD64 Architecture Programmer's Manual Volume 2 for documentation
+of the Secure Virtual Machine (SVM) technology.
+
 4. KVM guest environment
 ------------------------
 
diff --git a/testcases/kernel/kvm/bootstrap_x86.S b/testcases/kernel/kvm/bootstrap_x86.S
index 89f73eba1..a39c6bea7 100644
--- a/testcases/kernel/kvm/bootstrap_x86.S
+++ b/testcases/kernel/kvm/bootstrap_x86.S
@@ -9,6 +9,8 @@
 .set RESULT_ADDRESS, 0xfffff000
 .set KVM_GDT_SIZE, 32
 
+.set MSR_VM_HSAVE_PA, 0xc0010117
+
 /*
  * This section will be allocated at address 0x1000 and
  * jumped to from the reset stub provided by kvm_run.
@@ -351,6 +353,83 @@ kvm_yield:
 	hlt
 	ret
 
+.global kvm_svm_guest_entry
+kvm_svm_guest_entry:
+	call *%eax
+1:	hlt
+	jmp 1b
+
+.global kvm_svm_vmrun
+kvm_svm_vmrun:
+	push %edi
+	mov 8(%esp), %edi
+	push %ebx
+	push %esi
+	push %ebp
+
+	clgi
+
+	/* Save full host state */
+	movl $MSR_VM_HSAVE_PA, %ecx
+	rdmsr
+	vmsave
+	push %eax
+
+	/* Load guest registers */
+	push %edi
+	movl (%edi), %eax
+	/* %eax is loaded by vmrun from VMCB */
+	movl 0x0c(%edi), %ebx
+	movl 0x14(%edi), %ecx
+	movl 0x1c(%edi), %edx
+	movl 0x2c(%edi), %esi
+	movl 0x34(%edi), %ebp
+	/* %esp is loaded by vmrun from VMCB */
+	movl 0x24(%edi), %edi
+
+	vmload
+	vmrun
+	vmsave
+
+	/* Clear guest register buffer */
+	push %edi
+	push %ecx
+	movl 8(%esp), %edi
+	addl $4, %edi
+	xorl %eax, %eax
+	mov $32, %ecx
+	pushfl
+	cld
+	rep stosl
+	popfl
+
+	/* Save guest registers */
+	pop %ecx
+	pop %eax
+	pop %edi
+	movl %ebx, 0x0c(%edi)
+	movl %ecx, 0x14(%edi)
+	movl %edx, 0x1c(%edi)
+	movl %eax, 0x24(%edi)
+	movl %esi, 0x2c(%edi)
+	movl %ebp, 0x34(%edi)
+	/* Copy %eax and %esp from VMCB */
+	movl (%edi), %esi
+	movl 0x5f8(%esi), %eax
+	movl %eax, 0x04(%edi)
+	movl 0x5d8(%esi), %eax
+	movl %eax, 0x3c(%edi)
+
+	pop %eax
+	vmload
+	stgi
+
+	pop %ebp
+	pop %esi
+	pop %ebx
+	pop %edi
+	ret
+
 
 .section .bss.pgtables, "aw", @nobits
 .global kvm_pagetable
diff --git a/testcases/kernel/kvm/bootstrap_x86_64.S b/testcases/kernel/kvm/bootstrap_x86_64.S
index e4d160b2e..b02dd4d92 100644
--- a/testcases/kernel/kvm/bootstrap_x86_64.S
+++ b/testcases/kernel/kvm/bootstrap_x86_64.S
@@ -10,6 +10,8 @@
 .set RESULT_ADDRESS, 0xfffff000
 .set KVM_GDT_SIZE, 32
 
+.set MSR_VM_HSAVE_PA, 0xc0010117
+
 /*
  * This section will be allocated at address 0x1000 and
  * jumped to from the reset stub provided by kvm_run.
@@ -474,6 +476,93 @@ kvm_yield:
 	hlt
 	ret
 
+.global kvm_svm_guest_entry
+kvm_svm_guest_entry:
+	call *%rax
+1:	hlt
+	jmp 1b
+
+.global kvm_svm_vmrun
+kvm_svm_vmrun:
+	pushq %rbx
+	pushq %rbp
+	pushq %r12
+	pushq %r13
+	pushq %r14
+	pushq %r15
+
+	clgi
+
+	/* Save full host state */
+	movq $MSR_VM_HSAVE_PA, %rcx
+	rdmsr
+	shlq $32, %rdx
+	orq %rdx, %rax
+	vmsave
+	pushq %rax
+
+	/* Load guest registers */
+	pushq %rdi
+	movq (%rdi), %rax
+	/* %rax is loaded by vmrun from VMCB */
+	movq 0x10(%rdi), %rbx
+	movq 0x18(%rdi), %rcx
+	movq 0x20(%rdi), %rdx
+	movq 0x30(%rdi), %rsi
+	movq 0x38(%rdi), %rbp
+	/* %rsp is loaded by vmrun from VMCB */
+	movq 0x48(%rdi), %r8
+	movq 0x50(%rdi), %r9
+	movq 0x58(%rdi), %r10
+	movq 0x60(%rdi), %r11
+	movq 0x68(%rdi), %r12
+	movq 0x70(%rdi), %r13
+	movq 0x78(%rdi), %r14
+	movq 0x80(%rdi), %r15
+	movq 0x28(%rdi), %rdi
+
+	vmload
+	vmrun
+	vmsave
+
+	/* Save guest registers */
+	movq %rdi, %rax
+	popq %rdi
+	movq %rbx, 0x10(%rdi)
+	movq %rcx, 0x18(%rdi)
+	movq %rdx, 0x20(%rdi)
+	/* %rax contains guest %rdi */
+	movq %rax, 0x28(%rdi)
+	movq %rsi, 0x30(%rdi)
+	movq %rbp, 0x38(%rdi)
+	movq %r8,  0x48(%rdi)
+	movq %r9,  0x50(%rdi)
+	movq %r10, 0x58(%rdi)
+	movq %r11, 0x60(%rdi)
+	movq %r12, 0x68(%rdi)
+	movq %r13, 0x70(%rdi)
+	movq %r14, 0x78(%rdi)
+	movq %r15, 0x80(%rdi)
+	/* copy guest %rax and %rsp from VMCB*/
+	movq (%rdi), %rsi
+	movq 0x5f8(%rsi), %rax
+	movq %rax, 0x08(%rdi)
+	movq 0x5d8(%rsi), %rax
+	movq %rax, 0x40(%rdi)
+
+	/* Reload host state */
+	popq %rax
+	vmload
+
+	stgi
+
+	popq %r15
+	popq %r14
+	popq %r13
+	popq %r12
+	popq %rbp
+	popq %rbx
+	retq
 
 .section .bss.pgtables, "aw", @nobits
 .global kvm_pagetable
diff --git a/testcases/kernel/kvm/include/kvm_x86.h b/testcases/kernel/kvm/include/kvm_x86.h
index a94f05451..bc36c0e0f 100644
--- a/testcases/kernel/kvm/include/kvm_x86.h
+++ b/testcases/kernel/kvm/include/kvm_x86.h
@@ -64,16 +64,25 @@
 /* CPUID constants */
 #define CPUID_GET_INPUT_RANGE 0x80000000
 #define CPUID_GET_EXT_FEATURES 0x80000001
+#define CPUID_GET_SVM_FEATURES 0x8000000a
 
 
 /* Model-specific CPU register constants */
 #define MSR_EFER 0xc0000080
+#define MSR_VM_CR 0xc0010114
+#define MSR_VM_HSAVE_PA 0xc0010117
 
 #define EFER_SCE (1 << 0)	/* SYSCALL/SYSRET instructions enabled */
 #define EFER_LME (1 << 8)	/* CPU is running in 64bit mode */
 #define EFER_LMA (1 << 10)	/* CPU uses 64bit memory paging (read-only) */
 #define EFER_NXE (1 << 11)	/* Execute disable bit active */
+#define EFER_SVME (1 << 12)	/* AMD SVM instructions enabled */
 
+#define VM_CR_DPD (1 << 0)
+#define VM_CR_R_INIT (1 << 1)
+#define VM_CR_DIS_A20M (1 << 2)
+#define VM_CR_LOCK (1 << 3)
+#define VM_CR_SVMDIS (1 << 4)
 
 /* Control register constants */
 #define CR4_VME (1 << 0)
@@ -162,6 +171,11 @@ struct kvm_sregs {
 	uint16_t cs, ds, es, fs, gs, ss;
 };
 
+struct kvm_regs64 {
+	uint64_t rax, rbx, rcx, rdx, rdi, rsi, rbp, rsp;
+	uint64_t r8, r9, r10, r11, r12, r13, r14, r15;
+};
+
 extern struct page_table_entry_pae kvm_pagetable[];
 extern struct intr_descriptor kvm_idt[X86_INTR_COUNT];
 extern struct segment_descriptor kvm_gdt[KVM_GDT_SIZE];
diff --git a/testcases/kernel/kvm/include/kvm_x86_svm.h b/testcases/kernel/kvm/include/kvm_x86_svm.h
new file mode 100644
index 000000000..965d1e716
--- /dev/null
+++ b/testcases/kernel/kvm/include/kvm_x86_svm.h
@@ -0,0 +1,157 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2023 SUSE LLC <mdoucha@suse.cz>
+ *
+ * x86-specific KVM helper functions and structures for AMD SVM
+ */
+
+#ifndef KVM_X86_SVM_H_
+#define KVM_X86_SVM_H_
+
+#include "kvm_x86.h"
+
+/* CPUID_GET_SVM_FEATURES flags returned in EDX */
+#define SVM_CPUID_NESTED_PAGING (1 << 0)
+#define SVM_CPUID_LBR_VIRT (1 << 1)
+#define SVM_CPUID_LOCK (1 << 2)
+#define SVM_CPUID_NRIP_SAVE (1 << 3)
+#define SVM_CPUID_TSC_RATE_MSR (1 << 4)
+#define SVM_CPUID_VMCB_CLEAN (1 << 5)
+#define SVM_CPUID_FLUSH_ASID (1 << 6)
+#define SVM_CPUID_DECODE_ASSIST (1 << 7)
+#define SVM_CPUID_PAUSE_FILTER (1 << 10)
+#define SVM_CPUID_PAUSE_THRESHOLD (1 << 12)
+#define SVM_CPUID_AVIC (1 << 13)
+#define SVM_CPUID_VMSAVE_VIRT (1 << 15)
+#define SVM_CPUID_VGIF (1 << 16)
+#define SVM_CPUID_GMET (1 << 17)
+#define SVM_CPUID_X2AVIC (1 << 18)
+#define SVM_CPUID_SSSCHECK (1 << 19)
+#define SVM_CPUID_SPEC_CTRL (1 << 20)
+#define SVM_CPUID_ROGPT (1 << 21)
+#define SVM_CPUID_HOST_MCE_OVERRIDE (1 << 23)
+#define SVM_CPUID_TLBI_CTL (1 << 24)
+#define SVM_CPUID_NMI_VIRT (1 << 25)
+#define SVM_CPUID_IBS_VIRT (1 << 26)
+
+/* SVM event intercept IDs */
+#define SVM_INTERCEPT_HLT 0x78
+#define SVM_INTERCEPT_VMRUN 0x80
+#define SVM_INTERCEPT_MAX 0x95
+
+/* SVM vmrun exit codes */
+#define SVM_EXIT_HLT 0x78
+#define SVM_EXIT_AVIC_NOACCEL 0x402
+#define SVM_EXIT_INVALID ((uint64_t)-1)
+
+/* SVM VMCB flags */
+#define SVM_INTR_AVIC (1 << 7)
+
+struct kvm_vmcb_descriptor {
+	uint16_t selector;
+	uint16_t attrib;
+	uint32_t limit;
+	uint64_t base;
+};
+
+struct kvm_vmcb {
+	/* VMCB control area */
+	uint8_t intercepts[20];
+	uint8_t reserved1[44];
+	uint64_t iopm_base_addr;
+	uint64_t msrpm_base_addr;
+	uint64_t tsc_offset;
+	uint32_t guest_asid;
+	uint32_t tlb_control;
+	uint8_t virtual_tpr;
+	uint8_t virtual_irq;
+	unsigned char virt_intr_prio: 4;
+	unsigned char virt_ignore_tpr: 4;
+	uint8_t virt_intr_ctl;
+	uint8_t virt_intr_vector;
+	uint8_t reserved2[3];
+	uint64_t interrupt_shadow;
+	uint64_t exitcode;
+	uint64_t exitinfo1;
+	uint64_t exitinfo2;
+	uint64_t exit_int_info;
+	uint64_t enable_nested_paging;
+	uint64_t avic_bar;
+	uint64_t ghcb_gpa;
+	uint64_t event_injection;
+	uint64_t nested_cr3;
+	uint64_t virt_ext;
+	uint32_t vmcb_clean;
+	uint8_t reserved3[4];
+	uint64_t next_rip;
+	uint8_t instr_len;
+	uint8_t instr_bytes[15];
+	uint64_t avic_backing_page;
+	uint8_t reserved4[8];
+	uint64_t avic_logical_ptr;
+	uint64_t avic_physical_ptr;
+	uint8_t reserved5[8];
+	uint64_t vmsa_pa;
+	uint64_t vmgexit_rax;
+	uint8_t vmgexit_cpl;
+	uint8_t reserved6[0x2e7];
+
+	/* VMCB state save area */
+	struct kvm_vmcb_descriptor es, cs, ss, ds, fs, gs;
+	struct kvm_vmcb_descriptor gdtr, ldtr, idtr, tr;
+	uint8_t reserved7[43];
+	uint8_t cpl;
+	uint8_t reserved8[4];
+	uint64_t efer;
+	uint8_t reserved9[112];
+	uint64_t cr4;
+	uint64_t cr3;
+	uint64_t cr0;
+	uint64_t dr7;
+	uint64_t dr6;
+	uint64_t rflags;
+	uint64_t rip;
+	uint8_t reserved10[88];
+	uint64_t rsp;
+	uint64_t s_cet;
+	uint64_t ssp;
+	uint64_t isst_addr;
+	uint64_t rax;
+	uint64_t star;
+	uint64_t lstar;
+	uint64_t cstar;
+	uint64_t sfmask;
+	uint64_t kernel_gs_base;
+	uint64_t sysenter_cs;
+	uint64_t sysenter_esp;
+	uint64_t sysenter_eip;
+	uint64_t cr2;
+	uint8_t reserved11[32];
+	uint64_t guest_pat;
+	uint8_t padding[0x990];
+};
+
+struct kvm_svm_vcpu {
+	struct kvm_vmcb *vmcb;
+	struct kvm_regs64 regs;
+};
+
+/* AMD SVM virtualization helper functions */
+int kvm_is_svm_supported(void);
+int kvm_get_svm_state(void);
+void kvm_set_svm_state(int enabled);
+
+void kvm_init_svm(void);	/* Fully initialize host SVM environment */
+struct kvm_vmcb *kvm_alloc_vmcb(void);
+void kvm_vmcb_copy_gdt_descriptor(struct kvm_vmcb_descriptor *dst,
+	unsigned int gdt_id);
+void kvm_vmcb_set_intercept(struct kvm_vmcb *vmcb, unsigned int id,
+	unsigned int state);
+void kvm_init_guest_vmcb(struct kvm_vmcb *vmcb, uint32_t asid, uint16_t ss,
+	void *rsp, int (*guest_main)(void));
+struct kvm_svm_vcpu *kvm_create_svm_vcpu(int (*guest_main)(void),
+	int alloc_stack);
+
+void kvm_svm_vmrun(struct kvm_svm_vcpu *cpu);
+
+#endif /* KVM_X86_SVM_H_ */
diff --git a/testcases/kernel/kvm/lib_x86.c b/testcases/kernel/kvm/lib_x86.c
index d206072ee..3e6656f11 100644
--- a/testcases/kernel/kvm/lib_x86.c
+++ b/testcases/kernel/kvm/lib_x86.c
@@ -5,7 +5,9 @@
  * x86-specific KVM helper functions
  */
 
-#include "kvm_x86.h"
+#include "kvm_x86_svm.h"
+
+void kvm_svm_guest_entry(void);
 
 struct kvm_interrupt_frame {
 	uintptr_t eip, cs, eflags, esp, ss;
@@ -240,3 +242,154 @@ uintptr_t kvm_get_interrupt_ip(const struct kvm_interrupt_frame *ifrm)
 {
 	return ifrm->eip;
 }
+
+int kvm_is_svm_supported(void)
+{
+	struct kvm_cpuid buf;
+
+	kvm_get_cpuid(CPUID_GET_INPUT_RANGE, 0, &buf);
+
+	if (buf.eax < CPUID_GET_EXT_FEATURES)
+		return 0;
+
+	kvm_get_cpuid(CPUID_GET_EXT_FEATURES, 0, &buf);
+	return buf.ecx & 0x4;
+}
+
+int kvm_get_svm_state(void)
+{
+	return kvm_rdmsr(MSR_EFER) & EFER_SVME;
+}
+
+void kvm_set_svm_state(int enabled)
+{
+	uint64_t value;
+
+	if (!kvm_is_svm_supported())
+		tst_brk(TCONF, "CPU does not support SVM");
+
+	if (kvm_rdmsr(MSR_VM_CR) & VM_CR_SVMDIS)
+		tst_brk(TCONF, "SVM is supported but disabled");
+
+	value = kvm_rdmsr(MSR_EFER);
+
+	if (enabled)
+		value |= EFER_SVME;
+	else
+		value &= ~EFER_SVME;
+
+	kvm_wrmsr(MSR_EFER, value);
+}
+
+struct kvm_vmcb *kvm_alloc_vmcb(void)
+{
+	struct kvm_vmcb *ret;
+
+	ret = tst_heap_alloc_aligned(sizeof(struct kvm_vmcb), PAGESIZE);
+	memset(ret, 0, sizeof(struct kvm_vmcb));
+	return ret;
+}
+
+void kvm_init_svm(void)
+{
+	kvm_set_svm_state(1);
+	kvm_wrmsr(MSR_VM_HSAVE_PA, (uintptr_t)kvm_alloc_vmcb());
+}
+
+void kvm_vmcb_copy_gdt_descriptor(struct kvm_vmcb_descriptor *dst,
+	unsigned int gdt_id)
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
+		memset(dst, 0, sizeof(struct kvm_vmcb_descriptor));
+		return;
+	}
+
+	if (flags & SEGFLAG_PAGE_LIMIT)
+		limit = (limit << 12) | 0xfff;
+
+	dst->selector = gdt_id << 3;
+	dst->attrib = flags;
+	dst->limit = limit;
+	dst->base = baseaddr;
+}
+
+void kvm_vmcb_set_intercept(struct kvm_vmcb *vmcb, unsigned int id,
+	unsigned int state)
+{
+	unsigned int addr = id / 8, bit = 1 << (id % 8);
+
+	if (id >= SVM_INTERCEPT_MAX)
+		tst_brk(TBROK, "Invalid SVM intercept ID");
+
+	if (state)
+		vmcb->intercepts[addr] |= bit;
+	else
+		vmcb->intercepts[addr] &= ~bit;
+}
+
+void kvm_init_guest_vmcb(struct kvm_vmcb *vmcb, uint32_t asid, uint16_t ss,
+	void *rsp, int (*guest_main)(void))
+{
+	struct kvm_cregs cregs;
+	struct kvm_sregs sregs;
+
+	kvm_read_cregs(&cregs);
+	kvm_read_sregs(&sregs);
+
+	kvm_vmcb_set_intercept(vmcb, SVM_INTERCEPT_VMRUN, 1);
+	kvm_vmcb_set_intercept(vmcb, SVM_INTERCEPT_HLT, 1);
+
+	kvm_vmcb_copy_gdt_descriptor(&vmcb->es, sregs.es >> 3);
+	kvm_vmcb_copy_gdt_descriptor(&vmcb->cs, sregs.cs >> 3);
+	kvm_vmcb_copy_gdt_descriptor(&vmcb->ss, ss);
+	kvm_vmcb_copy_gdt_descriptor(&vmcb->ds, sregs.ds >> 3);
+	kvm_vmcb_copy_gdt_descriptor(&vmcb->fs, sregs.fs >> 3);
+	kvm_vmcb_copy_gdt_descriptor(&vmcb->gs, sregs.gs >> 3);
+	vmcb->gdtr.base = (uintptr_t)kvm_gdt;
+	vmcb->gdtr.limit = (KVM_GDT_SIZE*sizeof(struct segment_descriptor)) - 1;
+	vmcb->idtr.base = (uintptr_t)kvm_idt;
+	vmcb->idtr.limit = (X86_INTR_COUNT*sizeof(struct intr_descriptor)) - 1;
+
+	vmcb->guest_asid = asid;
+	vmcb->efer = kvm_rdmsr(MSR_EFER);
+	vmcb->cr0 = cregs.cr0;
+	vmcb->cr3 = cregs.cr3;
+	vmcb->cr4 = cregs.cr4;
+	vmcb->rip = (uintptr_t)kvm_svm_guest_entry;
+	vmcb->rax = (uintptr_t)guest_main;
+	vmcb->rsp = (uintptr_t)rsp;
+	vmcb->rflags = 0x200;	/* Interrupts enabled */
+}
+
+struct kvm_svm_vcpu *kvm_create_svm_vcpu(int (*guest_main)(void),
+	int alloc_stack)
+{
+	uint16_t ss = 0;
+	char *stack = NULL;
+	struct kvm_vmcb *vmcb;
+	struct kvm_svm_vcpu *ret;
+
+	vmcb = kvm_alloc_vmcb();
+
+	if (alloc_stack) {
+		stack = tst_heap_alloc_aligned(2 * PAGESIZE, PAGESIZE);
+		ss = kvm_create_stack_descriptor(kvm_gdt, KVM_GDT_SIZE, stack);
+		stack += 2 * PAGESIZE;
+	}
+
+	kvm_init_guest_vmcb(vmcb, 1, ss, stack, guest_main);
+	ret = tst_heap_alloc(sizeof(struct kvm_svm_vcpu));
+	memset(ret, 0, sizeof(struct kvm_svm_vcpu));
+	ret->vmcb = vmcb;
+	return ret;
+}
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
