Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C29606A338
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 16:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=Qsjc5mSS;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=DrH/r87C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792513371; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=u2ZT1mYqjeGyXGebsyNgyLWOtwVIy0cDxZZ4x+5rHmY=;
 b=Qsjc5mSS7ub4vwheVqEvUl/POKnDEGO1wkOdFgEXVmxpAtnoI/ZjoUxmMK/aYGYnX74dY
 0s7OoJFVxLVnxY2uiK97XxaK9V/B8zEsOwu1RHE0b8FYCuOB0sTb2rTONWzBFSa1T/yfmfc
 nIx4MQNz1J9Sxgyvkgm+rE0I1ZTbfsw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E590D3EAF73
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 18:22:51 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E7CD3EAF77
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 18:22:26 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A8AF460067E
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 18:22:25 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so2491697f8f.1
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 09:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792513345; x=1793118145; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BoB2sgnHJf/Rf/7BW8fY7XVU52QuUbGz+sPspef9YLM=;
 b=DrH/r87CRZ+QyFWtfgM8r8TtsjLQo1ax7g1axgEVM7Q1MjIYYSoAf2IDJ4Syn16Oy7
 kfdLGr1ayox7Ia85TwDDax2kw0UBvdrjKAhwmDKRH8lu4hvDWmTCznkD6KJaGy6+16w6
 kfP5QZCd8+jsEAz/rleSlea5bYgEXUYKk6RpkLyx5Clko/rD6b6KHTUbgPFQTSbcEKYl
 zibeO7p+W4bI9Uz3TmkgTiDk86hywQELJMzFzTW6XulNihgXLPXO4JxtkXEzu9o6IGxl
 rQfzuqHa49pVkenCH78W2wRIbBstPBNIrkHSBBJd5II4fPyEn1jWHDPwT3U6wv1fkeno
 l1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792513345; x=1793118145;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BoB2sgnHJf/Rf/7BW8fY7XVU52QuUbGz+sPspef9YLM=;
 b=yOdmnXb6zF8dRbRr6uD2kK2ShhOf5TPys5VEy3UP2L8l4X4Or1B9485AjUQiFK5mFv
 lUNMKBjJ/w3D/rutp9dbDJf8j42dj3/W+aKo9TvB2SENVHFFTkk09ZMJxvKvPpDIFfbQ
 3H/Kqu4AU1VjDkMwkkcwYMzEN7E10Yeu8vsQXM+t0gm+eDiREBQGJsxP6L7xE2t2GkIK
 3A5dltDzwAYoH/JG/GtJg1sca7k0flGPpeJ/wy88T7f/mVvWggagVfKU3X8DCg2gU9F3
 bgfExvmUBgcpVWUJo/ih1fUZ5iU18VtwyPr/VL/mnjO8ahskaXjsVaqcuL7Y0AhwReMs
 naFg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx3TiM1Xue32b9PpA2fDe54RDoLtYbhqscw810Fb6Znd2t6LirKh81pT6ImmuyhffMqjwU=@lists.linux.it
X-Gm-Message-State: AFq9FYKNBsszvNIVD8cRcUyEvZVix62OOgnrjL52cuQvPLWCgRusKGzd
 5b5YPjXhAVYc9mYpAC5XTVMoLZGK6h3LMwy1aGh/X5K5TpuStVOK/PThpBjXBtQu+lA=
X-Gm-Gg: AYBFou3p3QILuEleKEGzmxUHZwmswoFqfm8ZKNZ/6qTt/6ryuI4Vw5NpSG7I4FWGSDf
 xYE6V92smN36D6ilfjzVWul2eC0aBDB4+fcBvyB0UzqPZRupiT9VyXLYuVWh6J5l7oxdA4lB/v0
 gKPvGGJUFB6PJLqPYuDJc4J49MbSYyvKWJAqrLZjdOP1N2myCMZxEgP+TSfK6TI+at5ykCjiB1c
 VDHKqqvjSvxLhJS1VPqTLMon19lw8DtkL5cfYd9syc5vp2blcUjZDiTZB4KFcz4Fx8fewWJpB/W
 sUVjQ+/D4qVKCOP74nI3nQbplveYJuEryMg/DnMSmakEZbP5cKCCg+TdtnCjK8oXGWT/xegXB/l
 dumffYji3Ggsp/qOHvdN5Qsv2IrBXsGjf7VUx4/BeJGO1Shwh4FHTZpWoW4q3zc5Uz6jM4ZRTcj
 AlmyHq+L9td5VrHER9m2lc9LhojD0tMtcXBI66LZgSMRebLhMrp7mPtWwQn6LfyQbvRT5wylb/L
 Q0z1kOCy3aLszEi5iTV0chHCvQZajZN1Ar9NfS+2hU2UH0=
X-Received: by 2002:a05:6000:29ca:b0:48e:a9:9e2e with SMTP id
 ffacd0b85a97d-48e07bb315cmr17092069f8f.14.1792513343483; 
 Tue, 20 Oct 2026 09:22:23 -0700 (PDT)
Received: from localhost.localdomain (p50918b5c.dip0.t-ipconnect.de.
 [80.145.139.92]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d83a338sm7312097f8f.59.2026.10.20.09.22.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 09:22:23 -0700 (PDT)
Message-ID: <sw28wD0OsYmREOqziL1aTVSqvTXbsLQMPRwf@localhost.localdomain>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20261020145109.9255-1-linuxtestproject.agent@gmail.com>
Date: Tue, 20 Oct 2026 16:22:21 +0000
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cve: add pwnescape reproducer
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Andrea,
> 
> On 20 Oct 2026, Andrea Cervesato wrote:
> > cve: add pwnescape reproducer
> 
> > +	SAFE_FILE_PRINTF("/proc/sys/net/ipv4/ip_forward", "1");
> 
> Medium severity: CONFIG_TUN and the namespace dependencies allow
> CONFIG_SYSCTL=n. On that configuration this path is absent, so setup
> reports TBROK instead of TCONF; add CONFIG_SYSCTL=y to .needs_kconfigs.

This is valid

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
