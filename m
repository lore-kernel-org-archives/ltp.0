Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C731C4332F
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 15:52:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB5EC3CD271
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 16:52:09 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B1E5F3CD20D
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 16:52:00 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 820891A000BB
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 16:51:59 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id CE091200EE;
 Mon, 14 Nov 2022 15:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1668441118;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vtTaafJFsfKOBi0NVv6PydVEbEj5/Yho0RpFsmJMvVQ=;
 b=rNZNN8wDLydv//FarBffq1lCIGUv12/LI2zwBw2yehMm6EniWh/NM6KVIM7Md7Z+qCuSwx
 3Go0ysU2ys7Im5gDyBztGCKEfL3NfLliR7BNxmbHuEFhB9UtaoA3iV+CiirO7dmmvDaK/y
 V22QwUwBtMPWVZQ5DlKoKxLD696iZFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1668441118;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vtTaafJFsfKOBi0NVv6PydVEbEj5/Yho0RpFsmJMvVQ=;
 b=Xs8ep815jFv+tJ8f+Ukgg1G/DwY+8zSOH6rAAsxSD7JVcmVgDWYtutHJWhC7Hyy3neBOyw
 QxaPt+g8c9ABuXCg==
Received: from g78 (unknown [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 91E3A2C142;
 Mon, 14 Nov 2022 15:51:58 +0000 (UTC)
References: <20221112040107.3953862-1-liwang@redhat.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Mon, 14 Nov 2022 14:32:48 +0000
Organization: Linux Private Site
In-reply-to: <20221112040107.3953862-1-liwang@redhat.com>
Message-ID: <87pmdpsfdv.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] setitimer01: add interval timer test
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
Cc: Andrea Cervesato <acervesato@suse.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Li Wang <liwang@redhat.com> writes:

> Split checking the return ovalue from testing the signal is
> delivered, so that we could use two time value for verifying.
>
> Also, adding interval timer test by handling the signal at
> least 10 times. After that recover the signal behavior to
> default and do deliver-signal checking.
>
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  .../kernel/syscalls/setitimer/setitimer01.c   | 63 ++++++++++++-------
>  1 file changed, 39 insertions(+), 24 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/setitimer/setitimer01.c b/testcases/kernel/syscalls/setitimer/setitimer01.c
> index 1f631d457..260590b0e 100644
> --- a/testcases/kernel/syscalls/setitimer/setitimer01.c
> +++ b/testcases/kernel/syscalls/setitimer/setitimer01.c
> @@ -22,8 +22,10 @@
>  #include "tst_safe_clocks.h"
>  
>  static struct itimerval *value, *ovalue;
> +static volatile unsigned long sigcnt;
>  static long time_step;
> -static long time_count;
> +static long time_sec;
> +static long time_usec;
>  
>  static struct tcase {
>  	int which;
> @@ -40,54 +42,66 @@ static int sys_setitimer(int which, void *new_value, void *old_value)
>  	return tst_syscall(__NR_setitimer, which, new_value, old_value);
>  }
>  
> -static void set_setitimer_value(int usec, int o_usec)
> +static void sig_routine(int signo LTP_ATTRIBUTE_UNUSED)
>  {
> -	value->it_value.tv_sec = 0;
> -	value->it_value.tv_usec = usec;
> -	value->it_interval.tv_sec = 0;
> -	value->it_interval.tv_usec = 0;
> +	sigcnt++;
> +}
>  
> -	ovalue->it_value.tv_sec = o_usec;
> -	ovalue->it_value.tv_usec = o_usec;
> -	ovalue->it_interval.tv_sec = 0;
> -	ovalue->it_interval.tv_usec = 0;
> +static void set_setitimer_value(int sec, int usec)
> +{
> +	value->it_value.tv_sec = sec;
> +	value->it_value.tv_usec = usec;
> +	value->it_interval.tv_sec = sec;
> +	value->it_interval.tv_usec = usec;
>  }
>  
>  static void verify_setitimer(unsigned int i)
>  {
>  	pid_t pid;
>  	int status;
> -	long margin;
>  	struct tcase *tc = &tcases[i];
>  
> +	tst_res(TINFO, "tc->which = %s", tc->des);
> +
>  	pid = SAFE_FORK();
>  
>  	if (pid == 0) {
> -		tst_res(TINFO, "tc->which = %s", tc->des);
> -
>  		tst_no_corefile(0);
>  
> -		set_setitimer_value(time_count, 0);
> +		set_setitimer_value(time_sec, time_usec);
>  		TST_EXP_PASS(sys_setitimer(tc->which, value, NULL));
>  
> -		set_setitimer_value(5 * time_step, 7 * time_step);
> +		set_setitimer_value(2 * time_sec, 2 * time_usec);

IDK if there was some reason for choosing 5 and 7 in the first place?

Andrea seemed to be going through the prime numbers.

>  		TST_EXP_PASS(sys_setitimer(tc->which, value, ovalue));
>  
> -		tst_res(TINFO, "tv_sec=%ld, tv_usec=%ld",
> -			ovalue->it_value.tv_sec,
> -			ovalue->it_value.tv_usec);
> +		TST_EXP_EQ_LI(ovalue->it_interval.tv_sec, time_sec);
> +		TST_EXP_EQ_LI(ovalue->it_interval.tv_usec, time_usec);
> +
> +		tst_res(TINFO, "ovalue->it_value.tv_sec=%ld, ovalue->it_value.tv_usec=%ld",
> +			ovalue->it_value.tv_sec, ovalue->it_value.tv_usec);
>  
>  		/*
>  		 * ITIMER_VIRTUAL and ITIMER_PROF timers always expire a
>  		 * time_step afterward the elapsed time to make sure that
>  		 * at least counters take effect.
>  		 */
> -		margin = tc->which == ITIMER_REAL ? 0 : time_step;
> +		long margin = (tc->which == ITIMER_REAL) ? 0 : time_step;

Looks like an unecessary change?

>  
> -		if (ovalue->it_value.tv_sec != 0 || ovalue->it_value.tv_usec > time_count + margin)
> +		if (ovalue->it_value.tv_sec > time_sec ||
> +				ovalue->it_value.tv_usec > time_usec + margin)

Looking at the man page, technically speaking the valid range for
ovalue->it_value.tv_sec is 0 to value->it_value.tv_sec when
ovalue->it_value.tv_usec > 0.

Practically speaking we have to assume a large amount of time has passed
when using ITIMER_REAL. It has to be *much* larger than a VM is likely
to be paused for and then successfully resumed. Or the amount of time a
clock may be corrected by (for e.g. with NTP).

>  			tst_res(TFAIL, "Ending counters are out of range");

While we are here; we should make our lives easier when the test fails
by printing any relevant values.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
