Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7975C54FCD
	for <ltp@archiver.kernel.org>; Sat,  1 Aug 2026 10:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785578704; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=KZMWIrqMVC+dBWH5MedTQv+zSPAJc+FSdjyyY/IMDz8=;
 b=OOOnrTHHf00epGpMi86hkqJv+Esye+AiKmOUHTdLRJM6WVzmBuCmGJYcIb5Um5UeUu7Fo
 4uJgPeQvuRF8Y3vy21V8s7VegfqXHNpTwzFPs4VVrvkNZ4fRsEPfjQxc4keLRe5f4juTPmq
 fKXpuUjHspZadA0Z+rJYoXb1b5n9JHw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3AB693EA677
	for <ltp@archiver.kernel.org>; Sat,  1 Aug 2026 12:05:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D73433E2D10
 for <ltp@lists.linux.it>; Sat,  1 Aug 2026 12:04:41 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 17CFB2005E7
 for <ltp@lists.linux.it>; Sat,  1 Aug 2026 12:04:38 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4957eefd361so3691265e9.1
 for <ltp@lists.linux.it>; Sat, 01 Aug 2026 03:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785578677; x=1786183477; darn=lists.linux.it;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/UASS1GqA5zdXLQ1Xbzhoyucg53KK4HcJ2sdtEiznTU=;
 b=YaBMBecMjJNZZopvpSF0js4TMouM2P1ruvUBbJ03A+oIen0ZezBNnIakJ+MHjjB4XL
 ZKklex8aK71DdF2iKVkaB+OeYi9vSxLtJfA4sSw2GGLPuJZyh5ygfqHQfmED1io+K2Qv
 4fe3J83/CVWV3T1g6r5L+jafc4WH6ptDpVbpQgjNNk3IeJnXzTTyDkrHAg3B5MXjLBze
 QBZJKg36fg3O8K8kdm7cpbxDOY7VxgcvSSjlDqcBTdVQ8X7Cyj5+6GQpYqzY+pytKTuf
 3uXo0cf0qQDBmlnB5LWgSe1zfOrdLTrjX7poZ3x2aoXGqNDe36BOGKKqHusXd/DnzOlS
 mxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785578677; x=1786183477;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/UASS1GqA5zdXLQ1Xbzhoyucg53KK4HcJ2sdtEiznTU=;
 b=fyDdWH9kwaZbaaZ1GKHq9ECmw7IOStKSIcycCxPxO7QlZKcZjEH6inXPPgeQnLomsp
 urMP0jeykyA3gHH0fldYcgyPnRYfkxxf5ptu3xC4150mGXWIl7c5At+gVS1h8PsD5i1k
 xEQi30Rn+UMC1ZAiuEYAbOzKKVMIWOy+HZVz377k4qSbslyjhltShIBaCJe22SZwpld+
 H9Ozh2xK2WWPl7eZWBj4jaPCjXL+WUPfVrmwyLWWXlQzzEWxOcaG9RJPUVzroieFqbNN
 9G/8TrQ6K1TpXozpfU3tjsm1hgmxe20jrnrlfgOYVvZyCy91ejlWMBlw5Hpvt1vqtjf6
 3LUw==
X-Gm-Message-State: AOJu0YyNhtOItaHoSzxYEHW1FBt8bzsrOWb+Q1QcuxGwXueVo9/9ZrsH
 8gksg6L2BTCOEWlOe5/Y9uvvHnYpqu1hSqJ5U1DB7PGrawyXZPwxZJ/FY3PtRty6rw==
X-Gm-Gg: AR+sD12LWQuNsFMMU+pnRMpSEeFGXMWaizx96k9fTjNjTlui0ir1z/11iqxcmsOXGjf
 V5OuSSVVD25nZA9uR71PZ45U9AGQ1oJ6U5r4GeZbCNqTKmvlhhp4nLNi9ECtFGnEmyAvk4wriOW
 suJ/nhjcA5nU4ddGUD5sSVermD9klwefwVweOtPiCnBarxAWR8+i1qRf27JYAv66x7b92s9Cdln
 Kg5nHiM/FNOB2YgcSiLoYEDP08X6IpTemiMNLejeYjfC+ofubSncE8zS0DmhnikBkZqoK+NSefz
 g8yzhbSJiIjOP+RJbWQZJ9typXZSPJGPwRLj7wCpIDnkCaH0FTgbbqLMwGoxYXnLMyWHR3m44ie
 nFbz3dr7M3VjSWwLbx4i9DwUTeuPy7QOyut8AOC5O5e1hfr/H8SYVOQSHXgAmwf94vplvhUCxYQ
 2kVqD5Q4/IHYI7kBAEx+xLbA0KffCFYaJa2OupCGGjgxGHlN4OBplxDyI8FEvhBYG3Sji7AoFNF
 hOZmg==
X-Received: by 2002:a05:600c:3488:b0:493:e6f7:ad75 with SMTP id
 5b1f17b1804b1-4980c653e15mr35564455e9.11.1785578677347; 
 Sat, 01 Aug 2026 03:04:37 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807b5f0c3sm40080505e9.5.2026.08.01.03.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 03:04:36 -0700 (PDT)
Date: Sat, 1 Aug 2026 10:04:35 +0000
To: linuxtestproject.agent@gmail.com
Message-ID: <am3Es6Qp9ixeXTll@autotest-wegao.qe.prg2.suse.org>
References: <20260729053803.9823-1-wegao@suse.com>
 <20260729055233.8636-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260729055233.8636-1-linuxtestproject.agent@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] min_free_kbytes: Handle transient memory drops in
 check_monitor
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Jul 29, 2026 at 05:52:33AM +0000, linuxtestproject.agent@gmail.com wrote:
> Hi Wei,
> 
> On Wed, 29 Jul 2026, Wei Gao wrote:
> > min_free_kbytes: Handle transient memory drops in check_monitor
> 
> > Implement a 2-second grace period with high-accuracy 10ms fixed polling
> > in check_monitor() to allow the kernel time to reclaim memory.
> >
> > Introduce a 10% tolerance (90% threshold) for the MemFree check.
> 
> These are two independent changes, and the second one is much more
> invasive than the first. Could they be split into separate patches?
> 
> The idle poll interval change and the diagnostics are two more logical
> changes in the same commit. Splitting them would let the tolerance be
> discussed (or reverted) on its own.
> 
> > +		threshold = tune * 9 / 10;
> 
> > +			if (memfree < threshold) {
> > +				tst_res(TFAIL, "MemFree %lu kB < 90%% of min_free_kbytes %lu kB (MinSeen: %lu%%) after 2s",
> > +					memfree, tune, (min_memfree * 100 / tune));
> > +				violated = 1;
> > +			} else if (memfree < tune) {
> > +				tst_res(TINFO, "MemFree (%lu kB) stayed within 10%% tolerance (min %lu%%) after ~2s",
> > +					memfree, (min_memfree * 100 / tune));
> 
> With this, a kernel that steadily keeps MemFree at, say, 0.95 *
> min_free_kbytes forever never fails: the loop runs its full 2s, the
> value is above threshold, only TINFO is printed and the test ends with
> TPASS.
> 
> Isn't that the exact regression this test exists to catch? The kernel
> contract is MemFree >= min_free_kbytes, and the tolerance turns a
> permanent violation into an informational message.
> 
AI is now questioning my 90% threshold implementation. To be fair, adding a 
90% threshold under overcommit_memory = 2 might be overkill. But under modes 0 and 1, 
where OOM is to be triggered, I'm not entirely confident that the test can reliably 
capture MemFree > min_free_kbytes before the process gets killed.

What do you guys think? I'd love to hear your feedback on this.

> The 2s grace period already covers the transient case described in the
> commit message. What does the tolerance add on top of it that the grace
> period does not?
> 
> If the concern is the slow recovery tail, would extending the grace
> period (or retrying with a longer budget) be preferable to lowering the
> watermark the test enforces?
> 
> > -		sleep(2);
> > +		usleep(100000);
> 
> The commit message says this improves "responsiveness". What does the
> monitor gain from it?
No idea why AI think this can not improves responsiveness :(
> 
> Sampling 10x more often finds more transient dips, which is what the
> grace period and the tolerance in this same patch are trying to
> suppress. The two changes seem to pull in opposite directions.
> 
> It also makes the child read /proc/meminfo and the min_free_kbytes
> sysctl 20 times per second while the parent is deliberately driving the
> machine into memory pressure, so the monitor adds load to what it is
> measuring.
Make sense, but in my local test it show ok.
> 
> > +			for (i = 10; i <= 2000; i += 10) {
> > +				usleep(10000);
> > +				memfree = SAFE_READ_MEMINFO("MemFree:");
> 
> The loop does not look at "end". min_free_kbytes_test() sends SIGUSR1
> right after test_tune() returns, so if the signal lands while this loop
> is running the child keeps sampling for up to 2s more and can report
> TFAIL for a sample taken after the workload has already finished.
> 
> Would adding "end" to the loop condition avoid reporting on the
> post-test tail?
I have replied in patchv4.
> 
> Also, c-tests rule 4 asks for exponential-backoff polling rather than a
> fixed usleep() interval, and TST_RETRY_FN_EXP_BACKOFF() in
> include/tst_common.h implements it. Fixed 10ms is what makes the
> "recovered after %d ms" number meaningful, so this may be a deliberate
> trade-off worth stating in a comment.
I have replied in patchv4.
> 
> > +					memfree, tune, (min_memfree * 100 / tune));
> 
> min_memfree * 100 overflows a 32-bit unsigned long above roughly 41 GB
> of free memory. The test still carries a TST_ABI32 branch, so 32-bit is
> in scope. 100 * (min_memfree / tune) or a 64-bit intermediate would
> avoid it.
can be improved
> 
> >  * Since the tune is not too large or too little, which will
> >  * lead to the system hang, the following cases are tested
> >  * on all ``overcommit_memory`` policy, at the same time, compare
> >  * the current free memory with the tunable value repeatedly.
> 
> The high-level description still says the free memory is compared with
> the tunable value. After this patch that is no longer what happens.
> Could this block be updated to mention the grace period and, if it
> stays, the tolerance?
> 
> Verdict - Needs revision
> 
> Pre-existing issues, not introduced by this patch:
> 
> - "volatile int end;" is a non-static global; it could be static.
> - eatup_mem() mmaps until failure and never munmaps. The child exits
>   immediately after, so this is not a real leak.
> - checkpatch reports pre-existing warnings on lines 36, 104 and 126.
> 
> ---
> Note:
> 
> The agent can sometimes produce false positives although often its
> findings are genuine. If you find issues with the review, please
> comment this email or ignore the suggestions.
> 
> Regards,
> LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
