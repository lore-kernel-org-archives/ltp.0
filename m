Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FBCC433FE
	for <ltp@archiver.kernel.org>; Thu, 24 Nov 2022 01:37:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 83DB83CCA1A
	for <ltp@archiver.kernel.org>; Thu, 24 Nov 2022 02:37:32 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C90AF3CCA04
 for <ltp@lists.linux.it>; Thu, 24 Nov 2022 02:37:23 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B859E600700
 for <ltp@lists.linux.it>; Thu, 24 Nov 2022 02:37:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669253840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+XreMOl+6b/ZVrk4EuOyyFlkobMBMK924BTYvbSeYfg=;
 b=Py+5/Kg1b367w4JdxFen18SkzFtwC/Q1rVt+fHZNg7+KZdUsI17LG2i7obH0p434QS8CEy
 QJGrSj+mMJAL5NetdOW6b0Z5Ylwf9RWkK1FNbbaRnLIjhuPz/PPl4aEen8jQd2qlnTm4dj
 moT+j2uQ5kAtuW22t3fRHxQ/0mDq5vc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-516-0s0ijOx4NzefcOeD4j7qVg-1; Wed, 23 Nov 2022 20:37:18 -0500
X-MC-Unique: 0s0ijOx4NzefcOeD4j7qVg-1
Received: by mail-wm1-f69.google.com with SMTP id
 h9-20020a1c2109000000b003cfd37aec58so239426wmh.1
 for <ltp@lists.linux.it>; Wed, 23 Nov 2022 17:37:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+XreMOl+6b/ZVrk4EuOyyFlkobMBMK924BTYvbSeYfg=;
 b=PySk36TbmC/t9bu6318Habg3RZ3Het3fCLH1dr7mBbpVj/tXuZquNQMVWdKTKO8tCr
 ZRkhLsMSRny7HukhNj25KN07yZmcOwSIxMdp71wxVEJcZ++uHYKDem7NiNj70slQiIJX
 kVSCXz+r0CihSquc5rztuhNPJN2xAJOQQFwkY4/rOKmDCVsg8r2gDECeRkHaPtg5CIwN
 LgikBuuYmTwcKfHqjlOylUBc8HbgazyIrWNTGborutykBS9OtrZMEq45yGA7s4315lvM
 O7KzViv9RPvJ6UJUHoTPcKmN530VxJDbgsFaoKtRDu9NU3UDedjTEQPJ6uexgUPNUf+j
 IYNQ==
X-Gm-Message-State: ANoB5pnp2yR/Sg/LD/vOsPgET01uyErzwOIcQC9ClJqFR5M/ypKUDY8N
 tXTstPHNuKedCmbHBHlm1TiNYrtkQ5pCwylLw0G1rNS2hhf7niDgaWYfMdZsoPWT1EZxwGlAG5a
 mxEQpIWhArH03iDE9fxS0P35H3bk=
X-Received: by 2002:adf:e8c9:0:b0:22e:33dc:3bf1 with SMTP id
 k9-20020adfe8c9000000b0022e33dc3bf1mr19199740wrn.316.1669253837756; 
 Wed, 23 Nov 2022 17:37:17 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6S+odDHhDhfiV/jjn8tmDxrL28GyQmCORakTRuZySd5KIp4I4OaKv0L8Rr4UNOSPJzkXsnA0W89p332vtgcj4=
X-Received: by 2002:adf:e8c9:0:b0:22e:33dc:3bf1 with SMTP id
 k9-20020adfe8c9000000b0022e33dc3bf1mr19199731wrn.316.1669253837574; Wed, 23
 Nov 2022 17:37:17 -0800 (PST)
MIME-Version: 1.0
References: <20221123115546.786-1-pvorel@suse.cz>
 <CAEemH2f=TTMPYHR8u3Bub4C7zWijf=9Fi1bkjFO1rYgFDdQZsg@mail.gmail.com>
 <20221123183547.6hvdotidxmfjehqg@zlang-mailbox>
In-Reply-To: <20221123183547.6hvdotidxmfjehqg@zlang-mailbox>
From: Li Wang <liwang@redhat.com>
Date: Thu, 24 Nov 2022 09:37:06 +0800
Message-ID: <CAEemH2dmMbP7FumWj1oj0z0BST4+iDBOXc9vN7jt8Zv7Dsvvsg@mail.gmail.com>
To: Zorro Lang <zlang@redhat.com>, Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] Remove fs-bench
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
Cc: ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============2128972291=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============2128972291==
Content-Type: multipart/alternative; boundary="000000000000076d8d05ee2d7242"

--000000000000076d8d05ee2d7242
Content-Type: text/plain; charset="UTF-8"

Zorro Lang <zlang@redhat.com> wrote:

On Wed, Nov 23, 2022 at 08:25:33PM +0800, Li Wang wrote:

>    I rarely touch the FS bench test, cc'ing my fs-colleagues
> >    in case they have some opinions on this.
>
> Hi Li,
>
> Our team never used this case, it's even not recommended in ltp/runtest/*,
> so we didn't notice that either. We have other similar tests, not sure
> what's special in this case. So there's not objection from me, if you'd
> like to remove it as the reason in this patch commit log.
>

Thank you so much for the feedback, Zorro!

@Petr, you got my Acked by:

Acked-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

--000000000000076d8d05ee2d7242
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Zorro Lang &lt;<a href=3D"mailto:zlang@redhat.com">zlang@redh=
at.com</a>&gt; wrote:<br></div><div class=3D"gmail_default" style=3D"font-s=
ize:small"><br></div></div><div class=3D"gmail_quote"><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">On Wed, Nov 23, 2022 at 08:25:33PM +0800, Li W=
ang wrote:=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
&gt;=C2=A0 =C2=A0 I rarely touch the FS bench test, cc&#39;ing my fs-collea=
gues<br>
&gt;=C2=A0 =C2=A0 in case they have some opinions on this.<br>
<br>
Hi Li,<br>
<br>
Our team never used this case, it&#39;s even not recommended in ltp/runtest=
/*,<br>
so we didn&#39;t notice that either. We have other similar tests, not sure<=
br>
what&#39;s special in this case. So there&#39;s not objection from me, if y=
ou&#39;d<br>
like to remove it as the reason in this patch commit log.<br></blockquote><=
div><br></div><div><div class=3D"gmail_default" style=3D"font-size:small">T=
hank you so much for the feedback, Zorro!</div><div class=3D"gmail_default"=
 style=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"=
font-size:small">@Petr, you got my Acked by:</div><div class=3D"gmail_defau=
lt" style=3D"font-size:small"><br></div><div class=3D"gmail_default" style=
=3D"font-size:small">Acked-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.=
com">liwang@redhat.com</a>&gt;</div></div><div class=3D"gmail_default" styl=
e=3D"font-size:small"><br></div></div><div><br></div>-- <br><div dir=3D"ltr=
" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li=
 Wang<br></div></div></div></div>

--000000000000076d8d05ee2d7242--


--===============2128972291==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============2128972291==--

