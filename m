Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E68CA5FA1
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 07:25:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 679173CFF65
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 09:25:08 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C52173CE13E
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 09:24:36 +0200 (CEST)
Received: from out28-219.mail.aliyun.com (out28-219.mail.aliyun.com
 [115.124.28.219])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3DD281A009A2
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 09:24:31 +0200 (CEST)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1141123|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0137365-0.000450289-0.985813;
 FP=7474458847454196989|2|1|1|0|-1|-1|-1; HT=maildocker-contentspam033032053168;
 MF=yehuaisheng@open-hieco.net; NM=1; PH=DS; RN=5; RT=5; SR=0;
 TI=SMTPD_---.jR9cqXv_1790666658; 
Received: from centos9p-03(mailfrom:yehuaisheng@open-hieco.net
 fp:SMTPD_---.jR9cqXv_1790666658 cluster:ay29) by smtp.aliyun-inc.com;
 Tue, 29 Sep 2026 15:24:28 +0800
From: Huaisheng Ye <yehuaisheng@open-hieco.net>
To: li.wang@linux.dev,
	chrubis@suse.cz,
	pvorel@suse.cz
Date: Tue, 29 Sep 2026 15:24:09 +0800
Message-ID: <20260929072412.20979-1-yehuaisheng@open-hieco.net>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/3] hugemmap10: Account for memory policy in
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

The hugetlb reservation fix allocates surplus hugepages when global free
pages are outside nodes allowed by the current cpuset and MPOL_BIND policy.
This series updates hugemmap10's global counter expectations to match that
behavior.

Patch 1 fixes mappings that create their reservation at mmap() time. Patches
2 and 3 add and validate a MAP_NORESERVE private-mapping mode, which lets the
test exercise fault-time reservations without booting an older kernel.

Changes in v2:
- Expand the v1 change[1] from mmap-time to private fault-time accounting
  patches, with the MAP_NORESERVE test mode between them.
- Match hugetlb's MPOL_BIND behavior when its policy mask no longer overlaps
  the current cpuset: fall back to the cpuset mask instead of treating the
  allowed set as empty.
- Normalize nodemask bit tests to avoid truncating bits in the upper half of
  an unsigned long on 64-bit systems.
- Add -n to map only private VMAs with MAP_NORESERVE. The reservation probe
  uses the same flags, so the private_resv debug report reflects the actual
  private mapping behavior. MAP_SHARED mappings are unchanged.
- Account for the allowed-node shortfall when an unreserved private mapping
  first faults in touch_(), and share the reservation predicate with unmap_().

[1] https://lore.kernel.org/ltp/20260914032359.9956-1-yehuaisheng@open-hieco.net/

Huaisheng Ye (3):
  hugemmap10: Account for memory policy in mmap counter checks
  hugemmap10: Add private MAP_NORESERVE test mode
  hugemmap10: Account for memory policy in private fault checks

 .../kernel/mem/hugetlb/hugemmap/hugemmap10.c  | 156 ++++++++++++++++--
 1 file changed, 141 insertions(+), 15 deletions(-)

-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
