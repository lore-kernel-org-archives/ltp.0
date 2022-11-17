Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA67C4332F
	for <ltp@archiver.kernel.org>; Thu, 17 Nov 2022 09:58:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E58903CCF31
	for <ltp@archiver.kernel.org>; Thu, 17 Nov 2022 10:58:11 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 822AD3CCF25
 for <ltp@lists.linux.it>; Thu, 17 Nov 2022 10:58:02 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C979520AF08
 for <ltp@lists.linux.it>; Thu, 17 Nov 2022 10:58:01 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id E584F1F8BE;
 Thu, 17 Nov 2022 09:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1668679079;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x5wXekdKv4yEdhv4+xQbLrGmzwpvUvJfy6tjAkqeh8Y=;
 b=fM9tuPkBeqFYUhR4DvoZkKWqIOOz76VzCGlNDbYu15GOtv/7jSYDebnSgKGB1jA6vA1FD2
 D6fXatuL4RWVmKbnCXhqPyKTCK9UYHLRIJG1EbrfG4vT1N/m3TK8RrNF8dU3WRhV4aTngz
 k3CMOVNknHJ+vXjAIMWH/UUQG1+eJDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1668679079;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x5wXekdKv4yEdhv4+xQbLrGmzwpvUvJfy6tjAkqeh8Y=;
 b=j0ViYX/kyNlgqlv9oq0yRnbgXv7ICmBco1ETxuy7WMgwa0Q2ietSuA3/eSr4IQBoJ08Ygy
 6WwnRsGcd4P8VWAA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id BD83D2C141;
 Thu, 17 Nov 2022 09:57:59 +0000 (UTC)
References: <20221116122646.4085688-1-liwang@redhat.com>
 <20221116122646.4085688-2-liwang@redhat.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Thu, 17 Nov 2022 09:57:47 +0000
Organization: Linux Private Site
In-reply-to: <20221116122646.4085688-2-liwang@redhat.com>
Message-ID: <87edu1rjh4.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] getitimer01: add checking for nonzero timer
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
>     v1 --> v2
>         * reset itimer value to zero to make parameter '-i' works
>         * print the time at the begining and end of test
>         * sperately compare result for tv_sec elapse or not
>         * print more info when TFAIL

Merged, thanks!

>
>  .../kernel/syscalls/getitimer/getitimer01.c   | 108 ++++++++++++++++--
>  1 file changed, 96 insertions(+), 12 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/getitimer/getitimer01.c b/testcases/kernel/syscalls/getitimer/getitimer01.c
> index 5ecfac55c..6b0cfba1c 100644
> --- a/testcases/kernel/syscalls/getitimer/getitimer01.c
> +++ b/testcases/kernel/syscalls/getitimer/getitimer01.c
> @@ -12,25 +12,109 @@
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
> +static struct timeval tv;
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
> +{
> +	value->it_value.tv_sec = sec;
> +	value->it_value.tv_usec = usec;
> +	value->it_interval.tv_sec = sec;
> +	value->it_interval.tv_usec = usec;
> +}
> +
> +static void verify_getitimer(unsigned int i)
>  {
> -	long unsigned int i;
> -	struct itimerval value;
> +	struct tcase *tc = &tcases[i];
> +
> +	tst_res(TINFO, "tc->which = %s", tc->des);
>  
> -	for (i = 0; i < ARRAY_SIZE(itimer_name); i++) {
> -		TST_EXP_PASS(getitimer(itimer_name[i], &value));
> -		TST_EXP_EQ_LI(value.it_value.tv_sec, 0);
> -		TST_EXP_EQ_LI(value.it_value.tv_usec, 0);
> +	if (tc->which == ITIMER_REAL) {
> +		if (gettimeofday(&tv, NULL) == -1)
> +			tst_brk(TBROK | TERRNO, "gettimeofday(&tv1, NULL) failed");
> +		else
> +			tst_res(TINFO, "Test begin time: %ld.%lds", tv.tv_sec, tv.tv_usec);
>  	}
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
> +	if (value->it_value.tv_sec == SEC) {
> +		if (value->it_value.tv_usec < 0 ||
> +				value->it_value.tv_usec > USEC + margin)
> +			tst_brk(TFAIL, "value->it_value.tv_usec is out of range: %ld",
> +				value->it_value.tv_usec);
> +	} else {
> +		if (value->it_value.tv_sec < 0 ||
> +				value->it_value.tv_sec > SEC)
> +			tst_brk(TFAIL, "value->it_value.tv_sec is out of range: %ld",
> +				value->it_value.tv_sec);
> +	}
> +
> +	tst_res(TPASS, "timer value is within the expected range");
> +
> +	if (tc->which == ITIMER_REAL) {
> +		if (gettimeofday(&tv, NULL) == -1)
> +			tst_brk(TBROK | TERRNO, "gettimeofday(&tv1, NULL) failed");
> +		else
> +			tst_res(TINFO, "Test end time: %ld.%lds", tv.tv_sec, tv.tv_usec);
> +	}
> +
> +	set_setitimer_value(0, 0);
> +	TST_EXP_PASS_SILENT(setitimer(tc->which, value, NULL));
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


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
