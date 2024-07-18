Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DC1C3DA60
	for <ltp@archiver.kernel.org>; Thu, 18 Jul 2024 06:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1721285789; h=to : date :
 message-id : in-reply-to : references : subject : list-id :
 list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=F3sVfa46oR4YJqkzU+4+qrKU5ljNvqgthiH1sjSPyr0=;
 b=k0Dwz1/hP6yWo9Hst2Zm0IyhurYZ8ODg9rNGHZFfHZeMmoNgDvyW6TdhebIzYsDhG5nnF
 BhrvqAxSIc9Fy8lsxBUh9aG+6zdW9Ds5bFVVq2mI9mk9CRmCE5CEasK744Uj8Dd8n17inEG
 HI7rV/eP0piuvaIQeqdQxfPpFsmcn+o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC87D3D1AF8
	for <ltp@archiver.kernel.org>; Thu, 18 Jul 2024 08:56:29 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 578A93C221F
 for <ltp@lists.linux.it>; Thu, 18 Jul 2024 08:56:07 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.47;
 helo=esa1.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com
 [207.54.90.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C28351A00FD7
 for <ltp@lists.linux.it>; Thu, 18 Jul 2024 08:56:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1721285767; x=1752821767;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=SBX6Tu+moY+kBg8VFOgnmnzc9qhCRrHe+liWR24YAnk=;
 b=lH14rcpNLXWire/+V5AUxKMSZ0bf+VorHUREPhIkPexgh5K+yYBEQ26I
 GDCdOo9FtyfQhLKz9EiosuQEerPh86SlFxqwRjOMlznGBaABXMmPZRjjS
 OC3poN6eWjvbRxC+SIIG3bpTr4CXBEmYdFKGfitp+WE5l3kOTUtL84cVv
 xCD8fmABsfQbWV6yhk0ZKwvRIMFDG3hfbITajoRQNQk5P4TaDzoQSoZdr
 ddYwpawlMEc6dcwWG7AHuR3pogh3iTGZ4ElLoq/IMD1Laq9Xj7dkdwvOP
 KyyJxnS3FJ42eXyzXEfQwx/xyt3VP/5rlR0X4rgctITgjzjVoYlZbfapx g==;
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="167678978"
X-IronPort-AV: E=Sophos;i="6.09,217,1716217200"; d="scan'208";a="167678978"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 15:56:04 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 4130EC68E1
 for <ltp@lists.linux.it>; Thu, 18 Jul 2024 15:56:02 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8B9D4D97F4
 for <ltp@lists.linux.it>; Thu, 18 Jul 2024 15:56:01 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 16B496BB7D
 for <ltp@lists.linux.it>; Thu, 18 Jul 2024 15:56:01 +0900 (JST)
Received: from localhost (unknown [10.167.226.69])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id AD2681A000A;
 Thu, 18 Jul 2024 14:56:00 +0800 (CST)
To: ltp@lists.linux.it
Date: Thu, 18 Jul 2024 14:55:32 +0800
Message-Id: <20240718065532.20188-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <ZpfOqJaIO5mr__CW@rei>
References: <ZpfOqJaIO5mr__CW@rei>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28536.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28536.005
X-TMASE-Result: 10--12.429400-10.000000
X-TMASE-MatchedRID: 4RkzoBnX1FukSoeAfA+QP6oXHZz/dXlxBMdp5178zSNgPgeggVwCFnU3
 oKSu0J1xUh5maKIJAx/mn3xyPJAJoh2P280ZiGmRCtzGvPCy/m5SuvtBzlaEqFH3rkvzbWPM4Ib
 z3CH3vCeP9u+1+GFcS2+n5v/ArhNPWUOK5XsuMf7FVAV8vDjN/0i8rgutezVpnWFz7KRtHPr6sR
 z1g/tlo+LzNWBegCW2EKNtpnMeXG3aqT6lqWS9QsRB0bsfrpPIqxB32o9eGcm1ywT+7plDG9af3
 ns3TUaAMnEfuxvHV39J/HVeLtlfZM6C/xvBSwWu
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] getcpu: Add testcase for EFAULT
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
 testcases/kernel/syscalls/getcpu/getcpu02.c | 32 +++++++++++++++++++++
 3 files changed, 34 insertions(+)
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
index 000000000..81a8dd871
--- /dev/null
+++ b/testcases/kernel/syscalls/getcpu/getcpu02.c
@@ -0,0 +1,32 @@
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
+static void run(void)
+{
+	unsigned int cpu_id, node_id = 0;
+
+	TST_EXP_FAIL(getcpu(tst_get_bad_addr(NULL), &node_id), EFAULT);
+	TST_EXP_FAIL(getcpu(&cpu_id, tst_get_bad_addr(NULL)), EFAULT);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+};
-- 
2.18.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
