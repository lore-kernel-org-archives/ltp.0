Return-Path: <SRS0=7Ptb=QG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89873C433EF
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 05:37:22 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64F3661AF0
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 05:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 64F3661AF0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 23DD13C89C1
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 06:37:19 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 55A203C2E5C
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 06:37:08 +0100 (CET)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D5D321000F2B
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 06:37:06 +0100 (CET)
X-QQ-mid: bizesmtp42t1637300219tvf5w7dc
Received: from localhost.localdomain (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Fri, 19 Nov 2021 13:36:53 +0800 (CST)
X-QQ-SSF: 0140000000200050D000B00D0000000
X-QQ-FEAT: 3uawQE1sH+0R7zpQ+rmuMDRWbQ2s7E2UnK8Ip6WW2r16MrAPH47fvDy1rdO/t
 isnL4Bj89iLlzti7B9gWkO5AOQ7I06gWdFcmlfpKxkmM91T6LHLu062iWa/aPoQ/TBGOGXF
 nlyeMYRhuR2/XZl6Kwt4Ea1ErjyAsgtiB3IxpIIftg7oZIPrGL94zqIrezatBNNUvKgq0qx
 545W2c7h+wOKRkK59iFmcLbchb2X7hhQOhFcsaKYFWdhZfTgUrTsBHIghXdXW3f3DYdkukL
 V1u36eDPYQKh4BXk+gEYRvKnppV/B7uYAlyV6BulGXR/YvBlVuV2FQWYIIiF5lJDbo5oHT7
 ASrVB/RwnXhGokb7fPiVMCqIcxSng==
X-QQ-GoodBg: 2
From: tangmeng <tangmeng@uniontech.com>
To: ltp@lists.linux.it
Date: Fri, 19 Nov 2021 13:36:50 +0800
Message-Id: <20211119053650.11979-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/pselect_02: Convert to new API
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
 testcases/kernel/syscalls/pselect/pselect02.c | 95 ++++---------------
 1 file changed, 20 insertions(+), 75 deletions(-)

diff --git a/testcases/kernel/syscalls/pselect/pselect02.c b/testcases/kernel/syscalls/pselect/pselect02.c
index d31621d5a..8ee05f40c 100644
--- a/testcases/kernel/syscalls/pselect/pselect02.c
+++ b/testcases/kernel/syscalls/pselect/pselect02.c
@@ -1,24 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2014 Fujitsu Ltd.
  * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU Library General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
- *
  */
-/*
- * Test Description:
+
+/*\
+ * [Description]
+ *
  *  Verify that,
  *   1. pselect() fails with -1 return value and sets errno to EBADF
  *      if a file descriptor that was already closed.
@@ -28,91 +16,48 @@
  *      if the value contained within timeout was invalid.
  */

-#include <errno.h>
-#include "test.h"
-#include "safe_macros.h"
-
-TCID_DEFINE(pselect02);
+#include "tst_test.h"

 static fd_set read_fds;
 static struct timespec time_buf;

-static struct test_case_t {
+static struct tcase {
 	int nfds;
 	fd_set *readfds;
 	struct timespec *timeout;
 	int exp_errno;
-} test_cases[] = {
+} tcases[] = {
 	{128, &read_fds, NULL, EBADF},
 	{-1, NULL, NULL, EINVAL},
 	{128, NULL, &time_buf, EINVAL},
 };

-int TST_TOTAL = ARRAY_SIZE(test_cases);
-
-static void setup(void);
-static void cleanup(void);
-static void pselect_verify(const struct test_case_t *);
-
-int main(int argc, char **argv)
-{
-	int lc, i;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		for (i = 0; i < TST_TOTAL; i++)
-			pselect_verify(&test_cases[i]);
-	}
-
-	cleanup();
-	tst_exit();
-}
-
 static void setup(void)
 {
 	int fd;

-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	fd = SAFE_OPEN(cleanup, "test_file", O_RDWR | O_CREAT, 0777);
+	fd = SAFE_OPEN("test_file", O_RDWR | O_CREAT, 0777);

 	FD_ZERO(&read_fds);
 	FD_SET(fd, &read_fds);

-	SAFE_CLOSE(cleanup, fd);
+	SAFE_CLOSE(fd);

 	time_buf.tv_sec = -1;
 	time_buf.tv_nsec = 0;
 }

-static void pselect_verify(const struct test_case_t *test)
+static void pselect_verify(unsigned int i)
 {
-	TEST(pselect(test->nfds, test->readfds, NULL, NULL, test->timeout,
-	     NULL));
-
-	if (TEST_RETURN != -1) {
-		tst_resm(TFAIL, "pselect() succeeded unexpectedly");
-		return;
-	}
+	struct tcase *tc = &tcases[i];

-	if (TEST_ERRNO == test->exp_errno) {
-		tst_resm(TPASS | TTERRNO, "pselect() failed as expected");
-	} else {
-		tst_resm(TFAIL | TTERRNO,
-			 "pselect() failed unexpectedly; expected: %d - %s",
-			 test->exp_errno, strerror(test->exp_errno));
-	}
+	TST_EXP_FAIL(pselect(tc->nfds, tc->readfds, NULL, NULL, tc->timeout,
+		     NULL), tc->exp_errno);
 }

-static void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tst_test test = {
+        .tcnt = ARRAY_SIZE(tcases),
+        .test = pselect_verify,
+        .setup = setup,
+        .needs_tmpdir = 1,
+};
--
2.20.1




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
