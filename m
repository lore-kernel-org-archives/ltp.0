Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A9D4C433F5
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 08:45:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA6353C1B97
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 09:45:46 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC8AE3C012E
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 09:45:35 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2708A1A011E3
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 09:45:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646901933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p/288XRguDPGhwN1rWA1SxF+jV9Z1QvQIS7cr9fwRuA=;
 b=XM/uye3BPvWWVmIrUttKskGNu/t8rUiz0n0j2sOSxRyAoAJ1qyIU8P9/L3ajyH0MhwrRqU
 g0k/vR3BB0h93UqiRe+iXMg+11WxOibBb0oMDvc4K2OZS7Wp6qBz/TrR3kSLDF3FnLG/5q
 XtPrpSyX5HZ7E2dgYo7PAqEvKpPm5LY=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-147-tqcbyyqwMtGBCsEpxySVAw-1; Thu, 10 Mar 2022 03:45:31 -0500
X-MC-Unique: tqcbyyqwMtGBCsEpxySVAw-1
Received: by mail-yb1-f200.google.com with SMTP id
 v1-20020a25fc01000000b006289a83ed20so3885284ybd.7
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 00:45:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=p/288XRguDPGhwN1rWA1SxF+jV9Z1QvQIS7cr9fwRuA=;
 b=fOUK+ZiRuZ06Ad/JWb8d3ODhS9Q8qL3SnB1FHtF6TuYFVh804jQ86BeqEXbn7NM1Uw
 OMCET881QjbtWRGgtc3c1pz46tpId9fiIQ+a4o8vlUv6JxY8RW8tyK2sl+iCCh+VjmnA
 ssiVWSvl02FQ4gW7AR1qsDXb+xRcNvr3QRC//LJRQB4GAOWPJf+ngoNeqHJqMvzS7pRa
 yDxsiWfGaDTnbpulF0NxFKwBWQsQlHqgrGpfgZFoVZDo65wXB0Sk1sWm78IqQhZoomRd
 EDHInWZYkC8diLLuDA7s3QTfjlNKd3YG0yCE2Vqnv/tNmlh/cCJ0g2UAlQWtaYc+VXW/
 JQSA==
X-Gm-Message-State: AOAM530xImbeB2r2WKbbttO5Xc16a+gfEPrIQ7lUkdJxnYHThJhwVskn
 L6hau3xb7mV9B5+zsUDua1XMGpDwOE9TA3bD9gJobu4nGmQf9Xb1EqBnPBTDZI1Y4kcfit6luNk
 olb+uTRN4R9uRygt8890JOsArAmo=
X-Received: by 2002:a5b:5d0:0:b0:623:c68d:d473 with SMTP id
 w16-20020a5b05d0000000b00623c68dd473mr2987434ybp.506.1646901931277; 
 Thu, 10 Mar 2022 00:45:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw+D9PZlZCnQVAnwSt039j7oNr6DkzI2IGiRj7AYrO0gkkn4ShMFt6sNSnwVGIffE+1sAz6IC4oODHzFM6FOaM=
X-Received: by 2002:a5b:5d0:0:b0:623:c68d:d473 with SMTP id
 w16-20020a5b05d0000000b00623c68dd473mr2987424ybp.506.1646901931048; Thu, 10
 Mar 2022 00:45:31 -0800 (PST)
MIME-Version: 1.0
References: <20220310082251.13173-1-liwang@redhat.com>
 <6229B934.9040606@fujitsu.com>
In-Reply-To: <6229B934.9040606@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 10 Mar 2022 16:45:16 +0800
Message-ID: <CAEemH2dwawam7iK+E7KnY8Qi0vwz9NWXEf4Bzo3o_9tz-75kjg@mail.gmail.com>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [COMMITTED] save_restore: remove the duplicate 'const'
 declaration
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============2099503718=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============2099503718==
Content-Type: multipart/alternative; boundary="00000000000094989f05d9d93cd5"

--00000000000094989f05d9d93cd5
Content-Type: text/plain; charset="UTF-8"

On Thu, Mar 10, 2022 at 4:38 PM xuyang2018.jy@fujitsu.com <
xuyang2018.jy@fujitsu.com> wrote:

> Hi Li
> > --- a/lib/newlib_tests/test19.c
> > +++ b/lib/newlib_tests/test19.c
> > @@ -23,7 +23,7 @@ static struct tst_test test = {
> >       .needs_root = 1,
> >       .test_all = run,
> >       .setup = setup,
> > -     .save_restore = (const struct tst_path_val const[]) {
> > +     .save_restore = (const struct tst_path_val[]) {
> >               {"?/proc/nonexistent", NULL},
> >               {"!/proc/sys/kernel/numa_balancing", NULL},
> >               {"/proc/sys/kernel/core_pattern", NULL},
>
> Since tst_path_val is a struct array, we should use {NULL, NULL} or {}
> terminated instead of NULL terminated , otherwise it will report missing
> braces warning.
>

Ah, right. Sorry!!!

Seems I was in so hurry to fix the const issue but overlook this.

-- 
Regards,
Li Wang

--00000000000094989f05d9d93cd5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, Mar 10, 2022 at 4:38 PM <a href=3D"mailto:x=
uyang2018.jy@fujitsu.com">xuyang2018.jy@fujitsu.com</a> &lt;<a href=3D"mail=
to:xuyang2018.jy@fujitsu.com">xuyang2018.jy@fujitsu.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Li<br>
&gt; --- a/lib/newlib_tests/test19.c<br>
&gt; +++ b/lib/newlib_tests/test19.c<br>
&gt; @@ -23,7 +23,7 @@ static struct tst_test test =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.needs_root =3D 1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.test_all =3D run,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.setup =3D setup,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0.save_restore =3D (const struct tst_path_val cons=
t[]) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.save_restore =3D (const struct tst_path_val[]) {=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;?/proc/no=
nexistent&quot;, NULL},<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;!/proc/sy=
s/kernel/numa_balancing&quot;, NULL},<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/proc/sys=
/kernel/core_pattern&quot;, NULL},<br>
<br>
Since tst_path_val is a struct array, we should use {NULL, NULL} or {} <br>
terminated instead of NULL terminated , otherwise it will report missing <b=
r>
braces warning.<br></blockquote><div>=C2=A0</div><div><div class=3D"gmail_d=
efault" style=3D"font-size:small">Ah, right. Sorry!!!</div><div class=3D"gm=
ail_default" style=3D"font-size:small"><br></div><div class=3D"gmail_defaul=
t" style=3D"font-size:small">Seems I was in so hurry to fix the const issue=
 but overlook this.</div></div></div><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--00000000000094989f05d9d93cd5--


--===============2099503718==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============2099503718==--

