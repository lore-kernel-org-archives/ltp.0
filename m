Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49741C64ED8
	for <ltp@archiver.kernel.org>; Mon, 27 Feb 2023 12:28:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A14E3CDE5E
	for <ltp@archiver.kernel.org>; Mon, 27 Feb 2023 13:27:59 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF8693C0162
 for <ltp@lists.linux.it>; Mon, 27 Feb 2023 13:27:45 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AC9962217D9
 for <ltp@lists.linux.it>; Mon, 27 Feb 2023 13:27:44 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 9415B219DF;
 Mon, 27 Feb 2023 12:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1677500863;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zRNpyHLLiXSuOu+0axU4cyIzwqVqOOZn+o1Lcz+0CYM=;
 b=UGzFOetNQ9YE3kTJA6nRKPRaZcfBFfOwk2eGiIGO9zvBKpKkaPDBLUyHVudB4j9c2FLPRG
 mXgmSY2RrjTcEhogeOx2NXgX9SbsEjwoziYONWD8F8SQJYU0wM9+w2tw7zGDRRqujgiY52
 VpOuF9OQjbqeKmIb5LCmDH5B5EGTZCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1677500863;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zRNpyHLLiXSuOu+0axU4cyIzwqVqOOZn+o1Lcz+0CYM=;
 b=aF41buBXH7ABc3fD/7x4zVQVddhTsHuMbbhP7TWOnkodbPZsErprrQkK7k7HLuHrNLKfs/
 /+ZavdHU5paSDxDg==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 357992C141;
 Mon, 27 Feb 2023 12:27:41 +0000 (UTC)
References: <20230218040919.3548296-1-liwang@redhat.com>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Mon, 27 Feb 2023 11:33:18 +0000
Organization: Linux Private Site
In-reply-to: <20230218040919.3548296-1-liwang@redhat.com>
Message-ID: <87fsarb8eb.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] madvise06: Raise the bar for judging failure
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
Cc: Yang Xu <xuyang2018.jy@cn.fujitsu.com>,
 Yongqiang Liu <liuyongqiang13@huawei.com>, Paul Bunyan <pbunyan@redhat.com>,
 Eirik Fuller <efuller@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hell Li,

Li Wang <liwang@redhat.com> writes:

> There is an intermittent failure which we have observed many times whether
> on rhel or mainline kernel. But we're unable to stable reproduce it:
>
>     43	madvise06.c:201: TFAIL: less than 102400 Kb were moved to the swap cache
>     ...
>
> However it does not look like a kernel issue, because SwapCached change is
> not strictly abiding by the principle of MADV_WILLNEED advice. That means it
> all depends on the kernel's specific circumstances. The value of the threshold
> is debatable at least from my point of view, its use 1/4 is not guaranteed
> 100% safe.
>
> As MADV_WILLNEED is just advice to the kernel, not a guarantee. The kernel may
> choose to ignore the advice, or may prioritize other memory management tasks
> over pre-loading the advised pages.
>
> So this patch is aimed at improving the accuracy and clarity of the test results.
> Specifically, the use of two separate variables to track the results of different
> comparisons will make it easier to understand what the test is doing.
>
> Additionally, the change to report a test result of "TINFO" instead of "TFAIL"
> when the swap cache size is less than expected would be intended to indicate
> that this is an acceptable outcome.
>
> Finally, the change to the second tst_res call is intended to make the test more
> lenient, as it now passes if either no page faults occur or the swap cache size
> is larger than expected.

Why not skip to making them all TINFO?

It's undefined what action will result from MADV_WILLNEED. If it were
better for performance *not* to read in pages, then it would be valid
for the kernel to ignore it.

Yang Xu added a tag for a perf regression that it could
reproduce. However looking at the kernel commit this was first found by
stress-ng.

commit 66383800df9cbdbf3b0c34d5a51bf35bcdb72fd2
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Sat Nov 21 22:17:22 2020 -0800

    mm: fix madvise WILLNEED performance problem

    The calculation of the end page index was incorrect, leading to a
    regression of 70% when running stress-ng.

    With this fix, we instead see a performance improvement of 3%

I found a bug with this test, but it was causing an Oops. It wouldn't
matter if the test printed pass or fail.

So I think we are wasting our time by constantly tweaking this test.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
