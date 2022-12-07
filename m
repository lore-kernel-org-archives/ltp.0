Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9761CC4708E
	for <ltp@archiver.kernel.org>; Wed,  7 Dec 2022 15:53:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 876783CC147
	for <ltp@archiver.kernel.org>; Wed,  7 Dec 2022 16:53:23 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 166C03CC112
 for <ltp@lists.linux.it>; Wed,  7 Dec 2022 16:53:12 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 309341A00812
 for <ltp@lists.linux.it>; Wed,  7 Dec 2022 16:53:11 +0100 (CET)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5D11D21F0C
 for <ltp@lists.linux.it>; Wed,  7 Dec 2022 15:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1670428391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mUcnkFY1/JbKuHbxSmpd3u7X0cNCNr2iAI1Hv/Kzcj8=;
 b=t8VoBSwW1doBSCU+lwGa2K1x476IzP0qp1VstwEKqiODfu69kVEynEFzlPGM+sqNgdmtVq
 s+b/39979V2ZNSRDnEVKoTa+dab3z16aUxIyCwvkVg6+f+2+nwWLQODVFan1IjXGILmbPA
 Ue3aDPwRFC1nMMhGPS0R20JEDPUqVFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1670428391;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mUcnkFY1/JbKuHbxSmpd3u7X0cNCNr2iAI1Hv/Kzcj8=;
 b=sShWR2VZ38ghcuS+QICVTYyP8mFE7K4o+uxt47TC/nNwExpEWg0KKpiS9/CJ9Zq0+DS8zW
 bvvl1Dc0ZI/CUeCg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id CEEE3136B4
 for <ltp@lists.linux.it>; Wed,  7 Dec 2022 15:53:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id SO2WI+a2kGMyQQAAGKfGzw
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Wed, 07 Dec 2022 15:53:10 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Wed,  7 Dec 2022 21:23:07 +0530
Message-Id: <20221207155307.13118-1-akumar@suse.de>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] setresuid05.c: Rewrite using new LTP API
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
 .../kernel/syscalls/setresuid/setresuid05.c   | 107 +++++-------------
 1 file changed, 26 insertions(+), 81 deletions(-)

diff --git a/testcases/kernel/syscalls/setresuid/setresuid05.c b/testcases/kernel/syscalls/setresuid/setresuid05.c
index c00d07b19..efdcbd18f 100644
--- a/testcases/kernel/syscalls/setresuid/setresuid05.c
+++ b/testcases/kernel/syscalls/setresuid/setresuid05.c
@@ -1,104 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2014 Fujitsu Ltd.
  * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-/*
- * Test Description:
- *  Verify that,
- *	File system UID is always set to the same value as the (possibly new)
- *	effective UID.
+ * Copyright (c) 2022 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
 
-#define _GNU_SOURCE
+/*\
+ * [Description]
+ *
+ * Verify that after updating euid with setresuid(), any file creation
+ * also gets the new euid as its owner user ID.
+ */
 
-#include <errno.h>
-#include <unistd.h>
 #include <pwd.h>
 #include <sys/stat.h>
-#include "test.h"
-#include "safe_macros.h"
-#include "compat_16.h"
+#include "tst_test.h"
+#include "compat_tst_16.h"
 
-TCID_DEFINE(setresuid05);
-int TST_TOTAL = 1;
+#define TEMP_FILE	"testfile"
 static struct passwd *ltpuser;
-static void setup(void);
-static void setresuid_verify(void);
-static void cleanup(void);
-
-int main(int argc, char **argv)
-{
-	int i, lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		for (i = 0; i < TST_TOTAL; i++)
-			setresuid_verify();
-	}
-
-	cleanup();
-	tst_exit();
-}
 
 static void setup(void)
 {
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
-
-	UID16_CHECK(ltpuser->pw_uid, "setresuid", cleanup)
+	ltpuser = SAFE_GETPWNAM("nobody");
+	UID16_CHECK(ltpuser->pw_uid, "setresuid");
 }
 
-static void setresuid_verify(void)
+static void run(void)
 {
 	struct stat buf;
 
-	TEST(SETRESUID(cleanup, -1, ltpuser->pw_uid, -1));
-
-	if (TEST_RETURN != 0) {
-		tst_resm(TFAIL | TTERRNO, "setresuid failed unexpectedly");
-		return;
-	}
+	TST_EXP_PASS(SETRESUID(-1, ltpuser->pw_uid, -1));
 
-	SAFE_TOUCH(cleanup, "test_file", 0644, NULL);
+	SAFE_TOUCH(TEMP_FILE, 0644, NULL);
+	SAFE_STAT(TEMP_FILE, &buf);
 
-	SAFE_STAT(cleanup, "test_file", &buf);
+	TST_EXP_EQ_LI(ltpuser->pw_uid, buf.st_uid);
 
-	if (ltpuser->pw_uid == buf.st_uid) {
-		tst_resm(TPASS, "setresuid succeeded as expected");
-	} else {
-		tst_resm(TFAIL,
-			 "setresuid failed unexpectedly; euid(%d) - st_uid(%d)",
-			 ltpuser->pw_uid, buf.st_uid);
-	}
+	SAFE_UNLINK(TEMP_FILE);
+	TST_EXP_PASS_SILENT(SETRESUID(-1, 0, -1));
 }
 
-static void cleanup(void)
-{
-	if (seteuid(0) < 0)
-		tst_resm(TWARN | TERRNO, "seteuid failed");
-
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.needs_root = 1,
+	.needs_tmpdir = 1
+};
-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
