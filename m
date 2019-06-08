From: Li Wang <liwang@redhat.com>
Date: Sat,  8 Jun 2019 13:45:49 +0800
Subject: [LTP] [PATCH RFC 2/3] max_map_count: taking use of tst_on_arch in
	testcase
In-Reply-To: <20190608054550.13744-1-liwang@redhat.com>
References: <20190608054550.13744-1-liwang@redhat.com>
Message-ID: <20190608054550.13744-2-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We have two different ways to use tst_on_arch, first is to set
.arch = "xxx, yyy" in test struct to limit testcase running on some
specified arch, the second is calling it directly in test functions.

Demo:
  1. ptrace07.c, cve-2017-17053.c, meltdown.c
  2. max_map_count.c

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/cve/cve-2017-17053.c               |  1 +
 testcases/cve/meltdown.c                     |  9 +----
 testcases/kernel/mem/tunable/max_map_count.c | 36 ++++++++++----------
 testcases/kernel/syscalls/ptrace/ptrace07.c  |  8 ++---
 4 files changed, 23 insertions(+), 31 deletions(-)

diff --git a/testcases/cve/cve-2017-17053.c b/testcases/cve/cve-2017-17053.c
index e01db3d4f..67bf4135f 100644
--- a/testcases/cve/cve-2017-17053.c
+++ b/testcases/cve/cve-2017-17053.c
@@ -162,6 +162,7 @@ void run(void)
 }
 
 static struct tst_test test = {
+	.arch = "x86_64, i386",
 	.forks_child = 1,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/cve/meltdown.c b/testcases/cve/meltdown.c
index a53ea9b8e..da35213ec 100644
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
+	.arch = "x86_64, i386",
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
diff --git a/testcases/kernel/mem/tunable/max_map_count.c b/testcases/kernel/mem/tunable/max_map_count.c
index 5b03a60ec..ae86288bf 100644
--- a/testcases/kernel/mem/tunable/max_map_count.c
+++ b/testcases/kernel/mem/tunable/max_map_count.c
@@ -91,24 +91,24 @@ static bool filter_map(const char *line)
 	if (ret != 1)
 		return false;
 
-#if defined(__x86_64__) || defined(__x86__)
-	/* On x86, there's an old compat vsyscall page */
-	if (!strcmp(buf, "[vsyscall]"))
-		return true;
-#elif defined(__ia64__)
-	/* On ia64, the vdso is not a proper mapping */
-	if (!strcmp(buf, "[vdso]"))
-		return true;
-#elif defined(__arm__)
-	/* Skip it when run it in aarch64 */
-	if ((!strcmp(un.machine, "aarch64"))
-	|| (!strcmp(un.machine, "aarch64_be")))
-		return false;
-
-	/* Older arm kernels didn't label their vdso maps */
-	if (!strncmp(line, "ffff0000-ffff1000", 17))
-		return true;
-#endif
+	if (tst_on_arch("x86_64, x86")) {
+		/* On x86, there's an old compat vsyscall page */
+		if (!strcmp(buf, "[vsyscall]"))
+			return true;
+	} else if (tst_on_arch("ia64")) {
+		/* On ia64, the vdso is not a proper mapping */
+		if (!strcmp(buf, "[vdso]"))
+			return true;
+	} else if (tst_on_arch("arm")) {
+		/* Skip it when run it in aarch64 */
+		if ((!strcmp(un.machine, "aarch64"))
+				|| (!strcmp(un.machine, "aarch64_be")))
+			return false;
+
+		/* Older arm kernels didn't label their vdso maps */
+		if (!strncmp(line, "ffff0000-ffff1000", 17))
+			return true;
+	}
 
 	return false;
 }
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
2.17.0

