Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 580BFC433FE
	for <ltp@archiver.kernel.org>; Wed,  9 Mar 2022 02:28:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A6393C5AD0
	for <ltp@archiver.kernel.org>; Wed,  9 Mar 2022 03:28:21 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E6A7C3C54E6
 for <ltp@lists.linux.it>; Wed,  9 Mar 2022 03:28:10 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 510AB1000DE4
 for <ltp@lists.linux.it>; Wed,  9 Mar 2022 03:28:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646792887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RB+8unI2EIiVrWi3PNOuDjIbDbLkyLI0dmATGmZKuEk=;
 b=Z0kmRMTYsKgZ8tQXsHloZhSbHmXdzkkLJ33fAhC8M1qwbJ/UII+0fEdPNV7G7WGLoi7sRX
 NWpy7uv+M/FVG0JCpJ3/Yx/M1PLv4b3Opsq25zHFOEAKaWtnx1NngTGK2vBkhPbgiy4uYm
 RkMqLT8ea5EWosDZkQvG1Rbib6pAb1o=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-i7PZosRoNpq-gbyq8CC7qQ-1; Tue, 08 Mar 2022 21:28:06 -0500
X-MC-Unique: i7PZosRoNpq-gbyq8CC7qQ-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-2d61f6c1877so6148437b3.15
 for <ltp@lists.linux.it>; Tue, 08 Mar 2022 18:28:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RB+8unI2EIiVrWi3PNOuDjIbDbLkyLI0dmATGmZKuEk=;
 b=tOVEsxjP8ePOynHczEtioD5UZr6TbztmCf+2q6Nb3stb8+1sudbM4LDAhO1dD1cow9
 6N76e1WXHICEQCrd7or/C+I1kFIyW+gYwKLmccZtVMncuVusdEacg3dyqyEjvhPhFWJr
 qNRQTBo3sXYQ1HHUV23XwEqJszlNvx9vP2IGC6vInACLvyRELiyo6714eANRr1FbubMm
 oyZWwR/lURtH2K+n3sAblqhhTxon95oWJ3xRlAGXqb/oZ0yf9Ze1MlMjuGO0Hmpk4Pcc
 RCiYoqEN129KoolRm6+lPO0gwICdGpBEp1h616Dh/ydzy/2Pi5GuffrGdjYEU15ppR1+
 p9CQ==
X-Gm-Message-State: AOAM531XONf6VvF3szEwbwR4YgqJIdv061ftCMVaMitNU6jdDHw1fj8r
 9F4+kuuxDK91cnW3YlFQr0YggayhjkbRxtSzrHHsACMlm21gVkHNA9SMQk/XcY/HMeKga5GpJc2
 80o0g2/X7H4HlsOnc9hQnJwE/ZEQ=
X-Received: by 2002:a81:9a42:0:b0:2dc:2bf4:204 with SMTP id
 r63-20020a819a42000000b002dc2bf40204mr15361551ywg.170.1646792885789; 
 Tue, 08 Mar 2022 18:28:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw9VQvRuMplTWFFJ8mG5qOILWER5D7hcFp2GRPQZx0R34UhlJHjRL175O/eBkMHbc2c8/sZh4xcDsHvV67D3as=
X-Received: by 2002:a81:9a42:0:b0:2dc:2bf4:204 with SMTP id
 r63-20020a819a42000000b002dc2bf40204mr15361539ywg.170.1646792885504; Tue, 08
 Mar 2022 18:28:05 -0800 (PST)
MIME-Version: 1.0
References: <20220308073709.4125677-1-liwang@redhat.com>
 <20220308073709.4125677-3-liwang@redhat.com>
 <YidT0piJ3+e9FvhE@yuki>
In-Reply-To: <YidT0piJ3+e9FvhE@yuki>
From: Li Wang <liwang@redhat.com>
Date: Wed, 9 Mar 2022 10:27:52 +0800
Message-ID: <CAEemH2eDvVeSGHrcOqqcPXq64neP2CF1yYcZEA86v4CaxQ=VjA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/4] lib: enhance .save_restore to support set
 expected value
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
Cc: Bruno Goncalves <bgoncalv@redhat.com>, ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============0393025485=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0393025485==
Content-Type: multipart/alternative; boundary="000000000000f5a87005d9bfd809"

--000000000000f5a87005d9bfd809
Content-Type: text/plain; charset="UTF-8"

Cyril Hrubis <chrubis@suse.cz> wrote:


> > diff --git a/lib/tst_test.c b/lib/tst_test.c
> > index 9e745c537..fe2e2bb6c 100644
> > --- a/lib/tst_test.c
> > +++ b/lib/tst_test.c
> > @@ -1105,11 +1105,12 @@ static void do_setup(int argc, char *argv[])
> >               tst_tmpdir();
> >
> >       if (tst_test->save_restore) {
> > -             const char * const *name = tst_test->save_restore;
> > +             const struct tst_path_val const *pvl =
> tst_test->save_restore;
> >
> > -             while (*name) {
> > -                     tst_sys_conf_save(*name);
> > -                     name++;
> > +             while (pvl->path) {
> > +                     if (!tst_sys_conf_save(pvl->path))
> > +                             tst_sys_conf_set(pvl->path, pvl->val);
>
> Maybe it would be cleaner if we added tst_sys_conf_save_set() function
> instead of tst_sys_conf_set() that would do both, saved the value and
> set new one if non-NULL.
>

Yes, it can be. Actually, I started writing like that at the beginning.

But I feel that tst_sys_conf_save_set() looks a bit longer and does more
things. To split the set into a separate function is to respect the UNIX
design
philosophy (one function does one thing). Another important reason
is to export tst_sys_conf_set() to global use instead of low-level macros
for knob settings.

The rest suggestions sound good to me, thanks for reviewing!

-- 
Regards,
Li Wang

--000000000000f5a87005d9bfd809
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz">chrubis@s=
use.cz</a>&gt; wrote:<br></div></div><div class=3D"gmail_quote"><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; diff --git a/lib/tst_test.c b/lib/tst_test.c<br>
&gt; index 9e745c537..fe2e2bb6c 100644<br>
&gt; --- a/lib/tst_test.c<br>
&gt; +++ b/lib/tst_test.c<br>
&gt; @@ -1105,11 +1105,12 @@ static void do_setup(int argc, char *argv[])<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_tmpdir();<br=
>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (tst_test-&gt;save_restore) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char * const *n=
ame =3D tst_test-&gt;save_restore;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct tst_path=
_val const *pvl =3D tst_test-&gt;save_restore;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (*name) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0tst_sys_conf_save(*name);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0name++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (pvl-&gt;path) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (!tst_sys_conf_save(pvl-&gt;path))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_sys_conf_set(pvl-&gt;path, pvl-&gt;v=
al);<br>
<br>
Maybe it would be cleaner if we added tst_sys_conf_save_set() function<br>
instead of tst_sys_conf_set() that would do both, saved the value and<br>
set new one if non-NULL.<br></blockquote><div><br></div><div class=3D"gmail=
_default" style=3D"font-size:small">Yes, it can be. Actually, I started wri=
ting like that at the beginning.</div><div class=3D"gmail_default" style=3D=
"font-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size=
:small">But I feel that tst_sys_conf_save_set() looks a bit longer and does=
 more</div><div class=3D"gmail_default" style=3D"font-size:small">things. T=
o split the set into a separate function is to respect the UNIX design</div=
><div class=3D"gmail_default" style=3D"font-size:small">philosophy (one fun=
ction does one thing). Another=C2=A0important reason=C2=A0</div><div class=
=3D"gmail_default" style=3D"font-size:small">is to export tst_sys_conf_set(=
) to global use instead of low-level macros</div><div class=3D"gmail_defaul=
t" style=3D"font-size:small">for knob settings.</div><div class=3D"gmail_de=
fault" style=3D"font-size:small"><br></div><div class=3D"gmail_default" sty=
le=3D"font-size:small">The rest suggestions sound good to me, thanks for re=
viewing!</div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></d=
iv></div></div>

--000000000000f5a87005d9bfd809--


--===============0393025485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0393025485==--

