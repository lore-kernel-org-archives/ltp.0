From: Sandeep Patil <sspatil@android.com>
Date: Sat, 18 May 2019 17:38:08 -0700
Subject: [LTP] [PATCH 5/5] syscalls/bind01: convert to new library.
In-Reply-To: <20190519003808.47425-1-sspatil@android.com>
References: <20190519003808.47425-1-sspatil@android.com>
Message-ID: <20190519003808.47425-6-sspatil@android.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Drop UCLINUX specific tests along the way.

Signed-off-by: Sandeep Patil <sspatil@android.com>
---
 testcases/kernel/syscalls/bind/bind01.c | 201 ++++++------------------
 1 file changed, 49 insertions(+), 152 deletions(-)

diff --git a/testcases/kernel/syscalls/bind/bind01.c b/testcases/kernel/syscalls/bind/bind01.c
index 868749368..4ce530ed3 100644
--- a/testcases/kernel/syscalls/bind/bind01.c
+++ b/testcases/kernel/syscalls/bind/bind01.c
@@ -1,43 +1,7 @@
-/*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
+// SPDX-License-Identifier: GPL-2.0
 
 /*
- * Test Name: bind01
- *
- * Test Description:
- *  Verify that bind() returns the proper errno for various failure cases
- *
- * Usage:  <for command-line>
- *  bind01 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS:
- *  None.
- *
+ * Copyright (c) International Business Machines  Corp., 2001
  */
 
 #include <stdio.h>
@@ -51,108 +15,54 @@
 
 #include <netinet/in.h>
 
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 
-char *TCID = "bind01";
-int testno;
+int inet_socket;
+int dev_null;
 
-int s;				/* socket descriptor */
 struct sockaddr_in sin1, sin2, sin3;
-struct sockaddr_un sun1;
-
-void setup(void), setup0(void), setup1(void), setup2(void),
-cleanup(void), cleanup0(void), cleanup1(void);
+struct sockaddr_un sun;
 
-struct test_case_t {		/* test case structure */
-	int domain;		/* PF_INET, PF_UNIX, ... */
-	int type;		/* SOCK_STREAM, SOCK_DGRAM ... */
-	int proto;		/* protocol number (usually 0 = default) */
+static struct test_case {
+	int *socket_fd;		/* file descriptor for test case */
 	struct sockaddr *sockaddr;	/* socket address buffer */
-	int salen;		/* bind's 3rd argument */
-	int retval;		/* syscall return value */
+	socklen_t salen;		/* bind's 3rd argument */
+	int retval;		/* expected return value */
 	int experrno;		/* expected errno */
-	void (*setup) (void);
-	void (*cleanup) (void);
 	char *desc;
-} tdat[] = {
-#ifndef UCLINUX
-/* Skip since uClinux does not implement memory protection */
-	{
-	PF_INET, SOCK_STREAM, 0, (struct sockaddr *)-1,
-		    sizeof(struct sockaddr_in), -1, EFAULT, setup0,
-		    cleanup0, "invalid sockaddr"},
-#endif
-	{
-	PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&sin1,
-		    3, -1, EINVAL, setup0, cleanup0, "invalid salen"}, {
-	0, 0, 0, (struct sockaddr *)&sin1,
-		    sizeof(sin1), -1, ENOTSOCK, setup1, cleanup1,
-		    "invalid socket"}
-	, {
-	PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&sin2,
-		    sizeof(sin2), 0, 0, setup0, cleanup0, "INADDR_ANYPORT"}
-	, {
-	PF_UNIX, SOCK_STREAM, 0, (struct sockaddr *)&sun1,
-		    sizeof(sun1), -1, EADDRINUSE, setup0, cleanup0,
-		    "UNIX-domain of current directory"}
-	, {
-	PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&sin3,
-		    sizeof(sin3), -1, EADDRNOTAVAIL, setup0, cleanup0,
-		    "non-local address"}
-,};
-
-int TST_TOTAL = sizeof(tdat) / sizeof(tdat[0]);
-
-int main(int argc, char *argv[])
+} tcases[] = {
+	{ &inet_socket, (struct sockaddr *)&sin1, 3, -1,
+	  EINVAL, "invalid salen" },
+	{ &dev_null, (struct sockaddr *)&sin1, sizeof(sin1), -1,
+	  ENOTSOCK, "invalid socket" },
+	{ &inet_socket, (struct sockaddr *)&sin2, sizeof(sin2), 0,
+	  0, "INADDR_ANYPORT"},
+	{ &inet_socket, (struct sockaddr *)&sun, sizeof(sun), -1,
+	  EAFNOSUPPORT, "UNIX-domain of current directory" },
+	{ &inet_socket, (struct sockaddr *)&sin3, sizeof(sin3), -1,
+	  EADDRNOTAVAIL, "non-local address" },
+};
+
+void verify_bind(unsigned int nr)
 {
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		tst_count = 0;
-
-		for (testno = 0; testno < TST_TOTAL; ++testno) {
-			tdat[testno].setup();
-
-			TEST(bind
-			     (s, tdat[testno].sockaddr, tdat[testno].salen));
-			if (TEST_RETURN > 0) {
-				TEST_RETURN = 0;
-			} else {
-			}
-			if (TEST_RETURN != tdat[testno].retval ||
-			    (TEST_RETURN < 0 &&
-			     TEST_ERRNO != tdat[testno].experrno)) {
-				tst_resm(TFAIL, "%s ; returned"
-					 " %ld (expected %d), errno %d (expected"
-					 " %d)", tdat[testno].desc,
-					 TEST_RETURN, tdat[testno].retval,
-					 TEST_ERRNO, tdat[testno].experrno);
-			} else {
-				tst_resm(TPASS, "%s successful",
-					 tdat[testno].desc);
-			}
-			tdat[testno].cleanup();
-		}
+	struct test_case *tcase = &tcases[nr];
+
+	TEST(bind(*tcase->socket_fd, tcase->sockaddr, tcase->salen));
+	if (TST_RET != tcase->retval && TST_ERR != tcase->experrno) {
+		tst_res(TFAIL, "%s ; returned"
+			" %ld (expected %d), errno %d (expected"
+			" %d)", tcase->desc, TST_RET, tcase->retval,
+			TST_ERR, tcase->experrno);
+	} else {
+		tst_res(TPASS, "%s successful", tcase->desc);
 	}
-	cleanup();
-
-	tst_exit();
 }
 
-void setup(void)
+void test_setup(void)
 {
-
-	TEST_PAUSE;		/* if -p option specified */
-
 	/* initialize sockaddr's */
 	sin1.sin_family = AF_INET;
-	/* this port must be unused! */
-	sin1.sin_port = tst_get_unused_port(NULL, AF_INET, SOCK_STREAM);
+	sin1.sin_port = 0;
 	sin1.sin_addr.s_addr = INADDR_ANY;
 
 	sin2.sin_family = AF_INET;
@@ -164,35 +74,22 @@ void setup(void)
 	/* assumes 10.255.254.253 is not a local interface address! */
 	sin3.sin_addr.s_addr = htonl(0x0AFFFEFD);
 
-	sun1.sun_family = AF_UNIX;
-	strncpy(sun1.sun_path, ".", sizeof(sun1.sun_path));
-
-}
-
-void cleanup(void)
-{
-}
+	sun.sun_family = AF_UNIX;
+	strncpy(sun.sun_path, ".", sizeof(sun.sun_path));
 
-void setup0(void)
-{
-	s = SAFE_SOCKET(cleanup, tdat[testno].domain, tdat[testno].type,
-		        tdat[testno].proto);
+	inet_socket = SAFE_SOCKET(PF_INET, SOCK_STREAM, 0);
+	dev_null = SAFE_OPEN("/dev/null", O_WRONLY);
 }
 
-void cleanup0(void)
+void test_cleanup(void)
 {
-	(void)close(s);
+	SAFE_CLOSE(inet_socket);
+	SAFE_CLOSE(dev_null);
 }
 
-void setup1(void)
-{
-	/* setup for the "not a socket" case */
-	if ((s = open("/dev/null", O_WRONLY)) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "open(/dev/null) failed");
-
-}
-
-void cleanup1(void)
-{
-	s = -1;
-}
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = test_setup,
+	.cleanup = test_cleanup,
+	.test = verify_bind,
+};
-- 
2.21.0.1020.gf2820cf01a-goog

