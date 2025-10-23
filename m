Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40952CCD193
	for <ltp@archiver.kernel.org>; Thu, 23 Oct 2025 19:20:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8FA823CF285
	for <ltp@archiver.kernel.org>; Thu, 23 Oct 2025 21:20:37 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EAE7E3CEEEF
 for <ltp@lists.linux.it>; Thu, 23 Oct 2025 21:20:20 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6999D600147
 for <ltp@lists.linux.it>; Thu, 23 Oct 2025 21:20:20 +0200 (CEST)
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-87c1250fc90so2341526d6.1
 for <ltp@lists.linux.it>; Thu, 23 Oct 2025 12:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761247219; x=1761852019; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y7Jc2L0p0jcJ2tGUUd6Ppdki3QU4yD7rPhAK5dStwsA=;
 b=RFXI5FhSuBah/hrulBlfVWKE3fS1M/5gYdiO9lImuJ6KpLaaGNwlyI9WMvUK/Nf7Rr
 MKfaVW1LfLUS05Z7dvvp2e8UmZDntwS/R/LrvnicvmDBhz0MZe4WUOjBGsLZggGF4ZOU
 gM2OE1V2P5pKOjTwSaDE+0ZdU8u52F0lm8KXmQSm7S/PbJwTIFI1fJ8/nSSIxjFE6Ms8
 XI//2mS91+PZUWCzCx04pTWGf9JN/a3IgKZhndXXkrg2iFkZ+QsAPqO6md3i+ztetQSj
 IFlv2BDyC8qnxffjZcVq+pWdWFPPAF2S663xRLrUnvvLFmF6HW3oRbgyO9Fem2mnqXau
 44RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761247219; x=1761852019;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y7Jc2L0p0jcJ2tGUUd6Ppdki3QU4yD7rPhAK5dStwsA=;
 b=F0Xxq9hl/pxf5RKplLe8qERieEfWiMx4CBBv1qVEWiJQR/AVx0HHljqOFJCxVuFQtO
 oU192pNrFrZOWL1vwYDy12kYdU2G8VKWD90bVWgTw0//fpAfLORXQSh4JXIPuamYepru
 5TTwqyoTwjDZbbAmxde7JbTduWd2F1fREo3jLsXx/6c4kknAzL3s0TOHmH/lh3xyJ3PZ
 DuGVPuKNTYzyx4iUnuIjxp9WB+FW55IDUptdHtWOmtYWvNO/y9xKutqN8MWxA55ZPhWf
 zqSJ/lbMzJbgS6akSIL+2AssToIPo2KdUNg1fvpkp6YXcBmh+DGapLfc6rblMFp4JRvi
 YuJw==
X-Gm-Message-State: AOJu0YzisdO56i3jtllfqFKfRkenbi9LDwc4/Kh8jCfEhWIKSXbUyw7o
 TRvhxKrThl/8coyiJI81k+sajs+4EI/8LQK2QNzZmTDr106Iz7gFxIc+vbL/eeV9T5oJMxwm0W/
 LolOskD1uPBRu5iPt6dyjpJP2tGNQVPJW7dsGqllMsA==
X-Gm-Gg: ASbGncsXgRKGeRk8NY+4iHvvk9BTD3q1/SGCArZtaEocIhSoPonqXrODA0xZV26ydYZ
 Rt1wF2rQkNUjUBN7L8NNUk4eBHRTaQ5LMSG+vKmOpO5ItyhQMtHrP4cuzcPYYJFOIU6Si6vk08L
 RdVBi3KiPB1hO0OEFk+uAiHktlcWKJ8magLLwLr9P11WCoVanei1UDPg9FQlexrsFFmFC2he68v
 jhtNNyGQOa10n4xzd7ey22C/FZZiIOW1id5m+NcX/3dvopLJK2hrzf3IvZGaUcOmKYGFA==
X-Google-Smtp-Source: AGHT+IGkQvnw+P4oceXyA5t5qG3cgWb0laXxzyqv1FiNzsffgaXuAVfp39vbfz48HT80gEehZCMHTKqYfeFUsV9baTU=
X-Received: by 2002:ad4:5b87:0:b0:87c:21db:cbbf with SMTP id
 6a1803df08f44-87de714bf08mr100164216d6.4.1761247219089; Thu, 23 Oct 2025
 12:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <20251023164401.302967-1-naresh.kamboju@linaro.org>
In-Reply-To: <20251023164401.302967-1-naresh.kamboju@linaro.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Thu, 23 Oct 2025 21:20:06 +0200
X-Gm-Features: AWmQ_bm15EalXbAnjLs4CmLjdIsxVVIbblnMfG02uQMZQ8ouizbiUwGmA3HVblI
Message-ID: <CADYN=9J1xAgctUqwptD5C3Ss9aJZvZQ2ep=Ck2zP6X+ZrKe81Q@mail.gmail.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] ioctl_pidfd05: accept both EINVAL and ENOTTY
 as valid errors
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
Cc: arnd@kernel.org, brauner@kernel.org, jack@suse.cz,
 regressions@lists.linux.dev, arnd@arndb.de, linux-kernel@vger.kernel.org,
 lkft-triage@lists.linaro.org, ltp@lists.linux.it, benjamin.copeland@linaro.org,
 linux-fsdevel@vger.kernel.org, aalbersh@kernel.org, lkft@linaro.org,
 dan.carpenter@linaro.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, 23 Oct 2025 at 18:44, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> Newer kernels (since ~v6.18-rc1) return ENOTTY instead of EINVAL when
> invoking ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid). Update the
> test to accept both EINVAL and ENOTTY as valid errors to ensure
> compatibility across different kernel versions.
>
> Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>

Verified this on arm64, and the test passed now.

Tested-by: Anders Roxell <anders.roxell@linaro.org>


Cheers,
Anders

> ---
>  testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
> index d20c6f074..744f7def4 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
> @@ -4,8 +4,8 @@
>   */
>
>  /*\
> - * Verify that ioctl() raises an EINVAL error when PIDFD_GET_INFO is used. This
> - * happens when:
> + * Verify that ioctl() raises an EINVAL or ENOTTY (since ~v6.18-rc1) error when
> + * PIDFD_GET_INFO is used. This happens when:
>   *
>   * - info parameter is NULL
>   * - info parameter is providing the wrong size
> @@ -14,6 +14,7 @@
>  #include "tst_test.h"
>  #include "lapi/pidfd.h"
>  #include "lapi/sched.h"
> +#include <errno.h>
>  #include "ioctl_pidfd.h"
>
>  struct pidfd_info_invalid {
> @@ -43,7 +44,12 @@ static void run(void)
>                 exit(0);
>
>         TST_EXP_FAIL(ioctl(pidfd, PIDFD_GET_INFO, NULL), EINVAL);
> -       TST_EXP_FAIL(ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid), EINVAL);
> +
> +       /* Expect ioctl to fail; accept either EINVAL or ENOTTY (~v6.18-rc1) */
> +       int exp_errnos[] = {EINVAL, ENOTTY};
> +
> +       TST_EXP_FAIL_ARR(ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid),
> +                       exp_errnos, ARRAY_SIZE(exp_errnos));
>
>         SAFE_CLOSE(pidfd);
>  }
> --
> 2.43.0
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
