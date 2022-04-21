Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6504CC433EF
	for <ltp@archiver.kernel.org>; Thu, 21 Apr 2022 12:34:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF3283CA6E7
	for <ltp@archiver.kernel.org>; Thu, 21 Apr 2022 14:34:31 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 009BA3CA6FC
 for <ltp@lists.linux.it>; Thu, 21 Apr 2022 14:33:57 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D868A1400C59
 for <ltp@lists.linux.it>; Thu, 21 Apr 2022 14:33:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1D21E1F388
 for <ltp@lists.linux.it>; Thu, 21 Apr 2022 12:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1650544432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7GMLZUhb8mDL2A/cF6z4KKwxLCP+a5ave4YT1Fws0sY=;
 b=XiH4s/tpsze3GsswrI/xmKOYxNGTeayoHFsVtpMtuydE9MNz0c0LExBmGMIP3GzETNteL3
 C12joC/9i+Mq72V/U3y+LVp5t5rvf099coP0vZJ2pt1jqSjt6c+ME/0yLE86wiQGB+bQvo
 tg/dx6TO/+HZYdIt2nK7G+5WDuWAPeo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1650544432;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7GMLZUhb8mDL2A/cF6z4KKwxLCP+a5ave4YT1Fws0sY=;
 b=OKHrz/Ws9mzUezuMZFfkqXimfr1BhjPuB4+nzWYscVp6EFa/ItNEQFF++RmuLpjr8Tjv50
 aWPb5PxXqWiz2+Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EF35A13A84
 for <ltp@lists.linux.it>; Thu, 21 Apr 2022 12:33:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kGudOS9PYWL/GgAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 21 Apr 2022 12:33:51 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 21 Apr 2022 14:33:50 +0200
Message-Id: <20220421123351.17645-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220421123351.17645-1-mdoucha@suse.cz>
References: <20220421123351.17645-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] KVM test infrastructure
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

Implement LTP infrastructure for tests which require executing a special
program inside KVM virtual machine. The infrastructure is split into two parts:
the host library and the guest library.

The host library provides functions for setting up and running virtual machines
with test payload built from test sources.

The guest library provides CPU bootstrap code and basic implementation of
some C and LTP library functions as well as functions for accessing low-level
arch features like special registers, interrupt tables or memory mapping tables.

The test sources will contain both guest-side payload code and host-side setup
code separated by preprocessor switch. The files get compiled twice with
different compiler options. Once to build the VM payload, once to build
the main program that will create the VM and execute the payload inside it.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1:
- Fixed build on distros which enable -pie by default
- tst_res()/tst_brk() now print file:lineno even from inside KVM payload
- Refactored global GDT symbols in x86 bootstrap code for future use
- Removed unnecessary comments in host library

Changes since v2:
- #include tst_res_flags.h from main LTP library in kvm_guest.h
- Use LTP_ALIGN() in tst_heap_alloc() functions

 configure.ac                              |   3 +
 include/mk/config.mk.in                   |   2 +
 include/mk/env_post.mk                    |   1 +
 include/mk/rules.mk                       |   8 +
 testcases/kernel/Makefile                 |   1 +
 testcases/kernel/kvm/Makefile             |  62 +++
 testcases/kernel/kvm/bootstrap_x86.S      | 368 ++++++++++++++++
 testcases/kernel/kvm/bootstrap_x86_64.S   | 515 ++++++++++++++++++++++
 testcases/kernel/kvm/include/kvm_common.h |  31 ++
 testcases/kernel/kvm/include/kvm_guest.h  |  85 ++++
 testcases/kernel/kvm/include/kvm_host.h   | 115 +++++
 testcases/kernel/kvm/include/kvm_test.h   |  23 +
 testcases/kernel/kvm/include/kvm_x86.h    | 157 +++++++
 testcases/kernel/kvm/lib_guest.c          | 179 ++++++++
 testcases/kernel/kvm/lib_host.c           | 215 +++++++++
 testcases/kernel/kvm/lib_x86.c            | 150 +++++++
 testcases/kernel/kvm/linker/payload.lds   |  11 +
 testcases/kernel/kvm/linker/x86.lds       |  74 ++++
 testcases/kernel/kvm/linker/x86_64.lds    |  74 ++++
 19 files changed, 2074 insertions(+)
 create mode 100644 testcases/kernel/kvm/Makefile
 create mode 100644 testcases/kernel/kvm/bootstrap_x86.S
 create mode 100644 testcases/kernel/kvm/bootstrap_x86_64.S
 create mode 100644 testcases/kernel/kvm/include/kvm_common.h
 create mode 100644 testcases/kernel/kvm/include/kvm_guest.h
 create mode 100644 testcases/kernel/kvm/include/kvm_host.h
 create mode 100644 testcases/kernel/kvm/include/kvm_test.h
 create mode 100644 testcases/kernel/kvm/include/kvm_x86.h
 create mode 100644 testcases/kernel/kvm/lib_guest.c
 create mode 100644 testcases/kernel/kvm/lib_host.c
 create mode 100644 testcases/kernel/kvm/lib_x86.c
 create mode 100644 testcases/kernel/kvm/linker/payload.lds
 create mode 100644 testcases/kernel/kvm/linker/x86.lds
 create mode 100644 testcases/kernel/kvm/linker/x86_64.lds

diff --git a/configure.ac b/configure.ac
index 9b6d01f54..f0ea6acb4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -371,6 +371,9 @@ LTP_CHECK_SYSCALL_EVENTFD
 LTP_CHECK_SYSCALL_FCNTL
 LTP_CHECK_FSVERITY
 
+AX_CHECK_COMPILE_FLAG([-no-pie], [LTP_CFLAGS_NOPIE=1])
+AC_SUBST([LTP_CFLAGS_NOPIE])
+
 if test "x$with_numa" = xyes; then
 	LTP_CHECK_SYSCALL_NUMA
 	numa_error_msg="test requires libnuma development packages with LIBNUMA_API_VERSION >= 2"
diff --git a/include/mk/config.mk.in b/include/mk/config.mk.in
index 218447ef3..674843563 100644
--- a/include/mk/config.mk.in
+++ b/include/mk/config.mk.in
@@ -83,6 +83,8 @@ WCFLAGS			?= -Wall -W @GCC_WARN_OLDSTYLE@
 LDFLAGS			+= $(WLDFLAGS)
 CFLAGS			+= $(DEBUG_CFLAGS) $(OPT_CFLAGS) $(WCFLAGS)
 
+LTP_CFLAGS_NOPIE	:= @LTP_CFLAGS_NOPIE@
+
 ifeq ($(strip $(HOST_CFLAGS)),)
 HOST_CFLAGS := $(CFLAGS)
 endif
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
index d44856c57..c0fa24147 100644
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
index 000000000..69a9946fe
--- /dev/null
+++ b/testcases/kernel/kvm/Makefile
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2021 Linux Test Project
+
+top_srcdir		?= ../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+ASFLAGS =
+CPPFLAGS += -I$(abs_srcdir)/include
+GUEST_CPPFLAGS = $(CPPFLAGS) -DCOMPILE_PAYLOAD
+GUEST_CFLAGS = -ffreestanding -O2 -Wall -fno-asynchronous-unwind-tables -mno-mmx -mno-sse
+GUEST_LDFLAGS = -nostdlib -Wl,--build-id=none
+GUEST_LDLIBS =
+
+FILTER_OUT_MAKE_TARGETS := lib_guest lib_host lib_x86
+
+ifeq ($(HOST_CPU),x86_64)
+	ifneq (,$(findstring m32,$(CFLAGS)))
+		HOST_CPU = x86
+		GUEST_CFLAGS += -m32
+		ASFLAGS += --32
+	endif
+endif
+
+# Some distros enable -pie by default. That breaks KVM payload linking.
+ifdef LTP_CFLAGS_NOPIE
+	GUEST_CFLAGS += -fno-pie
+	GUEST_LDFLAGS += -no-pie
+endif
+
+GUEST_LDFLAGS += -Wl,-T$(abs_srcdir)/linker/$(HOST_CPU).lds
+ARCH_OBJ = bootstrap_$(HOST_CPU).o
+
+ifeq ($(HOST_CPU),x86_64)
+ARCH_OBJ += lib_x86.o
+BIN_FORMAT=elf64-x86-64
+else ifeq ($(HOST_CPU),x86)
+ARCH_OBJ += lib_x86.o
+BIN_FORMAT=elf32-i386
+else
+MAKE_TARGETS =
+endif
+
+lib_guest.o $(ARCH_OBJ): CPPFLAGS	:= $(GUEST_CPPFLAGS)
+lib_guest.o $(ARCH_OBJ): CFLAGS		:= $(GUEST_CFLAGS)
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+%-payload.o: %.c lib_guest.o $(ARCH_OBJ)
+ifdef VERBOSE
+	$(CC) $(GUEST_CPPFLAGS) $(GUEST_CFLAGS) $(GUEST_LDFLAGS) -o $*-payload.elf $^ $(GUEST_LDLIBS)
+	objcopy -O binary -j .init.boot -j .text -j .data -j .init -j .preinit_array -j .init_array --gap-fill=0 $*-payload.elf $*-payload.bin
+	ld -r -T $(abs_srcdir)/linker/payload.lds --oformat=$(BIN_FORMAT) -o $@ $*-payload.bin
+else
+	@$(CC) $(GUEST_CPPFLAGS) $(GUEST_CFLAGS) $(GUEST_LDFLAGS) -o $*-payload.elf $^ $(GUEST_LDLIBS)
+	@objcopy -O binary -j .init.boot -j .text -j .data -j .init -j .preinit_array -j .init_array --gap-fill=0 $*-payload.elf $*-payload.bin
+	@ld -r -T $(abs_srcdir)/linker/payload.lds --oformat=$(BIN_FORMAT) -o $@ $*-payload.bin
+	@echo KVM_CC $(target_rel_dir)$@
+endif
+	@rm $*-payload.elf $*-payload.bin
+
+$(MAKE_TARGETS): %: %-payload.o lib_host.o
diff --git a/testcases/kernel/kvm/bootstrap_x86.S b/testcases/kernel/kvm/bootstrap_x86.S
new file mode 100644
index 000000000..6b079cd27
--- /dev/null
+++ b/testcases/kernel/kvm/bootstrap_x86.S
@@ -0,0 +1,368 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020 SUSE LLC
+ * Author: Nicolai Stange <nstange@suse.de>
+ * LTP port: Martin Doucha <mdoucha@suse.cz>
+ */
+
+.set KVM_TEXIT, 0xff
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
+	lgdt kvm_gdt_desc
+
+	mov $0x11, %eax
+	mov %eax, %cr0
+
+	jmp $1 * 8, $protected_mode_entry
+
+.code32
+protected_mode_entry:
+	mov $2 * 8, %eax
+	mov %eax, %ds
+	mov %eax, %es
+	jmp init_memlayout
+
+.section .data.gdt32, "a", @progbits
+
+.macro gdt32_entry type:req l=0 d=0 dpl=0 limit=0xfffff g=1 p=1
+	.4byte \limit & 0xffff
+	.2byte (\type << 8) | (\dpl << 13) | (\p << 15)
+	.2byte (\limit >> 16) | (\l << 5) | (\d << 6) | (\g << 7)
+.endm
+.align 8
+.global kvm_gdt
+kvm_gdt:
+	.8byte 0
+	gdt32_entry type=0x1a l=0 d=1 /* Code segment protected_mode, 32bits */
+	gdt32_entry type=0x12 /* Data segment, writable */
+	.skip 16 /* Stack and TSS segment descriptors */
+
+.Lgdt_end:
+.global kvm_gdt_desc
+kvm_gdt_desc:
+	.2byte .Lgdt_end - kvm_gdt - 1
+	.4byte kvm_gdt
+
+.code32
+.section .init.memlayout, "ax"
+init_memlayout:
+	/*
+	 * Identity-map the first 2GB of virtual address space.
+	 */
+	lea kvm_pagetable, %edi
+	lea kvm_pgtable_l2, %esi
+	movl %esi, %eax
+	mov $1024, %ecx
+
+1:	movl %eax, %ebx
+	orl $0x3, %ebx		/* Flags: present, writable */
+	movl %ebx, (%edi)
+	addl $4, %edi
+	addl $4096, %eax
+	dec %ecx
+	jnz 1b
+
+	/* Fill kvm_pgtable_l2 with identity map of the first 2GB. */
+	movl %esi, %edi
+	movl $512 * 1024, %ecx
+	xor %eax, %eax
+
+1:	movl %eax, %ebx
+	orl $0x3, %ebx		/* Flags: present, writable */
+	movl %ebx, (%edi)
+	addl $4, %edi
+	addl $4096, %eax
+	dec %ecx
+	jnz 1b
+
+	/* Mark the upper 2GB as unmapped except for the last page. */
+	movl $512 * 1024 - 1, %ecx
+	xor %eax, %eax
+	rep stosl
+	movl $0xfffff003, (%edi)
+
+	/*
+	 * Install new pagetable to CR3 and enable memory paging by setting
+	 * CR0.WP and CR0.PG
+	 */
+	lea kvm_pagetable, %eax
+	movl %eax, %cr3
+	movl %cr0, %eax
+	btsl $31, %eax
+	btsl $16, %eax
+	movl %eax, %cr0
+
+	/* Init TSS */
+	lea kvm_tss, %edx
+	movl %edx, %edi
+	movl $.Ltss_end - kvm_tss, %ecx
+	xor %eax, %eax
+	rep stosb
+	movl %edx, %edi
+	lea kvm_stack_top, %edx
+	movl %edx, 4(%edi)
+
+	/* Create a stack descriptor in the 4th GDT slot */
+	/* Base address: 0x0, Limit: kvm_stack_bottom */
+	xor %eax, %eax
+	movl $0xc09600, %ebx /* flags + access bits */
+	movl $kvm_stack_bottom - 1, %edx
+	shr $12, %edx
+	movw %dx, %ax
+	andl $0xf0000, %edx
+	orl %edx, %ebx
+
+	lea kvm_gdt + 3*8, %edi
+	mov %eax, (%edi)
+	mov %ebx, 4(%edi)
+	mov $3 * 8, %eax
+	mov %ax, %ss
+	lea kvm_stack_top, %esp
+
+	/* Create a TSS descriptor in the 5th GDT slot */
+	lea kvm_tss, %edx
+	movl %edx, %ebx
+	andl $0xff000000, %ebx
+	movl %edx, %eax
+	shr $16, %eax
+	movb %al, %bl
+	orl $0x408900, %ebx /* flags + access bits */
+
+	movl %edx, %eax
+	movl $.Ltss_end - kvm_tss - 1, %edx
+	shl $16, %eax
+	movw %dx, %ax
+	andl $0xf0000, %edx
+	orl %edx, %ebx
+
+	lea kvm_gdt + 4*8, %edi
+	mov %eax, (%edi)
+	mov %ebx, 4(%edi)
+	mov $4 * 8, %ax
+	ltr %ax
+
+	/* Configure and enable interrupts */
+	call kvm_init_interrupts
+	lidt kvm_idt_desc
+	sti
+
+	/*
+	 * Do just enough of initialization to get to a working
+	 * -ffreestanding environment and call tst_main(void).
+	 */
+	lea __preinit_array_begin, %edi
+	lea __preinit_array_end, %esi
+1:
+	cmp %edi, %esi
+	je 2f
+	call *(%edi)
+	add $4, %edi
+	jmp 1b
+2:
+
+	lea __init_array_begin, %edi
+	lea __init_array_end, %esi
+1:
+	cmp %edi, %esi
+	je 2f
+	call *(%edi)
+	add $4, %edi
+	jmp 1b
+2:
+	call main
+	jmp kvm_exit
+
+.global kvm_read_cregs
+kvm_read_cregs:
+	push %edi
+	mov 8(%esp), %edi
+	mov %cr0, %eax
+	mov %eax, (%edi)
+	mov %cr2, %eax
+	mov %eax, 4(%edi)
+	mov %cr3, %eax
+	mov %eax, 8(%edi)
+	mov %cr4, %eax
+	mov %eax, 12(%edi)
+	pop %edi
+	ret
+
+handle_interrupt:
+	/* save CPU state */
+	push %ebp
+	mov %esp, %ebp
+	addl $12, %ebp
+	pushal
+
+	/* call handler */
+	push -4(%ebp)
+	push -8(%ebp)
+	push %ebp
+	cld
+	call tst_handle_interrupt
+	addl $12, %esp
+	popal
+	pop %ebp
+	addl $8, %esp
+	iret
+
+.macro create_intr_handler vector:req padargs=0
+.if \padargs
+	pushl $0	/* push dummy error code */
+.endif
+	pushl $\vector
+	jmp handle_interrupt
+.endm
+
+.global kvm_handle_zerodiv
+kvm_handle_zerodiv:
+	create_intr_handler 0, padargs=1
+
+.global kvm_handle_debug
+kvm_handle_debug:
+	create_intr_handler 1, padargs=1
+
+.global kvm_handle_nmi
+kvm_handle_nmi:
+	create_intr_handler 2, padargs=1
+
+.global kvm_handle_breakpoint
+kvm_handle_breakpoint:
+	create_intr_handler 3, padargs=1
+
+.global kvm_handle_overflow
+kvm_handle_overflow:
+	create_intr_handler 4, padargs=1
+
+.global kvm_handle_bound_range_exc
+kvm_handle_bound_range_exc:
+	create_intr_handler 5, padargs=1
+
+.global kvm_handle_bad_opcode
+kvm_handle_bad_opcode:
+	create_intr_handler 6, padargs=1
+
+.global kvm_handle_device_error
+kvm_handle_device_error:
+	create_intr_handler 7, padargs=1
+
+.global kvm_handle_double_fault
+kvm_handle_double_fault:
+	create_intr_handler 8
+
+.global kvm_handle_invalid_tss
+kvm_handle_invalid_tss:
+	create_intr_handler 10
+
+.global kvm_handle_segfault
+kvm_handle_segfault:
+	create_intr_handler 11
+
+.global kvm_handle_stack_fault
+kvm_handle_stack_fault:
+	create_intr_handler 12
+
+.global kvm_handle_gpf
+kvm_handle_gpf:
+	create_intr_handler 13
+
+.global kvm_handle_page_fault
+kvm_handle_page_fault:
+	create_intr_handler 14
+
+.global kvm_handle_fpu_error
+kvm_handle_fpu_error:
+	create_intr_handler 16, padargs=1
+
+.global kvm_handle_alignment_error
+kvm_handle_alignment_error:
+	create_intr_handler 17
+
+.global kvm_handle_machine_check
+kvm_handle_machine_check:
+	create_intr_handler 18, padargs=1
+
+.global kvm_handle_simd_error
+kvm_handle_simd_error:
+	create_intr_handler 19, padargs=1
+
+.global kvm_handle_virt_error
+kvm_handle_virt_error:
+	create_intr_handler 20, padargs=1
+
+.global kvm_handle_cpe
+kvm_handle_cpe:
+	create_intr_handler 21
+
+.global kvm_handle_hv_injection
+kvm_handle_hv_injection:
+	create_intr_handler 28, padargs=1
+
+.global kvm_handle_vmm_comm
+kvm_handle_vmm_comm:
+	create_intr_handler 29
+
+.global kvm_handle_security_error
+kvm_handle_security_error:
+	create_intr_handler 30
+
+.global kvm_handle_bad_exception
+kvm_handle_bad_exception:
+	create_intr_handler -1, padargs=1
+
+.global kvm_exit
+kvm_exit:
+	movl $RESULT_ADDRESS, %edi
+	movl $KVM_TEXIT, (%edi)
+	hlt
+	jmp kvm_exit
+
+.global kvm_yield
+kvm_yield:
+	hlt
+	ret
+
+
+.section .bss.pgtables, "aw", @nobits
+.global kvm_pagetable
+kvm_pagetable:
+	.skip 4096
+
+kvm_pgtable_l2:
+	.skip 1024 * 4096
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
+	.skip 0x6C
+.Ltss_end:
+
+.section .bss
+.align 8
+.global kvm_idt
+kvm_idt:
+	.skip 8 * 256
+.Lidt_end:
+
+.section .data
+.align 8
+.global kvm_idt_desc
+kvm_idt_desc:
+	.2byte .Lidt_end - kvm_idt - 1
+	.4byte kvm_idt
diff --git a/testcases/kernel/kvm/bootstrap_x86_64.S b/testcases/kernel/kvm/bootstrap_x86_64.S
new file mode 100644
index 000000000..c9577e83f
--- /dev/null
+++ b/testcases/kernel/kvm/bootstrap_x86_64.S
@@ -0,0 +1,515 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020 SUSE LLC
+ * Author: Nicolai Stange <nstange@suse.de>
+ * LTP port: Martin Doucha <mdoucha@suse.cz>
+ */
+
+.set KVM_TCONF, 32
+.set KVM_TEXIT, 0xff
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
+	jmp $3 * 8, $protected_mode_entry
+
+.code32
+protected_mode_entry:
+	mov $2 * 8, %eax
+	mov %eax, %ds
+	mov %eax, %es
+	jmp init_memlayout
+
+.section .data.gdt32, "a", @progbits
+
+.macro gdt32_entry type:req l=0 d=0 dpl=0 limit=0xfffff g=1 p=1
+	.4byte \limit & 0xffff
+	.2byte (\type << 8) | (\dpl << 13) | (\p << 15)
+	.2byte (\limit >> 16) | (\l << 5) | (\d << 6) | (\g << 7)
+.endm
+.align 8
+kvm_gdt32:
+	.8byte 0
+	gdt32_entry type=0x1a l=1 /* Code segment long mode */
+	gdt32_entry type=0x12 /* Data segment, writable */
+	gdt32_entry type=0x1a l=0 d=1 /* Code segment protected_mode, 32bits */
+
+.Lgdt32_end:
+kvm_gdt32_desc:
+	.2byte .Lgdt32_end - kvm_gdt32 - 1
+	.4byte kvm_gdt32
+
+.section .data.strings, "aS", @progbits
+source_filename:
+	.ascii "bootstrap_x86_64.S\0"
+
+long_mode_err:
+	.ascii "Virtual CPU does not support 64bit mode\0"
+
+.code32
+.section .init.memlayout, "ax"
+init_memlayout:
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
+	movl $KVM_TCONF, %edi
+	lea long_mode_err, %esi
+	jmp init_error
+1:
+	movl $0x80000001, %eax
+	cpuid
+	bt $29, %edx
+	jc 1f
+	movl $KVM_TCONF, %edi
+	lea long_mode_err, %esi
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
+	jmp $1 * 8, $long_mode_entry
+
+init_error:
+	/* Write error info to test result structure and exit VM */
+	/* Equivalent to tst_brk() but using only 32bit instructions */
+	movl %edi, RESULT_ADDRESS
+	movl $RESULT_ADDRESS+4, %edi
+	movl $0, (%edi)
+	lea source_filename, %eax
+	movl %eax, 4(%edi)
+	movl $0, 8(%edi)
+	addl $12, %edi
+	xor %edx, %edx
+
+1:	movzbl (%esi,%edx,1), %eax
+	movb %al, (%edi,%edx,1)
+	inc %edx
+	test %al, %al
+	jne 1b
+	hlt
+	jmp kvm_exit
+
+.code64
+long_mode_entry:
+	lgdt kvm_gdt_desc
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
+	lea kvm_gdt + 2*8, %rdi
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
+	 * -ffreestanding environment and call tst_main(void).
+	 */
+	lea __preinit_array_begin, %rdi
+1:
+	lea __preinit_array_end, %rsi
+	cmp %rdi, %rsi
+	je 2f
+	push %rdi
+	call *(%rdi)
+	pop %rdi
+	add $8, %rdi
+	jmp 1b
+2:
+
+	lea __init_array_begin, %rdi
+1:
+	lea __init_array_end, %rsi
+	cmp %rdi, %rsi
+	je 2f
+	push %rdi
+	call *(%rdi)
+	pop %rdi
+	add $8, %rdi
+	jmp 1b
+2:
+	call main
+	jmp kvm_exit
+
+.global kvm_read_cregs
+kvm_read_cregs:
+	mov %cr0, %rax
+	mov %rax, (%rdi)
+	mov %cr2, %rax
+	mov %rax, 8(%rdi)
+	mov %cr3, %rax
+	mov %rax, 16(%rdi)
+	mov %cr4, %rax
+	mov %rax, 24(%rdi)
+	retq
+
+handle_interrupt:
+	/* push CPU state */
+	push %rbp
+	mov %rsp, %rbp
+	push %rax
+	push %rbx
+	push %rcx
+	push %rdx
+	push %rdi
+	push %rsi
+	push %r8
+	push %r9
+	push %r10
+	push %r11
+
+	/* load handler arguments from the stack and call handler */
+	movq %rbp, %rdi
+	addq $24, %rdi
+	movq 8(%rbp), %rsi
+	movq 16(%rbp), %rdx
+	cld
+	call tst_handle_interrupt
+
+	/* restore CPU state and return */
+	pop %r11
+	pop %r10
+	pop %r9
+	pop %r8
+	pop %rsi
+	pop %rdi
+	pop %rdx
+	pop %rcx
+	pop %rbx
+	pop %rax
+	pop %rbp
+	add $16, %rsp
+	iretq
+
+.macro create_intr_handler vector:req padargs=0
+.if \padargs
+	pushq $0	/* push dummy error code */
+.endif
+	pushq $\vector
+	jmp handle_interrupt
+.endm
+
+.global kvm_handle_zerodiv
+kvm_handle_zerodiv:
+	create_intr_handler 0, padargs=1
+
+.global kvm_handle_debug
+kvm_handle_debug:
+	create_intr_handler 1, padargs=1
+
+.global kvm_handle_nmi
+kvm_handle_nmi:
+	create_intr_handler 2, padargs=1
+
+.global kvm_handle_breakpoint
+kvm_handle_breakpoint:
+	create_intr_handler 3, padargs=1
+
+.global kvm_handle_overflow
+kvm_handle_overflow:
+	create_intr_handler 4, padargs=1
+
+.global kvm_handle_bound_range_exc
+kvm_handle_bound_range_exc:
+	create_intr_handler 5, padargs=1
+
+.global kvm_handle_bad_opcode
+kvm_handle_bad_opcode:
+	create_intr_handler 6, padargs=1
+
+.global kvm_handle_device_error
+kvm_handle_device_error:
+	create_intr_handler 7, padargs=1
+
+.global kvm_handle_double_fault
+kvm_handle_double_fault:
+	create_intr_handler 8
+
+.global kvm_handle_invalid_tss
+kvm_handle_invalid_tss:
+	create_intr_handler 10
+
+.global kvm_handle_segfault
+kvm_handle_segfault:
+	create_intr_handler 11
+
+.global kvm_handle_stack_fault
+kvm_handle_stack_fault:
+	create_intr_handler 12
+
+.global kvm_handle_gpf
+kvm_handle_gpf:
+	create_intr_handler 13
+
+.global kvm_handle_page_fault
+kvm_handle_page_fault:
+	create_intr_handler 14
+
+.global kvm_handle_fpu_error
+kvm_handle_fpu_error:
+	create_intr_handler 16, padargs=1
+
+.global kvm_handle_alignment_error
+kvm_handle_alignment_error:
+	create_intr_handler 17
+
+.global kvm_handle_machine_check
+kvm_handle_machine_check:
+	create_intr_handler 18, padargs=1
+
+.global kvm_handle_simd_error
+kvm_handle_simd_error:
+	create_intr_handler 19, padargs=1
+
+.global kvm_handle_virt_error
+kvm_handle_virt_error:
+	create_intr_handler 20, padargs=1
+
+.global kvm_handle_cpe
+kvm_handle_cpe:
+	create_intr_handler 21
+
+.global kvm_handle_hv_injection
+kvm_handle_hv_injection:
+	create_intr_handler 28, padargs=1
+
+.global kvm_handle_vmm_comm
+kvm_handle_vmm_comm:
+	create_intr_handler 29
+
+.global kvm_handle_security_error
+kvm_handle_security_error:
+	create_intr_handler 30
+
+.global kvm_handle_bad_exception
+kvm_handle_bad_exception:
+	create_intr_handler -1, padargs=1
+
+
+.global kvm_exit
+kvm_exit:
+	movq $RESULT_ADDRESS, %rdi
+	movl $KVM_TEXIT, (%rdi)
+	hlt
+	jmp kvm_exit
+
+.global kvm_yield
+kvm_yield:
+	hlt
+	ret
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
+.section .data
+.align 8
+.global kvm_gdt
+kvm_gdt:
+	.8byte 0
+	gdt32_entry type=0x1a l=1 limit=0 g=0 /* Code segment long mode */
+	.skip 16 /* TSS segment descriptor */
+
+.Lgdt_end:
+.global kvm_gdt_desc
+kvm_gdt_desc:
+	.2byte .Lgdt_end - kvm_gdt - 1
+	.8byte kvm_gdt
+
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
+	.skip 0x6C
+.Ltss_end:
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
diff --git a/testcases/kernel/kvm/include/kvm_common.h b/testcases/kernel/kvm/include/kvm_common.h
new file mode 100644
index 000000000..4e81d8302
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
+#define KVM_TNONE	-1	/* "No result" status value */
+
+/*
+ * Result value indicating end of test. If the test program exits using
+ * the HLT instruction with any valid result value other than KVM_TEXIT or
+ * TBROK, KVM runner will automatically resume VM execution after printing
+ * the message.
+ */
+#define KVM_TEXIT	0xff
+
+#define KVM_RESULT_BASEADDR 0xfffff000
+#define KVM_RESULT_SIZE 0x1000
+
+struct tst_kvm_result {
+	int32_t result;
+	int32_t lineno;
+	uint64_t file_addr;
+	char message[0];
+};
+
+#endif /* KVM_COMMON_H_ */
diff --git a/testcases/kernel/kvm/include/kvm_guest.h b/testcases/kernel/kvm/include/kvm_guest.h
new file mode 100644
index 000000000..8b19f2811
--- /dev/null
+++ b/testcases/kernel/kvm/include/kvm_guest.h
@@ -0,0 +1,85 @@
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
+/* The main LTP include dir is intentionally excluded during payload build */
+#include "../../../../include/tst_res_flags.h"
+#undef TERRNO
+#undef TTERRNO
+#undef TRERRNO
+
+#define TST_TEST_TCONF(message) \
+	void main(void) { tst_brk(TCONF, message); }
+
+# define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
+/* Round x up to the next multiple of a.
+ * a must be a power of 2.
+ */
+#define LTP_ALIGN(x, a)    __LTP_ALIGN_MASK((x), (typeof(x))(a) - 1)
+#define __LTP_ALIGN_MASK(x, mask)  (((x) + (mask)) & ~(mask))
+
+#define INTERRUPT_COUNT 32
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
+void *memset(void *dest, int val, size_t size);
+void *memzero(void *dest, size_t size);
+void *memcpy(void *dest, const void *src, size_t size);
+
+char *strcpy(char *dest, const char *src);
+char *strcat(char *dest, const char *src);
+size_t strlen(const char *str);
+
+/* Exit the VM by looping on a HLT instruction forever */
+void kvm_exit(void) __attribute__((noreturn));
+
+/* Exit the VM using the HLT instruction but allow resume */
+void kvm_yield(void);
+
+void tst_res_(const char *file, const int lineno, int result,
+	const char *message);
+#define tst_res(result, msg) tst_res_(__FILE__, __LINE__, (result), (msg))
+
+void tst_brk_(const char *file, const int lineno, int result,
+	const char *message) __attribute__((noreturn));
+#define tst_brk(result, msg) tst_brk_(__FILE__, __LINE__, (result), (msg))
+
+void *tst_heap_alloc_aligned(size_t size, size_t align);
+void *tst_heap_alloc(size_t size);
+
+/* Arch dependent: */
+
+struct kvm_interrupt_frame;
+
+typedef int (*tst_interrupt_callback)(void *userdata,
+	struct kvm_interrupt_frame *ifrm, unsigned long errcode);
+
+extern const char *tst_interrupt_names[INTERRUPT_COUNT];
+
+void tst_set_interrupt_callback(unsigned int vector,
+	tst_interrupt_callback func, void *userdata);
+
+/* Get the instruction pointer from interrupt frame */
+uintptr_t kvm_get_interrupt_ip(const struct kvm_interrupt_frame *ifrm);
+
+#endif /* KVM_GUEST_H_ */
diff --git a/testcases/kernel/kvm/include/kvm_host.h b/testcases/kernel/kvm/include/kvm_host.h
new file mode 100644
index 000000000..52cc3f5e9
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
+extern const unsigned char tst_kvm_reset_code[VM_RESET_CODE_SIZE];
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
index 000000000..4f3671135
--- /dev/null
+++ b/testcases/kernel/kvm/include/kvm_x86.h
@@ -0,0 +1,157 @@
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
+/* Interrupts */
+#define X86_INTR_COUNT 256
+
+#define INTR_ZERODIV 0
+#define INTR_DEBUG 1
+#define INTR_NMI 2
+#define INTR_BREAKPOINT 3
+#define INTR_OVERFLOW 4
+#define INTR_BOUND_RANGE_EXC 5
+#define INTR_BAD_OPCODE 6
+#define INTR_DEVICE_ERROR 7
+#define INTR_DOUBLE_FAULT 8
+#define INTR_INVALID_TSS 10
+#define INTR_SEGFAULT 11
+#define INTR_STACK_FAULT 12
+#define INTR_GPF 13
+#define INTR_PAGE_FAULT 14
+#define INTR_FPU_ERROR 16
+#define INTR_ALIGNMENT_ERROR 17
+#define INTR_MACHINE_CHECK 18
+#define INTR_SIMD_ERROR 19
+#define INTR_VIRT_ERROR 20
+#define INTR_CPE 21
+#define INTR_HV_INJECTION 28
+#define INTR_VMM_COMM 29
+#define INTR_SECURITY_ERROR 30
+
+
+/* CPUID constants */
+#define CPUID_GET_INPUT_RANGE 0x80000000
+#define CPUID_GET_EXT_FEATURES 0x80000001
+
+
+/* Model-specific CPU register constants */
+#define MSR_EFER 0xc0000080
+
+#define EFER_SCE (1 << 0)	/* SYSCALL/SYSRET instructions enabled */
+#define EFER_LME (1 << 8)	/* CPU is running in 64bit mode */
+#define EFER_LMA (1 << 10)	/* CPU uses 64bit memory paging (read-only) */
+#define EFER_NXE (1 << 11)	/* Execute disable bit active */
+
+
+/* Control register constants */
+#define CR4_VME (1 << 0)
+#define CR4_PVI (1 << 1)
+#define CR4_TSD (1 << 2)
+#define CR4_DE (1 << 3)
+#define CR4_PSE (1 << 4)
+#define CR4_PAE (1 << 5)
+#define CR4_MCE (1 << 6)
+#define CR4_PGE (1 << 7)
+#define CR4_PCE (1 << 8)
+#define CR4_OSFXSR (1 << 9)
+#define CR4_OSXMMEXCPT (1 << 10)
+#define CR4_UMIP (1 << 11)
+#define CR4_LA57 (1 << 12)
+#define CR4_VMXE (1 << 13)
+#define CR4_SMXE (1 << 14)
+#define CR4_FSGSBASE (1 << 16)
+#define CR4_PCIDE (1 << 17)
+#define CR4_OSXSAVE (1 << 18)
+#define CR4_KL (1 << 19)
+#define CR4_SMEP (1 << 20)
+#define CR4_SMAP (1 << 21)
+#define CR4_PKE (1 << 22)
+#define CR4_CET (1 << 23)
+#define CR4_PKS (1 << 24)
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
+struct kvm_cregs {
+	unsigned long cr0, cr2, cr3, cr4;
+};
+
+extern struct page_table_entry_pae kvm_pagetable[];
+extern struct intr_descriptor kvm_idt[X86_INTR_COUNT];
+
+/* Page table helper functions */
+uintptr_t kvm_get_page_address_pae(const struct page_table_entry_pae *entry);
+
+/* Functions for querying CPU info and status */
+void kvm_get_cpuid(unsigned int eax, unsigned int ecx, struct kvm_cpuid *buf);
+void kvm_read_cregs(struct kvm_cregs *buf);
+uint64_t kvm_rdmsr(unsigned int msr);
+void kvm_wrmsr(unsigned int msr, uint64_t value);
+
+/* Low-level interrupt handlers, DO NOT call directly */
+void kvm_handle_bad_exception(void);
+void kvm_handle_zerodiv(void);
+void kvm_handle_debug(void);
+void kvm_handle_nmi(void);
+void kvm_handle_breakpoint(void);
+void kvm_handle_overflow(void);
+void kvm_handle_bound_range_exc(void);
+void kvm_handle_bad_opcode(void);
+void kvm_handle_device_error(void);
+void kvm_handle_double_fault(void);
+void kvm_handle_invalid_tss(void);
+void kvm_handle_segfault(void);
+void kvm_handle_stack_fault(void);
+void kvm_handle_gpf(void);
+void kvm_handle_page_fault(void);
+void kvm_handle_fpu_error(void);
+void kvm_handle_alignment_error(void);
+void kvm_handle_machine_check(void);
+void kvm_handle_simd_error(void);
+void kvm_handle_virt_error(void);
+void kvm_handle_cpe(void);
+void kvm_handle_hv_injection(void);
+void kvm_handle_vmm_comm(void);
+void kvm_handle_security_error(void);
+
+#endif /* KVM_X86_H_ */
diff --git a/testcases/kernel/kvm/lib_guest.c b/testcases/kernel/kvm/lib_guest.c
new file mode 100644
index 000000000..d237293fc
--- /dev/null
+++ b/testcases/kernel/kvm/lib_guest.c
@@ -0,0 +1,179 @@
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
+static char *heap_end = kvm_heap_begin;
+
+static struct tst_intr_handler {
+	tst_interrupt_callback callback;
+	void *userdata;
+} intr_handlers[INTERRUPT_COUNT];
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
+void *memcpy(void *dest, const void *src, size_t size)
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
+char *strcpy(char *dest, const char *src)
+{
+	char *ret = dest;
+
+	while ((*dest++ = *src++))
+		;
+
+	return ret;
+}
+
+char *strcat(char *dest, const char *src)
+{
+	char *ret = dest;
+
+	for (; *dest; dest++)
+		;
+
+	strcpy(dest, src);
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
+char *ptr2hex(char *dest, uintptr_t val)
+{
+	unsigned int i;
+	uintptr_t tmp;
+	char *ret = dest;
+
+	for (i = 4; val >> i; i += 4)
+		;
+
+	do {
+		i -= 4;
+		tmp = (val >> i) & 0xf;
+		*dest++ = tmp + (tmp >= 10 ? 'A' - 10 : '0');
+	} while (i);
+
+	*dest = '\0';
+	return ret;
+}
+
+void *tst_heap_alloc_aligned(size_t size, size_t align)
+{
+	uintptr_t addr = (uintptr_t)heap_end;
+	void *ret;
+
+	addr += align - 1;
+	addr -= addr % align;
+	ret = (void *)addr;
+	heap_end = (char *)LTP_ALIGN(addr + size, 4);
+	return ret;
+}
+
+void *tst_heap_alloc(size_t size)
+{
+	void *ret = heap_end;
+
+	heap_end += LTP_ALIGN(size, 4);
+	return ret;
+}
+
+void tst_set_interrupt_callback(unsigned int vector,
+	tst_interrupt_callback func, void *userdata)
+{
+	if (vector >= INTERRUPT_COUNT)
+		tst_brk(TBROK, "Set interrupt callback: vector out of range");
+
+	intr_handlers[vector].callback = func;
+	intr_handlers[vector].userdata = userdata;
+}
+
+static void tst_fatal_error(const char *file, const int lineno,
+	const char *message, uintptr_t ip)
+{
+	test_result->result = TBROK;
+	test_result->lineno = lineno;
+	test_result->file_addr = (uintptr_t)file;
+	strcpy(test_result->message, message);
+	strcat(test_result->message, " at address 0x");
+	ptr2hex(test_result->message + strlen(test_result->message), ip);
+	kvm_yield();
+	kvm_exit();
+}
+
+void tst_res_(const char *file, const int lineno, int result,
+	const char *message)
+{
+	test_result->result = result;
+	test_result->lineno = lineno;
+	test_result->file_addr = (uintptr_t)file;
+	strcpy(test_result->message, message);
+	kvm_yield();
+}
+
+void tst_brk_(const char *file, const int lineno, int result,
+	const char *message)
+{
+	tst_res_(file, lineno, result, message);
+	kvm_exit();
+}
+
+void tst_handle_interrupt(struct kvm_interrupt_frame *ifrm, long vector,
+	unsigned long errcode)
+{
+	uintptr_t ip = kvm_get_interrupt_ip(ifrm);
+	const char *iname;
+	tst_interrupt_callback callback;
+	int ret = 0;
+
+	if (vector < 0 || vector >= INTERRUPT_COUNT)
+		tst_fatal_error(__FILE__, __LINE__, "Unexpected interrupt", ip);
+
+	callback = intr_handlers[vector].callback;
+
+	if (callback)
+		ret = callback(intr_handlers[vector].userdata, ifrm, errcode);
+
+	iname = tst_interrupt_names[vector];
+	iname = iname ? iname : "Unexpected interrupt";
+
+	if (!ret)
+		tst_fatal_error(__FILE__, __LINE__, iname, ip);
+}
diff --git a/testcases/kernel/kvm/lib_host.c b/testcases/kernel/kvm/lib_host.c
new file mode 100644
index 000000000..a52722b7b
--- /dev/null
+++ b/testcases/kernel/kvm/lib_host.c
@@ -0,0 +1,215 @@
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
+const unsigned char tst_kvm_reset_code[VM_RESET_CODE_SIZE] = {
+	0xea, 0x00, 0x10, 0x00, 0x00	/* JMP 0x1000 */
+};
+
+void tst_kvm_validate_result(int value)
+{
+	int ttype, valid_result[] = {TPASS, TFAIL, TBROK, TWARN, TINFO, TCONF};
+	size_t i;
+
+	if (value == KVM_TNONE)
+		tst_brk(TBROK, "KVM test did not return any result");
+
+	ttype = TTYPE_RESULT(value);
+
+	for (i = 0; i < ARRAY_SIZE(valid_result); i++) {
+		if (ttype == valid_result[i])
+			return;
+	}
+
+	tst_brk(TBROK, "KVM test returned invalid result value %d", value);
+}
+
+void tst_kvm_print_result(const struct tst_kvm_instance *inst)
+{
+	int ttype;
+	const struct tst_kvm_result *result = inst->result;
+	const char *file = inst->ram;
+
+	tst_kvm_validate_result(result->result);
+	ttype = TTYPE_RESULT(result->result);
+	file += result->file_addr;
+
+	if (ttype == TBROK)
+		tst_brk_(file, result->lineno, ttype, "%s", result->message);
+	else
+		tst_res_(file, result->lineno, ttype, "%s", result->message);
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
+	memslot.userspace_addr = (uintptr_t)ret;
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
+	size_t pagesize, result_pageaddr = KVM_RESULT_BASEADDR;
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
+	result_pageaddr -= result_pageaddr % pagesize;
+
+	if (payload_size + MIN_FREE_RAM > ram_size - VM_KERNEL_BASEADDR) {
+		ram_size = payload_size + MIN_FREE_RAM + VM_KERNEL_BASEADDR;
+		ram_size += 1024 * 1024 - 1;
+		ram_size -= ram_size % (1024 * 1024);
+		tst_res(TWARN, "RAM size increased to %zu bytes", ram_size);
+	}
+
+	if (ram_size > result_pageaddr) {
+		ram_size = result_pageaddr;
+		tst_res(TWARN, "RAM size truncated to %zu bytes", ram_size);
+	}
+
+	sys_fd = SAFE_OPEN("/dev/kvm", O_RDWR);
+	inst->vcpu_info_size = SAFE_IOCTL(sys_fd, KVM_GET_VCPU_MMAP_SIZE, 0);
+	inst->vm_fd = SAFE_IOCTL(sys_fd, KVM_CREATE_VM, 0);
+	cpuid_data = tst_kvm_get_cpuid(sys_fd);
+	SAFE_CLOSE(sys_fd);
+
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
+	while (1) {
+		inst->result->result = KVM_TNONE;
+		inst->result->message[0] = '\0';
+		SAFE_IOCTL(inst->vcpu_fd, KVM_RUN, 0);
+
+		if (inst->vcpu_info->exit_reason != KVM_EXIT_HLT) {
+			SAFE_IOCTL(inst->vcpu_fd, KVM_GET_REGS, &regs);
+			tst_brk(TBROK,
+				"Unexpected VM exit, RIP=0x%llx, reason=%u",
+				regs.rip, inst->vcpu_info->exit_reason);
+		}
+
+		if (inst->result->result == KVM_TEXIT)
+			break;
+
+		tst_kvm_print_result(inst);
+	}
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
diff --git a/testcases/kernel/kvm/lib_x86.c b/testcases/kernel/kvm/lib_x86.c
new file mode 100644
index 000000000..dc2354b10
--- /dev/null
+++ b/testcases/kernel/kvm/lib_x86.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2021 SUSE LLC <mdoucha@suse.cz>
+ *
+ * x86-specific KVM helper functions
+ */
+
+#include "kvm_x86.h"
+
+struct kvm_interrupt_frame {
+	uintptr_t eip, cs, eflags, esp, ss;
+};
+
+const char *tst_interrupt_names[INTERRUPT_COUNT] = {
+	"Division by zero",
+	"Debug interrupt",
+	"Non-maskable interrupt",
+	"Breakpoint",
+	"Arithmetic overflow",
+	"Bound range exception",
+	"Illegal instruction error",
+	"Device not available error",
+	"Double fault",
+	NULL,
+	"Invalid TSS error",
+	"Segment not present error",
+	"Stack segment fault",
+	"General protection fault",
+	"Page fault",
+	NULL,
+	"Floating point exception",
+	"Alignment error",
+	"Machine check exception",
+	"SIMD floating point exception",
+	"Virtualization exception",
+	"Control protection exception",
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	"Hypervisor injection exception",
+	"VMM communication exception",
+	"Security exception",
+	NULL
+};
+
+static uintptr_t intr_handlers[] = {
+	(uintptr_t)kvm_handle_zerodiv,
+	(uintptr_t)kvm_handle_debug,
+	(uintptr_t)kvm_handle_nmi,
+	(uintptr_t)kvm_handle_breakpoint,
+	(uintptr_t)kvm_handle_overflow,
+	(uintptr_t)kvm_handle_bound_range_exc,
+	(uintptr_t)kvm_handle_bad_opcode,
+	(uintptr_t)kvm_handle_device_error,
+	(uintptr_t)kvm_handle_double_fault,
+	(uintptr_t)kvm_handle_bad_exception,
+	(uintptr_t)kvm_handle_invalid_tss,
+	(uintptr_t)kvm_handle_segfault,
+	(uintptr_t)kvm_handle_stack_fault,
+	(uintptr_t)kvm_handle_gpf,
+	(uintptr_t)kvm_handle_page_fault,
+	(uintptr_t)kvm_handle_bad_exception,
+	(uintptr_t)kvm_handle_fpu_error,
+	(uintptr_t)kvm_handle_alignment_error,
+	(uintptr_t)kvm_handle_machine_check,
+	(uintptr_t)kvm_handle_simd_error,
+	(uintptr_t)kvm_handle_virt_error,
+	(uintptr_t)kvm_handle_cpe,
+	(uintptr_t)kvm_handle_bad_exception,
+	(uintptr_t)kvm_handle_bad_exception,
+	(uintptr_t)kvm_handle_bad_exception,
+	(uintptr_t)kvm_handle_bad_exception,
+	(uintptr_t)kvm_handle_bad_exception,
+	(uintptr_t)kvm_handle_bad_exception,
+	(uintptr_t)kvm_handle_hv_injection,
+	(uintptr_t)kvm_handle_vmm_comm,
+	(uintptr_t)kvm_handle_security_error,
+	(uintptr_t)kvm_handle_bad_exception,
+	0
+};
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
+	for (i = 0; intr_handlers[i]; i++)
+		kvm_set_intr_handler(i, intr_handlers[i]);
+
+	for (; i < X86_INTR_COUNT; i++)
+		kvm_set_intr_handler(i, (uintptr_t)kvm_handle_bad_exception);
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
+		"cpuid\n"
+		: "=a" (buf->eax), "=b" (buf->ebx), "=c" (buf->ecx),
+			"=d" (buf->edx)
+		: "0" (eax), "2" (ecx)
+	);
+}
+
+uint64_t kvm_rdmsr(unsigned int msr)
+{
+	unsigned int ret_lo, ret_hi;
+
+	asm (
+		"rdmsr\n"
+		: "=a" (ret_lo), "=d" (ret_hi)
+		: "c" (msr)
+	);
+
+	return (((uint64_t)ret_hi) << 32) | ret_lo;
+}
+
+void kvm_wrmsr(unsigned int msr, uint64_t value)
+{
+	uint32_t val_lo = value & 0xffffffff, val_hi = value >> 32;
+
+	asm (
+		"wrmsr\n"
+		:
+		: "a" (val_lo), "d" (val_hi), "c" (msr)
+	);
+}
+
+uintptr_t kvm_get_interrupt_ip(const struct kvm_interrupt_frame *ifrm)
+{
+	return ifrm->eip;
+}
diff --git a/testcases/kernel/kvm/linker/payload.lds b/testcases/kernel/kvm/linker/payload.lds
new file mode 100644
index 000000000..a544fd37a
--- /dev/null
+++ b/testcases/kernel/kvm/linker/payload.lds
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
diff --git a/testcases/kernel/kvm/linker/x86.lds b/testcases/kernel/kvm/linker/x86.lds
new file mode 100644
index 000000000..f1546dedb
--- /dev/null
+++ b/testcases/kernel/kvm/linker/x86.lds
@@ -0,0 +1,74 @@
+OUTPUT_FORMAT(elf32-i386)
+
+PHDRS
+{
+	headers PT_PHDR PHDRS ;
+	text PT_LOAD FILEHDR PHDRS ;
+	bss PT_LOAD ;
+}
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
+		*(.init.memlayout)
+	} :text
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
+	.init :
+	{
+		KEEP (*(SORT_NONE(.init)))
+	}
+
+	.data :
+	{
+		*(.data.strings)
+		*(.data)
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
+	} :bss
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
diff --git a/testcases/kernel/kvm/linker/x86_64.lds b/testcases/kernel/kvm/linker/x86_64.lds
new file mode 100644
index 000000000..000bb0338
--- /dev/null
+++ b/testcases/kernel/kvm/linker/x86_64.lds
@@ -0,0 +1,74 @@
+OUTPUT_FORMAT(elf64-x86-64)
+
+PHDRS
+{
+	headers PT_PHDR PHDRS ;
+	text PT_LOAD FILEHDR PHDRS ;
+	bss PT_LOAD ;
+}
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
+		*(.init.memlayout)
+	} :text
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
+	.init :
+	{
+		KEEP (*(SORT_NONE(.init)))
+	}
+
+	.data :
+	{
+		*(.data.strings)
+		*(.data)
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
+	} :bss
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
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
