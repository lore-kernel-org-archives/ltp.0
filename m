Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA12ECDFA1
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 08:42:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8EA013C8FC1
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 10:42:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE6113C04D1
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 10:42:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C813C2005E2
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 10:42:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666600929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=osTBTeTMvNCM8F1vhTMYzhcO2TrW2pIea9aAicMN3zw=;
 b=FFiZU3O8wTqhTHxOnquOZUwUBD/OfQx0gp2InV+FPK199fWmAE6ESWfSLbTT6jdh1ZFdPE
 +7APu0gOY7FWP4fM0tzBQWDZsY++x1xg4/ZY63svjiwCSzmSEve08vA/iIYSOKIdhAD/ZF
 4clt74ZuZgBoWT7MWlD2JzlUT7USEdA=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-103-l9Ejb0XqMlmCtfptFBjWgQ-1; Mon, 24 Oct 2022 04:42:04 -0400
X-MC-Unique: l9Ejb0XqMlmCtfptFBjWgQ-1
Received: by mail-oo1-f71.google.com with SMTP id
 b25-20020a4a9bd9000000b0047679132f18so4341433ook.21
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 01:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=osTBTeTMvNCM8F1vhTMYzhcO2TrW2pIea9aAicMN3zw=;
 b=HhX57CKU0jO5UQWmEZpDjND4dWkGwbNyRutNbWJdudq/YlD3kFRefoDl+6LbyNcHiv
 nZJGI9xpYAdOz23xDHAo4hKhMX69c2hi+Ef/C5g2eYawoz4JH4yy0S+MHWWioepkeXNf
 BMjuzNzSqLaVA9VcvEoWPeRnoCOHxVL/9aKg07s3Im6csSMbJ3E0qa8NGKDAhCwn/udJ
 YoBZjKLM2DOUJBwwkFGfPuTyeZvboKO+gN1EQlLw96upF7iEvDKQPtBixZ4AdT6Alaku
 yDXCCJA8oS7NGRqIGe/p+x4zAH2McST6WOZiToVjBsmF3Z3GejDmGOizWDhqnglKzbAg
 RyyA==
X-Gm-Message-State: ACrzQf2NtGb7sgBXV05TTK+z8kWCmbgq/xrE6fWVea9WkVpqZM81p6LW
 BSySwf+QDdTpN0TOyYCc9F0Y0RfGXTDcrH62bKSIfHRsYVrIKIQKlCmi7wDtXpq1CAonYY5u9c+
 5IawHs4AfLZsHFgccE7aKUoXm3h0=
X-Received: by 2002:a05:6808:1486:b0:355:3cb7:b51 with SMTP id
 e6-20020a056808148600b003553cb70b51mr15670932oiw.19.1666600923271; 
 Mon, 24 Oct 2022 01:42:03 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5/6RHz/LjETKTUgeu2+85jtYDVQ2hl3ISTG7UY39KQ53CInmip/ycY2uMqM7ok8SAUoqX3N1Ow6vCF5cAepzc=
X-Received: by 2002:a05:6808:1486:b0:355:3cb7:b51 with SMTP id
 e6-20020a056808148600b003553cb70b51mr15670923oiw.19.1666600923008; Mon, 24
 Oct 2022 01:42:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221009085745.3239893-1-liwang@redhat.com>
 <20221024024009.3553633-1-liwang@redhat.com>
 <20221024024009.3553633-2-liwang@redhat.com> <87edux1z0l.fsf@suse.de>
In-Reply-To: <87edux1z0l.fsf@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Mon, 24 Oct 2022 16:41:50 +0800
Message-ID: <CAEemH2f_DzmbGE6OHMLr+9RH+xeMb_j46sdt-zKMjtzZifiphQ@mail.gmail.com>
To: rpalethorpe@suse.de
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] setitimer01: rewrite using new API
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
Content-Type: multipart/mixed; boundary="===============1956418163=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1956418163==
Content-Type: multipart/alternative; boundary="000000000000ffa96905ebc3c36d"

--000000000000ffa96905ebc3c36d
Content-Type: text/plain; charset="UTF-8"

Richard Palethorpe <rpalethorpe@suse.de> wrote:

> -/*
> > - * setup() - performs all the ONE TIME setup for this test.
> > - */
> > -void setup(void)
> > -{
> > +             set_setitimer_value(USEC2, USEC2);
> > +             TST_EXP_PASS(sys_setitimer(tc->which, value, ovalue));
> >
> > -     tst_sig(NOFORK, DEF_HANDLER, cleanup);
> > +             if (ovalue->it_value.tv_sec != 0 ||
> ovalue->it_value.tv_usec >= USEC2)
> > +                     tst_brk(TFAIL, "old timer value is not within
> > the expected range");
>
> Maybe we could split testing the return value and ovalue from testing
> the signal is delivered?
>
> When testing the return value and ovalue; a very long timeout can be
> used (which is never hit). When testing the signal a very short one can
> be used.
>
> This way, the test is not racing with the signal and the loop below
> won't be executed much.
>

Very good point. Also, I plan to add the 'it_interval' check to
verify the periodic timer, which will make the functionality test
more complete.

This will be achieved in a separate patch.


>
> In any case LGTM
>
> Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>
>

Thanks for the review.

-- 
Regards,
Li Wang

--000000000000ffa96905ebc3c36d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Richard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@suse.de"=
 target=3D"_blank">rpalethorpe@suse.de</a>&gt; wrote:<br></div></div><div c=
lass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr"><br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
&gt; -/*<br>
&gt; - * setup() - performs all the ONE TIME setup for this test.<br>
&gt; - */<br>
&gt; -void setup(void)<br>
&gt; -{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_setitimer_value(U=
SEC2, USEC2);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TST_EXP_PASS(sys_seti=
timer(tc-&gt;which, value, ovalue));<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0tst_sig(NOFORK, DEF_HANDLER, cleanup);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ovalue-&gt;it_val=
ue.tv_sec !=3D 0 || ovalue-&gt;it_value.tv_usec &gt;=3D USEC2)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0tst_brk(TFAIL, &quot;old timer value is not within<br>
&gt; the expected range&quot;);<br>
<br>
Maybe we could split testing the return value and ovalue from testing<br>
the signal is delivered?<br>
<br>
When testing the return value and ovalue; a very long timeout can be<br>
used (which is never hit). When testing the signal a very short one can<br>
be used.<br>
<br>
This way, the test is not racing with the signal and the loop below<br>
won&#39;t be executed much.<br></blockquote><div><br></div><div><div class=
=3D"gmail_default" style=3D"font-size:small">Very good point. Also, I plan =
to add the &#39;it_interval&#39; check to</div><div class=3D"gmail_default"=
 style=3D"font-size:small">verify the periodic timer, which will make the f=
unctionality test</div><div class=3D"gmail_default" style=3D"font-size:smal=
l">more complete.</div></div><div class=3D"gmail_default" style=3D"font-siz=
e:small"><br></div><div class=3D"gmail_default" style=3D"font-size:small">T=
his will be achieved in a separate patch.</div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
<br>
In any case LGTM<br>
<br>
Reviewed-by: Richard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@suse.com"=
 target=3D"_blank">rpalethorpe@suse.com</a>&gt;<br></blockquote><div><br></=
div><div class=3D"gmail_default" style=3D"font-size:small">Thanks for the r=
eview.</div><div class=3D"gmail_default" style=3D"font-size:small"><br></di=
v></div>-- <br><div dir=3D"ltr"><div dir=3D"ltr"><div>Regards,<br></div><di=
v>Li Wang<br></div></div></div></div>

--000000000000ffa96905ebc3c36d--


--===============1956418163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1956418163==--

