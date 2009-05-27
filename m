Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <maknayak@in.ibm.com>) id 1M9G72-0002GY-S7
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2009 10:11:56 +0000
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M9G6z-00011n-3p
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2009 10:11:56 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4RA8KMd016706
	for <ltp-list@lists.sourceforge.net>; Wed, 27 May 2009 04:08:20 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4RABqIJ223774
	for <ltp-list@lists.sourceforge.net>; Wed, 27 May 2009 04:11:52 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4RABpFD002746
	for <ltp-list@lists.sourceforge.net>; Wed, 27 May 2009 04:11:52 -0600
From: Manas Kumar Nayak <maknayak@in.ibm.com>
Date: Wed, 27 May 2009 15:41:28 +0530
Message-Id: <20090527101124.18638.7961.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20090527100645.18638.75163.sendpatchset@subratamodak.linux.ibm.com>
References: <20090527100645.18638.75163.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [PATCH 10/13] Add/Port mq_unlink01 test for mq_unlink()
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

--- ltp-intermediate-20090521.orig/testcases/kernel/syscalls/mq_unlink/Makefile	1970-01-01 05:30:00.000000000 +0530
+++ ltp-intermediate-20090521/testcases/kernel/syscalls/mq_unlink/Makefile	2009-05-23 14:56:20.000000000 +0530
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
--- ltp-intermediate-20090521.orig/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c	1970-01-01 05:30:00.000000000 +0530
+++ ltp-intermediate-20090521/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c	2009-05-27 13:51:14.000000000 +0530
@@ -0,0 +1,392 @@
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
+/* File:        mq_ulink01.c                                                  */
+/*                                                                            */
+/* Description: This tests the mq_ulink() syscall                             */
+/*									      */
+/* 									      */
+/*									      */
+/*									      */
+/*									      */
+/*                                                                            */
+/* Usage:  <for command-line>                                                 */
+/* mq_ulink01 [-c n] [-e][-i n] [-I x] [-p x] [-t]                            */
+/*      where,  -c n : Run n copies concurrently.                             */
+/*              -e   : Turn on errno logging.                                 */
+/*              -i n : Execute test n times.                                  */
+/*              -I x : Execute test for x seconds.                            */
+/*              -P x : Pause for x seconds between iterations.                */
+/*              -t   : Turn on syscall timing.                                */
+/*                                                                            */
+/* Total Tests: 1                                                             */
+/*                                                                            */
+/* Test Name:   mq_ulink01                                             */
+/* History:     Porting from Crackerjack to LTP is done by                    */
+/*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
+/******************************************************************************/
+
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/uio.h>
+#include <getopt.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <string.h>
+#include <mqueue.h>
+#include <limits.h>
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
+char *TCID = "mq_ulink01";  /* Test program identifier.*/
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
+#define SYSCALL_NAME    "mq_ulink"
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
+};
+
+
+/*
+ * Data Structure
+ */
+struct test_case {
+	char *user;
+        char *qname;
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
+*   EACCES             v (permission is denied)
+*   ENAMETOOLONG       v (too long name length)
+*   ENOENT             v (named message queue does not exist)
+*/
+
+static struct test_case tcase[] = {
+	{ // case00
+                .ttype          = NORMAL,
+                .qname          = QUEUE_NAME,
+                .ret            = 0,
+                .err            = 0,
+        },
+        { // case01
+                .ttype          = NORMAL,
+                .user           = "nobody",
+                .qname          = QUEUE_NAME,
+                .ret            = -1,
+                .err            = EACCES,
+        },
+        { // case02
+                .ttype          = NORMAL,
+                                //  0         1         2         3
+                                //  0123456789012345678901234567890123456789
+                .qname          = "/aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" \
+                                   "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" \
+                                   "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" \
+                                   "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" \
+                                   "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" \
+                                   "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" \
+                                   "aaaaaaaaaaaaaaa",
+                .ret            = -1,
+                .err            = ENOENT,
+        },
+	{ // case03
+                .ttype          = NORMAL,
+                                //  0         1         2         3
+                                //  0123456789012345678901234567890123456789
+                .qname          = "/aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" \
+                                   "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" \
+                                   "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" \
+                                   "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" \
+                                   "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" \
+                                   "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" \
+                                   "aaaaaaaaaaaaaaaa",
+                .ret            = -1,
+                .err            = ENAMETOOLONG,
+        },
+};
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
+	int rc, fd1 = -1, fd2 = -1;
+        uid_t old_uid = -1;
+
+        /*
+         * When test ended with SIGTERM etc, mq discriptor is left remains.
+         * So we delete it first.
+         */
+        TEST(mq_unlink(QUEUE_NAME));
+
+        /*
+         * Open message queue
+         */
+        TEST(rc = mq_open(QUEUE_NAME, O_CREAT|O_EXCL|O_RDWR, S_IRWXU, NULL));
+	if (TEST_RETURN < 0) {
+                tst_resm(TFAIL, "mq_open failed - errno = %d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
+                result = 1;
+                goto EXIT;
+        }
+        fd1 = rc;
+
+        /*
+         * Change effective user id
+         */
+        if (tc->user != NULL) {
+                TEST(rc = setup_euid(tc->user, &old_uid));
+                if (TEST_RETURN < 0) {
+                        result = 1;
+                        goto EXIT;
+                }
+        }
+
+/*
+         * Execute system call
+         */
+        //tst_resm(TINFO,"PATH_MAX: %d\n", PATH_MAX);
+        //tst_resm(TINFO,"NAME_MAX: %d\n", NAME_MAX);
+        errno = 0;
+        TEST(sys_ret = mq_unlink(tc->qname));
+        sys_errno = errno;
+        if (sys_ret >= 0)
+                fd2 = sys_ret;
+
+        /*
+         * Check results
+         */
+        result |= (sys_errno != tc->err);
+        PRINT_RESULT(sys_ret >= 0, tc->ret, tc->err, sys_ret, sys_errno);
+
+EXIT:
+        if (tc->user != NULL && old_uid != -1)
+                cleanup_euid(old_uid);
+
+        if (fd1 >= 0)
+                close(fd1);
+        if (fd2 >= 0)
+                close(fd2);
+        if (fd1 >= 0)
+                mq_unlink(QUEUE_NAME);
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
+        tst_resm(TINFO,"NG\n");
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
+        			tst_resm(TPASS, "mq_ulink call succeeded");
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
--- ltp-intermediate-20090521.orig/runtest/syscalls	2009-05-27 13:43:32.000000000 +0530
+++ ltp-intermediate-20090521/runtest/syscalls	2009-05-27 13:52:49.000000000 +0530
@@ -588,6 +588,7 @@ mprotect03 mprotect03
 mq_notify01 mq_notify01
 mq_open01 mq_open01
 mq_timedreceive01 mq_timedreceive01
+mq_unlink01 mq_unlink01
 
 mremap01 mremap01
 mremap02 mremap02

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
