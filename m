Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MNqTQ-0000id-5r
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 15:51:20 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MNqTP-0002fI-Et
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 15:51:20 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e7.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n66FcIS3029377
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Jul 2009 11:38:18 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n66FpElv252870
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Jul 2009 11:51:14 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n66FpCDk029889
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Jul 2009 11:51:13 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <f5a7b3810907030846x35249218u1fe574ba70f796fd@mail.gmail.com>
References: <f5a7b3810907030846x35249218u1fe574ba70f796fd@mail.gmail.com>
Date: Mon, 06 Jul 2009 21:20:58 +0530
Message-Id: <1246895458.4887.53.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [FIX PATCHE] rt_sigaction
Reply-To: subrata@linux.vnet.ibm.com
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
To: naresh kamboju <naresh.kernel@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Jiri Palecek <jpalecek@web.de>, maxin john <maxinbjohn@gmail.com>, brinda_mn@yahoo.co.in, Manas Kumar Nayak <maknayak@in.ibm.com>

On Fri, 2009-07-03 at 21:16 +0530, naresh kamboju wrote: 
> Hi,
> 
> I have divided rt_sigaction01.c test case in to three test cases
> 
> 1. rt_sigaction01.c (Functionality)
> 2. rt_sigaction02.c (EFAULT)
> 3. rt_sigaction03.c (EINVAL)
> 
> In these test cases rt_sigaction use signal number from SIGRTMIN (34)
> to  SIGRTMAX (64).The Real Time (RT) signals will start from 34 to 64
> as per signal.h because sigaction is testing from 1 to 30 signals I
> hope.
> 
> If you want to test 1 to 64 signals by rt_sigaction signal number 9
> and 19 i.e SIGKILL and SIGTERM will FAIL, because as per
> Specifications we should not use SIGKILL and SIGTERM signals with
> rt_sigaction/sigaction.
> 
> long sys_rt_sigaction (int sig, const struct sigaction *act, struct
> sigaction *oact, size_t sigsetsize)
> 
> SIGSETSIZE is different for different architectures that is taken care
>  for ARM, PowerPC, X86 and MIPS in this patch.
> 
> Subrata,
> 
> Coding style is not as LTP, I did not get much time to fix this.
> If you are using any indent for LTP, please share I will use those
> script to fix coding style.
> 
> If any body is interested to fix coding style issue please welcome... :-)
> 
> 
> I have attached fix patch and below.
> Please review the same.
> 
> Best regards
> Naresh Kamboju
> 
> /*******************************************************/
> Test Start Time: Fri Jul  3 07:52:04 2009
> -----------------------------------------
> Testcase                       Result     Exit Value
> --------                       ------     ----------
> rt_sigaction01                 PASS       0
> rt_sigaction02                 PASS       0
> rt_sigaction03                 PASS       0
> 
> -----------------------------------------------
> Total Tests: 3
> Total Failures: 0
> Kernel Version: 2.6.23.17-alp_nl-pc-g56b4520c-dirty
> Machine Architecture: i686
> Hostname: 43.88.101.228
> ************************************************************/
> 
> Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >

Thanks Naresh.

Regards--
Subrata

> 
> diff -Naurb a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
> b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
> --- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c	2009-05-21
> 23:50:58.000000000 +0530
> +++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c	2009-07-03
> 19:38:41.000000000 +0530
> @@ -55,6 +55,15 @@
>  #include "usctest.h"
>  #include "linux_syscall_numbers.h"
> 
> +#if defined __mips__
> +#define SIGSETSIZE 16
> +#endif
> +
> +#if defined __arm__ || __i386__ || __powerpc__
> +#define SIGSETSIZE 8
> +#endif
> +
> +
>  /* Extern Global Variables */
>  extern int Tst_count;           /* counter for tst_xxx routines.         */
>  extern char *TESTDIR;           /* temporary dir created by tst_tmpdir() */
> @@ -117,58 +126,35 @@
>  }
> 
>  int test_flags[] = {SA_RESETHAND|SA_SIGINFO, SA_RESETHAND,
> SA_RESETHAND|SA_SIGINFO, SA_RESETHAND|SA_SIGINFO, SA_NOMASK};
> +char *test_flags_list[] = {"SA_RESETHAND|SA_SIGINFO", "SA_RESETHAND",
> "SA_RESETHAND|SA_SIGINFO", "SA_RESETHAND|SA_SIGINFO", "SA_NOMASK"};
> 
>  void
>  handler(int sig)
>  {
> -        tst_resm(TINFO,"Here is signal handler. Got signal: %d, do
> nothing here\n", sig);
> +        tst_resm(TINFO,"Signal Handler Called with signal number %d\n",sig);
>          return;
>  }
> 
>  int
> -set_handler(int sig, int sig_to_mask, int flag, int mask_flags)
> +set_handler(int sig, int sig_to_mask, int mask_flags)
>  {
>          struct sigaction sa, oldaction;
> -        int err = 0;
> 
> -        if (flag == 0) {
> -                tst_resm(TINFO,"flag0 - ");
> -                sa.sa_sigaction = (void *)handler;
> -                sa.sa_flags = mask_flags;
> -                TEST(sigemptyset(&sa.sa_mask));
> -                TEST(sigaddset(&sa.sa_mask, sig_to_mask));
> -                TEST(err = syscall(__NR_rt_sigaction,sig, &sa, NULL,8));
> -        } else if (flag == 1) {
> -                tst_resm(TINFO,"flag1 - ");
> -                TEST(err = syscall(__NR_rt_sigaction,sig, (void *)-1, NULL,8));
> -        } else if (flag == 2) {
> -               	tst_resm(TINFO,"flag2 - ");
> -                TEST(err = syscall(__NR_rt_sigaction,sig, NULL, (void *)-1,8));
> -	} else if (flag == 3) {
> -                tst_resm(TINFO,"flag3 - ");
>                  sa.sa_sigaction = (void *)handler;
>                  sa.sa_flags = mask_flags;
> -                TEST(sigemptyset(&sa.sa_mask));
> -                TEST(sigaddset(&sa.sa_mask, sig_to_mask));
> -                TEST(err = syscall(__NR_rt_sigaction,sig, &sa, &oldaction, 8));
> -                if (TEST_RETURN == 0) {
> -                        return 0;
> -                } else {
> -                        return TEST_ERRNO;
> -                }
> -        } else if (flag == 4){
> -                        TEST(err = syscall(__NR_rt_sigaction,sig,
> &sa, NULL,9));
> -        }
> +                sigemptyset(&sa.sa_mask);
> +                sigaddset(&sa.sa_mask, sig_to_mask);
> +                TEST(syscall(__NR_rt_sigaction,sig, &sa,
> &oldaction,SIGSETSIZE));
>          if (TEST_RETURN == 0) {
>                  return 0;
>          } else {
> -                return TEST_ERRNO;
> +                        return TEST_RETURN;
>          }
>  }
> 
> 
>  int main(int ac, char **av) {
> -	int retnval, i, j;
> +	int signal, flag;
>          int lc;                 /* loop counter */
>          char *msg;              /* message returned from parse_opts */
>  	
> @@ -185,24 +171,26 @@
>                  Tst_count = 0;
>                  for (testno = 0; testno < TST_TOTAL; ++testno) {
> 
> -			for (i = 0; i <= (SIGRTMAX + 1); i++){//signal for 0 to 65
> -	    			tst_resm(TINFO,"Signal : %d",i);
> -			                for (j = 0; j < 4; j++){
> -			                       	 TEST(retnval = set_handler(i, 0, j,
> test_flags[j]));
> +			for (signal = SIGRTMIN; signal <= (SIGRTMAX ); signal++){//signal
> for 34 to 65
> +			 	for(flag=0; flag<5;flag++) {
> +	                        	 TEST(set_handler(signal, 0, test_flags[flag]));
>  						 if (TEST_RETURN == 0) {
> -        						tst_resm(TPASS, "rt_sigaction call succeeded: result =
> %d",TEST_RETURN);
> +        					tst_resm(TINFO,"signal: %d ", signal);
> +        					tst_resm(TPASS, "rt_sigaction call succeeded: result =
> %d ",TEST_RETURN );
> +        					tst_resm(TINFO, "sa.sa_flags = %s ",test_flags_list[flag]);
> +						kill(getpid(),signal);
>  			                         } else {
>                   	   				tst_resm(TFAIL, "%s failed - errno = %d :
> %s", TCID, TEST_ERRNO, strerror(TEST_ERRNO));
> -							cleanup();
> -							tst_exit();
>                         				}
>                  			}
> +		 	printf("\n");	
>          		}
> 
> 
> 
>                  }
>          }	
> +	cleanup();
>          tst_exit();
>  }
> 
> diff -Naurb a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
> b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
> --- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c	1970-01-01
> 05:30:00.000000000 +0530
> +++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c	2009-07-03
> 19:24:26.000000000 +0530
> @@ -0,0 +1,183 @@
> +/******************************************************************************/
> +/* Copyright (c) Crackerjack Project., 2007
>         */
> +/*
>         */
> +/* This program is free software;  you can redistribute it and/or
> modify      */
> +/* it under the terms of the GNU General Public License as published
> by       */
> +/* the Free Software Foundation; either version 2 of the License, or
>         */
> +/* (at your option) any later version.
>         */
> +/*
>         */
> +/* This program is distributed in the hope that it will be useful,
>         */
> +/* but WITHOUT ANY WARRANTY;  without even the implied warranty of
>         */
> +/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
>         */
> +/* the GNU General Public License for more details.
>         */
> +/*
>         */
> +/* You should have received a copy of the GNU General Public License
>         */
> +/* along with this program;  if not, write to the Free Software
>         */
> +/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
> 02111-1307 USA    */
> +/*
>         */
> +/******************************************************************************/
> +/******************************************************************************/
> +/*
>         */
> +/* File:        rt_sigaction02.c
>         */
> +/*
>         */
> +/* Description: This tests the rt_sigaction() syscall
>         */
> +/*		rt_sigaction Expected EFAULT error check                      */
> +/*
>         */
> +/* Usage:  <for command-line>
>         */
> +/* rt_sigaction02 [-c n] [-e][-i n] [-I x] [-p x] [-t]
>         */
> +/*      where,  -c n : Run n copies concurrently.
>         */
> +/*              -e   : Turn on errno logging.
>         */
> +/*              -i n : Execute test n times.
>         */
> +/*              -I x : Execute test for x seconds.
>         */
> +/*              -P x : Pause for x seconds between iterations.
>         */
> +/*              -t   : Turn on syscall timing.
>         */
> +/*
>         */
> +/* Total Tests: 1
>         */
> +/*
>         */
> +/* Test Name:   rt_sigaction02                                             */
> +/* History:     Porting from Crackerjack to LTP is done by
>         */
> +/*              Manas Kumar Nayak maknayak@in.ibm.com>
>         */
> +/******************************************************************************/
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <signal.h>
> +#include <errno.h>
> +#include <sys/syscall.h>
> +#include <string.h>
> +
> +/* Harness Specific Include Files. */
> +#include "test.h"
> +#include "usctest.h"
> +#include "linux_syscall_numbers.h"
> +
> +#if defined __mips__
> +#define SIGSETSIZE 16
> +#endif
> +
> +#if defined __arm__ || __i386__ || __powerpc__
> +#define SIGSETSIZE 8
> +#endif
> +
> +#define INVAL_STRUCT -1
> +
> +/* Extern Global Variables */
> +extern int Tst_count;           /* counter for tst_xxx routines.         */
> +extern char *TESTDIR;           /* temporary dir created by tst_tmpdir() */
> +
> +/* Global Variables */
> +char *TCID = "rt_sigaction02";  /* Test program identifier.*/
> +int  testno;
> +int  TST_TOTAL = 1;                   /* total number of tests in
> this file.   */
> +
> +/* Extern Global Functions */
> +/******************************************************************************/
> +/*
>         */
> +/* Function:    cleanup
>         */
> +/*
>         */
> +/* Description: Performs all one time clean up for this test on
> successful    */
> +/*              completion,  premature exit or  failure. Closes all
> temporary */
> +/*              files, removes all temporary directories exits the
> test with  */
> +/*              appropriate return code by calling tst_exit()
> function.       */
> +/*
>         */
> +/* Input:       None.
>         */
> +/*
>         */
> +/* Output:      None.
>         */
> +/*
>         */
> +/* Return:      On failure - Exits calling tst_exit(). Non '0' return
> code.   */
> +/*              On success - Exits calling tst_exit(). With '0'
> return code.  */
> +/*
>         */
> +/******************************************************************************/
> +extern void cleanup() {
> +        /* Remove tmp dir and all files in it */
> +        TEST_CLEANUP;
> +        tst_rmdir();
> +
> +        /* Exit with appropriate return code. */
> +        tst_exit();
> +}
> +
> +/* Local  Functions */
> +/******************************************************************************/
> +/*
>         */
> +/* Function:    setup
>         */
> +/*
>         */
> +/* Description: Performs all one time setup for this test. This
> function is   */
> +/*              typically used to capture signals, create temporary
> dirs      */
> +/*              and temporary files that may be used in the course of
> this    */
> +/*              test.
>         */
> +/*
>         */
> +/* Input:       None.
>         */
> +/*
>         */
> +/* Output:      None.
>         */
> +/*
>         */
> +/* Return:      On failure - Exits by calling cleanup().
>         */
> +/*              On success - returns 0.
>         */
> +/*
>         */
> +/******************************************************************************/
> +void setup() {
> +        /* Capture signals if any */
> +        /* Create temporary directories */
> +        TEST_PAUSE;
> +        tst_tmpdir();
> +}
> +
> +int test_flags[] = {SA_RESETHAND|SA_SIGINFO, SA_RESETHAND,
> SA_RESETHAND|SA_SIGINFO, SA_RESETHAND|SA_SIGINFO, SA_NOMASK};
> +char *test_flags_list[] = {"SA_RESETHAND|SA_SIGINFO", "SA_RESETHAND",
> "SA_RESETHAND|SA_SIGINFO", "SA_RESETHAND|SA_SIGINFO", "SA_NOMASK"};
> +
> +struct test_case_t {
> +        int exp_errno;
> +        char *errdesc;
> +} test_cases[] = {
> +	{ EFAULT, "EFAULT" }
> +};
> +
> +
> +int main(int ac, char **av) {
> +	int signal, flag;
> +        int lc;                 /* loop counter */
> +        char *msg;              /* message returned from parse_opts */
> +	
> +        /* parse standard options */
> +        if ((msg = parse_opts(ac, av, (option_t *)NULL, NULL)) !=
> (char *)NULL){
> +             tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
> +             tst_exit();
> +           }
> +
> +        setup();
> +
> +        /* Check looping state if -i option given */
> +        for (lc = 0; TEST_LOOPING(lc); ++lc) {
> +                Tst_count = 0;
> +                for (testno = 0; testno < TST_TOTAL; ++testno) {
> +
> +			for (signal = SIGRTMIN; signal <= (SIGRTMAX ); signal++){//signal
> for 34 to 65
> +			 	for(flag=0; flag<5;flag++) {
> +
> +				/*   							        *
> +				 * long sys_rt_sigaction (int sig, const struct sigaction *act, *
> +				 * truct sigaction *oact, size_t sigsetsize);			*
> +				 * EFAULT:							*
> +		        	 * An invalid act or oact value was specified 			*
> +				 */
> +
> +					 TEST(syscall(__NR_rt_sigaction,signal, INVAL_STRUCT, NULL,SIGSETSIZE));
> +					if((TEST_RETURN == -1) && (TEST_ERRNO == test_cases[0].exp_errno)) {
> +        						tst_resm(TINFO, "sa.sa_flags = %s ",test_flags_list[flag]);
> +                 	   				tst_resm(TPASS, "%s failure with sig: %d as
> expected errno  = %s : %s", TCID, signal,test_cases[0].errdesc,
> strerror(TEST_ERRNO));
> +			                         } else {
> +        					tst_resm(TFAIL, "rt_sigaction call succeeded: result =
> %d got error %d:but expected  %d", TEST_RETURN, TEST_ERRNO,
> test_cases[0].exp_errno);
> +        					tst_resm(TINFO, "sa.sa_flags = %s ",test_flags_list[flag]);
> +						}
> +                			}
> +		 	printf("\n");	
> +        		}
> +
> +
> +
> +                }
> +        }	
> +	cleanup();
> +        tst_exit();
> +}
> +
> diff -Naurb a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
> b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
> --- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c	1970-01-01
> 05:30:00.000000000 +0530
> +++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c	2009-07-03
> 19:24:12.000000000 +0530
> @@ -0,0 +1,200 @@
> +/******************************************************************************/
> +/* Copyright (c) Crackerjack Project., 2007
>         */
> +/*
>         */
> +/* This program is free software;  you can redistribute it and/or
> modify      */
> +/* it under the terms of the GNU General Public License as published
> by       */
> +/* the Free Software Foundation; either version 2 of the License, or
>         */
> +/* (at your option) any later version.
>         */
> +/*
>         */
> +/* This program is distributed in the hope that it will be useful,
>         */
> +/* but WITHOUT ANY WARRANTY;  without even the implied warranty of
>         */
> +/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
>         */
> +/* the GNU General Public License for more details.
>         */
> +/*
>         */
> +/* You should have received a copy of the GNU General Public License
>         */
> +/* along with this program;  if not, write to the Free Software
>         */
> +/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
> 02111-1307 USA    */
> +/*
>         */
> +/******************************************************************************/
> +/******************************************************************************/
> +/*
>         */
> +/* File:        rt_sigaction03.c
>         */
> +/*
>         */
> +/* Description: This tests the rt_sigaction() syscall
>         */
> +/*		rt_sigaction Expected EINVAL error check                      */
> +/*
>         */
> +/* Usage:  <for command-line>
>         */
> +/* rt_sigaction03 [-c n] [-e][-i n] [-I x] [-p x] [-t]
>         */
> +/*      where,  -c n : Run n copies concurrently.
>         */
> +/*              -e   : Turn on errno logging.
>         */
> +/*              -i n : Execute test n times.
>         */
> +/*              -I x : Execute test for x seconds.
>         */
> +/*              -P x : Pause for x seconds between iterations.
>         */
> +/*              -t   : Turn on syscall timing.
>         */
> +/*
>         */
> +/* Total Tests: 1
>         */
> +/*
>         */
> +/* Test Name:   rt_sigaction03                                             */
> +/* History:     Porting from Crackerjack to LTP is done by
>         */
> +/*              Manas Kumar Nayak maknayak@in.ibm.com>
>         */
> +/******************************************************************************/
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <signal.h>
> +#include <errno.h>
> +#include <sys/syscall.h>
> +#include <string.h>
> +
> +/* Harness Specific Include Files. */
> +#include "test.h"
> +#include "usctest.h"
> +#include "linux_syscall_numbers.h"
> +
> +#define INVAL_SIGSETSIZE -1
> +
> +/* Extern Global Variables */
> +extern int Tst_count;           /* counter for tst_xxx routines.         */
> +extern char *TESTDIR;           /* temporary dir created by tst_tmpdir() */
> +
> +/* Global Variables */
> +char *TCID = "rt_sigaction03";  /* Test program identifier.*/
> +int  testno;
> +int  TST_TOTAL = 1;                   /* total number of tests in
> this file.   */
> +
> +/* Extern Global Functions */
> +/******************************************************************************/
> +/*
>         */
> +/* Function:    cleanup
>         */
> +/*
>         */
> +/* Description: Performs all one time clean up for this test on
> successful    */
> +/*              completion,  premature exit or  failure. Closes all
> temporary */
> +/*              files, removes all temporary directories exits the
> test with  */
> +/*              appropriate return code by calling tst_exit()
> function.       */
> +/*
>         */
> +/* Input:       None.
>         */
> +/*
>         */
> +/* Output:      None.
>         */
> +/*
>         */
> +/* Return:      On failure - Exits calling tst_exit(). Non '0' return
> code.   */
> +/*              On success - Exits calling tst_exit(). With '0'
> return code.  */
> +/*
>         */
> +/******************************************************************************/
> +extern void cleanup() {
> +        /* Remove tmp dir and all files in it */
> +        TEST_CLEANUP;
> +        tst_rmdir();
> +
> +        /* Exit with appropriate return code. */
> +        tst_exit();
> +}
> +
> +/* Local  Functions */
> +/******************************************************************************/
> +/*
>         */
> +/* Function:    setup
>         */
> +/*
>         */
> +/* Description: Performs all one time setup for this test. This
> function is   */
> +/*              typically used to capture signals, create temporary
> dirs      */
> +/*              and temporary files that may be used in the course of
> this    */
> +/*              test.
>         */
> +/*
>         */
> +/* Input:       None.
>         */
> +/*
>         */
> +/* Output:      None.
>         */
> +/*
>         */
> +/* Return:      On failure - Exits by calling cleanup().
>         */
> +/*              On success - returns 0.
>         */
> +/*
>         */
> +/******************************************************************************/
> +void setup() {
> +        /* Capture signals if any */
> +        /* Create temporary directories */
> +        TEST_PAUSE;
> +        tst_tmpdir();
> +}
> +
> +int test_flags[] = {SA_RESETHAND|SA_SIGINFO, SA_RESETHAND,
> SA_RESETHAND|SA_SIGINFO, SA_RESETHAND|SA_SIGINFO, SA_NOMASK};
> +char *test_flags_list[] = {"SA_RESETHAND|SA_SIGINFO", "SA_RESETHAND",
> "SA_RESETHAND|SA_SIGINFO", "SA_RESETHAND|SA_SIGINFO", "SA_NOMASK"};
> +
> +
> +struct test_case_t {
> +        int exp_errno;
> +        char *errdesc;
> +} test_cases[] = {
> +	{ EINVAL, "EINVAL" }
> +};
> +
> +void
> +handler(int sig)
> +{
> +        tst_resm(TINFO,"Signal Handler Called with signal number %d\n",sig);
> +        return;
> +}
> +
> +int
> +set_handler(int sig, int sig_to_mask, int mask_flags)
> +{
> +        struct sigaction sa, oldaction;
> +
> +                sa.sa_sigaction = (void *)handler;
> +                sa.sa_flags = mask_flags;
> +                sigemptyset(&sa.sa_mask);
> +                sigaddset(&sa.sa_mask, sig_to_mask);
> +
> +		/*   							        *
> +		 * long sys_rt_sigaction (int sig, const struct sigaction *act, *
> +		 * truct sigaction *oact, size_t sigsetsize);			*
> +		 * EINVAL:							*
> +        	 * sigsetsize was not equivalent to the size of a sigset_t type *
> +		 */
> +
> +                TEST(syscall(__NR_rt_sigaction,sig, &sa ,
> &oldaction,INVAL_SIGSETSIZE));
> +                if (TEST_RETURN == 0) {
> +                        return 0;
> +                } else {
> +                        return TEST_RETURN;
> +                }
> +}
> +
> +
> +int main(int ac, char **av) {
> +	int signal, flag;
> +        int lc;                 /* loop counter */
> +        char *msg;              /* message returned from parse_opts */
> +	
> +        /* parse standard options */
> +        if ((msg = parse_opts(ac, av, (option_t *)NULL, NULL)) !=
> (char *)NULL){
> +             tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
> +             tst_exit();
> +           }
> +
> +        setup();
> +
> +        /* Check looping state if -i option given */
> +        for (lc = 0; TEST_LOOPING(lc); ++lc) {
> +                Tst_count = 0;
> +                for (testno = 0; testno < TST_TOTAL; ++testno) {
> +
> +			for (signal = SIGRTMIN; signal <= (SIGRTMAX ); signal++){//signal
> for 34 to 65
> +			 	for(flag=0; flag<5;flag++) {
> +	                        	 TEST(set_handler(signal, 0, test_flags[flag]));
> +					if((TEST_RETURN == -1) && (TEST_ERRNO == test_cases[0].exp_errno)) {
> +        						tst_resm(TINFO, "sa.sa_flags = %s ",test_flags_list[flag]);
> +                 	   				tst_resm(TPASS, "%s failure with sig: %d as
> expected errno  = %s : %s", TCID, signal,test_cases[0].errdesc,
> strerror(TEST_ERRNO));
> +			                         } else {
> +        					tst_resm(TFAIL, "rt_sigaction call succeeded: result =
> %d got error %d:but expected  %d", TEST_RETURN, TEST_ERRNO,
> test_cases[0].exp_errno);
> +        					tst_resm(TINFO, "sa.sa_flags = %s ",test_flags_list[flag]);
> +						}
> +                			}
> +		 	printf("\n");	
> +        		}
> +
> +
> +
> +                }
> +        }	
> +	cleanup();
> +        tst_exit();
> +}
> +


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
