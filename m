Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5E7F433DD
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 03:24:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD0063E5DF8
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 05:24:06 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B0343C9917
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 05:23:47 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 69BB3600856
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 05:23:47 +0200 (CEST)
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-8acae26e564so48899306d6.2
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 20:23:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776309826; cv=none;
 d=google.com; s=arc-20240605;
 b=BnkgLjYdeWfInRw2jj4jrp2RgNrFfnJDoGNGOjo4GMeDRrSgf5QcgdfHzJATlGSvK5
 JMuAVPJazgngSwKJbzGqZ0neyvwxMxpHuURUJFg4wtxwBwy73e2cXGxWdXyPcqclaYuW
 BE7CCAC2dR2Wxo2lyKcph8II2/OEcqIed37rIEOma5LVPiuT2Fl40rGmXVbm/fM9iDvR
 s+DXEVUY5/iwD0/d63ecN6EPHJ3SqMcROeROYQvtezFchU9Ri6X/u2mJVZx+0lVykx+j
 nbPASuBYr4C2PbK48gkxrJztXYPK1NMShIZbBkx1wwFQ5CCiFvMeQFfIFSZKe/OyjQNp
 vcSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=A4rthckyVd/14S41RuSoOr2gtvTbB1cvvhKPzRFidPo=;
 fh=D6MNrfoLb+fmFM8qJq1MC0gBbNmJfgEDhu6yddyYbAY=;
 b=T5stwM4EAOssbuMuZLkDqXJpt71YGPteT7obWg0LTl/LFeZcteUkGy9uwqgxyFVvac
 1FFfPkWTbaoLnRzxHBWbjlRfxU73dK9Aq0bXe+n4FbzAwEQBEE4RkjeKT4ahzP6tyI1/
 2HCSpmOF4SDPXttYbTBzloW0CMVEvJZbiVYk8nvTvj+74+MFX5W8JRvq6nX2CYXRST1i
 UPPQPqlZw5O/F0WUgnTajF4EXmwDw0dWzJTQdfrw0aXQniTnazaB09d04u41aTcz31uP
 sCZlqfoFZ6h4MWrKt7pinjPhUBFLH8gduoTucxVwA/cVUic4wqB1mzFeuPKWbTKfAAV5
 5jVA==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776309826; x=1776914626; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A4rthckyVd/14S41RuSoOr2gtvTbB1cvvhKPzRFidPo=;
 b=UI1u4xv1b+Mgkl7nxujcSWNGZz9oKOKujwWZ8l68Id2YhY3GJAS5LTL1/iee79gX84
 g4GnbcV7Udz940o6ZU1QQivf1ekyGiVYQXaSsK8tptb+DgAEkXuvZb/ryEUk22Jq+t07
 FfFDUYOXkwb+y3MFyjTzNaNJXFM9xyLTCMWMa8LZ4TJh0PDS2sPyAgRjQ6v0P3W2hWry
 WCfEBYtsEBYP3KMefBKCkG2+qrUSEDahk+5cQQ35vLcVdJ8OqVipu1F4XvWurfsOexS0
 q3a9EI13v0STvQ1p8NvYCgEpuw+WqkLw/bTqhn8XQvOEopBWxBlOEol2hyaG+ZuNjPxt
 hfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776309826; x=1776914626;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A4rthckyVd/14S41RuSoOr2gtvTbB1cvvhKPzRFidPo=;
 b=o5YjaT3Q08k1bOwCNRiWTvGmuZl47nYDLh/fjum7rW3sMW9oA5df8jgIyZQi4uMqxE
 b40whZXY2nPYqB5iM/SdV0ERT6q9vXmP3hJ/8molMg35f0VIOyIIzZmqgiTO/GE8Ch/Z
 IXpbG0Vdz4a5I/v3FIfGPddQ0YAs7C60rV0jqgZDJedtgqgG/VILSvaPxhSOFu61MoMR
 o50E0tvCVCuyD/43KbAJdAyZqgeBB7O5+zkrPb0G9w2zrzIVLIQPrQxdDLxoZteK6fCg
 zN/M27j0bVCd4da7tiDG7VpKzMGH5DLVtanFTq7AuhNdGAGMuJEHSjPkkUlYT+jh3oXk
 Yucg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/DZjb9uM1ZMKW6wF5ayQYlc5MoCaWLky4ZzNzfdbfoEybC4YX301+aN9YEj/neN8sp/cY=@lists.linux.it
X-Gm-Message-State: AOJu0YxL+wkYhAtTr62IhKeijUwV0xQbddVtSREk0mRjJKD8AeYm6D5X
 O8f9WKBwRlNfhUX/tH/Vrh1dCliwR1W1N1oUc84e6Gfy+w86AZesrmTE7botOA6/4YZFvUDUcrp
 cL4t2TC0NDmtZX5Sliv4SjPxxMFtuig==
X-Gm-Gg: AeBDievHh1Ar5AC06j3fB0bNXoJT7f2ALPbg48pDu4K/V/2RslmeJ6iqobGM782zp1l
 /9zZvKjpUq8NoB5cu7OxZLq8zdavV3AHCyBYQFn2UFV5O1cGZvys7/h98eXg0bMscKqKaG7E9cs
 v5dae+sflDkEwgNBPjSUldamSFUbcChZRKtXBIz2FOzIyGGd3kjf3Karc77TRGB0ZhmXorHpDWf
 84leLsZpKROj9bvO++PmqqzvI+Eke+78V1rAsGpg1XKw/q+Xgp/YLEf+uqDf0ACn85wR6t0nbHt
 MdBdOX+RvR9x/ZU3hI6qrYbV/Sw=
X-Received: by 2002:a0c:e016:0:b0:89e:e841:1f25 with SMTP id
 6a1803df08f44-8ac860ba93fmr364391416d6.11.1776309826147; Wed, 15 Apr 2026
 20:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <53f26493-09fc-4f8b-9751-24d2c2e80697@linux.ibm.com>
 <ad5jSSYZJS0FdZva@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <CANgNiRyTovPjVq01n7sCNhbNdYNp6nSvWcpVV_8aC3+kBX0edg@mail.gmail.com>
 <ad-sqJXCYZpBAKM0@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <CANDhNCoAc4ktPUzqgam_oO7aAc4yp3nCqkcwQDvWs0zV15ZCaw@mail.gmail.com>
In-Reply-To: <CANDhNCoAc4ktPUzqgam_oO7aAc4yp3nCqkcwQDvWs0zV15ZCaw@mail.gmail.com>
From: Li Wang <wangli.ahau@gmail.com>
Date: Thu, 16 Apr 2026 11:23:35 +0800
X-Gm-Features: AQROBzBE4YR9Jl_uz2eeZfsK2vgKERZevAyQCzXHh7V4PvrdYtRbKD6Pr6hid0s
Message-ID: <CANgNiRz7c7mJ3E2QQwHCHb4=DCk-S6vXe3Xkge05xfYe2LYTEQ@mail.gmail.com>
To: John Stultz <jstultz@google.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sched_football: fix false failures on many-CPU
 systems
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
Cc: Soma Das <somadas1@linux.ibm.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi John,

John Stultz <jstultz@google.com> wrote:

> > > > > 1. RT throttling freezes all SCHED_FIFO threads simultaneously. On
> > > > > release, the kernel does not always reschedule the highest-priority
> > > > > thread first on every CPU, so offense briefly runs and increments
> > > > > the_ball before defense is rescheduled. Fix by saving and disabling
> > > > > sched_rt_runtime_us in setup and restoring it in a new cleanup
> > > > > callback.
> > >
> > > Make sense, and like the AI-reviewer points out LTP provides an option
> > > to save_restore it automatically.
>
> Throttling shouldn't break the test. The fact that SCHED_NORMAL tasks
> ran shouldn't change the ordering when we go back to running RT tasks.
> This is likely a kernel bug.

Theoretically speaking, your point is correct. While instant global
priority ordering upon unthrottling is ideal, it ignores the physical realities
of SMP architecture.

If we look at do_sched_rt_period_timer(), CPUs are unthrottled sequentially
via a for_each_cpu loop. When an early CPU in the loop is unlocked, it
immediately schedules its local RT task 'offense'.
See:
  https://elixir.bootlin.com/linux/v7.0/source/kernel/sched/rt.c#L797

Meanwhile, subsequent CPUs in the loop (which may hold the higher-priority
'defense' task) are literally still throttled.

Expecting atomic, zero-latency global unthrottling is physically unrealistic for
multi-core systems.

That's why I tend to believe disabling throttling for this specific test is the
wise and practical approach.


> > > > > 2. Offense and defense threads were unpinned, allowing the scheduler
> > > > > to migrate them freely. An offense thread could land on a CPU with
> > > > > no defense thread present and run unchecked. Fix by passing a CPU
> > > > > index as the thread arg and calling sched_setaffinity() at thread
> > > > > start. Pairs are distributed round-robin (i % ncpus) so each
> > > > > offense thread shares its CPU with a defense thread.
> > >
> > > This is a good thought, as for SCHED_FIFO it manages the corresponding
> > > runqueue for each CPU and simply picks the higher priority task to run.
> > > So pinning the threads to each CPU makes sense, but maybe we could
> > > only pin the defense because:
> > >
> > > With N defense threads pinned one per CPU, every CPU has a defense
> > > thread at priority 30 permanently runnable. The offense threads at priority
> > > 15, regardless of which CPU the scheduler places them on, will always find
> > > a higher-priority defense thread on the same CPU's runqueue. Since
> > > SCHED_FIFO strictly favors the higher-priority runnable task, offense can
> > > never be picked.
> > >
> > > Pinning offense as well would be redundant, it doesn't matter where offense
> > > lands, because defense already covers every CPU. This also has the advantage
> > > of letting the scheduler freely migrate offense threads without
> > > affecting the test
> > > outcome, which avoids interfering with the kernel's load balancing logic during
> > > the test.
> > >
> > > And, I'd suggest using tst_ncpus_available() instead of get_numcpus()
> > > when distributing defense threads across CPUs, in case some CPUs are
> > > offline. Pinning a defense thread to an offline CPU would leave that
> > > CPU uncovered and allow offense to run unchecked. See:
>
> I didn't see the orignal patch here, but the whole point of
> sched_football is to ensure the top <num cpu> (unaffined) priority
> tasks are always run and no lower priority rt tasks are run instead.
>
> So none of the tasks should be pinned to any cpus. The scheduler is
> supposed to ensure the RT invariant holds.
> There are some known bugs at the moment that will cause sched_football
> to fail (the RT_PUSH_IPI feature, for instance). That's a problem with
> the kernel, not the test.

Apart from the known bug of RT_PUSH_IPI feature, it still does not
guarantee 100% success in real scenarios.

After a deep look into the rt scheduler principals, I found that, because
the RT_PUSH_IPI mechanism is designed as a "best-effort"
optimization rather than a guaranteed operation. As the kernel's
scheduling state is highly dynamic and asynchronous, a push attempt
will deliberately abort if the environment changes between the time the
IPI is sent and when it is actually processed.

It fails by design to prevent instability, primarily due to state expiration,
CPU affinity restrictions, sudden priority inversions, or the lack of an
eligible target CPU.

See push_rt_task() in kernel/sched/rt.c:
  https://elixir.bootlin.com/linux/v7.0/source/kernel/sched/rt.c#L1939

Hence, if we explicitly pin the defense thread to each CPU, it will join in
the corresponding runqueues, which completely match the reasonable
situation: the kernel's RT scheduler guarantees per-CPU priority ordering,
not global placement. The RT load balancer is asynchronous and doesn't
guarantee that all high-priority threads are placed before any low-priority
thread runs.

On the other side, if the test expects a global guarantee, it's testing
something the kernel doesn't claim to provide.

To the rest changes, the current test has several non-kernel issues
(RT throttling interference, uninitialized game_over on reruns, silent
sched_setscheduler failures) that produce false failures. These mask
the real kernel bugs you want to detect.


--
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
