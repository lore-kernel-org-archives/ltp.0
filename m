Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B03AC6FA8F
	for <ltp@archiver.kernel.org>; Wed, 30 Aug 2023 13:26:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 922D33CE048
	for <ltp@archiver.kernel.org>; Wed, 30 Aug 2023 15:26:06 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C93C3CC002
 for <ltp@lists.linux.it>; Wed, 30 Aug 2023 15:25:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E79001A00921
 for <ltp@lists.linux.it>; Wed, 30 Aug 2023 15:25:30 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E73A11F74B;
 Wed, 30 Aug 2023 13:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693401929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=85L1WEHaT0JYnIPb68npxISGMq3alxNGHeMaX+QFQs4=;
 b=lg11NPbVbRa8AmTbcq8/IqfJSEFjCAtocqzVy+7y/674oQkH91q9QLx2DNiXjqubXSJaXq
 gr4ODa7Tm9A5DoNsqMGR4oni3Lgr8WgXBzX08HooAvpjWvFI5RgOmLaT6F7it1Qomiyh80
 xO9c9VIdOYcVn+fpnOyAQBN1VAx6b2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693401929;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=85L1WEHaT0JYnIPb68npxISGMq3alxNGHeMaX+QFQs4=;
 b=XcAID6cOeYxVWNZ5RVYL/NXvoCXOVJ4pauMqIiG6CD7V1spAHaMgPPl7GsHRTA8jBvW66G
 ceLuWWgzY/TsLPBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C836C13441;
 Wed, 30 Aug 2023 13:25:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QLRZL0lD72QXaAAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Wed, 30 Aug 2023 13:25:29 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Wed, 30 Aug 2023 15:25:28 +0200
Message-Id: <20230830132528.26521-3-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230830132528.26521-1-andrea.cervesato@suse.de>
References: <20230830132528.26521-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 2/2] Refactor personality02 using new API
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
 .../syscalls/personality/personality02.c      | 64 +++++++------------
 1 file changed, 22 insertions(+), 42 deletions(-)

diff --git a/testcases/kernel/syscalls/personality/personality02.c b/testcases/kernel/syscalls/personality/personality02.c
index eb18c9951..e080284f4 100644
--- a/testcases/kernel/syscalls/personality/personality02.c
+++ b/testcases/kernel/syscalls/personality/personality02.c
@@ -1,62 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) 2016 Linux Test Project
  * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
-/*
- * If personality with STICKY_TIMEOUTS is used select() timeout is not updated.
+/*\
+ * [Description]
+ *
+ * This test checks if select() timeout is not updated when personality with
+ * STICKY_TIMEOUTS is used.
  */
 
-#include "test.h"
-#include <sys/personality.h>
+#include "tst_test.h"
+#include "lapi/personality.h"
 #include <sys/select.h>
 
-char *TCID = "personality02";
-int TST_TOTAL = 1;
-
 #define USEC 10
 
-static void verify_personality(void)
+static void run(void)
 {
-	struct timeval tv = {.tv_sec = 0, .tv_usec = USEC};
-	int ret;
+	struct timeval tv = { .tv_sec = 0, .tv_usec = USEC };
 	fd_set rfds;
 
 	FD_ZERO(&rfds);
 	FD_SET(1, &rfds);
 
-	personality(PER_LINUX | STICKY_TIMEOUTS);
-	ret = select(2, &rfds, NULL, NULL, &tv);
-	personality(PER_LINUX);
-	if (ret < 0)
-		tst_resm(TBROK | TERRNO, "select()");
+	SAFE_PERSONALITY(PER_LINUX | STICKY_TIMEOUTS);
 
-	if (tv.tv_usec != USEC)
-		tst_resm(TFAIL, "Timeout was modified");
-	else
-		tst_resm(TPASS, "Timeout wasn't modified");
-}
-
-int main(int ac, char **av)
-{
-	int lc;
+	TEST(select(2, &rfds, NULL, NULL, &tv));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TERRNO, "select() error");
 
-	tst_parse_opts(ac, av, NULL, NULL);
+	SAFE_PERSONALITY(PER_LINUX);
 
-	for (lc = 0; TEST_LOOPING(lc); lc++)
-		verify_personality();
-
-	tst_exit();
+	TST_EXP_EQ_LI(tv.tv_usec, USEC);
 }
+
+static struct tst_test test = {
+	.test_all = run,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
