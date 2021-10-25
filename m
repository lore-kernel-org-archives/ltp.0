Return-Path: <SRS0=uLVz=PN=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EC9C433EF
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 08:05:28 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A8F760524
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 08:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2A8F760524
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D3BAC3C653E
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 10:05:25 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CADFB3C26A5
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 10:05:16 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5E2F9600F58
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 10:05:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635149114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0+J0xqelC5XWDgdKNLEqlMh7pdSZX5xn5rKg/AYSpoY=;
 b=hzIIjIqkX0bt6QuRtcaheXnev3GIuRqcaCJgh+fKgO9L77cTZaw91iDZiB6HYFbje2fiB7
 0K84eQpJG00IiJQwgjWRnPaGrgqyPI5DxH/dFQd5T0+be9eFfuNlmQr5pJmyAVyJqK1iLI
 pU2HUwgaemxIYxWmZ0Og6BoCBEPqv2s=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-abIPBbX_Nr2-moG_whPFBA-1; Mon, 25 Oct 2021 04:05:09 -0400
X-MC-Unique: abIPBbX_Nr2-moG_whPFBA-1
Received: by mail-yb1-f200.google.com with SMTP id
 x15-20020a056902102f00b005ba71cd7dbfso16119831ybt.8
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 01:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0+J0xqelC5XWDgdKNLEqlMh7pdSZX5xn5rKg/AYSpoY=;
 b=Up5TixMp4sHUJJvhq5Wdc4OsKc9JUDD/8QdR1UZiTU7iUANRRELAffw60qbXeoyxEB
 afII4nzVzdhVPLco0leNSF2Ieqv4PGVVmt8W2CuMrm0K4UtwLZrASS3h8Q2XjaFI4M4j
 EmBS+mBmNdM83J1RwvRwhpxCPqXWqu4fEjEBvmhCyQT9ST9mYPWCpDeyhi7aaUgF9ZLF
 Ifb65rbn92favF02ACh0RHudpRTDC7I01Fk7ZEZaUar/PgmKipl9x/8nKDm1097atskK
 oS3EvRXe2cf176OuK5th/pJA2X+K6QNxGXW4Is3ix7QAc3z4/Ml3zY4e6wkdidmQRKoR
 K3vw==
X-Gm-Message-State: AOAM533frLPnQp0Fk1xMG/kH9P58dk2b3W/7tHpxfSq/eyh++UBdOrkO
 pmUlBOOxl5buO94sGXVq3pWcaoXiV+c9BWOvH9tPiRliOOjR2UUQiiz3dFeVR5hZo2GyyIRm35U
 PPANFAFWIGD7099Dg2AWyL7Ss4CE=
X-Received: by 2002:a25:7e46:: with SMTP id z67mr15366034ybc.166.1635149109026; 
 Mon, 25 Oct 2021 01:05:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzq9KQ5kRpWm0ST8VruKyjRWf6Oo4DmXIxzKNRcX5FmUlt8FmJOuJjRsfm5YdIRXBxNCYGAz65LhsbUQmodmyc=
X-Received: by 2002:a25:7e46:: with SMTP id z67mr15366016ybc.166.1635149108842; 
 Mon, 25 Oct 2021 01:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211022043806.19171-1-tangmeng@uniontech.com>
In-Reply-To: <20211022043806.19171-1-tangmeng@uniontech.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 25 Oct 2021 16:04:57 +0800
Message-ID: <CAEemH2dOJWGqji+2nYg8X9eKZfFeJPhn0pV2TX6UovS9M_=_Tg@mail.gmail.com>
To: tangmeng <tangmeng@uniontech.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] link/link02: Convert to new API
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
Content-Type: multipart/mixed; boundary="===============1323344498=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1323344498==
Content-Type: multipart/alternative; boundary="000000000000c9adb205cf28d122"

--000000000000c9adb205cf28d122
Content-Type: text/plain; charset="UTF-8"

Tang Meng,

Plz stop sending the same patch again and again. It looks
like an email bomb to the mailing list.

If you are not sure the patch being deliver correctly, you
can try wait a moment and check https://lists.linux.it/listinfo/ltp

-- 
Regards,
Li Wang

--000000000000c9adb205cf28d122
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Tang Meng,</div><div class=3D"gmail_default" style=3D"font-si=
ze:small"><br></div><div class=3D"gmail_default" style=3D"font-size:small">=
Plz stop sending the same patch again and again. It looks</div><div class=
=3D"gmail_default" style=3D"font-size:small">like an email bomb to the mail=
ing list.</div><div class=3D"gmail_default" style=3D"font-size:small"><br><=
/div><div class=3D"gmail_default" style=3D"font-size:small">If you are not =
sure the patch being deliver correctly, you=C2=A0</div><div class=3D"gmail_=
default" style=3D"font-size:small">can try wait a moment and check=C2=A0<a =
href=3D"https://lists.linux.it/listinfo/ltp">https://lists.linux.it/listinf=
o/ltp</a></div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_=
signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></=
div></div></div>

--000000000000c9adb205cf28d122--


--===============1323344498==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1323344498==--

