Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 572FDC433EF
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 10:09:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 06D483C9AE6
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 11:09:17 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C0BA63C094C
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 11:09:07 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 654D7600769
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 11:09:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644228544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sU0yP19DV4BX1n/n8tg6h0p9u9wOnq8gTtisxVq1jd0=;
 b=GxZm79uOMDGccr9mEEqoEiQf9GPlfvbNziZGtS7tTRNo7JgG6rO8+i4gkKjM7PBnhuOUaN
 x5hRStzFsZVm+52EkEEECNWYtsg9tn9bX3vHi8xqLUcKahbpOvCwTCxY5RkQCoXdIc5MEm
 oEcJKmeMp2ZnxEUaQX7ItXoDEs5Q/yU=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-k6g5YpJMPMOeufaIDgSAkQ-1; Mon, 07 Feb 2022 05:09:01 -0500
X-MC-Unique: k6g5YpJMPMOeufaIDgSAkQ-1
Received: by mail-yb1-f198.google.com with SMTP id
 u185-20020a2560c2000000b0060fd98540f7so27523615ybb.0
 for <ltp@lists.linux.it>; Mon, 07 Feb 2022 02:09:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sU0yP19DV4BX1n/n8tg6h0p9u9wOnq8gTtisxVq1jd0=;
 b=747EcupOpnlZ3IFvhCiErr4Zt6nh5MZ0l1Bm7fNyVyyCefuHMbDMteFfLkZ8L1pTzw
 zQzLsfyDJuXB30z2/mjK4ltyDz5kwWeg0Z/21bZ6HwrJIxKrxLFjBmXSE7eFTwJDRVkW
 NxjvqXTiO+cpGDvlkOINLnaafLhaYqGKfTgI6x10L3qASwbb9/M1u+cyMVFFKdtO0f+y
 sGZLEwQNWH9/edveFDfJl3v5DRq7BF76jhe2MA+SYF8YXs7YYujbLfJRtxzTmVKvlqqI
 iM+w8OcBHCzdw1HNcBOJUsdP1x4DAh1OJ+EUU5ExWACwvwSw07lQsE3b1b+ajZ84dk+C
 rRkg==
X-Gm-Message-State: AOAM533oYhG4ymW2kaxRzW+q4k7F3yEitxnQmdJn7igypexUi88Mqj+q
 aUPoIexeeOlDVQhYT2O3oFvGQi0hEpioFZFFR2D3HT2D8ivPy2qQZ6Pk6YHwjTcYOMbum8egE1a
 mXOQw1xI1zGSBbYOLTTckvUYNEIw=
X-Received: by 2002:a81:ae0c:: with SMTP id m12mr3974524ywh.19.1644228540984; 
 Mon, 07 Feb 2022 02:09:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy4MkGv3XQ1z8efcReHagLdz/MDol60m0Klh6gXsarXwN3LFKNt1wK/dfL12DPHZHOBihXbVtgZ3jf+qBmLyVo=
X-Received: by 2002:a81:ae0c:: with SMTP id m12mr3974509ywh.19.1644228540734; 
 Mon, 07 Feb 2022 02:09:00 -0800 (PST)
MIME-Version: 1.0
References: <20220207040447.2803113-1-liwang@redhat.com>
 <YgDNB9v0x82mExVE@pevik>
In-Reply-To: <YgDNB9v0x82mExVE@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 7 Feb 2022 18:08:47 +0800
Message-ID: <CAEemH2fY-Om6z3WJzJ2X80x1H6DUG4Ec6sbWych1gfnT1C81EA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getrusage03: skip on small RAM system
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
Content-Type: multipart/mixed; boundary="===============0730566491=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0730566491==
Content-Type: multipart/alternative; boundary="00000000000019b3a105d76acaff"

--00000000000019b3a105d76acaff
Content-Type: text/plain; charset="UTF-8"

On Mon, Feb 7, 2022 at 3:41 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Li,
>
> > Notes:
> >     Ps. I also think we might need .min_mem_[avai|total] field but
> >         not sure if it is really necessary to add that.
> Is it just a single test? Than maybe not worth of it, but generally I'm for
>

By now I only see sporadic tests have this requirement.
(hugeshmat04.c, swapping01.c, getrusage03.c)

> adding tags like this into the library - it encapsulates code and gives us
> a
> documentation in docparse.
>

Agree, maybe just holding as a future plan for adding that.



> ...
> > +static void setup(void)
> > +{
> > +     long long mem_avail = tst_available_mem();
> > +
> > +     if (mem_avail < 512L*1024)
> > +             tst_brk(TCONF, "Needed > 512MB availabe, only have: %ld
> kB", mem_avail);
> typo: s/availabe/available/
>

Thanks.



>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Thanks!
>
> Kind regards,
> Petr
>
>

-- 
Regards,
Li Wang

--00000000000019b3a105d76acaff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Feb 7, 2022 at 3:41 PM Petr Vorel &lt;<a hr=
ef=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">Hi Li,<br>
<br>
&gt; Notes:<br>
&gt;=C2=A0 =C2=A0 =C2=A0Ps. I also think we might need .min_mem_[avai|total=
] field but<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0not sure if it is really necessary to=
 add that.<br>
Is it just a single test? Than maybe not worth of it, but generally I&#39;m=
 for<br></blockquote><div><br></div><div class=3D"gmail_default" style=3D"f=
ont-size:small">By now I only see=C2=A0sporadic tests have this requirement=
.</div><div class=3D"gmail_default" style=3D"font-size:small">(hugeshmat04.=
c, swapping01.c, getrusage03.c)</div><div class=3D"gmail_default" style=3D"=
font-size:small"></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
adding tags like this into the library - it encapsulates code and gives us =
a<br>
documentation in docparse.<br></blockquote><div><br></div><div class=3D"gma=
il_default" style=3D"font-size:small">Agree, maybe just holding as a future=
 plan for adding that.</div><div class=3D"gmail_default" style=3D"font-size=
:small"><br></div><div class=3D"gmail_default" style=3D"font-size:small"><b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
...<br>
&gt; +static void setup(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0long long mem_avail =3D tst_available_mem();<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (mem_avail &lt; 512L*1024)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brk(TCONF, &quot;=
Needed &gt; 512MB availabe, only have: %ld kB&quot;, mem_avail);<br>
typo: s/availabe/available/<br></blockquote><div><br></div><div><div class=
=3D"gmail_default" style=3D"font-size:small">Thanks.</div><br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Reviewed-by: Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz" target=3D"_bl=
ank">pvorel@suse.cz</a>&gt;<br>
<br>
Thanks!<br>
<br>
Kind regards,<br>
Petr<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--00000000000019b3a105d76acaff--


--===============0730566491==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0730566491==--

