Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0442C77B7C
	for <ltp@archiver.kernel.org>; Wed, 24 May 2023 16:10:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 74E013CEFD2
	for <ltp@archiver.kernel.org>; Wed, 24 May 2023 18:10:14 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 300173C9957
 for <ltp@lists.linux.it>; Wed, 24 May 2023 18:10:03 +0200 (CEST)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com
 [IPv6:2607:f8b0:4864:20::92d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6F92260093D
 for <ltp@lists.linux.it>; Wed, 24 May 2023 18:10:03 +0200 (CEST)
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-783ec566cb9so435073241.3
 for <ltp@lists.linux.it>; Wed, 24 May 2023 09:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684944602; x=1687536602;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hnKnJLk5XskAadqSOglm+u1gXpzLvCMAqdJh1pm0Hzs=;
 b=OPbRiUvnyyM8Ff1YHJXRdDB8TFJhGhfRTeZi/NCsnY+6aqHkO6NOIRuvkasfsCn0XF
 cEAWddOnZQSaHD+LwvRecEBoMv+UGxKgVuRdBNQz4Hc1AM83h6oVTCPTFiju4Sx8ZJ30
 OPR2p6gYx3d0naRWXWzp4hHR2wgjoxkE3yjU3kC7S+pe/XATi4Q0nn6147/LUGSN/a7o
 r0xwjtBbZW2hMEHfGQnjFlYYu8a8vdz/aedcL1ZehKgg6Vh0q/sum/W8ONyA4Wfr6I6p
 Qua3dLeV4r5qXVf/UkF4nRPA7FCdU/HMb4VFtu/VbhGo8oVPkM3/tZYECDZ/iAFgLBeq
 fJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684944602; x=1687536602;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hnKnJLk5XskAadqSOglm+u1gXpzLvCMAqdJh1pm0Hzs=;
 b=gkf753grd1F20BspLioYxfFy9cZ6poGD/pMjx6l7ADQEHR200C5/Lyu9zku+ch4jff
 jrEmQ7oBJg1VJL9ewBNwH+NkhkjS4oP2KYcX7YedLXLDF41yCz5F78ut5iys7kCTc2VE
 H/ai+XscbsChCXV68dcktxF+vsLDksTQfS8ZK7X3g8xTdrtodMUxbG7rweS3JjP55kiZ
 1Qqf3uXNDZ8fclXBmBMCGICBxFY4tCTr71qrX6EFBaD0xjwe5gCoTfoESCmwh/gzu8ma
 MYvvO904dEJLSnWEUKCMKOTHQT3Ze1vN4GsMPCjR/Oet56eeDZ4UDuw+3FQkjcQX5rME
 VLNw==
X-Gm-Message-State: AC+VfDwa+AJLYd7qw7Wh8n2NZ1i2CS1Tho287Xk3eIy/1QDSTnUrY337
 BBUqgaHuVaEcIWPZw9C/Uo3iRfyQulURb/p4h0nVkg==
X-Google-Smtp-Source: ACHHUZ4N8LNrGGH46475VJSYcLdfqfwXlbofiGMAcoVwOJwNo5Ttw8kKZWbSPwyVOTcCBQ1mZYne0U8cGZf4BfT/hXE=
X-Received: by 2002:a67:e411:0:b0:42e:5597:b60c with SMTP id
 d17-20020a67e411000000b0042e5597b60cmr5117900vsf.2.1684944601973; Wed, 24 May
 2023 09:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvVZ9WF-2zfrYeo3xnWNra0QGxLzei+b4yANZwEvr5CYw@mail.gmail.com>
 <20230524140744.GK4253@hirez.programming.kicks-ass.net>
In-Reply-To: <20230524140744.GK4253@hirez.programming.kicks-ass.net>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 24 May 2023 21:39:50 +0530
Message-ID: <CA+G9fYsP1XN31sWMtPsaXzRtiAvHsn+A2cFZS2s6+muE_Qh61Q@mail.gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] qemu-x86_64 compat: LTP: controllers: RIP:
 0010:__alloc_pages
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
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 X86 ML <x86@kernel.org>, open list <linux-kernel@vger.kernel.org>,
 linux-stable <stable@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 Ingo Molnar <mingo@redhat.com>, lkft-triage@lists.linaro.org,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Peter,

On Wed, 24 May 2023 at 19:37, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, May 24, 2023 at 02:32:20PM +0530, Naresh Kamboju wrote:
> > While running LTP controllers following kernel crash noticed on qemu-x86_64
> > compat mode with stable-rc 6.3.4-rc2.
>
> Both your reports are stable-rc 6.3.4-rc2; can I assume that stable
> 6.3.3 is good?

It was not good.
starting from 6.3.1-c1 these issues were there on
both i386 and x86_64.

I need to check back on other branches and compare it
with Linux mainline and Linux next master branches.

>
> Either way, could you please:
>
>  1) try linus/master
>  2) bisect stable-rc
>
> I don't immediately see a patch in that tree that would cause either of
> these things.

Thanks for asking these questions.
I should have included this information in my earlier email.
I have been noticing this from day one on stable-rc 6.3.1-rc1.

As per your suggestions, I will try to reproduce on other trees and
branches and get back to you.+

FYI,
These are running in AWS cloud as qemu-i386 and qemu-x86_64.

A few old links showing the history of the problem.
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build/v6.3.3-364-ga37c304c022d/testrun/17170422/suite/log-parser-test/test/check-kernel-panic-7c768ef1d898edf92187a69f777efd2977be7fb965a68b333443bd4120e64c06/history/

i386:
====
Boot failed due to the following kernel crash.

<6>[    2.078988] sched_clock: Marking stable (2023078833,
55554488)->(2088116191, -9482870)
<4>[    2.081669] int3: 0000 [#1] PREEMPT SMP
<4>[    2.082070] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.3.3-rc1 #1
<4>[    2.082174] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.14.0-2 04/01/2014
<4>[    2.082326] EIP: sched_clock_cpu+0xa/0x2b0


i386: while running LTP controllers tests
====
<4>[  888.113619] int3: 0000 [#1] PREEMPT SMP
<4>[  888.113966] CPU: 0 PID: 8805 Comm: pids.sh Not tainted 6.3.1-rc1 #1
<4>[  888.114134] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.14.0-2 04/01/2014
<4>[  888.114360] EIP: get_page_from_freelist+0xf1/0xc70

x86_64: while running LTP controllers tests
======

<4>[ 3182.753415] int3: 0000 [#1] PREEMPT SMP PTI
<4>[ 3182.755092] CPU: 0 PID: 69163 Comm: cgroup_fj_stres Not tainted
6.3.1-rc1 #1
<4>[ 3182.755228] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.14.0-2 04/01/2014
<4>[ 3182.755394] RIP: 0010:__alloc_pages+0xeb/0x340

x86_64: while running LTP tracing tests
======

<4>[   52.392251] int3: 0000 [#1] PREEMPT SMP PTI
<4>[   52.392648] CPU: 0 PID: 331 Comm: journal-offline Not tainted 6.3.3-rc1 #1
<4>[   52.392794] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.14.0-2 04/01/2014
<4>[   52.393070] RIP: 0010:syscall_trace_enter.constprop.0+0x1/0x1b0


- Naresh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
