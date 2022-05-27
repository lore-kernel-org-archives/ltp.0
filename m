Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34EBFC433F5
	for <ltp@archiver.kernel.org>; Fri, 27 May 2022 11:07:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0408B3C184E
	for <ltp@archiver.kernel.org>; Fri, 27 May 2022 13:07:48 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B6C93C0FBC
 for <ltp@lists.linux.it>; Fri, 27 May 2022 13:07:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 613D81A00E2B
 for <ltp@lists.linux.it>; Fri, 27 May 2022 13:07:35 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 75E5C1F96C;
 Fri, 27 May 2022 11:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1653649655;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h8NG40Cm0s3CX8Gx6m9ocJFO3PAt6JSCxlHxwzTqTwA=;
 b=Fd6DRml5euufKIz02MfB0mLF0mA/G6xdF1elgd7KaN328MxJktstFGTq/3Q+CRNz1nN+Wx
 f7qwMTA663HLR7bbzGWxCtQYj50NQAtjJwG5mk2YoNAlmEtlIspxNxUbInCfCr1VCNFf9P
 r/cPWDFeShjO0q+CiFLnN1bmyb7luDo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1653649655;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h8NG40Cm0s3CX8Gx6m9ocJFO3PAt6JSCxlHxwzTqTwA=;
 b=MU/XkaLYWzroRdxJEKb04zjHLfrLSzNPx5qyjWZIgejxD7yHe7xHkmCvzHBCW8nPXaz3sC
 HERJnkSyizHO3TAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A0CA139C4;
 Fri, 27 May 2022 11:07:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NZ+gC/ewkGK3fgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 27 May 2022 11:07:35 +0000
Date: Fri, 27 May 2022 13:07:32 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Message-ID: <YpCw9Kj5CvvmYjME@pevik>
References: <20220507073642.219085-1-zhaogongyi@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220507073642.219085-1-zhaogongyi@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] nice05: Add testcase for nice() syscall
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Zhao,

on first look LGTM, few notes below.

make check complains about style, could you please fix it?

$ make check-nice05
CHECK testcases/kernel/syscalls/nice/nice05.c
nice05.c:48: ERROR: "foo* bar" should be "foo *bar"
nice05.c:48: ERROR: "foo* bar" should be "foo *bar"
nice05.c:53: ERROR: "(foo*)" should be "(foo *)"
nice05.c:70: ERROR: "foo* bar" should be "foo *bar"
nice05.c:70: ERROR: "foo* bar" should be "foo *bar"
nice05.c:75: ERROR: "(foo*)" should be "(foo *)"
nice05.c:104: WARNING: braces {} are not necessary for single statement blocks
nice05.c:114: WARNING: braces {} are not necessary for single statement blocks
nice05.c:138: ERROR: "(foo*)" should be "(foo *)"
nice05.c:139: ERROR: "(foo*)" should be "(foo *)"
nice05.c:148: ERROR: space required before the open parenthesis '('
nice05.c:154: ERROR: space required before the open parenthesis '('
make: [../../../../include/mk/rules.mk:56: check-nice05] Error 1 (ignored)


> Add test verify that the low nice thread execute more cycles than
                                           ^ executes

> the high nice thread since the two thread binded on the same cpu.

> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>

...
> diff --git a/testcases/kernel/syscalls/nice/nice05.c b/testcases/kernel/syscalls/nice/nice05.c
...
> +/*\
> + * [Description]
> + *
> + * 1. Create a high nice thread and a low nice thread, the main
> + *    thread wake them at the same time
> + * 2. Both threads run on the same CPU
> + * 3. Verify that the low nice thread execute more cycles than
                                         ^ executes

> + *    the high nice thread
> + */
> +
> +#define _GNU_SOURCE
> +#include <pthread.h>
> +#include "tst_test.h"
> +#include "tst_safe_pthread.h"
> +
> +#define LIMIT_TIME 3
> +#define RUN_TIMES 1000000
It might be useful if user could change this value with getopt switch (to debug
on error to speedup). I also wonder if we hit timeout on some slow machine.

...
> +static void verify_nice(void)
> +{
> +	int ret;
> +	int nice_inc_high = -1;
> +	int nice_inc_low = -2;
> +	pthread_t nice_low, nice_high;
> +
> +	ret = pthread_barrier_init(&barrier, NULL, 3);
> +	if (ret != 0) {
> +		tst_brk(TBROK, "pthread_barrier_init() returned %s",
> +			tst_strerrno(-ret));
> +	}
Maybe just:
	if (pthread_barrier_init(&barrier, NULL, 3) != 0)
		tst_brk(TBROK | TERRNO, "pthread_barrier_init() failed");

Or feel free to use ret if you need it (see below), the point is with tst_brk()
use TERRNO. Or am I missing something pthread specific?

> +	SAFE_PTHREAD_CREATE(&nice_high, NULL, nice_high_thread, (void*)&nice_inc_high);
> +	SAFE_PTHREAD_CREATE(&nice_low, NULL, nice_low_thread, (void*)&nice_inc_low);
> +
> +	pthread_barrier_wait(&barrier);
Not an expert on pthread, but IMHO you should compare
PTHREAD_BARRIER_SERIAL_THREAD with the result of pthread_barrier_wait(), with
your current code you compare with the result of pthread_barrier_init().
> +	if (ret != 0 && ret != PTHREAD_BARRIER_SERIAL_THREAD)
> +		tst_brk(TBROK | TERRNO, "pthread_barrier_wait() failed");
> +
> +	sleep(LIMIT_TIME);
> +
> +	ret = pthread_cancel(nice_high);
> +	if(ret) {
> +		tst_brk(TBROK, "pthread_cancel() returned %s",
> +			tst_strerrno(-ret));
if (pthread_cancel(nice_high))
	tst_brk(TBROK | TERRNO, "pthread_cancel() failed");

> +	}
> +
> +	ret = pthread_cancel(nice_low);
> +	if(ret) {
> +		tst_brk(TBROK, "pthread_cancel() returned %s",
> +			tst_strerrno(-ret));
and here as well.
> +	}
> +
> +	ret = pthread_barrier_destroy(&barrier);
> +	if (ret) {
> +		tst_brk(TBROK, "pthread_barrier_destroy() returned %s",
> +			tst_strerrno(-ret));
> +	}
> +
> +	SAFE_PTHREAD_JOIN(nice_high, NULL);
> +	SAFE_PTHREAD_JOIN(nice_low, NULL);
> +
> +	if (time_nice_low > time_nice_high) {
> +		tst_res(TPASS, "time_nice_low = %lld time_nice_high = %lld",
> +			time_nice_low, time_nice_high);
> +	} else {
> +		tst_brk(TFAIL | TTERRNO, "Test failed :"
Wrong space between ':', missing after it, use:
		tst_brk(TFAIL | TTERRNO, "Test failed: "


Kind regards,
Petr

> +			"time_nice_low = %lld time_nice_high = %lld",
> +			time_nice_low, time_nice_high);
> +	}
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = verify_nice,
> +	.needs_root = 1,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
