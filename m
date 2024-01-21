Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B16C47422
	for <ltp@archiver.kernel.org>; Sun, 21 Jan 2024 12:30:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D61EE3CE261
	for <ltp@archiver.kernel.org>; Sun, 21 Jan 2024 13:30:34 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F6993CACCC
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 13:30:20 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.61.252;
 helo=esa7.hc1455-7.c3s2.iphmx.com; envelope-from=yangx.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com
 [139.138.61.252])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2AFA0100202D
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 13:30:18 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10959"; a="125539534"
X-IronPort-AV: E=Sophos;i="6.05,209,1701097200"; d="scan'208";a="125539534"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2024 21:30:15 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id D43F5D9D97
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 21:30:13 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 0B974D4F53
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 21:30:13 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 9F94422D93A
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 21:30:12 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.214.93])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 5AE971A0070;
 Sun, 21 Jan 2024 20:30:12 +0800 (CST)
From: Xiao Yang <yangx.jy@fujitsu.com>
To: pvorel@suse.cz
Date: Sun, 21 Jan 2024 20:29:59 +0800
Message-Id: <20240121122959.1386-4-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240121122959.1386-1-yangx.jy@fujitsu.com>
References: <20240121122959.1386-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28132.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28132.007
X-TMASE-Result: 10--6.032400-10.000000
X-TMASE-MatchedRID: Wy+nSYbiYSvfytYpCSLCzrnHu4BcYSmtwTlc9CcHMZerwqxtE531VPnT
 SlCpnRQQbnRB47KLJ1QzLmfGY6iDkYF+91Q/EzGtN70wXhI0DX4O4jfa+nI3PyfJTn+dmnFQuJE
 UmdYPGSV+CxzcGwLNWC4s/ZINHrYCTjkI/HOY4jS628cXbnOhT1K6+0HOVoSoe9hy6oWpRq3+H2
 Vc++7V2eLzNWBegCW2wgn7iDBesS0gBwKKRHe+r2iF3+txQzMoVakMn4gzHg2BhLMw/M+z5SX0l
 muy64XQsWKjyeRUS7o=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/4] syscalls/pwritev: Make make check happy
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

Also add LTP Copyright.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 testcases/kernel/syscalls/pwritev/pwritev.h   | 21 ++++++-------------
 testcases/kernel/syscalls/pwritev/pwritev01.c |  7 ++++---
 testcases/kernel/syscalls/pwritev/pwritev02.c |  7 ++++---
 testcases/kernel/syscalls/pwritev/pwritev03.c |  3 ++-
 4 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/testcases/kernel/syscalls/pwritev/pwritev.h b/testcases/kernel/syscalls/pwritev/pwritev.h
index 833160ddb..bc98487d0 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev.h
+++ b/testcases/kernel/syscalls/pwritev/pwritev.h
@@ -1,18 +1,9 @@
-/*
-* Copyright (c) 2015 Fujitsu Ltd.
-* Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
-*
-* This program is free software; you can redistribute it and/or modify it
-* under the terms of version 2 of the GNU General Public License as
-* published by the Free Software Foundation.
-*
-* This program is distributed in the hope that it would be useful, but
-* WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-*
-* You should have received a copy of the GNU General Public License
-* alone with this program.
-*/
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (c) 2015 Fujitsu Ltd.
+ * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ * Copyright (c) Linux Test Project, 2016-2023
+ */
 
 #ifndef PWRITEV_H
 #define PWRITEV_H
diff --git a/testcases/kernel/syscalls/pwritev/pwritev01.c b/testcases/kernel/syscalls/pwritev/pwritev01.c
index d0ec14a69..f5fce81f2 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev01.c
+++ b/testcases/kernel/syscalls/pwritev/pwritev01.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
-* Copyright (c) 2015 Fujitsu Ltd.
-* Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
-*/
+ * Copyright (c) 2015 Fujitsu Ltd.
+ * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ * Copyright (c) Linux Test Project, 2016-2023
+ */
 
 /*\
  * [Description]
diff --git a/testcases/kernel/syscalls/pwritev/pwritev02.c b/testcases/kernel/syscalls/pwritev/pwritev02.c
index f3a7cc003..59a286847 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev02.c
+++ b/testcases/kernel/syscalls/pwritev/pwritev02.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
-* Copyright (c) 2015-2016 Fujitsu Ltd.
-* Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
-*/
+ * Copyright (c) 2015-2016 Fujitsu Ltd.
+ * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ * Copyright (c) Linux Test Project, 2017-2023
+ */
 
 /*\
  * [Description]
diff --git a/testcases/kernel/syscalls/pwritev/pwritev03.c b/testcases/kernel/syscalls/pwritev/pwritev03.c
index ea2892971..1bf9d5731 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev03.c
+++ b/testcases/kernel/syscalls/pwritev/pwritev03.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
  * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ * Copyright (c) Linux Test Project, 2019-2023
  */
 
 /*\
@@ -92,7 +93,7 @@ static void verify_direct_pwritev(unsigned int n)
 static void setup(void)
 {
 	int dev_fd, ret;
-	
+
 	dev_fd = SAFE_OPEN(tst_device->dev, O_RDWR);
 	SAFE_IOCTL(dev_fd, BLKSSZGET, &ret);
 	SAFE_CLOSE(dev_fd);
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
