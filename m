Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D24EAC433EF
	for <ltp@archiver.kernel.org>; Thu, 17 Mar 2022 08:20:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 79C8D3C9419
	for <ltp@archiver.kernel.org>; Thu, 17 Mar 2022 09:20:04 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 75BC33C91FC
 for <ltp@lists.linux.it>; Thu, 17 Mar 2022 09:19:54 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DC8AA1800AF1
 for <ltp@lists.linux.it>; Thu, 17 Mar 2022 09:19:53 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 2780C21115
 for <ltp@lists.linux.it>; Thu, 17 Mar 2022 08:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647505193;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xrk52GaizuktoB0Yat6mz7Hy6XTTe/tNVmx/O/x+wQs=;
 b=bO6KDS32GNeuQFYZuKtlQNUX3rKO0bRAmRp723MaP35qoCqezaB9DJ0Ig1gZO+pw7YDidF
 2VWadPJBk92iMXr+wXY70X9n5RWs6m+DVJvyza+PlhPv3HFcM7A8yt/AbJcHL2LMamB7rb
 tL7KgaB1xuywxbjkk2D3yoF9raEyGWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647505193;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xrk52GaizuktoB0Yat6mz7Hy6XTTe/tNVmx/O/x+wQs=;
 b=7pOJbhz5lZ0Y0nMH0zBNc9HIrmghe0s9WWTYz3vszhlM+4rqhzr5+6rTEoWfvNRbxpYhHL
 qU4nMDkpIL72NLAA==
Received: from g78 (unknown [10.163.24.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id E8921A3B9D;
 Thu, 17 Mar 2022 08:19:52 +0000 (UTC)
References: <20220309164954.23751-1-mdoucha@suse.cz>
 <87k0cv5ij5.fsf@suse.de> <60ee7094-fc86-b06c-87e5-500018d9de29@suse.cz>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 17 Mar 2022 07:59:19 +0000
In-reply-to: <60ee7094-fc86-b06c-87e5-500018d9de29@suse.cz>
Message-ID: <87tubx3s9j.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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

Hi,

Martin Doucha <mdoucha@suse.cz> writes:

> On 15. 03. 22 16:00, Richard Palethorpe wrote:
>> Hi Martin,
>> 
>> Martin Doucha <mdoucha@suse.cz> writes:
>>> +void tst_kvm_print_result(const struct tst_kvm_result *result)
>>> +{
>>> +	int ttype;
>>> +
>>> +	tst_kvm_validate_result(result->result);
>>> +	ttype = TTYPE_RESULT(result->result);
>>> +
>>> +	if (ttype == TBROK)
>>> +		tst_brk(ttype, "%s", result->message);
>>> +	else
>>> +		tst_res(ttype, "%s", result->message);
>>> +}
>> 
>> Could you please pass the file and lineno from the test?
>
> I've skipped that mainly because passing the filename would require an
> extra string buffer in the result structure. But I guess I can pass just
> a 64bit string address since the filename is a string constant and then
> read the text from the VM memory buffer.

Either way sounds good to me.

>
>>> +void tst_kvm_create_instance(struct tst_kvm_instance *inst, size_t ram_size)
>>> +{
>>> +	int sys_fd;
>>> +	size_t pagesize, result_pageaddr = KVM_RESULT_BASEADDR;
>>> +	char *vm_result, *reset_ptr;
>>> +	struct kvm_cpuid2 *cpuid_data;
>>> +	const size_t payload_size = kvm_payload_end - kvm_payload_start;
>>> +
>>> +	memset(inst, 0, sizeof(struct tst_kvm_instance));
>>> +	inst->vm_fd = -1;
>>> +	inst->vcpu_fd = -1;
>>> +	inst->vcpu_info = MAP_FAILED;
>>> +
>>> +	pagesize = SAFE_SYSCONF(_SC_PAGESIZE);
>>> +	result_pageaddr -= result_pageaddr % pagesize;
>>> +
>>> +	if (payload_size + MIN_FREE_RAM > ram_size - VM_KERNEL_BASEADDR) {
>>> +		ram_size = payload_size + MIN_FREE_RAM + VM_KERNEL_BASEADDR;
>>> +		ram_size += 1024 * 1024 - 1;
>>> +		ram_size -= ram_size % (1024 * 1024);
>>> +		tst_res(TWARN, "RAM size increased to %zu bytes", ram_size);
>>> +	}
>>> +
>>> +	if (ram_size > result_pageaddr) {
>>> +		ram_size = result_pageaddr;
>>> +		tst_res(TWARN, "RAM size truncated to %zu bytes", ram_size);
>>> +	}
>>> +
>>> +	/* Create VM */
>> 
>> These comments are pretty redundant when we have ioctl's like
>> KVM_CREATE_VM and KVM_CREATE_VCPU. There are much harder things to
>> understand in this patchset.
>
> I know that the code is straightforward. But it's quite dense so I've
> added the comments as section headers for easier navigation when you
> need to change something.

Makes sense. However the style guide forbids commenting the obvious.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
