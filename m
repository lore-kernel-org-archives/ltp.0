Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E84C433EF
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 06:24:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 245163C9358
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 08:24:25 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AEE083C0756
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 08:24:14 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 480EA6006C0
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 08:24:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655706251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LRYFQyDaOth2QQ4maDW+pe6RSp8816Q9AFEKmaI7Rjo=;
 b=PUv8O5WOGjhO2v7ssv5Fr7RjV3aKME2eRcrsdDHFEzKMWQt/ICg5YOOU0X+Zl27oxXQQxG
 rsJjRQLcwUoIvGH0R3Zueq1HYdc3JUCtMcyrSq0gpwMPu1XWDRAMQwss9FqAQwB2ka7OQu
 k3wovw9zYTcFt42xC4c2nzub4KtX0sY=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-504-RsSuDaayPfOEEdHep7EGiA-1; Mon, 20 Jun 2022 02:24:09 -0400
X-MC-Unique: RsSuDaayPfOEEdHep7EGiA-1
Received: by mail-yb1-f199.google.com with SMTP id
 v191-20020a25c5c8000000b00663d6d41f5aso8844270ybe.12
 for <ltp@lists.linux.it>; Sun, 19 Jun 2022 23:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LRYFQyDaOth2QQ4maDW+pe6RSp8816Q9AFEKmaI7Rjo=;
 b=l9T9YZhmpnvVi0m1P8HZ7f0KsREE736hk86se0qfndscm5TTiktdlGHloDMpTpXc44
 YCQ48N0cOyqsPvALwOP6z7pSPu0AKcvZcZ9WxsN9q4lmaRXnMf2g+k4ZvtYZd/CPXNCK
 xvW0oKEMzFZlSG8GUvFHlQz5/UzJmVcrPTxx1L/QDkKpfYxsSpGHmx7K3wY8PV4F18Ff
 6hHov5GjqJLF4vJ5MevbYhwjErs6BbPPROSJDK1DgCSCWbQRoSbELNj7rgsQMQZzewgU
 Mgno5xHSgLiWlSyHlbC305CtafxH0Ld6pLRboUp5ZFvi9gSmJwfl6LfaZmt7i8/H6wBs
 Qemg==
X-Gm-Message-State: AJIora+9dnb+sLbrLzLW5Eee6crLWVzaGxgeLr5F3vXJbV38nLcOLlnR
 f00mE3eBxaxlNVdEHLEaGaYseJTjXx66Aq/bBKszApmoxg9g1Lzxaw2M0Skgw8NQT+0F428gBcF
 BTYFEkwfZqz3YbICKQBTQHEz1oRA=
X-Received: by 2002:a5b:4c4:0:b0:668:5604:b395 with SMTP id
 u4-20020a5b04c4000000b006685604b395mr22929540ybp.355.1655706248914; 
 Sun, 19 Jun 2022 23:24:08 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sEsQVlhbPAzOoLCmmy4Hggz5YXxO6cGXUymylnKMHX8rmjLa3iAJmyEo8lV38VWqcC1LZCCKkQWwRFyBuW+MU=
X-Received: by 2002:a5b:4c4:0:b0:668:5604:b395 with SMTP id
 u4-20020a5b04c4000000b006685604b395mr22929527ybp.355.1655706248651; Sun, 19
 Jun 2022 23:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220617055600.455225-1-liwang@redhat.com> <YqxSxUh4F1vajB2i@yuki>
In-Reply-To: <YqxSxUh4F1vajB2i@yuki>
From: Li Wang <liwang@redhat.com>
Date: Mon, 20 Jun 2022 14:23:57 +0800
Message-ID: <CAEemH2dNBD9VexxgkV_2tBZporiLSVrJ4CjU63vf938YCsJAHA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] swapping01: set .max_runtime to 90 seconds
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
Content-Type: multipart/mixed; boundary="===============1923697477=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1923697477==
Content-Type: multipart/alternative; boundary="000000000000cdbb0c05e1db2646"

--000000000000cdbb0c05e1db2646
Content-Type: text/plain; charset="UTF-8"

On Fri, Jun 17, 2022 at 6:07 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> >   # time ./swapping01
> >   tst_kconfig.c:82: TINFO: Parsing kernel config
> '/boot/config-4.18.0-309.el8.x86_64+debug'
> >   tst_test.c:1528: TINFO: Timeout per run is 0h 02m 00s
> >   swapping01.c:110: TINFO: available physical memory: 1545 MB
> >   swapping01.c:113: TINFO: try to allocate: 2008 MB
> >   swapping01.c:152: TPASS: no heavy swapping detected, 218 MB swapped.
> >   ...
> >
> >   real    0m34.241s
> >   user    0m0.386s
> >   sys     0m16.040s
>
> I did play with the test for a bit and it's even more unpredictable for
> me, it tooks a minute or two on my workstation but there were outliners
> that took nearly four minutes as well.
>
> Hence I would propose to go even further and default to 10 minutes for
> max_runtime. At the same time I would limit the loop that waits for the
> swap usage to settle to run for a reminder of max_runtime/2 instead of
> the hardcoded 30 seconds. Something as:
>

Fair enough!

max_runtime/2 is about 5mins which is the previous default time of timeout
that works well.


-- 
Regards,
Li Wang

--000000000000cdbb0c05e1db2646
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Jun 17, 2022 at 6:07 PM Cyril Hrubis &lt;<a=
 href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt;=C2=A0 =C2=A0# time ./swapping01<br>
&gt;=C2=A0 =C2=A0tst_kconfig.c:82: TINFO: Parsing kernel config &#39;/boot/=
config-4.18.0-309.el8.x86_64+debug&#39;<br>
&gt;=C2=A0 =C2=A0tst_test.c:1528: TINFO: Timeout per run is 0h 02m 00s<br>
&gt;=C2=A0 =C2=A0swapping01.c:110: TINFO: available physical memory: 1545 M=
B<br>
&gt;=C2=A0 =C2=A0swapping01.c:113: TINFO: try to allocate: 2008 MB<br>
&gt;=C2=A0 =C2=A0swapping01.c:152: TPASS: no heavy swapping detected, 218 M=
B swapped.<br>
&gt;=C2=A0 =C2=A0...<br>
&gt; <br>
&gt;=C2=A0 =C2=A0real=C2=A0 =C2=A0 0m34.241s<br>
&gt;=C2=A0 =C2=A0user=C2=A0 =C2=A0 0m0.386s<br>
&gt;=C2=A0 =C2=A0sys=C2=A0 =C2=A0 =C2=A00m16.040s<br>
<br>
I did play with the test for a bit and it&#39;s even more unpredictable for=
<br>
me, it tooks a minute or two on my workstation but there were outliners<br>
that took nearly four minutes as well.<br>
<br>
Hence I would propose to go even further and default to 10 minutes for<br>
max_runtime. At the same time I would limit the loop that waits for the<br>
swap usage to settle to run for a reminder of max_runtime/2 instead of<br>
the hardcoded 30 seconds. Something as:<br></blockquote><div><br></div><div=
><div class=3D"gmail_default" style=3D"font-size:small">Fair enough!</div><=
div class=3D"gmail_default" style=3D"font-size:small"><br></div><div class=
=3D"gmail_default" style=3D"font-size:small">max_runtime/2 is about 5mins w=
hich is the previous default time of timeout that works well.</div><br></di=
v><div><br></div></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></d=
iv>

--000000000000cdbb0c05e1db2646--


--===============1923697477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1923697477==--

