Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F88C433F5
	for <ltp@archiver.kernel.org>; Thu,  3 Mar 2022 08:34:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF9D53CA364
	for <ltp@archiver.kernel.org>; Thu,  3 Mar 2022 09:34:12 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 481673C978E
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 09:34:02 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C23541401428
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 09:33:59 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CD6391F3A3;
 Thu,  3 Mar 2022 08:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1646296438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6zKIrLde98dtJgPzy3dqp1TUwXyaHIjW99BCt95Py74=;
 b=hnZ7qXbmhfvbcBy36d50dbRpjA+wWIXTjaEhBkOUNTlI2JCiJybo4Occ6cBDCyHMFT79GD
 egl+JJy2CpFTojwe47uiEAPtumtQHMRclo+OILR34TiZBX403E6FtQEfXZdJdyZlpUYDb2
 gRZjdv8BYliRXCcFqQiZtBWME792cu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1646296438;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6zKIrLde98dtJgPzy3dqp1TUwXyaHIjW99BCt95Py74=;
 b=u/NoGebWCVkfka7EQAmeDvyuFHgDef0FRY67/GEebZnf5p5HVt9M5nI+enRBoKEPbB9Mo9
 0+xIY5t4KMhW0DBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A4694139BD;
 Thu,  3 Mar 2022 08:33:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id c+4hJnZ9IGI2TgAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Thu, 03 Mar 2022 08:33:58 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu,  3 Mar 2022 09:33:57 +0100
Message-Id: <20220303083357.20675-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Rewrite getcontext01.c test using new LTP API
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

Removed old LTP API from getcontext01.c test and check if getcontext is
present in the current system. The check is useful in those systems
where musl is used by default.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
---
 configure.ac                                  |  1 +
 .../kernel/syscalls/getcontext/getcontext01.c | 93 ++++---------------
 2 files changed, 20 insertions(+), 74 deletions(-)

diff --git a/configure.ac b/configure.ac
index 49499704e..9b6d01f54 100644
--- a/configure.ac
+++ b/configure.ac
@@ -97,6 +97,7 @@ AC_CHECK_FUNCS_ONCE([ \
     fspick \
     fstatat \
     getauxval \
+    getcontext \
     getdents \
     getdents64 \
     io_pgetevents \
diff --git a/testcases/kernel/syscalls/getcontext/getcontext01.c b/testcases/kernel/syscalls/getcontext/getcontext01.c
index 48e78907f..7176a9035 100644
--- a/testcases/kernel/syscalls/getcontext/getcontext01.c
+++ b/testcases/kernel/syscalls/getcontext/getcontext01.c
@@ -1,89 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Wipro Technologies Ltd, 2005.  All Rights Reserved.
- *  Author: Prashant P Yendigeri <prashant.yendigeri@wipro.com>
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
+ *               Author: Prashant P Yendigeri <prashant.yendigeri@wipro.com>
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
-#include <features.h>
-
-#include <stdio.h>
-#include <unistd.h>
-#include <errno.h>
-#include <ucontext.h>
-
-#include "test.h"
-
-char *TCID = "getcontext01";
+/*\
+ * [Description]
+ *
+ * Test getting user context functionality.
+ */
 
-#if !defined(__UCLIBC__)
+#include "config.h"
+#include "tst_test.h"
 
-static void setup(void);
-static void cleanup(void);
+#ifdef HAVE_GETCONTEXT
 
-int TST_TOTAL = 1;
+#include <ucontext.h>
 
-static void test_getcontext(void)
+static void run(void)
 {
 	ucontext_t ptr;
 
-	TEST(getcontext(&ptr));
-
-	if (TEST_RETURN == -1) {
-		if (errno == ENOSYS)
-			tst_resm(TCONF, "getcontext not implemented in libc");
-		else
-			tst_resm(TFAIL | TTERRNO, "getcontext failed");
-	} else if (TEST_RETURN == 0) {
-		tst_resm(TPASS, "getcontext passed");
-	} else {
-		tst_resm(TFAIL, "Unexpected return value %li", TEST_RETURN);
-	}
-}
-
-int main(int ac, char **av)
-{
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
-		test_getcontext();
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-static void setup(void)
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	TST_EXP_PASS(getcontext(&ptr));
 }
 
-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.test_all = run,
+};
 
-#else /* systems that dont support obsolete getcontext */
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "system doesn't have getcontext support");
-}
+#else
+TST_TEST_TCONF("system doesn't have getcontext support");
 #endif
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
