Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B852AC3A59D
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 06:53:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9EEF83C9221
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 08:53:47 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 98A673C0367
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 08:53:36 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C57C1600057
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 08:53:35 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 8A74621C2C;
 Mon, 24 Oct 2022 06:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666594414;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hODrplF/MoYaO52pKFzGvFpKmGmKfZVXVQa6voWUwBQ=;
 b=VQYwv+Z4KFNzTd/VDLrpjIOntJz40wOVBq9Qint4zJlhFL0BkVFkt5hzSyjf8vHecKZN5C
 XUwDHZyPZ+Oiiheq7AtbQY220ZkrjyacEUG60nJ8marklGNEwyMXpvPgH/SWTVKK6wFsmp
 ZtUXE1Ne1i+ebN7wfL6tScBCD9DQcvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666594414;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hODrplF/MoYaO52pKFzGvFpKmGmKfZVXVQa6voWUwBQ=;
 b=nnDfdod1EGNvT41mOcPvyQtV7goFJvwFsrR69HWTKsMD8j30zvrqGp9i1ulkZyYsQYP+uw
 5MFwlnzB2vLiTqAw==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id EED7E2C141;
 Mon, 24 Oct 2022 06:53:33 +0000 (UTC)
References: <20221009085745.3239893-1-liwang@redhat.com>
 <20221024024009.3553633-1-liwang@redhat.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Mon, 24 Oct 2022 07:52:27 +0100
In-reply-to: <20221024024009.3553633-1-liwang@redhat.com>
Message-ID: <87ilk91zmb.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] setitimer03: convert to new API
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

> Combine this EINVAL test into setitimer02 and add one additional
> ITIMER_VIRTUAL verification.
>
> Signed-off-by: Li Wang <liwang@redhat.com>

Looks, good!

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

> ---
>  runtest/syscalls                              |   1 -
>  .../kernel/syscalls/setitimer/.gitignore      |   1 -
>  .../kernel/syscalls/setitimer/setitimer02.c   |  29 +++-
>  .../kernel/syscalls/setitimer/setitimer03.c   | 158 ------------------
>  4 files changed, 21 insertions(+), 168 deletions(-)
>  delete mode 100644 testcases/kernel/syscalls/setitimer/setitimer03.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index a52b93c92..3dc6fa397 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1327,7 +1327,6 @@ sethostname03 sethostname03
>  
>  setitimer01 setitimer01
>  setitimer02 setitimer02
> -setitimer03 setitimer03
>  
>  setns01 setns01
>  setns02 setns02
> diff --git a/testcases/kernel/syscalls/setitimer/.gitignore b/testcases/kernel/syscalls/setitimer/.gitignore
> index 048db9b31..35779a32c 100644
> --- a/testcases/kernel/syscalls/setitimer/.gitignore
> +++ b/testcases/kernel/syscalls/setitimer/.gitignore
> @@ -1,3 +1,2 @@
>  /setitimer01
>  /setitimer02
> -/setitimer03
> diff --git a/testcases/kernel/syscalls/setitimer/setitimer02.c b/testcases/kernel/syscalls/setitimer/setitimer02.c
> index 9ac9ce1fa..b012d71fa 100644
> --- a/testcases/kernel/syscalls/setitimer/setitimer02.c
> +++ b/testcases/kernel/syscalls/setitimer/setitimer02.c
> @@ -8,8 +8,10 @@
>  /*\
>   * [Description]
>   *
> - * Check that a setitimer() call fails with EFAULT with invalid itimerval
> - * pointer.
> + * Check that setitimer() call fails:
> + *
> + * 1. EFAULT with invalid itimerval pointer
> + * 2. EINVAL when called with an invalid first argument
>   */
>  
>  #include <errno.h>
> @@ -18,17 +20,26 @@
>  #include "tst_test.h"
>  #include "lapi/syscalls.h"
>  
> -static struct itimerval *value;
> +static struct itimerval *value, *ovalue;
>  
>  static int sys_setitimer(int which, void *new_value, void *old_value)
>  {
>  	return tst_syscall(__NR_setitimer, which, new_value, old_value);
>  }
>  
> -static void verify_setitimer(void)
> +static void verify_setitimer(unsigned int i)
>  {
> -	TST_EXP_FAIL(sys_setitimer(ITIMER_REAL, value, (struct itimerval *)-1),
> -	             EFAULT);
> +	switch (i) {
> +	case 0:
> +		TST_EXP_FAIL(sys_setitimer(ITIMER_REAL, value, (void *)-1), EFAULT);
> +		break;
> +	case 1:
> +		TST_EXP_FAIL(sys_setitimer(ITIMER_VIRTUAL, value, (void *)-1), EFAULT);
> +		break;
> +	case 2:
> +		TST_EXP_FAIL(sys_setitimer(-ITIMER_PROF, value, ovalue), EINVAL);
> +		break;
> +	}
>  }
>  
>  static void setup(void)
> @@ -40,10 +51,12 @@ static void setup(void)
>  }
>  
>  static struct tst_test test = {
> -	.test_all = verify_setitimer,
> +	.tcnt = 3,
> +	.test = verify_setitimer,
>  	.setup = setup,
>  	.bufs = (struct tst_buffers[]) {
> -		{&value, .size = sizeof(struct itimerval)},
> +		{&value,  .size = sizeof(struct itimerval)},
> +		{&ovalue, .size = sizeof(struct itimerval)},
>  		{}
>  	}
>  };
> diff --git a/testcases/kernel/syscalls/setitimer/setitimer03.c b/testcases/kernel/syscalls/setitimer/setitimer03.c
> deleted file mode 100644
> index 418ec71f0..000000000
> --- a/testcases/kernel/syscalls/setitimer/setitimer03.c
> +++ /dev/null
> @@ -1,158 +0,0 @@
> -/*
> - *
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
> - */
> -
> -/*
> - * NAME
> - *	setitimer03.c
> - *
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
> -char *TCID = "setitimer03";
> -int TST_TOTAL = 1;
> -
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
> -- 
> 2.35.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
