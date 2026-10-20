Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EFE606A319
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 19:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UFh4sIIu
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A9993E278D
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 21:05:12 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 91A153E7500
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 21:04:54 +0200 (CEST)
Received: from mail-oo2-x06.google.com (mail-oo2-x06.google.com
 [IPv6:2607:f8b0:4864:31::6])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0C4971400777
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 21:04:54 +0200 (CEST)
Received: by mail-oo2-x06.google.com with SMTP id
 46e09a7af769-8217177c5daso527279a34.0
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 12:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792523092; x=1793127892; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eI4Q+HWAcTj+eUNZBSUFMCIwzSq6lVslnwfdwj3PcUA=;
 b=UFh4sIIuRsHIgP/3KZczoeBcct5QE+JOUqohYUQ+bry2D0J+hmucKvBqMyAu+ARsHf
 gscjWamLWvMsHR15y5+QKOW2FoY1beJWRpYWOha0uFqHFMtWAgFsDp3TR7J3cYyDNtGO
 C9KWDFuxb8k/RSytdLaJVqU0lm85MSj1yjnM2BgScizsK5KEGXYpKrgnfW8s1Gmkd50z
 F/OZKfb51tlbYGW3eWhKLwBPgDhoZtaUXhmU6xh9QMKw6srjzyn5eBXdL+1MJpdOK7ZC
 dQhEfMEFSJQ0e/g6xzqQyy+AkxZT67BZsN9o8V4nTBoDlIqvYpV9te0PANp1zIcckLXA
 kF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792523092; x=1793127892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eI4Q+HWAcTj+eUNZBSUFMCIwzSq6lVslnwfdwj3PcUA=;
 b=YmlqjaW7VvnzJLd7bQvNY4AAq4jAhMtoUwJGjQXw+SpkI0Avr+ngXEeYC2pnfQ/TtR
 dI9Y3Fvz6IR3Rdu6WPhZ7wJFI0rCUE6NWfqR+rl1s7Df7V9FZNgUIqk7fdj+wuPjmCTy
 mcKshV8CpURHR8ugYjQK/NDmeUWXpG7QK/HPcU/+LOWu2oBvEF6ngJ41jFfD6KEj7HR7
 QqV0kz/GFfQeseYHb+sc/xoF897aerLx9YKE3dIacOeRkGNIQNAM6HBSxeZxd/PgsBlq
 lO86YZD1VtaKH/Ub99Q+INIGNMPVIO72QIxrT7mxlvMnXxwu2UMcDv71SADG3nRkTbfa
 N+og==
X-Gm-Message-State: AFq9FYLrzgcA9t7NZ3yOxdAL5u3TfU8Zp+B8CIX8+6+Ypqvg5u/q/yi+
 bVOj4a/1eh4MCQwQgMDHqznrLPaJJ9Kl+ZeCIH1HSGUwAxB0wfXyQ++K
X-Gm-Gg: AYBFou1m+5Tty4nV6x0GTdPQIEEXCpoG6r1rlA2w3txYA/c3eeHpZ+eddJWzWPWAJSq
 iebx3+n9/lwpozSSMrVzeNiuqQWfqZHGMBH0MPEv7IhwxHoXC+DvjIplVq3ZxhtJbMO7LIAsiEd
 KVJInKzaz8fhlAh0XRxE6Dl5kaN2T+I1d5eViV5cRCf40SZ9m0ZRvmJ/aav20iCInjiuuA2tutM
 pM4LhM97DCH7sEu9NMjLdYWpRM+QsjqyGe9LkLhea21GAzJcuNn2jhH3Qhy3KPkDZEkmd+Hoe42
 InPWfUqNyNCiZaJYZVJvag2WBxYoAEb70BeEK0OAvv75XoCdbq9YyRsj5EIwHSRvODpaLwHfxRQ
 BOL+p5XRyNjfRWYM0UWilBuy7NbOLv7d88gJYTKKfSuqRoKJIt2Jxd7T3sPDdXt6QtdK3wnJdHI
 e4x3oQSrh8fcdhN1gIB2UOffnat1V8PiF28l0itz8bKd2mqBLG6HazaQ2JAfgdYKvRHxYtE0vvs
 OrQNw7EwoluQKanYspiLqce9e9IsoKDg+IfPIc+yCnBB0FmVZaoXpps0YsfzpbMTFcI3BTGbLiG
 xd161o/fg5P5eCz+hlMwYw==
X-Received: by 2002:a05:6870:ac20:b0:48f:e0f6:c467 with SMTP id
 586e51a60fabf-4a757a7be61mr8719381fac.53.1792523091991; 
 Tue, 20 Oct 2026 12:04:51 -0700 (PDT)
Received: from
 runnervm8k3b6.ubskotnc0ogejgnjnab5l43iwg.gx.internal.cloudapp.net
 ([132.196.83.39]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a7d61ce790sm254257fac.11.2026.10.20.12.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 12:04:51 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 20 Oct 2026 19:04:50 +0000
Message-ID: <20261020190450.17534-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020-build_system_optimize-v2-1-b527ac7cf835@suse.com>
References: <20261020-build_system_optimize-v2-1-b527ac7cf835@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] build: Fix library prerequisites in testcases.mk
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

On 20 October 2026, Andrea Cervesato wrote:
> [PATCH 1/3] build: Fix library prerequisites in testcases.mk

--- [PATCH 2/3] ---

> diff --git a/include/mk/generic_trunk_target.inc b/include/mk/generic_trunk_target.inc
> +MAKE_DEPS += $(abs_top_builddir)/lib/libltp.a $(abs_top_builddir)/libs-all

Medium: testcases/lib already has a per-library ujson prerequisite, so
when ujson needs rebuilding, make -j4 -C testcases/lib tst_run_shell
launches that builder alongside libs-all's ujson builder. Both write the
same objects and libujson.a concurrently, allowing a corrupt archive or
a failed link. Serialize or deduplicate these prerequisite paths so each
library has only one builder.

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
