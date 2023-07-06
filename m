Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B65C1EB64DC
	for <ltp@archiver.kernel.org>; Thu,  6 Jul 2023 10:06:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 980A33CBED4
	for <ltp@archiver.kernel.org>; Thu,  6 Jul 2023 12:06:31 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 69F383CBEF1
 for <ltp@lists.linux.it>; Thu,  6 Jul 2023 12:06:13 +0200 (CEST)
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com
 [139.138.61.253])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AEFF61400431
 for <ltp@lists.linux.it>; Thu,  6 Jul 2023 12:06:11 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="111638019"
X-IronPort-AV: E=Sophos;i="6.01,185,1684767600"; d="scan'208";a="111638019"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2023 19:06:09 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com
 [192.168.83.65])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id D05BAC68E7
 for <ltp@lists.linux.it>; Thu,  6 Jul 2023 19:06:07 +0900 (JST)
Received: from aks-ab2.gw.nic.fujitsu.com (aks-ab2.gw.nic.fujitsu.com
 [192.51.207.12])
 by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 08DB1D5E97
 for <ltp@lists.linux.it>; Thu,  6 Jul 2023 19:06:07 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by aks-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id 08419887BD;
 Thu,  6 Jul 2023 19:06:05 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Thu,  6 Jul 2023 18:05:54 +0800
Message-Id: <1688637954-17765-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1688637954-17765-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1688637954-17765-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27734.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27734.005
X-TMASE-Result: 10-1.094000-10.000000
X-TMASE-MatchedRID: 8JSP0tnJJxehhjsqgSuNbxF4zyLyne+AVBDQSDMig9HEosIs7IJbkIh+
 mL+ciFCpbnRB47KLJ1QzLmfGY6iDkX5uUfhNvnKzOWUWxTQJdI8UZYubbUj2DLt4BAaULwAVJf5
 otvavOZf9vT5evMX4tJhCh8+WImJUkto8AKCDbo6lJdWkFL6KVjEvENg7dSUMUYkZd9+4t2+Gvc
 FsL4SEyESEioDlXSTvA9PO4OC4jbwR3RjJbq0tuZU7Bltw5qVLWvaFnGMIvOqUd3Z19F2OH6PFj
 JEFr+olwXCBO/GKkVqOhzOa6g8KrWn0RJhtzZ+7ponyDYwa4/D/gBNqDuYrN2U04iop5co3jOrV
 9g+tLk4DgTZ4Yn79BHaUo2f8H9JN2m8dSymhC+vLDSoEA6ZOhR0m4Rm5hspVxSSu8i52URmXTt0
 OuyJi/IIuEVM/dBEMBtjAKW7+qHc=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] syscalls/geteuid02: Convert into new api
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
 testcases/kernel/syscalls/geteuid/geteuid02.c | 89 +++++++--------------------
 1 file changed, 23 insertions(+), 66 deletions(-)

diff --git a/testcases/kernel/syscalls/geteuid/geteuid02.c b/testcases/kernel/syscalls/geteuid/geteuid02.c
index e00f812..00b42c3 100644
--- a/testcases/kernel/syscalls/geteuid/geteuid02.c
+++ b/testcases/kernel/syscalls/geteuid/geteuid02.c
@@ -1,79 +1,36 @@
+//SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2001
- *  Ported by Wayne Boyer
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
+ * Copyright (c) Linux Test Project, 2003-2023
+ * AUTHOR: Wayne Boyer
  */
 
-#include <pwd.h>
-#include <errno.h>
-
-#include "test.h"
-#include "compat_16.h"
-
-TCID_DEFINE(geteuid02);
-int TST_TOTAL = 1;
+/*\
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
-
-	setup();
+	long uid[4];
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
+	TST_EXP_POSITIVE(GETEUID(), "geteuid()");
 
-		TEST(GETEUID(cleanup));
+	if (!TST_PASS)
+		return;
 
-		if (TEST_RETURN == -1)
-			tst_brkm(TBROK | TTERRNO, cleanup, "geteuid* failed");
+	SAFE_FILE_LINES_SCANF("/proc/self/status", "Uid: %ld %ld %ld %ld",
+			      &uid[0], &uid[1], &uid[2], &uid[3]);
 
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
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-static void setup(void)
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
+	TST_EXP_EXPR(TST_RET == uid[1],
+		     "geteuid() ret %ld == /proc/self/status EUID: %ld",
+		     TST_RET, uid[1]);
 }
 
-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.test_all = verify_geteuid,
+};
-- 
1.8.3.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
