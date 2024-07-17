Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC610C3DA59
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 02:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1721183292; h=to : date :
 message-id : subject : list-id : list-unsubscribe : list-archive :
 list-post : list-help : list-subscribe : from : reply-to :
 mime-version : content-type : content-transfer-encoding : sender :
 from; bh=QrsoSuTqVjtmIQ0DyfEhiiX53x5Zyl7EiPJdfUjDI6U=;
 b=q92+j5MugJyrt15WUZs0I+0Klb/AaAZks4tIyMLQ2ohk0QRH7SzWBLC40kJSYddV6FOLe
 vL5wxDz6l4DeS8TmsoPy9NCI/pUSk83xxBjABqh5yLDkpRPCzMjLu+ezeqf+UrgCoDbN98p
 MW3AZOV7oDvsAMYSXktqP5M98YJZeIw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C1B63D1AAB
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 04:28:12 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C9C13D0B46
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 04:27:50 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.36.223;
 helo=esa9.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com
 [139.138.36.223])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CC5701016B82
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 04:27:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1721183269; x=1752719269;
 h=from:to:cc:subject:date:message-id;
 bh=Z4Yxw9fgxz9hQAP3uIVx4wqLzz+TFb4RdKA1FS8RNf8=;
 b=I2yChngvJM3SDr9vtmy4kbp7oGJ4yj073msjuEYdofWmRyWfYJCe2PNt
 pvcM3kW+ENbZAxyoXO+s+6ztsSvKB+kmIj6QwG8ShWp6uXgDseATic7CR
 W1Gi4AkXI2wNEu0+b3pwfGAH95UfACemGBE0pO5vioEfcMsKjA2i2ub7R
 exPh+kZ9h1n8LYqXtxgNH6WT9UVhnwVPJeiKC92A2iw9nlByDT8HnKx3x
 WA+MCCSHWEJj1+R8UI4TCFyc6Nm7sRlVgMkw06vGqQLrUrU4r6i3bbZB5
 DiVUJHlsJr38tv7sGy1Ngl9feGCyu7OGevnklb6wl6DtubDoPbfKcCKB0 A==;
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="155779369"
X-IronPort-AV: E=Sophos;i="6.09,213,1716217200"; d="scan'208";a="155779369"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2024 11:27:46 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 99A44D4250
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 11:27:44 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id E3387D8BD0
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 11:27:43 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 852762007CDED
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 11:27:43 +0900 (JST)
Received: from localhost (unknown [10.167.226.69])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 0B3D31A000A;
 Wed, 17 Jul 2024 10:27:42 +0800 (CST)
To: ltp@lists.linux.it
Date: Wed, 17 Jul 2024 10:27:24 +0800
Message-Id: <20240717022724.16333-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.18.1
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28534.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28534.003
X-TMASE-Result: 10--12.077600-10.000000
X-TMASE-MatchedRID: mafpUJSAc1CkSoeAfA+QP6oXHZz/dXlxBMdp5178zSNgPgeggVwCFnU3
 oKSu0J1xUh5maKIJAx/mn3xyPJAJoh2P280ZiGmRCtzGvPCy/m5SuvtBzlaEqFH3rkvzbWPM4Ib
 z3CH3vCeP9u+1+GFcS2+n5v/ArhNPWUOK5XsuMf7FVAV8vDjN/0i8rgutezVpW1EpqtJXzRujxY
 yRBa/qJXtf8bo3mMyQhzImjrjZJG3dB/CxWTRRu/558CedkGIvzP4Frv6e/e7ZGbM+0J3WCPm0f
 i01OIuoe2JYNHRTCRIk9mWDlBRWBn7cGd19dSFd
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] getcpu: Add testcase for EFAULT
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

Add a testcase with the arguments point to an invalid address.

Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/getcpu/.gitignore |  1 +
 testcases/kernel/syscalls/getcpu/getcpu02.c | 31 +++++++++++++++++++++
 3 files changed, 33 insertions(+)
 create mode 100644 testcases/kernel/syscalls/getcpu/getcpu02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 136fd03fa..31922bc9f 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -440,6 +440,7 @@ futimesat01 futimesat01
 getcontext01 getcontext01
 
 getcpu01 getcpu01
+getcpu02 getcpu02
 
 getcwd01 getcwd01
 getcwd02 getcwd02
diff --git a/testcases/kernel/syscalls/getcpu/.gitignore b/testcases/kernel/syscalls/getcpu/.gitignore
index 31fec5d35..cd3022bbb 100644
--- a/testcases/kernel/syscalls/getcpu/.gitignore
+++ b/testcases/kernel/syscalls/getcpu/.gitignore
@@ -1 +1,2 @@
 /getcpu01
+/getcpu02
diff --git a/testcases/kernel/syscalls/getcpu/getcpu02.c b/testcases/kernel/syscalls/getcpu/getcpu02.c
new file mode 100644
index 000000000..0857a0598
--- /dev/null
+++ b/testcases/kernel/syscalls/getcpu/getcpu02.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
+ * Copyright (c) Linux Test Project, 2024
+ * Author: Ma Xinjian <maxj.fnst@fujitsu.com>
+ *
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that getcpu(2) fails with
+ *
+ * - EFAULT arguments point outside the calling process's address
+ *          space.
+ */
+
+#define _GNU_SOURCE
+#include "tst_test.h"
+#include "lapi/sched.h"
+
+static void run(void) {
+        unsigned int cpu_id, node_id = 0;
+
+        TST_EXP_FAIL(getcpu(tst_get_bad_addr(NULL), &node_id), EFAULT);
+        TST_EXP_FAIL(getcpu(&cpu_id, tst_get_bad_addr(NULL)), EFAULT);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+};
-- 
2.18.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
