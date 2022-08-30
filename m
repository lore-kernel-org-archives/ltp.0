Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40033C0502A
	for <ltp@archiver.kernel.org>; Tue, 30 Aug 2022 06:00:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 91F4A3CA5E2
	for <ltp@archiver.kernel.org>; Tue, 30 Aug 2022 08:00:18 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9251C3CA5C7
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 08:00:06 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 93743600849
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 08:00:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661839202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yrWh2y090K4Th6hpGQoidWnlAdVO/qTZxLHx22Ab30w=;
 b=IWnPg2P1WEgF7vrGJFGzaLNpv9zvVr4TTKel7ZmnbP0AtAZZME05ZT3H363pDcKie7yxYL
 M9Akh3yADcPLAwQ67PfylWz93Mt1L7EzEd61avt8rju+k2HUto2GwE6YFY+r1gnJmwqQRj
 0sUjJ7LueQEnYJHu47YjyWrvkRokS9s=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-449-jVkk1NetOaeBogE4GNjq5g-1; Tue, 30 Aug 2022 02:00:00 -0400
X-MC-Unique: jVkk1NetOaeBogE4GNjq5g-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-33dd097f993so163210927b3.10
 for <ltp@lists.linux.it>; Mon, 29 Aug 2022 22:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=yrWh2y090K4Th6hpGQoidWnlAdVO/qTZxLHx22Ab30w=;
 b=wTXJBQZkiH7NkbTN/Jb2SR7E1HioreB0XoKbpEnKynaWZmBD0Y3DFZrsrRY0IlqMsv
 UnJ8GzRGhFUsKmapRnkyfUoicgHhl9DKLDajcgwn7+t0A3A2KvpTZ1CPaQloTCslrH9z
 7M1pGdKFoU4go6aS+CwvtMUpdQ/t0B0DULI4LnoEZQ0ENSNpTPjFZqfZn0I7jPwcyHEw
 YjPdlXYcucTUY6l1KCThZYGIfk1sns2mzqvKL1cj4x0WMZ8k86zocfnqlP1ri+Ubx5n7
 R/O7IOLDI+2svzejbPd6at73+sEMv1FyjHhjrPbM3ZV3mW9b+CFyCdcq7rw0nVdYpoJj
 Z51A==
X-Gm-Message-State: ACgBeo1JjGRiEbugub9s40FaAWQPz0zkEDoUGpE03LoyXAh+Yt9/DyyS
 QfbJSqa94YXiVjsNPSpEbKInBYECjNV7X0dfxNR1uWRIga2OgV+DfTXFxmsvGw1dvGJayLY+RZR
 x8QRohfakQ4IiV96EXnf+UUz593A=
X-Received: by 2002:a81:4a04:0:b0:33d:ad51:8efb with SMTP id
 x4-20020a814a04000000b0033dad518efbmr13189713ywa.86.1661839199533; 
 Mon, 29 Aug 2022 22:59:59 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5lzyiMxk/CRCr/qTCbr1g3hQK7ban9ZJ52SWfHPohySlDDGmZg1horXu0vr/67ip22iEbJ5ejvp8P54SuJ8zw=
X-Received: by 2002:a81:4a04:0:b0:33d:ad51:8efb with SMTP id
 x4-20020a814a04000000b0033dad518efbmr13189700ywa.86.1661839199377; Mon, 29
 Aug 2022 22:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220827002815.19116-1-pvorel@suse.cz>
 <20220827002815.19116-2-pvorel@suse.cz>
In-Reply-To: <20220827002815.19116-2-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 30 Aug 2022 13:59:48 +0800
Message-ID: <CAEemH2c4DvnwtoVr+BZtHcX9cdvtoRKPWxv-0wUNdyP9W3=2zw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/6] tst_fs_type: Add nsfs, vfat,
 squashfs to tst_fs_type_name()
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
Content-Type: multipart/mixed; boundary="===============1737365045=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1737365045==
Content-Type: multipart/alternative; boundary="00000000000027327005e76f1778"

--00000000000027327005e76f1778
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang

--00000000000027327005e76f1778
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div>=C2=A0</div><div><span cla=
ss=3D"gmail_default" style=3D"font-size:small">Reviewed-by: Li Wang &lt;<a =
href=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt;</span></div></d=
iv><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div di=
r=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--00000000000027327005e76f1778--


--===============1737365045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1737365045==--

