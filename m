Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6129BC433F5
	for <ltp@archiver.kernel.org>; Thu, 26 May 2022 10:26:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E081E3C0F4C
	for <ltp@archiver.kernel.org>; Thu, 26 May 2022 12:26:51 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 91D243C00EA
 for <ltp@lists.linux.it>; Thu, 26 May 2022 12:26:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 82A78200250
 for <ltp@lists.linux.it>; Thu, 26 May 2022 12:26:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653560799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hCwQuCrPLn4ewU/HRzMM6iNt+3iP0po3XNvbtvGh52U=;
 b=jWUZ4Gi3WkNGnJRHTBIGAAHwUX+EfUOnoXZzfcr5K8nQ366CJEi1RB7R8omnP7n6FB2ne2
 08xvpJd4Mo8nMA078Bq5VersIf4oLcL6gZiddmwpekMwx9gE3nsrW4Rm7gBMJgJQEmE5Ho
 s4fdGafUbj4QZXxUDNMd9Jj6OHdQGKM=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-DGmfRoVmMLqIIvzQCHx7TA-1; Thu, 26 May 2022 06:26:35 -0400
X-MC-Unique: DGmfRoVmMLqIIvzQCHx7TA-1
Received: by mail-yb1-f200.google.com with SMTP id
 s127-20020a252c85000000b0065386279888so1242358ybs.3
 for <ltp@lists.linux.it>; Thu, 26 May 2022 03:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hCwQuCrPLn4ewU/HRzMM6iNt+3iP0po3XNvbtvGh52U=;
 b=dxqFPqgrpfdxDPSRV4PfIHzV0olHnN8sE42RBk2rrdRjy9VWolL607pWtgbih1Rb50
 TbrydmYbZfj0GR1dt+/xN4nNs8zGKWEoUas7aoQMOPuxL2V0EO1IWUFDqu5sTRLWoBk7
 6UIDFJGs+XxnKJ6qaSlJ/uKNLkrM71RWvT9QbCumGW+ZX+GTTPR1v/P+06e7d02Z5gp/
 DzIRSSu/hLrseo/ncVHZgGgQ3s/ace6gDvnfREB49KbD5da7V2wAB1Rev079EQrusIW9
 tXm6vE2WjhTWQGiF06cdABH3qYMt+iSpDXOjs4CfcUKnUEkXkzTd0KiXN17CxAM07nP6
 iY6A==
X-Gm-Message-State: AOAM533mFfw3OmV0RBy7wf6zozsYhbXwE6FI5OCTN3qVqUCvTV/09Yll
 qvr7fg2hizmeTIrRdRyZhfqs3Fo8GfytUcW+QI4KdD3VlLOpEyKi3eHtEdafRm7c/xHnEwvxz/h
 zvqLfgMzZbqqlo6YNxTxxkJ+dLlI=
X-Received: by 2002:a25:9c43:0:b0:64b:f78:3735 with SMTP id
 x3-20020a259c43000000b0064b0f783735mr33367556ybo.591.1653560794967; 
 Thu, 26 May 2022 03:26:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4A2Pt6sigCRc5CGNhQ6hYsqGkT/wTrkgAHQOatDxUEJNooBwgTotbo23YkgT8vRgFEUTJYtQ4GYnvTlZ53uo=
X-Received: by 2002:a25:9c43:0:b0:64b:f78:3735 with SMTP id
 x3-20020a259c43000000b0064b0f783735mr33367538ybo.591.1653560794716; Thu, 26
 May 2022 03:26:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220525113113.9811-1-chrubis@suse.cz>
In-Reply-To: <20220525113113.9811-1-chrubis@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Thu, 26 May 2022 18:26:23 +0800
Message-ID: <CAEemH2dsasry++GmBxgbTRRAryrBs3FPtYgXMNEmDcOK--r4XQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/timer_settime03: Scale interval with
 clock precision
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
Content-Type: multipart/mixed; boundary="===============0486015591=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0486015591==
Content-Type: multipart/alternative; boundary="000000000000c8b41305dfe79f1c"

--000000000000c8b41305dfe79f1c
Content-Type: text/plain; charset="UTF-8"

On Wed, May 25, 2022 at 7:29 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> What the test does is to:
>
> - set initial expiration in the past
> - set very small interval value
> - expect the timer to overrun immediatelly many times
>   to trigger timer overrun counter overflow
>
> However the test has harcoded expectation that the kernel timers have
> 1ns resolution. And while that is true for many modern hardware high
> resolution timers are generally not always present.
>
> The test tried to cope with that by adding kernel requirement for
> CONFIG_HIGH_RES_TIMERS=y however that does not necessarily mean that the
> high resolution hardware is present or that the drivers are loaded.
> This only means that the support has been compiled in the kernel.
>
> So instead of disabling the test when kernel timers have lower precision
> we scale the timer interval so that the inverval length divided by the
> timer precision is constant i.e. handler_delay.
>
> Fixes #925
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
>

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

--000000000000c8b41305dfe79f1c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, May 25, 2022 at 7:29 PM Cyril Hrubis &lt;<a=
 href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">What the test does is to:<b=
r>
<br>
- set initial expiration in the past<br>
- set very small interval value<br>
- expect the timer to overrun immediatelly many times<br>
=C2=A0 to trigger timer overrun counter overflow<br>
<br>
However the test has harcoded expectation that the kernel timers have<br>
1ns resolution. And while that is true for many modern hardware high<br>
resolution timers are generally not always present.<br>
<br>
The test tried to cope with that by adding kernel requirement for<br>
CONFIG_HIGH_RES_TIMERS=3Dy however that does not necessarily mean that the<=
br>
high resolution hardware is present or that the drivers are loaded.<br>
This only means that the support has been compiled in the kernel.<br>
<br>
So instead of disabling the test when kernel timers have lower precision<br=
>
we scale the timer interval so that the inverval length divided by the<br>
timer precision is constant i.e. handler_delay.<br>
<br>
Fixes #925<br>
<br>
Signed-off-by: Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz" target=
=3D"_blank">chrubis@suse.cz</a>&gt;<br></blockquote><div><br></div><div cla=
ss=3D"gmail_default" style=3D"font-size:small">Reviewed-by: Li Wang &lt;<a =
href=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt;</div><div class=
=3D"gmail_default" style=3D"font-size:small"><br></div></div><div><br></div=
>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Re=
gards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000c8b41305dfe79f1c--


--===============0486015591==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0486015591==--

