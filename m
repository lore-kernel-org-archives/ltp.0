Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B97D5B177
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 14:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765810374; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=pSed64pmQfhEG8hRR+/2hm7kxjFbqNtDND1LFWF/vEU=;
 b=T9sntGMA9d5y/ZBm3BYQN69OqVepWShGJ2a9vJLxxqpam/cpFcrJvbx7Dr+TkqCY5yuC3
 1yqHWUBOAlAaluK1n3lyZ5lsrTCp83FJBT7DgRoqRyLZya2UHXVxpwRFSq+EQ3yb4ny+Vx3
 pcykxGEqIYSa2QoxTKxxyshqIPxYlyw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 795B13D00D8
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 15:52:54 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7316C3C9A3E
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 15:52:30 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 213AF1400277
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 15:52:28 +0100 (CET)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4779ce2a624so39712945e9.2
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 06:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1765810348; x=1766415148; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YsIUnUAlt5TApguRIkTLUu8cNap8Pa92p+rVA3TnE9A=;
 b=SvYvflSsQdwj1Voe4gpA9e+JzZYnODqpS+S+mvL7EbE3nNlyNWkdIXUADUtyRzWPlS
 K/n9Rv6IFBQZqIEdFOrTdu35zr8IfOcT43ktBP7sqB4xm1SaWSKd2fE8NXl6oeulwCwq
 JVS7bcRz77JdIPTVo6CnAPbN1B0ne828TJRS9Ng3zU4CVa2TAqPxh92bQI/0a2g7sT8y
 PtSfawjGMvySRdJ1LastpoF+uwVaID1qE1EdB5pbGX39mX6CR08pXKrWErkfoaijL8k9
 PtWe9odr9H6Th5ss5DPPEr5Xe49FV9dmwfNbrByYgmnnevbY/5Pl+VtK8UAxdR/r+e62
 sAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765810348; x=1766415148;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YsIUnUAlt5TApguRIkTLUu8cNap8Pa92p+rVA3TnE9A=;
 b=JJJ3E0P+mpRKweVjuQ2iE3YKfpze0ZVBQltnOTW+76X0jo0Ak2bkT/tPpI+rKCGrL8
 i0cmmgf0hXgZog4m9vOR+gaw0ZXvnX3Q+xfEWM9mPIhtsh91E2BhUZbNaX1/w5AfZx4u
 6o8RSzBw55cXX+6z6/v9GjqOx7ac/nPDqUntIvZQIit36BdM88++iL9iurfJmOl2Inm2
 JQVJi01j1hJxDG+Iv3nwYQuN8Os9S9mS+0hymEeMHa94chiMjPu1wMmO1JxYs50GkIk6
 USqq6a7HVy5Y9NX2Uiwzkgq23uCWtcf6flUwf/Ne+Rnj4S0NaRMTppiTacS7Gl99k4Xi
 gU+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa4pV943vwyy2lRnAlXvvy1HrkmiODD4QcILXLmHRhJyH59uh22RZ/dA8lxhnfCU/fxmk=@lists.linux.it
X-Gm-Message-State: AOJu0YxprRoUi/sn1NtjFhfaxORD1IPnm6nJpLNUARzZY5nWn78j8+k+
 kuovAOOmsgWa7VZMCS5u2fvyIHiseEwVOQ9C0dN3PrzCRjN4UdCes4B276rpZHL0EsouPBnjnsD
 PTRpjCio=
X-Gm-Gg: AY/fxX6FpQKauDe6oUJkBcj9asEWAsUDPbkq0ksrIfE9gkV+NjAUBlWIwNAchAts/Cy
 7cuqU1JsvHz+IclC6OC9NEQb3Y/Kqi0wvzMcK6fCEBly7zuqge23HlUTop29G2RmIAj4j57EZUP
 qVadhFHGeTb/qcubDIhVpg3LOns+boKGIRy2tNrXm0jCjSlZc55J3b1peBR4g4MORkM3t0+I/Kh
 CSC2g77Aw8+aDsk0rHJl7JKfgmLBAilTTjNP1p3CN+OQ+Z2Z4fGDYheepHzvqpyl9E4PZNusZ+m
 HULxi1PEORliMopDogAwHw/LFLEufFp5qk4Si+baOFLi2EFrB7O3sUDTdmTErlIYUj4FeAjZ9F3
 Bthv+azwysOLFR18vwHrA0URrfLUgRr9FkktwQue24x1cpQKszAXWLnFoqW2sa6SUPxhC0kJWX2
 6Faw2QBy1w9Qb+QcQri6E=
X-Google-Smtp-Source: AGHT+IEZfzB6Cw+MgsCXHzAmpfSpWZUJ2pAeQ1jDzXlh/5h2upBPe/9JcyWeBvo/8T28irAIkN9mfg==
X-Received: by 2002:a05:600c:4ec6:b0:475:dd89:abc with SMTP id
 5b1f17b1804b1-47a8f8c434cmr110458665e9.11.1765810348188; 
 Mon, 15 Dec 2025 06:52:28 -0800 (PST)
Received: from localhost ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-430f1fa232csm15535184f8f.6.2025.12.15.06.52.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Dec 2025 06:52:27 -0800 (PST)
Mime-Version: 1.0
Date: Mon, 15 Dec 2025 15:52:27 +0100
Message-Id: <DEYVIYP75MAA.FWJPZR7SQDQ4@suse.com>
To: "Cyril Hrubis" <chrubis@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20251215124404.16395-1-chrubis@suse.cz>
 <20251215124404.16395-2-chrubis@suse.cz>
In-Reply-To: <20251215124404.16395-2-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] doc: Add ground rules page
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

In general I like the idea, but many sentences can be shorten. I didn't
use AI for this review, but usually they work pretty well on spotting
errors and english mistakes and it might be a good idea to review it
first with that.

Some comments below.

On Mon Dec 15, 2025 at 1:44 PM CET, Cyril Hrubis wrote:
> This is a continued effort to write down the unwritten rules we have in
> the project. Feel free to suggest more topics for the page.
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  doc/developers/ground_rules.rst | 91 +++++++++++++++++++++++++++++++++
>  doc/index.rst                   |  1 +
>  2 files changed, 92 insertions(+)
>  create mode 100644 doc/developers/ground_rules.rst
>
> Changes in v2:
>
> - added two more rules
> - fixes and typos as pointed out by Peter
>
> diff --git a/doc/developers/ground_rules.rst b/doc/developers/ground_rules.rst
> new file mode 100644
> index 000000000..2bef426aa
> --- /dev/null
> +++ b/doc/developers/ground_rules.rst
> @@ -0,0 +1,91 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Ground Rules
> +============
> +
> +Do not work around kernel bugs
> +------------------------------
> +
> +We have decided what we will not work around bugs in upstream LTP sources. If a
> +test fails on your system for a good reason, e.g. patch wasn't backported and
> +the bug is present, work around for this will not be accepted upstream. The
> +main reason for this decision is that this masks the failure for everyone else.
> +
> +
> +Do not synchronize by sleep
> +---------------------------
> +
> +Why is sleep in tests bad then?
> +```````````````````````````````
> +
> +The first problem is that it will likely introduce very rare test failures,
> +that means somebody has to spend time looking into these, which is a wasted
> +effort. Nobody likes tests that will fail rarely for no good reason. Even more
> +so you cannot run such tests with a background load to ensure that everything
> +works correctly on a busy system, because that will increase the likehood of a
> +failure.
> +
> +The second problem is that this wastes resources and slows down a test run. If
> +you think that adding a sleep to a test is not a big deal, lets have a look at
> +the bigger perspective. There is about 1600 syscall tests in Linux Test
> +Project, if 7.5% of them would sleep just for one second, we would end up with
> +two minutes of wasted time per testrun. In practice most of the test, that
> +historically misused sleep for synchronization, waited for much longer just to
> +be sure that things will works even on slower hardware. With sleeps between 2
> +and 5 seconds that puts us somewhere between 4 and 10 minutes which is between
> +13% and 33% of the syscall runtime on an outdated thinkpad, where the run
> +finishes in a bit less than half an hour. It's even worse on newer hardware,
> +because this slowdown will not change no matter how fast your machine is, which
> +is maybe the reason why this was acceptable twenty years ago but it's not now.
> +
> +
> +What to do instead?
> +```````````````````
> +
> +Use proper synchronization.
> +
> +There are different problems and different solutions. Most often test needs to
> +synchronize between child and parent proces.
> +
> +The easiest case is that parent needs to wait for a child to finish, that can
> +be fixed just be adding a :man2:`waitpid` in the parent which ensures that child is
                  ^ by                                    ^ . This ensures
> +finished before parent runs.
> +
> +Commonly child has to execute certain piece of code before parent can continue.
           ^ ,
> +For that LTP library implements checkpoints with simple

In these cases, LTP library implements..

> +:c:func:`TST_CHECKPOINT_WAIT()` and :c:func:`TST_CHECKPOINT_WAKE()` functions based
> +on futexes on a piece of shared memory set up by the test library.
> +
> +Another common case is where child must sleep in a syscall before parent can
> +continue, for which we have a :c:func:`TST_PROCESS_STATE_WAIT()` helper that
           ^ . In this case we have..

> +polls `/proc/$PID/stat`.
> +
> +Less often test needs to wait for an action that is done asynchronously, or a
> +kernel resource deallocation is deferred to a later time. In such cases the
> +best we can do is to poll. In LTP we ended up with a macro that polls by
> +calling a piece of code in a loop with exponentially increasing sleeps between
> +retries until it succeeds. Which means that instead of sleeping for a maximal
> +time event can possibly take the sleep is capped by twice of the optimal
> +sleeping time while we avoid polling too aggressively.

Less often, tests need to wait for an action that is done asynchronously
or they need to wait for a kernel resource deallocation. In such cases,
the best we can do is using polling mechanism. In LTP we have a macro
that loops over a piece of code, exponentially increasing sleeps between
retries until succeed.

 -> it would be nice to add the link to it.

----
For the entire section I would put a bullet points list.

> +
> +
> +Use runtime checks for kernel features
> +======================================
> +
> +What is and what isn't supported by kernel is determined by the version
> +and configuration of the kernel the systems is currently running on.

Supported kernel features are determined by version and configuration
of the kernel running on the system.

> +That especially means that any checks done during the compilation cannot
> +be used to assume features supported by the kernel the tests end up
> +running on. The compile time checks, done by configure script, are only
> +useful for enabling fallback kernel API definitions when missing, as we
> +do in lapi/ directory.

This means that kernel features can't be always checked at compile-time.
Please keep compile-time checks only for fallback kernel API definitions,
when needed. -> (reference to lapi?)

> +
> +
> +Kernel features and RCs
> +=======================
> +
> +LTP tests or fixes for kernel changes that were not released yet can be posted
> +to the LTP list for a review but will not be be accepted until respective
> +kernel changes are released. Review of such changes is also considered to be
> +lower priority than rest of the changes. This is because kernel changes
> +especially in the early RC phase are volatile and could be changed or reverted.

LTP tests for new kernel features inside the mainline can be sent to the
mailing list, but they will get a low priority in the review process due
to the highly volatile nature of Linux kernel before release.

> diff --git a/doc/index.rst b/doc/index.rst
> index 06b75616f..659549cc3 100644
> --- a/doc/index.rst
> +++ b/doc/index.rst
> @@ -19,6 +19,7 @@
>     :hidden:
>     :caption: For developers
>  
> +   developers/ground_rules
>     developers/setup_mailinglist
>     developers/writing_tests
>     developers/test_case_tutorial


-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
