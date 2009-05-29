Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MA1dq-0000jM-QU
	for ltp-list@lists.sourceforge.net; Fri, 29 May 2009 12:56:58 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MA1do-0001vr-Dw
	for ltp-list@lists.sourceforge.net; Fri, 29 May 2009 12:56:58 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e37.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4TCuHxj007026
	for <ltp-list@lists.sourceforge.net>; Fri, 29 May 2009 06:56:17 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4TCusf0240396
	for <ltp-list@lists.sourceforge.net>; Fri, 29 May 2009 06:56:54 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4TCusfu023883
	for <ltp-list@lists.sourceforge.net>; Fri, 29 May 2009 06:56:54 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090527101031.18638.86395.sendpatchset@subratamodak.linux.ibm.com>
References: <20090527100645.18638.75163.sendpatchset@subratamodak.linux.ibm.com>
	<20090527101031.18638.86395.sendpatchset@subratamodak.linux.ibm.com>
Date: Fri, 29 May 2009 18:26:50 +0530
Message-Id: <1243601811.5188.50.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH 08/13] Add/Port mq_timedreceive01 test
	for	mq_timedreceive() syscall
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

On Wed, 2009-05-27 at 15:40 +0530, Manas Kumar Nayak wrote: 
> Signed-off-by: Manas Kumar Nayak <maknayak@in.ibm.com>
> To: LTP List <ltp-list@lists.sourceforge.net>

Thanks.

Regards--
Subrata

> Cc: Subrata Modak <subrata@linux.vnet.ibm.com>
> Cc: Masatake YAMATO <yamato@redhat.com>
> ---
> 
> --- ltp-intermediate-20090521.orig/testcases/kernel/syscalls/mq_timedreceive/Makefile	1970-01-01 05:30:00.000000000 +0530
> +++ ltp-intermediate-20090521/testcases/kernel/syscalls/mq_timedreceive/Makefile	2009-05-23 14:30:57.000000000 +0530
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
> +CFLAGS += -I../../../../include -Wall -O2 -D_POSIX_C_SOURCE=$(shell getconf _POSIX_MESSAGE_PASSING)L
> +LDLIBS += -L../../../../lib -lltp -lrt
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
> --- ltp-intermediate-20090521.orig/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c	1970-01-01 05:30:00.000000000 +0530
> +++ ltp-intermediate-20090521/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c	2009-05-27 13:23:51.000000000 +0530
> @@ -0,0 +1,548 @@
> +/******************************************************************************/
> +/* Copyright (c) Crackerjack Project., 2007-2008 ,Hitachi, Ltd                */
> +/*          Author(s): Takahiro Yasui <takahiro.yasui.mp@hitachi.com>,	      */
> +/*		       Yumiko Sugita <yumiko.sugita.yf@hitachi.com>, 	      */
> +/*		       Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>	      */
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
> +/* File:        mq_timedreceive01.c                                           */
> +/*                                                                            */
> +/* Description: This tests the mq_timedreceive() syscall                      */
> +/*									      */
> +/* 									      */
> +/*									      */
> +/*									      */
> +/*									      */
> +/*                                                                            */
> +/* Usage:  <for command-line>                                                 */
> +/* mq_timedreceive01 [-c n] [-e][-i n] [-I x] [-p x] [-t]                     */
> +/*      where,  -c n : Run n copies concurrently.                             */
> +/*              -e   : Turn on errno logging.                                 */
> +/*              -i n : Execute test n times.                                  */
> +/*              -I x : Execute test for x seconds.                            */
> +/*              -P x : Pause for x seconds between iterations.                */
> +/*              -t   : Turn on syscall timing.                                */
> +/*                                                                            */
> +/* Total Tests: 1                                                             */
> +/*                                                                            */
> +/* Test Name:   mq_timedreceive01                                             */
> +/* History:     Porting from Crackerjack to LTP is done by                    */
> +/*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
> +/******************************************************************************/
> +#include <sys/syscall.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <sys/wait.h>
> +#include <getopt.h>
> +#include <stdlib.h>
> +#include <errno.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <mqueue.h>
> +#include <time.h>
> +#include <signal.h>
> +#include <limits.h>
> +
> +
> +#include "../utils/include_j_h.h"
> +#include "../utils/common_j_h.c"
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
> +char *TCID = "mq_timedreceive01";  /* Test program identifier.*/
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
> +#define SYSCALL_NAME    "mq_timedreceive"
> +
> +
> +/*
> + * Global variables
> + */
> +static int opt_debug;
> +static char *progname;
> +
> +enum test_type {
> +	NORMAL,
> +        FD_NONE,
> +        FD_NOT_EXIST,
> +        FD_FILE,
> +        INVALID_MSG_LEN,
> +        EMPTY_QUEUE,
> +        SEND_SIGINT,
> +};
> +
> +
> +/*
> + * Data Structure
> + */
> +struct test_case {
> +	int ttype;
> +        int non_block;
> +        int len;
> +        unsigned prio;
> +        time_t sec;
> +        long nsec;
> +        int ret;
> +        int err;
> +};
> +
> +#define MAX_MSG         10
> +#define MAX_MSGSIZE     8192
> +
> +/* Test cases
> + *
> + *   test status of errors on man page
> + *
> + *   EAGAIN             v (would block)
> + *   EBADF              v (not a valid descriptor)
> + *   EINTR              v (interrupted by a signal)
> + *   EINVAL             v (invalid timeout value)
> + *   ETIMEDOUT          v (not block and timeout occured)
> + *   EMSGSIZE           v ('msg_len' is less than the message size of the queue)
> + *   EBADMSG            can't check because this error never occur
> + */
> +static struct test_case tcase[] = {
> +        { // case00
> +                .ttype          = NORMAL,
> +                .len            = 0,    // also success when size equals zero
> +                .ret            = 0,
> +                .err            = 0,
> +        },
> +	{ // case01
> +                .ttype          = NORMAL,
> +                .len            = 1,
> +                .ret            = 0,
> +                .err            = 0,
> +        },
> +        { // case02
> +                .ttype          = NORMAL,
> +                .len            = MAX_MSGSIZE,
> +                .ret            = 0,
> +                .err            = 0,
> +        },
> +        { // case03
> +                .ttype          = NORMAL,
> +                .len            = 1,
> +                .prio           = 32767, // max priority
> +                .ret            = 0,
> +                .err            = 0,
> +        },
> +	{ // case04
> +                .ttype          = INVALID_MSG_LEN,
> +                .len            = 0,
> +                .ret            = -1,
> +                .err            = EMSGSIZE,
> +        },
> +        { // case05
> +                .ttype          = FD_NONE,
> +                .len            = 0,
> +                .ret            = -1,
> +                .err            = EBADF,
> +        },
> +        { // case06
> +                .ttype          = FD_NOT_EXIST,
> +                .len            = 0,
> +                .ret            = -1,
> +                .err            = EBADF,
> +        },
> +        { // case07
> +                .ttype          = FD_FILE,
> +                .len            = 0,
> +                .ret            = -1,
> +                .err            = EBADF,
> +        },
> +        { // case08
> +                .ttype          = EMPTY_QUEUE,
> +                .non_block      = 1,
> +                .len            = 16,
> +                .ret            = -1,
> +                .err            = EAGAIN,
> +        },
> +        { // case09
> +                .ttype          = EMPTY_QUEUE,
> +                .len            = 16,
> +                .sec            = -1,
> +                .nsec           = 0,
> +                .ret            = -1,
> +                .err            = EINVAL,
> +        },
> +	{ // case10
> +                .ttype          = EMPTY_QUEUE,
> +                .len            = 16,
> +                .sec            = 0,
> +                .nsec           = -1,
> +                .ret            = -1,
> +                .err            = EINVAL,
> +        },
> +        { // case11
> +                .ttype          = EMPTY_QUEUE,
> +                .len            = 16,
> +                .sec            = 0,
> +                .nsec           = 1000000000,
> +                .ret            = -1,
> +                .err            = EINVAL,
> +        },
> +        { // case12
> +                .ttype          = EMPTY_QUEUE,
> +                .len            = 16,
> +                .sec            = 0,
> +                .nsec           = 999999999,
> +                .ret            = -1,
> +                .err            = ETIMEDOUT,
> +        },
> +        { // case13
> +                .ttype          = SEND_SIGINT,
> +                .len            = 16,
> +                .ret            = -1,
> +                .err            = EINTR,
> +        },
> +};
> +
> +
> +
> +
> +#define MEM_LENGTH              (4 * 1024 * 1024)
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
> +	int oflag;
> +        int i, rc, cmp_ok = 1, fd = -1;
> +        char smsg[MAX_MSGSIZE], rmsg[MAX_MSGSIZE];
> +        struct timespec ts, *p_ts;
> +        pid_t pid = 0;
> +        unsigned prio;
> +        size_t msg_len;
> +
> +	/*
> +         * When test ended with SIGTERM etc, mq discriptor is left remains.
> +         * So we delete it first.
> +         */
> +        TEST(mq_unlink(QUEUE_NAME));
> +
> +switch (tc->ttype) {
> +        case FD_NOT_EXIST:
> +                fd = INT_MAX - 1;
> +                /* fallthrough */
> +        case FD_NONE:
> +                break;
> +        case FD_FILE:
> +                TEST(fd = open("/", O_RDONLY));
> +                if (TEST_RETURN < 0) {
> +                 	tst_resm(TFAIL, "can't open \"/\". - errno = %d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> +                        result = 1;
> +                        goto EXIT;
> +                }
> +                break;
> +        default:
> +                /*
> +                 * Open message queue
> +                 */
> +                oflag = O_CREAT|O_EXCL|O_RDWR;
> +                if (tc->non_block)
> +                        oflag |= O_NONBLOCK;
> +
> +                TEST(fd = mq_open(QUEUE_NAME, oflag, S_IRWXU, NULL));
> +                if (TEST_RETURN < 0) {
> +                 	tst_resm(TFAIL, "mq_open failed - errno = %d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> +                        result = 1;
> +                        goto EXIT;
> +                }
> +
> +		 if (tc->ttype == SEND_SIGINT) {
> +                        TEST(pid = create_sig_proc(200000, SIGINT));
> +                        if (TEST_RETURN < 0) {
> +                                result = 1;
> +                                goto EXIT;
> +                        }
> +                }
> +                break;
> +           }
> +
> +	/*
> +         * Prepare send message
> +         */
> +        for (i = 0; i < tc->len; i++)
> +                smsg[i] = i;
> +
> +        /*
> +         * Send message
> +         */
> +        switch (tc->ttype) {
> +        case EMPTY_QUEUE:
> +        case SEND_SIGINT:
> +        case FD_NONE:
> +        case FD_NOT_EXIST:
> +        case FD_FILE:
> +                break;
> +        default:
> +		TEST(rc = mq_timedsend(fd, smsg, tc->len, tc->prio, NULL));
> +                if (TEST_RETURN < 0) {
> +                 	tst_resm(TFAIL, "mq_timedsend failed - errno = %d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> +                        result = 1;
> +                        goto EXIT;
> +                }
> +                break;
> +        }
> +
> +        /*
> +         * Set the message length and timeout value
> +         */
> +        msg_len = MAX_MSGSIZE;
> +        if (tc->ttype == INVALID_MSG_LEN)
> +                msg_len -= 1;
> +        ts.tv_sec = tc->sec;
> +        ts.tv_nsec = tc->nsec;
> +        p_ts = &ts;
> +        if (tc->sec == 0 && tc->nsec == 0)
> +                p_ts = NULL;
> +
> +	/*
> +         * Execute system call
> +         */
> +        errno = 0;
> +        TEST(sys_ret = mq_timedreceive(fd, rmsg, msg_len, &prio, p_ts));
> +        sys_errno = errno;
> +        if (sys_ret < 0)
> +                goto TEST_END;
> + 
> +	 /*
> +         * Compare received message
> +         */
> +        if (sys_ret != tc->len || tc->prio != prio)
> +                cmp_ok = 0;
> +        else {
> +                for (i = 0; i < tc->len; i++)
> +                        if (rmsg[i] != smsg[i]) {
> +                                cmp_ok = 0;
> +                                break;
> +                        }
> +        }
> +
> +
> +	TEST_END:
> +        /*
> +         * Check results
> +         */
> +        result |= (sys_errno != tc->err) || !cmp_ok;
> +        PRINT_RESULT_CMP(0, tc->ret == 0 ? tc->len : tc->ret, tc->err,sys_ret, sys_errno, cmp_ok);
> +
> +EXIT:
> +        if (fd >= 0) {
> +                TEST(close(fd));
> +                TEST(mq_unlink(QUEUE_NAME));
> +        }
> +        if (pid > 0) {
> +                int st;
> +                TEST(kill(pid, SIGTERM));
> +                TEST(wait(&st));
> +        }
> +        return result;
> +}
> +
> +/*
> + * sighandler()
> + */
> +void sighandler(int sig)
> +{
> +        if (sig == SIGINT)
> +                return;
> +        // NOTREACHED
> +        return;
> +}
> +
> +
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
> +        			tst_resm(TPASS, "mq_timedreceive call succeeded");
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
> --- ltp-intermediate-20090521.orig/runtest/syscalls	2009-05-27 13:28:26.000000000 +0530
> +++ ltp-intermediate-20090521/runtest/syscalls	2009-05-27 13:27:56.000000000 +0530
> @@ -587,6 +587,7 @@ mprotect03 mprotect03
> 
>  mq_notify01 mq_notify01
>  mq_open01 mq_open01
> +mq_timedreceive01 mq_timedreceive01
> 
>  mremap01 mremap01
>  mremap02 mremap02
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
