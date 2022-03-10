Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67BEC433F5
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 08:58:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ABD023C1FE9
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 09:58:44 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2B4B73C010B
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 09:58:32 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0CC64200D2E
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 09:58:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646902710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S0ngDcitqUCC1Rquv8l0JYKhxgPABp54eUb+hSNNBmc=;
 b=h6iS5btV8Y6zX5LVX/RiQjvRCyS9QEjKWeMR0yv9N5XaqrVgVhvuIMIQDEd4wlqobLiDmT
 YX3H4QMZE9CPjwEc/Q2mNRIP7u3EP4kAbeQx3mYWzNBkVXqXYBE41zAMcqDLHcpIYyFsCs
 Na2xGkIEWEF3IqeUbGPF0pfjt+wsu0s=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-Wli6qVuGNiiu6-outKRzSg-1; Thu, 10 Mar 2022 03:58:28 -0500
X-MC-Unique: Wli6qVuGNiiu6-outKRzSg-1
Received: by mail-yb1-f198.google.com with SMTP id
 j5-20020a056902020500b00628ab64be30so3872690ybs.16
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 00:58:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=S0ngDcitqUCC1Rquv8l0JYKhxgPABp54eUb+hSNNBmc=;
 b=G5LxYDrzZClRh6h+xRr0klpZlR/h8Qxdg9FJZIA85L1xf3oLMWJh78PHx4JZWw+4Jz
 LWGHgh9arHaSBr24KBXCYzDPTxZ0MZMXz9FNakIb7IzCpY7eO5hk85xp5TzNP9KXYjp5
 z6NbGe8aZkUsppzJ8exeCaKhCyLkCjWqFSTcox++uyV1N6A3qkjupzm7hFEQAb3XlkeO
 pj/PVYGA3wOlLaKXLht2aLhASUlH6LnHLqsKBg9tTWWGwev/quY/OkkW4e4/IvB2EUof
 xphso6VkIfET85cLo4iVOqcJMPHRNKrYSVuP5Ag/jaKKzCu92SurFflBPKBTTMuDiTzF
 iyMg==
X-Gm-Message-State: AOAM533ER5kM9NCupgEY+y+sFRF9ag5zpTy8muxBpSpbCbdAj8Rj4b6E
 VlKE8OefuTyaGpe6JINx4PIgorsDW9DApp6mnxDwU5taPWqf/8pH69NChtuAn6R9EWAvBXSBf1C
 LJvQU+iGKzOVajKyZYNsRWKSAF58=
X-Received: by 2002:a25:2f83:0:b0:629:2551:2309 with SMTP id
 v125-20020a252f83000000b0062925512309mr3100809ybv.211.1646902708130; 
 Thu, 10 Mar 2022 00:58:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyOlECU9bMP5R24bl62q3OU2+aHMh/EdMJqnlZ1t4hyGr7sOPfA3a0BKXvZyJhkbBIJJR0LGdfB2ij4bscawKE=
X-Received: by 2002:a25:2f83:0:b0:629:2551:2309 with SMTP id
 v125-20020a252f83000000b0062925512309mr3100802ybv.211.1646902707905; Thu, 10
 Mar 2022 00:58:27 -0800 (PST)
MIME-Version: 1.0
References: <20220310082251.13173-1-liwang@redhat.com>
 <6229B934.9040606@fujitsu.com>
 <CAEemH2dwawam7iK+E7KnY8Qi0vwz9NWXEf4Bzo3o_9tz-75kjg@mail.gmail.com>
 <6229BCAF.1020502@fujitsu.com>
In-Reply-To: <6229BCAF.1020502@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 10 Mar 2022 16:58:14 +0800
Message-ID: <CAEemH2cUc6WQisKG0Zth9=PUG-8X4818McyVguvP4t3d+stZaQ@mail.gmail.com>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
Content-Type: multipart/mixed; boundary="===============0534426307=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0534426307==
Content-Type: multipart/alternative; boundary="000000000000e2772805d9d96a18"

--000000000000e2772805d9d96a18
Content-Type: text/plain; charset="UTF-8"

On Thu, Mar 10, 2022 at 4:53 PM xuyang2018.jy@fujitsu.com <
xuyang2018.jy@fujitsu.com> wrote:

> Hi Li
> >
> >
> > On Thu, Mar 10, 2022 at 4:38 PM xuyang2018.jy@fujitsu.com
> > <mailto:xuyang2018.jy@fujitsu.com> <xuyang2018.jy@fujitsu.com
> > <mailto:xuyang2018.jy@fujitsu.com>> wrote:
> >
> >     Hi Li
> >      > --- a/lib/newlib_tests/test19.c
> >      > +++ b/lib/newlib_tests/test19.c
> >      > @@ -23,7 +23,7 @@ static struct tst_test test = {
> >      > .needs_root = 1,
> >      > .test_all = run,
> >      > .setup = setup,
> >      > - .save_restore = (const struct tst_path_val const[]) {
> >      > + .save_restore = (const struct tst_path_val[]) {
> >      > {"?/proc/nonexistent", NULL},
> >      > {"!/proc/sys/kernel/numa_balancing", NULL},
> >      > {"/proc/sys/kernel/core_pattern", NULL},
> >
> >     Since tst_path_val is a struct array, we should use {NULL, NULL} or
> {}
> >     terminated instead of NULL terminated , otherwise it will report
> >     missing
> >     braces warning.
> >
> > Ah, right. Sorry!!!
> Never mind.
> >
> > Seems I was in so hurry to fix the const issue but overlook this.
> I also think you can add a separate patch to fix this comment in doc or
> in  tst_test.h for other struct pointers.
>

You are right. I will go through the whole part to see if other places need
updates.

Thanks for finding this :).



>
>          /*
>           * NULL-terminated array to be allocated buffers.
>           */
>          struct tst_buffers *bufs;
>
>          /*
>           * NULL-terminated array of capability settings
>           */
>          struct tst_cap *caps;
>
> Best Regards
> Yang Xu
> >
> > --
> > Regards,
> > Li Wang
>


-- 
Regards,
Li Wang

--000000000000e2772805d9d96a18
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, Mar 10, 2022 at 4:53 PM <a href=3D"mailto:x=
uyang2018.jy@fujitsu.com">xuyang2018.jy@fujitsu.com</a> &lt;<a href=3D"mail=
to:xuyang2018.jy@fujitsu.com">xuyang2018.jy@fujitsu.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Li<br>
&gt;<br>
&gt;<br>
&gt; On Thu, Mar 10, 2022 at 4:38 PM <a href=3D"mailto:xuyang2018.jy@fujits=
u.com" target=3D"_blank">xuyang2018.jy@fujitsu.com</a><br>
&gt; &lt;mailto:<a href=3D"mailto:xuyang2018.jy@fujitsu.com" target=3D"_bla=
nk">xuyang2018.jy@fujitsu.com</a>&gt; &lt;<a href=3D"mailto:xuyang2018.jy@f=
ujitsu.com" target=3D"_blank">xuyang2018.jy@fujitsu.com</a><br>
&gt; &lt;mailto:<a href=3D"mailto:xuyang2018.jy@fujitsu.com" target=3D"_bla=
nk">xuyang2018.jy@fujitsu.com</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Hi Li<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/lib/newlib_tests/test19.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/lib/newlib_tests/test19.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -23,7 +23,7 @@ static struct tst_test test=
 =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; .needs_root =3D 1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; .test_all =3D run,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; .setup =3D setup,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - .save_restore =3D (const struct tst_path_va=
l const[]) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + .save_restore =3D (const struct tst_path_va=
l[]) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; {&quot;?/proc/nonexistent&quot;, NULL},<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; {&quot;!/proc/sys/kernel/numa_balancing&quot;=
, NULL},<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; {&quot;/proc/sys/kernel/core_pattern&quot;, N=
ULL},<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Since tst_path_val is a struct array, we should use=
 {NULL, NULL} or {}<br>
&gt;=C2=A0 =C2=A0 =C2=A0terminated instead of NULL terminated , otherwise i=
t will report<br>
&gt;=C2=A0 =C2=A0 =C2=A0missing<br>
&gt;=C2=A0 =C2=A0 =C2=A0braces warning.<br>
&gt;<br>
&gt; Ah, right. Sorry!!!<br>
Never mind.<br>
&gt;<br>
&gt; Seems I was in so hurry to fix the const issue but overlook this.<br>
I also think you can add a separate patch to fix this comment in doc or <br=
>
in=C2=A0 tst_test.h for other struct pointers.<br></blockquote><div><br></d=
iv><div><div class=3D"gmail_default" style=3D"font-size:small">You are righ=
t. I will go through the whole part to see if other places need updates.</d=
iv></div><div><br></div><div><div class=3D"gmail_default" style=3D"font-siz=
e:small">Thanks for finding this :).</div><br></div><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * NULL-terminated array to be allocated =
buffers.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct tst_buffers *bufs;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * NULL-terminated array of capability se=
ttings<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct tst_cap *caps;<br>
<br>
Best Regards<br>
Yang Xu<br>
&gt;<br>
&gt; --<br>
&gt; Regards,<br>
&gt; Li Wang<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--000000000000e2772805d9d96a18--


--===============0534426307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0534426307==--

