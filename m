Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA96ECAAA1
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 14:35:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 30A253CA19D
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 16:35:01 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 476A03C8F91
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 16:34:51 +0200 (CEST)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com
 [IPv6:2607:f8b0:4864:20::e2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CBE1914000A2
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 16:34:50 +0200 (CEST)
Received: by mail-vs1-xe2c.google.com with SMTP id 189so6800656vsi.9
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 07:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6mRg25YlgqcYsO/aOIdHsGAzNMrfeb4UDNXddHfl1V4=;
 b=nrGCfspLQWOt55htWB3mNyuXVcnhT8f1hy6ygC9thjAAN1rPFD6IjM3G5MlLUWh4Wb
 3P0V7ca6HM7+emEv6OAb6v2BSS2d/59GULgS7V/sOTwNPKK54/U4qj1cB/ncZLJVlVWT
 VzNMMDX3X0x+2j6cXQF0GEXWqyRPiwVFKJKbo2j8mbrUi11ntmA2TNc+UjMU4ehs5Cnh
 NLbE6ReLUkr/r/rnaw0bySQvvok7sb6BBsLfkVJrOYT1HgJmJpDbUNc7bks5bpRSFuCx
 1vLC6PITGd84KCnHyZWxPZeOQwLxmKSavccD+YhfJ/hyK31beCTNbOHcQjHn8SegC9B5
 hmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6mRg25YlgqcYsO/aOIdHsGAzNMrfeb4UDNXddHfl1V4=;
 b=AydnjWe5iM8m29KmrTLtATRNusOcp4x66TRwvrww0tL88vvsFfj3ZWkPuk12juWYx/
 RHGXxSAWuAIrWYmyQLb5AftV3Rm8BR6jV/H0BjC0e4LdRnRX8dsH8slTLrq/Z4yx52oD
 xvGB04ikJWESa7XB9tH1FrevHJMZU7oMP0YeEhZVdbjVjL/2nm7cUg3o15SvakHGoaJy
 wbbP1RTyAU170T5VSdIMDlpCR0PsPe2xZr3BFub0462jH+CpYNeLEjJkQsODdwAjoY3a
 FMuM6biWPf1UrWfV2F6HYhItALOQCYs55BYleclROfAgp26oOhU6k58RvqCO3/SPrGmz
 qNGA==
X-Gm-Message-State: ACrzQf2dP+O0EGw4OEyf9w+vzOf8PZhq4Xt30MQdhgeyRvjhD0Lbt6dB
 iXZGK/jWOIwXHsxa3zVRoLyNXE3HswmMzIhuKNnz3DT1azI=
X-Google-Smtp-Source: AMsMyM58I+siwHwElCv4HFxnbIe0nzmstTQRJpawRFX0TpaXkqiSXKMWqO+RlzjdE7rIn7h4UP1y6QjBN9TdYre4uP4=
X-Received: by 2002:a67:c099:0:b0:39b:342:3c0d with SMTP id
 x25-20020a67c099000000b0039b03423c0dmr19536373vsi.3.1666622089455; Mon, 24
 Oct 2022 07:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <20221020130843.15147-1-mdoucha@suse.cz>
 <20221020130843.15147-3-mdoucha@suse.cz>
 <CAOQ4uxi=3aS+ROZ_kcQbVK9C4qiW76M1junEz2J+fdai5xjnAQ@mail.gmail.com>
 <b3443f46-37fc-3c15-76d6-0985e6da0535@suse.cz>
 <CAOQ4uxianp4e7gykk_N-yPKPPsK4xYu2HnH5d=N93+gAM60c=Q@mail.gmail.com>
 <9b1164dd-68fa-0335-0b38-f820e3d303be@suse.cz>
 <CAOQ4uxizXrthqR7G8Tx7kq+bz6kPTUxTSYs1BfireEXRpiNw4w@mail.gmail.com>
 <ea4fd7d6-0985-2983-d0ce-489a32a2f6dc@suse.cz>
In-Reply-To: <ea4fd7d6-0985-2983-d0ce-489a32a2f6dc@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 24 Oct 2022 17:34:37 +0300
Message-ID: <CAOQ4uxib_vxncQa3RiObKYwQg0CQvPXLH+nyRckO9FVg=ihERQ@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] Add fanotify_get_supported_init_flags()
 helper function
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
Cc: Jan Kara <jack@suse.cz>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Oct 24, 2022 at 4:16 PM Martin Doucha <mdoucha@suse.cz> wrote:
>
> On 24. 10. 22 15:08, Amir Goldstein wrote:
> > Why is skipping the test better than passing the test?
> >
> > The test wants to know that a specific flag combination is not allowed.
> >
> > It is particarly not allowed also on old kernels that do not support
> > either individual flag.
> >
> > What's the difference?
> >
> > Who is going to gain anything from this change?
> >
> > Sorry for being strict on this point
> > I may be missing something.
> >
> > Please clarify what it is the problem use case is and I will suggest a
> > solution, because I disagree with this solution.
>
> We're running fanotify14 on kernel 5.3 and one of the subtests (test
> case #8) is using a flag that was added in kernel 5.9. But in this case,
> fanotify_init() is supposed to pass and then fanotify_mark() is supposed
> to fail because of mismatch between mark() and init() flags. I'm trying
> to fix this particular subtest failure caused by wrong feature check.
>

Got it. If you wrote this information somewhere else
I must have missed it - if you did not, please write explicitly
which test case is being fixed on which kernel version/config.

This is how I would fix the problem:

        if (!tc->mask) {
                /* tc->expected_errno refers to the expected result of
fanotify_init() */
                TST_EXP_FD_OR_FAIL(fanotify_fd =
fanotify_init(tc->init_flags, O_RDONLY),
                                   tc->expected_errno);
        } else {
                /* tc->expected_errno refers to the expected result of
fanotify_mark() */
                fanotify_fd = fanotify_init(tc->init_flags, O_RDONLY);
                if (fanotify_fd < 0) {
                        if (errno == EINVAL)
                                tst_res(TCONF, "fanotify_init flags
XXX not supported");
                        else
                                tst_res(TFAIL, "fanotify_init failed");
                }
        }

Give or take using more macros and your nicer flag prints.
There is no need for auto-detection of the unsupported kernel flags.

If the test case is expected to get to fanotify_mark() (i.e. non-zero tc->mask)
EINVAL from fanotify_init() always means "unsupported".

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
