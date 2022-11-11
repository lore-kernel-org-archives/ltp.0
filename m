Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 307EFC4332F
	for <ltp@archiver.kernel.org>; Fri, 11 Nov 2022 09:42:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D16053CD549
	for <ltp@archiver.kernel.org>; Fri, 11 Nov 2022 10:42:00 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D57BE3CA956
 for <ltp@lists.linux.it>; Fri, 11 Nov 2022 10:41:51 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C265F10000EB
 for <ltp@lists.linux.it>; Fri, 11 Nov 2022 10:41:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668159709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=frQJo5IhpABUsF+QS2EJuw3BCLfnh0OtgEYRODE8fdE=;
 b=dKeg/CsEdAaiFYTo4gnsrBqyc25X2MKFYlVlv1PLsYt+6PZKpLdn/Lq46xeyb0fdueMM7q
 MNt7AecbctUqM0bsynqu2dsRILy5S2+QW7LM8yGUtftv2i0f7JAerbGQk3qds+H6rBYDdq
 XvvBDSBiPiemyX/GPM95UqsZK9E0ESs=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-106-U8LKsODAPO-mKVKHyfkJFw-1; Fri, 11 Nov 2022 04:41:46 -0500
X-MC-Unique: U8LKsODAPO-mKVKHyfkJFw-1
Received: by mail-oi1-f200.google.com with SMTP id
 x203-20020acae0d4000000b0035a623fce1aso1526857oig.10
 for <ltp@lists.linux.it>; Fri, 11 Nov 2022 01:41:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=frQJo5IhpABUsF+QS2EJuw3BCLfnh0OtgEYRODE8fdE=;
 b=aNDXHtGT32dJO2SUrBIoHbtmf4A9BLq7FPUE11rKs5edAPOMljqK/0SIfqCrVLJqce
 el8jIIpU53e/pbAVek5L61QDLk4lJy5PdYGlCnGd4Cgbg6slhGkdjIHL9W4u3ENavsJ0
 HeUuLnSksh5M1JzpUBex6Kf3h9KfdZzILy/XUKo0kd9Nb6JeGxaX11WT7Jm/ii7oNph1
 e/CW19ANoDAO9keOUxRw27ET/RwtJhH7TBILpeP7o5LB7Ve0wkuV/GM/xVq0NH2EWUpy
 aPZMS8j9vyAzXlvGUX0Ku8LlzsiDCDzTkhomP/VQbQufRjSFIc95/XRPAyKs19d7Slpx
 BxNg==
X-Gm-Message-State: ANoB5pn4PCZI+2h0JzZZHT2C9wfZeHZVh9SAA8fXsrzkM09MyyyNThMY
 bYvgpjQiYRCvyxDfvbWwIOlEtO6QFMcLEnkve5xELQJUi6s6YewJJa9mVUj0kQMwfGPFHMJ4Utt
 pMW6RAiyOxXyRfHncwVUO8z8waJk=
X-Received: by 2002:a05:6808:1589:b0:35a:8668:c9ca with SMTP id
 t9-20020a056808158900b0035a8668c9camr379716oiw.107.1668159703016; 
 Fri, 11 Nov 2022 01:41:43 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5qAh0ndHEvqgnTPbRbzZh3tQ1FrjS1z+3xX5hLsfhE2cqEWiV+8K/Xmju/37USTQOWMvAgPDEiBfqZCiJH7uo=
X-Received: by 2002:a05:6808:1589:b0:35a:8668:c9ca with SMTP id
 t9-20020a056808158900b0035a8668c9camr379713oiw.107.1668159702751; Fri, 11 Nov
 2022 01:41:42 -0800 (PST)
MIME-Version: 1.0
References: <20221110102758.26328-1-andrea.cervesato@suse.com>
In-Reply-To: <20221110102758.26328-1-andrea.cervesato@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 11 Nov 2022 17:41:29 +0800
Message-ID: <CAEemH2fc--utPwQmhB=fE_i+6PEGyK5a+B6j4NgVLxogc+kbgw@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Correctly check setitimer params in setitimer01
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
Content-Type: multipart/mixed; boundary="===============0875513232=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0875513232==
Content-Type: multipart/alternative; boundary="00000000000082f82c05ed2eb2af"

--00000000000082f82c05ed2eb2af
Content-Type: text/plain; charset="UTF-8"

Andrea Cervesato via ltp <ltp@lists.linux.it> wrote:


>  static void setup(void)
>  {
> ...
> +       struct timespec time_res;
> +
> +       /*
> +        * We use CLOCK_MONOTONIC_COARSE resolution for all timers, since
> +        * we are sure its value is bigger than CLOCK_MONOTONIC and we can
> use
> +        * it for both realtime and virtual/prof timers resolutions.
> +        */
> +       SAFE_CLOCK_GETRES(CLOCK_MONOTONIC_COARSE, &time_res);
> +
> +       time_step = time_res.tv_nsec / 1000;
> +       if (time_step <= 0)
> +               time_step = 1000;
> +
> +       time_count = 3 * time_step;
> +
> +       tst_res(TINFO, "clock resolution: %luns, "
>


I would use "low-resolution" for this output, but
someone merge patch can help modify it.

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

--00000000000082f82c05ed2eb2af
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Andrea Cervesato via ltp &lt;<a href=3D"mailto:ltp@lists.linu=
x.it">ltp@lists.linux.it</a>&gt; wrote:<br></div></div><div class=3D"gmail_=
quote"><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0static void setup(void)<br>
=C2=A0{<br><span class=3D"gmail_default" style=3D"font-size:small">...</spa=
n><br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct timespec time_res;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * We use CLOCK_MONOTONIC_COARSE resolution for=
 all timers, since<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * we are sure its value is bigger than CLOCK_M=
ONOTONIC and we can use<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * it for both realtime and virtual/prof timers=
 resolutions.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CLOCK_GETRES(CLOCK_MONOTONIC_COARSE, &amp;=
time_res);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0time_step =3D time_res.tv_nsec / 1000;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (time_step &lt;=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0time_step =3D 1000;=
<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0time_count =3D 3 * time_step;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TINFO, &quot;clock resolution: %luns, &=
quot;<br></blockquote><div><br></div><div><br></div><div><div class=3D"gmai=
l_default" style=3D"font-size:small">I would use &quot;low-resolution&quot;=
 for this output, but</div><div class=3D"gmail_default" style=3D"font-size:=
small">someone merge patch can help modify it.</div><br></div><div><div cla=
ss=3D"gmail_default" style=3D"font-size:small">Reviewed-by: Li Wang &lt;<a =
href=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt;</div></div><div=
><br></div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div>=
</div></div>

--00000000000082f82c05ed2eb2af--


--===============0875513232==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0875513232==--

