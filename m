From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 10 Aug 2021 13:31:06 +0200
Subject: [LTP] [PATCH] [5/6] syscalls/sysfs: Convert sysfs05 to the new
 API
In-Reply-To: <20210806113100.8785-1-sujiaxun@uniontech.com>
References: <20210806113100.8785-1-sujiaxun@uniontech.com>
Message-ID: <YRJjeg80s7xTVwOU@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.

Same here GPL-2.0

> - * This program is distributed in the hope that it would be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> - *
> - * You should have received a copy of the GNU General Public License along
> - * with this program; if not, write the Free Software Foundation, Inc.,
> - * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> - *
>   */
> -/**************************************************************************
> - *
> - *    TEST IDENTIFIER	: sysfs(2)
> - *
> - *
> - *    EXECUTED BY	: anyone
> - *
> - *    TEST TITLE	: Test checking for basic error conditions
> - *				 for sysfs(2)
> - *
> - *    TEST CASE TOTAL	: 3
> - *
> - *    AUTHOR		: Aniruddha Marathe <aniruddha.marathe@wipro.com>
> - *
> - *    SIGNALS
> - *	Uses SIGUSR1 to pause before test if option set.
> - *	(See the parse_opts(3) man page).
> - *
> - *    DESCRIPTION
> - *	This test case checks whether sysfs(2) system call returns
> - *	appropriate error number for invalid
> - *	option and for invalid filesystem name.
> - *
> - *	Setup:
> - *	  Setup signal handling.
> - *	  Pause for SIGUSR1 if option specified.
> - *
> - *	Test:
> - *	  Loop if the proper options are given.
> - *	  Execute system call with invaid option parameter and for
> - *	  invalid filesystem name
> - *	  Check return code, if system call fails with errno == expected errno
> - *		Issue syscall passed with expected errno
> - *	  Otherwise,
> - *	  Issue syscall failed to produce expected errno
> - *
> - *	Cleanup:
> - *	  Do cleanup for the test.
> - *
> - * USAGE:  <for command-line>
> - *  sysfs05 [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-f] [-h] [-p]
> - *  where:
> - *	-c n : Run n copies simultaneously
> - *	-e   : Turn on errno logging.
> - *	-i n : Execute test n times.
> - *	-I x : Execute test for x seconds.
> - *	-p   : Pause for SIGUSR1 before starting
> - *	-P x : Pause for x seconds between iterations.
> - *	-t   : Turn on syscall timing.
> - *
> - *RESTRICTIONS:
> - *There is no libc or glibc support
> - *Kernel must be compiled with ext2 support
> - *****************************************************************************/
> +
> +/*
> + * [DESCRIPTION]
> + * This test case checks whether sysfs(2) system call returns appropriate
> + * error number for invalid option and for invalid filesystem name.
> + */

Here as well, fix the comment please.

>  #include <errno.h>
>  #include <sys/syscall.h>
> -#include "test.h"
> +#include "tst_test.h"
>  #include "lapi/syscalls.h"
> 
> -static void setup();
> -static void cleanup();
> -
> -char *TCID = "sysfs05";
> -static int option[3] = { 1, 4, 1 };	/* valid and invalid option */
> +static int option[3] = { 1, 4, 1 }; /* valid and invalid option */
>  static char *fsname[] = { "ext0", " ext2", (char *)-1 };
> 
> -static struct test_case_t {
> -	char *err_desc;		/*error description */
> -	int exp_errno;		/* expected error number */
> -	char *exp_errval;	/*Expected errorvalue string */
> -} testcase[] = {
> -	{
> -	"Invalid option", EINVAL, "EINVAL"}, {
> -	"Invalid filesystem name", EINVAL, "EINVAL "}, {
> -	"Address is out of your address space", EFAULT, "EFAULT "}
> +static struct test_case {
> +    char *err_desc;     /*error description */
> +    int exp_errno;      /* expected error number */
> +    char *exp_errval;   /*Expected errorvalue string */

These comments are commenting the obvious, please remove them as well.

> +} tcases[] = {
> +    {
> +    "Invalid option", EINVAL, "EINVAL "}, {
> +    "Invalid filesystem name", EINVAL, "EINVAL "}, {
> +    "Address is out of your address space", EFAULT, "EFAULT "}
>  };


The option should be part of the testcase structure as well as the
fsname.

> -int TST_TOTAL = ARRAY_SIZE(testcase);
> -
> -int main(int ac, char **av)
> +static void verify_sysfs05(unsigned int nr)
>  {
> -	int lc, i;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		for (i = 0; i < TST_TOTAL; i++) {
> -
> -			tst_count = 0;
> -			TEST(ltp_syscall(__NR_sysfs, option[i], fsname[i]));
> -
> -			/* check return code */
> -			if ((TEST_RETURN == -1)
> -			    && (TEST_ERRNO == testcase[i].exp_errno)) {
> -				tst_resm(TPASS,
> -					 "sysfs(2) expected failure;"
> -					 " Got errno - %s : %s",
> -					 testcase[i].exp_errval,
> -					 testcase[i].err_desc);
> -			} else {
> -				tst_resm(TFAIL, "sysfs(2) failed to produce"
> -					 " expected error; %d, errno"
> -					 ": %s and got %d",
> -					 testcase[i].exp_errno,
> -					 testcase[i].exp_errval, TEST_ERRNO);
> -			}
> +    TEST(tst_syscall(__NR_sysfs, option[nr], fsname[nr]));
> +
> +    /* check return code */
> +    if ((TST_RET == -1)
> +        && (TST_ERR == tcases[nr].exp_errno)) {
> +            tst_res(TPASS,
> +                 "sysfs(2) expected failure;"
> +                 " Got errno - %s : %s",
> +                 tcases[nr].exp_errval,
> +                 tcases[nr].err_desc);
> +    } else {
> +        tst_res(TFAIL, "sysfs(2) failed to produce"
> +                 " expected error; %d, errno"
> +                 ": %s and got %d",
> +                 tcases[nr].exp_errno,
> +                 tcases[nr].exp_errval, TST_ERR);
> +    }

Just use TST_EXP_FAIL() instead.

> -		}		/*End of TEST LOOPS */
> -	}
> -
> -	/*Clean up and exit */
> -	cleanup();
> -
> -	tst_exit();
> -}				/*End of main */
> -
> -/* setup() - performs all ONE TIME setup for this test */
> -void setup(void)
> -{
> -
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
>  }
> 
> -/*
> -* cleanup() - Performs one time cleanup for this test at
> -* completion or premature exit
> -*/
> -void cleanup(void)
> -{
> +static struct tst_test test = {
> +    .tcnt = ARRAY_SIZE(tcases),
> +    .test = verify_sysfs05,
> +};
> 
> -}
> --
> 2.20.1
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
