From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 10 Feb 2020 11:26:07 +0800
Subject: [LTP] [PATCH v1 1/2] syscalls/socketcall02: Cleanup && rewrite
 to new API
In-Reply-To: <1581249526-25295-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1581249526-25295-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <04f0e695-8301-98bb-2b7a-4e20dfb09d72@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


> Also add EFAULT error test.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>   .../kernel/syscalls/socketcall/socketcall02.c | 173 ++++--------------
>   1 file changed, 37 insertions(+), 136 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/socketcall/socketcall02.c b/testcases/kernel/syscalls/socketcall/socketcall02.c
> index 7574782ff..6a9d51f4e 100644
> --- a/testcases/kernel/syscalls/socketcall/socketcall02.c
> +++ b/testcases/kernel/syscalls/socketcall/socketcall02.c
> @@ -1,163 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
>    * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
> + * Copyright (c) 2020 Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> + * Author: Sowmya Adiga <sowmya.adiga@wipro.com>
>    *
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
> + * This is a error test for the socketcall(2) system call.
>    */
> -/**************************************************************************
> - *
> - *    TEST IDENTIFIER	: socketcall02
> - *
> - *    EXECUTED BY	: All user
> - *
> - *    TEST TITLE	: Error test for socketcall(2)
> - *
> - *    TEST CASE TOTAL	: 1
> - *
> - *    AUTHOR		: sowmya adiga<sowmya.adiga@wipro.com>
> - *
> - *    SIGNALS
> - *	Uses SIGUSR1 to pause before test if option set.
> - *	(See the parse_opts(3) man page).
> - *
> - *    DESCRIPTION
> - *	verify socketcall(2) returns -1 and sets errno
> - *	appropriately if argument passed is invalid.
> - *
> - *
> - *	Setup:
> - *	  Setup signal handling.
> - *	  Pause for SIGUSR1 if option specified.
> - *
> - *	Test:
> - *	  Loop if the proper option is given.
> - *	  Execute system call.
> - *	  Check return code, If system call failed (return == -1) &&
> - *				(errno set == expected errno)
> - *	  Issue sys call pass with expected error
> - *	  otherwise
> - *	  Issue sys call fails with unexpected error
> - *
> - *	Cleanup:
> - *	  Print errno log and/or timing stats if options given
> - *
> - * USAGE:  <for command-line>
> - *  socketcall02 [-c n] [-e] [-i n] [-I x] [-p x] [-t]
> - *		where,		-c n : Run n copies concurrently
> - *				-e   : Turn on errno logging.
> - *				-h   : Show this help screen
> - *				-i n : Execute test n times.
> - *				-I x : Execute test for x seconds.
> - *				-p   : Pause for SIGUSR1 before starting
> - *				-P x : Pause for x seconds between iterations.
> - *				-t   : Turn on syscall timing.
> - *
> - * RESTRICTIONS
> - * None
> - *****************************************************************************/
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <errno.h>
> -#include <sys/syscall.h>
> +
>   #include <unistd.h>
> +#include <errno.h>
>   #include <sys/types.h>
>   #include <sys/socket.h>
>   #include <linux/net.h>
>   #include <sys/un.h>
>   #include <netinet/in.h>
>   
> -#include "test.h"
> -
> -char *TCID = "socketcall02";
> -
> -#ifdef __NR_socketcall
> +#include "tst_test.h"
> +#include "lapi/syscalls.h"
>   
> -#define socketcall(call, args) syscall(__NR_socketcall, call, args)
> -
> -void setup();
> -void cleanup();
> -
> -int TST_TOTAL = 1;
> +static unsigned long args_valid[3] = {PF_INET, SOCK_STREAM, 0};
>   
>   struct test_case_t {
>   	int call;
> -	unsigned long args[3];
> -	int retval;
> -	int experrno;
> +	unsigned long *args;
> +	int exp_err;
>   	char *desc;
> -} TC = {
> -	-1, {
> -PF_INET, SOCK_STREAM, 0}, -1, EINVAL, "invalid call"};
> +} TC[] = {
> +	{0, args_valid, EINVAL, "invalid call(0)"},
"invalid call(<1)" is more correc.
> +	{21, args_valid, EINVAL, "invalid call(21)"},
"invalid call(>20)" is more correct.
> +	{SYS_SOCKET, NULL, EFAULT, "invalid args address"},
> +};
>   
> -int main(int ac, char **av)
> +static void verify_socketcall(unsigned int i)
>   {
> -	int lc;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	/* check looping state */
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +	tst_res(TINFO, "%s", TC[i].desc);
>   
> -		tst_count = 0;
> -
> -		TEST(socketcall(TC.call, TC.args));
> -
> -		/* check return code */
> -		if ((TEST_RETURN == -1)
> -		    && (TEST_ERRNO == TC.experrno)) {
> -			tst_resm(TPASS, "socketcall() failed"
> -				 " as expected for %s", TC.desc);
> -		} else {
> -			tst_brkm(TFAIL, NULL, "socketcall()"
> -				 " Failed with wrong experrno"
> -				 " =%d got: errno=%d : %s",
> -				 TC.experrno, TEST_ERRNO, strerror(TEST_ERRNO));
> -		}
> +	TEST(tst_syscall(__NR_socketcall, TC[i].call, TC[i].args));
> +	if (TST_RET != -1) {
> +		tst_res(TFAIL, "socketcall() succeeded unexpectedly");
> +		return;
>   	}
> -
> -	/* cleanup and exit */
> -	cleanup();
> -
> -	tst_exit();
> +	if (TST_ERR == TC[i].exp_err)
> +		tst_res(TPASS | TTERRNO, "socketcall() failed as expected ");
> +	else
> +		tst_res(TFAIL | TTERRNO, "socketcall fail expected %s got", tst_strerrno(TC[i].exp_err));
>   }
>   
> -/* setup() - performs all ONE TIME setup for this test. */
> -void setup(void)
> +static void setup(void)
>   {
> +	unsigned int i;
>   
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -}
> -
> -/*
> - * cleanup() - performs all ONE TIME cleanup for this test at
> - *		completion or premature exit.
> - */
> -void cleanup(void)
> -{
> +	for (i = 0; i < ARRAY_SIZE(TC); i++) {
> +		if (!TC[i].args)
> +			TC[i].args = tst_get_bad_addr(NULL);
> +	}
>   }
>   
> -#else
> -
> -int TST_TOTAL = 0;
> -
> -int main(void)
> -{
> -	tst_resm(TCONF, "socket call test on this architecture disabled.");
> -	tst_exit();
> -}
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test = verify_socketcall,
> +	.tcnt = ARRAY_SIZE(TC),
> +};
>   
> -#endif
> 


