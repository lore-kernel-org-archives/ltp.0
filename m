Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFD3C433F5
	for <ltp@archiver.kernel.org>; Thu, 17 Feb 2022 06:59:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 316273CA0AA
	for <ltp@archiver.kernel.org>; Thu, 17 Feb 2022 07:59:49 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A3FA3C9299
 for <ltp@lists.linux.it>; Thu, 17 Feb 2022 07:59:39 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A988814013B7
 for <ltp@lists.linux.it>; Thu, 17 Feb 2022 07:59:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645081177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RXROvT1B5NJdnIkAjuFZgbq/SvwlCtKJoE+IVeZEgsA=;
 b=GHkp7Dk1QkUeEhHVAuNo7vMu1t9VC/OBnForocAaUADG3N49NGfxFmF+iq+uQReAQ6WwUh
 hYfD3RyfN2UyZcJHlZFkOAqXdrdfzJv4IVsMIiS1TvNbSpvyxsuZ2PdMknozOzrjYq4zo2
 W6YUKvzpgr4zwJYGqWL57BFSlYYyLpo=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-256-XvNhLD-cP5aiwn8FSpfJWw-1; Thu, 17 Feb 2022 01:59:35 -0500
X-MC-Unique: XvNhLD-cP5aiwn8FSpfJWw-1
Received: by mail-yb1-f200.google.com with SMTP id
 b18-20020a25fa12000000b0062412a8200eso2716133ybe.22
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 22:59:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RXROvT1B5NJdnIkAjuFZgbq/SvwlCtKJoE+IVeZEgsA=;
 b=up7ckZLfyKuzHnEbTJdXMVnUaMORdTPOTd65NJReyOXtNKTqnS4IIkwLo++Z0e2K3W
 BhBfIZcyPKECNSLsYL73ETAYaW+948WQ06piuCePDVb4yh4+wAV6jaTYZLtfD7z+qq+o
 C0fZqjErZLAy+G6bBzxKKbyd0+7ok5mm3Xm9qBbpg6kr74QmxmlunYDqdhnhaVac9xH4
 KEIfMFXEKFmVMAn4rC/aM5pvoaEtAQx/nUWWRlmsk3UgYZrEugEEqScj8DtUH/w3Q9Wh
 WNsGAJwiWTHJzAH+E9sQWQ+kyotir95MvS5pVPxNjISwwx/mor9MjWClhjQWj/IkyQBw
 dfkg==
X-Gm-Message-State: AOAM531Ole2CtFvTJAX3QcjMKs9Xb0czAIM+g3wn2tAIt5IGyNdKyVFv
 /I1SAVfAd1PEhxTRLY2JX/iTmXoBRm5oKd+wBD4tNDNqj8m0Mb2ygBe5WctyQ9XBVzUN54POiEH
 kvVI+L/JkIkV/RwYK3EhvNmL8C+A=
X-Received: by 2002:a81:1416:0:b0:2d6:83d3:6e1a with SMTP id
 22-20020a811416000000b002d683d36e1amr1418829ywu.370.1645081174995; 
 Wed, 16 Feb 2022 22:59:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxxKU7Kp7pynMDWFLCRrki3RmR3aHR4S1X4L3aaXi2CvINSIA7392peYlzV1rhzUiJ9Sk28ikiGq+3CVCMkYU0=
X-Received: by 2002:a81:1416:0:b0:2d6:83d3:6e1a with SMTP id
 22-20020a811416000000b002d683d36e1amr1418819ywu.370.1645081174783; Wed, 16
 Feb 2022 22:59:34 -0800 (PST)
MIME-Version: 1.0
References: <20220208132414.2852202-1-liwang@redhat.com>
 <20220209085213.2882229-1-liwang@redhat.com> <YgzJwTxk7Lnf7uG+@rei>
In-Reply-To: <YgzJwTxk7Lnf7uG+@rei>
From: Li Wang <liwang@redhat.com>
Date: Thu, 17 Feb 2022 14:59:19 +0800
Message-ID: <CAEemH2dd0Ctejvx2bZvHVWHd4Q=3y1sguoq=-CLCZvTYZafEeQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] getrusage03: mlock all address space for
 process calling consume_mb
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
Content-Type: multipart/mixed; boundary="===============0801094870=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0801094870==
Content-Type: multipart/alternative; boundary="0000000000000ccfec05d8314fc5"

--0000000000000ccfec05d8314fc5
Content-Type: text/plain; charset="UTF-8"

On Wed, Feb 16, 2022 at 5:54 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > --- a/testcases/kernel/syscalls/getrusage/getrusage03.c
> > +++ b/testcases/kernel/syscalls/getrusage/getrusage03.c
> > @@ -193,4 +193,8 @@ static struct tst_test test = {
> >       .setup = setup,
> >       .test = run,
> >       .tcnt = ARRAY_SIZE(testfunc_list),
> > +     .caps = (struct tst_cap []) {
> > +             TST_CAP(TST_CAP_REQ, CAP_IPC_LOCK),
> > +             {}
> > +     },
> >  };
>
> I wonder if we should start to track the capabilities like this instead
> of the .needs_root approach. I guess that it may be useful to keep
> things granular in the future.
>

I think yes, Linux Capabilities makes it possible for specific privileges to
the test process, and avoid that .needs_root limited many tests scenario
to skip directly with non-root users. Especially beneficial for running LTP
in the docker with only part of root privileges for reasons like strict
security
verification.

-- 
Regards,
Li Wang

--0000000000000ccfec05d8314fc5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, Feb 16, 2022 at 5:54 PM Cyril Hrubis &lt;<a=
 href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt; --- a/testcases/kernel/syscalls/getrusage/getrusage03.c<br>
&gt; +++ b/testcases/kernel/syscalls/getrusage/getrusage03.c<br>
&gt; @@ -193,4 +193,8 @@ static struct tst_test test =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.setup =3D setup,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.test =3D run,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.tcnt =3D ARRAY_SIZE(testfunc_list),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.caps =3D (struct tst_cap []) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TST_CAP(TST_CAP_REQ, =
CAP_IPC_LOCK),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0},<br>
&gt;=C2=A0 };<br>
<br>
I wonder if we should start to track the capabilities like this instead<br>
of the .needs_root approach. I guess that it may be useful to keep<br>
things granular in the future.<br></blockquote><div><br></div>I think yes, =
Linux Capabilities makes it possible for specific privileges<span class=3D"=
gmail_default" style=3D"font-size:small"> to</span></div><div class=3D"gmai=
l_quote">the test process, and avoid <span class=3D"gmail_default" style=3D=
"font-size:small">that </span>.needs_root limited many tests scenario</div>=
<div class=3D"gmail_quote"><div class=3D"gmail_default" style=3D"font-size:=
small">to skip directly with non-root users. Especially beneficial for runn=
ing LTP</div><div class=3D"gmail_default" style=3D"font-size:small">in the =
docker with only part of root privileges for reasons like strict security</=
div><div class=3D"gmail_default" style=3D"font-size:small">verification.</d=
iv></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><=
div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></=
div>

--0000000000000ccfec05d8314fc5--


--===============0801094870==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0801094870==--

