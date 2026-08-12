Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30866C5B572
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 13:09:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9483C3C9EF8
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 15:09:49 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 41FBA3DD436
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 15:09:34 +0200 (CEST)
Received: from mail-pj2-x09.google.com (mail-pj2-x09.google.com
 [IPv6:2607:f8b0:4864:39::9])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DC0A110006B6
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 15:09:33 +0200 (CEST)
Received: by mail-pj2-x09.google.com with SMTP id
 98e67ed59e1d1-38f0f8ab050so919768a91.0
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 06:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786540172; x=1787144972; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MV0sF7EBZ1+9uBg17UkHv6mv0yFyPsWJlScUXiAS+5Y=;
 b=m+yLqxH00ug0hqYilpa1X/rIgJGljhRDTZYiWwdNo7dqHWxEOzq/1onq8AMrQjE1BI
 ptHjYVoURu9oGKRtoeGn4ZnXaL82fKEForINuFmfVjAVZU0rsZdhhaTjA/1tJQwHgyEx
 9EmUZtzPdE1zW5CDskHT47XVxEzp8mozEXmzAzQQ/hthL+0KulTAz+ua5oQkDyiZWSD8
 JU+b6A6UuHHrerOEqLxV3e9JMZ7h2+yM3syfn4Cxu5aR/Awlf6kp5JoL3nnubRS2MN7T
 xN1hQ2hdZ0D0GnRFVKGilX1v8lsFSIXaLheTYowAOIq4ip7Hq1RnmiNC4T8cHZen+uO6
 YGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786540172; x=1787144972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MV0sF7EBZ1+9uBg17UkHv6mv0yFyPsWJlScUXiAS+5Y=;
 b=SIky68k3XdNkg+FGZGTBFwNFYCpSSgJ7yrgTtvScdbdftsfx8lavDTcf9595zxXSVG
 RC62IO63bP28pt7Yrw4L1pyUr1Duc569r164pqwGIHZ1dU653OADNOjwahNa4Ox7F/He
 YNAbjHS3XjzkKgaVfmkqngQFWUNHTn3LhxtEg2KXWgIyRESLg0fYgd9Lar20dyrbWbJJ
 e6xIjVWrKstZuWwoAfwiI5soARm71+bOF+B9Kkv453wNJU31EY8RE5ZGrJareCKqfiAF
 nFBuwQXdassnEjdhpfy7IgLef94DTUpNZSipTqSH9gMCZurzvoH5kaOXVGN9zY0BMwcj
 pHvg==
X-Gm-Message-State: AOJu0Ywgs+sG+xdPENNo9ucKVTIb2P43IMRnaLa8+1kg67yJD4OoaYc8
 pTInpjQssIzb0/Bw119/y42JBrkNBohHGqS2pSdoJTh3hMNhoBLxNgsw
X-Gm-Gg: AR+sD12U7HyRFczWWcuFKtPdHpmlsw0RqeaLpBanOA2noS0K1AU2UkxzY0mojcTsQ+K
 foekLIyeMNcL6uflq+d8i2UJK3cF/ZSrFMhx0sasQ8h3m03urf50r5DBFmOk9EpRqL38l3oTo8o
 Q1Ax6vAAISmmHzTlp2k956ChvZdb97WzNkfr0MCDEH4pkDd+oy8lTKpeOKyFhWvvbBDNb6J563E
 ks4oHmJHxKLO+lsbQ8IVKF6givLs3QnrRoJi1G0zwchgkt/2JZ6h5X4Ipi1VnM+z1OK20dxB765
 IYtQBg6h2KOUb/KP2dxwGFqlY4y/O3gRpQcBYlEoeTXLzIJOHvtfyftEZjNzUYW2o8hkuG1TeZn
 u3pJpYe0L5xNb3//6mW1+4CSo01Vv4Yh4p3KvBhxVRaFgNxMT3X1TTp9sc1o7MPZPXjScHWTWxp
 +vbKJsJy2pxrnwOr3y9LaOvBKWQMhsookhqBhTS4SQN03tjarMkrgG6ip0N9VTK5lL8WS2EiRoA
 jU4y/MDpCtRO5afvZepRnTtDabhKzMzxwJWtJNj1ygZbLb0CyeomicWF8YmgbYbQ7oX8o+iXWeu
 bw==
X-Received: by 2002:a17:90b:2783:b0:38e:64b0:8bce with SMTP id
 98e67ed59e1d1-393014b0169mr6034791a91.20.1786540171846; 
 Wed, 12 Aug 2026 06:09:31 -0700 (PDT)
Received: from
 runnervmvrwv9.h0til1qxdkvunc1k3rnb33aecf.yx.internal.cloudapp.net
 ([57.151.137.215]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31cf628e42asm13958799eec.15.2026.08.12.06.09.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 06:09:31 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Frank Ranner <frank.ranner@intel.com>
Date: Wed, 12 Aug 2026 13:09:30 +0000
Message-ID: <20260812130930.9202-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812112737.2222475-1-frank.ranner@intel.com>
References: <20260812112737.2222475-1-frank.ranner@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] testcases/kernel/crypto/crypto_user02.c: try non-generic
 hmac names first
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

Hi Frank,

On Wed, 12 Aug 2026, Frank Ranner wrote:
> testcases/kernel/crypto/crypto_user02.c: try non-generic hmac names first

> +	"hmac(sha1)",
> +	"hmac(sha224)",
> +	"hmac(sha256)",
> +	"hmac(sha384)",
> +	"hmac(md5)",
> +	"hmac(sm3)",
> +	"hmac(sha512)",
> +	"hmac(rmd160)",
> +	"hmac(sha3-224)",
> +	"hmac(sha3-256)",
> +	"hmac(sha3-384)",
> +	"hmac(sha3-512)",
> +	"hmac(streebog256)",
> +	"hmac(streebog512)",

[Major] Could these be replaced with actual deletable instance driver names?
The strings are copied into cru_driver_name, but these new values are
algorithm names.

On Linux 7.2, CRYPTO_MSG_NEWALG first misses the exact driver-name lookup
for "hmac(sha256)", then finds the non-instance "hmac-sha256-lib" driver by
its cra_name and returns success. CRYPTO_MSG_DELALG subsequently requires an
exact driver-name match, cannot find "hmac(sha256)", and returns ENOENT.

Consequently, the setup loop rejects every newly added candidate and still
reaches TCONF when the legacy *-generic instances are absent. The 7.2 HMAC
shash template instead produces deletable hmac-shash(<driver>) instance
names.

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
