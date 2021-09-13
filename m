Return-Path: <SRS0=2Bls=OD=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C276C433F5
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 07:34:13 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 567D161004
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 07:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 567D161004
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 681C23C22F6
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 09:34:10 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A51623C1DC0
 for <ltp@lists.linux.it>; Mon, 13 Sep 2021 09:34:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0DF9D200B8E
 for <ltp@lists.linux.it>; Mon, 13 Sep 2021 09:33:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631518437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hpcF+RG8ZBaaixIiX+KjF1WPUYER5c+p13wApCxwZzk=;
 b=RuV+mTWfI/HwYIqYLY1fqfX0NBQBO2w972Eq7CmD7uDlq0gAMcA7ZePXqEC8JdAmbWmyKm
 IyiDKt8z9jtDD+tiKokBg6JbU1x+Q2Leob6hwTAnC1KAhfb3SUDEl1UgtB/YsWrVlHnTkI
 +vYaCWRCceFRA7X4GPEpsv8s8/TEGsI=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-3OtdBhMTOqGKHqOo7KSyQg-1; Mon, 13 Sep 2021 03:33:54 -0400
X-MC-Unique: 3OtdBhMTOqGKHqOo7KSyQg-1
Received: by mail-yb1-f199.google.com with SMTP id
 j4-20020a258b84000000b005a203c5e066so11797219ybl.19
 for <ltp@lists.linux.it>; Mon, 13 Sep 2021 00:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hpcF+RG8ZBaaixIiX+KjF1WPUYER5c+p13wApCxwZzk=;
 b=TsBkFWEd/ax1xY4+hba0uyjtiq2f3SU5ZSxbdmMLufPsjyPKNMeihU45OCYRvF5ege
 T+2CSBOXIURYoaC6hVNJ0xSallILlbSq9n6uoOGB+trfJhcqlYLh1AS7VohkvNR/4o+5
 w4SxpZ2K5DOPrW575cpvNq8akesWwFjacFM3Ro1NoIHVgKBMeYRu9y8LyDfRd3IKmF2c
 DXbstTFR3Hw2SXzG9FGDyeoWekrHRbWKPFd2pQ7GWci4U/8ys9Av+BiKyyNII+8XpKo2
 KTznF2zHx3rZVIz7mh+w7E62wca2UCXlmj4OSvedqODDYv9bTpKRBC3xglqxR0XknSBj
 K2ww==
X-Gm-Message-State: AOAM531HHOU0umBQPYvleF2LfiwoXYahxoWskkAzC7npnX5bCHk93Ajc
 nHBuLLtXR2oKsygJbHOunGnm8BF8Y6GFMNyFoeFn5hRl1/emk+pqro+uhXavNMH1xstIst/ns4y
 SSAJ5DFjv5pYh9uc2nR9kED4sFVQ=
X-Received: by 2002:a25:2f48:: with SMTP id v69mr13325796ybv.339.1631518433904; 
 Mon, 13 Sep 2021 00:33:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBuDLImBPblx+4zbAlCKbQ0jJ4f9CFWca7UM6/3b6AuwDYIhs/YCJAmPikxxHRGB5Jr7rFZ8hwP2M+SB0AAmI=
X-Received: by 2002:a25:2f48:: with SMTP id v69mr13325771ybv.339.1631518433687; 
 Mon, 13 Sep 2021 00:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210910130820.21141-1-pvorel@suse.cz>
 <CAEemH2evPtStSndYb0viwt-+x+g4dB3FER366_KEjcRUn7pWYg@mail.gmail.com>
 <YT7wZrmi8Jc0YHfL@pevik>
 <CAEemH2cO31kSwK3=tk6krB8ZZYPPaP+c-+5D7FGRK2ofYSmbtg@mail.gmail.com>
 <YT7+UU1d3llds9br@pevik>
In-Reply-To: <YT7+UU1d3llds9br@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 13 Sep 2021 15:33:42 +0800
Message-ID: <CAEemH2cnRbgMYWdo5ym0MHW+npoVEcfup9+0p+kW46sJV7aKWA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/7] Cleanup sched/process.c
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
Content-Type: multipart/mixed; boundary="===============1994509583=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210913073342.6wtLfMrEuY0aJr6-NljF1J-erqM2SLRG9-PNjXiXDCY@z>

--===============1994509583==
Content-Type: multipart/alternative; boundary="000000000000af582b05cbdb7cb0"

--000000000000af582b05cbdb7cb0
Content-Type: text/plain; charset="UTF-8"

> Ah, good catch! I didn't check it's not a binary which would be required.
> I'll recheck it once again and send a patch to remove it then.
>

Agree, it has obsoleted 20 years, I guess it probably not much sense to
keep it.

-- 
Regards,
Li Wang

--000000000000af582b05cbdb7cb0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
Ah, good catch! I didn&#39;t check it&#39;s not a binary which would be req=
uired.<br>
I&#39;ll recheck it once again and send a patch to remove it then.<br></blo=
ckquote><div><br></div><div><div class=3D"gmail_default" style=3D"font-size=
:small">Agree, it has obsoleted=C2=A020 years, I guess it probably not much=
 sense to keep it.</div></div><div><br></div></div>-- <br><div dir=3D"ltr" =
class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li W=
ang<br></div></div></div></div>

--000000000000af582b05cbdb7cb0--


--===============1994509583==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1994509583==--

