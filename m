Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A43BAC433F5
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 10:05:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 18FD63CA09A
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 11:05:12 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 71F003CA09F
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 11:04:43 +0100 (CET)
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com
 [195.245.230.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 947241401278
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 11:04:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1645005877; i=@fujitsu.com;
 bh=CqAmQy18o/IiDEd3Pb9fJJw/vmwbmHPQbzlr3oBHvZU=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=elSIX/9PiMcrsw0kriaclFYh3zE/fDkb4sjdNW+O1DMh54GFr/m1PyhbhhVlQHBc+
 z1X1u3RfVYqdkH26MWivMKF17g1XTU6IqUTIZkMuiMF5uZ1MWTUNtKsTTUloZSzlBx
 XczxVJGwi9LvUqNj0Zm0BUu8Ss4dEdZwn9BizDm8h0jYIATjwgfrYo03QkH0ac1Xf1
 Vyk3lKl73zyoedR4L47hdPSM80f+uryhpqHY0GA3+zRNRTaNYScmM0U6gaBhgSaYPk
 9CWLgsJyMXy6sHj209jUQfjtz0GrbIxL/j87FNNsgYHY8dgyHkDskI1ycK48QPQ8wZ
 sFe2dEVxo1bkQ==
Received: from [100.115.7.114] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-4.bemta.az-a.eu-west-1.aws.ess.symcld.net id 0C/F6-12986-53CCC026;
 Wed, 16 Feb 2022 10:04:37 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRWlGSWpSXmKPExsViZ8ORqGt6hif
 J4PRpMYsV33cwOjB67Pu9jjWAMYo1My8pvyKBNWPyxS7Ggu1cFa+OzGJtYHzJ0cXIySEkcJZR
 YuFu8S5GLiB7J5PEt7mNzBDOHkaJpptTmECq2AQ0JZ51LmAGsUUEJCQ6Gt6yg9jMAuoSyyf9A
 qrh4BAWMJD4dUcUJMwioCpxa+cesFZeAQ+J0zuXsIHYEgIKElMevgcbwyngKdHc+4kV4ggPiX
 +XVrFC1AtKnJz5hAVivITEwRcvmCF6FSUudXxjhLArJGbNamOCsNUkrp7bxDyBUXAWkvZZSNo
 XMDKtYrRKKspMzyjJTczM0TU0MNA1NDTVNdU1MjLXS6zSTdRLLdUtTy0u0TXUSywv1kstLtYr
 rsxNzknRy0st2cQIDOGUYtbHOxjX9P3UO8QoycGkJMprtYonSYgvKT+lMiOxOCO+qDQntfgQo
 wwHh5IEb/5eoJxgUWp6akVaZg4wnmDSEhw8SiK80ieB0rzFBYm5xZnpEKlTjIpS4rw2p4ESAi
 CJjNI8uDZYDF9ilJUS5mVkYGAQ4ilILcrNLEGVf8UozsGoJMzrATKFJzOvBG76K6DFTECLFRu
 5QBaXJCKkpBqYFBZZRNx9/fxHY4+O8oU1hUqVs/9XqUstPsHrNuu29IXEtZc83bYmS+5ad1xZ
 T7zrRuN36boJtxy4OHvP3hNV2ijMtemeOaNJlnKj4j2TezPzFr8qmuZ9NSYp4vmSheF6TdyMj
 fcCvyqyVH27Pkl4ldG599eb2l5pLLtR9/rr/n/fjiT/3rlw4kVZZ8VXB4L5D9eVuXue2ViTfv
 hcnpdxrEH980mcDstlqlPlFWr0jiYJ2s3Istv0Ukrt9PlNC2TuCIgvFXuxcylH8v39wl4Chb/
 z5JanfL58fv/ER2etZabx5qQZpByY/Hz+E7VZMn7LgmoFYz5x3l681WN91jGJpXu1BfSLPPuu
 zW+v/OTwXomlOCPRUIu5qDgRAJXUDNhcAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-18.tower-585.messagelabs.com!1645005877!8764!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 2110 invoked from network); 16 Feb 2022 10:04:37 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-18.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 16 Feb 2022 10:04:37 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 94FD8100186
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 10:04:36 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 6BC26100195
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 10:04:36 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.28; Wed, 16 Feb 2022 10:04:31 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 16 Feb 2022 18:04:26 +0800
Message-ID: <1645005868-2373-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1645005868-2373-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1645005868-2373-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/5] pidfd_getfd.h: add fallback
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 configure.ac               |  1 +
 include/lapi/pidfd_getfd.h | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 include/lapi/pidfd_getfd.h

diff --git a/configure.ac b/configure.ac
index 8d2c5b1c4..49499704e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -115,6 +115,7 @@ AC_CHECK_FUNCS_ONCE([ \
     open_tree \
     openat \
     openat2 \
+    pidfd_getfd \
     pidfd_open \
     pidfd_send_signal \
     pkey_mprotect \
diff --git a/include/lapi/pidfd_getfd.h b/include/lapi/pidfd_getfd.h
new file mode 100644
index 000000000..1f488a518
--- /dev/null
+++ b/include/lapi/pidfd_getfd.h
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+#ifndef LAPI_PIDFD_GETFD_H__
+#define LAPI_PIDFD_GETFD_H__
+
+#include "lapi/syscalls.h"
+#include "config.h"
+
+static inline void pidfd_getfd_supported(void)
+{
+	/* allow the tests to fail early */
+	tst_syscall(__NR_pidfd_getfd);
+}
+
+#ifndef HAVE_PIDFD_GETFD
+static inline int pidfd_getfd(int pidfd, int targetfd, unsigned int flags)
+{
+	return tst_syscall(__NR_pidfd_getfd, pidfd, targetfd, flags);
+}
+#endif
+
+#endif /* LAPI_PIDFD_GETFD_H__ */
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
