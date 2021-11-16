Return-Path: <SRS0=zuCx=QD=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9988FC433EF
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 02:54:49 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2466A619E8
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 02:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2466A619E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF7753C8703
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 03:54:47 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E12A3C87B5
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 03:54:19 +0100 (CET)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 368D820034C
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 03:54:19 +0100 (CET)
Received: by mail-pf1-x42a.google.com with SMTP id o4so16692921pfp.13
 for <ltp@lists.linux.it>; Mon, 15 Nov 2021 18:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6ziLB/GuThq2NzeISQ2S1C/jfz7A1AIszKsxw1Pu6E8=;
 b=lVd0jg3gOFac4Cq5TewCpLs3CrUPFrnOxzRw2+5sKJRz/u0FD62c4R1O2bnRI8qT+N
 iwY+tBRJW+qdpSMfs0DVExazC+vMP5cBZxtavGg2uunZzYIYApKMD/TyC0qEQI/uUPBN
 7T6y/jo55vnDuZHG4/boJR4hWhFUd7yA+BU5x0E4Ol2/kPys4xJU5RxBCD9ltWd6IE9k
 urw2OvtchJ/bpjO1sG1Z/j4lC00KUG3AhJ0Hs5oe3VVbSJobBuSkk2/VG76lWcmvr/dt
 galLBhm9NAl5aDLGxQTfPWT+ikBDBGqaJ7QJ/CjpkFusOA8FbgZcD+jX8iCpQru1CbBb
 2ETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6ziLB/GuThq2NzeISQ2S1C/jfz7A1AIszKsxw1Pu6E8=;
 b=MO1Y4Z9O4TYWJqlK5+oja1ShbiSoWgDsV4iL9B4F8StlC8irQwx1xp76241ooqgOdW
 0FN1KDFSDODTQU/N/FZWlHCsoi9GEq5eFAVw1EuyEUX42A34c/095YX4+udu3ACAAGb7
 +Ivp/xTqDhW2Kae201U5cUtnk5fiCo9LUreebaD8Lu+TjEpYdwQbtah66linZgedrAem
 iLFULbddfggbenCMEcXy+Xr6U1kC93OtC0ujlt2fSql4o6ODqdTDfAGDerqmL3qxSHzY
 FHa2SlxrSQrH1pdPfpN0bBOo8ujXIQObRv1cMcgP3jIy4trXAxFVorn4wtgBu8waedBH
 3QVA==
X-Gm-Message-State: AOAM533IQThK6xPNkBgXJvz9qHwsA37Xn7fPEbyGWAxczGeBHiryN6RO
 MESkTLd9JNnefClHK5hKpNMgzftR6YPdWQ==
X-Google-Smtp-Source: ABdhPJzgpAXVY/OxZlPuPI2WE0bclaC91MEbgbXVm/bx8sPK4VpqWbbNx5YAHXCXfUmUBl0OtY9Rnw==
X-Received: by 2002:a63:1a4e:: with SMTP id a14mr2554395pgm.273.1637031257617; 
 Mon, 15 Nov 2021 18:54:17 -0800 (PST)
Received: from fedora34.. (125x103x255x1.ap125.ftth.ucom.ne.jp.
 [125.103.255.1])
 by smtp.gmail.com with ESMTPSA id e2sm13000922pgm.48.2021.11.15.18.54.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Nov 2021 18:54:17 -0800 (PST)
From: QI Fuli <fukuri.sai@gmail.com>
X-Google-Original-From: QI Fuli <qi.fuli@fujitsu.com>
To: ltp@lists.linux.it
Date: Tue, 16 Nov 2021 11:53:54 +0900
Message-Id: <20211116025354.2566-3-qi.fuli@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211116025354.2566-1-qi.fuli@fujitsu.com>
References: <20211116025354.2566-1-qi.fuli@fujitsu.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] syscalls/dup3_02: Convert to new API
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
Cc: QI Fuli <qi.fuli@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: QI Fuli <qi.fuli@fujitsu.com>

Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
---
 testcases/kernel/syscalls/dup3/dup3_02.c | 119 ++++++-----------------
 1 file changed, 30 insertions(+), 89 deletions(-)

diff --git a/testcases/kernel/syscalls/dup3/dup3_02.c b/testcases/kernel/syscalls/dup3/dup3_02.c
index e49ec3575..e31a758c1 100644
--- a/testcases/kernel/syscalls/dup3/dup3_02.c
+++ b/testcases/kernel/syscalls/dup3/dup3_02.c
@@ -1,118 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2013 Fujitsu Ltd.
  * Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
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
  */
-
-/*
- * Description:
- * Verify that,
- *  1. dup3() fails with -1 return value and sets errno to EINVAL
- *     if flags contain an invalid value or oldfd was equal to newfd.
+/*\
+ * [Description]
+ * Test for various EINVAL error.
+ * - EINVAL - oldfd is equal to newfd without using O_CLOEXEC flag
+ * - EINVAL - oldfd is equal to newfd with using O_CLOEXEC flag
+ * - EINVAL - flags contain an invalid value
  */
 
 #define _GNU_SOURCE
+#define INVALID_FLAG -1
 
-#include <stdio.h>
 #include <errno.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <string.h>
-#include <signal.h>
-#include <sys/types.h>
-
-#include "test.h"
-#include "safe_macros.h"
-#include "lapi/fcntl.h"
-#include "lapi/syscalls.h"
-
-
-static void setup(void);
-static void cleanup(void);
-
-#define INVALID_FLAG	-1
+#include "tst_test.h"
+#include "tst_safe_macros.h"
 
 static int old_fd;
-static int new_fd;
+static int new_fd = 5;
 
-static struct test_case_t {
+static struct tcase {
 	int *oldfd;
 	int *newfd;
 	int flags;
-	int exp_errno;
-} test_cases[] = {
-	{&old_fd, &old_fd, O_CLOEXEC, EINVAL},
-	{&old_fd, &old_fd, 0, EINVAL},
-	{&old_fd, &new_fd, INVALID_FLAG, EINVAL}
+} tcases[] = {
+	{&old_fd, &old_fd, O_CLOEXEC},
+	{&old_fd, &old_fd, 0},
+	{&old_fd, &new_fd, INVALID_FLAG}
 };
 
-char *TCID = "dup3_02";
-int TST_TOTAL = ARRAY_SIZE(test_cases);
-
-int main(int ac, char **av)
+static void run(unsigned int i)
 {
-	int lc;
-	int i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
+	struct tcase *tc = tcases + i;
 
-		for (i = 0; i < TST_TOTAL; i++) {
-			TEST(ltp_syscall(__NR_dup3, *(test_cases[i].oldfd),
-			     *(test_cases[i].newfd), test_cases[i].flags));
-
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "dup3 succeeded unexpectedly");
-				continue;
-			}
-
-			if (TEST_ERRNO == test_cases[i].exp_errno) {
-				tst_resm(TPASS | TTERRNO,
-					 "dup3 failed as expected");
-			} else {
-				tst_resm(TFAIL | TTERRNO,
-					 "dup3 failed unexpectedly; expected:"
-					 "%d - %s", test_cases[i].exp_errno,
-					 strerror(test_cases[i].exp_errno));
-			}
-		}
-	}
-
-	cleanup();
-	tst_exit();
+	TST_EXP_FAIL2(dup3(*tc->oldfd, *tc->newfd, tc->flags), EINVAL,
+		"dup3(%d, %d, %d)", *tc->oldfd, *tc->newfd, tc->flags);
 }
 
 static void setup(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	tst_tmpdir();
-
-	TEST_PAUSE;
-
-	old_fd = SAFE_CREAT(cleanup, "testeinval.file", 0644);
-	new_fd = -1;
+	old_fd = SAFE_CREAT("testeinval.file", 0644);
 }
 
 static void cleanup(void)
 {
 	if (old_fd > 0)
-		SAFE_CLOSE(NULL, old_fd);
-
-	tst_rmdir();
+		SAFE_CLOSE(old_fd);
 }
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
