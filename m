Return-Path: <SRS0=7iMP=PW=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC74C433F5
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 23:57:04 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4ADD611C0
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 23:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D4ADD611C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 17F023C72CF
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 00:57:01 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 398533C552C
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 00:56:50 +0100 (CET)
Received: from smtpproxy21.qq.com (smtpbg704.qq.com [203.205.195.105])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 552672003B9
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 00:56:43 +0100 (CET)
X-QQ-mid: bizesmtp44t1635983798t9f1u967
Received: from localhost.localdomain (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Thu, 04 Nov 2021 07:56:32 +0800 (CST)
X-QQ-SSF: 0140000000200040C000000A0000000
X-QQ-FEAT: r5+m3MaUqzXGVSD6izpgZyaRW+USglE+KWRKF1JY3lv1l5XCVtbHAwBErCTvK
 EVpxq8bvdYqU7S4iesg64EkuhS9SBlmSMcXd57iyB4QexGQjZr4XQL0X5I/sGD0MZbDk4Ir
 GttJYIAjdiz6kfCDhFioBMDrgvEm1uudpajcNbvH7bdvmTbNBq3upAWAoWPBHeqTQ3LVB+M
 MSTsYv5Q4MPZeeBN/3NrXsi+xeKAzkLgfQHzl4zT8VLFDRYCIPzjYjeRZNUPtZiwoljJtpp
 +OUTocFHEsMOz4+ImfqzGIDevi6Jf+Kw4cRERcSssAGFJruq8+n1v43HSciEvtd68G0/shg
 ghXoPf8q32FLHGCGd/2o6lEbS/fvg==
X-QQ-GoodBg: 2
From: tangmeng <tangmeng@uniontech.com>
To: ltp@lists.linux.it
Date: Thu,  4 Nov 2021 07:56:30 +0800
Message-Id: <20211103235631.9709-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] getrlimit/getrlimit01: Convert to new API
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
 .../kernel/syscalls/getrlimit/getrlimit01.c   | 90 +++++--------------
 1 file changed, 23 insertions(+), 67 deletions(-)

diff --git a/testcases/kernel/syscalls/getrlimit/getrlimit01.c b/testcases/kernel/syscalls/getrlimit/getrlimit01.c
index 68e8bf818..0f7c2150f 100644
--- a/testcases/kernel/syscalls/getrlimit/getrlimit01.c
+++ b/testcases/kernel/syscalls/getrlimit/getrlimit01.c
@@ -1,41 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *
  *   Copyright (c) Wipro Technologies, 2002. All Rights Reserved.
  *   Author: Suresh Babu V. <suresh.babu@wipro.com>
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
  */

-/*
+/*\
+ * [Description]
+ *
  * Verify that getrlimit(2) call will be successful for all possible resource
  * types.
  */
-#include <stdio.h>
-#include <errno.h>
-#include <sys/time.h>
 #include <sys/resource.h>
-#include "test.h"
-
-static void cleanup(void);
-static void setup(void);
+#include "tst_test.h"

 static struct rlimit rlim;
-static struct test_t {
+static struct tcase {
 	int res;
 	char *res_str;
-} testcases[] = {
+} tcases[] = {
 	{RLIMIT_CPU, "RLIMIT_CPU"},
 	{RLIMIT_FSIZE, "RLIMIT_FSIZE"},
 	{RLIMIT_DATA, "RLIMIT_DATA"},
@@ -60,49 +42,23 @@ static struct test_t {
 #endif
 };

-char *TCID = "getrlimit01";
-int TST_TOTAL = ARRAY_SIZE(testcases);
-
-int main(int ac, char **av)
+static void verify_getrlimit(unsigned int i)
 {
-	int i;
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
-		for (i = 0; i < TST_TOTAL; ++i) {
-
-			TEST(getrlimit(testcases[i].res, &rlim));
-
-			if (TEST_RETURN == -1) {
-				tst_resm(TFAIL | TTERRNO,
-					 "getrlimit() test %s failed",
-					 testcases[i].res_str);
-			} else {
-				tst_resm(TPASS,
-					 "getrlimit() test %s success",
-					 testcases[i].res_str);
-			}
-		}
+	struct tcase *tc = &tcases[i];
+	TEST(getrlimit(tc->res, &rlim));
+
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO,
+			 "getrlimit() test %s failed",
+			 tc->res_str);
+	} else {
+		tst_res(TPASS,
+			 "getrlimit() test %s success",
+			 tc->res_str);
 	}
-
-	cleanup();
-	tst_exit();
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
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_getrlimit,
+};
--
2.20.1




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
