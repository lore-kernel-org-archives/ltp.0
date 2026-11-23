Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7586C607150A
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 08:06:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 07BE13E916E
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 09:06:31 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 424CE3C70D9
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 09:06:00 +0100 (CET)
Received: from out28-170.mail.aliyun.com (out28-170.mail.aliyun.com
 [115.124.28.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 09928600711
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 09:05:57 +0100 (CET)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.08957792|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.00556565-0.000343906-0.99409;
 FP=7726238093929894121|1|1|1|0|-1|-1|-1; HT=maildocker-contentspam033037026024;
 MF=yehuaisheng@open-hieco.net; NM=1; PH=DS; RN=5; RT=5; SR=0;
 TI=SMTPD_---.k862beR_1795421140; 
Received: from centos9p-03(mailfrom:yehuaisheng@open-hieco.net
 fp:SMTPD_---.k862beR_1795421140 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 23 Nov 2026 16:05:54 +0800
From: Huaisheng Ye <yehuaisheng@open-hieco.net>
To: li.wang@linux.dev,
	chrubis@suse.cz,
	pvorel@suse.cz
Date: Mon, 23 Nov 2026 16:05:34 +0800
Message-ID: <20261123080537.20122-1-yehuaisheng@open-hieco.net>
X-Mailer: git-send-email 2.52.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/3] hugemmap10: Add NUMA hugetlb regression test
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

The existing hugemmap10 counter test does not reliably exercise the
hugetlb NUMA regression fixed by Linux commit
21f514ad520459fbfa58ccdf171bb68148c2f5aa. Free hugepages may be
available globally but located outside the nodes allowed by the task's
memory policy, so the test needs to establish this state explicitly.

Add a NUMA subtest which binds the task to the second memory node, keeps
free hugepages on the first node, and reuses the existing counter-test
sequence for base pool sizes from zero through three. The original test
continues to run unchanged as the default subtest.

Changes since v1:

  - Move the regression description and reproduction command into the
    existing LTP documentation comment so they are exported properly.
  - Add a separate NUMA subtest instead of relying on an externally
    configured numactl environment.
  - Reuse the original five mapping scenarios and base pool sizes 0-3,
    while skipping only the NUMA subtest when its prerequisites cannot
    be established.
  - Save and restore the inherited memory policy and the affected
    per-node persistent hugepage pools.
  - Split the NUMA test implementation and its diagnostic logging into
    separate patches.

v1: https://lore.kernel.org/ltp/20261116101559.93229-1-yehuaisheng@open-hieco.net/

Tested on a NUMA system:

  make -C testcases/kernel/mem/hugetlb/hugemmap hugemmap10
  ./hugemmap10 -D2
  ./hugemmap10 -D2 -n

The test completed with two passing subtests.

Huaisheng Ye (3):
  hugemmap10: Add linux-git tag for NUMA fix
  hugemmap10: Reuse counter tests with a NUMA bind policy
  hugemmap10: Add NUMA counter test diagnostics

 .../kernel/mem/hugetlb/hugemmap/hugemmap10.c  | 251 +++++++++++++++++-
 1 file changed, 239 insertions(+), 12 deletions(-)

-- 
2.52.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
