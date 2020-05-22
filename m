From: Li Wang <liwang@redhat.com>
Date: Fri, 22 May 2020 09:23:25 +0800
Subject: [LTP] [PATCH RFC 2/4] mem: take use of new cgroup API
In-Reply-To: <20200522012327.18991-1-liwang@redhat.com>
References: <20200522012327.18991-1-liwang@redhat.com>
Message-ID: <20200522012327.18991-2-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

For issue #611:
  https://github.com/linux-test-project/ltp/issues/611

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/cpuset/cpuset01.c | 19 +++++++++--------
 testcases/kernel/mem/include/mem.h     |  1 +
 testcases/kernel/mem/ksm/ksm02.c       |  6 ++----
 testcases/kernel/mem/ksm/ksm03.c       | 11 +++-------
 testcases/kernel/mem/ksm/ksm04.c       | 14 +++++--------
 testcases/kernel/mem/lib/mem.c         |  8 +++----
 testcases/kernel/mem/oom/oom03.c       | 20 +++++++++---------
 testcases/kernel/mem/oom/oom04.c       |  8 +++----
 testcases/kernel/mem/oom/oom05.c       | 29 ++++++++++++++------------
 9 files changed, 54 insertions(+), 62 deletions(-)

diff --git a/testcases/kernel/mem/cpuset/cpuset01.c b/testcases/kernel/mem/cpuset/cpuset01.c
index 853f7fe55..0db919121 100644
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
+	read_cpuset_files(PATH_TMP_CG1_CST, "cpus", buf);
+	write_cpuset_files(PATH_CG1_CST_LTP, "cpus", buf);
+	read_cpuset_files(PATH_TMP_CG1_CST, "mems", mems);
+	write_cpuset_files(PATH_CG1_CST_LTP, "mems", mems);
+	SAFE_FILE_PRINTF(PATH_CG1_CST_LTP "/tasks", "%d", getpid());
 
 	child = SAFE_FORK();
 	if (child == 0) {
@@ -70,9 +70,9 @@ static void test_cpuset(void)
 	}
 
 	snprintf(buf, BUFSIZ, "%d", nodes[0]);
-	write_cpuset_files(CPATH_NEW, "mems", buf);
+	write_cpuset_files(PATH_CG1_CST_LTP, "mems", buf);
 	snprintf(buf, BUFSIZ, "%d", nodes[1]);
-	write_cpuset_files(CPATH_NEW, "mems", buf);
+	write_cpuset_files(PATH_CG1_CST_LTP, "mems", buf);
 
 	SAFE_WAITPID(child, &status, WUNTRACED | WCONTINUED);
 	if (WEXITSTATUS(status) != 0) {
@@ -85,7 +85,7 @@ static void test_cpuset(void)
 
 static void setup(void)
 {
-	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
+	tst_mount_cpusetcg();
 	ncpus = count_cpu();
 	if (get_allowed_nodes_arr(NH_MEMS | NH_CPUS, &nnodes, &nodes) < 0)
 		tst_brk(TBROK | TERRNO, "get_allowed_nodes_arr");
@@ -95,7 +95,7 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	umount_mem(CPATH, CPATH_NEW);
+	tst_umount_cpusetcg();
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
index cce9c0497..f553651c2 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -2,6 +2,7 @@
 #define _MEM_H
 #include "config.h"
 #include "tst_test.h"
+#include "tst_cgroup.h"
 #include "ksm_helper.h"
 
 #if defined(__powerpc__) || defined(__powerpc64__)
diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index 3d4c19deb..dffafc412 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -88,8 +88,7 @@ static void cleanup(void)
 		FILE_PRINTF(PATH_KSM "merge_across_nodes",
 				 "%d", merge_across_nodes);
 
-	if (cpuset_mounted)
-		umount_mem(CPATH, CPATH_NEW);
+	tst_umount_cpusetcg();
 }
 
 static void setup(void)
@@ -105,8 +104,7 @@ static void setup(void)
 		SAFE_FILE_PRINTF(PATH_KSM "merge_across_nodes", "1");
 	}
 
-	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
-	cpuset_mounted = 1;
+	tst_mount_cpusetcg();
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/ksm/ksm03.c b/testcases/kernel/mem/ksm/ksm03.c
index 0e5131654..8dd794a75 100644
--- a/testcases/kernel/mem/ksm/ksm03.c
+++ b/testcases/kernel/mem/ksm/ksm03.c
@@ -59,11 +59,9 @@
 #include "mem.h"
 #include "ksm_common.h"
 
-static int memcg_mounted;
-
 static void verify_ksm(void)
 {
-	write_memcg();
+	tst_write_memcg(TESTMEM);
 	create_same_memory(size, num, unit);
 }
 
@@ -79,8 +77,7 @@ static void setup(void)
 	}
 
 	parse_ksm_options(opt_sizestr, &size, opt_numstr, &num, opt_unitstr, &unit);
-	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
-	memcg_mounted = 1;
+	tst_mount_memcg();
 }
 
 static void cleanup(void)
@@ -88,9 +85,7 @@ static void cleanup(void)
 	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0)
 		FILE_PRINTF(PATH_KSM "merge_across_nodes",
 				 "%d", merge_across_nodes);
-
-	if (memcg_mounted)
-		umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
+	tst_umount_memcg();
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index e393dbd40..0a6fbd8a4 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -70,7 +70,7 @@ static void verify_ksm(void)
 	node = get_a_numa_node();
 	set_node(nmask, node);
 
-	write_memcg();
+	tst_write_memcg(TESTMEM);
 
 	if (set_mempolicy(MPOL_BIND, nmask, MAXNODES) == -1) {
 		if (errno != ENOSYS)
@@ -91,10 +91,8 @@ static void cleanup(void)
 		FILE_PRINTF(PATH_KSM "merge_across_nodes",
 				 "%d", merge_across_nodes);
 
-	if (cpuset_mounted)
-		umount_mem(CPATH, CPATH_NEW);
-	if (memcg_mounted)
-		umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
+	tst_umount_cpusetcg();
+	tst_umount_memcg();
 }
 
 static void setup(void)
@@ -110,10 +108,8 @@ static void setup(void)
 
 	parse_ksm_options(opt_sizestr, &size, opt_numstr, &num, opt_unitstr, &unit);
 
-	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
-	cpuset_mounted = 1;
-	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
-	memcg_mounted = 1;
+	tst_mount_memcg();
+	tst_mount_cpusetcg();
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index eca4c61c8..df1baa42a 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -692,7 +692,7 @@ void write_cpusets(long nd)
 	char cpus[BUFSIZ] = "";
 
 	snprintf(buf, BUFSIZ, "%ld", nd);
-	write_cpuset_files(CPATH_NEW, "mems", buf);
+	write_cpuset_files(PATH_CG1_CST_LTP, "mems", buf);
 
 	gather_node_cpus(cpus, nd);
 	/*
@@ -701,14 +701,14 @@ void write_cpusets(long nd)
 	 * the value of cpuset.cpus.
 	 */
 	if (strlen(cpus) != 0) {
-		write_cpuset_files(CPATH_NEW, "cpus", cpus);
+		write_cpuset_files(PATH_CG1_CST_LTP, "cpus", cpus);
 	} else {
 		tst_res(TINFO, "No CPUs in the node%ld; "
 				"using only CPU0", nd);
-		write_cpuset_files(CPATH_NEW, "cpus", "0");
+		write_cpuset_files(PATH_CG1_CST_LTP, "cpus", "0");
 	}
 
-	SAFE_FILE_PRINTF(CPATH_NEW "/tasks", "%d", getpid());
+	SAFE_FILE_PRINTF(PATH_CG1_CST_LTP "/tasks", "%d", getpid());
 }
 
 void umount_mem(char *path, char *path_new)
diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
index ce0b34c31..b437952f3 100644
--- a/testcases/kernel/mem/oom/oom03.c
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -36,27 +36,29 @@
 
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
+	tst_write_memcg(TESTMEM);
 
 	testoom(0, 0, ENOMEM, 1);
 
-	if (access(MEMCG_SW_LIMIT, F_OK) == -1) {
+	if ((access(PATH_MEMORY_SW_LIMIT, F_OK) == -1) ||
+			(access(PATH_MEMORY_SW_MAX, F_OK) == -1)) {
 		if (errno == ENOENT)
 			tst_res(TCONF,
 				"memcg swap accounting is disabled");
 		else
 			tst_brk(TBROK | TERRNO, "access");
 	} else {
-		SAFE_FILE_PRINTF(MEMCG_SW_LIMIT, "%ld", TESTMEM);
+		if (tst_cg_ver & TST_CGROUP_V1)
+			SAFE_FILE_PRINTF(PATH_MEMORY_SW_LIMIT, "%ld", TESTMEM);
+		if (tst_cg_ver & TST_CGROUP_V2)
+			SAFE_FILE_PRINTF(PATH_MEMORY_SW_MAX, "%ld", TESTMEM);
+
 		testoom(0, 1, ENOMEM, 1);
 	}
 
@@ -73,16 +75,14 @@ static void setup(void)
 {
 	overcommit = get_sys_tune("overcommit_memory");
 	set_sys_tune("overcommit_memory", 1, 1);
-	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
-	memcg_mounted = 1;
+	tst_mount_memcg();
 }
 
 static void cleanup(void)
 {
 	if (overcommit != -1)
 		set_sys_tune("overcommit_memory", overcommit, 0);
-	if (memcg_mounted)
-		umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
+	tst_umount_memcg();
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
index 7185ef973..0ce4c81ae 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -53,7 +53,7 @@ static void verify_oom(void)
 		 * is in charge of cpuset.memory_migrate, we can write
 		 * 1 to cpuset.memory_migrate to enable the migration.
 		 */
-		write_cpuset_files(CPATH_NEW, "memory_migrate", "1");
+		write_cpuset_files(PATH_CG1_CST_LTP, "memory_migrate", "1");
 		tst_res(TINFO, "OOM on CPUSET with mem migrate:");
 		testoom(0, 0, ENOMEM, 1);
 	}
@@ -69,8 +69,7 @@ static void setup(void)
 	overcommit = get_sys_tune("overcommit_memory");
 	set_sys_tune("overcommit_memory", 1, 1);
 
-	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
-	cpuset_mounted = 1;
+	tst_mount_cpusetcg();
 
 	/*
 	 * Some nodes do not contain memory, so use
@@ -89,8 +88,7 @@ static void cleanup(void)
 {
 	if (overcommit != -1)
 		set_sys_tune("overcommit_memory", overcommit, 0);
-	if (cpuset_mounted)
-		umount_mem(CPATH, CPATH_NEW);
+	tst_umount_cpusetcg();
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/oom/oom05.c b/testcases/kernel/mem/oom/oom05.c
index db24df6de..1ab272655 100644
--- a/testcases/kernel/mem/oom/oom05.c
+++ b/testcases/kernel/mem/oom/oom05.c
@@ -56,13 +56,14 @@ static void verify_oom(void)
 	 * 1 to cpuset.memory_migrate to enable the migration.
 	 */
 	if (is_numa(NULL, NH_MEMS, 2)) {
-		write_cpuset_files(CPATH_NEW, "memory_migrate", "1");
+		write_cpuset_files(PATH_CG1_CST_LTP, "memory_migrate", "1");
 		tst_res(TINFO, "OOM on CPUSET & MEMCG with "
 				"cpuset.memory_migrate=1");
 		testoom(0, 0, ENOMEM, 1);
 	}
 
-	if (access(MEMCG_SW_LIMIT, F_OK) == -1) {
+	if ((access(PATH_MEMORY_SW_LIMIT, F_OK) == -1) ||
+			(access(PATH_MEMORY_SW_MAX, F_OK) == -1)) {
 		if (errno == ENOENT) {
 			tst_res(TCONF, "memcg swap accounting is disabled");
 			swap_acc_on = 0;
@@ -73,12 +74,18 @@ static void verify_oom(void)
 	if (swap_acc_on) {
 		tst_res(TINFO, "OOM on CPUSET & MEMCG with "
 				"special memswap limitation:");
-		SAFE_FILE_PRINTF(MEMCG_SW_LIMIT, "%ld", TESTMEM);
+		if (tst_cg_ver & TST_CGROUP_V1)
+			SAFE_FILE_PRINTF(PATH_MEMORY_SW_LIMIT, "%ld", TESTMEM);
+		if (tst_cg_ver & TST_CGROUP_V2)
+			SAFE_FILE_PRINTF(PATH_MEMORY_SW_MAX, "%ld", TESTMEM);
 		testoom(0, 0, ENOMEM, 1);
 
 		tst_res(TINFO, "OOM on CPUSET & MEMCG with "
 				"disabled memswap limitation:");
-		SAFE_FILE_PRINTF(MEMCG_SW_LIMIT, "-1");
+		if (tst_cg_ver & TST_CGROUP_V1)
+			SAFE_FILE_PRINTF(PATH_MEMORY_SW_LIMIT, "%ld", -1);
+		if (tst_cg_ver & TST_CGROUP_V2)
+			SAFE_FILE_PRINTF(PATH_MEMORY_SW_MAX, "%ld", -1);
 		testoom(0, 0, ENOMEM, 1);
 	}
 }
@@ -93,11 +100,9 @@ void setup(void)
 	overcommit = get_sys_tune("overcommit_memory");
 	set_sys_tune("overcommit_memory", 1, 1);
 
-	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
-	memcg_mounted = 1;
-	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
-	cpuset_mounted = 1;
-	write_memcg();
+	tst_mount_memcg();
+	tst_mount_cpusetcg();
+	tst_write_memcg(TESTMEM);
 
 	/*
 	 * Some nodes do not contain memory, so use
@@ -116,10 +121,8 @@ void cleanup(void)
 {
 	if (overcommit != -1)
 		set_sys_tune("overcommit_memory", overcommit, 0);
-	if (cpuset_mounted)
-		umount_mem(CPATH, CPATH_NEW);
-	if (memcg_mounted)
-		umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
+	tst_umount_cpusetcg();
+	tst_umount_memcg();
 }
 
 static struct tst_test test = {
-- 
2.21.1

