Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28593EE8009
	for <ltp@archiver.kernel.org>; Fri,  8 Sep 2023 14:14:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B09C73CC994
	for <ltp@archiver.kernel.org>; Fri,  8 Sep 2023 16:14:49 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 91E193CB543
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 16:14:16 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 014DC1001594
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 16:14:15 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8342C21C81;
 Fri,  8 Sep 2023 14:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694182455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0V1VvSM7JZAE0j5BtsDujXNb3ECXuH/JxxMOHPK2v6U=;
 b=cLF/cl8VQqh+TOUsLdXQNTzYt0es0a/XaQWoLrdvD6AwLzzqNwkmY4hEUvewX8GSVIzH0X
 ieqhexP9wzibMXkFgnMY9bYR32b1/QlkrXCXQ9w7A3VFz8xj2vDdfIre/yvYYvuSmSpzu2
 dBpabe8n95O325ax/tuD7tchb1bB9kU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694182455;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0V1VvSM7JZAE0j5BtsDujXNb3ECXuH/JxxMOHPK2v6U=;
 b=7MFYU0ZXPuX1GcSHjkWYAHZHhcQytlEdv/AM2b8TnzmJzEqlZfQOGSIqGFbezOmw0he5rk
 K+K8qy89AdMFC8DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 56C66132F2;
 Fri,  8 Sep 2023 14:14:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2BXDEjcs+2RocQAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Fri, 08 Sep 2023 14:14:15 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri,  8 Sep 2023 16:14:13 +0200
Message-Id: <20230908141414.28359-2-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230908141414.28359-1-andrea.cervesato@suse.de>
References: <20230908141414.28359-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] Refactor getegid01 using new LTP API
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

This new version also verifies that getegid() effectively returns the
right effective group ID by looking at /proc/self/status information.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/getegid/getegid01.c | 95 ++++---------------
 1 file changed, 20 insertions(+), 75 deletions(-)

diff --git a/testcases/kernel/syscalls/getegid/getegid01.c b/testcases/kernel/syscalls/getegid/getegid01.c
index 271fbb6b6..46cdc680b 100644
--- a/testcases/kernel/syscalls/getegid/getegid01.c
+++ b/testcases/kernel/syscalls/getegid/getegid01.c
@@ -1,87 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
- *
+ *   William Roske, Dave Fenner
+ * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
-/*
- *    AUTHOR		: William Roske
- *    CO-PILOT		: Dave Fenner
+/*\
+ * [Description]
+ *
+ * This test checks if getegid() returns the effective group id.
  */
 
-#include <sys/types.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-
-#include "test.h"
-#include "compat_16.h"
-
-static void setup();
-static void cleanup();
+#include "tst_test.h"
+#include "compat_tst_16.h"
 
-TCID_DEFINE(getegid01);
-int TST_TOTAL = 1;
-
-int main(int ac, char **av)
+static void run(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		TEST(GETEGID(cleanup));
+	gid_t gid, st_egid;
 
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TTERRNO, "getegid failed");
-			continue;	/* next loop for MTKERNEL */
-		}
+	SAFE_FILE_LINES_SCANF("/proc/self/status", "Gid: %*d %d", &st_egid);
+	gid = getegid();
 
-		tst_resm(TPASS, "getegid returned %ld", TEST_RETURN);
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
+	if (GID_SIZE_CHECK(st_egid))
+		TST_EXP_EQ_LI(gid, st_egid);
+	else
+		tst_res(TPASS, "getegid() passed");
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
