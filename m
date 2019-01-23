From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 23 Jan 2019 10:51:30 -0500 (EST)
Subject: [LTP] [PATCH v2] syscalls/sigpending02: convert to new lib
In-Reply-To: <20190122100110.120507-1-maennich@google.com>
References: <20190122100110.120507-1-maennich@google.com>
Message-ID: <466653972.97606760.1548258690524.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Signed-off-by: Matthias Maennich <maennich@google.com>
> Reviewed-by: Sandeep Patil <sspatil@android.com>

Hi,

Pushed with some small tweaks:
 - tst_brk replaced with tst_res
 - TTERRNO used instead of errno + strerr()
 - added curly braces around multi-line tst_res()

Thanks,
Jan

> ---
>  .../kernel/syscalls/sigpending/sigpending02.c | 160 ++++--------------
>  1 file changed, 32 insertions(+), 128 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/sigpending/sigpending02.c
> b/testcases/kernel/syscalls/sigpending/sigpending02.c
> index 5fd4eefbf..3898001b2 100644
> --- a/testcases/kernel/syscalls/sigpending/sigpending02.c
> +++ b/testcases/kernel/syscalls/sigpending/sigpending02.c
> @@ -1,143 +1,47 @@
> -
> +// SPDX-License-Identifier: GPL-2.0
>  /*
> + *  Copyright (c) International Business Machines  Corp., 2002
>   *
> - *   Copyright (c) International Business Machines  Corp., 2002
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
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> 02110-1301 USA
> - */
> -
> -/*
> - * NAME
> - * 	sigpending02.c
> + * AUTHORS
> + *	Paul Larson
>   *
>   * DESCRIPTION
> - * 	Test to see the the proper errors are returned by sigpending
> - *$
> - * ALGORITHM
> - * 	test 1:
> - * 	Call sigpending(sigset_t*=-1), it should return -1 with errno EFAULT
> - *
> - * USAGE:  <for command-line>
> - *         -c n    Run n copies concurrently
> - *         -e      Turn on errno logging
> - *         -f      Turn off functional testing
> - *         -h      Show this help screen
> - *         -i n    Execute test n times
> - *         -I x    Execute test for x seconds
> - *         -p      Pause for SIGUSR1 before starting
> - *         -P x    Pause for x seconds between iterations
> - *         -t      Turn on syscall timing
> + *	Test to see that the proper errors are returned by sigpending
>   *
> - * HISTORY
> - *	02/2002 Written by Paul Larson
> - *
> - * RESTRICTIONS
> - * 	None
> + *	Test 1:
> + *		Call sigpending(sigset_t*=-1), it should return -1 with errno EFAULT
>   */
> -#include <sys/types.h>
> -#include <fcntl.h>
> -#include <sys/stat.h>
> +
>  #include <errno.h>
> -#include <string.h>
>  #include <signal.h>
> -#include "test.h"
> -
> -void setup();
> -void help();
> -void cleanup();
> +#include <sys/types.h>
>  
> -char *TCID = "sigpending02";
> -int TST_TOTAL = 1;
> +#include "tst_test.h"
>  
> -/***********************************************************************
> - * Main
> - ***********************************************************************/
> -int main(int ac, char **av)
> +static void run(void)
>  {
> -	int lc;
> -	sigset_t *sigset;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -    /***************************************************************
> -     * perform global setup for test
> -     ***************************************************************/
> -	setup();
> -
>  	/* set sigset to point to an invalid location */
> -	sigset = (sigset_t *) - 1;
> -
> -    /***************************************************************
> -     * check looping state
> -     ***************************************************************/
> -	/* TEST_LOOPING() is a macro that will make sure the test continues
> -	 * looping according to the standard command line args.
> -	 */
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -
> -		TEST(sigpending(sigset));
> -
> -		/* check return code */
> -		if (TEST_RETURN == -1) {
> -			if (TEST_ERRNO != EFAULT)
> -				tst_brkm(TFAIL, cleanup,
> -					 "sigpending() Failed with wrong "
> -					 "errno, expected errno=%d, got errno=%d : %s",
> -					 EFAULT, TEST_ERRNO,
> -					 strerror(TEST_ERRNO));
> -			else
> -				tst_resm(TPASS,
> -					 "expected failure - errno = %d : %s",
> -					 TEST_ERRNO, strerror(TEST_ERRNO));
> -		} else {
> -			tst_brkm(TFAIL, cleanup,
> -				 "sigpending() Failed, expected "
> -				 "return value=-1, got %ld", TEST_RETURN);
> -		}
> +	sigset_t *sigset = (sigset_t *) - 1;
> +
> +	TEST(sigpending(sigset));
> +
> +	/* check return code */
> +	if (TST_RET == -1) {
> +		if (TST_ERR != EFAULT)
> +			tst_brk(TFAIL,
> +				"sigpending() Failed with wrong errno, "
> +				"expected errno=%d, got errno=%d : %s",
> +				EFAULT, TST_ERR, strerror(TST_ERR));
> +		else
> +			tst_res(TPASS,
> +				"expected failure - errno = %d : %s",
> +				TST_ERR, strerror(TST_ERR));
> +	} else {
> +		tst_brk(TFAIL,
> +			"sigpending() Failed, expected return value=-1, got %ld", TST_RET);
>  	}
> -
> -    /***************************************************************
> -     * cleanup and exit
> -     ***************************************************************/
> -	cleanup();
> -	tst_exit();
> -
>  }
>  
> -/***************************************************************
> - * help
> - ***************************************************************/
> -void help(void)
> -{
> -	printf("test\n");
> -}
> -
> -/***************************************************************
> - * setup() - performs all ONE TIME setup for this test.
> - ***************************************************************/
> -void setup(void)
> -{
> -	TEST_PAUSE;
> -}
> -
> -/***************************************************************
> - * cleanup() - performs all ONE TIME cleanup for this test at
> - *		completion or premature exit.
> - ***************************************************************/
> -void cleanup(void)
> -{
> -}
> +static struct tst_test test = {
> +	.test_all = run
> +};
> --
> 2.20.1.321.g9e740568ce-goog
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
