Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13ABCC83F32
	for <ltp@archiver.kernel.org>; Thu, 31 Aug 2023 10:43:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2650E3CEEB8
	for <ltp@archiver.kernel.org>; Thu, 31 Aug 2023 12:43:06 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4395A3CBF43
 for <ltp@lists.linux.it>; Thu, 31 Aug 2023 12:42:45 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 84367140042B
 for <ltp@lists.linux.it>; Thu, 31 Aug 2023 12:42:44 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C45921F854;
 Thu, 31 Aug 2023 10:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693478563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0NdYM86YsxycvyImygfa7Alq47I9Ickaz886pdKZzA8=;
 b=CZMcvtF36+MpQ46nks6aghIKsYnnC7QlkyFtLZUeGEeIgp4FRFKqbw92GOO9ADOAKzXdBH
 L7UBL/dEzfun6VijgCOxi5JPUU5jwyJMiQ6h4xCzxXBRYoxnNUepOshO9xP4/8eeZaCX76
 ICdvanB3JQDBoZmPGGcron2e7BG0+Ok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693478563;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0NdYM86YsxycvyImygfa7Alq47I9Ickaz886pdKZzA8=;
 b=vWmtB0+BAEq+els0Bh14axss6V9/vezZTaOVRrwLAvCEFll5mrPPqBWUBl26VZZwh9Ei86
 jcaD1i3P+ZqcWgCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ABD3413587;
 Thu, 31 Aug 2023 10:42:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QKrYKKNu8GQIQgAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Thu, 31 Aug 2023 10:42:43 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu, 31 Aug 2023 12:42:42 +0200
Message-Id: <20230831104242.27156-3-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230831104242.27156-1-andrea.cervesato@suse.de>
References: <20230831104242.27156-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 2/2] Refactor getegid02 using new LTP API
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/getegid/getegid02.c | 93 +++++--------------
 1 file changed, 21 insertions(+), 72 deletions(-)

diff --git a/testcases/kernel/syscalls/getegid/getegid02.c b/testcases/kernel/syscalls/getegid/getegid02.c
index 60f09501e..2f64bd869 100644
--- a/testcases/kernel/syscalls/getegid/getegid02.c
+++ b/testcases/kernel/syscalls/getegid/getegid02.c
@@ -1,90 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
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
+ * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+ *   William Roske, Dave Fenner
+ * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
-/*
- * Testcase to check the basic functionality of getegid().
+/*\
+ * [Description]
  *
- * For functionality test the return value from getegid() is compared to passwd
- * entry.
+ * This test checks if getegid() returns the same effective group given by
+ * passwd entry via getpwuid().
  */
 
 #include <pwd.h>
-#include <errno.h>
-
-#include "test.h"
-#include "compat_16.h"
 
-static void cleanup(void);
-static void setup(void);
+#include "tst_test.h"
+#include "compat_tst_16.h"
 
-TCID_DEFINE(getegid02);
-int TST_TOTAL = 1;
-
-int main(int ac, char **av)
+static void run(void)
 {
-	int lc;
 	uid_t euid;
+	gid_t egid;
 	struct passwd *pwent;
 
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		TEST(GETEGID(cleanup));
+	UID16_CHECK((euid = geteuid()), "geteuid");
 
-		if (TEST_RETURN < 0) {
-			tst_brkm(TBROK, cleanup, "This should never happen");
-		}
+	pwent = getpwuid(euid);
+	if (!pwent)
+		tst_brk(TBROK | TERRNO, "getpwuid() error");
 
-		euid = geteuid();
-		pwent = getpwuid(euid);
+	GID16_CHECK((egid = getegid()), "getegid");
 
-		if (pwent == NULL)
-			tst_brkm(TBROK, cleanup, "geteuid() returned "
-				 "unexpected value %d", euid);
-
-		GID16_CHECK(pwent->pw_gid, getegid, cleanup);
-
-		if (pwent->pw_gid != TEST_RETURN) {
-			tst_resm(TFAIL, "getegid() return value"
-				 " %ld unexpected - expected %d",
-				 TEST_RETURN, pwent->pw_gid);
-		} else {
-			tst_resm(TPASS,
-				 "effective group id %ld "
-				 "is correct", TEST_RETURN);
-		}
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
+	TST_EXP_EQ_LI(pwent->pw_gid, egid);
 }
 
-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.test_all = run,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
