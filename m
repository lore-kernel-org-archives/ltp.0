Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1MwE5u-0007J3-Vs
	for ltp-list@lists.sourceforge.net; Fri, 09 Oct 2009 11:57:10 +0000
Date: Fri, 9 Oct 2009 13:56:55 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20091009115655.GB3725@schrodinger.suse.cz>
References: <f5a7b3810908310549t6ced24qd9e0faf634d2319f@mail.gmail.com>
	<1252323746.4922.34.camel@subratamodak.linux.ibm.com>
	<20090917134805.GA5337@schrodinger.suse.cz>
	<1253298631.15071.10.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="rJwd6BRFiFCcLxzm"
Content-Disposition: inline
In-Reply-To: <1253298631.15071.10.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [PATCH 16/21] Add sigreturn01 test for sigreturn syscall
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>, naresh kamboju <naresh.kernel@gmail.com>, Manas Kumar Nayak <maknayak@in.ibm.com>


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

Requested patch attached.

Signed-off-by: chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--rJwd6BRFiFCcLxzm
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="remove_sigreturn.patch"

Index: ltp/testcases/kernel/syscalls/sigreturn/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/sigreturn/Makefile
+++ /dev/null
@@ -1,31 +0,0 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
-
-CFLAGS += -I../../../../include -Wall
-LDLIBS += -L../../../../lib -lltp
-
-SRCS    = $(wildcard *.c)
-TARGETS = $(patsubst %.c,%,$(SRCS))
-
-all: $(TARGETS)
-
-install:
-	@set -e; for i in $(TARGETS); do ln -f $$i ../../../bin/$$i ; done
-
-clean:
-	rm -f $(TARGETS)
Index: ltp/testcases/kernel/syscalls/sigreturn/sigreturn01.c
===================================================================
--- ltp.orig/testcases/kernel/syscalls/sigreturn/sigreturn01.c
+++ /dev/null
@@ -1,172 +0,0 @@
-/******************************************************************************/
-/* Copyright (c) Crackerjack Project., 2007                                   */
-/*                                                                            */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    */
-/*                                                                            */
-/******************************************************************************/
-/******************************************************************************/
-/*                                                                            */
-/* File:        sigreturn01.c                                           */
-/*                                                                            */
-/* Description: This tests the sigreturn() syscall  
-	sigreturn - return from signal handler and cleanup stack frame.	
-	When the Linux kernel creates the stack frame for a signal handler, 
-	a call to sigreturn() is inserted into the stack frame so that the
-	signal handler will call sigreturn() upon return. This inserted call
-	to sigreturn() cleans up the stack so that the process can restart 
-	from where it was interrupted by the signal.  		
-		                    */
-/*                                                                            */
-/* Usage:  <for command-line>                                                 */
-/* sigreturn01 [-c n] [-e][-i n] [-I x] [-p x] [-t]                     */
-/*      where,  -c n : Run n copies concurrently.                             */
-/*              -e   : Turn on errno logging.                                 */
-/*              -i n : Execute test n times.                                  */
-/*              -I x : Execute test for x seconds.                            */
-/*              -P x : Pause for x seconds between iterations.                */
-/*              -t   : Turn on syscall timing.                                */
-/*                                                                            */
-/* Total Tests: 1                                                             */
-/*                                                                            */
-/* Test Name:   sigreturn01                                             */
-/* History:     Porting from Crackerjack to LTP is done by                    */
-/*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
-/******************************************************************************/
-#include <limits.h>
-#include <unistd.h>
-#include <sys/types.h>
-#include <sys/syscall.h>
-#include <pwd.h>
-#include <grp.h>
-#include <string.h>
-#include <sys/param.h>
-#include <stdio.h>
-#include <errno.h>
-
-/* Harness Specific Include Files. */
-#include "test.h"
-#include "usctest.h"
-#include "linux_syscall_numbers.h"
-
-/* Extern Global Variables */
-extern int Tst_count;           /* counter for tst_xxx routines.         */
-extern char *TESTDIR;           /* temporary dir created by tst_tmpdir() */
-
-/* Global Variables */
-char *TCID = "sigreturn01";  /* Test program identifier.*/
-int  testno;
-int  TST_TOTAL = 2;                   /* total number of tests in this file.   */
-
-/* Extern Global Functions */
-/******************************************************************************/
-/*                                                                            */
-/* Function:    cleanup                                                       */
-/*                                                                            */
-/* Description: Performs all one time clean up for this test on successful    */
-/*              completion,  premature exit or  failure. Closes all temporary */
-/*              files, removes all temporary directories exits the test with  */
-/*              appropriate return code by calling tst_exit() function.       */
-/*                                                                            */
-/* Input:       None.                                                         */
-/*                                                                            */
-/* Output:      None.                                                         */
-/*                                                                            */
-/* Return:      On failure - Exits calling tst_exit(). Non '0' return code.   */
-/*              On success - Exits calling tst_exit(). With '0' return code.  */
-/*                                                                            */
-/******************************************************************************/
-extern void cleanup() {
-        /* Remove tmp dir and all files in it */
-        TEST_CLEANUP;
-        tst_rmdir();
-
-        /* Exit with appropriate return code. */
-        tst_exit();
-}
-
-/* Local  Functions */
-/******************************************************************************/
-/*                                                                            */
-/* Function:    setup                                                         */
-/*                                                                            */
-/* Description: Performs all one time setup for this test. This function is   */
-/*              typically used to capture signals, create temporary dirs      */
-/*              and temporary files that may be used in the course of this    */
-/*              test.                                                         */
-/*                                                                            */
-/* Input:       None.                                                         */
-/*                                                                            */
-/* Output:      None.                                                         */
-/*                                                                            */
-/* Return:      On failure - Exits by calling cleanup().                      */
-/*              On success - returns 0.                                       */
-/*                                                                            */
-/******************************************************************************/
-void setup() {
-        /* Capture signals if any */
-        /* Create temporary directories */
-        TEST_PAUSE;
-        tst_tmpdir();
-}
-
-
-#define PRINT(X) fprintf(stdout,"%s\n", X)
-
-int ngexit(void);
-
-int main(int ac, char **av) {
-        int retval = 0;
-        unsigned long parm = 0;
-	int lc;                 /* loop counter */
-        char *msg;              /* message returned from parse_opts */
-	
-        /* parse standard options */
-        if ((msg = parse_opts(ac, av, (option_t *)NULL, NULL)) != (char *)NULL){
-             tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
-             tst_exit();
-           }
-
-        setup();
-
-        /* Check looping state if -i option given */
-        for (lc = 0; TEST_LOOPING(lc); ++lc) {
-                Tst_count = 0;
-                for (testno = 0; testno < TST_TOTAL; ++testno) {
-                    TEST(retval = sigreturn(parm)); 
-                    if(TEST_RETURN > 0 ) {
-                 	tst_resm(TFAIL, "%s ERROR!! sigreturn never return- errno = %d : %s", TCID, TEST_ERRNO, strerror(TEST_ERRNO));
-			cleanup();
-                        tst_exit();
-                     }
-                     else if (TEST_RETURN <= 0 ){
-        	 	   tst_resm(TPASS, "sigreturn call succeeded: result = %d ",TEST_RETURN);
-                     }
-
-	            parm = 0xffffffff;
-		    TEST(retval = sigreturn(parm)); 
-                    if(TEST_RETURN > 0 ) {
-                 	tst_resm(TFAIL, "%s ERROR!! sigreturn never return- errno = %d : %s", TCID, TEST_ERRNO, strerror(TEST_ERRNO));
-			cleanup();
-			tst_exit();
-                     }
-                     else if (TEST_RETURN <= 0 ){
-        	 	   tst_resm(TPASS, "sigreturn call succeeded: result = %d ",TEST_RETURN);
-                     }
-                }
-        }	
-	cleanup();
-        tst_exit();
-}
-

--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--rJwd6BRFiFCcLxzm--

