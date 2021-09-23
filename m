Return-Path: <SRS0=3vE2=ON=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4BFC433EF
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 06:50:30 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29192610D1
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 06:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 29192610D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2937B3C8495
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 08:50:28 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4CD733C2201
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 08:50:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1270B100126A
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 08:50:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632379815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yRbmBbibY0MsgRXlU2rxXJA8tO5P18axGAh/jwBO6I8=;
 b=ZKqnTclYvNQKDRmeKIQEGqjvG0IMOPfVDAfvPdUIBcOin5cXkVPeoSvVUSMnw9MxCGrLxo
 hHyOV0znmasajR2JRjxmi9YXFp4uNeRDY/VNoC+5pobOa742HbD30/hbLmkJs9SFWiv7W0
 4mEN/dsPybhBV1yxzJjAqBgm93XWcds=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-L4HvHl0AMB2lL3U9Cv191A-1; Thu, 23 Sep 2021 02:50:10 -0400
X-MC-Unique: L4HvHl0AMB2lL3U9Cv191A-1
Received: by mail-qt1-f198.google.com with SMTP id
 c21-20020a05622a025500b002a6965decfdso15280201qtx.14
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 23:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yRbmBbibY0MsgRXlU2rxXJA8tO5P18axGAh/jwBO6I8=;
 b=ZgnJzuWVJayzwV5NbxPeNqN5slAKyrr0FYH3CGVft9pG1snfpgvTprPJXGPYsCfaeb
 bb+NIkOKHBC/2+TnlK+mhlqEdT8SqpL19xTtoxQ5yt2bTm2ynolwz1OhSWVtXTJXTs4p
 AwOH5QYIbaWbbOHdNzbvry++Jhn6UX32ZGpd0rok5+I8pFNa9g2FgST9HxLbXb2J7VLz
 UV3ASIi+09p2INa0kHx6jRH73sN1UsSLRrqnhDS0ZJzLoCjpjhp11xu+9BX0ALpThN/f
 PARIVG9iqspxRYELQRSdcNaaGO1Mc7405sKko2QHt7obq66ZAo7qz/YcfvU7xadJOGT6
 NLOA==
X-Gm-Message-State: AOAM5309HJP+MZSdg2J1dROYe9QBhqP68940iUn/XyWdMn4++XhSing6
 Pwo4t503x5LGPHbmfVFO+tAiPeTglIoipISKB8GnngbI4y961MqIrxsHgB8TYEb9uiGh00bkxsJ
 JiBOM+BHNX/X89wjJuIRDUZNzgVI=
X-Received: by 2002:a25:e4c7:: with SMTP id b190mr3767227ybh.302.1632379810201; 
 Wed, 22 Sep 2021 23:50:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVramadC1EvP2vCeOqvWuxi2d/1A8QZcToGkKSkcT7M6+Rk9L5anwyCC9Dj7+mPlF4TR7FX/g8DZjGWYFhGOw=
X-Received: by 2002:a25:e4c7:: with SMTP id b190mr3767204ybh.302.1632379809928; 
 Wed, 22 Sep 2021 23:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <8b4c1fad2914aee00c8a160d1f9e482574b8e5ae.1632242721.git.jstancek@redhat.com>
 <CAEemH2dQ7NyWSoSwEcyeug6phJKja5=affWzWxt0fQLvHrtODw@mail.gmail.com>
 <YUs9tz0wjk2LJiAL@yuki>
In-Reply-To: <YUs9tz0wjk2LJiAL@yuki>
From: Li Wang <liwan@redhat.com>
Date: Thu, 23 Sep 2021 14:49:57 +0800
Message-ID: <CAEemH2cgbEoSQF0AruoZyJ9vCGoF_N9u0hfPd8aGdtP=TgOK8g@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] hugeshmat04: don't attach at specific address
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
Content-Type: multipart/mixed; boundary="===============2005107055=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============2005107055==
Content-Type: multipart/alternative; boundary="000000000000b5b37105cca40a99"

--000000000000b5b37105cca40a99
Content-Type: text/plain; charset="UTF-8"

> It seems to be regression test for:
>
> commit c5c99429fa57dcf6e05203ebe3676db1ec646793
> Author: Larry Woodman <lwoodman@redhat.com>
> Date:   Thu Jan 24 05:49:25 2008 -0800
>
>     fix hugepages leak due to pagetable page sharing
>


>
> As far as I can tell there is no reason to allocate the memory on a
> fixed address to trigger this bug but it should be easy enough to check
> if the test fails on a kernel that has the two lines this patch adds
> commented before and after the change it test.
>

That commit was merged in v2.6.24, it too old kernel and
changes a lot in the two lines, I guess it is not easy to test
a kernel with revert that patch.

>
> Also can we pretty please add the commit hash to the test metadata?
>

+1

-- 
Regards,
Li Wang

--000000000000b5b37105cca40a99
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
It seems to be regression test for:<br>
<br>
commit c5c99429fa57dcf6e05203ebe3676db1ec646793<br>
Author: Larry Woodman &lt;<a href=3D"mailto:lwoodman@redhat.com" target=3D"=
_blank">lwoodman@redhat.com</a>&gt;<br>
Date:=C2=A0 =C2=A0Thu Jan 24 05:49:25 2008 -0800<br>
<br>
=C2=A0 =C2=A0 fix hugepages leak due to pagetable page sharing<br></blockqu=
ote><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
As far as I can tell there is no reason to allocate the memory on a<br>
fixed address to trigger this bug but it should be easy enough to check<br>
if the test fails on a kernel that has the two lines this patch adds<br>
commented before and after the change it test.<br></blockquote><div><br></d=
iv><div class=3D"gmail_default" style=3D"font-size:small">That commit was m=
erged in v2.6.24, it too old kernel and=C2=A0</div><div class=3D"gmail_defa=
ult" style=3D"font-size:small">changes a lot in the two lines, I guess it i=
s not easy to test</div><div class=3D"gmail_default" style=3D"font-size:sma=
ll">a kernel with revert that patch.</div><div class=3D"gmail_default" styl=
e=3D"font-size:small"></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
<br>
Also can we pretty please add the commit hash to the test metadata?<br></bl=
ockquote><div><br></div><div class=3D"gmail_default" style=3D"font-size:sma=
ll">+1</div><div class=3D"gmail_default" style=3D"font-size:small"><br></di=
v><div class=3D"gmail_default" style=3D"font-size:small"></div></div>-- <br=
><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=
=3D"ltr">Regards,<br>Li Wang<br></div></div></div></div></div>

--000000000000b5b37105cca40a99--


--===============2005107055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============2005107055==--

