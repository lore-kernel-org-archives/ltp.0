Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93152C433EF
	for <ltp@archiver.kernel.org>; Wed, 11 May 2022 01:54:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C46713CA97C
	for <ltp@archiver.kernel.org>; Wed, 11 May 2022 03:54:45 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 95AD83CA963
 for <ltp@lists.linux.it>; Wed, 11 May 2022 03:54:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6AE806008A7
 for <ltp@lists.linux.it>; Wed, 11 May 2022 03:54:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652234071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4P3K/wHIuklDsfEZhI1cLqv7wpizTxJhbQ/yEtceeCQ=;
 b=Xp66Yg2z3zU2q0YHb4QbjO3WFcc/VVDjp28zYEsegYveoF4Ajp6umSWcTZT3xOkob3FE+m
 lL8dCpjXxTv3GrNmbrTRfwhpY/kFRBLKKewORyccXDt6Y7akjvehpQ5kFO4N95rBzYxQ25
 +afmIkRVOOUBO3mKfRRxGNCusOZyNyQ=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-157-9nP7PnpdNvKksmYscaxISA-1; Tue, 10 May 2022 21:54:30 -0400
X-MC-Unique: 9nP7PnpdNvKksmYscaxISA-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-2fb7cb07885so4797057b3.23
 for <ltp@lists.linux.it>; Tue, 10 May 2022 18:54:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4P3K/wHIuklDsfEZhI1cLqv7wpizTxJhbQ/yEtceeCQ=;
 b=c84dddfbHQERi9wNxWxoV3N3axFEiK28lURJPWDm7oIsNEu9l1XUtwvRrXrJ+m/7O+
 rLeN3SNOzt5ZH7FElGUXytGSrYBkpOQ8eGJLmSCyXgpm6ClbUJNLgzEbOXm/SaSlCEn2
 PRZLxJ8izMJ24Z05U03fJNrMoJooMDqKzBlj1v07tjVfsr48bTyJDtIK5wt02O/2FQW3
 RQTaGZWNkaSGaHrYbDPS8D3tuAkldbVR6NHZxLhXxDVyWv5Z+RWuVuvgw18aAkDjwsti
 nk5JyMLJHFlU+dX4qXE4dLiqR0cu4kcmzSMh37ur5fHNMJA3Z6tFpEMQpca/BEVHiigl
 L2Mw==
X-Gm-Message-State: AOAM5332/xshXrxkDpcDuCRJbQs/9UvuH2nuc6NEaUYSSqOFN210h1Zx
 qoxEp722VfUD8HErmhpS7hs7EYHcHmcvUEZ1CovKp1iSSdDG3Xs4FR8jCQYQ3tYVxUrQ6/JY5LL
 xbl1ay7SuFfShMptSgo2LhyYWhXk=
X-Received: by 2002:a25:59c4:0:b0:645:7d91:db7b with SMTP id
 n187-20020a2559c4000000b006457d91db7bmr20398141ybb.273.1652234069668; 
 Tue, 10 May 2022 18:54:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEfXziCQUjmcc0W8T+pa1ZVJzFiyJUd0Fmw8dBKdIebXiGbkqu3dU+LSC1E8U7NygU5JAaYlrDIVlcDQFi7UQ=
X-Received: by 2002:a25:59c4:0:b0:645:7d91:db7b with SMTP id
 n187-20020a2559c4000000b006457d91db7bmr20398128ybb.273.1652234069445; Tue, 10
 May 2022 18:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAEemH2d-83ubH1LF3SotjvxwD_5C0BiLTTZ+yGtaYqv47n28AQ@mail.gmail.com>
 <20220508030524.2072035-1-liwang@redhat.com> <Ynpx9suOjKrwggmy@yuki>
In-Reply-To: <Ynpx9suOjKrwggmy@yuki>
From: Li Wang <liwang@redhat.com>
Date: Wed, 11 May 2022 09:54:18 +0800
Message-ID: <CAEemH2c0FmVXo2M3ovTRc_bkevEH=zSR9hiUg2w=OFngWN1yuw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] rtc02: loosen the compare precision with few
 seconds
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
Cc: Eirik Fuller <efuller@redhat.com>, LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============1825358555=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1825358555==
Content-Type: multipart/alternative; boundary="000000000000cbaa5e05deb2b8a1"

--000000000000cbaa5e05deb2b8a1
Content-Type: text/plain; charset="UTF-8"

Cyril Hrubis <chrubis@suse.cz> wrote:


>
> I would have done this a bit differently, first chek for day, mon, year
> then do the calculation as:
>
>         if (set_tm->tm_year != read_tm->tm_year)
>                 return 1;
>
>         if (set_tm->tm_mon != read_tm->tm_mon)
>                 return 1;
>
>         if (set_tm->tm_mday != read_tm->tm_mday)
>                 return 1;
>
>
I slightly want to keep rtc_time comparison before converting
into seconds here, because the time change rarely happens,
we don't need to use seconds every time.

+       if ((set_tm->tm_sec != read_tm->tm_sec)
+               || (set_tm->tm_min != read_tm->tm_min)
+               || (set_tm->tm_hour != read_tm->tm_hour)) {


>         seconds1 = ....
>         seconds2 = ....
>         delta = ...
>
>         if (delta < 0 || delta > 3)
>                 return 1;
>

+ }


>
>         return 0;
>
>
> I find this a bit clearer to read.
>

Fair enough!

-- 
Regards,
Li Wang

--000000000000cbaa5e05deb2b8a1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz" target=3D=
"_blank">chrubis@suse.cz</a>&gt; wrote:<br></div></div><div class=3D"gmail_=
quote"><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
I would have done this a bit differently, first chek for day, mon, year<br>
then do the calculation as:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (set_tm-&gt;tm_year !=3D read_tm-&gt;tm_year=
)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (set_tm-&gt;tm_mon !=3D read_tm-&gt;tm_mon)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (set_tm-&gt;tm_mday !=3D read_tm-&gt;tm_mday=
)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
<br></blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"=
font-size:small">I slightly=C2=A0want to keep rtc_time comparison before co=
nverting</div><div class=3D"gmail_default" style=3D"font-size:small">into s=
econds here, because the=C2=A0time change rarely happens,</div><div class=
=3D"gmail_default" style=3D"font-size:small">we don&#39;t need to use=C2=A0=
seconds every time.</div><div class=3D"gmail_default" style=3D"font-size:sm=
all"><br></div>+ =C2=A0 =C2=A0 =C2=A0 if ((set_tm-&gt;tm_sec !=3D read_tm-&=
gt;tm_sec)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || (set_tm=
-&gt;tm_min !=3D read_tm-&gt;tm_min)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 || (set_tm-&gt;tm_hour !=3D read_tm-&gt;tm_hour)) {<br><d=
iv class=3D"gmail_default" style=3D"font-size:small"></div></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 seconds1 =3D ....<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 seconds2 =3D ....<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 delta =3D ...<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (delta &lt; 0 || delta &gt; 3)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br></bloc=
kquote><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:=
small">+ }</div></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
<br>
<br>
I find this a bit clearer to read.<br></blockquote><div><br></div><div clas=
s=3D"gmail_default" style=3D"font-size:small">Fair enough!</div></div><div>=
<br></div>-- <br><div dir=3D"ltr"><div dir=3D"ltr"><div>Regards,<br></div><=
div>Li Wang<br></div></div></div></div>

--000000000000cbaa5e05deb2b8a1--


--===============1825358555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1825358555==--

