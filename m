Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0696BC433EF
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 00:40:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C47B3C9897
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 01:40:11 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DFEB13C5A4C
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 01:40:01 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9341E1A014ED
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 01:39:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644539998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CAnq5zPNPNleKlKcza3HwabcQHAhBBcGhP5syvYBNOs=;
 b=Gk0WRYLS9vUVHpEsaTtrtyHU8J6IQl+5nRkeV6nXGyUAOpPtJhjDi1OBmWxjkdkHRXqEBD
 1BC+odLK+xTmtmfmjkyAcbW4pn/0yENybijvSG0bmmWXS19PXI7OYgjP1d3lx7C2LTdkpx
 A8gQyytl+BRhSL0Zw1zj1oP35Uc+090=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-LIwJXp0DPnuOQrqIsjTniQ-1; Thu, 10 Feb 2022 19:39:57 -0500
X-MC-Unique: LIwJXp0DPnuOQrqIsjTniQ-1
Received: by mail-yb1-f199.google.com with SMTP id
 t8-20020a259ac8000000b00619a3b5977fso15639526ybo.5
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 16:39:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CAnq5zPNPNleKlKcza3HwabcQHAhBBcGhP5syvYBNOs=;
 b=R/TNvztQud/90z8Vg486ICOGuTFm85EqecK9fx5bn7IAFm52S8wTJ6xU507xchQPjl
 9zL5+GK2Au+YjHdLyqxyfoaDqWR7tFXAgpuNT6YjYrALkxl5f9tTHPEIvumOd7HF4t98
 GrtAua9OrVOcSxRD6852Z/7kkU4PVxG6Wpz8CgCeQIR68IVfUDrfy4nqtlRcpSw8ZMXG
 Icod2kllneBH9EXE0s5wLhj28rFhMO/r68CG9wLP5CNEbqs1IJx+bpXb2WaBwL97x0H4
 8Uv0UzSlhCcmYEHTk47tBr6goof+zr1/qRqjIVV8bOYrgQGnEYVdhPoh0M2yTxo2opU/
 SrKQ==
X-Gm-Message-State: AOAM5338v6FOLfKz/e51fkCKU4Fj0ZxpxWnZuEqkDJLNH3oXiQ5EVqaH
 Ay26ig4cmVCEoVCujKz8NCTLMLx4KNNDMkDVy5cfhVZfO/S2A+jSvnpGuu6T/LUGPPue9FUxRj6
 KQQzT/9KmKJGIQfIvtu5aI6NOLvA=
X-Received: by 2002:a81:e543:: with SMTP id c3mr10170005ywm.370.1644539996761; 
 Thu, 10 Feb 2022 16:39:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwr4UleDwsfCfz5x0HURkbrTE+dRGKW9B2dt8m6m2V0tyoNb83ervVVaMksGcY7b05kas+7RK4rDH6YIoA5xbc=
X-Received: by 2002:a81:e543:: with SMTP id c3mr10169999ywm.370.1644539996575; 
 Thu, 10 Feb 2022 16:39:56 -0800 (PST)
MIME-Version: 1.0
References: <20220210133812.13368-1-bogdan.lezhepekov@suse.com>
 <YgU5QvQnzmcCgKq7@yuki>
In-Reply-To: <YgU5QvQnzmcCgKq7@yuki>
From: Li Wang <liwang@redhat.com>
Date: Fri, 11 Feb 2022 08:39:43 +0800
Message-ID: <CAEemH2c71jsd5VDZ05pCEGJMHtdxK2_T2MXaK5P73qttBd-gLQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mem/swapping01: Make sure swap is supported by
 kernel
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
Content-Type: multipart/mixed; boundary="===============0556493321=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0556493321==
Content-Type: multipart/alternative; boundary="00000000000050b07505d7b34e01"

--00000000000050b07505d7b34e01
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 11, 2022 at 12:09 AM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> Applied, thanks.
>
> I guess that the SAFE_OPEN() caused TBROK on machines without
> CONFIG_SWAP, right?
>

If so, why not go fix with .needs_config for "CONFIG_SWAP=y" ?

-- 
Regards,
Li Wang

--00000000000050b07505d7b34e01
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Feb 11, 2022 at 12:09 AM Cyril Hrubis &lt;<=
a href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
Applied, thanks.<br>
<br>
I guess that the SAFE_OPEN() caused TBROK on machines without<br>
CONFIG_SWAP, right?<br></blockquote><div><br></div><div class=3D"gmail_defa=
ult" style=3D"font-size:small">If so, why not go fix with .needs_config for=
 &quot;CONFIG_SWAP=3Dy&quot; ?</div></div><div><br></div>-- <br><div dir=3D=
"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><di=
v>Li Wang<br></div></div></div></div>

--00000000000050b07505d7b34e01--


--===============0556493321==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0556493321==--

