Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BFE606A31C
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 10:16:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C1CF43E97B3
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 11:16:39 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 34D3D3E200A
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 11:16:22 +0100 (CET)
Received: from out28-193.mail.aliyun.com (out28-193.mail.aliyun.com
 [115.124.28.193])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 10DD36007B4
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 11:16:18 +0100 (CET)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1006085|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0650605-0.00117185-0.933768;
 FP=5197783019196859373|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033032065030;
 MF=yehuaisheng@open-hieco.net; NM=1; PH=DS; RN=5; RT=5; SR=0;
 TI=SMTPD_---.k3-DU7G_1794824167; 
Received: from centos9p-03(mailfrom:yehuaisheng@open-hieco.net
 fp:SMTPD_---.k3-DU7G_1794824167 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 16 Nov 2026 18:16:15 +0800
From: Huaisheng Ye <yehuaisheng@open-hieco.net>
To: li.wang@linux.dev,
	chrubis@suse.cz,
	pvorel@suse.cz
Date: Mon, 16 Nov 2026 18:15:59 +0800
Message-ID: <20261116101559.93229-1-yehuaisheng@open-hieco.net>
X-Mailer: git-send-email 2.52.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] hugemmap10: Add linux-git tag for NUMA fix
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

Tag Linux commit 21f514ad520459fbfa58ccdf171bb68148c2f5aa, which fixes
hugetlb mappings when free huge pages are outside the nodes allowed by the
task's cpuset or MPOL_BIND policy.

Before the fix, gathering surplus pages considered only global counters, so
mmap() could fail with ENOMEM even when nr_overcommit_hugepages allowed
surplus pages on the permitted nodes.

Document the regression and its NUMA reproduction command in the test.

Signed-off-by: Huaisheng Ye <yehuaisheng@open-hieco.net>
---
 .../kernel/mem/hugetlb/hugemmap/hugemmap10.c   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
index c66b07039..c3e0984d4 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
@@ -12,6 +12,20 @@
  * successful, the test passes.
  */
 
+/*
+ * This test also covers the NUMA regression fixed by Linux commit
+ * 21f514ad520459fbfa58ccdf171bb68148c2f5aa. If free huge pages are outside
+ * the nodes allowed by the task's cpuset or MPOL_BIND policy, hugetlb must
+ * account for the allowed-node shortfall when gathering surplus pages.
+ * Otherwise mmap() may fail with ENOMEM even when nr_overcommit_hugepages
+ * permits allocating surplus pages on the allowed nodes.
+ *
+ * The issue can be exercised on a system with two or more NUMA nodes, for
+ * example with:
+ *
+ *   numactl --cpunodebind=0 --membind=1 ./hugemmap10
+ */
+
 #define _GNU_SOURCE
 #include <errno.h>
 #include <linux/mempolicy.h>
@@ -602,6 +616,10 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.tags = (struct tst_tag[]) {
+		{"linux-git", "21f514ad520459fbfa58ccdf171bb68148c2f5aa"},
+		{}
+	},
 	.needs_root = 1,
 	.options = (struct tst_option[]) {
 		{"n", &private_noreserve_opt,
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
