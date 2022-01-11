Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438C7C433EF
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 15:00:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C70E93C93FC
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 16:00:09 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 79C5F3C93F8
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 16:00:00 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A7D5C200049
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 15:59:59 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id A2752212C3;
 Tue, 11 Jan 2022 14:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1641913198;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=69c6mxl52hYFYBLXvugjvxP2Iam+Ouao2M1K5p+8KcI=;
 b=RZjMFFxJlmcWAAIqsQ2sdtuX/xyl8b7p/+abIV30BxH3zXjzlSrDwQS7BZS1JLWZaZgWOl
 BrqGtFxNPAIaNsgsi0bFBUK+BYw+eg+ry2HLYGsqOqfd3NXVwdbYzqBYSzVKAUbXPE0j31
 hvMTogvCfMmfagcm1QJJ476CmDIfeqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1641913198;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=69c6mxl52hYFYBLXvugjvxP2Iam+Ouao2M1K5p+8KcI=;
 b=1VEAA253XtvmCMomGIAd6Krxfu19dJudbCwBDPxdBwaZRnTOxRRtNtCqu40MescD5T9moU
 JWoPo7SR19i2O7Ag==
Received: from g78 (unknown [10.163.24.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 67EAAA3B81;
 Tue, 11 Jan 2022 14:59:58 +0000 (UTC)
References: <YSz36VZ18+N4YsM/@yuki>
 <20210831091005.25361-1-rpalethorpe@suse.com>
 <20210831091005.25361-4-rpalethorpe@suse.com>
 <7cf81226-52ca-5016-5041-ce12b93b534f@jv-coder.de>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Joerg Vehlow <lkml@jv-coder.de>
Date: Tue, 11 Jan 2022 14:36:29 +0000
In-reply-to: <7cf81226-52ca-5016-5041-ce12b93b534f@jv-coder.de>
Message-ID: <875yqq1fo7.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
> Am 8/31/2021 um 11:10 AM schrieb Richard Palethorpe via ltp:
>> On older kernels pointer arithmetic requires CAP_BPF. They also lack
>> the ability to call BPF subprogs. This makes it difficult to exploit
>> the div/mod behavior.
>> Older kernels leave div/mod by zero undefined. This causes the test
>> to
>> fail and backporting the new behavior is difficult. So when we find
>> that pointer arithmetic is not possible without CAP_BPF we can return
>> TCONF. Because in this case, we know the test will fail, the risk is
>> limited and there is little that can be done about it.
>
> What does older kernel mean here?

I'm refering to multiple different kernel versions (perhaps
confusingly). On much older kernels we don't have any issues because
pointer arithmetic was not possible in sensitive contexts.

Then it was made possible, but div/mod by zero was undefined. Then that
was fixed, but IIRC there were other issues. Depending on what commits
you have, any number of outcomes are possible.

>
>> +
>> +	if (ret != -1)
>> +		tst_brk(TBROK, "Invalid bpf() return value: %d", ret);
>> +
>> +	if (log[0] != 0)
>> +		tst_brk(TCONF | TERRNO, "No pointer arithmetic:\n %s", log);
> This check now fails for me with the following output, where the test
> was successful, before this patch. The kernel is a non-standard suse 
> 5.3.18 with realtime patches.
>
> bpf_prog05.c:100: TCONF: No pointer arithmetic:
>  0: (bf) r2 = r10
> 1: (b7) r3 = -1
> 2: (0f) r2 += r3
> 3: (72) *(u8 *)(r2 +0) = 0
> 4: (b7) r0 = 0
> 5: (95) exit
>
> from 2 to 3 (speculative execution): R1=ctx(id=0,off=0,imm=0) R2_w=fp0
> R3_w=invP-1 R10=fp0
> 3: (72) *(u8 *)(r2 +0) = 0
> invalid stack off=0 size=1
> processed 7 insns (limit 1000000) max_states_per_insn 0 total_states 0
> peak_states 0 mark_read 0
> : EACCES (13)
>
>
> Is this too old? But then again, the test was successful before this
> patch and your commit message states, that it was not successful on 
> "older kernels".

Are you testing on ARM? eBPF adopted the ARM behavior when dividing by
zero.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
