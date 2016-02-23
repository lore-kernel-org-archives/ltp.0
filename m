From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 23 Feb 2016 11:00:32 +0100
Subject: [LTP] [PATCH v2 2/2] numa_helper: add min_nodes parameter to
	is_numa()
In-Reply-To: <83c57fb26e06f81d4b71cb89dfcd36706bf28093.1456220777.git.jstancek@redhat.com>
References: <83c57fb26e06f81d4b71cb89dfcd36706bf28093.1456220777.git.jstancek@redhat.com>
Message-ID: <11305bbeff8a3b83ee9da6c4a17fc1cd9c37b9f5.1456220777.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

get_allowed_nodes() can fail if callers request more nodes than
are available. This patch changes is_numa() by adding a parameter
to it, which allows to easily check that system supports NUMA and
has at least certain number of nodes and it also updates tests
that used get_allowed_nodes() without checking node count first.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/include/numa_helper.h                    | 2 +-
 testcases/kernel/lib/numa_helper.c                        | 9 +++++----
 testcases/kernel/mem/ksm/ksm06.c                          | 4 ++--
 testcases/kernel/mem/oom/oom02.c                          | 2 +-
 testcases/kernel/mem/oom/oom03.c                          | 2 +-
 testcases/kernel/mem/oom/oom04.c                          | 5 ++++-
 testcases/kernel/mem/oom/oom05.c                          | 5 ++++-
 testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c | 3 +++
 testcases/kernel/syscalls/mbind/mbind01.c                 | 3 +++
 testcases/kernel/syscalls/migrate_pages/migrate_pages01.c | 4 ++--
 10 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/include/numa_helper.h b/testcases/kernel/include/numa_helper.h
index 3cf65d5638c4..a1eb593ea70c 100644
--- a/testcases/kernel/include/numa_helper.h
+++ b/testcases/kernel/include/numa_helper.h
@@ -34,6 +34,6 @@ unsigned long get_max_node(void);
 int get_allowed_nodes_arr(int flag, int *num_nodes, int **nodes);
 int get_allowed_nodes(int flag, int count, ...);
 void nh_dump_nodes(void);
-int is_numa(void (*cleanup_fn)(void));
+int is_numa(void (*cleanup_fn)(void), int min_nodes);
 
 #endif
diff --git a/testcases/kernel/lib/numa_helper.c b/testcases/kernel/lib/numa_helper.c
index 82b1978f7d8a..5b69bb0e0d5b 100644
--- a/testcases/kernel/lib/numa_helper.c
+++ b/testcases/kernel/lib/numa_helper.c
@@ -281,14 +281,15 @@ void nh_dump_nodes(void)
 
 /*
  * is_numa - judge a system is NUMA system or not
- * NOTE: the function is designed to try to find more than
- *       1 available node, at least each node contains memory.
+ * @min_nodes: find at least 'min_nodes' nodes with memory
+ * NOTE: the function is designed to try to find at least 'min_nodes'
+ * available nodes, where each node contains memory.
  * WARN: Don't use this func in child, as it calls tst_brkm()
  * RETURNS:
  *     0 - it's not a NUMA system
  *     1 - it's a NUMA system
  */
-int is_numa(void (*cleanup_fn)(void))
+int is_numa(void (*cleanup_fn)(void), int min_nodes)
 {
 	int ret;
 	int numa_nodes = 0;
@@ -297,7 +298,7 @@ int is_numa(void (*cleanup_fn)(void))
 	if (ret < 0)
 		tst_brkm(TBROK | TERRNO, cleanup_fn, "get_allowed_nodes_arr");
 
-	if (numa_nodes > 1)
+	if (numa_nodes >= min_nodes)
 		return 1;
 	else
 		return 0;
diff --git a/testcases/kernel/mem/ksm/ksm06.c b/testcases/kernel/mem/ksm/ksm06.c
index 1cda01fe61b8..fc4d5b5bd825 100644
--- a/testcases/kernel/mem/ksm/ksm06.c
+++ b/testcases/kernel/mem/ksm/ksm06.c
@@ -95,8 +95,8 @@ void setup(void)
 	if (access(PATH_KSM "merge_across_nodes", F_OK) == -1)
 		tst_brkm(TCONF, NULL, "no merge_across_nodes sysfs knob");
 
-	if (!is_numa(NULL))
-		tst_brkm(TCONF, NULL, "The case need a NUMA system.");
+	if (!is_numa(NULL, 2))
+		tst_brkm(TCONF, NULL, "The case needs a NUMA system.");
 
 	/* save the current value */
 	SAFE_FILE_SCANF(NULL, PATH_KSM "run", "%d", &run);
diff --git a/testcases/kernel/mem/oom/oom02.c b/testcases/kernel/mem/oom/oom02.c
index 48bd0a3ad632..53acc1534a7c 100644
--- a/testcases/kernel/mem/oom/oom02.c
+++ b/testcases/kernel/mem/oom/oom02.c
@@ -79,7 +79,7 @@ void setup(void)
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;
 
-	if (!is_numa(NULL))
+	if (!is_numa(NULL, 2))
 		tst_brkm(TCONF, NULL, "The case need a NUMA system.");
 
 	overcommit = get_sys_tune("overcommit_memory");
diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
index 3afc3dea48bf..06e6e90a346f 100644
--- a/testcases/kernel/mem/oom/oom03.c
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -77,7 +77,7 @@ int main(int argc, char *argv[])
 		}
 
 		/* OOM for MEMCG with mempolicy */
-		if (is_numa(cleanup)) {
+		if (is_numa(cleanup, 2)) {
 			tst_resm(TINFO, "OOM on MEMCG & mempolicy...");
 			testoom(MPOL_BIND, 0, ENOMEM, 1);
 			testoom(MPOL_INTERLEAVE, 0, ENOMEM, 1);
diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
index 0a315e110972..391cc1651c0e 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -63,7 +63,7 @@ int main(int argc, char *argv[])
 		tst_resm(TINFO, "OOM on CPUSET...");
 		testoom(0, 0, ENOMEM, 1);
 
-		if (is_numa(cleanup)) {
+		if (is_numa(cleanup, 2)) {
 			/*
 			 * Under NUMA system, the migration of cpuset's memory
 			 * is in charge of cpuset.memory_migrate, we can write
@@ -87,6 +87,9 @@ void setup(void)
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;
 
+	if (!is_numa(NULL, 1))
+		tst_brkm(TCONF, NULL, "requires NUMA with at least 1 node");
+
 	overcommit = get_sys_tune("overcommit_memory");
 	set_sys_tune("overcommit_memory", 1, 1);
 
diff --git a/testcases/kernel/mem/oom/oom05.c b/testcases/kernel/mem/oom/oom05.c
index 44a243e2f2bd..4b31d59e1a65 100644
--- a/testcases/kernel/mem/oom/oom05.c
+++ b/testcases/kernel/mem/oom/oom05.c
@@ -69,7 +69,7 @@ int main(int argc, char *argv[])
 		 * is in charge of cpuset.memory_migrate, we can write
 		 * 1 to cpuset.memory_migrate to enable the migration.
 		 */
-		if (is_numa(cleanup)) {
+		if (is_numa(cleanup, 2)) {
 			write_cpuset_files(CPATH_NEW, "memory_migrate", "1");
 			tst_resm(TINFO, "OOM on CPUSET & MEMCG with "
 					"cpuset.memory_migrate=1");
@@ -110,6 +110,9 @@ void setup(void)
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;
 
+	if (!is_numa(NULL, 1))
+		tst_brkm(TCONF, NULL, "requires NUMA with at least 1 node");
+
 	overcommit = get_sys_tune("overcommit_memory");
 	set_sys_tune("overcommit_memory", 1, 1);
 
diff --git a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
index e4cff88a5b6d..c0f83f908467 100644
--- a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
+++ b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
@@ -339,6 +339,9 @@ static void setup(void)
 	/* check syscall availability */
 	ltp_syscall(__NR_get_mempolicy, NULL, NULL, 0, NULL, 0);
 
+	if (!is_numa(NULL, 1))
+		tst_brkm(TCONF, NULL, "requires NUMA with at least 1 node");
+
 	TEST_PAUSE;
 	tst_tmpdir();
 }
diff --git a/testcases/kernel/syscalls/mbind/mbind01.c b/testcases/kernel/syscalls/mbind/mbind01.c
index d56f39e96c59..28506c50df36 100644
--- a/testcases/kernel/syscalls/mbind/mbind01.c
+++ b/testcases/kernel/syscalls/mbind/mbind01.c
@@ -298,6 +298,9 @@ static void setup(void)
 	/* check syscall availability */
 	ltp_syscall(__NR_mbind, NULL, 0, 0, NULL, 0, 0);
 
+	if (!is_numa(NULL, 1))
+		tst_brkm(TCONF, NULL, "requires NUMA with at least 1 node");
+
 	TEST_PAUSE;
 	tst_tmpdir();
 }
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
index 6484b40d72a5..ad520fc15ab9 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
@@ -226,8 +226,8 @@ static void setup(void)
 	tst_require_root();
 	TEST(ltp_syscall(__NR_migrate_pages, 0, 0, NULL, NULL));
 
-	if (numa_available() == -1)
-		tst_brkm(TCONF, NULL, "NUMA not available");
+	if (!is_numa(NULL, 1))
+		tst_brkm(TCONF, NULL, "requires NUMA with at least 1 node");
 
 	ret = get_allowed_nodes(NH_MEMS, 1, &node);
 	if (ret < 0)
-- 
1.8.3.1

