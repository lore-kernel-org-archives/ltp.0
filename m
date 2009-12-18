Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1NLfIl-0005nt-PI
	for ltp-list@lists.sourceforge.net; Fri, 18 Dec 2009 16:03:35 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NLfIg-00018j-50
	for ltp-list@lists.sourceforge.net; Fri, 18 Dec 2009 16:03:35 +0000
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e4.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nBIFsJuD029102
	for <ltp-list@lists.sourceforge.net>; Fri, 18 Dec 2009 10:54:19 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nBIG3OW6096882
	for <ltp-list@lists.sourceforge.net>; Fri, 18 Dec 2009 11:03:24 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nBIG3EtV017589
	for <ltp-list@lists.sourceforge.net>; Fri, 18 Dec 2009 14:03:15 -0200
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4B1F52FD.4010305@cn.fujitsu.com>
References: <4B1F52FD.4010305@cn.fujitsu.com>
Date: Fri, 18 Dec 2009 21:33:05 +0530
Message-Id: <1261152185.8993.23.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] syscalls: fix some failure on arch X86_64
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Garret,

Not sure if you applied this :-(

Regards--
Subrata

On Wed, 2009-12-09 at 15:34 +0800, liubo wrote: 
> Here is the patch, which contains lots of adjustments 
> on style, so it might be a bit huge.
> 
> Testcase 1. rt_sigaction01
> On arch x86_64, if we directly get to call syscall 
> rt_sigaction, there will be "segment fault".
> 1) One reason is that we must supply the flag of 
> "SA_RESTORER" and the correct pointer to the fuction 
> "restorer", according to the kernel code.
> 2) The other reason is that default syscall rt_sigaction 
> use kernel "sigaction" structure, which is different 
> with normal "sigaction" structure.
> 
> So, 
> 1) We manage to find the address of the function 
> "restorer" by using glibc function "sigaction", 
> which might be something tricky. Then we add these 
> arguments to make test run correctly.
> 2) We also use kernel "sigaction" structure to fit 
> realtime syscall __NR_rt_sigaction.
> 
> Testcase 2. rt_sigprocmask01
> First, there exsits the same problem as rt_sigaction01.
> Second, this testcase uses a unchanged signal number 33, 
> which may diff among different archs and lead to error
> "unknown signal".
> 
> So, we use a macro TEST_SIG which refers to SIGRTMIN 
> to replace 33.
> 
> Testcase 3. rt_sigsuspend01
> There exists the same problem as rt_sigaction01.
> 
> This patch fixed these failure.
> 
> Signed-off-by: Liu Bo <liubo2009@cn.fujitsu.com>
> 
> ---
>  include/ltp_signal.h                               |  152 --------
>  include/rt_signal.h                                |   60 ++++
>  .../kernel/syscalls/rt_sigaction/rt_sigaction01.c  |  364 +++++++++-----------
>  .../syscalls/rt_sigprocmask/rt_sigprocmask01.c     |  331 ++++++++++--------
>  .../syscalls/rt_sigsuspend/rt_sigsuspend01.c       |  168 +++++----
>  5 files changed, 499 insertions(+), 576 deletions(-)
>  delete mode 100644 include/ltp_signal.h
>  create mode 100644 include/rt_signal.h
> 
> diff --git a/include/ltp_signal.h b/include/ltp_signal.h
> deleted file mode 100644
> index 5e9a198..0000000
> --- a/include/ltp_signal.h
> +++ /dev/null
> @@ -1,152 +0,0 @@
> -/*
> - * Copyright (c) 2009 Cisco Systems, Inc.  All Rights Reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it would be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> - *
> - * Further, this software is distributed without any warranty that it is
> - * free of the rightful claim of any third person regarding infringement
> - * or the like.  Any license provided herein, whether implied or
> - * otherwise, applies only to this software file.  Patent licenses, if
> - * any, provided herein do not apply to combinations of this program with
> - * other software, or any other product whatsoever.
> - *
> - * You should have received a copy of the GNU General Public License along
> - * with this program; if not, write the Free Software Foundation, Inc., 59
> - * Temple Place - Suite 330, Boston MA 02111-1307, USA.
> - *
> - */
> -
> -#ifndef __LTP_SIGNAL_H
> -#define __LTP_SIGNAL_H
> -
> -#include <errno.h>
> -#include <signal.h>
> -#include <stdio.h>
> -#include "config.h"
> -
> -#define SIGSETSIZE (_NSIG / 8)
> -
> -#ifdef LTP_RT_SIG_TEST
> -
> -extern int  expected_signal_number;
> -
> -#if defined(__x86_64__)
> -
> -/*
> - * From asm/signal.h -- this value isn't exported anywhere outside of glibc and
> - * asm/signal.h and is only required for the rt_sig* function family because
> - * sigaction(2), et all, appends this if necessary to
> - * (struct sigaction).sa_flags. HEH.
> - *
> - * I do #undef though, just in case...
> - */
> -#undef SA_RESTORER
> -#define SA_RESTORER	0x04000000
> -
> -/* 
> - * From .../arch/x86/kernel/signal.c:448 --
> - *
> - * x86-64 should always use SA_RESTORER.
> - *
> - * -- thus SA_RESTORER must always be defined along with
> - * (struct sigaction).sa_restorer.
> - */
> -#define ARCH_SPECIFIC_RT_SIGACTION_SETUP(__sa) __sa.sa_flags |= SA_RESTORER; __sa.sa_restorer = dummy_restorer;
> -/* defined(__x86_64) */
> -#else
> -#define ARCH_SPECIFIC_RT_SIGACTION_SETUP(__sa)
> -#endif
> -
> -/*
> - * To help direct sigsegv_sigaction_handler in determining whether or not the
> - * segfault was valid.
> - */
> -extern int  expected_signal_number;
> -
> -/* 
> - * A dummy sa_restorer function, because we have to have it if SA_RESTORER is
> - * required.
> - */
> -inline void
> -dummy_restorer(void) {
> -	tst_resm(TINFO, "%s called", __func__);
> -}
> -
> -/* 
> - * SIGSEGV will be thrown if an overflow occurs, or some other undesired
> - * precondition. Let's catch it so the test will at least proceed and not
> - * completely bomb the heck out.
> - */
> -inline void
> -sigsegv_sigaction_handler(int signum, siginfo_t *siginfo, void *ucontext) {
> -
> -	/*
> -	 * Backwards compatibility is a pain; I think that's what's driving
> -	 * the implicit sa_restorer BS on x86_64, and the reason why mips* and
> -	 * ppc* only has a sigaction handler (not rt_sigaction).
> -	 *
> -	 * GG for backwards compatibility and lack of documentation on an
> -	 * internal syscall...
> -	 */
> -#ifdef __x86_64__
> -	if (expected_signal_number == SIGRTMIN) {
> -		tst_resm(TINFO, "SIGRTMIN segfaults on x86_64 (known issue).");
> -	} else {
> -#endif
> -	tst_brkm(TBROK | TERRNO, NULL,
> -		"Uncaught SIGSEGV; please validate whether or not test meets "
> -		"functional requirements as per do_signal and callees in "
> -		"$KERN_SRC/arch/<arch>/kernel/signal.c is concerned");
> -
> -#ifdef __x86_64__
> -	}
> -#endif
> -}
> -
> -/* 
> - * Catch SIGSEGV just in case one of the rt_sigaction calls tosses up a SIGSEGV
> - * at the kernel level because of an -EFAULT was tossed by a caller. What a
> - * PITA :].
> - */
> -inline int
> -setup_sigsegv_sigaction_handler()
> -{
> -	int rc = -1;
> -	struct sigaction sa;
> -	sigset_t sigset;
> -
> -	/* 
> -	 * Catch SIGSEGV just in case one of the rt_sigaction calls tosses up a
> -	 * SIGSEGV at the kernel level because of an -EFAULT was tossed by a
> -	 * caller. What a PITA :].
> -	 */
> -	sa.sa_sigaction = (void *)sigsegv_sigaction_handler;
> -	/* We want the handler to persist, so don't do SA_RESETHAND... */
> -	sa.sa_flags = SA_SIGINFO;
> -
> -	if (sigemptyset(&sa.sa_mask) < 0) {
> -		tst_brkm(TBROK | TERRNO, cleanup,
> -			"Failed to call sigemptyset for SIGSEGV");
> -	} else if (sigaddset(&sigset, SIGSEGV) < 0) {
> -		tst_brkm(TBROK | TERRNO, cleanup,
> -			"Failed to do sigaddset for SIGSEGV");
> -	} else if (sigaction(SIGSEGV, &sa, (struct sigaction *) NULL) < 0) {
> -		tst_brkm(TBROK | TERRNO, cleanup,
> -			"Failed to setup sighandler for SIGSEGV");
> -	} else {
> -		rc = 0;
> -	}
> -
> -	return rc;
> -
> -}
> -
> -#endif /* RT_SIG_TEST */
> -
> -#endif
> diff --git a/include/rt_signal.h b/include/rt_signal.h
> new file mode 100644
> index 0000000..be64deb
> --- /dev/null
> +++ b/include/rt_signal.h
> @@ -0,0 +1,60 @@
> +/******************************************************************************/
> +/*                                                                            */
> +/* Copyright (c) 2009 FUJITSU LIMITED                                         */
> +/*                                                                            */
> +/* This program is free software;  you can redistribute it and/or modify      */
> +/* it under the terms of the GNU General Public License as published by       */
> +/* the Free Software Foundation; either version 2 of the License, or          */
> +/* (at your option) any later version.                                        */
> +/*                                                                            */
> +/* This program is distributed in the hope that it will be useful,            */
> +/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
> +/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
> +/* the GNU General Public License for more details.                           */
> +/*                                                                            */
> +/* You should have received a copy of the GNU General Public License          */
> +/* along with this program;  if not, write to the Free Software               */
> +/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    */
> +/*                                                                            */
> +/* Author: Liu Bo <liubo2009@cn.fujitsu.com>                                  */
> +/*                                                                            */
> +/******************************************************************************/
> +
> +#ifndef __LTP_SIGNAL_H
> +#define __LTP_SIGNAL_H
> +
> +/* We do not globally define the SA_RESTORER flag so do it here.  */
> +#define HAVE_SA_RESTORER
> +#define SA_RESTORER 0x04000000
> +
> +struct kernel_sigaction {
> +	__sighandler_t k_sa_handler;
> +	unsigned long sa_flags;
> +	void (*sa_restorer) (void);
> +	sigset_t sa_mask;
> +};
> +
> +void (*restore_rt) (void);
> +
> +void
> +handler_h(void)
> +{
> +	return;
> +}
> +
> +/* initial restore_rt for x86_64 */
> +void
> +sig_initial(int sig)
> +{
> +	struct sigaction act, oact;
> +
> +	act.sa_handler = (void *)handler_h;
> +	sigemptyset(&act.sa_mask);
> +	sigaddset(&act.sa_mask, sig);
> +	/* copy act.sa_restorer to kernel */
> +	sigaction(sig, &act, &oact);
> +	/* copy oact.sa_restorer from kernel */
> +	sigaction(sig, &act, &oact);
> +	restore_rt = oact.sa_restorer;
> +}
> +
> diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
> index 6e937d2..d30f204 100644
> --- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
> +++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
> @@ -1,266 +1,216 @@
>  /******************************************************************************/
> -/* Copyright (c) Crackerjack Project., 2007				   */
> -/*									    */
> +/* Copyright (c) Crackerjack Project., 2007                                   */
> +/*                                                                            */
>  /* This program is free software;  you can redistribute it and/or modify      */
>  /* it under the terms of the GNU General Public License as published by       */
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
> +/* the Free Software Foundation; either version 2 of the License, or          */
> +/* (at your option) any later version.                                        */
> +/*                                                                            */
> +/* This program is distributed in the hope that it will be useful,            */
> +/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
> +/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
> +/* the GNU General Public License for more details.                           */
> +/*                                                                            */
> +/* You should have received a copy of the GNU General Public License          */
> +/* along with this program;  if not, write to the Free Software               */
>  /* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    */
> -/*									    */
> +/*                                                                            */
>  /******************************************************************************/
>  /******************************************************************************/
> -/*									    */
> -/* File:	rt_sigaction01.c					      */
> -/*									    */
> -/* Description: This tests the rt_sigaction() syscall			 */
> +/*                                                                            */
> +/* File:        rt_sigaction01.c                                              */
> +/*                                                                            */
> +/* Description: This tests the rt_sigaction() syscall                         */
>  /*		rt_sigaction alters an action taken by a process on receipt   */
> -/* 		of a particular signal. The action is specified by the	*/
> +/* 		of a particular signal. The action is specified by the        */
>  /*		sigaction structure. The previous action on the signal is     */
> -/*		saved in oact.sigsetsize should indicate the size of a	*/
> -/*		sigset_t type.		       			      */
> -/*									    */
> -/* Usage:  <for command-line>						 */
> -/* rt_sigaction01 [-c n] [-e][-i n] [-I x] [-p x] [-t]			*/
> -/*      where,  -c n : Run n copies concurrently.			     */
> -/*	      -e   : Turn on errno logging.				 */
> -/*	      -i n : Execute test n times.				  */
> -/*	      -I x : Execute test for x seconds.			    */
> -/*	      -P x : Pause for x seconds between iterations.		*/
> -/*	      -t   : Turn on syscall timing.				*/
> -/*									    */
> -/* Total Tests: 1							     */
> -/*									    */
> -/* Test Name:   rt_sigaction01					     */
> -/* History:     Porting from Crackerjack to LTP is done by		    */
> -/*	      Manas Kumar Nayak maknayak@in.ibm.com>			*/
> +/*		saved in oact.sigsetsize should indicate the size of a        */
> +/*		sigset_t type.                       			      */
> +/*                                                                            */
> +/* Usage:  <for command-line>                                                 */
> +/* rt_sigaction01 [-c n] [-e][-i n] [-I x] [-p x] [-t]                        */
> +/*      where,  -c n : Run n copies concurrently.                             */
> +/*              -e   : Turn on errno logging.                                 */
> +/*              -i n : Execute test n times.                                  */
> +/*              -I x : Execute test for x seconds.                            */
> +/*              -P x : Pause for x seconds between iterations.                */
> +/*              -t   : Turn on syscall timing.                                */
> +/*                                                                            */
> +/* Total Tests: 1                                                             */
> +/*                                                                            */
> +/* Test Name:   rt_sigaction01                                             */
> +/* History:     Porting from Crackerjack to LTP is done by                    */
> +/*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
>  /******************************************************************************/
> -#define _GNU_SOURCE
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <unistd.h>
> +#include <signal.h>
>  #include <errno.h>
> -#include <sys/types.h>
> +#include <sys/syscall.h>
>  #include <string.h>
> -#include "config.h"
> 
>  /* Harness Specific Include Files. */
>  #include "test.h"
>  #include "usctest.h"
>  #include "linux_syscall_numbers.h"
> -#define LTP_RT_SIG_TEST
> -#include "ltp_signal.h"
> +
> +#ifdef __x86_64__
> +#include "rt_signal.h"
> +#endif
> +
> +/*
> + * For all but __mips__:
> + *
> + * _COMPAT_NSIG / _COMPAT_NSIG_BPW == 2.
> + *
> + * For __mips__:
> + *
> + * _COMPAT_NSIG / _COMPAT_NSIG_BPW == 4.
> + *
> + * See asm/compat.h under the kernel source for more details.
> + *
> + * Multiply that by a fudge factor of 4 and you have your SIGSETSIZE.
> + */
> +#if defined (__mips__)
> +#define SIGSETSIZE 16
> +#else
> +#define SIGSETSIZE 8
> +#endif
> 
>  /* Extern Global Variables */
> -extern int Tst_count;	   /* counter for tst_xxx routines.	 */
> -extern char *TESTDIR;	   /* temporary dir created by tst_tmpdir() */
> +extern int Tst_count;           /* counter for tst_xxx routines.         */
> +extern char *TESTDIR;           /* temporary dir created by tst_tmpdir() */
> 
>  /* Global Variables */
>  char *TCID = "rt_sigaction01";  /* Test program identifier.*/
> -int  expected_signal_number = 0;
> -int  pass_count = 0;
>  int  testno;
> -int  TST_TOTAL = 1;		   /* total number of tests in this file.   */
> -
> -int test_flags[] = {
> -	SA_RESETHAND|SA_SIGINFO,
> -	SA_RESETHAND,
> -	SA_RESETHAND|SA_SIGINFO,
> -	SA_RESETHAND|SA_SIGINFO,
> -	SA_NOMASK
> -};
> -char *test_flags_list[] = {
> -	"SA_RESETHAND|SA_SIGINFO",
> -	"SA_RESETHAND",
> -	"SA_RESETHAND|SA_SIGINFO",
> -	"SA_RESETHAND|SA_SIGINFO",
> -	"SA_NOMASK"
> -};
> +int  TST_TOTAL = 1;                   /* total number of tests in this file.   */
> 
>  /* Extern Global Functions */
>  /******************************************************************************/
> -/*									    */
> -/* Function:    cleanup						       */
> -/*									    */
> +/*                                                                            */
> +/* Function:    cleanup                                                       */
> +/*                                                                            */
>  /* Description: Performs all one time clean up for this test on successful    */
> -/*	      completion,  premature exit or  failure. Closes all temporary */
> -/*	      files, removes all temporary directories exits the test with  */
> -/*	      appropriate return code by calling tst_exit() function.       */
> -/*									    */
> -/* Input:       None.							 */
> -/*									    */
> -/* Output:      None.							 */
> -/*									    */
> +/*              completion,  premature exit or  failure. Closes all temporary */
> +/*              files, removes all temporary directories exits the test with  */
> +/*              appropriate return code by calling tst_exit() function.       */
> +/*                                                                            */
> +/* Input:       None.                                                         */
> +/*                                                                            */
> +/* Output:      None.                                                         */
> +/*                                                                            */
>  /* Return:      On failure - Exits calling tst_exit(). Non '0' return code.   */
> -/*	      On success - Exits calling tst_exit(). With '0' return code.  */
> -/*									    */
> +/*              On success - Exits calling tst_exit(). With '0' return code.  */
> +/*                                                                            */
>  /******************************************************************************/
> -static void cleanup() {
> +extern void cleanup() 
> +{
>  	/* Remove tmp dir and all files in it */
>  	TEST_CLEANUP;
>  	tst_rmdir();
> +
> +	/* Exit with appropriate return code. */
> +	tst_exit();
>  }
> 
>  /* Local  Functions */
>  /******************************************************************************/
> -/*									    */
> -/* Function:    setup							 */
> -/*									    */
> +/*                                                                            */
> +/* Function:    setup                                                         */
> +/*                                                                            */
>  /* Description: Performs all one time setup for this test. This function is   */
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
> +/*              typically used to capture signals, create temporary dirs      */
> +/*              and temporary files that may be used in the course of this    */
> +/*              test.                                                         */
> +/*                                                                            */
> +/* Input:       None.                                                         */
> +/*                                                                            */
> +/* Output:      None.                                                         */
> +/*                                                                            */
> +/* Return:      On failure - Exits by calling cleanup().                      */
> +/*              On success - returns 0.                                       */
> +/*                                                                            */
>  /******************************************************************************/
> -void
> -setup()
> +void setup() 
>  {
> -	(void) setup_sigsegv_sigaction_handler();
> -	/* Wait for SIGUSR1 if requested */
> -	TEST_PAUSE;
> +	/* Capture signals if any */
>  	/* Create temporary directories */
> +	TEST_PAUSE;
>  	tst_tmpdir();
>  }
> 
> +int test_flags[] = {SA_RESETHAND|SA_SIGINFO, SA_RESETHAND, SA_RESETHAND|SA_SIGINFO, SA_RESETHAND|SA_SIGINFO, SA_NOMASK};
> +char *test_flags_list[] = {"SA_RESETHAND|SA_SIGINFO", "SA_RESETHAND", "SA_RESETHAND|SA_SIGINFO", "SA_RESETHAND|SA_SIGINFO", "SA_NOMASK"};
> +
>  void
>  handler(int sig)
>  {
> -	tst_resm(TINFO, "Signal handler (non-sigaction) called with signal number %d", sig);
> -	pass_count++;
> +        tst_resm(TINFO,"Signal Handler Called with signal number %d\n",sig);
> +        return;
>  }
> -
> -void
> -sigaction_handler(int sig, siginfo_t *siginfo, void *ucontext) {
> -	tst_resm(TINFO, "Signal handler (sigaction) called with signal number %d", sig);
> -	if (sig == expected_signal_number)
> -		pass_count++;
> -}
> -
>  int
>  set_handler(int sig, int mask_flags)
>  {
> -	int rc = -1;
> -	struct sigaction sa;
> -
> -	//memset(&sa, 0, SIGSETSIZE);
> -
> -	sa.sa_flags = mask_flags;
> -
> -	ARCH_SPECIFIC_RT_SIGACTION_SETUP(sa);
> -
> -#if HAVE_STRUCT_SIGACTION_SA_SIGACTION
> -	/*
> -         *  SA_SIGINFO (since Linux 2.2)
> -         *        The  signal  handler  takes  3  arguments, not one.  In this
> -         *        case, sa_sigaction should  be  set  instead  of  sa_handler.
> -         *        This flag is only meaningful when establishing a signal han-
> -         *        dler.
> -         *
> -	 */
> -	if (sa.sa_flags & SA_SIGINFO)
> -		sa.sa_sigaction = (void *) sigaction_handler;
> -	else
> +#ifdef __x86_64__
> +	struct kernel_sigaction sa, oldaction;
> +	mask_flags |= SA_RESTORER;
> +	sa.sa_restorer = restore_rt;
> +	sa.k_sa_handler = (void *)handler;
> +#else
> +	struct sigaction sa, oldaction;
> +	sa.sa_handler = (void *)handler;
>  #endif
> -		sa.sa_handler = (void *) handler;
> -
> -	if (sigemptyset(&sa.sa_mask) < 0) {
> -		tst_resm(TINFO, "sigemptyset(..) failed");
> -	} else if (sigaddset(&sa.sa_mask, sig) < 0) {
> -		tst_resm(TFAIL | TINFO, "sigaddset(..) failed");
> -	} else if (syscall(__NR_rt_sigaction, sig, &sa, (struct sigaction*) NULL, SIGSETSIZE)) {
> -		tst_resm(TFAIL | TERRNO, "rt_sigaction(%d, ..) failed", sig);
> -	} else {
> -		rc = 0;
> -	}
> -	return rc;
> +	sa.sa_flags = mask_flags;
> +	sigemptyset(&sa.sa_mask);
> +	sigaddset(&sa.sa_mask, sig);
> +	TEST(syscall(__NR_rt_sigaction,sig, &sa, &oldaction,SIGSETSIZE));
> +	return TEST_RETURN;
>  }
> 
> -int
> -main(int ac, char **av) {
> 
> -	char *msg;	/* message returned from parse_opts */
> -
> -	/* parse standard options */
> -	if ((msg = parse_opts(ac, av, (option_t *)NULL, NULL)) != (char *)NULL){
> -		tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
> -		tst_exit();
> -	}
> -
> -	setup();
> -
> -#if HAVE_STRUCT_SIGACTION_SA_SIGACTION
> -	int flag;
> -	int last_pass_count;
> -	int num_tests_per_signal = sizeof(test_flags) / sizeof(*test_flags);
> -	int tests_passed;
> -	int lc;		/* loop counter */
> -
> -	tst_resm(TINFO, "Will run %d tests per signal in set [%d, %d]",
> -			num_tests_per_signal, SIGRTMIN, SIGRTMAX);
> -
> -	/* Check looping state if -i option given */
> -	for (lc = 0; TEST_LOOPING(lc); ++lc) {
> -
> -		Tst_count = 0;
> -
> -		for (testno = 0; testno < TST_TOTAL; ++testno) {
> -
> -			/* 34 (NPTL) or 35 (LinuxThreads) to 65 (or 128 on mips). */
> -			for (expected_signal_number = SIGRTMIN; expected_signal_number <= SIGRTMAX; expected_signal_number++) { 
> -
> -				last_pass_count = pass_count;
> -
> -				tst_resm(TINFO, "signal: %d ", expected_signal_number);
> -
> -			 	for (flag = 0; flag < num_tests_per_signal; flag++) {
> -
> -					if (set_handler(expected_signal_number, test_flags[flag]) == 0) {
> -
> -						tst_resm(TINFO,
> -							"\tsa.sa_flags = %s",
> -							test_flags_list[flag]);
> -
> -						if (kill(getpid(), expected_signal_number) < 0) {
> -							tst_resm(TINFO | TERRNO, "kill failed");
> -						}
> -
> -		       			}
> -
> -				}
> -
> -				tests_passed = ((pass_count - last_pass_count) ==
> -						 num_tests_per_signal);
> -
> -				tst_resm(tests_passed ? TPASS : TFAIL,
> -					"tests %s for signal = %d",
> -					tests_passed ? "passed" : "failed",
> -					expected_signal_number);
> -
> -			}
> -
> -		}
> -
> -	}
> -#else
> -	tst_brkm(TCONF, NULL,
> -			"Your architecture doesn't support this test (no "
> -			"sa_sigaction field in struct sigaction).");
> +int main(int ac, char **av) {
> +	int signal, flag;
> +        int lc;                 /* loop counter */
> +        char *msg;              /* message returned from parse_opts */
> +	
> +        /* parse standard options */
> +        if ((msg = parse_opts(ac, av, (option_t *)NULL, NULL)) != (char *)NULL){
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
> +			for (signal = SIGRTMIN; signal <= (SIGRTMAX ); signal++){//signal for 34 to 65 
> +#ifdef __x86_64__
> +				sig_initial(signal);
>  #endif
> +				for(flag=0; flag<5;flag++) {
> +	                        	 TEST(set_handler(signal, test_flags[flag]));
> +						 if (TEST_RETURN == 0) {
> +        					tst_resm(TINFO,"signal: %d ", signal);
> +        					tst_resm(TPASS, "rt_sigaction call succeeded: result = %ld ",TEST_RETURN );
> +        					tst_resm(TINFO, "sa.sa_flags = %s ",test_flags_list[flag]);
> +						kill(getpid(),signal);
> +			                         } else {
> +                 	   				tst_resm(TFAIL, "%s failed - errno = %d : %s", TCID, TEST_ERRNO, strerror(TEST_ERRNO));
> +                       				}
> +                			}
> +		 	printf("\n");	
> +        		}
> +
> +
> +
> +                }
> +        }	
>  	cleanup();
> -	tst_exit();
> -
> +        tst_exit();
>  }
> +
> diff --git a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
> index 2e51176..8bcdc78 100644
> --- a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
> +++ b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
> @@ -1,26 +1,26 @@
>  /******************************************************************************/
> -/* Copyright (c) Crackerjack Project., 2007				      */
> -/*									      */
> +/* Copyright (c) Crackerjack Project., 2007                                   */
> +/*                                                                            */
>  /* This program is free software;  you can redistribute it and/or modify      */
>  /* it under the terms of the GNU General Public License as published by       */
> -/* the Free Software Foundation; either version 2 of the License, or	      */
> -/* (at your option) any later version.					      */
> -/*									      */
> -/* This program is distributed in the hope that it will be useful,	      */
> -/* but WITHOUT ANY WARRANTY;  without even the implied warranty of	      */
> -/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See		      */
> -/* the GNU General Public License for more details.			      */
> -/*									      */
> -/* You should have received a copy of the GNU General Public License	      */
> -/* along with this program;  if not, write to the Free Software		      */
> +/* the Free Software Foundation; either version 2 of the License, or          */
> +/* (at your option) any later version.                                        */
> +/*                                                                            */
> +/* This program is distributed in the hope that it will be useful,            */
> +/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
> +/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
> +/* the GNU General Public License for more details.                           */
> +/*                                                                            */
> +/* You should have received a copy of the GNU General Public License          */
> +/* along with this program;  if not, write to the Free Software               */
>  /* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    */
> -/*									      */
> +/*                                                                            */
>  /******************************************************************************/
>  /******************************************************************************/
> -/*									      */
> -/* File:	rt_sigprocmask01.c					      */
> -/*									      */
> -/* Description: This tests the rt_sigprocmask() syscall			      */
> +/*                                                                            */
> +/* File:        rt_sigprocmask01.c                                              */
> +/*                                                                            */
> +/* Description: This tests the rt_sigprocmask() syscall                       */
>  /*		rt_sigprocmask changes the list of currently blocked signals. */
>  /*		The set value stores the signal mask of the pending signals.  */
>  /*		The previous action on the signal is saved in oact. The value */
> @@ -37,170 +37,211 @@
>  /*		SIG_SETMASK						      */
>  /*		    The set of blocked signals is set to the set argument.    */
>  /*		    sigsetsize should indicate the size of a sigset_t type.   */
> -/*									      */
> -/* Usage:  <for command-line>						      */
> -/* rt_sigprocmask01 [-c n] [-e][-i n] [-I x] [-p x] [-t]		      */
> -/*      where,  -c n : Run n copies concurrently.			      */
> -/*	      -e   : Turn on errno logging.				      */
> -/*	      -i n : Execute test n times.				      */
> -/*	      -I x : Execute test for x seconds.			      */
> -/*	      -P x : Pause for x seconds between iterations.		      */
> -/*	      -t   : Turn on syscall timing.				      */
> -/*									      */
> -/* Total Tests: 1							      */
> -/*									      */
> -/* Test Name:   rt_sigprocmask01					      */
> -/* History:     Porting from Crackerjack to LTP is done by		      */
> -/*	      Manas Kumar Nayak maknayak@in.ibm.com>			      */
> +/*                                                                            */
> +/* Usage:  <for command-line>                                                 */
> +/* rt_sigprocmask01 [-c n] [-e][-i n] [-I x] [-p x] [-t]                      */
> +/*      where,  -c n : Run n copies concurrently.                             */
> +/*              -e   : Turn on errno logging.                                 */
> +/*              -i n : Execute test n times.                                  */
> +/*              -I x : Execute test for x seconds.                            */
> +/*              -P x : Pause for x seconds between iterations.                */
> +/*              -t   : Turn on syscall timing.                                */
> +/*                                                                            */
> +/* Total Tests: 1                                                             */
> +/*                                                                            */
> +/* Test Name:   rt_sigprocmask01                                              */
> +/* History:     Porting from Crackerjack to LTP is done by                    */
> +/*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
>  /******************************************************************************/
>  #include <stdio.h>
> +#include <signal.h>
>  #include <errno.h>
> 
>  /* Harness Specific Include Files. */
> -#include "ltp_signal.h"
>  #include "test.h"
>  #include "usctest.h"
>  #include "linux_syscall_numbers.h"
> 
> +#ifdef __x86_64__
> +#include "rt_signal.h"
> +#endif
> +
> +#define TEST_SIG SIGRTMIN
> +
>  /* Extern Global Variables */
> -extern int Tst_count;	   /* counter for tst_xxx routines.	 	      */
> -extern char *TESTDIR;	   /* temporary dir created by tst_tmpdir()	      */
> +extern int Tst_count;           /* counter for tst_xxx routines.         */
> +extern char *TESTDIR;           /* temporary dir created by tst_tmpdir() */
> 
>  /* Global Variables */
> -char *TCID = "rt_sigprocmask01";	/* Test program identifier.	      */
> -int  TST_TOTAL = 8;			/* total number of tests in this file.*/
> +char *TCID = "rt_sigprocmask01";  /* Test program identifier.*/
> +int  testno;
> +int  TST_TOTAL = 8;                   /* total number of tests in this file.   */
> 
>  /* Extern Global Functions */
>  /******************************************************************************/
> -/*									      */
> -/* Function:    cleanup							      */
> -/*									      */
> +/*                                                                            */
> +/* Function:    cleanup                                                       */
> +/*                                                                            */
>  /* Description: Performs all one time clean up for this test on successful    */
> -/*	      completion,  premature exit or  failure. Closes all temporary   */
> -/*	      files, removes all temporary directories exits the test with    */
> -/*	      appropriate return code by calling tst_exit() function.	      */
> -/*									      */
> -/* Input:       None.							      */
> -/*									      */
> -/* Output:      None.							      */
> -/*									      */
> +/*              completion,  premature exit or  failure. Closes all temporary */
> +/*              files, removes all temporary directories exits the test with  */
> +/*              appropriate return code by calling tst_exit() function.       */
> +/*                                                                            */
> +/* Input:       None.                                                         */
> +/*                                                                            */
> +/* Output:      None.                                                         */
> +/*                                                                            */
>  /* Return:      On failure - Exits calling tst_exit(). Non '0' return code.   */
> -/*	      On success - Exits calling tst_exit(). With '0' return code.    */
> -/*									      */
> +/*              On success - Exits calling tst_exit(). With '0' return code.  */
> +/*                                                                            */
>  /******************************************************************************/
>  extern void cleanup() {
> -	/* Remove tmp dir and all files in it */
> -	TEST_CLEANUP;
> -	tst_rmdir();
> +        /* Remove tmp dir and all files in it */
> +        TEST_CLEANUP;
> +        tst_rmdir();
> 
> -	/* Exit with appropriate return code. */
> -	tst_exit();
> +        /* Exit with appropriate return code. */
> +        tst_exit();
>  }
> 
>  /* Local  Functions */
>  /******************************************************************************/
> -/*									      */
> -/* Function:    setup							      */
> -/*									      */
> +/*                                                                            */
> +/* Function:    setup                                                         */
> +/*                                                                            */
>  /* Description: Performs all one time setup for this test. This function is   */
> -/*	      typically used to capture signals, create temporary dirs	      */
> -/*	      and temporary files that may be used in the course of this      */
> -/*	      test.							      */
> -/*									      */
> -/* Input:       None.							      */
> -/*									      */
> -/* Output:      None.							      */
> -/*									      */
> -/* Return:      On failure - Exits by calling cleanup().		      */
> -/*	      On success - returns 0.					      */
> -/*									      */
> +/*              typically used to capture signals, create temporary dirs      */
> +/*              and temporary files that may be used in the course of this    */
> +/*              test.                                                         */
> +/*                                                                            */
> +/* Input:       None.                                                         */
> +/*                                                                            */
> +/* Output:      None.                                                         */
> +/*                                                                            */
> +/* Return:      On failure - Exits by calling cleanup().                      */
> +/*              On success - returns 0.                                       */
> +/*                                                                            */
>  /******************************************************************************/
>  void setup() {
> -	/* Capture signals if any */
> -	/* Create temporary directories */
> -	TEST_PAUSE;
> -	tst_tmpdir();
> +        /* Capture signals if any */
> +        /* Create temporary directories */
> +        TEST_PAUSE;
> +        tst_tmpdir();
>  }
> 
>  int sig_count = 0;
> 
>  void sig_handler(int sig)
>  {
> -	sig_count++;
> +        sig_count++;
>  }
> 
>  int main(int ac, char **av) {
> -	struct sigaction act, oact;
> -	sigset_t set, oset;
> -	int lc;		 /* loop counter */
> -	char *msg;	      /* message returned from parse_opts */
> +#ifdef __x86_64__
> +	struct kernel_sigaction act, oact;
> +	sig_initial(TEST_SIG);
> +	act.sa_flags |= SA_RESTORER;
> +        act.sa_restorer = restore_rt;
> +        act.k_sa_handler = sig_handler;
> +#else
> +        struct sigaction act, oact;
> +        act.sa_handler = sig_handler;
> +#endif
> +        sigset_t set, oset;
> +        int lc;                 /* loop counter */
> +        char *msg;              /* message returned from parse_opts */
>  	
> -	/* parse standard options */
> -	if ((msg = parse_opts(ac, av, (option_t *)NULL, NULL)) != (char *)NULL){
> -		tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
> -		tst_exit();
> -	}
> -
> -	setup();
> -
> -	Tst_count = 0;
> -	TEST(sigemptyset(&set));
> -	if (TEST_RETURN == -1) {
> -		tst_resm(TFAIL | TTERRNO, "sigemptyset() failed");
> -		cleanup();
> -		tst_exit();
> -	}
> -	TEST(sigaddset(&set, SIGRTMIN));
> -	if (TEST_RETURN == -1){
> -		tst_resm(TFAIL | TTERRNO, "sigaddset() failed");
> -		cleanup();
> -		tst_exit();
> -	}
> -	
> -	/* call rt_sigaction() */
> -	act.sa_handler = sig_handler;
> -	TEST(syscall(__NR_rt_sigaction, SIGRTMIN, &act, &oact,
> -		SIGSETSIZE));
> -	if (TEST_RETURN != 0){
> -		tst_resm(TFAIL | TTERRNO,"rt_sigaction() failed");
> -	}
> -	/* call rt_sigprocmask() to block signal # SIGRTMIN */
> -	TEST(syscall(__NR_rt_sigprocmask, SIG_BLOCK, &set, &oset, SIGSETSIZE));
> -	if (TEST_RETURN == -1) {
> -		tst_brkm(TFAIL | TTERRNO, cleanup, "rt_sigprocmask() failed");
> -	}
> -	TEST(kill(getpid(), SIGRTMIN));
> -	if (TEST_RETURN != 0){
> -		tst_brkm(TFAIL | TTERRNO, cleanup, "kill() failed");
> -	}
> -	if (sig_count) {
> -		tst_brkm(TFAIL | TTERRNO, cleanup,
> -			"rt_sigprocmask() failed to change the "
> -			"process's signal mask");
> -	}
> -	/* call rt_sigpending() */
> -	TEST(syscall(__NR_rt_sigpending, &oset, SIGSETSIZE));
> -	if (TEST_RETURN == -1) {
> -		tst_brkm(TFAIL | TTERRNO, cleanup, "rt_sigpending() failed");
> -	}
> -	TEST(sigismember(&oset, SIGRTMIN));
> -	if (TEST_RETURN == 0) {
> -		tst_brkm(TFAIL | TTERRNO, cleanup, "sigismember() failed");
> -	}
> -	/* call rt_sigprocmask() to unblock signal#33 */
> -	TEST(syscall(__NR_rt_sigprocmask, SIG_UNBLOCK, &set, &oset, SIGSETSIZE));
> -	if (TEST_RETURN == -1) {
> -		tst_brkm(TFAIL | TTERRNO, cleanup, "rt_sigprocmask() failed");
> -	}
> -	if (sig_count) {
> -		tst_resm(TPASS, "rt_sigprocmask() PASSED");
> -	} else {
> -		tst_resm(TFAIL | TTERRNO,
> -			"rt_sigprocmask() "
> -			"functionality failed");
> -	}
> -
> -	cleanup();
> -	tst_exit();
> +        /* parse standard options */
> +        if ((msg = parse_opts(ac, av, (option_t *)NULL, NULL)) != (char *)NULL){
> +             tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
> +             tst_exit();
> +           }
> +
> +        setup();
> 
> +        /* Check looping state if -i option given */
> +        for (lc = 0; TEST_LOOPING(lc); ++lc) {
> +                Tst_count = 0;
> +                for (testno = 0; testno < TST_TOTAL; ++testno) {
> +			TEST(sigemptyset(&set));
> +			if(TEST_RETURN == -1){
> +				tst_resm(TFAIL,"Call to sigemptyset() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> +                        	cleanup();
> +				tst_exit();
> +			}
> +			TEST(sigaddset(&set, TEST_SIG));
> +			if(TEST_RETURN == -1){
> +				tst_resm(TFAIL,"Call to sigaddset() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> +                        	cleanup();
> +				tst_exit();
> +			}
> +				
> +			/* call rt_sigaction() */
> +                        TEST(syscall(__NR_rt_sigaction, TEST_SIG, &act, &oact, 8));
> +			if(TEST_RETURN != 0){
> +				tst_resm(TFAIL,"Call to rt_sigaction() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> +                        	cleanup();
> +				tst_exit();
> +			}
> +			/* call rt_sigprocmask() to block signal#SIGRTMIN */
> +                        TEST(syscall(__NR_rt_sigprocmask, SIG_BLOCK, &set, &oset, 8));
> +			if(TEST_RETURN == -1){
> +				tst_resm(TFAIL,"Call to rt_sigprocmask()**** Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> +                        	cleanup();
> +				tst_exit();
> +			}
> +			
> +			else {
> +				TEST(kill(getpid(), TEST_SIG));
> +				if(TEST_RETURN != 0){
> +					tst_resm(TFAIL,"Call to kill() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> +                        		cleanup();
> +					tst_exit();
> +					
> +				}
> +				if(sig_count){
> +					tst_resm(TFAIL,"FAIL --- rt_sigprocmask() fail to change the process's signal mask, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> +                        		cleanup();
> +					tst_exit();
> +				}
> +				else {
> +					/* call rt_sigpending() */
> +					TEST(syscall(__NR_rt_sigpending, &oset, 8));
> +					if(TEST_RETURN == -1){
> +						tst_resm(TFAIL,"call rt_sigpending() failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> +                        			cleanup();
> +						tst_exit();
> +					}
> +					TEST(sigismember(&oset, TEST_SIG));
> +					if(TEST_RETURN == 0 ){
> +						tst_resm(TFAIL,"call sigismember() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> +                        			cleanup();
> +						tst_exit();
> +					}
> +					/* call rt_sigprocmask() to unblock signal#SIGRTMIN */
> +					TEST(syscall(__NR_rt_sigprocmask, SIG_UNBLOCK, &set, &oset, 8));
> +					if(TEST_RETURN == -1){
> +						tst_resm(TFAIL,"Call to rt_sigprocmask() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> +                        			cleanup();
> +						tst_exit();
> +					}
> +					if(sig_count) {
> +						tst_resm(TPASS,"rt_sigprocmask() PASSED");
> +                        			cleanup();
> +						tst_exit();
> +					}
> +		                        else {
> +						tst_resm(TFAIL,"rt_sigprocmask() functionality failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> +		                                cleanup();
> +						tst_exit();
> +		                        }
> +
> +				}
> +			}
> +
> +                }
> +	Tst_count++;
> +        }	
> +        tst_exit();
>  }
> +
> diff --git a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
> index fcb5b0b..84f2967 100644
> --- a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
> +++ b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
> @@ -18,12 +18,12 @@
>  /******************************************************************************	*/
>  /******************************************************************************	*/
>  /*                                                                            	*/
> -/* File:        rt_sigsuspend01.c                                           	*/
> +/* File:        rt_sigsuspend01.c                                           	      	*/
>  /*                                                                            	*/
> -/* Description: This tests the rt_sigsuspend() syscall.                      	*/
> +/* Description: This tests the rt_sigsuspend() syscall.                      	      	*/
>  /*		                                                               	*/
>  /* Usage:  <for command-line>                                                 	*/
> -/* rt_sigsuspend01 [-c n] [-e][-i n] [-I x] [-p x] [-t]                     	*/
> +/* rt_sigsuspend01 [-c n] [-e][-i n] [-I x] [-p x] [-t]                     		*/
>  /*      where,  -c n : Run n copies concurrently.                             	*/
>  /*              -e   : Turn on errno logging.                                 	*/
>  /*              -i n : Execute test n times.                                  	*/
> @@ -33,15 +33,11 @@
>  /*                                                                            	*/
>  /* Total Tests: 2                                                             	*/
>  /*                                                                            	*/
> -/* Test Name:   rt_sigsuspend01                                             	*/
> +/* Test Name:   rt_sigsuspend01                                             		*/
>  /* History:     Porting from Crackerjack to LTP is done by                    	*/
>  /*              Manas Kumar Nayak maknayak@in.ibm.com>                        	*/
>  /********************************************************************************/
> 
> -#ifndef _GNU_SOURCE
> -#define _GNU_SOURCE
> -#endif
> -
>  #include <stdio.h>
>  #include <signal.h>
>  #include <errno.h>
> @@ -50,16 +46,19 @@
>  #include "test.h"
>  #include "usctest.h"
>  #include "linux_syscall_numbers.h"
> -#include "ltp_signal.h"
> +
> +#ifdef __x86_64__
> +#include "rt_signal.h"
> +#endif
> 
>  /* Extern Global Variables */
> -extern int Tst_count;            /* counter for tst_xxx routines.         */
> -extern char *TESTDIR;            /* temporary dir created by tst_tmpdir() */
> +extern int Tst_count;           /* counter for tst_xxx routines.         */
> +extern char *TESTDIR;           /* temporary dir created by tst_tmpdir() */
> 
>  /* Global Variables */
>  char *TCID = "rt_sigsuspend01";  /* Test program identifier.*/
>  int  testno;
> -int  TST_TOTAL = 4;              /* total number of tests in this file.   */
> +int  TST_TOTAL =4;                   /* total number of tests in this file.   */
> 
>  /* Extern Global Functions */
>  /******************************************************************************/
> @@ -69,20 +68,23 @@ int  TST_TOTAL = 4;              /* total number of tests in this file.   */
>  /* Description: Performs all one time clean up for this test on successful    */
>  /*              completion,  premature exit or  failure. Closes all temporary */
>  /*              files, removes all temporary directories exits the test with  */
> -/*              appropriate return code by calling tst_exit() function.       */
> +/*              appropriate TEST_RETURNurn code by calling tst_exit() function.       */
>  /*                                                                            */
>  /* Input:       None.                                                         */
>  /*                                                                            */
>  /* Output:      None.                                                         */
>  /*                                                                            */
> -/* Return:      On failure - Exits calling tst_exit(). Non '0' return code.   */
> -/*              On success - Exits calling tst_exit(). With '0' return code.  */
> +/* Return:      On failure - Exits calling tst_exit(). Non '0' TEST_RETURNurn code.   */
> +/*              On success - Exits calling tst_exit(). With '0' TEST_RETURNurn code.  */
>  /*                                                                            */
>  /******************************************************************************/
> -void cleanup() {
> -	/* Remove tmp dir and all files in it */
> -	TEST_CLEANUP;
> -	tst_rmdir();
> +extern void cleanup() {
> +        /* Remove tmp dir and all files in it */
> +        TEST_CLEANUP;
> +        tst_rmdir();
> +
> +        /* Exit with appropriate TEST_RETURNurn code. */
> +        tst_exit();
>  }
> 
>  /* Local  Functions */
> @@ -100,14 +102,14 @@ void cleanup() {
>  /* Output:      None.                                                         */
>  /*                                                                            */
>  /* Return:      On failure - Exits by calling cleanup().                      */
> -/*              On success - Returns 0.					      */
> +/*              On success - TEST_RETURNurns 0.                                       */
>  /*                                                                            */
>  /******************************************************************************/
>  void setup() {
> -/* Capture signals if any */
> -/* Create temporary directories */
> -TEST_PAUSE;
> -tst_tmpdir();
> +        /* Capture signals if any */
> +        /* Create temporary directories */
> +        TEST_PAUSE;
> +        tst_tmpdir();
>  }
> 
> 
> @@ -120,55 +122,77 @@ void sig_handler(int sig)
>  int main(int ac, char **av) {
>  	
>  	sigset_t set, set1, set2;
> -	char *msg;		/* message returned from parse_opts */
> +	int lc;                 /* loop counter */
> +        char *msg;              /* message TEST_RETURNurned from parse_opts */
>  	
> -	/* parse standard options */
> -	if ((msg = parse_opts(ac, av, (option_t *)NULL, NULL)) != (char *)NULL){
> -		tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
> -		tst_exit();
> -	}
> -
> -	setup();
> -
> -	Tst_count = 0;
> -	TEST(sigemptyset(&set));
> -	if (TEST_RETURN == -1){
> -		tst_brkm(TFAIL | TTERRNO, cleanup, "sigemptyset() failed");
> -	}
> -	struct sigaction act, oact;
> -	act.sa_handler = sig_handler;
> -			
> -	TEST(syscall(__NR_rt_sigaction, SIGALRM, &act, &oact, SIGSETSIZE));
> -	if (TEST_RETURN == -1){
> -	       	tst_brkm(TFAIL | TTERRNO, cleanup, "rt_sigaction() failed");
> -	}
> -	TEST(syscall(__NR_rt_sigprocmask, SIG_UNBLOCK, 0, &set1, SIGSETSIZE));
> -	if (TEST_RETURN == -1){
> -		tst_brkm(TFAIL | TTERRNO, cleanup, "rt_sigprocmask() failed");
> -		cleanup();
> -		tst_exit();
> -	}
> +        /* parse standard options */
> +        if ((msg = parse_opts(ac, av, (option_t *)NULL, NULL)) != (char *)NULL){
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
> +			TEST(sigemptyset(&set));
> +			if(TEST_RETURN == -1){
> +				tst_resm(TFAIL,"sigemptyset() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> +				cleanup();
> +				tst_exit();
> +			}
> +#ifdef __x86_64__
> +		        struct kernel_sigaction act, oact;
> +			sig_initial(SIGALRM);
> +			act.sa_flags |= SA_RESTORER;
> +			act.sa_restorer = restore_rt;
> +			act.k_sa_handler = sig_handler;			
> +#else
> +			struct sigaction act, oact;
> +		        act.sa_handler = sig_handler;
> +#endif
> +			TEST(syscall(__NR_rt_sigaction, SIGALRM, &act, &oact, 8));
> +			if(TEST_RETURN == -1){
> +		        	tst_resm(TFAIL,"rt_sigaction() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> +				cleanup();
> +				tst_exit();
> +			}
> +			TEST(syscall(__NR_rt_sigprocmask, SIG_UNBLOCK, 0, &set1, 8));
> +			if(TEST_RETURN == -1){
> +		        	tst_resm(TFAIL,"rt_sigprocmask() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> +				cleanup();
> +				tst_exit();
> +			}
>  			
> -	TEST(alarm(5));
> -	int result;
> -	TEST(result = syscall(__NR_rt_sigsuspend, &set, SIGSETSIZE));
> -	TEST(alarm(0));
> -	if (result == -1 && TEST_ERRNO != EINTR) {
> -		TEST(syscall(__NR_rt_sigprocmask, SIG_UNBLOCK, 0, &set2,
> -				SIGSETSIZE));
> -		if (TEST_RETURN == -1) {
> -			tst_resm(TFAIL | TTERRNO, "rt_sigprocmask() failed");
> -		} else if (set1.__val[0] != set2.__val[0]) {
> -			tst_resm(TFAIL | TTERRNO,
> -				"rt_sigsuspend failed to preserve signal mask");
> -	        } else {
> -			tst_resm(TPASS, "rt_sigsuspend PASSED");
> -		}
> -	} else {
> -		tst_resm(TFAIL | TTERRNO, "rt_sigsuspend failed");
> -	}
> -
> +			TEST(alarm(5));
> +		        int result;
> +			TEST(result = syscall(__NR_rt_sigsuspend, &set, 8));
> +		        TEST(alarm(0));
> +			if((result == -1) && (TEST_ERRNO != EINTR)){
> +				TEST(syscall(__NR_rt_sigprocmask, SIG_UNBLOCK, 0, &set2, 8));
> +				if(TEST_RETURN == -1){
> +		        		tst_resm(TFAIL,"rt_sigprocmask() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> +					cleanup();
> +					tst_exit();
> +				} else if(set1.__val[0] != set2.__val[0]){
> +		                        tst_resm(TFAIL," rt_sigsuspend failed to preserve signal mask,errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> +					cleanup();
> +					tst_exit();
> +			        } else {
> +		                        tst_resm(TPASS,"rt_sigsuspend PASSED");
> +		                }
> +		        }else{
> +		             tst_resm(TFAIL," rt_sigsuspend failed ,errrno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> +	                     cleanup();
> +			     tst_exit();
> +			}
> +		
> +	
> +                }
> +	 }
>  	cleanup();
> -	tst_exit();
> -
> +        tst_exit();
>  }
> +
> -- 
> 1.6.2.2
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> ------------------------------------------------------------------------------
> Return on Information:
> Google Enterprise Search pays you back
> Get the facts.
> http://p.sf.net/sfu/google-dev2dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
