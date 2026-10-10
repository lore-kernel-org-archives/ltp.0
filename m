Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B6FCA9EBE
	for <ltp@archiver.kernel.org>; Sat, 10 Oct 2026 09:53:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 928353E2E35
	for <ltp@archiver.kernel.org>; Sat, 10 Oct 2026 11:53:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 80D603E2E47
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 11:52:29 +0200 (CEST)
Received: from out28-3.mail.aliyun.com (out28-3.mail.aliyun.com [115.124.28.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D2F6C1A000AF
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 11:52:24 +0200 (CEST)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07183095|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0191358-0.0226152-0.958249;
 FP=16650648761595151865|0|0|0|0|-1|-1|-1;
 HT=maildocker-contentspam033037028158; MF=yehuaisheng@open-hieco.net; NM=1;
 PH=DS; RN=5; RT=5; SR=0; TI=SMTPD_---.jYP2TqY_1791625939; 
Received: from centos9p-03(mailfrom:yehuaisheng@open-hieco.net
 fp:SMTPD_---.jYP2TqY_1791625939 cluster:ay29) by smtp.aliyun-inc.com;
 Sat, 10 Oct 2026 17:52:20 +0800
From: Huaisheng Ye <yehuaisheng@open-hieco.net>
To: li.wang@linux.dev,
	chrubis@suse.cz,
	pvorel@suse.cz
Date: Sat, 10 Oct 2026 17:51:53 +0800
Message-ID: <20261010095155.117953-2-yehuaisheng@open-hieco.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261010095155.117953-1-yehuaisheng@open-hieco.net>
References: <20261010095155.117953-1-yehuaisheng@open-hieco.net>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/3] hugemmap10: Account for memory policy in mmap
 counter checks
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Expected surplus accounting for mappings that reserve at mmap() time only
considers the global free and reserved hugepage counters. But sometimes,
for instance with MPOL_BIND, globally free hugepages can reside outside
nodes from which the task can allocate or plans to allocate. Hugetlb
then creates surplus pages on allowed nodes, while the test expects
no counter change.

For example, reproduce this on an eight-node system running 7.3.0-rc1:

    $ numactl --membind=0-3 ./hugemmap10
    tst_hugepage.c:84: TINFO: 3 hugepage(s) reserved
    ...
    hugemmap10.c:386: TINFO: Base pool size: 0
    hugemmap10.c:313: TINFO: Clean...
    hugemmap10.c:364: TINFO: OK
    hugemmap10.c:313: TINFO: Untouched, shared...
    hugemmap10.c:364: TINFO: OK
    hugemmap10.c:313: TINFO: Untouched, private...
    hugemmap10.c:364: TINFO: OK
    hugemmap10.c:313: TINFO: Touched, shared...
    hugemmap10.c:364: TINFO: OK
    hugemmap10.c:313: TINFO: Touched, private...
    hugemmap10.c:364: TINFO: OK
    hugemmap10.c:386: TINFO: Base pool size: 1
    hugemmap10.c:313: TINFO: Clean...
    hugemmap10.c:319: TFAIL: While doing mmap shared with no touch: Bad HugePages_Total: expected 1, actual 2
    hugemmap10.c:319: TFAIL: While doing mmap shared with no touch: Bad HugePages_Free: expected 1, actual 2
    hugemmap10.c:319: TFAIL: While doing mmap shared with no touch: Bad HugePages_Surp: expected 0, actual 1

    Summary:
    passed   0
    failed   3
    broken   0
    skipped  0
    warnings 0

    $ numactl --membind=4-7 ./hugemmap10
    ...
    hugemmap10.c:364: TINFO: OK
    hugemmap10.c:429: TPASS: Hugepages Counters works as expected.

    Summary:
    passed   1
    failed   0
    broken   0
    skipped  0
    warnings 0

If global free hugepages are on nodes 4-7 while the memory policy restricts
hugemmap10 to nodes 0-3, the counter discrepancy is observed.

Read the task policy and cpuset mask, then sum free hugepages on the
nodes available to the mapping. Calculate the expected surplus as the
maximum of the global and allowed-node shortfalls. Match hugetlb's fallback
to the cpuset when an MPOL_BIND mask no longer intersects it.

This fixes counter expectations for MAP_SHARED and MAP_PRIVATE mappings
that create reservations at mmap() time.

This complements the hugetlb reservation fix:
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?id=21f514ad520459fbfa58ccdf171bb68148c2f5aa

Signed-off-by: Huaisheng Ye <yehuaisheng@open-hieco.net>
Reviewed-by: Li Wang <li.wang@linux.dev>
---
 .../kernel/mem/hugetlb/hugemmap/hugemmap10.c  | 107 +++++++++++++++++-
 1 file changed, 103 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
index fc530dda4..1f8d00226 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
@@ -13,6 +13,9 @@
  */
 
 #define _GNU_SOURCE
+#include <errno.h>
+#include <linux/mempolicy.h>
+#include <stdlib.h>
 #include <unistd.h>
 #include <stdio.h>
 #include <sys/mount.h>
@@ -21,8 +24,10 @@
 #include <sys/types.h>
 
 #include "hugetlb.h"
+#include "lapi/syscalls.h"
 
 #define MNTPOINT "hugetlbfs/"
+#define ULONG_BITS (sizeof(unsigned long) * CHAR_BIT)
 
 static long hpage_size;
 static int private_resv;
@@ -48,6 +53,98 @@ static void read_meminfo_huge(long *total, long *free, long *resv, long *surp)
 	*surp = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SURP);
 }
 
+static int node_isset(unsigned long node, const unsigned long *nodemask)
+{
+	return !!(nodemask[node / ULONG_BITS] & (1UL << (node % ULONG_BITS)));
+}
+
+static int nodemasks_intersect(const unsigned long *left,
+			       const unsigned long *right, unsigned long maxnode)
+{
+	unsigned long node;
+
+	for (node = 0; node < maxnode; node++) {
+		if (node_isset(node, left) && node_isset(node, right))
+			return 1;
+	}
+
+	return 0;
+}
+
+static unsigned long surplus_pages_needed(int hpages, unsigned long allowed_free)
+{
+	unsigned long global_shortfall = 0;
+	unsigned long allowed_shortfall = 0;
+
+	if (hpages + prev_resv > prev_free)
+		global_shortfall = hpages - prev_free + prev_resv;
+
+	if ((unsigned long)hpages > allowed_free)
+		allowed_shortfall = hpages - allowed_free;
+
+	return MAX(global_shortfall, allowed_shortfall);
+}
+
+static int mapping_creates_reservation(int flags)
+{
+	return (flags & MAP_SHARED) || private_resv;
+}
+
+static unsigned long read_allowed_free_hugepages(void)
+{
+	char path[PATH_MAX];
+	size_t mask_size = getpagesize();
+	unsigned long allowed_free = 0;
+	unsigned long maxnode = mask_size * CHAR_BIT;
+	unsigned long *policy_nodemask;
+	unsigned long *cpuset_nodemask;
+	unsigned long node, node_free;
+	int mode, use_bind;
+
+	policy_nodemask = SAFE_CALLOC(1, mask_size);
+	cpuset_nodemask = SAFE_CALLOC(1, mask_size);
+
+	if (syscall(__NR_get_mempolicy, &mode, policy_nodemask,
+		    maxnode, NULL, 0)) {
+		if (errno == ENOSYS) {
+			allowed_free = prev_free;
+			goto out;
+		}
+		tst_brk(TBROK | TERRNO, "get_mempolicy() failed");
+	}
+
+	if (syscall(__NR_get_mempolicy, NULL, cpuset_nodemask,
+		    maxnode, NULL, MPOL_F_MEMS_ALLOWED))
+		tst_brk(TBROK | TERRNO,
+			"get_mempolicy(MPOL_F_MEMS_ALLOWED) failed");
+
+	mode &= ~MPOL_MODE_FLAGS;
+	/* Hugetlb ignores a bind policy that no longer overlaps the cpuset. */
+	use_bind = mode == MPOL_BIND &&
+		nodemasks_intersect(policy_nodemask, cpuset_nodemask, maxnode);
+	for (node = 0; node < maxnode; node++) {
+		if (!node_isset(node, cpuset_nodemask))
+			continue;
+		if (use_bind && !node_isset(node, policy_nodemask))
+			continue;
+
+		snprintf(path, sizeof(path),
+			 "/sys/devices/system/node/node%lu/hugepages/"
+			 "hugepages-%ldkB/free_hugepages",
+			 node, hpage_size / 1024);
+		if (access(path, R_OK))
+			continue;
+
+		SAFE_FILE_SCANF(path, "%lu", &node_free);
+		allowed_free += node_free;
+	}
+
+out:
+	free(policy_nodemask);
+	free(cpuset_nodemask);
+	return allowed_free;
+}
+
 static int kernel_has_private_reservations(void)
 {
 	int fd;
@@ -178,10 +275,14 @@ out:
 
 static int map_(int s, int hpages, int flags, char *desc, int line)
 {
+	unsigned long allowed_free = 0;
 	long et, ef, er, es;
+	int creates_reservation = mapping_creates_reservation(flags);
 
 	map_fd[s] = tst_creat_unlinked(MNTPOINT, 0, 0600);
 	map_size[s] = hpages * hpage_size;
+	if (creates_reservation)
+		allowed_free = read_allowed_free_hugepages();
 	map_addr[s] = SAFE_MMAP(NULL, map_size[s], PROT_READ|PROT_WRITE, flags,
 				map_fd[s], 0);
 	touched[s] = 0;
@@ -201,11 +302,9 @@ static int map_(int s, int hpages, int flags, char *desc, int line)
 	 * mappings behave like MAP_SHARED at mmap time.  Otherwise,
 	 * no counter updates will occur.
 	 */
-	if ((flags & MAP_SHARED) || private_resv) {
-		unsigned long shortfall = 0;
+	if (creates_reservation) {
+		unsigned long shortfall = surplus_pages_needed(hpages, allowed_free);
 
-		if (hpages + prev_resv > prev_free)
-			shortfall = hpages - prev_free + prev_resv;
 		et += shortfall;
 		ef += shortfall;
 		er += hpages;
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
