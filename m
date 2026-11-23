Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CFA6071539
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 08:07:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7EFAE3E2398
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 09:07:00 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 61EC23C70D9
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 09:06:03 +0100 (CET)
Received: from out28-101.mail.aliyun.com (out28-101.mail.aliyun.com
 [115.124.28.101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D801D1A006F3
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 09:06:00 +0100 (CET)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.0743636|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0866683-0.018406-0.894926;
 FP=2573574762329261304|1|1|1|0|-1|-1|-1; HT=maildocker-contentspam033037033194;
 MF=yehuaisheng@open-hieco.net; NM=1; PH=DS; RN=5; RT=5; SR=0;
 TI=SMTPD_---.k862buO_1795421155; 
Received: from centos9p-03(mailfrom:yehuaisheng@open-hieco.net
 fp:SMTPD_---.k862buO_1795421155 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 23 Nov 2026 16:05:56 +0800
From: Huaisheng Ye <yehuaisheng@open-hieco.net>
To: li.wang@linux.dev,
	chrubis@suse.cz,
	pvorel@suse.cz
Date: Mon, 23 Nov 2026 16:05:37 +0800
Message-ID: <20261123080537.20122-4-yehuaisheng@open-hieco.net>
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
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/3] hugemmap10: Add NUMA counter test diagnostics
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

Add TDEBUG output for NUMA node selection, saved memory policy,
pool changes and restoration so NUMA setup and cleanup failures can
be diagnosed.

Signed-off-by: Huaisheng Ye <yehuaisheng@open-hieco.net>
---
 .../kernel/mem/hugetlb/hugemmap/hugemmap10.c  | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
index 4c36df789..ca6eecec0 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
@@ -369,6 +369,8 @@ static int map_(int s, int hpages, int flags, char *desc, int line)
 	map_size[s] = hpages * hpage_size;
 	if (creates_reservation)
 		allowed_free = read_allowed_free_hugepages();
+	tst_res_(__FILE__, line, TDEBUG, "While %s: mmap(len=%lu, flags=%#x, fd=%d)",
+		 desc, map_size[s], mmap_flags, map_fd[s]);
 	TESTPTR(mmap(NULL, map_size[s], PROT_READ | PROT_WRITE, mmap_flags, map_fd[s], 0));
 	if (TST_RET_PTR == MAP_FAILED) {
 		tst_res_(__FILE__, line, TFAIL | TTERRNO, "While %s: mmap() failed", desc);
@@ -665,6 +667,8 @@ static void restore_numa_state(void)
 			    numa_maxnode)) {
 			tst_res(TWARN | TERRNO, "Failed to restore memory policy");
 			failed = 1;
+		} else {
+			tst_res(TDEBUG, "Restored memory policy mode %d", saved_policy);
 		}
 		numa_policy_set = 0;
 	}
@@ -675,6 +679,9 @@ static void restore_numa_state(void)
 				tst_res(TWARN, "Failed to restore node %lu hugepage pool",
 					numa_nodes[index]);
 				failed = 1;
+			} else {
+				tst_res(TDEBUG, "Restored node %lu nr_hugepages to %lu",
+					numa_nodes[index], numa_pool_sizes[index]);
 			}
 		}
 		numa_pools_saved = 0;
@@ -705,6 +712,8 @@ static int prepare_numa_test(void)
 	}
 	if (separator == '-')
 		numa_nodes[NUMA_TARGET] = numa_nodes[NUMA_SOURCE] + 1;
+	tst_res(TDEBUG, "Selected NUMA source node %lu and target node %lu",
+		numa_nodes[NUMA_SOURCE], numa_nodes[NUMA_TARGET]);
 	if (numa_nodes[NUMA_TARGET] >= numa_maxnode) {
 		tst_res(TCONF, "NUMA node ID exceeds the nodemask capacity");
 		return 0;
@@ -739,6 +748,7 @@ static int prepare_numa_test(void)
 		tst_res(TCONF | TERRNO, "NUMA memory policies are unavailable");
 		return 0;
 	}
+	tst_res(TDEBUG, "Saved memory policy mode %d", saved_policy);
 
 	node_set(numa_nodes[NUMA_TARGET], numa_nodemask);
 	if (syscall(__NR_set_mempolicy, MPOL_BIND, numa_nodemask, numa_maxnode)) {
@@ -748,10 +758,15 @@ static int prepare_numa_test(void)
 		return 0;
 	}
 	numa_policy_set = 1;
+	tst_res(TDEBUG, "Bound memory policy to NUMA target node %lu",
+		numa_nodes[NUMA_TARGET]);
 
 	for (index = 0; index < NUMA_NODES; index++)
 		numa_pool_sizes[index] = read_numa_hugepages(index, "nr_hugepages");
 	numa_pools_saved = 1;
+	tst_res(TDEBUG, "Saved node %lu nr_hugepages=%lu, node %lu nr_hugepages=%lu",
+		numa_nodes[NUMA_SOURCE], numa_pool_sizes[NUMA_SOURCE],
+		numa_nodes[NUMA_TARGET], numa_pool_sizes[NUMA_TARGET]);
 
 	if (!numa_pool_sizes[NUMA_SOURCE] && !set_numa_hugepages(NUMA_SOURCE, 1)) {
 		tst_res(TCONF, "Cannot allocate a hugepage on source node %lu",
@@ -782,6 +797,8 @@ static int prepare_numa_test(void)
 
 static void run_test(unsigned int index)
 {
+	tst_res(TDEBUG, "Running hugemmap10 test case %u", index);
+
 	if (!index || prepare_numa_test())
 		run_counter_test();
 
@@ -793,6 +810,8 @@ static void setup(void)
 {
 	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
 	SAFE_FILE_PRINTF(PATH_VM_OVERCOMMIT_HPAGES, "%lu", tst_hugepages);
+	tst_res(TDEBUG, "Hugepage size=%ld kB, nr_overcommit_hugepages=%lu",
+		hpage_size / 1024, tst_hugepages);
 	private_resv = kernel_has_private_reservations();
 	tst_res(TDEBUG, "MAP_PRIVATE mmap() %s a hugetlb reservation",
 		private_resv ? "creates" : "does not create");
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
