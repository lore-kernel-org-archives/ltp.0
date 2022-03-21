Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162BAC433FE
	for <ltp@archiver.kernel.org>; Mon, 21 Mar 2022 08:20:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB8EB3C70D9
	for <ltp@archiver.kernel.org>; Mon, 21 Mar 2022 09:20:17 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DF29A3C062C
 for <ltp@lists.linux.it>; Mon, 21 Mar 2022 09:20:06 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F0DBC600132
 for <ltp@lists.linux.it>; Mon, 21 Mar 2022 09:20:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647850803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ysQTSoAhpg2j7JAhbbmR+vW4TaAYfqE2f9/cogu5GDA=;
 b=SIlf6SkM9KD68F9rCji9vcoLAdJIUrAgzFLd9MtTHqOYrmSy96ZxnH4BmZAStkONfkIdVY
 BJCfXZcFJuGto5f4KsdpDEosyCLBtt/Gb0XRuCTCmSjRnZeOsEoixt5D60jiTVToVz6v/4
 VdcGWlgcv6oj25dSuoR2rRd5YmiDjSo=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-bAym6UBrNHGq4b1uSQfsEg-1; Mon, 21 Mar 2022 04:19:59 -0400
X-MC-Unique: bAym6UBrNHGq4b1uSQfsEg-1
Received: by mail-yb1-f200.google.com with SMTP id
 e4-20020a056902034400b00633691534d5so11509959ybs.7
 for <ltp@lists.linux.it>; Mon, 21 Mar 2022 01:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ysQTSoAhpg2j7JAhbbmR+vW4TaAYfqE2f9/cogu5GDA=;
 b=nRTSxPFfAJdgyfXWASXI0BcHSdagiauDwu8oMWEUb1HZ81QNwRhYYa9yd9SInxUId3
 OGMj5wP9jYH2DQAUK1jl0wJ5FebEjh2NyERFbCMxHZ8fkTI9yBSqMHpl2OjtmJGyAlXr
 3OnORVsVMK6FlIBnIzFBPLk3b0qDBW2KHmTvIyiBHKhkKRc/uAJBjmCgEoTogPuiGHIc
 xwLYHDrsht3OEyUbn9wOe6VjRW2PQo3pqpVGMKpl8Kl5hYTd8lQru2rxbsbaZ8sZ2FAG
 uZQosyQfr0JyHmVfye6rnKWD3qAQWpzIEBh6dwRP3THXySNbYbZ2krdVthG3xh4odALH
 BmNQ==
X-Gm-Message-State: AOAM530RIHR7iHCf+Rhtmba7c382gIyQPG9GzGXaUXC+095eMAqw0JVZ
 zZ0l2c73UhjrowD/u45t22+Wa8SBcuxI77fz22v8yyNHNw2mUmgMB/VObnOTp2IGJLYViqweNOW
 wjD6OSz954x30qB4dyoGlOiGEGDw=
X-Received: by 2002:a5b:a8f:0:b0:633:fd57:f587 with SMTP id
 h15-20020a5b0a8f000000b00633fd57f587mr3935080ybq.506.1647850799095; 
 Mon, 21 Mar 2022 01:19:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSNwffNEZrlBPrJJpannEk/ABgbPfIUyGyuM4uVKuvuUDeL10rt4YU//fru3NfMXK2FqmVMRbQTfo41J7/01c=
X-Received: by 2002:a5b:a8f:0:b0:633:fd57:f587 with SMTP id
 h15-20020a5b0a8f000000b00633fd57f587mr3935070ybq.506.1647850798872; Mon, 21
 Mar 2022 01:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220315122516.3864-1-pvorel@suse.cz>
 <20220315122516.3864-2-pvorel@suse.cz>
 <6231852C.5020506@fujitsu.com> <YjHwEt+hAVQ7bN/D@pevik>
 <CAEemH2fGoTamaY14KSt6s+SvajQVEFp1kshCWCdDd74p9goH6Q@mail.gmail.com>
 <YjRVyiJry8kErKTs@pevik>
In-Reply-To: <YjRVyiJry8kErKTs@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 21 Mar 2022 16:19:45 +0800
Message-ID: <CAEemH2dwTBGpW9Psg0PDtmhaD=xY526SZQ3tyB3oYjDpVjOiGA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] tst_kernel: Fix search for foo-x86-64 module
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
Content-Type: multipart/mixed; boundary="===============1823606574=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1823606574==
Content-Type: multipart/alternative; boundary="000000000000828d6605dab62903"

--000000000000828d6605dab62903
Content-Type: text/plain; charset="UTF-8"

On Fri, Mar 18, 2022 at 5:50 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Li,
>
> > On Wed, Mar 16, 2022 at 10:11 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> > > > Hi Petr
> > > > I don't understand why we must serach foo-x86-64 module, so what
> problem
> > > > do you meet?
>
> > > > I used 5.17-rc8,  it still use foo-x86_64 named rule for
> > > > kernel/arch/x86/crypto/libblake2s-x86_64.ko.
>
> > > > If kernel has libblake2s-x86_64 module, then tst_check_driver will
> use
> > > > libblake2s_x86_64 to find, it should succeed.
>
> > > > If kernel doesn't have libblake2s-x86_64 module, then
> tst_ckeck_driver
> > > > will search twice ,the first time use libblake2s-x86_64  and the
> second
> > > > time use libblake2s_x86_64, then search failed.
>
> > > tst_check_driver.sh is failing on intel based systems. Well, we could
> make
> > > sure
> > > it does not try to test libblake2s-x86-64, IMHO it'd be better to make
> sure
> > > tst_search_driver() works with it, because modinfo/modprobe works with
> it:
>
> > > $ modinfo libblake2s-x86-64
> > > name:           libblake2s_x86_64
> > > filename:       (builtin)
> > > license:        GPL v2
> > > file:           arch/x86/crypto/libblake2s-x86_64
>
> > > Sure, it's a corner case, but I'd still fix it.
> > > Let's see what other think.
>

Ah, I see. Sure, I'm fine to go with your fix :).



>
>
> > Which kernel (and kmod) version did you use?
>
> > I tried locally on my rhel8 and fedora 34 but that doesn't work for me.
>
> > $ rpm -q kmod
> > kmod-28-2.fc34.x86_64
>
> > $ lsmod  |grep  libblake2s
> > libblake2s             16384  0
> > blake2s_x86_64         20480  1 libblake2s
> > libblake2s_generic     20480  1 blake2s_x86_64
>
> > $ modinfo libblake2s-x86-64
> > modinfo: ERROR: Module libblake2s-x86-64 not found.
> => 5.16 had blake2s_x86_64, not libblake2s_x86_64
>
> openSUSE
> * 5.17.0-rc7-26.g04b7727-default, kmod-29-8.4.x86_64
> works (testing libblake2s-x86-64)
> * 5.16, kmod-29-7.1.x86_64
> works (testing blake2s_x86-64)
>
> Fedora 34
> * 5.13.16, kmod-29-2.fc34.x86_64
> works (testing blake2s_x86-64)
>
>
> > Then I checked the Linux source code and get:
> > ------------------
>
> > $ cat linux/arch/x86/crypto/Makefile |grep libblake2s
> > obj-$(if $(CONFIG_CRYPTO_BLAKE2S_X86),y) += libblake2s-x86_64.o
> > libblake2s-x86_64-y := blake2s-core.o blake2s-glue.o
> 6048fdcc5f26 ("lib/crypto: blake2s: include as built-in")
> Follows: v5.16-rc8
> Precedes: v5.17-rc1
> ...
> +++ b/arch/x86/crypto/Makefile
> ...
> -blake2s-x86_64-y := blake2s-core.o blake2s-glue.o
> +blake2s-x86_64-y := blake2s-shash.o
> +obj-$(if $(CONFIG_CRYPTO_BLAKE2S_X86),y) += libblake2s-x86_64.o
> +libblake2s-x86_64-y := blake2s-core.o blake2s-glue.o
>
> Kind regards,
> Petr
>
>

-- 
Regards,
Li Wang

--000000000000828d6605dab62903
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Mar 18, 2022 at 5:50 PM Petr Vorel &lt;<a h=
ref=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">Hi Li,<br>
<br>
&gt; On Wed, Mar 16, 2022 at 10:11 PM Petr Vorel &lt;<a href=3D"mailto:pvor=
el@suse.cz" target=3D"_blank">pvorel@suse.cz</a>&gt; wrote:<br>
<br>
&gt; &gt; &gt; Hi Petr<br>
&gt; &gt; &gt; I don&#39;t understand why we must serach foo-x86-64 module,=
 so what problem<br>
&gt; &gt; &gt; do you meet?<br>
<br>
&gt; &gt; &gt; I used 5.17-rc8,=C2=A0 it still use foo-x86_64 named rule fo=
r<br>
&gt; &gt; &gt; kernel/arch/x86/crypto/libblake2s-x86_64.ko.<br>
<br>
&gt; &gt; &gt; If kernel has libblake2s-x86_64 module, then tst_check_drive=
r will use<br>
&gt; &gt; &gt; libblake2s_x86_64 to find, it should succeed.<br>
<br>
&gt; &gt; &gt; If kernel doesn&#39;t have libblake2s-x86_64 module, then ts=
t_ckeck_driver<br>
&gt; &gt; &gt; will search twice ,the first time use libblake2s-x86_64=C2=
=A0 and the second<br>
&gt; &gt; &gt; time use libblake2s_x86_64, then search failed.<br>
<br>
&gt; &gt; tst_check_driver.sh is failing on intel based systems. Well, we c=
ould make<br>
&gt; &gt; sure<br>
&gt; &gt; it does not try to test libblake2s-x86-64, IMHO it&#39;d be bette=
r to make sure<br>
&gt; &gt; tst_search_driver() works with it, because modinfo/modprobe works=
 with it:<br>
<br>
&gt; &gt; $ modinfo libblake2s-x86-64<br>
&gt; &gt; name:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0libblake2s_x86_64<b=
r>
&gt; &gt; filename:=C2=A0 =C2=A0 =C2=A0 =C2=A0(builtin)<br>
&gt; &gt; license:=C2=A0 =C2=A0 =C2=A0 =C2=A0 GPL v2<br>
&gt; &gt; file:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0arch/x86/crypto/lib=
blake2s-x86_64<br>
<br>
&gt; &gt; Sure, it&#39;s a corner case, but I&#39;d still fix it.<br>
&gt; &gt; Let&#39;s see what other think.<br></blockquote><div><br></div><d=
iv><div class=3D"gmail_default" style=3D"font-size:small">Ah, I see. Sure, =
I&#39;m fine to go with your fix :).</div><br></div><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
<br>
<br>
&gt; Which kernel (and kmod) version did you use?<br>
<br>
&gt; I tried locally on my rhel8 and fedora 34 but that doesn&#39;t work fo=
r me.<br>
<br>
&gt; $ rpm -q kmod<br>
&gt; kmod-28-2.fc34.x86_64<br>
<br>
&gt; $ lsmod=C2=A0 |grep=C2=A0 libblake2s<br>
&gt; libblake2s=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A016384=C2=A0 =
0<br>
&gt; blake2s_x86_64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A020480=C2=A0 1 libblake=
2s<br>
&gt; libblake2s_generic=C2=A0 =C2=A0 =C2=A020480=C2=A0 1 blake2s_x86_64<br>
<br>
&gt; $ modinfo libblake2s-x86-64<br>
&gt; modinfo: ERROR: Module libblake2s-x86-64 not found.<br>
=3D&gt; 5.16 had blake2s_x86_64, not libblake2s_x86_64<br>
<br>
openSUSE<br>
* 5.17.0-rc7-26.g04b7727-default, kmod-29-8.4.x86_64<br>
works (testing libblake2s-x86-64)<br>
* 5.16, kmod-29-7.1.x86_64<br>
works (testing blake2s_x86-64)<br>
<br>
Fedora 34<br>
* 5.13.16, kmod-29-2.fc34.x86_64<br>
works (testing blake2s_x86-64)<br>
<br>
<br>
&gt; Then I checked the Linux source code and get:<br>
&gt; ------------------<br>
<br>
&gt; $ cat linux/arch/x86/crypto/Makefile |grep libblake2s<br>
&gt; obj-$(if $(CONFIG_CRYPTO_BLAKE2S_X86),y) +=3D libblake2s-x86_64.o<br>
&gt; libblake2s-x86_64-y :=3D blake2s-core.o blake2s-glue.o<br>
6048fdcc5f26 (&quot;lib/crypto: blake2s: include as built-in&quot;)<br>
Follows: v5.16-rc8<br>
Precedes: v5.17-rc1<br>
...<br>
+++ b/arch/x86/crypto/Makefile<br>
...<br>
-blake2s-x86_64-y :=3D blake2s-core.o blake2s-glue.o<br>
+blake2s-x86_64-y :=3D blake2s-shash.o<br>
+obj-$(if $(CONFIG_CRYPTO_BLAKE2S_X86),y) +=3D libblake2s-x86_64.o<br>
+libblake2s-x86_64-y :=3D blake2s-core.o blake2s-glue.o<br>
<br>
Kind regards,<br>
Petr<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--000000000000828d6605dab62903--


--===============1823606574==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1823606574==--

