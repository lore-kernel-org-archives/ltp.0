Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D26ECAAA1
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 06:24:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 121623CA8E3
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 08:24:12 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D46F33CA4A1
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 08:24:00 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6113C600824
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 08:23:59 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 83DCF20C91
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 06:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1662099838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=r7reL4wYLACMBuNLNk2016nEQ3ptPyIkzF7olXGV8co=;
 b=05HCNByHGmmxOmYeizEN5/qlBBBupM+n+tORNCVfO+1sna0Ha6++SwEVE10SDnGyqTVExx
 iL8N1FDu1Xg1MA1+8Sq/3WeBdy7hxkA7TCJVcMQXCY576sp5IZ4hFeW/51ICsTScTt0CCh
 CyDkwDHrvYoTHwCPKekVZSJppQlMZ2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1662099838;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=r7reL4wYLACMBuNLNk2016nEQ3ptPyIkzF7olXGV8co=;
 b=P9vrNJHUw1zvyXwGdxmmbL/PZgNwQrqTI7FdLFPzZgLwAw2JzesgyHdS+oaaq2rq/0CcH+
 Ay/fM8y4wsJQspAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 018741330E
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 06:23:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jBOyLX2hEWOfRQAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Fri, 02 Sep 2022 06:23:57 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Fri,  2 Sep 2022 11:53:55 +0530
Message-Id: <20220902062355.19954-1-akumar@suse.de>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] unlink07: use TST_EXP_FAIL(), docparse format,
 copyright update  and remove redundant headers
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
 testcases/kernel/syscalls/unlink/unlink07.c | 43 +++++++--------------
 1 file changed, 14 insertions(+), 29 deletions(-)

diff --git a/testcases/kernel/syscalls/unlink/unlink07.c b/testcases/kernel/syscalls/unlink/unlink07.c
index 869bd5f51..9c9ed0132 100644
--- a/testcases/kernel/syscalls/unlink/unlink07.c
+++ b/testcases/kernel/syscalls/unlink/unlink07.c
@@ -1,23 +1,22 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+ * Copyright (c) Linux Test Project, 2002-2022
  */
 
-/*
- * Description:
- * The testcase checks the various errnos of the unlink(2).
- * 1) unlink() returns ENOENT if file doesn't exist.
- * 2) unlink() returns ENOENT if path is empty.
- * 3) unlink() returns ENOENT if path contains a non-existent file.
- * 4) unlink() returns EFAULT if address is invalid.
- * 5) unlink() returns ENOTDIR if path contains a regular file.
- * 6) unlink() returns ENAMETOOLONG if path contains a regular file.
+/*\
+ * [Description]
+ *
+ * Verify that unlink() fails with
+ * - ENOENT when file does not exist
+ * - ENOENT when pathname is empty
+ * - ENOENT when a component in pathname does not exist
+ * - EFAULT when pathname points outside the accessible address space
+ * - ENOTDIR when a component used as a directory in pathname is not,
+ * in fact, a directory
+ * - ENAMETOOLONG when pathname is too long
  */
 
-#include <errno.h>
-#include <string.h>
-#include <unistd.h>
-#include <sys/param.h>	/* for PATH_MAX */
 #include "tst_test.h"
 
 static char longpathname[PATH_MAX + 2];
@@ -39,26 +38,12 @@ static void verify_unlink(unsigned int n)
 {
 	struct test_case_t *tc = &tcases[n];
 
-	TEST(unlink(tc->name));
-	if (TST_RET != -1) {
-		tst_res(TFAIL, "unlink(<%s>) succeeded unexpectedly",
-			tc->desc);
-		return;
-	}
-
-	if (TST_ERR == tc->exp_errno) {
-		tst_res(TPASS | TTERRNO, "unlink(<%s>) failed as expected",
-			tc->desc);
-	} else {
-		tst_res(TFAIL | TTERRNO,
-			"unlink(<%s>) failed, expected errno: %s",
-			tc->desc, tst_strerrno(tc->exp_errno));
-	}
+	TST_EXP_FAIL(unlink(tc->name), tc->exp_errno, "%s", tc->desc);
 }
 
 static void setup(void)
 {
-	unsigned int n;
+	size_t n;
 
 	SAFE_TOUCH("file", 0777, NULL);
 
-- 
2.37.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
