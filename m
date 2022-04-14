Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67D8C433EF
	for <ltp@archiver.kernel.org>; Thu, 14 Apr 2022 10:23:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D49773CA5CB
	for <ltp@archiver.kernel.org>; Thu, 14 Apr 2022 12:23:10 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A692E3C5785
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 12:22:57 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 032E5140054A
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 12:22:55 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3196F21611;
 Thu, 14 Apr 2022 10:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1649931775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EUcjU48rV5qM6eLKxOQ0IiUTmU4pWe1WY69Y55VVfs4=;
 b=onxff8zX7BGH0uMRHfECmj9Uz8sG+RWzkMNv7/T5gdIqWgRHfKE7vekfngDB4wdHsQiCBs
 PY1PpVR8B/Hp3Cawmx9EZyyypJkxznp1zNq4fyAcYkZGA+cepZj1TAA/aYcOB1HwamEPac
 jnS/Vi7gy+mvKeR2cXFBKq7OtrMqjP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1649931775;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EUcjU48rV5qM6eLKxOQ0IiUTmU4pWe1WY69Y55VVfs4=;
 b=NJlCsc/xle08Qrm/j8mR5uDUB4qx/s5aJHn+AE2zIb9PBv+Tr9Hma+pQ/mfrPNmZQ6Tsu7
 txruiQ3Pz01oA2AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1328C13A86;
 Thu, 14 Apr 2022 10:22:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id b4l2A//1V2LBeQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 14 Apr 2022 10:22:55 +0000
Date: Thu, 14 Apr 2022 12:25:09 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Ylf2hd82r1pLFlbd@yuki>
References: <20220331113324.14742-1-mdoucha@suse.cz>
 <20220331113324.14742-3-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220331113324.14742-3-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] KVM test infrastructure
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> diff --git a/testcases/kernel/kvm/include/kvm_guest.h b/testcases/kernel/kvm/include/kvm_guest.h
> new file mode 100644
> index 000000000..edb1cb66d
> --- /dev/null
> +++ b/testcases/kernel/kvm/include/kvm_guest.h
> @@ -0,0 +1,82 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2021 SUSE LLC <mdoucha@suse.cz>
> + *
> + * Minimal test library for KVM tests
> + */
> +
> +#ifndef KVM_GUEST_H_
> +#define KVM_GUEST_H_
> +
> +/*
> + * These constants must match the value of corresponding constants defined
> + * in tst_res_flags.h.
> + */
> +#define TPASS	0	/* Test passed flag */
> +#define TFAIL	1	/* Test failed flag */
> +#define TBROK	2	/* Test broken flag */
> +#define TWARN	4	/* Test warning flag */
> +#define TINFO	16	/* Test information flag */
> +#define TCONF	32	/* Test not appropriate for configuration */

The tst_res_flags.h header has been created so that there will be no
need to copy these definitions around like this. Why not just include
the header?

> +#define TST_TEST_TCONF(message) \
> +	void main(void) { tst_brk(TCONF, message); }
> +
> +#define INTERRUPT_COUNT 32
> +
> +typedef unsigned long size_t;
> +typedef long ssize_t;
> +
> +typedef signed char int8_t;
> +typedef unsigned char uint8_t;
> +typedef short int16_t;
> +typedef unsigned short uint16_t;
> +typedef int int32_t;
> +typedef unsigned int uint32_t;
> +typedef long long int64_t;
> +typedef unsigned long long uint64_t;
> +typedef unsigned long uintptr_t;
> +
> +#define NULL ((void *)0)
> +
> +void *memset(void *dest, int val, size_t size);
> +void *memzero(void *dest, size_t size);
> +void *memcpy(void *dest, const void *src, size_t size);
> +
> +char *strcpy(char *dest, const char *src);
> +char *strcat(char *dest, const char *src);
> +size_t strlen(const char *str);
> +
> +/* Exit the VM by looping on a HLT instruction forever */
> +void kvm_exit(void) __attribute__((noreturn));
> +
> +/* Exit the VM using the HLT instruction but allow resume */
> +void kvm_yield(void);
> +
> +void tst_res_(const char *file, const int lineno, int result,
> +	const char *message);
> +#define tst_res(result, msg) tst_res_(__FILE__, __LINE__, (result), (msg))
> +
> +void tst_brk_(const char *file, const int lineno, int result,
> +	const char *message) __attribute__((noreturn));
> +#define tst_brk(result, msg) tst_brk_(__FILE__, __LINE__, (result), (msg))

I think that it may be slightly better to name these kvm_res() and
kvm_brk() to make clear that these are used in the guest context and
that the implementation is actually different. I guess that it would
make sense to have all the functions called from the guest prefixed with
kvm_ just to make the boundary clearer.

> +void *tst_heap_alloc_aligned(size_t size, size_t align);
> +void *tst_heap_alloc(size_t size);
>
> +/* Arch dependent: */
> +
> +struct kvm_interrupt_frame;
> +
> +typedef int (*tst_interrupt_callback)(void *userdata,
> +	struct kvm_interrupt_frame *ifrm, unsigned long errcode);
> +
> +extern const char *tst_interrupt_names[INTERRUPT_COUNT];
> +
> +void tst_set_interrupt_callback(unsigned int vector,
> +	tst_interrupt_callback func, void *userdata);
> +
> +/* Get the instruction pointer from interrupt frame */
> +uintptr_t kvm_get_interrupt_ip(const struct kvm_interrupt_frame *ifrm);
> +
> +#endif /* KVM_GUEST_H_ */
> diff --git a/testcases/kernel/kvm/include/kvm_host.h b/testcases/kernel/kvm/include/kvm_host.h
> new file mode 100644
> index 000000000..52cc3f5e9
> --- /dev/null
> +++ b/testcases/kernel/kvm/include/kvm_host.h
> @@ -0,0 +1,115 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2021 SUSE LLC <mdoucha@suse.cz>
> + *
> + * KVM host library for setting up and running virtual machine tests. Tests
> + * can either use the default setup/run/host functions or use the advanced
> + * API to create customized VMs.
> + */
> +
> +/*
> + * Most basic usage:
> + *
> + * #include "kvm_test.h"
> + *
> + * #ifdef COMPILE_PAYLOAD
> + *
> + * void main(void)
> + * {
> + *	[VM guest code goes here]
> + * }
> + *
> + * #else
> + *
> + * [optional VM host setup/run/cleanup code goes here]
> + *
> + * static struct tst_test test = {
> + *	.test_all = tst_kvm_run,
> + *	.setup = tst_kvm_setup,
> + *	.cleanup = tst_kvm_cleanup,
> + * };
> + *
> + * #endif
> + */
> +
> +#ifndef KVM_HOST_H_
> +#define KVM_HOST_H_
> +
> +#include <inttypes.h>
> +#include <linux/kvm.h>
> +#include "kvm_common.h"
> +
> +#define VM_KERNEL_BASEADDR 0x1000
> +#define VM_RESET_BASEADDR 0xfffffff0
> +#define VM_RESET_CODE_SIZE 8
> +
> +#define MIN_FREE_RAM (10 * 1024 * 1024)
> +#define DEFAULT_RAM_SIZE (16 * 1024 * 1024)
> +
> +struct tst_kvm_instance {
> +	int vm_fd, vcpu_fd;
> +	struct kvm_run *vcpu_info;
> +	size_t vcpu_info_size;
> +	void *ram;
> +	struct tst_kvm_result *result;
> +};
> +
> +/* Test binary to be installed into the VM at VM_KERNEL_BASEADDR */
> +extern const char kvm_payload_start[], kvm_payload_end[];
> +
> +/* CPU reset code to be installed into the VM at VM_RESET_BASEADDR */
> +extern const unsigned char tst_kvm_reset_code[VM_RESET_CODE_SIZE];
> +
> +/* Default KVM test functions. */
> +void tst_kvm_setup(void);
> +void tst_kvm_run(void);
> +void tst_kvm_cleanup(void);
> +
> +/*
> + * Validate KVM guest test result (usually passed via result->result) and
> + * fail with TBROK if the value cannot be safely passed to tst_res() or
> + * tst_brk().
> + */
> +void tst_kvm_validate_result(int value);
> +
> +/*
> + * Allocate memory slot for the VM. The returned pointer is page-aligned
> + * so the actual requested base address is at ret[baseaddr % pagesize].
> + *
> + * The first argument is a VM file descriptor created by ioctl(KVM_CREATE_VM)
> + *
> + * The return value points to a guarded buffer and the user should not attempt
> + * to free() it. Any extra space added at the beginning or end for page
> + * alignment will be writable.
> + */
> +void *tst_kvm_alloc_memory(int vm, unsigned int slot, uint64_t baseaddr,
> +	size_t size, unsigned int flags);
> +
> +/*
> + * Find CPUIDs supported by KVM. x86_64 tests must set non-default CPUID,
> + * otherwise bootstrap will fail to initialize 64bit mode.
> + * Returns NULL if ioctl(KVM_GET_SUPPORTED_CPUID) is not supported.
> + *
> + * The argument is a file descriptor created by open("/dev/kvm")
> + */
> +struct kvm_cpuid2 *tst_kvm_get_cpuid(int sysfd);
> +
> +/*
> + * Initialize the given KVM instance structure. Creates new KVM virtual machine
> + * with 1 virtual CPU, allocates VM RAM (max. 4GB minus one page) and
> + * shared result structure. KVM memory slots 0 and 1 will be set by this
> + * function.
> + */
> +void tst_kvm_create_instance(struct tst_kvm_instance *inst, size_t ram_size);
> +
> +/*
> + * Execute the given KVM instance and print results.
> + */
> +void tst_kvm_run_instance(struct tst_kvm_instance *inst);
> +
> +/*
> + * Close the given KVM instance.
> + */
> +void tst_kvm_destroy_instance(struct tst_kvm_instance *inst);
> +
> +#endif /* KVM_HOST_H_ */
> diff --git a/testcases/kernel/kvm/include/kvm_test.h b/testcases/kernel/kvm/include/kvm_test.h
> new file mode 100644
> index 000000000..55989eaa5
> --- /dev/null
> +++ b/testcases/kernel/kvm/include/kvm_test.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2021 SUSE LLC <mdoucha@suse.cz>
> + *
> + * Minimal test library for KVM tests
> + */
> +
> +#ifndef KVM_TEST_H_
> +#define KVM_TEST_H_
> +
> +#ifdef COMPILE_PAYLOAD
> +
> +  #include "kvm_guest.h"
> +  #include "kvm_common.h"
> +
> +#else
> +
> +  #include "tst_test.h"
> +  #include "kvm_host.h"
> +
> +#endif /* COMPILE_PAYLOAD */
> +
> +#endif /* KVM_TEST_H_ */
> diff --git a/testcases/kernel/kvm/include/kvm_x86.h b/testcases/kernel/kvm/include/kvm_x86.h
> new file mode 100644
> index 000000000..4f3671135
> --- /dev/null
> +++ b/testcases/kernel/kvm/include/kvm_x86.h
> @@ -0,0 +1,157 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2021 SUSE LLC <mdoucha@suse.cz>
> + *
> + * x86-specific KVM helper functions and structures
> + */
> +
> +#ifndef KVM_X86_H_
> +#define KVM_X86_H_
> +
> +#include "kvm_test.h"
> +
> +/* Interrupts */
> +#define X86_INTR_COUNT 256
> +
> +#define INTR_ZERODIV 0
> +#define INTR_DEBUG 1
> +#define INTR_NMI 2
> +#define INTR_BREAKPOINT 3
> +#define INTR_OVERFLOW 4
> +#define INTR_BOUND_RANGE_EXC 5
> +#define INTR_BAD_OPCODE 6
> +#define INTR_DEVICE_ERROR 7
> +#define INTR_DOUBLE_FAULT 8
> +#define INTR_INVALID_TSS 10
> +#define INTR_SEGFAULT 11
> +#define INTR_STACK_FAULT 12
> +#define INTR_GPF 13
> +#define INTR_PAGE_FAULT 14
> +#define INTR_FPU_ERROR 16
> +#define INTR_ALIGNMENT_ERROR 17
> +#define INTR_MACHINE_CHECK 18
> +#define INTR_SIMD_ERROR 19
> +#define INTR_VIRT_ERROR 20
> +#define INTR_CPE 21
> +#define INTR_HV_INJECTION 28
> +#define INTR_VMM_COMM 29
> +#define INTR_SECURITY_ERROR 30
> +
> +
> +/* CPUID constants */
> +#define CPUID_GET_INPUT_RANGE 0x80000000
> +#define CPUID_GET_EXT_FEATURES 0x80000001
> +
> +
> +/* Model-specific CPU register constants */
> +#define MSR_EFER 0xc0000080
> +
> +#define EFER_SCE (1 << 0)	/* SYSCALL/SYSRET instructions enabled */
> +#define EFER_LME (1 << 8)	/* CPU is running in 64bit mode */
> +#define EFER_LMA (1 << 10)	/* CPU uses 64bit memory paging (read-only) */
> +#define EFER_NXE (1 << 11)	/* Execute disable bit active */
> +
> +
> +/* Control register constants */
> +#define CR4_VME (1 << 0)
> +#define CR4_PVI (1 << 1)
> +#define CR4_TSD (1 << 2)
> +#define CR4_DE (1 << 3)
> +#define CR4_PSE (1 << 4)
> +#define CR4_PAE (1 << 5)
> +#define CR4_MCE (1 << 6)
> +#define CR4_PGE (1 << 7)
> +#define CR4_PCE (1 << 8)
> +#define CR4_OSFXSR (1 << 9)
> +#define CR4_OSXMMEXCPT (1 << 10)
> +#define CR4_UMIP (1 << 11)
> +#define CR4_LA57 (1 << 12)
> +#define CR4_VMXE (1 << 13)
> +#define CR4_SMXE (1 << 14)
> +#define CR4_FSGSBASE (1 << 16)
> +#define CR4_PCIDE (1 << 17)
> +#define CR4_OSXSAVE (1 << 18)
> +#define CR4_KL (1 << 19)
> +#define CR4_SMEP (1 << 20)
> +#define CR4_SMAP (1 << 21)
> +#define CR4_PKE (1 << 22)
> +#define CR4_CET (1 << 23)
> +#define CR4_PKS (1 << 24)
> +
> +struct intr_descriptor {
> +	uint16_t offset_lo;
> +	uint16_t selector;
> +	uint8_t ist;
> +	uint8_t flags;
> +#if defined(__x86_64__)
> +	uint64_t offset_hi; /* top 16 bits must be set to 0 */
> +	uint16_t padding;
> +#else /* defined(__x86_64__) */
> +	uint16_t offset_hi;
> +#endif /* defined(__x86_64__) */
> +} __attribute__((__packed__));
> +
> +struct page_table_entry_pae {
> +	unsigned int present: 1;
> +	unsigned int writable: 1;
> +	unsigned int user_access: 1;
> +	unsigned int write_through: 1;
> +	unsigned int disable_cache: 1;
> +	unsigned int accessed: 1;
> +	unsigned int dirty: 1;
> +	unsigned int page_type: 1;
> +	unsigned int global: 1;
> +	unsigned int padding: 3;
> +	uint64_t address: 40;
> +	unsigned int padding2: 7;
> +	unsigned int prot_key: 4;
> +	unsigned int noexec: 1;
> +} __attribute__((__packed__));
> +
> +struct kvm_cpuid {
> +	unsigned int eax, ebx, ecx, edx;
> +};
> +
> +struct kvm_cregs {
> +	unsigned long cr0, cr2, cr3, cr4;
> +};
> +
> +extern struct page_table_entry_pae kvm_pagetable[];
> +extern struct intr_descriptor kvm_idt[X86_INTR_COUNT];
> +
> +/* Page table helper functions */
> +uintptr_t kvm_get_page_address_pae(const struct page_table_entry_pae *entry);
> +
> +/* Functions for querying CPU info and status */
> +void kvm_get_cpuid(unsigned int eax, unsigned int ecx, struct kvm_cpuid *buf);
> +void kvm_read_cregs(struct kvm_cregs *buf);
> +uint64_t kvm_rdmsr(unsigned int msr);
> +void kvm_wrmsr(unsigned int msr, uint64_t value);
> +
> +/* Low-level interrupt handlers, DO NOT call directly */
> +void kvm_handle_bad_exception(void);
> +void kvm_handle_zerodiv(void);
> +void kvm_handle_debug(void);
> +void kvm_handle_nmi(void);
> +void kvm_handle_breakpoint(void);
> +void kvm_handle_overflow(void);
> +void kvm_handle_bound_range_exc(void);
> +void kvm_handle_bad_opcode(void);
> +void kvm_handle_device_error(void);
> +void kvm_handle_double_fault(void);
> +void kvm_handle_invalid_tss(void);
> +void kvm_handle_segfault(void);
> +void kvm_handle_stack_fault(void);
> +void kvm_handle_gpf(void);
> +void kvm_handle_page_fault(void);
> +void kvm_handle_fpu_error(void);
> +void kvm_handle_alignment_error(void);
> +void kvm_handle_machine_check(void);
> +void kvm_handle_simd_error(void);
> +void kvm_handle_virt_error(void);
> +void kvm_handle_cpe(void);
> +void kvm_handle_hv_injection(void);
> +void kvm_handle_vmm_comm(void);
> +void kvm_handle_security_error(void);
> +
> +#endif /* KVM_X86_H_ */
> diff --git a/testcases/kernel/kvm/lib_guest.c b/testcases/kernel/kvm/lib_guest.c
> new file mode 100644
> index 000000000..f5dfbc46f
> --- /dev/null
> +++ b/testcases/kernel/kvm/lib_guest.c
> @@ -0,0 +1,183 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2021 SUSE LLC <mdoucha@suse.cz>
> + *
> + * Minimal testing library for KVM tests
> + */
> +
> +#include "kvm_test.h"
> +
> +extern char kvm_heap_begin[];
> +
> +static struct tst_kvm_result *const test_result =
> +	(struct tst_kvm_result *)KVM_RESULT_BASEADDR;
> +
> +static char *heap_end = kvm_heap_begin;
> +
> +static struct tst_intr_handler {
> +	tst_interrupt_callback callback;
> +	void *userdata;
> +} intr_handlers[INTERRUPT_COUNT];
> +
> +void *memset(void *dest, int val, size_t size)
> +{
> +	char *ptr = dest;
> +
> +	while (size--)
> +		*ptr++ = val;
> +
> +	return dest;
> +}
> +
> +void *memzero(void *dest, size_t size)
> +{
> +	return memset(dest, 0, size);
> +}
> +
> +void *memcpy(void *dest, const void *src, size_t size)
> +{
> +	char *dptr = dest;
> +	const char *sptr = src;
> +
> +	while (size--)
> +		*dptr++ = *sptr++;
> +
> +	return dest;
> +}
> +
> +char *strcpy(char *dest, const char *src)
> +{
> +	char *ret = dest;
> +
> +	while ((*dest++ = *src++))
> +		;
> +
> +	return ret;
> +}
> +
> +char *strcat(char *dest, const char *src)
> +{
> +	char *ret = dest;
> +
> +	for (; *dest; dest++)
> +		;
> +
> +	strcpy(dest, src);
> +	return ret;
> +}
> +
> +size_t strlen(const char *str)
> +{
> +	size_t ret;
> +
> +	for (ret = 0; str[ret]; ret++)
> +		;
> +
> +	return ret;
> +}
> +
> +char *ptr2hex(char *dest, uintptr_t val)
> +{
> +	unsigned int i;
> +	uintptr_t tmp;
> +	char *ret = dest;
> +
> +	for (i = 4; val >> i; i += 4)
> +		;
> +
> +	do {
> +		i -= 4;
> +		tmp = (val >> i) & 0xf;
> +		*dest++ = tmp + (tmp >= 10 ? 'A' - 10 : '0');
> +	} while (i);
> +
> +	*dest = '\0';
> +	return ret;
> +}
> +
> +void *tst_heap_alloc_aligned(size_t size, size_t align)
> +{
> +	uintptr_t addr = (uintptr_t)heap_end;
> +	void *ret;
> +
> +	addr += align - 1;
> +	addr -= addr % align;
> +	ret = (void *)addr;
> +	addr += size + 3;
> +	addr -= addr % 4;
> +	heap_end = (char *)addr;
> +	return ret;
> +}
> +
> +void *tst_heap_alloc(size_t size)
> +{
> +	void *ret = heap_end;
> +
> +	size += 3;
> +	size -= size % 4;
> +	heap_end += size;
> +	return ret;

We do have a few similar pieces scattered around the code, can put the
code into a macro that would make the code slightly easier to
understand?

We do have LTP_ALIGN() in tst_common.h but I guess that we do not want
to include it here in the guest library.


Other than the very minor comments the code looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
