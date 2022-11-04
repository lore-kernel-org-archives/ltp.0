Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B90C4332F
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 12:47:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB2DD3C8A03
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 13:47:10 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C6F23C0427
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 13:47:00 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 43C0D200089
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 13:46:58 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 677E521983;
 Fri,  4 Nov 2022 12:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1667566018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=buBidWB8ddCtKQuR+bEp+140nD47vlydiuR7XBryLwo=;
 b=ZhtDi5pc9nB7x10tl3iJm5TCRDxjwmruzEl3lReqglAnS5FfRVSIW6pq0aisUvf7yHYSx/
 /cLWJTbnobAn8gsGWzXiPxrYF0n5GxCGv8YUbb/YOG/KYUBlzJ0pif8eOJ+GojR9OBwbpI
 bvl0iTDPTMlSlIHq7LTnFZ/LIyzLMQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1667566018;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=buBidWB8ddCtKQuR+bEp+140nD47vlydiuR7XBryLwo=;
 b=kJV9WttDdqqR1RPEHu6oBXXKBEX1OdXQMoqIP0/QAJcFvP2+AFHKtrp23SVoXIflxACNj7
 IRIRc617qgfTvqAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 530AC13216;
 Fri,  4 Nov 2022 12:46:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id tIR7E8IJZWP9cQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 04 Nov 2022 12:46:58 +0000
Message-ID: <c9a2c8ce-9dfb-a001-fa93-10a669c0e228@suse.cz>
Date: Fri, 4 Nov 2022 13:46:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To: Andrea Cervesato <andrea.cervesato@suse.com>, ltp@lists.linux.it
References: <20221104092411.5446-1-andrea.cervesato@suse.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20221104092411.5446-1-andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
suggestion below.

On 04. 11. 22 10:24, Andrea Cervesato via ltp wrote:
> Since ITIMER_VIRTUAL and ITIMER_PROF are counting down in user time, we
> need to take in consideration CLOCK_MONOTONIC_COARSE resolution. This is
> requested by the syscall, since it's considering context switch from
> user to kernel mode by using a higher clock resolution.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>   .../kernel/syscalls/setitimer/setitimer01.c   | 54 +++++++++++--------
>   1 file changed, 33 insertions(+), 21 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/setitimer/setitimer01.c b/testcases/kernel/syscalls/setitimer/setitimer01.c
> index eb62f02c6..5fcae53e8 100644
> --- a/testcases/kernel/syscalls/setitimer/setitimer01.c
> +++ b/testcases/kernel/syscalls/setitimer/setitimer01.c
> @@ -8,9 +8,16 @@
>   /*\
>    * [Description]
>    *
> - * Spawn a child and verify that setitimer() syscall passes, and it ends up
> + * Spawn a child, verify that setitimer() syscall passes and it ends up
>    * counting inside expected boundaries. Then verify from the parent that our
>    * syscall sent the correct signal to the child.
> + *
> + * Boundaries are choosen accordingly with system clock. In particular, when
> + * timer counts down in real time, CLOCK_MONOTONIC resolution has taken into
> + * account as our time step. When timer counts down in user time,
> + * CLOCK_MONOTONIC_COARSE is used. The reason is that CLOCK_MONOTONIC_COARSE
> + * is our system resolution in user space, since it's taking in consideration
> + * context switches from user to kernel space.
>    */
>   
>   #include <time.h>
> @@ -22,7 +29,6 @@
>   #include "tst_safe_clocks.h"
>   
>   static struct itimerval *value, *ovalue;
> -static unsigned long time_step;
>   
>   static struct tcase {
>   	int which;
> @@ -55,9 +61,31 @@ static void set_setitimer_value(int usec, int o_usec)
>   static void verify_setitimer(unsigned int i)
>   {
>   	pid_t pid;
> -	int status;
> -	int usec = 3 * time_step;
> +	struct timespec res;
>   	struct tcase *tc = &tcases[i];
> +	int status, usec, time_step, error;
> +
> +	if (tc->which == ITIMER_REAL)
> +		SAFE_CLOCK_GETRES(CLOCK_MONOTONIC, &res);
> +	else
> +		SAFE_CLOCK_GETRES(CLOCK_MONOTONIC_COARSE, &res);
> +
> +	time_step = res.tv_nsec / 1000;
> +	error = time_step;
> +
> +	if (time_step <= 0) {
> +		time_step = 1000;
> +		error = 0;
> +	}

This approach looks like it'll lead to some bad edge cases when
0 < time_step < 1000. It'd be better to keep the original time_step 
detection and initialize "error" variable like this (and also rename it 
to "margin"):

int jiffy;

verify_setitimer()
{
	...
	margin = (tc->which == ITIMER_REAL) ? 0 : jiffy;
	...
}

setup()
{
	...
	SAFE_CLOCK_GETRES(CLOCK_MONOTONIC_COARSE, &res);
	jiffy = (res.tv_nsec + 999) / 1000;
	...
}

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
>   	pid = SAFE_FORK();
>   
> @@ -76,7 +104,7 @@ static void verify_setitimer(unsigned int i)
>   			ovalue->it_value.tv_sec,
>   			ovalue->it_value.tv_usec);
>   
> -		if (ovalue->it_value.tv_sec != 0 || ovalue->it_value.tv_usec > usec)
> +		if (ovalue->it_value.tv_sec != 0 || ovalue->it_value.tv_usec > usec + error)
>   			tst_res(TFAIL, "Ending counters are out of range");
>   
>   		for (;;)
> @@ -91,26 +119,10 @@ static void verify_setitimer(unsigned int i)
>   		tst_res(TFAIL, "Child: %s", tst_strstatus(status));
>   }
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
>   static struct tst_test test = {
>   	.tcnt = ARRAY_SIZE(tcases),
>   	.forks_child = 1,
>   	.test = verify_setitimer,
> -	.setup = setup,
>   	.bufs = (struct tst_buffers[]) {
>   		{&value,  .size = sizeof(struct itimerval)},
>   		{&ovalue, .size = sizeof(struct itimerval)},

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
