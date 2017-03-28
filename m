From: Li Wang <liwang@redhat.com>
Date: Tue, 28 Mar 2017 11:22:27 +0800
Subject: [LTP] [RFC PATCH 01/13] mem/lib: convert to new API
In-Reply-To: <20170328032239.11917-1-liwang@redhat.com>
References: <20170328032239.11917-1-liwang@redhat.com>
Message-ID: <20170328032239.11917-2-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/include/mem.h |   8 +-
 testcases/kernel/mem/lib/mem.c     | 268 ++++++++++++++++++-------------------
 2 files changed, 132 insertions(+), 144 deletions(-)

diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index f9522a5..4966f90 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -1,7 +1,7 @@
 #ifndef _MEM_H
 #define _MEM_H
 #include "config.h"
-#include "test.h"
+#include "tst_test.h"
 
 #if defined(__powerpc__) || defined(__powerpc64__)
 #define MAXNODES		256
@@ -84,16 +84,14 @@ void mount_mem(char *name, char *fs, char *options, char *path, char *path_new);
 void umount_mem(char *path, char *path_new);
 
 /* shared */
-unsigned int get_a_numa_node(void (*cleanup_fn)(void));
+unsigned int get_a_numa_node(void);
 int  path_exist(const char *path, ...);
 long read_meminfo(char *item);
 void set_sys_tune(char *sys_file, long tune, int check);
 long get_sys_tune(char *sys_file);
-void cleanup(void);
-void setup(void);
 
 void update_shm_size(size_t *shm_size);
 
 /* MMAP */
-int range_is_mapped(void (*cleanup_fn) (void), unsigned long low, unsigned long high);
+int range_is_mapped(unsigned long low, unsigned long high);
 #endif
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 7e403b5..7cc884f 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -1,9 +1,12 @@
+#define TST_NO_DEFAULT_MAIN
+
 #include "config.h"
 #include <sys/types.h>
 #include <sys/mman.h>
 #include <sys/mount.h>
 #include <sys/stat.h>
 #include <sys/wait.h>
+#include <sys/param.h>
 #include <errno.h>
 #include <fcntl.h>
 #if HAVE_NUMA_H
@@ -16,10 +19,9 @@
 #include <stdarg.h>
 #include <stdio.h>
 #include <string.h>
+#include <stdlib.h>
 #include <unistd.h>
 
-#include "test.h"
-#include "safe_macros.h"
 #include "mem.h"
 #include "numa_helper.h"
 
@@ -31,7 +33,7 @@ static int alloc_mem(long int length, int testcase)
 	long i, pagesz = getpagesize();
 	int loop = 10;
 
-	tst_resm(TINFO, "thread (%lx), allocating %ld bytes.",
+	tst_res(TINFO, "thread (%lx), allocating %ld bytes.",
 		(unsigned long) pthread_self(), length);
 
 	s = mmap(NULL, length, PROT_READ | PROT_WRITE,
@@ -80,7 +82,7 @@ static void child_alloc(int testcase, int lite, int threads)
 
 	th = malloc(sizeof(pthread_t) * threads);
 	if (!th) {
-		tst_resm(TINFO | TERRNO, "malloc");
+		tst_res(TINFO | TERRNO, "malloc");
 		goto out;
 	}
 
@@ -88,7 +90,7 @@ static void child_alloc(int testcase, int lite, int threads)
 		TEST(pthread_create(&th[i], NULL, child_alloc_thread,
 			(void *)((long)testcase)));
 		if (TEST_RETURN) {
-			tst_resm(TINFO | TRERRNO, "pthread_create");
+			tst_res(TINFO | TRERRNO, "pthread_create");
 			/*
 			 * Keep going if thread other than first fails to
 			 * spawn due to lack of resources.
@@ -128,10 +130,10 @@ void oom(int testcase, int lite, int retcode, int allow_sigkill)
 	switch (pid = fork()) {
 	case -1:
 		if (errno == retcode) {
-			tst_resm(TPASS | TERRNO, "fork");
+			tst_res(TPASS | TERRNO, "fork");
 			return;
 		}
-		tst_brkm(TBROK | TERRNO, cleanup, "fork");
+		tst_brk(TBROK | TERRNO, "fork");
 	case 0:
 		threads = MAX(1, tst_ncpus() - 1);
 		child_alloc(testcase, lite, threads);
@@ -139,31 +141,31 @@ void oom(int testcase, int lite, int retcode, int allow_sigkill)
 		break;
 	}
 
-	tst_resm(TINFO, "expected victim is %d.", pid);
+	tst_res(TINFO, "expected victim is %d.", pid);
 	if (waitpid(-1, &status, 0) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
+		tst_brk(TBROK | TERRNO, "waitpid");
 
 	if (WIFSIGNALED(status)) {
 		if (allow_sigkill && WTERMSIG(status) == SIGKILL) {
-			tst_resm(TPASS, "victim signalled: (%d) %s",
+			tst_res(TPASS, "victim signalled: (%d) %s",
 				SIGKILL,
 				tst_strsig(SIGKILL));
 		} else {
-			tst_resm(TFAIL, "victim signalled: (%d) %s",
+			tst_res(TFAIL, "victim signalled: (%d) %s",
 				WTERMSIG(status),
 				tst_strsig(WTERMSIG(status)));
 		}
 	} else if (WIFEXITED(status)) {
 		if (WEXITSTATUS(status) == retcode) {
-			tst_resm(TPASS, "victim retcode: (%d) %s",
+			tst_res(TPASS, "victim retcode: (%d) %s",
 				retcode, strerror(retcode));
 		} else {
-			tst_resm(TFAIL, "victim unexpectedly ended with "
+			tst_res(TFAIL, "victim unexpectedly ended with "
 				"retcode: %d, expected: %d",
 				WEXITSTATUS(status), retcode);
 		}
 	} else {
-		tst_resm(TFAIL, "victim unexpectedly ended");
+		tst_res(TFAIL, "victim unexpectedly ended");
 	}
 }
 
@@ -178,10 +180,9 @@ static void set_global_mempolicy(int mempolicy)
 	if (mempolicy) {
 		ret = get_allowed_nodes_arr(NH_MEMS|NH_CPUS, &num_nodes, &nodes);
 		if (ret != 0)
-			tst_brkm(TBROK|TERRNO, cleanup,
-				 "get_allowed_nodes_arr");
+			tst_brk(TBROK|TERRNO, "get_allowed_nodes_arr");
 		if (num_nodes < 2) {
-			tst_resm(TINFO, "mempolicy need NUMA system support");
+			tst_res(TINFO, "mempolicy need NUMA system support");
 			free(nodes);
 			return;
 		}
@@ -193,7 +194,7 @@ static void set_global_mempolicy(int mempolicy)
 		case MPOL_INTERLEAVE:
 		case MPOL_PREFERRED:
 			if (num_nodes == 2) {
-				tst_resm(TINFO, "The mempolicy need "
+				tst_res(TINFO, "The mempolicy need "
 					 "more than 2 numa nodes");
 				free(nodes);
 				return;
@@ -204,10 +205,10 @@ static void set_global_mempolicy(int mempolicy)
 			}
 			break;
 		default:
-			tst_brkm(TBROK|TERRNO, cleanup, "Bad mempolicy mode");
+			tst_brk(TBROK|TERRNO, "Bad mempolicy mode");
 		}
 		if (set_mempolicy(mempolicy, nmask, MAXNODES) == -1)
-			tst_brkm(TBROK|TERRNO, cleanup, "set_mempolicy");
+			tst_brk(TBROK|TERRNO, "set_mempolicy");
 	}
 #endif
 }
@@ -218,10 +219,10 @@ void testoom(int mempolicy, int lite, int retcode, int allow_sigkill)
 
 	set_global_mempolicy(mempolicy);
 
-	tst_resm(TINFO, "start normal OOM testing.");
+	tst_res(TINFO, "start normal OOM testing.");
 	oom(NORMAL, lite, retcode, allow_sigkill);
 
-	tst_resm(TINFO, "start OOM testing for mlocked pages.");
+	tst_res(TINFO, "start OOM testing for mlocked pages.");
 	oom(MLOCK, lite, retcode, allow_sigkill);
 
 	/*
@@ -229,14 +230,14 @@ void testoom(int mempolicy, int lite, int retcode, int allow_sigkill)
 	 * run to run, which isn't reliable for oom03 cgroup test.
 	 */
 	if (access(PATH_KSM, F_OK) == -1 || lite == 1) {
-		tst_resm(TINFO, "KSM is not configed or lite == 1, "
+		tst_res(TINFO, "KSM is not configed or lite == 1, "
 			 "skip OOM test for KSM pags");
 	} else {
-		tst_resm(TINFO, "start OOM testing for KSM pages.");
-		SAFE_FILE_SCANF(cleanup, PATH_KSM "run", "%d", &ksm_run_orig);
-		SAFE_FILE_PRINTF(cleanup, PATH_KSM "run", "1");
+		tst_res(TINFO, "start OOM testing for KSM pages.");
+		SAFE_FILE_SCANF(PATH_KSM "run", "%d", &ksm_run_orig);
+		SAFE_FILE_PRINTF(PATH_KSM "run", "1");
 		oom(KSM, lite, retcode, allow_sigkill);
-		SAFE_FILE_PRINTF(cleanup,PATH_KSM "run", "%d", ksm_run_orig);
+		SAFE_FILE_PRINTF(PATH_KSM "run", "%d", ksm_run_orig);
 	}
 }
 
@@ -247,8 +248,8 @@ static int max_page_sharing;
 void save_max_page_sharing(void)
 {
 	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
-	        SAFE_FILE_SCANF(NULL, PATH_KSM "max_page_sharing",
-	                        "%d", &max_page_sharing);
+		SAFE_FILE_SCANF(PATH_KSM "max_page_sharing",
+				"%d", &max_page_sharing);
 }
 
 void restore_max_page_sharing(void)
@@ -264,11 +265,11 @@ static void check(char *path, long int value)
 	long actual_val;
 
 	snprintf(fullpath, BUFSIZ, PATH_KSM "%s", path);
-	SAFE_FILE_SCANF(cleanup, fullpath, "%ld", &actual_val);
+	SAFE_FILE_SCANF(fullpath, "%ld", &actual_val);
 
-	tst_resm(TINFO, "%s is %ld.", path, actual_val);
+	tst_res(TINFO, "%s is %ld.", path, actual_val);
 	if (actual_val != value)
-		tst_resm(TFAIL, "%s is not %ld.", path, value);
+		tst_res(TFAIL, "%s is not %ld.", path, value);
 }
 
 static void wait_ksmd_done(void)
@@ -282,17 +283,10 @@ static void wait_ksmd_done(void)
 		sleep(10);
 		count++;
 
-		SAFE_FILE_SCANF(cleanup, PATH_KSM "pages_shared",
-				"%ld", &pages_shared);
-
-		SAFE_FILE_SCANF(cleanup, PATH_KSM "pages_sharing",
-				"%ld", &pages_sharing);
-
-		SAFE_FILE_SCANF(cleanup, PATH_KSM "pages_volatile",
-				"%ld", &pages_volatile);
-
-		SAFE_FILE_SCANF(cleanup, PATH_KSM "pages_unshared",
-				"%ld", &pages_unshared);
+		SAFE_FILE_SCANF(PATH_KSM "pages_shared", "%ld", &pages_shared);
+		SAFE_FILE_SCANF(PATH_KSM "pages_sharing", "%ld", &pages_sharing);
+		SAFE_FILE_SCANF(PATH_KSM "pages_volatile", "%ld", &pages_volatile);
+		SAFE_FILE_SCANF(PATH_KSM "pages_unshared", "%ld", &pages_unshared);
 
 		if (pages_shared != old_pages_shared ||
 		    pages_sharing != old_pages_sharing ||
@@ -307,7 +301,7 @@ static void wait_ksmd_done(void)
 		}
 	}
 
-	tst_resm(TINFO, "ksm daemon takes %ds to scan all mergeable pages",
+	tst_res(TINFO, "ksm daemon takes %ds to scan all mergeable pages",
 		 count * 10);
 }
 
@@ -318,7 +312,7 @@ static void group_check(int run, int pages_shared, int pages_sharing,
 	/* wait for ksm daemon to scan all mergeable pages. */
 	wait_ksmd_done();
 
-	tst_resm(TINFO, "check!");
+	tst_res(TINFO, "check!");
 	check("run", run);
 	check("pages_shared", pages_shared);
 	check("pages_sharing", pages_sharing);
@@ -336,16 +330,16 @@ static void verify(char **memory, char value, int proc,
 
 	s = malloc((end - start) * (end2 - start2));
 	if (s == NULL)
-		tst_brkm(TBROK | TERRNO, tst_exit, "malloc");
+		tst_brk(TBROK | TERRNO, "malloc");
 
-	tst_resm(TINFO, "child %d verifies memory content.", proc);
+	tst_res(TINFO, "child %d verifies memory content.", proc);
 	memset(s, value, (end - start) * (end2 - start2));
 	if (memcmp(memory[start], s, (end - start) * (end2 - start2))
 	    != 0)
 		for (j = start; j < end; j++)
 			for (i = start2; i < end2; i++)
 				if (memory[j][i] != value)
-					tst_resm(TFAIL, "child %d has %c at "
+					tst_res(TFAIL, "child %d has %c@"
 						 "%d,%d,%d.",
 						 proc, memory[j][i], proc,
 						 j, i);
@@ -354,9 +348,9 @@ static void verify(char **memory, char value, int proc,
 
 void write_memcg(void)
 {
-	SAFE_FILE_PRINTF(NULL, MEMCG_LIMIT, "%ld", TESTMEM);
+	SAFE_FILE_PRINTF(MEMCG_LIMIT, "%ld", TESTMEM);
 
-	SAFE_FILE_PRINTF(NULL, MEMCG_PATH_NEW "/tasks", "%d", getpid());
+	SAFE_FILE_PRINTF(MEMCG_PATH_NEW "/tasks", "%d", getpid());
 }
 
 struct ksm_merge_data {
@@ -370,14 +364,14 @@ static void ksm_child_memset(int child_num, int size, int total_unit,
 	int i = 0, j;
 	int unit = size / total_unit;
 
-	tst_resm(TINFO, "child %d continues...", child_num);
+	tst_res(TINFO, "child %d continues...", child_num);
 
 	if (ksm_merge_data.mergeable_size == size * MB) {
-		tst_resm(TINFO, "child %d allocates %d MB filled with '%c'",
+		tst_res(TINFO, "child %d allocates %d MB filled with '%c'",
 			child_num, size, ksm_merge_data.data);
 
 	} else {
-		tst_resm(TINFO, "child %d allocates %d MB filled with '%c'"
+		tst_res(TINFO, "child %d allocates %d MB filled with '%c'"
 				" except one page with 'e'",
 				child_num, size, ksm_merge_data.data);
 	}
@@ -409,16 +403,16 @@ static void create_ksm_child(int child_num, int size, int unit,
 		memory[j] = mmap(NULL, unit * MB, PROT_READ|PROT_WRITE,
 			MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
 		if (memory[j] == MAP_FAILED)
-			tst_brkm(TBROK|TERRNO, tst_exit, "mmap");
+			tst_brk(TBROK|TERRNO, "mmap");
 #ifdef HAVE_MADV_MERGEABLE
 		if (madvise(memory[j], unit * MB, MADV_MERGEABLE) == -1)
-			tst_brkm(TBROK|TERRNO, tst_exit, "madvise");
+			tst_brk(TBROK|TERRNO, "madvise");
 #endif
 	}
 
-	tst_resm(TINFO, "child %d stops.", child_num);
+	tst_res(TINFO, "child %d stops.", child_num);
 	if (raise(SIGSTOP) == -1)
-		tst_brkm(TBROK|TERRNO, tst_exit, "kill");
+		tst_brk(TBROK|TERRNO, "kill");
 	fflush(stdout);
 
 	for (j = 0; j < 4; j++) {
@@ -428,9 +422,9 @@ static void create_ksm_child(int child_num, int size, int unit,
 
 		fflush(stdout);
 
-		tst_resm(TINFO, "child %d stops.", child_num);
+		tst_res(TINFO, "child %d stops.", child_num);
 		if (raise(SIGSTOP) == -1)
-			tst_brkm(TBROK|TERRNO, tst_exit, "kill");
+			tst_brk(TBROK|TERRNO, "kill");
 
 		if (ksm_merge_data[j].mergeable_size < size * MB) {
 			verify(memory, 'e', child_num, total_unit - 1,
@@ -443,19 +437,19 @@ static void create_ksm_child(int child_num, int size, int unit,
 		}
 	}
 
-	tst_resm(TINFO, "child %d finished.", child_num);
+	tst_res(TINFO, "child %d finished.", child_num);
 }
 
 static void stop_ksm_children(int *child, int num)
 {
 	int k, status;
 
-	tst_resm(TINFO, "wait for all children to stop.");
+	tst_res(TINFO, "wait for all children to stop.");
 	for (k = 0; k < num; k++) {
 		if (waitpid(child[k], &status, WUNTRACED) == -1)
-			tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+			tst_brk(TBROK|TERRNO, "waitpid");
 		if (!WIFSTOPPED(status))
-			tst_brkm(TBROK, cleanup, "child %d was not stopped", k);
+			tst_brk(TBROK, "child %d was not stopped", k);
 	}
 }
 
@@ -463,10 +457,10 @@ static void resume_ksm_children(int *child, int num)
 {
 	int k;
 
-	tst_resm(TINFO, "resume all children.");
+	tst_res(TINFO, "resume all children.");
 	for (k = 0; k < num; k++) {
 		if (kill(child[k], SIGCONT) == -1)
-			tst_brkm(TBROK|TERRNO, cleanup, "kill child[%d]", k);
+			tst_brk(TBROK|TERRNO, "kill child[%d]", k);
 	}
 	fflush(stdout);
 }
@@ -503,13 +497,13 @@ void create_same_memory(int size, int num, int unit)
 
 	child = malloc(num * sizeof(int));
 	if (child == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup, "malloc");
+		tst_brk(TBROK | TERRNO, "malloc");
 
 	for (i = 0; i < num; i++) {
 		fflush(stdout);
 		switch (child[i] = fork()) {
 		case -1:
-			tst_brkm(TBROK|TERRNO, cleanup, "fork");
+			tst_brk(TBROK|TERRNO, "fork");
 		case 0:
 			if (i == 0) {
 				create_ksm_child(i, size, unit, ksm_data0);
@@ -529,14 +523,12 @@ void create_same_memory(int size, int num, int unit)
 
 	stop_ksm_children(child, num);
 
-	tst_resm(TINFO, "KSM merging...");
+	tst_res(TINFO, "KSM merging...");
 	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
-		SAFE_FILE_PRINTF(cleanup, PATH_KSM "max_page_sharing",
-				"%ld", size * pages * num);
-	SAFE_FILE_PRINTF(cleanup, PATH_KSM "run", "1");
-	SAFE_FILE_PRINTF(cleanup, PATH_KSM "pages_to_scan", "%ld",
-			 size * pages * num);
-	SAFE_FILE_PRINTF(cleanup, PATH_KSM "sleep_millisecs", "0");
+		SAFE_FILE_PRINTF(PATH_KSM "max_page_sharing", "%ld", size * pages * num);
+	SAFE_FILE_PRINTF(PATH_KSM "run", "1");
+	SAFE_FILE_PRINTF(PATH_KSM "pages_to_scan", "%ld", size * pages * num);
+	SAFE_FILE_PRINTF(PATH_KSM "sleep_millisecs", "0");
 
 	resume_ksm_children(child, num);
 	group_check(1, 2, size * num * pages - 2, 0, 0, 0, size * pages * num);
@@ -555,19 +547,19 @@ void create_same_memory(int size, int num, int unit)
 
 	stop_ksm_children(child, num);
 
-	tst_resm(TINFO, "KSM unmerging...");
-	SAFE_FILE_PRINTF(cleanup, PATH_KSM "run", "2");
+	tst_res(TINFO, "KSM unmerging...");
+	SAFE_FILE_PRINTF(PATH_KSM "run", "2");
 
 	resume_ksm_children(child, num);
 	group_check(2, 0, 0, 0, 0, 0, size * pages * num);
 
-	tst_resm(TINFO, "stop KSM.");
-	SAFE_FILE_PRINTF(cleanup, PATH_KSM "run", "0");
+	tst_res(TINFO, "stop KSM.");
+	SAFE_FILE_PRINTF(PATH_KSM "run", "0");
 	group_check(0, 0, 0, 0, 0, 0, size * pages * num);
 
 	while (waitpid(-1, &status, WUNTRACED | WCONTINUED) > 0)
 		if (WEXITSTATUS(status) != 0)
-			tst_resm(TFAIL, "child exit status is %d",
+			tst_res(TFAIL, "child exit status is %d",
 				 WEXITSTATUS(status));
 }
 
@@ -586,9 +578,9 @@ void test_ksm_merge_across_nodes(unsigned long nr_pages)
 
 	ret = get_allowed_nodes_arr(NH_MEMS|NH_CPUS, &num_nodes, &nodes);
 	if (ret != 0)
-		tst_brkm(TBROK|TERRNO, cleanup, "get_allowed_nodes_arr");
+		tst_brk(TBROK|TERRNO, "get_allowed_nodes_arr");
 	if (num_nodes < 2) {
-		tst_resm(TINFO, "need NUMA system support");
+		tst_res(TINFO, "need NUMA system support");
 		free(nodes);
 		return;
 	}
@@ -601,10 +593,10 @@ void test_ksm_merge_across_nodes(unsigned long nr_pages)
 		memory[i] = mmap(NULL, length, PROT_READ|PROT_WRITE,
 			    MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
 		if (memory[i] == MAP_FAILED)
-			tst_brkm(TBROK|TERRNO, tst_exit, "mmap");
+			tst_brk(TBROK|TERRNO, "mmap");
 #ifdef HAVE_MADV_MERGEABLE
 		if (madvise(memory[i], length, MADV_MERGEABLE) == -1)
-			tst_brkm(TBROK|TERRNO, tst_exit, "madvise");
+			tst_brk(TBROK|TERRNO, "madvise");
 #endif
 
 #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
@@ -617,17 +609,17 @@ void test_ksm_merge_across_nodes(unsigned long nr_pages)
 		 */
 		ret = mbind(memory[i], length, MPOL_BIND, nmask, MAXNODES, 0);
 		if (ret == -1)
-			tst_brkm(TBROK|TERRNO, tst_exit, "mbind");
+			tst_brk(TBROK|TERRNO, "mbind");
 #endif
 
 		memset(memory[i], 10, length);
 	}
 
-	SAFE_FILE_PRINTF(cleanup, PATH_KSM "sleep_millisecs", "0");
-	SAFE_FILE_PRINTF(cleanup, PATH_KSM "pages_to_scan", "%ld",
+	SAFE_FILE_PRINTF(PATH_KSM "sleep_millisecs", "0");
+	SAFE_FILE_PRINTF(PATH_KSM "pages_to_scan", "%ld",
 			 nr_pages * num_nodes);
 	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
-		SAFE_FILE_PRINTF(cleanup, PATH_KSM "max_page_sharing",
+		SAFE_FILE_PRINTF(PATH_KSM "max_page_sharing",
 			"%ld", nr_pages * num_nodes);
 	/*
 	 * merge_across_nodes setting can be changed only when there
@@ -635,23 +627,23 @@ void test_ksm_merge_across_nodes(unsigned long nr_pages)
 	 * pages first, then to 1 after changing merge_across_nodes,
 	 * to remerge according to the new setting.
 	 */
-	SAFE_FILE_PRINTF(cleanup, PATH_KSM "run", "2");
+	SAFE_FILE_PRINTF(PATH_KSM "run", "2");
 	wait_ksmd_done();
-	tst_resm(TINFO, "Start to test KSM with merge_across_nodes=1");
-	SAFE_FILE_PRINTF(cleanup, PATH_KSM "merge_across_nodes", "1");
-	SAFE_FILE_PRINTF(cleanup, PATH_KSM "run", "1");
+	tst_res(TINFO, "Start to test KSM with merge_across_nodes=1");
+	SAFE_FILE_PRINTF(PATH_KSM "merge_across_nodes", "1");
+	SAFE_FILE_PRINTF(PATH_KSM "run", "1");
 	group_check(1, 1, nr_pages * num_nodes - 1, 0, 0, 0,
 		    nr_pages * num_nodes);
 
-	SAFE_FILE_PRINTF(cleanup, PATH_KSM "run", "2");
+	SAFE_FILE_PRINTF(PATH_KSM "run", "2");
 	wait_ksmd_done();
-	tst_resm(TINFO, "Start to test KSM with merge_across_nodes=0");
-	SAFE_FILE_PRINTF(cleanup, PATH_KSM "merge_across_nodes", "0");
-	SAFE_FILE_PRINTF(cleanup, PATH_KSM "run", "1");
+	tst_res(TINFO, "Start to test KSM with merge_across_nodes=0");
+	SAFE_FILE_PRINTF(PATH_KSM "merge_across_nodes", "0");
+	SAFE_FILE_PRINTF(PATH_KSM "run", "1");
 	group_check(1, num_nodes, nr_pages * num_nodes - num_nodes,
 		    0, 0, 0, nr_pages * num_nodes);
 
-	SAFE_FILE_PRINTF(cleanup, PATH_KSM "run", "2");
+	SAFE_FILE_PRINTF(PATH_KSM "run", "2");
 	wait_ksmd_done();
 }
 
@@ -660,22 +652,22 @@ void check_ksm_options(int *size, int *num, int *unit)
 	if (opt_size) {
 		*size = atoi(opt_sizestr);
 		if (*size < 1)
-			tst_brkm(TBROK, cleanup, "size cannot be less than 1.");
+			tst_brk(TBROK, "size cannot be less than 1.");
 	}
 	if (opt_unit) {
 		*unit = atoi(opt_unitstr);
 		if (*unit > *size)
-			tst_brkm(TBROK, cleanup,
+			tst_brk(TBROK,
 				 "unit cannot be greater than size.");
 		if (*size % *unit != 0)
-			tst_brkm(TBROK, cleanup,
+			tst_brk(TBROK,
 				 "the remainder of division of size by unit is "
 				 "not zero.");
 	}
 	if (opt_num) {
 		*num = atoi(opt_numstr);
 		if (*num < 3)
-			tst_brkm(TBROK, cleanup,
+			tst_brk(TBROK,
 				 "process number cannot be less 3.");
 	}
 }
@@ -712,7 +704,7 @@ static void gather_node_cpus(char *cpus, long nd)
 			 * be taken offline
 			 */
 			if (path_exist(path1)) {
-				SAFE_FILE_SCANF(cleanup, path1, "%ld", &online);
+				SAFE_FILE_SCANF(path1, "%ld", &online);
 				if (online == 0)
 					continue;
 			}
@@ -742,13 +734,12 @@ void read_cpuset_files(char *prefix, char *filename, char *retbuf)
 				 prefix, filename);
 			fd = open(path, O_RDONLY);
 			if (fd == -1)
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "open %s", path);
+				tst_brk(TBROK | TERRNO, "open %s", path);
 		} else
-			tst_brkm(TBROK | TERRNO, cleanup, "open %s", path);
+			tst_brk(TBROK | TERRNO, "open %s", path);
 	}
 	if (read(fd, retbuf, BUFSIZ) < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "read %s", path);
+		tst_brk(TBROK | TERRNO, "read %s", path);
 	close(fd);
 }
 
@@ -770,13 +761,12 @@ void write_cpuset_files(char *prefix, char *filename, char *buf)
 				 prefix, filename);
 			fd = open(path, O_WRONLY);
 			if (fd == -1)
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "open %s", path);
+				tst_brk(TBROK | TERRNO, "open %s", path);
 		} else
-			tst_brkm(TBROK | TERRNO, cleanup, "open %s", path);
+			tst_brk(TBROK | TERRNO, "open %s", path);
 	}
 	if (write(fd, buf, strlen(buf)) != (ssize_t)strlen(buf))
-		tst_brkm(TBROK | TERRNO, cleanup, "write %s", path);
+		tst_brk(TBROK | TERRNO, "write %s", path);
 	close(fd);
 }
 
@@ -797,12 +787,12 @@ void write_cpusets(long nd)
 	if (strlen(cpus) != 0) {
 		write_cpuset_files(CPATH_NEW, "cpus", cpus);
 	} else {
-		tst_resm(TINFO, "No CPUs in the node%ld; "
+		tst_res(TINFO, "No CPUs in the node%ld; "
 				"using only CPU0", nd);
 		write_cpuset_files(CPATH_NEW, "cpus", "0");
 	}
 
-	SAFE_FILE_PRINTF(NULL, CPATH_NEW "/tasks", "%d", getpid());
+	SAFE_FILE_PRINTF(CPATH_NEW "/tasks", "%d", getpid());
 }
 
 void umount_mem(char *path, char *path_new)
@@ -815,53 +805,53 @@ void umount_mem(char *path, char *path_new)
 	sprintf(s, "%s/tasks", path);
 	fd = open(s, O_WRONLY);
 	if (fd == -1)
-		tst_resm(TWARN | TERRNO, "open %s", s);
+		tst_res(TWARN | TERRNO, "open %s", s);
 
 	snprintf(s_new, BUFSIZ, "%s/tasks", path_new);
 	fp = fopen(s_new, "r");
 	if (fp == NULL)
-		tst_resm(TWARN | TERRNO, "fopen %s", s_new);
+		tst_res(TWARN | TERRNO, "fopen %s", s_new);
 	if ((fd != -1) && (fp != NULL)) {
 		while (fgets(value, BUFSIZ, fp) != NULL)
 			if (write(fd, value, strlen(value) - 1)
 			    != (ssize_t)strlen(value) - 1)
-				tst_resm(TWARN | TERRNO, "write %s", s);
+				tst_res(TWARN | TERRNO, "write %s", s);
 	}
 	if (fd != -1)
 		close(fd);
 	if (fp != NULL)
 		fclose(fp);
 	if (rmdir(path_new) == -1)
-		tst_resm(TWARN | TERRNO, "rmdir %s", path_new);
+		tst_res(TWARN | TERRNO, "rmdir %s", path_new);
 	if (umount(path) == -1)
-		tst_resm(TWARN | TERRNO, "umount %s", path);
+		tst_res(TWARN | TERRNO, "umount %s", path);
 	if (rmdir(path) == -1)
-		tst_resm(TWARN | TERRNO, "rmdir %s", path);
+		tst_res(TWARN | TERRNO, "rmdir %s", path);
 }
 
 void mount_mem(char *name, char *fs, char *options, char *path, char *path_new)
 {
 	if (mkdir(path, 0777) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "mkdir %s", path);
+		tst_brk(TBROK | TERRNO, "mkdir %s", path);
 	if (mount(name, path, fs, 0, options) == -1) {
 		if (errno == ENODEV) {
 			if (rmdir(path) == -1)
-				tst_resm(TWARN | TERRNO, "rmdir %s failed",
+				tst_res(TWARN | TERRNO, "rmdir %s failed",
 					 path);
-			tst_brkm(TCONF, NULL,
+			tst_brk(TCONF,
 				 "file system %s is not configured in kernel",
 				 fs);
 		}
-		tst_brkm(TBROK | TERRNO, cleanup, "mount %s", path);
+		tst_brk(TBROK | TERRNO, "mount %s", path);
 	}
 	if (mkdir(path_new, 0777) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "mkdir %s", path_new);
+		tst_brk(TBROK | TERRNO, "mkdir %s", path_new);
 }
 
 /* shared */
 
 /* Warning: *DO NOT* use this function in child */
-unsigned int get_a_numa_node(void (*cleanup_fn) (void))
+unsigned int get_a_numa_node(void)
 {
 	unsigned int nd1, nd2;
 	int ret;
@@ -871,24 +861,24 @@ unsigned int get_a_numa_node(void (*cleanup_fn) (void))
 	case 0:
 		break;
 	case -3:
-		tst_brkm(TCONF, cleanup_fn, "requires a NUMA system.");
+		tst_brk(TCONF, "requires a NUMA system.");
 	default:
-		tst_brkm(TBROK | TERRNO, cleanup_fn, "1st get_allowed_nodes");
+		tst_brk(TBROK | TERRNO, "1st get_allowed_nodes");
 	}
 
 	ret = get_allowed_nodes(NH_MEMS | NH_CPUS, 1, &nd1);
 	switch (ret) {
 	case 0:
-		tst_resm(TINFO, "get node%u.", nd1);
+		tst_res(TINFO, "get node%u.", nd1);
 		return nd1;
 	case -3:
-		tst_brkm(TCONF, cleanup_fn, "requires a NUMA system that has "
+		tst_brk(TCONF, "requires a NUMA system that has "
 			 "at least one node with both memory and CPU "
 			 "available.");
 	default:
 		break;
 	}
-	tst_brkm(TBROK | TERRNO, cleanup_fn, "2nd get_allowed_nodes");
+	tst_brk(TBROK | TERRNO, "2nd get_allowed_nodes");
 }
 
 int path_exist(const char *path, ...)
@@ -911,7 +901,7 @@ long read_meminfo(char *item)
 
 	fp = fopen(PATH_MEMINFO, "r");
 	if (fp == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup, "fopen %s", PATH_MEMINFO);
+		tst_brk(TBROK | TERRNO, "fopen %s", PATH_MEMINFO);
 
 	while (fgets(line, BUFSIZ, fp) != NULL) {
 		if (sscanf(line, "%64s %ld", buf, &val) == 2)
@@ -923,7 +913,7 @@ long read_meminfo(char *item)
 	}
 	fclose(fp);
 
-	tst_brkm(TBROK, cleanup, "cannot find \"%s\" in %s",
+	tst_brk(TBROK, "cannot find \"%s\" in %s",
 		 item, PATH_MEMINFO);
 }
 
@@ -932,15 +922,15 @@ void set_sys_tune(char *sys_file, long tune, int check)
 	long val;
 	char path[BUFSIZ];
 
-	tst_resm(TINFO, "set %s to %ld", sys_file, tune);
+	tst_res(TINFO, "set %s to %ld", sys_file, tune);
 
 	snprintf(path, BUFSIZ, PATH_SYSVM "%s", sys_file);
-	SAFE_FILE_PRINTF(NULL, path, "%ld", tune);
+	SAFE_FILE_PRINTF(path, "%ld", tune);
 
 	if (check) {
 		val = get_sys_tune(sys_file);
 		if (val != tune)
-			tst_brkm(TBROK, cleanup, "%s = %ld, but expect %ld",
+			tst_brk(TBROK, "%s = %ld, but expect %ld",
 				 sys_file, val, tune);
 	}
 }
@@ -951,7 +941,7 @@ long get_sys_tune(char *sys_file)
 	long tune;
 
 	snprintf(path, BUFSIZ, PATH_SYSVM "%s", sys_file);
-	SAFE_FILE_SCANF(NULL, path, "%ld", &tune);
+	SAFE_FILE_SCANF(path, "%ld", &tune);
 
 	return tune;
 }
@@ -960,20 +950,20 @@ void update_shm_size(size_t * shm_size)
 {
 	size_t shmmax;
 
-	SAFE_FILE_SCANF(cleanup, PATH_SHMMAX, "%ld", &shmmax);
+	SAFE_FILE_SCANF(PATH_SHMMAX, "%ld", &shmmax);
 	if (*shm_size > shmmax) {
-		tst_resm(TINFO, "Set shm_size to shmmax: %ld", shmmax);
+		tst_res(TINFO, "Set shm_size to shmmax: %ld", shmmax);
 		*shm_size = shmmax;
 	}
 }
 
-int range_is_mapped(void (*cleanup_fn) (void), unsigned long low, unsigned long high)
+int range_is_mapped(unsigned long low, unsigned long high)
 {
 	FILE *fp;
 
 	fp = fopen("/proc/self/maps", "r");
 	if (fp == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup_fn, "Failed to open /proc/self/maps.");
+		tst_brk(TBROK | TERRNO, "Failed to open /proc/self/maps.");
 
 	while (!feof(fp)) {
 		unsigned long start, end;
@@ -982,7 +972,7 @@ int range_is_mapped(void (*cleanup_fn) (void), unsigned long low, unsigned long
 		ret = fscanf(fp, "%lx-%lx %*[^\n]\n", &start, &end);
 		if (ret != 2) {
 			fclose(fp);
-			tst_brkm(TBROK | TERRNO, cleanup_fn, "Couldn't parse /proc/self/maps line.");
+			tst_brk(TBROK | TERRNO, "Couldn't parse /proc/self/maps line.");
 		}
 
 		if ((start >= low) && (start < high)) {
-- 
2.9.3

