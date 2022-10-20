Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A6BC4332F
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 08:54:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E2E923CB18F
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 10:54:09 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C96B73C1769
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 10:53:58 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 81D39200B98
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 10:53:57 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id B34AC226EA;
 Thu, 20 Oct 2022 08:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666256036;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uwcTR8uVhdx3baNkDzZ+3hRGFI2abgVsW14tB4goDuo=;
 b=otV1QoV/rtnDO4FM48/N4h+dchHPjSHEbYcIfuO0SsbV1OwwlQI02MEzoHZ+R4/Y7UtFnB
 HGVxjzVAyKhjSt+YXBGWoWhgd09Ul61VFNBZFD7xUQJYDStisrMk+VfJSmfhjX1JeKhkNN
 3LpbLMQMQhvt/fHTZuIeuUw12T26Y0k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666256036;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uwcTR8uVhdx3baNkDzZ+3hRGFI2abgVsW14tB4goDuo=;
 b=RkDKj8B5jenEweh/TwDhpENhiYpq1ZOk3c8zGBXr0NcXzP6HC3S9jZ8fsdRMbFXgRjKtpR
 tKsRYFGqUfHperAQ==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id E143D2C191;
 Thu, 20 Oct 2022 08:53:55 +0000 (UTC)
References: <20221009085745.3239893-1-liwang@redhat.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Thu, 20 Oct 2022 09:42:29 +0100
In-reply-to: <20221009085745.3239893-1-liwang@redhat.com>
Message-ID: <871qr2x4da.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setitimer01: rewrite using new API
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

> Also add signal checking when the timer take effection.
>
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  .../kernel/syscalls/setitimer/setitimer01.c   | 230 ++++++++----------
>  1 file changed, 99 insertions(+), 131 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/setitimer/setitimer01.c b/testcases/kernel/syscalls/setitimer/setitimer01.c
> index 6874b94ad..def559db8 100644
> --- a/testcases/kernel/syscalls/setitimer/setitimer01.c
> +++ b/testcases/kernel/syscalls/setitimer/setitimer01.c
> @@ -1,157 +1,125 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> + * Copyright (c) International Business Machines  Corp., 2001
> + * 03/2001 - Written by Wayne Boyer
>   *
> - *   Copyright (c) International Business Machines  Corp., 2001
> - *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> - *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> - *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
>   */
>  
> -/*
> - * NAME
> - *	setitimer01.c
> - *
> - * DESCRIPTION
> - *	setitimer01 - check that a resonable setitimer() call succeeds.
> +/*\
> + * [Description]
>   *
> - * ALGORITHM
> - *	loop if that option was specified
> - *	allocate needed space and set up needed values
> - *	issue the system call
> - *	check the errno value
> - *	  issue a PASS message if we get zero
> - *	otherwise, the tests fails
> - *	  issue a FAIL message
> - *	  break any remaining tests
> - *	  call cleanup
> - *
> - * USAGE:  <for command-line>
> - *  setitimer01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
> - *     where,  -c n : Run n copies concurrently.
> - *             -f   : Turn off functionality Testing.
> - *	       -i n : Execute test n times.
> - *	       -I x : Execute test for x seconds.
> - *	       -P x : Pause for x seconds between iterations.
> - *	       -t   : Turn on syscall timing.
> - *
> - * HISTORY
> - *	03/2001 - Written by Wayne Boyer
> - *
> - * RESTRICTIONS
> - *	none
> + * Check that a setitimer() call pass with timer seting.
> + * Check if signal is generated correctly when when timer expiration.
>   */
>  
> -#include "test.h"
> -
>  #include <errno.h>
>  #include <sys/time.h>
> -
> -void cleanup(void);
> -void setup(void);
> -
> -char *TCID = "setitimer01";
> -int TST_TOTAL = 1;
> +#include <stdlib.h>
> +#include "tst_test.h"
> +#include "lapi/syscalls.h"
>  
>  #define SEC0	0
> -#define SEC1	20
> -#define SEC2	40
> -
> -int main(int ac, char **av)
> +#define SEC1	3
> +#define SEC2	5
> +
> +static volatile int si_flag;
> +static struct itimerval *value, *ovalue;
> +
> +static struct tcase {
> +       int which;
> +       struct itimerval **val;
> +       struct itimerval **oval;
> +       int signo;
> +} tcases[] = {
> +       {ITIMER_REAL,    &value, &ovalue, SIGALRM},
> +       {ITIMER_VIRTUAL, &value, &ovalue, SIGVTALRM},
> +       {ITIMER_PROF,    &value, &ovalue, SIGPROF},

Same issue here as in other itimer test.

> +};
> +
> +static int sys_setitimer(int which, void *new_value, void *old_value)
>  {
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
> +	return tst_syscall(__NR_setitimer, which, new_value, old_value);
> +}
>  
> -		TEST(setitimer(ITIMER_REAL, value, ovalue));
> +static void sig_routine(int signo)
> +{
> +	switch(signo){
> +	case SIGALRM:
> +		si_flag = 1;
> +		break;
> +	case SIGVTALRM:
> +		si_flag = 2;
> +		break;
> +	case SIGPROF:
> +		si_flag = 3;
> +		break;
> +	default:
> +		break;
> +	}
> +}
>  
> -		if (TEST_RETURN != 0) {
> -			tst_resm(TFAIL, "call failed - errno = %d - %s",
> -				 TEST_ERRNO, strerror(TEST_ERRNO));
> -			continue;
> +static void verify_setitimer(unsigned int i)
> +{
> +	struct tcase *tc = &tcases[i];
> +
> +	si_flag = 0;
> +	value->it_value.tv_sec = SEC1;
> +	value->it_value.tv_usec = SEC0;

Why not test usecs instead?

> +	value->it_interval.tv_sec = SEC0;
> +	value->it_interval.tv_usec = SEC0;
> +
> +	TST_EXP_PASS(sys_setitimer(tc->which, *(tc->val), *(tc->oval)));
> +
> +	/*
> +	 * call setitimer again with new values.
> +	 * the old values should be stored in ovalue
> +	 */

We should probably set ovalue to some value > SEC1 here. Otherwise it
could just be zero or some previous value that is still valid.

> +	value->it_value.tv_sec = SEC2;
> +	value->it_value.tv_usec = SEC0;
> +
> +	TST_EXP_PASS(sys_setitimer(tc->which, *(tc->val), *(tc->oval)));
> +
> +	if (ovalue->it_value.tv_sec <= SEC1)
> +		tst_res(TPASS, "setitimer functionality is correct");
> +	else
> +		tst_brk(TFAIL, "old timer value is not equal to expected value");
> +
> +	for (;;) {

Could we use sigwait here instead?

We seem to be burning CPU cycles for no reason and if we get a spurious
signal the test will still pass if we get the correct one afterwards.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
