From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 4 Jan 2019 16:35:34 +0100
Subject: [LTP] [PATCH 3/3] syscalls/getcpu01: convert to new lib,
 cleanups, enable on Android
In-Reply-To: <20181227003102.246617-3-smuckle@google.com>
References: <20181227003102.246617-1-smuckle@google.com>
 <20181227003102.246617-3-smuckle@google.com>
Message-ID: <20190104153534.GA29238@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've simplified the test a bit more and pushed, thanks.

The reason why the test was checking for glibc version was because the
CPU_ALLOC() and friends macros were not present on old glibc, with the
fallback definitions in place we can drop these ifdefs now, see patch
below that I applied over your changes.

Also it seems that getcpu syscall is not specific to i386 and many
architectures also have vdso implementation.

So we should probably change the test to call both getcpu syscall and
sched_getcpu() library function and assert that both are correct.

diff --git a/testcases/kernel/syscalls/getcpu/getcpu01.c b/testcases/kernel/syscalls/getcpu/getcpu01.c
index b5380dbb2..eb6ded8ab 100644
--- a/testcases/kernel/syscalls/getcpu/getcpu01.c
+++ b/testcases/kernel/syscalls/getcpu/getcpu01.c
@@ -15,32 +15,16 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/types.h>
+#include "lapi/syscalls.h"
 #include "lapi/cpuset.h"
 #include "tst_test.h"
 
-#ifdef ANDROID
-	#define TEST_SUPPORTED 1
-#elif defined(__i386__) || defined(__x86_64__)
-	#if __GLIBC_PREREQ(2,6)
-		#if defined(__x86_64__)
-			#include <utmpx.h>
-		#endif
-		#define TEST_SUPPORTED 1
-	#elif defined(__i386__)
-		#define TEST_SUPPORTED 1
-	#else
-		#define TEST_SUPPORTED 0
-	#endif
-#else
-	#define TEST_SUPPORTED 0
-#endif
-
 static inline int get_cpu(unsigned *cpu_id,
 			  unsigned *node_id LTP_ATTRIBUTE_UNUSED,
 			  void *cache_struct LTP_ATTRIBUTE_UNUSED)
 {
 #if defined(__i386__)
-	return syscall(318, cpu_id, node_id, cache_struct);
+	return syscall(__NR_getcpu, cpu_id, node_id, cache_struct);
 #else
 	*cpu_id = sched_getcpu();
 #endif
@@ -66,34 +50,28 @@ static unsigned int set_cpu_affinity(void)
 	cpu_set_t *set;
 	size_t size;
 	int nrcpus = 1024;
+
 realloc:
 	set = CPU_ALLOC(nrcpus);
-	if (set == NULL) {
-		tst_brk(TBROK, "CPU_ALLOC:errno:%d", errno);
-	}
+	if (!set)
+		tst_brk(TBROK | TERRNO, "CPU_ALLOC()");
+
 	size = CPU_ALLOC_SIZE(nrcpus);
 	CPU_ZERO_S(size, set);
 	if (sched_getaffinity(0, size, set) < 0) {
 		CPU_FREE(set);
-#if __GLIBC_PREREQ(2, 7) || defined(ANDROID)
 		if (errno == EINVAL && nrcpus < (1024 << 8)) {
 			nrcpus = nrcpus << 2;
 			goto realloc;
 		}
-#else
-		if (errno == EINVAL)
-			tst_brk(TBROK,
-				"NR_CPUS of the kernel is more than 1024, so we'd better use a newer glibc(>= 2.7)");
-		else
-#endif
-			tst_brk(TBROK, "sched_getaffinity:errno:%d", errno);
+		tst_brk(TBROK | TERRNO, "sched_getaffinity()");
 	}
 	cpu_max = max_cpuid(size, set);
 	CPU_ZERO_S(size, set);
 	CPU_SET_S(cpu_max, size, set);
 	if (sched_setaffinity(0, size, set) < 0) {
 		CPU_FREE(set);
-		tst_brk(TBROK, "sched_setaffinity:errno:%d", errno);
+		tst_brk(TBROK | TERRNO, "sched_setaffinity()");
 	}
 	CPU_FREE(set);
 	return cpu_max;
@@ -104,7 +82,7 @@ static unsigned int get_nodeid(unsigned int cpu_id)
 {
 	DIR *directory_parent, *directory_node;
 	struct dirent *de, *dn;
-	char directory_path[255];
+	char directory_path[PATH_MAX];
 	unsigned int cpu;
 	int node_id = 0;
 
@@ -181,8 +159,6 @@ static void setup(void)
 {
 	if (tst_kvercmp(2, 6, 20) < 0)
 		tst_brk(TCONF, "kernel >= 2.6.20 required");
-	if (!TEST_SUPPORTED)
-		tst_brk(TCONF, "insufficient C library support");
 }
 
 static struct tst_test test = {

-- 
Cyril Hrubis
chrubis@suse.cz
