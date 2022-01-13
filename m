Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8660C433F5
	for <ltp@archiver.kernel.org>; Thu, 13 Jan 2022 08:49:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1DF813C9509
	for <ltp@archiver.kernel.org>; Thu, 13 Jan 2022 09:49:24 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B8CA03C821C
 for <ltp@lists.linux.it>; Thu, 13 Jan 2022 09:49:12 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1013A140013F
 for <ltp@lists.linux.it>; Thu, 13 Jan 2022 09:49:11 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id DA8E6218B1;
 Thu, 13 Jan 2022 08:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1642063750;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=517OXQA1KpYlzO3USh2UYZxZZVwn9XG5w32kaziivPo=;
 b=tnxms/ZeGj0Dspl9supHHxtOtnTmbFGLXtd9p2Oz6eQNFHgw6nNe6Wvsydj5Q2MgVf08hT
 hjPcv6b+GKObMSI5Xjm2POtiyT2ccjE6zX3C4u6VghScZd0FcEDdPuAd6wkViphL620Sez
 sBvxxNXaFQzfgAIp/KGD1pbv2zTwgx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1642063750;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=517OXQA1KpYlzO3USh2UYZxZZVwn9XG5w32kaziivPo=;
 b=gWXyOcHXvV7elZtu3PuunGJJL4BmwlGVPu12UCmRk2izalzM/lrdHNPwd/GEgscWFulvuZ
 QmoOFIBamlchGHBA==
Received: from g78 (unknown [10.163.24.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 8B19FA3B81;
 Thu, 13 Jan 2022 08:49:10 +0000 (UTC)
References: <YSz36VZ18+N4YsM/@yuki>
 <20210831091005.25361-1-rpalethorpe@suse.com>
 <20210831091005.25361-4-rpalethorpe@suse.com>
 <7cf81226-52ca-5016-5041-ce12b93b534f@jv-coder.de>
 <875yqq1fo7.fsf@suse.de>
 <5de1ae7d-139a-8f76-1e99-27d4491eae15@jv-coder.de>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Joerg Vehlow <lkml@jv-coder.de>
Date: Thu, 13 Jan 2022 07:48:26 +0000
In-reply-to: <5de1ae7d-139a-8f76-1e99-27d4491eae15@jv-coder.de>
Message-ID: <871r1c10my.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/4] bpf_prog05: Drop CAP_BPF and check if ptr
 arithmetic is allowed
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

Hello Joerg,

Joerg Vehlow <lkml@jv-coder.de> writes:

> Hi Richard,
>
> Am 1/11/2022 um 3:36 PM schrieb Richard Palethorpe:
>>>> +	if (log[0] != 0)
>>>> +		tst_brk(TCONF | TERRNO, "No pointer arithmetic:\n %s", log);
>>> This check now fails for me with the following output, where the test
>>> was successful, before this patch. The kernel is a non-standard suse
>>> 5.3.18 with realtime patches.
>>>
>>> bpf_prog05.c:100: TCONF: No pointer arithmetic:
>>>   0: (bf) r2 = r10
>>> 1: (b7) r3 = -1
>>> 2: (0f) r2 += r3
>>> 3: (72) *(u8 *)(r2 +0) = 0
>>> 4: (b7) r0 = 0
>>> 5: (95) exit
>>>
>>> from 2 to 3 (speculative execution): R1=ctx(id=0,off=0,imm=0) R2_w=fp0
>>> R3_w=invP-1 R10=fp0
>>> 3: (72) *(u8 *)(r2 +0) = 0
>>> invalid stack off=0 size=1
>>> processed 7 insns (limit 1000000) max_states_per_insn 0 total_states 0
>>> peak_states 0 mark_read 0
>>> : EACCES (13)
>>>
>>>
>>> Is this too old? But then again, the test was successful before this
>>> patch and your commit message states, that it was not successful on
>>> "older kernels".
>> Are you testing on ARM? eBPF adopted the ARM behavior when dividing
>> by
>> zero.
>> 
>
> No this is x86 and I was expecting 5.3 to not be "very old". IIRC
> patches for the bug tested here are partly already integrated into
> 4.19, so I guess 5.3 shouldn't be "very old" in that context?
>
> I am not sure what you tried to test, I guess accessing the stack
> using indirect pointer arithmetic? Because changing the store to "*(u8
> *)(r10 - 1) = 0", works. But if this indirection is required for the
> actually test, it should fail, but it doesn't -> I think the check
> tests something, that is not actually required for the actual test.

The actual test just checks what the result of modulo and division by
zero are against the 'arbitrary' values chosen by ARM/upstream (simlar
to the selftests BTW). This is because there are multiple different
values, which can be exploited depending on what patches are applied.

However they require different logic to detect if pointer arithmetic
resulted in an OOB read or write. Note that even if you can do pointer
arithmetic and it results in the wrong value being accessed. It doesn't
matter if it's not OOB or if the validator blocks it because it has
calculated the offset in the wrong direction. It may still be
exploitable in these cases, but the test will pass.

I can't remember what the exact problems were; it got very complicated
so I just checked that the results of division/modulo by zero matched
upstream. This resulted in a false positive on some kernel which in
theory would be vulnerable if unprivileged pointer arithmetic were
possible. So I added the ptr arithmetic check to prevent the test from
running on kernels like this.

This also appears to prevent the test from running on your kernel which
is not vulnerable in any case. Thinking about it, this may be due to a
configuration option you have set
(i.e. sys/kernel/unprivileged_bpf_disabled). Perhaps the problem is this
is not mentioned in the test description or TCONF message?

IIRC We chose TCONF instead of TPASS to give a hint that we're not
running the full test. You could also have a vulnerable kernel, but with
unpriveleged BPF disabled by a config option. In this case the test
should not return TCONF because a user could change the option and make
themselves vulnerable.

> I guess what you wanted to check is what BPF_MAP_ARRAY_STX does. There
> is one major difference between your implementation of the check and 
> BPF_MAP_ARRAY_STX: BPF_MAP_ARRAY_STX uses an immediate value, to add
> to r2 compared to a register in your check:
>
>  * r2 = fp
>  * r2 += r2 - 4
>
> vs
>
>  * r2 = r10
>  * r3 = -1
>  * r2 += r3
>
> That is actually what makes the difference here...

No, BPF_MAP_ARRAY_STX is just used to output the result of div/mod by
zero and I don't think it needs testing.

>
> If I modify the check like this it works:
>
> --- a/testcases/kernel/syscalls/bpf/bpf_prog05.c
> +++ b/testcases/kernel/syscalls/bpf/bpf_prog05.c
> @@ -67,13 +67,11 @@ static void ensure_ptr_arithmetic(void)
>  {
>         const struct bpf_insn prog_insn[] = {
>                 /* r2 = r10
> -                * r3 = -1
> -                * r2 += r3
> +                * r2 += -1
>                  * *(char *)r2 = 0
>                  */
>                 BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
> -               BPF_MOV64_IMM(BPF_REG_3, -1),
> -               BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_3),
> +               BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -1),
>                 BPF_ST_MEM(BPF_B, BPF_REG_2, 0, 0),
>
>                 /* exit(0) */
>
>
> Is this still checking what it is supposed to? Then I would send it
> post this as a patch
>
> Joerg

This will reintroduce the false positive.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
