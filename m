Return-Path: <SRS0=5Ww9=PQ=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BD7C433EF
	for <ltp@archiver.kernel.org>; Thu, 28 Oct 2021 03:48:23 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2B0960F90
	for <ltp@archiver.kernel.org>; Thu, 28 Oct 2021 03:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B2B0960F90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A5A0D3C6BB2
	for <ltp@archiver.kernel.org>; Thu, 28 Oct 2021 05:48:20 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 420D53C6349
 for <ltp@lists.linux.it>; Thu, 28 Oct 2021 05:48:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 52D971A01DFE
 for <ltp@lists.linux.it>; Thu, 28 Oct 2021 05:48:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635392888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tNIdBO/lhxbhKTaPdH1GSvo6XY+Yx77rHYU/167YqII=;
 b=ZOSSO1rm8Qs5Cgp5MwINKkhn/wwUBKiEgT/NkEP6RdVbkdWYolu2rsfXP0gTsrsS7SR9jw
 Z8vAmqTBkAltoOw4nXJhdJ75DZXh3XedEZr49HMENaXndfgXdIn6x8iW57gSA/35Iz7QWg
 4tTepj5pWis0ebwnbfaFbpNFB/XoK3s=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-hzvh2KXhOQisJ4p8uB40Tg-1; Wed, 27 Oct 2021 23:48:06 -0400
X-MC-Unique: hzvh2KXhOQisJ4p8uB40Tg-1
Received: by mail-yb1-f200.google.com with SMTP id
 i128-20020a252286000000b005beea522aa8so6933077ybi.17
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 20:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tNIdBO/lhxbhKTaPdH1GSvo6XY+Yx77rHYU/167YqII=;
 b=OhaHZBKwWOqHlenQEODQ75ycfgE6Rh/X+hPsjOiaWOOaEhHRDfZQ5ZviRxfq/RnDx3
 3uVNxsttFUdE1YPwxpZsSdO3bTohnM/WwwaOPZHvwJh08eeom29nUBZ+cE/a64xRcRD9
 xZ92tRDBlwGv8JWGL+fVQDgL27lRQ+nVp3gS0SAUipTW45IckdSbnTBDnoL3U5OhVVwl
 l8X05XlMrcSQTrfIDwUFVjhnh7eGxAUrr9bZmW4Djo8hfK1PJ0dLpiZCyyaMFqJyheRG
 0Rgb3DkrKiFXxMtCUf3sYFzIkVgTvd29SK+tyQ7C4LPUQISqFziRm8oWaOq9SqdVjwru
 lcMw==
X-Gm-Message-State: AOAM533OqPV2UVu7Y2lH02EDihEEI8MoDZptOuOfrwuBRL15/8q7iTD2
 MVBlti5mJHDs1Cf3N8IxYbgkIaprX/oec86B2DbdJk8lt7Fz99a6Y4OCgtuUeRqrV2VTqStqj3o
 w1mOiDXcgu9VeEhSeecJ3XK+VLfs=
X-Received: by 2002:a25:dc8d:: with SMTP id y135mr1912865ybe.490.1635392886232; 
 Wed, 27 Oct 2021 20:48:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjLwEowah5QIjGYlwqXj4HsjDx0B/QxSeESrw8n4stU9nw14U4LKNOmAyhkYa0nGbXZvbcZ1HRNdCoZCjyEX0=
X-Received: by 2002:a25:dc8d:: with SMTP id y135mr1912840ybe.490.1635392885852; 
 Wed, 27 Oct 2021 20:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <20211026061016.11751-1-tangmeng@uniontech.com>
 <CAEemH2d2nBXLS6F6EK-1R2JnRxGMd2VQge1ETwg6KZWrdY+i_A@mail.gmail.com>
In-Reply-To: <CAEemH2d2nBXLS6F6EK-1R2JnRxGMd2VQge1ETwg6KZWrdY+i_A@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 28 Oct 2021 11:47:53 +0800
Message-ID: <CAEemH2fyLYEiH1jwvW2m9fB_nBx_pZLazpOVnsNuSFzMMmL1Bg@mail.gmail.com>
To: tangmeng <tangmeng@uniontech.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] link/link02: Convert to new API
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
Content-Type: multipart/mixed; boundary="===============1910224655=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1910224655==
Content-Type: multipart/alternative; boundary="00000000000007a7b705cf6194c6"

--00000000000007a7b705cf6194c6
Content-Type: text/plain; charset="UTF-8"

Patch applied, thanks!

-- 
Regards,
Li Wang

--00000000000007a7b705cf6194c6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div><span class=3D"gmail_defau=
lt" style=3D"font-size:small">Patch applied, thanks!</span>=C2=A0</div></di=
v><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=
=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--00000000000007a7b705cf6194c6--


--===============1910224655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1910224655==--

