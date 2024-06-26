Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F293C30653
	for <ltp@archiver.kernel.org>; Wed, 26 Jun 2024 11:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1719402444; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=FDngB/EYrXQIr3nrGRDrBeAAmOIGfDciBXIqV+jzkmI=;
 b=l3QE957lYegNss5nfUPVIWJhCdYtXq9y+l6CNYZ9GrJEztLy4sZXsQp/oj0g53S8VupM8
 oDDNkwsy2IPUv1UiJEzidoCkM03Qtx5LKYqQR7Lp+bE4RZTSXGi3Jln4w2IL+AXvY3cwZCo
 sclzcEa9O6wIbgx9vuT2VfDKRwd7B7I=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA80F3D1133
	for <ltp@archiver.kernel.org>; Wed, 26 Jun 2024 13:47:24 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BCCE13C1037
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 13:47:00 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 113732009A9
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 13:47:00 +0200 (CEST)
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2ebe0a81dc8so87372001fa.2
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 04:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1719402419; x=1720007219; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uP2LJbfWOlQicnRWR1AydaIyXtcNzTL86tvoAOjEgB0=;
 b=GuxPkUzGC9toVzYWhrJFM+LeSTxQZKp5acEiduiyxm4MvZeb367FF3jhqvMOB3QfoQ
 09HN0jhm5U4HFNQxrJTQMeJspERrwyL8Woi5/G3dv2P19uNDREXFd/1M1LbIlxAE6f40
 5E0mZcjcMpjgb0G0hwAJy95i3rMv2lcWK7S3uwIfw3M8c5WGRq3JgBZbKHdd9Xzt71DK
 0I3fMcWPRWowRa5+IuhPLAWZO615Yl3ubIFr/hfnb7/I4oRcTRODtH1ge1QEx88eCFNP
 ADSQ64yYZmBTuM+adFNiplGr7brk9Paqy/Qi6ofAzcso26lCKEWM3aENfl1antCqAJHE
 TLSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719402419; x=1720007219;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uP2LJbfWOlQicnRWR1AydaIyXtcNzTL86tvoAOjEgB0=;
 b=V99XBbbuZfYmxNFtdDmMERepoHcFmA4Z9QdM4MGk5T1nnuQ9pi48mzJhq7NAlQ1TCE
 l+VofAmFQS7BdaMKyhYUnGoKQxrR8Qdj8nXJfTUASg6nsYP3eqciQaBrS4TSkc0XmnwG
 zrEriDYuHiISugwzDqLhr5PgzeqUlC1ZfxlqT3rA1HgTNLEzaVBmIwfDcrUo05R1OZPU
 c5d8hL3DIN+86mIAMsiSkcTBnlBCeh0YcOHupJbwFJQZNMZQJoxP2oEqzVFBLw1CfzSP
 FVs0+k6nOjECD7yxFMkO81so2GZ9nkHgQyeaIkrETNYg06EmwutlVjiLeist9P1xjS3C
 S8Bg==
X-Gm-Message-State: AOJu0Yzm1nNNHcL4+Uj1Xvlgrev+BYFg4+I37ObEnX8uMEkiv3IG0EWc
 6jMKn/KL6lsgUDj+/hx3oTwk8029nBDz9z8S3M48M2XoPGTSUzluVGg1YCj73DRISeBzS65zh6o
 Mm/E=
X-Google-Smtp-Source: AGHT+IGc5GSNL6bFs4ZohyA7tEzun3lb1+nk3RRMbCXgWwa+3kehPnRxHYOHxo2vc7svUNnpxsUEqw==
X-Received: by 2002:a2e:964c:0:b0:2ed:136b:7563 with SMTP id
 38308e7fff4ca-2ed136b79b5mr17441701fa.33.1719402418622; 
 Wed, 26 Jun 2024 04:46:58 -0700 (PDT)
Received: from [10.232.133.69] ([88.128.88.49])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb3c6032sm97637265ad.150.2024.06.26.04.46.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 04:46:58 -0700 (PDT)
Message-ID: <2d226ceb-4a96-4979-a44e-750d594559f7@suse.com>
Date: Wed, 26 Jun 2024 13:46:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it, Li Wang <liwang@redhat.com>
References: <20240626105431.746411-1-liwang@redhat.com>
Content-Language: en-US
In-Reply-To: <20240626105431.746411-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/2] lib: add TST_RES_ serious macros
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

Sorry but I don't see the point on it. What we can do with tst_res() is 
enough and this patch adds one more layer of complexity to the main library.
Both approaches are equivalent, also from the point of view of the 
ending result.

I will let other maintainers discussing this feature, but from my point 
of view (as reviewer), I would reject it.

Best regards,
Andrea

On 6/26/24 12:54, Li Wang wrote:
> This patch introduces new macros to encapsulate existing tst_res and
> tst_brk functions in the LTP library. These macros simplify the usage
> of tst_ functions by providing a more user-friendly interface for
> generating standardized test output.
>
>    TST_RES_TINFO()    -> tst_res(TINFO, ...)
>    TST_RES_TWARN()    -> tst_res(TINFO, "WARNING: ", ...)
>    TST_RES_TPASS()    -> tst_res(TPASS, ...)
>    TST_RES_TDEBUG()   -> tst_res(TDEBUG, ...)
>    TST_RES_TFAIL()    -> tst_res(TFAIL,  ...)
>
>    TST_BRK_TCONF()    -> tst_brk(TCONF, ...)
>    TST_BRK_TBROK()    -> tst_brk(TBROK,  ...)
>
>    TST_RES_TPASS_ER() -> tst_res(TPASS | errno, ...)
>    TST_RES_TFAIL_ER() -> tst_res(TFAIL | errno, ...)
>    TST_BRK_TBROK_ER() -> tst_brk(TBROK | errno, ... )
>
> The macros handle various scenarios including simple messages and messages
> with error flags, ensuring consistent logging of file and line information.
>
> Additionally, a new test case in tst_res_macros.c demonstrates the usage
> of these macros.
>
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>
> Notes:
>      At the begining I wanted to implement one macro to implement functionality
>      like handling both messages and printing errno with the message. Still,
>      after trying some complex macro definition usages I found that this made
>      things too complex and confusing, so why not define more macros for special
>      use, and then this patch was signed.
>      
>      Maybe something like TST_RES_TFAIL_ER is not a good name, but please help to
>      give another, or any advise will be appreciated.
>
>   include/tst_test_macros.h         | 34 +++++++++++++++++++++
>   lib/newlib_tests/tst_res_macros.c | 50 +++++++++++++++++++++++++++++++
>   2 files changed, 84 insertions(+)
>   create mode 100644 lib/newlib_tests/tst_res_macros.c
>
> diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
> index 22b39fb14..e36df9c0d 100644
> --- a/include/tst_test_macros.h
> +++ b/include/tst_test_macros.h
> @@ -368,4 +368,38 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
>   #define TST_EXP_EQ_SSZ(VAL_A, VAL_B) \
>   		TST_EXP_EQ_(VAL_A, #VAL_A, VAL_B, #VAL_B, ssize_t, "%zi")
>   
> +/* Test result print macros */
> +#define TST_RES_TINFO(MESSAGE, ...) \
> +	tst_res(TINFO, MESSAGE, ##__VA_ARGS__)
> +
> +#define TST_RES_TCONF(MESSAGE, ...) \
> +	tst_res(TCONF, MESSAGE, ##__VA_ARGS__)
> +
> +#define TST_BRK_TCONF(MESSAGE, ...) \
> +	tst_brk(TCONF, MESSAGE, ##__VA_ARGS__)
> +
> +#define TST_RES_TWARN(MESSAGE, ...) \
> +	tst_res(TINFO, "WARNING: "MESSAGE, ##__VA_ARGS__)
> +
> +#define TST_RES_TPASS(MESSAGE, ...) \
> +	tst_res(TPASS, MESSAGE, ##__VA_ARGS__)
> +
> +#define TST_RES_TPASS_ER(flag, MESSAGE, ...) \
> +	tst_res(TPASS | flag, MESSAGE, ##__VA_ARGS__)
> +
> +#define TST_RES_TDEBUG(MESSAGE, ...) \
> +	tst_res(TDEBUG, MESSAGE, ##__VA_ARGS__)
> +
> +#define TST_RES_TFAIL(MESSAGE, ...) \
> +	tst_res(TFAIL, MESSAGE, ##__VA_ARGS__)
> +
> +#define TST_RES_TFAIL_ER(flag, MESSAGE, ...) \
> +	tst_res(TFAIL | flag, MESSAGE, ##__VA_ARGS__)
> +
> +#define TST_BRK_TBROK(MESSAGE, ...) \
> +	tst_brk(TBROK, MESSAGE, ##__VA_ARGS__)
> +
> +#define TST_BRK_TBROK_ER(flag, MESSAGE, ...) \
> +	tst_brk(TBROK | flag, MESSAGE, ##__VA_ARGS__)
> +
>   #endif	/* TST_TEST_MACROS_H__ */
> diff --git a/lib/newlib_tests/tst_res_macros.c b/lib/newlib_tests/tst_res_macros.c
> new file mode 100644
> index 000000000..74b656da0
> --- /dev/null
> +++ b/lib/newlib_tests/tst_res_macros.c
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2024 Li Wang <liwang@redhat.com>
> + */
> +
> +#include "tst_test.h"
> +
> +static void do_test(void)
> +{
> +	int i = 10, j = 20;
> +	char *str = "test";
> +
> +	TST_RES_TINFO("message");
> +	TST_RES_TINFO("message, i = %d", i);
> +	TST_RES_TDEBUG("message, i = %d", i);
> +
> +	TST_RES_TPASS("message");
> +	TST_RES_TPASS("message, i = %d, j = %d, str = %s", i, j, str);
> +	TST_RES_TPASS_ER(TTERRNO, "message, i = %d, j = %d", i, j);
> +
> +	TST_RES_TWARN("message");
> +	TST_RES_TWARN("message, i = %d", i);
> +
> +	TST_RES_TFAIL("message");
> +	TST_RES_TFAIL("message, i = %d, j = %d", i, j);
> +
> +	TST_RES_TFAIL_ER(TERRNO, "message");
> +	TST_RES_TFAIL_ER(TERRNO, "message, i = %d, j = %d", i, j);
> +	TST_RES_TFAIL_ER(TERRNO, "message, i = %d, str = %s", i, str);
> +
> +	TST_RES_TFAIL_ER(TTERRNO, "message");
> +	TST_RES_TFAIL_ER(TTERRNO, "message, i = %d", i);
> +	TST_RES_TFAIL_ER(TTERRNO, "message, i = %d, str = %s", i, str);
> +
> +	TST_BRK_TBROK("message");
> +	TST_BRK_TBROK("message, i = %d, j = %d", i, j);
> +
> +	TST_BRK_TBROK_ER(TERRNO, "message");
> +	TST_BRK_TBROK_ER(TERRNO, "message, i = %d, str = %s", i, str);
> +
> +	TST_BRK_TBROK_ER(TTERRNO, "message");
> +	TST_BRK_TBROK_ER(TTERRNO, "message, i = %d", i);
> +	TST_BRK_TBROK_ER(TTERRNO, "message, i = %d, str = %s", i, str);
> +
> +	TST_BRK_TCONF("message, i = %d, j = %d, str = %s", i, j, str);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = do_test,
> +};



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
