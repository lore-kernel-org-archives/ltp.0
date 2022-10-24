Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249DCC3A59D
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 07:06:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA1F43C3099
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 09:06:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 24E333C0367
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 09:06:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D235A600749
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 09:06:36 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 8A17E1F88B;
 Mon, 24 Oct 2022 07:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666595195;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0UXyF9DX7UwlYJvwSUhH/5L4j0PoO0YkSoqwFRpKZWA=;
 b=BpLOXy01oedbDN+83i5yD/KgMulflakUwhouc/YWz2oY4OgnrBp4oIR/aMQgnVxLewqcxs
 oTPZT69WSK9cIYBQClbuXuKTH7OtuJicMFyQKB6YuMcZgAtVkOnlg0bUNTQlRTKz9myR8F
 8T7aULtBS82ckaygDUcVBQCBmUMzfkk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666595195;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0UXyF9DX7UwlYJvwSUhH/5L4j0PoO0YkSoqwFRpKZWA=;
 b=e/sfAiLdhVt7Ult6lz6Zg+/AeGPUd2H/1d2c2bPtbogsY1ZzPf+Yn+WUTszG2jk20tSkYY
 TQNJ4JTESAXPLmBg==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 10D172C141;
 Mon, 24 Oct 2022 07:06:34 +0000 (UTC)
References: <20221009085745.3239893-1-liwang@redhat.com>
 <20221024024009.3553633-1-liwang@redhat.com>
 <20221024024009.3553633-2-liwang@redhat.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Mon, 24 Oct 2022 07:58:44 +0100
In-reply-to: <20221024024009.3553633-2-liwang@redhat.com>
Message-ID: <87edux1z0l.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] setitimer01: rewrite using new API
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

>  
> -#include "test.h"
> -
>  #include <errno.h>
>  #include <sys/time.h>
> +#include <stdlib.h>
> +#include "tst_test.h"
> +#include "lapi/syscalls.h"
> +
> +#define USEC1	10000
> +#define USEC2	20000
> +
> +static struct itimerval *value, *ovalue;
> +
> +static struct tcase {
> +	int which;
> +	char *des;
> +	int signo;
> +} tcases[] = {
> +	{ITIMER_REAL,    "ITIMER_REAL",    SIGALRM},
> +	{ITIMER_VIRTUAL, "ITIMER_VIRTUAL", SIGVTALRM},
> +	{ITIMER_PROF,    "ITIMER_PROF",    SIGPROF},
> +};
> +
> +static int sys_setitimer(int which, void *new_value, void *old_value)
> +{
> +	return tst_syscall(__NR_setitimer, which, new_value, old_value);
> +}
> +
> +static void set_setitimer_value(int usec, int o_usec)
> +{
> +	value->it_value.tv_sec = 0;
> +	value->it_value.tv_usec = usec;
> +	value->it_interval.tv_sec = 0;
> +	value->it_interval.tv_usec = 0;
> +
> +	ovalue->it_value.tv_sec = o_usec;
> +	ovalue->it_value.tv_usec = o_usec;
> +	ovalue->it_interval.tv_sec = 0;
> +	ovalue->it_interval.tv_usec = 0;
> +}
>  
> -void cleanup(void);
> -void setup(void);
> +static void verify_setitimer(unsigned int i)
> +{
> +	pid_t pid;
> +	int status;
> +	struct tcase *tc = &tcases[i];
>  
> -char *TCID = "setitimer01";
> -int TST_TOTAL = 1;
> +	pid = SAFE_FORK();
>  
> -#define SEC0	0
> -#define SEC1	20
> -#define SEC2	40
> +	if (pid == 0) {
> +		tst_res(TINFO, "tc->which = %s", tc->des);
>  
> -int main(int ac, char **av)
> -{
> -	int lc;
> -	struct itimerval *value, *ovalue;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();		/* global setup */
> -
> -	/* The following loop checks looping state if -i option given */
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		/* reset tst_count in case we are looping */
> -		tst_count = 0;
> -
> -		/* allocate some space for the timer structures */
> -
> -		if ((value = malloc((size_t)sizeof(struct itimerval))) ==
> -		    NULL) {
> -			tst_brkm(TBROK, cleanup, "value malloc failed");
> -		}
> -
> -		if ((ovalue = malloc((size_t)sizeof(struct itimerval))) ==
> -		    NULL) {
> -			tst_brkm(TBROK, cleanup, "ovalue malloc failed");
> -		}
> -
> -		/* set up some reasonable values */
> -
> -		value->it_value.tv_sec = SEC1;
> -		value->it_value.tv_usec = SEC0;
> -		value->it_interval.tv_sec = 0;
> -		value->it_interval.tv_usec = 0;
> -		/*
> -		 * issue the system call with the TEST() macro
> -		 * ITIMER_REAL = 0, ITIMER_VIRTUAL = 1 and ITIMER_PROF = 2
> -		 */
> -
> -		TEST(setitimer(ITIMER_REAL, value, ovalue));
> -
> -		if (TEST_RETURN != 0) {
> -			tst_resm(TFAIL, "call failed - errno = %d - %s",
> -				 TEST_ERRNO, strerror(TEST_ERRNO));
> -			continue;
> -		}
> -
> -		/*
> -		 * call setitimer again with new values.
> -		 * the old values should be stored in ovalue
> -		 */
> -		value->it_value.tv_sec = SEC2;
> -		value->it_value.tv_usec = SEC0;
> -
> -		if ((setitimer(ITIMER_REAL, value, ovalue)) == -1) {
> -			tst_brkm(TBROK, cleanup, "second setitimer "
> -				 "call failed");
> -		}
> -
> -		if (ovalue->it_value.tv_sec <= SEC1) {
> -			tst_resm(TPASS, "functionality is correct");
> -		} else {
> -			tst_brkm(TFAIL, cleanup, "old timer value is "
> -				 "not equal to expected value");
> -		}
> -	}
> +		tst_no_corefile(0);
>  
> -	cleanup();
> -	tst_exit();
> -}
> +		set_setitimer_value(USEC1, 0);
> +		TST_EXP_PASS(sys_setitimer(tc->which, value, NULL));
>  
> -/*
> - * setup() - performs all the ONE TIME setup for this test.
> - */
> -void setup(void)
> -{
> +		set_setitimer_value(USEC2, USEC2);
> +		TST_EXP_PASS(sys_setitimer(tc->which, value, ovalue));
>  
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +		if (ovalue->it_value.tv_sec != 0 || ovalue->it_value.tv_usec >= USEC2)
> +			tst_brk(TFAIL, "old timer value is not within
> the expected range");

Maybe we could split testing the return value and ovalue from testing
the signal is delivered?

When testing the return value and ovalue; a very long timeout can be
used (which is never hit). When testing the signal a very short one can
be used.

This way, the test is not racing with the signal and the loop below
won't be executed much.

In any case LGTM

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

>  
> -	TEST_PAUSE;
> -}
> +		for (;;)
> +			;
> +	}
>  
> -/*
> - * cleanup() - performs all the ONE TIME cleanup for this test at completion
> - * 	       or premature exit.
> - */
> -void cleanup(void)
> -{
> +	SAFE_WAITPID(pid, &status, 0);
>  
> +	if (WIFSIGNALED(status) && WTERMSIG(status) == tc->signo)
> +		tst_res(TPASS, "Child received signal: %s", tst_strsig(tc->signo));
> +	else
> +		tst_res(TFAIL, "Child: %s", tst_strstatus(status));
>  }
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.forks_child = 1,
> +	.test = verify_setitimer,
> +	.bufs = (struct tst_buffers[]) {
> +		{&value,  .size = sizeof(struct itimerval)},
> +		{&ovalue, .size = sizeof(struct itimerval)},
> +		{}
> +	}
> +};
> -- 
> 2.35.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
