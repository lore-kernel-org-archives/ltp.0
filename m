Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30567C88E50
	for <ltp@archiver.kernel.org>; Mon, 14 Sep 2026 08:55:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A7753E9087
	for <ltp@archiver.kernel.org>; Mon, 14 Sep 2026 10:55:46 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F1F7E3CD382
 for <ltp@lists.linux.it>; Mon, 14 Sep 2026 05:25:28 +0200 (CEST)
Received: from out28-74.mail.aliyun.com (out28-74.mail.aliyun.com
 [115.124.28.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C290B600211
 for <ltp@lists.linux.it>; Mon, 14 Sep 2026 05:25:24 +0200 (CEST)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436259|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0139902-0.0120513-0.973958;
 FP=7427135987251500537|1|1|1|0|-1|-1|-1; HT=maildocker-contentspam033037006180;
 MF=yehuaisheng@open-hieco.net; NM=1; PH=DS; RN=5; RT=5; SR=0;
 TI=SMTPD_---.jCpK9tL_1789356286; 
Received: from centos9p-03(mailfrom:yehuaisheng@open-hieco.net
 fp:SMTPD_---.jCpK9tL_1789356286 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 14 Sep 2026 11:25:21 +0800
From: Huaisheng Ye <yehuaisheng@open-hieco.net>
To: tsahu@linux.ibm.com,
	pvorel@suse.cz,
	li.wang@linux.dev
Date: Mon, 14 Sep 2026 11:23:59 +0800
Message-ID: <20260914032359.9956-1-yehuaisheng@open-hieco.net>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 14 Sep 2026 10:55:30 +0200
Subject: [LTP] [PATCH] hugemmap10: Account for memory policy in counter
 checks
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

The expected surplus calculation only considers the global free and
reserved hugepage counters. This is insufficient when the task has an
MPOL_BIND policy and some or all globally free hugepages reside outside
the nodes allowed by that policy.

Policy-aware hugetlb reservation accounting allocates surplus pages on
the allowed nodes in this case. For example, with one globally free page
outside the policy and no free pages inside it, reserving one page grows
HugePages_Total, HugePages_Free and HugePages_Surp by one. The current test
expects all three counters to remain unchanged and reports false failures.

Read the current memory policy and cpuset allowed mask with
get_mempolicy(). For MPOL_BIND, intersect both masks; for other policy
modes, use the cpuset mask because they do not impose a hard allocation
constraint. Sum free_hugepages for the resulting nodes before mmap(), and
calculate the expected surplus count as the maximum of the global and
allowed-node shortfalls.

Note that a kernel patch has already been posted for solving Hugetlb
reservations defect. Without that, hugemmap10 would fail when mapping .
https://lore.kernel.org/all/20260909074642.7308-1-yehuaisheng@open-hieco.net/

For example, reproduce it with an eight-node system running 7.3.0-rc1:

# numactl  --membind=0-3   ./hugemmap10
tst_hugepage.c:84: TINFO: 3 hugepage(s) reserved
tst_tmpdir.c:308: TINFO: Using /tmp/LTP_hugwmfnRD as tmpdir (xfs filesystem)
tst_test.c:1218: TINFO: Mounting none to /tmp/LTP_hugwmfnRD/hugetlbfs fstyp=hugetlbfs flags=0
tst_test.c:2048: TINFO: LTP version: 20260529-234-g6e966054b
tst_test.c:2051: TINFO: Tested kernel: 7.3.0-rc1+ #33 SMP PREEMPT Mon Sep  7 11:50:02 CST 2026 x86_64
tst_kconfig.c:90: TINFO: Parsing kernel config '/proc/config.gz'
tst_test.c:1876: TINFO: Overall timeout per run is 0h 00m 30s
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

# numactl  --membind=4-7   ./hugemmap10
tst_hugepage.c:84: TINFO: 3 hugepage(s) reserved
...
hugemmap10.c:364: TINFO: OK
hugemmap10.c:429: TPASS: Hugepages Counters works as expected.

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0

In this example, if the free global huge pages are located on Nodes 4-7 while
the memory policy restricts hugemap10 to allocating memory from Nodes 0-3,
the discrepancy in the counters can be observed.

Signed-off-by: Huaisheng Ye <yehuaisheng@open-hieco.net>
---
 .../kernel/mem/hugetlb/hugemmap/hugemmap10.c  | 73 ++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
index 5b5577a0e..6d1cd6241 100644
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
@@ -48,6 +53,63 @@ static void read_meminfo_huge(long *total, long *free, long *resv, long *surp)
 	*surp = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SURP);
 }

+static int node_isset(unsigned long node, const unsigned long *nodemask)
+{
+	return nodemask[node / ULONG_BITS] & (1UL << (node % ULONG_BITS));
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
+	int mode;
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
+	for (node = 0; node < maxnode; node++) {
+		if (!node_isset(node, cpuset_nodemask))
+			continue;
+		if (mode == MPOL_BIND && !node_isset(node, policy_nodemask))
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
@@ -178,10 +240,14 @@ out:

 static int map_(int s, int hpages, int flags, char *desc, int line)
 {
+	unsigned long allowed_free = 0;
 	long et, ef, er, es;
+	int creates_reservation = (flags & MAP_SHARED) || private_resv;

 	map_fd[s] = tst_creat_unlinked(MNTPOINT, 0, 0600);
 	map_size[s] = hpages * hpage_size;
+	if (creates_reservation)
+		allowed_free = read_allowed_free_hugepages();
 	map_addr[s] = SAFE_MMAP(NULL, map_size[s], PROT_READ|PROT_WRITE, flags,
 				map_fd[s], 0);
 	touched[s] = 0;
@@ -201,11 +267,16 @@ static int map_(int s, int hpages, int flags, char *desc, int line)
 	 * mappings behave like MAP_SHARED at mmap time.  Otherwise,
 	 * no counter updates will occur.
 	 */
-	if ((flags & MAP_SHARED) || private_resv) {
+	if (creates_reservation) {
 		unsigned long shortfall = 0;

 		if (hpages + prev_resv > prev_free)
 			shortfall = hpages - prev_free + prev_resv;
+
+		if ((unsigned long)hpages > allowed_free)
+			shortfall = MAX(shortfall,
+					(unsigned long)hpages - allowed_free);
+
 		et += shortfall;
 		ef += shortfall;
 		er += hpages;
--
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
