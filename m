Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012BAC83F1B
	for <ltp@archiver.kernel.org>; Mon, 14 Jul 2025 11:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752493793; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=GER7cXkfBEbIeTsRSQhNAv1RmickbP7H0YMhbhwMqvo=;
 b=UJB/Oz3NdwKcA68fkBSv1YdWUgfoR+taTlc1daSLNhb0oQpMf3/0LCQLHCjzWKVLyesrh
 NkYaiC/UjoDhgudVhoUCK98DuzNTj4z139x+FAuaLknknlSyiFymKBteZQJuJXfHAeFGR0W
 scd8tD7z8LHZpbaLmNqqCHB9EcfPYtI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E0AE53CB59B
	for <ltp@archiver.kernel.org>; Mon, 14 Jul 2025 13:49:53 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B495E3C06E9
 for <ltp@lists.linux.it>; Mon, 14 Jul 2025 13:49:32 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 001E21000A00
 for <ltp@lists.linux.it>; Mon, 14 Jul 2025 13:49:30 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4561ca74829so6642925e9.0
 for <ltp@lists.linux.it>; Mon, 14 Jul 2025 04:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752493770; x=1753098570; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ly3kwFTfEkxqNBd8O8B11VPPwcZbiUWoIVRh2cpZp84=;
 b=dwq6r3ognzHg3TpjEeFdjhq/YRykJ6DdLBYmRHnS8DX8M76MFfDipnNsmwvuDQp08M
 HFNpxBk3BLrdt8/hLlxD4VCXo+48ICWO/xPWhHp4NYp61dxAw539P9tRwjpijOO4JawI
 uwp/wO9chlQCeEcGf2ZfFBL+4hAbihLDsjx+a14xPFsXk4Hj1K5aUS/Xw7MPvZor/jG/
 CMF24i+xm9VBinY1gos6ASmgYiFWD9rKQBoirCdnP9dQciKjuGJS4/uEmc2oZ4aocj9g
 vIkbThxyqMn/4XvuPJxJy5F0vogSCr8F+WhQsBZ4tPCtDED1QCTqgFucCg/dqGu0kwmU
 XYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752493770; x=1753098570;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ly3kwFTfEkxqNBd8O8B11VPPwcZbiUWoIVRh2cpZp84=;
 b=Joe/vgBTARzvy1Q4BMoXHxwP/Nk4EWj7kCJr+nJHvvh2dmJW7dBtYZXGKLTGpybpDG
 7rFyuVSr0/8mW/hxOXeRuD5f5a/OmN7akUFP15UHb+PWxPpyn3F12NcYVOOHdWqckiCo
 KR5Fbyz8CJEHPTJBGQmV5xp9ku/g2YtYKfyYiEPOFs+y2uNSdn3uidcvkjKPyggkg5ny
 pOaaSiFOmAVJ8Hle08IMwRKi31iH1ORaZG+W7Wazw0l0FX3kJnPss8StkaI1NpUU6wY7
 HuZntqhupzA2fhqZQCJiJcniT1OlRrPlRn7ydsrRVvC+evKQpM09o+/QjAoTdbTSM8ve
 B6Xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWw5JQzh1wykWFtZrtXYXjXryjR7Wz1+Sfi/T0T5c3t5Zhr/dV690ffOPZ/voV23555dHQ=@lists.linux.it
X-Gm-Message-State: AOJu0YzgJSlOmPqhAz7310PgO9PO56UIB2wsWJfdDwl+A8F+28M0nFzj
 SmHbxOCTKHJ4FGm5dwYU6prxRo3vuzEI2/8sWIU/K1dD2CNVhbgw+Rxi/spmIFJ/Xy0QvtYBwsn
 3yrMDm2Cb8g==
X-Gm-Gg: ASbGnctoNGqNWBzBWZGVJxW5rYcfH7j6Nj2Ec58TLr7WRlNoGkheIEDkktgiGxlgYOY
 3Bf0gGrgFOkZ9ZuvgrTyGPDJ7bc5mQpkIfJA3yywVuMHn6yz8LrJ6WHsdDU3Ot/WbYAmLzzDTJn
 FZYMzucpeySm3bTN1CGNK7m1Wr4GTkDwwcZ7chPPo0ewpSrb5SgrAkWfOueG7BW3jnMwbJOs+jH
 HUz/R7N56xgCp2RQ/gfBFftZGJLmOy3F8FLU2X1r6CSdbbk1Y4uQz2Iwh/Eak5RhmvU8hIyMTaN
 ZAACHIN4L33raJHmBxfc1VVCFa6FF04ndh7c6HLZAtzORAJi+R1SH8gFYvk9vjM5sbRCNF4Enw4
 JPURrq0O6cmW/qUFLIS+Ysjvf3oEg2Whq
X-Google-Smtp-Source: AGHT+IELQ/R/4Od25e+6t0Fs8OiYceb252NAeplC49G4EDQt9f5/mFQGXNvP+tpmp7dDPEXUeWP7/w==
X-Received: by 2002:a05:600c:4fc7:b0:443:48:66d2 with SMTP id
 5b1f17b1804b1-454f425864cmr134724645e9.16.1752493770335; 
 Mon, 14 Jul 2025 04:49:30 -0700 (PDT)
Received: from [10.232.133.64] ([88.128.90.46])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-455f7af4bf0sm87862315e9.13.2025.07.14.04.49.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 04:49:30 -0700 (PDT)
Message-ID: <754f17cd-b5d4-4324-83d2-310c25d315cf@suse.com>
Date: Mon, 14 Jul 2025 13:49:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: lufei <lufei@uniontech.com>, ltp@lists.linux.it
References: <20250711072406.41444-1-lufei@uniontech.com>
 <20250714021951.47362-1-lufei@uniontech.com>
Content-Language: en-US
In-Reply-To: <20250714021951.47362-1-lufei@uniontech.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Add unshare(CLONE_NEWPID) test
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

On 7/14/25 4:19 AM, lufei wrote:
> Test unshare(CLONE_NEWPID) to make first child in new PID namespce get
> pid 1.
>
> Signed-off-by: lufei <lufei@uniontech.com>
> ---
>   runtest/syscalls                              |  1 +
>   testcases/kernel/syscalls/unshare/.gitignore  |  1 +
>   testcases/kernel/syscalls/unshare/unshare05.c | 47 +++++++++++++++++++
>   3 files changed, 49 insertions(+)
>   create mode 100644 testcases/kernel/syscalls/unshare/unshare05.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 57338297a..82e222bf4 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1726,6 +1726,7 @@ unshare01 unshare01
>   unshare02 unshare02
>   unshare03 unshare03
>   unshare04 unshare04
> +unshare05 unshare05
>   
>   #
>   # These tests require an unmounted block device
> diff --git a/testcases/kernel/syscalls/unshare/.gitignore b/testcases/kernel/syscalls/unshare/.gitignore
> index b1206e452..8ece5f988 100644
> --- a/testcases/kernel/syscalls/unshare/.gitignore
> +++ b/testcases/kernel/syscalls/unshare/.gitignore
> @@ -2,3 +2,4 @@
>   /unshare02
>   /unshare03
>   /unshare04
> +/unshare05
> diff --git a/testcases/kernel/syscalls/unshare/unshare05.c b/testcases/kernel/syscalls/unshare/unshare05.c
> new file mode 100644
> index 000000000..59fc782ab
> --- /dev/null
> +++ b/testcases/kernel/syscalls/unshare/unshare05.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2025 lufei <lufei@uniontech.com>
> + */
> +
> +/*\
> + * This test case verifies unshare(CLONE_NEWPID) creates a new PID namespace
> + * and that the first child process in the new namespace gets PID 1.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include "tst_test.h"
> +#include "sched.h"
We have "lapi/sched.h"
> +
> +static struct tst_clone_args *args;
> +
> +static void setup(void)
> +{
> +	args->flags = CLONE_NEWPID;
> +	args->exit_signal = SIGCHLD;
> +}
> +
> +static void run(void)
> +{
> +	if (!SAFE_CLONE(args)) {
> +		SAFE_UNSHARE(CLONE_NEWPID);
> +
> +		if (!SAFE_FORK()) {
> +			TST_EXP_EQ_LI(getpid(), 1);
> +			exit(0);
> +		}
Here we need also exit(0);
> +	}
> +
> +	SAFE_WAIT(NULL);
This is not needed, LTP calls "tst_reap_children()" automatically.
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.forks_child = 1,
> +	.needs_root = 1,
> +	.test_all = run,
> +	.bufs = (struct tst_buffers []) {
> +		{&args, .size = sizeof(*args)},
> +		{},
> +	}
> +};
- Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
