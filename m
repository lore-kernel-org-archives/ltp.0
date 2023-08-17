Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82BA0C27C7A
	for <ltp@archiver.kernel.org>; Thu, 17 Aug 2023 08:47:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B03513CCBF9
	for <ltp@archiver.kernel.org>; Thu, 17 Aug 2023 10:47:41 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7072D3CB9A0
 for <ltp@lists.linux.it>; Thu, 17 Aug 2023 10:47:31 +0200 (CEST)
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com
 [139.138.61.253])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 67E911A00CC9
 for <ltp@lists.linux.it>; Thu, 17 Aug 2023 10:47:29 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="116491031"
X-IronPort-AV: E=Sophos;i="6.01,179,1684767600"; d="scan'208";a="116491031"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2023 17:47:26 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id C187ECA1E4
 for <ltp@lists.linux.it>; Thu, 17 Aug 2023 17:47:24 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id EE369BF4AF
 for <ltp@lists.linux.it>; Thu, 17 Aug 2023 17:47:23 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 7165220074739;
 Thu, 17 Aug 2023 17:47:23 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Thu, 17 Aug 2023 16:46:48 +0800
Message-Id: <1692262008-9126-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27818.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27818.005
X-TMASE-Result: 10--6.405000-10.000000
X-TMASE-MatchedRID: QAAr3LZ6Q9IxAROjHaAf26ncG1vVsfbQwTlc9CcHMZerwqxtE531VKQQ
 tsHSQRrXofT1xcfXENRvp+b/wK4TT1lDiuV7LjH+PKN38CLPK0H5UnqVnIHSz7s3Yh2IOCYzAu0
 C/xvh/SiBwOiAXd70LIQWsdcgJn9KNyl1nd9CIt0URSScn+QSXmVV1G+Ck2l7+gtHj7OwNO38o7
 Ys1NK4Y6vI7YG+kYGXoZxvxJ1NrvByucLWAAcCjEQvj8flU7Q4
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] write02: Simplify test using TST_ macros
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/write/write02.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/write/write02.c b/testcases/kernel/syscalls/write/write02.c
index 2f630ab65..ab38dce77 100644
--- a/testcases/kernel/syscalls/write/write02.c
+++ b/testcases/kernel/syscalls/write/write02.c
@@ -2,27 +2,24 @@
 /*
  * Copyright (c) 2017 Carlo Marcelo Arenas Belon <carlo@gmail.com>
  * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) Linux Test Project, 2003-2023
  */
-/*
+
+/*\
+ * [Description]
+ *
  * Tests for a special case NULL buffer with size 0 is expected to return 0.
  */
 
-#include <errno.h>
 #include "tst_test.h"
 
 static int fd;
 
 static void verify_write(void)
 {
-	TEST(write(fd, NULL, 0));
-
-	if (TST_RET != 0) {
-		tst_res(TFAIL | TTERRNO,
-			"write() should have succeeded with ret=0");
-		return;
-	}
+	TST_EXP_POSITIVE(write(fd, NULL, 0));
 
-	tst_res(TPASS, "write(fd, NULL, 0) == 0");
+	TST_EXP_EXPR(TST_RET == 0, "write(fd, NULL, %ld) == %d", TST_RET, 0);
 }
 
 static void setup(void)
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
