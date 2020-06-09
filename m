From: Li Wang <liwang@redhat.com>
Date: Tue,  9 Jun 2020 17:51:00 +0800
Subject: [LTP] [PATCH v4 2/4] mem: take use of new cgroup API
In-Reply-To: <20200609095102.21153-1-liwang@redhat.com>
References: <20200609095102.21153-1-liwang@redhat.com>
Message-ID: <20200609095102.21153-2-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

For issue #611:
  https://github.com/linux-test-project/ltp/issues/611

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/cpuset/cpuset01.c | 19 +++++++------
 testcases/kernel/mem/include/mem.h     |  3 +-
 testcases/kernel/mem/ksm/ksm02.c       | 12 ++++----
 testcases/kernel/mem/ksm/ksm03.c       | 12 +++-----
 testcases/kernel/mem/ksm/ksm04.c       | 21 ++++++--------
 testcases/kernel/mem/lib/mem.c         | 10 +++----
 testcases/kernel/mem/oom/oom03.c       | 22 ++++-----------
 testcases/kernel/mem/oom/oom04.c       | 14 ++++-----
 testcases/kernel/mem/oom/oom05.c       | 39 ++++++++------------------
 9 files changed, 57 insertions(+), 95 deletions(-)

diff --git a/testcases/kernel/mem/cpuset/cpuset01.c b/testcases/kernel/mem/cpuset/cpuset01.c
index 853f7fe55..8b1b6fcdf 100644
--- a/testcases/kernel/mem/cpuset/cpuset01.c
+++ b/testcases/kernel/mem/cpuset/cpuset01.c
@@ -51,11 +51,11 @@ static void test_cpuset(void)
 	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
 	char mems[BUFSIZ], buf[BUFSIZ];
 
-	read_cpuset_files(CPATH, "cpus", buf);
-	write_cpuset_files(CPATH_NEW, "cpus", buf);
-	read_cpuset_files(CPATH, "mems", mems);
-	write_cpuset_files(CPATH_NEW, "mems", mems);
-	SAFE_FILE_PRINTF(CPATH_NEW "/tasks", "%d", getpid());
+	tst_cgroup_move_current(PATH_TMP_CG_CST);
+	tst_cgroup_cpuset_read_files(PATH_TMP_CG_CST, "cpus", buf);
+	tst_cgroup_cpuset_write_files(PATH_TMP_CG_CST, "cpus", buf);
+	tst_cgroup_cpuset_read_files(PATH_TMP_CG_CST, "mems", mems);
+	tst_cgroup_cpuset_write_files(PATH_TMP_CG_CST, "mems", mems);
 
 	child = SAFE_FORK();
 	if (child == 0) {
@@ -70,9 +70,9 @@ static void test_cpuset(void)
 	}
 
 	snprintf(buf, BUFSIZ, "%d", nodes[0]);
-	write_cpuset_files(CPATH_NEW, "mems", buf);
+	tst_cgroup_cpuset_write_files(PATH_TMP_CG_CST, "mems", buf);
 	snprintf(buf, BUFSIZ, "%d", nodes[1]);
-	write_cpuset_files(CPATH_NEW, "mems", buf);
+	tst_cgroup_cpuset_write_files(PATH_TMP_CG_CST, "mems", buf);
 
 	SAFE_WAITPID(child, &status, WUNTRACED | WCONTINUED);
 	if (WEXITSTATUS(status) != 0) {
@@ -85,7 +85,7 @@ static void test_cpuset(void)
 
 static void setup(void)
 {
-	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
+	tst_cgroup_mount(TST_CGROUP_CPUSET, PATH_TMP_CG_CST);
 	ncpus = count_cpu();
 	if (get_allowed_nodes_arr(NH_MEMS | NH_CPUS, &nnodes, &nodes) < 0)
 		tst_brk(TBROK | TERRNO, "get_allowed_nodes_arr");
@@ -95,7 +95,7 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	umount_mem(CPATH, CPATH_NEW);
+	tst_cgroup_umount(PATH_TMP_CG_CST);
 }
 
 static void sighandler(int signo LTP_ATTRIBUTE_UNUSED)
@@ -183,6 +183,7 @@ static long count_cpu(void)
 
 static struct tst_test test = {
 	.needs_root = 1,
+	.forks_child = 1,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = test_cpuset,
diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index cce9c0497..c5dca1d9b 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -2,6 +2,7 @@
 #define _MEM_H
 #include "config.h"
 #include "tst_test.h"
+#include "tst_cgroup.h"
 #include "ksm_helper.h"
 
 #if defined(__powerpc__) || defined(__powerpc64__)
@@ -74,7 +75,7 @@ void write_memcg(void);
 
 void read_cpuset_files(char *prefix, char *filename, char *retbuf);
 void write_cpuset_files(char *prefix, char *filename, char *buf);
-void write_cpusets(long nd);
+void write_cpusets(const char *cgroup_dir, long nd);
 void mount_mem(char *name, char *fs, char *options, char *path, char *path_new);
 void umount_mem(char *path, char *path_new);
 
diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index 3d4c19deb..771f4dd65 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -59,13 +59,13 @@
 #ifdef HAVE_NUMA_V2
 #include <numaif.h>
 
-static int cpuset_mounted;
-
 static void verify_ksm(void)
 {
 	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
 	unsigned int node;
 
+	tst_cgroup_move_current(PATH_TMP_CG_CST);
+
 	node = get_a_numa_node();
 	set_node(nmask, node);
 
@@ -78,7 +78,7 @@ static void verify_ksm(void)
 	}
 	create_same_memory(size, num, unit);
 
-	write_cpusets(node);
+	write_cpusets(PATH_TMP_CG_CST, node);
 	create_same_memory(size, num, unit);
 }
 
@@ -88,8 +88,7 @@ static void cleanup(void)
 		FILE_PRINTF(PATH_KSM "merge_across_nodes",
 				 "%d", merge_across_nodes);
 
-	if (cpuset_mounted)
-		umount_mem(CPATH, CPATH_NEW);
+	tst_cgroup_umount(PATH_TMP_CG_CST);
 }
 
 static void setup(void)
@@ -105,8 +104,7 @@ static void setup(void)
 		SAFE_FILE_PRINTF(PATH_KSM "merge_across_nodes", "1");
 	}
 
-	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
-	cpuset_mounted = 1;
+	tst_cgroup_mount(TST_CGROUP_CPUSET, PATH_TMP_CG_CST);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/ksm/ksm03.c b/testcases/kernel/mem/ksm/ksm03.c
index 0e5131654..cc3695e95 100644
--- a/testcases/kernel/mem/ksm/ksm03.c
+++ b/testcases/kernel/mem/ksm/ksm03.c
@@ -59,11 +59,10 @@
 #include "mem.h"
 #include "ksm_common.h"
 
-static int memcg_mounted;
-
 static void verify_ksm(void)
 {
-	write_memcg();
+	tst_cgroup_move_current(PATH_TMP_CG_MEM);
+	tst_cgroup_mem_set_maxbytes(PATH_TMP_CG_MEM, TESTMEM);
 	create_same_memory(size, num, unit);
 }
 
@@ -79,8 +78,7 @@ static void setup(void)
 	}
 
 	parse_ksm_options(opt_sizestr, &size, opt_numstr, &num, opt_unitstr, &unit);
-	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
-	memcg_mounted = 1;
+	tst_cgroup_mount(TST_CGROUP_MEMCG, PATH_TMP_CG_MEM);
 }
 
 static void cleanup(void)
@@ -88,9 +86,7 @@ static void cleanup(void)
 	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0)
 		FILE_PRINTF(PATH_KSM "merge_across_nodes",
 				 "%d", merge_across_nodes);
-
-	if (memcg_mounted)
-		umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
+	tst_cgroup_umount(PATH_TMP_CG_MEM);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index e393dbd40..8af529d91 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -59,9 +59,6 @@
 #ifdef HAVE_NUMA_V2
 #include <numaif.h>
 
-static int cpuset_mounted;
-static int memcg_mounted;
-
 static void verify_ksm(void)
 {
 	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
@@ -70,7 +67,8 @@ static void verify_ksm(void)
 	node = get_a_numa_node();
 	set_node(nmask, node);
 
-	write_memcg();
+	tst_cgroup_move_current(PATH_TMP_CG_MEM);
+	tst_cgroup_mem_set_maxbytes(PATH_TMP_CG_MEM, TESTMEM);
 
 	if (set_mempolicy(MPOL_BIND, nmask, MAXNODES) == -1) {
 		if (errno != ENOSYS)
@@ -81,7 +79,8 @@ static void verify_ksm(void)
 	}
 	create_same_memory(size, num, unit);
 
-	write_cpusets(node);
+	tst_cgroup_move_current(PATH_TMP_CG_CST);
+	write_cpusets(PATH_TMP_CG_CST, node);
 	create_same_memory(size, num, unit);
 }
 
@@ -91,10 +90,8 @@ static void cleanup(void)
 		FILE_PRINTF(PATH_KSM "merge_across_nodes",
 				 "%d", merge_across_nodes);
 
-	if (cpuset_mounted)
-		umount_mem(CPATH, CPATH_NEW);
-	if (memcg_mounted)
-		umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
+	tst_cgroup_umount(PATH_TMP_CG_MEM);
+	tst_cgroup_umount(PATH_TMP_CG_CST);
 }
 
 static void setup(void)
@@ -110,10 +107,8 @@ static void setup(void)
 
 	parse_ksm_options(opt_sizestr, &size, opt_numstr, &num, opt_unitstr, &unit);
 
-	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
-	cpuset_mounted = 1;
-	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
-	memcg_mounted = 1;
+	tst_cgroup_mount(TST_CGROUP_MEMCG, PATH_TMP_CG_MEM);
+	tst_cgroup_mount(TST_CGROUP_CPUSET, PATH_TMP_CG_CST);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index eca4c61c8..50bee39cb 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -686,13 +686,13 @@ void write_cpuset_files(char *prefix, char *filename, char *buf)
 	close(fd);
 }
 
-void write_cpusets(long nd)
+void write_cpusets(const char *cgroup_dir, long nd)
 {
 	char buf[BUFSIZ];
 	char cpus[BUFSIZ] = "";
 
 	snprintf(buf, BUFSIZ, "%ld", nd);
-	write_cpuset_files(CPATH_NEW, "mems", buf);
+	tst_cgroup_cpuset_write_files(cgroup_dir, "mems", buf);
 
 	gather_node_cpus(cpus, nd);
 	/*
@@ -701,14 +701,12 @@ void write_cpusets(long nd)
 	 * the value of cpuset.cpus.
 	 */
 	if (strlen(cpus) != 0) {
-		write_cpuset_files(CPATH_NEW, "cpus", cpus);
+		tst_cgroup_cpuset_write_files(cgroup_dir, "cpus", cpus);
 	} else {
 		tst_res(TINFO, "No CPUs in the node%ld; "
 				"using only CPU0", nd);
-		write_cpuset_files(CPATH_NEW, "cpus", "0");
+		tst_cgroup_cpuset_write_files(cgroup_dir, "cpus", "0");
 	}
-
-	SAFE_FILE_PRINTF(CPATH_NEW "/tasks", "%d", getpid());
 }
 
 void umount_mem(char *path, char *path_new)
diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
index ce0b34c31..fc860c660 100644
--- a/testcases/kernel/mem/oom/oom03.c
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -36,27 +36,19 @@
 
 #ifdef HAVE_NUMA_V2
 
-static int memcg_mounted;
-
 static void verify_oom(void)
 {
 #ifdef TST_ABI32
 	tst_brk(TCONF, "test is not designed for 32-bit system.");
 #endif
 
-	SAFE_FILE_PRINTF(MEMCG_PATH_NEW "/tasks", "%d", getpid());
-	SAFE_FILE_PRINTF(MEMCG_LIMIT, "%ld", TESTMEM);
+	tst_cgroup_move_current(PATH_TMP_CG_MEM);
+	tst_cgroup_mem_set_maxbytes(PATH_TMP_CG_MEM, TESTMEM);
 
 	testoom(0, 0, ENOMEM, 1);
 
-	if (access(MEMCG_SW_LIMIT, F_OK) == -1) {
-		if (errno == ENOENT)
-			tst_res(TCONF,
-				"memcg swap accounting is disabled");
-		else
-			tst_brk(TBROK | TERRNO, "access");
-	} else {
-		SAFE_FILE_PRINTF(MEMCG_SW_LIMIT, "%ld", TESTMEM);
+	if (tst_cgroup_mem_swapacct_enabled(PATH_TMP_CG_MEM)) {
+		tst_cgroup_mem_set_maxswap(PATH_TMP_CG_MEM, TESTMEM);
 		testoom(0, 1, ENOMEM, 1);
 	}
 
@@ -73,16 +65,14 @@ static void setup(void)
 {
 	overcommit = get_sys_tune("overcommit_memory");
 	set_sys_tune("overcommit_memory", 1, 1);
-	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
-	memcg_mounted = 1;
+	tst_cgroup_mount(TST_CGROUP_MEMCG, PATH_TMP_CG_MEM);
 }
 
 static void cleanup(void)
 {
 	if (overcommit != -1)
 		set_sys_tune("overcommit_memory", overcommit, 0);
-	if (memcg_mounted)
-		umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
+	tst_cgroup_umount(PATH_TMP_CG_MEM);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
index 7185ef973..582663275 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -36,14 +36,14 @@
 
 #ifdef HAVE_NUMA_V2
 
-static int cpuset_mounted;
-
 static void verify_oom(void)
 {
 #ifdef TST_ABI32
 	tst_brk(TCONF, "test is not designed for 32-bit system.");
 #endif
 
+	tst_cgroup_move_current(PATH_TMP_CG_CST);
+
 	tst_res(TINFO, "OOM on CPUSET...");
 	testoom(0, 0, ENOMEM, 1);
 
@@ -53,7 +53,7 @@ static void verify_oom(void)
 		 * is in charge of cpuset.memory_migrate, we can write
 		 * 1 to cpuset.memory_migrate to enable the migration.
 		 */
-		write_cpuset_files(CPATH_NEW, "memory_migrate", "1");
+		tst_cgroup_cpuset_write_files(PATH_TMP_CG_CST, "memory_migrate", "1");
 		tst_res(TINFO, "OOM on CPUSET with mem migrate:");
 		testoom(0, 0, ENOMEM, 1);
 	}
@@ -69,8 +69,7 @@ static void setup(void)
 	overcommit = get_sys_tune("overcommit_memory");
 	set_sys_tune("overcommit_memory", 1, 1);
 
-	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
-	cpuset_mounted = 1;
+	tst_cgroup_mount(TST_CGROUP_CPUSET, PATH_TMP_CG_CST);
 
 	/*
 	 * Some nodes do not contain memory, so use
@@ -82,15 +81,14 @@ static void setup(void)
 	if (ret < 0)
 		tst_brk(TBROK, "Failed to get a memory node "
 			      "using get_allowed_nodes()");
-	write_cpusets(memnode);
+	write_cpusets(PATH_TMP_CG_CST, memnode);
 }
 
 static void cleanup(void)
 {
 	if (overcommit != -1)
 		set_sys_tune("overcommit_memory", overcommit, 0);
-	if (cpuset_mounted)
-		umount_mem(CPATH, CPATH_NEW);
+	tst_cgroup_umount(PATH_TMP_CG_CST);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/oom/oom05.c b/testcases/kernel/mem/oom/oom05.c
index db24df6de..871f302e3 100644
--- a/testcases/kernel/mem/oom/oom05.c
+++ b/testcases/kernel/mem/oom/oom05.c
@@ -36,18 +36,16 @@
 
 #ifdef HAVE_NUMA_V2
 
-static int memcg_mounted;
-static int cpuset_mounted;
-
 static void verify_oom(void)
 {
-	int swap_acc_on = 1;
-
 #ifdef TST_ABI32
 	tst_brk(TCONF, "test is not designed for 32-bit system.");
 #endif
 
 	tst_res(TINFO, "OOM on CPUSET & MEMCG...");
+	tst_cgroup_move_current(PATH_TMP_CG_MEM);
+	tst_cgroup_move_current(PATH_TMP_CG_CST);
+	tst_cgroup_mem_set_maxbytes(PATH_TMP_CG_MEM, TESTMEM);
 	testoom(0, 0, ENOMEM, 1);
 
 	/*
@@ -56,29 +54,21 @@ static void verify_oom(void)
 	 * 1 to cpuset.memory_migrate to enable the migration.
 	 */
 	if (is_numa(NULL, NH_MEMS, 2)) {
-		write_cpuset_files(CPATH_NEW, "memory_migrate", "1");
+		tst_cgroup_cpuset_write_files(PATH_TMP_CG_CST, "memory_migrate", "1");
 		tst_res(TINFO, "OOM on CPUSET & MEMCG with "
 				"cpuset.memory_migrate=1");
 		testoom(0, 0, ENOMEM, 1);
 	}
 
-	if (access(MEMCG_SW_LIMIT, F_OK) == -1) {
-		if (errno == ENOENT) {
-			tst_res(TCONF, "memcg swap accounting is disabled");
-			swap_acc_on = 0;
-		} else
-			tst_brk(TBROK|TERRNO, "access");
-	}
-
-	if (swap_acc_on) {
+	if (tst_cgroup_mem_swapacct_enabled(PATH_TMP_CG_MEM)) {
 		tst_res(TINFO, "OOM on CPUSET & MEMCG with "
 				"special memswap limitation:");
-		SAFE_FILE_PRINTF(MEMCG_SW_LIMIT, "%ld", TESTMEM);
+		tst_cgroup_mem_set_maxswap(PATH_TMP_CG_MEM, TESTMEM);
 		testoom(0, 0, ENOMEM, 1);
 
 		tst_res(TINFO, "OOM on CPUSET & MEMCG with "
 				"disabled memswap limitation:");
-		SAFE_FILE_PRINTF(MEMCG_SW_LIMIT, "-1");
+		tst_cgroup_mem_set_maxswap(PATH_TMP_CG_MEM, -1);
 		testoom(0, 0, ENOMEM, 1);
 	}
 }
@@ -93,11 +83,8 @@ void setup(void)
 	overcommit = get_sys_tune("overcommit_memory");
 	set_sys_tune("overcommit_memory", 1, 1);
 
-	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
-	memcg_mounted = 1;
-	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
-	cpuset_mounted = 1;
-	write_memcg();
+	tst_cgroup_mount(TST_CGROUP_MEMCG, PATH_TMP_CG_MEM);
+	tst_cgroup_mount(TST_CGROUP_CPUSET, PATH_TMP_CG_CST);
 
 	/*
 	 * Some nodes do not contain memory, so use
@@ -109,17 +96,15 @@ void setup(void)
 	if (ret < 0)
 		tst_brk(TBROK, "Failed to get a memory node "
 			      "using get_allowed_nodes()");
-	write_cpusets(memnode);
+	write_cpusets(PATH_TMP_CG_CST, memnode);
 }
 
 void cleanup(void)
 {
 	if (overcommit != -1)
 		set_sys_tune("overcommit_memory", overcommit, 0);
-	if (cpuset_mounted)
-		umount_mem(CPATH, CPATH_NEW);
-	if (memcg_mounted)
-		umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
+	tst_cgroup_umount(PATH_TMP_CG_MEM);
+	tst_cgroup_umount(PATH_TMP_CG_CST);
 }
 
 static struct tst_test test = {
-- 
2.21.1

