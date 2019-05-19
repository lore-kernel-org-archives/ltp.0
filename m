From: Sandeep Patil <sspatil@android.com>
Date: Sun, 19 May 2019 16:33:27 -0700
Subject: [LTP] [PATCH v2] syscalls/bdflush01: delete bdflush test
In-Reply-To: <20190519003808.47425-5-sspatil@android.com>
References: <20190519003808.47425-5-sspatil@android.com>
Message-ID: <20190519233327.249118-1-sspatil@android.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The manual says the system call is deprecated since Linux 2.6
and does nothing. So, remove the test.

Signed-off-by: Sandeep Patil <sspatil@android.com>
---
v2
=====
- Delete bdflush01 from runtest

 runtest/syscalls                              |   2 -
 testcases/kernel/syscalls/bdflush/.gitignore  |   1 -
 testcases/kernel/syscalls/bdflush/Makefile    |  23 ----
 testcases/kernel/syscalls/bdflush/bdflush01.c | 126 ------------------
 4 files changed, 152 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/bdflush/.gitignore
 delete mode 100644 testcases/kernel/syscalls/bdflush/Makefile
 delete mode 100644 testcases/kernel/syscalls/bdflush/bdflush01.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 2b8ca719b..97b93b24e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -31,8 +31,6 @@ bind01 bind01
 bind02 bind02
 bind03 bind03
 
-bdflush01 bdflush01
-
 brk01 brk01
 
 capget01 capget01
diff --git a/testcases/kernel/syscalls/bdflush/.gitignore b/testcases/kernel/syscalls/bdflush/.gitignore
deleted file mode 100644
index 54601ec2d..000000000
--- a/testcases/kernel/syscalls/bdflush/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-/bdflush01
diff --git a/testcases/kernel/syscalls/bdflush/Makefile b/testcases/kernel/syscalls/bdflush/Makefile
deleted file mode 100644
index 2ef86f06f..000000000
--- a/testcases/kernel/syscalls/bdflush/Makefile
+++ /dev/null
@@ -1,23 +0,0 @@
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
-top_srcdir		?= ../../../..
-
-include $(top_srcdir)/include/mk/testcases.mk
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/bdflush/bdflush01.c b/testcases/kernel/syscalls/bdflush/bdflush01.c
deleted file mode 100644
index 1323cc4e4..000000000
--- a/testcases/kernel/syscalls/bdflush/bdflush01.c
+++ /dev/null
@@ -1,126 +0,0 @@
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
-/* File:	bdflush01.c					    */
-/*									    */
-/* Description: bdflush() starts, flushes, or tunes the buffer-dirty-flush    */
-/*		daemon. Only a privileged process (one with the CAP_SYS_ADMIN */
-/*		capability) may call bdflush().				      */
-/*									      */
-/*		If func is negative or 0, and no daemon has been started,     */
-/*		then bdflush() enters the daemon code and never returns.      */
-/*									      */
-/*		If func is 1, some dirty buffers are written to disk.	      */
-/*		If func is 2 or more and is even (low bit is 0), then address */
-/*		is the address of a long word, and the tuning parameter       */
-/*		numbered (func-2)/2 is returned to the caller in that address.*/
-/*									      */
-/*		If func is 3 or more and is odd (low bit is 1), then data is  */
-/*		a long word, and the kernel sets tuning parameter numbered    */
-/*		(func-3)/2 to that value.				      */
-/*		    							      */
-/*		The set of parameters, their values, and their legal ranges   */
-/*		are defined in the kernel source file fs/buffer.c. 	      */
-/*									      */
-/*		Return Value:						      */
-/*		If func is negative or 0 and the daemon successfully starts,  */
-/*		bdflush() never returns. Otherwise, the return value is 0 on  */
-/*		success and -1 on failure, with errno set to indicate the     */
-/*		error.							      */
-/*									      */
-/*		Errors:							      */
-/*			EBUSY						      */
-/*			    An attempt was made to enter the daemon code after*/
-/*			    another process has already entered. 	      */
-/*			EFAULT						      */
-/*			   address points outside your accessible address     */
-/*			   space. 					      */
-/*			EINVAL						      */
-/*			    An attempt was made to read or write an invalid   */
-/*			    parameter number, or to write an invalid value to */
-/*			    a parameter. 				      */
-/*			EPERM						      */
-/*			    Caller does not have the CAP_SYS_ADMIN capability.*/
-/*									      */
-/* Usage:  <for command-line>						 */
-/* bdflush01 [-c n] [-e][-i n] [-I x] [-p x] [-t]		      */
-/*      where,  -c n : Run n copies concurrently.			     */
-/*	      -e   : Turn on errno logging.				 */
-/*	      -i n : Execute test n times.				  */
-/*	      -I x : Execute test for x seconds.			    */
-/*	      -P x : Pause for x seconds between iterations.		*/
-/*	      -t   : Turn on syscall timing.				*/
-/*									    */
-/* Total Tests: 1							     */
-/*									    */
-/* Test Name:   bdflush01					      */
-/* History:     Porting from Crackerjack to LTP is done by		    */
-/*	      Manas Kumar Nayak maknayak@in.ibm.com>			*/
-/******************************************************************************/
-#include <stdio.h>
-#include <stdlib.h>
-#include <sys/wait.h>
-#include <sys/types.h>
-#include <unistd.h>
-#include <errno.h>
-#include <sys/stat.h>
-
-#include "test.h"
-#include "lapi/syscalls.h"
-
-char *TCID = "bdflush01";
-int testno;
-int TST_TOTAL = 1;
-
-void cleanup(void)
-{
-	tst_rmdir();
-}
-
-void setup(void)
-{
-	TEST_PAUSE;
-	tst_tmpdir();
-}
-
-int main(int ac, char **av)
-{
-	long data;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	/*
-	 * TODO (garrcoop): add more functional testcases; there are a ton
-	 * missing.
-	 */
-	data = 0;
-	tst_count = 1;
-	for (testno = 0; testno < TST_TOTAL; ++testno) {
-		TEST(ltp_syscall(__NR_bdflush, 3, data));
-		if (TEST_RETURN == -1)
-			tst_brkm(TFAIL | TTERRNO, cleanup, "bdflush failed");
-		else
-			tst_resm(TPASS, "bdflush() = %ld", TEST_RETURN);
-	}
-	cleanup();
-	tst_exit();
-}
-- 
2.21.0.1020.gf2820cf01a-goog

