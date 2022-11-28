Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5740DC433FE
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 14:38:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 334CD3CC67E
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 15:38:18 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6BA993C32D9
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 15:38:08 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9CFB720032F
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 15:38:06 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 730A121B23;
 Mon, 28 Nov 2022 14:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1669646286;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ppli+BqEMQIbcG4KAFsWBRa8ky31lvUlzGW8qaC9tO0=;
 b=J2U22EC5rkpu6+0nDGTWznbR5RI9F8cu8A9q11Mr69vAAjXNmh/HJNBnkL49iWAXSCS8nY
 S1eVeTea0QKJCG1cJWY1qvU34ZlxfKrgzkGLEF5rm2LPJLWtn2NzUP75VTMku86yxdUfdL
 K5yx9APWxOYZoWPKMYsWHCnOiyQ6sVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1669646286;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ppli+BqEMQIbcG4KAFsWBRa8ky31lvUlzGW8qaC9tO0=;
 b=J7uHTUayEKVlYAl7i/H0i0pF70UM90mdqwhXbIBPyCvndlZVvLrQ7zBIeDLxCx946/3Vev
 vqLaZG2hpKof4dBA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 14C1A2C141;
 Mon, 28 Nov 2022 14:38:06 +0000 (UTC)
References: <20221116034910.37030-1-zhaogongyi@huawei.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Mon, 28 Nov 2022 14:26:52 +0000
Organization: Linux Private Site
In-reply-to: <20221116034910.37030-1-zhaogongyi@huawei.com>
Message-ID: <87lenvuotu.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/nice01: Add test nice(-1) and nice(-50)
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Zhao Gongyi via ltp <ltp@lists.linux.it> writes:

> 1. Add test verify that the errno is zero when callling of nice
> legitimately return -1.(nice(-1), the default nice is usally 0)
> 2. Add test verify that user of root can decrease the nice value of
> the process successfully by passing a lower increment
> value (< min. applicable limits) to nice() system call.(nice(-50))
>
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>  testcases/kernel/syscalls/nice/nice01.c | 27 ++++++++++++++-----------
>  1 file changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/nice/nice01.c b/testcases/kernel/syscalls/nice/nice01.c
> index 876246180..bc022a265 100644
> --- a/testcases/kernel/syscalls/nice/nice01.c
> +++ b/testcases/kernel/syscalls/nice/nice01.c
> @@ -17,29 +17,31 @@
>  #include <sys/resource.h>
>  #include "tst_test.h"
>
> -#define	NICEINC		-12
> -#define MIN_PRIO	-20
> +#define MIN_PRIO        -20
>
> -static void verify_nice(void)
> +static int nice_inc[] = {-1, -12, -50};
> +
> +static void verify_nice(unsigned int i)
>  {
>  	int new_nice;
>  	int orig_nice;
>  	int exp_nice;
> +	int inc = nice_inc[i];
>
>  	orig_nice = SAFE_GETPRIORITY(PRIO_PROCESS, 0);
>
> -	TEST(nice(NICEINC));
> +	TEST(nice(inc));
>
> -	exp_nice = MAX(MIN_PRIO, (orig_nice + NICEINC));
> +	exp_nice = MAX(MIN_PRIO, (orig_nice + inc));
>
>  	if (TST_RET != exp_nice) {
>  		tst_res(TFAIL | TTERRNO, "nice(%d) returned %li, expected %i",
> -			NICEINC, TST_RET, exp_nice);
> +				inc, TST_RET, exp_nice);
>  		return;
>  	}
>
>  	if (TST_ERR) {
> -		tst_res(TFAIL | TTERRNO, "nice(%d) failed", NICEINC);
> +		tst_res(TFAIL | TTERRNO, "nice(%d) failed", inc);
>  		return;
>  	}
>
> @@ -47,18 +49,19 @@ static void verify_nice(void)
>
>  	if (new_nice != exp_nice) {
>  		tst_res(TFAIL, "Process priority %i, expected %i",
> -				new_nice, orig_nice + NICEINC);
> +				new_nice, exp_nice);
>  		return;
>  	}
>
> -	tst_res(TPASS, "nice(%d) passed", NICEINC);
> +	tst_res(TPASS, "nice(%d) passed", inc);
>
> -	TEST(nice(-NICEINC));
> +	TEST(setpriority(PRIO_PROCESS, 0, orig_nice));

This is the nice test not the setpriority test (which also has a SAFE_ variant).

>  	if (TST_ERR)
> -		tst_brk(TBROK | TTERRNO, "nice(%d) failed", -NICEINC);
> +		tst_brk(TBROK | TTERRNO, "setpriority(%d) failed", orig_nice);
>  }
>
>  static struct tst_test test = {
> -	.test_all = verify_nice,
>  	.needs_root = 1,
> +	.test = verify_nice,
> +	.tcnt = ARRAY_SIZE(nice_inc),
>  };
> --
> 2.17.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
