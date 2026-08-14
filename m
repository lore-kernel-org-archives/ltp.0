Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B759C5CFDB
	for <ltp@archiver.kernel.org>; Fri, 14 Aug 2026 13:05:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4B7F3C71CE
	for <ltp@archiver.kernel.org>; Fri, 14 Aug 2026 15:05:48 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F0BA53C6CD7
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 15:05:32 +0200 (CEST)
Received: from mail-pj2-x0a.google.com (mail-pj2-x0a.google.com
 [IPv6:2607:f8b0:4864:39::a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BDA0C1A0090E
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 15:05:31 +0200 (CEST)
Received: by mail-pj2-x0a.google.com with SMTP id
 d9443c01a7336-2d3a0a81329so11746845ad.1
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 06:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786712730; x=1787317530; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5e8GBtsmZG6NdpDlK+wWMreAOq2DEAcB6ao0h/IdT+I=;
 b=bdTfmEX+/gR22VIeWr1Us3VNRVc22CmVzvtQ9p80sVpKmh2LCRusn6p+MpfaTuu2yc
 VjItNOtx7Uip9hqivUbNDifKdZ0C/q6bk39lcBWAH0H7OiEJOPw3VarVRxhWu34M+mO3
 pV56IAa6G1513nULfoI8KWnhla340UHhBYHH+baPkahANmr5mTLo+EW1X2JGAGm/MPkF
 5p+pZ3mSffM6qYAOtKq4NsyrLEuMItYw08mm5ukUhKnMu/GFa090NhWhE3gQO6BjRRyC
 LeOWwAqiNic9F2rWap0G9W83D61YsWLpP99CvvztC+kvyBKIn6kurCMoS6ZYliQ/xC9X
 uoqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786712730; x=1787317530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5e8GBtsmZG6NdpDlK+wWMreAOq2DEAcB6ao0h/IdT+I=;
 b=RXtUBcgIWl4ERq/t0nKVFeSH12MPILw7Uz42qay/gxkN9jiRiQTS00edf6e+MBnXCw
 mj7wKo8c21GjVeLE/jwB7ZgXhzagraL6Krgn3C6YzvsR6kBgjEZolJ0xBpakzkngwvdI
 B0sXZvT/FRAo4+/UzYIPhTPniqz9olzCX99MamSkEbHQVWIyC0a3OhcKdAHyCFP1qZ1t
 FNbqtQAveshYVqQgZOj+AD2Kq4iDmCZaNUnafoR7d0D0or/2xMSFBxOX6yELShNTjTW2
 71x06FqjhcAMH6ma1UQ3mlEDLVxxXw8+j0IA7Sfsg4+rNhJ4z2PrC0OjLupIPTaqldQR
 tlWg==
X-Gm-Message-State: AOJu0YywnlncamiAVZPYos2hf7buODSCGyae36MAB0UeF3aSu17L6DEk
 YTWcnTV71K5d8FjE3MWuIOZ8wOErWHpAccan3egvRqK4LQ2wpoAX8pT+SU2twpxw
X-Gm-Gg: AR+sD12lvEr4hVRMG5vyVGFuzC1ec2tAWf3blRHYfT+1IKV5m0qVbge3q1DMLTefX3B
 O75Gmfy2vDx0c12x9dQbIwsgbxSeQElk1ohs6F15A1olwORhmJCke502IB9sSV5kokT0RZckD4R
 U4zN43JUT3cxi7Y+LGZ+Db504d3fNRdUEFwRY19hESTnlehyf65uK/BBmueK8FGnC2GOPfc0JlL
 ltNPwFas3hFdfB7ohCEIyEn6UJyXkYn7mpugON1v+OhLUWxFiAixJMRe16pLnGY5+xEbpcimD+G
 raD2AMF4Mo0lKlTQu40X3JjTc+dAskqXcA6lwPsd6kHi9mizw1xKRt1K0IpdKRlHFdFurfcQu/K
 ItYE73k1pmcbkvyBWFv9QOmdqb6seTAjXYvs++4x2y2aocWwOW9F/Wy886lECLOZ6hXjB780j0L
 ujX3KUGB8KEb2f0Xf77rlmpspDMGVCpBDe+Peuw00R8i0WNzX5TlCF2y/lth7frcKMf8w/aCqCO
 vHuV50x3tM8+E8wV4TptS6MOQk12l12y92ExUiyX1u5plJu7bHQEjEnErquRekYvepjR9vdE1Wa
 lA==
X-Received: by 2002:a17:902:c410:b0:2cf:ca89:4990 with SMTP id
 d9443c01a7336-2d3b0c9f12cmr66640305ad.17.1786712729987; 
 Fri, 14 Aug 2026 06:05:29 -0700 (PDT)
Received: from
 runnervmzvulz.sk4ncxdfcthutb4cvhnb1pmwjc.yx.internal.cloudapp.net
 ([172.215.216.211]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320ea8f9d19sm4810923eec.27.2026.08.14.06.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 06:05:29 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Martin Doucha <mdoucha@suse.cz>
Date: Fri, 14 Aug 2026 13:05:28 +0000
Message-ID: <20260814130528.8519-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814124943.36853-2-mdoucha@suse.cz>
References: <20260814124943.36853-2-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] struct tst_fs: Add flag for checking filesystem mount
 support in kernel
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

Hi Martin,

On Fri, 14 Aug 2026, Martin Doucha wrote:
> struct tst_fs: Add flag for checking filesystem mount support in kernel

--- [PATCH 1/3] ---

> -	       const void *data, int *is_fuse);
> +	       const void *data, int *is_fuse, unsigned int check_support);

Could safe_mount() and SAFE_MOUNT2() gain kernel-doc comments that describe
the new check_support argument and the resulting TCONF behavior? These are
modified public APIs in include/ and lib/.

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
