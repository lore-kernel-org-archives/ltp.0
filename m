Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192F0606A31A
	for <ltp@archiver.kernel.org>; Mon, 26 Oct 2026 07:08:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 386C93E216D
	for <ltp@archiver.kernel.org>; Mon, 26 Oct 2026 08:08:12 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0AA743E212E
 for <ltp@lists.linux.it>; Mon, 26 Oct 2026 08:07:56 +0100 (CET)
Received: from out28-50.mail.aliyun.com (out28-50.mail.aliyun.com
 [115.124.28.50])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9591310004A3
 for <ltp@lists.linux.it>; Mon, 26 Oct 2026 08:07:53 +0100 (CET)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.08175424|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0539659-0.000885369-0.945149;
 FP=8875113360780455165|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033071099199;
 MF=yehuaisheng@open-hieco.net; NM=1; PH=DS; RN=5; RT=5; SR=0;
 TI=SMTPD_---.jpkJxHD_1792998455; 
Received: from centos9p-03(mailfrom:yehuaisheng@open-hieco.net
 fp:SMTPD_---.jpkJxHD_1792998455 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 26 Oct 2026 15:07:49 +0800
From: Huaisheng Ye <yehuaisheng@open-hieco.net>
To: li.wang@linux.dev,
	chrubis@suse.cz,
	pvorel@suse.cz
Date: Mon, 26 Oct 2026 15:07:29 +0800
Message-ID: <20261026070732.74314-1-yehuaisheng@open-hieco.net>
X-Mailer: git-send-email 2.52.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/3] hugemmap10: Account for memory policy in
 counter checks
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

The hugetlb reservation fix allocates surplus hugepages when global free
pages are outside nodes allowed by the current cpuset and MPOL_BIND policy.
This series updates hugemmap10's global counter expectations to match that
behavior.

Patch 1 fixes mappings that create their reservation at mmap() time. Patches
2 and 3 add and validate a MAP_NORESERVE private-mapping mode, which lets the
test exercise fault-time allocation without booting a kernel that lacks
private mmap-time reservations.

Changes in v4:
- Rebase onto 05aebc377 ("sys_hwmon01: always report a result").
- Preserve the memory policy mode flags and resolve MPOL_F_RELATIVE_NODES
  masks against the current allowed memory nodes using nodes_fold() and
  nodes_onto() semantics before checking overlap or counting free pages.
- Give hugemmap10 -n the distinct runtest identifier hugemmap10_noreserve
  so session restore and reboot recovery track both invocations separately.
- Correct comments and commit messages to describe MAP_NORESERVE faults as
  allocating unreserved hugepages, without creating a mapping reservation
  or changing HugePages_Rsvd.
- Collect Reviewed-by in 2/3.

Changes in v3:
- Rebase onto 113594f53 ("hugemmap10: Treat fd 0 as valid in cleanup").
- Add hugemmap10 -n to runtest/hugetlb so the default suite exercises the
  private fault-time allocation path.
- Remove the redundant private_noreserve variable and use
  private_noreserve_opt directly to detect -n.
- Define MAP_TYPE in lapi/mmap.h when libc headers lack it, and include
  that header in hugemmap10.c.
- Collect Reviewed-by in 1/3 and 3/3.

Tested on an eight-node system running v7.3, with cpuset
{3,5,6}: both default and -n invocations pass with relative MPOL_BIND {1,2}
and ordinary MPOL_BIND {5,6}. An additional -n run with relative {0,4}
also passes, exercising folding to physical nodes {3,5}.

v3: https://lore.kernel.org/all/20261010095155.117953-2-yehuaisheng@open-hieco.net/
v2: https://lore.kernel.org/all/20260929072412.20979-1-yehuaisheng@open-hieco.net/

Huaisheng Ye (3):
  hugemmap10: Account for memory policy in mmap counter checks
  hugemmap10: Add private MAP_NORESERVE test mode
  hugemmap10: Account for memory policy in private fault checks

 include/lapi/mmap.h                           |   4 +
 runtest/hugetlb                               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap10.c  | 194 ++++++++++++++++--
 3 files changed, 184 insertions(+), 15 deletions(-)

-- 
2.52.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
