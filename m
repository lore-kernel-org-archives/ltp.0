Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61691C433EF
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 12:14:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4DBA3C8D56
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 13:14:50 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B83E83C104E
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 13:14:41 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6978A1A00913
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 13:14:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639484078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f6vtUvTpZBPetyQCkjqBrnWEJJ5sZFWYkgMGxsAE8r0=;
 b=Zg/oY6pqX8Y4kCrfloJQbQ3Fv2dHlVugeAAZUU9/HbpX48lEkzSJXK/Z6LdTjFEa+ba1fH
 nefGxScfTyJ4lWWZzZkEzImed82RQjZwe+kFh1W9AOnIVPFef5mb34udgLOK+baDJ+iF2O
 /Ckj917kpkzELWBxa6qPrxv8u5BXofQ=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-552-upKwejzNOjKj9PRzcYaz0g-1; Tue, 14 Dec 2021 07:14:29 -0500
X-MC-Unique: upKwejzNOjKj9PRzcYaz0g-1
Received: by mail-yb1-f197.google.com with SMTP id
 t1-20020a5b03c1000000b005f6ee3e97easo35726647ybp.16
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 04:14:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=f6vtUvTpZBPetyQCkjqBrnWEJJ5sZFWYkgMGxsAE8r0=;
 b=2aNRgil0p1x1QEZwnu7gEY6zuk5QcMSuaF3rvV1nPOZTL8WCQqfKg3zFEq8AedGcmW
 CHkmjaXjzbNr00nZ84/5G8DMmbtA5ONKWlApVmpbO2LG+lVmZLHHPgvp5XcVrhOl5dRH
 twc4SlmEZ231KyHhAc3Gnag2ERmV3TFhLfkNEylhfFBlYSJAWRZtZ0XhM3nD6BQ7ibfR
 UlhuFYGqOotFOlUPM1jPw72vfD1P9XYLQTHtx7kB40ih3KeViAkPEaiSsKxhtMx5Byo6
 ybl5QfdHJ8Y8JyLVPPwsqhcG+249yIn55dyXE+5iunSFfpJnC9N+nwCVNAIslvRvT2Hx
 wcpw==
X-Gm-Message-State: AOAM5302HTp5Tf7TzPqE5ABBRZUfmcl7OWdyJEakgaqkaFjl8R/GT5Bl
 W9zKFaUhLC3nbt0f/7bTDBRl1gwsheZKzu9H/9GrG9TC8+eJhhOnhtSimWteTc/nEo+0km/MLB6
 6Xxhn4Hsx8nVsiqazmSvqmiucKyA=
X-Received: by 2002:a25:9bc9:: with SMTP id w9mr5376488ybo.398.1639484069338; 
 Tue, 14 Dec 2021 04:14:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwsucJewhNZ0f3SAmREkmnjoNYX2bn53Jp9utRVeTsZopXB5ECnE5SBFzYg2tcIcYvFeLepGPWNMIdj+19X43g=
X-Received: by 2002:a25:9bc9:: with SMTP id w9mr5376465ybo.398.1639484069118; 
 Tue, 14 Dec 2021 04:14:29 -0800 (PST)
MIME-Version: 1.0
References: <20211213193419.13414-1-pvorel@suse.cz>
 <CAEemH2dp55yFvaXhq_5e77k6QBnY0aFU5fhz4TjW82bkbwwDiA@mail.gmail.com>
 <YbhV9VIv/8o97O6r@pevik> <YbhzexvHiyLKSAu6@yuki> <Ybh/isQcQltJFlyb@pevik>
In-Reply-To: <Ybh/isQcQltJFlyb@pevik>
From: Li Wang <liwang@redhat.com>
Date: Tue, 14 Dec 2021 20:14:17 +0800
Message-ID: <CAEemH2cmQbqQ2Xz-K72zXA2+ngofbY-=VFr0c1sxfHiVzrwc0w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lib: Add support for debugging
 .all_filesystems
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
Content-Type: multipart/mixed; boundary="===============1469438272=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1469438272==
Content-Type: multipart/alternative; boundary="0000000000008e186105d31a2146"

--0000000000008e186105d31a2146
Content-Type: text/plain; charset="UTF-8"

On Tue, Dec 14, 2021 at 7:27 PM Petr Vorel <pvorel@suse.cz> wrote:


>
> > Not sure about the "DEBUG" in the name. I would go for a variation of
> > the first name "LTP_SINGLE_FS_TYPE" or "LTP_LIMIT_FS_TYPE"
> LTP_SINGLE_FS_TYPE looks better for me, because I'd understand LIMIT to run
> fewer filesystems but possibly more than one.
>

+1 for LTP_SINGLE_FS_TYPE

-- 
Regards,
Li Wang

--0000000000008e186105d31a2146
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Dec 14, 2021 at 7:27 PM Petr Vorel &lt;<a h=
ref=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; Not sure about the &quot;DEBUG&quot; in the name. I would go for a var=
iation of<br>
&gt; the first name &quot;LTP_SINGLE_FS_TYPE&quot; or &quot;LTP_LIMIT_FS_TY=
PE&quot;<br>
LTP_SINGLE_FS_TYPE looks better for me, because I&#39;d understand LIMIT to=
 run<br>
fewer filesystems but possibly more than one.<br></blockquote><div>=C2=A0</=
div><div><span class=3D"gmail_default" style=3D"font-size:small">+1 for=C2=
=A0</span>LTP_SINGLE_FS_TYPE</div></div><div><br></div>-- <br><div dir=3D"l=
tr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>=
Li Wang<br></div></div></div></div>

--0000000000008e186105d31a2146--


--===============1469438272==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1469438272==--

