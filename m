From: Li Wang <liwang@redhat.com>
Date: Sat, 15 Jun 2019 12:20:47 +0800
Subject: [LTP] [PATCH v2 2/3] testcase: taking use of .arch in tst_test
In-Reply-To: <20190615042048.29839-1-liwang@redhat.com>
References: <20190615042048.29839-1-liwang@redhat.com>
Message-ID: <20190615042048.29839-2-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is a demo for .arch usage:
  1. ptrace07.c, cve-2017-17053.c, meltdown.c

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/cve/cve-2017-17053.c              | 1 +
 testcases/cve/meltdown.c                    | 9 +--------
 testcases/kernel/syscalls/ptrace/ptrace07.c | 8 +++-----
 3 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/testcases/cve/cve-2017-17053.c b/testcases/cve/cve-2017-17053.c
index e01db3d4f..62bbc5014 100644
--- a/testcases/cve/cve-2017-17053.c
+++ b/testcases/cve/cve-2017-17053.c
@@ -162,6 +162,7 @@ void run(void)
 }
 
 static struct tst_test test = {
+	.arch = "x86_64 i386",
 	.forks_child = 1,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/cve/meltdown.c b/testcases/cve/meltdown.c
index a53ea9b8e..72c9ec907 100644
--- a/testcases/cve/meltdown.c
+++ b/testcases/cve/meltdown.c
@@ -20,8 +20,6 @@
 #include "config.h"
 #include "tst_test.h"
 
-#if defined(__x86_64__) || defined(__i386__)
-
 #include <stdio.h>
 #include <string.h>
 #include <signal.h>
@@ -382,15 +380,10 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.arch = "x86_64 i386",
 	.needs_root = 1,
 	.setup = setup,
 	.test_all = run,
 	.cleanup = cleanup,
 	.min_kver = "2.6.32"
 };
-
-#else /* #if defined(__x86_64__) || defined(__i386__) */
-
-TST_TEST_TCONF("not x86_64 or i386");
-
-#endif /* #else #if defined(__x86_64__) || defined(__i386__) */
diff --git a/testcases/kernel/syscalls/ptrace/ptrace07.c b/testcases/kernel/syscalls/ptrace/ptrace07.c
index 9cbaefc3f..67e47ce16 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace07.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace07.c
@@ -60,13 +60,13 @@
 # define NT_X86_XSTATE 0x202
 #endif
 
-#ifdef __x86_64__
 static void check_regs_loop(uint32_t initval)
 {
 	const unsigned long num_iters = 1000000000;
 	uint32_t xmm0[4] = { initval, initval, initval, initval };
 	int status = 1;
 
+#ifdef __x86_64__
 	asm volatile("   movdqu %0, %%xmm0\n"
 		     "   mov %0, %%rbx\n"
 		     "1: dec %2\n"
@@ -80,6 +80,7 @@ static void check_regs_loop(uint32_t initval)
 		     "3:\n"
 		     : "+m" (xmm0), "+r" (status)
 		     : "r" (num_iters) : "rax", "rbx", "xmm0");
+#endif
 
 	if (status) {
 		tst_res(TFAIL,
@@ -188,10 +189,7 @@ static void do_test(void)
 
 static struct tst_test test = {
 	.test_all = do_test,
+	.arch = "x86_64",
 	.forks_child = 1,
 	.needs_checkpoints = 1,
 };
-
-#else /* !__x86_64__ */
-	TST_TEST_TCONF("this test is only supported on x86_64");
-#endif /* __x86_64__ */
-- 
2.20.1

