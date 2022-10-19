Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFCBC4332F
	for <ltp@archiver.kernel.org>; Wed, 19 Oct 2022 07:17:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4A6133CB0EE
	for <ltp@archiver.kernel.org>; Wed, 19 Oct 2022 09:17:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 819613CB0E5
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 09:17:12 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C38D1200B63
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 09:17:11 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A304622CBF
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 07:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666163829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Reo70exN0ohszAgIM7M0+8EXf860esIIZyAfBzB0DyY=;
 b=NcHADdUVoBripTUWlic3D5dHhgCxUd0tqsvmgVCGIlCO5rQ7RCQqykCRfQ9xtad9cvuZYm
 rFJOXEPbe2Sj5V0FBz2ZzFlVsYYdEViLlmMuhES65+QBR0f6e2b6Iy1/XVJ0lt3OzkZ2G2
 n75Ofe2A3LCOUbnDC/UbHRYmk7oACqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666163829;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Reo70exN0ohszAgIM7M0+8EXf860esIIZyAfBzB0DyY=;
 b=hQE8obuLLxwv1V976i0erVysHbo9PUmpWbeX2CCWU7A4EcNcYmbQyVE3sKUyh0pgDvqXf3
 4NnEL/vURxfm1yBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1EC9E13A36
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 07:17:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gF+rM3SkT2OeNgAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 07:17:08 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Wed, 19 Oct 2022 12:47:06 +0530
Message-Id: <20221019071706.25416-1-akumar@suse.de>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] setfsuid02: Rewrite using new LTP API
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

Rewrite using new API and add setfsuid(-1) call to verify that preceding
setfsuid() call with an invalid fsuid had failed.

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 .../kernel/syscalls/setfsuid/setfsuid02.c     | 96 ++++---------------
 1 file changed, 21 insertions(+), 75 deletions(-)

diff --git a/testcases/kernel/syscalls/setfsuid/setfsuid02.c b/testcases/kernel/syscalls/setfsuid/setfsuid02.c
index 5807bb6c0..84f9fb504 100644
--- a/testcases/kernel/syscalls/setfsuid/setfsuid02.c
+++ b/testcases/kernel/syscalls/setfsuid/setfsuid02.c
@@ -1,91 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) International Business Machines  Corp., 2001
  * Ported by Wayne Boyer
  * Adapted by Dustin Kirkland (k1rkland@us.ibm.com)
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
+ * Copyright (c) 2022 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
 
-/*
- * Testcase to test the basic functionality of the setfsuid(2) system
- * call to fail on invalid uid.
+/*\
+ * [Description]
+ *
+ * Verify that setfsuid() syscall fails if an invalid fsuid is given.
  */
 
-#include <stdio.h>
-#include <unistd.h>
 #include <pwd.h>
-#include <sys/types.h>
-#include <errno.h>
-
-#include "test.h"
-#include "compat_16.h"
+#include "tst_test.h"
+#include "compat_tst_16.h"
 
-static void setup(void);
-static void cleanup(void);
-
-TCID_DEFINE(setfsuid02);
-int TST_TOTAL = 1;
-
-int main(int ac, char **av)
+static void run(void)
 {
-	int lc;
-
-	uid_t uid;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
+	uid_t invalid_uid, current_uid;
 
-	uid = 1;
-	while (getpwuid(uid))
-		uid++;
+	current_uid = geteuid();
+	invalid_uid = 1;
+	while (getpwuid(invalid_uid))
+		invalid_uid++;
 
-	UID16_CHECK(uid, setfsuid, cleanup);
+	UID16_CHECK(invalid_uid, setfsuid);
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		TEST(SETFSUID(cleanup, uid));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TTERRNO,
-				"setfsuid() failed unexpectedly");
-			continue;
-		}
-
-		if (TEST_RETURN == uid) {
-			tst_resm(TFAIL, "setfsuid() returned %ld, expected %d",
-				 TEST_RETURN, uid);
-		} else {
-			tst_resm(TPASS, "setfsuid() returned expected value : "
-				 "%ld", TEST_RETURN);
-		}
-	}
-
-	cleanup();
-	tst_exit();
+	TST_EXP_VAL_SILENT(setfsuid(invalid_uid), current_uid);
+	TST_EXP_VAL(setfsuid(-1), current_uid,
+				"setfsuid(invalid_fsuid) test for expected failure:");
 }
 
-static void setup(void)
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-}
-
-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.test_all = run
+};
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
