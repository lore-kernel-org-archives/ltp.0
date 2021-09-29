Return-Path: <SRS0=fXc4=OT=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C1BC433EF
	for <ltp@archiver.kernel.org>; Wed, 29 Sep 2021 01:35:46 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10CE6613A9
	for <ltp@archiver.kernel.org>; Wed, 29 Sep 2021 01:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 10CE6613A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C3F673CA09F
	for <ltp@archiver.kernel.org>; Wed, 29 Sep 2021 03:35:43 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B727A3C81A9
 for <ltp@lists.linux.it>; Wed, 29 Sep 2021 03:35:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 05673140122F
 for <ltp@lists.linux.it>; Wed, 29 Sep 2021 03:35:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632879331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FJKaKn8XlJmrmMcI0VJn7udpPiDqhDUGcryhO1QF2Dk=;
 b=hnEsvuoMRfESp+skW/JJ5yevrPdFr39Xmbj/KMhp/q7KT1aMH7jZBGYaTyw27f11H7KoUX
 vWdH4j6v3Iuyezb1TuIjgwbMJoFrP4nb2cawNfG64UtWaiGCXqmrjzTpFRswzELlBuN8y+
 VxrRfu59k3l/XOiKkVEbnC/Zs1LSQa0=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-68hwrNvLOpe0GC2YYFv2Gg-1; Tue, 28 Sep 2021 21:35:21 -0400
X-MC-Unique: 68hwrNvLOpe0GC2YYFv2Gg-1
Received: by mail-yb1-f197.google.com with SMTP id
 b5-20020a251b05000000b005b575f23711so1482321ybb.4
 for <ltp@lists.linux.it>; Tue, 28 Sep 2021 18:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FJKaKn8XlJmrmMcI0VJn7udpPiDqhDUGcryhO1QF2Dk=;
 b=1EIzzKbl7cPooxwgcG+1SnfX82Xk7N0T8vz/BrorDgqnc6K6N5b6dJiVS9ocodzXrc
 31PEO1TtqU/Aq5r/0FjFMaaIbQX2y5VSuvqhU6vJKAwlv9Qh8Rb2QFs+Sp1kwUD/NJDc
 o9WPSilAG2PrtYEleGBqh2TwPxd2tmOfT3MfkgGCCu4HfZEpmIzUPx23O5gFSEORwf1Q
 wvenDoI310FS9N+BZMSLK86iRBDBI9Sr/jWAHfgrlOKRaUT9JUdEP9wqoANhJZxaZQLk
 y+5Mi1Z3atuANxjWqji41MfBLm2XvlEmPAskRyExGhs8dh8M5RzWy3eYcFCWGpWmfFtQ
 KX6g==
X-Gm-Message-State: AOAM532s5m8wHwN63VkzbBAr7MmZc61rpd9HOlL0ZmNURBU6MT9RrmzX
 2g1XR5xbrTy5iMXJcJfE71DlT9yDtLr/pW19Et8db48YHdKuVmg3p4HED6coSR4SLKP3F1e5UgK
 fhuRCC6U4fbymDrboUi9/BbhcXNU=
X-Received: by 2002:a05:6902:705:: with SMTP id
 k5mr11079667ybt.490.1632879320400; 
 Tue, 28 Sep 2021 18:35:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRATFcpnh+vL9R9sf2e4bWtwCelO93lx4WOealMlHRXlWoozKe/44Yc/pkIEuOMBahwhm2shSDFQMoQKpy4xY=
X-Received: by 2002:a05:6902:705:: with SMTP id
 k5mr11079653ybt.490.1632879320170; 
 Tue, 28 Sep 2021 18:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210928134528.2397293-1-ralph.siemsen@linaro.org>
In-Reply-To: <20210928134528.2397293-1-ralph.siemsen@linaro.org>
From: Li Wang <liwang@redhat.com>
Date: Wed, 29 Sep 2021 09:35:08 +0800
Message-ID: <CAEemH2dqGrZnDbHDVse83pDxOpKSLCGkKZeqWGHa5DmiZ+0M5A@mail.gmail.com>
To: Ralph Siemsen <ralph.siemsen@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fallocate06: drop explicit tmpfs size
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
Content-Type: multipart/mixed; boundary="===============0132381567=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0132381567==
Content-Type: multipart/alternative; boundary="000000000000d7175405cd185791"

--000000000000d7175405cd185791
Content-Type: text/plain; charset="UTF-8"

Merged, thanks!

-- 
Regards,
Li Wang

--000000000000d7175405cd185791
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Merged, thanks!</div></div><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr"><br></div></div>-- <br><div dir=3D"ltr" clas=
s=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<=
br></div></div></div></div>

--000000000000d7175405cd185791--


--===============0132381567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0132381567==--

