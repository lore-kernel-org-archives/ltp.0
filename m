Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE7BC43334
	for <ltp@archiver.kernel.org>; Mon, 25 Jul 2022 15:11:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2AEF53C9732
	for <ltp@archiver.kernel.org>; Mon, 25 Jul 2022 17:11:18 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 915A83C06A9
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 17:11:06 +0200 (CEST)
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com
 [IPv6:2607:f8b0:4864:20::e35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3FA7B1000434
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 17:11:06 +0200 (CEST)
Received: by mail-vs1-xe35.google.com with SMTP id 125so10965328vsx.7
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 08:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rF5etP49FNRJT0P3PMoz1wC8AvVMe1/8dIdcTVeUEZU=;
 b=W8V8VsJghIKgt+g1Be2AGU0u55WNJz08b2vvCOHdcgfKnrGVbR6c+NtrypHtKvPq1n
 C4Hrfg406/lRfN43M4/fSkqOVX9PrZR8MU8eWENYV3K7LvRNiKN/1jqG2f7/DlDUJI6F
 UzFfLdsqZm5ZTLL3/ztYVvd/zUxlVbkOMTR9GgWj3torhbAVGBaqdhiMfs7J8m1ku4Er
 +YznyauwD8PY0X+moNL3kNNNqn1DeWz8KxvolBznHEoo/XRtbPmMlncz/sF66BExiWyY
 1d1QXO4SqLuMvbmkSAOexU0It5RxRyiWx+c18AVqqUOTco40no3hB195v4CgfmhFT7d5
 sFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rF5etP49FNRJT0P3PMoz1wC8AvVMe1/8dIdcTVeUEZU=;
 b=g9QVDOvo5/TWFqBySRT/FXxWGVq61zve/Tsc75fl6FNjpOOOWXh6OKU3lLtm0PWJGL
 7IGOhlLkxRVgp2S9TrIx7zt30ivMvgsm6+yQ/En6KOYGSbONBvlcMkYCfk5xWXQU0JKQ
 9/ndtE4kHt3iP6Is2Po8buaCLgbN+BdslCcpBLZ3oJWrOYzdrfRd/fxLWqghGt5gD5bQ
 /dvjXrZWWU/A7Ar3u7evRKim/59EOTLi2x+pKg6kJxzEz/cQ1NFigj4/BBCPrHsFnJl6
 fSCgT+kohO54r2pmZhUQ1d9EVehVuQsUzMPQbUjrH/G2Xs1/la3IpfkN3zoNZ2l86ybZ
 V63g==
X-Gm-Message-State: AJIora86e/qM0C6sJtbe6HIqRMge9Bv3Qku8GWuM7Fb6FLAfl/u0aJOl
 VZBiygzqFnAL1Thj7hEmTa/1rgtAsXtmA9HByIs=
X-Google-Smtp-Source: AGRyM1u/sRgwn4NS3IAzGWX8yHGngnfrG66j3s/LBFlk/dGwZ5uruNx/VtSdOK+YB1hWvFjkuiroMnNageTNZLrJc+w=
X-Received: by 2002:a05:6102:3ecd:b0:358:57a1:d8a with SMTP id
 n13-20020a0561023ecd00b0035857a10d8amr1814951vsv.2.1658761864826; Mon, 25 Jul
 2022 08:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220719095853.3373732-1-amir73il@gmail.com>
 <20220719095853.3373732-2-amir73il@gmail.com>
 <YtcpBkevcBF6iycz@google.com> <Yt6Rcd3NAO1bKwwD@pevik>
In-Reply-To: <Yt6Rcd3NAO1bKwwD@pevik>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 25 Jul 2022 17:10:53 +0200
Message-ID: <CAOQ4uxgG_jrLHKFm67AQEw-+x66WoRaAfBi+3WwXzXwh9GOUAQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] syscalls/fanotify14: Encode the expected
 errno in test case
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
Cc: Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Jul 25, 2022 at 2:49 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> > On Tue, Jul 19, 2022 at 11:58:52AM +0200, Amir Goldstein wrote:
> > > So we can add test cases for errors other than EINVAL.
>
> > Just one optional nit. We can probably remove the comments which are
> > directly above the existing `if (errno == EINVAL)` checks as they're
> > specific to one expected errno value, but this is no longer the case
> > with ENOTDIR now in some fanotify_init/fanotify_mark cases.
>
> @Amir, I can remove it in this commit before merge (see diff below),
> but don't you want to keep this info somewhere?
> Or feel free to post new version.

Good idea.
I will add the comments to the individual test cases and re-post.

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
