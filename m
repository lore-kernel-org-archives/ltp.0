Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB251606A31D
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B2FUZYee
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 820183D26C3
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 15:36:20 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 309353CFE58
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 15:36:03 +0200 (CEST)
Received: from mail-qk2-x00.google.com (mail-qk2-x00.google.com
 [IPv6:2607:f8b0:4864:34::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CD8971401102
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 15:36:02 +0200 (CEST)
Received: by mail-qk2-x00.google.com with SMTP id
 af79cd13be357-93e5da88874so63538885a.1
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 06:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792676161; x=1793280961; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k4CQcbDMGDoetph1jMtbXRu55Vz8saN2IWPTQhD51qg=;
 b=B2FUZYeerA50qu56A+N5Sum/RMNlCQKWGEoJ3bwXwy50RvV0zgg/navb9kAPYxLFd7
 KxdlpSc15Xu46Ea7TVFaC1kcwJQGAXvhSPOk/M5TNz/vps85t+soGTDPsgKCt1FcPBoS
 xfoU6Tjb+Fyfig8ZyuZMF1+jyNwWTGv6AoYl5W1KEFlf4v8OMkXW9VBbr2O8R44iDX+t
 tby3Hzx6HxwK0/eB0OpudoxQh46Noni8Nu+zEfLbE6byQCX1DFpkeXn/WhYyqwG6XMZh
 ML9kHgmwAUggLm2ZhtjoBqVaTL9MlgivX7qenz4Qpg4XZw+K4N2pDe1it/8xgQDi12zo
 jKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792676161; x=1793280961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=k4CQcbDMGDoetph1jMtbXRu55Vz8saN2IWPTQhD51qg=;
 b=GGDt+YgYlBAs5Xjpz86gOM6GlnIAd3f0GYRIBN3i7KJUm4JkKGu/Rkh+D8L1Yhwdaz
 tkZ0w4TSntZhi2LPnd7nJu8LPGvbTlSwgNLAkcR9Jeq/5bfmoyWqScKXDBUfvA7yXSd1
 sH+ktgMcMN5AbRBxTC9Hv3T7yngEWNuzPsngKQruRSA6rGxPmNsse5Ybcg+Yh4g16N2+
 jZuxJljj6H9NqD+BtuBkUsjWCRIMaulf+4MZx5zCw2alMQCyW4RlD3mDtiuR3Z8RVihP
 LkK920bf8yTIraOipYPyLriZ5Fe0jcGUm7VMDcQzeNUe5Q+8qcEV17WRqX2Ep5HhRH7b
 FwyQ==
X-Gm-Message-State: AFq9FYKpcHfjjE6XGgxSkwMrWYipn/2kRKXliZ9EuvGQsKZbHh7rto0b
 7Goi+hfnrBu7+5eu2GALVPISnr4L9xOIqgitsguXJpRWjbqMV7b1YjTj
X-Gm-Gg: AYBFou1EjeuQv9vzrHGTJmZKkUyxC33OCbzezxfrSOn3ykK16K7jjfVwCcFS/qW+SNY
 9LyIe5k0bUK09PZmVBE/FccE6QBtaxJe3+swuS661lp63ItWRCddOqVLuRsvgUQPtMDScOr038r
 J0RCu8z+VNbahorb1g6QJ2rZoOn/smsu4t7Rjc68qlNIlcnW9Nc5fmBA/1Sxb93y/phCIqdndMT
 asDPod+reBqV9lshmokES6FHwGe9uy6rcmCZ4iiPTpP2Hb8rSpgtJtGIyNAUxisYtvhMOocg0L0
 M6oQh/7ZdtRmuy/BRuE+xPTOMxqA45m1jdqTBXnk6jrpwFxV5SOBGKhaeYzaPZ3oJsu+J0zqxPC
 EEXOaHh1UK53ucQdEWPbvuRP0UN1AgC26FJo3MSibSQKMiznF6yp152jAw2SD9KyBbgrbdQ+Cft
 ZywAceR9EYxJZ7UKb3wO6sWmsEWy8HCmUKMqemLGmOvsBX8fJ9VQ4ukZB+fsXf9N3SvIf5XY1ye
 X0RWKkBEQNgxc4M9kQiO0ec39ClQtypsQRUEHit9XakJqJpZgHQHddNakyiJO261s8TRP3L9YsB
 +vMC246iStXftvVxgXf4ZKKTaxFJWnYTz4bK2cWl1yHJ7YF2cGxLtIwAmyO+onzKnl6p
X-Received: by 2002:a05:620a:6f04:b0:93f:565f:e46 with SMTP id
 af79cd13be357-93f57f936ecmr896433385a.52.1792676161380; 
 Thu, 22 Oct 2026 06:36:01 -0700 (PDT)
Received: from
 runnervm8k3b6.xoxzbnckc3tuvhtfp2zpexthsa.bx.internal.cloudapp.net
 ([20.83.175.231]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93f56dfdb2esm520997685a.28.2026.10.22.06.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 06:36:01 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
Date: Thu, 22 Oct 2026 13:36:00 +0000
Message-ID: <20261022133600.4532-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012060336.36147-1-kuan-ying.lee@canonical.com>
References: <20261012060336.36147-1-kuan-ying.lee@canonical.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] binfmt_misc02.sh: Fix interpreter with uutils/coreutils
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

Hi Kuan-Ying,

On 12 Oct 2026, Kuan-Ying Lee wrote:
> binfmt_misc02.sh: Fix interpreter with uutils/coreutils

> +	printf '#!/bin/sh\nexec %s "$1"\n' "$(command -v cat)" > "$interp" ||
> +		tst_brk TBROK "Failed to write $interp"

The resolved cat pathname is inserted into the wrapper without shell
quoting. With cat in a PATH directory containing a space, the wrapper
executes a truncated pathname and subtests 1-4 incorrectly fail.
Generate 'exec cat "$1"' instead, or shell-quote the resolved pathname.

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
