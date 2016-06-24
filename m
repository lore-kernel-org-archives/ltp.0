From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 24 Jun 2016 17:04:53 +0800
Subject: [LTP] [PATCH 4/4] syscalls/socketpair02: reconstruct and convert to
	new API
In-Reply-To: <1466759093-15755-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1466759093-15755-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1466759093-15755-4-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

1) take use of some SAFE Marcos
2) add SOCK_CLOEXEC introduced in socketpair()

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 .../kernel/syscalls/socketpair/socketpair02.c      | 221 ++++++++---------=
----
 1 file changed, 86 insertions(+), 135 deletions(-)

diff --git a/testcases/kernel/syscalls/socketpair/socketpair02.c b/testcase=
s/kernel/syscalls/socketpair/socketpair02.c
index f1ff463..be545b2 100644
--- a/testcases/kernel/syscalls/socketpair/socketpair02.c
+++ b/testcases/kernel/syscalls/socketpair/socketpair02.c
@@ -1,50 +1,30 @@
-/*************************************************************************=
*****/
-/*                                                                        =
    */
-/* Copyright (c) Ulrich Drepper <drepper@redhat.com>                      =
    */
-/* Copyright (c) International Business Machines  Corp., 2009             =
    */
-/*                                                                        =
    */
-/* This program is free software;  you can redistribute it and/or modify  =
    */
-/* it under the terms of the GNU General Public License as published by   =
    */
-/* the Free Software Foundation; either version 2 of the License, or      =
    */
-/* (at your option) any later version.                                    =
    */
-/*                                                                        =
    */
-/* This program is distributed in the hope that it will be useful,        =
    */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of        =
    */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See              =
    */
-/* the GNU General Public License for more details.                       =
    */
-/*                                                                        =
    */
-/* You should have received a copy of the GNU General Public License      =
    */
-/* along with this program;  if not, write to the Free Software           =
    */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-130=
1 USA    */
-/*                                                                        =
    */
-/*************************************************************************=
*****/
-/*************************************************************************=
*****/
-/*                                                                        =
    */
-/* File:        socketpair02.c                                            =
    */
-/*                                                                        =
    */
-/* Description: This Program tests the new system call introduced in 2.6.2=
7.  */
-/*              Ulrich=C2=B4s comment as in:                              =
         */
-/* http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commit;h=3D77d2720059618b9b6e827a8b73831eb6c6fad63c */
-/*                                                                        =
    */
-/* Usage:  <for command-line>                                             =
    */
-/* socketpair02 [-c n] [-e][-i n] [-I x] [-p x] [-t]                      =
    */
-/*      where,  -c n : Run n copies concurrently.                         =
    */
-/*              -e   : Turn on errno logging.                             =
    */
-/*              -i n : Execute test n times.                              =
    */
-/*              -I x : Execute test for x seconds.                        =
    */
-/*              -P x : Pause for x seconds between iterations.            =
    */
-/*              -t   : Turn on syscall timing.                            =
    */
-/*                                                                        =
    */
-/* Total Tests: 1                                                         =
    */
-/*                                                                        =
    */
-/* Test Name:   socketpair02                                              =
    */
-/*                                                                        =
    */
-/* Author:      Ulrich Drepper <drepper@redhat.com>                       =
    */
-/*                                                                        =
    */
-/* History:     Created - Jan 13 2009 - Ulrich Drepper <drepper@redhat.com=
>   */
-/*              Ported to LTP                                             =
    */
-/*                      - Jan 13 2009 - Subrata <subrata@linux.vnet.ibm.co=
m>  */
-/*************************************************************************=
*****/
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
+* Test Name:	socketpair02
+*
+* Description:
+* This Program tests the new flag SOCK_CLOEXEC and SOCK_NONBLOCK introduced
+* in socketpair() in kernel 2.6.27.
+*/
+
+#include <errno.h>
 #include <fcntl.h>
 #include <pthread.h>
 #include <stdio.h>
@@ -52,108 +32,79 @@
 #include <netinet/in.h>
 #include <sys/socket.h>
 #include <sys/syscall.h>
+#include "tst_test.h"
+
+#ifndef O_CLOEXEC
+#define O_CLOEXEC 02000000
+#endif
=20
-#include "test.h"
+#ifndef SOCK_CLOEXEC
+#define SOCK_CLOEXEC O_CLOEXEC
+#endif
=20
 #ifndef SOCK_NONBLOCK
 #define SOCK_NONBLOCK O_NONBLOCK
 #endif
=20
-int TST_TOTAL =3D 2;
-char *TCID =3D "socketpair02";
-
-/* Extern Global Functions */
-/*************************************************************************=
*****/
-/*                                                                        =
    */
-/* Function:    cleanup                                                   =
    */
-/*                                                                        =
    */
-/* Description: Performs all one time clean up for this test on successful=
    */
-/*              completion,  premature exit or  failure. Closes all tempor=
ary */
-/*              files, removes all temporary directories exits the test wi=
th  */
-/*              appropriate return code by calling tst_exit() function.   =
    */
-/*                                                                        =
    */
-/* Input:       None.                                                     =
    */
-/*                                                                        =
    */
-/* Output:      None.                                                     =
    */
-/*                                                                        =
    */
-/* Return:      On failure - Exits calling tst_exit(). Non '0' return code=
.   */
-/*              On success - Exits calling tst_exit(). With '0' return cod=
e.  */
-/*                                                                        =
    */
-/*************************************************************************=
*****/
-void cleanup(void)
-{
+static int fds[2];
=20
-	tst_rmdir();
-}
+static struct tcase {
+	int type;
+	int flag;
+	int fl_flag;
+	char *des;
+} tcases[] =3D {
+	{SOCK_STREAM, 0, F_GETFD, "no close-on-exec"},
+	{SOCK_STREAM | SOCK_CLOEXEC, FD_CLOEXEC, F_GETFD, "close-on-exec"},
+	{SOCK_STREAM, 0, F_GETFL, "no non-blocking"},
+	{SOCK_STREAM | SOCK_NONBLOCK, O_NONBLOCK, F_GETFL, "non-blocking"}
+};
=20
-/* Local  Functions */
-/*************************************************************************=
*****/
-/*                                                                        =
    */
-/* Function:    setup                                                     =
    */
-/*                                                                        =
    */
-/* Description: Performs all one time setup for this test. This function i=
s   */
-/*              typically used to capture signals, create temporary dirs  =
    */
-/*              and temporary files that may be used in the course of this=
    */
-/*              test.                                                     =
    */
-/*                                                                        =
    */
-/* Input:       None.                                                     =
    */
-/*                                                                        =
    */
-/* Output:      None.                                                     =
    */
-/*                                                                        =
    */
-/* Return:      On failure - Exits by calling cleanup().                  =
    */
-/*              On success - returns 0.                                   =
    */
-/*                                                                        =
    */
-/*************************************************************************=
*****/
-void setup(void)
+static void verify_socketpair(unsigned int n)
 {
-	/* Capture signals if any */
-	/* Create temporary directories */
-	TEST_PAUSE;
-	tst_tmpdir();
-}
+	int res, i;
+	struct tcase *tc =3D &tcases[n];
=20
-int main(int argc, char *argv[])
-{
-	int fds[2], fl, i;
+	TEST(socketpair(PF_UNIX, tc->type, 0, fds));
=20
-	if ((tst_kvercmp(2, 6, 27)) < 0) {
-		tst_brkm(TCONF, NULL,
-			 "This test can only run on kernels that are 2.6.27 and higher");
-	}
-	setup();
+	if (TEST_RETURN =3D=3D -1)
+		tst_brk(TFAIL | TTERRNO, "socketpair() failed");
=20
-	if (socketpair(PF_UNIX, SOCK_STREAM, 0, fds) =3D=3D -1) {
-		tst_brkm(TFAIL, cleanup, "socketpair(0) failed");
-	}
-	for (i =3D 0; i < ARRAY_SIZE(fds); i++) {
-		fl =3D fcntl(fds[i], F_GETFL);
-		if (fl =3D=3D -1) {
-			tst_brkm(TBROK, cleanup, "fcntl failed");
-		}
-		if (fl & O_NONBLOCK) {
-			tst_brkm(TFAIL, cleanup,
-				 "socketpair(0) set non-blocking mode for fds[%d]",
-				 i);
-		}
-		close(fds[i]);
-	}
+	for (i =3D 0; i < 2; i++) {
+		res =3D SAFE_FCNTL(fds[i], tc->fl_flag);
=20
-	if (socketpair(PF_UNIX, SOCK_STREAM | SOCK_NONBLOCK, 0, fds) =3D=3D -1) {
-		tst_brkm(TFAIL, cleanup, "socketpair(SOCK_NONBLOCK) failed");
-	}
-	for (i =3D 0; i < ARRAY_SIZE(fds); i++) {
-		fl =3D fcntl(fds[i], F_GETFL);
-		if (fl =3D=3D -1) {
-			tst_brkm(TBROK, cleanup, "fcntl failed");
+		if (tc->flag !=3D 0 && (res & tc->flag) =3D=3D 0) {
+			tst_brk(TFAIL, "socketpair() failed to set %s flag for fds[%d]",
+				tc->des, i);
+			return;
 		}
-		if ((fl & O_NONBLOCK) =3D=3D 0) {
-			tst_brkm(TFAIL, cleanup,
-				 "socketpair(SOCK_NONBLOCK) didn't set non-blocking "
-				 "mode for fds[%d]", i);
+
+		if (tc->flag =3D=3D 0 && (res & tc->flag) !=3D 0) {
+			tst_brk(TFAIL, "socketpair() failed to set %s flag for fds[%d]",
+				tc->des, i);
+			return;
 		}
-		close(fds[i]);
 	}
-	tst_resm(TPASS, "socketpair(SOCK_NONBLOCK) PASSED");
-	cleanup();
-	tst_exit();
+
+	tst_res(TPASS, "socketpair() passed to set %s flag", tc->des);
+
+	SAFE_CLOSE(fds[0]);
+	SAFE_CLOSE(fds[1]);
 }
+
+static void cleanup(void)
+{
+	if (fds[0] > 0 && close(fds[0]))
+		tst_res(TWARN | TERRNO, "failed to close file");
+
+	if (fds[1] > 0 && close(fds[1]))
+		tst_res(TWARN | TERRNO, "failed to close file");
+}
+
+static struct tst_test test =3D {
+	.tid =3D "socketpair02",
+	.tcnt =3D ARRAY_SIZE(tcases),
+	.test =3D verify_socketpair,
+	.min_kver =3D "2.6.27",
+	.cleanup =3D cleanup
+};
--=20
1.8.3.1



