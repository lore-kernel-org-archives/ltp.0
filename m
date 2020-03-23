From: Petr Vorel <petr.vorel@gmail.com>
Date: Mon, 23 Mar 2020 23:49:31 +0100
Subject: [LTP] [PATCH 1/3] accept4: Use tst_variant
Message-ID: <20200323224933.2613658-1-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

to test both raw syscall and libc implementation.

This allows remove glibc specific __GLIBC_PREREQ() macro.

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
I guess __NR_socketcall is for x86 and other old architectures,
but we still want to use it, right?

Kind regards,
Petr

 .../kernel/syscalls/accept4/accept4_01.c      | 49 ++++++++++---------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/testcases/kernel/syscalls/accept4/accept4_01.c b/testcases/kernel/syscalls/accept4/accept4_01.c
index 29e18f27d..a596b9b1a 100644
--- a/testcases/kernel/syscalls/accept4/accept4_01.c
+++ b/testcases/kernel/syscalls/accept4/accept4_01.c
@@ -2,9 +2,9 @@
 
 /*
  * Copyright (C) 2008, Linux Foundation,
+ * Copyright (c) 2020 Petr Vorel <petr.vorel@gmail.com>
  * written by Michael Kerrisk <mtk.manpages@gmail.com>
  * Initial Porting to LTP by Subrata <subrata@linux.vnet.ibm.com>
- *
  */
 
 #define _GNU_SOURCE
@@ -17,6 +17,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <errno.h>
+#include <linux/net.h>
 
 #include "tst_test.h"
 #include "lapi/fcntl.h"
@@ -31,18 +32,17 @@
 # define SOCK_NONBLOCK   O_NONBLOCK
 #endif
 
-#if defined(SYS_ACCEPT4)	/* the socketcall() number */
-#define USE_SOCKETCALL 1
-#endif
+static const char *variant_desc[] = {
+	"libc accept4()",
+	"__NR_accept4 syscall",
+	"__NR_socketcall SYS_ACCEPT4 syscall"};
 
 static struct sockaddr_in *conn_addr, *accept_addr;
 static int listening_fd;
 
-#if !(__GLIBC_PREREQ(2, 10))
 static int
 accept4_01(int fd, struct sockaddr *sockaddr, socklen_t *addrlen, int flags)
 {
-#if USE_SOCKETCALL
 	long args[6];
 
 	args[0] = fd;
@@ -51,11 +51,7 @@ accept4_01(int fd, struct sockaddr *sockaddr, socklen_t *addrlen, int flags)
 	args[3] = flags;
 
 	return tst_syscall(__NR_socketcall, SYS_ACCEPT4, args);
-#else
-	return tst_syscall(__NR_accept4, fd, sockaddr, addrlen, flags);
-#endif
 }
-#endif
 
 static int create_listening_socket(void)
 {
@@ -80,6 +76,8 @@ static int create_listening_socket(void)
 
 static void setup(void)
 {
+	tst_res(TINFO, "Testing variant: %s", variant_desc[tst_variant]);
+
 	memset(conn_addr, 0, sizeof(*conn_addr));
 	conn_addr->sin_family = AF_INET;
 	conn_addr->sin_addr.s_addr = htonl(INADDR_LOOPBACK);
@@ -106,6 +104,7 @@ static struct test_case {
 static void verify_accept4(unsigned int nr)
 {
 	struct test_case *tcase = &tcases[nr];
+	int flags = tcase->cloexec | tcase->nonblock;
 	int connfd, acceptfd;
 	int fdf, flf, fdf_pass, flf_pass, fd_cloexec, fd_nonblock;
 	socklen_t addrlen;
@@ -114,20 +113,25 @@ static void verify_accept4(unsigned int nr)
 	SAFE_CONNECT(connfd, (struct sockaddr *)conn_addr, sizeof(*conn_addr));
 	addrlen = sizeof(*accept_addr);
 
-#if !(__GLIBC_PREREQ(2, 10))
-	TEST(accept4_01(listening_fd, (struct sockaddr *)accept_addr, &addrlen,
-				tcase->cloexec | tcase->nonblock));
-#else
-	TEST(accept4(listening_fd, (struct sockaddr *)accept_addr, &addrlen,
-				tcase->cloexec | tcase->nonblock));
-#endif
-	if (TST_RET == -1) {
-		if (TST_ERR == ENOSYS)
-			tst_brk(TCONF, "syscall __NR_accept4 not supported");
-		else
-			tst_brk(TBROK | TTERRNO, "accept4 failed");
+	switch (tst_variant) {
+	case 0:
+		TEST(accept4(listening_fd, (struct sockaddr *)accept_addr,
+			     &addrlen, flags));
+	break;
+	case 1:
+		TEST(tst_syscall(__NR_accept4, listening_fd,
+				 (struct sockaddr *)accept_addr,
+				 &addrlen, flags));
+	break;
+	case 2:
+		TEST(accept4_01(listening_fd, (struct sockaddr *)accept_addr,
+				&addrlen, flags));
+	break;
 	}
 
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "accept4 failed");
+
 	acceptfd = TST_RET;
 
 	/* Test to see if O_CLOEXEC is as expected */
@@ -161,6 +165,7 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.setup = setup,
 	.cleanup = cleanup,
+	.test_variants = 3,
 	.test = verify_accept4,
 	.bufs = (struct tst_buffers []) {
 		{&conn_addr, .size = sizeof(*conn_addr)},
-- 
2.25.1

