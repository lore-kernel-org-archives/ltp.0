Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E434C001B0
	for <ltp@archiver.kernel.org>; Wed,  9 Aug 2023 13:19:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F9153CD0C7
	for <ltp@archiver.kernel.org>; Wed,  9 Aug 2023 15:19:17 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB0313CACD6
 for <ltp@lists.linux.it>; Wed,  9 Aug 2023 15:18:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EB15964027B
 for <ltp@lists.linux.it>; Wed,  9 Aug 2023 15:18:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 771CA21853
 for <ltp@lists.linux.it>; Wed,  9 Aug 2023 13:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1691587132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HYkBl4Vi+Xoc8Eezh2TBRey5ouix5YuWeeBRVrk8uZQ=;
 b=hzngr1JwKxhW4GpApsaCpIipxD6ofua10PTYjOIZ20VTYxTyOn3TtCIHQ0i7qJGt1m+SE5
 /d1rAZsIbrGrOUpI0wppiWZtMPD/JhS8aOLuZX+TUmyjRg+fqe/PfXv3mIHQD0yNqve+PI
 fEBXJEiYYV9qYrFqdJnupn0fqkYNujY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1691587132;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HYkBl4Vi+Xoc8Eezh2TBRey5ouix5YuWeeBRVrk8uZQ=;
 b=Kpjjvgk9wi18gt3ORFjaadgkdXihJQTDDrYXQILl5BG3xydER8KaAZ2SI5SV2uFHGN6XSp
 8gDdP6oi/21xt+Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 28C3E13251
 for <ltp@lists.linux.it>; Wed,  9 Aug 2023 13:18:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IKraADyS02TXCgAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Wed, 09 Aug 2023 13:18:52 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Wed,  9 Aug 2023 18:48:46 +0530
Message-ID: <20230809131847.10914-2-akumar@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809131847.10914-1-akumar@suse.de>
References: <20230809131847.10914-1-akumar@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] sbrk02.c: Refactor the test using new LTP API
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
 testcases/kernel/syscalls/sbrk/sbrk02.c | 101 ++++++------------------
 1 file changed, 26 insertions(+), 75 deletions(-)

diff --git a/testcases/kernel/syscalls/sbrk/sbrk02.c b/testcases/kernel/syscalls/sbrk/sbrk02.c
index 84744ef90..7fccc4d3a 100644
--- a/testcases/kernel/syscalls/sbrk/sbrk02.c
+++ b/testcases/kernel/syscalls/sbrk/sbrk02.c
@@ -1,101 +1,52 @@
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
+ * Copyright (c) 2023 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
-/*
- * DESCRIPTION
- *	Check sbrk() with error condition that should produce ENOMEM.
- */
-
-#include <errno.h>
-#include <unistd.h>
-#include "test.h"
 
-#define INC 16*1024*1024
+/*\
+ * [Description]
+ *
+ * Verify that sbrk() on failure sets errno to ENOMEM.
+ */
 
-char *TCID = "sbrk02";
-int TST_TOTAL = 1;
 
-static void setup(void);
-static void sbrk_verify(void);
-static void cleanup(void);
+#include "tst_test.h"
 
+#define INC (16*1024*1024)
 static long increment = INC;
 
-int main(int argc, char *argv[])
+static void run(void)
 {
-	int lc;
-	int i;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
+	TESTPTR(sbrk(increment));
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		for (i = 0; i < TST_TOTAL; i++)
-			sbrk_verify();
+	if (TST_RET_PTR != (void *)-1) {
+		tst_res(TFAIL, "sbrk(%ld) unexpectedly passed and returned %p, "
+						"expected (void *)-1 with errno=%d",
+						increment, TST_RET_PTR, ENOMEM);
+		return;
 	}
 
-	cleanup();
-	tst_exit();
+	if (TST_ERR == ENOMEM)
+		tst_res(TPASS | TTERRNO, "sbrk(%ld) failed as expected", increment);
+	else
+		tst_res(TFAIL | TTERRNO, "sbrk(%ld) failed but unexpected errno, "
+								"expected errno=%d - %s",
+								increment, ENOMEM, strerror(ENOMEM));
 }
 
 static void setup(void)
 {
 	void *ret = NULL;
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	/* call sbrk until it fails or increment overflows */
 	while (ret != (void *)-1 && increment > 0) {
 		ret = sbrk(increment);
 		increment += INC;
 	}
-	tst_resm(TINFO | TERRNO, "setup() bailing inc: %ld, ret: %p, sbrk: %p",
-		increment, ret, sbrk(0));
-
-	errno = 0;
-}
-
-static void sbrk_verify(void)
-{
-	void *tret;
-
-	tret = sbrk(increment);
-	TEST_ERRNO = errno;
-
-	if (tret != (void *)-1) {
-		tst_resm(TFAIL,
-			 "sbrk(%ld) returned %p, expected (void *)-1, errno=%d",
-			 increment, tret, ENOMEM);
-		return;
-	}
-
-	if (TEST_ERRNO == ENOMEM) {
-		tst_resm(TPASS | TTERRNO, "sbrk(%ld) failed as expected",
-			 increment);
-	} else {
-		tst_resm(TFAIL | TTERRNO,
-			 "sbrk(%ld) failed unexpectedly; expected: %d - %s",
-			 increment, ENOMEM, strerror(ENOMEM));
-	}
 }
 
-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup
+};
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
