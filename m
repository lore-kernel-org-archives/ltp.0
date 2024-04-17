Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212E8C4345F
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 09:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1713347986; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=++7RzSXpMFWpIr20IKebk7TroII82ikWBCBHz715vQ8=;
 b=DERdR9W/tCUg76+UyNebhAMcBtjiWBNjFc5DaOIC7Z7+ncQ8PLKWXQzBR52oFhiccyBv1
 cAHHTGtZ2K4kbjWr/nJJ76AbcOB8kIHgPRib0rmCeWGltqmh/ENw9YdypurnNgVz2NYk5p3
 aLJlLAsRFl/gSEJLrZuxx3VP9nkTwTA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 406CE3CFB5F
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 11:59:46 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD2053CFB09
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 11:59:24 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.48;
 helo=esa2.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com
 [207.54.90.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3F9CC1402E3B
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 11:59:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1713347963; x=1744883963;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=XwkJr5smi2n/nK4YDUPrvHgGhXhQVnoxggdfE0Fqgao=;
 b=V1dPdn57AJLqvz3+C1Gs1XFk788Qv6TE52S5gnrw16BUmgFiPhR9EgPP
 jfIMFgtWw/PQdpKB7dbpmmCyDq62CwZ5ItSm+4zzxwgwgveWuBxyM/4T+
 OpaHQjvF4fSuUHFMZfD/4DhsQPHizh8ikQv2l50xoSUVsnymytWcpHdfq
 ATae81K0M+XJ/Ee9mQBlHn55mAoTIBN4DV/D8zdIrSRNv4U6AKCjfAFF0
 ZJvWijIoIHoTKmj4eqAUJxbALLmmN8PJBvVRw4tV9lB6hmXiSK1t/fLla
 peMMtkErSB1na7urpu71mtruFb0ghyr2p/rGFriR+6evSDD2FeZ1ld1r4 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="155900781"
X-IronPort-AV: E=Sophos;i="6.07,208,1708354800"; d="scan'208";a="155900781"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2024 18:59:21 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id BB78B23226
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 18:59:18 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id EA9B0F6A1
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 18:59:17 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 724BB6BEE2
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 18:59:17 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 0ACA01A000A;
 Wed, 17 Apr 2024 17:59:16 +0800 (CST)
To: ltp@lists.linux.it
Date: Wed, 17 Apr 2024 05:25:06 -0400
Message-Id: <20240417092506.23625-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28326.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28326.006
X-TMASE-Result: 10--15.707900-10.000000
X-TMASE-MatchedRID: 4RK2gbhxGJNSuJfEWZSQfB1kSRHxj+Z5TJDl9FKHbrlgPgeggVwCFnU3
 oKSu0J1xUh5maKIJAx/mn3xyPJAJoimyf2R1E4xpGYJhRh6ssesfimmlcABuNyfJTn+dmnFQGmV
 udEhnpoS1/NE2jc9NGJzIetqw3Ni7ziy8MZTDuT2qh5pv1eDPz/lSepWcgdLPnt/M15zYPUNQVq
 ChHDgAleLzNWBegCW2wgn7iDBesS0gBwKKRHe+r+MxPxT8A/6PXhGiRaJ96jmW96+NJdBWeG6i5
 CTebBY+8FIg0ib4G2s=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] getrandom: Add negative tests for getrandom
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
From: Yang Xu via ltp <ltp@lists.linux.it>
Reply-To: Yang Xu <xuyang2018.jy@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add negative cases for getrandom(), when errno is EFAULT or EINVAL

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                              |  1 +
 .../kernel/syscalls/getrandom/.gitignore      |  1 +
 .../kernel/syscalls/getrandom/getrandom05.c   | 45 +++++++++++++++++++
 3 files changed, 47 insertions(+)
 create mode 100644 testcases/kernel/syscalls/getrandom/getrandom05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index cc1e39c05..62eb4c1cd 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -504,6 +504,7 @@ getrandom01 getrandom01
 getrandom02 getrandom02
 getrandom03 getrandom03
 getrandom04 getrandom04
+getrandom05 getrandom05
 
 getresgid01 getresgid01
 getresgid01_16 getresgid01_16
diff --git a/testcases/kernel/syscalls/getrandom/.gitignore b/testcases/kernel/syscalls/getrandom/.gitignore
index ef06ece9d..e47d8b3f4 100644
--- a/testcases/kernel/syscalls/getrandom/.gitignore
+++ b/testcases/kernel/syscalls/getrandom/.gitignore
@@ -2,3 +2,4 @@
 /getrandom02
 /getrandom03
 /getrandom04
+/getrandom05
diff --git a/testcases/kernel/syscalls/getrandom/getrandom05.c b/testcases/kernel/syscalls/getrandom/getrandom05.c
new file mode 100644
index 000000000..1a9614330
--- /dev/null
+++ b/testcases/kernel/syscalls/getrandom/getrandom05.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that getrandom(2) fails with
+ *
+ * - EFAULT when buf address is outside the accessible address space
+ * - EINVAL when flag is invalid
+ */
+
+#include <sys/random.h>
+#include "tst_test.h"
+
+static char buff_efault[64];
+static char buff_einval[64];
+
+static struct test_case_t {
+	char *buff;
+	size_t size;
+	unsigned int flag;
+	int expected_errno;
+	char *desc;
+} tcases[] = {
+	{(void *)-1, sizeof(buff_efault), 0, EFAULT,
+		"buf address is outside the accessible address space"},
+	{buff_einval, sizeof(buff_einval), -1, EINVAL, "flag is invalid"},
+};
+
+static void verify_getrandom(unsigned int i)
+{
+	struct test_case_t *tc = &tcases[i];
+
+	TST_EXP_FAIL2(getrandom(tc->buff, tc->size, tc->flag),
+		tc->expected_errno, "%s", tc->desc);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_getrandom,
+};
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
