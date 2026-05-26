Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A52FBCD5BB1
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 21:01:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC8ED3C7105
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 23:01:43 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 514473C5F08
 for <ltp@lists.linux.it>; Tue, 26 May 2026 23:01:25 +0200 (CEST)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8B3281A008B9
 for <ltp@lists.linux.it>; Tue, 26 May 2026 23:01:24 +0200 (CEST)
Received: by mail-qk1-x743.google.com with SMTP id
 af79cd13be357-9106ea78cd8so1713280485a.3
 for <ltp@lists.linux.it>; Tue, 26 May 2026 14:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779829283; x=1780434083; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H0fbp7e7da8xIsouM2WQzr8VdB5vwwCJI+e5GxPsyJ0=;
 b=ajCUVd9lC11wV00nTQRg7zWzX2OhiQvXHlK0SV+9hgnYijqNOTAfk3acFaw2+ahaEd
 7wy+zPFj2WhxOrt5+sPcTcJXO/mhiF9obEdMMMipabsJdNX8Z/LZN3DGdM1TCAVuSodN
 DlrxfGUVJIBpgcrJYGoxNCmZZDDLHpmVYlCLj6Am4DqltV3jVrS8rG9L2ktmUDhe1YZA
 kasANmO7h2hL6DS+yXBsFrjP74bQ2Psx3NQ4x4eN7XZYqXxZr4I01Axyvw8p/ad4vhje
 Q7/gQOw5b8TQ9D0lXJyZ20koXy7qDf8kZVPkkCnN3tz101O11vyTBdjgsbZ2M8SHiiX8
 lsRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779829283; x=1780434083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H0fbp7e7da8xIsouM2WQzr8VdB5vwwCJI+e5GxPsyJ0=;
 b=G13WG8NW5EZ3gipZQmLWUhe0Ndbeeskr5tBVjF+R1ctbK1zUWidmck6t+7oW9nUzxR
 Q2UO11nI2YIPul8CGVJBY4PJGjkoEWGTgTMpULq+zQ7MD2Yr9hVLy3kk4BmV+b2IzUjk
 9jaaU8pCiMDbF34cQsedbcVPAOmMMlZH3c07TCfFOKAHEh1tTUF8NJ1R5W5tZb1C3zze
 E33IPMRYjn+Wzcq1XjAFdsj89SEYqETHoHNIB9nFfeav8yiXt8D8wF2ZxWGv3xJeTYct
 pTqcttcOtPUKjzBOW3bCcMvL7jACTITYzBFhQKtFOawidvnCxq8EqdcvZAzYTeICsOG0
 VMhw==
X-Gm-Message-State: AOJu0YzstNzSW4cUXfExcrZqiHKHLA2NV4/9WWtowABJFcy2Eu6h+doo
 LxKfh71GAZAOft5QPrH57a+y9IhroxmC8EoATJ2kpVqD4Sq21KqsrSBD+KEzbk/lWMs=
X-Gm-Gg: Acq92OHyYovi+08AgVxNdiZahzfaXG8SZlQlOEwBPIzptPiw4JvsfDD8Jg9Yhpq616D
 kiy7g9QthFM5kL22goX5kDz8UHzNN2OsarMGdFkpkit44xtVN/g8xsGtUwA//Q1/rjRMFjGFYud
 xYvgtVTTURpkADacHdye6hBvM6fFADogim6oEaeAK6UXNVS/cqP+MMbPqO0gT3alaXDtjZDMo1j
 j7MDhG256D80cpgjK1T2rk1Dqmi221xTkYn6ATRHTPe0Mrs7nZp1O07rNI/jEG0JFJvBrAMf4xn
 NxSFvucaeP/3z31uWY7LsX4EnjHv8dHFCUXzYHXd01CMb8ikUVkue4YGzD42mNAWdcsKKpZy2xH
 n3t0df9M99isBkV5sGjfyPNU0xIXdh7WpA28ppt/Vt8PYmvhIEU9wmKuvDkNrh7w9l9rAXyltRz
 sJgV0W07RIav0Yt3KC+95EoAclSG++OR6aRVc6FxAodsiPFKL1TMlrxhe6D7n64F1BAlJ5/+WFc
 S6T3nzr+0JYjkePtt3v7mDm5SpLwq+uogW8+b/EHjGoev0/Txo=
X-Received: by 2002:a05:620a:6f01:b0:909:c82b:9756 with SMTP id
 af79cd13be357-914b48b3995mr2676822785a.5.1779829244626; 
 Tue, 26 May 2026 14:00:44 -0700 (PDT)
Received: from
 runnervmg397c.ewmzc0bqkruufhf1y4x1ywmkfc.ex.internal.cloudapp.net
 ([64.236.135.136]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-914f880c1b1sm294554385a.40.2026.05.26.14.00.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 14:00:44 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Michael Menasherov <mmenashe@redhat.com>
Date: Tue, 26 May 2026 21:00:43 +0000
Message-ID: <20260526210043.3935-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526190430.129798-2-mmenashe@redhat.com>
References: <20260526190430.129798-2-mmenashe@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] futex_wait06: Add EFAULT error coverage test
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

Hi Michael,

On Tue, 26 May 2026 22:04:27 +0300, Michael Menasherov wrote:
> futex_wait06: Add EFAULT error coverage test

--- [PATCH 1/4] futex_wait06: Add EFAULT error coverage test ---

> diff --git a/runtest/syscalls b/runtest/syscalls
> [...]
> +futex_cmp_requeue03 futex_cmp_requeue03
> [...]
> +futex_wait07 futex_wait07
> [...]
> +futex_wake05 futex_wake05

The runtest entries for futex_wait07, futex_wake05, and
futex_cmp_requeue03 belong in the commits that introduce those tests,
not here. As-is, if the first commit is applied alone (e.g. during
bisect) the runtest file references binaries that don't exist yet.

--- [PATCH 3/4] futex_wake05: Add EFAULT error coverage test ---

> +#include <sys/mman.h>
> +#include "futextest.h"

Missing blank line between system and local includes.

--- [PATCH 4/4] futex_cmp_requeue03: Add EFAULT error coverage test ---

> + * uaddr2 is only reached after *uaddr == val passes; both are
> + * FUTEX_INITIALIZER so the comparison succeeds.

This is inaccurate. The kernel calls get_futex_key() for both uaddr
and uaddr2 before performing the *uaddr == val comparison, so uaddr2
is validated regardless of the comparison outcome. The test still
works correctly since futex_var == FUTEX_INITIALIZER == val, but the
comment should be fixed.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
