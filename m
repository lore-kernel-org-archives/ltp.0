From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 15 Jul 2020 11:29:23 +0200
Subject: [LTP] [PATCH 1/2] iopl: convert to new API
In-Reply-To: <20200709085237.10158-1-liwang@redhat.com>
References: <20200709085237.10158-1-liwang@redhat.com>
Message-ID: <20200715092923.GC7741@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +/*
> + * This is a basic test for iopl(2) system call.
> + * It is intended to provide a limited exposure of the system call.
> + *
> + * Author: Subhab Biswas <subhabrata.biswas@wipro.com>
> + */
>  
>  #include <errno.h>
>  #include <unistd.h>
>  #include <sys/io.h>
>  
> -#include "test.h"
> +#include "tst_test.h"
>  
> -static void setup();
> -static void cleanup();
> -
> -int TST_TOTAL = 4;
> -
> -int level;			/* I/O privilege level of the process */
> +#if defined __i386__ || defined(__x86_64__)
>  
> -int main(int ac, char **av)
> +static void verify_iopl(void)
>  {
> +	int total_level = 4;
> +	int level; /* I/O privilege level of the process */

This comment is useless please remove it as well.

> -	int lc;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -
> -		/*
> -		 * Test the system call for possible privelege levels.
> -		 * As the privelge level for a normal process is 0,
> -		 * start by setting/changing the level to 0.
> -		 */
> -		for (level = 0; level < TST_TOTAL; ++level) {
> +	/*
> +	 * Test the system call for possible privelege levels.
> +	 * As the privelge level for a normal process is 0,
> +	 * start by setting/changing the level to 0.
> +	 */

This comment should be moved to the test description at the start of the
test, right?

> +	for (level = 0; level < total_level; ++level) {
>  
> -			TEST(iopl(level));
> +		TEST(iopl(level));
>  
> -			if (TEST_RETURN == -1) {
> -				tst_resm(TFAIL, "iopl() failed for level %d, "
> -					 "errno=%d : %s", level,
> -					 TEST_ERRNO, strerror(TEST_ERRNO));
> -			} else {
> -				tst_resm(TPASS, "iopl() passed for level %d, "
> -					 "returned %ld", level, TEST_RETURN);
> -			}
> +		if (TST_RET == -1) {
> +			tst_res(TFAIL, "iopl() failed for level %d, "
> +					"errno=%d : %s", level,
> +					TST_ERR, tst_strerrno(TFAIL | TTERRNO));
> +		} else {
> +			tst_res(TPASS, "iopl() passed for level %d, "
> +					"returned %ld", level, TST_RET);
>  		}
>  	}
> -
> -	/* cleanup and exit */
> -	cleanup();
> -	tst_exit();
> -
> -}
> -
> -/* setup() - performs all ONE TIME setup for this test */
> -void setup(void)
> -{
> -	tst_require_root();
> -
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
>  }
>  
>  /*
>   *cleanup() -  performs all ONE TIME cleanup for this test at
>   *		completion or premature exit.
>   */

Another useless comment, please remove it as well.

> -void cleanup(void)
> +static void cleanup(void)
>  {
> -
>  	/*
>  	 * back to I/O privilege for normal process.
>  	 */
> -	if (iopl(0) == -1) {
> -		tst_resm(TWARN, "iopl() cleanup failed");
> -	}
> -
> +	if (iopl(0) == -1)
> +		tst_res(TWARN, "iopl() cleanup failed");
>  }
>  
> -#else /* __i386__ */
> -
> -#include "test.h"
> -
> -int TST_TOTAL = 0;
> -
> -int main(void)
> -{
> -	tst_resm(TPASS,
> -		 "LSB v1.3 does not specify iopl() for this architecture.");
> -	tst_exit();
> -}
> +static struct tst_test test = {
> +	.test_all = verify_iopl,
> +	.needs_root = 1,
> +	.cleanup = cleanup,
> +};
>  
> -#endif /* __i386__ */
> +#else /* __i386__, __x86_64__*/
> +TST_TEST_TCONF("LSB v1.3 does not specify iopl() for this architecture. (only for i386 or x86_64)");
> +#endif /* __i386_, __x86_64__*/
> diff --git a/testcases/kernel/syscalls/iopl/iopl02.c b/testcases/kernel/syscalls/iopl/iopl02.c
> index 35d239268..747a1ca56 100644
> --- a/testcases/kernel/syscalls/iopl/iopl02.c
> +++ b/testcases/kernel/syscalls/iopl/iopl02.c
> @@ -1,221 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it would be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> - *
> - * You should have received a copy of the GNU General Public License along
> - * with this program; if not, write the Free Software Foundation, Inc.,
> - * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> - *
> + *  Copyright (c) Linux Test Project, 2020
> + *  Copyright (c) Wipro Technologies Ltd, 2002
>   */
> -/**********************************************************
> - *
> - *    TEST IDENTIFIER	: iopl02
> - *
> - *    EXECUTED BY	: superuser
> - *
> - *    TEST TITLE	: Tests for error conditions
> - *
> - *    TEST CASE TOTAL	: 2
> - *
> - *    AUTHOR		: Subhab Biwas <subhabrata.biswas@wipro.com>
> - *
> - *    SIGNALS
> - * 	Uses SIGUSR1 to pause before test if option set.
> - * 	(See the parse_opts(3) man page).
> - *
> - *    DESCRIPTION
> - *	Verify that
> - *	1) iopl(2) returns -1 and sets errno to EINVAL for privilege
> - *	   level greater than 3.
> - *	2) iopl(2) returns -1 and sets errno to EPERM if the current
> - *	   user is not the super-user.
> - *
> - * 	Setup:
> - * 	  Setup signal handling.
> - *	  Test caller is superuser
> - *	  Set expected errnos for logging
> - *	  Pause for SIGUSR1 if option specified.
> - *
> - * 	Test:
> - *	 Loop if the proper options are given.
> - * 	  Execute system call
> - *	  Check return code and error number, if matching,
> - *		     Issue PASS message
> - *	  Otherwise,
> - *		     Issue FAIL message
> - *	  Perform testcase specific cleanup (if needed)
> - *
> - * 	Cleanup:
> - * 	  Print errno log and/or timing stats if options given
> +
> +/*
> + * This is an error test for iopl(2) system call.
>   *
> - * USAGE:  <for command-line>
> - * iopl02 [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-h] [-f] [-p]
> - *			where,  -c n : Run n copies concurrently.
> - *				-e   : Turn on errno logging.
> - *				-h   : Show help screen
> - *				-f   : Turn off functional testing
> - *				-i n : Execute test n times.
> - *				-I x : Execute test for x seconds.
> - *				-p   : Pause for SIGUSR1 before starting
> - *				-P x : Pause for x seconds between iterations.
> - *				-t   : Turn on syscall timing.
> + * Verify that
> + *  1) iopl(2) returns -1 and sets errno to EINVAL for privilege
> + *     level greater than 3.
> + *  2) iopl(2) returns -1 and sets errno to EPERM if the current
> + *     user is not the super-user.
>   *
> - ****************************************************************/
> -
> -char *TCID = "iopl02";
> -
> -#if defined __i386__ || defined(__x86_64__)
> + * Author: Subhab Biswas <subhabrata.biswas@wipro.com>
> + */
>  
>  #include <errno.h>
>  #include <unistd.h>
>  #include <sys/io.h>
>  #include <pwd.h>
> -#include "test.h"
> -#include "safe_macros.h"
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
> +
> +#if defined __i386__ || defined(__x86_64__)
>  
>  #define INVALID_LEVEL 4		/* Invalid privilege level */
>  #define EXP_RET_VAL -1

Do we need to have macros for these? I doubt so...

> -static void setup();
> -static int setup1(void);
> -static void cleanup1();
> -static void cleanup();
> -
> -static char nobody_uid[] = "nobody";
> -struct passwd *ltpuser;
> -
> -struct test_cases_t {
> -	int level;		/* I/O privilege level */
> -	char *desc;		/* test case description */
> -	int exp_errno;		/* expected error number */
> -} test_cases[] = {
> -	{
> -	INVALID_LEVEL, "Invalid privilege level", EINVAL}, {
> -	1, "Non super-user", EPERM}
> +static struct tcase {
> +	int level;	/* I/O privilege level */
> +	char *desc;	/* test case description */
> +	int exp_errno;	/* expected error number */

It's pretty much clear what these variables are from the names, no need
to comment here as well.

> +} tcases[] = {
> +	{INVALID_LEVEL, "Invalid privilege level", EINVAL},
> +	{1, "Non super-user", EPERM}
>  };
>  
> -int TST_TOTAL = sizeof(test_cases) / sizeof(test_cases[0]);
> -
> -int main(int ac, char **av)
> +static void verify_iopl(unsigned int i)
>  {
> -
> -	int lc, i;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -
> -		for (i = 0; i < TST_TOTAL; ++i) {
> -
> -			if (i == 1) {
> -				/* setup Non super-user for second test */
> -				if (setup1()) {
> -					/* setup1() failed, skip this test */
> -					continue;
> -				}
> -			}
> -
> -			/*
> -			 * Call iopl(2)
> -			 */
> -			TEST(iopl(test_cases[i].level));
> -
> -			if ((TEST_RETURN == EXP_RET_VAL) &&
> -			    (TEST_ERRNO == test_cases[i].exp_errno)) {
> -				tst_resm(TPASS, "Expected failure for %s, "
> -					 "errno: %d", test_cases[i].desc,
> -					 TEST_ERRNO);
> -			} else {
> -				tst_resm(TFAIL, "Unexpected results for %s ; "
> -					 "returned %ld (expected %d), errno %d "
> -					 "(expected errno  %d)",
> -					 test_cases[i].desc,
> -					 TEST_RETURN, EXP_RET_VAL,
> -					 TEST_ERRNO, test_cases[i].exp_errno);
> -			}
> -
> -			if (i == 1) {
> -				/* revert back to super user */
> -				cleanup1();
> -			}
> -
> +	if (i == 1) {
> +		/* setup Non super-user for second test */
> +		struct passwd *pw;
> +		pw = SAFE_GETPWNAM("nobody");

This should be put into the test setup, also the comment is useless.

> +		if (seteuid(pw->pw_uid) == -1) {
> +			tst_res(TWARN, "Failed to set effective"
> +					"uid to %d", pw->pw_uid);
> +			return;
>  		}
>  	}
>  
> -	/* cleanup and exit */
> -	cleanup();
> -
> -	tst_exit();
> -
> -}
> -
> -/* setup1() - set up non-super user for second test case */
> -int setup1(void)
> -{
> -	/* switch to "nobody" user */
> -	if (seteuid(ltpuser->pw_uid) == -1) {
> -		tst_resm(TWARN, "Failed to set effective"
> -			 "uid to %d", ltpuser->pw_uid);
> -		return 1;
> +	TEST(iopl(tcases[i].level));
> +
> +	if ((TST_RET == EXP_RET_VAL) && (TST_ERR == tcases[i].exp_errno)) {
> +		tst_res(TPASS, "Expected failure for %s, "
> +				"errno: %d", tcases[i].desc,
> +				TST_ERR);

Please use TTERRNO to print TST_ERR. Also the tst_res() prints TPASS so
we can omit the "Expected failure" as well and print it with something
as:

	tst_res(TPASS | TTERRNO, "%s", tcases[i].desc);

> +	} else {
> +		tst_res(TFAIL, "Unexpected results for %s ; "
> +				"returned %ld (expected %d), errno %d "
> +				"(expected errno  %d)",
> +				tcases[i].desc,
> +				TST_RET, EXP_RET_VAL,
> +				TST_ERR, tcases[i].exp_errno);

Here as well, the TST_ERR should be printed with TTERRNO and the
exp_errno should be printed with tst_strerrno(). We can do this with
somethign as:

	tst_res(TFAIL | TTERRNO,
	        "%s returned %ld expected -1, expected %s got ",
		tcases[i].desc, tst_strerrno(tcases[i].exp_errno));

>  	}
> -	return 0;
> -}
> -
> -/* cleanup1() - reset to super user for first test case */
> -void cleanup1(void)
> -{
> -	/* reset user as root */
> -	SAFE_SETEUID(NULL, 0);
> -}
> -
> -/* setup() - performs all ONE TIME setup for this test */
> -void setup(void)
> -{
> -	tst_require_root();
>  
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	/* Check if "nobody" user id exists */
> -	if ((ltpuser = getpwnam(nobody_uid)) == NULL) {
> -		tst_brkm(TBROK, NULL, "\"nobody\" user id doesn't exist");
> +	if (i == 1) {
> +		/* revert back to super user */
> +		SAFE_SETEUID(0);
>  	}

Another useless comment and useless curly braces.

> -
> -	TEST_PAUSE;
> -
>  }
>  
> -/*
> - *cleanup() -  performs all ONE TIME cleanup for this test at
> - *		completion or premature exit.
> - */
> -void cleanup(void)
> -{
> -
> -}
> -
> -#else /* __i386__ */
> -
> -#include "test.h"
> -#include "safe_macros.h"
> -
> -int TST_TOTAL = 0;
> -
> -int main(void)
> -{
> -	tst_resm(TPASS,
> -		 "LSB v1.3 does not specify iopl() for this architecture.");
> -	tst_exit();
> -}
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = verify_iopl,
> +	.needs_root = 1,
> +};
>  
> -#endif /* __i386__ */
> +#else /* __i386__, __x86_64__*/

Usually the comment is added only for the endif here.

> +TST_TEST_TCONF("LSB v1.3 does not specify iopl() for this architecture. (only for i386 or x86_64)");
> +#endif /* __i386_, __x86_64__*/

Other than the minor things it's a good cleanup.

-- 
Cyril Hrubis
chrubis@suse.cz
