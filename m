Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F30A9C624D3
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 17:42:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 44F293E93B1
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 19:42:50 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 550E53E93B1
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 19:42:35 +0200 (CEST)
Received: from mail-oo2-x09.google.com (mail-oo2-x09.google.com
 [IPv6:2607:f8b0:4864:31::9])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id ABDCA600D12
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 19:42:34 +0200 (CEST)
Received: by mail-oo2-x09.google.com with SMTP id
 006d021491bc7-6b136fad4b3so346548eaf.0
 for <ltp@lists.linux.it>; Wed, 02 Sep 2026 10:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788370953; x=1788975753; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6iksCnUiPGUfZHJ8/J8qR8LzxdLOqSCTawK+SdI+jxE=;
 b=qCMxDCqrwBI9qXug3u9qgkDkpoAyGwzLM/cU/VC5Nd7Hkan1Dbu8Reez6+HDE3Gl+l
 NhRYHkKo/V8RPXXpkvTsoe6rK1SEdyEqFO3MprY8pJOYoe+jwHvV77v5W/9lKMbFKNxW
 pSnYjiA44Ae/STU209Cq7ISCTdqAD08YMBEkr/FUo+mEeASchRnXpHtGolHIBOOnbWaw
 AgA+KMg+tDlE3emSGYFrQKyTIqCunO3N4vJsCTWNO3ZaTfS83MkmosXL4UUp8UxdutSc
 Q3V7BhbHaE2De4s292Ygfyw6c9s/esBpWW8FLp1hnbzOTHIlXvoxfVcoMxB6lWHyUZ64
 Qrxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788370953; x=1788975753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6iksCnUiPGUfZHJ8/J8qR8LzxdLOqSCTawK+SdI+jxE=;
 b=GmLNwFTvrluIl68M9sKAoQ76R/MU92QkMEQkUlPu3xp+exp0OsHbWsYm4sNBP1x11i
 p+wpn/OEFebBuQhF75xDe1s0CFVV/U9viAgREykmUeiQG02Z4utYWztUJlZhv7n1XaDH
 GVDsyqLZ20CT/CJdvIoI3Vyu/21C8YrwdWyBXGVZe0Mq76px2D2i15Eskvx/eBIoBxFP
 xcoIoz2RnqPAmfPXnZgJm7P8gxB2oyX0Iz2ptM9ggrUc6EtwgEJ2iOUceLNRQSAuM0FA
 1dF/KMwtoipqzvvovSED12wgMzUR6LZHtMfW+HNYyNMNretlEq1YTI9UKNQbU+Q/K8qG
 D1RQ==
X-Gm-Message-State: AFuF++luOHsm9SX55KrMCbiFzhvuzHA/ywfn9AeNPoF6GvhwBEWQ0HFk
 ZS+YRX9yfsiUm5KOdCw5jdN19GJkolikU5bhS6wuJOSexy0fVoyRFC4zIR4mivi1H6Q=
X-Gm-Gg: AR+sD133e4O4pzZkOtvIrDdPxUKTylIgimojduAMLozJBAxzA7Ex0GfxsXFJ5evlWIc
 N9TiSyVK1VuhI8DCD8NFSW4vr68DM/i+xQXjdJnOMQ5UTUucOEdx2Fwooi3UiORP7XnaBGIWwV7
 bTofri7fZy9A7GoKkiE4uE3PweVMb6geeJhK6xg4DNt3ZPL8KFwfHxJGfynq5S+ckyhe9NFRS5C
 qTC9Cz7kJVkmGXZj7DtNh3Pf+jGKDyOlmElbjXYIuLNM3XBgYNhOZ05EXf2J/aYzgb0PkIPz56t
 BuPlfR78Yx17B2mI2BOrt6CDAguML27XNvZ9hAsl4JNaO7Ldw+IfLKi+pX/aM03E6gigtr84gUC
 hVdbVVEnyRl46X1IPne07C3Jj90W9ZDC6VqFzdWPcz+6uKIRMX9AtqS+a5xX34fCBM81aXChJRi
 3vU4mzQYWX3jMlylPc5wn7oAcbe8jchWeSVqDC6YkkZE/p59g+0OpRpSAkHgYPWgQrheMjPc1v2
 N2f4x1YcQTOgGzIOG1WkvhgEFQ+8dZxSHUwdTdwd4foj5cQKjkeOqeoB+o24bMmRiikksaQMhYw
 hJ12LY4LRwo=
X-Received: by 2002:a05:6820:609:b0:6b1:39b1:80ee with SMTP id
 006d021491bc7-6b4817383fbmr4920644eaf.24.1788370953055; 
 Wed, 02 Sep 2026 10:42:33 -0700 (PDT)
Received: from
 runnervmgx7h7.1ffd5xu5fasuhmxhcl0sq2twxa.gx.internal.cloudapp.net
 ([132.196.32.66]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b40ec2eb8bsm2994682eaf.11.2026.09.02.10.42.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 10:42:32 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Avinesh Kumar <avinesh.kumar@suse.com>
Date: Wed,  2 Sep 2026 17:42:31 +0000
Message-ID: <20260902174231.9025-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902134019.163296-1-avinesh.kumar@suse.com>
References: <20260902134019.163296-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/ioctl03: add IFF_BACKPRESSURE flag
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

Hi Avinesh,

On Wed, Sep 2, 2026, Avinesh Kumar wrote:
> syscalls/ioctl03: add IFF_BACKPRESSURE flag

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
