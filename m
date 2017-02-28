From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Feb 2017 12:11:43 +0100
Subject: [LTP] [COMMITTED] [PATCH 21/23] syscalls/tkill02: Small cleanup.
In-Reply-To: <20170228111145.3265-1-chrubis@suse.cz>
References: <20170228111145.3265-1-chrubis@suse.cz>
Message-ID: <20170228111145.3265-21-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Get rid of useless comments

* Make use of tst_parse_opts()

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/tkill/tkill02.c | 112 ++++++++----------------------
 1 file changed, 30 insertions(+), 82 deletions(-)

diff --git a/testcases/kernel/syscalls/tkill/tkill02.c b/testcases/kernel/syscalls/tkill/tkill02.c
index 24f2bb2..cc0d4f5 100644
--- a/testcases/kernel/syscalls/tkill/tkill02.c
+++ b/testcases/kernel/syscalls/tkill/tkill02.c
@@ -1,42 +1,29 @@
-/******************************************************************************/
-/* Copyright (c) Crackerjack Project., 2007				   */
-/*									    */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or	  */
-/* (at your option) any later version.					*/
-/*									    */
-/* This program is distributed in the hope that it will be useful,	    */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of	    */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See		  */
-/* the GNU General Public License for more details.			   */
-/*									    */
-/* You should have received a copy of the GNU General Public License	  */
-/* along with this program;  if not, write to the Free Software	       */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*									    */
-/******************************************************************************/
-/******************************************************************************/
-/*									    */
-/* File:	tkill02.c					   */
-/*									    */
-/* Description: This tests the tkill() syscall		      */
-/*									    */
-/* Usage:  <for command-line>						 */
-/* tkill02 [-c n] [-e][-i n] [-I x] [-p x] [-t]		     */
-/*      where,  -c n : Run n copies concurrently.			     */
-/*	      -e   : Turn on errno logging.				 */
-/*	      -i n : Execute test n times.				  */
-/*	      -I x : Execute test for x seconds.			    */
-/*	      -P x : Pause for x seconds between iterations.		*/
-/*	      -t   : Turn on syscall timing.				*/
-/*									    */
-/* Total Tests: 1							     */
-/*									    */
-/* Test Name:   tkill02					     */
-/* History:     Porting from Crackerjack to LTP is done by		    */
-/*	      Manas Kumar Nayak maknayak@in.ibm.com>			*/
-/******************************************************************************/
+/******************************************************************************
+ * Copyright (c) Crackerjack Project., 2007                                   *
+ *                                                                            *
+ * This program is free software;  you can redistribute it and/or modify      *
+ * it under the terms of the GNU General Public License as published by       *
+ * the Free Software Foundation; either version 2 of the License, or          *
+ * (at your option) any later version.                                        *
+ *                                                                            *
+ * This program is distributed in the hope that it will be useful,            *
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of            *
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  *
+ * the GNU General Public License for more details.                           *
+ *                                                                            *
+ * You should have received a copy of the GNU General Public License          *
+ * along with this program;  if not, write to the Free Software Foundation,   *
+ * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           *
+ *                                                                            *
+ ******************************************************************************/
+/*
+ * File:	tkill02.c
+ *
+ * Description: This tests the tkill() syscall
+ *
+ * History:     Porting from Crackerjack to LTP is done by
+ *              Manas Kumar Nayak maknayak@in.ibm.com>
+ */
 
 #include <stdio.h>
 #include <stdlib.h>
@@ -54,53 +41,13 @@ int testno;
 static pid_t inval_tid = -1;
 static pid_t unused_tid;
 
-
-/* Extern Global Functions */
-/******************************************************************************/
-/*									    */
-/* Function:    cleanup						       */
-/*									    */
-/* Description: Performs all one time clean up for this test on successful    */
-/*	      completion,  premature exit or  failure. Closes all temporary */
-/*	      files, removes all temporary directories exits the test with  */
-/*	      appropriate return code by calling tst_exit() function.       */
-/*									    */
-/* Input:       None.							 */
-/*									    */
-/* Output:      None.							 */
-/*									    */
-/* Return:      On failure - Exits calling tst_exit(). Non '0' return code.   */
-/*	      On success - Exits calling tst_exit(). With '0' return code.  */
-/*									    */
-/******************************************************************************/
 void cleanup(void)
 {
-
 	tst_rmdir();
 }
 
-/* Local  Functions */
-/******************************************************************************/
-/*									    */
-/* Function:    setup							 */
-/*									    */
-/* Description: Performs all one time setup for this test. This function is   */
-/*	      typically used to capture signals, create temporary dirs      */
-/*	      and temporary files that may be used in the course of this    */
-/*	      test.							 */
-/*									    */
-/* Input:       None.							 */
-/*									    */
-/* Output:      None.							 */
-/*									    */
-/* Return:      On failure - Exits by calling cleanup().		      */
-/*	      On success - returns 0.				       */
-/*									    */
-/******************************************************************************/
 void setup(void)
 {
-	/* Capture signals if any */
-	/* Create temporary directories */
 	TEST_PAUSE;
 	tst_tmpdir();
 
@@ -111,9 +58,8 @@ struct test_case_t {
 	int *tid;
 	int exp_errno;
 } test_cases[] = {
-	{
-	&inval_tid, EINVAL}, {
-	&unused_tid, ESRCH}
+	{&inval_tid, EINVAL},
+	{&unused_tid, ESRCH}
 };
 
 int TST_TOTAL = sizeof(test_cases) / sizeof(test_cases[0]);
@@ -124,6 +70,8 @@ int main(int ac, char **av)
 
 	setup();
 
+	tst_parse_opts(ac, av, NULL, NULL);
+
 	for (i = 0; i < TST_TOTAL; i++) {
 
 		TEST(ltp_syscall(__NR_tkill, *(test_cases[i].tid), SIGUSR1));
-- 
2.10.2

