Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97116C44511
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 15:14:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A6973E5685
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 17:14:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AAEA23E2580
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 17:13:43 +0200 (CEST)
Received: from mail-pj2-x01.google.com (mail-pj2-x01.google.com
 [IPv6:2607:f8b0:4864:39::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 464E3100022F
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 17:13:43 +0200 (CEST)
Received: by mail-pj2-x01.google.com with SMTP id
 98e67ed59e1d1-38dadcaf0f0so1053249a91.1
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 08:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784214821; x=1784819621; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wGZ23OetxnQt1HT6cwy5fzRnsoD1dUtRj1D1ZvEIHjw=;
 b=LE//tSHePxGixidNrYDt7p3/rbGHtaWfWTTXXoqimYSsGRe7PmWM2JdisvJdSvROTU
 o0krmdJH1rFo7HCWS10HS10Ul4cjJTuPcwT+6osSQ9SdEgp2qPC7Q4uPV0EQ7QEVQaB8
 7f9virX41azEeKiVkBoHt+rfaqwx2GLvWAK0GUtyu+7SdZEvTAPHO9pW1aWBxf64GBpn
 gae37lw0ONmN1T9+xOa23b/Ruo5TIBwc4ziG16T3CHOEEpf54L04pRAZUk78EI+29yE1
 yGBJvlZmCFXm40ldI+XxT/y7V4PJYui7rZM/Ytbvy3xkuecVBWBaBkiBTUmM9cMV4OJ2
 2QVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784214821; x=1784819621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wGZ23OetxnQt1HT6cwy5fzRnsoD1dUtRj1D1ZvEIHjw=;
 b=SeQZ5fZO843uXDm01RBm0LEXvff7CLorD9D5LpuNSb1VrgRgj6ARWttON/BZQqhomx
 R/DLtsavAhSMo0hUNm0MRZvlJk4AOGiI0KDnVOU1vjmiLhN6B2xVRPpow4fbkil5+9eQ
 xvpi9Wo18jgeS28pAwrmnASGTHsiW0NQSQXaHKeb3fBXDOSZikBpIGRKu6h8WwQHxFQd
 T0DMcPq9uj4nZfn4g8kQWMBsKI0v6f9O5OQonf8kgGOpengjw9opyb6Y6tsSn22wGRzP
 PnqUoNea1DVNZEYo6ItGvwQhFOARErlLFpWVQFh2Lpy51GrmmERIlVUUy2YLVRbwkf0j
 r1Dw==
X-Gm-Message-State: AOJu0YxA+tne7Hsh7aGRCf5KpXTK9JMLif+dNd9bXQ7BppSG/Q+15iAk
 gRMhh+OKuoqW3waOV9swxiHx7nHtJ8wk7Nqw1sD+FAPgJC5VXABms7FT
X-Gm-Gg: AfdE7cnon4V1Mjgbhs+BFdmw8Z9s/l/g3ouECxEF4BAcivcvpMOR1gFz4yOIsBF3Om8
 z1gwPN9FF1P3z9NZhagPp5aP+O2fpPNOf2KYRY5XC4nymAbN52LALFbLzdM03mN7IzNNVAi7Khi
 LTqGknK65PGns7Z6wzBwDipKDJ1L9G6Lk3rwAMhUX2elN+CwSNQMf86IVU+iGF09RqqrBrwA5K/
 SxT0Zv3Lt3F9lfKf+8mil/8oWwdgfgm3QLGSpkF+9RVhNUguj7B57x9L5Dbz4TVdEk+CZx0dEIn
 bHem1CJ2APa4itlvqo/2gmP4Q/UxdZTnWzzrM9COu0p8Zt1l5oR6kmNXMh2UtrPQTRvpiZUTxyS
 FV9ExK3j+junBvlGZikIhitzPaGe2NCCuv/ojb5/E/ru9pi/WtrSktQORzj+OFoexUiEG7wJQDb
 CYrHml1hUTKXg01xnx1rijkNTdaIKoQBX2dDj1Nk1nsLXyQoJb044CRJB1eNvcZXmPS6PF7E7ZC
 AiZRyLmN8XwvM5UrWdygh2efhL/VHAB+Q==
X-Received: by 2002:a17:90b:2889:b0:387:e0db:bc34 with SMTP id
 98e67ed59e1d1-38dc7bbee67mr20216453a91.42.1784214821235; 
 Thu, 16 Jul 2026 08:13:41 -0700 (PDT)
Received: from
 runnervm3jd5f.sgaplscctz0uxe4tann0drhwng.phxx.internal.cloudapp.net
 ([172.182.225.201]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e6c2b17sm19284851eec.25.2026.07.16.08.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 08:13:40 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Kuba Pawlak <kuba.pawlak@canonical.com>
Date: Thu, 16 Jul 2026 15:13:39 +0000
Message-ID: <20260716151339.3940-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716132459.1042752-1-kuba.pawlak@canonical.com>
References: <20260716132459.1042752-1-kuba.pawlak@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] rtc02: skip (TCONF) on read-only RTCs that reject
 RTC_SET_TIME
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

Hi Kuba,

On Thu, 16 Jul 2026, Kuba Pawlak wrote:
> rtc02: skip (TCONF) on read-only RTCs that reject RTC_SET_TIME

> +	if (tst_rtc_settime(rtc_dev, &probe_tm)) {
> +		if (errno == ENODEV || errno == EOPNOTSUPP ||
> +		    errno == EINVAL || errno == EACCES || errno == EPERM)
> +			tst_brk(TCONF | TERRNO,
> +				"RTC does not support setting the time");
> +
> +	    tst_brk(TBROK | TERRNO, "ioctl() RTC_SET_TIME");
> +	}

The fallthrough tst_brk() line uses a tab followed by four spaces instead
of two tabs. Everything else in the block uses tabs only; this one line
mixes whitespace.

Verdict - Needs revision

Pre-existing issues:

tst_rtc_ioctl() in lib/tst_rtctime.c does not close rtc_fd when ioctl()
fails:

    ret = ioctl(rtc_fd, request, rtc_tm);
    if (ret != 0)
        return -1;   /* rtc_fd leaked */

The new probe in rtc_setup() deliberately exercises this error path on
read-only devices, so on the hardware this patch targets the fd opened by
SAFE_OPEN() is leaked on every test run.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
