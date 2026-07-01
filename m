Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F32C43327
	for <ltp@archiver.kernel.org>; Wed,  1 Jul 2026 09:11:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 320053E907D
	for <ltp@archiver.kernel.org>; Wed,  1 Jul 2026 11:11:58 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 79F6D3E627D
 for <ltp@lists.linux.it>; Wed,  1 Jul 2026 11:11:40 +0200 (CEST)
Received: from mail-dy1-x1343.google.com (mail-dy1-x1343.google.com
 [IPv6:2607:f8b0:4864:20::1343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 22BF61000933
 for <ltp@lists.linux.it>; Wed,  1 Jul 2026 11:11:40 +0200 (CEST)
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-30bc871ecdfso753610eec.1
 for <ltp@lists.linux.it>; Wed, 01 Jul 2026 02:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782897098; x=1783501898; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KWt7Nw3P9eL6R/MyfChMRT89G9R8UsnYtpOtOL7wnR8=;
 b=Cnlq3Gp1YoIJtVRTJ+9MsaiEYXO3uqxSA12RSkEEpwK0K4/lP7EbEe4PCvUgo9wNDq
 qIj6RMhqSUGxLfMiiYUohjy8JtKTsxIXO2HMCpv9JVE99RV2R2Z9Ni8anJGoFjvcV0tw
 ozR8zhWR1kkMrlEdjS3zRHRNv+IsdPpzzAfA6/rSt6vk8G32MufKS8IouKHi5SMV85xO
 la/qAM1oSJ8Qj6BZiE1M5QDPUh/EzCgOJ6/V2854MbU1fnjgCF/sMMFAL3Q956Y1UnEO
 PRYpVWgp2y1DwOxujNSGZzcZvmGcvTsw9lgirb9n5gSv5BF6Z03SGujv2NAXdTd8sW70
 74fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782897098; x=1783501898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KWt7Nw3P9eL6R/MyfChMRT89G9R8UsnYtpOtOL7wnR8=;
 b=GT7uVtvpFRI6QJKFqa7ucpBlHGS2xqapOmW1sZDZBlR2L0p6Ti4IkYXYVrIR/X9Nfe
 wsAVZF3pB0j2ACUDI+5IVMIC4yJbVIxNQqWcbg4evMZ4VqAFk3F1r3Hjx7rRzb4FoMqt
 5WaBNEHnacMZk8V0/VYzrtMNPLWBjfbPWosolgTutnTF5/5HBZaKIif7cgL2oJ0VBZUr
 2uNCOGGaImZHQbInT885rJNtYzbYt8a1OUa+blZcS0u66wn9+fNJCMGH++XocJmqy6Be
 WtB+H21gcq1LC/32ykg5hVaVh5ky+t1fvMQ7ZPpAu+zBsE3cKS4gdFtD2orW9YsLk+YE
 KwpQ==
X-Gm-Message-State: AOJu0YxHMhiWNrAuwX5iSWmNYP4Rs51sqKN8UbV2ZatSoR++QamibBs1
 Hse2CsPThjf5+D1kIDzOGBRSXThnvTPElQHAu8FWXeqGd/VVDn4w7QXnBMmCdNsV
X-Gm-Gg: AfdE7cnuCWyj2JInpPPg6b3ni4/vkQuewEVyILEM1WyMjnZol2xb4sac3jv01T8KAmd
 agsqTbAASujuZh9SRxD8Gry3yBEs4XX1o8Bo1dMml9uyUx/YjGNyryicIkbad/0yFQiq6yilj2L
 8Fat843g7l/ma70G4bqTRxyZMAzYtfsSku8cPDiYddYWTZPWviPMUs5sRd0+VgN6PwkQs+zTT9n
 EwBhSNDZIRrTJbLX1GCBDA4EpaU1vhSh5821h1bUzc+qSAcIE5J8DI5vBqgXHTGMmp34bA8PEuF
 acGWxJL04s+80JhOOWe03NykSLB/GnDLJ/X/ALdTQuPxY8tNh0HwcJ51zdLW37L4R68O/k65n07
 ioO/3DOvlPnEOblD0wZPBB7cB9C3nPPR9II82QpjxSPLo9YTXHXwyeDizxhvhdCfothrY5ptUpr
 eVyIHfNxBxmOHQNaPrQVWCk4EFZiVpxv7NP21nFd0/RUaNE989MDg7fWDHtNYsYbk1YBXVE+1nn
 uQP09Vd8cydmacG93LnwIJ9AwmE7Q==
X-Received: by 2002:a05:7301:2f86:b0:30c:1147:ccc3 with SMTP id
 5a478bee46e88-30eff349e04mr1115932eec.33.1782897098339; 
 Wed, 01 Jul 2026 02:11:38 -0700 (PDT)
Received: from
 runnervmmklqx.c5dam0qjnfsefkc3bjzldlum2d.dx.internal.cloudapp.net
 ([52.159.247.180]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee316bf4dsm17758660eec.17.2026.07.01.02.11.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 02:11:38 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Wed,  1 Jul 2026 09:11:36 +0000
Message-ID: <20260701091136.4083-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701080324.19270-1-wegao@suse.com>
References: <20260701080324.19270-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] statx/statx04: Skip testing casefolded filesystems
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

On Wed, Jul 01, 2026, Wei Gao wrote:
> statx/statx04: Skip testing casefolded filesystems

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
