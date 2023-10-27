Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3E2C25B47
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 10:20:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80CAA3CEBF2
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 12:20:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0029A3CCA83
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 12:19:40 +0200 (CEST)
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com
 [207.54.90.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 90F3E1A00906
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 12:19:40 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="137551059"
X-IronPort-AV: E=Sophos;i="6.03,255,1694703600"; d="scan'208";a="137551059"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2023 19:19:38 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 71925DDC75
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 19:19:35 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id A9CC6D8B96
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 19:19:34 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 4FEDD70B0D
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 19:19:34 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.220.121])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id DC24F1A0073;
 Fri, 27 Oct 2023 18:19:33 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Fri, 27 Oct 2023 05:38:00 -0400
Message-Id: <20231027093801.51947-2-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231027093801.51947-1-xuyang2018.jy@fujitsu.com>
References: <20231027093801.51947-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27960.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27960.006
X-TMASE-Result: 10--6.499000-10.000000
X-TMASE-MatchedRID: 9IrrHbNZyfoxAROjHaAf207nLUqYrlslFIuBIWrdOePfUZT83lbkEDav
 Mpat2LKSRVgGqcBDy4XD6kydICBLzzsr+6lvFGlyutvHF25zoU99LQinZ4QefCP/VFuTOXUTae6
 hIZpj4MuOhzOa6g8KrR0WrqeuyXg/7wErChJRa2FHWOgzJ0Ko+HjhIXehjZ9kz/+UHLqtCNk=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/3] umount02: Simplify test using TST_ macros
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
 testcases/kernel/syscalls/umount/umount02.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/testcases/kernel/syscalls/umount/umount02.c b/testcases/kernel/syscalls/umount/umount02.c
index 34a38c998..4aa999014 100644
--- a/testcases/kernel/syscalls/umount/umount02.c
+++ b/testcases/kernel/syscalls/umount/umount02.c
@@ -14,8 +14,6 @@
  * 5) ENAMETOOLONG if pathname was longer than MAXPATHLEN.
  */
 
-#include <errno.h>
-#include <string.h>
 #include <sys/mount.h>
 #include "tst_test.h"
 
@@ -41,21 +39,7 @@ static void verify_umount(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
 
-	TEST(umount(tc->mntpoint));
-
-	if (TST_RET != -1) {
-		tst_res(TFAIL, "umount() succeeds unexpectedly");
-		return;
-	}
-
-	if (tc->exp_errno != TST_ERR) {
-		tst_res(TFAIL | TTERRNO, "umount() should fail with %s",
-			tst_strerrno(tc->exp_errno));
-		return;
-	}
-
-	tst_res(TPASS | TTERRNO, "umount() fails as expected: %s",
-		tc->err_desc);
+	TST_EXP_FAIL(umount(tc->mntpoint), tc->exp_errno);
 }
 
 static void setup(void)
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
