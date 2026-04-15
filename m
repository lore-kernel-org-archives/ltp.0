Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 853FBF41989
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 09:52:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 21E043E59CA
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 11:52:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DDCC93E2660
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 11:52:25 +0200 (CEST)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3C8F01A007ED
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 11:52:25 +0200 (CEST)
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-50b2b289925so54164341cf.2
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 02:52:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776246744; cv=none;
 d=google.com; s=arc-20240605;
 b=P/xoTxA8GQE24hNkiL/C1J7h04ptsfSqLj25yxAHRFE/6wTKtaC8IDJ+F1SvsCXrsU
 DB8Kd1EFlCL0RfZZRwvGXP2TLYAR+hwKSZkUj8st3bAPySbP32Ng/SykA//2nB2VenQQ
 n6ITWfEVIlcw3WggH6mAV9/hPg9fTc6SgcQV3YDcRHJGk8nc/at76ac+Joe9M5D/b/qN
 YjyJDTDEK3EF348lk5cnV5LdAIqRSAOOm1qtsGGBh1UXY7Wfw8rioW1sMoEv3oIceqoQ
 rVXviR8ovS7wPmvJ9tTsiWH5YW3PzT+X+z+2AmzcYcLg542YkNnucpfqsc9iB/2fioy4
 U2Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4dWWC9FqxS+TqVlI0Oe27UQtL/Cucw8jGow8hZc1jjk=;
 fh=iiQDWzqcvLqJlWA25u3IRlJ3QztPU47SwJAHJLx1g20=;
 b=lIXU/FJKdyG4KFm8wEyGGA+CY+YT0UhP6GNXwhkhplmr1R5hxWUGBn0TlZX7gv5Gkf
 1rWS7ybozLQMDT8teYBNTKOSWtEnepOFipsHEg9BbKDeY3h+yL53T2ClHHMVC2+fzJzI
 Y+ev3Cd0rr8G5JtncsadAKCEDYbRbaubM9YCEHHSKNF9RfGXZ/1ftCsuZd6oJIGl8LRi
 RgHEcMFMQieRXu+OqnyogLSUIv37bz+UECmPVE9Vf8srHfkp05AP6S1uol4KPziEbPdE
 eOR7BtLQ6U/G2Pv1v3kcLcW3+C6ScuTyhXvouDw3b/9fcWxkHvHFf65MI6WV1/k9QNq7
 iBHA==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776246744; x=1776851544; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4dWWC9FqxS+TqVlI0Oe27UQtL/Cucw8jGow8hZc1jjk=;
 b=svTXSJfD6dxOcgeupQOjae7Lb4TilqNmlJEtMmdT2tlip1moj4rJmDxtvPndWYcSWa
 1D1pYzxPOeFIdE3XvnPQNNqSVS0sOhMq5Lhv2P4yiKc9En2Hbv9KKNonaq7mnO1yZRi4
 UMs3FViBloNHtQ3JzZiZxMCg5mvL1yo2S5AfkZtP85BOEPfxTqCqSyPpB5916x8DzJWv
 v+dIycV6ErzaN0zsDRTfUPPyYNyJhw8NMKLjN97znktwFDXsv1DUn71x9ZPrssFxqJtb
 gH1/MJ4eOchMKTI+OBUx80uDGvE0iHxd6kHJLMY4jibqNeogJHRaboodM23THlI+Rtn4
 mjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776246744; x=1776851544;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4dWWC9FqxS+TqVlI0Oe27UQtL/Cucw8jGow8hZc1jjk=;
 b=UmCooSdCFkf/8NtFgZVM0e70okHhRLu6WU+NePhse8LCjY0Ml1XzclhUPf5wh65qzf
 O/IC82tvQniMvYNIp7nnSPEZ2WXyqxfPH6aWwbsgSj+B3M96yy3mbJfElksPT2mBy7Cs
 BmT+ArIV6p2Rk/PwTE3i5YiG/YqUQtZTOsiT3zmIxKpv3fXeRElK5NYhXE/vTL+c2CsV
 y3UuqjmerfwQQUZPEUV8D9UEss2ivARpLl78TKKlG0WDNgDHGezQLqY0U1k88sCk6Ncx
 f4jEF6ohFosrti6yPtgW1CRDduC1dqCMXQkf/TJZ9Wzpzivhjn2wfcoaQz1RYCuqTNZ7
 g/2w==
X-Gm-Message-State: AOJu0YyRMO48tsSNia1cpOPPH/asNQb0pKj2Zu+oNbbuHIwdixRpr+ap
 mcdaE1T3rlaCMQnIBN6xkWLBGlyPdIjjZ1gQ7Sn8/UeEIjwsYjEUePmS4uV47NqoDhs0RcBykif
 Q7mEdoR2XciMy3YbSC1KDSHN2m67ToQ==
X-Gm-Gg: AeBDies7AAQq3TzL4I4C8/WZqqh+Pr3P5QtZeUxvC86AOsKc+qYJwyc9Mcq+bZPpyad
 5AqpKPWceJy+br1jBLeRQZecrYg4Ztah1i5zJLUl3KCNYf8d8zyokFar/jb7P0J5j6XNvToUXeG
 h463hV4iMN9hzWRv3pIdpuI8WcRQXNDcpVohQ4Ek0ALjKpbZT8FnhbjdhhnbR8a6FOadfM3e3pJ
 4eOsVGTYO56zrtTuCBrbmT8ojRrobKgUkC8FPaBKHU/s30e3bmBQ1kUGk6xI6/bdjmhHDBpCeLC
 AJV0JP+ap9ORHvhRQ6JG5RRRN9A=
X-Received: by 2002:a05:622a:550d:b0:50b:3788:ab58 with SMTP id
 d75a77b69052e-50dd5acb1e9mr312275481cf.17.1776246743874; Wed, 15 Apr 2026
 02:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <53f26493-09fc-4f8b-9751-24d2c2e80697@linux.ibm.com>
 <ad5jSSYZJS0FdZva@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
In-Reply-To: <ad5jSSYZJS0FdZva@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
From: Li Wang <wangli.ahau@gmail.com>
Date: Wed, 15 Apr 2026 17:52:11 +0800
X-Gm-Features: AQROBzBUc-qadwFkgR-JCscazqHWDGakCZzA4gS-a2_MLgKbcLjKPBZI2HPeioo
Message-ID: <CANgNiRyTovPjVq01n7sCNhbNdYNp6nSvWcpVV_8aC3+kBX0edg@mail.gmail.com>
To: Jan Polensky <japo@linux.ibm.com>, Soma Das <somadas1@linux.ibm.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
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
Cc: jstultz@google.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Soma and Jan,

> > 1. RT throttling freezes all SCHED_FIFO threads simultaneously. On
> > release, the kernel does not always reschedule the highest-priority
> > thread first on every CPU, so offense briefly runs and increments
> > the_ball before defense is rescheduled. Fix by saving and disabling
> > sched_rt_runtime_us in setup and restoring it in a new cleanup
> > callback.

Make sense, and like the AI-reviewer points out LTP provides an option
to save_restore it automatically.

> > 2. Offense and defense threads were unpinned, allowing the scheduler
> > to migrate them freely. An offense thread could land on a CPU with
> > no defense thread present and run unchecked. Fix by passing a CPU
> > index as the thread arg and calling sched_setaffinity() at thread
> > start. Pairs are distributed round-robin (i % ncpus) so each
> > offense thread shares its CPU with a defense thread.

This is a good thought, as for SCHED_FIFO it manages the corresponding
runqueue for each CPU and simply picks the higher priority task to run.
So pinning the threads to each CPU makes sense, but maybe we could
only pin the defense because:

With N defense threads pinned one per CPU, every CPU has a defense
thread at priority 30 permanently runnable. The offense threads at priority
15, regardless of which CPU the scheduler places them on, will always find
a higher-priority defense thread on the same CPU's runqueue. Since
SCHED_FIFO strictly favors the higher-priority runnable task, offense can
never be picked.

Pinning offense as well would be redundant, it doesn't matter where offense
lands, because defense already covers every CPU. This also has the advantage
of letting the scheduler freely migrate offense threads without
affecting the test
outcome, which avoids interfering with the kernel's load balancing logic during
the test.

And, I'd suggest using tst_ncpus_available() instead of get_numcpus()
when distributing defense threads across CPUs, in case some CPUs are
offline. Pinning a defense thread to an offline CPU would leave that
CPU uncovered and allow offense to run unchecked. See:

Also, the short usleep() after setting kickoff_flag, which was originally
there to give the RT load balancer time to distribute threads across CPUs,
can now be removed, since defense is already pinned to every CPU and
coverage is guaranteed without any extra settling time.

-       if (tst_check_preempt_rt())
-               usleep(20000);
-       else
-               usleep(2000000);


> > 3. game_over was never reset between iterations, causing all threads
> > to exit immediately on reruns (-i N), making the test a no-op.
> > Fix by resetting both kickoff_flag and game_over at the top of
> > do_test().

Good catch.

> > 4. sched_setscheduler() failure for the referee was silently ignored.
> > If the call fails the test produces meaningless results. Fix by
> > checking the return value and calling tst_brk(TBROK) on failure.

+1

> Tested-by: Jan Polensky <japo@linux.ibm.com>

Thanks, can you re-test it based on what my above revision suggests?

--
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
