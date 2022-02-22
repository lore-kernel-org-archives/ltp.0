Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E934C433F5
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 08:41:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 591EA3CA1A9
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 09:41:36 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5477A3CA18D
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 09:41:15 +0100 (CET)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CA7AB10007DA
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 09:41:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1645519273; i=@fujitsu.com;
 bh=fIaT/eKTpnBHr88cKeJHTkjKkbWbAl0pPok2gAWTtzw=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=MIf58W0OT9WAnEcje6Cjeu3U63kMN6tujfpDiTD5BTUy7WkSbI+xfi6D/gA5amyVv
 xLfW3GpGloH1J0ZWG/4vYzaXSG7v4A4QLbeguJQKf0rnWnLCyG8PrUUc9VIK4EF41E
 mhhMZyW+LhGcxG67ov4roLO24wSz2TOfQZcqtXu/dcp7NdZXemDQklipkOQ4hgHFRR
 RRZoxLMsUTp7yJoPoFR5pWZDWiha9GYQXtkt70xIFxWv3ZkW/TARFrcFO8FucilFWt
 aXjoXYOjPZm4gEhWrpTNPuzGwoBsa8+kcWttj0SzsQo5bVu1+Ix9y6jBed19fXSKE7
 SnqMPQx4c1cLw==
Received: from [100.115.7.206] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-a.eu-west-1.aws.ess.symcld.net id 3D/82-00700-9A1A4126;
 Tue, 22 Feb 2022 08:41:13 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRWlGSWpSXmKPExsViZ8ORqLtyoUi
 SwfN5chYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8aMNVsZCybyVezqnMjewNjJ08XIxSEkcJZR
 YlX/KbYuRk4gZyeTxNZbdhCJPYwSu5YdZQRJsAloSjzrXMAMYosISEh0NLxlB7GZBdQllk/6x
 QRiCwu4SmxY0wU2iEVAVWJOxyOgOAcHr4CHxJ+2WJCwhICCxJSH78HGcAp4SjyZd48ZYq+HxJ
 Njv8FsXgFBiZMzn7BAjJeQOPjiBTNEr6LEpY5vjBB2hcSsWW1MELaaxNVzm5gnMArOQtI+C0n
 7AkamVYxWSUWZ6RkluYmZObqGBga6hoamuoa6RobmeolVuol6qaW65anFJbqGeonlxXqpxcV6
 xZW5yTkpenmpJZsYgSGcUsx4cwdja99PvUOMkhxMSqK8X6eIJAnxJeWnVGYkFmfEF5XmpBYfY
 pTh4FCS4F06DygnWJSanlqRlpkDjCeYtAQHj5II75bZQGne4oLE3OLMdIjUKUZFKXFegQVACQ
 GQREZpHlwbLIYvMcpKCfMyMjAwCPEUpBblZpagyr9iFOdgVBLmDZsPNIUnM68EbvoroMVMQIu
 nZAmBLC5JREhJNTDtr+s4ZKxhfac+dWb36zQx66d31m1eF37qa1Ww/5Xpe/ViP/82vfSroY7r
 RWxoV+RHg0cSr3fol/gcXdP2RMbi6kb2qOfHFdKnHF1pW7qU6+iOheFcLy6eZ04/MVk6pvPV5
 kyRkIT38zm4Ljfn6jxwTX4y4+HM8xsjxSQviEr+e7q98EPhs9kLfj7Lf3lp0wpm65wTi1gEyv
 vvl019uPG8uY7i0f9Xl95L7J5oe1T30h0Du7eGvqYKWueXsT1UyhYW2KhwrXW75ZsL/ZWlnUs
 iG9tev03ri/9k8pn1R9zqN5/6/qoqfVOMb91VJ7ZdZzHvpex567ezpHJz/WaTOs2gsrWr4/2+
 xkdipnM672t8VGIpzkg01GIuKk4EAFVPjapcAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-8.tower-587.messagelabs.com!1645519273!8977!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 13753 invoked from network); 22 Feb 2022 08:41:13 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-8.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 22 Feb 2022 08:41:13 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 045D710019C
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 08:41:13 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id E9B7D10019A
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 08:41:12 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.28; Tue, 22 Feb 2022 08:41:06 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 22 Feb 2022 16:41:08 +0800
Message-ID: <1645519272-2733-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1645519272-2733-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1645519272-2733-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/7] lib/tst_safe_pidfd: Add SAFE_PIDFD_OPEN macro
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
 include/tst_safe_pidfd.h | 19 +++++++++++++++++++
 lib/tst_safe_pidfd.c     | 28 ++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)
 create mode 100644 include/tst_safe_pidfd.h
 create mode 100644 lib/tst_safe_pidfd.c

diff --git a/include/tst_safe_pidfd.h b/include/tst_safe_pidfd.h
new file mode 100644
index 000000000..5c37099bd
--- /dev/null
+++ b/include/tst_safe_pidfd.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+#ifndef TST_SAFE_PIDFD_H__
+#define TST_SAFE_PIDFD_H__
+
+#include <unistd.h>
+#include "lapi/pidfd.h"
+
+int safe_pidfd_open(const char *file, const int lineno, pid_t pid,
+		    unsigned int flags);
+
+#define SAFE_PIDFD_OPEN(pid, flags) \
+	safe_pidfd_open(__FILE__, __LINE__, (pid), (flags))
+
+#endif /* TST_SAFE_PIDFD_H__ */
diff --git a/lib/tst_safe_pidfd.c b/lib/tst_safe_pidfd.c
new file mode 100644
index 000000000..c9fe5e1d0
--- /dev/null
+++ b/lib/tst_safe_pidfd.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+#include "tst_safe_pidfd.h"
+
+int safe_pidfd_open(const char *file, const int lineno, pid_t pid,
+		    unsigned int flags)
+{
+	int rval;
+
+	rval = pidfd_open(pid, flags);
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			 "pidfd_open(%i, %i) failed", pid, flags);
+	} else if (rval < 0) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			  "Invalid pidfd_open(%i, %i) return value %d",
+			  pid, flags, rval);
+	}
+
+	return rval;
+}
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
