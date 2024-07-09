Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A8AC2BD09
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 09:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1720518688; h=to : date :
 message-id : subject : list-id : list-unsubscribe : list-archive :
 list-post : list-help : list-subscribe : from : reply-to :
 mime-version : content-type : content-transfer-encoding : sender :
 from; bh=0fhXETuTTUeuiwJyZup0PSMaoW4Tatg+jXl3gPKHyxc=;
 b=aFOKYlS6OfttCH3uz4IlutPxEXjtLm1LvfH2/Bu9YkgC0z463BSPf55sfQvp4npXIDzOO
 BJG503oJ2X9AqcrDfRB7HluapCN2A0r2gnIPIsIeHU2M52SqfXu4BZgidizjZpGe01UU3SS
 BBpHsICh3N8IPwMaArSRwUaAVw+xr1I=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 834683D393C
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 11:51:28 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 16A473D3916
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 11:51:06 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.36.223;
 helo=esa9.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com
 [139.138.36.223])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BC4C31A01166
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 11:51:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1720518665; x=1752054665;
 h=from:to:cc:subject:date:message-id;
 bh=GuaKYcv/fk51SXmmaufybFllIKwGiUgym/8gPUKuTc8=;
 b=ZjQyohEkWTPlsW0zAK6taK3kuKjZLM3gLso3mOfhBxrYH4eq3p8Ssh5e
 W2teB5wUAbjau8GtKHh6bE34rUPg/IeTxx90sp4eX+iAKmr33YQEslrVY
 kymthkHGKjYDpM4fLb3tfEzECNbLwiOJXn+zeSwTloXQc9clBHLY+I77P
 Nj7dRO1eURduL7qpJvDGL7J0hvYozU9Th37mHvQr7IfirVoYOkAR+gvrt
 pvMKuWSIbNi4x1g9VouPxEcqWjtu6vjIW9Xu7cpenvLhyF7pOk1g/qMrN
 e69ifLVY8ZnXQbg//YuBTJMhnSZa5eMCId6IMm+Sh6+hzj/F6q5NDa4Mj g==;
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="154689169"
X-IronPort-AV: E=Sophos;i="6.09,194,1716217200"; d="scan'208";a="154689169"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2024 18:51:03 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 488B0D4240
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 18:51:01 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 7E713D8B82
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 18:51:00 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 1711B40A62
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 18:50:58 +0900 (JST)
Received: from localhost (unknown [10.167.226.69])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id D0BA41A000B;
 Tue,  9 Jul 2024 17:50:57 +0800 (CST)
To: ltp@lists.linux.it
Date: Tue,  9 Jul 2024 17:50:45 +0800
Message-Id: <20240709095045.30896-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.18.1
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28518.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28518.006
X-TMASE-Result: 10--10.354400-10.000000
X-TMASE-MatchedRID: AvuQOGDihJqkSoeAfA+QP6oXHZz/dXlxOtFOIp/xxwDfUZT83lbkEC15
 IFUNL+ETKaYrswcBhT7/hDDq/XyZmS/7QU2czuUNCtzGvPCy/m5SuvtBzlaEqFH3rkvzbWPM4Ib
 z3CH3vCeP9u+1+GFcS2+n5v/ArhNPWUOK5XsuMf7FVAV8vDjN/6TYf9v9flolmyiLZetSf8kqzD
 t2+ewmfOGANVBCTxXNC24oEZ6SpSkgbhiVsIMQK9LdHHLXgng3s4YzAnZqxSBrOPjjAZZhkaqnS
 UWFAietQaELP5xj7PIJK2MK45H+GA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] sigsuspend: Add testcase for EFAULT
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
From: Ma Xinjian via ltp <ltp@lists.linux.it>
Reply-To: Ma Xinjian <maxj.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add a testcase with the mask parameter points to an invalid address.

Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
---
 runtest/syscalls                              |  1 +
 .../kernel/syscalls/sigsuspend/.gitignore     |  1 +
 .../kernel/syscalls/sigsuspend/sigsuspend02.c | 34 +++++++++++++++++++
 3 files changed, 36 insertions(+)
 create mode 100644 testcases/kernel/syscalls/sigsuspend/sigsuspend02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index b6cadb2df..373f4d2e6 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1496,6 +1496,7 @@ sigprocmask01 sigprocmask01
 sigrelse01 sigrelse01
 
 sigsuspend01 sigsuspend01
+sigsuspend02 sigsuspend02
 
 sigtimedwait01 sigtimedwait01
 
diff --git a/testcases/kernel/syscalls/sigsuspend/.gitignore b/testcases/kernel/syscalls/sigsuspend/.gitignore
index 46ea52f73..926b73571 100644
--- a/testcases/kernel/syscalls/sigsuspend/.gitignore
+++ b/testcases/kernel/syscalls/sigsuspend/.gitignore
@@ -1 +1,2 @@
 /sigsuspend01
+/sigsuspend02
diff --git a/testcases/kernel/syscalls/sigsuspend/sigsuspend02.c b/testcases/kernel/syscalls/sigsuspend/sigsuspend02.c
new file mode 100644
index 000000000..5bfed9d2d
--- /dev/null
+++ b/testcases/kernel/syscalls/sigsuspend/sigsuspend02.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
+ * Copyright (c) Linux Test Project, 2024
+ * Author: Ma Xinjian <maxj.fnst@fujitsu.com>
+
+/*\
+ * [Description]
+ *
+ * Verify that sigsuspend(2) fails with
+ *
+ * - EFAULT mask points to memory which is not a valid part of the
+ *          process address space.
+ */
+
+#include "tst_test.h"
+
+static void *invalid_mask;
+
+static void setup(void)
+{
+        invalid_mask = tst_get_bad_addr(NULL);
+}
+
+static void verify_sigsuspend(void)
+{
+        TST_EXP_FAIL(sigsuspend(invalid_mask), EFAULT);
+}
+
+static struct tst_test test = {
+        .test_all = verify_sigsuspend,
+        .setup = setup,
+};
+
-- 
2.18.1

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
