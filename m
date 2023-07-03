Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97747EB64D9
	for <ltp@archiver.kernel.org>; Mon,  3 Jul 2023 02:41:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A902C3CE0A5
	for <ltp@archiver.kernel.org>; Mon,  3 Jul 2023 04:41:19 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F06B93CD18C
 for <ltp@lists.linux.it>; Mon,  3 Jul 2023 04:40:59 +0200 (CEST)
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com
 [139.138.36.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4DE0F600152
 for <ltp@lists.linux.it>; Mon,  3 Jul 2023 04:40:59 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="110860457"
X-IronPort-AV: E=Sophos;i="6.01,177,1684767600"; d="scan'208";a="110860457"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2023 11:40:58 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 3BDFFC53CA
 for <ltp@lists.linux.it>; Mon,  3 Jul 2023 11:40:56 +0900 (JST)
Received: from aks-ab2.gw.nic.fujitsu.com (aks-ab2.gw.nic.fujitsu.com
 [192.51.207.12])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 58846D4F62
 for <ltp@lists.linux.it>; Mon,  3 Jul 2023 11:40:55 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by aks-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id EDF0B86D09;
 Mon,  3 Jul 2023 11:40:53 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Mon,  3 Jul 2023 10:40:41 +0800
Message-Id: <1688352041-4945-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1688352041-4945-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1688352041-4945-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27728.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27728.003
X-TMASE-Result: 10--1.110000-10.000000
X-TMASE-MatchedRID: uWxJDmPsnWGhhjsqgSuNbxF4zyLyne+AVBDQSDMig9HEosIs7IJbkIh+
 mL+ciFCpbnRB47KLJ1QzLmfGY6iDkX5uUfhNvnKzOWUWxTQJdI8UZYubbUj2DLt4BAaULwAVJf5
 otvavOZf9vT5evMX4tJhCh8+WImJUGTqvujVODuXX3j/lf1V8LARryDXHx6oXPM1GpA31IisRRL
 fe6UPgvJIDpnANBdZHE9PhZaJeNjNaoFFRAKWvJoXQ/hu1OV/0TPe1tPWSpl2bKItl61J/yZ+in
 TK0bC9eKrauXd3MZDW5M9qCNoUJrIvLnnSWiWPKlnwAnLIenORg46uJuUL8y4RRmBRDEGYSqYhW
 L9E63K/zJcz3OM2q/vK8yplexztMF7tY1R8q3waOIN/Y0IxYTVPJnXL2yNYdkuo847l05tDEzMy
 Amsz+FHoWLWlXcsZv
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] syscalls/geteuid02: Convert into new api
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
 testcases/kernel/syscalls/geteuid/geteuid02.c | 88 ++++++++-------------------
 1 file changed, 24 insertions(+), 64 deletions(-)

diff --git a/testcases/kernel/syscalls/geteuid/geteuid02.c b/testcases/kernel/syscalls/geteuid/geteuid02.c
index e00f812..cd71ebe 100644
--- a/testcases/kernel/syscalls/geteuid/geteuid02.c
+++ b/testcases/kernel/syscalls/geteuid/geteuid02.c
@@ -1,79 +1,39 @@
+//SPDX-Lincense-Identifier:GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2001
  *  Ported by Wayne Boyer
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
-#include <pwd.h>
-#include <errno.h>
-
-#include "test.h"
-#include "compat_16.h"
-
-TCID_DEFINE(geteuid02);
-int TST_TOTAL = 1;
+/*
+ *[Description]
+ *
+ * Check that geteuid() return value matches value from /proc/self/status.
+ */
 
-static void setup(void);
-static void cleanup(void);
+#include "tst_test.h"
+#include "compat_tst_16.h"
 
-int main(int ac, char **av)
+static void verify_geteuid(void)
 {
-	struct passwd *pwent;
-	int lc;
-	uid_t uid;
-
-	tst_parse_opts(ac, av, NULL, NULL);
+	long uid[4];
 
-	setup();
+	TST_EXP_POSITIVE(GETEUID(),"geteuid");
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
+	if(!TST_PASS)
+		return;
 
-		TEST(GETEUID(cleanup));
+	SAFE_FILE_LINES_SCANF("/proc/self/status","Uid: %ld %ld %ld %ld",&uid[0],&uid[1],&uid[2],&uid[3]);
 
-		if (TEST_RETURN == -1)
-			tst_brkm(TBROK | TTERRNO, cleanup, "geteuid* failed");
-
-		uid = geteuid();
-		pwent = getpwuid(uid);
-
-		if (pwent == NULL)
-			tst_resm(TFAIL | TERRNO, "getpwuid failed");
-
-		UID16_CHECK(pwent->pw_uid, geteuid, cleanup);
-		if (pwent->pw_uid != TEST_RETURN)
-			tst_resm(TFAIL, "getpwuid value, %d, "
-				 "does not match geteuid "
-				 "value, %ld", pwent->pw_uid,
-				 TEST_RETURN);
-		else
-			tst_resm(TPASS, "values from geteuid "
-				 "and getpwuid match");
+	if(TST_RET != uid[1]){
+		tst_res(TFAIL,
+			"geteuid() ret %ld != /proc/self/status Euid: %ld",
+			TST_RET,uid[1]);
+	}else{
+		tst_res(TPASS,
+			"geteuid() ret == /proc/self/status Euid: %ld",uid[1]);
 	}
-
-	cleanup();
-	tst_exit();
 }
 
-static void setup(void)
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
-}
-
-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.test_all = verify_geteuid
+};
-- 
1.8.3.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
