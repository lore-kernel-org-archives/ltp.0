Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A580C433F5
	for <ltp@archiver.kernel.org>; Wed, 30 Mar 2022 03:17:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6EAD3C9DAD
	for <ltp@archiver.kernel.org>; Wed, 30 Mar 2022 05:17:17 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 27DCB3C14BC
 for <ltp@lists.linux.it>; Wed, 30 Mar 2022 05:17:03 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 67C041400BD8
 for <ltp@lists.linux.it>; Wed, 30 Mar 2022 05:17:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648610220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=106ktuZrNRb7GE/0u42krK5VqkGBA7sYF5DXlrw8298=;
 b=TWCNbpJi4OUSg1/b6P4vJy7bTo7WBZ+uSySJ/hlir0rUDE/mqsaIiTxc+XrVOT14ihEgV5
 DaGX4sCsFtu9QhqYbtZyy6w5FRvFmTLr89PkkDjukTvXp51u/cEPdCE6zhJnIlbeK7Kkk3
 lc2S8lHI9Ho3vQjdqXXvD0N0+BYfny4=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-CDp1QjEUNniQvTCsRbHU_w-1; Tue, 29 Mar 2022 23:16:57 -0400
X-MC-Unique: CDp1QjEUNniQvTCsRbHU_w-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-2e61c5a0eb7so159370197b3.22
 for <ltp@lists.linux.it>; Tue, 29 Mar 2022 20:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=106ktuZrNRb7GE/0u42krK5VqkGBA7sYF5DXlrw8298=;
 b=LeisvphkkyThsEbFRHUQAJucM+0ihOcawFXXfik0yJZ0S0tX/XvDWm75ogv3Ddoo/3
 SxkSpzo40lOUqrwpnxHcjphFCfzROhof9osfCAYuPf8DBKf9SRh3C7g+/EEJOR1jMoLl
 +G4bsn2X0oNX4LCUpKnXHPcz2eifmvAtIsw/TfqnhoF8dF+Do3RzOzlCiYcyiNVfCGN1
 NhZMzP2T9vFZwnV+KgJ3TgwD8osQfuSvPOOoGL3jxrdFHzleLGkA5WxHEfxDFuDBHu4a
 olTZ5z1JyvBSMw1km7Q1bgTzusRkYO1LwNKS82LVgSgIBzJR4J5+3UAQUsw6jXmcSDC+
 e6OQ==
X-Gm-Message-State: AOAM533Dhcm6QGYUUDOOv9hB+a3+WLfD8r21eXJfDnl511KK90DQQep3
 dgFdd4YN+4a2+TkKusnxMlrF1rPHMkooleNq8daUt7jx+kBUpnQWas4xGWaKeLukV9TJCFx6rtJ
 33bUEMVtD0Wd3zLwmAtBg4lr0mv0=
X-Received: by 2002:a25:e78e:0:b0:633:9df1:9fff with SMTP id
 e136-20020a25e78e000000b006339df19fffmr30232641ybh.233.1648610217245; 
 Tue, 29 Mar 2022 20:16:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNig4BK9ZeNcRxu0nIq5HnYyuwLpZUAVz9po0d2Nj5cQ++cF0vfAUveYPnRZY083d2+huVIzoKhqVhR4f+Brk=
X-Received: by 2002:a25:e78e:0:b0:633:9df1:9fff with SMTP id
 e136-20020a25e78e000000b006339df19fffmr30232627ybh.233.1648610216920; Tue, 29
 Mar 2022 20:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220329050351.688432-1-liwang@redhat.com>
 <d14a7c35-db49-4b7c-7951-9ad597b99831@redhat.com>
In-Reply-To: <d14a7c35-db49-4b7c-7951-9ad597b99831@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 30 Mar 2022 11:16:43 +0800
Message-ID: <CAEemH2eAaSyZiXE4G792U72iQvmOwQcVe+RoMMqjF7Bc0uajGQ@mail.gmail.com>
To: Waiman Long <longman@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] clock_gettime04: set threshold based on the
 clock resolution
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
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Eirik Fuller <efuller@redhat.com>,
 Waiman Long <llong@redhat.com>, ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============1102303397=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1102303397==
Content-Type: multipart/alternative; boundary="0000000000005a5d1005db66fab7"

--0000000000005a5d1005db66fab7
Content-Type: text/plain; charset="UTF-8"

Waiman Long <longman@redhat.com> wrote:


The patch looks good in general. However, maybe we should do something like:
>
> diff --git a/clock_gettime04.c b/clock_gettime04.c
> index a8d2c5b..1ba218b 100644
> --- a/clock_gettime04.c
> +++ b/clock_gettime04.c
> @@ -92,11 +92,18 @@ static struct time64_variants variants[] = {
>
>   static void setup(void)
>   {
> +       delta = 5;
>          if (tst_is_virt(VIRT_ANY)) {
>                  tst_res(TINFO, "Running in a virtual machine, multiply
> the delta by 10.");
>                  delta *= 10;
>          }
>
> +       clock_getres(CLOCK_REALTIME, &res);
> +       precise_delta = delta + res.tv_nsec / 1000000;
> +
> +       clock_getres(CLOCK_REALTIME_COARSE, &res);
> +       coarse_delta = delta + res.tv_nsec / 1000000;
> +
>          find_clock_gettime_vdso(&ptr_vdso_gettime, &ptr_vdso_gettime64);
>   }
>
> to avoid a coarse_delta that is too large for vm.
>

Thierically that's right, we only make the resolution as additional value
to tolerate.

But I'm afraid this is the part we can not guarantee especially for VM.
As from Eirik's test history, the KVM guest ever failed with "150ms" delay:
  clock_gettime04.c:163: TFAIL: CLOCK_BOOTTIME(vDSO with old kernel spec):
Difference between successive readings greater than 50 ms (2): 150

If we decide to go with your suggestion, I think we'd better skip this test
on VM.

-- 
Regards,
Li Wang

--0000000000005a5d1005db66fab7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Waiman Long &lt;<a href=3D"mailto:longman@redhat.com">longman=
@redhat.com</a>&gt; wrote:<br></div></div><div class=3D"gmail_quote"><div><=
br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
The patch looks good in general. However, maybe we should do something like=
:<br>
<br>
diff --git a/clock_gettime04.c b/clock_gettime04.c<br>
index a8d2c5b..1ba218b 100644<br>
--- a/clock_gettime04.c<br>
+++ b/clock_gettime04.c<br>
@@ -92,11 +92,18 @@ static struct time64_variants variants[] =3D {<br>
<br>
=C2=A0=C2=A0static void setup(void)<br>
=C2=A0=C2=A0{<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 delta =3D 5;<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (tst_is_virt(VIRT_ANY))=
 {<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 tst_res(TINFO, &quot;Running in a virtual machine, mu=
ltiply <br>
the delta by 10.&quot;);<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 delta *=3D 10;<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock_getres(CLOCK_REALTIME, &amp;res=
);<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 precise_delta =3D delta + res.tv_nsec=
 / 1000000;<br>
+<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock_getres(CLOCK_REALTIME_COARSE, &=
amp;res);<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 coarse_delta =3D delta + res.tv_nsec =
/ 1000000;<br>
+<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 find_clock_gettime_vdso(&a=
mp;ptr_vdso_gettime, &amp;ptr_vdso_gettime64);<br>
=C2=A0=C2=A0}<br>
<br>
to avoid a coarse_delta that is too large for vm.<br></blockquote><div><br>=
</div><div><div class=3D"gmail_default" style=3D"font-size:small">Thierical=
ly that&#39;s right, we only make the resolution as additional value to tol=
erate.</div><div class=3D"gmail_default" style=3D"font-size:small"><br></di=
v><div class=3D"gmail_default" style=3D"font-size:small">But I&#39;m afraid=
 this is the part we can not guarantee especially for VM.=C2=A0</div><span =
class=3D"gmail_default" style=3D"font-size:small">As f</span>rom Eirik<span=
 class=3D"gmail_default" style=3D"font-size:small">&#39;s</span> test histo=
ry<span class=3D"gmail_default" style=3D"font-size:small">, the KVM guest e=
ver failed with &quot;150ms&quot; delay:</span></div><div><div class=3D"gma=
il_default" style=3D"font-size:small"></div></div><div><span class=3D"gmail=
_default" style=3D"font-size:small">=C2=A0 </span>clock_gettime04.c:163: TF=
AIL: CLOCK_BOOTTIME(vDSO with old kernel spec): Difference between successi=
ve<span class=3D"gmail_default"> </span>readings greater than 50 ms (2): 15=
0</div><div><br></div></div><div><div class=3D"gmail_default" style=3D"font=
-size:small">If we decide to go with your suggestion, I think we&#39;d bett=
er skip this test on VM.</div></div><div><br></div>-- <br><div dir=3D"ltr" =
class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li W=
ang<br></div></div></div></div>

--0000000000005a5d1005db66fab7--


--===============1102303397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1102303397==--

