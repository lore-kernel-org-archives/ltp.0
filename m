Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <maknayak@in.ibm.com>) id 1M9G5C-00023b-0w
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2009 10:10:02 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M9G58-0000hr-FI
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2009 10:10:01 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4RA4P7r019202
	for <ltp-list@lists.sourceforge.net>; Wed, 27 May 2009 06:04:25 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4RA9wJQ256018
	for <ltp-list@lists.sourceforge.net>; Wed, 27 May 2009 06:09:58 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4RA9vSL013715
	for <ltp-list@lists.sourceforge.net>; Wed, 27 May 2009 06:09:57 -0400
From: Manas Kumar Nayak <maknayak@in.ibm.com>
Date: Wed, 27 May 2009 15:39:39 +0530
Message-Id: <20090527100935.18638.88021.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20090527100645.18638.75163.sendpatchset@subratamodak.linux.ibm.com>
References: <20090527100645.18638.75163.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [PATCH 06/13]  Add/Port ppoll01 test for ppoll() syscall
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP List <ltp-list@lists.sourceforge.net>
Cc: Manas Kumar Nayak <maknayak@in.ibm.com>

diff -uprN ltp-intermediate-20090521.orig/testcases/kernel/syscalls/ppoll/Makefile ltp-intermediate-20090521/testcases/kernel/syscalls/ppoll/Makefile
--- ltp-intermediate-20090521.orig/testcases/kernel/syscalls/ppoll/Makefile	1970-01-01 05:30:00.000000000 +0530
+++ ltp-intermediate-20090521/testcases/kernel/syscalls/ppoll/Makefile	2009-05-23 12:01:25.000000000 +0530
@@ -0,0 +1,31 @@
+#
+#  Copyright (c) International Business Machines  Corp., 2009
+#
+#  This program is free software;  you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#  the GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program;  if not, write to the Free Software
+#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+
+CFLAGS += -I../../../../include -Wall -O2
+LDLIBS += -L../../../../lib -lltp 
+
+SRCS    = $(wildcard *.c)
+TARGETS = $(patsubst %.c,%,$(SRCS))
+
+all: $(TARGETS)
+
+install:
+	@set -e; for i in $(TARGETS); do ln -f $$i ../../../bin/$$i ; done
+
+clean:
+	rm -f $(TARGETS)
diff -uprN ltp-intermediate-20090521.orig/testcases/kernel/syscalls/ppoll/ppoll01.c ltp-intermediate-20090521/testcases/kernel/syscalls/ppoll/ppoll01.c
--- ltp-intermediate-20090521.orig/testcases/kernel/syscalls/ppoll/ppoll01.c	1970-01-01 05:30:00.000000000 +0530
+++ ltp-intermediate-20090521/testcases/kernel/syscalls/ppoll/ppoll01.c	2009-05-27 13:00:58.000000000 +0530
@@ -0,0 +1,482 @@
+/******************************************************************************/
+/* Copyright (c) Crackerjack Project., 2007-2008 ,Hitachi, Ltd                */
+/*          Author(s): Takahiro Yasui <takahiro.yasui.mp@hitachi.com>,	      */
+/*		       Yumiko Sugita <yumiko.sugita.yf@hitachi.com>, 	      */
+/*		       Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>	      */
+/*                                                                  	      */
+/* This program is free software;  you can redistribute it and/or modify      */
+/* it under the terms of the GNU General Public License as published by       */
+/* the Free Software Foundation; either version 2 of the License, or          */
+/* (at your option) any later version.                                        */
+/*                                                                            */
+/* This program is distributed in the hope that it will be useful,            */
+/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
+/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
+/* the GNU General Public License for more details.                           */
+/*                                                                            */
+/* You should have received a copy of the GNU General Public License          */
+/* along with this program;  if not, write to the Free Software               */
+/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    */
+/*                                                                            */
+/******************************************************************************/
+/******************************************************************************/
+/*                                                                            */
+/* File:        ppoll01.c                                                     */
+/*                                                                            */
+/* Description: This tests the ppoll01() syscall                              */
+/*									      */
+/* 									      */
+/*									      */
+/*									      */
+/*									      */
+/*                                                                            */
+/* Usage:  <for command-line>                                                 */
+/* ppoll01 [-c n] [-e][-i n] [-I x] [-p x] [-t]                               */
+/*      where,  -c n : Run n copies concurrently.                             */
+/*              -e   : Turn on errno logging.                                 */
+/*              -i n : Execute test n times.                                  */
+/*              -I x : Execute test for x seconds.                            */
+/*              -P x : Pause for x seconds between iterations.                */
+/*              -t   : Turn on syscall timing.                                */
+/*                                                                            */
+/* Total Tests: 1                                                             */
+/*                                                                            */
+/* Test Name:   ppoll01                                                       */
+/* History:     Porting from Crackerjack to LTP is done by                    */
+/*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
+/******************************************************************************/
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/select.h>
+#include <sys/wait.h>
+#include <getopt.h>
+#include <string.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <libgen.h>
+#include <limits.h>
+#include <signal.h>
+#include "asm/poll.h"
+
+
+#include "../utils/include_j_h.h"
+#include "../utils/common_j_h.c"
+
+/* Harness Specific Include Files. */
+#include "test.h"
+#include "usctest.h"
+#include "linux_syscall_numbers.h"
+
+/* Extern Global Variables */
+extern int Tst_count;           /* counter for tst_xxx routines.         */
+extern char *TESTDIR;           /* temporary dir created by tst_tmpdir() */
+
+/* Global Variables */
+char *TCID = "ppoll01";  /* Test program identifier.*/
+int  testno;
+int  TST_TOTAL = 1;                   /* total number of tests in this file.   */
+
+/* Extern Global Functions */
+/******************************************************************************/
+/*                                                                            */
+/* Function:    cleanup                                                       */
+/*                                                                            */
+/* Description: Performs all one time clean up for this test on successful    */
+/*              completion,  premature exit or  failure. Closes all temporary */
+/*              files, removes all temporary directories exits the test with  */
+/*              appropriate return code by calling tst_exit() function.       */
+/*                                                                            */
+/* Input:       None.                                                         */
+/*                                                                            */
+/* Output:      None.                                                         */
+/*                                                                            */
+/* Return:      On failure - Exits calling tst_exit(). Non '0' return code.   */
+/*              On success - Exits calling tst_exit(). With '0' return code.  */
+/*                                                                            */
+/******************************************************************************/
+extern void cleanup() {
+        /* Remove tmp dir and all files in it */
+        TEST_CLEANUP;
+        tst_rmdir();
+
+        /* Exit with appropriate return code. */
+        tst_exit();
+}
+
+/* Local  Functions */
+/******************************************************************************/
+/*                                                                            */
+/* Function:    setup                                                         */
+/*                                                                            */
+/* Description: Performs all one time setup for this test. This function is   */
+/*              typically used to capture signals, create temporary dirs      */
+/*              and temporary files that may be used in the course of this    */
+/*              test.                                                         */
+/*                                                                            */
+/* Input:       None.                                                         */
+/*                                                                            */
+/* Output:      None.                                                         */
+/*                                                                            */
+/* Return:      On failure - Exits by calling cleanup().                      */
+/*              On success - returns 0.                                       */
+/*                                                                            */
+/******************************************************************************/
+void setup() {
+        /* Capture signals if any */
+        /* Create temporary directories */
+        TEST_PAUSE;
+        tst_tmpdir();
+}
+
+
+/*
+ * Macros
+ */
+#define SYSCALL_NAME    "ppoll"
+
+#ifndef __NR_ppoll
+#  define __NR_ppoll    309
+#endif
+
+#ifndef POLLRDHUP
+#  define POLLRDHUP     0x2000
+#endif
+
+
+/*
+ * Global variables
+ */
+static int opt_debug;
+static char *progname;
+static char *progdir;
+
+enum test_type {
+	NORMAL,
+        MASK_SIGNAL,
+        TIMEOUT,
+        FD_ALREADY_CLOSED,
+        SEND_SIGINT,
+        INVALID_NFDS,
+        INVALID_FDS,
+        MINUS_NSEC,
+        TOO_LARGE_NSEC,
+
+};
+
+
+/*
+ * Data Structure
+ */
+struct test_case {
+	short expect_revents;
+        int ttype;
+        int ret;
+        int err;
+};
+
+
+/* Test cases
+ *
+ *   test status of errors on man page
+ *
+ *   EBADF              can't check because EBADF never happen even though
+ *                      fd was invalid. In this case, information of invalid
+ *                      fd is set in revents
+ *   EFAULT             v ('fds' array in the invalid address space)
+ *   EINTR              v (a non blocked signal was caught)
+ *   EINVAL             v ('nfds' is over the 'RLIMIT_NOFILE' value)
+ *   ENOMEM             can't check because it's difficult to create no-memory
+ */
+
+
+static struct test_case tcase[] = {
+	{ // case00
+                .ttype          = NORMAL,
+                .expect_revents = POLLOUT,
+                .ret            = 0,
+                .err            = 0,
+        },
+        { // case01
+                .ttype          = MASK_SIGNAL,
+                .expect_revents = 0, // don't care
+                .ret            = 0,
+                .err            = 0,
+        },
+        { // case02
+                .ttype          = TIMEOUT,
+                .expect_revents = 0, // don't care
+                .ret            = 0,
+                .err            = 0,
+        },
+        { // case03
+                .ttype          = FD_ALREADY_CLOSED,
+                .expect_revents = POLLNVAL,
+                .ret            = 0,
+                .err            = 0,
+        },
+        { // case04
+                .ttype          = SEND_SIGINT,
+                .ret            = -1,
+                .err            = EINTR,
+        },
+        { // case05
+                .ttype          = INVALID_NFDS,
+                .ret            = -1,
+                .err            = EINVAL,
+        },
+        { // case06
+                .ttype          = INVALID_FDS,
+                .ret            = -1,
+                .err            = EFAULT,
+        },
+#if 0
+        { // case07
+                .ttype          = MINUS_NSEC,
+                .ret            = -1,
+                .err            = EINVAL, // RHEL4U1 + 2.6.18 returns SUCCESS
+        },
+        { // case08
+                .ttype          = TOO_LARGE_NSEC,
+                .ret            = -1,
+                .err            = EINVAL, // RHEL4U1 + 2.6.18 returns SUCCESS
+        },
+#endif
+};
+
+#define NUM_TEST_FDS    1
+
+/*
+ * do_test()
+ *
+ *   Input  : TestCase Data
+ *   Return : RESULT_OK(0), RESULT_NG(1)
+ *
+ */
+
+static int do_test(struct test_case *tc)
+{
+        int sys_ret;
+        int sys_errno;
+        int result = RESULT_OK;
+	int fd = -1 , cmp_ok = 1;
+	char fpath[PATH_MAX];
+	struct pollfd *p_fds, fds[NUM_TEST_FDS];
+        unsigned int nfds = NUM_TEST_FDS;
+        struct timespec *p_ts, ts;
+        sigset_t *p_sigmask, sigmask;
+        size_t sigsetsize = 0;
+        pid_t pid = 0;
+
+	TEST(fd = setup_file(progdir, "test.file", fpath));
+        if (fd < 0)
+                return 1;
+        fds[0].fd = fd;
+        fds[0].events = POLLIN | POLLPRI | POLLOUT | POLLRDHUP;
+        fds[0].revents = 0;
+        p_fds = fds;
+        p_ts = NULL;
+        p_sigmask = NULL;
+
+	switch (tc->ttype) {
+        case TIMEOUT:
+                nfds = 0;
+                ts.tv_sec = 0;
+                ts.tv_nsec = 50000000;  // 50msec
+                p_ts = &ts;
+                break;
+	case FD_ALREADY_CLOSED:
+                TEST(close(fd));
+                fd = -1;
+                TEST(cleanup_file(fpath));
+                break;
+        case MASK_SIGNAL:
+                TEST(sigemptyset(&sigmask));
+                TEST(sigaddset(&sigmask, SIGINT));
+                p_sigmask = &sigmask;
+                //sigsetsize = sizeof(sigmask);
+                sigsetsize = 8;
+                nfds = 0;
+                ts.tv_sec = 0;
+                ts.tv_nsec = 300000000; // 300msec => need to be enough for
+                                        //   waiting the signal
+                p_ts = &ts;
+                // fallthrough
+	case SEND_SIGINT:
+                nfds = 0;
+                TEST(pid = create_sig_proc(100000, SIGINT)); // 100msec
+                if (pid < 0)
+                        return 1;
+                break;
+        case INVALID_NFDS:
+                //nfds = RLIMIT_NOFILE + 1; ==> RHEL4U1 + 2.6.18 returns SUCCESS
+                nfds = -1;
+                break;
+        case INVALID_FDS:
+                p_fds = (void*)0xc0000000;
+                break;
+        case MINUS_NSEC:
+                ts.tv_sec = 0;
+                ts.tv_nsec = -1;
+                p_ts = &ts;
+                break;
+	case TOO_LARGE_NSEC:
+                ts.tv_sec = 0;
+                ts.tv_nsec = 1000000000;
+                p_ts = &ts;
+                break;
+        }
+
+	/*
+	   * Execute system call
+         */
+        errno = 0;
+        TEST(sys_ret = syscall(__NR_ppoll, p_fds, nfds, p_ts, p_sigmask, sigsetsize));
+        sys_errno = errno;
+        if (sys_ret <= 0 || tc->ret < 0)
+                goto TEST_END;
+
+        cmp_ok = fds[0].revents == tc->expect_revents;
+        if (opt_debug) {
+                tst_resm(TINFO,"EXPECT: revents=0x%04x", tc->expect_revents);
+                tst_resm(TINFO,"RESULT: revents=0x%04x", fds[0].revents);
+        }
+
+TEST_END:
+        /*
+         * Check results
+         */
+        result |= (sys_errno != tc->err) || !cmp_ok;
+        PRINT_RESULT_CMP(sys_ret >= 0, tc->ret, tc->err, sys_ret, sys_errno,
+                         cmp_ok);
+
+        if (fd >= 0)
+                cleanup_file(fpath);
+        if (pid > 0) {
+                int st;
+                kill(pid, SIGTERM);
+                wait(&st);
+        }
+	return result;
+}
+
+
+/*
+ * sighandler()
+ */
+void sighandler(int sig)
+{
+        if (sig == SIGINT)
+                return;
+        // NOTREACHED
+        return;
+}
+
+
+/*
+ * usage()
+ */
+
+static void usage(const char *progname)
+{
+        tst_resm(TINFO,"usage: %s [options]", progname);
+        tst_resm(TINFO,"This is a regression test program of %s system call.",SYSCALL_NAME);
+        tst_resm(TINFO,"options:");
+        tst_resm(TINFO,"    -d --debug           Show debug messages");
+        tst_resm(TINFO,"    -h --help            Show this message");
+        tst_resm(TINFO,"NG");
+        exit(1);
+}
+
+
+/*
+ * main()
+ */
+
+
+
+int main(int ac, char **av) {
+	int result = RESULT_OK;
+        int c;
+        int i;
+        int lc;                 /* loop counter */
+        char *msg;              /* message returned from parse_opts */
+
+	struct option long_options[] = {
+                { "debug", no_argument, 0, 'd' },
+                { "help",  no_argument, 0, 'h' },
+                { NULL, 0, NULL, 0 }
+        };
+
+	progname = strchr(av[0], '/');
+        progname = progname ? progname + 1 : av[0];	
+
+	progdir = strdup(av[0]);
+        progdir = dirname(progdir);
+	
+        /* parse standard options */
+        if ((msg = parse_opts(ac, av, (option_t *)NULL, NULL)) != (char *)NULL){
+             tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
+             tst_exit();
+           }
+
+        setup();
+
+        /* Check looping state if -i option given */
+        for (lc = 0; TEST_LOOPING(lc); ++lc) {
+                Tst_count = 0;
+                for (testno = 0; testno < TST_TOTAL; ++testno) {
+			 TEST(c = getopt_long(ac, av, "dh", long_options, NULL));
+			 while(TEST_RETURN != -1) {
+		                switch (c) {
+                		case 'd':
+		                        opt_debug = 1;
+                		        break;
+		                default:
+                		        usage(progname);
+                        		// NOTREACHED
+                		}
+		        }
+
+
+		if (ac != optind) {
+        	        tst_resm(TINFO,"Options are not match.");
+                	usage(progname);
+                	// NOTREACHED
+	        }
+
+		/*
+		* Execute test
+         	*/
+	        for (i = 0; i < (int)(sizeof(tcase) / sizeof(tcase[0])); i++) {
+        	        int ret;
+	                tst_resm(TINFO,"(case%02d) START", i);
+	                ret = do_test(&tcase[i]);
+	                tst_resm(TINFO,"(case%02d) END => %s", i, (ret == 0) ? "OK" : "NG");
+	                result |= ret;
+        	}
+		
+		/*
+        	 * Check results
+         	*/
+        	switch(result) {
+	        case RESULT_OK:
+        			tst_resm(TPASS, "ppoll01 call succeeded ");
+		                break;
+
+	        default:
+                 	   	tst_resm(TFAIL, "%s failed - errno = %d : %s", TCID, TEST_ERRNO, strerror(TEST_ERRNO));
+        		        RPRINTF("NG");
+				cleanup();
+				tst_exit();
+		                break;
+        	}
+
+                }
+        }	
+        cleanup();
+	tst_exit();
+}
+
--- ltp-intermediate-20090521.orig/runtest/syscalls	2009-05-27 12:58:57.000000000 +0530
+++ ltp-intermediate-20090521/runtest/syscalls	2009-05-27 13:06:52.000000000 +0530
@@ -706,6 +706,8 @@ pipe2_02 pipe2_02
 
 poll01 poll01
 
+ppoll01 ppoll01
+
 prctl01 prctl01
 prctl02 prctl02
 

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
