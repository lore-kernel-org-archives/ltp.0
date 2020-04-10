From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 10 Apr 2020 16:52:50 +0800
Subject: [LTP] [PATCH] syscalls/pipe2_01: convert into new API
Message-ID: <1586508770-8662-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Also, merge pipe2_02.c into this case and use SAFE_PIPE2 macro(it is in
review). I have a kernel doubt when using O_DIRECT flag, for read side,
it is ignore as below:
fs/pipe.c
create_pipe_files(...)
....
res[0] = alloc_file_clone(f, O_RDONLY | (flags & O_NONBLOCK),
                                  &pipefifo_fops)

In internal, this O_DIRECT flag is used to set flag with buf as below:
 if (is_packetized(filp)) {
        buf->ops = &packet_pipe_buf_ops;
        buf->flags = PIPE_BUF_FLAG_PACKET;
}

but we can set this flag in read side by fcntl with SETFL, GETFL command can
get this flag correctly. Do we should remove this filter for O_DIRECT flag in res[0]?
Or, I should skip this sub test when using O_DIRECT flag for read side?

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 runtest/syscalls                           |   1 -
 testcases/kernel/syscalls/pipe2/.gitignore |   1 -
 testcases/kernel/syscalls/pipe2/pipe2_01.c | 228 +++++----------------
 testcases/kernel/syscalls/pipe2/pipe2_02.c | 175 ----------------
 4 files changed, 52 insertions(+), 353 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/pipe2/pipe2_02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 5607ae9a3..d3edc1126 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -919,7 +919,6 @@ pipe12 pipe12
 pipe13 pipe13
 
 pipe2_01 pipe2_01
-pipe2_02 pipe2_02
 pipe2_03 pipe2_03
 
 pivot_root01 pivot_root01
diff --git a/testcases/kernel/syscalls/pipe2/.gitignore b/testcases/kernel/syscalls/pipe2/.gitignore
index 01d980dba..e54774705 100644
--- a/testcases/kernel/syscalls/pipe2/.gitignore
+++ b/testcases/kernel/syscalls/pipe2/.gitignore
@@ -1,3 +1,2 @@
 /pipe2_01
-/pipe2_02
 /pipe2_03
diff --git a/testcases/kernel/syscalls/pipe2/pipe2_01.c b/testcases/kernel/syscalls/pipe2/pipe2_01.c
index 5f3ad8f0f..af86e4c35 100644
--- a/testcases/kernel/syscalls/pipe2/pipe2_01.c
+++ b/testcases/kernel/syscalls/pipe2/pipe2_01.c
@@ -1,186 +1,62 @@
-/******************************************************************************/
-/*                                                                            */
-/* Copyright (c) Ulrich Drepper <drepper@redhat.com>                          */
-/* Copyright (c) International Business Machines  Corp., 2009                 */
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
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/******************************************************************************/
-/******************************************************************************/
-/*                                                                            */
-/* File:        pipe2_01.c                                                    */
-/*                                                                            */
-/* Description: This Program tests the new system call introduced in 2.6.27.  */
-/*              Ulrich??s comment as in:                                       */
-/* http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=ed8cae8ba01348bfd83333f4648dd807b04d7f08 */
-/*              says:                                                         */
-/* This patch introduces the new syscall pipe2 which is like pipe but it also */
-/* takes an additional parameter which takes a flag value.  This patch        */
-/* implements the handling of O_CLOEXEC for the flag.  I did not add support  */
-/* for the new syscall for the architectures which have a special sys_pipe    */
-/* implementation.  I think the maintainers of those archs have the chance to */
-/* go with the unified implementation but that's up to them.                  */
-/*                                                                            */
-/* The implementation introduces do_pipe_flags.  I did that instead of        */
-/* changing all callers of do_pipe because some of the callers are written in */
-/* assembler. I would probably screw up changing the assembly code.  To avoid */
-/* breaking code do_pipe is now a small wrapper around do_pipe_flags.  Once   */
-/* all callers are changed over to do_pipe_flags the old do_pipe function can */
-/* be removed.                                                                */
-/* The following test must be adjusted for architectures other than x86 and   */
-/* x86-64 and in case the syscall numbers changed.                            */
-/*                                                                            */
-/* Usage:  <for command-line>                                                 */
-/* pipe2_01 [-c n] [-e][-i n] [-I x] [-p x] [-t]                              */
-/*      where,  -c n : Run n copies concurrently.                             */
-/*              -e   : Turn on errno logging.                                 */
-/*              -i n : Execute test n times.                                  */
-/*              -I x : Execute test for x seconds.                            */
-/*              -P x : Pause for x seconds between iterations.                */
-/*              -t   : Turn on syscall timing.                                */
-/*                                                                            */
-/* Total Tests: 1                                                             */
-/*                                                                            */
-/* Test Name:   pipe2_01                                                      */
-/*                                                                            */
-/* Author:      Ulrich Drepper <drepper@redhat.com>                           */
-/*                                                                            */
-/* History:     Created - Jan 13 2009 - Ulrich Drepper <drepper@redhat.com>   */
-/*              Ported to LTP                                                 */
-/*                      - Jan 13 2009 - Subrata <subrata@linux.vnet.ibm.com>  */
-/******************************************************************************/
-#include <fcntl.h>
+// SPDX-License-Identifier: GPL-2.0-or-late
+/*
+ * Copyright (c) Ulrich Drepper <drepper@redhat.com>
+ * Copyright (c) International Business Machines  Corp., 2009
+ *
+ * Author: Ulrich Drepper <drepper@redhat.com>
+ *
+ * History:
+ * Created - Jan 13 2009 - Ulrich Drepper <drepper@redhat.com>
+ * Ported to LTP - Jan 13 2009 - Subrata <subrata@linux.vnet.ibm.com>
+ */
+#define _GNU_SOURCE
 #include <stdio.h>
 #include <unistd.h>
-#include <sys/syscall.h>
-#include <errno.h>
-
-#include "test.h"
 #include "lapi/fcntl.h"
-#include "lapi/syscalls.h"
-
-char *TCID = "pipe2_01";
-int testno;
-int TST_TOTAL = 1;
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
-void cleanup(void)
-{
-
-	tst_rmdir();
-
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
-void setup(void)
+#include "tst_test.h"
+
+static int fds[2];
+
+static struct tcase {
+	int flags;
+	int check_cmd;
+	char *message;
+} tcases[] = {
+	{0, F_GETFD, "Test pipe2 with 0 flag"},
+	{O_CLOEXEC, F_GETFD, "Test pipe2 using O_CLOEXEC flag"},
+	{O_DIRECT, F_GETFL, "Test pipe2 using O_DIRECT flag"},
+	{O_NONBLOCK, F_GETFL, "Test pipe2 using O_NONBLOCK flag"},
+};
+
+static void cleanup(void)
 {
-	/* Capture signals if any */
-	/* Create temporary directories */
-	TEST_PAUSE;
-	tst_tmpdir();
+	if (fds[0] > 0)
+		SAFE_CLOSE(fds[0]);
+	if (fds[1] > 1)
+		SAFE_CLOSE(fds[1]);
 }
 
-int main(int argc, char *argv[])
+static void verify_pipe2(unsigned int n)
 {
-	int fd[2], i, coe;
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-	if ((tst_kvercmp(2, 6, 27)) < 0) {
-		tst_brkm(TCONF,
-			 NULL,
-			 "This test can only run on kernels that are 2.6.27 and higher");
+	struct tcase *tc = &tcases[n];
+	int get_flag = 0, i = 0;
+
+	tst_res(TINFO, "%s ", tc->message);
+	for (i = 0; i < 2; i++) {
+		SAFE_PIPE2(fds, tc->flags);
+		get_flag = SAFE_FCNTL(fds[i], tc->check_cmd);
+		if ((get_flag && tc->flags) || (tc->flags == get_flag))
+			tst_res(TPASS, "pipe2 fds[%d] gets expected flag(%d)", i, tc->flags);
+		else
+			tst_res(TFAIL, "pipe2 fds[%d] doesn't get expected flag(%d), get flag(%d)",
+					i, tc->flags, get_flag);
 	}
-	setup();
+	cleanup();
+}
 
-	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		tst_count = 0;
-		for (testno = 0; testno < TST_TOTAL; ++testno) {
-			if (ltp_syscall(__NR_pipe2, fd, 0) != 0) {
-				tst_brkm(TFAIL, cleanup, "pipe2(0) failed");
-			}
-			for (i = 0; i < 2; ++i) {
-				coe = fcntl(fd[i], F_GETFD);
-				if (coe == -1) {
-					tst_brkm(TBROK, cleanup,
-						 "fcntl failed");
-				}
-				if (coe & FD_CLOEXEC) {
-					tst_brkm(TFAIL,
-						 cleanup, "pipe2(0) set close-on-exit for fd[%d]",
-						 i);
-				}
-			}
-			close(fd[0]);
-			close(fd[1]);
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_pipe2,
+	.cleanup = cleanup,
+};
 
-			if (ltp_syscall(__NR_pipe2, fd, O_CLOEXEC) != 0) {
-				tst_brkm(TFAIL, cleanup,
-					 "pipe2(O_CLOEXEC) failed");
-			}
-			for (i = 0; i < 2; ++i) {
-				coe = fcntl(fd[i], F_GETFD);
-				if (coe == -1) {
-					tst_brkm(TBROK, cleanup,
-						 "fcntl failed");
-				}
-				if ((coe & FD_CLOEXEC) == 0) {
-					tst_brkm(TFAIL,
-						 cleanup, "pipe2(O_CLOEXEC) does not set close-on-exit for fd[%d]",
-						 i);
-				}
-			}
-			close(fd[0]);
-			close(fd[1]);
-			tst_resm(TPASS, "pipe2(O_CLOEXEC) PASSED");
-			cleanup();
-		}
-	}
-	tst_exit();
-}
diff --git a/testcases/kernel/syscalls/pipe2/pipe2_02.c b/testcases/kernel/syscalls/pipe2/pipe2_02.c
deleted file mode 100644
index 39f02ff8c..000000000
--- a/testcases/kernel/syscalls/pipe2/pipe2_02.c
+++ /dev/null
@@ -1,175 +0,0 @@
-/******************************************************************************/
-/*                                                                            */
-/* Copyright (c) Ulrich Drepper <drepper@redhat.com>                          */
-/* Copyright (c) International Business Machines  Corp., 2009                 */
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
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/******************************************************************************/
-/******************************************************************************/
-/*                                                                            */
-/* File:        pipe2_02.c                                                    */
-/*                                                                            */
-/* Description: This Program tests the new system call introduced in 2.6.27.  */
-/*              Ulrich??s comment as in:                                       */
-/* http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=be61a86d7237dd80510615f38ae21d6e1e98660c */
-/* which says:                                                                */
-/* This patch adds O_NONBLOCK support to pipe2.  It is minimally more involved*/
-/* than the patches for eventfd et.al but still trivial.  The interfaces of   */
-/* the create_write_pipe and create_read_pipe helper functions were changed   */
-/* and the one other caller as well.                                          */
-/* The following test must be adjusted for architectures other than x86 and   */
-/* x86-64 and in case the syscall numbers changed.                            */
-/*                                                                            */
-/* Usage:  <for command-line>                                                 */
-/* pipe2_02 [-c n] [-e][-i n] [-I x] [-p x] [-t]                              */
-/*      where,  -c n : Run n copies concurrently.                             */
-/*              -e   : Turn on errno logging.                                 */
-/*              -i n : Execute test n times.                                  */
-/*              -I x : Execute test for x seconds.                            */
-/*              -P x : Pause for x seconds between iterations.                */
-/*              -t   : Turn on syscall timing.                                */
-/*                                                                            */
-/* Total Tests: 1                                                             */
-/*                                                                            */
-/* Test Name:   pipe2_02                                                      */
-/*                                                                            */
-/* Author:      Ulrich Drepper <drepper@redhat.com>                           */
-/*                                                                            */
-/* History:     Created - Jan 13 2009 - Ulrich Drepper <drepper@redhat.com>   */
-/*              Ported to LTP                                                 */
-/*                      - Jan 13 2009 - Subrata <subrata@linux.vnet.ibm.com>  */
-/******************************************************************************/
-#include <fcntl.h>
-#include <stdio.h>
-#include <unistd.h>
-#include <sys/syscall.h>
-#include <errno.h>
-
-#include "test.h"
-#include "lapi/fcntl.h"
-#include "lapi/syscalls.h"
-
-char *TCID = "pipe2_02";
-int testno;
-int TST_TOTAL = 1;
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
-void cleanup(void)
-{
-
-	tst_rmdir();
-
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
-void setup(void)
-{
-	/* Capture signals if any */
-	/* Create temporary directories */
-	TEST_PAUSE;
-	tst_tmpdir();
-}
-
-int main(int argc, char *argv[])
-{
-	int fds[2], fl, i;
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-	if ((tst_kvercmp(2, 6, 27)) < 0) {
-		tst_brkm(TCONF,
-			 NULL,
-			 "This test can only run on kernels that are 2.6.27 and higher");
-	}
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		tst_count = 0;
-		for (testno = 0; testno < TST_TOTAL; ++testno) {
-			if (ltp_syscall(__NR_pipe2, fds, 0) == -1) {
-				tst_brkm(TFAIL, cleanup, "pipe2(0) failed");
-			}
-			for (i = 0; i < 2; ++i) {
-				fl = fcntl(fds[i], F_GETFL);
-				if (fl == -1) {
-					tst_brkm(TBROK, cleanup,
-						 "fcntl failed");
-				}
-				if (fl & O_NONBLOCK) {
-					tst_brkm(TFAIL,
-						 cleanup, "pipe2(0) set non-blocking mode for fds[%d]",
-						 i);
-				}
-				close(fds[i]);
-			}
-
-			if (ltp_syscall(__NR_pipe2, fds, O_NONBLOCK) == -1) {
-				tst_brkm(TFAIL, cleanup,
-					 "pipe2(O_NONBLOCK) failed");
-			}
-			for (i = 0; i < 2; ++i) {
-				fl = fcntl(fds[i], F_GETFL);
-				if (fl == -1) {
-					tst_brkm(TBROK, cleanup,
-						 "fcntl failed");
-				}
-				if ((fl & O_NONBLOCK) == 0) {
-					tst_brkm(TFAIL,
-						 cleanup, "pipe2(O_NONBLOCK) does not set non-blocking mode for fds[%d]\n",
-						 i);
-				}
-				close(fds[i]);
-			}
-			tst_resm(TPASS, "pipe2(O_NONBLOCK) PASSED");
-			cleanup();
-		}
-	}
-	tst_exit();
-}
-- 
2.23.0



