Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF518C43334
	for <ltp@archiver.kernel.org>; Wed, 20 Jul 2022 07:18:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 634DC3C97C8
	for <ltp@archiver.kernel.org>; Wed, 20 Jul 2022 09:17:59 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0727F3C8CA9
 for <ltp@lists.linux.it>; Wed, 20 Jul 2022 09:17:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4D5806011B6
 for <ltp@lists.linux.it>; Wed, 20 Jul 2022 09:17:46 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 744523480C
 for <ltp@lists.linux.it>; Wed, 20 Jul 2022 07:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1658301466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=iuPRWy+t6n/xKIrtGneJApXN+4BhwHJhIBza+IvBz1s=;
 b=n7qFA/FaPgr6Ns4Eej9mj4zhuwf2jL/XHzKTGWhlCIDh4KF1OKayzCbzHKFxGHauLufcGH
 Ur0dGNUaBDXuhTumFM9D5m76V1/7QqjnLKraBuknWnCeQhgTt3/suE+4eR/bzoce5MZQbU
 IokB6Opcq7kAKAL6nUC17DWuPIeFr+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1658301466;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=iuPRWy+t6n/xKIrtGneJApXN+4BhwHJhIBza+IvBz1s=;
 b=PEq/DQM/lzS+w2ifNw2FPGV28i2xaU0iBtVVVkmcN1pusIE5nCASEqteWY6Omk5ERQbCxb
 jcwG5q7Mvz7P5YDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD87B13AA1
 for <ltp@lists.linux.it>; Wed, 20 Jul 2022 07:17:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4l3/JRms12KsUQAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Wed, 20 Jul 2022 07:17:45 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Wed, 20 Jul 2022 12:47:43 +0530
Message-Id: <20220720071743.28371-1-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] getitimer01.c: convert to new LTP API
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

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 .../kernel/syscalls/getitimer/getitimer01.c   | 90 ++++---------------
 1 file changed, 17 insertions(+), 73 deletions(-)

diff --git a/testcases/kernel/syscalls/getitimer/getitimer01.c b/testcases/kernel/syscalls/getitimer/getitimer01.c
index 9f6fc5e8f..e914f4c20 100644
--- a/testcases/kernel/syscalls/getitimer/getitimer01.c
+++ b/testcases/kernel/syscalls/getitimer/getitimer01.c
@@ -1,39 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2001
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
+ *	03/2001 - Written by Wayne Boyer
+ * Copyright (c) 2022 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
 
-/*
-  HISTORY
-    03/2001 - Written by Wayne Boyer
-
-  TEST ITEMS:
-    Check that a correct call to getitimer() succeeds.
-*/
-
-#include "test.h"
-
-#include <errno.h>
-#include <sys/time.h>
-
-static void cleanup(void);
-static void setup(void);
+/*\
+ * [Description]
+ *
+ * Check that a correct call to getitimer() succeeds.
+ */
 
-char *TCID = "getitimer01";
-int TST_TOTAL = 3;
+#include "tst_test.h"
 
 static int itimer_name[] = {
 	ITIMER_REAL,
@@ -41,52 +19,18 @@ static int itimer_name[] = {
 	ITIMER_PROF,
 };
 
-int main(int ac, char **av)
+static void run(void)
 {
-	int lc;
 	int i;
 	struct itimerval value;
 
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (i = 0; i < 3; i++) {
-
-			TEST(getitimer(itimer_name[i], &value));
-
-			if (TEST_RETURN != 0)
-				tst_resm(TFAIL, "call failed - errno = %d - %s",
-					 TEST_ERRNO, strerror(TEST_ERRNO));
-
-			/*
-			 * Since ITIMER is effectively disabled (we did
-			 * not set it before the getitimer call), the
-			 * elements in it_value should be zero.
-			 */
-			if ((value.it_value.tv_sec == 0) &&
-				(value.it_value.tv_usec == 0)) {
-				tst_resm(TPASS, "functionality is ok");
-			} else {
-				tst_resm(TFAIL, "timer are non zero");
-			}
-		}
+	for (i = 0; i < 3; i++) {
+		TST_EXP_PASS(getitimer(itimer_name[i], &value));
+		TST_EXP_EQ_LI(value.it_value.tv_sec, 0);
+		TST_EXP_EQ_LI(value.it_value.tv_usec, 0);
 	}
-
-	cleanup();
-	tst_exit();
-}
-
-static void setup(void)
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
 }
 
-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.test_all = run
+};
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
