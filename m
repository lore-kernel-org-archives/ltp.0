Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MGHhM-0004G4-AA
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2009 19:18:28 +0000
Received: from [32.97.182.142] (helo=e2.ny.us.ibm.com)
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MGHhL-0006h9-5Q
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2009 19:18:28 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5FJCPs7025606
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Jun 2009 15:12:25 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5FJH1aX181182
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Jun 2009 15:17:01 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5FJEiP5010355
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Jun 2009 15:14:44 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090612175252.26047.88904.sendpatchset@subratamodak.linux.ibm.com>
References: <20090612175132.26047.54266.sendpatchset@subratamodak.linux.ibm.com>
	<20090612175252.26047.88904.sendpatchset@subratamodak.linux.ibm.com>
Date: Tue, 16 Jun 2009 00:46:18 +0530
Message-Id: <1245093378.4871.47.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH 05/05] Add/Port quotactl01 test for quotactl()
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
> --- ltp-full-20090531.orig/testcases/kernel/syscalls/quotactl/Makefile	1970-01-01 05:30:00.000000000 +0530
> +++ ltp-full-20090531/testcases/kernel/syscalls/quotactl/Makefile	2009-06-12 21:44:37.000000000 +0530
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
> --- ltp-full-20090531.orig/testcases/kernel/syscalls/quotactl/quotactl01.c	1970-01-01 05:30:00.000000000 +0530
> +++ ltp-full-20090531/testcases/kernel/syscalls/quotactl/quotactl01.c	2009-06-12 22:51:19.000000000 +0530
> @@ -0,0 +1,168 @@
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
> +/* File:        quotactl01.c                                                  */
> +/*                                                                            */
> +/* Description: This tests the quotactl() syscall                             */
> +/*                                                                            */
> +/* Usage:  <for command-line>                                                 */
> +/* quotactl01 [-c n] [-e][-i n] [-I x] [-p x] [-t]                            */
> +/*      where,  -c n : Run n copies concurrently.                             */
> +/*              -e   : Turn on errno logging.                                 */
> +/*              -i n : Execute test n times.                                  */
> +/*              -I x : Execute test for x seconds.                            */
> +/*              -P x : Pause for x seconds between iterations.                */
> +/*              -t   : Turn on syscall timing.                                */
> +/*                                                                            */
> +/* Total Tests: 1                                                             */
> +/*                                                                            */
> +/* Test Name:   quotactl01                                                    */
> +/* History:     Porting from Crackerjack to LTP is done by                    */
> +/*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
> +/******************************************************************************/
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <sys/syscall.h>
> +#include <stdio.h>
> +#include <errno.h>
> +#include <linux/fs.h>
> +#include <sys/quota.h>
> +#include <sys/types.h>
> +
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
> +char *TCID = "quotactl01";  /* Test program identifier.*/
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
> +/*
> +*  WARNING!! This test may cause the potential harm to the system, we DO NOT
> +*  provide any warranty for the safety!!
> +*/
> +/*
> +* To use this testcase , the quota function must be turned on and the user must be * the super user
> +*/
> +
> +int cmd[] = {Q_QUOTAON, Q_QUOTAOFF, Q_GETQUOTA, Q_SETQUOTA, Q_GETINFO, Q_SETINFO, Q_GETFMT, Q_SYNC};
> +int retval = 0, id = 0, i = 0;
> +
> +int main(int ac, char **av) {
> +        int newtid = -1;
> +        int result;
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
> +		id = getuid();
> +                for (i = 0; i <= 7; i++){
> +                        TEST(retval = syscall(__NR_quotactl, cmd[i], (const char *)NULL, id, (caddr_t)NULL));
> +			if(TEST_RETURN != 0){
> +                 	   	tst_resm(TFAIL, "%s failed - errno = %d : %s ...cmderror=%s", TCID, TEST_ERRNO, strerror(TEST_ERRNO),cmd[i]);
> +                        }else{
> +        			tst_resm(TPASS, "quotactl call succeeded");
> +                        }
> +                }
> +	             TEST(result = syscall(258, &newtid));     //call quotactl()
> +                     if(TEST_RETURN == getpid()) {
> +                        cleanup();
> +                     }
> +                     else {
> +                           cleanup();
> +	  	           tst_exit();
> +                     }
> +                }
> +        }	
> +        cleanup();
> +	tst_exit();
> +}
> +
> --- ltp-full-20090531.orig/runtest/syscalls	2009-06-12 21:42:54.000000000 +0530
> +++ ltp-full-20090531/runtest/syscalls	2009-06-12 22:54:14.000000000 +0530
> @@ -742,6 +742,7 @@ pwrite02 pwrite02
>  pwrite03 pwrite03
>  pwrite04 pwrite04
> 
> +quotactl01 quotactl01
> 
>  read01 read01
>  read02 read02
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
