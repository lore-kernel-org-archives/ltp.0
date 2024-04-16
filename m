Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71202C4345F
	for <ltp@archiver.kernel.org>; Tue, 16 Apr 2024 08:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1713256766; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=cQA6jnzdz4zDcfcdzaiYKGyLYs32nb4TCu3O6If5m48=;
 b=diA4ZqbgQ/KdQ1It5b1CZCvnt/TfYcvdqTf5fSXy6cBtK1TlDCVrMrIpMTyrh6qZ0Vzf5
 PisTSVdA8TRE6dc5Z3yVsjhqFTrWN7wJORuMn9GdnUIyZCu2XkhX+8ZO1YJWOdSB3Q1BIHp
 uJGzi6/mqCtVpoQUO81h5bcGEv+Vw3g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB3D23CFAA3
	for <ltp@archiver.kernel.org>; Tue, 16 Apr 2024 10:39:25 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DF1443CFA82
 for <ltp@lists.linux.it>; Tue, 16 Apr 2024 10:39:05 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.61.253;
 helo=esa8.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com
 [139.138.61.253])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4865960029A
 for <ltp@lists.linux.it>; Tue, 16 Apr 2024 10:39:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1713256745; x=1744792745;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=XJr9zoG4AQoVYtbG8rA7FTEFRDKhJ7N+28GXN/pzKAU=;
 b=gUnxeVZYXzVGw2tEuUfI+xfsz84JdhPgqgnbce+2GanNEUPjSBxqcVpp
 TCeEXChkUuWstYEkUzkmuMNCX5ibbYHQrzpPYJakG9rCQmv89zaEi/hDl
 OOn2kEaK/KuJYV4uePsZi5ihjCSvwmU80lzONtsH21D2rwBJfe6lvhjSO
 Ks0rLWYMeh71Iw6Jn9Cb7FL7Y7qYxJLtZSwKj0OJh/7V3edqWH6VDbvB8
 hmeFcbAZMCZ2icAmoSBgw//EWOPMQp8B7+bI5HamCgb5xMe63RS6GrZ6h
 0kRanvj0LYNUNtdujmrk/g6z8NqAP2buZ6FskawKc8M+ISLrJ8dJB3pez w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="143708923"
X-IronPort-AV: E=Sophos;i="6.07,205,1708354800"; d="scan'208";a="143708923"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2024 17:39:02 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id A5F59C2261
 for <ltp@lists.linux.it>; Tue, 16 Apr 2024 17:39:00 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id CEDB3BDC8A
 for <ltp@lists.linux.it>; Tue, 16 Apr 2024 17:38:59 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 717486B5ED
 for <ltp@lists.linux.it>; Tue, 16 Apr 2024 17:38:59 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 213281A000A;
 Tue, 16 Apr 2024 16:38:59 +0800 (CST)
To: ltp@lists.linux.it
Date: Tue, 16 Apr 2024 04:04:48 -0400
Message-Id: <20240416080448.22650-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28324.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28324.006
X-TMASE-Result: 10--16.373900-10.000000
X-TMASE-MatchedRID: 2wfub8HDRfNSuJfEWZSQfB1kSRHxj+Z5TJDl9FKHbrlgPgeggVwCFnU3
 oKSu0J1xUh5maKIJAx/mn3xyPJAJoimyf2R1E4xpGYJhRh6ssesfimmlcABuNyfJTn+dmnFQGmV
 udEhnpoS1/NE2jc9NGJzIetqw3Ni7ziy8MZTDuT2qh5pv1eDPz/lSepWcgdLPnt/M15zYPUO0x0
 bNkCWz1poi4Fk1Ww9PgDLqnrRlXrZ8nn9tnqel2JBlLa6MK1y4
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] getrandom: Add negative tests for getrandom
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
 .../kernel/syscalls/getrandom/getrandom05.c   | 46 +++++++++++++++++++
 3 files changed, 48 insertions(+)
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
index 000000000..a50228d3d
--- /dev/null
+++ b/testcases/kernel/syscalls/getrandom/getrandom05.c
@@ -0,0 +1,46 @@
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
+	{NULL, sizeof(buff_efault), 0, EFAULT,
+		"buf address is outside the accessible address space"},
+	{buff_einval, sizeof(buff_einval), -1, EINVAL, "flag is invalid"},
+};
+
+static void verify_getrandom(unsigned int i)
+{
+	struct test_case_t *tc = &tcases[i];
+
+	TST_EXP_FAIL(getrandom(tc->buff, tc->size, tc->flag),
+		tc->expected_errno, "%s", tc->desc);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_getrandom,
+	.needs_root = 1,
+};
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
