Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD91E7AD77
	for <ltp@archiver.kernel.org>; Tue,  3 Oct 2023 17:43:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A568B3CDCA5
	for <ltp@archiver.kernel.org>; Tue,  3 Oct 2023 19:43:41 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 05DD83CB9AD
 for <ltp@lists.linux.it>; Tue,  3 Oct 2023 19:43:31 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EC526140042E
 for <ltp@lists.linux.it>; Tue,  3 Oct 2023 19:43:30 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E47122188F;
 Tue,  3 Oct 2023 17:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1696355008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=q2Sw3qZPKXcWGoBGlU5b+KZlJn6eT/GcC/4AuzM8+Ag=;
 b=c9h0MXidt1mB8zZIOh68/sTGDFm5kxu4AYXW94fhEwQ124pHg/9wonzihvD9KoAknVsZug
 FWchEHOMSH2zKb3euocyn6jz493uO+K6czNnvujlL/ZW13RAWhVxD29cA8CIyTcwSXaidL
 +qV5OaX7AJQXR6wTzXOT2BfzqvgFR60=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D32A5132D4;
 Tue,  3 Oct 2023 17:43:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EZGpMsBSHGX/KwAAMHmgww
 (envelope-from <ybonatakis@suse.com>); Tue, 03 Oct 2023 17:43:28 +0000
To: ltp@lists.linux.it
Date: Tue,  3 Oct 2023 19:41:55 +0200
Message-ID: <20231003174155.25566-1-ybonatakis@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Refactor wait4/wait402.c to the new API
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
From: ybonatakis via ltp <ltp@lists.linux.it>
Reply-To: ybonatakis <ybonatakis@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Not major changes in functionality. Man page says, *wait for process to change
state, BSD style*. So i kept the `_USE_BSD` macro, even if test seems to work
anyway without it.

Signed-off-by: ybonatakis <ybonatakis@suse.com>
---
 testcases/kernel/syscalls/wait4/wait402.c | 97 ++++-------------------
 1 file changed, 17 insertions(+), 80 deletions(-)

diff --git a/testcases/kernel/syscalls/wait4/wait402.c b/testcases/kernel/syscalls/wait4/wait402.c
index 39b170253..13b2af533 100644
--- a/testcases/kernel/syscalls/wait4/wait402.c
+++ b/testcases/kernel/syscalls/wait4/wait402.c
@@ -1,101 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *   Copyright (c) International Business Machines  Corp., 2001
  *   Copyright (c) 2012 Cyril Hrubis <chrubis@suse.cz>
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ *   Copyright (c) 2023 Ioannis Bonatakis <ybonatakis@suse.com>
  */
 
- /*
-  * wait402 - check for ECHILD errno when using an illegal pid value
-  */
-
-#include "test.h"
+/*\
+ * [Description]
+ *
+ * Check for ECHILD errno when using an illegal pid value
+ */
 
-#include <errno.h>
+#include "tst_test.h"
 #define _USE_BSD
-#include <sys/types.h>
-#include <sys/resource.h>
 #include <sys/wait.h>
-#include <stdlib.h>
-#include <string.h>
 
-char *TCID = "wait402";
-int TST_TOTAL = 1;
-
-static void cleanup(void);
-static void setup(void);
-
-static long get_pid_max(void)
-{
-	long pid_max;
-
-	SAFE_FILE_SCANF(NULL, "/proc/sys/kernel/pid_max", "%ld", &pid_max);
-
-	return pid_max;
-}
+static pid_t pid_max;
 
-int main(int ac, char **av)
+static void run(void)
 {
-	int lc;
-	pid_t epid = get_pid_max() + 1;
-
 	int status = 1;
 	struct rusage rusage;
 
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		TEST(wait4(epid, &status, 0, &rusage));
-
-		if (TEST_RETURN == 0) {
-			tst_brkm(TFAIL, cleanup,
-				 "call failed to produce expected error - errno = %d - %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-		}
-
-		switch (TEST_ERRNO) {
-		case ECHILD:
-			tst_resm(TPASS,
-				 "received expected failure - errno = %d - %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-			break;
-		default:
-			tst_brkm(TFAIL, cleanup,
-				 "call failed to produce expected "
-				 "error - errno = %d - %s", TEST_ERRNO,
-				 strerror(TEST_ERRNO));
-		}
-	}
-
-	cleanup();
-	tst_exit();
+	TST_EXP_FAIL2(wait4(pid_max, &status, 0, &rusage), ECHILD,
+		      "wait4 fails with ECHILD");
 }
 
 static void setup(void)
 {
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	SAFE_FILE_SCANF("/proc/sys/kernel/pid_max", "%d\n", &pid_max);
 }
 
-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+};
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
