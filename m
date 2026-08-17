Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E093C5B572
	for <ltp@archiver.kernel.org>; Mon, 17 Aug 2026 06:57:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 512543C9D1D
	for <ltp@archiver.kernel.org>; Mon, 17 Aug 2026 08:57:45 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA7693C281A
 for <ltp@lists.linux.it>; Mon, 17 Aug 2026 08:57:27 +0200 (CEST)
Received: from mail-oa2-x01.google.com (mail-oa2-x01.google.com
 [IPv6:2607:f8b0:4864:30::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 985782002AB
 for <ltp@lists.linux.it>; Mon, 17 Aug 2026 08:57:27 +0200 (CEST)
Received: by mail-oa2-x01.google.com with SMTP id
 586e51a60fabf-448a12ddfb4so1233646fac.1
 for <ltp@lists.linux.it>; Sun, 16 Aug 2026 23:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786949846; x=1787554646; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7V1Nckrio9vZh1JTBOCHUrKS1q7M1YepDR0Twmwmhl0=;
 b=p5T2wrREL6dGH6dU0LA9oUBuUTivdSxwgp8vNColnGDm+4iWUXJ9KMIR7srZmuJ214
 yy237f8biI5Bf55PIKWw8lnl2Ekw0AT1Kx8RLdhR9TXDjhXiFLT9A8Z3lVTKByt1FZCq
 9aAqk61kXMyjMnw77SrD9HPPZzLgAOB6BZadMaQOX4lzh8BKZYWcnxniSh0U9ceI/0Sj
 k85pHhxQtVlZfy0/HzNctlK7wYdbjA8g1T9TCECPPUio1hYjHK5/zEWQza5LrsO7E/J1
 8/y6MA+dyze94Mc0ju8e+kwR8igAACU9G+ahgy1WnFOkt3bbIPpN353ay4PZL802aeba
 oFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786949846; x=1787554646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7V1Nckrio9vZh1JTBOCHUrKS1q7M1YepDR0Twmwmhl0=;
 b=GWif2qvx1ezbrtPTZzPi+7AnojXVwsQ9em5cXXES0QJTgXW3iDxYsxtyT5pn4gxrqN
 7XIoBSR2+5A5cS8m+tmMpe25EGbHZumOhmttZ+Re+Pu5oXkPA9w7VGFvXAyVjfug+eDg
 d70wdhffoUZkM9qJIFI6ou5GtEZtZl5X9FyiubSm9+TQR0Js6t19H2Kk+0axdcIH+5SP
 l/E8syj9m4llf2OwoHZbnZxjpFx6rL1E1VciYE7HBlqSJmJPUQMmNih7OR6n7lo9FF69
 xBOeoVD15WbHX6dkAco84zFd3Qik1B9sv5DXLQ9F2ZGCPWVeiwwqfd1z4qs7PjwVUd/6
 /c4Q==
X-Gm-Message-State: AOJu0YyR6kYJsyUVvRQ9j6C6vC7ZR2KTLdYdSXByxQqfuLKwiYABO8ZH
 EZjpiqmQfX+7mPRb/MS8t54Cw2xF2AfJRWDid6CiehjBjUlnUNBEmGlK
X-Gm-Gg: AR+sD10I9UzDlv8c5mWtCzp6kaeQpWtwT2IClaa0OGhqapmk60P/K+qxt02a8azGVD1
 xIF+CsMP3JIQ+BByO/OAcEL5dYiY7nCP8sTi/MNj52qHMf/qtBWTNdd5R1E/QD1CQh5ORQGaFsK
 uTpHN12BlCWAuTKLTJy34cE74VZguNj2R0Sif8r/lOCKu220vhhodZxNrYiVtXPRr9OgQq4B0Wp
 a3zwyM/oiHchoOfHr56reXB3v/dD0f80ngMQeTgi3w2VZ1gBrJIY/Gc2S9BhGMed7P9tuG86dwp
 utjRalYWJMmAh1M0Fc+pMn7n7N1LCrLMYXJzLh9QfPYMtn7MbDtunVDsJVqd1/ihalTmXVr17wI
 aUfcLWoJXV7JagRMNzPZFAo8Ye+seUMPPQ2+ODC1rVjXqFI/2AOM/xRPbG34VXdtg2faZLQgTxu
 IvzINXiDZ8+Lsnuwz5wPBt6nOWs79fEqRHva9GRmPKZqe4W0M2ezKht+d5tRvRxEGFdJ8x5v/8i
 DUcNKh74z56pDSMClOQ75d1i5tXN8jVfn77qF/UstO7l76UiVYSlXOnCTiBljWvwvXO0tOSGFuP
 NQ==
X-Received: by 2002:a05:6871:60c:b0:451:d77d:f2d5 with SMTP id
 586e51a60fabf-45e921d46b3mr19998067fac.13.1786949846112; 
 Sun, 16 Aug 2026 23:57:26 -0700 (PDT)
Received: from
 runnervmzvulz.jpvc0s5br4gevjsk3lvl0jg5mh.ex.internal.cloudapp.net
 ([172.214.156.83]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-45f22d72e97sm466427fac.12.2026.08.16.23.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 23:57:25 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Piotr Kubaj <piotr.kubaj@intel.com>
Date: Mon, 17 Aug 2026 06:57:24 +0000
Message-ID: <20260817065724.8951-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817064052.304786-2-piotr.kubaj@intel.com>
References: <20260817064052.304786-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] pmc_core: add test for pkgc_blocker_residency_show
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

Hi Piotr,

On Mon, 17 Aug 2026 08:40:53 +0200, Piotr Kubaj wrote:
> pmc_core: add test for pkgc_blocker_residency_show

> + * telemetry region behind these counters refreshes at roughly 1s granularity
> + * on Nova Lake, so the retries end within about a second. Two seconds is
> + * enough headroom that a sample which observed no refresh at all means "every
> + * source idle" rather than "polled too early".

> +	differs = TST_RETRY_FN_EXP_BACKOFF(second_sample_differs(),
> +					   TST_RETVAL_NOTNULL, MAX_SAMPLE_DELAY);
> +
> +	tst_clock_gettime(CLOCK_MONOTONIC, &end);
> +
> +	elapsed_us = tst_timespec_diff_us(end, start);

Could the bound account for the age of an asynchronous telemetry snapshot?
If the first read occurs just before a roughly one-second refresh, the retry
can observe about 100000 ticks accumulated during the previous second after
only microseconds of measured time. Since the retry stops at the first change,
the factor-of-two slack still reports a valid update as implausible.

Could the test establish a refresh-aligned baseline and measure the following
update, or add a justified refresh-age allowance to the bound?

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
