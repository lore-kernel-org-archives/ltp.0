Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7F0C43458
	for <ltp@archiver.kernel.org>; Fri,  3 Jul 2026 10:01:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 706F43E72D7
	for <ltp@archiver.kernel.org>; Fri,  3 Jul 2026 12:01:28 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1AF573C5751
 for <ltp@lists.linux.it>; Fri,  3 Jul 2026 12:01:13 +0200 (CEST)
Received: from mail-qv2-x01.google.com (mail-qv2-x01.google.com
 [IPv6:2607:f8b0:4864:33::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B34FD200B08
 for <ltp@lists.linux.it>; Fri,  3 Jul 2026 12:01:12 +0200 (CEST)
Received: by mail-qv2-x01.google.com with SMTP id
 6a1803df08f44-8f0f56c2dc9so688256d6.0
 for <ltp@lists.linux.it>; Fri, 03 Jul 2026 03:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783072871; x=1783677671; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oY24cVAVz2MfUsKawrZraWwLiWVic1XUpqAZzoMAAa8=;
 b=Ne5aUPvACR0jychMnoBrEoCUYCtuy4o1HXi2jOC6e81iQKziqWtOwrJb8PwD3atuEt
 PCzIWpD/wHntaQp8GMfElqRIyUZId/GFE7wW18NvJOaRj6VrzR7d+r/NExuuFdgqeOSX
 OHm/IdFNdWTrl6wvSYANj64+TZuJV+CEgcxnYViGfD3Sm9Fs5vWHTqlLp8quFt8IXn/I
 QWf1xDSJn47dbQDYmwDyy9tEyAwO4be6jl999gZtWFoIhfHLPGt60rM1O60Oztb+Zj6y
 FtzwZk80scyBxX6ERWVgjA8gE5qyt+eS+pHXf2JuNEubL4tavwZ7ihAoq3LM3BrSc9cy
 QFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783072871; x=1783677671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oY24cVAVz2MfUsKawrZraWwLiWVic1XUpqAZzoMAAa8=;
 b=HP4WcuO4ttbY4CeB5etrJqSaKQwe2wHyFkrmNYom8yWVJBVIkKHLnDhv09FgR3Bzv9
 httKPhVZgvSpm8Vyr74wqwIZcmwpKpwhrKY5teKJSLuV/NrkDb0y58Ff0yRj2hCnY5uq
 pGEz5sHRI5RsXWZxRVp9pFtDd6nRz5TatPrTnJNXYJ4T4gFPT/XhN9c83ITTPapXTho/
 idzqgXfP2txPNCy2NRx9aKZ2UyIW2A78ZtcymtMx46VtbMwzNbqBUoKJk7q4fudRZ4Ne
 cvHzsF1NTBs8vixX6SiEDmHyGVirpJBLqojCWPoq76aUBfvjIj/Bo7ze1FIhl5rVDdyJ
 vCmg==
X-Gm-Message-State: AOJu0Yxpbuvtjzy7tTvuhlsGGK2v+aBGL6eP8Kc4r2+AKxzdwLVBLTZL
 Rdl2dy0nav+AOCCDi2tZwp0UKxUs58XQN5dDPrCW1vGiojGfBa7BFyCj
X-Gm-Gg: AfdE7cm+1xQsk+eb2+7xGHn2o1OXzt66nb1r0M3S8+H6TSuj/CayoOrM26NbEi3Lay3
 ZEe3Ggl+cK3IXUaxkVYSnVjcIJiLK5AMKlRQCZklewjj/D48xbEusnOVL0iZA0tJobCo1NcFuNe
 Wc8eIWGO6aVkGCO1eexaN1d7pDU5fPTPgFRol6JozpEy1WEhOJBf4lL65TljSTMBxGaiYWQSgC+
 lXAF0ju/X3Zx0FpxNVeZ8VcldHq/U+WNnnmM8DRn1qGVtXcHkWb9f0ftQoWsL+Y7Y2AxVyBn9jX
 4vdWSqvE3qsgR5nDDnyZPRDBKb5m1+tVHBRFiXGMg69a4hQO0oguJvARvrnpuDbOHJaEA+O+cdR
 5PIOuE/vEgiM33rw36mnQ6lq8AyssKZEAljAO1oieA4QhdnHj92m67Yqzx7VvaihhjcV50X8/qe
 pGDQ9+LDw9vZd3XcKpCr2qASyqMz3NRvz7J+ICjPaHzY/4EgXA2UYH60MuUIGjCcW1iFm/fKBRa
 +HcK9pkMSmyENytJ7YI28/tvTJNb43kA4wnQhU=
X-Received: by 2002:a05:6214:83d4:20b0:8f3:9d85:405b with SMTP id
 6a1803df08f44-8f3c6ec4faamr102250386d6.16.1783072870873; 
 Fri, 03 Jul 2026 03:01:10 -0700 (PDT)
Received: from
 runnervmkkn4f.zzosww5kenvepmod4gf1ivnhag.bx.internal.cloudapp.net
 ([40.76.191.135]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f471813f56sm51708226d6.30.2026.07.03.03.01.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 03:01:10 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri,  3 Jul 2026 10:01:09 +0000
Message-ID: <20260703100109.4012-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703-fix_memcg_stress-v1-1-93bd09a62446@suse.com>
References: <20260703-fix_memcg_stress-v1-1-93bd09a62446@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] memcg_stress: survive OOM by targeting the stressors
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

Hi Andrea,

On Fri, 3 Jul 2026, Andrea Cervesato wrote:
> memcg_stress: survive OOM by targeting the stressors

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
