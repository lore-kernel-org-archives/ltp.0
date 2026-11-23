Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9CF607150F
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 08:06:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4A9B3E919B
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 09:06:42 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5DE0A3E9165
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 09:06:03 +0100 (CET)
Received: from out28-5.mail.aliyun.com (out28-5.mail.aliyun.com [115.124.28.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C5FBA1A006E1
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 09:05:58 +0100 (CET)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1038428|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0498063-0.00106425-0.949129;
 FP=5413393401108846061|1|1|1|0|-1|-1|-1; HT=maildocker-contentspam033025068124;
 MF=yehuaisheng@open-hieco.net; NM=1; PH=DS; RN=5; RT=5; SR=0;
 TI=SMTPD_---.k862bt5_1795421154; 
Received: from centos9p-03(mailfrom:yehuaisheng@open-hieco.net
 fp:SMTPD_---.k862bt5_1795421154 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 23 Nov 2026 16:05:54 +0800
From: Huaisheng Ye <yehuaisheng@open-hieco.net>
To: li.wang@linux.dev,
	chrubis@suse.cz,
	pvorel@suse.cz
Date: Mon, 23 Nov 2026 16:05:35 +0800
Message-ID: <20261123080537.20122-2-yehuaisheng@open-hieco.net>
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
Subject: [LTP] [PATCH v2 1/3] hugemmap10: Add linux-git tag for NUMA fix
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

Tag Linux commit 21f514ad5204 ("mm/hugetlb: account for allowed nodes
when gathering surplus pages"), which fixes hugetlb mappings when free
huge pages are outside the nodes allowed by the task's cpuset or
MPOL_BIND policy.

Before the fix, gather_surplus_pages() considered only global counters.
As a result, mmap() could fail with ENOMEM even when
nr_overcommit_hugepages allowed surplus pages on the permitted nodes.

Put the regression description and NUMA reproduction command in the
existing documentation comment so both are exported to documentation.

Signed-off-by: Huaisheng Ye <yehuaisheng@open-hieco.net>
---
 .../kernel/mem/hugetlb/hugemmap/hugemmap10.c     | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
index c66b07039..763f68e69 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
@@ -10,6 +10,18 @@
  * Hugetlb counter (Total, Free, Reserve, Surplus) in /proc/meminfo and
  * compare them with expected (calculated) value. if all checks are
  * successful, the test passes.
+ *
+ * This test also covers the NUMA regression fixed by Linux commit
+ * 21f514ad520459fbfa58ccdf171bb68148c2f5aa. If free huge pages are outside
+ * the nodes allowed by the task's cpuset or MPOL_BIND policy, hugetlb must
+ * account for the allowed-node shortfall when gathering surplus pages.
+ * Otherwise mmap() may fail with ENOMEM even when nr_overcommit_hugepages
+ * permits allocating surplus pages on the allowed nodes.
+ *
+ * The issue can be exercised on a system with two or more NUMA nodes, for
+ * example with::
+ *
+ *     numactl --cpunodebind=0 --membind=1 ./hugemmap10
  */
 
 #define _GNU_SOURCE
@@ -602,6 +614,10 @@ static void cleanup(void)
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
