Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BEBC98321
	for <ltp@archiver.kernel.org>; Fri, 25 Sep 2026 11:21:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AEBBB3E9720
	for <ltp@archiver.kernel.org>; Fri, 25 Sep 2026 13:21:48 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D75D23E615A
 for <ltp@lists.linux.it>; Fri, 25 Sep 2026 13:21:31 +0200 (CEST)
Received: from mail-qk2-x04.google.com (mail-qk2-x04.google.com
 [IPv6:2607:f8b0:4864:34::4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3A34C600784
 for <ltp@lists.linux.it>; Fri, 25 Sep 2026 13:21:31 +0200 (CEST)
Received: by mail-qk2-x04.google.com with SMTP id
 d75a77b69052e-530e7b7a366so5377861cf.0
 for <ltp@lists.linux.it>; Fri, 25 Sep 2026 04:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790335290; x=1790940090; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T0d7Hdy6WrCQixBKqJEoX/rQbI/qoXqNnFZ1/BTEyBU=;
 b=bWJpvFnyCiTV58xPr0NbK1+u9ih1AmM3Y2GZgK3vW1ZSd9EA1o+MzFafHrZMwdUsQb
 GQdyrHXR0VqPYCNa5xIhsysifhrC+uH9xto9keUgjjQBO3umIDj/1MhVHontgzPs/XyH
 GNR/GFQfAV8xa5J32R1iNR1k7CiDxrYK5YZnJIaXp2SksqXli/kr7tZrDaDGtj68A9cr
 +6Qeg1b57+m8z06OYN9XxMcYFBqrn1WCne7Fv6eouO9OG2jjAkSfZoIYAE/kzz4W7wQK
 WkshcSqFwQ44EzM1VLnWQ/DQhExkhu42uYd7w3+kK7DB2BS4vCPob9lTRrU6mgGR2Ww/
 KRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790335290; x=1790940090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=T0d7Hdy6WrCQixBKqJEoX/rQbI/qoXqNnFZ1/BTEyBU=;
 b=rPrfNvlgM/6skWwv0GPoe0GnwJDJ5Tv+uk7Iywd0KzmKDkGQ4qfJTT7UeVHwLoyZNt
 XSjFaw3oSLMihY9yKwMRpLPB2px4/mjf2lf7QfknX2utXzIvwcjBkl3YNxdtX4rQdun4
 ZSJhlRwEXSYmhuCVeUADf792N+hjZRqaAn4aAb5NU6kZTUx5VYCcI/iQ/YY9rH+avW/G
 I41OXUqtAnc4xQlvsNGJwdYkU4urnd+mymUr2rJMb8YD35mayH6D6piMmmORJhxeAHhW
 ekLktc9+TtJ4Mb3wIhCWGFC2txotGVdkKh4rpdDqClWoi4GYSI/aWwsqTM2LPQ+hFnV6
 zRVQ==
X-Gm-Message-State: AFuF++nFt9zj1mxqh0mBMWiS/tpmMwVFN3rHG+bZhmHBP5JCUIfivqES
 uNWOSrFLYrwxcKffJicfqo08idCWBD2fAdsKkCKxBco5xA95+i9v11cy
X-Gm-Gg: AYBFou3ESdn4yiAFN2JaJ123Fq5ZMW+Oac+9+ieCIx8e1xJwqXVNiy4sVtHiS7aNj9k
 MUmmp1dPiQj//P7bN9qDoV3frT1rz41N6WeqRcq5gGB2kXFothGV9RN4gRJ+9rNCPECKifE2Hrn
 A4YNb+M7TBwGMy+fNcAp17rtaAjiSUDqgXlt5/AgFxbKJTUoOPBps37dXhjb6cNInrfy95XQYlR
 /JK20jTLRv40oGWhWvHxA7XlQuvaGb8s7vzyLChklHi6oHwocfGz70dsRgiWGLay+8OoxOUoa8k
 VaZnj8af49JoRi7YV7iUai/xb37VXsoOuflYo42TRo20TlCBhNd01Wj3z9NApSQwPdm31s29KBZ
 IrMWgp53xy6Gi6PGfd8fmdV7x5aE9G/ixtm/SkVfVHPcRjn3qhOl+w/JnJo9p/nDXInTtkmodSz
 NeXeXc/zsNbpPFj4Ez9Ed9AFzTQzHRahcqp2ligHyZAipae4vY4NpmyC02xH5ZdDEtOTyPyttDs
 AAHh/1NP7TIRqLAE45Hq3UlOzghed3gHrt/wd0lCxI2B4CqWnmEGXITu6ueCQSZG9wvQnDDpiVk
 wiNwNbYuqtPAaQ==
X-Received: by 2002:ac8:5a07:0:b0:532:a34e:7c50 with SMTP id
 d75a77b69052e-5330b331080mr39604731cf.0.1790335289962; 
 Fri, 25 Sep 2026 04:21:29 -0700 (PDT)
Received: from
 runnervmtr4k5.ubsh35wddc4etnvdacx5cyawwd.cx.internal.cloudapp.net
 ([145.132.102.180]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5330c0aa543sm12951591cf.24.2026.09.25.04.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 04:21:29 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 25 Sep 2026 11:21:28 +0000
Message-ID: <20260925112128.4171-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925082840.2408504-2-pvorel@suse.cz>
References: <20260925082840.2408504-2-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] shmctl03: Fix shmmax clamped to INT_MAX in 32bit compat
 mode
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

On Fri, 25 Sep 2026 10:28:39 +0200, Petr Vorel wrote:
> [PATCH 1/2] shmctl03: Fix shmmax clamped to INT_MAX in 32bit compat mode

--- [PATCH 1/2] ---

> +	SAFE_FILE_SCANF(PATH_KERN_SHMMAX, "%lu", &shmmax);
> +	if (tst_is_compat_mode() && info.shmmax == INT_MAX)
> +		TST_EXP_LE_LU(INT_MAX, shmmax);
> +	else
> +		TST_EXP_EQ_LU(info.shmmax, shmmax);

Testing `info.shmmax == INT_MAX` in the condition masks regressions; if the
kernel fails to clamp `info.shmmax`, execution takes the else branch and
reports TPASS. Additionally, `TST_EXP_LE_LU(INT_MAX, shmmax)` compares
`INT_MAX` against `shmmax` rather than verifying `info.shmmax`. Use
`unsigned long long` with `"%llu"` to avoid 32-bit overflow when reading
`PATH_KERN_SHMMAX`, and assert `info.shmmax` equals `INT_MAX` when
`tst_is_compat_mode() && shmmax > INT_MAX` (or `shmmax` otherwise).

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
