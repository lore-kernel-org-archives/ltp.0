Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1010C4332F
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 10:57:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 832263CB17A
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 12:57:33 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA3EC3C9179
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 12:57:22 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5BAAE600A0E
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 12:57:22 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id C7AC421D5A;
 Thu, 20 Oct 2022 10:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666263441;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xfxCCIXhj6AYDRUhYvjBioVU6rs3OuoN/+xImksT3Xc=;
 b=EHbDQiXvY6dblyhLZMmnN3B48/uA51oxe4URjXHN6pyTkLAbK/HsdtzJK8K6rymc9WYbge
 8ymZXh17eNPXBS0LFHIalrAGMcZ80Z3SGl74x+VL7wbqqEwjAVvwI5zG+0Nblep8XunaZ7
 8t5l3KwGcErFsn9jv/qZH+ivW8IVUvA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666263441;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xfxCCIXhj6AYDRUhYvjBioVU6rs3OuoN/+xImksT3Xc=;
 b=GTOSFo4JTJakgJ2szWdLO39sHGCjvud1stZWN/w0+Og1SkDl7SmqWUUZ5lWWrQk6kuc2yv
 pyaknKILBvYYnjCA==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 3604D2C141;
 Thu, 20 Oct 2022 10:57:21 +0000 (UTC)
References: <20221011110437.21572-1-akumar@suse.de>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Avinesh Kumar <akumar@suse.de>
Date: Thu, 20 Oct 2022 11:56:04 +0100
In-reply-to: <20221011110437.21572-1-akumar@suse.de>
Message-ID: <874jvyvk33.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setitimer03: Rewrite using new LTP API
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

As you probably know alread, we have another patch in flight which
merges this into setitimer02 by Li Wang. So I will mark this one as
rejected.

Avinesh Kumar <akumar@suse.de> writes:

> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ---
>  .../kernel/syscalls/setitimer/setitimer03.c   | 168 +++---------------
>  1 file changed, 25 insertions(+), 143 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/setitimer/setitimer03.c b/testcases/kernel/syscalls/setitimer/setitimer03.c
> index 418ec71f0..659eac9a3 100644
> --- a/testcases/kernel/syscalls/setitimer/setitimer03.c
> +++ b/testcases/kernel/syscalls/setitimer/setitimer03.c
> @@ -1,158 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - *
>   *   Copyright (c) International Business Machines  Corp., 2001
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
> + *		03/2001 - Written by Wayne Boyer
> + *   Copyright (c) 2022 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
>   */
>  
> -/*
> - * NAME
> - *	setitimer03.c
> +/*\
> + * [Description]
>   *
> - * DESCRIPTION
> - *	setitimer03 - check that a setitimer() call fails as expected
> - *		      with incorrect values.
> - *
> - * ALGORITHM
> - *	loop if that option was specified
> - *	allocate needed space and set up needed values
> - *	issue the system call
> - *	check the errno value
> - *	  issue a PASS message if we get EINVAL
> - *	otherwise, the tests fails
> - *	  issue a FAIL message
> - *	  break any remaining tests
> - *	  call cleanup
> - *
> - * USAGE:  <for command-line>
> - *  setitimer03 [-c n] [-e] [-i n] [-I x] [-p x] [-t]
> - *     where,  -c n : Run n copies concurrently.
> - *             -e   : Turn on errno logging.
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
> + * Verify that setitimer(2) syscall fails with EINVAL when given
> + * an invalid timer.
>   */
>  
> -#include "test.h"
> -
> -#include <errno.h>
> -#include <sys/time.h>
> +#include "tst_test.h"
>  
> -void cleanup(void);
> -void setup(void);
> +static struct itimerval *new_value, *old_value;
>  
> -char *TCID = "setitimer03";
> -int TST_TOTAL = 1;
> -
> -int main(int ac, char **av)
> +static void setup(void)
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
> -		/* allocate some space for timer structures */
> -
> -		if ((value = malloc((size_t)sizeof(struct itimerval))) ==
> -		    NULL) {
> -			tst_brkm(TBROK, cleanup, "value malloc failed");
> -		}
> -
> -		if ((ovalue = malloc((size_t)sizeof(struct itimerval))) ==
> -		    NULL) {
> -			tst_brkm(TBROK, cleanup, "value malloc failed");
> -		}
> -
> -		/* set up some reasonable values */
> -
> -		value->it_value.tv_sec = 30;
> -		value->it_value.tv_usec = 0;
> -		value->it_interval.tv_sec = 0;
> -		value->it_interval.tv_usec = 0;
> -
> -		/*
> -		 * issue the system call with the TEST() macro
> -		 * ITIMER_REAL = 0, ITIMER_VIRTUAL = 1 and ITIMER_PROF = 2
> -		 */
> -
> -		/* make the first value negative to get a failure */
> -		TEST(setitimer(-ITIMER_PROF, value, ovalue));
> -
> -		if (TEST_RETURN == 0) {
> -			tst_resm(TFAIL, "call failed to produce expected error "
> -				 "- errno = %d - %s", TEST_ERRNO,
> -				 strerror(TEST_ERRNO));
> -			continue;
> -		}
> -
> -		switch (TEST_ERRNO) {
> -		case EINVAL:
> -			tst_resm(TPASS, "expected failure - errno = %d - %s",
> -				 TEST_ERRNO, strerror(TEST_ERRNO));
> -			break;
> -		default:
> -			tst_resm(TFAIL, "call failed to produce expected error "
> -				 "- errno = %d - %s", TEST_ERRNO,
> -				 strerror(TEST_ERRNO));
> -		}
> -
> -		/*
> -		 * clean up things in case we are looping
> -		 */
> -		free(value);
> -		free(ovalue);
> -		value = NULL;
> -		ovalue = NULL;
> -	}
> -
> -	cleanup();
> -	tst_exit();
> -
> +	new_value->it_value.tv_sec = 30;
> +	new_value->it_value.tv_usec = 0;
> +	new_value->it_interval.tv_sec = 0;
> +	new_value->it_interval.tv_usec = 0;
>  }
>  
> -/*
> - * setup() - performs all the ONE TIME setup for this test.
> - */
> -void setup(void)
> +static void run(void)
>  {
> -
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> +	TST_EXP_FAIL(setitimer(-ITIMER_PROF, new_value, old_value), EINVAL);
>  }
>  
> -/*
> - * cleanup() - performs all the ONE TIME cleanup for this test at completion
> - * 	       or premature exit.
> - */
> -void cleanup(void)
> -{
> -
> -}
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.bufs = (struct tst_buffers[]) {
> +		{&new_value, .size = sizeof(struct itimerval)},
> +		{&old_value, .size = sizeof(struct itimerval)},
> +		{}
> +	}
> +};
> -- 
> 2.37.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
