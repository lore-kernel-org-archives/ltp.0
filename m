Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA01C6FA86
	for <ltp@archiver.kernel.org>; Tue,  6 Sep 2022 17:28:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8EE7E3CA6F6
	for <ltp@archiver.kernel.org>; Tue,  6 Sep 2022 19:28:47 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C0C843C1B7E
 for <ltp@lists.linux.it>; Tue,  6 Sep 2022 19:28:37 +0200 (CEST)
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com
 [IPv6:2607:f8b0:4864:20::a30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D9BF3100096B
 for <ltp@lists.linux.it>; Tue,  6 Sep 2022 19:28:36 +0200 (CEST)
Received: by mail-vk1-xa30.google.com with SMTP id 134so5850330vkz.11
 for <ltp@lists.linux.it>; Tue, 06 Sep 2022 10:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=eSjVG6+Fseh4Kx+pXvDS7K+ZYlGAuAfnKGLh0p+8asI=;
 b=CRVr5G8zknisIJDAEgLTSQS10/VNvTucFB4YCOOPoPuaA9M1UmCHprUa1jbCFsD0Va
 AwJhTyFB5yyOuZaynrLX+In0OCFKZQPPniGJiqcwG1erF2HWxG1mqAXvQBSMOSZOmHRP
 SkIIGw2sTaR7fnijkSNWIbcnzOFnLIIF7F5iDfZuU2NDdJ+94gx3vflgrWzHTv5Sl5LI
 NHXKLlbsNcf0XfglJkiPUlsPEVwFRQvl2LfZNcSJNhTz0bFyGMr4ucDQ24pFOv/pAz08
 pWuEErPYqD+dZXu/v5MWFrzF634q0ToBKGvKC9Mx9LR8SFc6XtHSS1BpEEc3ZC3MH2QH
 EXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=eSjVG6+Fseh4Kx+pXvDS7K+ZYlGAuAfnKGLh0p+8asI=;
 b=stouDQ49OldrI+oaiOwKvCLq/kXhQP/rqknS2tZ5tqJuF76K1NMAl0Jvv9DOINVFE9
 h+V94vb/u30hTv/ElJyHghe2SKbtD/s1FS4BPzL3Fx0u8Dza/tsI1Ls3Xlt2lHllhD8f
 59eYy4deGCow8Su4QXMmR/4fhe4QgunTpi5pQutrrGNIa3zGMKNQW8ASvlsR8xP8Z3G5
 9dgwz7iRF05GgGDQiXkmAgOM6gHAMTUkFD0Ln+rWemyyeD4mc7fz697xjbUSlOOBmRYh
 G6Rs2beKFHqO+nwRgvvod/kQ0qpfFrDuLLe/mR8geQA7f84KexLO/73L5dCxzhDo1UZR
 PU9w==
X-Gm-Message-State: ACgBeo0uWmdEm5SiEaBLBrQwaPWaMF2ntoC50VI8BtDFY9Gi6ekTiq76
 MhvWOA1YHwuk6J6nYxLlWoGlxlGFCxifzsLGJIc=
X-Google-Smtp-Source: AA6agR7h9gO8/PXKKbwH6uu4eGkLZfF5JgThtxPIuW2SQjLqfnP38mq3GOP5Y2/7KPeK/rF57bXoWdd34EmLjN+KczQ=
X-Received: by 2002:a1f:19cf:0:b0:375:6144:dc41 with SMTP id
 198-20020a1f19cf000000b003756144dc41mr16269547vkz.3.1662485315640; Tue, 06
 Sep 2022 10:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220905154239.2652169-1-amir73il@gmail.com>
 <20220906153811.uigc6dfxsyes5fhi@quack3>
In-Reply-To: <20220906153811.uigc6dfxsyes5fhi@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 6 Sep 2022 20:28:24 +0300
Message-ID: <CAOQ4uxi1=4K5Epvx5oYEwbcL90o5Po=eySrkxt=uGuj-Whi7Hg@mail.gmail.com>
To: Jan Kara <jack@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/9] Fanotify tests for FAN_MARK_IGNORE
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
Cc: LTP List <ltp@lists.linux.it>, Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Sep 6, 2022 at 6:38 PM Jan Kara <jack@suse.cz> wrote:
>
> Hi Amir!
>
> On Mon 05-09-22 18:42:30, Amir Goldstein wrote:
> > FAN_MARK_IGNORE feature was merge in v6.0-rc1.
> > A man page draft was posted here [1].
> >
> > Following are the tests for the new feature.
> >
> > All new test cases are skipped on old kernels.
> >
> > Note that fanotify10 will run ALL of its existing test cases
> > in two variants:
> > 1. Legacy FAN_MARK_IGNORED_MASK
> > 2. New FAN_MARK_IGNORE
> >
> > On old kernels, only the first variant of the test will run.
> >
> > In addition to the new test variant it also has some new test cases
> > that only run with new FAN_MARK_IGNORE variant.
>
> Thanks for the tests! They look good to me although I have to admit my head
> starts to spin with the number of combinations and variations in fanotify10
> testcase so I'm not very confident some subtle bug could not slip in. But

Yeh.. I can follow fanotify10 only on a good day ;)

The good thing about it is that after staring at it for long enough
I was able to extend it to provide test coverage for FAN_MARK_IGNORE
with relatively very little changes.

> hey, it's just tests and they are easy to fix if some breakage slips in. So
> feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks!
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
