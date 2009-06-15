Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MGIxH-0002nn-Ls
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2009 20:38:59 +0000
Received: from [32.97.110.151] (helo=e33.co.us.ibm.com)
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MGHgT-0007qj-5O
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2009 19:17:34 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5FJEeNn009933
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Jun 2009 13:14:40 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5FJGe2A119648
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Jun 2009 13:16:42 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5FJGebS007651
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Jun 2009 13:16:40 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090612175204.26047.43781.sendpatchset@subratamodak.linux.ibm.com>
References: <20090612175132.26047.54266.sendpatchset@subratamodak.linux.ibm.com>
	<20090612175204.26047.43781.sendpatchset@subratamodak.linux.ibm.com>
Date: Tue, 16 Jun 2009 00:46:02 +0530
Message-Id: <1245093362.4871.43.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH 02/05] Add/Port sched_getaffinity01 test
	for	sched_getaffinity() syscall
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
To: Manas Kumar Nayak <maknayak@in.ibm.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On Fri, 2009-06-12 at 23:22 +0530, Manas Kumar Nayak wrote: 
> Signed-off-by: Manas Kumar Nayak <maknayak@in.ibm.com>

Thanks.

Regards--
Subrata

> To: LTP List <ltp-list@lists.sourceforge.net>
> Cc: Subrata Modak <subrata@linux.vnet.ibm.com>
> Cc: Masatake YAMATO <yamato@redhat.com>
> ---
> 
> --- ltp-full-20090531.orig/testcases/kernel/syscalls/sched_getaffinity/Makefile	1970-01-01 05:30:00.000000000 +0530
> +++ ltp-full-20090531/testcases/kernel/syscalls/sched_getaffinity/Makefile	2009-03-29 16:54:46.000000000 +0530
> @@ -0,0 +1,31 @@
> +#
> +#  Copyright (c) International Business Machines  Corp., 2009
> +#
> +#  This program is free software;  you can redistribute it and/or modify
> +#  it under the terms of the GNU General Public License as published by
> +#  the Free Software Foundation; either version 2 of the License, or
> +#  (at your option) any later version.
> +#
> +#  This program is distributed in the hope that it will be useful,
> +#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
> +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> +#  the GNU General Public License for more details.
> +#
> +#  You should have received a copy of the GNU General Public License
> +#  along with this program;  if not, write to the Free Software
> +#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +#
> +
> +CFLAGS += -I../../../../include -Wall
> +LDLIBS += -L../../../../lib -lltp
> +
> +SRCS    = $(wildcard *.c)
> +TARGETS = $(patsubst %.c,%,$(SRCS))
> +
> +all: $(TARGETS)
> +
> +install:
> +	@set -e; for i in $(TARGETS); do ln -f $$i ../../../bin/$$i ; done
> +
> +clean:
> +	rm -f $(TARGETS)
> --- ltp-full-20090531.orig/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c	1970-01-01 05:30:00.000000000 +0530
> +++ ltp-full-20090531/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c	2009-06-12 20:57:03.000000000 +0530
> @@ -0,0 +1,197 @@
> +/******************************************************************************/
> +/* Copyright (c) Crackerjack Project., 2007                                   */
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
> +/******************************************************************************/
> +/******************************************************************************/
> +/*                                                                            */
> +/* File:        sched_getaffinity01.c                                         */
> +/*                                                                            */
> +/* Description: This tests the sched_getaffinity() syscall                    */
> +/*                                                                            */
> +/* Usage:  <for command-line>                                                 */
> +/* sched_getaffinity01 [-c n] [-e][-i n] [-I x] [-p x] [-t]                   */
> +/*      where,  -c n : Run n copies concurrently.                             */
> +/*              -e   : Turn on errno logging.                                 */
> +/*              -i n : Execute test n times.                                  */
> +/*              -I x : Execute test for x seconds.                            */
> +/*              -P x : Pause for x seconds between iterations.                */
> +/*              -t   : Turn on syscall timing.                                */
> +/*                                                                            */
> +/* Total Tests: 1                                                             */
> +/*                                                                            */
> +/* Test Name:   sched_getaffinity01                                           */
> +/* History:     Porting from Crackerjack to LTP is done by                    */
> +/*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
> +/******************************************************************************/
> +#include<stdlib.h>
> +#include<stdio.h>
> +#include<sys/types.h>
> +#include<unistd.h>
> +#define _GNU_SOURCE 
> +#define __USE_GNU
> +#include<sched.h>
> +#include<string.h>
> +#include <errno.h>
> +
> +/* Harness Specific Include Files. */
> +#include "test.h"
> +#include "usctest.h"
> +#include "linux_syscall_numbers.h"
> +
> +/* Extern Global Variables */
> +extern int Tst_count;           /* counter for tst_xxx routines.         */
> +extern char *TESTDIR;           /* temporary dir created by tst_tmpdir() */
> +
> +/* Global Variables */
> +char *TCID = "sched_getaffinity01";  /* Test program identifier.*/
> +int  testno;
> +int  TST_TOTAL = 1;                   /* total number of tests in this file.   */
> +
> +/* Extern Global Functions */
> +/******************************************************************************/
> +/*                                                                            */
> +/* Function:    cleanup                                                       */
> +/*                                                                            */
> +/* Description: Performs all one time clean up for this test on successful    */
> +/*              completion,  premature exit or  failure. Closes all temporary */
> +/*              files, removes all temporary directories exits the test with  */
> +/*              appropriate return code by calling tst_exit() function.       */
> +/*                                                                            */
> +/* Input:       None.                                                         */
> +/*                                                                            */
> +/* Output:      None.                                                         */
> +/*                                                                            */
> +/* Return:      On failure - Exits calling tst_exit(). Non '0' return code.   */
> +/*              On success - Exits calling tst_exit(). With '0' return code.  */
> +/*                                                                            */
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
> +/*                                                                            */
> +/* Function:    setup                                                         */
> +/*                                                                            */
> +/* Description: Performs all one time setup for this test. This function is   */
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
> +/******************************************************************************/
> +void setup() {
> +        /* Capture signals if any */
> +        /* Create temporary directories */
> +        TEST_PAUSE;
> +        tst_tmpdir();
> +}
> +
> +int errnochoose(void)  // choose the relative errno
> +{
> +        switch errno
> +        {
> +                case EFAULT: 
> +			perror("EFAULT");
> +                        break;
> +                case EINVAL: perror("EINVAL");
> +                        break;
> +                case EPERM: perror("EPERM");
> +                        break;
> +                case ESRCH: perror("ESRCH");
> +                        break;
> +                default: perror("other errno");
> +                        break;
> +        }
> +        return 0 ;
> +}
> +
> +
> +int main(int ac, char **av) {
> +        int lc,num,i;                 /* loop counter */
> +        char *msg;              /* message returned from parse_opts */
> +	cpu_set_t mask;
> +	unsigned int len = sizeof(cpu_set_t);
> +
> +	
> +        /* parse standard options */
> +        if ((msg = parse_opts(ac, av, (option_t *)NULL, NULL)) != (char *)NULL){
> +             tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
> +             tst_exit();
> +           }
> +
> +        setup();
> +
> +	TEST(num=sysconf(_SC_NPROCESSORS_CONF));  //the number of processor(s)
> +        tst_resm(TINFO,"system has %d processor(s).", num);
> +
> +        /* Check looping state if -i option given */
> +        for (lc = 0; TEST_LOOPING(lc); ++lc) {
> +                Tst_count = 0;
> +                for (testno = 0; testno < TST_TOTAL; ++testno) {
> +                     TEST(sched_getaffinity(0,len,(cpu_set_t *)-1));     //call sched_getaffinity()
> +                     if(TEST_RETURN == -1) {
> +			errnochoose();
> +                     }
> +		
> +                     TEST(sched_getaffinity(0,0,&mask));     //call sched_getaffinity()
> +                     if(TEST_RETURN == -1) {
> +			errnochoose();
> +                     }
> +
> +                     TEST(sched_getaffinity(getpid()+1,len,&mask));     //call sched_getaffinity()
> +                     if(TEST_RETURN == -1) {
> +			errnochoose();
> +                     }
> +			
> +		     CPU_ZERO(&mask); //clear
> +                     TEST(sched_getaffinity(0,len,&mask));     //call sched_getaffinity()
> +		     if(TEST_RETURN == -1) {
> +                 	   tst_resm(TFAIL, "%s failed -could not get cpu affinity errno = %d : %s", TCID, TEST_ERRNO, strerror(TEST_ERRNO));
> +			errnochoose();
> +			cleanup();
> +			tst_exit();
> +                     } else {
> +				tst_resm(TINFO,"cpusetsize is %d cpu_set_t mask is %d",len,mask);
> +				tst_resm(TINFO,"mask.__bits[0] = %lu ",mask.__bits[0]);
> +				for(i=0;i<num;i++){    // check the processor
> +	                        	TEST(CPU_ISSET(i,&mask));
> +					if (TEST_RETURN != -1 ){
> +                                	tst_resm(TPASS,"sched_getaffinity() succeed ,this process %d is running processor: %d",getpid(), i);
> +					}
> +			        }
> +	                    }
> +
> +
> +                     }
> +		}
> +        cleanup();
> +	tst_exit();
> +}
> +
> --- ltp-full-20090531.orig/runtest/syscalls	2009-06-12 21:02:30.000000000 +0530
> +++ ltp-full-20090531/runtest/syscalls	2009-06-12 20:58:25.000000000 +0530
> @@ -837,6 +837,8 @@ sched_setscheduler02 sched_setscheduler0
> 
>  sched_yield01 sched_yield01
> 
> +sched_getaffinity01 sched_getaffinity01
> +
>  select01 select01
>  select02 select02
>  select03 select03
> 
> ---
> Regards--
> Manas
> 


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
