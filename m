Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB57C982D8
	for <ltp@archiver.kernel.org>; Sat, 19 Sep 2026 05:52:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EEBE63E5FC7
	for <ltp@archiver.kernel.org>; Sat, 19 Sep 2026 07:52:31 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9DC1C3E4C14
 for <ltp@lists.linux.it>; Sat, 19 Sep 2026 07:52:15 +0200 (CEST)
Received: from mail-pj2-x0b.google.com (mail-pj2-x0b.google.com
 [IPv6:2607:f8b0:4864:39::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1AC80140006D
 for <ltp@lists.linux.it>; Sat, 19 Sep 2026 07:52:15 +0200 (CEST)
Received: by mail-pj2-x0b.google.com with SMTP id
 98e67ed59e1d1-39569e136f9so1133776a91.0
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 22:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789797133; x=1790401933; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bVVKUVKnoSqXpSf2WXA+wifuz5EVU2H4nBbDYP2aFaM=;
 b=OOwP9CMHuljB8jopxrgb41BgTyeaG10d0nFaMuHNwr9r2GwJeZ8lfr4v9aUDkK67ly
 ogoFWop8RpRqvlus2mIsw3LG5omici/kaSGVwftGQOinbC/zHo9pVcvy4UiLAsDg8kCw
 y6Os6Bg471vX3VwXyEIURaBTyrgfs+ISUBnQZCaxYqlnfnLXdiCzQAiy8dXv+BLMO+ro
 Ku2lPML4Sv9hRWDK6ydKaFwj8PH/oD8qOr8gU6k1sMM0t3CSh28XzULqIUg+c/0KjCt5
 2lS3XpYj/B8ekrCg4RKL4IYcHFn8DkQdd66vIcFRquySV8sjbYEr48SN6BcZUp+rxScO
 Yu+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789797133; x=1790401933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bVVKUVKnoSqXpSf2WXA+wifuz5EVU2H4nBbDYP2aFaM=;
 b=FT0+WiFjL7yB4T3GylkGvLEVGpAiu+6Pwh8F3Jltz0rDjRG5YuIQ/JHFiRsK/5Fm4g
 iJD8EHtR7dXz07elY2UdDBkacTtEzBFvYryEx2uiN5YThqAsv+I82vXrA7kJVorkCgHg
 tZuzwz4fjke5LbnAog8s7huG5r2s9LBd4vjEYUfvFNKgOf2H90SdXf3KGE6lAmHk78zd
 Kg1OBAlH8dnwbaRdCpDsACTIAti6ARVlYTzYqK7QYeADHj1nmYwH5OK7vKRY8KL8Qr+T
 0WFHfhLg3QV0eWGFe3Kdr1bn5hmgbOLwHeBqgpMyHEi0bpcY+iWNPzzABMCv6F8sDaaw
 098w==
X-Gm-Message-State: AFuF++mPrBGqPX+prxKJ5IzaurVJi5IHyqcDQIlscYcYtLjZrfZkOQdg
 51JTPUDcVsVgko7xRIqAVW+H4yJS/MDxnGtNSrbW+PFlVvaxKC7yly+r
X-Gm-Gg: AYBFou1QthSraXSuCqTUf0dnu0JKywQlI+EX3t0q7cc70YwKIHVotko96pbgN0/Wenm
 vHOhu6XxxIc0EdUXYZki4U7AkUswQcqZoKF/2GddR4oi6Vbc7BiWQ6sKR65GKOkPh7mbP8KqjuV
 RvrP0iDNxpSM43cw3OtKWuuJctOFi1TEvXuZDSKOCXOrn3uOFKker+eFh/IXn04+zD4Sy/tm9Yf
 6WBuBGoNqr+ycWTa+TmpSKzNLMj84+/2grLVwEaTdxEDo2MYJNM7sW1VQUrEBHv86tj0Ss9U6Ix
 loBbaFBopo+YW/7IsLlZcPTi5I+2AAxKf8Q77O7R9l9hwfwodTLP/ROraGyVngDFC0GhXCSoWaN
 CYCU0IfjDGA+2fm4LZEGSAManyBbcizXIMo1WYA3NFhzfts/E2wuH3ATJRSpIlMttkpu7zTpLUH
 RpqBeL1NAGGweXo5U55Ndue0bVDtAAr8wKxczBnEzTj4Ohj4yAY90fx7T/6hkYSTszE2CWFxfXH
 uDM6otCRWUuS2FhrnMCsPAVIXk5j+wxEJjsC6xcgXSSg4nq/CXD1+yVEtc0UPt4apY/f07/dyRq
 p9g9GtkUXBo1
X-Received: by 2002:a17:90b:4a41:b0:39e:6a81:5a94 with SMTP id
 98e67ed59e1d1-39e6a815e44mr2915867a91.40.1789797133167; 
 Fri, 18 Sep 2026 22:52:13 -0700 (PDT)
Received: from
 runnervmlun5p.r50tedadd32edku3f1y4ch5pzb.xx.internal.cloudapp.net
 ([20.109.162.178]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6c615f05sm2809004a91.15.2026.09.18.22.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 22:52:12 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Sat, 19 Sep 2026 05:52:12 +0000
Message-ID: <20260919055212.8607-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919015329.22042-2-wegao@suse.com>
References: <20260919015329.22042-2-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib/tst_uid: Remove spurious TERRNO from tst_get_free_gid
 success path
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

On Sat, 19 Sep 2026, Wei Gao wrote:
> lib/tst_uid: Remove spurious TERRNO from tst_get_free_gid success path

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
