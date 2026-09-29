Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9A3CA5FA5
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 17:49:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 29B223EA9CB
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 19:49:18 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F5363CD51F
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 19:49:01 +0200 (CEST)
Received: from mail-pj2-x01.google.com (mail-pj2-x01.google.com
 [IPv6:2607:f8b0:4864:39::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1D9D8600BC9
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 19:48:59 +0200 (CEST)
Received: by mail-pj2-x01.google.com with SMTP id
 98e67ed59e1d1-3a4a2517101so470174a91.0
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 10:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790704137; x=1791308937; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KLHL7/D6/Z+R01BJa5uFTzQ0KI6CiiDvLjzvCRU+EHU=;
 b=FW/Q4HTIp02c/d8R+Al9u7tSDHQor5Lw1rtBRoO0riqIvF3b9ivj2fWJQ6FryiHbd6
 ZyY3ZL9zWYurMhq0HH/o1bHA1a24noD6w9PH4k4bZv0DUEW4uPg6+74pXn31taHbI4uy
 MF+bo6CcjDXIh+FnGuw1+nqsqQmNRPx96hFHk6gRm0XZ0510PPMoKj/w8PEW6ltxKSSp
 GQo0fS6kIF9BmMDkRIi7Af2ImnUwhM64SMspjJTgD3AvS/eRTHCYZsZzRrundo55Aq6Q
 t2vRaDw9YQJei14xjd9zliBHGxKwZan4N6+iM9H66CFcI2bSKnIf1v606HBN8gaqXn9F
 klYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790704137; x=1791308937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KLHL7/D6/Z+R01BJa5uFTzQ0KI6CiiDvLjzvCRU+EHU=;
 b=Bc089b8Xs02TrD9lrVfG1mwv8dWLag5nPTIA4v5dreFJ7UoAOgYFmCjl3Ai714FmZQ
 srpby0uAiTFnfc2w4d5W4Y+EBTWi+3kX8RXNjEnHbjwmkOB8f95wmkrJGhCed5DLFwr/
 U7jMS03FgjtIeG6eqIqfyOSmq9I8aaGLyoDNfWVFE0y00A7opJ1ukgFFqZfk6o1km6Fa
 Sje5KM34Ns8BnneV9vFk0bjIlhZa2AwgN+vuSXGHf/nfVkG+3OLtwIA+xygOv3d2WJqY
 H5F7z394CVjXvjRue+Y6bR85GBLwb8bcjFim8CWtdq+3eOHJBId+720QFFyggB9GcLGx
 52KQ==
X-Gm-Message-State: AFq9FYJN1Kvcbf1TdgkOx74MmOEcILZSgwEVT1lewPaNU1wE5TDAbXJR
 h4BHdJQZYfpScN2ojUx/8hNDyT52dDRSQ4odeifqcurCWwavxLBkeUor
X-Gm-Gg: AYBFou1V3R0zKpDj3saS5R+ADUarGAW9E0eoKPEye4nuwFeXsRqZv5Usv1WuacRtLxb
 J9yVty/LnoATqTz0WvqDGYqqppzuBd2IKy+MrubUNuOKeFS929DccNSyJ9QaOH41S4XsoUHq56Y
 rAgo6/IrHcgfzjZHi1iCs5Kun2gOLMxASPOihEIoFgZ8dtpO5pIhQSCBvJnYMobXpiUQqt4v69U
 NwJapejAxuKlG1AagYmoZNT2r5Vw6sVqQWuhD3GTC0g7+qBrDYWslJOBEZFR2rvzWtHGGm+dgNw
 1pkVJVXVYhMZz6/0J8FBeP2MuCiuNDy7i61mJLm9NAGyVbnvnBAFcXPg2LBzSn+TOOkAMCgQ7mL
 mUYeMsfbSzmL97nGNwZMqp4+/ZziL2t+pkZ3Hwe0hTF8wh/Lym3/eEvTmWYOa4THpnVPKPW+y0T
 8fQAbvJ1LpGJqQ+y2DuEwqwer/A3g736TtyAm5g9HGouZFNSYXAc75WEEA0cW+GDE77B/cg1iI9
 KGc20HM2H+G6QCGDWxXj2yStv9mJ7/8eWIzk0LHj0ateUAo8Uv8fgSofJUD30mRgjrCDssn0NSV
 in3X4WN0OAk=
X-Received: by 2002:a17:90b:5830:b0:3a0:ca1d:b40d with SMTP id
 98e67ed59e1d1-3a4c0015fadmr100047a91.55.1790704136903; 
 Tue, 29 Sep 2026 10:48:56 -0700 (PDT)
Received: from
 runnervmtr4k5.3fxghdbni5zetivtyknzag4qyg.xx.internal.cloudapp.net
 ([4.155.111.103]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4bf24f0ddsm338931a91.0.2026.09.29.10.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 10:48:56 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Huaisheng Ye <yehuaisheng@open-hieco.net>
Date: Tue, 29 Sep 2026 17:48:55 +0000
Message-ID: <20260929174855.9020-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929111527.43833-1-yehuaisheng@open-hieco.net>
References: <20260929111527.43833-1-yehuaisheng@open-hieco.net>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugemmap10: Treat fd 0 as valid in cleanup
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

Hi Huaisheng,

On Tue, 29 Sep 2026 19:15:27 +0800, Huaisheng Ye wrote:
> hugemmap10: Treat fd 0 as valid in cleanup

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
