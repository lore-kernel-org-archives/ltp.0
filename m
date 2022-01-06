Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF9DC433EF
	for <ltp@archiver.kernel.org>; Thu,  6 Jan 2022 16:54:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 29BEE3C7B55
	for <ltp@archiver.kernel.org>; Thu,  6 Jan 2022 17:54:48 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 65EA03C1301
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 17:54:38 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D0026600C60
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 17:54:36 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BAE591F385
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 16:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641488075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9nOa2eeMz/rjyEUPezZNCRmc+W+VwO5z7l7BtSToguI=;
 b=NSLO9SWC8I+/5hE8Mbwk7hwwVDC2EJvIbpv3O7AnRKYJF9lZIR4Ugc0Qty2gwKQkcL7a1v
 W3U2EInz/SthtIH3+zXIgVB4sN6YTUXBe47ktLKMU9t/CTBxXB5dX1g2MI4m+79VmGGb+L
 ZvTEpXIAQ2dLxC6BvhKrGY/F2D1ZMyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641488075;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9nOa2eeMz/rjyEUPezZNCRmc+W+VwO5z7l7BtSToguI=;
 b=RwAvIW8lON9x0vkHbUmDOigr058sB1JTQua8oXIwACLfrvBubhWbE+17PNq2dr2mZNOjyq
 N8wtgCcl+gIHTEDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C7F613C60
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 16:54:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XBo5Jcse12EYGQAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 06 Jan 2022 16:54:35 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  6 Jan 2022 17:54:35 +0100
Message-Id: <20220106165435.16556-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] RFC: KVM test infrastructure (WIP)
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

*** DO NOT MERGE THIS PATCH ***

This is a tech demo of the new KVM test library for LTP. The code has 3 main
parts:
- KVM host library
  - host_lib.c
- KVM guest library
  - boostrap.S
  - guest_lib.c
  - kvm_x86.c
- Tests
  - kvm_pagefault01.c

The host library provides functions for setting up and running virtual machines
with test payload built from test sources.

The guest library provides CPU bootstrap code and basic implementation of
some C and LTP library functions as well as functions for accessing low-level
arch features like special registers, interrupt tables or memory mapping tables.

The test sources contain both guest-side payload code and host-side setup code
separated by preprocessor switch. The files get compiled twice with different
compiler options. Once to build the VM payload, once to build the main program
that will create the VM and execute the payload inside it.

The KVM tests currently work only on x86_64. I'm still working on implementing
i386 bootstrap code and skipping the build on unsupported archs.

Beware that if you merge this patch into LTP upstream in this state, you'll
break LTP compilation on all non-x86 archs. This code is intended
for discussion and private experiments only.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 include/mk/env_post.mk                    |   1 +
 include/mk/rules.mk                       |   8 +
 testcases/kernel/Makefile                 |   1 +
 testcases/kernel/kvm/Makefile             |  53 +++
 testcases/kernel/kvm/bootstrap_x86.S      | 372 ++++++++++++++++++++++
 testcases/kernel/kvm/guest_lib.c          |  92 ++++++
 testcases/kernel/kvm/host_lib.c           | 208 ++++++++++++
 testcases/kernel/kvm/include/kvm_common.h |  31 ++
 testcases/kernel/kvm/include/kvm_guest.h  |  47 +++
 testcases/kernel/kvm/include/kvm_host.h   | 115 +++++++
 testcases/kernel/kvm/include/kvm_test.h   |  23 ++
 testcases/kernel/kvm/include/kvm_x86.h    |  61 ++++
 testcases/kernel/kvm/kvm_pagefault01.c    | 104 ++++++
 testcases/kernel/kvm/kvm_x86.c            |  54 ++++
 testcases/kernel/kvm/layout-x86_64.lds    |  67 ++++
 testcases/kernel/kvm/payload.lds          |  11 +
 16 files changed, 1248 insertions(+)
 create mode 100644 testcases/kernel/kvm/Makefile
 create mode 100644 testcases/kernel/kvm/bootstrap_x86.S
 create mode 100644 testcases/kernel/kvm/guest_lib.c
 create mode 100644 testcases/kernel/kvm/host_lib.c
 create mode 100644 testcases/kernel/kvm/include/kvm_common.h
 create mode 100644 testcases/kernel/kvm/include/kvm_guest.h
 create mode 100644 testcases/kernel/kvm/include/kvm_host.h
 create mode 100644 testcases/kernel/kvm/include/kvm_test.h
 create mode 100644 testcases/kernel/kvm/include/kvm_x86.h
 create mode 100644 testcases/kernel/kvm/kvm_pagefault01.c
 create mode 100644 testcases/kernel/kvm/kvm_x86.c
 create mode 100644 testcases/kernel/kvm/layout-x86_64.lds
 create mode 100644 testcases/kernel/kvm/payload.lds

diff --git a/include/mk/env_post.mk b/include/mk/env_post.mk
index ec045c40d..dc4df41d3 100644
--- a/include/mk/env_post.mk
+++ b/include/mk/env_post.mk
@@ -32,6 +32,7 @@ ENV_POST_LOADED = 1
 # poor software design if you need more than one search directory, and
 # would suggest creating a general purpose static library to that end.
 vpath %.c $(abs_srcdir)
+vpath %.S $(abs_srcdir)
 
 # For config.h, et all.
 CPPFLAGS			+= -I$(top_srcdir)/include -I$(top_builddir)/include -I$(top_srcdir)/include/old/
diff --git a/include/mk/rules.mk b/include/mk/rules.mk
index a60e6705a..32d8d05a7 100644
--- a/include/mk/rules.mk
+++ b/include/mk/rules.mk
@@ -1,5 +1,13 @@
 target_rel_dir := $(if $(cwd_rel_from_top),$(cwd_rel_from_top)/,)
 
+%.o: %.S
+ifdef VERBOSE
+	$(AS) $(ASFLAGS) -c -o $@ $<
+else
+	@$(AS) $(ASFLAGS) -c -o $@ $<
+	@echo AS $(target_rel_dir)$@
+endif
+
 %.o: %.c
 ifdef VERBOSE
 	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
diff --git a/testcases/kernel/Makefile b/testcases/kernel/Makefile
index 4604f1f38..bad5c03a5 100644
--- a/testcases/kernel/Makefile
+++ b/testcases/kernel/Makefile
@@ -29,6 +29,7 @@ SUBDIRS			+= connectors \
 			   io \
 			   ipc \
 			   irq \
+			   kvm \
 			   logging \
 			   mem \
 			   numa \
diff --git a/testcases/kernel/kvm/Makefile b/testcases/kernel/kvm/Makefile
new file mode 100644
index 000000000..87691cd78
--- /dev/null
+++ b/testcases/kernel/kvm/Makefile
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2021 Linux Test Project
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+CPPFLAGS += -I$(abs_srcdir)/include
+GUEST_CPPFLAGS = $(CPPFLAGS) -DCOMPILE_PAYLOAD
+GUEST_CFLAGS = -ffreestanding -O2 -Wall -fno-asynchronous-unwind-tables -mno-mmx -mno-sse
+GUEST_LDFLAGS = -nostdlib -Wl,--build-id=none
+GUEST_LDLIBS =
+
+FILTER_OUT_MAKE_TARGETS := bootstrap kvm_x86 guest_lib host_lib
+
+ifeq ($(HOST_CPU),x86_64)
+	ifneq (,$(findstring m32,$(CFLAGS)))
+		HOST_CPU = x86
+		GUEST_CFLAGS += -m32
+	endif
+endif
+
+GUEST_LDFLAGS += -T $(abs_srcdir)/layout-$(HOST_CPU).lds
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+ifeq ($(HOST_CPU),x86_64)
+ARCH_OBJ = bootstrap_x86.o kvm_x86.o
+BIN_FORMAT=elf64-x86-64
+else ifeq ($(HOST_CPU),x86)
+ARCH_OBJ = bootstrap_x86.o kvm_x86.o
+BIN_FORMAT=elf32-i386
+else
+MAKE_TARGETS =
+endif
+
+guest_lib.o $(ARCH_OBJ): CPPFLAGS	:= $(GUEST_CPPFLAGS)
+guest_lib.o $(ARCH_OBJ): CFLAGS		:= $(GUEST_CFLAGS)
+
+%-payload.o: %.c guest_lib.o $(ARCH_OBJ)
+ifdef VERBOSE
+	$(CC) $(GUEST_CPPFLAGS) $(GUEST_CFLAGS) $(GUEST_LDFLAGS) $^ $(GUEST_LDLIBS) -o $*-payload.elf
+	objcopy -O binary -j .init.boot -j .text -j .data --gap-fill=0 $*-payload.elf $*-payload.bin
+	ld -r -T $(abs_srcdir)/payload.lds --oformat=$(BIN_FORMAT) -o $@ $*-payload.bin
+else
+	@$(CC) $(GUEST_CPPFLAGS) $(GUEST_CFLAGS) $(GUEST_LDFLAGS) $^ $(GUEST_LDLIBS) -o $*-payload.elf
+	@objcopy -O binary -j .init.boot -j .text -j .data --gap-fill=0 $*-payload.elf $*-payload.bin
+	@ld -r -T $(abs_srcdir)/payload.lds --oformat=$(BIN_FORMAT) -o $@ $*-payload.bin
+	@echo KVM_CC $(target_rel_dir)$@
+endif
+	@rm $*-payload.elf $*-payload.bin
+
+$(MAKE_TARGETS): %: %-payload.o host_lib.o
diff --git a/testcases/kernel/kvm/bootstrap_x86.S b/testcases/kernel/kvm/bootstrap_x86.S
new file mode 100644
index 000000000..a483a8377
--- /dev/null
+++ b/testcases/kernel/kvm/bootstrap_x86.S
@@ -0,0 +1,372 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020 SUSE LLC
+ * Author: Nicolai Stange <nstange@suse.de>
+ * LTP port: Martin Doucha <mdoucha@suse.cz>
+ */
+
+.set KVM_TCONF, 32
+.set RESULT_ADDRESS, 0xfffff000
+
+/*
+ * This section will be allocated at address 0x1000 and
+ * jumped to from the reset stub provided by kvm_run.
+ */
+.code16
+.section .init.protected_mode, "ax"
+real_mode_entry:
+	cli
+
+	lgdt kvm_gdt32_desc
+
+	mov $0x11, %eax
+	mov %eax, %cr0
+
+	jmp $3 * 8,$protected_mode_entry
+
+.code32
+protected_mode_entry:
+	mov $2 * 8, %eax
+	mov %eax, %ds
+	mov %eax, %es
+	jmp init_long_mode
+
+.section .data.gdt32, "a", @progbits
+
+.macro gdt32_entry type:req l=0 d=0 dpl=0 limit=0xfffff g=1 p=1
+	.4byte \limit & 0xffff
+	.2byte (\type << 8) | (\dpl << 13) | (\p << 15)
+	.2byte (\limit >> 16) | (\l << 5) | (\d << 6) | (\g << 7)
+.endm
+.align 8
+.global kvm_gdt32
+kvm_gdt32:
+	.8byte 0
+	gdt32_entry type=0x1a l=1 /* Code segment long mode */
+	gdt32_entry type=0x12 /* Data segment, writable */
+	gdt32_entry type=0x1a l=0 d=1 /* Code segment protected_mode, 32bits */
+.Lgdt32_end:
+.global kvm_gdt32_desc
+kvm_gdt32_desc:
+	.2byte .Lgdt32_end - kvm_gdt32 - 1
+	.4byte kvm_gdt32
+
+long_mode_err:
+	.ascii "Virtual CPU does not support 64bit mode\0"
+
+.code32
+.section .init.long_mode, "ax"
+init_long_mode:
+	/*
+	 * Identity-map the first 2GB of virtual address space.
+	 */
+	lea kvm_pagetable, %edi
+
+	/*
+	 * Set the first entry of kvm_pagetable (level 1) and fill the rest
+	 * of the page with zeroes.
+	 */
+	lea kvm_pgtable_l2, %esi
+	movl %esi, %ebx
+	orl $0x3, %ebx		/* Flags: present, writable */
+	movl %ebx, (%edi)
+	addl $4, %edi
+	movl $1023, %ecx
+	xor %eax, %eax
+	rep stosl
+
+	/*
+	 * Set the first four entries of kvm_pgtable_l2 and fill the rest
+	 * of the page with zeroes.
+	 */
+	mov %esi, %edi
+	lea kvm_pgtable_l3, %esi
+	movl %esi, %eax
+	mov $4, %ecx
+
+1:	movl %eax, %ebx
+	orl $0x3, %ebx		/* Flags: present, writable */
+	movl %ebx, (%edi)
+	movl $0, 4(%edi)
+	addl $8, %edi
+	addl $4096, %eax
+	dec %ecx
+	jnz 1b
+
+	movl $1016, %ecx
+	xor %eax, %eax
+	rep stosl
+
+	/* Fill kvm_pgtable_l3 with pointers to kvm_pgtable_l4 */
+	mov %esi, %edi
+	lea kvm_pgtable_l4, %esi
+	movl %esi, %eax
+	mov $4 * 512, %ecx
+
+1:	movl %eax, %ebx
+	orl $0x3, %ebx		/* Flags: present, writable */
+	movl %ebx, (%edi)
+	movl $0, 4(%edi)
+	addl $8, %edi
+	addl $4096, %eax
+	dec %ecx
+	jnz 1b
+
+	/* Fill kvm_pgtable_l4 with identity map of the first 2GB. */
+	movl %esi, %edi
+	movl $2 * 512 * 512, %ecx
+	xor %eax, %eax
+
+1:	movl %eax, %ebx
+	orl $0x3, %ebx		/* Flags: present, writable */
+	movl %ebx, (%edi)
+	movl $0, 4(%edi)
+	addl $8, %edi
+	addl $4096, %eax
+	dec %ecx
+	jnz 1b
+
+	/* Mark the upper 2GB as unmapped except for the last page. */
+	movl $4 * 512 * 512 - 2, %ecx
+	xor %eax, %eax
+	rep stosl
+	movl $0xfffff003, (%edi)
+	movl $0, 4(%edi)
+
+	/*
+	 * Now that the identity-map pagestables have been populated,
+	 * we're ready to install them at CR3 and switch to long mode.
+	 */
+	/* Enable CR4.PAE */
+	movl %cr4, %eax
+	btsl $5, %eax
+	movl %eax, %cr4
+
+	lea kvm_pagetable, %eax
+	movl %eax, %cr3
+
+	/* Check if the CPU supports long mode. */
+	movl $0x80000000, %eax
+	cpuid
+	cmpl $0x80000000, %eax
+	jg 1f
+	/*
+	 * Give the host resp. user a clue by storing the queried cpuid function
+	 * code in %eax.
+	 */
+	movl $KVM_TCONF, %edi
+	movl $long_mode_err, %esi
+	jmp init_error
+1:
+	movl $0x80000001, %eax
+	cpuid
+	bt $29, %edx
+	jc 1f
+	/*
+	 * Give the host resp. user a clue by storing the queried cpuid function
+	 * code in %eax.
+	 */
+	movl $KVM_TCONF, %edi
+	movl $long_mode_err, %esi
+	jmp init_error
+1:
+
+	/* Activate EFER.LME to enable long mode. */
+	movl $0xc0000080, %ecx
+	rdmsr
+	btsl $8, %eax
+	wrmsr
+
+	/* Enable CR0.PG and CR0.WP */
+	movl %cr0, %eax
+	btsl $31, %eax
+	btsl $16, %eax
+	movl %eax, %cr0
+
+	/* Long jmp to load the long mode %cs. */
+	jmp $1 * 8,$long_mode_entry
+
+init_error:
+	/* Write error info to test result structure and exit VM */
+	/* Equivalent to tst_exit() but using only 32bit instructions */
+	movl %edi, RESULT_ADDRESS
+	movl $RESULT_ADDRESS+4, %edi
+	xor %edx, %edx
+
+1:	movzbl (%esi,%edx,1), %eax
+	movb %al, (%edi,%edx,1)
+	inc %edx
+	test %al, %al
+	jne 1b
+2:	hlt
+	jmp 2b
+
+.code64
+long_mode_entry:
+	lgdt kvm_gdt64_desc
+
+	/*
+	 * Reset data segment selectors to NULL selector and
+	 * initialize stack.
+	 */
+	xor %eax, %eax
+	mov %eax, %ds
+	mov %eax, %es
+	mov %eax, %ss
+	lea kvm_stack_top, %rsp
+
+	/*
+	 * Strictly speaking a TSS should not be required
+	 * and experiments confirm that. However, we
+	 * might perhaps want to play games with the
+	 * interrupt/exception stacks in the future, so
+	 * install a minimal one now.
+	 */
+	lea kvm_tss, %rdx
+	movq %rdx, %rdi
+	movq $.Ltss_end - kvm_tss, %rsi
+	call memzero
+
+	movq %rsp, 4(%rdx)
+
+	/*
+	 * Create a 16 byte descriptor starting at the
+	 * 3rd 8-byte GDT slot.xs
+	 */
+	movq %rdx, %rax
+	shl $40, %rax
+	shr $24, %rax
+	movq %rdx, %rbx
+	shr $24, %rbx
+	shl $56, %rbx
+	or %rbx, %rax
+	movq $0x89, %rbx
+	shl $40, %rbx
+	or $.Ltss_end - kvm_tss - 1, %rbx
+	or %rbx, %rax
+	shr $32, %rdx
+
+	lea kvm_gdt64 + 2*8, %rdi
+	mov %rax, (%rdi)
+	mov %rdx, 8(%rdi)
+
+	mov $2 * 8, %ax
+	ltr %ax
+
+
+	/* Configure and enable interrupts */
+	call kvm_init_interrupts
+	lidt kvm_idt_desc
+	sti
+
+	/*
+	 * Do just enough of initialization to get to a working
+	 * -ffreestanding environment and call main(void).
+	 */
+	lea __preinit_array_begin, %rdi
+	lea __preinit_array_end, %rsi
+1:
+	cmp %rdi, %rsi
+	je 2f
+	call *%rdi
+	add $8, %rdi
+	jmp 1b
+2:
+
+	lea __init_array_begin, %rdi
+	lea __init_array_end, %rsi
+1:
+	cmp %rdi, %rsi
+	je 2f
+	call *%rdi
+	add $8, %rdi
+	jmp 1b
+2:
+	call main
+1:
+	hlt
+	jmp 1b
+
+.global kvm_handle_page_fault
+kvm_handle_page_fault:
+	push %rdi
+	push %rsi
+	push %rdx
+	mov %cr2, %rdi
+	mov 0x20(%rsp), %rsi
+	mov 0x18(%rsp), %rdx
+	call tst_handle_page_fault
+	pop %rdx
+	pop %rsi
+	pop %rdi
+	add $8, %rsp
+	iretq
+
+.global kvm_exit
+kvm_exit:
+	mov %rdi, %rax
+1:	hlt
+	jmp 1b
+
+.global kvm_handle_bad_exception
+kvm_handle_bad_exception:
+1:
+	ud2
+	jmp 1b
+
+
+.section .bss.pgtables, "aw", @nobits
+.global kvm_pagetable
+kvm_pagetable:
+	.skip 4096
+
+kvm_pgtable_l2:
+	.skip 4096
+
+kvm_pgtable_l3:
+	.skip 4 * 4096
+
+kvm_pgtable_l4:
+	.skip 4 * 512 * 4096
+
+.section .bss.stack, "aw", @nobits
+.global kvm_stack_bottom
+kvm_stack_bottom:
+	.skip 2 * 4096
+.global kvm_stack_top
+kvm_stack_top:
+
+.section .bss.tss
+.global kvm_tss
+kvm_tss:
+	.skip 0x68
+.Ltss_end:
+
+.section .data
+.align 8
+.global kvm_gdt64
+kvm_gdt64:
+	.8byte 0
+	gdt32_entry type=0x1a l=1 limit=0 g=0 /* Code segment long mode */
+
+	.skip 16 /* TSS segment descriptor */
+
+.Lgdt64_end:
+.global kvm_gdt64_desc
+kvm_gdt64_desc:
+	.2byte .Lgdt64_end - kvm_gdt64 - 1
+	.8byte kvm_gdt64
+
+.section .bss
+.align 8
+.global kvm_idt
+kvm_idt:
+	.skip 16 * 256
+.Lidt_end:
+
+.section .data
+.align 8
+.global kvm_idt_desc
+kvm_idt_desc:
+	.2byte .Lidt_end - kvm_idt - 1
+	.8byte kvm_idt
diff --git a/testcases/kernel/kvm/guest_lib.c b/testcases/kernel/kvm/guest_lib.c
new file mode 100644
index 000000000..5f070d246
--- /dev/null
+++ b/testcases/kernel/kvm/guest_lib.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2021 SUSE LLC <mdoucha@suse.cz>
+ *
+ * Minimal testing library for KVM tests
+ */
+
+#include "kvm_test.h"
+
+extern char kvm_heap_begin[];
+
+static struct tst_kvm_result *const test_result =
+	(struct tst_kvm_result *)KVM_RESULT_BASEADDR;
+
+static page_fault_callback_t pgf_callback;
+static void *pgf_userdata;
+static char *heap_end = kvm_heap_begin;
+
+void *memset(void *dest, int val, size_t size)
+{
+	char *ptr = dest;
+
+	while (size--)
+		*ptr++ = val;
+
+	return dest;
+}
+
+void *memzero(void *dest, size_t size)
+{
+	return memset(dest, 0, size);
+}
+
+void *memcpy(void *restrict dest, const void *restrict src, size_t size)
+{
+	char *dptr = dest;
+	const char *sptr = src;
+
+	while (size--)
+		*dptr++ = *sptr++;
+
+	return dest;
+}
+
+char *strcpy(char *restrict dest, const char *restrict src)
+{
+	char *ret = dest;
+
+	while ((*dest++ = *src++))
+		;
+
+	return ret;
+}
+
+size_t strlen(const char *str)
+{
+	size_t ret;
+
+	for (ret = 0; str[ret]; ret++)
+		;
+
+	return ret;
+}
+
+void tst_set_page_fault_callback(page_fault_callback_t func, void *userdata)
+{
+	pgf_callback = func;
+	pgf_userdata = userdata;
+}
+
+void tst_handle_page_fault(uintptr_t addr, uintptr_t ip, unsigned long errcode)
+{
+	if (!pgf_callback || !pgf_callback(pgf_userdata, addr, ip, errcode))
+		tst_exit(KVM_TBROK, "Unexpected page fault");
+}
+
+void tst_exit(int result, const char *message)
+{
+	test_result->result = result;
+	strcpy(test_result->message, message);
+	kvm_exit(0);
+}
+
+void *tst_heap_alloc(size_t size)
+{
+	void *ret = heap_end;
+
+	size += 3;
+	size -= size % 4;
+	heap_end += size;
+	return ret;
+}
diff --git a/testcases/kernel/kvm/host_lib.c b/testcases/kernel/kvm/host_lib.c
new file mode 100644
index 000000000..65e63c3fe
--- /dev/null
+++ b/testcases/kernel/kvm/host_lib.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2021 SUSE LLC <mdoucha@suse.cz>
+ *
+ * KVM host library for setting up and running virtual machine tests.
+ */
+
+#include <stdlib.h>
+#include <errno.h>
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+#include "kvm_host.h"
+
+static struct tst_kvm_instance test_vm = { .vm_fd = -1 };
+
+const char tst_kvm_reset_code[VM_RESET_CODE_SIZE] = {
+	0xea, 0x00, 0x10, 0x00, 0x00	/* JMP 0x1000 */
+};
+
+void tst_kvm_validate_result(int value)
+{
+	/* TINFO is not a valid exit result */
+	int valid_result[] = {TPASS, TFAIL, TBROK, TWARN, TCONF};
+	size_t i;
+
+	if (value == KVM_TNONE)
+		tst_brk(TBROK, "KVM test did not return any result");
+
+	for (i = 0; i < ARRAY_SIZE(valid_result); i++) {
+		if (value == valid_result[i])
+			return;
+	}
+
+	tst_brk(TBROK, "KVM test returned invalid result value %d", value);
+}
+
+void *tst_kvm_alloc_memory(int vm, unsigned int slot, uint64_t baseaddr,
+	size_t size, unsigned int flags)
+{
+	size_t pagesize;
+	void *ret;
+	struct kvm_userspace_memory_region memslot = {
+		.slot = slot,
+		.flags = flags
+	};
+
+	pagesize = SAFE_SYSCONF(_SC_PAGESIZE);
+	size += (baseaddr % pagesize) + pagesize - 1;
+	baseaddr -= baseaddr % pagesize;
+	size -= size % pagesize;
+	ret = tst_alloc(size);
+
+	memslot.guest_phys_addr = baseaddr;
+	memslot.memory_size = size;
+	memslot.userspace_addr = (__u64)ret;
+	SAFE_IOCTL(vm, KVM_SET_USER_MEMORY_REGION, &memslot);
+	return ret;
+}
+
+struct kvm_cpuid2 *tst_kvm_get_cpuid(int sysfd)
+{
+	unsigned int count;
+	int result;
+	struct kvm_cpuid2 *ret;
+
+	if (!SAFE_IOCTL(sysfd, KVM_CHECK_EXTENSION, KVM_CAP_EXT_CPUID))
+		return NULL;
+
+	for (count = 8; count < 1 << 30; count *= 2) {
+		ret = SAFE_MALLOC(sizeof(struct kvm_cpuid2) +
+			count * sizeof(struct kvm_cpuid_entry2));
+		ret->nent = count;
+		errno = 0;
+		result = ioctl(sysfd, KVM_GET_SUPPORTED_CPUID, ret);
+
+		if (!result)
+			return ret;
+
+		free(ret);
+
+		if (errno != E2BIG)
+			break;
+	}
+
+	tst_brk(TBROK | TERRNO, "ioctl(KVM_GET_SUPPORTED_CPUID) failed");
+	return NULL;
+}
+
+void tst_kvm_create_instance(struct tst_kvm_instance *inst, size_t ram_size)
+{
+	int sys_fd;
+	size_t pagesize;
+	char *vm_result, *reset_ptr;
+	struct kvm_cpuid2 *cpuid_data;
+	const size_t payload_size = kvm_payload_end - kvm_payload_start;
+
+	memset(inst, 0, sizeof(struct tst_kvm_instance));
+	inst->vm_fd = -1;
+	inst->vcpu_fd = -1;
+	inst->vcpu_info = MAP_FAILED;
+
+	pagesize = SAFE_SYSCONF(_SC_PAGESIZE);
+
+	if (payload_size + MIN_FREE_RAM > ram_size - VM_KERNEL_BASEADDR) {
+		ram_size = payload_size + MIN_FREE_RAM + VM_KERNEL_BASEADDR;
+		ram_size += 1024 * 1024 - 1;
+		ram_size -= ram_size % (1024 * 1024);
+		tst_res(TWARN, "RAM size increased to %zu bytes", ram_size);
+	}
+
+	if (ram_size > KVM_RESULT_BASEADDR) {
+		ram_size = KVM_RESULT_BASEADDR;
+		ram_size -= ram_size % pagesize;
+		tst_res(TWARN, "RAM size truncated to %zu bytes", ram_size);
+	}
+
+	/* Create VM */
+	sys_fd = SAFE_OPEN("/dev/kvm", O_RDWR);
+	inst->vcpu_info_size = SAFE_IOCTL(sys_fd, KVM_GET_VCPU_MMAP_SIZE);
+	inst->vm_fd = SAFE_IOCTL(sys_fd, KVM_CREATE_VM, 0);
+	cpuid_data = tst_kvm_get_cpuid(sys_fd);
+	SAFE_CLOSE(sys_fd);
+
+	/* Create virtual CPU */
+	inst->vcpu_fd = SAFE_IOCTL(inst->vm_fd, KVM_CREATE_VCPU, 0);
+
+	if (cpuid_data) {
+		SAFE_IOCTL(inst->vcpu_fd, KVM_SET_CPUID2, cpuid_data);
+		free(cpuid_data);
+	}
+
+	inst->vcpu_info = SAFE_MMAP(NULL, inst->vcpu_info_size,
+		PROT_READ | PROT_WRITE, MAP_SHARED, inst->vcpu_fd, 0);
+
+	/* Set VM memory banks and install test program */
+	inst->ram = tst_kvm_alloc_memory(inst->vm_fd, 0, 0, ram_size, 0);
+	vm_result = tst_kvm_alloc_memory(inst->vm_fd, 1, KVM_RESULT_BASEADDR,
+		KVM_RESULT_SIZE, 0);
+	memset(vm_result, 0, KVM_RESULT_SIZE);
+	memcpy(inst->ram + VM_KERNEL_BASEADDR, kvm_payload_start, payload_size);
+
+	reset_ptr = vm_result + (VM_RESET_BASEADDR % pagesize);
+	memcpy(reset_ptr, tst_kvm_reset_code, sizeof(tst_kvm_reset_code));
+	inst->result = (struct tst_kvm_result *)(vm_result +
+		(KVM_RESULT_BASEADDR % pagesize));
+	inst->result->result = KVM_TNONE;
+	inst->result->message[0] = '\0';
+}
+
+void tst_kvm_run_instance(struct tst_kvm_instance *inst)
+{
+	struct kvm_regs regs;
+
+	SAFE_IOCTL(inst->vcpu_fd, KVM_RUN, 0);
+	SAFE_IOCTL(inst->vcpu_fd, KVM_GET_REGS, &regs);
+
+	if (inst->vcpu_info->exit_reason != KVM_EXIT_HLT) {
+		tst_brk(TBROK,
+			"Unexpected VM exit at RIP=0x%llx with exit reason=%u",
+			regs.rip, inst->vcpu_info->exit_reason);
+	}
+
+	if (regs.rax) {
+		tst_res(TINFO,
+			"RBX=%llx, RCX=%llx, RDX=%llx, RDI=%llx, RSI=%llx",
+			regs.rbx, regs.rcx, regs.rdx, regs.rdi, regs.rsi);
+		tst_brk(TBROK,
+			"VM exited at RIP=0x%llx with RAX=0x%llx (expected 0)",
+			regs.rip, regs.rax);
+	}
+
+	tst_kvm_validate_result(inst->result->result);
+
+	if (inst->result->result == TBROK)
+		tst_brk(inst->result->result, "%s", inst->result->message);
+	else
+		tst_res(inst->result->result, "%s", inst->result->message);
+}
+
+void tst_kvm_destroy_instance(struct tst_kvm_instance *inst)
+{
+	if (inst->vm_fd < 0)
+		return;
+
+	if (inst->vcpu_info != MAP_FAILED)
+		SAFE_MUNMAP(inst->vcpu_info, inst->vcpu_info_size);
+
+	if (inst->vcpu_fd >= 0)
+		SAFE_CLOSE(inst->vcpu_fd);
+
+	SAFE_CLOSE(inst->vm_fd);
+}
+
+void tst_kvm_setup(void)
+{
+	tst_kvm_create_instance(&test_vm, DEFAULT_RAM_SIZE);
+}
+
+void tst_kvm_run(void)
+{
+	tst_kvm_run_instance(&test_vm);
+}
+
+void tst_kvm_cleanup(void)
+{
+	tst_kvm_destroy_instance(&test_vm);
+}
diff --git a/testcases/kernel/kvm/include/kvm_common.h b/testcases/kernel/kvm/include/kvm_common.h
new file mode 100644
index 000000000..264f83841
--- /dev/null
+++ b/testcases/kernel/kvm/include/kvm_common.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2021 SUSE LLC <mdoucha@suse.cz>
+ *
+ * Common definitions for communication between KVM guest and host.
+ */
+
+#ifndef KVM_COMMON_H_
+#define KVM_COMMON_H_
+
+/*
+ * KVM_Txxxx constants must match value of the corresponding Txxxx constant
+ * defined in tst_res_flags.h, if it exists.
+ */
+#define KVM_TNONE	-1	/* No result flag */
+#define KVM_TPASS	0	/* Test passed flag */
+#define KVM_TFAIL	1	/* Test failed flag */
+#define KVM_TBROK	2	/* Test broken flag */
+#define KVM_TWARN	4	/* Test warning flag */
+#define KVM_TINFO	16	/* Test information flag */
+#define KVM_TCONF	32	/* Test not appropriate for configuration */
+
+#define KVM_RESULT_BASEADDR 0xfffff000
+#define KVM_RESULT_SIZE 0x1000
+
+struct tst_kvm_result {
+	int result;
+	char message[0];
+};
+
+#endif /* KVM_COMMON_H_ */
diff --git a/testcases/kernel/kvm/include/kvm_guest.h b/testcases/kernel/kvm/include/kvm_guest.h
new file mode 100644
index 000000000..62bb2e0f5
--- /dev/null
+++ b/testcases/kernel/kvm/include/kvm_guest.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2021 SUSE LLC <mdoucha@suse.cz>
+ *
+ * Minimal test library for KVM tests
+ */
+
+#ifndef KVM_GUEST_H_
+#define KVM_GUEST_H_
+
+#define TST_TEST_TCONF(message) \
+	void main(void) { tst_exit(KVM_TCONF, message); }
+
+typedef unsigned long size_t;
+typedef long ssize_t;
+
+typedef signed char int8_t;
+typedef unsigned char uint8_t;
+typedef short int16_t;
+typedef unsigned short uint16_t;
+typedef int int32_t;
+typedef unsigned int uint32_t;
+typedef long long int64_t;
+typedef unsigned long long uint64_t;
+typedef unsigned long uintptr_t;
+
+#define NULL ((void *)0)
+
+typedef int (*page_fault_callback_t)(void *userdata, uintptr_t address,
+	uintptr_t instptr, unsigned long errcode);
+
+void *memset(void *dest, int val, size_t size);
+void *memzero(void *dest, size_t size);
+void *memcpy(void *restrict dest, const void *restrict src, size_t size);
+
+char *strcpy(char *restrict dest, const char *restrict src);
+size_t strlen(const char *str);
+
+void kvm_exit(long exitcode) __attribute__((noreturn));
+
+void tst_exit(int result, const char *message) __attribute__((noreturn));
+
+void tst_set_page_fault_callback(page_fault_callback_t func, void *userdata);
+
+void *tst_heap_alloc(size_t size);
+
+#endif /* KVM_GUEST_H_ */
diff --git a/testcases/kernel/kvm/include/kvm_host.h b/testcases/kernel/kvm/include/kvm_host.h
new file mode 100644
index 000000000..62e76485f
--- /dev/null
+++ b/testcases/kernel/kvm/include/kvm_host.h
@@ -0,0 +1,115 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2021 SUSE LLC <mdoucha@suse.cz>
+ *
+ * KVM host library for setting up and running virtual machine tests. Tests
+ * can either use the default setup/run/host functions or use the advanced
+ * API to create customized VMs.
+ */
+
+/*
+ * Most basic usage:
+ *
+ * #include "kvm_test.h"
+ *
+ * #ifdef COMPILE_PAYLOAD
+ *
+ * void main(void)
+ * {
+ *	[VM guest code goes here]
+ * }
+ *
+ * #else
+ *
+ * [optional VM host setup/run/cleanup code goes here]
+ *
+ * static struct tst_test test = {
+ *	.test_all = tst_kvm_run,
+ *	.setup = tst_kvm_setup,
+ *	.cleanup = tst_kvm_cleanup,
+ * };
+ *
+ * #endif
+ */
+
+#ifndef KVM_HOST_H_
+#define KVM_HOST_H_
+
+#include <inttypes.h>
+#include <linux/kvm.h>
+#include "kvm_common.h"
+
+#define VM_KERNEL_BASEADDR 0x1000
+#define VM_RESET_BASEADDR 0xfffffff0
+#define VM_RESET_CODE_SIZE 8
+
+#define MIN_FREE_RAM (10 * 1024 * 1024)
+#define DEFAULT_RAM_SIZE (16 * 1024 * 1024)
+
+struct tst_kvm_instance {
+	int vm_fd, vcpu_fd;
+	struct kvm_run *vcpu_info;
+	size_t vcpu_info_size;
+	void *ram;
+	struct tst_kvm_result *result;
+};
+
+/* Test binary to be installed into the VM at VM_KERNEL_BASEADDR */
+extern const char kvm_payload_start[], kvm_payload_end[];
+
+/* CPU reset code to be installed into the VM at VM_RESET_BASEADDR */
+extern const char tst_kvm_reset_code[VM_RESET_CODE_SIZE];
+
+/* Default KVM test functions. */
+void tst_kvm_setup(void);
+void tst_kvm_run(void);
+void tst_kvm_cleanup(void);
+
+/*
+ * Validate KVM guest test result (usually passed via result->result) and
+ * fail with TBROK if the value cannot be safely passed to tst_res() or
+ * tst_brk().
+ */
+void tst_kvm_validate_result(int value);
+
+/*
+ * Allocate memory slot for the VM. The returned pointer is page-aligned
+ * so the actual requested base address is at ret[baseaddr % pagesize].
+ *
+ * The first argument is a VM file descriptor created by ioctl(KVM_CREATE_VM)
+ *
+ * The return value points to a guarded buffer and the user should not attempt
+ * to free() it. Any extra space added at the beginning or end for page
+ * alignment will be writable.
+ */
+void *tst_kvm_alloc_memory(int vm, unsigned int slot, uint64_t baseaddr,
+	size_t size, unsigned int flags);
+
+/*
+ * Find CPUIDs supported by KVM. x86_64 tests must set non-default CPUID,
+ * otherwise bootstrap will fail to initialize 64bit mode.
+ * Returns NULL if ioctl(KVM_GET_SUPPORTED_CPUID) is not supported.
+ *
+ * The argument is a file descriptor created by open("/dev/kvm")
+ */
+struct kvm_cpuid2 *tst_kvm_get_cpuid(int sysfd);
+
+/*
+ * Initialize the given KVM instance structure. Creates new KVM virtual machine
+ * with 1 virtual CPU, allocates VM RAM (max. 4GB minus one page) and
+ * shared result structure. KVM memory slots 0 and 1 will be set by this
+ * function.
+ */
+void tst_kvm_create_instance(struct tst_kvm_instance *inst, size_t ram_size);
+
+/*
+ * Execute the given KVM instance and print results.
+ */
+void tst_kvm_run_instance(struct tst_kvm_instance *inst);
+
+/*
+ * Close the given KVM instance.
+ */
+void tst_kvm_destroy_instance(struct tst_kvm_instance *inst);
+
+#endif /* KVM_HOST_H_ */
diff --git a/testcases/kernel/kvm/include/kvm_test.h b/testcases/kernel/kvm/include/kvm_test.h
new file mode 100644
index 000000000..55989eaa5
--- /dev/null
+++ b/testcases/kernel/kvm/include/kvm_test.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2021 SUSE LLC <mdoucha@suse.cz>
+ *
+ * Minimal test library for KVM tests
+ */
+
+#ifndef KVM_TEST_H_
+#define KVM_TEST_H_
+
+#ifdef COMPILE_PAYLOAD
+
+  #include "kvm_guest.h"
+  #include "kvm_common.h"
+
+#else
+
+  #include "tst_test.h"
+  #include "kvm_host.h"
+
+#endif /* COMPILE_PAYLOAD */
+
+#endif /* KVM_TEST_H_ */
diff --git a/testcases/kernel/kvm/include/kvm_x86.h b/testcases/kernel/kvm/include/kvm_x86.h
new file mode 100644
index 000000000..7e412176a
--- /dev/null
+++ b/testcases/kernel/kvm/include/kvm_x86.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2021 SUSE LLC <mdoucha@suse.cz>
+ *
+ * x86-specific KVM helper functions and structures
+ */
+
+#ifndef KVM_X86_H_
+#define KVM_X86_H_
+
+#include "kvm_test.h"
+
+#define INTR_PAGE_FAULT 14
+#define INTR_COUNT 256
+
+struct intr_descriptor {
+	uint16_t offset_lo;
+	uint16_t selector;
+	uint8_t ist;
+	uint8_t flags;
+#if defined(__x86_64__)
+	uint64_t offset_hi; /* top 16 bits must be set to 0 */
+	uint16_t padding;
+#else /* defined(__x86_64__) */
+	uint16_t offset_hi;
+#endif /* defined(__x86_64__) */
+} __attribute__((__packed__));
+
+struct page_table_entry_pae {
+	unsigned int present: 1;
+	unsigned int writable: 1;
+	unsigned int user_access: 1;
+	unsigned int write_through: 1;
+	unsigned int disable_cache: 1;
+	unsigned int accessed: 1;
+	unsigned int dirty: 1;
+	unsigned int page_type: 1;
+	unsigned int global: 1;
+	unsigned int padding: 3;
+	uint64_t address: 40;
+	unsigned int padding2: 7;
+	unsigned int prot_key: 4;
+	unsigned int noexec: 1;
+} __attribute__((__packed__));
+
+struct kvm_cpuid {
+	unsigned int eax, ebx, ecx, edx;
+};
+
+extern struct page_table_entry_pae kvm_pagetable[];
+extern struct intr_descriptor kvm_idt[INTR_COUNT];
+
+uintptr_t kvm_get_page_address_pae(const struct page_table_entry_pae *entry);
+
+void kvm_get_cpuid(unsigned int eax, unsigned int ecx, struct kvm_cpuid *buf);
+
+/* Low-level interrupt handlers */
+void kvm_handle_bad_exception(void);
+void kvm_handle_page_fault(void);
+
+#endif /* KVM_X86_H_ */
diff --git a/testcases/kernel/kvm/kvm_pagefault01.c b/testcases/kernel/kvm/kvm_pagefault01.c
new file mode 100644
index 000000000..7eac3ac5b
--- /dev/null
+++ b/testcases/kernel/kvm/kvm_pagefault01.c
@@ -0,0 +1,104 @@
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
+int handle_page_fault(void *userdata, uintptr_t address, uintptr_t instptr,
+	unsigned long errcode)
+{
+	if (address == (uintptr_t)userdata)
+		tst_exit(KVM_TPASS, "KVM enforces memory write permissions");
+
+	tst_exit(KVM_TBROK, "Unexpected page fault");
+}
+
+void main(void)
+{
+	uintptr_t tmp;
+	struct page_table_entry_pae *pte = kvm_pagetable;
+	char *writable, *readonly;
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
+	 * Remap 0x80000000 - 0xbfffffff to the same physical address range as
+	 * pte[0] (which is guaranteed to be backed by memory) but drop write
+	 * permissions for the second mapping.
+	 */
+	pte[2] = pte[0];
+	pte[2].writable = 0;
+
+	/*
+	 * Get a pointer somewhere safe into pte[0] memory range and
+	 * convert it to the overlapping read-only range from pte[2]. Writing
+	 * to it through the converted pointer must cause page fault.
+	 */
+	writable = tst_heap_alloc(1);
+	*writable = 0;
+	tmp = (uintptr_t)writable;
+	tmp |= 0x80000000;
+	readonly = (char *)tmp;
+	tst_set_page_fault_callback(handle_page_fault, readonly);
+
+	/* Trigger page fault */
+	*readonly = 1;
+
+	/* This line should be unreachable */
+	tst_exit(KVM_TFAIL, "Write to read-only address did not page fault");
+}
+
+#else /* __x86_64__ */
+TST_TEST_TCONF("Test supported only on x86_64");
+#endif /* __x86_64__ */
+
+#else /* COMPILE_PAYLOAD */
+
+static struct tst_test test = {
+	.test_all = tst_kvm_run,
+	.setup = tst_kvm_setup,
+	.cleanup = tst_kvm_cleanup,
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
diff --git a/testcases/kernel/kvm/kvm_x86.c b/testcases/kernel/kvm/kvm_x86.c
new file mode 100644
index 000000000..d15265ccd
--- /dev/null
+++ b/testcases/kernel/kvm/kvm_x86.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2021 SUSE LLC <mdoucha@suse.cz>
+ *
+ * x86-specific KVM helper functions
+ */
+
+#include "kvm_x86.h"
+
+static void kvm_set_intr_handler(unsigned int id, uintptr_t func)
+{
+	memset(kvm_idt + id, 0, sizeof(kvm_idt[0]));
+	kvm_idt[id].offset_lo = func & 0xffff;
+	kvm_idt[id].offset_hi = func >> 16;
+	kvm_idt[id].selector = 8;
+	kvm_idt[id].flags = 0x8f;	/* type = 0xf, P = 1 */
+}
+
+void kvm_init_interrupts(void)
+{
+	int i;
+
+	kvm_set_intr_handler(0, (uintptr_t)kvm_handle_bad_exception);
+
+	for (i = 1; i < INTR_COUNT; i++)
+		kvm_idt[i] = kvm_idt[0];
+
+	kvm_set_intr_handler(INTR_PAGE_FAULT, (uintptr_t)kvm_handle_page_fault);
+}
+
+uintptr_t kvm_get_page_address_pae(const struct page_table_entry_pae *entry)
+{
+	if (!entry->present)
+		return 0;
+
+	return entry->address << 12;
+}
+
+void kvm_get_cpuid(unsigned int eax, unsigned int ecx, struct kvm_cpuid *buf)
+{
+	asm (
+		"movl %4, %%eax\n"
+		"movl %5, %%ecx\n"
+		"cpuid\n"
+		"movl %%eax, %0\n"
+		"movl %%ebx, %1\n"
+		"movl %%ecx, %2\n"
+		"movl %%edx, %3\n"
+		: "=m" (buf->eax), "=m" (buf->ebx), "=m" (buf->ecx),
+			"=m" (buf->edx)
+		: "rm" (eax), "rm" (ecx)
+		: "eax", "ebx", "ecx", "edx"
+	);
+}
diff --git a/testcases/kernel/kvm/layout-x86_64.lds b/testcases/kernel/kvm/layout-x86_64.lds
new file mode 100644
index 000000000..84244de02
--- /dev/null
+++ b/testcases/kernel/kvm/layout-x86_64.lds
@@ -0,0 +1,67 @@
+OUTPUT_FORMAT(elf64-x86-64)
+
+SECTIONS
+{
+	/DISCARD/ :
+	{
+		  *(.note.gnu.* .comment)
+	}
+
+	. = 0x1000;
+	.init.boot :
+	{
+		*(.init.protected_mode)
+		*(.data.gdt32)
+		*(.init.long_mode)
+	}
+
+	.text :
+	{
+		*(.rodata .rodata.*)
+		*(.text.unlikely .text.unlikely.*)
+		*(.text.startup .text.startup.*)
+		*(.text .text.*)
+		*(.gnu.linkonce.t.*)
+	}
+
+
+	.data :
+	{
+		*(.data)
+	}
+
+	.init :
+	{
+		KEEP (*(SORT_NONE(.init)))
+	}
+
+	.preinit_array :
+	{
+		PROVIDE_HIDDEN (__preinit_array_begin = .);
+		KEEP (*(.preinit_array))
+		PROVIDE_HIDDEN (__preinit_array_end = .);
+	}
+
+	.init_array :
+	{
+		PROVIDE_HIDDEN (__init_array_begin = .);
+		KEEP (*(SORT_BY_INIT_PRIORITY(.init_array.*) SORT_BY_INIT_PRIORITY(.ctors.*)))
+		KEEP (*(.init_array EXCLUDE_FILE (*crtbegin.o *crtbegin?.o *crtend.o *crtend?.o ) .ctors))
+		PROVIDE_HIDDEN (__init_array_end = .);
+	}
+
+	.bss.pgtables : ALIGN(4096)
+	{
+		*(.bss.pgtables)
+	}
+
+	.bss : ALIGN(4096)
+	{
+		*(.bss.stack)
+		*(.bss.tss)
+		*(.bss)
+
+		. = ALIGN(4096);
+		kvm_heap_begin = .;
+	}
+}
diff --git a/testcases/kernel/kvm/payload.lds b/testcases/kernel/kvm/payload.lds
new file mode 100644
index 000000000..a544fd37a
--- /dev/null
+++ b/testcases/kernel/kvm/payload.lds
@@ -0,0 +1,11 @@
+TARGET(binary)
+
+SECTIONS
+{
+	.data :
+	{
+		kvm_payload_start = .;
+		KEEP(*(.data))
+		kvm_payload_end = .;
+	}
+}
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
