From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 24 Jun 2016 17:04:51 +0800
Subject: [LTP] [PATCH 2/4] syscalls/socket02: reconstruct and convert to new
	API
In-Reply-To: <1466759093-15755-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1466759093-15755-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1466759093-15755-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

1) take use of some SAFE Marcos
2) remove SOCK_CLOEXEC introduced in socketpair()
3) merge socket03 into socket02

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/syscalls                            |   1 -
 testcases/kernel/syscalls/.gitignore        |   1 -
 testcases/kernel/syscalls/socket/socket02.c | 276 ++++++++--------------------
 testcases/kernel/syscalls/socket/socket03.c | 168 -----------------
 4 files changed, 78 insertions(+), 368 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/socket/socket03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 428b774..bf4338d 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1188,7 +1188,6 @@ sigsuspend01 sigsuspend01
 
 socket01 socket01
 socket02 socket02
-socket03 socket03
 
 socketcall01 socketcall01
 socketcall02 socketcall02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 81f4890..7fe87d2 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -948,7 +948,6 @@
 /sigwaitinfo/sigwaitinfo01
 /socket/socket01
 /socket/socket02
-/socket/socket03
 /socketcall/socketcall01
 /socketcall/socketcall02
 /socketcall/socketcall03
diff --git a/testcases/kernel/syscalls/socket/socket02.c b/testcases/kernel/syscalls/socket/socket02.c
index 259f0e3..f6473d5 100644
--- a/testcases/kernel/syscalls/socket/socket02.c
+++ b/testcases/kernel/syscalls/socket/socket02.c
@@ -1,219 +1,99 @@
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
-/* File:        socket02.c                                                    */
-/*                                                                            */
-/* Description: This program tests the new flag SOCK_CLOEXEC introduced in    */
-/*              socket() & socketpair() and in kernel 2.6.27. Ulrich´s comment*/
-/*              as in:                                                        */
-/*              http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=a677a039be7243357d93502bff2b40850c942e2d */
-/*              says:                                                         */
-/*                                                                            */
-/*              flag parameters: socket and socketpair                        */
-/*              This patch adds support for flag values which are ORed to the */
-/*              type passwd to socket and socketpair.  The additional code is */
-/*              minimal. The flag values in this implementation can and must  */
-/*              match the O_* flags. This avoids overhead in the conversion.  */
-/*              The internal functions sock_alloc_fd and sock_map_fd get a new*/
-/*              parameters and all callers are changed.                       */
-/*                                                                            */
-/* Usage:  <for command-line>                                                 */
-/*  socket02 [-c n] [-e][-i n] [-I x] [-p x] [-t]                             */
-/*      where,  -c n : Run n copies concurrently.                             */
-/*              -e   : Turn on errno logging.                                 */
-/*              -i n : Execute test n times.                                  */
-/*              -I x : Execute test for x seconds.                            */
-/*              -P x : Pause for x seconds between iterations.                */
-/*              -t   : Turn on syscall timing.                                */
-/*                                                                            */
-/* Total Tests: 1                                                             */
-/*                                                                            */
-/* Test Name:   socket02                                                      */
-/*                                                                            */
-/* Author:      Ulrich Drepper <drepper@redhat.com>                           */
-/*                                                                            */
-/* History:     Created - Jan 05 2009 - Ulrich Drepper <drepper@redhat.com>   */
-/*              Ported to LTP                                                 */
-/*                      - Jan 05 2009 - Subrata <subrata@linux.vnet.ibm.com>  */
-/******************************************************************************/
+/*
+* Copyright (c) Ulrich Drepper <drepper@redhat.com>
+* Copyright (c) International Business Machines  Corp., 2009
+*
+* This program is free software;  you can redistribute it and/or modify
+* it under the terms of the GNU General Public License as published by
+* the Free Software Foundation; either version 2 of the License, or
+* (at your option) any later version.
+*
+* This program is distributed in the hope that it will be useful,
+* but WITHOUT ANY WARRANTY;  without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+* the GNU General Public License for more details.
+*
+* You should have received a copy of the GNU General Public License
+* along with this program.
+*/
+
+/*
+* Test Name:	socket02
+*
+* Description:
+* This program tests the new flag SOCK_CLOEXEC and SOCK_NONBLOCK introduced
+* in socket() in kernel 2.6.27.
+*/
 
 #include <fcntl.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <netinet/in.h>
 #include <sys/socket.h>
-
-#include "test.h"
 #include "lapi/fcntl.h"
+#include "tst_test.h"
 
-#define PORT 57392
+#ifndef O_CLOEXEC
+#define O_CLOEXEC 02000000
+#endif
 
-/* For Linux these must be the same.  */
 #ifndef SOCK_CLOEXEC
 #define SOCK_CLOEXEC O_CLOEXEC
 #endif
 
-char *TCID = "socket02";
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
+#ifndef SOCK_NONBLOCK
+#define SOCK_NONBLOCK O_NONBLOCK
+#endif
 
-	tst_rmdir();
+static int fd;
 
-}
+static struct tcase {
+	int type;
+	int flag;
+	int fl_flag;
+	char *des;
+} tcases[] = {
+	{SOCK_STREAM, 0, F_GETFD, "no close-on-exec"},
+	{SOCK_STREAM | SOCK_CLOEXEC, FD_CLOEXEC, F_GETFD, "close-on-exec"},
+	{SOCK_STREAM, 0, F_GETFL, "no non-blocking"},
+	{SOCK_STREAM | SOCK_NONBLOCK, O_NONBLOCK, F_GETFL, "non-blocking"}
+};
 
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
+static void verify_socket(unsigned int n)
 {
-	/* Capture signals if any */
-	/* Create temporary directories */
-	TEST_PAUSE;
-	tst_tmpdir();
-}
+	int res;
+	struct tcase *tc = &tcases[n];
 
-int main(int argc, char *argv[])
-{
-	int fd, fds[2], i, coe;
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-	if ((tst_kvercmp(2, 6, 27)) < 0) {
-		tst_brkm(TCONF,
-			 NULL,
-			 "This test can only run on kernels that are 2.6.27 and higher");
+	fd = socket(PF_INET, tc->type, 0);
+	if (fd == -1)
+		tst_brk(TFAIL | TERRNO, "socket() failed");
+
+	res = SAFE_FCNTL(fd, tc->fl_flag);
+
+	if (tc->flag != 0 && (res & tc->flag) == 0) {
+		tst_res(TFAIL, "socket() failed to set %s flag", tc->des);
+		return;
 	}
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		tst_count = 0;
-		for (testno = 0; testno < TST_TOTAL; ++testno) {
-			fd = socket(PF_INET, SOCK_STREAM, 0);
-			if (fd == -1) {
-				tst_brkm(TBROK, cleanup, "socket(0) failed");
-			}
-			coe = fcntl(fd, F_GETFD);
-			if (coe == -1) {
-				tst_brkm(TBROK, cleanup, "fcntl failed");
-			}
-			if (coe & FD_CLOEXEC) {
-				tst_brkm(TFAIL,
-					 cleanup,
-					 "socket(0) set close-on-exec flag");
-			}
-			close(fd);
-
-			fd = socket(PF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
-			if (fd == -1) {
-				tst_brkm(TFAIL, cleanup,
-					 "socket(SOCK_CLOEXEC) failed");
-			}
-			coe = fcntl(fd, F_GETFD);
-			if (coe == -1) {
-				tst_brkm(TBROK, cleanup, "fcntl failed");
-			}
-			if ((coe & FD_CLOEXEC) == 0) {
-				tst_brkm(TFAIL,
-					 cleanup,
-					 "socket(SOCK_CLOEXEC) does not set close-on-exec flag");
-			}
-			close(fd);
-
-			if (socketpair(PF_UNIX, SOCK_STREAM, 0, fds) == -1) {
-				tst_brkm(TBROK, cleanup,
-					 "socketpair(0) failed");
-			}
-			for (i = 0; i < 2; ++i) {
-				coe = fcntl(fds[i], F_GETFD);
-				if (coe == -1) {
-					tst_brkm(TBROK, cleanup,
-						 "fcntl failed");
-				}
-				if (coe & FD_CLOEXEC) {
-					tst_brkm(TFAIL,
-						 cleanup, "socketpair(0) set close-on-exec flag for fds[%d]\n",
-						 i);
-				}
-				close(fds[i]);
-			}
-
-			if (socketpair
-			    (PF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0,
-			     fds) == -1) {
-				tst_brkm(TBROK, cleanup,
-					 "socketpair(SOCK_CLOEXEC) failed");
-			}
-			for (i = 0; i < 2; ++i) {
-				coe = fcntl(fds[i], F_GETFD);
-				if (coe == -1) {
-					tst_brkm(TBROK, cleanup,
-						 "fcntl failed");
-				}
-				if ((coe & FD_CLOEXEC) == 0) {
-					tst_brkm(TFAIL,
-						 cleanup, "socketpair(SOCK_CLOEXEC) does not set close-on-exec flag for fds[%d]\n",
-						 i);
-				}
-				close(fds[i]);
-			}
-			tst_resm(TPASS, "socket(SOCK_CLOEXEC) PASSED");
-			cleanup();
-		}
+
+	if (tc->flag == 0 && (res & tc->flag) != 0) {
+		tst_res(TFAIL, "socket() failed to set %s flag", tc->des);
+		return;
 	}
-	tst_exit();
+
+	tst_res(TPASS, "socket() passed to set %s flag", tc->des);
+
+	SAFE_CLOSE(fd);
 }
+
+static void cleanup(void)
+{
+	if (fd > 0 && close(fd))
+		tst_res(TWARN | TERRNO, "failed to close file");
+}
+
+static struct tst_test test = {
+	.tid = "socket02",
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_socket,
+	.min_kver = "2.6.27",
+	.cleanup = cleanup
+};
diff --git a/testcases/kernel/syscalls/socket/socket03.c b/testcases/kernel/syscalls/socket/socket03.c
deleted file mode 100644
index 2f069f2..0000000
--- a/testcases/kernel/syscalls/socket/socket03.c
+++ /dev/null
@@ -1,168 +0,0 @@
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
-/* File:        socket03.c                                                    */
-/*                                                                            */
-/* Description: This Program tests the new system call introduced in 2.6.27.  */
-/*              Ulrich´s comment as in:                                       */
-/* http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=77d2720059618b9b6e827a8b73831eb6c6fad63c */
-/*                                                                            */
-/* Usage:  <for command-line>                                                 */
-/* socket03 [-c n] [-e][-i n] [-I x] [-p x] [-t]                      */
-/*      where,  -c n : Run n copies concurrently.                             */
-/*              -e   : Turn on errno logging.                                 */
-/*              -i n : Execute test n times.                                  */
-/*              -I x : Execute test for x seconds.                            */
-/*              -P x : Pause for x seconds between iterations.                */
-/*              -t   : Turn on syscall timing.                                */
-/*                                                                            */
-/* Total Tests: 1                                                             */
-/*                                                                            */
-/* Test Name:   socket03                                                      */
-/*                                                                            */
-/* Author:      Ulrich Drepper <drepper@redhat.com>                           */
-/*                                                                            */
-/* History:     Created - Jan 13 2009 - Ulrich Drepper <drepper@redhat.com>   */
-/*              Ported to LTP                                                 */
-/*                      - Jan 13 2009 - Subrata <subrata@linux.vnet.ibm.com>  */
-/******************************************************************************/
-#include <fcntl.h>
-#include <pthread.h>
-#include <stdio.h>
-#include <unistd.h>
-#include <netinet/in.h>
-#include <sys/socket.h>
-#include <sys/syscall.h>
-
-#include "test.h"
-
-#ifndef SOCK_NONBLOCK
-#define SOCK_NONBLOCK O_NONBLOCK
-#endif
-
-char *TCID = "socket03";
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
-	int fd, fl;
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
-			fd = socket(PF_INET, SOCK_STREAM, 0);
-			if (fd == -1) {
-				tst_brkm(TFAIL, cleanup, "socket(0) failed");
-			}
-			fl = fcntl(fd, F_GETFL);
-			if (fl == -1) {
-				tst_brkm(TBROK, cleanup, "fcntl failed");
-			}
-			if (fl & O_NONBLOCK) {
-				tst_brkm(TFAIL,
-					 cleanup,
-					 "socket(0) set non-blocking mode");
-			}
-			close(fd);
-
-			fd = socket(PF_INET, SOCK_STREAM | SOCK_NONBLOCK, 0);
-			if (fd == -1) {
-				tst_brkm(TFAIL, cleanup,
-					 "socket(SOCK_NONBLOCK) failed");
-			}
-			fl = fcntl(fd, F_GETFL);
-			if (fl == -1) {
-				tst_brkm(TBROK, cleanup, "fcntl failed");
-			}
-			if ((fl & O_NONBLOCK) == 0) {
-				tst_brkm(TFAIL,
-					 cleanup,
-					 "socket(SOCK_NONBLOCK) does not set non-blocking mode");
-			}
-			close(fd);
-			tst_resm(TPASS, "socket(SOCK_NONBLOCK) PASSED");
-			cleanup();
-		}
-	}
-	tst_exit();
-}
-- 
1.8.3.1



