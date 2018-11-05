From: Jan Stancek <jstancek@redhat.com>
Date: Mon,  5 Nov 2018 16:46:14 +0100
Subject: [LTP] [PATCH 1/4] syscalls/migrate_pages02: convert to newlib
Message-ID: <4ab262666b5022a1f62a2e2967899dfecc56396d.1541431525.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Convert test to use safe macros and checkpoints. This is
preparation so we can use newly added save_restore feature.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../syscalls/migrate_pages/migrate_pages02.c       | 213 ++++++++-------------
 1 file changed, 75 insertions(+), 138 deletions(-)

diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
index ac5aa303212b..aa9ade71f527 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
@@ -41,8 +41,7 @@
 #include <unistd.h>
 #include <pwd.h>
 
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 #include "lapi/syscalls.h"
 #include "numa_helper.h"
 #include "migrate_pages_common.h"
@@ -57,9 +56,6 @@
  */
 #define NODE_MIN_FREEMEM (32*1024*1024)
 
-char *TCID = "migrate_pages02";
-int TST_TOTAL = 1;
-
 #ifdef HAVE_NUMA_V2
 
 static const char nobody_uid[] = "nobody";
@@ -67,13 +63,6 @@ static struct passwd *ltpuser;
 static int *nodes, nodeA, nodeB;
 static int num_nodes;
 
-static void setup(void);
-static void cleanup(void);
-
-option_t options[] = {
-	{NULL, NULL, NULL}
-};
-
 static void print_mem_stats(pid_t pid, int node)
 {
 	char s[64];
@@ -82,7 +71,7 @@ static void print_mem_stats(pid_t pid, int node)
 	if (pid == 0)
 		pid = getpid();
 
-	tst_resm(TINFO, "mem_stats pid: %d, node: %d", pid, node);
+	tst_res(TINFO, "mem_stats pid: %d, node: %d", pid, node);
 
 	/* dump pid's VM info */
 	sprintf(s, "cat /proc/%d/status", pid);
@@ -92,7 +81,7 @@ static void print_mem_stats(pid_t pid, int node)
 
 	/* dump node free mem */
 	node_size = numa_node_size64(node, &freep);
-	tst_resm(TINFO, "Node id: %d, size: %lld, free: %lld",
+	tst_res(TINFO, "Node id: %d, size: %lld, free: %lld",
 		 node, node_size, freep);
 }
 
@@ -102,12 +91,12 @@ static int migrate_to_node(pid_t pid, int node)
 	unsigned long *old_nodes, *new_nodes;
 	int i;
 
-	tst_resm(TINFO, "pid(%d) migrate pid %d to node -> %d",
+	tst_res(TINFO, "pid(%d) migrate pid %d to node -> %d",
 		 getpid(), pid, node);
 	max_node = LTP_ALIGN(get_max_node(), sizeof(unsigned long)*8);
 	nodemask_size = max_node / 8;
-	old_nodes = SAFE_MALLOC(NULL, nodemask_size);
-	new_nodes = SAFE_MALLOC(NULL, nodemask_size);
+	old_nodes = SAFE_MALLOC(nodemask_size);
+	new_nodes = SAFE_MALLOC(nodemask_size);
 
 	memset(old_nodes, 0, nodemask_size);
 	memset(new_nodes, 0, nodemask_size);
@@ -115,20 +104,20 @@ static int migrate_to_node(pid_t pid, int node)
 		set_bit(old_nodes, nodes[i], 1);
 	set_bit(new_nodes, node, 1);
 
-	TEST(ltp_syscall(__NR_migrate_pages, pid, max_node, old_nodes,
+	TEST(tst_syscall(__NR_migrate_pages, pid, max_node, old_nodes,
 		new_nodes));
-	if (TEST_RETURN != 0) {
-		if (TEST_RETURN < 0)
-			tst_resm(TFAIL | TERRNO, "migrate_pages failed "
-				 "ret: %ld, ", TEST_RETURN);
+	if (TST_RET != 0) {
+		if (TST_RET < 0)
+			tst_res(TFAIL | TERRNO, "migrate_pages failed "
+				 "ret: %ld, ", TST_RET);
 		else
-			tst_resm(TINFO, "migrate_pages could not migrate all "
-				 "pages, not migrated: %ld", TEST_RETURN);
+			tst_res(TINFO, "migrate_pages could not migrate all "
+				 "pages, not migrated: %ld", TST_RET);
 		print_mem_stats(pid, node);
 	}
 	free(old_nodes);
 	free(new_nodes);
-	return TEST_RETURN;
+	return TST_RET;
 }
 
 static int addr_on_node(void *addr)
@@ -136,10 +125,10 @@ static int addr_on_node(void *addr)
 	int node;
 	int ret;
 
-	ret = ltp_syscall(__NR_get_mempolicy, &node, NULL, (unsigned long)0,
+	ret = tst_syscall(__NR_get_mempolicy, &node, NULL, (unsigned long)0,
 		      (unsigned long)addr, MPOL_F_NODE | MPOL_F_ADDR);
 	if (ret == -1) {
-		tst_resm(TBROK | TERRNO, "error getting memory policy "
+		tst_res(TBROK | TERRNO, "error getting memory policy "
 			 "for page %p", addr);
 	}
 	return node;
@@ -151,11 +140,11 @@ static int check_addr_on_node(void *addr, int exp_node)
 
 	node = addr_on_node(addr);
 	if (node == exp_node) {
-		tst_resm(TPASS, "pid(%d) addr %p is on expected node: %d",
+		tst_res(TPASS, "pid(%d) addr %p is on expected node: %d",
 			 getpid(), addr, exp_node);
 		return TPASS;
 	} else {
-		tst_resm(TFAIL, "pid(%d) addr %p not on expected node: %d "
+		tst_res(TFAIL, "pid(%d) addr %p not on expected node: %d "
 			 ", expected %d", getpid(), addr, node, exp_node);
 		print_mem_stats(0, exp_node);
 		return TFAIL;
@@ -169,10 +158,10 @@ static void test_migrate_current_process(int node1, int node2, int cap_sys_nice)
 	pid_t child;
 
 	/* parent can migrate its non-shared memory */
-	tst_resm(TINFO, "current_process, cap_sys_nice: %d", cap_sys_nice);
-	testp = SAFE_MALLOC(NULL, getpagesize());
+	tst_res(TINFO, "current_process, cap_sys_nice: %d", cap_sys_nice);
+	testp = SAFE_MALLOC(getpagesize());
 	testp[0] = 0;
-	tst_resm(TINFO, "private anonymous: %p", testp);
+	tst_res(TINFO, "private anonymous: %p", testp);
 	migrate_to_node(0, node2);
 	check_addr_on_node(testp, node2);
 	migrate_to_node(0, node1);
@@ -180,153 +169,105 @@ static void test_migrate_current_process(int node1, int node2, int cap_sys_nice)
 	free(testp);
 
 	/* parent can migrate shared memory with CAP_SYS_NICE */
-	testp2 = mmap(NULL, getpagesize(), PROT_READ | PROT_WRITE,
+	testp2 = SAFE_MMAP(NULL, getpagesize(), PROT_READ | PROT_WRITE,
 		      MAP_ANONYMOUS | MAP_SHARED, 0, 0);
-	if (testp2 == MAP_FAILED)
-		tst_brkm(TBROK | TERRNO, cleanup, "mmap failed");
 	testp2[0] = 1;
-	tst_resm(TINFO, "shared anonymous: %p", testp2);
+	tst_res(TINFO, "shared anonymous: %p", testp2);
 	migrate_to_node(0, node2);
 	check_addr_on_node(testp2, node2);
 
 	/* shared mem is on node2, try to migrate in child to node1 */
 	fflush(stdout);
-	child = fork();
-	switch (child) {
-	case -1:
-		tst_brkm(TBROK | TERRNO, cleanup, "fork");
-		break;
-	case 0:
-		tst_resm(TINFO, "child shared anonymous, cap_sys_nice: %d",
+	child = SAFE_FORK();
+	if (child == 0) {
+		tst_res(TINFO, "child shared anonymous, cap_sys_nice: %d",
 			 cap_sys_nice);
-		testp = SAFE_MALLOC(NULL, getpagesize());
+		testp = SAFE_MALLOC(getpagesize());
 		testp[0] = 1;
 		testp2[0] = 1;
 		if (!cap_sys_nice)
-			SAFE_SETEUID(NULL, ltpuser->pw_uid);
+			SAFE_SETEUID(ltpuser->pw_uid);
 
 		migrate_to_node(0, node1);
 		/* child can migrate non-shared memory */
 		ret = check_addr_on_node(testp, node1);
 
 		free(testp);
-		munmap(testp2, getpagesize());
+		SAFE_MUNMAP(testp2, getpagesize());
 		exit(ret);
-	default:
-		SAFE_WAITPID(cleanup, child, &status, 0);
-		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
-			tst_resm(TFAIL, "child returns %d", status);
-		if (cap_sys_nice)
-			/* child can migrate shared memory only
-			 * with CAP_SYS_NICE */
-			check_addr_on_node(testp2, node1);
-		else
-			check_addr_on_node(testp2, node2);
-		munmap(testp2, getpagesize());
 	}
+
+	SAFE_WAITPID(child, &status, 0);
+	if (cap_sys_nice)
+		/* child can migrate shared memory only
+		 * with CAP_SYS_NICE */
+		check_addr_on_node(testp2, node1);
+	else
+		check_addr_on_node(testp2, node2);
+	SAFE_MUNMAP(testp2, getpagesize());
 }
 
 static void test_migrate_other_process(int node1, int node2, int cap_sys_nice)
 {
 	char *testp;
-	int ret, tmp;
+	int ret, status;
 	pid_t child1, child2;
-	int child1_ready[2];
-	int pages_migrated[2];
-
-	/* setup pipes to synchronize child1/child2 */
-	if (pipe(child1_ready) == -1)
-		tst_resm(TBROK | TERRNO, "pipe #1 failed");
-	if (pipe(pages_migrated) == -1)
-		tst_resm(TBROK | TERRNO, "pipe #2 failed");
 
-	tst_resm(TINFO, "other_process, cap_sys_nice: %d", cap_sys_nice);
+	tst_res(TINFO, "other_process, cap_sys_nice: %d", cap_sys_nice);
 
 	fflush(stdout);
-	child1 = fork();
-	switch (child1) {
-	case -1:
-		tst_brkm(TBROK | TERRNO, cleanup, "fork");
-		break;
-	case 0:
-		close(child1_ready[0]);
-		close(pages_migrated[1]);
-
-		testp = SAFE_MALLOC(NULL, getpagesize());
+	child1 = SAFE_FORK();
+	if (child1 == 0) {
+		testp = SAFE_MALLOC(getpagesize());
 		testp[0] = 0;
 
 		/* make sure we are on node1 */
 		migrate_to_node(0, node1);
 		check_addr_on_node(testp, node1);
 
-		SAFE_SETUID(NULL, ltpuser->pw_uid);
+		SAFE_SETUID(ltpuser->pw_uid);
 
 		/* commit_creds() will clear dumpable, restore it */
 		if (prctl(PR_SET_DUMPABLE, 1))
-			tst_brkm(TBROK | TERRNO, NULL, "prctl");
+			tst_brk(TBROK | TERRNO, "prctl");
 
 		/* signal child2 it's OK to migrate child1 and wait */
-		if (write(child1_ready[1], &tmp, 1) != 1)
-			tst_brkm(TBROK | TERRNO, NULL, "write #1 failed");
-		if (read(pages_migrated[0], &tmp, 1) != 1)
-			tst_brkm(TBROK | TERRNO, NULL, "read #1 failed");
+		TST_CHECKPOINT_WAKE(1);
+		TST_CHECKPOINT_WAIT(2);
 
 		/* child2 can migrate child1 process if it's privileged */
 		/* child2 can migrate child1 process if it has same uid */
 		ret = check_addr_on_node(testp, node2);
 
 		free(testp);
-		close(child1_ready[1]);
-		close(pages_migrated[0]);
 		exit(ret);
 	}
 
-	close(child1_ready[1]);
-	close(pages_migrated[0]);
-
 	fflush(stdout);
-	child2 = fork();
-	switch (child2) {
-	case -1:
-		tst_brkm(TBROK | TERRNO, cleanup, "fork");
-		break;
-	case 0:
+	child2 = SAFE_FORK();
+	if (child2 == 0) {
 		if (!cap_sys_nice)
-			SAFE_SETUID(NULL, ltpuser->pw_uid);
+			SAFE_SETUID(ltpuser->pw_uid);
 
 		/* wait until child1 is ready on node1, then migrate and
 		 * signal to check current node */
-		if (read(child1_ready[0], &tmp, 1) != 1)
-			tst_brkm(TBROK | TERRNO, NULL, "read #2 failed");
+		TST_CHECKPOINT_WAIT(1);
 		migrate_to_node(child1, node2);
-		if (write(pages_migrated[1], &tmp, 1) != 1)
-			tst_brkm(TBROK | TERRNO, NULL, "write #2 failed");
+		TST_CHECKPOINT_WAKE(2);
 
-		close(child1_ready[0]);
-		close(pages_migrated[1]);
 		exit(TPASS);
 	}
 
-	tst_record_childstatus(NULL, child2);
-	tst_record_childstatus(NULL, child1);
+	SAFE_WAITPID(child1, &status, 0);
+	SAFE_WAITPID(child2, &status, 0);
 }
 
-int main(int argc, char *argv[])
+static void run(void)
 {
-	int lc;
-
-	tst_parse_opts(argc, argv, options, NULL);
-
-	setup();
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		test_migrate_current_process(nodeA, nodeB, 1);
-		test_migrate_current_process(nodeA, nodeB, 0);
-		test_migrate_other_process(nodeA, nodeB, 1);
-		test_migrate_other_process(nodeA, nodeB, 0);
-	}
-	cleanup();
-	tst_exit();
+	test_migrate_current_process(nodeA, nodeB, 1);
+	test_migrate_current_process(nodeA, nodeB, 0);
+	test_migrate_other_process(nodeA, nodeB, 1);
+	test_migrate_other_process(nodeA, nodeB, 0);
 }
 
 static void setup(void)
@@ -335,21 +276,20 @@ static void setup(void)
 	int pagesize = getpagesize();
 	void *p;
 
-	tst_require_root();
-	TEST(ltp_syscall(__NR_migrate_pages, 0, 0, NULL, NULL));
+	tst_syscall(__NR_migrate_pages, 0, 0, NULL, NULL);
 
 	if (numa_available() == -1)
-		tst_brkm(TCONF, NULL, "NUMA not available");
+		tst_brk(TCONF, "NUMA not available");
 
 	ret = get_allowed_nodes_arr(NH_MEMS, &num_nodes, &nodes);
 	if (ret < 0)
-		tst_brkm(TBROK | TERRNO, NULL, "get_allowed_nodes(): %d", ret);
+		tst_brk(TBROK | TERRNO, "get_allowed_nodes(): %d", ret);
 
 	if (num_nodes < 2)
-		tst_brkm(TCONF, NULL, "at least 2 allowed NUMA nodes"
+		tst_brk(TCONF, "at least 2 allowed NUMA nodes"
 			 " are required");
 	else if (tst_kvercmp(2, 6, 18) < 0)
-		tst_brkm(TCONF, NULL, "2.6.18 or greater kernel required");
+		tst_brk(TCONF, "2.6.18 or greater kernel required");
 
 	/*
 	 * find 2 nodes, which can hold NODE_MIN_FREEMEM bytes
@@ -386,25 +326,22 @@ static void setup(void)
 	}
 
 	if (nodeA == -1 || nodeB == -1)
-		tst_brkm(TCONF, NULL, "at least 2 NUMA nodes with "
+		tst_brk(TCONF, "at least 2 NUMA nodes with "
 			 "free mem > %d are needed", NODE_MIN_FREEMEM);
-	tst_resm(TINFO, "Using nodes: %d %d", nodeA, nodeB);
+	tst_res(TINFO, "Using nodes: %d %d", nodeA, nodeB);
 
 	ltpuser = getpwnam(nobody_uid);
 	if (ltpuser == NULL)
-		tst_brkm(TBROK | TERRNO, NULL, "getpwnam failed");
-
-	TEST_PAUSE;
-}
-
-static void cleanup(void)
-{
-	free(nodes);
+		tst_brk(TBROK | TERRNO, "getpwnam failed");
 }
 
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_checkpoints = 1,
+	.forks_child = 1,
+	.test_all = run,
+	.setup = setup,
+};
 #else
-int main(void)
-{
-	tst_brkm(TCONF, NULL, NUMA_ERROR_MSG);
-}
+TST_TEST_TCONF(NUMA_ERROR_MSG);
 #endif
-- 
1.8.3.1

