Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C870C25B0E
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 06:22:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A41113CA1B4
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 08:22:16 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C7013C8CA7
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 08:22:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BF93A600126
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 08:22:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660890124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LLS8juOOj9cd2lhMUQf6/RT77Z0fWy8df8L7r8fqhkY=;
 b=NjAh5NKcU2hUc0Ya1M0xSD3CZqw9ILPCiNpoO8yetraJxGhGpAmVys24M8K7qGYf3pURTw
 d6ChXu8CDgENMS+viNfspFGHWU6bg2IUZXEpq2EQ1//t0IdALqAaexEGf5/jzqRLB5SftM
 G99JwuPo3xr6R7erQySEqGlwfTL0+F4=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-185-zLObxP4QMEii6KRhoDB5tQ-1; Fri, 19 Aug 2022 02:22:02 -0400
X-MC-Unique: zLObxP4QMEii6KRhoDB5tQ-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-31f5960500bso62439337b3.14
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 23:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=LLS8juOOj9cd2lhMUQf6/RT77Z0fWy8df8L7r8fqhkY=;
 b=4VpmtGY0AmO08TPPU4qqubcTtFLFDn60mRZNiV5WQfP5qVUGK4dZSTgQ8DzjfIA6oF
 utVCf7kOyhvATVVGcLe+St35KnHTj8oGiEVXwHWgdS11UTp3BbeIHYBwUeDJa+KBuue0
 rjjnVjO+HVwlBzGmbHPWkXDj+9sVLBRIqna/ommg+BbLWGvfUVQVp0vucGvlpuu7MSVe
 NGiwC7GKiMqUj3TJCCY8ZikX5DokWmg2p9ecGVXKKkJyI7aJTDN4i/kd3nbM4FamDXyb
 TvR/kz7OA7xBAasX/+afgPj27KmyTjc5fxmygvq1WyWrH0DrBzWLkJO5TghelBW/AvbB
 k/Xg==
X-Gm-Message-State: ACgBeo0xBHNJuJ0zg3vFHbzxFIHBcLuidmMbkt4ExNyPy8XV4TwOcyh0
 RwNOLSksrdVUkQzINLE/2mxAMOWQe8792IUK2IU3rIF/KlCWfBCp3NrB0u2rq2rvgY04lkjwyWE
 IYtnkzHWO56x5nR42SGds2r1IoUM=
X-Received: by 2002:a25:a2c2:0:b0:683:daca:540d with SMTP id
 c2-20020a25a2c2000000b00683daca540dmr6257402ybn.301.1660890122405; 
 Thu, 18 Aug 2022 23:22:02 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4TjJYbf5fLj9RxuOEKItB6zyS6rSmqUs18bvoS5xzbIaVZuLe8VO1iPGw+/R+iLKU5tzRN3qUmEIzw+JLB4TQ=
X-Received: by 2002:a25:a2c2:0:b0:683:daca:540d with SMTP id
 c2-20020a25a2c2000000b00683daca540dmr6257391ybn.301.1660890122087; Thu, 18
 Aug 2022 23:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220818095030.1964355-1-liwang@redhat.com>
 <da253a0e-d082-9329-3392-aacee81e6c8d@fujitsu.com>
 <CAEemH2cipQ-k1J7WEoNecqGJvDfXD2iz7zZOX+B9rv6oMkU5JQ@mail.gmail.com>
In-Reply-To: <CAEemH2cipQ-k1J7WEoNecqGJvDfXD2iz7zZOX+B9rv6oMkU5JQ@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 19 Aug 2022 14:21:51 +0800
Message-ID: <CAEemH2fVx4nHDt3y6tO7RhA-8gti75FTjy4fiAzP3d4dsiNMGA@mail.gmail.com>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] statx04: mask STATX_ATTR_COMPRESSED on tmpfs
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============0598131975=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0598131975==
Content-Type: multipart/alternative; boundary="000000000000bd07e905e6921db6"

--000000000000bd07e905e6921db6
Content-Type: text/plain; charset="UTF-8"

Merged, thanks!


-- 
Regards,
Li Wang

--000000000000bd07e905e6921db6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div><span class=3D"gmail_defau=
lt" style=3D"font-size:small">Merged, thanks!</span>=C2=A0</div></div><br c=
lear=3D"all"><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signatur=
e"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></di=
v></div>

--000000000000bd07e905e6921db6--


--===============0598131975==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0598131975==--

