Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <maknayak@in.ibm.com>) id 1M9G3p-0001tk-H5
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2009 10:08:37 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M9G3n-0000Rd-7E
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2009 10:08:37 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e8.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4R9wFIY029262
	for <ltp-list@lists.sourceforge.net>; Wed, 27 May 2009 05:58:15 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4RA8YUa258262
	for <ltp-list@lists.sourceforge.net>; Wed, 27 May 2009 06:08:34 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4RA8X5J002943
	for <ltp-list@lists.sourceforge.net>; Wed, 27 May 2009 06:08:34 -0400
From: Manas Kumar Nayak <maknayak@in.ibm.com>
Date: Wed, 27 May 2009 15:38:15 +0530
Message-Id: <20090527100811.18638.52529.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20090527100645.18638.75163.sendpatchset@subratamodak.linux.ibm.com>
References: <20090527100645.18638.75163.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [PATCH 03/13] Add/Port clock_getres01 test for clock_getres()
	syscall
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

Signed-off-by: Manas Kumar Nayak <maknayak@in.ibm.com>
To: LTP List <ltp-list@lists.sourceforge.net>
Cc: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: Masatake YAMATO <yamato@redhat.com>
---

--- ltp-intermediate-20090521.orig/testcases/kernel/syscalls/clock_getres/clock_getres01.c	1970-01-01 05:30:00.000000000 +0530
+++ ltp-intermediate-20090521/testcases/kernel/syscalls/clock_getres/clock_getres01.c	2009-05-27 12:15:45.000000000 +0530
@@ -0,0 +1,344 @@
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
+/* File:        clock_getres01.c                                              */
+/*                                                                            */
+/* Description: This tests the clock_getres() syscall                         */
+/*									      */
+/* 									      */
+/*									      */
+/*									      */
+/*									      */
+/*                                                                            */
+/* Usage:  <for command-line>                                                 */
+/* clock_getres01 [-c n] [-e][-i n] [-I x] [-p x] [-t]                        */
+/*      where,  -c n : Run n copies concurrently.                             */
+/*              -e   : Turn on errno logging.                                 */
+/*              -i n : Execute test n times.                                  */
+/*              -I x : Execute test for x seconds.                            */
+/*              -P x : Pause for x seconds between iterations.                */
+/*              -t   : Turn on syscall timing.                                */
+/*                                                                            */
+/* Total Tests: 1                                                             */
+/*                                                                            */
+/* Test Name:   clock_getres01                                                */
+/* History:     Porting from Crackerjack to LTP is done by                    */
+/*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
+/******************************************************************************/
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <getopt.h>
+#include <string.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <stdio.h>
+#include <time.h>
+
+
+#include "../utils/include_j_h.h"
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
+char *TCID = "clock_getres01";  /* Test program identifier.*/
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
+#define SYSCALL_NAME    "clock_getres"
+
+
+/*
+ * Global variables
+ */
+static int opt_debug;
+static char *progname;
+
+enum test_type {
+		NORMAL,
+		NULL_POINTER,
+};
+
+
+/*
+ * Data Structure
+ */
+struct test_case {
+	clockid_t clk_id;
+        int ttype;
+        int ret;
+        int err;
+};
+
+
+/* Test cases
+*
+*   test status of errors on man page
+*
+*   EPERM   can't check because clock_getres not requires permission
+*   EINVAL  v (not supported clk_id)
+*/
+
+static struct test_case tcase[] = {
+        { // case00
+                .clk_id         = CLOCK_REALTIME,
+                .ttype          = NORMAL,
+                .ret            = 0,
+                .err            = 0,
+        },
+        { // case01
+                .clk_id         = CLOCK_MONOTONIC,
+                .ttype          = NORMAL,
+                .ret            = 0,
+                .err            = 0,
+        },
+        { // case02
+                .clk_id         = CLOCK_PROCESS_CPUTIME_ID,
+                .ttype          = NORMAL,
+                .ret            = 0,
+                .err            = 0,
+        },
+        { // case03
+                .clk_id         = CLOCK_THREAD_CPUTIME_ID,
+                .ttype          = NORMAL,
+                .ret            = 0,
+                .err            = 0,
+        },
+        { // case04
+                .clk_id         = -1,
+                .ttype          = NORMAL,
+                .ret            = -1,
+                .err            = EINVAL,
+        },
+        { // case05
+                .clk_id         = CLOCK_REALTIME,
+                .ttype          = NULL_POINTER,
+                .ret            = 0,
+                .err            = 0,
+        },
+};
+
+
+
+
+#define MEM_LENGTH              (4 * 1024 * 1024)
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
+	struct timespec res;
+
+	/*
+         * Execute system call
+         */
+        errno = 0;
+        if (tc->ttype == NULL_POINTER)
+                TEST(sys_ret = clock_getres(tc->clk_id, NULL));
+        else
+                TEST(sys_ret = clock_getres(tc->clk_id, &res));
+        sys_errno = errno;
+
+        /*
+         * Check results
+         */
+        result |= (sys_errno != tc->err);
+        PRINT_RESULT(sys_ret >= 0, tc->ret, tc->err, sys_ret, sys_errno);
+
+        return result;
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
+
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
+        			tst_resm(TPASS, "clock_getres call succeeded");
+		                break;
+
+	        default:
+                 	   	tst_resm(TFAIL, "%s failed - errno = %d : %s", TCID, TEST_ERRNO, strerror(TEST_ERRNO));
+        		        RPRINTF("NG\n");
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
--- ltp-intermediate-20090521.orig/testcases/kernel/syscalls/clock_getres/Makefile	1970-01-01 05:30:00.000000000 +0530
+++ ltp-intermediate-20090521/testcases/kernel/syscalls/clock_getres/Makefile	2009-05-22 23:43:27.000000000 +0530
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
+LDLIBS += -L../../../../lib -lltp -lrt
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
--- ltp-intermediate-20090521.orig/runtest/syscalls	2009-05-27 12:11:54.000000000 +0530
+++ ltp-intermediate-20090521/runtest/syscalls	2009-05-27 12:18:36.000000000 +0530
@@ -74,6 +74,7 @@ chroot02 chroot02
 chroot03 chroot03
 chroot04 chroot04
 
+clock_getres01 clock_getres01
 clock_nanosleep2_01 clock_nanosleep2_01
 
 clone01 clone01

---
Regards--
Manas


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
