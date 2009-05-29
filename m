Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MA1eD-0000mj-I5
	for ltp-list@lists.sourceforge.net; Fri, 29 May 2009 12:57:21 +0000
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MA1eC-00031b-Is
	for ltp-list@lists.sourceforge.net; Fri, 29 May 2009 12:57:21 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4TCxqAZ003493
	for <ltp-list@lists.sourceforge.net>; Fri, 29 May 2009 08:59:52 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4TCvKrv151850
	for <ltp-list@lists.sourceforge.net>; Fri, 29 May 2009 08:57:20 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4TCvJJH014487
	for <ltp-list@lists.sourceforge.net>; Fri, 29 May 2009 08:57:20 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090527101228.18638.22844.sendpatchset@subratamodak.linux.ibm.com>
References: <20090527100645.18638.75163.sendpatchset@subratamodak.linux.ibm.com>
	<20090527101228.18638.22844.sendpatchset@subratamodak.linux.ibm.com>
Date: Fri, 29 May 2009 18:27:15 +0530
Message-Id: <1243601835.5188.54.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH 12/13] Add/Port unshare01 test for unshare()
	syscall
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

On Wed, 2009-05-27 at 15:42 +0530, Manas Kumar Nayak wrote: 
> Signed-off-by: Manas Kumar Nayak <maknayak@in.ibm.com>

Thanks.

Regards--
Subrata

> To: LTP List <ltp-list@lists.sourceforge.net>
> Cc: Subrata Modak <subrata@linux.vnet.ibm.com>
> Cc: Masatake YAMATO <yamato@redhat.com>
> ---
> 
> --- ltp-intermediate-20090521.orig/testcases/kernel/syscalls/unshare/Makefile	1970-01-01 05:30:00.000000000 +0530
> +++ ltp-intermediate-20090521/testcases/kernel/syscalls/unshare/Makefile	2009-05-25 15:12:47.000000000 +0530
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
> --- ltp-intermediate-20090521.orig/testcases/kernel/syscalls/unshare/unshare01.c	1970-01-01 05:30:00.000000000 +0530
> +++ ltp-intermediate-20090521/testcases/kernel/syscalls/unshare/unshare01.c	2009-05-27 14:43:04.000000000 +0530
> @@ -0,0 +1,231 @@
> +/********************************************************************************/
> +/* Copyright (c) Crackerjack Project., 2007                                   	*/
> +/*                                                                            	*/
> +/* This program is free software;  you can redistribute it and/or modify      	*/
> +/* it under the terms of the GNU General Public License as published by       	*/
> +/* the Free Software Foundation; either version 2 of the License, or          	*/
> +/* (at your option) any later version.                                        	*/
> +/*                                                                            	*/
> +/* This program is distributed in the hope that it will be useful,            	*/
> +/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            	*/
> +/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  	*/
> +/* the GNU General Public License for more details.                           	*/
> +/*                                                                            	*/
> +/* You should have received a copy of the GNU General Public License          	*/
> +/* along with this program;  if not, write to the Free Software               	*/
> +/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    	*/
> +/*                                                                            	*/
> +/******************************************************************************	*/
> +/******************************************************************************	*/
> +/*                                                                            	*/
> +/* File:        unshare01.c                                           	      	*/
> +/*                                                                            	*/
> +/* Description: This tests the unshare() syscall.                      	      	*/
> +/*             unshare() allows a process to disassociate parts of its 		*/
> +/*		execution context that are currently being shared with other 	*/
> +/*		processes. Part of the execution context, such as the namespace	*/
> +/*		,is shared implicitly when a new process is created using 	*/
> +/*		fork(2) or vfork(2), while other parts, such as virtual memory	*/
> +/*		, may be shared by explicit request when creating a process 	*/
> +/*		using clone(2).							*/
> +/*										*/
> +/*		The main use of unshare() is to allow a process to control its	*/ 
> +/*		shared execution context without creating a new process.	*/
> +/*	         								*/
> +/*										*/
> +/*		The flags argument is a bit mask that specifies which parts of	*/
> +/*		the execution context should be unshared. This argument is 	*/
> +/*		specified by ORing together zero or more of the following cons-	*/
> +/*		tants:								*/
> +/*										*/
> +/*		CLONE_FILES:							*/
> +/*		    	Reverse the effect of the clone(2) CLONE_FILES flag. 	*/
> +/*			Unshare	the file descriptor table, so that the calling 	*/
> +/*			process no longer shares its file descriptors with any 	*/
> +/*			other process.						*/
> +/*		CLONE_FS:							*/
> +/*			Reverse the effect of the clone(2) CLONE_FS flag.Unshare*/
> +/*			file system attributes, so that the calling process no 	*/
> +/*			longer shares its root directory, current directory, or	*/
> +/*			umask attributes with any other process.		*/
> +/*		CLONE_NEWNS:							*/
> +/*		       This flag has the same effect as the clone(2) CLONE_NEWNS*/ 
> +/*			flag. Unshare the namespace, so that the calling process*/ 
> +/*			has a private copy of its namespacei which is not shared*/
> +/*			with any other process. Specifying this flag automat-	*/
> +/*			ically implies CLONE_FS as well. 			*/
> +/*										*/
> +/*		If flags is specified as zero, then unshare() is a no-op; no 	*/
> +/*		changes are made to the calling process's execution context. 	*/
> +/*		                                                               	*/
> +/* Usage:  <for command-line>                                                 	*/
> +/* unshare01 [-c n] [-e][-i n] [-I x] [-p x] [-t]                     		*/
> +/*      where,  -c n : Run n copies concurrently.                             	*/
> +/*              -e   : Turn on errno logging.                                 	*/
> +/*              -i n : Execute test n times.                                  	*/
> +/*              -I x : Execute test for x seconds.                            	*/
> +/*              -P x : Pause for x seconds between iterations.                	*/
> +/*              -t   : Turn on syscall timing.                                	*/
> +/*                                                                            	*/
> +/* Total Tests: 1                                                             	*/
> +/*                                                                            	*/
> +/* Test Name:   unshare01                                             		*/
> +/* History:     Porting from Crackerjack to LTP is done by                    	*/
> +/*              Manas Kumar Nayak maknayak@in.ibm.com>                        	*/
> +/********************************************************************************/
> +
> +#include <stdio.h>
> +#include <sys/wait.h>
> +#include <sys/types.h>
> +#include <sched.h>
> +#include <limits.h>
> +#include <unistd.h>
> +#include <sys/types.h>
> +#include <sys/syscall.h>
> +#include <errno.h>
> +#include <pwd.h>
> +#include <grp.h>
> +#include <string.h>
> +#include <sys/param.h>
> +#include <stdio.h>
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
> +char *TCID = "unshare01";  /* Test program identifier.*/
> +int  testno;
> +int  TST_TOTAL =1;                   /* total number of tests in this file.   */
> +
> +/* Extern Global Functions */
> +/******************************************************************************/
> +/*                                                                            */
> +/* Function:    cleanup                                                       */
> +/*                                                                            */
> +/* Description: Performs all one time clean up for this test on successful    */
> +/*              completion,  premature exit or  failure. Closes all temporary */
> +/*              files, removes all temporary directories exits the test with  */
> +/*              appropriate TEST_RETURNurn code by calling tst_exit() function.       */
> +/*                                                                            */
> +/* Input:       None.                                                         */
> +/*                                                                            */
> +/* Output:      None.                                                         */
> +/*                                                                            */
> +/* Return:      On failure - Exits calling tst_exit(). Non '0' TEST_RETURNurn code.   */
> +/*              On success - Exits calling tst_exit(). With '0' TEST_RETURNurn code.  */
> +/*                                                                            */
> +/******************************************************************************/
> +extern void cleanup() {
> +        /* Remove tmp dir and all files in it */
> +        TEST_CLEANUP;
> +        tst_rmdir();
> +
> +        /* Exit with appropriate TEST_RETURNurn code. */
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
> +/*              On success - TEST_RETURNurns 0.                                       */
> +/*                                                                            */
> +/******************************************************************************/
> +void setup() {
> +        /* Capture signals if any */
> +        /* Create temporary directories */
> +        TEST_PAUSE;
> +        tst_tmpdir();
> +}
> +
> +int main(int ac, char **av) {
> +        pid_t pid1;
> +	int lc;                 /* loop counter */
> +        char *msg;              /* message TEST_RETURNurned from parse_opts */
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
> + /*
> + *fork a child process;testing which one is a child or a parent;
> + * */
> +		        TEST(pid1=fork());    //call to fork()
> +			if (TEST_RETURN == -1){
> +				tst_resm(TFAIL, "fork() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> +				cleanup();
> +				tst_exit();
> +			}else if (TEST_RETURN == 0){
> +				if((TEST_RETURN = unshare(CLONE_FILES)) == 0) {
> +	        		tst_resm(TPASS, "unshare with CLONE_FILES call succeeded");
> +				tst_exit();
> +				}else if (TEST_RETURN == -1 )
> +					tst_resm(TFAIL,"unshare Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> +					tst_exit();
> +			}else{
> +			}
> +
> +			TEST(pid1=fork());    //call to fork()
> +                        if (TEST_RETURN == -1){
> +                	        tst_resm(TFAIL, "fork() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> +	                        cleanup();
> +                        	tst_exit();
> +                        }else if (TEST_RETURN == 0){
> +                                if((TEST_RETURN = unshare(CLONE_FS)) == 0) {
> +                                	tst_resm(TPASS, "unshare with CLONE_FS call succeeded");
> +					tst_exit();
> +                                }else if (TEST_RETURN == -1 )
> +                                        tst_resm(TFAIL,"unshare Failed 2, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> +					tst_exit();
> +                        }else{
> +			}
> +
> +			TEST(pid1=fork());    //call to fork()
> +                        if (TEST_RETURN == -1){
> +                	        tst_resm(TFAIL, "fork() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> +	                        cleanup();
> +                        	tst_exit();
> +                        }else if (TEST_RETURN == 0){
> +                                if((TEST_RETURN = unshare(CLONE_NEWNS)) == 0) {
> +                                	tst_resm(TPASS, "unshare call with CLONE_NEWNS succeeded");
> +					tst_exit();
> +                                }else if (TEST_RETURN == -1 )
> +                                        tst_resm(TFAIL,"unshare Failed 2, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> +					tst_exit();
> +                        }else{
> +			}
> +
> +
> +                }
> +
> +                }
> +	cleanup();
> +	tst_exit();
> +}
> +
> --- ltp-intermediate-20090521.orig/runtest/syscalls	2009-05-27 14:45:49.000000000 +0530
> +++ ltp-intermediate-20090521/runtest/syscalls	2009-05-27 14:45:21.000000000 +0530
> @@ -1207,6 +1207,8 @@ unlink08 unlink08
>  #unlinkat test cases
>  unlinkat01 unlinkat01
> 
> +unshare01 unshare01
> +
>  #
>  # These tests require an unmounted block device
>  # to run correctly. Please see individual test
> 
> ---
> Regards--
> Manas
> 


------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
