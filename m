From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 23 Nov 2016 17:22:44 +0100
Subject: [LTP] [PATCH v2 2/2] testcases/clock_nanosleep01: convert to
 use new	test library API
In-Reply-To: <20161122162926.5573-2-pvorel@suse.cz>
References: <20161122162926.5573-1-pvorel@suse.cz>
 <20161122162926.5573-2-pvorel@suse.cz>
Message-ID: <20161123162244.GN3346@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> removed test type NULL_POINTER
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Not sure if I've done signal hadling correctly.
> 
> Changes v1->v2:
> * use helper functions for measuring elapsed time
> * removed unused variables
> * renaming variables
> * removed useless comments
> * removed use of temporary directory
> ---
>  testcases/kernel/syscalls/clock_nanosleep/Makefile |   2 +
>  .../syscalls/clock_nanosleep/clock_nanosleep01.c   | 451 ++++++---------------
>  2 files changed, 122 insertions(+), 331 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/clock_nanosleep/Makefile b/testcases/kernel/syscalls/clock_nanosleep/Makefile
> index 71ebae9..07b9154 100644
> --- a/testcases/kernel/syscalls/clock_nanosleep/Makefile
> +++ b/testcases/kernel/syscalls/clock_nanosleep/Makefile
> @@ -22,4 +22,6 @@ include $(top_srcdir)/include/mk/testcases.mk
>  
>  LDLIBS			+= -lpthread -lrt
>  
> +clock_nanosleep01:	LDLIBS+=-lrt

No need for this, since the LDLIBS has -lrt allready hence all sources
in that directory are compiled with -lrt. Per target LDLIBS are only
needed if only some of the tests needs to link with some library.

>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
> index 08c1fbd..0443329 100644
> --- a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
> +++ b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
> @@ -1,158 +1,50 @@
> -/******************************************************************************/
> -/* Copyright (c) Crackerjack Project., 2007-2008 ,Hitachi, Ltd		*/
> -/*	  Author(s): Takahiro Yasui <takahiro.yasui.mp@hitachi.com>,	      */
> -/*		       Yumiko Sugita <yumiko.sugita.yf@hitachi.com>, 	      */
> -/*		       Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>	      */
> -/*								  	      */
> -/* This program is free software;  you can redistribute it and/or modify      */
> -/* it under the terms of the GNU General Public License as published by       */
> -/* the Free Software Foundation; either version 2 of the License, or	  */
> -/* (at your option) any later version.					*/
> -/*									    */
> -/* This program is distributed in the hope that it will be useful,	    */
> -/* but WITHOUT ANY WARRANTY;  without even the implied warranty of	    */
> -/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See		  */
> -/* the GNU General Public License for more details.			   */
> -/*									    */
> -/* You should have received a copy of the GNU General Public License	  */
> -/* along with this program;  if not, write to the Free Software	       */
> -/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
> -/*									    */
> -/******************************************************************************/
> -/******************************************************************************/
> -/*									    */
> -/* File:	clock_nanosleep01.c					   */
> -/*									    */
> -/* Description: This tests the clock_nanosleep() syscall		      */
> -/*									      */
> -/* 									      */
> -/*									      */
> -/*									      */
> -/*									      */
> -/*									    */
> -/* Usage:  <for command-line>						 */
> -/* clock_nanosleep01 [-c n] [-e][-i n] [-I x] [-p x] [-t]		     */
> -/*      where,  -c n : Run n copies concurrently.			     */
> -/*	      -e   : Turn on errno logging.				 */
> -/*	      -i n : Execute test n times.				  */
> -/*	      -I x : Execute test for x seconds.			    */
> -/*	      -P x : Pause for x seconds between iterations.		*/
> -/*	      -t   : Turn on syscall timing.				*/
> -/*									    */
> -/* Total Tests: 1							     */
> -/*									    */
> -/* Test Name:   clock_nanosleep01					     */
> -/* History:     Porting from Crackerjack to LTP is done by		    */
> -/*	      Manas Kumar Nayak maknayak@in.ibm.com>			*/
> -/******************************************************************************/
> -#include <sys/syscall.h>
> -#include <sys/types.h>
> -#include <getopt.h>
> -#include <string.h>
> -#include <stdlib.h>
> -#include <errno.h>
> -#include <stdio.h>
> -#include <time.h>
> -#include <signal.h>
> -#include "../utils/common_j_h.c"
> -#include "../utils/include_j_h.h"
> -
> -#include "test.h"
> -#include "linux_syscall_numbers.h"
> -
> -char *TCID = "clock_nanosleep01";
> -int testno;
> -int TST_TOTAL = 1;
> -struct sigaction act;
> -
>  /*
> - * sighandler()
> + * Copyright (c) Crackerjack Project., 2007-2008 ,Hitachi, Ltd
> + *          Author(s): Takahiro Yasui <takahiro.yasui.mp@hitachi.com>,
> + *		       Yumiko Sugita <yumiko.sugita.yf@hitachi.com>,
> + *		       Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>
> + * Copyright (c) 2016 Linux Test Project
> + *
> + * This program is free software;  you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> + * the GNU General Public License for more details.

I'm not sure if it is okay to leave out the third paragraph, but
it's most likely Ok.

>   */
> -void sighandler(int sig)
> -{
> -	if (sig == SIGINT)
> -		return;
> -
> -	return;
> -}
>  
> -/* Extern Global Functions */
> -/******************************************************************************/
> -/*									    */
> -/* Function:    cleanup						       */
> -/*									    */
> -/* Description: Performs all one time clean up for this test on successful    */
> -/*	      completion,  premature exit or  failure. Closes all temporary */
> -/*	      files, removes all temporary directories exits the test with  */
> -/*	      appropriate return code by calling tst_exit() function.       */
> -/*									    */
> -/* Input:       None.							 */
> -/*									    */
> -/* Output:      None.							 */
> -/*									    */
> -/* Return:      On failure - Exits calling tst_exit(). Non '0' return code.   */
> -/*	      On success - Exits calling tst_exit(). With '0' return code.  */
> -/*									    */
> -/******************************************************************************/
> -void cleanup(void)
> -{
> +#include <limits.h>
>  
> -	tst_rmdir();
> +#include "linux_syscall_numbers.h"
> +#include "tst_sig_proc.h"
> +#include "tst_timer.h"
> +#include "tst_test.h"
>  
> -}
> +#define MAX_MSEC_DIFF   20
>  
> -/* Local  Functions */
> -/******************************************************************************/
> -/*									    */
> -/* Function:    setup							 */
> -/*									    */
> -/* Description: Performs all one time setup for this test. This function is   */
> -/*	      typically used to capture signals, create temporary dirs      */
> -/*	      and temporary files that may be used in the course of this    */
> -/*	      test.							 */
> -/*									    */
> -/* Input:       None.							 */
> -/*									    */
> -/* Output:      None.							 */
> -/*									    */
> -/* Return:      On failure - Exits by calling cleanup().		      */
> -/*	      On success - returns 0.				       */
> -/*									    */
> -/******************************************************************************/
> -void setup(void)
> +static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
>  {
> -	/* Capture signals if any */
> -	act.sa_handler = sighandler;
> -	sigfillset(&act.sa_mask);
> -	sigaction(SIGINT, &act, NULL);
> -
> -	/* Create temporary directories */
> -	TEST_PAUSE;
> -	tst_tmpdir();
>  }
>  
> -/*
> - * Macros
> - */
> -#define SYSCALL_NAME    "clock_nanosleep"
> -
>  enum test_type {
>  	NORMAL,
> -	NULL_POINTER,
>  	SEND_SIGINT,
>  };
>  
> -/*
> - * Data Structure
> - */
> +#define TYPE_NAME(x) .ttype = x, .desc = #x
> +
>  struct test_case {
> -	clockid_t clk_id;
> -	int ttype;
> -	int flags;
> +	clockid_t clk_id;	   /* clock_* clock type parameter */
> +	int ttype;		   /* test type (enum) */
> +	const char *desc;	   /* test description (name) */
> +	int flags;		   /* clock_nanosleep flags parameter */
>  	time_t sec;
>  	long nsec;
> -	int ret;
> -	int err;
> +	int exp_ret;
> +	int exp_err;
>  };
>  
>  /* Test cases
> @@ -161,245 +53,142 @@ struct test_case {
>   *
>   *   EINTR	      v (function was interrupted by a signal)
>   *   EINVAL	     v (invalid tv_nsec, etc.)
> - *   ENOTSUP	    can't check because not supported clk_id generates
> - *		      EINVAL
> + *   ENOTSUP	    can't check because not supported clk_id generates EINVAL
>   */
>  
>  static struct test_case tcase[] = {
> -	{			// case00
> +	{
>  	 .clk_id = CLOCK_REALTIME,
> -	 .ttype = NORMAL,
> +	 TYPE_NAME(NORMAL),
>  	 .flags = 0,
>  	 .sec = 0,
> -	 .nsec = 500000000,	// 500msec
> -	 .ret = 0,
> -	 .err = 0,
> +	 .nsec = 500000000,
> +	 .exp_ret = 0,
> +	 .exp_err = 0,
>  	 },
> -	{			// case01
> +	{
>  	 .clk_id = CLOCK_MONOTONIC,
> -	 .ttype = NORMAL,
> +	 TYPE_NAME(NORMAL),
>  	 .flags = 0,
>  	 .sec = 0,
> -	 .nsec = 500000000,	// 500msec
> -	 .ret = 0,
> -	 .err = 0,
> +	 .nsec = 500000000,
> +	 .exp_ret = 0,
> +	 .exp_err = 0,
>  	 },
> -	{			// case02
> -	 .ttype = NORMAL,
> +	{
> +	 TYPE_NAME(NORMAL),
>  	 .clk_id = CLOCK_REALTIME,
>  	 .flags = 0,
>  	 .sec = 0,
> -	 .nsec = -1,		// invalid
> -	 .ret = EINVAL,
> -	 .err = 0,
> +	 .nsec = -1,
> +	 .exp_ret = EINVAL,
> +	 .exp_err = 0,
>  	 },
> -	{			// case03
> -	 .ttype = NORMAL,
> +	{
> +	 TYPE_NAME(NORMAL),
>  	 .clk_id = CLOCK_REALTIME,
>  	 .flags = 0,
>  	 .sec = 0,
> -	 .nsec = 1000000000,	// invalid
> -	 .ret = EINVAL,
> -	 .err = 0,
> +	 .nsec = 1000000000,
> +	 .exp_ret = EINVAL,
> +	 .exp_err = 0,
>  	 },
> -	{			// case04
> -	 .ttype = NORMAL,
> -	 .clk_id = CLOCK_THREAD_CPUTIME_ID,	// not supported
> +	{
> +	 TYPE_NAME(NORMAL),
> +	 .clk_id = CLOCK_THREAD_CPUTIME_ID,
>  	 .flags = 0,
>  	 .sec = 0,
> -	 .nsec = 500000000,	// 500msec
> -	 .ret = EINVAL,		// RHEL4U1 + 2.6.18 returns EINVAL
> -	 .err = 0,
> +	 .nsec = 500000000,
> +	 .exp_ret = EINVAL,
> +	 .exp_err = 0,
>  	 },
> -	{			// case05
> -	 .ttype = SEND_SIGINT,
> +	{
> +	 TYPE_NAME(SEND_SIGINT),
>  	 .clk_id = CLOCK_REALTIME,
>  	 .flags = 0,
>  	 .sec = 10,
>  	 .nsec = 0,
> -	 .ret = EINTR,
> -	 .err = 0,
> -	 },
> -#if 0				// glibc generates SEGV error (RHEL4U1 + 2.6.18)
> -	{			// caseXX
> -	 .ttype = NULL_POINTER,
> -	 .clk_id = CLOCK_REALTIME,
> -	 .flags = 0,
> -	 .sec = 0,
> -	 .nsec = 500000000,	// 500msec
> -	 .ret = EFAULT,
> -	 .err = 0,
> +	 .exp_ret = EINTR,
> +	 .exp_err = 0,
>  	 },
> -#endif
>  };
>  
> -/*
> - * chk_difftime()
> - *   Return : OK(0), NG(-1)
> - */
> -#define MAX_MSEC_DIFF   20
> -
> -static int chk_difftime(struct timespec *bef, struct timespec *aft,
> -			time_t sec, long nsec)
> +void setup(void)
>  {
> -	struct timespec t;
> -	time_t expect;
> -	time_t result;
> +	unsigned int i;
> +
> +	SAFE_SIGNAL(SIGINT, sighandler);
>  
> -	t.tv_sec = aft->tv_sec - bef->tv_sec;
> -	t.tv_nsec = aft->tv_nsec - bef->tv_nsec;
> -	if (t.tv_nsec < 0) {
> -		t.tv_sec -= 1;
> -		t.tv_nsec += 1000000000;
> +	for (i = 0; i < ARRAY_SIZE(tcase); i++) {
> +		tst_timer_check(tcase[i].clk_id);

There is no need for this, It's perfectly okay if we end the test with
TCONF for an clock that is unsupported. Whe should check that the clock
that we use for measuring elapsed time is supported though.

>  	}
> -	expect = (sec * 1000) + (nsec / 1000000);
> -	result = (t.tv_sec * 1000) + (t.tv_nsec / 1000000);
> -	tst_resm(TINFO, "check sleep time: (min:%ld) < %ld < (max:%ld) (msec)",
> -		 expect - MAX_MSEC_DIFF, result, expect + MAX_MSEC_DIFF);
> -	if (result < expect - MAX_MSEC_DIFF || result > expect + MAX_MSEC_DIFF)
> -		return -1;
> -	return 0;
> +
>  }
>  
> -/*
> - * do_test()
> - *
> - *   Input  : TestCase Data
> - *   Return : RESULT_OK(0), RESULT_NG(1)
> - *
> - */
> -static int do_test(struct test_case *tc)
> +static void do_test(unsigned int i)
>  {
> -	int sys_ret;
> -	int sys_errno;
> -	int result = RESULT_OK;
> -	struct timespec beftp, afttp, rq, rm;
> -	int rc, range_ok = 1, remain_ok = 1;
> +	int dummy;
> +	struct timespec rq, rm;
>  	pid_t pid = 0;
> +	struct test_case *tc = &tcase[i];
> +	long long elapsed_ms = 0, expect_ms = 0;
> +	struct timespec t;
>  
> -	/*
> -	 * Check before sleep time
> -	 */
> +	tst_res(TINFO, "case %s", tc->desc);
> +
> +	/* setup */
>  	if (tc->ttype == SEND_SIGINT) {
> -		pid = create_sig_proc(500000, SIGINT, UINT_MAX);
> -		if (pid < 0)
> -			return 1;
> +		pid = create_sig_proc(SIGINT, 40, 500000);
>  	}
>  
> -	/*
> -	 * Check before sleep time
> -	 */
> -	TEST(rc = clock_gettime(tc->clk_id, &beftp));
> -	if (rc < 0) {
> -		tst_resm(TFAIL | TTERRNO, "clock_gettime failed");
> -		result = 1;
> -		goto EXIT;
> -	}
> -	/*
> -	 * Execute system call
> -	 */
> +	tst_timer_start(tc->clk_id);
> +
> +	/* test */
>  	rq.tv_sec = tc->sec;
>  	rq.tv_nsec = tc->nsec;
> -	// !!!CAUTION: 'clock_gettime' returns errno itself
> -	errno = 0;
> -	if (tc->ttype == NULL_POINTER)
> -		TEST(sys_ret =
> -		     clock_nanosleep(tc->clk_id, tc->flags, NULL, &rm));
> -	else
> -		TEST(sys_ret =
> -		     clock_nanosleep(tc->clk_id, tc->flags, &rq, &rm));
> -	sys_errno = errno;
> -	if (sys_ret != 0)
> -		goto TEST_END;
> -
> -	/*
> -	 * Check after sleep time
> -	 */
> -	TEST(rc = clock_gettime(tc->clk_id, &afttp));
> -	if (TEST_RETURN < 0) {
> -		EPRINTF("clock_gettime failed.\n");
> -		result = 1;
> -		goto EXIT;
> -	}
> -	range_ok = chk_difftime(&beftp, &afttp, tc->sec, tc->nsec) == 0;
> -	/*
> -	 * Check remaining time
> -	 */
> -TEST_END:
> -	if (tc->ttype == NORMAL || tc->ttype == SEND_SIGINT) {
> -		tst_resm(TINFO, "remain time: %ld %ld", rm.tv_sec, rm.tv_nsec);
> -		if (tc->ttype == NORMAL)
> -			remain_ok = 1;
> -		else
> -			remain_ok = rm.tv_sec != 0 || rm.tv_nsec != 0;
> +	TEST(clock_nanosleep(tc->clk_id, tc->flags, &rq, &rm));
> +	if (!TEST_RETURN) {
> +		tst_timer_stop();
> +		t.tv_sec = tc->sec;
> +		t.tv_nsec = tc->nsec;

We may as well embed the struct timespec into the test structure so that
we don't have to asign it to it in the test, i.e.:

struct tcase {
	...
	struct timespec rq;
	...
} tcases[] = {
	{
	...
	.rq = (struct timespec) {.tv_sec = 1, .tv_nsec = 0},
	...
	}
};

Then use it directly as &tc->rq

> +		expect_ms = tst_timespec_to_ms(t);
> +		elapsed_ms = tst_timer_elapsed_ms();
>  	}
>  
> -	/*
> -	 * Check results
> -	 */
> -	result |= (sys_ret != tc->ret) || !range_ok || !remain_ok;
> -	if (!range_ok)
> -		PRINT_RESULT_EXTRA(0, tc->ret, tc->err, sys_ret, sys_errno,
> -				   "time range check", range_ok);
> -	else
> -		PRINT_RESULT_EXTRA(0, tc->ret, tc->err, sys_ret, sys_errno,
> -				   "remain time check", remain_ok);
> -EXIT:
> +	tst_res(TINFO, "remain time: %ld %ld", rm.tv_sec, rm.tv_nsec);
> +
> +	/* cleanup */
>  	if (pid > 0) {
> -		int st;
> -		TEST(kill(pid, SIGTERM));
> -		TEST(wait(&st));
> +		kill(pid, SIGTERM);

Don't we have SAFE_KILL()?

> +		SAFE_WAIT(&dummy);

Hmm, haven't I told you to pass just NULL here?

>  	}
> -	return result;
> -}
> -
> -/*
> - * main()
> - */
> -
> -int main(int ac, char **av)
> -{
> -	int result = RESULT_OK;
> -	int i;
> -	int lc;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); ++lc) {
> -
> -		tst_count = 0;
> -
> -		for (testno = 0; testno < TST_TOTAL; ++testno) {
> -
> -			for (i = 0; i < (int)(sizeof(tcase) / sizeof(tcase[0]));
> -			     i++) {
> -				int ret;
> -				tst_resm(TINFO, "(case%02d) START", i);
> -				ret = do_test(&tcase[i]);
> -				tst_resm(TINFO, "(case%02d) END => %s",
> -					 i, (ret == 0) ? "OK" : "NG");
> -				result |= ret;
> -			}
> -
> -			switch (result) {
> -			case RESULT_OK:
> -				tst_resm(TPASS,
> -					 "clock_nanosleep call succeeded");
> -				break;
> -
> -			default:
> -				tst_brkm(TFAIL | TERRNO, cleanup,
> -					 "clock_nanosleep failed");
> -				break;
> -			}
> -
> -		}
>  
> +	/* result check */
> +	if (!TEST_RETURN && (elapsed_ms < expect_ms - MAX_MSEC_DIFF
> +		|| elapsed_ms > expect_ms + MAX_MSEC_DIFF)) {
> +		tst_res(TFAIL, "time range check ret: %ld, exp: %d, ret_errno: %s (%d),"
> +			" exp_errno: %s (%d)", TEST_RETURN, tc->exp_ret,
> +			tst_strerrno(TEST_ERRNO), TEST_ERRNO,
                                     ^
                              Just use the TTERRNO flag together with
			      TFAIL flag, it's much shorter and cleaner

> +			tst_strerrno(tc->exp_err), tc->exp_err);
> +	} else if (tc->ttype == SEND_SIGINT && !rm.tv_sec && !rm.tv_nsec) {
> +		tst_res(TFAIL, "remain time check ret: %ld, exp: %d, ret_errno: %s (%d),"
> +			" exp_errno: %s (%d)", TEST_RETURN, tc->exp_ret,
> +			tst_strerrno(TEST_ERRNO), TEST_ERRNO,
> +			tst_strerrno(tc->exp_err), tc->exp_err);
> +	} else if (TEST_RETURN != tc->exp_ret) {
> +		tst_res(TFAIL, "ret: %ld, exp: %d, ret_errno: %s (%d),"
> +			" exp_errno: %s (%d)", TEST_RETURN, tc->exp_ret,
> +			tst_strerrno(TEST_ERRNO), TEST_ERRNO,
> +			tst_strerrno(tc->exp_err), tc->exp_err);
> +	} else {
> +		tst_res(TPASS, "ret: %ld", TEST_RETURN);
>  	}

Can we get rid of this else if spagheti please?
(Use the return Luke)

>  }
> +
> +static struct tst_test test = {
> +	.tid = "clock_nanosleep01",
> +	.tcnt = ARRAY_SIZE(tcase),
> +	.test = do_test,
> +	.setup = setup,
> +	.forks_child = 1,
> +};
> -- 
> 2.10.2
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
