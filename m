Return-Path: <SRS0=ZNpR=QE=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F2FC433EF
	for <ltp@archiver.kernel.org>; Wed, 17 Nov 2021 13:51:32 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D97DC6127C
	for <ltp@archiver.kernel.org>; Wed, 17 Nov 2021 13:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D97DC6127C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C8D43C8811
	for <ltp@archiver.kernel.org>; Wed, 17 Nov 2021 14:51:30 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4901C3C2754
 for <ltp@lists.linux.it>; Wed, 17 Nov 2021 14:51:21 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5C92B601C73
 for <ltp@lists.linux.it>; Wed, 17 Nov 2021 14:51:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637157079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u9hjSDGuD7J/ZZ+A4ZsD7YHGZ0crgr8Ea7fPdc3EP4E=;
 b=D/zrRxRBH9mT8Xd1FDiOS7fbaIXNLr704KYvsiyxcHrlvg5BcBSQ02JlE3x6ZklHkWM7/W
 PFARI0wJHg3adAjTDkNBQ6kaOV3rsvWb8WXBs+UdMLKV92msEw9KfBX7LWptp4uSwDJe8f
 gagCA5w1bQ+l8/iVUh6+bnRAc1EheqQ=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-YP6OGOflPcy6amLu0EBpDA-1; Wed, 17 Nov 2021 08:51:17 -0500
X-MC-Unique: YP6OGOflPcy6amLu0EBpDA-1
Received: by mail-yb1-f198.google.com with SMTP id
 y125-20020a25dc83000000b005c2326bf744so3952259ybe.21
 for <ltp@lists.linux.it>; Wed, 17 Nov 2021 05:51:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u9hjSDGuD7J/ZZ+A4ZsD7YHGZ0crgr8Ea7fPdc3EP4E=;
 b=gPD8VzP4OgQFdGP5NEPM86qi41S2kyRqApC6wM4WmuDZmkUDPAu4PfxKRokdBNOOvv
 Z5HV7btsDlc27qDr0rrifXWHDtMFfbUyBUKvNSqV+sz8sHeH/tIuVK9JLMlXP7uJJTO4
 h9kw4dUSyovkBShCfNEDm2etdVQUmcfwHiqW4knYzCcq7JInpR9KesGlt88lLKBIWKhu
 LI7bWooonmkWvdUNrTWm6MmswpdW4dDmFEg8wucs2AV1wwn6XSdqcoPtpbeX0eeAQ1Kl
 L8s7qVu7P+Jzd8X50P5uTJnvFXe0bSjwDlXmbfAI6w98KRvd2x8YUe9vd17mAOud3rL2
 UEDw==
X-Gm-Message-State: AOAM532IFiudOtR4Fh9zMY25+KD5l3mVwuuaMBmsqkeaqSFL76agcFxQ
 0jyhFvdE330QBC478jbT2dMCOzFbMkMAQCuEs+29c9DDXikZ+sJ4Fsa5CLVK+aCEJz1xPHDBGFO
 KD3bUHl0ZBCTA5Kl+anvg9GFCJt0=
X-Received: by 2002:a25:a062:: with SMTP id x89mr17760705ybh.339.1637157076679; 
 Wed, 17 Nov 2021 05:51:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzuy+WS2I9iuHslYy9Hi4rOWMhM8OEsEAOKe9vrYb+afy8Hxi3H83w/nDEmht0IvgODlsPAXjZYVq3YZNu0xP8=
X-Received: by 2002:a25:a062:: with SMTP id x89mr17760682ybh.339.1637157076494; 
 Wed, 17 Nov 2021 05:51:16 -0800 (PST)
MIME-Version: 1.0
References: <20211117070708.2174932-1-liwang@redhat.com>
 <87zgq39j2b.fsf@suse.de>
In-Reply-To: <87zgq39j2b.fsf@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Wed, 17 Nov 2021 21:51:04 +0800
Message-ID: <CAEemH2cYn6XmsL+5m20aiadUrqWDwoE_+KQ5pm5rT5p34-Omug@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/3] lib: adding .supported_archs field in
 tst_test structure
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
Content-Type: multipart/mixed; boundary="===============1239113502=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1239113502==
Content-Type: multipart/alternative; boundary="000000000000fc84be05d0fc55ff"

--000000000000fc84be05d0fc55ff
Content-Type: text/plain; charset="UTF-8"

Hi Richard,


> > +const struct tst_arch tst_arch = {
> > +#if defined(__x86_64__)
> > +        .name = "x86_64",
>
> Writing out these string constants multiple times is error
> prone. Perhaps arch_type_list can be indexed with enum tst_arch_type and
> then name can be ".name = arch_type_list[TST_X86]"?
>

Right, that will more flexible but you know, all arches we have are just
those, and we write them only once in the LTP test library.

I slightly wanted to keep string constants to make it more simple/readable.


> > +static const char *const arch_type_list[] = {
> > +     "i386",
> > +     "i586",
> > +     "i686",
>
> These are not valid arch names AFAICT. There is no mapping from these to
> x86 in the tst_arch table above.
>
> Perhaps we could replace them all with x86?
>

Yes, that is also the unsure part I was concerned about in patch v4.
Because x86 is also an invalid arch (it is just a conventional name),
if we use it in the arch_type_list we have to recognize it as a valid arch
name in test case as well. I'm not sure that will be accepted by other
people.

-- 
Regards,
Li Wang

--000000000000fc84be05d0fc55ff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Richard,</div></div><div class=3D"gmail_quote"><div>=C2=A0=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +const struct tst_arch tst_arch =3D {<br>
&gt; +#if defined(__x86_64__)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D &quot;x86_64&quot;,<br>
<br>
Writing out these string constants multiple times is error<br>
prone. Perhaps arch_type_list can be indexed with enum tst_arch_type and<br=
>
then name can be &quot;.name =3D arch_type_list[TST_X86]&quot;?<br></blockq=
uote><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:sm=
all">Right, that will more=C2=A0flexible but you know, all arches we have a=
re just</div><div class=3D"gmail_default" style=3D"font-size:small">those, =
and we write them only once in the LTP test library.</div><div class=3D"gma=
il_default" style=3D"font-size:small"><br></div><div class=3D"gmail_default=
" style=3D"font-size:small">I slightly wanted to keep string constants to m=
ake it more simple/readable.</div></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
&gt; +static const char *const arch_type_list[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;i386&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;i586&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;i686&quot;,<br>
<br>
These are not valid arch names AFAICT. There is no mapping from these to<br=
>
x86 in the tst_arch table above.<br>
<br>
Perhaps we could replace them all with x86?<br></blockquote><div><br></div>=
<div><div class=3D"gmail_default" style=3D"font-size:small">Yes, that is al=
so the unsure part I was concerned about in patch v4.=C2=A0</div><div class=
=3D"gmail_default" style=3D"font-size:small">Because x86 is also an invalid=
 arch (it is just a conventional name),</div><div class=3D"gmail_default" s=
tyle=3D"font-size:small">if we use it in the arch_type_list we have to reco=
gnize it as a valid arch</div><div class=3D"gmail_default" style=3D"font-si=
ze:small">name in test case as well. I&#39;m not sure that will be accepted=
 by other</div></div><div class=3D"gmail_default" style=3D"font-size:small"=
>people.</div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></d=
iv></div></div>

--000000000000fc84be05d0fc55ff--


--===============1239113502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1239113502==--

