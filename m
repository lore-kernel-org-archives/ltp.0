Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948F5C0502A
	for <ltp@archiver.kernel.org>; Wed, 31 Aug 2022 06:36:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F20D83CA720
	for <ltp@archiver.kernel.org>; Wed, 31 Aug 2022 08:35:57 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F5D83C0E02
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 08:35:48 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 76913600654
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 08:35:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661927745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5f8oW4lZxHgiyKP+eAlQ4noQX1mS1/+5QSaNok1H7uo=;
 b=f8wP7zR0XptPVO462W2yhQx6wNucyjY2ErKArhJxBQ4gMKpRwOoJaC0afOdEZ1S3ffeqhW
 httYnzPGzbzU2n1tt5Xp3Eov5uGIqPRxTR+yboJPaP9gs3fAOn5kb/A1VGLsmerUwTGUbV
 RqxdI+ksIzJFPwpmYnqhseZAE8Kz24s=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-627-Cw7jCUavOcWyxK61wc3UUw-1; Wed, 31 Aug 2022 02:35:44 -0400
X-MC-Unique: Cw7jCUavOcWyxK61wc3UUw-1
Received: by mail-yb1-f200.google.com with SMTP id
 f3-20020a056902038300b00696588a0e87so168940ybs.3
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 23:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=5f8oW4lZxHgiyKP+eAlQ4noQX1mS1/+5QSaNok1H7uo=;
 b=xFb0prfCChTqHHZibxjZZmf9++Lih9+9+br3mjEp2F6Ukba5sPcS2mrn+MdvLG+sdh
 8ysBS3+cQ+Xcd7fUpuhc9H+8GmSq4Ep7R/l60PcLzO+CxTATEzsoQnMoJL5f1aiJqux1
 4q0kuaFQfP7mw7JMzPHzLaoQLmwdln1vxrAfz1fhffEXxQQPzvRKtF0oGsyAgddz3Dkr
 6YmQNCYJ4+D5eTu9m1heGQkpiOoJn5lB2ViXIk1vSFmzbiL667ZlLGJwOgfJw/OfJ2By
 MSSB9egfNkGU+YhT/9Y6neDclhvm3Oq/ZdUwSe5kC7dY1ms+gyPemXmPQIVaQAv1zCdz
 GhSA==
X-Gm-Message-State: ACgBeo30X9IRABIpKo7Xb4w2T+sSJ0zA1TmI4NjGObg4jET87xEg/rt7
 pu7xd+znMG1aqx/MIY5E7Ef8lQUvA/XiQKu+HuBdtg10gEOONyMkB9LtH3dyVRa4xBXOX/XNs9k
 hor6BNXZrszmz6MXwdIc8shn0VKk=
X-Received: by 2002:a25:558:0:b0:696:4e84:6367 with SMTP id
 85-20020a250558000000b006964e846367mr13814494ybf.412.1661927743262; 
 Tue, 30 Aug 2022 23:35:43 -0700 (PDT)
X-Google-Smtp-Source: AA6agR48Uw2oRPF2z0NsFinyAN+2ClCgleVX3NiRKshT4I6mUk6yUCc0y91v9y8my1kMMY408+9ami2g2N7BVxkGlhk=
X-Received: by 2002:a25:558:0:b0:696:4e84:6367 with SMTP id
 85-20020a250558000000b006964e846367mr13814487ybf.412.1661927743096; Tue, 30
 Aug 2022 23:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220830072028.1115-1-akumar@suse.de>
In-Reply-To: <20220830072028.1115-1-akumar@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Wed, 31 Aug 2022 14:35:32 +0800
Message-ID: <CAEemH2fTpsMf_j3rRHw+Uy+D5nEes1tPpSbqVfKDavSWoGOk6Q@mail.gmail.com>
To: Avinesh Kumar <akumar@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getsid01.c: Convert to new LTP API
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
Content-Type: multipart/mixed; boundary="===============0463418232=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0463418232==
Content-Type: multipart/alternative; boundary="000000000000c51ff005e783b448"

--000000000000c51ff005e783b448
Content-Type: text/plain; charset="UTF-8"

Hi Avinesh,

Avinesh Kumar <akumar@suse.de> wrote:


> -       for (lc = 0; TEST_LOOPING(lc); lc++) {
> -               /* reset tst_count in case we are looping */
> -               tst_count = 0;
> +       TEST(getsid(0));
> +       p_sid = TST_RET;
>

We'd better examine TST_RET not equal -1, otherwise, the test can
still report pass with two wrong values (-1) returned. isn't it?


> +               c_sid = TST_RET;
>

Here as well.


-- 
Regards,
Li Wang

--000000000000c51ff005e783b448
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Avinesh,</div></div><div class=3D"gmail_quote"><div dir=3D=
"ltr" class=3D"gmail_attr"><br></div><div dir=3D"ltr" class=3D"gmail_attr">=
Avinesh Kumar &lt;<a href=3D"mailto:akumar@suse.de">akumar@suse.de</a>&gt; =
wrote:<br></div><div>=C2=A0=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0for (lc =3D 0; TEST_LOOPING(lc); lc++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* reset tst_count =
in case we are looping */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_count =3D 0;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TEST(getsid(0));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0p_sid =3D TST_RET;<br></blockquote><div><br></d=
iv><div class=3D"gmail_default" style=3D"font-size:small">We&#39;d better e=
xamine TST_RET not equal -1, otherwise, the test can</div><div class=3D"gma=
il_default" style=3D"font-size:small">still report pass with two wrong valu=
es (-1) returned. isn&#39;t it?</div><div class=3D"gmail_default" style=3D"=
font-size:small"></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c_sid =3D TST_RET;<=
br></blockquote><div><br></div></div><div class=3D"gmail_default" style=3D"=
font-size:small">Here as well.</div><br clear=3D"all"><div><br></div>-- <br=
><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<=
br></div><div>Li Wang<br></div></div></div></div>

--000000000000c51ff005e783b448--


--===============0463418232==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0463418232==--

