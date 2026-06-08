Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D90CD98C5
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 06:59:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D5E23E5A43
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 08:59:25 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1DF0D3E2744
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 19:13:04 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B2B3360018E
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 19:13:03 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-490ae94a89eso38831255e9.1
 for <ltp@lists.linux.it>; Mon, 08 Jun 2026 10:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780938783; x=1781543583; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AUpt/EToVTToJvd7YASG+3OoKZxNxbXoqptfVbb/HeE=;
 b=nW6ucuQsloW756Uwio+MEP6hFE+T52E/otTE/fzvHjnBR9RuFfHJFdXK2gmP1Brjjw
 RG/QFqqDQ563uMiF4a1OPT9bqQ27mZXPENOwEQpVgAGyNvA/5D4Xm+D0tvBJF8gTZT7e
 np+Ko0fbzPVYq91KTGvL2gq0d9w7evMGQtLvjsrmUGjsko5c6ydVRLb7Hpe8uJLpX8t3
 XXXkYmwbKEesl7a11RKd6TKoWeL9SYRvzK7ZI5ndUtOwqUkCNAfCwvqTMuI2Vco/y8Cd
 TVa3qF0yW86X1a0w3GrOLgDi9NVwkQKWX/KWBgRTU+L0ux3dLMiH2OH60GpEyyti/kGZ
 ZnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780938783; x=1781543583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AUpt/EToVTToJvd7YASG+3OoKZxNxbXoqptfVbb/HeE=;
 b=ank2hXzcE1vcdwZmD6O7jpIEvZcRuSL+Tb69yj0zAKLiCVcHiPNubtCAuBbzLwfvMd
 z1BHM74rjYqMp5q/wRrlv4vdb/bFIR2fKDsTJ0Z3i+Ql6VI/eLt9CC00J5Y6trARJeoP
 71hDbNdwLRSgSa7hlZ/KYFApJiY9SnNDYhjX5J55LWBF54Igp6/Rg923GME/nMnQFuAY
 5s9pWOGSQFjz6P2YRoVLIn2za0J9zv+Y7vENBE1IJkU9vGlDPanIFmGUE8cf+rJCkE81
 SN2KLaiTzUzzZHa/+urB6ViOgFVM0OLC3zH7u6xqJNKUrsJ8tCYg665ho5V0iCiCgTLf
 c4PQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9zpEQMgpkDVwmPyqIkUoGcX3WnHMRURCu4h8xLh8zgrReOvFCXeW1Hhc4XvBFMxzJoxsk=@lists.linux.it
X-Gm-Message-State: AOJu0YzHFYv76wNY38cqxl530LhRE3r3+kFbjHrZXzW+T9xZPGgB2tdr
 LLaRm/9CtUoOoAt5EBUlGINYukndrHpiFSC+rvzxI2k4DQZoRvSd21nz
X-Gm-Gg: Acq92OHboTXJ2La3srzr9U4rb5ZeIND6rYdQueoar0ozFq2+nP8Ey+tlUkRgRVRztsr
 SUyhZZGqakZeYxaJvVF2UMlhQzUS016PWWN0DN8Y+d0Enhc3SBGTxplq7O5A1rDxccby0sfjGBc
 f/+arQ9mFIok7prN0h1STNGVb6rvRZHhdRKvNzuRMXYA2GFV9/yGKAn2lUuWHLZg4Aud089IZCi
 zn7Hnb5LxlJ3RCeDdCOxjOIE3jNO4LKAnh/mJ4/vCjh+4MjbgNtXedI8JTCOHexuS/IZ43X8QAK
 wqpzs9mIndwdIsn5JGDoZaeGnurJwUpi8aoIAYfgG6cU9n1kHbmg+MizwZha2Hy3t4Aas1MVsIw
 XVjTEJDtLVvW5cL1YMdepZ31slpi3Gg7ocn3avdYwzPgefuFrYBMScZkaIkF/VF0M6s3ijJ9U74
 rPl+aWugPewNHgTamoC5Pm78mDUKyTvzlTo1Ny5Whn
X-Received: by 2002:a05:600c:458a:b0:490:389:7644 with SMTP id
 5b1f17b1804b1-490c25fbd78mr244360025e9.17.1780938782731; 
 Mon, 08 Jun 2026 10:13:02 -0700 (PDT)
Received: from localhost ([212.73.77.104]) by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-4601f351ac0sm97432933f8f.27.2026.06.08.10.12.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 10:13:02 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: andrea.cervesato@suse.com
Date: Mon,  8 Jun 2026 20:12:31 +0300
Message-ID: <20260608171231.1480447-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <6a26aa28.283787d8.1f1282.ba36@mx.google.com>
References: <6a26aa28.283787d8.1f1282.ba36@mx.google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 15 Jun 2026 08:59:10 +0200
Subject: Re: [LTP] [PATCH 0/5] vmsplice: fix some problems in my previous
 vmsplice patchset
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
Cc: jack@suse.cz, kernel@infinite-source.de, linux-kernel@vger.kernel.org,
 fuse-devel@lists.linux.dev, linux-mm@kvack.org, collin.funk1@gmail.com,
 joannelkoong@gmail.com, miklos@szeredi.hu, david.laight.linux@gmail.com,
 pfalcato@suse.de, willy@infradead.org, hch@infradead.org, metze@samba.org,
 rostedt@goodmis.org, viro@zeniv.linux.org.uk, david@kernel.org,
 ltp@lists.linux.it, axboe@kernel.dk, dhowells@redhat.com, brauner@kernel.org,
 netdev@vger.kernel.org, patches@lists.linux.dev, luto@amacapital.net,
 safinaskar@gmail.com, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 akpm@linux-foundation.org, torvalds@linux-foundation.org, w@1wt.eu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

"Andrea Cervesato" <andrea.cervesato@suse.com>:
> Hi Askar,
> 
> the patch-set doesn't apply:

This is patchset for Linux kernel.
(It is expected it will fix some failing LTP tests, among other things.)

-- 
Askar Safin

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
