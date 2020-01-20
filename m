From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 20 Jan 2020 14:36:45 +0100
Subject: [LTP] [PATCH 1/2] socketcall01: Use tst_syscall() instead of custom
 syscall support detection
Message-ID: <20200120133646.8629-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Besides it's always better to use API functions instead of
reimplementing a wheel it's also needed to fix regression in detecting
socketcall() syscall support for archs which does not support it (e.g.
x86_64, ARM):

socketcall01.c:42: FAIL: socketcall() for TCP stream failed with -1: ENOSYS (38)
socketcall01.c:42: FAIL: socketcall() for unix domain dgram failed with -1: ENOSYS (38)
socketcall01.c:42: FAIL: socketcall() for Raw socket failed with -1: ENOSYS (38)
socketcall01.c:42: FAIL: socketcall() for UDP dgram failed with -1: ENOSYS (38)

Fixes: 9e83513eb "tst_device.h: Use lapi/syscalls.h instead of <sys/syscall.h>"
Fixes: #634

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/syscalls/socketcall/socketcall01.c   | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/socketcall/socketcall01.c b/testcases/kernel/syscalls/socketcall/socketcall01.c
index a8f6649a6..48e818846 100644
--- a/testcases/kernel/syscalls/socketcall/socketcall01.c
+++ b/testcases/kernel/syscalls/socketcall/socketcall01.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
- *    AUTHOR : sowmya adiga<sowmya.adiga@wipro.com>
+ * Author: sowmya adiga <sowmya.adiga@wipro.com>
  * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) Linux Test Project, 2017-2020
  */
 /*
  * This is a basic test for the socketcall(2) system call.
@@ -11,16 +12,12 @@
 #include <errno.h>
 #include <sys/types.h>
 #include <sys/socket.h>
-#include <sys/syscall.h>
 #include <linux/net.h>
 #include <sys/un.h>
 #include <netinet/in.h>
 
 #include "tst_test.h"
-
-#ifdef __NR_socketcall
-
-#define socketcall(call, args) syscall(__NR_socketcall, call, args)
+#include "lapi/syscalls.h"
 
 struct test_case_t {
 	int call;
@@ -35,7 +32,7 @@ struct test_case_t {
 
 void verify_socketcall(unsigned int i)
 {
-	TEST(socketcall(TC[i].call, TC[i].args));
+	TEST(tst_syscall(__NR_socketcall, TC[i].call, TC[i].args));
 
 	if (TST_RET < 0) {
 		tst_res(TFAIL | TTERRNO, "socketcall() for %s failed with %li",
@@ -53,9 +50,3 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(TC),
 	.needs_root = 1,
 };
-
-#else
-
-TST_TEST_TCONF("The socketcall() syscall is not supported");
-
-#endif
-- 
2.24.1

