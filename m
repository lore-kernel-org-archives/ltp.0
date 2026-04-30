Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C4B9FF8875
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 11:38:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 267733E65B1
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 13:38:36 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 72EF33E2622
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 13:38:17 +0200 (CEST)
Received: from mail-dl1-x1241.google.com (mail-dl1-x1241.google.com
 [IPv6:2607:f8b0:4864:20::1241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0B9DF200C76
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 13:38:17 +0200 (CEST)
Received: by mail-dl1-x1241.google.com with SMTP id
 a92af1059eb24-12c8ccc7755so1167418c88.0
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 04:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777549095; x=1778153895; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5pwItLVQPAmsZljdEqdVwWIQBWGS95A2F6UqGl6G5Cc=;
 b=OVNu8yjV1oq5xk61WN39hvLlkavKPCfmoxExLpm37TNAJ2JNs/rCB332nkqCS8yrWj
 mUJALlMF+aknJd8Vuoy71NCHyHH07GYGP17p1zpo/yFJAKyWAYVqO5dBMfSy6ugJJ6i2
 zBRPQTvx/KMbZHhGm1aXbYcb0YTzghvdDBNgO9R3jY4+YN5bYVKAtmLi1Gr7UsU74kfG
 WTloP9FCroLXqVH4BPyUSH5aMXPWMq7vaZYPpXpLgLwaW6zvQLxK48kK+vFWD1JdywkB
 nihX4gRdyF/9mPdYmKyEdbXZxNOA0VD7rUf/I2pJNVKP3mgbUXmuE0CKrd+TLsIlZEhr
 wPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777549095; x=1778153895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5pwItLVQPAmsZljdEqdVwWIQBWGS95A2F6UqGl6G5Cc=;
 b=SDZEn6np6wlt3K4srA6xzHfUG0dCzTnzL5Lv+FR+28ErISdCz8pSaTWXcIyDQNqbk+
 kVhke92sZxVRJt35GQrXMGeUH24Dh+IHZrGf/jlFk602NdsX7U4dUwj7kMbLM4e7B4Ik
 BRaWgZ7mHhisEjMSlQbGA43hG+zLinkGUeAemlIA2KuGk8xyK2iJn8Spxtdg3LCNViD6
 DxRnlOz2039I4v3YOpzCwR8VKpv7CFshYBSElZ0SMhZXvK6JPvf7YPmW6BQ1pemjISo5
 C7apaZwrpZFRSMQKtYSQRkaJDECoERTMCZtba4G6q0bFgfNSQ1/+J9kxdmFpZKoBOED2
 zNDQ==
X-Gm-Message-State: AOJu0YxG6GpZJcWNeh26Sqvn+NAzNNUThz321SBJjU9io9NJgXH+CYkx
 fHIKp5bEjnaQZuYywM22JQz57duL3/ULuYJ7S2ZKvIE0sZzSR6G8V9iK
X-Gm-Gg: AeBDieu1x7c6G1DMJK00+T02ZcBD8slSCscKV0KfYe7eRHdccQM9pZj2mRubRIqQ5HC
 RuLfyCFlAbGU7TWBR+l4idfQmdwP+rWKxpyOmKVXu/kD28YXRRjyBU2qbi0U5V+9BE+7AP6BUWE
 ldEsGhaueOzu0H0fMy2NoEgb8RQSpo11xc/rQWQ7W/3zsjm8+Wxjdv4sq/EI5XzRoVvWl7Fesqb
 uLoSornQvwv9sMAM0lFlHMG26Pfr+7a1OlEgqD+9twQkI/AYzMDiG7kE29Def4k+OLhqiNWRkcs
 Y+5fPn+1mMmTlFWeV8/yofDEIbny5MZ9JN/URy5lAMDjkq2sZpMdP9Us0JaxvSn5NGEFNW2QVAx
 nsjgg8pq+WTuwNBBP7iC18XB+CX7KksD5qNpECT/SDSp2oc/BXQeMBeiQQ8Vxnm6UTFYsyHwnWI
 MG2RoMDfh8zBlbWsA1VLFqCs92scToD+tPosmfptx/TDMf2HQ0MHw1BW6lRU+L5lvbWuxnV+hZR
 3Gj/QW7Oy/G1yQwbu+e6y6CI81Ds68ElEOJ1lRFo3A+farKvEvm
X-Received: by 2002:a05:7022:6289:b0:128:d3de:c9e4 with SMTP id
 a92af1059eb24-12dead1ade0mr830645c88.30.1777549095170; 
 Thu, 30 Apr 2026 04:38:15 -0700 (PDT)
Received: from
 runnervmeorf1.e1l4ph4qrhju1ov0vk0vbxsjaa.dx.internal.cloudapp.net
 ([172.184.174.114]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12de31ab65fsm7133453c88.0.2026.04.30.04.38.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 04:38:14 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 30 Apr 2026 11:38:13 +0000
Message-ID: <20260430113813.4009-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430091956.10915-1-chrubis@suse.cz>
References: <20260430091956.10915-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: tst_test: tst_reinit() abort when already initialized
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
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

On 2026-04-30, Cyril Hrubis wrote:
> lib: tst_test: tst_reinit() abort when already initialized

> +       if (ipc)
> +               tst_brk(TBROK, "Test library already initialized!");

Looks good.

Reviewed-by: LTP AI Reviewer <ltp-ai@noreply.github.com>

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://github.com/linux-test-project/ltp-agent/actions/runs/25163012944

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
