Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECFAC001DB
	for <ltp@archiver.kernel.org>; Tue,  8 Aug 2023 15:36:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A0B93CE144
	for <ltp@archiver.kernel.org>; Tue,  8 Aug 2023 17:36:06 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B1783C9D45
 for <ltp@lists.linux.it>; Tue,  8 Aug 2023 17:35:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 828EF600141
 for <ltp@lists.linux.it>; Tue,  8 Aug 2023 17:35:54 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E88F12031B
 for <ltp@lists.linux.it>; Tue,  8 Aug 2023 15:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1691508953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HBS6BSvolUT/PiHm5D74NGtgulUvCoYnNl9Q+ivzAkU=;
 b=AheJR67amuZ6HpTwZVEaT+QmGJEJIyTnhrbF2OEZ9Ih00YVfi+jPqttgWv2ulhmElNbT7g
 F9VXPMt37kWpLCzq7NSoQ7YZQQ+Z3tt0buQ8s6JIKPvYZWXmDClQJYLssIgc1gnDH/Rzod
 Na16G3WX/c8SUNRxSmIkfEDGXcyo8HM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1691508953;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HBS6BSvolUT/PiHm5D74NGtgulUvCoYnNl9Q+ivzAkU=;
 b=eRBIESbMwEbX6AwgguvTY+mwyQes9rfUi5xTMLlVsuvGet5mWf3SzoRuMZx/YX/w0pkOg/
 91xkT01YXlasWjDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7F3C4139D1
 for <ltp@lists.linux.it>; Tue,  8 Aug 2023 15:35:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id V/jEFdlg0mSbVgAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Tue, 08 Aug 2023 15:35:53 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Tue,  8 Aug 2023 21:05:47 +0530
Message-ID: <20230808153549.22777-2-akumar@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230808153549.22777-1-akumar@suse.de>
References: <20230808153549.22777-1-akumar@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] sbrk02.c: Refactor the test using new LTP API
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
 testcases/kernel/syscalls/sbrk/sbrk02.c | 102 +++++++-----------------
 1 file changed, 28 insertions(+), 74 deletions(-)

diff --git a/testcases/kernel/syscalls/sbrk/sbrk02.c b/testcases/kernel/syscalls/sbrk/sbrk02.c
index 84744ef90..69a7ce35c 100644
--- a/testcases/kernel/syscalls/sbrk/sbrk02.c
+++ b/testcases/kernel/syscalls/sbrk/sbrk02.c
@@ -1,101 +1,55 @@
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
- * DESCRIPTION
- *	Check sbrk() with error condition that should produce ENOMEM.
+ * Copyright (c) 2023 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
 
-#include <errno.h>
-#include <unistd.h>
-#include "test.h"
-
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
+	void *tret;
 
-	setup();
+	tret = sbrk(increment);
+	TST_ERR = errno;
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		for (i = 0; i < TST_TOTAL; i++)
-			sbrk_verify();
+	if (tret != (void *)-1) {
+		tst_res(TFAIL, "sbrk(%ld) unexpectedly passed and returned %p, "
+						"expected (void *)-1 with errno=%d",
+						increment, tret, ENOMEM);
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
 }
 
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
-}
-
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
