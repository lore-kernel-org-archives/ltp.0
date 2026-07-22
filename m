Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C18E4C4453A
	for <ltp@archiver.kernel.org>; Wed, 22 Jul 2026 19:21:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 855C83E614E
	for <ltp@archiver.kernel.org>; Wed, 22 Jul 2026 21:21:11 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 95ADB3E2B11
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 21:20:55 +0200 (CEST)
Received: from mail-qk2-x03.google.com (mail-qk2-x03.google.com
 [IPv6:2607:f8b0:4864:34::3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 14A06600875
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 21:20:55 +0200 (CEST)
Received: by mail-qk2-x03.google.com with SMTP id
 d75a77b69052e-51bfca7f85aso76409371cf.0
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 12:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784748054; x=1785352854; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B4DhTmPiWwsxP/oO+iP239KnKWQOWGTvoDix4DOQFj4=;
 b=sgI3prcRT5Df4dl/UywI0d7nV3aYIewCaXpGi6EYWqVm9qtL1ticl5HRr+4P046rxl
 EC/WwMy9HtRIP1LNxHPe9UFyw2cIIQvQnnrOyVsoGFbe6klWl7pAjejzCPbEu15MpUVA
 Ncf+UJI7g68FMGaNQQPP2sxrKImNr/djG9WHcauJKGn/s3xn2BOUQCRMu4wmjt88Jt0+
 C8CTdOJ0w218SLmygXf5fREwfk66fz8EUalAtKC1bCSEZES3TxP3rSD6Pg3cb9FLKkHu
 D3guZ/9XoAgWER7JNdARtpkU+nkwRbqnkK43NJ0lxDGiEMv1AKdr8AsEwyqMCQYT8I7y
 /bBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784748054; x=1785352854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=B4DhTmPiWwsxP/oO+iP239KnKWQOWGTvoDix4DOQFj4=;
 b=N35A7Tg/5VaCTdMKfg23/OXgIb7hZIGgUp9PqAcBY81Ms9KmlIsuIW2kCQltvRdzhl
 eC9dQzEaKSNADZxmhJGgs86U65/mP8JFvmJkyo2Lxjx8dnFicltAxhHqeeL7nA46mOh4
 6UoKcA0gwuVH5530twr5ZakUVkvfai2+pWkIP20YgD0JIBhYL0VykXaZw2t/KfEd+RFM
 cpkSZoygUFHWgYhMy28EiTMEW5WXH/ccbhHpq6zH+Fq1PPKzrMrxVbEuPx0kMDuCk9B2
 wSJXFwyOJobdmLNAkg+SDGL+fnVHN1dLBgkjzxUqiaDQAmL5p2A3qrI8N/CNgZH83y27
 ObWw==
X-Gm-Message-State: AOJu0Yz8DElS7YSn7hzqilkZ98+T9M75gnSFe1KbhO6UU7ZxZrdUw+TB
 orXLGbEqGQmwJdRYyu13ajC+gAbAM1MZ/IeGLc81sE9c5pfJe7pMgrF/
X-Gm-Gg: AR+sD119VvGnC7RLvTZJ+fHqnJIbutmcpNlwJhA/JnGzO7BZfsZyHMGbtelAO58M5q9
 Ac1Pl0M2Td8LYZIg/NnjcUo9BBkVNPKTbKlmgncwqmgxgcqmu0/rJL/D5B0S46aPRWysXwtTqZU
 cX+u3/jyeF2CHnKAtmHvL0x8NSEIszIWdzk7EBvBQFhX9sljrfC6en699Bayq+CMtJFUL+54tmN
 v7u/0vDjKBcfLEioRh7uUKwhbSNpbbL1EzXwCObuTfj7A8TzcjU4BGxh+zlUT6EZKs206TSOweU
 cub9NXnzwZBguy6LTWLMMJacBA/r5r59XstQ7RtrySL30e6lTUbJWlhvxzaGILJzTaOWN5hSAsp
 Pkbu+Jq3BJI4Zvhp04yLBC0Zbwb1WaNW0Ls2WH6HpzphxpNf4/xuMJyvHVgp9oYPAic1DITt0nC
 rFduOjNJT3U8AekAYSTLPjPIxwpOAp/PNeRo8srDx12MaqU/woGhcGvbkLfLBf523x7uwwVuy0A
 f2W816D3JYlTc9qzMc=
X-Received: by 2002:a05:622a:178a:b0:51a:8c86:bd40 with SMTP id
 d75a77b69052e-5213cdca389mr235064391cf.61.1784748053717; 
 Wed, 22 Jul 2026 12:20:53 -0700 (PDT)
Received: from
 runnervm3jd5f.okp1kt4cbedudkhwtsza4g40ra.ex.internal.cloudapp.net
 ([135.232.224.80]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-527d1032f5esm21313351cf.12.2026.07.22.12.20.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 12:20:53 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Brian Grech <bgrech@redhat.com>
Date: Wed, 22 Jul 2026 19:20:52 +0000
Message-ID: <20260722192052.3975-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260722181458.2230141-1-bgrech@redhat.com>
References: <20260722181458.2230141-1-bgrech@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cve/icmp_rate_limit01: Lower icmp_msgs_per_sec for debug
 kernel reliability
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

Hi Brian,

On Wed, 22 Jul 2026, Brian Grech wrote:
> cve/icmp_rate_limit01: Lower icmp_msgs_per_sec for debug kernel reliability

> On debug kernels with CONFIG_PROVE_LOCKING or PREEMPT_RT, each socket
> operation (bind, sendto) takes ~3-4ms instead of <0.5ms on a normal
> kernel. At the default icmp_msgs_per_sec=1000, the token bucket refills
> ~371 tokens during the 371ms it takes to send 100 packets, so rate
> limiting never engages and all batches return identical error counts,
> causing a false TFAIL.

Checking net/ipv4/icmp.c (net_init_ipv4_early() /
icmp_sk_init()), the kernel default for icmp_msgs_per_sec has been
10000, not 1000, since the sysctl was introduced -- 1000 is actually
the default of the unrelated icmp_ratelimit sysctl (a millisecond
delay, not a rate). Is the "1000" default and the derived "~371
tokens in 371ms" figure meant to reference icmp_msgs_per_sec, or was
this confused with icmp_ratelimit? The direction of the fix still
holds either way, but the justification as written doesn't match the
real default.

> Lower icmp_msgs_per_sec to 10 in both the global save_restore and the
> child network namespace. At 10/sec the bucket cannot meaningfully refill
> during the send loop regardless of kernel speed, while the 2s inter-batch
> sleep still allows full credit recovery (10 * 2 = 20 = burst).

Two things don't line up here:

icmp_msgs_burst is set to 50 by this same test
(`{PATH_IPV4_ICMP_MSGS_BURST, "50", TST_SR_TBROK}`), not 20, so "20 =
burst" doesn't hold regardless of rate.

Also, icmp_global_allow() caps the elapsed interval used for the
refill calculation: `delta = min_t(u32, now - oldstamp, HZ);`, so at
most one second's worth of credit (10 tokens at this rate) is ever
added on a single check, no matter how long the real elapsed time
was. After the 2s sleep, the achievable refill is capped at 10, not
20.

Neither burst (50) nor the achievable refill (10) match the "10 * 2
= 20 = burst" statement. This likely doesn't break the practical
effect of the fix -- less refill only makes rate limiting engage
more reliably -- but is the reasoning here intentional, or should the
comment be corrected to reflect the actual kernel behavior?

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
