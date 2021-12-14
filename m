Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA92C433EF
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 09:05:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D9A0D3C8C37
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 10:05:11 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 657083C2FF6
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 10:05:00 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9EAAF14013A4
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 10:04:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639472698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SvGGTAAOEoRJbaAy5QK/FDs94X3xeTGpwzpiGG1P1TA=;
 b=NMPpToV9QRkvSUvwfErx1TUtA3PNR4Ry1jd1y2qJ8Yz23OaEywOLU7eZLFAlvUaqNrsNWE
 nU6tSUQw704mKxtHjWeAlgobowY9Za/8u4UxrcYDAD9kHfBKUI52PWBJo2u3izjC3sHDVx
 6k+x6EuBSPlcQuXQX+10W1ThC5yo6Rs=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-9otNz1DOO0WyINZn1COJkg-1; Tue, 14 Dec 2021 04:04:53 -0500
X-MC-Unique: 9otNz1DOO0WyINZn1COJkg-1
Received: by mail-yb1-f199.google.com with SMTP id
 q198-20020a25d9cf000000b005f7a6a84f9fso35056231ybg.6
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 01:04:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SvGGTAAOEoRJbaAy5QK/FDs94X3xeTGpwzpiGG1P1TA=;
 b=5RaRx/WKF4f3QnXeShTL5FiMUSIo2f3muTkeGb+FiIOl/47qOhEVc93qeHWf+UL5T+
 b3Mzx98SgUdzyAbw8KhmStO2Q7TJfaRgdT9s2eupbqCYwR94dOjmGHOLJX0lE5Dv2OJP
 IrItVQ2lIMAw4koPMzIs/i+8GjBetIvtFMJAS1aQx/7jKInY837Dpy+cUKIrJykuBGcB
 qo0rTMiF946ZxKkzntmtVgBvdq1c3mw7T6vNACQ9egQN18XIfgRC14btdMN9bZ8K04vp
 JyKC60gHfNMNknDaBoCpbmK/7W0NeVG9359cdLXoHkUpDLYDcn4uXmuTlbJojiS19OnW
 R1fQ==
X-Gm-Message-State: AOAM5325YkSITyjtb8EKM/kJ+ndCpdf2Mkja0Uq/MLipX6EI8HHrpyl5
 TbyZs8SCsSCtOyxMMy6qIctBDkXTq2rHIJchBFPOMXDS/aHo8lBE0tEA7y5S/ZOJF6p9GMkzdIq
 WhT+RbrnhYRGE0Pk69Sc03ZRiS3k=
X-Received: by 2002:a05:6902:4f4:: with SMTP id
 w20mr4534274ybs.421.1639472693169; 
 Tue, 14 Dec 2021 01:04:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzRL4gjcENzkR3hwAG5X9dnUvIuOjlUwi0fEFJ8kg6rqElpCt7Rw8QSB9wENt1m2wGW1m778NSrX1cVHGtnbZU=
X-Received: by 2002:a05:6902:4f4:: with SMTP id
 w20mr4534245ybs.421.1639472692910; 
 Tue, 14 Dec 2021 01:04:52 -0800 (PST)
MIME-Version: 1.0
References: <20211213193419.13414-1-pvorel@suse.cz>
 <CAEemH2dp55yFvaXhq_5e77k6QBnY0aFU5fhz4TjW82bkbwwDiA@mail.gmail.com>
 <YbhV9VIv/8o97O6r@pevik>
In-Reply-To: <YbhV9VIv/8o97O6r@pevik>
From: Li Wang <liwang@redhat.com>
Date: Tue, 14 Dec 2021 17:04:39 +0800
Message-ID: <CAEemH2c0pRRRvLVgFwD1kWRRGWSimiN1qjbhQN=T2OpxYpmJuA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lib: Add support for debugging
 .all_filesystems
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
Content-Type: multipart/mixed; boundary="===============1203896405=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1203896405==
Content-Type: multipart/alternative; boundary="0000000000007aeea405d3177b1e"

--0000000000007aeea405d3177b1e
Content-Type: text/plain; charset="UTF-8"

On Tue, Dec 14, 2021 at 4:29 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Li,
>
> > On Tue, Dec 14, 2021 at 3:34 AM Petr Vorel <pvorel@suse.cz> wrote:
>
> > > LTP_ALL_FILESYSTEMS_ONLY_FS_TYPE environment variable tests only that
> > > filesystem instead of all supported filesystems.
>
> ...
> > > +++ b/doc/user-guide.txt
> ...
> > > 'TST_NEEDS_DEVICE=1').
> > > +| 'LTP_ALL_FILESYSTEMS_ONLY_FS_TYPE' | Testing only specified
> filesystem
> > > instead all
> > > +                          supported (for tests with
> '.all_filesystems').
>
> > My only concern is that the variable name is too long and not easy
> > to remember/understand usage. Can we find a better name?
> >     LTP_ONE_FS_TYPE
> >     LTP_ASGD_FD_TYPE
> >     LTP_FS_TYPE_DEBUG
> Yes, it's too long. LTP_FS_TYPE_DEBUG sounds best to me, but no strong
> opinion
> about it.
>
> If we agree we want this, we can consider to use some switch instead or
> print
> this variable in help output (-h), with other variables from
> https://github.com/linux-test-project/ltp/wiki/User-Guidelines.
>

Yes for sure, I agree to add this for debugging, since skip_filesystem is
not very convenient to some degree.



>
> > or some else.
>
> > P.s.
> > And btw I often use .skip_filesystems skip other FS for debugging :).
> I do use it as well, but it's I wanted to have way to debug single
> filesystem
> without having to recompile (easier on embedded or non-intel platforms run
> via
> some frameworks).
>

Indeed.

>
> Kind regards,
> Petr
>
>

-- 
Regards,
Li Wang

--0000000000007aeea405d3177b1e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Dec 14, 2021 at 4:29 PM Petr Vorel &lt;<a h=
ref=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">Hi Li,<br>
<br>
&gt; On Tue, Dec 14, 2021 at 3:34 AM Petr Vorel &lt;<a href=3D"mailto:pvore=
l@suse.cz" target=3D"_blank">pvorel@suse.cz</a>&gt; wrote:<br>
<br>
&gt; &gt; LTP_ALL_FILESYSTEMS_ONLY_FS_TYPE environment variable tests only =
that<br>
&gt; &gt; filesystem instead of all supported filesystems.<br>
<br>
...<br>
&gt; &gt; +++ b/doc/user-guide.txt<br>
...<br>
&gt; &gt; &#39;TST_NEEDS_DEVICE=3D1&#39;).<br>
&gt; &gt; +| &#39;LTP_ALL_FILESYSTEMS_ONLY_FS_TYPE&#39; | Testing only spec=
ified filesystem<br>
&gt; &gt; instead all<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 supported (for tests with &#39;.all_filesystems=
&#39;).<br>
<br>
&gt; My only concern is that the variable name is too long and not easy<br>
&gt; to remember/understand usage. Can we find a better name?<br>
&gt;=C2=A0 =C2=A0 =C2=A0LTP_ONE_FS_TYPE<br>
&gt;=C2=A0 =C2=A0 =C2=A0LTP_ASGD_FD_TYPE<br>
&gt;=C2=A0 =C2=A0 =C2=A0LTP_FS_TYPE_DEBUG<br>
Yes, it&#39;s too long. LTP_FS_TYPE_DEBUG sounds best to me, but no strong =
opinion<br>
about it.<br>
<br>
If we agree we want this, we can consider to use some switch instead or pri=
nt<br>
this variable in help output (-h), with other variables from<br>
<a href=3D"https://github.com/linux-test-project/ltp/wiki/User-Guidelines" =
rel=3D"noreferrer" target=3D"_blank">https://github.com/linux-test-project/=
ltp/wiki/User-Guidelines</a>.<br></blockquote><div><br></div><div><div clas=
s=3D"gmail_default" style=3D"font-size:small">Yes for sure, I agree to add =
this for debugging, since skip_filesystem is</div><div class=3D"gmail_defau=
lt" style=3D"font-size:small">not very convenient to some degree.</div><br>=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; or some else.<br>
<br>
&gt; P.s.<br>
&gt; And btw I often use .skip_filesystems skip other FS for debugging :).<=
br>
I do use it as well, but it&#39;s I wanted to have way to debug single file=
system<br>
without having to recompile (easier on embedded or non-intel platforms run =
via<br>
some frameworks).<br></blockquote><div><br></div><div class=3D"gmail_defaul=
t" style=3D"font-size:small">Indeed.</div><div class=3D"gmail_default" styl=
e=3D"font-size:small"></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
<br>
Kind regards,<br>
Petr<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--0000000000007aeea405d3177b1e--


--===============1203896405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1203896405==--

