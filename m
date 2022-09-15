Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0CBDECAAD3
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 10:00:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 490F13CAC06
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 12:00:41 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 45B603CAC2E
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 12:00:28 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5C53A20096D
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 12:00:26 +0200 (CEST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8839E33F96;
 Thu, 15 Sep 2022 10:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1663236026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7wj5uGEp+c7dQ4KRjXmbXHrRhCZz4wcgzWuDaC9TdLE=;
 b=Qcefd5CAsTOJHrqwoVnT/jyP7V35xVFAINANP/p7XBNm8qSK2hnU4GXUofySR3ZpN2FqX6
 qf4LWEZncw12R5dsEwoghSgf2RcvQHNUA36h8xUhKuEsSNCbAwPc0deRHGH1R44/B6aT2w
 vBkRMb7uJwblqGmGE+TmaVzXihG7WHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1663236026;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7wj5uGEp+c7dQ4KRjXmbXHrRhCZz4wcgzWuDaC9TdLE=;
 b=BNzB/I5yNIDfdfyu4FytZszi8yajbssHQthvfSscoK4l8pigSefKAbMQhEcXJ7wn8R4TfO
 5tKauXyZM0dhMLBQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 7E5CD13310;
 Thu, 15 Sep 2022 10:00:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id GP/4D7n3ImOQLQAAGKfGzw
 (envelope-from <akumar@suse.de>); Thu, 15 Sep 2022 10:00:25 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Thu, 15 Sep 2022 15:30:22 +0530
Message-ID: <12066736.O9o76ZdvQC@localhost>
Organization: SUSE
In-Reply-To: <20220915074900.2639623-1-liwang@redhat.com>
References: <YyI/KU10+zSi7Fpj@pevik>
 <20220915074900.2639623-1-liwang@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] getitimer03.c: convert to new LTP API
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

Hi Li,

Sorry, I missed acting on the review comments you had provided. Thank you for
implementing them. Your patch looks good, I have tested as well.


On Thursday, September 15, 2022 1:19:00 PM IST Li Wang wrote:
> From: Avinesh Kumar <akumar@suse.de>
> 
> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
> 
> Notes:
>     Hi Avinesh,
>     
>         As this patch pending there with no action more than six weeks, I just
>         help to moving on the test convert-work in my suggest way, if you have
>         any different thought, please feel free add comments and review.
>         Thanks!  -- Li Wang
>     
>     v1 --> v2
>         * combine error test into 02 to better manage the error test in LTP
> 
>  .../kernel/syscalls/getitimer/getitimer02.c   |  45 +++++-
>  .../kernel/syscalls/getitimer/getitimer03.c   | 152 ------------------
>  2 files changed, 39 insertions(+), 158 deletions(-)
>  delete mode 100644 testcases/kernel/syscalls/getitimer/getitimer03.c
> 
> diff --git a/testcases/kernel/syscalls/getitimer/getitimer02.c b/testcases/kernel/syscalls/getitimer/getitimer02.c
> index a91e6434d..863e8e0a8 100644
> --- a/testcases/kernel/syscalls/getitimer/getitimer02.c
> +++ b/testcases/kernel/syscalls/getitimer/getitimer02.c
> @@ -1,30 +1,63 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) International Business Machines  Corp., 2001
> - * 03/2001 - Written by Wayne Boyer
> + *               03/2001 - Written by Wayne Boyer
> + * Copyright (c) 2022 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
>   */
>  
>  /*\
>   * [Description]
>   *
> - * Check that a getitimer() call fails with EFAULT with invalid itimerval pointer.
> + * Check that getitimer() call fails:
> + *   1. EFAULT with invalid itimerval pointer
> + *   2. EINVAL when called with an invalid first argument
>   */
>  
> +#include <stdlib.h>
>  #include <errno.h>
>  #include <sys/time.h>
>  #include "tst_test.h"
>  #include "lapi/syscalls.h"
>  
> +static struct itimerval *value;
> +static struct itimerval *invalid;
> +
> +static struct tcase {
> +       int which;
> +       struct itimerval **val;
> +       int exp_errno;
> +} tcases[] = {
> +       {ITIMER_REAL, &invalid, EFAULT},
> +       {-ITIMER_PROF, &value, EINVAL},
> +};
> +
>  static int sys_getitimer(int which, void *curr_value)
>  {
> -	return tst_syscall(__NR_getitimer, which, curr_value);
> +        return tst_syscall(__NR_getitimer, which, curr_value);
> +}
> +
> +static void setup(void)
> +{
> +        value = SAFE_MALLOC(sizeof(struct itimerval));
> +        invalid = (struct itimerval *)-1;
> +}
> +
> +static void verify_getitimer(unsigned int i)
> +{
> +        struct tcase *tc = &tcases[i];
> +
> +        TST_EXP_FAIL(sys_getitimer(tc->which, *(tc->val)), tc->exp_errno);
>  }
>  
> -static void verify_getitimer(void)
> +static void cleanup(void)
>  {
> -	TST_EXP_FAIL(sys_getitimer(ITIMER_REAL, (struct itimerval *)-1), EFAULT);
> +        free(value);
> +        value = NULL;
>  }
>  
>  static struct tst_test test = {
> -	.test_all = verify_getitimer,
> +        .tcnt = ARRAY_SIZE(tcases),
> +        .test = verify_getitimer,
> +        .setup = setup,
> +        .cleanup = cleanup,
>  };
> diff --git a/testcases/kernel/syscalls/getitimer/getitimer03.c b/testcases/kernel/syscalls/getitimer/getitimer03.c
> deleted file mode 100644
> index cc5e83fad..000000000
> --- a/testcases/kernel/syscalls/getitimer/getitimer03.c
> +++ /dev/null
> @@ -1,152 +0,0 @@
> -/*
> - * Copyright (c) International Business Machines  Corp., 2001
> - *
> - * This program is free software;  you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - * the GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program;  if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> - */
> -
> -/* $Header: /cvsroot/ltp/ltp/testcases/kernel/syscalls/getitimer/getitimer03.c,v 1.7 2009/08/28 10:18:24 vapier Exp $ */
> -
> -/*
> - * NAME
> - *	getitimer03.c
> - *
> - * DESCRIPTION
> - *	getitimer03 - check that a getitimer() call fails as expected
> - *		      with an incorrect first argument.
> - *
> - * CALLS
> - *	getitimer()
> - *
> - * ALGORITHM
> - *	loop if that option was specified
> - *	allocate space and set up needed values
> - *	issue the system call
> - *	check the errno value
> - *	  issue a PASS message if we get EINVAL
> - *	otherwise, the tests fails
> - *	  issue a FAIL message
> - *	  break any remaining tests
> - *	  call cleanup
> - *
> - * USAGE:  <for command-line>
> - *  getitmer03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
> - *     where,  -c n : Run n copies concurrently.
> - *             -e   : Turn on errno logging.
> - *	       -i n : Execute test n times.
> - *	       -I x : Execute test for x seconds.
> - *	       -P x : Pause for x seconds between iterations.
> - *	       -t   : Turn on syscall timing.
> - *
> - * USAGE
> - *	./getitimer03
> - *
> - * HISTORY
> - *	03/2001 - Written by Wayne Boyer
> - *
> - * RESTRICTIONS
> - *	none
> - */
> -
> -#include "test.h"
> -
> -#include <errno.h>
> -#include <sys/time.h>
> -
> -void cleanup(void);
> -void setup(void);
> -
> -char *TCID = "getitimer03";
> -int TST_TOTAL = 1;
> -
> -int main(int ac, char **av)
> -{
> -	int lc;
> -	struct itimerval *value;
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
> -		/* allocate some space for the timer structure */
> -
> -		if ((value = malloc((size_t)sizeof(struct itimerval))) ==
> -		    NULL) {
> -			tst_brkm(TBROK, cleanup, "value malloc failed");
> -		}
> -
> -		/*
> -		 * issue the system call with the TEST() macro
> -		 * ITIMER_REAL = 0, ITIMER_VIRTUAL = 1 and ITIMER_PROF = 2
> -		 */
> -
> -		/* make the first value negative to get a failure */
> -		TEST(getitimer(-ITIMER_PROF, value));
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
> -
> -		free(value);
> -		value = NULL;
> -	}
> -
> -	cleanup();
> -
> -	tst_exit();
> -}
> -
> -/*
> - * setup() - performs all the ONE TIME setup for this test.
> - */
> -void setup(void)
> -{
> -
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -}
> -
> -/*
> - * cleanup() - performs all the ONE TIME cleanup for this test at completion
> - * 	       or premature exit.
> - */
> -void cleanup(void)
> -{
> -
> -}
> 

Regards,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
