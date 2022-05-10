Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADDC0C433F5
	for <ltp@archiver.kernel.org>; Tue, 10 May 2022 08:36:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 09CD93CA988
	for <ltp@archiver.kernel.org>; Tue, 10 May 2022 10:36:34 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D7BC3C1C59
 for <ltp@lists.linux.it>; Tue, 10 May 2022 10:36:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D43611A009A6
 for <ltp@lists.linux.it>; Tue, 10 May 2022 10:36:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652171780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YhHQXLrvV2uRMNjxGQyaY/D+5IZjZ1A3zJzFLEI0ZMs=;
 b=MtS0yXTe9FA/UuHKQF1R0fu4ZinMkryY11YRuE5G3/nBUyaG6ew722IPLzt1S2fNkm6Yb3
 5fvXeJopnJMdk9rs1adGeSZWZargEac7UzNhmE0Ca2IL6/M/ccdcXP72/utazPPXjMbFNQ
 ytN8IxS/HIMTQYL545yowEKdNH7fuEU=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-387-Uom6A_lWMR-99KWBysW5pQ-1; Tue, 10 May 2022 04:36:18 -0400
X-MC-Unique: Uom6A_lWMR-99KWBysW5pQ-1
Received: by mail-yb1-f199.google.com with SMTP id
 d188-20020a25cdc5000000b00648429e5ab9so14280185ybf.13
 for <ltp@lists.linux.it>; Tue, 10 May 2022 01:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YhHQXLrvV2uRMNjxGQyaY/D+5IZjZ1A3zJzFLEI0ZMs=;
 b=nUpylx1ZNzJ0/EXJ95+J5OnGhotQmNO/GPwu1DoV1rszPVHk80OL8urPei9HiTUgp2
 wPB12eg6/mBw6PLgH6CFUouHcHkcaPBtlWzi8eIeXjUTFsDJ5iobJ3Tx7fiX0LoVEOAI
 eK4hjqMtbSUPgwgVawiuLWRTyGuh53YlBoC3nIdK+9W7C99MTcPM6PsxFtvg6B/J0dh+
 7sHTmK7HLivVeJcsYB4VWKxpWVksF4kihUHcFMpSC58b4aEd5ykrpRGAVVu8AMbYFF7l
 3w3FODQw3+iTqPDdl17qQYICpezLicOjs/o6y4T/S/OGgTecKixsbH+Imy7tXro3i8xm
 bz1Q==
X-Gm-Message-State: AOAM533JeX5B+B8R0FakGjmy30N40yOfPTnOhp4KzUYse+ISMzfvXFn1
 if7aP+Oh4/kcdVgxPh+Jo8clyKDrwnaStPjCNfZ+VMU/IprmBfEzuFkXRERRnE+IxUFgA7TdCls
 JVCqf31xlwtgcHroljfmz+PlmTlo=
X-Received: by 2002:a81:194d:0:b0:2f7:cb5d:eaa7 with SMTP id
 74-20020a81194d000000b002f7cb5deaa7mr18336653ywz.25.1652171778182; 
 Tue, 10 May 2022 01:36:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzv5UnLeXxfd+fEUlD9HWr0xcLjruEtO1osHEcDwhDlYIQTlb2clp/ENo10gLuiSm8LJqDln5H+VlnTgTA3ES8=
X-Received: by 2002:a81:194d:0:b0:2f7:cb5d:eaa7 with SMTP id
 74-20020a81194d000000b002f7cb5deaa7mr18336637ywz.25.1652171777947; Tue, 10
 May 2022 01:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <YnkOEruIKIwEeC3M@yuki>
In-Reply-To: <YnkOEruIKIwEeC3M@yuki>
From: Li Wang <liwang@redhat.com>
Date: Tue, 10 May 2022 16:36:06 +0800
Message-ID: <CAEemH2cUXJ1BGL_yzN+Eakdo__knmrHajwLCmZo9+H4VxE+gNw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preparations
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
Content-Type: multipart/mixed; boundary="===============0950024696=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0950024696==
Content-Type: multipart/alternative; boundary="000000000000eed43805dea43779"

--000000000000eed43805dea43779
Content-Type: text/plain; charset="UTF-8"

On Mon, May 9, 2022 at 8:48 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> It's time to start working on pre-release preparations. As usually we
> should start by considering patches that should be applied before we
> freeze the git.
>
> As for me I would like to get the runtime patchset in if possible.
>

+1, I will add my review ASAP.



> What else should be considered for the release?
>


1628025 New          [v2] rtc02: loosen the compare precision with few
seconds
1625610 New          [1/2] lapi/mount.h: Remove <linux/mount.h>
1625609 New          [2/2] Remove duplicate include of <sys/mount.h>

also, I vote for adding expand Cgroup library from Luke's patchset, but
if time is hurrying I'm fine without it as well.



-- 
Regards,
Li Wang

--000000000000eed43805dea43779
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, May 9, 2022 at 8:48 PM Cyril Hrubis &lt;<a =
href=3D"mailto:chrubis@suse.cz" target=3D"_blank">chrubis@suse.cz</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
It&#39;s time to start working on pre-release preparations. As usually we<b=
r>
should start by considering patches that should be applied before we<br>
freeze the git.<br>
<br>
As for me I would like to get the runtime patchset in if possible.<br></blo=
ckquote><div><span class=3D"gmail_default" style=3D"font-size:small"><br></=
span></div><div><span class=3D"gmail_default" style=3D"font-size:small">+1,=
=C2=A0</span>I will add my=C2=A0review=C2=A0<span class=3D"gmail_default" s=
tyle=3D"font-size:small">ASAP</span>.</div><div><span class=3D"gmail_defaul=
t" style=3D"font-size:small"></span>=C2=A0</div><div><br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
<br>
What else should be considered for the release?<br></blockquote><div><br></=
div><div><br></div><div class=3D"gmail_default" style=3D"font-size:small">1=
628025 New =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[v2] rtc02: loosen the compare=
 precision with few seconds</div></div><div class=3D"gmail_default" style=
=3D"font-size:small">1625610 New =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[1/2] la=
pi/mount.h: Remove &lt;linux/mount.h&gt;</div>1625609 New =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0[2/2] Remove duplicate include of &lt;sys/mount.h&gt;<div>=
<br><div class=3D"gmail_default" style=3D"font-size:small"></div>also, I vo=
te for<span class=3D"gmail_default" style=3D"font-size:small"> adding expan=
d Cgroup library from Luke&#39;s patchset, but</span></div><div><div class=
=3D"gmail_default" style=3D"font-size:small">if time is hurrying I&#39;m fi=
ne without it as well.</div><br><br clear=3D"all"><div><br></div>-- <br><di=
v dir=3D"ltr"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div=
></div></div></div></div>

--000000000000eed43805dea43779--


--===============0950024696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0950024696==--

