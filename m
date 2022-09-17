Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF80ECAAD8
	for <ltp@archiver.kernel.org>; Sat, 17 Sep 2022 02:51:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E88B3CACA8
	for <ltp@archiver.kernel.org>; Sat, 17 Sep 2022 04:51:02 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2477C3CAC64
 for <ltp@lists.linux.it>; Sat, 17 Sep 2022 04:50:52 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2AE2C601BB5
 for <ltp@lists.linux.it>; Sat, 17 Sep 2022 04:50:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663383050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YGad5bGUGby9YTuHWzmTxIldWRHhwQEGYQkEUWzOIKg=;
 b=W1wQkPP/SWCwHUyxh3BaolvDhJErjoHggaY11ES3cR0Yu/64+UQEoahCpbSojIryvXtS3s
 R80Secrw//CSJP8gGc+k0fWfNNMzgXA+SBkkmfZC2mki1Jz6BYPTDe/JQ6ianQ+tnV11Sk
 /wUm8UPdJhCl6nzf2xXvId1taeFVCOA=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-156-1IUt4dcaMieUgnAN0ONLcg-1; Fri, 16 Sep 2022 22:50:48 -0400
X-MC-Unique: 1IUt4dcaMieUgnAN0ONLcg-1
Received: by mail-ua1-f71.google.com with SMTP id
 v6-20020ab05b46000000b003beeaa937ceso1272083uae.9
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 19:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=YGad5bGUGby9YTuHWzmTxIldWRHhwQEGYQkEUWzOIKg=;
 b=s2pj/J1QW+pcON92rlMWTexjXwyU9+n3vdNQ1whq+qGfZCBZ9So3CBLDVUFYhdCwjD
 Sp/gn/x30ez5gJvZc5pmXZs38/zxYAjn4bOrSAJisEzq3PX/OUHq1QmUGA1CgrraPrJF
 EPXMRhB/E2JG8+Po+F4lrg2m4hFoGBaLf8J4osDabXQScHNbXKv4mRNkNNpll3+sh6q9
 XJ5/oxD5tFISsFzYRSbHk7B2kl1Dqjj9uvXHFtHi5xAeNN83mWFRrqy38nPp37CDJlPn
 F5Pax/fxO3gYY7jFJTrbR6sSiYe/6kjkOLe4hY2/uaqLgZTWOYWKKPXqyuZX5A8SM5Xu
 rXBw==
X-Gm-Message-State: ACrzQf0/23FOo3pkAxeEpA6HhHiCUuCmH1DAtNT9h0MBNBdgNeyvFOeV
 9eNKuF2wCSGvO/gCQVHb9+2NHdvxzoJcqwx7eseN+M9nAiJPKPG9r/VgTKId36cc5mUAN4vFm/Q
 QHTjs1UpXw6Son7KdNYZkVKxk6ss=
X-Received: by 2002:ab0:5a24:0:b0:3af:fbb1:2dfb with SMTP id
 l33-20020ab05a24000000b003affbb12dfbmr3227242uad.27.1663383048259; 
 Fri, 16 Sep 2022 19:50:48 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7X+glDKpHvBBSPf1iGPXUxb1i3TTRCcocxGXZXTjYjmuc7B+yVI39DLjLQd7SzcMgJ8Extx/1YsiF6Z8qqhvs=
X-Received: by 2002:ab0:5a24:0:b0:3af:fbb1:2dfb with SMTP id
 l33-20020ab05a24000000b003affbb12dfbmr3227230uad.27.1663383048050; Fri, 16
 Sep 2022 19:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220818100945.7935-1-pvorel@suse.cz> <YyTrqPxEABXGtAYF@pevik>
In-Reply-To: <YyTrqPxEABXGtAYF@pevik>
From: Li Wang <liwang@redhat.com>
Date: Sat, 17 Sep 2022 10:50:37 +0800
Message-ID: <CAEemH2cqn=Pe_b3GiXD7A3k5Qxva=XTPGonbfyvA=3D8FVMjPw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/2] Fix mkfs.xfs 300MB min size requirement
 (v5.19.0)
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
Cc: LTP List <ltp@lists.linux.it>, automated-testing@lists.yoctoproject.org
Content-Type: multipart/mixed; boundary="===============1830675706=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1830675706==
Content-Type: multipart/alternative; boundary="000000000000b4732705e8d68bf1"

--000000000000b4732705e8d68bf1
Content-Type: text/plain; charset="UTF-8"

Hi Petr,


Do we want to merge this patchset to get XFS fix before the release?
>

Sure, I'm fine going with this temporary fix for releasing.


-- 
Regards,
Li Wang

--000000000000b4732705e8d68bf1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi=C2=A0Petr,</div></div><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr"><br></div><div><br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
Do we want to merge this patchset to get XFS fix before the release?<br></b=
lockquote><div><br></div><div class=3D"gmail_default" style=3D"font-size:sm=
all">Sure, I&#39;m fine going with this temporary fix for releasing.</div><=
div><br></div><div class=3D"gmail_default" style=3D"font-size:small"><br></=
div></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr=
"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000b4732705e8d68bf1--


--===============1830675706==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1830675706==--

