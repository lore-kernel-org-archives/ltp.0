Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54C0ECAAD1
	for <ltp@archiver.kernel.org>; Tue, 30 Aug 2022 06:16:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 27ABE3CA5E6
	for <ltp@archiver.kernel.org>; Tue, 30 Aug 2022 08:16:41 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD9633C81E1
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 08:16:31 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2CF7560086A
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 08:16:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661840189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wrycDknftddiSXVDjpAE/bTyBHQ1FR5LjC4slGF7lSs=;
 b=aIOtOt20NwA3qbdUVn8omYcRulwSTT4fIKgzGpthe9rkiTeGOYUTbXhvjOjJjrOWYwS++D
 gKYfWSxC1zksSlmhI1bXpzJPnxOjlU96HSV0OaSQdkZt5hjc+xs7XcgcR4e6HhvE7zcj/O
 GBcF4OLQUdML5rdey6FO+9syixg3f9U=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-562-TRgjRjEVPcC-2Xtp_EEylA-1; Tue, 30 Aug 2022 02:16:26 -0400
X-MC-Unique: TRgjRjEVPcC-2Xtp_EEylA-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-335420c7bfeso162091447b3.16
 for <ltp@lists.linux.it>; Mon, 29 Aug 2022 23:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=wrycDknftddiSXVDjpAE/bTyBHQ1FR5LjC4slGF7lSs=;
 b=ZhT0AMwqtL7sYZlBzkkXHvoTyLgsKQ64LFE2vBXZAjApeCYSmM817tRmyEDUAgK5YW
 QCNwKeYHtLqfVGHVErCit/xlgMMfkvJ73ARoMHqm9K010cYrhN4ribVSZh9MDbXZsaeH
 rbZd9Ey0h3nmeUkhF/8S9VPYrqrni+JokR5mwN2Nk2W9+OB5XFtQffxfn1ktX9gvk/jy
 7UyvRHsKHmD4TTygeoJZdhtJzI/BHoygVgwmGKskO2z8ViTgQPeTglVMhwaKEYBam46K
 5mKbPrhJthXubGF5w/uX9i3EzI02rq/Qlm+bPGY0i1P6yRl1xyCVLQpRDidIy/OPgEYu
 45hQ==
X-Gm-Message-State: ACgBeo2lRztmoYqQHZ8JE5p0f22SpKuhV+3d7gG/cemZTsTkJGus82Si
 bNDCSgFF6uyN/+zCfJu9XLBXHLIBrQSn7wm530OePciCV5kYugdUfrF5kFWaOI9fPQW+mi1fih0
 Vr9gAWtdaf6och3QAsWK8K/2syr4=
X-Received: by 2002:a0d:f783:0:b0:340:cd25:fc5d with SMTP id
 h125-20020a0df783000000b00340cd25fc5dmr10112946ywf.82.1661840186424; 
 Mon, 29 Aug 2022 23:16:26 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5kCEMyZHnEOD2btQTDJtyNaZXLzA45yJ4uNjSacahKarzX45+JWcsZ0Zs6BWPcYWRm95qnu51AA/oR0n/4Jr8=
X-Received: by 2002:a0d:f783:0:b0:340:cd25:fc5d with SMTP id
 h125-20020a0df783000000b00340cd25fc5dmr10112939ywf.82.1661840186220; Mon, 29
 Aug 2022 23:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220827002815.19116-1-pvorel@suse.cz>
 <20220827002815.19116-7-pvorel@suse.cz>
In-Reply-To: <20220827002815.19116-7-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 30 Aug 2022 14:16:15 +0800
Message-ID: <CAEemH2detWVD6FY3HeHB152vKDQqW+2urHHyhJdi4whb26=Wbg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 6/6] tst_test.sh: Pass used filesystem to
 tst_device
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
Cc: Joerg Vehlow <joerg.vehlow@aox-tech.de>, linux-fsdevel@vger.kernel.org,
 Richard Palethorpe <rpalethorpe@suse.com>, LTP List <ltp@lists.linux.it>,
 automated-testing@lists.yoctoproject.org
Content-Type: multipart/mixed; boundary="===============0096826363=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0096826363==
Content-Type: multipart/alternative; boundary="000000000000f93e9405e76f51ae"

--000000000000f93e9405e76f51ae
Content-Type: text/plain; charset="UTF-8"

Hi Petr,

Nice work on this patchset. Thanks!

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang

--000000000000f93e9405e76f51ae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Petr,</div><div class=3D"gmail_default" style=3D"font-size=
:small"><br></div><div class=3D"gmail_default" style=3D"font-size:small">Ni=
ce work on this patchset. Thanks!</div><div class=3D"gmail_default" style=
=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"font-s=
ize:small">Reviewed-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com">li=
wang@redhat.com</a>&gt;</div></div><div><br></div>-- <br><div dir=3D"ltr" c=
lass=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wa=
ng<br></div></div></div></div>

--000000000000f93e9405e76f51ae--


--===============0096826363==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0096826363==--

