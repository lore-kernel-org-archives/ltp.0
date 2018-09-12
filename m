From: Steve Muckle <smuckle.linux@gmail.com>
Date: Wed, 12 Sep 2018 10:32:08 -0700
Subject: [LTP] [PATCH] syscalls/getcpu01: support Android
Message-ID: <20180912173208.131065-1-smuckle.linux@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Android platforms have the required support for this test.

Signed-off-by: Steve Muckle <smuckle.linux@gmail.com>
---
 testcases/kernel/syscalls/getcpu/getcpu01.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/getcpu/getcpu01.c b/testcases/kernel/syscalls/getcpu/getcpu01.c
index c927512ca..73db5a21a 100644
--- a/testcases/kernel/syscalls/getcpu/getcpu01.c
+++ b/testcases/kernel/syscalls/getcpu/getcpu01.c
@@ -61,7 +61,9 @@
 #include <sys/types.h>
 #include <dirent.h>
 
-#if defined(__i386__) || defined(__x86_64__)
+#ifdef ANDROID
+int sys_support = 1;
+#elif defined(__i386__) || defined(__x86_64__)
 #if __GLIBC_PREREQ(2,6)
 #if defined(__x86_64__)
 #include <utmpx.h>
@@ -164,7 +166,7 @@ static inline int getcpu(unsigned *cpu_id, unsigned *node_id,
 {
 #if defined(__i386__)
 	return syscall(318, cpu_id, node_id, cache_struct);
-#elif __GLIBC_PREREQ(2,6)
+#elif __GLIBC_PREREQ(2,6) || defined(ANDROID)
 	*cpu_id = sched_getcpu();
 #endif
 	return 0;
@@ -191,7 +193,7 @@ unsigned int set_cpu_affinity(void)
 	cpu_set_t *set;
 	size_t size;
 	int nrcpus = 1024;
-#if __GLIBC_PREREQ(2, 7)
+#if __GLIBC_PREREQ(2, 7) || defined(ANDROID)
 realloc:
 	set = CPU_ALLOC(nrcpus);
 #else
@@ -200,7 +202,7 @@ realloc:
 	if (set == NULL) {
 		tst_brkm(TFAIL, NULL, "CPU_ALLOC:errno:%d", errno);
 	}
-#if __GLIBC_PREREQ(2, 7)
+#if __GLIBC_PREREQ(2, 7) || defined(ANDROID)
 	size = CPU_ALLOC_SIZE(nrcpus);
 	CPU_ZERO_S(size, set);
 #else
@@ -209,7 +211,7 @@ realloc:
 #endif
 	if (sched_getaffinity(0, size, set) < 0) {
 		CPU_FREE(set);
-#if __GLIBC_PREREQ(2, 7)
+#if __GLIBC_PREREQ(2, 7) || defined(ANDROID)
 		if (errno == EINVAL && nrcpus < (1024 << 8)) {
 			nrcpus = nrcpus << 2;
 			goto realloc;
@@ -224,7 +226,7 @@ realloc:
 		tst_exit();
 	}
 	cpu_max = max_cpuid(size, set);
-#if __GLIBC_PREREQ(2, 7)
+#if __GLIBC_PREREQ(2, 7) || defined(ANDROID)
 	CPU_ZERO_S(size, set);
 	CPU_SET_S(cpu_max, size, set);
 #else
@@ -247,7 +249,7 @@ unsigned int max_cpuid(size_t size, cpu_set_t * set)
 {
 	unsigned int index, max = 0;
 	for (index = 0; index < size * BITS_PER_BYTE; index++)
-#if __GLIBC_PREREQ(2, 7)
+#if __GLIBC_PREREQ(2, 7) || defined(ANDROID)
 		if (CPU_ISSET_S(index, size, set))
 #else
 		if (CPU_ISSET(index, set))
-- 
2.19.0.rc2.392.g5ba43deb5a-goog

