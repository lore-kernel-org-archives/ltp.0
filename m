Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D43C4332F
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 16:12:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED2EF3CD25D
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 17:12:25 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B88783CD214
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 17:12:16 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9839160055D
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 17:12:14 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 957D120118;
 Mon, 14 Nov 2022 16:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1668442334;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fKwwP2g0gDKEiMHkmSOkkFJRGfaaw6rwqVXQQMyxDgs=;
 b=g7Rq7jwARMAox0QBnW/ZyAAiqNQrau1Diea7kVpYZ1bLA9YdQAcOYVPaiVl9Id0BnX+pI7
 d82slgNXVV2hZOJA9E4rKKHkm7gnGA0rWKKIP+Ank2w2IJlfhUnM56R5850e3Fb2v1zTO0
 HkOJEbvkSViB8pywOuDEDLD+1BENouM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1668442334;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fKwwP2g0gDKEiMHkmSOkkFJRGfaaw6rwqVXQQMyxDgs=;
 b=ByMm3jvMT0+O8mGN6ni0M1mV7T8QWcX2XHdvZFm1UVbXtQ3aio6d0WRdm4jzUdZCETh1df
 99GmIBETolXCWSDg==
Received: from g78 (unknown [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 549A42C142;
 Mon, 14 Nov 2022 16:12:14 +0000 (UTC)
References: <20221112040107.3953862-1-liwang@redhat.com>
 <20221112040107.3953862-2-liwang@redhat.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Mon, 14 Nov 2022 16:02:51 +0000
Organization: Linux Private Site
In-reply-to: <20221112040107.3953862-2-liwang@redhat.com>
Message-ID: <87leodseg2.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] getitimer01: add checking for nonzero timer
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

Li Wang <liwang@redhat.com> writes:

> By default a new process disabled the timer and getitimer()
> returned zero value. But we also need to check if the timer
> is correct when reset to nonzero.
>
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>
> Notes:
>       The reason for using jiffy instead of time_step is that it only
>       checks the timer is set expectedly but not really expired. So we
>       use a rough value in the macro definition is enough.
>
>  .../kernel/syscalls/getitimer/getitimer01.c   | 84 ++++++++++++++++---
>  1 file changed, 71 insertions(+), 13 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/getitimer/getitimer01.c b/testcases/kernel/syscalls/getitimer/getitimer01.c
> index 5ecfac55c..a49f63a85 100644
> --- a/testcases/kernel/syscalls/getitimer/getitimer01.c
> +++ b/testcases/kernel/syscalls/getitimer/getitimer01.c
> @@ -12,25 +12,83 @@
>   */
>  
>  #include "tst_test.h"
> +#include "tst_safe_clocks.h"
>  
> -static int itimer_name[] = {
> -	ITIMER_REAL,
> -	ITIMER_VIRTUAL,
> -	ITIMER_PROF,
> +#define SEC  100
> +#define USEC 10000
> +
> +static struct itimerval *value;
> +static long jiffy;
> +
> +static struct tcase {
> +	int which;
> +	char *des;
> +} tcases[] = {
> +	{ITIMER_REAL,    "ITIMER_REAL"},
> +	{ITIMER_VIRTUAL, "ITIMER_VIRTUAL"},
> +	{ITIMER_PROF,    "ITIMER_PROF"},
>  };
>  
> -static void run(void)
> +static void set_setitimer_value(int sec, int usec)
>  {
> -	long unsigned int i;
> -	struct itimerval value;
> +	value->it_value.tv_sec = sec;
> +	value->it_value.tv_usec = usec;
> +	value->it_interval.tv_sec = sec;
> +	value->it_interval.tv_usec = usec;
> +}
>  
> -	for (i = 0; i < ARRAY_SIZE(itimer_name); i++) {
> -		TST_EXP_PASS(getitimer(itimer_name[i], &value));
> -		TST_EXP_EQ_LI(value.it_value.tv_sec, 0);
> -		TST_EXP_EQ_LI(value.it_value.tv_usec, 0);
> -	}
> +static void verify_getitimer(unsigned int i)
> +{
> +	struct tcase *tc = &tcases[i];
> +
> +	tst_res(TINFO, "tc->which = %s", tc->des);
> +
> +	TST_EXP_PASS(getitimer(tc->which, value));
> +	TST_EXP_EQ_LI(value->it_value.tv_sec, 0);
> +	TST_EXP_EQ_LI(value->it_value.tv_usec, 0);
> +	TST_EXP_EQ_LI(value->it_interval.tv_sec, 0);
> +	TST_EXP_EQ_LI(value->it_interval.tv_usec, 0);
> +
> +	set_setitimer_value(SEC, USEC);
> +	TST_EXP_PASS(setitimer(tc->which, value, NULL));
> +
> +	set_setitimer_value(0, 0);
> +	TST_EXP_PASS(getitimer(tc->which, value));
> +
> +	TST_EXP_EQ_LI(value->it_interval.tv_sec, SEC);
> +	TST_EXP_EQ_LI(value->it_interval.tv_usec, USEC);
> +
> +	tst_res(TINFO, "value->it_value.tv_sec=%ld, value->it_value.tv_usec=%ld",
> +			value->it_value.tv_sec, value->it_value.tv_usec);
> +
> +	/*
> +	 * ITIMER_VIRTUAL and ITIMER_PROF timers always expire a
> +	 * TICK_NSEC (jiffy) afterward the elapsed time to make
> +	 * sure that at least time counters take effect.
> +	 */
> +	long margin = (tc->which == ITIMER_REAL) ? 0 : jiffy;
> +
> +	if (value->it_value.tv_sec > SEC ||
> +			value->it_value.tv_usec > USEC + margin)

If a second is able to elapse then it_value.tv_usec can be greater than
USEC + margin. Or is there something I am missing?

I guess again there is the issue with wall clock time jumping around.

> +		tst_res(TFAIL, "timer value is not within the expected range");
> +	else
> +		tst_res(TPASS, "timer value is within the expected
> range");

Also we want to print all the relevant values in case of failure.

> +}
> +
> +static void setup(void)
> +{
> +	struct timespec time_res;
> +
> +	SAFE_CLOCK_GETRES(CLOCK_MONOTONIC_COARSE, &time_res);
> +	jiffy = (time_res.tv_nsec + 999) / 1000;
>  }
>  
>  static struct tst_test test = {
> -	.test_all = run
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.setup = setup,
> +	.test = verify_getitimer,
> +	.bufs = (struct tst_buffers[]) {
> +		{&value,  .size = sizeof(struct itimerval)},
> +		{}
> +	}
>  };
> -- 
> 2.35.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
