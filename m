Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A97E607150A
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 08:06:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A7863E9177
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 09:06:18 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 55A133C70D9
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 09:06:01 +0100 (CET)
Received: from out28-49.mail.aliyun.com (out28-49.mail.aliyun.com
 [115.124.28.49])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DFDF91000784
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 09:05:59 +0100 (CET)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436259|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_system_inform|0.158074-0.0323504-0.809575;
 FP=7355007783966295285|1|1|1|0|-1|-1|-1; HT=maildocker-contentspam033045099153;
 MF=yehuaisheng@open-hieco.net; NM=1; PH=DS; RN=5; RT=5; SR=0;
 TI=SMTPD_---.k862btk_1795421155; 
Received: from centos9p-03(mailfrom:yehuaisheng@open-hieco.net
 fp:SMTPD_---.k862btk_1795421155 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 23 Nov 2026 16:05:55 +0800
From: Huaisheng Ye <yehuaisheng@open-hieco.net>
To: li.wang@linux.dev,
	chrubis@suse.cz,
	pvorel@suse.cz
Date: Mon, 23 Nov 2026 16:05:36 +0800
Message-ID: <20261123080537.20122-3-yehuaisheng@open-hieco.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261123080537.20122-1-yehuaisheng@open-hieco.net>
References: <20261123080537.20122-1-yehuaisheng@open-hieco.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/3] hugemmap10: Reuse counter tests with a NUMA
 bind policy
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The allowed-node surplus regression is only exercised by the counter
tests when free hugepages are outside the task's memory policy. Running
hugemmap10 without an external NUMA setup does not ensure this coverage.

Add a second test case which selects the first two system memory nodes,
keeps free hugepages on the first and applies MPOL_BIND to the second.
Run the existing counter suite for both test cases, including all five
mapping scenarios and base pool sizes from zero through three.

Resize the bound node's pool through nr_hugepages_mempolicy, adding the
unchanged remote pool to the requested global persistent count. Account
for remote free pages when predicting pool shrinkage and the release of
unused surplus pages. The zero-size pool exercises surplus reservations
on an empty allowed node despite free hugepages elsewhere.

Check that the target can allocate three hugepages before testing. Skip
only the NUMA case when its prerequisites cannot be established. Report
mmap failures as TFAIL and one TPASS per completed counter suite.

Restore the inherited memory policy and affected node pools after each
iteration, with final cleanup covering partial setup and early failures.

Signed-off-by: Huaisheng Ye <yehuaisheng@open-hieco.net>
---
 .../kernel/mem/hugetlb/hugemmap/hugemmap10.c  | 224 ++++++++++++++++--
 1 file changed, 208 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
index 763f68e69..4c36df789 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
@@ -18,10 +18,13 @@
  * Otherwise mmap() may fail with ENOMEM even when nr_overcommit_hugepages
  * permits allocating surplus pages on the allowed nodes.
  *
- * The issue can be exercised on a system with two or more NUMA nodes, for
- * example with::
- *
- *     numactl --cpunodebind=0 --membind=1 ./hugemmap10
+ * A separate subtest runs the same counter checks with MPOL_BIND on the
+ * second NUMA memory node. It varies that node's persistent pool from zero
+ * to three pages while keeping free pages on the first node. With an empty
+ * local pool, a mapping must allocate a surplus page on the bound node
+ * despite the free pages elsewhere.
+ * The subtest is skipped if the required NUMA or allocation conditions
+ * cannot be established; the original counter tests still run.
  */
 
 #define _GNU_SOURCE
@@ -42,6 +45,9 @@
 
 #define MNTPOINT "hugetlbfs/"
 #define ULONG_BITS (sizeof(unsigned long) * CHAR_BIT)
+#define NODE_HUGEPAGES "/sys/devices/system/node/node%lu/hugepages/hugepages-%ldkB/%s"
+#define NR_HUGEPAGES_MEMPOLICY "/proc/sys/vm/nr_hugepages_mempolicy"
+#define MAX_BASE_POOL_SIZE 3
 
 static long hpage_size;
 static int private_resv;
@@ -60,6 +66,19 @@ static long prev_free;
 static long prev_resv;
 static long prev_surp;
 
+enum {
+	NUMA_SOURCE,
+	NUMA_TARGET,
+	NUMA_NODES,
+};
+
+static unsigned long numa_nodes[NUMA_NODES];
+static unsigned long numa_pool_sizes[NUMA_NODES];
+static unsigned long *numa_nodemask, *saved_nodemask;
+static unsigned long numa_maxnode;
+static long numa_remote_free;
+static int saved_policy, numa_policy_set, numa_pools_saved;
+
 static void read_meminfo_huge(long *total, long *free, long *resv, long *surp)
 {
 	*total = SAFE_READ_MEMINFO(MEMINFO_HPAGE_TOTAL);
@@ -295,7 +314,9 @@ static int set_nr_hugepages_(long count, char *desc, int line)
 	long min_size;
 	long et, ef, er, es;
 
-	SAFE_FILE_PRINTF(PATH_VM_NR_HPAGES, "%lu", count);
+	count += numa_remote_free;
+	SAFE_FILE_PRINTF(numa_remote_free ? NR_HUGEPAGES_MEMPOLICY : PATH_VM_NR_HPAGES,
+			 "%ld", count);
 
 	/* The code below is based on set_max_huge_pages in mm/hugetlb.c */
 	es = prev_surp;
@@ -325,7 +346,7 @@ static int set_nr_hugepages_(long count, char *desc, int line)
 	 * to the desired size as pages become free.
 	 */
 	min_size = MAX(count, er + et - ef);
-	while (min_size < et - es) {
+	while (min_size < et - es && ef > numa_remote_free) {
 		ef--;
 		et--;
 	}
@@ -342,14 +363,18 @@ static int map_(int s, int hpages, int flags, char *desc, int line)
 	unsigned long allowed_free = 0;
 	long et, ef, er, es;
 	int creates_reservation = mapping_creates_reservation(flags);
+	int mmap_flags = private_mmap_flags(flags);
 
 	map_fd[s] = tst_creat_unlinked(MNTPOINT, 0, 0600);
 	map_size[s] = hpages * hpage_size;
 	if (creates_reservation)
 		allowed_free = read_allowed_free_hugepages();
-	map_addr[s] = SAFE_MMAP(NULL, map_size[s], PROT_READ|PROT_WRITE,
-			private_mmap_flags(flags),
-			map_fd[s], 0);
+	TESTPTR(mmap(NULL, map_size[s], PROT_READ | PROT_WRITE, mmap_flags, map_fd[s], 0));
+	if (TST_RET_PTR == MAP_FAILED) {
+		tst_res_(__FILE__, line, TFAIL | TTERRNO, "While %s: mmap() failed", desc);
+		return -1;
+	}
+	map_addr[s] = TST_RET_PTR;
 	touched[s] = 0;
 
 	et = prev_total;
@@ -417,6 +442,9 @@ static int unmap_(int s, int hpages, int flags, char *desc, int line)
 	if (mapping_creates_reservation(flags)) {
 		int unused_surplus = MIN(hpages - touched[s], es);
 
+		if (numa_remote_free)
+			unused_surplus = MIN(unused_surplus, ef - numa_remote_free);
+
 		et -= unused_surplus;
 		ef -= unused_surplus;
 		er -= hpages - touched[s];
@@ -515,7 +543,7 @@ static int test_counters(char *desc, int base_nr)
 		return -1;
 
 	/* Add pages once surplus is consumed */
-	if (SET_NR_HUGEPAGES(MAX(base_nr, 3), "adding more pages after consuming surplus"))
+	if (SET_NR_HUGEPAGES(MAX(base_nr, MAX_BASE_POOL_SIZE), "adding more pages after consuming surplus"))
 		return -1;
 
 	/* Release free huge pages first */
@@ -543,8 +571,11 @@ static void per_iteration_cleanup(void)
 	prev_resv = 0;
 	prev_surp = 0;
 	for (nr = 0; nr < NR_SLOTS; nr++) {
-		if (map_addr[nr])
+		if (map_addr[nr]) {
 			SAFE_MUNMAP(map_addr[nr], map_size[nr]);
+			map_addr[nr] = NULL;
+			map_size[nr] = 0;
+		}
 		if (map_fd[nr] != -1)
 			SAFE_CLOSE(map_fd[nr]);
 	}
@@ -586,17 +617,176 @@ static int test_per_base_nr(int base_nr)
 	return 0;
 }
 
-static void run_test(void)
+static void run_counter_test(void)
 {
 	int base_nr;
 
-	for (base_nr = 0; base_nr <= 3; base_nr++) {
+	for (base_nr = 0; base_nr <= MAX_BASE_POOL_SIZE; base_nr++) {
 		if (test_per_base_nr(base_nr))
 			break;
 	}
-	if (base_nr > 3)
-		tst_res(TPASS, "Hugepages Counters works as expected.");
+	if (base_nr > MAX_BASE_POOL_SIZE)
+		tst_res(TPASS, "%s hugepage counters work as expected",
+			numa_remote_free ? "NUMA-bound" : "Default");
+}
+
+static unsigned long read_numa_hugepages(unsigned int index, const char *name)
+{
+	char path[PATH_MAX];
+	unsigned long pages;
+
+	snprintf(path, sizeof(path), NODE_HUGEPAGES, numa_nodes[index],
+		 hpage_size / 1024, name);
+	SAFE_FILE_SCANF(path, "%lu", &pages);
+	return pages;
+}
+
+static int set_numa_hugepages(unsigned int index, unsigned long pages)
+{
+	char path[PATH_MAX];
+
+	snprintf(path, sizeof(path), NODE_HUGEPAGES, numa_nodes[index],
+		 hpage_size / 1024, "nr_hugepages");
+	SAFE_FILE_PRINTF(path, "%lu", pages);
+	return read_numa_hugepages(index, "nr_hugepages") == pages;
+}
+
+static void restore_numa_state(void)
+{
+	unsigned int index;
+	int failed = 0;
+
+	if (!numa_policy_set && !numa_pools_saved &&
+	    !numa_nodemask && !saved_nodemask)
+		return;
+
+	if (numa_policy_set) {
+		if (syscall(__NR_set_mempolicy, saved_policy, saved_nodemask,
+			    numa_maxnode)) {
+			tst_res(TWARN | TERRNO, "Failed to restore memory policy");
+			failed = 1;
+		}
+		numa_policy_set = 0;
+	}
+
+	if (numa_pools_saved) {
+		for (index = 0; index < NUMA_NODES; index++) {
+			if (!set_numa_hugepages(index, numa_pool_sizes[index])) {
+				tst_res(TWARN, "Failed to restore node %lu hugepage pool",
+					numa_nodes[index]);
+				failed = 1;
+			}
+		}
+		numa_pools_saved = 0;
+	}
+
+	free(numa_nodemask);
+	numa_nodemask = NULL;
+	free(saved_nodemask);
+	saved_nodemask = NULL;
+	numa_remote_free = 0;
+
+	if (failed)
+		tst_brk(TBROK, "Failed to restore NUMA test state");
+}
+
+static int prepare_numa_test(void)
+{
+	char path[PATH_MAX];
+	char separator;
+	size_t mask_size = getpagesize();
+	unsigned int index;
+
+	numa_maxnode = mask_size * CHAR_BIT;
+	if (FILE_SCANF("/sys/devices/system/node/has_memory", "%lu%c%lu",
+		       &numa_nodes[NUMA_SOURCE], &separator, &numa_nodes[NUMA_TARGET])) {
+		tst_res(TCONF, "NUMA subtest needs at least two memory nodes");
+		return 0;
+	}
+	if (separator == '-')
+		numa_nodes[NUMA_TARGET] = numa_nodes[NUMA_SOURCE] + 1;
+	if (numa_nodes[NUMA_TARGET] >= numa_maxnode) {
+		tst_res(TCONF, "NUMA node ID exceeds the nodemask capacity");
+		return 0;
+	}
+	if (access(NR_HUGEPAGES_MEMPOLICY, W_OK)) {
+		tst_res(TCONF | TERRNO, "Cannot resize hugepage pool using the NUMA policy");
+		return 0;
+	}
+
+	for (index = 0; index < NUMA_NODES; index++) {
+		snprintf(path, sizeof(path), NODE_HUGEPAGES, numa_nodes[index],
+			 hpage_size / 1024, "nr_hugepages");
+		if (access(path, W_OK)) {
+			tst_res(TCONF, "Node %lu hugepage pool is not writable",
+				numa_nodes[index]);
+			return 0;
+		}
+	}
+
+	read_meminfo_huge(&prev_total, &prev_free, &prev_resv, &prev_surp);
+	if (prev_total != prev_free || prev_resv || prev_surp) {
+		tst_res(TCONF, "Cannot prepare NUMA subtest while hugepages are in use");
+		return 0;
+	}
+
+	numa_nodemask = SAFE_CALLOC(1, mask_size);
+	saved_nodemask = SAFE_CALLOC(1, mask_size);
+	if (syscall(__NR_get_mempolicy, &saved_policy, saved_nodemask,
+		    numa_maxnode, NULL, 0)) {
+		if (errno != ENOSYS && errno != EPERM && errno != EACCES)
+			tst_brk(TBROK | TERRNO, "get_mempolicy() failed");
+		tst_res(TCONF | TERRNO, "NUMA memory policies are unavailable");
+		return 0;
+	}
+
+	node_set(numa_nodes[NUMA_TARGET], numa_nodemask);
+	if (syscall(__NR_set_mempolicy, MPOL_BIND, numa_nodemask, numa_maxnode)) {
+		if (errno != ENOSYS && errno != EPERM && errno != EACCES && errno != EINVAL)
+			tst_brk(TBROK | TERRNO, "set_mempolicy(MPOL_BIND) failed");
+		tst_res(TCONF | TERRNO, "Cannot bind memory to the target NUMA node");
+		return 0;
+	}
+	numa_policy_set = 1;
+
+	for (index = 0; index < NUMA_NODES; index++)
+		numa_pool_sizes[index] = read_numa_hugepages(index, "nr_hugepages");
+	numa_pools_saved = 1;
+
+	if (!numa_pool_sizes[NUMA_SOURCE] && !set_numa_hugepages(NUMA_SOURCE, 1)) {
+		tst_res(TCONF, "Cannot allocate a hugepage on source node %lu",
+			numa_nodes[NUMA_SOURCE]);
+		return 0;
+	}
+
+	if (!set_numa_hugepages(NUMA_TARGET, MAX_BASE_POOL_SIZE) ||
+	    !set_numa_hugepages(NUMA_TARGET, 0)) {
+		tst_res(TCONF, "Cannot prepare the hugepage pool on target node %lu",
+			numa_nodes[NUMA_TARGET]);
+		return 0;
+	}
+
+	read_meminfo_huge(&prev_total, &prev_free, &prev_resv, &prev_surp);
+	if (prev_total != prev_free || !prev_free || prev_resv || prev_surp ||
+	    !read_numa_hugepages(NUMA_SOURCE, "free_hugepages") ||
+	    read_numa_hugepages(NUMA_TARGET, "free_hugepages")) {
+		tst_res(TCONF, "Cannot establish the NUMA surplus allocation preconditions");
+		return 0;
+	}
+	numa_remote_free = prev_free;
+	tst_res(TINFO, "NUMA target node %lu has an empty pool with %ld free hugepages on other nodes",
+		numa_nodes[NUMA_TARGET], numa_remote_free);
+
+	return 1;
+}
+
+static void run_test(unsigned int index)
+{
+	if (!index || prepare_numa_test())
+		run_counter_test();
+
 	per_iteration_cleanup();
+	restore_numa_state();
 }
 
 static void setup(void)
@@ -611,6 +801,7 @@ static void setup(void)
 static void cleanup(void)
 {
 	per_iteration_cleanup();
+	restore_numa_state();
 }
 
 static struct tst_test test = {
@@ -633,6 +824,7 @@ static struct tst_test test = {
 	},
 	.setup = setup,
 	.cleanup = cleanup,
-	.test_all = run_test,
+	.test = run_test,
+	.tcnt = 2,
 	.hugepages = {3, TST_NEEDS},
 };
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
