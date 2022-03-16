Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94ACBC433EF
	for <ltp@archiver.kernel.org>; Wed, 16 Mar 2022 17:04:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2AC1F3C93DA
	for <ltp@archiver.kernel.org>; Wed, 16 Mar 2022 18:03:58 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D2093C0711
 for <ltp@lists.linux.it>; Wed, 16 Mar 2022 18:03:43 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 872F6600855
 for <ltp@lists.linux.it>; Wed, 16 Mar 2022 18:03:42 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7E0771F381;
 Wed, 16 Mar 2022 17:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647450221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=33qPzzdjHHo+UJL7CzJxng5UsMhtUN1Lo7p1p5Pl8bw=;
 b=K0gRyJADYTDF1uU97Xc4uDO9qsCat9qqc+LqJRo3nn1BnUSHIqdhYCvXmeUH0Mb6ogf2PG
 Iky726aqMDIfU//Cqk7XBSGKktGSTEPYlw8slAkcEOEFR2tWY2mqkGLiI9oYqV+vfVHIc7
 FuhpJGMDRz+gZwuvVutbSK4v5iM/aRo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647450221;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=33qPzzdjHHo+UJL7CzJxng5UsMhtUN1Lo7p1p5Pl8bw=;
 b=ueqQzP90MxczUJugsdofBB5J2+xBCervA0PVUWC4ooADh5mZNeh44fpNxZJHtwfkD7VojN
 iLja96nYBZBDUWCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5576213B5E;
 Wed, 16 Mar 2022 17:03:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +tGdEm0YMmIWUgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 16 Mar 2022 17:03:41 +0000
Message-ID: <60ee7094-fc86-b06c-87e5-500018d9de29@suse.cz>
Date: Wed, 16 Mar 2022 18:03:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To: rpalethorpe@suse.de
References: <20220309164954.23751-1-mdoucha@suse.cz> <87k0cv5ij5.fsf@suse.de>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <87k0cv5ij5.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 15. 03. 22 16:00, Richard Palethorpe wrote:
> Hi Martin,
> 
> Martin Doucha <mdoucha@suse.cz> writes:
>> +void tst_kvm_print_result(const struct tst_kvm_result *result)
>> +{
>> +	int ttype;
>> +
>> +	tst_kvm_validate_result(result->result);
>> +	ttype = TTYPE_RESULT(result->result);
>> +
>> +	if (ttype == TBROK)
>> +		tst_brk(ttype, "%s", result->message);
>> +	else
>> +		tst_res(ttype, "%s", result->message);
>> +}
> 
> Could you please pass the file and lineno from the test?

I've skipped that mainly because passing the filename would require an
extra string buffer in the result structure. But I guess I can pass just
a 64bit string address since the filename is a string constant and then
read the text from the VM memory buffer.

>> +void tst_kvm_create_instance(struct tst_kvm_instance *inst, size_t ram_size)
>> +{
>> +	int sys_fd;
>> +	size_t pagesize, result_pageaddr = KVM_RESULT_BASEADDR;
>> +	char *vm_result, *reset_ptr;
>> +	struct kvm_cpuid2 *cpuid_data;
>> +	const size_t payload_size = kvm_payload_end - kvm_payload_start;
>> +
>> +	memset(inst, 0, sizeof(struct tst_kvm_instance));
>> +	inst->vm_fd = -1;
>> +	inst->vcpu_fd = -1;
>> +	inst->vcpu_info = MAP_FAILED;
>> +
>> +	pagesize = SAFE_SYSCONF(_SC_PAGESIZE);
>> +	result_pageaddr -= result_pageaddr % pagesize;
>> +
>> +	if (payload_size + MIN_FREE_RAM > ram_size - VM_KERNEL_BASEADDR) {
>> +		ram_size = payload_size + MIN_FREE_RAM + VM_KERNEL_BASEADDR;
>> +		ram_size += 1024 * 1024 - 1;
>> +		ram_size -= ram_size % (1024 * 1024);
>> +		tst_res(TWARN, "RAM size increased to %zu bytes", ram_size);
>> +	}
>> +
>> +	if (ram_size > result_pageaddr) {
>> +		ram_size = result_pageaddr;
>> +		tst_res(TWARN, "RAM size truncated to %zu bytes", ram_size);
>> +	}
>> +
>> +	/* Create VM */
> 
> These comments are pretty redundant when we have ioctl's like
> KVM_CREATE_VM and KVM_CREATE_VCPU. There are much harder things to
> understand in this patchset.

I know that the code is straightforward. But it's quite dense so I've
added the comments as section headers for easier navigation when you
need to change something.

>> +	sys_fd = SAFE_OPEN("/dev/kvm", O_RDWR);
>> +	inst->vcpu_info_size = SAFE_IOCTL(sys_fd, KVM_GET_VCPU_MMAP_SIZE, 0);
>> +	inst->vm_fd = SAFE_IOCTL(sys_fd, KVM_CREATE_VM, 0);
>> +	cpuid_data = tst_kvm_get_cpuid(sys_fd);
>> +	SAFE_CLOSE(sys_fd);
>> +
>> +	/* Create virtual CPU */
>> +	inst->vcpu_fd = SAFE_IOCTL(inst->vm_fd, KVM_CREATE_VCPU, 0);
>> +
>> +	if (cpuid_data) {
>> +		SAFE_IOCTL(inst->vcpu_fd, KVM_SET_CPUID2, cpuid_data);
>> +		free(cpuid_data);
>> +	}
>> +
>> +	inst->vcpu_info = SAFE_MMAP(NULL, inst->vcpu_info_size,
>> +		PROT_READ | PROT_WRITE, MAP_SHARED, inst->vcpu_fd, 0);
>> +
>> +	/* Set VM memory banks and install test program */
>> +	inst->ram = tst_kvm_alloc_memory(inst->vm_fd, 0, 0, ram_size, 0);
>> +	vm_result = tst_kvm_alloc_memory(inst->vm_fd, 1, KVM_RESULT_BASEADDR,
>> +		KVM_RESULT_SIZE, 0);
>> +	memset(vm_result, 0, KVM_RESULT_SIZE);
>> +	memcpy(inst->ram + VM_KERNEL_BASEADDR, kvm_payload_start, payload_size);
>> +
>> +	reset_ptr = vm_result + (VM_RESET_BASEADDR % pagesize);
>> +	memcpy(reset_ptr, tst_kvm_reset_code, sizeof(tst_kvm_reset_code));
>> +	inst->result = (struct tst_kvm_result *)(vm_result +
>> +		(KVM_RESULT_BASEADDR % pagesize));
>> +	inst->result->result = KVM_TNONE;
>> +	inst->result->message[0] = '\0';
>> +}

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
