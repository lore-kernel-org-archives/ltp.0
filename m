Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CDBC47DAF
	for <ltp@archiver.kernel.org>; Sun, 21 Jan 2024 12:30:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C9DFB3CE24D
	for <ltp@archiver.kernel.org>; Sun, 21 Jan 2024 13:30:50 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3691A3CC7D3
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 13:30:19 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.48;
 helo=esa2.hc1455-7.c3s2.iphmx.com; envelope-from=yangx.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com
 [207.54.90.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 328741002057
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 13:30:18 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10959"; a="146761071"
X-IronPort-AV: E=Sophos;i="6.05,209,1701097200"; d="scan'208";a="146761071"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2024 21:30:16 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 6C098D9DA5
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 21:30:13 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id A596BD2147
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 21:30:12 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 2F068200A7854
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 21:30:12 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.214.93])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id C71FB1A015E;
 Sun, 21 Jan 2024 20:30:11 +0800 (CST)
From: Xiao Yang <yangx.jy@fujitsu.com>
To: pvorel@suse.cz
Date: Sun, 21 Jan 2024 20:29:57 +0800
Message-Id: <20240121122959.1386-2-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240121122959.1386-1-yangx.jy@fujitsu.com>
References: <20240121122959.1386-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28132.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28132.007
X-TMASE-Result: 10--7.304500-10.000000
X-TMASE-MatchedRID: f4rHggDVdNffytYpCSLCzrnHu4BcYSmtwTlc9CcHMZerwqxtE531VPnT
 SlCpnRQQbnRB47KLJ1QzLmfGY6iDkYF+91Q/EzGtN70wXhI0DX4O4jfa+nI3PyfJTn+dmnFQuJE
 UmdYPGSV+CxzcGwLNWGzNhvRhOypXTKxdspm3SX7fSQNpZkETVPi4nVERfgwdVub+/GZAO90gya
 HyKlLsWafJQ9RXKcxagDLqnrRlXrZ8nn9tnqel2DsAVzN+Ov/sg7B+KYpwErJUT9gKLiJOBVnlo
 9dWGqXoVgJEAhhcZghzy/hLIuZDsQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/4] syscalls/preadv: Make make check happy
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
 testcases/kernel/syscalls/preadv/preadv.h   | 21 ++++++---------------
 testcases/kernel/syscalls/preadv/preadv01.c | 13 +++++++------
 testcases/kernel/syscalls/preadv/preadv02.c |  7 ++++---
 testcases/kernel/syscalls/preadv/preadv03.c |  1 +
 4 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/testcases/kernel/syscalls/preadv/preadv.h b/testcases/kernel/syscalls/preadv/preadv.h
index 73466a9aa..bfe7e7223 100644
--- a/testcases/kernel/syscalls/preadv/preadv.h
+++ b/testcases/kernel/syscalls/preadv/preadv.h
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
 
 #ifndef PREADV_H
 #define PREADV_H
diff --git a/testcases/kernel/syscalls/preadv/preadv01.c b/testcases/kernel/syscalls/preadv/preadv01.c
index 10604200d..871b3ab42 100644
--- a/testcases/kernel/syscalls/preadv/preadv01.c
+++ b/testcases/kernel/syscalls/preadv/preadv01.c
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
@@ -38,7 +39,7 @@ static struct tcase {
 	{1, CHUNK*3/2, CHUNK/2, 'b'}
 };
 
-void verify_preadv(unsigned int n)
+static void verify_preadv(unsigned int n)
 {
 	int i;
 	char *vec;
@@ -81,7 +82,7 @@ void verify_preadv(unsigned int n)
 		 "with content '%c' expectedly", tc->size, tc->content);
 }
 
-void setup(void)
+static void setup(void)
 {
 	char buf[CHUNK];
 
@@ -94,7 +95,7 @@ void setup(void)
 	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, sizeof(buf));
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
 	if (fd > 0)
 		SAFE_CLOSE(fd);
diff --git a/testcases/kernel/syscalls/preadv/preadv02.c b/testcases/kernel/syscalls/preadv/preadv02.c
index bfcf5052b..9977a4f48 100644
--- a/testcases/kernel/syscalls/preadv/preadv02.c
+++ b/testcases/kernel/syscalls/preadv/preadv02.c
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
diff --git a/testcases/kernel/syscalls/preadv/preadv03.c b/testcases/kernel/syscalls/preadv/preadv03.c
index 5d2946bc3..558d85050 100644
--- a/testcases/kernel/syscalls/preadv/preadv03.c
+++ b/testcases/kernel/syscalls/preadv/preadv03.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
  * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ * Copyright (c) Linux Test Project, 2019-2023
  */
 
 /*\
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
