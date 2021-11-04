Return-Path: <SRS0=esfC=PX=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38775C433F5
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 02:24:27 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81511610D0
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 02:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 81511610D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 661C73C72BC
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 03:24:24 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC2F53C704D
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 03:24:14 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8DAB314010F9
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 03:24:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635992652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H6ANEaWHt82tTNW0Oqh8fx2HWQ6Qwi/rBej4R2hiKnA=;
 b=PwVrwOn2fc8IOcFj/h9oIzyQhduSRaZTAE1xlVE77wLh8Lze4MO2RMgUFrucynAgagd5mP
 d+bcZPnHZXF3TeYOLerZqHomkVFvIX+x04VoW/s7Y2ho4OLK/vUmIxtbrk5cgJDxV+wRmT
 LjQsuTXeHN3JYqPlOkPoeTm9ms4PwAU=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-zECTsflSMHSbDyQUdCIzRA-1; Wed, 03 Nov 2021 22:24:10 -0400
X-MC-Unique: zECTsflSMHSbDyQUdCIzRA-1
Received: by mail-yb1-f199.google.com with SMTP id
 q7-20020a25b007000000b005c1d1377abdso6674111ybf.23
 for <ltp@lists.linux.it>; Wed, 03 Nov 2021 19:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=H6ANEaWHt82tTNW0Oqh8fx2HWQ6Qwi/rBej4R2hiKnA=;
 b=dCEvwvkPxFTDNHh7fTlapFLisKeTB+8WVXgtJi1KHdsrwRdM4xHaX/iAA/VxJTOS3T
 VneZ6p5xL4ieT4FtBzqlZSpg9tYEG7nRh8gfXzb+QYsLMPs4KuBJO4p5AyXxOqaPIoDJ
 94dreL8Ve8GEncG8kKlj/i5w1k3UFVbEyIfYbAJbyouWDA4N//UTs50xdMwFhBX/Xqzq
 aHUXhavCwYGYvdSWKxIV3g5bOe+OrkYjVO5+95azG5QNoUsbGsiTtNKh5dMRl1YuByfz
 LyYCLpfOBDeBGK03oj0KK36Q4NBsh6EF70YYAgVr9aPWcknHv5ksv85If8WSeMeRH36i
 Bf/w==
X-Gm-Message-State: AOAM531ps6/MSpnYE4iBy+GsdsdjFnmyUVo1iKmldKVS/zPI9I0wkDFG
 xczUZtgtw1/BmCCieDTJRPIyJqxRsNzeIwP6dnoc+vV6MFMtPjKQLcXHqvKu2nP8QQPXoXHGe68
 KyJn5RCeLA1OPDF3QgqK9Xc5TGpE=
X-Received: by 2002:a05:6902:1543:: with SMTP id
 r3mr29966403ybu.166.1635992650250; 
 Wed, 03 Nov 2021 19:24:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxF3iQNrWzBR3S7khi9bafgJLQvqxXI9yeEDl/pKh0VDZcGdEmbNMFaqSve5cbLiEcSxfBKYQMzXXQsbW44L+M=
X-Received: by 2002:a05:6902:1543:: with SMTP id
 r3mr29966362ybu.166.1635992649746; 
 Wed, 03 Nov 2021 19:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211103235631.9709-1-tangmeng@uniontech.com>
In-Reply-To: <20211103235631.9709-1-tangmeng@uniontech.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 4 Nov 2021 10:23:56 +0800
Message-ID: <CAEemH2d2mtOO9Ssgg6AiTjbV1f2DisF8AP_4o+2FsoGq6bx+Kg@mail.gmail.com>
To: tangmeng <tangmeng@uniontech.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] getrlimit/getrlimit01: Convert to new API
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
Content-Type: multipart/mixed; boundary="===============1667233624=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1667233624==
Content-Type: multipart/alternative; boundary="000000000000be602205cfed3853"

--000000000000be602205cfed3853
Content-Type: text/plain; charset="UTF-8"

Pushed with tiny changes in code indent. Thanks~

-- 
Regards,
Li Wang

--000000000000be602205cfed3853
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:sma=
ll">Pushed with tiny changes in code indent. Thanks~</div></div><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr"><br></div></div>-- <=
br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards=
,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000be602205cfed3853--


--===============1667233624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1667233624==--

