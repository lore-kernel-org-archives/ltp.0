Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55605C32772
	for <ltp@archiver.kernel.org>; Tue, 23 Aug 2022 09:51:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3AB8C3CA334
	for <ltp@archiver.kernel.org>; Tue, 23 Aug 2022 11:51:32 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D55663C0726
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 11:51:21 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 248C31A00CC4
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 11:51:20 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 118465BCC2
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 09:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1661248280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=54osBkdqyKD8t/biNKqcvf2TK7vUFgpmYRjEt4oCr3Q=;
 b=uUWYOdYQlqO96N+nUnNHULhYvrwW0lWHusejxKk9UL3OJq8thbW9OEJJnFlR1TMLj1fOnx
 yCe8O3CcP2MZKum3oHaH6087XzdtQWOfBAM82sL52PeYJ0hSAPIDl8ybY045uT4mB34POd
 y6gV26eS9hR3CIm2oL0MXdaI51541jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1661248280;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=54osBkdqyKD8t/biNKqcvf2TK7vUFgpmYRjEt4oCr3Q=;
 b=O0OoGrDwM6P8QZvTyLl4cfZBnyYDoqf3DHPDoIg5p24EPiKRBFSZ9wPVhXpveUg0jPw5H8
 bTJqCri6EJDvemCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8727613AB7
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 09:51:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ECNgEhejBGPxfQAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 09:51:19 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Tue, 23 Aug 2022 15:21:16 +0530
Message-Id: <20220823095116.369-1-akumar@suse.de>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] setegid02.c: Rewrite using new LTP API
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
 testcases/kernel/syscalls/setegid/setegid02.c | 90 +++++--------------
 1 file changed, 21 insertions(+), 69 deletions(-)

diff --git a/testcases/kernel/syscalls/setegid/setegid02.c b/testcases/kernel/syscalls/setegid/setegid02.c
index 7c60a9cf5..66a8a07fb 100644
--- a/testcases/kernel/syscalls/setegid/setegid02.c
+++ b/testcases/kernel/syscalls/setegid/setegid02.c
@@ -1,87 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
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
+ * Copyright (c) 2022 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
-/*
- * DESCRIPTION
- *	The calling process is not privileged and euid is not appropriate,
- *	EPERM should return.
+
+/*\
+ * [Description]
+ *
+ * Verify that setegid() fails with EPERM when the calling process is not
+ * privileged and egid does not match the current real group ID,
+ * current effective group ID, or current saved set-group-ID.
  */
 
-#include <errno.h>
 #include <pwd.h>
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "setegid02";
-int TST_TOTAL = 1;
-static void setup(void);
-static void setegid_verify(void);
-static void cleanup(void);
+#include "tst_test.h"
 
 static struct passwd *ltpuser;
 
-int main(int argc, char *argv[])
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
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
-
-	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
+	ltpuser = SAFE_GETPWNAM("nobody");
+	SAFE_SETEUID(ltpuser->pw_uid);
 }
 
 static void setegid_verify(void)
 {
-	TEST(setegid(ltpuser->pw_gid));
-
-	if (TEST_RETURN != -1) {
-		tst_resm(TFAIL, "setegid(%d) succeeded unexpectedly",
-			 ltpuser->pw_gid);
-		return;
-	}
-
-	if (TEST_ERRNO == EPERM) {
-		tst_resm(TPASS | TTERRNO, "setegid failed as expected");
-	} else {
-		tst_resm(TFAIL | TTERRNO,
-			 "setegid failed unexpectedly; expected: %d - %s",
-			 EPERM, strerror(EPERM));
-	}
+	TST_EXP_FAIL(setegid(ltpuser->pw_gid),
+				EPERM,
+				"setegid(%d)",
+				ltpuser->pw_gid);
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
