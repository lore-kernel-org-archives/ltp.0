Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80E3C02183
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 07:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1737100128; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=gXm/4zswxOjvh0Zyys46oS2euANU8VQm490PzdP6Zcg=;
 b=XRQZ8yU4fiMM06UZGFNHdww7azimZCNoOl33lBUEvaxeqj6LMyM97TjtR+oA3LabTsvka
 rQ9FdFvMVXsaSbQ4ANfR5HBakvyOdKngIrLaJP9KwFj6FlEnPzOb7bkT909jJQNqFnMp5jI
 NxwMK4ir2vwI4yPCXvrQX+nr/28n7MY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C0E43C7C24
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 08:48:48 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A91ED3C7B97
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 08:48:26 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9139262098E
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 08:48:25 +0100 (CET)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-38a34e8410bso880201f8f.2
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 23:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1737100105; x=1737704905; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TREqSoMiK3zCRNFH36G8Wcxdz6JqJWLPjA9/8fPc9lI=;
 b=L/iLIdRjx8rFBIn46TSrwW6eeMciXewB0SR7BMhjL+p4COB5gJU4FE4GKwzzvUKppn
 ppMDCyWHzkBuoT372HgfRlsoTUFGYhXN98t9uoqfv3l2Te9YX+cJs+VyrDpcrKBkaJuc
 LEas6vuMIvkqyDwEHVvT7JE8W3c5yOS3+T8+dZjV/KyDWr8+n8lItC2RqfkJDJwAeVXr
 vMFrckon8+t7ilJ1WhpWFX6vW+ucjM6DO6u1UcgQzo6AKxNDFve27cHtXhW8hi4DMexG
 aZ8M+Ym6wu1XJY4+7TnHzPcwnZq4321A3aB73Cdxi9tRrAT9rOvQxLQoOLCKSyEtIyJa
 ueEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737100105; x=1737704905;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TREqSoMiK3zCRNFH36G8Wcxdz6JqJWLPjA9/8fPc9lI=;
 b=r+t32DEgql+fXRb9H5ol1TjWWe0e5Qcu8IUs9L9H1KFWa5KPxanoJwXpd+n/qn4fyv
 IvqZ/Yc9DqEpGn4eyXYERXNtmJfdq79RpzFNxcnZDbHNh6MZGzLL8ica6apY3aYwZSaD
 d4EWmCRt9mq835aAb+cLHLcbWBx+vEseLvOuxafzOhYb8YoMY1eLPZ7dbRKZHXcj35M4
 y8PBL76kJaM3bvDd3gHgOIWyb6HaUwmBQG8DnO3+7BZvDm5mpbeWklbWieipbu2hYQmd
 Cww88vv/cvuOInXd2FrOTNMhBR9cPfGLxFbqr6kY7MTft7Lk68C/q5TkW6EnH7ZjTp9i
 X7Gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK1gyFv5UU183WL/lMGLFEyEnK4FDY7/K4LrsWAol2pKFJ7thfxMe766+OB+mkhE9yhk4=@lists.linux.it
X-Gm-Message-State: AOJu0YyYRKzz8JkF9tl6nHXENZbBicpb81yqEInKVJNN546cahuaxgo/
 rO2vnB3mn/JZAUI0NaCX26hoKPUmFkO2GzAetCcq1gyKsQkUEzf5sfdgwv+29E0=
X-Gm-Gg: ASbGncusB+/0A6ZQgOsjHTkH2/Dk5Aid4fBJOTBIiwtc9VHoi8oX7pRnsOr7VRO5Hua
 HT4kvL54CY60pE2ZEqXEUxy7iuJVT7F53W8bHNFuLcuhH1E4mbbY90R1EQ6OqBQT1Sv+BUHesaw
 aoAkki14jKyjWtCDd6uLIyug5554tXyojpi3/yoTYMrFA6TnrFZYZgcl3M09VCiLWYITw0yGgji
 jtO6KK8KgzFjjrqaFMaKpFJ342PO6wUmRtFKR94Q9QobtQZtuIV48QJ/EPQmKlvVsRA19jXsW/U
 GsEldFpcjsmmpNE1nVIGiUjXE9yqDUPDG5V3rF7Xp/Lc+BFuA9trYmpGMNHr5qnE+zZV9wUzyfV
 RHKsciEE/PWzWtgmKAq0=
X-Google-Smtp-Source: AGHT+IGPX8QUhER2Dg89sdkZQ8zXGTgEt9M8bhafU4lW0R4VlcHjU/KPEss5Qund8ySDsRc3ld6XoA==
X-Received: by 2002:a05:6000:c8c:b0:382:51ae:7569 with SMTP id
 ffacd0b85a97d-38bf5686484mr990261f8f.18.1737100104941; 
 Thu, 16 Jan 2025 23:48:24 -0800 (PST)
Received: from ?IPV6:2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4?
 (p200300ef2f2b3f007ee622e7e7efafd4.dip0.t-ipconnect.de.
 [2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3221761sm1779787f8f.22.2025.01.16.23.48.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 23:48:24 -0800 (PST)
Message-ID: <95cf0806-4600-4949-8ed7-a31cacf2c8a5@suse.com>
Date: Fri, 17 Jan 2025 08:48:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Wang <liwang@redhat.com>, ltp@lists.linux.it
References: <20250117071758.120366-1-liwang@redhat.com>
Content-Language: en-US
In-Reply-To: <20250117071758.120366-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: add TST_NO_SLOW_KCONFIG_CHECK macro for
 testcase tools
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

the feature is interesting, but I have the feeling this should be added 
to tst_test struct rather than using a flag at compile time.
For example, by adding to tst_test a slow_kconfig attribute.

Andrea

On 1/17/25 08:17, Li Wang wrote:
> The macro TST_NO_SLOW_KCONFIG_CHECK is added to control whether
> the tst_has_slow_kconfig() function (which presumably checks for
> slow kernel configurations) should be executed.
>
> This allows test cases and tools to opt out of this additional
> check, enabling more flexible and faster test execution in
> certain scenarios.
>
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>   lib/tst_test.c                    | 2 ++
>   testcases/lib/tst_device.c        | 1 +
>   testcases/lib/tst_get_free_pids.c | 1 +
>   testcases/lib/tst_ns_create.c     | 1 +
>   testcases/lib/tst_ns_exec.c       | 1 +
>   testcases/lib/tst_run_shell.c     | 1 +
>   6 files changed, 7 insertions(+)
>
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index b204ad975..00d34b6f0 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1702,8 +1702,10 @@ unsigned int tst_multiply_timeout(unsigned int timeout)
>   	if (timeout < 1)
>   		tst_brk(TBROK, "timeout must to be >= 1! (%d)", timeout);
>   
> +#ifndef TST_NO_SLOW_KCONFIG_CHECK
>   	if (tst_has_slow_kconfig())
>   		timeout *= 4;
> +#endif
>   
>   	return timeout * timeout_mul;
>   }
> diff --git a/testcases/lib/tst_device.c b/testcases/lib/tst_device.c
> index 45f77a38b..386636610 100644
> --- a/testcases/lib/tst_device.c
> +++ b/testcases/lib/tst_device.c
> @@ -8,6 +8,7 @@
>   #include <stdio.h>
>   #include <stdlib.h>
>   #define TST_NO_DEFAULT_MAIN
> +#define TST_NO_SLOW_KCONFIG_CHECK
>   #include "tst_test.h"
>   #include "old/old_device.h"
>   
> diff --git a/testcases/lib/tst_get_free_pids.c b/testcases/lib/tst_get_free_pids.c
> index 370ec3e26..c6436687a 100644
> --- a/testcases/lib/tst_get_free_pids.c
> +++ b/testcases/lib/tst_get_free_pids.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0-or-later
>   
>   #define TST_NO_DEFAULT_MAIN
> +#define TST_NO_SLOW_KCONFIG_CHECK
>   #include <stdio.h>
>   #include "tst_test.h"
>   
> diff --git a/testcases/lib/tst_ns_create.c b/testcases/lib/tst_ns_create.c
> index ce3707a60..8c22ad449 100644
> --- a/testcases/lib/tst_ns_create.c
> +++ b/testcases/lib/tst_ns_create.c
> @@ -17,6 +17,7 @@
>    */
>   
>   #define TST_NO_DEFAULT_MAIN
> +#define TST_NO_SLOW_KCONFIG_CHECK
>   
>   #include <stdio.h>
>   #include <string.h>
> diff --git a/testcases/lib/tst_ns_exec.c b/testcases/lib/tst_ns_exec.c
> index 6a8e39339..ca5b717da 100644
> --- a/testcases/lib/tst_ns_exec.c
> +++ b/testcases/lib/tst_ns_exec.c
> @@ -14,6 +14,7 @@
>    */
>   
>   #define TST_NO_DEFAULT_MAIN
> +#define TST_NO_SLOW_KCONFIG_CHECK
>   
>   #include <stdio.h>
>   #include <sys/wait.h>
> diff --git a/testcases/lib/tst_run_shell.c b/testcases/lib/tst_run_shell.c
> index 7a446e004..b12a1e9f6 100644
> --- a/testcases/lib/tst_run_shell.c
> +++ b/testcases/lib/tst_run_shell.c
> @@ -5,6 +5,7 @@
>   #include <sys/mount.h>
>   
>   #define TST_NO_DEFAULT_MAIN
> +#define TST_NO_SLOW_KCONFIG_CHECK
>   #include "tst_test.h"
>   #include "tst_safe_stdio.h"
>   #include "ujson.h"

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
