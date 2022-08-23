Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D2AC32774
	for <ltp@archiver.kernel.org>; Tue, 23 Aug 2022 07:48:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A6C0B3CA317
	for <ltp@archiver.kernel.org>; Tue, 23 Aug 2022 09:48:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E76483C93EF
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 09:47:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 41F8310009F0
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 09:47:51 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B876F33FFF
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 07:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1661240869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ubTK+LPwb5MBNfdsmFVMD4syzJZ52L9YyGbYY2SXnbc=;
 b=ZtwvYrV769xl317ZfSshSFsYlqlcL4MX93G/oq3nkpAyh04Z/2Xnk+v2yXQKE8fClVKIck
 SeiZ9Vw0BUhi8BNqPq9XkCcGWlXJZS0Olnnug0p2AR8y1U7JpSED53K7Lu+iPpySOX2B2E
 sL7Tara/LmboLCT+dy8OWag9/FPrljg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1661240869;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ubTK+LPwb5MBNfdsmFVMD4syzJZ52L9YyGbYY2SXnbc=;
 b=EZA2IZTCoN/g9ibCrLo8GVaTBiqJEacAgJ/sMKYGp1rQYl4lqQNlCRShlCmTg+nBzUVB+L
 Sqlvm4ZUeNxLX4BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3854413AB7
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 07:47:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id lCniOiSGBGNGRAAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 07:47:48 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Tue, 23 Aug 2022 13:17:46 +0530
Message-Id: <20220823074746.28250-1-akumar@suse.de>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] setegid01.c: Rewrite using new LTP API
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
 testcases/kernel/syscalls/setegid/setegid01.c | 120 ++++--------------
 1 file changed, 25 insertions(+), 95 deletions(-)

diff --git a/testcases/kernel/syscalls/setegid/setegid01.c b/testcases/kernel/syscalls/setegid/setegid01.c
index 25d7519a6..2ed8c6e66 100644
--- a/testcases/kernel/syscalls/setegid/setegid01.c
+++ b/testcases/kernel/syscalls/setegid/setegid01.c
@@ -1,74 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Dan Kegel 2003
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
- * Test Name: setegid01
+/*\
+ * [Description]
  *
- * Test Description:
- *  Verify that setegid does not modify the saved gid or real gid.
+ * Verify that setegid() sets the effective user ID of the calling process
+ * correctly, and does not modify the saved gid and real gid.
  */
 
-#define _GNU_SOURCE 1
 #include <pwd.h>
-#include <sys/types.h>
-#include <stdio.h>
-#include <unistd.h>
-#include <errno.h>
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "setegid01";
-int TST_TOTAL = 1;
-static void setup(void);
-static void setegid_verify(void);
-static void cleanup(void);
+#include "tst_test.h"
 
 static gid_t nobody_gid;
 
-int main(int argc, char **argv)
-{
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		setegid_verify();
-	}
-
-	cleanup();
-	tst_exit();
-}
-
 static void setup(void)
 {
 	struct passwd *nobody;
 
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	nobody = SAFE_GETPWNAM(cleanup, "nobody");
-
+	nobody = SAFE_GETPWNAM("nobody");
 	nobody_gid = nobody->pw_gid;
 }
 
@@ -77,48 +29,26 @@ static void setegid_verify(void)
 	gid_t cur_rgid, cur_egid, cur_sgid;
 	gid_t orig_rgid, orig_egid, orig_sgid;
 
-	SAFE_GETRESGID(cleanup, &orig_rgid, &orig_egid, &orig_sgid);
-	tst_resm(TINFO, "getresgid reports rgid %d, egid %d, sgid %d",
-		 orig_rgid, orig_egid, orig_sgid);
-
-	tst_resm(TINFO, "calling setegid(nobody_gid %d)", nobody_gid);
-	SAFE_SETEGID(cleanup, nobody_gid);
+	SAFE_GETRESGID(&orig_rgid, &orig_egid, &orig_sgid);
+	tst_res(TINFO, "getresgid reports rgid %d, egid %d, sgid %d",
+			orig_rgid, orig_egid, orig_sgid);
 
-	SAFE_GETRESGID(cleanup, &cur_rgid, &cur_egid, &cur_sgid);
-	tst_resm(TINFO, "getresgid reports rgid %d, egid %d, sgid %d", cur_rgid,
-		 cur_egid, cur_sgid);
+	tst_res(TINFO, "calling setegid(nobody_gid %d)", nobody_gid);
+	SAFE_SETEGID(nobody_gid);
 
-	/* make sure it at least does what its name says */
-	if (nobody_gid != cur_egid) {
-		tst_resm(TFAIL, "setegid() failed to change the effective gid");
-		return;
-	}
+	SAFE_GETRESGID(&cur_rgid, &cur_egid, &cur_sgid);
+	tst_res(TINFO, "getresgid reports rgid %d, egid %d, sgid %d",
+			cur_rgid, cur_egid, cur_sgid);
 
-	/* SUSv3 says the real group ID and saved set-gid must
-	 * remain unchanged by setgid.  See
-	 * http://www.opengroup.org/onlinepubs/007904975/functions/setegid.html
-	 */
-	if (orig_sgid != cur_sgid) {
-		tst_resm(TFAIL, "setegid() changed the saved set-gid");
-		return;
-	}
-	if (orig_rgid != cur_rgid) {
-		tst_resm(TFAIL, "setegid() changed the real gid");
-		return;
-	}
+	TST_EXP_EQ_LU(nobody_gid, cur_egid);
+	TST_EXP_EQ_LU(orig_rgid, cur_rgid);
+	TST_EXP_EQ_LU(orig_sgid, cur_sgid);
 
-	SAFE_SETEGID(cleanup, orig_egid);
-
-	SAFE_GETRESGID(cleanup, &cur_rgid, &cur_egid, &orig_sgid);
-
-	if (orig_egid != cur_egid) {
-		tst_resm(TFAIL, "setegid() failed to reset effective gid back");
-		return;
-	}
-
-	tst_resm(TPASS, "setegid() passed functional test");
+	SAFE_SETEGID(orig_egid);
 }
 
-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = setegid_verify,
+	.needs_root = 1
+};
-- 
2.37.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
