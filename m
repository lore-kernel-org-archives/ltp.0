Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8847AC43458
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 08:25:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AFCE73E5B98
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 10:25:21 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B92673E176A
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 10:25:08 +0200 (CEST)
Received: from mail-qk2-x02.google.com (mail-qk2-x02.google.com
 [IPv6:2607:f8b0:4864:34::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4C7A01400DFC
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 10:25:08 +0200 (CEST)
Received: by mail-qk2-x02.google.com with SMTP id
 af79cd13be357-921382c469dso12112985a.1
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 01:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783671907; x=1784276707; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FQvA4HS1RHb6re4l5fX2v9ZgZh31OH8ptlkEb809+MA=;
 b=RQEXwp+u61vdbY1rIAUjfSbypCTv7vCqq8cHpwNNn19X+eWlhqCY53qmyk+UXaQxlJ
 MEc9dTlRJf6RtBZE2HoJro7JA5AUmbQydQ9r+TROD7sghxnngrrsbwI0dqdoZYDh8Dhr
 MzeVANY4nGk3WZN27CJUQM9eRsREss+c6KR1VbZkp9EQuP0dQ0f78eMLLu9sIjrD1jEk
 5U/D4iszwDytHwfLqGiR9PFSflHlYFHM05//AZblC75HYGRKNHygJMIneCMw4ygkbGnT
 QjBfs+VhaHkip/OQIfAUptsytaspqdjLZvLw3qiJ1wbZF/XbyYTf3eASlI5hTJyR7hK6
 toUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783671907; x=1784276707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FQvA4HS1RHb6re4l5fX2v9ZgZh31OH8ptlkEb809+MA=;
 b=PewMZM8XE83SQolKC8vSV+6CYKdf0INYXiKot7MeQhwaYmG1piW+tmcgwS1cHGszgX
 PHPuIU2vho7zBbl0qR0ncLTnFEESLsTBUsblIDT7nCIZzgWHZ96Dq1UnpgrK3qd/d7LV
 iBOJD8yg+Wmm5++U1qp8Q33j+GN85s4+9lIoTZNqTJio3Vq4saGWNj2lBpKolhYe6VXU
 R3BxG/drXFkQ1VedM+22HlGyjADGEwMDnXtiWX+aVpTwm8uaUe/cAU6Ta6hHjWswE4i/
 CUyvS8x3Qxa/23Sb/C+k2JtxZcGZ1yclBd649rRBZ88hbEbn0V3vy4iWmzeIKn+2TEFL
 WvTA==
X-Gm-Message-State: AOJu0Yw6OCgTiFb3dta5nTTGaa2ZKSgvNQzTVgl9krNLK5Rrpqj7IN1N
 IvyNlaa991cUMEpdP5/MkSAHSBCvpRMF0mhtiCfq2agFqK+KoRW5iN7BDxXjcsP3
X-Gm-Gg: AfdE7cm+f2CteQK53VcUjcqWJq07F5lwuyVbX4HnkLo7wrrM+nYzIi+8oQhjoml2usW
 UvctRtWohgBxYOSLKcVcgyEFLvs0eeBuPJxtgObac3uq5jCT8ZjYc9zUOutN3XxLjF0CEILudcM
 h1rUEGA2tom0ZLTF7QV3+IPkDjAPoW70qsBxHNIcgWOSwBv/7LYQd/4qDB8A9eNPb8zjijlSauB
 1NStEwUbrmOYzHh4K6dHLnsoxWDbiE8zdxnve2ryeYsdMb/b1RIunDsGp5uuP24Du1CoLFRksYr
 cHFW1Yt1DWy7UMCrSth0LeUMBjTz0MP+ipNTydBWR48IB+qaQCowxH4jmuvSoAPBZ8wbB1fqRrL
 luU99cdnsmv5MWZvwGdBR0inZd7nuLuonYe/yqEEeSZ3E13k3pP2zoHASZrBiDV3/NZP6otZvLU
 RyP4sBMm3nkKWJb3MAIXfgouogpLVTALboBA5Ri2nfG+LGunnisPPWozeA5ndduv0Vh+vQOY7U0
 fnDDO0jVkXDiVsO5iH9srGbC7VhsvU/zSj/9lU=
X-Received: by 2002:a05:620a:890b:b0:92e:93a6:4eaa with SMTP id
 af79cd13be357-92ecf67e9ecmr1051877585a.32.1783671906772; 
 Fri, 10 Jul 2026 01:25:06 -0700 (PDT)
Received: from
 runnervm5mmn9.blvezttv0b3ejdl4gomqurzhhe.cx.internal.cloudapp.net
 ([20.161.67.210]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92ee59223e7sm147098785a.0.2026.07.10.01.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 01:25:06 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 10 Jul 2026 08:25:05 +0000
Message-ID: <20260710082505.3989-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710062921.1145948-1-pvorel@suse.cz>
References: <20260710062921.1145948-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] checkpatch: Ignore USE_NEGATIVE_ERRNO
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

Hi Petr,

On Fri, Jul 10, 2026 at 08:29:21 +0200, Petr Vorel wrote:
> checkpatch: Ignore USE_NEGATIVE_ERRNO

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
