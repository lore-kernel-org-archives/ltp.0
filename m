Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CABCBC4332F
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 06:49:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E96843CAEB3
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 08:49:45 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 03F753CADF8
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 08:49:34 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E9C3D1000288
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 08:49:33 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1AC9222565
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 06:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1665557373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=E4atTkICN7sByTeig35F1oFQNx3CKpO7AXWDalO+LIA=;
 b=NVxKy9tTq+poPzWO+iKnaaNnp011QVn9YQbzYEJPw3SFofrL/rh2tMcVLe411NBhAyVXIm
 RmRPHtGt492LpmV0B3mncfhRiEilIHTKDBzF4MhO+EeUMX3EvQpCu3HxAD8gzq0J1W+OAH
 pOM7JeBINOC8gW/DFLaNcWZIm3ZeA+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1665557373;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=E4atTkICN7sByTeig35F1oFQNx3CKpO7AXWDalO+LIA=;
 b=Fgn5nWhyUMp+/J6mzgGYYK5CKykWiQlcPRM+smnqDQNp8ZCrG654BiqybxJSsVWwOsXQMz
 o7ocpC0X7uD/bhBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8136413A5C
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 06:49:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id lZyWEHxjRmNJLgAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 06:49:32 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Wed, 12 Oct 2022 12:19:29 +0530
Message-Id: <20221012064929.4725-1-akumar@suse.de>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] setfsgid01: Rewrite using new LTP API
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

Rewrite using new API and add test setfsgid(-1) which will always
fail but will determine if the preceding setfsgid() call changed
the filesystem group ID as expected.

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 .../kernel/syscalls/setfsgid/setfsgid01.c     | 97 ++++++-------------
 1 file changed, 29 insertions(+), 68 deletions(-)

diff --git a/testcases/kernel/syscalls/setfsgid/setfsgid01.c b/testcases/kernel/syscalls/setfsgid/setfsgid01.c
index 45d89c0cb..b97b21281 100644
--- a/testcases/kernel/syscalls/setfsgid/setfsgid01.c
+++ b/testcases/kernel/syscalls/setfsgid/setfsgid01.c
@@ -1,86 +1,47 @@
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
- * Testcase to check the basic functionality of setfsgid(2) system call.
+/*\
+ * [Description]
+ *
+ * Verify that setfsgid() correctly updates the filesystem group ID
+ * to the value given in fsgid argument.
  */
 
-#include <stdio.h>
-#include <unistd.h>
-#include <sys/fsuid.h>
-#include <sys/types.h>
-#include <errno.h>
-
-#include "test.h"
-#include "compat_16.h"
+#include <pwd.h>
 
-TCID_DEFINE(setfsgid01);
-int TST_TOTAL = 1;
+#include "tst_test.h"
+#include "compat_tst_16.h"
 
-static void setup(void);
-static void cleanup(void);
+static gid_t nobody_gid;
 
-int main(int ac, char **av)
+static void setup(void)
 {
-	int lc;
-
-	gid_t gid;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
+	struct passwd *nobody;
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		gid = getegid();
-		GID16_CHECK(gid, setfsgid, cleanup);
-
-		TEST(SETFSGID(cleanup, gid));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TTERRNO,
-				"setfsgid() failed unexpectedly");
-			continue;
-		}
-
-		if (TEST_RETURN != gid) {
-			tst_resm(TFAIL, "setfsgid() returned %ld, expected %d",
-				 TEST_RETURN, gid);
-		} else {
-			tst_resm(TPASS,
-				"setfsgid() returned expected value : %ld",
-				TEST_RETURN);
-		}
-	}
-
-	cleanup();
-	tst_exit();
+	nobody = SAFE_GETPWNAM("nobody");
+	nobody_gid = nobody->pw_gid;
 }
 
-static void setup(void)
+static void run(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	gid_t gid;
 
-	TEST_PAUSE;
-}
+	gid = getegid();
+	GID16_CHECK(gid, setfsgid);
 
-static void cleanup(void)
-{
+	SAFE_SETEUID(0);
+	TST_EXP_VAL(setfsgid(nobody_gid), gid);
+	TST_EXP_VAL(setfsgid(-1), nobody_gid);
+	TST_EXP_VAL_SILENT(setfsgid(gid), nobody_gid);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.needs_root = 1
+};
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
