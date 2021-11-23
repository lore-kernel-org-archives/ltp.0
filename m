Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3787EC433F5
	for <ltp@archiver.kernel.org>; Tue, 23 Nov 2021 04:13:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D5093C8E35
	for <ltp@archiver.kernel.org>; Tue, 23 Nov 2021 05:13:33 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B0BBC3C25EC
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 05:13:23 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.151.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 00BFD10007DA
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 05:13:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637640800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kT1DcW3cgpL0k32L8TNgsISCl6EsofWLdzJ5fjYsLio=;
 b=JLvk5aC3uXcDe5n+t8IyRfvNsllc83MipwVYPrQF2IZTzFg/+Fi0zpyaB8pvLleeWm9drq
 dAoGu/e9jQbuVqV76j3Y5a343gXD8oBHgiFw5tV80VBnaKZ0u+OMywNk7iU/l0UaomJSM8
 PTBKea1FeMPgZsTqYUOLlddnDT8dHx0=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-2-yNInh90gMkuUBomPlXaQzw-1; Mon, 22 Nov 2021 23:13:17 -0500
X-MC-Unique: yNInh90gMkuUBomPlXaQzw-1
Received: by mail-yb1-f197.google.com with SMTP id
 x16-20020a25b910000000b005b6b7f2f91cso31725923ybj.1
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 20:13:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kT1DcW3cgpL0k32L8TNgsISCl6EsofWLdzJ5fjYsLio=;
 b=aq8qyqZoTgGQK9GzMseJ1W9aXPB/E+LivjOZwuXKjzFNmtnd0dmnS7re8rDDULxQzf
 43TuEW0C3kCX/HvuzMXnNviBmVKfhy9h+j4j20nUtijh9FwUGbSOorbdHkxE5mkloz+r
 gtIwZ0yAlpsyw9o587JcTA/ZpGedOV7HVpoEMrL7UHuEJeujiyrJRUmVRNrVhSl9Jp1m
 usq1LD5y9nA18pG3+je+Dq2XvZyS/HCHmKZaPEkgTBEwDBzvJHj+eQ0A/w82FnyoLQtN
 pabSnsgISFRn+goxXiAoTqtD2O8PWs9NIdOUc+9IDhla7qg2QSjKX+Rc6LZhu4QSDhUW
 LziA==
X-Gm-Message-State: AOAM531HXwUzkE3mQ0H++y7jr2kveuxYz5N6L15t/kihflwWKCUwgae6
 +Xgpb3kQfA4Iyh+jKRYQqwdgDTOxp8elm8Is5lzq9hWx9RBQu7mZxhP0OvP2ieXkq75IotVNfOK
 TxnMh7Y6NlurvF9TgXUHJtBj1DQY=
X-Received: by 2002:a25:82:: with SMTP id 124mr2770603yba.490.1637640797310;
 Mon, 22 Nov 2021 20:13:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzmTb/tX5u2/Kbdf+0ulE7s2kZXWVeHWISViUuNEYVdMa1dxXd8Za9XuHU+OcwGcIMPNnNmcxKgdpSePcPxpRc=
X-Received: by 2002:a25:82:: with SMTP id 124mr2770536yba.490.1637640796630;
 Mon, 22 Nov 2021 20:13:16 -0800 (PST)
MIME-Version: 1.0
References: <20211117070708.2174932-1-liwang@redhat.com>
 <77e0b8b9-5de6-73ab-0f73-e3d95bad0935@jv-coder.de>
 <YZZCAXWRcrsYJo9+@yuki>
 <CAEemH2ehTUoDTqa21vKDvC4vQuTPBM1j23Dqa=FFEJjcPLsvvQ@mail.gmail.com>
 <87bl2cmhuw.fsf@suse.de> <YZungO1QrUR+xbSC@yuki>
In-Reply-To: <YZungO1QrUR+xbSC@yuki>
From: Li Wang <liwang@redhat.com>
Date: Tue, 23 Nov 2021 12:13:03 +0800
Message-ID: <CAEemH2cZ-KmpaNiO8AOy19D=yUyUYW9EXKOt-fdwW0a6h-Ewuw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
Content-Type: multipart/mixed; boundary="===============0599867482=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0599867482==
Content-Type: multipart/alternative; boundary="000000000000f4046c05d16cf574"

--000000000000f4046c05d16cf574
Content-Type: text/plain; charset="UTF-8"

Hi All,

On Mon, Nov 22, 2021 at 10:20 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > I still don't understand how tst_arch.name is mapped to i386, i586 or
> > i686?
> >
> > It appears that we will always get TCONF on any of these architectures
> > because tst_arch.name will be set to x86 and the required arch will be
> > i386, i586 or i686.
>

You are right, I neglected that point, anyway, let's switch to x86 in all.


>
> Can we please have single name for 32bit intel i.e. "x86" please?
>

Ok, sure.


Same here, the rest looks good.
>

Thank you all for the reviews.

I made changes by using the single name "x86" and pushed it.

-- 
Regards,
Li Wang

--000000000000f4046c05d16cf574
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi All,</div></div><br><div class=3D"gmail_quote"><div dir=3D=
"ltr" class=3D"gmail_attr">On Mon, Nov 22, 2021 at 10:20 PM Cyril Hrubis &l=
t;<a href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt; I still don&#39;t understand how <a href=3D"http://tst_arch.name" rel=
=3D"noreferrer" target=3D"_blank">tst_arch.name</a> is mapped to i386, i586=
 or<br>
&gt; i686?<br>
&gt; <br>
&gt; It appears that we will always get TCONF on any of these architectures=
<br>
&gt; because <a href=3D"http://tst_arch.name" rel=3D"noreferrer" target=3D"=
_blank">tst_arch.name</a> will be set to x86 and the required arch will be<=
br>
&gt; i386, i586 or i686.<br></blockquote><div><br></div><div><div class=3D"=
gmail_default" style=3D"font-size:small">You are right, I neglected that po=
int, anyway, let&#39;s switch to x86 in all.</div></div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Can we please have single name for 32bit intel i.e. &quot;x86&quot; please?=
<br></blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"=
font-size:small">Ok, sure.</div><br></div><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
Same here, the rest looks good.<br></blockquote><div><br></div><div><div cl=
ass=3D"gmail_default" style=3D"font-size:small">Thank you all for the revie=
ws.</div><div class=3D"gmail_default" style=3D"font-size:small"><br></div><=
div class=3D"gmail_default" style=3D"font-size:small">I made changes by usi=
ng the single name &quot;x86&quot; and pushed it.</div></div><div><br></div=
></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><=
div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000f4046c05d16cf574--


--===============0599867482==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0599867482==--

