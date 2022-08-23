Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3426C32772
	for <ltp@archiver.kernel.org>; Tue, 23 Aug 2022 14:52:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 054183CA38E
	for <ltp@archiver.kernel.org>; Tue, 23 Aug 2022 16:52:27 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 36D113C9882
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 16:52:18 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 57AB1600667
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 16:52:17 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AA4CB336D3
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 14:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1661266336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eZaRQ/ybVAcsGmP8OTL9ASOdjGiZUChlZHwT/yl9x6Y=;
 b=vwkqCy29Vyhg6eDS7ijKwL2SdPpZuZIMI+35b401rwk8lvLDu3zV1pnd0s4rtCjU1QrgMV
 KdY+DFXqFoiurO5oF9TKrz7p8mad3lgjqJIUXSTcTQsX6QF4NQOA2dMxI0KoWnGZ6QsWCH
 Eol4weZdUuk5pipmW3PoVqcFYMztZCs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1661266336;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eZaRQ/ybVAcsGmP8OTL9ASOdjGiZUChlZHwT/yl9x6Y=;
 b=WobDtp84EDLwwwLY7zxna2NW0djRkjWz3PD7M6WSAqIdtnxWdY0hasR3RnVXytvBfFBHOq
 UlSsI8vMWwerkoCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2BD1713AB7
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 14:52:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PVLIN5/pBGMzDQAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 14:52:15 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Tue, 23 Aug 2022 20:22:13 +0530
Message-Id: <20220823145213.24375-1-akumar@suse.de>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] setfsuid01.c: Rewrite using new LTP API
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

Rewrite with new API and add test to verify that filesystem user ID was
correctly updated by calling setfsuid(-1) which will always fail but
will return the previous filesystem user ID.

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 .../kernel/syscalls/setfsuid/setfsuid01.c     | 96 ++++++-------------
 1 file changed, 27 insertions(+), 69 deletions(-)

diff --git a/testcases/kernel/syscalls/setfsuid/setfsuid01.c b/testcases/kernel/syscalls/setfsuid/setfsuid01.c
index 63f9f5dd8..0cbf101ee 100644
--- a/testcases/kernel/syscalls/setfsuid/setfsuid01.c
+++ b/testcases/kernel/syscalls/setfsuid/setfsuid01.c
@@ -1,87 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2001
  * Ported by Wayne Boyer
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
- * Testcase to test the basic functionality of the setfsuid(2) system call.
+/*\
+ * [Description]
+ *
+ * Verify that setfsuid() correctly updates the filesystem user ID
+ * to the value given in fsuid argument.
  */
 
-#include <sys/types.h>
-#include <sys/fsuid.h>
-#include <stdio.h>
-#include <unistd.h>
-#include <errno.h>
+#include <pwd.h>
+#include "tst_test.h"
+#include "compat_tst_16.h"
 
-#include "test.h"
-#include "compat_16.h"
+static uid_t nobody_uid;
 
-static void setup(void);
-static void cleanup(void);
+static void setup(void)
+{
+	struct passwd *nobody;
 
-TCID_DEFINE(setfsuid01);
-int TST_TOTAL = 1;
+	nobody = SAFE_GETPWNAM("nobody");
+	nobody_uid = nobody->pw_uid;
+}
 
-int main(int ac, char **av)
+static void run(void)
 {
-	int lc;
-
 	uid_t uid;
 
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
 	uid = geteuid();
-	UID16_CHECK(uid, setfsuid, cleanup);
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+	UID16_CHECK(uid, setfsuid);
 
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
-		if (TEST_RETURN != uid) {
-			tst_resm(TFAIL, "setfsuid() returned %ld, expected %d",
-				 TEST_RETURN, uid);
-		} else {
-			tst_resm(TPASS,
-				"setfsuid() returned expected value : %ld",
-				TEST_RETURN);
-		}
-	}
-
-	cleanup();
-	tst_exit();
+	SAFE_SETEUID(0);
+	TST_EXP_VAL(setfsuid(nobody_uid), uid, "setfsuid(%d)", nobody_uid);
+	TST_EXP_VAL(setfsuid(-1), nobody_uid);
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
+	.setup = setup,
+	.test_all = run,
+	.needs_root = 1
+};
-- 
2.37.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
