Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC71C433EF
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 15:42:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6570B3C93D3
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 16:42:50 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 759503C04C3
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 16:42:40 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9FE36200B73
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 16:42:39 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id E594C1F397
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 15:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647358958;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=02XX8oMPI3c19pgMr40k5DMKDInx+0tze1YE0u6sqSI=;
 b=NdJpu/wWQ2cA7l+QJ9uji9vw8zbd62GA5sU1cetm3Y6FJIA3vqJDYvu8dYuGHLaZGIwvPj
 BPdB/Gyc9NkZQC1CFgEfA4V+ErmW2K93Ehs0p29fKcEcTE0iiZpG5Jg0nKYOG/XlF9nuZ9
 +p8Dn+V16PbyQRoAURqPEqWMHMb5S+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647358958;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=02XX8oMPI3c19pgMr40k5DMKDInx+0tze1YE0u6sqSI=;
 b=xZXuq4l1H+lJjb7Qu7r8MOM0+JAspCBEu4Be5IZTHxGb27eDUpGFLjwwNZmd7G9PKESeDv
 vT84NXiClohs2VBA==
Received: from g78 (unknown [10.163.24.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 939EAA3B92;
 Tue, 15 Mar 2022 15:42:38 +0000 (UTC)
References: <20220309164954.23751-1-mdoucha@suse.cz>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 15 Mar 2022 15:00:08 +0000
In-reply-to: <20220309164954.23751-1-mdoucha@suse.cz>
Message-ID: <87k0cv5ij5.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] KVM test infrastructure
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

Martin Doucha <mdoucha@suse.cz> writes:

> Implement LTP infrastructure for tests which require executing a special
> program inside KVM virtual machine. The infrastructure is split into two parts:
> the host library and the guest library.
>
> The host library provides functions for setting up and running virtual machines
> with test payload built from test sources.
>
> The guest library provides CPU bootstrap code and basic implementation of
> some C and LTP library functions as well as functions for accessing low-level
> arch features like special registers, interrupt tables or memory mapping tables.
>
> The test sources will contain both guest-side payload code and host-side setup
> code separated by preprocessor switch. The files get compiled twice with
> different compiler options. Once to build the VM payload, once to build
> the main program that will create the VM and execute the payload
> inside it.

This is great!

Due to its size I'll just comment as I get chance to read it.

> diff --git a/testcases/kernel/kvm/lib_host.c b/testcases/kernel/kvm/lib_host.c
> new file mode 100644
> index 000000000..d070c8106
> --- /dev/null
> +++ b/testcases/kernel/kvm/lib_host.c
> @@ -0,0 +1,215 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2021 SUSE LLC <mdoucha@suse.cz>
> + *
> + * KVM host library for setting up and running virtual machine tests.
> + */
> +
> +#include <stdlib.h>
> +#include <errno.h>
> +
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_test.h"
> +#include "kvm_host.h"
> +
> +static struct tst_kvm_instance test_vm = { .vm_fd = -1 };
> +
> +const unsigned char tst_kvm_reset_code[VM_RESET_CODE_SIZE] = {
> +	0xea, 0x00, 0x10, 0x00, 0x00	/* JMP 0x1000 */
> +};
> +
> +void tst_kvm_validate_result(int value)
> +{
> +	int ttype, valid_result[] = {TPASS, TFAIL, TBROK, TWARN, TINFO, TCONF};
> +	size_t i;
> +
> +	if (value == KVM_TNONE)
> +		tst_brk(TBROK, "KVM test did not return any result");
> +
> +	ttype = TTYPE_RESULT(value);
> +
> +	for (i = 0; i < ARRAY_SIZE(valid_result); i++) {
> +		if (ttype == valid_result[i])
> +			return;
> +	}
> +
> +	tst_brk(TBROK, "KVM test returned invalid result value %d", value);
> +}
> +
> +void tst_kvm_print_result(const struct tst_kvm_result *result)
> +{
> +	int ttype;
> +
> +	tst_kvm_validate_result(result->result);
> +	ttype = TTYPE_RESULT(result->result);
> +
> +	if (ttype == TBROK)
> +		tst_brk(ttype, "%s", result->message);
> +	else
> +		tst_res(ttype, "%s", result->message);
> +}

Could you please pass the file and lineno from the test?

> +
> +void *tst_kvm_alloc_memory(int vm, unsigned int slot, uint64_t baseaddr,
> +	size_t size, unsigned int flags)
> +{
> +	size_t pagesize;
> +	void *ret;
> +	struct kvm_userspace_memory_region memslot = {
> +		.slot = slot,
> +		.flags = flags
> +	};
> +
> +	pagesize = SAFE_SYSCONF(_SC_PAGESIZE);
> +	size += (baseaddr % pagesize) + pagesize - 1;
> +	baseaddr -= baseaddr % pagesize;
> +	size -= size % pagesize;
> +	ret = tst_alloc(size);
> +
> +	memslot.guest_phys_addr = baseaddr;
> +	memslot.memory_size = size;
> +	memslot.userspace_addr = (uintptr_t)ret;
> +	SAFE_IOCTL(vm, KVM_SET_USER_MEMORY_REGION, &memslot);
> +	return ret;
> +}
> +
> +struct kvm_cpuid2 *tst_kvm_get_cpuid(int sysfd)
> +{
> +	unsigned int count;
> +	int result;
> +	struct kvm_cpuid2 *ret;
> +
> +	if (!SAFE_IOCTL(sysfd, KVM_CHECK_EXTENSION, KVM_CAP_EXT_CPUID))
> +		return NULL;
> +
> +	for (count = 8; count < 1 << 30; count *= 2) {
> +		ret = SAFE_MALLOC(sizeof(struct kvm_cpuid2) +
> +			count * sizeof(struct kvm_cpuid_entry2));
> +		ret->nent = count;
> +		errno = 0;
> +		result = ioctl(sysfd, KVM_GET_SUPPORTED_CPUID, ret);
> +
> +		if (!result)
> +			return ret;
> +
> +		free(ret);
> +
> +		if (errno != E2BIG)
> +			break;
> +	}
> +
> +	tst_brk(TBROK | TERRNO, "ioctl(KVM_GET_SUPPORTED_CPUID) failed");
> +	return NULL;
> +}
> +
> +void tst_kvm_create_instance(struct tst_kvm_instance *inst, size_t ram_size)
> +{
> +	int sys_fd;
> +	size_t pagesize, result_pageaddr = KVM_RESULT_BASEADDR;
> +	char *vm_result, *reset_ptr;
> +	struct kvm_cpuid2 *cpuid_data;
> +	const size_t payload_size = kvm_payload_end - kvm_payload_start;
> +
> +	memset(inst, 0, sizeof(struct tst_kvm_instance));
> +	inst->vm_fd = -1;
> +	inst->vcpu_fd = -1;
> +	inst->vcpu_info = MAP_FAILED;
> +
> +	pagesize = SAFE_SYSCONF(_SC_PAGESIZE);
> +	result_pageaddr -= result_pageaddr % pagesize;
> +
> +	if (payload_size + MIN_FREE_RAM > ram_size - VM_KERNEL_BASEADDR) {
> +		ram_size = payload_size + MIN_FREE_RAM + VM_KERNEL_BASEADDR;
> +		ram_size += 1024 * 1024 - 1;
> +		ram_size -= ram_size % (1024 * 1024);
> +		tst_res(TWARN, "RAM size increased to %zu bytes", ram_size);
> +	}
> +
> +	if (ram_size > result_pageaddr) {
> +		ram_size = result_pageaddr;
> +		tst_res(TWARN, "RAM size truncated to %zu bytes", ram_size);
> +	}
> +
> +	/* Create VM */

These comments are pretty redundant when we have ioctl's like
KVM_CREATE_VM and KVM_CREATE_VCPU. There are much harder things to
understand in this patchset.

> +	sys_fd = SAFE_OPEN("/dev/kvm", O_RDWR);
> +	inst->vcpu_info_size = SAFE_IOCTL(sys_fd, KVM_GET_VCPU_MMAP_SIZE, 0);
> +	inst->vm_fd = SAFE_IOCTL(sys_fd, KVM_CREATE_VM, 0);
> +	cpuid_data = tst_kvm_get_cpuid(sys_fd);
> +	SAFE_CLOSE(sys_fd);
> +
> +	/* Create virtual CPU */
> +	inst->vcpu_fd = SAFE_IOCTL(inst->vm_fd, KVM_CREATE_VCPU, 0);
> +
> +	if (cpuid_data) {
> +		SAFE_IOCTL(inst->vcpu_fd, KVM_SET_CPUID2, cpuid_data);
> +		free(cpuid_data);
> +	}
> +
> +	inst->vcpu_info = SAFE_MMAP(NULL, inst->vcpu_info_size,
> +		PROT_READ | PROT_WRITE, MAP_SHARED, inst->vcpu_fd, 0);
> +
> +	/* Set VM memory banks and install test program */
> +	inst->ram = tst_kvm_alloc_memory(inst->vm_fd, 0, 0, ram_size, 0);
> +	vm_result = tst_kvm_alloc_memory(inst->vm_fd, 1, KVM_RESULT_BASEADDR,
> +		KVM_RESULT_SIZE, 0);
> +	memset(vm_result, 0, KVM_RESULT_SIZE);
> +	memcpy(inst->ram + VM_KERNEL_BASEADDR, kvm_payload_start, payload_size);
> +
> +	reset_ptr = vm_result + (VM_RESET_BASEADDR % pagesize);
> +	memcpy(reset_ptr, tst_kvm_reset_code, sizeof(tst_kvm_reset_code));
> +	inst->result = (struct tst_kvm_result *)(vm_result +
> +		(KVM_RESULT_BASEADDR % pagesize));
> +	inst->result->result = KVM_TNONE;
> +	inst->result->message[0] = '\0';
> +}
> +
> +void tst_kvm_run_instance(struct tst_kvm_instance *inst)
> +{
> +	struct kvm_regs regs;
> +
> +	while (1) {
> +		inst->result->result = KVM_TNONE;
> +		inst->result->message[0] = '\0';
> +		SAFE_IOCTL(inst->vcpu_fd, KVM_RUN, 0);
> +
> +		if (inst->vcpu_info->exit_reason != KVM_EXIT_HLT) {
> +			SAFE_IOCTL(inst->vcpu_fd, KVM_GET_REGS, &regs);
> +			tst_brk(TBROK,
> +				"Unexpected VM exit, RIP=0x%llx, reason=%u",
> +				regs.rip, inst->vcpu_info->exit_reason);
> +		}
> +
> +		if (inst->result->result == KVM_TEXIT)
> +			break;
> +
> +		tst_kvm_print_result(inst->result);
> +	}
> +}
> +
> +void tst_kvm_destroy_instance(struct tst_kvm_instance *inst)
> +{
> +	if (inst->vm_fd < 0)
> +		return;
> +
> +	if (inst->vcpu_info != MAP_FAILED)
> +		SAFE_MUNMAP(inst->vcpu_info, inst->vcpu_info_size);
> +
> +	if (inst->vcpu_fd >= 0)
> +		SAFE_CLOSE(inst->vcpu_fd);
> +
> +	SAFE_CLOSE(inst->vm_fd);
> +}
> +
> +void tst_kvm_setup(void)
> +{
> +	tst_kvm_create_instance(&test_vm, DEFAULT_RAM_SIZE);
> +}
> +
> +void tst_kvm_run(void)
> +{
> +	tst_kvm_run_instance(&test_vm);
> +}
> +
> +void tst_kvm_cleanup(void)
> +{
> +	tst_kvm_destroy_instance(&test_vm);
> +}

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
