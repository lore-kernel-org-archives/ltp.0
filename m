Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5CBC38142
	for <ltp@archiver.kernel.org>; Wed,  1 Feb 2023 18:32:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D3D303CC66A
	for <ltp@archiver.kernel.org>; Wed,  1 Feb 2023 19:32:31 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 96E6A3CB28F
 for <ltp@lists.linux.it>; Wed,  1 Feb 2023 19:32:22 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2C7BA600D93
 for <ltp@lists.linux.it>; Wed,  1 Feb 2023 19:32:22 +0100 (CET)
Received: by mail-ej1-x633.google.com with SMTP id hx15so34541478ejc.11
 for <ltp@lists.linux.it>; Wed, 01 Feb 2023 10:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4BOOXUPVXrUmlwMM+HULBsxTBE55UTXdSUBQjN+a61U=;
 b=WIBOZEge3PSiw1WPIqmUd6/R7AnpkpKbBtjRURsLz6T3JY5RdRzd+8Cvno9fxOeF3L
 ZM/L3HasZ3p0pLXCTc8ZNrMimuz7Wo99JsUcgXwdNhv6ymdMOZqaMxMDOlTxUvK4amOI
 YPlIibICnDwnV9/NcGRlqBQQygFMepxndYoaJ/F3H6/wCNB1wJpoZVQuSlyOBopZwbdP
 79CM5dag6Rx8y11/rN4guPrYpN5ZmfZQTyrBu6KxLm1SqOwytjhnJMLO7jzuAnf8mEu8
 lCt35euHqxr0qjr7P9CwGYwEYDt86MsojVgzECNHnMG333OkUod67EBzxRz8F5BG4kMB
 1WUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4BOOXUPVXrUmlwMM+HULBsxTBE55UTXdSUBQjN+a61U=;
 b=NEmGWt4i+yCFZaDfonBzTKpLCRKdWYA2C8hVGpJnE6IAz6km5IzzDOjcTz4kinAUYl
 lpYWeCQnq10lRt1oSgIm2lbSGVe86tA+yKN3cOCCqUpoPMaY76dnSXn60GOciPWAncRJ
 JHWE4wSc4woQh9DwC76+TmaKM0BpFrhK56qVvzvrBg6IiqIVjhXOfLOy/zWObuetQrdC
 iL4bt342H6qA5L7piag9t41fojbIoMwBp4rPM0YtmZFGbXDWMmTj8N+sTTkpIzK9xl0q
 vqOR/tHcuVeRrdkt8Ko0sx75M3Y1bhzq97GJnCttWn/WtE1q8sjYNxM694pMFLig7Xo8
 JMkg==
X-Gm-Message-State: AO0yUKVRj8jXrvuyQj408u5/IojlqTodx5nRP4HXigm6FeeAqDQGVSbF
 EaYmloQd2dZGl1tjBZZ+gGS0hTrGarkjq83biosaQRA8P99c25jP
X-Google-Smtp-Source: AK7set+83ewLaYxEJs/4jPaF+YzPq+6fjb05uQgbQw5mqzCKUteVemBDWO3lIN0R5FPMj8o5bYaeXUrhhJqurKjk1MM=
X-Received: by 2002:a17:907:6087:b0:889:7bef:3a9d with SMTP id
 ht7-20020a170907608700b008897bef3a9dmr1078009ejc.150.1675276341608; Wed, 01
 Feb 2023 10:32:21 -0800 (PST)
MIME-Version: 1.0
References: <20230131002532.459456-1-edliaw@google.com>
 <Y9paGafh97zKnu/j@pevik>
In-Reply-To: <Y9paGafh97zKnu/j@pevik>
Date: Wed, 1 Feb 2023 10:31:54 -0800
Message-ID: <CAG4es9V2773dyVrDwt7fiUq=VkUrn0Tr8icCC=X3xx+RGrbR9A@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] close_range: check for kernel support below 5.9
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

Hi Petr,

> > +++ b/include/lapi/close_range.h
> > @@ -25,4 +25,17 @@ static inline int close_range(unsigned int fd, unsigned int max_fd,
> >       return tst_syscall(__NR_close_range, fd, max_fd, flags);
> >  }
> >  # endif
> > +
> > +static inline void close_range_supported_by_kernel(void)
> > +{
> > +     long ret;
> > +
> > +     if ((tst_kvercmp(5, 9, 0)) < 0) {
> > +             /* Check if the syscall is backported on an older kernel */
> BTW what particular use case this fixed? Is it backported to some android
> kernel? Or to some enterprise distro? Because I don't think kernel stable trees
> accept new functionality, just fixes.

Oops, should I use .min_kver instead?  It isn't backported on Android;
I just wasn't sure what the right approach was.

Thanks,
Edward

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
