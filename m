Return-Path: <SRS0=zuCx=QD=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFFAC433FE
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 02:47:40 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F25CF6187F
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 02:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F25CF6187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE01F3C86E6
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 03:47:37 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0539D3C6268
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 03:47:27 +0100 (CET)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2EC1110009F6
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 03:47:22 +0100 (CET)
X-QQ-mid: bizesmtp49t1637030837tdz9g92y
Received: from localhost.localdomain (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Tue, 16 Nov 2021 10:47:16 +0800 (CST)
X-QQ-SSF: 0140000000200050C000B00A0000000
X-QQ-FEAT: NtgDvgqFC3NIelta8vNxcWNsZmkJusQNYSWK7kFA7S7+lNHyvhcG5J7CzLZ9j
 jf4va/RmDm/kDTyNHiSmGOV3UOexv7+HxN4MVeEFJEPprk7Yt+KsOsBrwztZcB5owPuYBbw
 SIs5xkH1/RxxZM9o3bylDYeZvY83zGtgxp3Z1KRiAjXgnZ6KOloBCqIRk0rI3dbs8ObHrBR
 MkZ+1jZwkrrooqp5G1gYvQEgyPDgIkP+NXP8AKNAFuI/59QvNr2fkWqIK5vSrF3F61wnrov
 1364wMxICuwVAM8L11cIl2M0zU/jWirDcKy1HL0ANDXSUjWasJH8SHzuOlG/IOkZiWuYmHh
 Pgg+6HBF+Un7VdwMZ86+blo7cMy98wdt1gK9nfw
X-QQ-GoodBg: 2
From: tangmeng <tangmeng@uniontech.com>
To: ltp@lists.linux.it
Date: Tue, 16 Nov 2021 10:47:06 +0800
Message-Id: <20211116024706.30853-2-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211116024706.30853-1-tangmeng@uniontech.com>
References: <20211116024706.30853-1-tangmeng@uniontech.com>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] getuid/getuid03: Convert to new API
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
Cc: tangmeng <tangmeng@uniontech.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: tangmeng <tangmeng@uniontech.com>
---
 testcases/kernel/syscalls/getuid/getuid03.c | 96 +++++----------------
 1 file changed, 23 insertions(+), 73 deletions(-)

diff --git a/testcases/kernel/syscalls/getuid/getuid03.c b/testcases/kernel/syscalls/getuid/getuid03.c
index 7c81c628e..fa1fa52cc 100644
--- a/testcases/kernel/syscalls/getuid/getuid03.c
+++ b/testcases/kernel/syscalls/getuid/getuid03.c
@@ -1,88 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2001
  *  Ported by Wayne Boyer
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */

-/*
- * Testcase to check the basic functionality of the getuid() system call.
+/*\
+ * [Description]
  *
- * For functionality test the return value from getgid() is compared to passwd
- * entry.
+ * Check the basic functionality of the getuid() system call
+ * return value against the /proc/self/status where all the
+ * UIDs are listed.
  */

-#include <pwd.h>
-#include <errno.h>
-
-#include "test.h"
-#include "compat_16.h"
+#include "tst_test.h"
+#include "compat_tst_16.h"

-TCID_DEFINE(getuid03);
-int TST_TOTAL = 1;
-
-static void setup(void);
-static void cleanup(void);
-
-int main(int ac, char **av)
+static void verify_getuid(void)
 {
-	struct passwd *pwent;
-	int lc;
-	uid_t uid;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+	long int uid;

-		tst_count = 0;
+	TST_EXP_POSITIVE(GETUID(), "getuid()");

-		TEST(GETUID(cleanup));
+	SAFE_FILE_LINES_SCANF("/proc/self/status", "Uid: %ld", &uid);

-		if (TEST_RETURN == -1)
-			tst_brkm(TBROK | TTERRNO, cleanup, "getuid failed");
-
-		uid = getuid();
-		pwent = getpwuid(uid);
-
-		if (pwent == NULL)
-			tst_resm(TFAIL | TERRNO, "getpwuid failed");
-
-		UID16_CHECK(pwent->pw_uid, getuid, cleanup);
-
-		if (pwent->pw_uid != TEST_RETURN)
-			tst_resm(TFAIL, "getpwuid value, %d, "
-				 "does not match getuid "
-				 "value, %ld", pwent->pw_uid,
-				 TEST_RETURN);
-		else
-			tst_resm(TPASS, "values from getuid "
-				 "and getpwuid match");
-	}
-	cleanup();
-	tst_exit();
-}
-
-static void setup(void)
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	if (TST_RET != uid)
+		tst_res(TFAIL, "Uid value list in /pro/self/status, %ld, "
+			 "does not match getuid "
+			 "value, %ld", uid,
+			 TST_RET);
+	else
+		tst_res(TPASS, "values from getuid "
+			 "and /proc/self/status match");
 }

-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+        .test_all = verify_getuid,
+};
--
2.20.1




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
