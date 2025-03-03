Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5949FC282C5
	for <ltp@archiver.kernel.org>; Mon,  3 Mar 2025 08:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740990292; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=JpyIyjoyoABWao5VjqGr0Fr7dhzkQI+n5pz4/n5xeUo=;
 b=f0TSlFCyBTCENWwdwZR4EqW8WoGPSGuI9snWwHHPmF2cOQ/92g1uwuMbjDxyebfcxLYO1
 eZ9L8I/cVczpYZ24L8lixoBroNbEOn9Mq+aXzLa5TGHEMHiqTGn9t4Hlct/6/hZkY/uuFiK
 I/o0DCUVKzx6rV7nGs5McQL/UMxaLTI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 667263C71E7
	for <ltp@archiver.kernel.org>; Mon,  3 Mar 2025 09:24:52 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 404133C5EF3
 for <ltp@lists.linux.it>; Mon,  3 Mar 2025 09:24:29 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 49812101F0D2
 for <ltp@lists.linux.it>; Mon,  3 Mar 2025 09:24:28 +0100 (CET)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5e4c0c12bccso7338434a12.1
 for <ltp@lists.linux.it>; Mon, 03 Mar 2025 00:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1740990267; x=1741595067; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GHxzAf1Lcg3p64KpjL5eG51i3b0iMw4SZGsc/lWa5/0=;
 b=Y90/xf1mWG/io0BsjXbKNxcnL+A1dUbTujOdfQdekG2EO6nkaqpFtSPsk7AFMjiKXs
 MLDO6PGhclNyG7onZ8PyXxSADe/rYCLIP8o/v6K4XXz6ln1+9WgUaCIbf0L3ulzaeGUQ
 D7qHuki39C0htdCXObnkVJei9vxvWssS/6Ik4KUZoMd8mImBLkDLKf/0VGXo+PfTHrHl
 /bs4HqVbAh6xPsmnln2uEN4uj+ZrLVVeIAe6MYjh4MYSTorbI1aXBoEIiz6MALadaXr9
 cXAy2BEcKFzX5xe1Zeqk6nru9aIiRMXO1ayKReUQXLLM2VLaFZcSh6FJL3bCE8lkdUJ5
 wkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740990267; x=1741595067;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GHxzAf1Lcg3p64KpjL5eG51i3b0iMw4SZGsc/lWa5/0=;
 b=BEtCYXzzHW+eHif9K9KhVpH2gp3uykxDPC+5JCETwGvPltFs+Kzn8m/7XNbDWoEhK+
 ajegUKHmJACiRsVzV39ZnjMqa4GTZU9GhgSNXmCgb5n1yCUTTPIWS+I2GCZZLHBKpttt
 cO0LyquLbNjCKv1KmQRhK99M8zsyNZ6Xkyo8I4oD+V+59WH1X8ixHtzI9R6aGreWczRW
 X0+0YrjM5DcbwT5zYgIHKJhHUDaQ+JEntEnBEFwfM7mZ57DFyu6lMOzXUV8USDA5GqEE
 Um/+sHV9DML9IM6W8UkAb4azB4UWF5RrCTTKMU02WN4E5aPKOTk2f1tMjCPz6rkODq0j
 C4Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjf7AfPBXqyrug2rnM1vTIJVQDh2tnwlTuhSEGmJ6q6wIGnV1GNAznUoCcp0hZa3FcT2E=@lists.linux.it
X-Gm-Message-State: AOJu0YwCixxQd+KgbYkH+hQMZl1XyXpYa97CapyKg3lpCXETgJdqjgKt
 RFhDeRG+QOHpnLU7Z2txw2+Tm3yoqutEOnyknh8WmM8qsImUPHwa0ceX6jNwuPo5iRbfORa/cEx
 2xtKp/w==
X-Gm-Gg: ASbGncsg6p+qR1U5StOcGx/Qxd8VNKtkFiGWEPKUX2PBD9SvgL5tQpjxXAglG1Ds52T
 6AUCOsCcNACO6Ymydz5gOZ+fAPtw/wFX4K9yD6G+00NzCW+VlDYaVIyVaZ7QewNLy/K224R+oT/
 HRIvKTRnpE+m0C5w84LH6p3ot+rZbpEaBT9pXv2TIeWNY0Ub5r2sIyXqIJkRSX0diuBVijt0257
 QQ9uxsqWT5Ln7BTbk87tkKCIDtFvo6qlhXJ3dVBF46fFQvH+JINSmHGQ1N0lpNNlfvprHJpeaOG
 1CmNnVsgZOBt9GgvhXpYSnKgOFLwc6E8NeUlTgrra6pDRvBPGLvEr7QJQphiJlq5ZoF0V+mZkR9
 niSnF+hzq5aO3eHN4LxQ8YttEaqydMeiNBBxyJmv2lAyoGNDfLlvXo8vg6TzxtJbkGRA67/WygH
 rgeXkS
X-Google-Smtp-Source: AGHT+IES4ziFIyG6rOPVrAffUvDU4j/p9/zRtJYaJuNWocvEvnRfWWvdeDeYAmKH7rC47ZlS4GzDDA==
X-Received: by 2002:a05:6402:40cf:b0:5e4:a88a:64e with SMTP id
 4fb4d7f45d1cf-5e4d6ad4d42mr15328652a12.5.1740990267270; 
 Mon, 03 Mar 2025 00:24:27 -0800 (PST)
Received: from ?IPV6:2003:ef:2f02:800:9162:c8ad:3b21:a399?
 (p200300ef2f0208009162c8ad3b21a399.dip0.t-ipconnect.de.
 [2003:ef:2f02:800:9162:c8ad:3b21:a399])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e4c43a7a1fsm6534925a12.80.2025.03.03.00.24.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 00:24:26 -0800 (PST)
Message-ID: <86a56f19-3c94-467d-898d-5f22e1ef4420@suse.com>
Date: Mon, 3 Mar 2025 09:24:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wei Gao <wegao@suse.com>, ltp@lists.linux.it
References: <20241228114416.12653-1-wegao@suse.com>
 <20250301063134.14515-1-wegao@suse.com>
Content-Language: en-US
In-Reply-To: <20250301063134.14515-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] fcntl40.c: Test fcntl using F_CREATED_QUERY
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

Hi Wei,

On 3/1/25 07:31, Wei Gao via ltp wrote:
> Signed-off-by: Wei Gao <wegao@suse.com>
There's a double Signed-off signature.
> This is new test case for fcntl using new F_CREATED_QUERY operation.
> Based on a kernel selftest.
>
> Signed-off-by: Wei Gao <wegao@suse.com>
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
> index 5cd1ae656..5ba2315d1 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -364,6 +364,8 @@ fcntl38 fcntl38
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
> index 000000000..2e4bef3e2
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fcntl/fcntl40.c
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 SUSE Wei Gao <wegao@suse.com>
> + */
> +
> +/*\
> + * Basic test for fcntl using F_CREATED_QUERY.
> + * Verify if the fcntl() syscall is recognizing whether a file has been
> + * created or not via O_CREAT when O_CLOEXEC is also used.
> + *
> + * Test is based on a kernel selftests.
> + */
> +
> +#include "lapi/fcntl.h"
> +#include "tst_test.h"
> +
> +#define TEST_NAME "LTP_FCNTL_CREATED_QUERY_TEST"
> +
> +static void verify_fcntl(void)
> +{
> +	int fd;
> +
> +	fd = SAFE_OPEN("/dev/null", O_RDONLY | O_CLOEXEC);
> +
> +	/* We didn't create "/dev/null". */
> +	SAFE_FCNTL(fd, F_CREATED_QUERY, 0);

We are missing the main check here: fctnl() should return 1 if we 
created file via O_CREAT | O_EXCL and 0 if we didn't.
Se we should use TST_EXP_EQ_LI() in this case.

> +	SAFE_CLOSE(fd);
> +
> +	fd = SAFE_OPEN(TEST_NAME, O_CREAT | O_RDONLY | O_CLOEXEC, 0600);
> +
> +	SAFE_FCNTL(fd, F_CREATED_QUERY, 0);
Here as well.
> +	SAFE_CLOSE(fd);
> +
> +	fd = SAFE_OPEN(TEST_NAME, O_RDONLY | O_CLOEXEC);
> +
> +	/* We're opening it again, so no positive creation check. */
> +	SAFE_FCNTL(fd, F_CREATED_QUERY, 0);
Here as well.
> +	SAFE_CLOSE(fd);
> +	SAFE_UNLINK(TEST_NAME);
> +
> +	tst_res(TPASS, "fcntl F_CREATED_QUERY check pass");
And this is not needed anymore.
> +}
> +
> +static struct tst_test test = {
> +	.test_all = verify_fcntl,
> +	.needs_tmpdir = 1,
> +	.min_kver = "6.12",
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "d0fe8920cbe4"},
> +		{}
> +	}
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
