Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 171A2C021B1
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 12:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740054920; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=lF07Dm+1sJnkU79+idX6Yn693/fwAakcy+nWO7mCzEw=;
 b=d1S6SISFAMwU2clfGHoIsvhAhpVEzAqvmkUFnfTHefmWZIdcUHY51VH9YrsYpdP56lbs8
 arbhxWNTG4NoJlzgDoKrjUuIZT/oPow1EZ7d3rMnz9Q+R6Ukar2fCLC+1OuUshDyeiYqL83
 heiSI8Ne07Fr1zKNcK9cYGrEkhdfNaQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F7C13C67B2
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 13:35:20 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4359B3C0549
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 13:34:58 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3D443656FDA
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 13:34:57 +0100 (CET)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aaec111762bso205464666b.2
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 04:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1740054896; x=1740659696; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OKhXfyOVXTLKkKV1bRLLYYJyv+S1PPkZPDX1zOZMEXs=;
 b=dsJ1QQvEgghAJmam0/ng75QCg8OPFOW6cixGspr3CDtRJf+ZO4+bHkhrxdRBxFI/aN
 mtnjSjviE25qBteT26gyp6PwnhkatjidkorhO5rrc9oWFznPSrQHRxjoxqsPGOnQPn97
 mtV4175HkB9vU43jeAvozcYMNS0fjrSU+/KCqaZYvuFqO6ebhRS6B9MOlf+fVXUP1sXU
 ArfOY+FC08G5rtOjW+DN1YUYpA9bXxP0l30QjJKd1Q8zTHB30exdAPLL/k6hCCAb15Uv
 Vg+KNO2Zm0OPULT3PrJ+YqbsBamBo2QtPq1CtERuBL++6aJN429cuMN/9WGLxzKV4Z8Y
 WYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740054896; x=1740659696;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OKhXfyOVXTLKkKV1bRLLYYJyv+S1PPkZPDX1zOZMEXs=;
 b=Zs2r0wHPCcprMzu1HmJ+x/QpHYaNmaDP3/hTkdEF1gZoCW06EnsSonJkO5BYKI1TUa
 JLikQ6g/PPrJeXFzaoRtYPdfO8UK1Wn6bnN0m9IqYnj0Z84LYXj/COlSMw1YNYt/Mzt5
 vVKJ9pca3v+hcodFyqmt2YoPqKpLYKNNsSgsqnmlvLKhNI36ujMIvcLE1JAQqO//HBJR
 GMC4KlCp5No2AYVhVlIaarXxwYCUeQISYagzT3kQ7zs0B7ElsUmJtxE4g0ClLOxYYEAY
 WU+VER9mleuXJncRhyoNS69rEDAEUA3Ij9bAng1x4d4onSj5bP8emmaZ/QrHecmXmaEB
 LBJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaIiasAFGFL49NELVgs51BQFjwpiN5vodzm5XAX9NqQEii+7FrfeJBFoGPvM/F5S4WJ9s=@lists.linux.it
X-Gm-Message-State: AOJu0Yy/28uGCHQuiozuIahLiy67lWmcEZPOdmaI1LWy7IFN28KsiIY9
 UrxpdKncgHx9QWuIusrCZVd8NtM1eLHLRd7akDgjJ8PzKgHJ04sBtlxDvTv6u5StlEb2KUG9Ck+
 5
X-Gm-Gg: ASbGncs7PnrfWe3vD5Cs5Tldj7f6rrzZPzt7r1V1kwU/huzyLQ7D7i7kXJj+B3Ag5em
 2Fo4awjsMjyeOTl+Uun/1QU6rtQrnS3BBb8fTkW/GVZY+zvP/Y9dhugRFBYVRJovKFbn7aEuQXD
 Gbqw7y4X2uwAxOESKvIHbdEeCZoQqWnol9+FKK9v7DtTUmtzb5l9YvoxlmTiT3wNgoCaSL7UNcE
 7m/ZywDBfWafU9rlMyTnaqQXGzJYbzKbvJIEIJw9ruyt5IMrtBr6SO39tlOXZkal29K/nnxbqPx
 Kkx5NdzQhMCrOLDUMDJs11+cKHg7Dwl8ASelgD6MKlUPaqEJ7MtFq8HOy51onBR2CT03pbzJFlu
 KsZMnhgF+t3l+mI2kJwIbPtdVfaxhbiz5WY5SBplhiPd9HyuKBEM=
X-Google-Smtp-Source: AGHT+IH4jH4jzG26X5srf88s/3ccKUwob+Hn8Bd0PVuvbprdALhaWps3wRWHU5iMpfH44zC4esx/IA==
X-Received: by 2002:a17:907:2dab:b0:ab7:bb93:56ef with SMTP id
 a640c23a62f3a-abbcce74faemr708458766b.19.1740054896388; 
 Thu, 20 Feb 2025 04:34:56 -0800 (PST)
Received: from ?IPV6:2003:ef:2f02:800:9162:c8ad:3b21:a399?
 (p200300ef2f0208009162c8ad3b21a399.dip0.t-ipconnect.de.
 [2003:ef:2f02:800:9162:c8ad:3b21:a399])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abb8ab30726sm894876966b.153.2025.02.20.04.34.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 04:34:56 -0800 (PST)
Message-ID: <0212a60c-3161-4569-afc5-99031c2f27c2@suse.com>
Date: Thu, 20 Feb 2025 13:34:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wei Gao <wegao@suse.com>, ltp@lists.linux.it
References: <20241228114416.12653-1-wegao@suse.com>
Content-Language: en-US
In-Reply-To: <20241228114416.12653-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] fcntl40.c: Test fcntl using F_CREATED_QUERY
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

Hi!

A main comment about selftests ports is due to the way we should pay an 
extra attention to the code we are merging in LTP.
The LTP code base is different and we need to double check if the 
selftests make sense and we are correctly using available LTP API.
The documentation is also important and we should take a closer look to 
the description.

Some comments below.

On 12/28/24 12:44, Wei Gao via ltp wrote:
> Signed-off-by: Wei Gao <wegao@suse.com>
There's no commit description
> ---
>   include/lapi/fcntl.h                       |  8 ++++
>   runtest/syscalls                           |  2 +
>   testcases/kernel/syscalls/fcntl/.gitignore |  2 +
>   testcases/kernel/syscalls/fcntl/fcntl40.c  | 52 ++++++++++++++++++++++
>   4 files changed, 64 insertions(+)
>   create mode 100644 testcases/kernel/syscalls/fcntl/fcntl40.c
>
> diff --git a/include/lapi/fcntl.h b/include/lapi/fcntl.h
> index 761331798..7c0502488 100644
> --- a/include/lapi/fcntl.h
> +++ b/include/lapi/fcntl.h
> @@ -154,6 +154,14 @@
>   # define RENAME_WHITEOUT		(1 << 2)
>   #endif
>   
> +#ifndef F_LINUX_SPECIFIC_BASE
> +#define F_LINUX_SPECIFIC_BASE 1024
> +#endif
> +
> +#ifndef F_CREATED_QUERY
> +#define F_CREATED_QUERY (F_LINUX_SPECIFIC_BASE + 4)
> +#endif
> +
>   /* splice, vmsplice, tee */
>   
>   #ifndef SPLICE_F_NONBLOCK
> diff --git a/runtest/syscalls b/runtest/syscalls
> index ded035ee8..43e493eb1 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -363,6 +363,8 @@ fcntl38 fcntl38
>   fcntl38_64 fcntl38_64
>   fcntl39 fcntl39
>   fcntl39_64 fcntl39_64
> +fcntl40 fcntl40
> +fcntl40_64 fcntl40_64
>   
>   fdatasync01 fdatasync01
>   fdatasync02 fdatasync02
> diff --git a/testcases/kernel/syscalls/fcntl/.gitignore b/testcases/kernel/syscalls/fcntl/.gitignore
> index e60176973..e3486ee45 100644
> --- a/testcases/kernel/syscalls/fcntl/.gitignore
> +++ b/testcases/kernel/syscalls/fcntl/.gitignore
> @@ -72,3 +72,5 @@
>   /fcntl38_64
>   /fcntl39
>   /fcntl39_64
> +/fcntl40
> +/fcntl40_64
> diff --git a/testcases/kernel/syscalls/fcntl/fcntl40.c b/testcases/kernel/syscalls/fcntl/fcntl40.c
> new file mode 100644
> index 000000000..ef03becef
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fcntl/fcntl40.c
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 SUSE Wei Gao <wegao@suse.com>
> + */
> +
> +/*\
> + * [Description]
Now we don't need this anymore
> + *
> + * Basic test for fcntl using F_CREATED_QUERY.
"Verify if the fcntl() syscall is recognizing whether a file has been 
created or not via O_CREAT when O_CLOEXEC is also used."
> + *
> + * It is based on the following kernel commit:
> + * commit d0fe8920cbe42547798fd806f078eeaaba05df18
> + * Author: Christian Brauner brauner@kernel.org
> + * Date: Wed Jul 24 15:15:36 2024 +0200
To write if test is based on a kernel selftests is enough. The git tag 
should be pointed in the "struct tst_test" via ".tags".
> + */
> +
> +#include "lapi/fcntl.h"
> +#include "tst_test.h"
> +
> +static void verify_fcntl(void)
> +{
> +	for (int i = 0; i < 101; i++) {
This has been probably added by selftest devs due to make sure fcntl() 
is working correctly when multiple files are created.
I think in our case is not really useful, but we might have 2 options at 
this point:

1. we keep the loop, but we don't spam text messages in the stdout. 
Which means we probably need to remove TST_EXP_EQ_LI and to process 
multiple results at once
2. we remove the loop and we test it only on a single file

I'm more for the 2nd option.

> +		int fd;
> +		char path[PATH_MAX];
> +
> +		fd = SAFE_OPEN("/dev/null", O_RDONLY | O_CLOEXEC);
> +
> +		/* We didn't create "/dev/null". */
> +		TST_EXP_EQ_LI(fcntl(fd, F_CREATED_QUERY, 0), 0);
SAFE_FCNTL()
> +		close(fd);
SAFE_CLOSE()
> +
> +		sprintf(path, "aaaa_%d", i);
There's no need for this if we use a single file. We can just define a 
TEST_NAME macro on top and use that everywhere
> +		fd = SAFE_OPEN(path, O_CREAT | O_RDONLY | O_CLOEXEC, 0600);
> +
> +		/* We created "aaaa_%d". */
> +		TST_EXP_EQ_LI(fcntl(fd, F_CREATED_QUERY, 0), 1);
SAFE_FCNTL()
> +		close(fd);
SAFE_CLOSE()
> +
> +		fd = SAFE_OPEN(path, O_RDONLY | O_CLOEXEC);
> +
> +		/* We're opening it again, so no positive creation check. */
> +		TST_EXP_EQ_LI(fcntl(fd, F_CREATED_QUERY, 0), 0);
SAFE_FCNTL()
> +		close(fd);
SAFE_CLOSE()
> +		unlink(path);
SAFE_UNLINK()
> +	}
> +}
> +
> +static struct tst_test test = {
> +	.test_all = verify_fcntl,
> +	.needs_tmpdir = 1,
> +	.min_kver = "6.12",

Here we need to define .tags , adding the kernel commit that introduced 
the selftest.

> +};

Kind regards,
Andrea Cervesato


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
