Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A7CC19F2D
	for <ltp@archiver.kernel.org>; Tue,  9 Aug 2022 10:33:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 115C23C942D
	for <ltp@archiver.kernel.org>; Tue,  9 Aug 2022 12:33:28 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA1D83C4D12
 for <ltp@lists.linux.it>; Tue,  9 Aug 2022 12:33:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9000510006AB
 for <ltp@lists.linux.it>; Tue,  9 Aug 2022 12:33:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660041195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dsVSCPP4wskbi79Bkcx46xmMEBOjjRFL3EJS+b4VUAU=;
 b=FEQ38enrbjbiPWcyeiGagfyHL23gry1dNuvfLePOXDBUiHO0e6+HzbEGxTvpcXYeF6xwBC
 UCvGFsKBLfAsCCggpZUr+NoWOdfPxVHqQQjrR21DHhyyzUHHNHAtI7bAaohoUZ5DumRcjP
 vLbElWGrf26AoXHagjqEE+nvmvTLFHw=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-154--W-Kq-FoMe6Dd97qTitPnA-1; Tue, 09 Aug 2022 06:33:13 -0400
X-MC-Unique: -W-Kq-FoMe6Dd97qTitPnA-1
Received: by mail-yb1-f198.google.com with SMTP id
 j11-20020a05690212cb00b006454988d225so9481344ybu.10
 for <ltp@lists.linux.it>; Tue, 09 Aug 2022 03:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dsVSCPP4wskbi79Bkcx46xmMEBOjjRFL3EJS+b4VUAU=;
 b=NUbjeeks5WK8HRHF5zx2aB5UbS9EFsFAca7eNkQVzJGCQQNhWh0JDrW6aWnfSQnE6Q
 GOub923jKwoW79qABwwq0D2zoAwsam9iZCzOx7pE2KbAwEhzhFGRXTD45yC5tCQMJ8Cb
 Epa+HXxar/PMCTspkk9mnPcaOU8lLR+J/RZ6RLtgx9cDZJDVFHrGEINuUnCcXh8Ti0+1
 3enq5BgT9Rkpx4SQt1tWQdlbDFY5V+sB2tYkSAeHzCI8GEL9tGJ+3rdJDYc0eI8irfmL
 gZQ0boTioEKph7AT5gzrEK59JPDEjpFO0erdn9GHuD8N7pp0/IwIww4SmLfm0JMc0G9s
 j4wg==
X-Gm-Message-State: ACgBeo3L2mFyyt9xy+4xSlPp1dJ857/7t/RFvCzgiVlhoPvbmkxzqQrq
 WqUL2jgjkHFVdk9CxCeYMpreoW2JJMm/rehJn9PW6N7j1044uma2SgbMvILFnT5+pGbXqcsY3fr
 jIjT8yxX4VLfVlmFPSdAl2IEjKmo=
X-Received: by 2002:a25:2e50:0:b0:669:9a76:beb with SMTP id
 b16-20020a252e50000000b006699a760bebmr20164662ybn.597.1660041193375; 
 Tue, 09 Aug 2022 03:33:13 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4IIE7Bfcj4WI2+rq9wGfWnihKXIsKmzQ838i7s5HcpmUVx2grTWQOYPBvKxOGjd3a7ajfbSozDaHBK4cd61DI=
X-Received: by 2002:a25:2e50:0:b0:669:9a76:beb with SMTP id
 b16-20020a252e50000000b006699a760bebmr20164646ybn.597.1660041193141; Tue, 09
 Aug 2022 03:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220808113756.11582-1-pvorel@suse.cz>
 <20220808113756.11582-5-pvorel@suse.cz>
In-Reply-To: <20220808113756.11582-5-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 9 Aug 2022 18:33:02 +0800
Message-ID: <CAEemH2ftf1O2Vi-WWuLEcmiZ8sf6A1mXKX7pMCDNUNTTbun_jA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 4/4] generate_lvm_runfile.sh: Fix bashism
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
Content-Type: multipart/mixed; boundary="===============1031852056=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1031852056==
Content-Type: multipart/alternative; boundary="000000000000a150cc05e5cc756e"

--000000000000a150cc05e5cc756e
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang

--000000000000a150cc05e5cc756e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Reviewed-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com"=
 target=3D"_blank">liwang@redhat.com</a>&gt;<br></div><div class=3D"gmail_d=
efault" style=3D"font-size:small"><br></div></div>-- <br><div dir=3D"ltr"><=
div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></=
div>

--000000000000a150cc05e5cc756e--


--===============1031852056==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1031852056==--

