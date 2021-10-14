Return-Path: <SRS0=+Yfp=PC=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFFCC433EF
	for <ltp@archiver.kernel.org>; Thu, 14 Oct 2021 02:54:32 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8CD060F11
	for <ltp@archiver.kernel.org>; Thu, 14 Oct 2021 02:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A8CD060F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD7E03C12FF
	for <ltp@archiver.kernel.org>; Thu, 14 Oct 2021 04:54:29 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 06DDB3C0EC5
 for <ltp@lists.linux.it>; Thu, 14 Oct 2021 04:54:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7EC5D6012DC
 for <ltp@lists.linux.it>; Thu, 14 Oct 2021 04:54:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634180058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6VtdB/X4001vVx4sG6cw39eWzrDFGV5Z8FLITTxlIWM=;
 b=WPE3uHMPciCMEjPiMon+P8iYyoifkO24Y0AVxfw3iba4M7Bczib+i9X9GLHYCDXkUx9I7u
 vMf1cam5PNmyNPoPeb88Voi1Kf/GDo9ma9r+hVY3ypxEihcih1FW3xruKzmpAZnK/PlHUv
 BxY/znsbKqKHxIKRXFzE5JSKm7qtQTM=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-f3jI-GZfO7qZq-uvhAJ1pg-1; Wed, 13 Oct 2021 22:54:16 -0400
X-MC-Unique: f3jI-GZfO7qZq-uvhAJ1pg-1
Received: by mail-yb1-f197.google.com with SMTP id
 i83-20020a256d56000000b005b706d1417bso5451993ybc.6
 for <ltp@lists.linux.it>; Wed, 13 Oct 2021 19:54:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6VtdB/X4001vVx4sG6cw39eWzrDFGV5Z8FLITTxlIWM=;
 b=xniMqwIVYRob3Aj5ZlCCPjH3eXl+GUO5H5EmRjBeaTKvkwG1/6WoU8mEsmO6cR1Jeh
 pZJ574VM7qFeS09raxhuGuQj56pcaS8XHiqWCBNhhimRgOC3i7NeQGOuIEExLV7mrP3n
 V0AFkqqE+q51l45aATgc3egwf3oLoo+d7WDvw2UgNY1Nt4x3vg9YFdl5gnkD8gJOA6+e
 BzQm02Kry0b6GPDJstBnw8uDsFiadJpFDjlkZk00aWd2rnzoRgjiKQDqjNAVQrT8851H
 D6Q5Xj4ABRFJUEBZnQ/1Orc+e2xggLvSbPBRtJ0vllDj67li1W23qYQZC+vghpHJa/aj
 CCZA==
X-Gm-Message-State: AOAM530Z7EYqJ9Xtw5LD7Ifz/vEPiOoaNyBXwduo8GHFFXiFvRWh8pfv
 X4XPTTE8lR8cdEzyjMDuXAIK/1s9uW/Une9A/4Li9H8kc3waAYzHDbKfxBntXohZUH6gLOgNmvx
 dSdBjEco7f+tGAlzcYGZS0KKk5u4=
X-Received: by 2002:a25:d394:: with SMTP id e142mr3256928ybf.186.1634180055681; 
 Wed, 13 Oct 2021 19:54:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyReE+qdiiOzqE2P939XdrWmfzB0LkgOLojpGJ2+rgqpj9ZomutMpuzrZZKp/AAVm3JpT88EHjYftYO2EP4ovA=
X-Received: by 2002:a25:d394:: with SMTP id e142mr3256910ybf.186.1634180055375; 
 Wed, 13 Oct 2021 19:54:15 -0700 (PDT)
MIME-Version: 1.0
References: <1634177651-16399-1-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1634177651-16399-1-git-send-email-xuyang2018.jy@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 14 Oct 2021 10:54:03 +0800
Message-ID: <CAEemH2fGOw_joBfA+2AURQTRugOdSaSKC3dEWvAXJ_F5-mub1A@mail.gmail.com>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib/tst_test.c: Use %u instead of %lu for
 tmpfs_size
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
Content-Type: multipart/mixed; boundary="===============1971674265=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1971674265==
Content-Type: multipart/alternative; boundary="000000000000b33d1605ce473186"

--000000000000b33d1605ce473186
Content-Type: text/plain; charset="UTF-8"

Good catch, pushed.

-- 
Regards,
Li Wang

--000000000000b33d1605ce473186
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div dir="ltr"><div class="gmail_default" style="font-size:small">Good catch, pushed.</div></div><div><br></div>-- <br><div dir="ltr" class="gmail_signature"><div dir="ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000b33d1605ce473186--


--===============1971674265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1971674265==--

