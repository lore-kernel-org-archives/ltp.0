Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C5DC433F5
	for <ltp@archiver.kernel.org>; Thu, 17 Feb 2022 03:15:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B46A3C939A
	for <ltp@archiver.kernel.org>; Thu, 17 Feb 2022 04:14:59 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 095553C3206
 for <ltp@lists.linux.it>; Thu, 17 Feb 2022 04:14:49 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 615DF140005F
 for <ltp@lists.linux.it>; Thu, 17 Feb 2022 04:14:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645067687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qNGNVp5GztfgziPfPJ3dkC7XteKJB95KfbAFbHqT3Ug=;
 b=MaO3yv8+Vbb8oj1So8XNNW8pMomUf94YWgQxzQSsvw5D2GwIDFd0wH5e1ZHKE4nctAAlqJ
 XvP064Rv/iDizrEPIEgjxAEahet/NVt+T/bZYLWmEl45xz2Gql8gzHaUQKvR9/1e2HaSzO
 iFCpi45d5Dhcg+oyPXZTP+1oVftcyoo=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-Ip58pbFkNeWDboyQuTULxA-1; Wed, 16 Feb 2022 22:14:46 -0500
X-MC-Unique: Ip58pbFkNeWDboyQuTULxA-1
Received: by mail-yb1-f198.google.com with SMTP id
 x1-20020a25a001000000b0061c64ee0196so8320833ybh.9
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 19:14:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qNGNVp5GztfgziPfPJ3dkC7XteKJB95KfbAFbHqT3Ug=;
 b=fcUA9mH8HCClL6zRx6S3fPdYwbdQZCl9mC0LjB/4EH00KLCIIDoDbK7V9iaQ28NXra
 Zlb01XijSz4omeie/nwtOTwMNNFvyXD9HxKxglUd1D5wMnI7UAJ9qX1s6452hH99lViZ
 b+QsE4kDyY6lqiwnsithVPYiT6+jM6aR739UEgoXVwmjxGDp8fpg7B1IFE8gZtvf1PWo
 X87jhph1gxrac14TKvOgZoyA0nM5m/1ts28xUZQ0wPUitxvMIVoYE1xHZP4+oxeYbkEf
 /lFMqdkQazA4iirYqZIwvjNKuyUp7NP/IHIdohbXlLm5AtrKUvHRpBfSbVt8f5z4UDbK
 qQzA==
X-Gm-Message-State: AOAM533Sd8i0o2NDcVtsnINJTGcM6Ye0bl4fM7chRYIGbV165wtfE1q2
 vhAhFhTMhecawjYwWGo8pX1WGHh3keFUtPFrI8O4YMbICunpOxqNg77rGMx6P661rdi7a93yy9Q
 1Y/uECDqvYOKVBC1VEp8dM+Z5GAY=
X-Received: by 2002:a81:a97:0:b0:2d0:b672:5bd4 with SMTP id
 145-20020a810a97000000b002d0b6725bd4mr872489ywk.90.1645067685638; 
 Wed, 16 Feb 2022 19:14:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxg8QYOwOSqgYS3Tl65pYYRHVI6lZ5Vz592IYReKP64TS1ETqpBArbc4ru99pP2Tjd7J1VwCyzY6fwxNVT4k8I=
X-Received: by 2002:a81:a97:0:b0:2d0:b672:5bd4 with SMTP id
 145-20020a810a97000000b002d0b6725bd4mr872481ywk.90.1645067685440; Wed, 16 Feb
 2022 19:14:45 -0800 (PST)
MIME-Version: 1.0
References: <20220208140322.6842-1-rpalethorpe@suse.com>
 <20220208140322.6842-2-rpalethorpe@suse.com>
In-Reply-To: <20220208140322.6842-2-rpalethorpe@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 17 Feb 2022 11:14:30 +0800
Message-ID: <CAEemH2fUCa6Uj0rDngmr_LadrC=dC3f4EKzRAs9zWQijH=eRhA@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] API/cgroup: Add memory.{events, low}
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
Content-Type: multipart/mixed; boundary="===============1012261294=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1012261294==
Content-Type: multipart/alternative; boundary="00000000000005cf4a05d82e2b31"

--00000000000005cf4a05d82e2b31
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang

--00000000000005cf4a05d82e2b31
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Reviewed-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com"=
>liwang@redhat.com</a>&gt;<br></div></div><div><br></div>-- <br><div dir=3D=
"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><di=
v>Li Wang<br></div></div></div></div>

--00000000000005cf4a05d82e2b31--


--===============1012261294==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1012261294==--

