Return-Path: <SRS0=gHvU=PP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC531C433F5
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 08:36:19 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B018360F21
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 08:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B018360F21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF07A3C68B7
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 10:36:16 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0556C3C67D6
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 10:36:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1DD52140165B
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 10:36:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635323765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4F0CTYAzFHVVg3Os6zSGyj33VaTJdAmsd8yc3VfTkY4=;
 b=OQMsvuLL1ZuK6FamcRaxQPJgZTfkVIV/yOqiaAf54klSKAev5rqdAsjx18IIY+iRavZW5t
 7E0x1dUNaoAji6e9f77rwVJgV1fOYZV5awQ3nqYKnRszvm4nPiAnNOHjvWpLhJzNMyRS4w
 Tq8BicCGiYhfluqJ4STGW7fo1FdelEY=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-e3-bHC22OIOYTJygoJCsKA-1; Wed, 27 Oct 2021 04:36:01 -0400
X-MC-Unique: e3-bHC22OIOYTJygoJCsKA-1
Received: by mail-oi1-f197.google.com with SMTP id
 n196-20020acad6cd000000b0029a267b839eso913373oig.19
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 01:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4F0CTYAzFHVVg3Os6zSGyj33VaTJdAmsd8yc3VfTkY4=;
 b=UI2wKpkQ/4gGsieCpFXUvFNStBI2aWMZdAlkv0mFbdqxVjzCs6lAl5TU7rzaTQxldJ
 HyLVl2DV/VuSuKbkeno4n0LcyASZa0JwPqYi1LNymVY54LzCCSEczD3PSJpWzxP0nNmr
 dishwdjL2pJx5mM6cJfrpq2pu1T9Wof6lg9ZDQdWfjNDlXzuAkDmOOgemr5nsze1ZwoO
 wN5M3gMt8vgN4O6tZvIPLJLtAwjbnHBsGYVNpRR15L+iuJH4uyNK/m5sP4IDdCUl7rDF
 8rWvpJEMTXwCyZSR5Semfqn7QteSg0YCT4EaJs8aax+BnT9M0kKz2enJyxUBSX83ruam
 csNQ==
X-Gm-Message-State: AOAM5332rJkr8Ps6Eg0iDcbK96MCu3tBTCvwEPzvhDD5s1Y3C+B3+hRz
 0VA9lNVY7LGknURindCaKCnWt73XgvgryGYj4LZdnKUzCPea2IgXaoJep0Ym7bnGKGBbCU5TtnE
 oTAI3CJhtQ0fYO1ffx7L00HkzW44=
X-Received: by 2002:a4a:b385:: with SMTP id p5mr4540606ooo.21.1635323761155;
 Wed, 27 Oct 2021 01:36:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyDctK0EJ/CGs9EVcxrHGgg18cYmrw9FXUa3f/N96gTTf7mJdsjYxPQ3sgiUXEN+zmKYAmg8Wggp7VM/INGi8=
X-Received: by 2002:a4a:b385:: with SMTP id p5mr4540592ooo.21.1635323760908;
 Wed, 27 Oct 2021 01:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <366c70644bfb48ddb13e33e80cea5718@huawei.com>
In-Reply-To: <366c70644bfb48ddb13e33e80cea5718@huawei.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 27 Oct 2021 10:35:44 +0200
Message-ID: <CAASaF6zpfq2CjxZS+N50AjXu-d+AuK5SKOZpOZv6JfPOeMn7Pw@mail.gmail.com>
To: zhaogongyi <zhaogongyi@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lapi/syscalls: Add epoll_create for aarch64.in
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Oct 27, 2021 at 5:28 AM zhaogongyi <zhaogongyi@huawei.com> wrote:
>
> Hi,
>
> >
> > On Tue, Oct 26, 2021 at 9:49 AM Zhao Gongyi <zhaogongyi@huawei.com>
> > wrote:
> > >
> > > Add epoll_create for aarch64.in and modify the value of epoll_ctl for
> > > aarch64.in. Otherwise, the testcase epoll_create01/epoll_create02 will
> > > fail.
> > >
> > > Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> > > ---
> > >  include/lapi/syscalls/aarch64.in | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/lapi/syscalls/aarch64.in
> > > b/include/lapi/syscalls/aarch64.in
> > > index a47185954..e9023a1d0 100644
> > > --- a/include/lapi/syscalls/aarch64.in
> > > +++ b/include/lapi/syscalls/aarch64.in
> > > @@ -19,7 +19,6 @@ getcwd 17
> > >  lookup_dcookie 18
> > >  eventfd2 19
> > >  epoll_create1 20
> > > -epoll_ctl 21
> > >  epoll_pwait 22
> > >  dup 23
> > >  dup3 24
> > > @@ -243,6 +242,8 @@ rt_tgsigqueueinfo 240  perf_event_open 241
> > >  accept4 242
> > >  recvmmsg 243
> > > +epoll_create 250
> > > +epoll_ctl 251
> >
> > These values are for 32 bit only syscalls. Won't this break 64 bit?
>
> Yes, these values are for 32 bit only syscalls, the syscall epoll_create is not support for 64bit arm64.

Right, adding epoll_create is OK, but changing epoll_ctl would break
64bit if there were any users of __NR_epoll_ctl.

>
> Reference to man 2 epoll_create, we can see that epoll_create/epoll_create1 are supported If only we include the header file sys/epoll.h.
>
> Is it better that we call epoll_create replace to syscall __NR_epoll_create since some plateform not support it?

I think so. We already use epoll_create() in other tests, so this
looks like simplest solution for all arches.

>
>
> Thanks for you review!
>
> >
> > >  wait4 260
> > >  prlimit64 261
> > >  fanotify_init 262
> > > --
> > > 2.17.1
> > >
> > >
> > > --
> > > Mailing list info: https://lists.linux.it/listinfo/ltp
> > >
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
