Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8003FC433FE
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 14:12:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 15C2F3CAEBC
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 15:12:00 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A0A43C0135
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 15:11:49 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 74F06140053B
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 15:11:47 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 543331F921;
 Fri,  4 Nov 2022 14:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1667571107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bx3gDS7QbWVkkCd5oml3t/6sSBY5kabtk7O2pXYqG3I=;
 b=gPx4kuw+1zc5C1h+32AG0ItUal0B6zvnMc4iH0bH4SBduZPeHC1xvkd1LpiyQbf5B9cbrV
 k9h2v/p0dsZEqoHvZLynYiS3POwd1wrMHBPvnqWckcY977vxReNoeqw9gS5mCe5Ir2nq3L
 Z+XLpLJlxoTC+skbqXsie3/Kreahj8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1667571107;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bx3gDS7QbWVkkCd5oml3t/6sSBY5kabtk7O2pXYqG3I=;
 b=51vmiuIFPuh2zumpdml6loiQmY4ZLeSXr/+JGf1rjqdGBDN7gppduTOZ46smMLMDSs2PxH
 FSQEucmsI81MOPDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1275D1346F;
 Fri,  4 Nov 2022 14:11:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jKkWA6MdZWN6JgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 04 Nov 2022 14:11:47 +0000
Date: Fri, 4 Nov 2022 15:13:20 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <Y2UeAGj58zSd47Rt@yuki>
References: <20221104092411.5446-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221104092411.5446-1-andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Correctly handle user time in setitimer01
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Since ITIMER_VIRTUAL and ITIMER_PROF are counting down in user time, we
> need to take in consideration CLOCK_MONOTONIC_COARSE resolution. This is
> requested by the syscall, since it's considering context switch from
> user to kernel mode by using a higher clock resolution.

What exactly do you mean by this? I do not think that there is "user"
and "kernel" time, just different in-kernel timers/counters with
different precisions.

As ITIMER_VIRTUAL and ITIMER_PROF counts CPU time the precision would be
the same as the COARSE clocks which depends on jiffies and on the
compile time option CONFIG_HZ. That is because in the scheduller the CPU
time is quantized into chunks based on CONFIG_HZ.

And the ITIMER_REAL runs on hrtimers which would be the same precision
as CLOCK_REALTIME or CLOCK_MONOTONIC.

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  .../kernel/syscalls/setitimer/setitimer01.c   | 54 +++++++++++--------
>  1 file changed, 33 insertions(+), 21 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/setitimer/setitimer01.c b/testcases/kernel/syscalls/setitimer/setitimer01.c
> index eb62f02c6..5fcae53e8 100644
> --- a/testcases/kernel/syscalls/setitimer/setitimer01.c
> +++ b/testcases/kernel/syscalls/setitimer/setitimer01.c
> @@ -8,9 +8,16 @@
>  /*\
>   * [Description]
>   *
> - * Spawn a child and verify that setitimer() syscall passes, and it ends up
> + * Spawn a child, verify that setitimer() syscall passes and it ends up
>   * counting inside expected boundaries. Then verify from the parent that our
>   * syscall sent the correct signal to the child.
> + *
> + * Boundaries are choosen accordingly with system clock. In particular, when
> + * timer counts down in real time, CLOCK_MONOTONIC resolution has taken into
> + * account as our time step. When timer counts down in user time,
> + * CLOCK_MONOTONIC_COARSE is used. The reason is that CLOCK_MONOTONIC_COARSE
> + * is our system resolution in user space, since it's taking in consideration
> + * context switches from user to kernel space.
>   */
>  
>  #include <time.h>
> @@ -22,7 +29,6 @@
>  #include "tst_safe_clocks.h"
>  
>  static struct itimerval *value, *ovalue;
> -static unsigned long time_step;
>  
>  static struct tcase {
>  	int which;
> @@ -55,9 +61,31 @@ static void set_setitimer_value(int usec, int o_usec)
>  static void verify_setitimer(unsigned int i)
>  {
>  	pid_t pid;
> -	int status;
> -	int usec = 3 * time_step;
> +	struct timespec res;
>  	struct tcase *tc = &tcases[i];
> +	int status, usec, time_step, error;
> +
> +	if (tc->which == ITIMER_REAL)
> +		SAFE_CLOCK_GETRES(CLOCK_MONOTONIC, &res);
> +	else
> +		SAFE_CLOCK_GETRES(CLOCK_MONOTONIC_COARSE, &res);

This is not going to change, so we may as well get the fine/coarse
resolution once in the test setup and initialize fine/coarse time step
once as well.

> +	time_step = res.tv_nsec / 1000;
> +	error = time_step;
> +
> +	if (time_step <= 0) {
> +		time_step = 1000;
> +		error = 0;
> +	}
> +
> +	usec = 3 * time_step;
> +
> +	tst_res(TINFO, "clock resolution: %luns, "
> +		"time step: %ius, "
> +		"counter time: %ius",
> +		res.tv_nsec,
> +		time_step,
> +		usec);
>  
>  	pid = SAFE_FORK();
>  
> @@ -76,7 +104,7 @@ static void verify_setitimer(unsigned int i)
>  			ovalue->it_value.tv_sec,
>  			ovalue->it_value.tv_usec);
>  
> -		if (ovalue->it_value.tv_sec != 0 || ovalue->it_value.tv_usec > usec)
> +		if (ovalue->it_value.tv_sec != 0 || ovalue->it_value.tv_usec > usec + error)
>  			tst_res(TFAIL, "Ending counters are out of range");
>  
>  		for (;;)
> @@ -91,26 +119,10 @@ static void verify_setitimer(unsigned int i)
>  		tst_res(TFAIL, "Child: %s", tst_strstatus(status));
>  }
>  
> -static void setup(void)
> -{
> -	struct timespec res;
> -
> -	SAFE_CLOCK_GETRES(CLOCK_MONOTONIC, &res);
> -
> -	time_step = res.tv_nsec / 1000;
> -	if (time_step < 10000)
> -		time_step = 10000;
> -
> -	tst_res(TINFO, "clock resolution: %luns, time step: %luus",
> -		res.tv_nsec,
> -		time_step);
> -}
> -
>  static struct tst_test test = {
>  	.tcnt = ARRAY_SIZE(tcases),
>  	.forks_child = 1,
>  	.test = verify_setitimer,
> -	.setup = setup,
>  	.bufs = (struct tst_buffers[]) {
>  		{&value,  .size = sizeof(struct itimerval)},
>  		{&ovalue, .size = sizeof(struct itimerval)},
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
