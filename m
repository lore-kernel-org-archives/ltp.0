Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BF1C32771
	for <ltp@archiver.kernel.org>; Wed, 28 Sep 2022 10:10:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 011233C9B48
	for <ltp@archiver.kernel.org>; Wed, 28 Sep 2022 12:10:13 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A5DAF3C1BB8
 for <ltp@lists.linux.it>; Wed, 28 Sep 2022 12:10:03 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D1D4F1A01163
 for <ltp@lists.linux.it>; Wed, 28 Sep 2022 12:10:00 +0200 (CEST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4McsZP0XPlzWgqX
 for <ltp@lists.linux.it>; Wed, 28 Sep 2022 18:05:49 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 18:09:54 +0800
To: <ltp@lists.linux.it>
Date: Wed, 28 Sep 2022 18:06:02 +0800
Message-ID: <20220928100602.213286-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] SPDX Identifier: Correct SPDX Identifier
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
From: Zhao Gongyi via ltp <ltp@lists.linux.it>
Reply-To: Zhao Gongyi <zhaogongyi@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Correct SPDX Identifier for madvise10.c and statx06.c.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 testcases/kernel/syscalls/madvise/madvise10.c | 1 -
 testcases/kernel/syscalls/statx/statx06.c     | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise10.c b/testcases/kernel/syscalls/madvise/madvise10.c
index d73d9aabc..c299788a9 100644
--- a/testcases/kernel/syscalls/madvise/madvise10.c
+++ b/testcases/kernel/syscalls/madvise/madvise10.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-// SPDX-License-Identifier: GPL-2.0 or later
 /*
  *  Copyright (c) Zilogic Systems Pvt. Ltd., 2018
  *  Email : code@zilogic.com
diff --git a/testcases/kernel/syscalls/statx/statx06.c b/testcases/kernel/syscalls/statx/statx06.c
index 28badb038..58a7094f8 100644
--- a/testcases/kernel/syscalls/statx/statx06.c
+++ b/testcases/kernel/syscalls/statx/statx06.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or later
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Zilogic Systems Pvt. Ltd., 2018
  * Email : code@zilogic.com
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
