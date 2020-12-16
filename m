From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed, 16 Dec 2020 10:01:21 +0000
Subject: [LTP] [RFC PATCH 5/5] cgroups: convert tests to use API rewrite
In-Reply-To: <20201216100121.16683-1-rpalethorpe@suse.com>
References: <20201216100121.16683-1-rpalethorpe@suse.com>
Message-ID: <20201216100121.16683-6-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

---
 testcases/kernel/mem/cpuset/cpuset01.c | 18 +++++++++---------
 testcases/kernel/mem/include/mem.h     |  2 +-
 testcases/kernel/mem/ksm/ksm02.c       |  8 ++++----
 testcases/kernel/mem/ksm/ksm03.c       |  8 ++++----
 testcases/kernel/mem/ksm/ksm04.c       | 15 +++++++--------
 testcases/kernel/mem/lib/mem.c         |  8 ++++----
 testcases/kernel/mem/oom/oom03.c       | 12 ++++++------
 testcases/kernel/mem/oom/oom04.c       | 10 +++++-----
 testcases/kernel/mem/oom/oom05.c       | 23 +++++++++++------------
 9 files changed, 51 insertions(+), 53 deletions(-)

diff --git a/testcases/kernel/mem/cpuset/cpuset01.c b/testcases/kernel/mem/cpuset/cpuset01.c
index 528c3eddd..f2a1b8d26 100644
--- a/testcases/kernel/mem/cpuset/cpuset01.c
+++ b/testcases/kernel/mem/cpuset/cpuset01.c
@@ -51,11 +51,11 @@ static void test_cpuset(void)
 	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
 	char mems[BUFSIZ], buf[BUFSIZ];
 
-	tst_cgroup_cpuset_read_files(PATH_TMP_CG_CST, "cpus", buf, BUFSIZ);
-	tst_cgroup_cpuset_write_files(PATH_TMP_CG_CST, "cpus", buf);
-	tst_cgroup_cpuset_read_files(PATH_TMP_CG_CST, "mems", mems, BUFSIZ);
-	tst_cgroup_cpuset_write_files(PATH_TMP_CG_CST, "mems", mems);
-	tst_cgroup_move_current(PATH_TMP_CG_CST);
+	tst_cgroup_cpuset_read_files("cpus", buf, BUFSIZ);
+	tst_cgroup_cpuset_write_files("cpus", buf);
+	tst_cgroup_cpuset_read_files("mems", mems, BUFSIZ);
+	tst_cgroup_cpuset_write_files("mems", mems);
+	tst_cgroup_move_current(TST_CGROUP_CPUSET);
 
 	child = SAFE_FORK();
 	if (child == 0) {
@@ -70,9 +70,9 @@ static void test_cpuset(void)
 	}
 
 	snprintf(buf, BUFSIZ, "%d", nodes[0]);
-	tst_cgroup_cpuset_write_files(PATH_TMP_CG_CST, "mems", buf);
+	tst_cgroup_cpuset_write_files("mems", buf);
 	snprintf(buf, BUFSIZ, "%d", nodes[1]);
-	tst_cgroup_cpuset_write_files(PATH_TMP_CG_CST, "mems", buf);
+	tst_cgroup_cpuset_write_files("mems", buf);
 
 	SAFE_WAITPID(child, &status, WUNTRACED | WCONTINUED);
 	if (WEXITSTATUS(status) != 0) {
@@ -85,7 +85,7 @@ static void test_cpuset(void)
 
 static void setup(void)
 {
-	tst_cgroup_mount(TST_CGROUP_CPUSET, PATH_TMP_CG_CST);
+	tst_cgroup_require(TST_CGROUP_CPUSET, NULL);
 	ncpus = count_cpu();
 	if (get_allowed_nodes_arr(NH_MEMS | NH_CPUS, &nnodes, &nodes) < 0)
 		tst_brk(TBROK | TERRNO, "get_allowed_nodes_arr");
@@ -95,7 +95,7 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	tst_cgroup_umount(PATH_TMP_CG_CST);
+	tst_cgroup_cleanup(NULL);
 }
 
 static void sighandler(int signo LTP_ATTRIBUTE_UNUSED)
diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index 42b12a230..7fda05d6f 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -61,7 +61,7 @@ void check_hugepage(void);
 void write_memcg(void);
 
 /* cpuset/memcg - include/tst_cgroup.h */
-void write_cpusets(const char *cgroup_dir, long nd);
+void write_cpusets(long nd);
 
 /* shared */
 unsigned int get_a_numa_node(void);
diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index 7417398a8..8f7f4fae3 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -76,8 +76,8 @@ static void verify_ksm(void)
 	}
 	create_same_memory(size, num, unit);
 
-	write_cpusets(PATH_TMP_CG_CST, node);
-	tst_cgroup_move_current(PATH_TMP_CG_CST);
+	write_cpusets(node);
+	tst_cgroup_move_current(TST_CGROUP_CPUSET);
 	create_same_memory(size, num, unit);
 }
 
@@ -87,7 +87,7 @@ static void cleanup(void)
 		FILE_PRINTF(PATH_KSM "merge_across_nodes",
 				 "%d", merge_across_nodes);
 
-	tst_cgroup_umount(PATH_TMP_CG_CST);
+	tst_cgroup_cleanup(NULL);
 }
 
 static void setup(void)
@@ -103,7 +103,7 @@ static void setup(void)
 		SAFE_FILE_PRINTF(PATH_KSM "merge_across_nodes", "1");
 	}
 
-	tst_cgroup_mount(TST_CGROUP_CPUSET, PATH_TMP_CG_CST);
+	tst_cgroup_require(TST_CGROUP_CPUSET, NULL);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/ksm/ksm03.c b/testcases/kernel/mem/ksm/ksm03.c
index cc3695e95..a7ea4c345 100644
--- a/testcases/kernel/mem/ksm/ksm03.c
+++ b/testcases/kernel/mem/ksm/ksm03.c
@@ -61,8 +61,8 @@
 
 static void verify_ksm(void)
 {
-	tst_cgroup_move_current(PATH_TMP_CG_MEM);
-	tst_cgroup_mem_set_maxbytes(PATH_TMP_CG_MEM, TESTMEM);
+	tst_cgroup_move_current(TST_CGROUP_MEMORY);
+	tst_cgroup_mem_set_maxbytes(TESTMEM);
 	create_same_memory(size, num, unit);
 }
 
@@ -78,7 +78,7 @@ static void setup(void)
 	}
 
 	parse_ksm_options(opt_sizestr, &size, opt_numstr, &num, opt_unitstr, &unit);
-	tst_cgroup_mount(TST_CGROUP_MEMCG, PATH_TMP_CG_MEM);
+	tst_cgroup_require(TST_CGROUP_MEMORY, NULL);
 }
 
 static void cleanup(void)
@@ -86,7 +86,7 @@ static void cleanup(void)
 	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0)
 		FILE_PRINTF(PATH_KSM "merge_across_nodes",
 				 "%d", merge_across_nodes);
-	tst_cgroup_umount(PATH_TMP_CG_MEM);
+	tst_cgroup_cleanup(NULL);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index 1207c4827..3cb789ab9 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -67,8 +67,8 @@ static void verify_ksm(void)
 	node = get_a_numa_node();
 	set_node(nmask, node);
 
-	tst_cgroup_move_current(PATH_TMP_CG_MEM);
-	tst_cgroup_mem_set_maxbytes(PATH_TMP_CG_MEM, TESTMEM);
+	tst_cgroup_move_current(TST_CGROUP_MEMORY);
+	tst_cgroup_mem_set_maxbytes(TESTMEM);
 
 	if (set_mempolicy(MPOL_BIND, nmask, MAXNODES) == -1) {
 		if (errno != ENOSYS)
@@ -79,8 +79,8 @@ static void verify_ksm(void)
 	}
 	create_same_memory(size, num, unit);
 
-	write_cpusets(PATH_TMP_CG_CST, node);
-	tst_cgroup_move_current(PATH_TMP_CG_CST);
+	write_cpusets(node);
+	tst_cgroup_move_current(TST_CGROUP_CPUSET);
 	create_same_memory(size, num, unit);
 }
 
@@ -90,8 +90,7 @@ static void cleanup(void)
 		FILE_PRINTF(PATH_KSM "merge_across_nodes",
 				 "%d", merge_across_nodes);
 
-	tst_cgroup_umount(PATH_TMP_CG_MEM);
-	tst_cgroup_umount(PATH_TMP_CG_CST);
+	tst_cgroup_cleanup(NULL);
 }
 
 static void setup(void)
@@ -107,8 +106,8 @@ static void setup(void)
 
 	parse_ksm_options(opt_sizestr, &size, opt_numstr, &num, opt_unitstr, &unit);
 
-	tst_cgroup_mount(TST_CGROUP_MEMCG, PATH_TMP_CG_MEM);
-	tst_cgroup_mount(TST_CGROUP_CPUSET, PATH_TMP_CG_CST);
+	tst_cgroup_require(TST_CGROUP_MEMORY, NULL);
+	tst_cgroup_require(TST_CGROUP_CPUSET, NULL);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 2de3f83a6..b98e0da75 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -629,13 +629,13 @@ static void gather_node_cpus(char *cpus, long nd)
 	cpus[strlen(cpus) - 1] = '\0';
 }
 
-void write_cpusets(const char *cgroup_dir, long nd)
+void write_cpusets(long nd)
 {
 	char buf[BUFSIZ];
 	char cpus[BUFSIZ] = "";
 
 	snprintf(buf, BUFSIZ, "%ld", nd);
-	tst_cgroup_cpuset_write_files(cgroup_dir, "mems", buf);
+	tst_cgroup_cpuset_write_files("mems", buf);
 
 	gather_node_cpus(cpus, nd);
 	/*
@@ -644,11 +644,11 @@ void write_cpusets(const char *cgroup_dir, long nd)
 	 * the value of cpuset.cpus.
 	 */
 	if (strlen(cpus) != 0) {
-		tst_cgroup_cpuset_write_files(cgroup_dir, "cpus", cpus);
+		tst_cgroup_cpuset_write_files("cpus", cpus);
 	} else {
 		tst_res(TINFO, "No CPUs in the node%ld; "
 				"using only CPU0", nd);
-		tst_cgroup_cpuset_write_files(cgroup_dir, "cpus", "0");
+		tst_cgroup_cpuset_write_files("cpus", "0");
 	}
 }
 
diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
index fc860c660..c193adcf1 100644
--- a/testcases/kernel/mem/oom/oom03.c
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -42,13 +42,13 @@ static void verify_oom(void)
 	tst_brk(TCONF, "test is not designed for 32-bit system.");
 #endif
 
-	tst_cgroup_move_current(PATH_TMP_CG_MEM);
-	tst_cgroup_mem_set_maxbytes(PATH_TMP_CG_MEM, TESTMEM);
+	tst_cgroup_move_current(TST_CGROUP_MEMORY);
+	tst_cgroup_mem_set_maxbytes(TESTMEM);
 
 	testoom(0, 0, ENOMEM, 1);
 
-	if (tst_cgroup_mem_swapacct_enabled(PATH_TMP_CG_MEM)) {
-		tst_cgroup_mem_set_maxswap(PATH_TMP_CG_MEM, TESTMEM);
+	if (tst_cgroup_mem_swapacct_enabled()) {
+		tst_cgroup_mem_set_maxswap(TESTMEM);
 		testoom(0, 1, ENOMEM, 1);
 	}
 
@@ -65,14 +65,14 @@ static void setup(void)
 {
 	overcommit = get_sys_tune("overcommit_memory");
 	set_sys_tune("overcommit_memory", 1, 1);
-	tst_cgroup_mount(TST_CGROUP_MEMCG, PATH_TMP_CG_MEM);
+	tst_cgroup_require(TST_CGROUP_MEMORY, NULL);
 }
 
 static void cleanup(void)
 {
 	if (overcommit != -1)
 		set_sys_tune("overcommit_memory", overcommit, 0);
-	tst_cgroup_umount(PATH_TMP_CG_MEM);
+	tst_cgroup_cleanup(NULL);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
index 582663275..d7d724bb9 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -42,7 +42,7 @@ static void verify_oom(void)
 	tst_brk(TCONF, "test is not designed for 32-bit system.");
 #endif
 
-	tst_cgroup_move_current(PATH_TMP_CG_CST);
+	tst_cgroup_move_current(TST_CGROUP_CPUSET);
 
 	tst_res(TINFO, "OOM on CPUSET...");
 	testoom(0, 0, ENOMEM, 1);
@@ -53,7 +53,7 @@ static void verify_oom(void)
 		 * is in charge of cpuset.memory_migrate, we can write
 		 * 1 to cpuset.memory_migrate to enable the migration.
 		 */
-		tst_cgroup_cpuset_write_files(PATH_TMP_CG_CST, "memory_migrate", "1");
+		tst_cgroup_cpuset_write_files("memory_migrate", "1");
 		tst_res(TINFO, "OOM on CPUSET with mem migrate:");
 		testoom(0, 0, ENOMEM, 1);
 	}
@@ -69,7 +69,7 @@ static void setup(void)
 	overcommit = get_sys_tune("overcommit_memory");
 	set_sys_tune("overcommit_memory", 1, 1);
 
-	tst_cgroup_mount(TST_CGROUP_CPUSET, PATH_TMP_CG_CST);
+	tst_cgroup_require(TST_CGROUP_CPUSET, NULL);
 
 	/*
 	 * Some nodes do not contain memory, so use
@@ -81,14 +81,14 @@ static void setup(void)
 	if (ret < 0)
 		tst_brk(TBROK, "Failed to get a memory node "
 			      "using get_allowed_nodes()");
-	write_cpusets(PATH_TMP_CG_CST, memnode);
+	write_cpusets(memnode);
 }
 
 static void cleanup(void)
 {
 	if (overcommit != -1)
 		set_sys_tune("overcommit_memory", overcommit, 0);
-	tst_cgroup_umount(PATH_TMP_CG_CST);
+	tst_cgroup_cleanup(NULL);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/oom/oom05.c b/testcases/kernel/mem/oom/oom05.c
index 871f302e3..63dd63500 100644
--- a/testcases/kernel/mem/oom/oom05.c
+++ b/testcases/kernel/mem/oom/oom05.c
@@ -43,9 +43,9 @@ static void verify_oom(void)
 #endif
 
 	tst_res(TINFO, "OOM on CPUSET & MEMCG...");
-	tst_cgroup_move_current(PATH_TMP_CG_MEM);
-	tst_cgroup_move_current(PATH_TMP_CG_CST);
-	tst_cgroup_mem_set_maxbytes(PATH_TMP_CG_MEM, TESTMEM);
+	tst_cgroup_move_current(TST_CGROUP_MEMORY);
+	tst_cgroup_move_current(TST_CGROUP_CPUSET);
+	tst_cgroup_mem_set_maxbytes(TESTMEM);
 	testoom(0, 0, ENOMEM, 1);
 
 	/*
@@ -54,21 +54,21 @@ static void verify_oom(void)
 	 * 1 to cpuset.memory_migrate to enable the migration.
 	 */
 	if (is_numa(NULL, NH_MEMS, 2)) {
-		tst_cgroup_cpuset_write_files(PATH_TMP_CG_CST, "memory_migrate", "1");
+		tst_cgroup_cpuset_write_files("memory_migrate", "1");
 		tst_res(TINFO, "OOM on CPUSET & MEMCG with "
 				"cpuset.memory_migrate=1");
 		testoom(0, 0, ENOMEM, 1);
 	}
 
-	if (tst_cgroup_mem_swapacct_enabled(PATH_TMP_CG_MEM)) {
+	if (tst_cgroup_mem_swapacct_enabled()) {
 		tst_res(TINFO, "OOM on CPUSET & MEMCG with "
 				"special memswap limitation:");
-		tst_cgroup_mem_set_maxswap(PATH_TMP_CG_MEM, TESTMEM);
+		tst_cgroup_mem_set_maxswap(TESTMEM);
 		testoom(0, 0, ENOMEM, 1);
 
 		tst_res(TINFO, "OOM on CPUSET & MEMCG with "
 				"disabled memswap limitation:");
-		tst_cgroup_mem_set_maxswap(PATH_TMP_CG_MEM, -1);
+		tst_cgroup_mem_set_maxswap(-1);
 		testoom(0, 0, ENOMEM, 1);
 	}
 }
@@ -83,8 +83,8 @@ void setup(void)
 	overcommit = get_sys_tune("overcommit_memory");
 	set_sys_tune("overcommit_memory", 1, 1);
 
-	tst_cgroup_mount(TST_CGROUP_MEMCG, PATH_TMP_CG_MEM);
-	tst_cgroup_mount(TST_CGROUP_CPUSET, PATH_TMP_CG_CST);
+	tst_cgroup_require(TST_CGROUP_MEMORY, NULL);
+	tst_cgroup_require(TST_CGROUP_CPUSET, NULL);
 
 	/*
 	 * Some nodes do not contain memory, so use
@@ -96,15 +96,14 @@ void setup(void)
 	if (ret < 0)
 		tst_brk(TBROK, "Failed to get a memory node "
 			      "using get_allowed_nodes()");
-	write_cpusets(PATH_TMP_CG_CST, memnode);
+	write_cpusets(memnode);
 }
 
 void cleanup(void)
 {
 	if (overcommit != -1)
 		set_sys_tune("overcommit_memory", overcommit, 0);
-	tst_cgroup_umount(PATH_TMP_CG_MEM);
-	tst_cgroup_umount(PATH_TMP_CG_CST);
+	tst_cgroup_cleanup(NULL);
 }
 
 static struct tst_test test = {
-- 
2.29.2

