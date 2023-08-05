Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B9BC001DB
	for <ltp@archiver.kernel.org>; Sat,  5 Aug 2023 04:08:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 04C823CE369
	for <ltp@archiver.kernel.org>; Sat,  5 Aug 2023 06:08:33 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B3293CB4BD
 for <ltp@lists.linux.it>; Sat,  5 Aug 2023 06:08:21 +0200 (CEST)
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com
 [139.138.61.253])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EAA87600FF8
 for <ltp@lists.linux.it>; Sat,  5 Aug 2023 06:08:20 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="115198598"
X-IronPort-AV: E=Sophos;i="6.01,256,1684767600"; d="scan'208";a="115198598"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2023 13:08:18 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 3CFCAF08A0
 for <ltp@lists.linux.it>; Sat,  5 Aug 2023 13:08:16 +0900 (JST)
Received: from aks-ab2.gw.nic.fujitsu.com (aks-ab2.gw.nic.fujitsu.com
 [192.51.207.12])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 5B2E1D6148
 for <ltp@lists.linux.it>; Sat,  5 Aug 2023 13:08:15 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by aks-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id 6F3D9878F1;
 Sat,  5 Aug 2023 13:08:14 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Sat,  5 Aug 2023 12:07:56 +0800
Message-Id: <1691208482-5464-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27794.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27794.003
X-TMASE-Result: 10--6.842900-10.000000
X-TMASE-MatchedRID: RtHHqK+8YWP/rbll2ZPJSE7nLUqYrlslKQNhMboqZlqrwqxtE531VICu
 qghmtWfXbF6gos3VEkPovZLr3MyNeVn0TQX1xc9+qoeab9Xgz8/kwFzTzcgzhNZHHyezBoPUo8W
 MkQWv6iUoTQl7wNH8Pg1fA1QHegDv3QfwsVk0UbtuRXh7bFKB7tB6ArnfSxw0+NLM+g33glo8oA
 IMHMfc5rvNeFyRJtBHsBTJSD2iAW0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] include/faccessat.h: Add header file faccessat.h
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/lapi/faccessat.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 include/lapi/faccessat.h

diff --git a/include/lapi/faccessat.h b/include/lapi/faccessat.h
new file mode 100644
index 000000000..f3318fd7a
--- /dev/null
+++ b/include/lapi/faccessat.h
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 FUJITSU LIMITED. All rights reserved.
+ * Copyright (c) Linux Test Project, 2003-2023
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+#ifndef FACCESSAT_H
+#define FACCESSAT_H
+
+#include <sys/types.h>
+#include "lapi/syscalls.h"
+
+#ifndef HAVE_FACCESSAT
+int faccessat(int dirfd, const char *pathname, int mode, int flags)
+{
+	return tst_syscall(__NR_faccessat, dirfd, pathname, mode, flags);
+}
+#endif
+
+#endif /* FACCESSAT_H */
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
