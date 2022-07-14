Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B28C43334
	for <ltp@archiver.kernel.org>; Thu, 14 Jul 2022 10:25:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A911D3CA947
	for <ltp@archiver.kernel.org>; Thu, 14 Jul 2022 12:25:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C8C613CA932
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 12:24:58 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 00E451401107
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 12:24:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657794296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WSnoqNaTpRsyiiOxAGMz1rIlFp6kGljCVSXrYmxYza4=;
 b=aSOWXZgOZ5V8wWNNj4QHFNGW2OCDH3wZz5b6WGa04wwxOriutnB2hn/IrZGYObhUMMvr9l
 lG+tFGvoBCb7FLXtVn8p4o8Oopr5uLYgvkbTaEebjvU2dNsV4fdPBXdEkpbgudqh8xFuni
 g9qEW998BbDo5595NW7D2vintCyetGI=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-v8mQYRW6O763sOvA4oAkrQ-1; Thu, 14 Jul 2022 06:24:53 -0400
X-MC-Unique: v8mQYRW6O763sOvA4oAkrQ-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-31cbe6ad44fso11792757b3.10
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 03:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WSnoqNaTpRsyiiOxAGMz1rIlFp6kGljCVSXrYmxYza4=;
 b=1WDCqn3LaTh2ySYjfXiasDmhreb5ZRWS7ouRaZgYbrCLQ/jZ8lZCUgax3M6P2FuNwu
 M81Mute07sDxMjWLqHU4Bh+wCryzV/HCVBc07Q4VWRdhr7WIv3Uz7bRzNTlG2xkVkeRS
 2vexcv3p7KjfbSZ5Ur2E5UvhshJ1slrMTCp+q7PWrHN8NuV0EJfShblqck8ljosdPvl9
 JlDynj41gnPK/YWyZHMUGnFEdJIRipn+gCacabJCiQR3o1Xe7gJVe2p5PJGvBAUmsXm2
 YDkkGWgRR2Wyop8r6d8STqnNRJo1NXdDYmXm4RcsWr4/rEsgXYCVPAnAKlF4fnPPhmPo
 /8rw==
X-Gm-Message-State: AJIora951LVjj961g0VrV3wFl1PVP9RlH6oCW58xwZ5Iw32a8Kk9oD9I
 Tx0/UzYWejuHMOTf/ayKn84KbCV/3yK6ohPI+DvZ5bCyU0fXq6kbGJcxbN0s3o8cxXQA56KQ8iS
 UjRIJGHhV9dNKh3uVRNsPzEr3nzc=
X-Received: by 2002:a0d:d654:0:b0:31c:8777:946c with SMTP id
 y81-20020a0dd654000000b0031c8777946cmr9122066ywd.15.1657794292493; 
 Thu, 14 Jul 2022 03:24:52 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uF2aUn+eIja406m/0oyJeWQOoYh0cmSOFGH3pgAUkqsJF36JTpUkV6IC0BqjRggUrDohEqzoygNXxygnemDEw=
X-Received: by 2002:a0d:d654:0:b0:31c:8777:946c with SMTP id
 y81-20020a0dd654000000b0031c8777946cmr9122054ywd.15.1657794292293; Thu, 14
 Jul 2022 03:24:52 -0700 (PDT)
MIME-Version: 1.0
References: <TY2PR01MB442719179C60B4DB6D275B5CFD889@TY2PR01MB4427.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB442719179C60B4DB6D275B5CFD889@TY2PR01MB4427.jpnprd01.prod.outlook.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 14 Jul 2022 18:24:41 +0800
Message-ID: <CAEemH2fMfQYhfaV5_LeZCxfkCY=FKCqXc+SrZzQLVjzTf4yf8g@mail.gmail.com>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Do we have some simple way to get the current
 cgroup.procs path?
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
Content-Type: multipart/mixed; boundary="===============1937605648=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1937605648==
Content-Type: multipart/alternative; boundary="000000000000e734ec05e3c14f77"

--000000000000e734ec05e3c14f77
Content-Type: text/plain; charset="UTF-8"

Hi Xu,

On Thu, Jul 14, 2022 at 2:02 PM xuyang2018.jy@fujitsu.com <
xuyang2018.jy@fujitsu.com> wrote:

> Hi Richard, LI
>
> I am writting a simple regression test[1]that refer to kernel selftest
> cgroup test_core[2]. I may name it as memcontrol05.c.
>
> It tests cgroup migration permission check should be performed based on
> the credentials at the time of open instead of write.
>
> I have used ltp cgroup framework, but ltp cgroup only use
> SAFE_CGROUP_PRINTF to write value.
>
> How can get the cgroup root_dir ltp_dir path? So I can open this fd
> and change/save effective uid between open and write?
>

Not sure if I fully understand your requirements.
Can we achieve this test by creating a two-layer subdirectory?

Does only the root/ltp_dir mandatory for completing your test?
If yes, I think tst_cg_print_config() maybe fits your purpose,
but that would need additional function help extracting that.

Take a reference to see how Luke gets the root path (in shell):
https://lists.linux.it/pipermail/ltp/2022-April/028772.html


-- 
Regards,
Li Wang

--000000000000e734ec05e3c14f77
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Xu,</div></div><br><div class=3D"gmail_quote"><div dir=3D"=
ltr" class=3D"gmail_attr">On Thu, Jul 14, 2022 at 2:02 PM <a href=3D"mailto=
:xuyang2018.jy@fujitsu.com" target=3D"_blank">xuyang2018.jy@fujitsu.com</a>=
 &lt;<a href=3D"mailto:xuyang2018.jy@fujitsu.com" target=3D"_blank">xuyang2=
018.jy@fujitsu.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">Hi Richard, LI<br>
<br>
I am writting a simple regression test[1]that refer to kernel selftest cgro=
up test_core[2]. I may name it as memcontrol05.c.<br>
<br>
It tests cgroup migration permission check should be performed based on the=
 credentials at the time of open instead of write.<br>
<br>
I have used ltp cgroup framework, but ltp cgroup only use SAFE_CGROUP_PRINT=
F to write value.<br>
<br>
How can get the cgroup root_dir ltp_dir path? So I can open this fd<br>
and change/save effective uid between open and write?<br></blockquote><div>=
=C2=A0</div></div><div class=3D"gmail_default" style=3D"font-size:small">No=
t sure if I fully understand your requirements.</div><div class=3D"gmail_de=
fault" style=3D"font-size:small">Can we achieve=C2=A0this test by creating =
a two-layer=C2=A0subdirectory?</div><div class=3D"gmail_default" style=3D"f=
ont-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:s=
mall">Does only the root/ltp_dir mandatory for completing=C2=A0your test?</=
div><div class=3D"gmail_default" style=3D"font-size:small">If yes, I think =
tst_cg_print_config() maybe fits your purpose,</div><div class=3D"gmail_def=
ault" style=3D"font-size:small">but that would need additional function hel=
p extracting that.</div><div class=3D"gmail_default" style=3D"font-size:sma=
ll"><br></div><div class=3D"gmail_default" style=3D"font-size:small">Take a=
 reference to see how Luke gets the root path (in shell):</div><div class=
=3D"gmail_default" style=3D"font-size:small"><a href=3D"https://lists.linux=
.it/pipermail/ltp/2022-April/028772.html">https://lists.linux.it/pipermail/=
ltp/2022-April/028772.html<br></a></div><br clear=3D"all"><div><br></div>--=
 <br><div dir=3D"ltr"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<=
br></div></div></div></div>

--000000000000e734ec05e3c14f77--


--===============1937605648==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1937605648==--

