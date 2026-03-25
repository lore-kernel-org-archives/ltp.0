Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE00103A99F
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 10:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774435650; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=1M512MSDtn2ZJ2+asC5Xm4c0yEPULN9jSzA2tLISa7Q=;
 b=jccXPuyhZYmQrnSFgPXN6GJvZXmpvs5uUl929b+GALzQgkld6pZ+71ck+mao6kUxWrqEf
 fgrnfQvCZx14WwmhwN/K05WxAuFKOxbktYIoOHHai52NEjA/06zNlnzyZyEstm3eBUCjbw4
 +8OOo8r4t5RdzPOnHgLR3ZcjRN5SY1g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 082043E2FFB
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 11:47:30 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A17373E2AD6
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 11:47:07 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0986C600E46
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 11:47:07 +0100 (CET)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4853e1ce427so53080955e9.3
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 03:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774435626; x=1775040426; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=+QFk6ZnBlZ//tap8U2fhMQSj/s5VTayBty3cuJ5LAp0=;
 b=ZWTaKBPpA4zGLOceYbEn0XW5antbpE3iMCHHww4POPcayeO7u2NnGAZ+9tNGxQL1ci
 VcVZe3JWRsn63Fzb0gqbMk9GIgHD+koheapyEY4EUReZM1nbtRf8gF177NiPmVgUgySb
 0gJ5us7tIRJey5p0wQEPWodOOCRE/JBojvbyaPMA1Fe6F1wkrV+353YXLjadt9/d0pnj
 qRLXYEmOzwlC3BfyEWu32lCbKSvQpAcprlPpZT0pbMj2BvmTbKC7Px7vc3sy2R8HXA4I
 WBbmAJIN52n48iT1frJ8oyusXBNxxSmEKDBXIlwFuoQap6i4/abs3TzFkV9WvPPmD01a
 jvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774435626; x=1775040426;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+QFk6ZnBlZ//tap8U2fhMQSj/s5VTayBty3cuJ5LAp0=;
 b=lYrt+uET1fxfrteGdhhlmPuQtP08xWJ0oMn0bjwTCusW/FP92hRp9Le53W3sGQUTsY
 U5mfm9OZLUsWw3SYv3dUCE20CIXsuzMHpr0G/W9FiPALeHwDiuTuzHKhKwJf174zoBx3
 9IHSUjqb6liKd5zeoD/FQTYIetEycEpsTzVaqWkeZz7P8qD3YMRp7BCf3ncLNQ5rmpNA
 g+FY1RITEg2DMH51mXq07O1fMisbdMl8aATo7Z3qUBY2XSDGvM3vUW36bZYN94Hg0en+
 HRnSe4jSbnaz4YfNcR2JOGlhUUkdlzp5n2MSFKqXrmT8zkKFAuwUrzdWEXZf8+d2x1at
 m85w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCh8P0bIZoud0ugxtFmmT9Ie9hpqYFQsq0d4BMvbgcQwm/JFqjSkKyG3PTCAO9ugP6sW4=@lists.linux.it
X-Gm-Message-State: AOJu0YxKXBQeEkLelRY+/e2tu9LD5keKmwiFK1XHO1FRH+0W+aVrkhLG
 dsNM5RalUFZ6n77YF/JdlOMZAeCMvPZrVLoiditz5Qw+qnoTpZ4fcocM3PU0nStHQiY=
X-Gm-Gg: ATEYQzwxp3YjW3FLH4xSFiLu2hlcrZ3IHChrTI9XstZxJCTvis8d2lwj4neha34fP+8
 YKmLA6xJMfcGO7d6M18GXoqbfJY5FMKPuoSCPhkk+SjQDk0WqmOTZ8xtYYk8wnsmDum64e2gbgI
 xgXRq6aNV2uf02YtK5Q5HYRPn8CQ+iouD9NsCHexRHvxWfVovHYV2intSHRh9bUz5fSDn5VU9t0
 R6rLP/R4Reu65qynYxAyj4a+DgqPlYQNt1ewc0/nPm2/50TroKhCBi2MY2Wc9EopTE5Sk9csIbA
 Tm5nl6vSB3MslT3xHdPbggUR3LJ/+1SZZHNvWVOLCyuZPYJeau1UZ/VQEZOf+m5xfImL1dFIieA
 RNjRTDZZZEqpV+3CSdVqINXmaBH3WooM7qFb8f7AkVIKvKkZ9qLaeTYmp92ljwfaJ2ok2GACSg4
 Mz+ZHCcxVFubzgKb5R3WftEYqL1V4QuAuq75YUy/IAGVoujsRSRaEUafZjfbq2OoOvbZmAH/bPY
 /adybuSiZ9n21KlXL55X5mOkpBZXTqORRkVH+joyPRk90FpoieA6p0dx2FPEEHhccvhidSvVHr6
 Jg==
X-Received: by 2002:a05:600c:c086:b0:485:30d4:6b9e with SMTP id
 5b1f17b1804b1-487160564dfmr30465375e9.21.1774435626309; 
 Wed, 25 Mar 2026 03:47:06 -0700 (PDT)
Received: from p200300ef2f4fc9002ac0653bb49440e6.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48717341e29sm17594825e9.15.2026.03.25.03.47.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 03:47:05 -0700 (PDT)
Message-ID: <69c3bd29.050a0220.e1178.617b@mx.google.com>
To: "Jan Polensky" <japo@linux.ibm.com>
In-Reply-To: <acO7fmOx60tVMfIL@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
Date: Wed, 25 Mar 2026 10:47:04 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add compile_flags.txt to gitignore file
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Jan,

> One thought: `compile_commands.json` (the compilation database) is also
> commonly generated locally (e.g. with bear, compiledb), and not
> necessarily in the repository root (often in a build directory). Since
> the intent here is to prevent accidental inclusion in patch series, would
> it make sense to ignore that filename as well?

I think it's a good idea, thanks. Will send v2.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
