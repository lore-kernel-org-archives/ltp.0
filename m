Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B17C433F5
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 03:53:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D1B33C8C62
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 04:53:55 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A382E3C0D0B
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 04:53:45 +0100 (CET)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 797F51A00716
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 04:53:41 +0100 (CET)
Received: from dggeml753-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HyCtG1FTgzbhxr
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 11:48:38 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 dggeml753-chm.china.huawei.com (10.1.199.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Mon, 22 Nov 2021 11:53:36 +0800
To: <ltp@lists.linux.it>
Date: Mon, 22 Nov 2021 11:54:53 +0800
Message-ID: <20211122035453.248702-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeml753-chm.china.huawei.com (10.1.199.152)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib/default_cleanup: add default_cleanup() for old
 testcases
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

In some old testcases, cleanup() will not run since it exit
form tst_brk. For example, because of the calling of ltp_syscall
have no real cleanup when syscall not support, testcase ssetmask01
will leave tmp file.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 include/old/test.h    |  2 ++
 lib/default_cleanup.c | 11 +++++++++++
 2 files changed, 13 insertions(+)
 create mode 100644 lib/default_cleanup.c

diff --git a/include/old/test.h b/include/old/test.h
index 2ae7dba71..752c9628d 100644
--- a/include/old/test.h
+++ b/include/old/test.h
@@ -218,4 +218,6 @@ const char *tst_strerrno(int err);
 #endif
 #define TCID_DEFINE(ID) char *TCID = (#ID TCID_BIT_SUFFIX)

+void __attribute__((destructor)) default_cleanup(void);
+
 #endif	/* __TEST_H__ */
diff --git a/lib/default_cleanup.c b/lib/default_cleanup.c
new file mode 100644
index 000000000..fca394a04
--- /dev/null
+++ b/lib/default_cleanup.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 Zhao gongyi <zhaogongyi@huawei.com>
+ */
+
+#include "test.h"
+
+void __attribute__((destructor)) default_cleanup(void)
+{
+	tst_rmdir();
+}
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
