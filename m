Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1W0349-0000Ni-HU
	for ltp-list@lists.sourceforge.net; Mon, 06 Jan 2014 05:49:33 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1W0347-0007sY-9G
	for ltp-list@lists.sourceforge.net; Mon, 06 Jan 2014 05:49:33 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s065nOj3016197
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Jan 2014 13:49:24 +0800
Message-ID: <1388987358.1648.14.camel@G08JYZSD130126>
From: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Date: Mon, 06 Jan 2014 13:49:18 +0800
In-Reply-To: <1386844012.1603.17.camel@G08JYZSD130126>
References: <1386844012.1603.17.camel@G08JYZSD130126>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH 1/2] getrlimit/getrlimit01.c: cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sourceforge.net>

Could anyone help to review this?

Thanks,
Zeng

On Thu, 2013-12-12 at 18:26 +0800, zenglg.jy wrote:
> cleanup the getrlimit01.c
> 
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/getrlimit/getrlimit01.c | 123 +++++-----------------
>  1 file changed, 29 insertions(+), 94 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/getrlimit/getrlimit01.c b/testcases/kernel/syscalls/getrlimit/getrlimit01.c
> index 3fe846b..f397a19 100644
> --- a/testcases/kernel/syscalls/getrlimit/getrlimit01.c
> +++ b/testcases/kernel/syscalls/getrlimit/getrlimit01.c
> @@ -1,6 +1,7 @@
>  /*
>   *
>   *   Copyright (c) Wipro Technologies, 2002. All Rights Reserved.
> + *   Author: Suresh Babu V. <suresh.babu@wipro.com>
>   *
>   *   This program is free software;  you can redistribute it and/or modify
>   *   it under the terms of the GNU General Public License as published by
> @@ -17,53 +18,9 @@
>   *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
>   */
>  
> -/****************************************************************************
> - *
> - *    TEST IDENTIFIER	: getrlimit01
> - *
> - *    TEST TITLE	: test for checking functionality of getrlimit(2)
> - *  $
> - *    EXECUTED BY	: anyone
> - *
> - *    TEST CASE TOTAL	: 11
> - *
> - *    AUTHOR		: Suresh Babu V. <suresh.babu@wipro.com>
> - *
> - *    SIGNALS
> - *      Uses SIGUSR1 to pause before test if option set.
> - *      (See the parse_opts(3) man page).
> - *
> - * DESCRIPTION
> - *      Verify that,
> - *	getrlimit(2) call will be successful for all possible resource types.
> - *
> - * Setup:
> - *   Setup signal handling.
> - *   Pause for SIGUSR1 if option specified.
> - *
> - *  Test:
> - *   Loop if the proper options are given.
> - *   Execute system call
> - *   Check return code, if system call failed
> - *		Issue sys call failed to get resource limits.
> - *      Otherwise,
> - *		Issue sys call is successful and got resource limits.
> - *
> - *   Cleanup:
> - *	Print errno log and/or timing stats if options given
> - *
> - * USAGE:  <for command-line>
> - *  getrlimit01 [-c n] [-e] [-i n] [-I x] [-P x] [-p] [-t] [-h]
> - *     where,  -c n  : Run n copies concurrently.
> - *		-e   : Turn on errno logging.
> - *		-i n : Execute test n times.
> - *		-I x : Execute test for x seconds.
> - *		-P x : Pause for x seconds between iterations.
> - *		-p   : Pause for SIGUSR1 before starting.
> - *		-t   : Turn on syscall timing.
> - *		-h   : Display usage information.
> - *
> - ***************************************************************************/
> +/*
> + *   Test for checking functionality of getrlimit(2)
> + */
>  #include <stdio.h>
>  #include <errno.h>
>  #include <sys/time.h>
> @@ -74,94 +31,72 @@
>  static void cleanup(void);
>  static void setup(void);
>  
> -char *TCID = "getrlimit01";
> -
>  static struct rlimit rlim;
>  static struct test_t {
>  	int res;
>  	char *res_str;
>  } testcases[] = {
> -	{
> -	RLIMIT_CPU, "RLIMIT_CPU"}, {
> -	RLIMIT_FSIZE, "RLIMIT_FSIZE"}, {
> -	RLIMIT_DATA, "RLIMIT_DATA"}, {
> -	RLIMIT_STACK, "RLIMIT_STACK"}, {
> -	RLIMIT_CORE, "RLIMIT_CORE"}, {
> -	RLIMIT_RSS, "RLIMIT_RSS"}, {
> -	RLIMIT_NPROC, "RLIMIT_NPROC"}, {
> -	RLIMIT_NOFILE, "RLIMIT_NOFILE"}, {
> -	RLIMIT_MEMLOCK, "RLIMIT_MEMLOCK"}, {
> -	RLIMIT_AS, "RLIMIT_AS"}, {
> -	RLIMIT_LOCKS, "RLIMIT_LOCKS"}
> +	{RLIMIT_CPU, "RLIMIT_CPU"},
> +	{RLIMIT_FSIZE, "RLIMIT_FSIZE"},
> +	{RLIMIT_DATA, "RLIMIT_DATA"},
> +	{RLIMIT_STACK, "RLIMIT_STACK"},
> +	{RLIMIT_CORE, "RLIMIT_CORE"},
> +	{RLIMIT_RSS, "RLIMIT_RSS"},
> +	{RLIMIT_NPROC, "RLIMIT_NPROC"},
> +	{RLIMIT_NOFILE, "RLIMIT_NOFILE"},
> +	{RLIMIT_MEMLOCK, "RLIMIT_MEMLOCK"},
> +	{RLIMIT_AS, "RLIMIT_AS"},
> +	{RLIMIT_LOCKS, "RLIMIT_LOCKS"},
>  };
>  
> -int TST_TOTAL = sizeof(testcases) / sizeof(*testcases);
> +char *TCID = "getrlimit01";
> +int TST_TOTAL = ARRAY_SIZE(testcases);
>  
>  int main(int ac, char **av)
>  {
>  	int i;
>  	int lc;
> -	char *msg;		/* parse_opts() return message */
> +	char *msg;
>  
> -	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
> +	msg = parse_opts(ac, av, NULL, NULL);
> +	if (msg != NULL)
>  		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> -		tst_exit();
> -	}
>  
> -	/* Do initial setup */
>  	setup();
>  
> -	/* check for looping state if -i option is given */
>  	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +
>  		tst_count = 0;
>  
>  		for (i = 0; i < TST_TOTAL; ++i) {
>  
> -			/*
> -			 * Test the system call with different resoruce types
> -			 * with codes 0 to 10
> -			 */
>  			TEST(getrlimit(testcases[i].res, &rlim));
>  
>  			if (TEST_RETURN == -1) {
> -				tst_resm(TFAIL, "getrlimit() failed to get %s "
> -					 "values. errno is %d",
> +				tst_resm(TFAIL,
> +					 "getrlimit() test %s failed errno: %d",
>  					 testcases[i].res_str, TEST_ERRNO);
>  			} else {
> -				tst_resm(TPASS, "getrlimit() returned %d; "
> -					 "got %s values ",
> -					 TEST_ERRNO, testcases[i].res_str);
> +				tst_resm(TPASS,
> +					 "getrlimit() test %s success",
> +					 testcases[i].res_str);
>  			}
>  		}
>  	}
> -	/* do cleanup and exit */
> +
>  	cleanup();
>  
>  	tst_exit();
>  }
>  
> -/*
> - * setup() - performs all one time setup for this test.
> - */
> -void setup()
> +static void setup(void)
>  {
> -	/* capture the signals */
>  	tst_sig(NOFORK, DEF_HANDLER, cleanup);
>  
> -	/* Pause if the option was specified */
>  	TEST_PAUSE;
>  }
>  
> -/*
> - * cleanup()  - performs all one time cleanup for this test
> - *		completion or premature exit.
> - */
> -void cleanup()
> +static void cleanup(void)
>  {
> -	/*
> -	 * print timing stats if that option was specified.
> -	 * print errno log if that option was specified.
> -	 */
>  	TEST_CLEANUP;
> -
>  }



------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
