Return-Path: <SRS0=8di7=P4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3AAC433F5
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 08:58:30 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BADA561029
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 08:58:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BADA561029
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3029F3C07BF
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 09:58:28 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D36503C089D
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 09:58:16 +0100 (CET)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B9AA8600659
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 09:58:14 +0100 (CET)
X-QQ-mid: bizesmtp37t1636448289tgahqg1x
Received: from localhost.localdomain (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Tue, 09 Nov 2021 16:57:55 +0800 (CST)
X-QQ-SSF: 0140000000200040C000B00A0000000
X-QQ-FEAT: O4BD17EyKbAnld5eavzjQUSYHoS3s4KNkszYbljXmdQo3Yue3kgqsRwVofi7Y
 KsAMmXfoy0S0m051aasaL3igSqSmraKjkUPjCYlnU9C5hYFl7ERQFPr+3mYC+CFt93zIkhl
 ca2ldv+7QDSNCNs/QY0fXcppp3iVXUOQrEwee2vRJONTJDilUW/qLu75ZqRJkZPiuKH4rtc
 Z4K2msniwR6k6XT3KggAu0P3M+3JMEoJhV+OfMBzuvzLcK0AKgLL++LegYQsfk2vqcQFRiW
 usPb7ztxaX3zJxPaopLQxyhwFhHveADtDREX6szdATC8qOwM3PeIisTs5xD8icL6WNo/nio
 IHh4psnX2ZrAflI90G0vAasqRKRCaaM7JU1tyD4
X-QQ-GoodBg: 2
From: tangmeng <tangmeng@uniontech.com>
To: ltp@lists.linux.it
Date: Tue,  9 Nov 2021 16:57:45 +0800
Message-Id: <20211109085745.21531-2-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211109085745.21531-1-tangmeng@uniontech.com>
References: <20211109085745.21531-1-tangmeng@uniontech.com>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] getuid/getuid03: Convert to new API
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
 testcases/kernel/syscalls/getuid/getuid03.c | 90 ++++++---------------
 1 file changed, 26 insertions(+), 64 deletions(-)

diff --git a/testcases/kernel/syscalls/getuid/getuid03.c b/testcases/kernel/syscalls/getuid/getuid03.c
index 7c81c628e..f551e982e 100644
--- a/testcases/kernel/syscalls/getuid/getuid03.c
+++ b/testcases/kernel/syscalls/getuid/getuid03.c
@@ -1,23 +1,12 @@
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
+/*\
+ * [Description]
+ *
  * Testcase to check the basic functionality of the getuid() system call.
  *
  * For functionality test the return value from getgid() is compared to passwd
@@ -25,64 +14,37 @@
  */

 #include <pwd.h>
-#include <errno.h>
+#include "tst_test.h"
+#include "compat_tst_16.h"

-#include "test.h"
-#include "compat_16.h"
-
-TCID_DEFINE(getuid03);
-int TST_TOTAL = 1;
-
-static void setup(void);
-static void cleanup(void);
-
-int main(int ac, char **av)
+static void verify_getuid(void)
 {
 	struct passwd *pwent;
-	int lc;
 	uid_t uid;

-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
+	TEST(GETUID());

-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "getuid failed");

-		tst_count = 0;
+	uid = getuid();
+	pwent = getpwuid(uid);

-		TEST(GETUID(cleanup));
+	if (pwent == NULL)
+		tst_res(TFAIL | TERRNO, "getpwuid failed");

-		if (TEST_RETURN == -1)
-			tst_brkm(TBROK | TTERRNO, cleanup, "getuid failed");
+	UID16_CHECK(pwent->pw_uid, getuid);

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
+	if (pwent->pw_uid != TST_RET)
+		tst_res(TFAIL, "getpwuid value, %d, "
+			 "does not match getuid "
+			 "value, %ld", pwent->pw_uid,
+			 TST_RET);
+	else
+		tst_res(TPASS, "values from getuid "
+			 "and getpwuid match");
 }

-static void setup(void)
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-}
-
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
