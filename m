From: Steve Muckle <smuckle@google.com>
Date: Wed, 26 Dec 2018 16:31:02 -0800
Subject: [LTP] [PATCH 3/3] syscalls/getcpu01: convert to new lib, cleanups,
 enable on Android
In-Reply-To: <20181227003102.246617-1-smuckle@google.com>
References: <20181227003102.246617-1-smuckle@google.com>
Message-ID: <20181227003102.246617-3-smuckle@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Convert getcpu01 test to new library. Also do various cleanups and
enable for Android.

Signed-off-by: Steve Muckle <smuckle@google.com>
---
 include/lapi/cpuset.h                       |   4 +
 testcases/kernel/syscalls/getcpu/getcpu01.c | 314 ++++++--------------
 2 files changed, 102 insertions(+), 216 deletions(-)

diff --git a/include/lapi/cpuset.h b/include/lapi/cpuset.h
index 5dc3fcc05..b94665022 100644
--- a/include/lapi/cpuset.h
+++ b/include/lapi/cpuset.h
@@ -56,4 +56,8 @@ if (ncpus > CPU_SETSIZE) { \
 #define CPU_SET_S(cpu, size, mask) CPU_SET(cpu, mask)
 #endif
 
+#ifndef CPU_ISSET_S
+#define CPU_ISSET_S(cpu, size, mask) CPU_ISSET(cpu, mask)
+#endif
+
 #endif /* LTP_CPUSET_H */
diff --git a/testcases/kernel/syscalls/getcpu/getcpu01.c b/testcases/kernel/syscalls/getcpu/getcpu01.c
index e850fe844..b5380dbb2 100644
--- a/testcases/kernel/syscalls/getcpu/getcpu01.c
+++ b/testcases/kernel/syscalls/getcpu/getcpu01.c
@@ -1,265 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright © International Business Machines  Corp., 2007, 2008
  *
- *   Copyright © International Business Machines  Corp., 2007, 2008
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
- *   Foundation,Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02111-1301 USA
- */
-
-/*
- * NAME
- *	getcpu1.c
- *
- * DESCRIPTION
- *	getcpu01 - call getcpu() and make sure it succeeds
- *
- * ALGORITHM
- *	set cpu affinity of the process
- *	If setaffinity() fails exit from the test suite
- *	Store the node ID of the cpu which has been set in previous step
- *	Make a call to getcpu() system call
- *	Verify the returned valued with the set value
- *	if they match
- *	  test is considered PASS
- *	else
- *	  test is considered FAIL
- *
- * USAGE:  <for command-line>
- *  getcpu [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	06/2008 written by Sharyathi Nagesh <sharyathi@in.ibm.com>
- *
- *      05/2009         Suzuki K P <suzuki@in.ibm.com>
- *                      Use TCONF instead of TWARN for non-NUMA machines
- *
- * RESTRICTIONS
- *	none
+ * Test Description:
+ *  The test process is affined to a CPU. It then calls getcpu and
+ *  checks that the CPU and node (if supported) match the expected
+ *  values.
  */
 
 #define _GNU_SOURCE
-#include <sched.h>
+#include <dirent.h>
 #include <errno.h>
-#include "test.h"
+#include <sched.h>
+#include <stdio.h>
+#include <stdlib.h>
 #include <sys/types.h>
-#include <dirent.h>
-
-#if defined(__i386__) || defined(__x86_64__)
-#if __GLIBC_PREREQ(2,6)
-#if defined(__x86_64__)
-#include <utmpx.h>
-#endif
-int sys_support = 1;
-#elif defined(__i386__)
-int sys_support = 1;
-#else
-int sys_support = 0;
-#endif
+#include "lapi/cpuset.h"
+#include "tst_test.h"
+
+#ifdef ANDROID
+	#define TEST_SUPPORTED 1
+#elif defined(__i386__) || defined(__x86_64__)
+	#if __GLIBC_PREREQ(2,6)
+		#if defined(__x86_64__)
+			#include <utmpx.h>
+		#endif
+		#define TEST_SUPPORTED 1
+	#elif defined(__i386__)
+		#define TEST_SUPPORTED 1
+	#else
+		#define TEST_SUPPORTED 0
+	#endif
 #else
-int sys_support = 0;
+	#define TEST_SUPPORTED 0
 #endif
 
-#if !(__GLIBC_PREREQ(2, 7))
-#define CPU_FREE(ptr) free(ptr)
-#endif
-
-void cleanup(void);
-void setup(void);
-static inline int get_cpu(unsigned int *, unsigned int *, void *);
-unsigned int set_cpu_affinity(void);
-unsigned int get_nodeid(unsigned int);
-unsigned int max_cpuid(size_t, cpu_set_t *);
-
-char *TCID = "getcpu01";
-int TST_TOTAL = 1;
-
-int main(int ac, char **av)
-{
-	int lc;
-	unsigned int cpu_id, node_id = 0;
-	unsigned int cpu_set;
-#ifdef __i386__
-	unsigned int node_set;
-#endif
-
-	/* Check For Kernel Version */
-	if (((tst_kvercmp(2, 6, 20)) < 0) || !(sys_support)) {
-		tst_resm(TCONF, "This test can only run on kernels that are ");
-		tst_resm(TCONF,
-			 "2.6.20 and higher and glibc version 2.6 and above");
-		tst_resm(TCONF, "Currently the test case has been");
-		tst_resm(TCONF, "developed only for i386 and x86_64");
-		exit(0);
-	}
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();		/* global setup */
-
-	/* The following loop checks looping state if -i option given */
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		/* call the system call with the TEST() macro */
-		cpu_set = set_cpu_affinity();
-#ifdef __i386__
-		node_set = get_nodeid(cpu_set);
-#endif
-		TEST(get_cpu(&cpu_id, &node_id, NULL));
-		if (TEST_RETURN == 0) {
-			if (cpu_id != cpu_set) {
-				tst_resm(TFAIL, "getcpu() returned wrong value"
-					 " expected cpuid:%d, returned value cpuid: %d",
-					 cpu_set, cpu_id);
-
-			}
-#ifdef __i386__
-			else if (node_id != node_set) {
-				tst_resm(TFAIL, "getcpu() returned wrong value"
-					 " expected  node id:%d returned  node id:%d",
-					 node_set, node_id);
-
-			}
-#endif
-			else
-				tst_resm(TPASS, "getcpu() returned proper"
-					 " cpuid:%d, node id:%d", cpu_id,
-					 node_id);
-		} else {
-			tst_resm(TFAIL, "getcpu() Failed, errno=%d:%s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-
-		}
-	}
-
-	cleanup();
-
-	tst_exit();
-}
-
-/*
- * get_cpu() - calls the system call
- */
-static inline int get_cpu(unsigned *cpu_id, unsigned *node_id,
-			  void *cache_struct)
+static inline int get_cpu(unsigned *cpu_id,
+			  unsigned *node_id LTP_ATTRIBUTE_UNUSED,
+			  void *cache_struct LTP_ATTRIBUTE_UNUSED)
 {
 #if defined(__i386__)
 	return syscall(318, cpu_id, node_id, cache_struct);
-#elif __GLIBC_PREREQ(2,6)
+#else
 	*cpu_id = sched_getcpu();
 #endif
 	return 0;
 }
 
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
+static unsigned int max_cpuid(size_t size, cpu_set_t * set)
 {
-
-	/* ?? */
-
-	TEST_PAUSE;
+	unsigned int index, max = 0;
+	for (index = 0; index < size * 8; index++)
+		if (CPU_ISSET_S(index, size, set))
+			max = index;
+	return max;
 }
 
 /*
  * This will set the affinity to max cpu on which process can run
  * and return that cpu id to the calling process
  */
-unsigned int set_cpu_affinity(void)
+static unsigned int set_cpu_affinity(void)
 {
 	unsigned cpu_max;
 	cpu_set_t *set;
 	size_t size;
 	int nrcpus = 1024;
-#if __GLIBC_PREREQ(2, 7)
 realloc:
 	set = CPU_ALLOC(nrcpus);
-#else
-	set = malloc(sizeof(cpu_set_t));
-#endif
 	if (set == NULL) {
-		tst_brkm(TFAIL, NULL, "CPU_ALLOC:errno:%d", errno);
+		tst_brk(TBROK, "CPU_ALLOC:errno:%d", errno);
 	}
-#if __GLIBC_PREREQ(2, 7)
 	size = CPU_ALLOC_SIZE(nrcpus);
 	CPU_ZERO_S(size, set);
-#else
-	size = sizeof(cpu_set_t);
-	CPU_ZERO(set);
-#endif
 	if (sched_getaffinity(0, size, set) < 0) {
 		CPU_FREE(set);
-#if __GLIBC_PREREQ(2, 7)
+#if __GLIBC_PREREQ(2, 7) || defined(ANDROID)
 		if (errno == EINVAL && nrcpus < (1024 << 8)) {
 			nrcpus = nrcpus << 2;
 			goto realloc;
 		}
 #else
 		if (errno == EINVAL)
-			tst_resm(TFAIL,
-				 "NR_CPUS of the kernel is more than 1024, so we'd better use a newer glibc(>= 2.7)");
+			tst_brk(TBROK,
+				"NR_CPUS of the kernel is more than 1024, so we'd better use a newer glibc(>= 2.7)");
 		else
 #endif
-			tst_resm(TFAIL, "sched_getaffinity:errno:%d", errno);
-		tst_exit();
+			tst_brk(TBROK, "sched_getaffinity:errno:%d", errno);
 	}
 	cpu_max = max_cpuid(size, set);
-#if __GLIBC_PREREQ(2, 7)
 	CPU_ZERO_S(size, set);
 	CPU_SET_S(cpu_max, size, set);
-#else
-	CPU_ZERO(set);
-	CPU_SET(cpu_max, set);
-#endif
 	if (sched_setaffinity(0, size, set) < 0) {
 		CPU_FREE(set);
-		tst_brkm(TFAIL, NULL, "sched_setaffinity:errno:%d", errno);
+		tst_brk(TBROK, "sched_setaffinity:errno:%d", errno);
 	}
 	CPU_FREE(set);
 	return cpu_max;
 }
 
-/*
- * Return the maximum cpu id
- */
-#define BITS_PER_BYTE 8
-unsigned int max_cpuid(size_t size, cpu_set_t * set)
-{
-	unsigned int index, max = 0;
-	for (index = 0; index < size * BITS_PER_BYTE; index++)
-#if __GLIBC_PREREQ(2, 7)
-		if (CPU_ISSET_S(index, size, set))
-#else
-		if (CPU_ISSET(index, set))
-#endif
-			max = index;
-	return max;
-}
-
-/*
- * get_nodeid(cpuid) - This will return the node to which selected cpu belongs
- */
-unsigned int get_nodeid(unsigned int cpu_id)
+#ifdef __i386__
+static unsigned int get_nodeid(unsigned int cpu_id)
 {
 	DIR *directory_parent, *directory_node;
 	struct dirent *de, *dn;
@@ -269,12 +110,13 @@ unsigned int get_nodeid(unsigned int cpu_id)
 
 	directory_parent = opendir("/sys/devices/system/node");
 	if (!directory_parent) {
-		tst_resm(TCONF,
-			 "/sys not mounted or not a numa system. Assuming one node");
-		tst_resm(TCONF,
-			 "Error opening: /sys/devices/system/node :%s",
-			 strerror(errno));
-		return 0;	//By Default assume it to belong to node Zero
+		tst_res(TINFO,
+			"/sys not mounted or not a numa system. "
+			"Assuming one node");
+		tst_res(TINFO, "Error opening: /sys/devices/system/node :%s",
+			strerror(errno));
+		/* Assume CPU belongs to the only node, node zero. */
+		return 0;
 	} else {
 		while ((de = readdir(directory_parent)) != NULL) {
 			if (strncmp(de->d_name, "node", 4))
@@ -298,12 +140,52 @@ unsigned int get_nodeid(unsigned int cpu_id)
 	}
 	return node_id;
 }
+#endif
 
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
-void cleanup(void)
+static void run(void)
 {
+	unsigned int cpu_id, node_id = 0;
+	unsigned int cpu_set;
+#ifdef __i386__
+	unsigned int node_set;
+#endif
 
+	cpu_set = set_cpu_affinity();
+#ifdef __i386__
+	node_set = get_nodeid(cpu_set);
+#endif
+
+	TEST(get_cpu(&cpu_id, &node_id, NULL));
+	if (TST_RET == 0) {
+		if (cpu_id != cpu_set)
+			tst_res(TFAIL, "getcpu() returned wrong value"
+				" expected cpuid:%d, returned value cpuid: %d",
+				cpu_set, cpu_id);
+#ifdef __i386__
+		else if (node_id != node_set)
+			tst_res(TFAIL, "getcpu() returned wrong value"
+				" expected  node id:%d returned  node id:%d",
+				node_set, node_id);
+#endif
+		else
+			tst_res(TPASS, "getcpu() returned proper"
+				" cpuid:%d, node id:%d", cpu_id,
+				node_id);
+	} else {
+		tst_res(TFAIL, "getcpu() Failed, errno=%d:%s",
+			TST_ERR, strerror(TST_ERR));
+	}
+}
+
+static void setup(void)
+{
+	if (tst_kvercmp(2, 6, 20) < 0)
+		tst_brk(TCONF, "kernel >= 2.6.20 required");
+	if (!TEST_SUPPORTED)
+		tst_brk(TCONF, "insufficient C library support");
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+};
-- 
2.20.1.415.g653613c723-goog

