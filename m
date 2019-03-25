From: Sandeep Patil <sspatil@android.com>
Date: Mon, 25 Mar 2019 16:20:11 -0700
Subject: [LTP] [PATCH 3/4] syscalls/accept4: convert to new library
In-Reply-To: <20190325232012.67123-1-sspatil@android.com>
References: <20190325232012.67123-1-sspatil@android.com>
Message-ID: <20190325232012.67123-4-sspatil@android.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Remove all debug checks and simplify the test.

Signed-off-by: Sandeep Patil <sspatil@android.com>
---
 .../kernel/syscalls/accept4/accept4_01.c      | 241 ++++++------------
 1 file changed, 81 insertions(+), 160 deletions(-)

diff --git a/testcases/kernel/syscalls/accept4/accept4_01.c b/testcases/kernel/syscalls/accept4/accept4_01.c
index dec4ef93b..036457571 100644
--- a/testcases/kernel/syscalls/accept4/accept4_01.c
+++ b/testcases/kernel/syscalls/accept4/accept4_01.c
@@ -1,23 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
 /*
- *
  * Copyright (C) 2008, Linux Foundation,
  * written by Michael Kerrisk <mtk.manpages@gmail.com>
  * Initial Porting to LTP by Subrata <subrata@linux.vnet.ibm.com>
  *
- * Licensed under the GNU GPLv2 or later.
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 #define _GNU_SOURCE
@@ -31,14 +18,12 @@
 #include <string.h>
 #include <errno.h>
 
-#include "test.h"
+#include "tst_test.h"
 #include "lapi/fcntl.h"
 #include "lapi/syscalls.h"
 
 #define PORT_NUM 33333
 
-#define die(msg)	tst_brkm(TBROK|TERRNO, cleanup, msg)
-
 #ifndef SOCK_CLOEXEC
 #define SOCK_CLOEXEC    O_CLOEXEC
 #endif
@@ -50,39 +35,13 @@
 #define USE_SOCKETCALL 1
 #endif
 
-char *TCID = "accept04_01";
-int TST_TOTAL = 1;
-
-static void setup(void)
-{
-	TEST_PAUSE;
-	tst_tmpdir();
-}
-
-static void cleanup(void)
-{
-	tst_rmdir();
-}
+struct sockaddr_in conn_addr;
+int listening_fd;
 
 #if !(__GLIBC_PREREQ(2, 10))
 static int
 accept4_01(int fd, struct sockaddr *sockaddr, socklen_t *addrlen, int flags)
 {
-#ifdef DEBUG
-	tst_resm(TINFO, "Calling accept4(): flags = %x", flags);
-	if (flags != 0) {
-		tst_resm(TINFO, " (");
-		if (flags & SOCK_CLOEXEC)
-			tst_resm(TINFO, "SOCK_CLOEXEC");
-		if ((flags & SOCK_CLOEXEC) && (flags & SOCK_NONBLOCK))
-			tst_resm(TINFO, " ");
-		if (flags & SOCK_NONBLOCK)
-			tst_resm(TINFO, "SOCK_NONBLOCK");
-		tst_resm(TINFO, ")");
-	}
-	tst_resm(TINFO, "\n");
-#endif
-
 #if USE_SOCKETCALL
 	long args[6];
 
@@ -98,79 +57,7 @@ accept4_01(int fd, struct sockaddr *sockaddr, socklen_t *addrlen, int flags)
 }
 #endif
 
-static void
-do_test(int lfd, struct sockaddr_in *conn_addr,
-	int closeonexec_flag, int nonblock_flag)
-{
-	int connfd, acceptfd;
-	int fdf, flf, fdf_pass, flf_pass;
-	struct sockaddr_in claddr;
-	socklen_t addrlen;
-
-#ifdef DEBUG
-	tst_resm(TINFO, "=======================================\n");
-#endif
-
-	connfd = socket(AF_INET, SOCK_STREAM, 0);
-	if (connfd == -1)
-		die("Socket Error");
-	if (connect(connfd, (struct sockaddr *)conn_addr,
-		    sizeof(struct sockaddr_in)) == -1)
-		die("Connect Error");
-
-	addrlen = sizeof(struct sockaddr_in);
-#if !(__GLIBC_PREREQ(2, 10))
-	acceptfd = accept4_01(lfd, (struct sockaddr *)&claddr, &addrlen,
-			      closeonexec_flag | nonblock_flag);
-#else
-	acceptfd = accept4(lfd, (struct sockaddr *)&claddr, &addrlen,
-			   closeonexec_flag | nonblock_flag);
-#endif
-	if (acceptfd == -1) {
-		if (errno == ENOSYS) {
-			tst_brkm(TCONF, cleanup,
-			         "syscall __NR_accept4 not supported");
-		} else {
-			tst_brkm(TBROK | TERRNO, cleanup, "accept4 failed");
-		}
-	}
-
-	fdf = fcntl(acceptfd, F_GETFD);
-	if (fdf == -1)
-		die("fcntl:F_GETFD");
-	fdf_pass = ((fdf & FD_CLOEXEC) != 0) ==
-	    ((closeonexec_flag & SOCK_CLOEXEC) != 0);
-#ifdef DEBUG
-	tst_resm(TINFO, "Close-on-exec flag is %sset (%s); ",
-		 (fdf & FD_CLOEXEC) ? "" : "not ", fdf_pass ? "OK" : "failed");
-#endif
-	if (!fdf_pass)
-		tst_resm(TFAIL,
-			 "Close-on-exec flag mismatch, should be %x, actual %x",
-			 fdf & FD_CLOEXEC, closeonexec_flag & SOCK_CLOEXEC);
-
-	flf = fcntl(acceptfd, F_GETFL);
-	if (flf == -1)
-		die("fcntl:F_GETFD");
-	flf_pass = ((flf & O_NONBLOCK) != 0) ==
-	    ((nonblock_flag & SOCK_NONBLOCK) != 0);
-#ifdef DEBUG
-	tst_resm(TINFO, "nonblock flag is %sset (%s)\n",
-		 (flf & O_NONBLOCK) ? "" : "not ", flf_pass ? "OK" : "failed");
-#endif
-	if (!flf_pass)
-		tst_resm(TFAIL,
-			 "nonblock flag mismatch, should be %x, actual %x",
-			 fdf & O_NONBLOCK, nonblock_flag & SOCK_NONBLOCK);
-
-	close(acceptfd);
-	close(connfd);
-
-	if (fdf_pass && flf_pass)
-		tst_resm(TPASS, "Test passed");
-}
-
-static int create_listening_socket(int port_num)
+static int create_listening_socket(void)
 {
 	struct sockaddr_in svaddr;
 	int lfd;
@@ -179,65 +66,99 @@ static int create_listening_socket(int port_num)
 	memset(&svaddr, 0, sizeof(struct sockaddr_in));
 	svaddr.sin_family = AF_INET;
 	svaddr.sin_addr.s_addr = htonl(INADDR_ANY);
-	svaddr.sin_port = htons(port_num);
+	svaddr.sin_port = htons(PORT_NUM);
 
-	lfd = socket(AF_INET, SOCK_STREAM, 0);
-	if (lfd == -1)
-		die("Socket Error");
+	lfd = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
 
 	optval = 1;
-	if (setsockopt(lfd, SOL_SOCKET, SO_REUSEADDR, &optval,
-		       sizeof(optval)) == -1)
-		die("Setsockopt Error");
-
-	if (bind(lfd, (struct sockaddr *)&svaddr,
-		 sizeof(struct sockaddr_in)) == -1)
-		die("Bind Error");
-
-	if (listen(lfd, 5) == -1)
-		die("Listen Error");
+	SAFE_SETSOCKOPT(lfd, SOL_SOCKET, SO_REUSEADDR, &optval, sizeof(optval));
+	SAFE_BIND(lfd, (struct sockaddr *)&svaddr, sizeof(struct sockaddr_in));
+	SAFE_LISTEN(lfd, 5);
 
 	return lfd;
 }
 
-static char *opt_port;
+void setup(void)
+{
+	memset(&conn_addr, 0, sizeof(struct sockaddr_in));
+	conn_addr.sin_family = AF_INET;
+	conn_addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
+	conn_addr.sin_port = htons(PORT_NUM);
 
-static option_t options[] = {
-	{"p:", NULL, &opt_port},
-	{NULL, NULL, NULL}
-};
+	listening_fd = create_listening_socket();
+}
 
-static void usage(void)
+void cleanup(void)
 {
-	printf("  -p      Port\n");
+	SAFE_CLOSE(listening_fd);
 }
 
-int main(int argc, char *argv[])
+static struct test_case {
+	int cloexec;
+	int nonblock;
+} tcases[] = {
+	{ 0, 0 },
+	{ SOCK_CLOEXEC, 0 },
+	{ 0, SOCK_NONBLOCK },
+	{ SOCK_CLOEXEC, SOCK_NONBLOCK },
+};
+
+void verify_accept4(unsigned int nr)
 {
-	struct sockaddr_in conn_addr;
-	int lfd;
-	int port_num = PORT_NUM;
+	struct test_case *tcase = &tcases[nr];
+	int connfd, acceptfd;
+	int fdf, flf, fdf_pass, flf_pass;
+	struct sockaddr_in claddr;
+	socklen_t addrlen;
 
-	tst_parse_opts(argc, argv, options, usage);
+	connfd = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
+	SAFE_CONNECT(connfd, (struct sockaddr *)&conn_addr, sizeof(conn_addr));
+	addrlen = sizeof(claddr);
 
-	if (opt_port)
-		port_num = atoi(opt_port);
+#if !(__GLIBC_PREREQ(2, 10))
+	TEST(accept4_01(listening_fd, (struct sockaddr *)&claddr, &addrlen,
+				tcase->cloexec | tcase->nonblock));
+#else
+	TEST(accept4(listening_fd, (struct sockaddr *)&claddr, &addrlen,
+				tcase->cloexec | tcase->nonblock));
+#endif
+	if (TST_RET == -1) {
+		if (TST_ERR == ENOSYS)
+			tst_brk(TCONF, "syscall __NR_accept4 not supported");
+		else
+			tst_brk(TBROK | TTERRNO, "accept4 failed");
+	}
 
-	setup();
+	acceptfd = TST_RET;
 
-	memset(&conn_addr, 0, sizeof(struct sockaddr_in));
-	conn_addr.sin_family = AF_INET;
-	conn_addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
-	conn_addr.sin_port = htons(port_num);
+	/* Test to see if O_CLOEXEC is as expected */
+	fdf = SAFE_FCNTL(acceptfd, F_GETFD);
+	fdf_pass = !!(fdf & FD_CLOEXEC) == !!(tcase->cloexec & SOCK_CLOEXEC);
+	if (!fdf_pass)
+		tst_res(TFAIL,  "Close-on-exec flag mismatch, %d vs %d",
+			 !!(fdf & FD_CLOEXEC),
+			 !!(tcase->cloexec & SOCK_CLOEXEC));
+
+	/* Test to see if O_NONBLOCK is as expected */
+	flf = SAFE_FCNTL(acceptfd, F_GETFL);
+	flf_pass = !!(flf & O_NONBLOCK) == !!(tcase->nonblock & SOCK_NONBLOCK);
+	if (!flf_pass)
+		tst_res(TFAIL, "nonblock flag mismatch, %d vs %d",
+			 !!(fdf & O_NONBLOCK),
+			 !!(tcase->nonblock & SOCK_NONBLOCK));
 
-	lfd = create_listening_socket(port_num);
+	SAFE_CLOSE(acceptfd);
+	SAFE_CLOSE(connfd);
 
-	do_test(lfd, &conn_addr, 0, 0);
-	do_test(lfd, &conn_addr, SOCK_CLOEXEC, 0);
-	do_test(lfd, &conn_addr, 0, SOCK_NONBLOCK);
-	do_test(lfd, &conn_addr, SOCK_CLOEXEC, SOCK_NONBLOCK);
+	if (fdf_pass && flf_pass)
+		tst_res(TPASS, "Test passed: Close-on-exec %d, nonblock %d",
+				fdf_pass, flf_pass);
 
-	close(lfd);
-	cleanup();
-	tst_exit();
 }
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = verify_accept4,
+};
-- 
2.21.0.392.gf8f6787159e-goog

