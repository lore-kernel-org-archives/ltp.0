Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C55FA3736
	for <ltp@archiver.kernel.org>; Fri, 13 Sep 2024 09:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1726220712; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=nuKtw+0oyyP3oEuUJ2YKBos090RBMMK5OkzoVIsTgv4=;
 b=k0edH4QWWcz838YoyP4b4gzNx3tuJ0o3orRZXMSPr779JMDJ7CaELtHf/2HovID9x+3Qm
 Q2HyUIpwIozH076w6sz+7pybbxdLlyjtFgeyLsIC+FODGx4F9pxH2QPu07Xe/26fkhNB74H
 4YF7XXwg+m6fF6GKFg0MDRsaPAILgtg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E86C3C27B5
	for <ltp@archiver.kernel.org>; Fri, 13 Sep 2024 11:45:12 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C5993C12A6
 for <ltp@lists.linux.it>; Fri, 13 Sep 2024 11:44:50 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.49;
 helo=esa3.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com
 [207.54.90.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 046B7140018A
 for <ltp@lists.linux.it>; Fri, 13 Sep 2024 11:44:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1726220690; x=1757756690;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=46olopAim0RMRvnwqEyompx698BgBjsUaYmOfVMIWoo=;
 b=ayzFnJebrtVv1L0lbVhnLTJ0vXyqGdIelIbGcWYtzAqhgtgvkz65Qi1Z
 VHccmp8r24TMy+Uk6JFzQZKdFLE86hJh3N9QH8EBeDu+bxBO7GzsBpEvc
 UCUYasYJJHznorbqugigz5OqIsusGkM7v4ImqSGvT3ejtfVoqDF/kuV7a
 XLHaNtVRZxV6QrjvUTazh0njQs1CdLMFoF2Bae4rBYcBjj5CMXIntMcc0
 lQ3pgqR94YsselllFrOYRn4FDNie5fn1sooFpuUNH907KXiJIGHkyJhkx
 Rre+C/95gMiQLxCl26jZVecz+aIeb4pEdjKdF6bzQ2+GR2fTL3mffXfNA g==;
X-CSE-ConnectionGUID: N69n1YtWRFGBdj84L7enFg==
X-CSE-MsgGUID: qyADMuEeRq6aFL401UY3LQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="173626461"
X-IronPort-AV: E=Sophos;i="6.10,225,1719846000"; d="scan'208";a="173626461"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Sep 2024 18:44:47 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 3746ED2AB6
 for <ltp@lists.linux.it>; Fri, 13 Sep 2024 18:44:45 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 7DBEDD4BE1
 for <ltp@lists.linux.it>; Fri, 13 Sep 2024 18:44:44 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 01A4F1EA73C
 for <ltp@lists.linux.it>; Fri, 13 Sep 2024 18:44:44 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 6B8D11A000B;
 Fri, 13 Sep 2024 17:44:43 +0800 (CST)
To: ltp@lists.linux.it
Date: Fri, 13 Sep 2024 17:46:15 +0800
Message-ID: <20240913094615.245573-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28660.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28660.006
X-TMASE-Result: 10--4.624900-10.000000
X-TMASE-MatchedRID: e52ZkoJcYPYB90FcL1q4MKzGfgakLdjaFIuBIWrdOeNrL/5mlYISizib
 ESY8R8hiQMOJEqjTDACHzK4exfm8m04GO5MhEQotqug9vIA2WODTAe9FsgbYx0z5vzLEGq8DvmK
 TdxbGqLLtTU/YlUxhz0lsuKDMyCG2816I8HMsK8xrzsINdopFUn2/mTu5B5RIvnhgJqkfm0Cyuh
 piqaRnaoDwwyz/PVRGjv0XK9b7bcU2uyAbjj7YRLrbxxduc6FPsK2kKj9eN58kt9BigJAcVqzDX
 pqeRKldmiLgWTVbD0+AMuqetGVetnyef22ep6XY4kYXbobxJbJtwx+p5fx653WzEpHA996i8CLr
 fOtL1DH5HM+8Y7cI7xXioKq0vKkcVMa0No5SFtmbJvuOlqsltlqzyEPA+iRVdl4q/z0pj+epHIo
 UsfrCmpsNEGpLafrrLM/nEDLP056e+TDiyH/49wxfkLAfkNNSaAZk0sEcY14=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] sched_getattr02: refactor with new LTP API
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
---
 .../syscalls/sched_getattr/sched_getattr02.c  | 95 +++++++------------
 1 file changed, 32 insertions(+), 63 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c b/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c
index 5efec2ff5..ded541083 100644
--- a/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c
+++ b/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c
@@ -1,43 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Huawei Technologies Co., Ltd., 2015
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
- * the GNU General Public License for more details.
+ * Copyright (c) Linux Test Project, 2015-2024
  */
 
- /* Description:
- *   Verify that:
- *              1) sched_getattr fails with unused pid
- *              2) sched_getattr fails with invalid address
- *              3) sched_getattr fails with invalid value
- *              4) sched_getattr fails with invalid flag
+/*\
+ * [Description]
+ *
+ * Verify that, sched_getattr(2) returns -1 and sets errno to
+ *
+ * 1. ESRCH if pid is unused.
+ * 2. EINVAL if address is NULL.
+ * 3. EINVAL if size is invalid.
+ * 4. EINVAL if flag is not zero.
  */
 
 #define _GNU_SOURCE
 
-#include <unistd.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <time.h>
-#include <linux/unistd.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <sys/syscall.h>
-#include <pthread.h>
 #include <errno.h>
+#include <string.h>
 
-#include "test.h"
+#include "tst_test.h"
 #include "lapi/sched.h"
 
-char *TCID = "sched_getattr02";
-
 static pid_t pid;
 static pid_t unused_pid;
 struct sched_attr attr_copy;
@@ -48,58 +33,42 @@ static struct test_case {
 	unsigned int size;
 	unsigned int flags;
 	int exp_errno;
-} test_cases[] = {
+} tcase[] = {
 	{&unused_pid, &attr_copy, sizeof(struct sched_attr), 0, ESRCH},
 	{&pid, NULL, sizeof(struct sched_attr), 0, EINVAL},
 	{&pid, &attr_copy, sizeof(struct sched_attr) - 1, 0, EINVAL},
 	{&pid, &attr_copy, sizeof(struct sched_attr), 1000, EINVAL}
 };
 
-static void setup(void);
-static void sched_getattr_verify(const struct test_case *test);
-
-int TST_TOTAL = ARRAY_SIZE(test_cases);
-
-static void sched_getattr_verify(const struct test_case *test)
+static void verify_sched_getattr(unsigned int n)
 {
-	TEST(sched_getattr(*(test->pid), test->a, test->size,
-			test->flags));
+	struct test_case *tc = tcase + n;
+
+	TEST(sched_getattr(*(tc->pid), tc->a, tc->size, tc->flags));
 
-	if (TEST_RETURN != -1) {
-		tst_resm(TFAIL, "sched_getattr() succeeded unexpectedly.");
+	if (TST_RET != -1) {
+		tst_res(TFAIL, "sched_getattr() succeeded unexpectedly.");
 		return;
 	}
 
-	if (TEST_ERRNO == test->exp_errno) {
-		tst_resm(TPASS | TTERRNO,
-			"sched_getattr() failed expectedly");
+	if (TST_ERR == tc->exp_errno) {
+		tst_res(TPASS | TTERRNO, "sched_getattr() failed expectedly");
 		return;
 	}
 
-	tst_resm(TFAIL | TTERRNO, "sched_getattr() failed unexpectedly "
+	tst_res(TFAIL | TTERRNO, "sched_getattr() failed unexpectedly "
 		": expected: %d - %s",
-		test->exp_errno, tst_strerrno(test->exp_errno));
+		tc->exp_errno, tst_strerrno(tc->exp_errno));
 }
 
-int main(int argc, char **argv)
+static void setup(void)
 {
-	int lc, i;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		for (i = 0; i < TST_TOTAL; i++)
-			sched_getattr_verify(&test_cases[i]);
-	}
-
-	tst_exit();
+	unused_pid = tst_get_unused_pid();
 }
 
-void setup(void)
-{
-	unused_pid = tst_get_unused_pid(setup);
-
-	TEST_PAUSE;
-}
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.test = verify_sched_getattr,
+	.tcnt = ARRAY_SIZE(tcase),
+	.setup = setup,
+};
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
