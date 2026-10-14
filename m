Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E76CC6B1D
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 11:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791976922; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=DylmNHQ7ge6Y6S8qaxDFtBSlI7SL9S5qb75u0xXyaEE=;
 b=O+IO80kT8plbAjm+JhAX2GNxnpNnnPPm6i85h5pD1A9wTqJFxumqGPGVHeRK9+1jzhiWI
 kuS1iYhHn04pSBeB303ekdumi8Ppf6e40aisxsMUniCay1RobXeGzIeja0VJ0yeX9kbNtwl
 YjgP/T6qpxvyV9X4j6/BVrOIWwGnZkc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 304D13E9E3D
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 13:22:02 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D439A3E6C83
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 13:21:41 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A742F1000A50
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 13:21:40 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a02667ccebso28862105e9.0
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 04:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1791976900; x=1792581700; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UO2Z3Q++SKEIbqKFaZcvGOuJQykxsDYQXhEYyp1nf6A=;
 b=J/YkdJUsjGPgnNn7z0hvnYyimrBzlRaVN3PKYq57WLE+rR2HtefGxou2biS3a06FhQ
 NPTUW2j/Q0uJANGuRurYsEvto4vxS+p1uxDtQvhGUUpGPHZWZZyLWARIvXelJIOyVIhi
 ZavVdLLJKIz7qIlVAkWG+ZyyOl6ThC8nesBh7T5s6chMAP+SF1MBL77kzYTCtI+D1k5P
 y9PoRxUOo15404NGAj6jgIopRK0BDLuOsVrwAjBSTk+J1s7+tqeVxNk+7PdloZWvmKnD
 Kmx1sKjM3C1RWJVx0O6EHIBkdcc29e0lWaNyXHQ/fQ6qAradYQUR/cypKAvIfsE40yXZ
 RpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791976900; x=1792581700;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UO2Z3Q++SKEIbqKFaZcvGOuJQykxsDYQXhEYyp1nf6A=;
 b=1LdxWfQ4ZrTbsRLrWtaGZy6xwHFIqxKR07b8bakfdiAnsxIXv2adL3a2S+9alQOl4Q
 ijhcqxHg3CJ9axyy8P/ESii9kO0yahjLh42VvzOuiBBpoKMe3AdNNwMRQ0z1CJf/Ss4R
 FlqSuZVx4aFIG+n3+x80ewCA629xLFe9mv0in3tU5Mt0wDVBE2KGVzBWcGinwYCeX9qM
 kuUpEvW4Wir2ts6J/9SdF9Z69X2LCn8utyJ8+CTWPfpwiGxbpsPzE7PVBNQwjgTGwStU
 yeA8dD5Dy5UQ4rO7Pf3PQk2XO37RQqUeJH5K1cG1g0UdJbshnIWNKud0xtdDZa5Inbx6
 ozhw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwL42CLLPQeG0/dzTrAon2vZY8AaCAqn8tn4LynDJ5udg9oL/v0DWZXDWYt5nOHkTBvG2Q=@lists.linux.it
X-Gm-Message-State: AFq9FYLJOAFPM03UC00PiDK1bjFSmE3TYJ4Tt1JIfYzQDPOa4y4mBpBW
 l94Af5Y6BbwyeU7uWc8pCg7yRW2OZD6Z/sjr/VJG3YrN+wOJa6xquNNzQMdC9atzq6I=
X-Gm-Gg: AYBFou2Kq2TLhTkW4l43qKvbOTZcRKlOow8qrr8x2L0s3D4d0INrtYOgTyBShlll3pt
 l0pPwk+n2CNDv+lbXH3MxjG+KkSpzBN6+Rkj3cd7lRE56obbTf5uXoRlrXuXwKWu9tRPeW2yJGK
 jr0iNE+kH+rFqaFeh9auMuK7emxfFk6YMxOo107gw4yF/sKOm/32CFkOfdKg7pW8gKku+pYBZh5
 g9JSnWriXrNdgbk3yJJt1g1gpw0hYp9SZKSXrDoKdyMVrkEJBe7BJfNmzcSGKSNjtu0RCdYXVRN
 znpv+/0x1QR+WS2PEZW3jERkHipXhhS5z0g4/fTUQP68GrtszeMbQ9fGpQSpeBV1LYKle1UBXii
 V1EI8iHQkyBdXhogV0pEhGM8G6hvoZJmYybeyOyQtWSpbx6dAA3KCoVDwytX86aarVkEyt9/ilk
 8cRI+dSeMOK2SaAhrSUOfCTXcGcOaNcol88asc/WdW9Tww7sroOA+c+ZsS/7tXK3aPTVpPMryin
 m+8srMY4goymZF7FdPgaX7Bnlu0S/UaVceBsSoKepRiWhDvSvCkqXB5LKmYG5g2O+GrMsy+/sPj
 KMrmfJTSt0v1QOVLVElfBoSpEeS0oDuR5vbVnXpLUXSyEtl1PcQEqGU=
X-Received: by 2002:a05:600c:548e:b0:4a0:1aa0:7cfa with SMTP id
 5b1f17b1804b1-4a18e4aa724mr317977555e9.12.1791976899930; 
 Wed, 14 Oct 2026 04:21:39 -0700 (PDT)
Received: from p200300ef2f310000b60e2c8966d10a6a.dip0.t-ipconnect.de
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf135fasm388316705e9.5.2026.10.14.04.21.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 04:21:39 -0700 (PDT)
Message-ID: <Gfl0MKY3z0aW4TP6xXBGrxZBbSI4OkHzAN9O@p200300ef2f310000b60e2c8966d10a6a.dip0.t-ipconnect.de>
To: "Pradeep Susarla" <pradeep.susarla@gmail.com>
In-Reply-To: <CAGsesOS0RUqRxqWVnRvUUsBkj0puamEPQ1V2n-XmeFX1TayQBQ@mail.gmail.com>
Date: Wed, 14 Oct 2026 11:21:38 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugetlb: Migrate library and numa helpers to libs/
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it, linuxtestproject.agent@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Pradeep,

I usually join into hugetlp or numa related patches reviews when I see
really obvious stuff, the final decision is up to my skilled fellows.

I forwarded your request and hopefully other maintainers will reach you
soon. In this period we are a bit overloaded.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
