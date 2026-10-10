Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D4BCA6017
	for <ltp@archiver.kernel.org>; Sat, 10 Oct 2026 09:52:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CD973E5381
	for <ltp@archiver.kernel.org>; Sat, 10 Oct 2026 11:52:43 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C3FB73E2D2C
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 11:52:27 +0200 (CEST)
Received: from out28-98.mail.aliyun.com (out28-98.mail.aliyun.com
 [115.124.28.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E0A541000612
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 11:52:23 +0200 (CEST)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1347984|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0716031-0.00237522-0.926022;
 FP=9203841104360797437|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033037021217;
 MF=yehuaisheng@open-hieco.net; NM=1; PH=DS; RN=5; RT=5; SR=0;
 TI=SMTPD_---.jYP2Tg._1791625928; 
Received: from centos9p-03(mailfrom:yehuaisheng@open-hieco.net
 fp:SMTPD_---.jYP2Tg._1791625928 cluster:ay29) by smtp.aliyun-inc.com;
 Sat, 10 Oct 2026 17:52:19 +0800
From: Huaisheng Ye <yehuaisheng@open-hieco.net>
To: li.wang@linux.dev,
	chrubis@suse.cz,
	pvorel@suse.cz
Date: Sat, 10 Oct 2026 17:51:52 +0800
Message-ID: <20261010095155.117953-1-yehuaisheng@open-hieco.net>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/3] hugemmap10: Account for memory policy in
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

Changes in v3:
- Rebase onto 113594f53 ("hugemmap10: Treat fd 0 as valid in cleanup").
- Add hugemmap10 -n to runtest/hugetlb so the default suite exercises the
  private fault-time reservation path.
- Remove the redundant private_noreserve variable and use
  private_noreserve_opt directly to detect -n.
- Define MAP_TYPE in lapi/mmap.h when libc headers lack it, and include
  that header in hugemmap10.c.
- Collect Reviewed-by in 1/3 and 3/3.

v2: https://lore.kernel.org/all/20260929072412.20979-1-yehuaisheng@open-hieco.net/

Huaisheng Ye (3):
  hugemmap10: Account for memory policy in mmap counter checks
  hugemmap10: Add private MAP_NORESERVE test mode
  hugemmap10: Account for memory policy in private fault checks

 include/lapi/mmap.h                           |   4 +
 runtest/hugetlb                               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap10.c  | 155 ++++++++++++++++--
 3 files changed, 145 insertions(+), 15 deletions(-)

-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
