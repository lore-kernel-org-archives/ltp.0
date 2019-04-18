From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 18 Apr 2019 17:27:10 +0200
Subject: [LTP] [PATCH v2 1/2] syscalls/sched_getaffinity: Cleanup &&
 Convert to new API
In-Reply-To: <1555481102-4158-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20190412114632.GD28648@haruka.lan>
 <1555481102-4158-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20190418152710.GB8766@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've did some fixes, split the patch into two and applied, thanks.

As it was the sched_getaffinity() test was really wrong since the
CPU_ISSET_S() does not return -1 at all. Also it's not guaranteed that
all cpus are in the affinity mask for a given process. So what I changed
it to instead is to check if sum of the enabled bits in the mask is
greater than zero and smaller or equal the number of the configured
processors as reported by the sysconf() call.

I've also changed the negative testcases to check errno as well, full
diff follows.

And lastly but not least I've split the patch into two, since the change
in the lapi/cpuset.h is unrelated to the conversion.

diff --git a/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c b/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c
index 1c149fe40..12ca198cb 100644
--- a/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c
+++ b/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c
@@ -14,20 +14,35 @@
 #include "tst_safe_macros.h"
 #include "lapi/cpuset.h"
 
-#define QUICK_TEST(t) \
-do { \
-	TEST(t); \
-	tst_res((TST_RET == -1 ? TPASS : TFAIL) | TTERRNO, #t); \
-} while (0)
+static long ncpu;
 
-static long num;
+static void *bad_addr;
+
+static void errno_test(pid_t pid, size_t cpusize, void *mask, int exp_errno)
+{
+	TEST(sched_getaffinity(pid, cpusize, mask));
+
+	if (TST_RET != -1) {
+		tst_res(TFAIL,
+			"sched_getaffinity() returned %ld, expected -1",
+			TST_RET);
+		return;
+	}
+
+	if (TST_ERR != exp_errno) {
+		tst_res(TFAIL | TTERRNO,
+			"sched_getaffinity() should fail with %s",
+			tst_strerrno(exp_errno));
+		return;
+	}
+
+	tst_res(TPASS | TTERRNO, "sched_getaffinity() failed");
+}
 
 static void do_test(void)
 {
-	int i;
 	cpu_set_t *mask;
 	int nrcpus = 1024;
-	pid_t unused_pid;
 	unsigned len;
 
 realloc:
@@ -38,42 +53,41 @@ realloc:
 	len = CPU_ALLOC_SIZE(nrcpus);
 	CPU_ZERO_S(len, mask);
 
-	/* positive test */
 	TEST(sched_getaffinity(0, len, mask));
 	if (TST_RET == -1) {
 		CPU_FREE(mask);
-		if (errno == EINVAL && nrcpus < (1024 << 8)) {
+		if (TST_ERR == EINVAL && nrcpus < (1024 << 8)) {
 			nrcpus = nrcpus << 2;
 			goto realloc;
 		}
-		tst_res(TFAIL | TTERRNO, "fail to get cpu affinity");
-	} else {
-		tst_res(TINFO, "cpusetsize is %d", len);
-		tst_res(TINFO, "mask.__bits[0] = %lu ", mask->__bits[0]);
-		for (i = 0; i < num; i++) {
-			TEST(CPU_ISSET_S(i, len, mask));
-			if (TST_RET != -1)
-				tst_res(TPASS, "sched_getaffinity() succeed, "
-					 "this process %d is running "
-					 "processor: %d", getpid(), i);
-		}
+		tst_brk(TBROK | TTERRNO, "fail to get cpu affinity");
 	}
 
-	CPU_ZERO_S(len, mask);
+	long i, af_cpus = 0;
 
-	/* negative tests */
-	QUICK_TEST(sched_getaffinity(0, len, (cpu_set_t *) - 1));
-	QUICK_TEST(sched_getaffinity(0, 0, mask));
+	for (i = 0; i < nrcpus; i++)
+		af_cpus += !!CPU_ISSET_S(i, len, mask);
+
+	if (af_cpus == 0)
+		tst_res(TFAIL, "No cpus enabled in mask");
+	else if (af_cpus > ncpu)
+		tst_res(TFAIL, "Enabled cpus = %li > system cpus %li", af_cpus, ncpu);
+	else
+		tst_res(TPASS, "cpuset size = %u, enabled cpus %ld", len, af_cpus);
+
+	errno_test(0, len, bad_addr, EFAULT);
+	errno_test(0, 0, mask, EINVAL);
+	errno_test(tst_get_unused_pid(), len, mask, ESRCH);
 
-	unused_pid = tst_get_unused_pid();
-	QUICK_TEST(sched_getaffinity(unused_pid, len, mask));
 	CPU_FREE(mask);
 }
 
 static void setup(void)
 {
-	num = SAFE_SYSCONF(_SC_NPROCESSORS_CONF);
-	tst_res(TINFO, "system has %ld processor(s).", num);
+	ncpu = SAFE_SYSCONF(_SC_NPROCESSORS_CONF);
+	tst_res(TINFO, "system has %ld processor(s).", ncpu);
+
+	bad_addr = tst_get_bad_addr(NULL);
 }
 
 static struct tst_test test = {

-- 
Cyril Hrubis
chrubis@suse.cz
