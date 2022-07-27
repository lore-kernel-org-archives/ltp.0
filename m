Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E511FC04A68
	for <ltp@archiver.kernel.org>; Wed, 27 Jul 2022 21:37:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E11EE3C4CA9
	for <ltp@archiver.kernel.org>; Wed, 27 Jul 2022 23:37:48 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 889B73C2168
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 23:37:39 +0200 (CEST)
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com
 [IPv6:2607:f8b0:4864:20::e2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B93381000D0E
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 23:37:38 +0200 (CEST)
Received: by mail-vs1-xe2b.google.com with SMTP id 66so15021471vse.4
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 14:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gpd8vF343U9xNimvBQnKXhUtg4ZptloRWJMxmUfGVj4=;
 b=X/JCZRVv6uLY0vyB1sRc5RJDJQejsQPrivonNEQn2PGsmRsATc0dmbWj/NJc6JzfbR
 WsI7A99etanCQ3fNnzbB5MG+35H6MK6Iiakc2BFjNP0zawV/X5+zwMxYW8WlTMlc1YcB
 yzCUVVKnXhe/Bq3IaN1EPWCkxwJfbYeYdwnTURXetnOM3+ULDju1DPCRvkoDb2g46uQx
 uEwuAduugliOg4xwTEPYhfh+gI9wflJBU9t4OrbfW0lLbE+OftXe1V3zyd6lWPVX6hku
 s4bYBMVYKc7LEHOVrPSHqLxQBYBPC+xrGT+PdmHkoqYdq1J8iwmALGqP5VSZKNdA+aPg
 ncIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gpd8vF343U9xNimvBQnKXhUtg4ZptloRWJMxmUfGVj4=;
 b=ncZtpcDK9fsQrlwxWbxUh6hfcxTrT9hKuhMA2Ci0ZJ389A77YJkggCr+Mx2hhRUStI
 /IGBweGpSm9oYVMqvdW7o2XMNYFoK8jpVYj34N9uhebLE0aZqFJHfB29rVdVoPClbHyW
 XCKtrDE27WxHOd8WR/aqERG4MHS0Im9E45n0xrVQKS26bfAjVdc2ElU0iWkvVbf2UpnH
 gIe+mxzXX9MsL9mhyjmni3YeFK9wypCKs7jrFpVL04DPALZKZGUINrBHIx4Gex7uz+8I
 7Gxw+/GYMzNHPjMEB+005qsd+12K4IY3vRzilxJfZCOTQllOSBcs4waqF4SKdwAp9I2k
 LEEg==
X-Gm-Message-State: AJIora/WZtVh/1mfGlmaFOXpDFyPSCvz+8snB/T8bYjPLKm++eFnsfdn
 b1ElzOrKJrfWHVEZi+D9IrhNS+j2m1FRg0/2+N+oKw==
X-Google-Smtp-Source: AGRyM1uKCFIn9Kx/jXhne8ChmMAZRbImtMq++9mvJNOwlSg00tfjbWJIKaLWNNfy+6OV903LpzZte4FZdkZb6fWZhyE=
X-Received: by 2002:a05:6102:2432:b0:357:4793:d267 with SMTP id
 l18-20020a056102243200b003574793d267mr7624337vsi.83.1658957857463; Wed, 27
 Jul 2022 14:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220712173921.2623135-1-edliaw@google.com> <YtaFddMFjVPMTpme@rei>
In-Reply-To: <YtaFddMFjVPMTpme@rei>
Date: Wed, 27 Jul 2022 14:37:26 -0700
Message-ID: <CAG4es9Wn+wZRu6xr-FgZ=pTq4ReGdrmsmGYO4ZXvKj8ee3QH8w@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] syscalls/signal06: add volatile to loop
 variable
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hey Cyril, sorry for the late reply, I was on vacation.

On Tue, Jul 19, 2022 at 3:19 AM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > On Android compiled with clang, the loop variable will be optimized out
> > unless it is tagged with volatile.
>
> Looking at the code it looks strange that it's optimized out since we
> use the value for the loop as:
>
>         loop = 0;
>
>         D = VALUE;
>         while (D == VALUE && loop < LOOPS) {
>                 asm(...);
>                 loop++;
>         }
>
> And the D variable is properly marked as volatile so it's not like the
> loop can be expected to iterate preciselly LOOPS iterations.
>
> It looks to me like the compiler actually forgets about the volatility
> of D for some reason and then assumes that the loop does LOOPS
> iterations.

I'm not totally sure how the compiler is working in this case.

What I saw with Android is that it fails with:
signal06    0  TINFO  :  loop = 2076174312
signal06    1  TFAIL  :
external/ltp/testcases/kernel/syscalls/signal/signal06.c:87: Bug
Reproduced!

It makes one iteration, then loop is set to a random large int and the
loop terminates.  Printing the value of loop inside the for loop
actually caused it to iterate 30000 times and succeed.

Compared to a successful run, which looks like:
signal06    0  TINFO  :  loop = 30000
signal06    1  TPASS  :  signal06 call succeeded

Thanks,
Edward

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
