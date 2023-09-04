Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D4AC83F33
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 14:04:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 853B13CB88D
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 16:04:37 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8BDB83CB887
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 16:04:27 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2355F601167
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 16:04:25 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 895E52184F;
 Mon,  4 Sep 2023 14:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693836265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3NujNPRNaJUd1hgEvCqFe5Ggb+Gu7rgkKAE3LiUrOBA=;
 b=SRakgBiK8aBa3goa06tRhFWyzJ/8LI0XnpSnXcZVSnB84gC8fuhZ2leVcvBwQDJmwG4UK7
 xBw+g/TBfpBbe682kwganbdg14ktlgUgTUsqmJP3vwb/Veo0mdMnvmWVW/QZQDaHmEE11u
 eV9MB0hEqG2dvGf4+6YKsrbUCYVm4Vg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693836265;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3NujNPRNaJUd1hgEvCqFe5Ggb+Gu7rgkKAE3LiUrOBA=;
 b=WhJK03t0ylcIxptdCAX3rZJ4LlHk0aTVdgB0/ItY73DRhROHkBNzYmC75KNb14plOLmKkh
 8Ys33oI42kuthHCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E8AE13425;
 Mon,  4 Sep 2023 14:04:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wLC2Genj9WQnIQAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Mon, 04 Sep 2023 14:04:25 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Mon,  4 Sep 2023 16:04:24 +0200
Message-Id: <20230904140424.9971-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Refactor timerfd_create01 using new LTP API
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
 .../syscalls/timerfd/timerfd_create01.c       | 99 +++++--------------
 1 file changed, 22 insertions(+), 77 deletions(-)

diff --git a/testcases/kernel/syscalls/timerfd/timerfd_create01.c b/testcases/kernel/syscalls/timerfd/timerfd_create01.c
index 3d70b84f0..18a233586 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd_create01.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd_create01.c
@@ -1,95 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2014 Fujitsu Ltd.
- * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
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
+ *         Zeng Linggang <zenglg.jy@cn.fujitsu.com>
+ * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
-/*
- * DESCRIPTION
- *  Verify that,
- *   1. The clockid argument is neither CLOCK_MONOTONIC nor CLOCK_REALTIME,
- *	EINVAL would return.
- *   2. flags is invalid, EINVAL would return.
+/*\
+ * [Description]
+ *
+ * This test verifies that:
+ * - clockid argument is neither CLOCK_MONOTONIC nor CLOCK_REALTIME,
+ * EINVAL would return.
+ * - flags is invalid, EINVAL would return.
  */
 
-#define _GNU_SOURCE
-
 #include <errno.h>
 
-#include "test.h"
-#include "lapi/timerfd.h"
-
-char *TCID = "timerfd_create01";
+#include "tst_test.h"
+#include "tst_safe_timerfd.h"
 
 static struct test_case_t {
 	int clockid;
 	int flags;
 	int exp_errno;
-} test_cases[] = {
-	{-1, 0, EINVAL},
-	{0, -1, EINVAL},
+} tcases[] = {
+	{ -1,  0, EINVAL },
+	{  0, -1, EINVAL },
 };
 
-int TST_TOTAL = ARRAY_SIZE(test_cases);
-static void setup(void);
-static void timerfd_create_verify(const struct test_case_t *);
-static void cleanup(void);
-
-int main(int argc, char *argv[])
+static void run(unsigned int i)
 {
-	int lc;
-	int i;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
+	struct test_case_t *test = &tcases[i];
 
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		for (i = 0; i < TST_TOTAL; i++)
-			timerfd_create_verify(&test_cases[i]);
-	}
-
-	cleanup();
-	tst_exit();
+	TST_EXP_FAIL(timerfd_create(test->clockid, test->flags), test->exp_errno);
 }
 
-static void setup(void)
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-}
-
-static void timerfd_create_verify(const struct test_case_t *test)
-{
-	TEST(timerfd_create(test->clockid, test->flags));
-
-	if (TEST_RETURN != -1) {
-		tst_resm(TFAIL, "timerfd_create() succeeded unexpectedly");
-		return;
-	}
-
-	if (TEST_ERRNO == test->exp_errno) {
-		tst_resm(TPASS | TTERRNO,
-			 "timerfd_create() failed as expected");
-	} else {
-		tst_resm(TFAIL | TTERRNO,
-			 "timerfd_create() failed unexpectedly; expected: "
-			 "%d - %s", test->exp_errno, strerror(test->exp_errno));
-	}
-}
-
-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
