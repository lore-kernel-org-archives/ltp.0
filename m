Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MA1ds-0000jn-Qo
	for ltp-list@lists.sourceforge.net; Fri, 29 May 2009 12:57:00 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MA1dr-0001xG-U4
	for ltp-list@lists.sourceforge.net; Fri, 29 May 2009 12:57:00 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e8.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4TCkZFS013365
	for <ltp-list@lists.sourceforge.net>; Fri, 29 May 2009 08:46:35 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4TCuxFJ098912
	for <ltp-list@lists.sourceforge.net>; Fri, 29 May 2009 08:56:59 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4TCuxj6000590
	for <ltp-list@lists.sourceforge.net>; Fri, 29 May 2009 08:56:59 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090527101058.18638.71341.sendpatchset@subratamodak.linux.ibm.com>
References: <20090527100645.18638.75163.sendpatchset@subratamodak.linux.ibm.com>
	<20090527101058.18638.71341.sendpatchset@subratamodak.linux.ibm.com>
Date: Fri, 29 May 2009 18:26:54 +0530
Message-Id: <1243601814.5188.51.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH 09/13] Add/Port utimes01 test for utimes() syscall
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

On Wed, 2009-05-27 at 15:41 +0530, Manas Kumar Nayak wrote: 
> Signed-off-by: Manas Kumar Nayak <maknayak@in.ibm.com>

Thanks.

Regards--
Subrata

> To: LTP List <ltp-list@lists.sourceforge.net>
> Cc: Subrata Modak <subrata@linux.vnet.ibm.com>
> Cc: Masatake YAMATO <yamato@redhat.com>
> ---
> 
> --- ltp-intermediate-20090521.orig/runtest/syscalls	2009-05-27 13:31:15.000000000 +0530
> +++ ltp-intermediate-20090521/runtest/syscalls	2009-05-27 13:39:18.000000000 +0530
> @@ -1227,6 +1227,8 @@ utime04 utime04
>  utime05 utime05
>  utime06 utime06
> 
> +utimes01 utimes01
> +
>  # Introduced from Kernel 2.6.22 onwards
>  utimensat01 utimensat_tests.sh
> 
> --- ltp-intermediate-20090521.orig/testcases/kernel/syscalls/utimes/Makefile	1970-01-01 05:30:00.000000000 +0530
> +++ ltp-intermediate-20090521/testcases/kernel/syscalls/utimes/Makefile	2009-05-23 14:53:58.000000000 +0530
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
> +CFLAGS += -I../../../../include -Wall -O2
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
> --- ltp-intermediate-20090521.orig/testcases/kernel/syscalls/utimes/utimes01.c	1970-01-01 05:30:00.000000000 +0530
> +++ ltp-intermediate-20090521/testcases/kernel/syscalls/utimes/utimes01.c	2009-05-27 13:33:45.000000000 +0530
> @@ -0,0 +1,407 @@
> +/******************************************************************************/
> +/* Copyright (c) Crackerjack Project., 2007 ,Hitachi, Ltd                     */
> +/*          Author(s): Takahiro Yasui <takahiro.yasui.mp@hitachi.com>,	      */
> +/*                                                                  	      */
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
> +/* File:        utimes01.c                                                    */
> +/*                                                                            */
> +/* Description: This tests the utimes() syscall                               */
> +/*									      */
> +/* 									      */
> +/*									      */
> +/*									      */
> +/*									      */
> +/*                                                                            */
> +/* Usage:  <for command-line>                                                 */
> +/* utimes01 [-c n] [-e][-i n] [-I x] [-p x] [-t]                              */
> +/*      where,  -c n : Run n copies concurrently.                             */
> +/*              -e   : Turn on errno logging.                                 */
> +/*              -i n : Execute test n times.                                  */
> +/*              -I x : Execute test for x seconds.                            */
> +/*              -P x : Pause for x seconds between iterations.                */
> +/*              -t   : Turn on syscall timing.                                */
> +/*                                                                            */
> +/* Total Tests: 1                                                             */
> +/*                                                                            */
> +/* Test Name:   utimes01                                                      */
> +/* History:     Porting from Crackerjack to LTP is done by                    */
> +/*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
> +/******************************************************************************/
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <sys/time.h>
> +#include <dirent.h>
> +#include <unistd.h>
> +#include <getopt.h>
> +#include <string.h>
> +#include <stdlib.h>
> +#include <errno.h>
> +#include <stdio.h>
> +#include <libgen.h>
> +
> +
> +#include "../utils/include_j_h.h"
> +#include "../utils/common_j_h.c"
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
> +char *TCID = "utimes01";  /* Test program identifier.*/
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
> +
> +/*
> + * Macros
> + */
> +#define SYSCALL_NAME    "utimes"
> +
> +
> +/*
> + * Global variables
> + */
> +static int opt_debug;
> +static char *progname;
> +static char *progdir;
> +
> +enum test_type {
> +		NORMAL,
> +		FILE_NOT_EXIST,
> +	        NO_FNAME,
> +};
> +
> +
> +/*
> + * Data Structure
> + */
> +struct test_case {
> +	int ttype;
> +        long a_sec;
> +        long m_sec;
> +        char *user;
> +        int ret;
> +        int err;
> +
> +};
> +
> +
> +/* Test cases
> + *
> + *   test status of errors on man page
> + *
> + *   EACCES             v (permission denied)
> + *   ENOENT             v (file does not exist)
> + *
> + *   test status of errors on man page
> + *
> + *   EFAULT             v (points to not process address space)
> + */
> +
> +static struct test_case tcase[] = {
> +	{ // case00
> +                .ttype          = NORMAL,
> +                .a_sec          = 0,
> +                .m_sec          = 1000,
> +                .ret            = 0,
> +                .err            = 0,
> +        },
> +        { // case01
> +                .ttype          = NORMAL,
> +                .a_sec          = 1000,
> +                .m_sec          = 0,
> +                .ret            = 0,
> +                .err            = 0,
> +        },
> +        { // case02
> +                .ttype          = NORMAL,
> +                .a_sec          = 1000,
> +                .m_sec          = 2000,
> +                .user           = "nobody",
> +                .ret            = -1,
> +                .err            = EACCES, // RHEL4U1 + 2.6.18 returns EPERM
> +        },
> +        { // case03
> +                .ttype          = FILE_NOT_EXIST,
> +                .a_sec          = 1000,
> +                .m_sec          = 2000,
> +                .ret            = -1,
> +                .err            = ENOENT,
> +        },
> +
> +	{ // case04
> +                .ttype          = NO_FNAME,
> +                .a_sec          = 1000,
> +                .m_sec          = 2000,
> +                .ret            = -1,
> +                .err            = EFAULT,
> +        },
> +};
> +
> +/*
> + * do_test()
> + *
> + *   Input  : TestCase Data
> + *   Return : RESULT_OK(0), RESULT_NG(1)
> + *
> + */
> +
> +static int do_test(struct test_case *tc)
> +{
> +        int sys_ret;
> +        int sys_errno;
> +        int result = RESULT_OK;
> +	struct timeval tv[2];
> +        char fpath[PATH_MAX], c = '\0';
> +        int rc, len, cmp_ok = 1;
> +        struct stat st;
> +        uid_t old_uid;
> +
> +        TEST(rc = setup_file(progdir, "test.file", fpath));
> +        if (rc < 0)
> +                return 1;
> +
> +	/*
> +         * Change effective user id
> +         */
> +        if (tc->user != NULL) {
> +                TEST(rc = setup_euid(tc->user, &old_uid));
> +                if (rc < 0)
> +                        goto EXIT2;
> +        }
> +
> +        /*
> +         * Execute system call
> +         */
> +        tv[0].tv_sec = tc->a_sec;
> +        tv[1].tv_sec = tc->m_sec;
> +        TEST(len = strlen(fpath));
> +        if (tc->ttype == FILE_NOT_EXIST) {
> +                c = fpath[len - 1];
> +                fpath[len - 1] = '\0';
> +        }
> +        errno = 0;
> +        if (tc->ttype == NO_FNAME)
> +                TEST(sys_ret = utimes(NULL, tv));
> +        else
> +                TEST(sys_ret = utimes(fpath, tv));
> +        sys_errno = errno;
> +        if (tc->ttype == FILE_NOT_EXIST)
> +                fpath[len - 1] = c;
> +        if (sys_ret < 0)
> +                goto TEST_END;
> +
> +	/*
> +         * Check test file's time stamp
> +         */
> +        rc = stat(fpath, &st);
> +        if (rc < 0) {
> +                EPRINTF("stat failed.\n");
> +                result = 1;
> +                goto EXIT1;
> +        }
> +        tst_resm(TINFO,"E:%ld,%ld <=> R:%ld,%ld",tv[0].tv_sec, tv[1].tv_sec, st.st_atime, st.st_mtime);
> +        cmp_ok = st.st_atime == tv[0].tv_sec && st.st_mtime == tv[1].tv_sec;
> +
> +        /*
> +         * Check results
> +         */
> +TEST_END:
> +        result |= (sys_errno != tc->err) || !cmp_ok;
> +        PRINT_RESULT_CMP(sys_ret >= 0, tc->ret, tc->err, sys_ret, sys_errno,cmp_ok);
> +
> +        /*
> +         * Restore effective user id
> +         */
> +EXIT1:
> +        if (tc->user != NULL) {
> +                TEST(rc = cleanup_euid(old_uid));
> +                if (rc < 0)
> +                        return 1;
> +        }
> +EXIT2:
> +        TEST(cleanup_file(fpath));
> +
> +        return result;
> +}
> +
> +/*
> + * usage()
> + */
> +
> +static void usage(const char *progname)
> +{
> +        tst_resm(TINFO,"usage: %s [options]", progname);
> +        tst_resm(TINFO,"This is a regression test program of %s system call.",SYSCALL_NAME);
> +        tst_resm(TINFO,"options:");
> +        tst_resm(TINFO,"    -d --debug           Show debug messages");
> +        tst_resm(TINFO,"    -h --help            Show this message");
> +        tst_resm(TINFO,"NG");
> +        exit(1);
> +}
> +
> +
> +/*
> + * main()
> + */
> +
> +
> +
> +int main(int ac, char **av) {
> +	int result = RESULT_OK;
> +        int c;
> +        int i;
> +        int lc;                 /* loop counter */
> +        char *msg;              /* message returned from parse_opts */
> +
> +	struct option long_options[] = {
> +                { "debug", no_argument, 0, 'd' },
> +                { "help",  no_argument, 0, 'h' },
> +                { NULL, 0, NULL, 0 }
> +        };
> +
> +	progname = strchr(av[0], '/');
> +        progname = progname ? progname + 1 : av[0];	
> +	
> +	progdir = strdup(av[0]);
> +        progdir = dirname(progdir);
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
> +			 TEST(c = getopt_long(ac, av, "dh", long_options, NULL));
> +			 while(TEST_RETURN != -1) {
> +		                switch (c) {
> +                		case 'd':
> +		                        opt_debug = 1;
> +                		        break;
> +		                default:
> +                		        usage(progname);
> +                        		// NOTREACHED
> +                		}
> +		        }
> +
> +
> +		if (ac != optind) {
> +        	        tst_resm(TINFO,"Options are not match.");
> +                	usage(progname);
> +                	// NOTREACHED
> +	        }
> +
> +		/*
> +		* Execute test
> +         	*/
> +	        for (i = 0; i < (int)(sizeof(tcase) / sizeof(tcase[0])); i++) {
> +        	        int ret;
> +	                tst_resm(TINFO,"(case%02d) START", i);
> +	                ret = do_test(&tcase[i]);
> +	                tst_resm(TINFO,"(case%02d) END => %s", i, (ret == 0) ? "OK" : "NG");
> +	                result |= ret;
> +        	}
> +		
> +		/*
> +        	 * Check results
> +         	*/
> +        	switch(result) {
> +	        case RESULT_OK:
> +        			tst_resm(TPASS, "utimes call succeeded ");
> +		                break;
> +
> +	        default:
> +                 	   	tst_resm(TFAIL, "%s failed - errno = %d : %s", TCID, TEST_ERRNO, strerror(TEST_ERRNO));
> +        		        tst_resm(TINFO,"NG");
> +				cleanup();
> +				tst_exit();
> +		                break;
> +        	}
> +
> +                }
> +        }	
> +        cleanup();
> +	tst_exit();
> +}
> +
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
