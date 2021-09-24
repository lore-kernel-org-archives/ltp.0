Return-Path: <SRS0=uWjX=OO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B567DC433EF
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 06:49:49 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D25AD610C7
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 06:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D25AD610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DF073C8F26
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 08:49:46 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E0C53C8F13
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 08:49:35 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F2F13601D76
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 08:49:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632466173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5hLX4JQnieLzhBP3IU6ejwUULeB7LSs2WrbH4FCrv4Y=;
 b=bgvvgO3VPZrb8ucN1eDT6kXR83RWLFnDb4UtPczCZSbBH9423EmEYcB2ke4KDPAEdRK8KC
 685BSQE9k6Hvi+TDKGVskO7GxRXGgaLOlY6Tb7pjXk6qR/jTAzDKwG4754vrrOJcsy1OHZ
 cLfJ7iXcS9yhmr4djZzRLehIsHM8zEA=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-XakSdz8vM_Koc8AR-ipFYA-1; Fri, 24 Sep 2021 02:49:30 -0400
X-MC-Unique: XakSdz8vM_Koc8AR-ipFYA-1
Received: by mail-yb1-f197.google.com with SMTP id
 f8-20020a2585480000b02905937897e3daso2311367ybn.2
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 23:49:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5hLX4JQnieLzhBP3IU6ejwUULeB7LSs2WrbH4FCrv4Y=;
 b=B4mgyVe3m27SKwyHj6YbXDBlNvKpOdQAUtLhZxFjfk6Y+fuJJv/xBfsMqWL1w1MbWI
 ZB44ixn0IDz8tysUEM036BeGzuIdFfuzLlCK1BvbBsai8ZFw9oCORgyWFCY4ohj3cA9z
 TgniwbsvWHKCbuONjBieJW/SZXDXdoOrW7gct1Iry7UmcwjkLoj7luhx6s1gk4fIVxh+
 rHT+pOmANsCi9vQy1Uk2NXCASN7zojoAjvWOdaomcDKVL+gCBKMYS+S9pvFOk8I1pvQE
 99Qu5w5NUgRojCTE/EUWng1QQypYqKPMeruSNqalXXWyV+MpUzg7uLlv/s/HJThufoww
 x4EQ==
X-Gm-Message-State: AOAM5338Yz4bMXspbjR4PATOubXXbBD+JjEdbSAuT684YmmG07NEc3QZ
 EKJ1i4QMzxYQyU4l/mKaBmgcxleeq78vveExCKuOM5qsD1oBlPC3Nd7WyCb6cnnS4wPDdl+X48C
 qp3M0/WOFwrFs2EQ1BKnHQItp5ek=
X-Received: by 2002:a25:3f47:: with SMTP id m68mr10782247yba.316.1632466169428; 
 Thu, 23 Sep 2021 23:49:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwBBVk1eJdn4l4PgJS0MCWKy6VNZKxl90FtiJcdOG6SufGRZzn9TssdxWkvecIOrCqcVNahuTkx/UL0K59V9g=
X-Received: by 2002:a25:3f47:: with SMTP id m68mr10782228yba.316.1632466169237; 
 Thu, 23 Sep 2021 23:49:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210817104625.2559362-1-liwang@redhat.com>
 <20210921203349.GA2014441@maple.netwinder.org>
 <CAEemH2dMCmYDkZYxfaeJ_oQCCcHzeMgSOGVQ_wS6BwCrp0YiQw@mail.gmail.com>
 <YUrnljqYd5Hx/fi+@yuki>
 <CAEemH2dDRT-iQPH0a-Aip8OZDUpp2Z3_x4dgVBEg4tv_pyWvfw@mail.gmail.com>
 <YUr9676LXNi0xMs6@yuki>
 <CAEemH2c37Qx6uEG40utX8pGC2Gp0ZLtT_z194L4RVNm6N2CefQ@mail.gmail.com>
 <YUs+jf35Zqp8GjJl@yuki> <20210922165218.GA3081072@maple.netwinder.org>
 <YUyQMBLPbCs4/Gur@yuki>
In-Reply-To: <YUyQMBLPbCs4/Gur@yuki>
From: Li Wang <liwang@redhat.com>
Date: Fri, 24 Sep 2021 14:49:17 +0800
Message-ID: <CAEemH2fRGX50RAgdAYJMW6FXX33FZG6kH=ygCQSGO6PHAi-S8g@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] fallocate05: increase the fallocate and
 defallocate size
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
Content-Type: multipart/mixed; boundary="===============1352176906=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1352176906==
Content-Type: multipart/alternative; boundary="000000000000202de605ccb8264e"

--000000000000202de605ccb8264e
Content-Type: text/plain; charset="UTF-8"

On Thu, Sep 23, 2021 at 10:32 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> FYI I've tried to run syscalls on a VM with 256MB RAM just to see what
> explodes and it looks like futex_cmp_requeue01 fails as well because we
> don't have enough memory to fork 1000 processes. I guess that we really
> need an API for at least rough scaling for the number of processes we
> can run based on free memory. With that we could finally fix the
> msgstress testcases as well.
>

+1 Sounds good.

[Cc Fang Ping]

Btw, AFAIK, pifang@ is working on an SUT ability(io, memory, ..) evaluation
before running the test, then set test parameters intelligently according
to the
lite benchmark result. This will definitely help make a proper runtest file
for LTP,
but I'm not sure if he plans to integrate it in LTP internally.

I will talk to him to learn more details.

>
> Also it seems that in my case the tmpfs returns ENOSPC correctly when
> the machine free memory gets low enough regardless of the limit set at
> the mount time, and that's 4.19.0-16-amd64. So I guess that there may be
> something wrong in the kernel you are testing after all.
>

Maybe yes, so I send request for more info of Ralph's system.

-- 
Regards,
Li Wang

--000000000000202de605ccb8264e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, Sep 23, 2021 at 10:32 PM Cyril Hrubis &lt;<=
a href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
FYI I&#39;ve tried to run syscalls on a VM with 256MB RAM just to see what<=
br>
explodes and it looks like futex_cmp_requeue01 fails as well because we<br>
don&#39;t have enough memory to fork 1000 processes. I guess that we really=
<br>
need an API for at least rough scaling for the number of processes we<br>
can run based on free memory. With that we could finally fix the<br>
msgstress testcases as well.<br></blockquote><div><br></div><div class=3D"g=
mail_default" style=3D"font-size:small">+1 Sounds good.</div><div class=3D"=
gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmail_defa=
ult" style=3D"font-size:small">[Cc Fang Ping]</div><div class=3D"gmail_defa=
ult" style=3D"font-size:small"><br></div><div class=3D"gmail_default" style=
=3D"font-size:small">Btw, AFAIK, pifang@ is working on an SUT ability(io, m=
emory, ..) evaluation=C2=A0</div><div class=3D"gmail_default" style=3D"font=
-size:small">before running the test, then set test parameters intelligentl=
y according to the</div><div class=3D"gmail_default" style=3D"font-size:sma=
ll">lite benchmark=C2=A0result. This will definitely help make a proper run=
test file for LTP,=C2=A0</div><div class=3D"gmail_default" style=3D"font-si=
ze:small">but I&#39;m not sure if he plans to integrate=C2=A0it in LTP inte=
rnally.</div><div class=3D"gmail_default" style=3D"font-size:small"><br></d=
iv><div class=3D"gmail_default" style=3D"font-size:small">I will talk to hi=
m to learn more details.</div><div class=3D"gmail_default" style=3D"font-si=
ze:small"></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Also it seems that in my case the tmpfs returns ENOSPC correctly when<br>
the machine free memory gets low enough regardless of the limit set at<br>
the mount time, and that&#39;s 4.19.0-16-amd64. So I guess that there may b=
e<br>
something wrong in the kernel you are testing after all.<br>
</blockquote><div><br></div><div class=3D"gmail_default" style=3D"font-size=
:small">Maybe yes, so I send request for more info of Ralph&#39;s system.</=
div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature">=
<div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div><=
/div>

--000000000000202de605ccb8264e--


--===============1352176906==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1352176906==--

