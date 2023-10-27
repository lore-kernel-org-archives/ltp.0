Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F2FC25B47
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 10:20:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F14773CEB8F
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 12:20:12 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 506C03CCA83
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 12:19:41 +0200 (CEST)
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com
 [139.138.36.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A1895601026
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 12:19:39 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="125437518"
X-IronPort-AV: E=Sophos;i="6.03,255,1694703600"; d="scan'208";a="125437518"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2023 19:19:37 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id C7470DDC7D
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 19:19:35 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 14020BF4B1
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 19:19:35 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id A88026CB0B
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 19:19:34 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.220.121])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 3EFC61A0070;
 Fri, 27 Oct 2023 18:19:34 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Fri, 27 Oct 2023 05:38:01 -0400
Message-Id: <20231027093801.51947-3-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231027093801.51947-1-xuyang2018.jy@fujitsu.com>
References: <20231027093801.51947-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27960.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27960.006
X-TMASE-Result: 10--8.170000-10.000000
X-TMASE-MatchedRID: m5YRaeAMZa4xAROjHaAf207nLUqYrlslFIuBIWrdOeOjEIt+uIPPOAm5
 8KT4o411+xFlvZshf1bFLqTgoGRsK/85GCR7+Gth0AOtsg+VNceZIt4iAQN6P6DAhpB4cBl/o8W
 MkQWv6iV3LAytsQR4e1cppCzPq+1UOwBXM346/+xvN1hhpyDB4Wjt2br7QknGIrjNiB1jtrUpS7
 ojNbYTzo+6MMrYnLaL
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/3] umount03: Simplify test using TST_ macros
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

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/umount/umount03.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/testcases/kernel/syscalls/umount/umount03.c b/testcases/kernel/syscalls/umount/umount03.c
index 1cef06fa1..3dd222d9f 100644
--- a/testcases/kernel/syscalls/umount/umount03.c
+++ b/testcases/kernel/syscalls/umount/umount03.c
@@ -7,11 +7,8 @@
  * is not the super-user.
  */
 
-#include <errno.h>
 #include <pwd.h>
 #include <sys/mount.h>
-#include <sys/types.h>
-#include <unistd.h>
 #include "tst_test.h"
 
 #define MNTPOINT	"mntpoint"
@@ -20,19 +17,7 @@ static int mount_flag;
 
 static void verify_umount(void)
 {
-	TEST(umount(MNTPOINT));
-
-	if (TST_RET != -1) {
-		tst_res(TFAIL, "umount() succeeds unexpectedly");
-		return;
-	}
-
-	if (TST_ERR != EPERM) {
-		tst_res(TFAIL | TTERRNO, "umount() should fail with EPERM");
-		return;
-	}
-
-	tst_res(TPASS | TTERRNO, "umount() fails as expected");
+	TST_EXP_FAIL(umount(MNTPOINT), EPERM);
 }
 
 static void setup(void)
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
