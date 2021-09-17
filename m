Return-Path: <SRS0=//k7=OH=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92304C433EF
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 10:19:47 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3E4A60F6D
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 10:19:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D3E4A60F6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB1173C884F
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 12:19:44 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 932693C8849
 for <ltp@lists.linux.it>; Fri, 17 Sep 2021 12:19:28 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EC325600849
 for <ltp@lists.linux.it>; Fri, 17 Sep 2021 12:19:27 +0200 (CEST)
Received: by mail-pl1-x633.google.com with SMTP id v1so5862069plo.10
 for <ltp@lists.linux.it>; Fri, 17 Sep 2021 03:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LiPkVNVEwEF7mIHDgJRAH/2Nwi0eigtvOAqIhFuQtA8=;
 b=duvH8eBqXwjhKtyxaa0/H8SdihUawkOHjtqLgB9agCSCnPUIPbELtp51Txl2s+MCNH
 pG3wtKaoNh/IgYNi8uaFaLqGlg7z1agccngUkEwfRhmaOSB8YC7+1mYXUsM2E0BHV7AR
 zZtYcPBMQObIBvslhJ3fhQEwJg0mVbqhdcV72MLxbSASQAcFxcnBGXfDr52+DpGWZIH0
 gIzYzI9ns+z3Jk1azRvtwp4MEP1I8ahSBpYzA6j6i6GtgyAvlhDlu/4uOH248UPVJY1B
 /ZFeUmVfLMichjlbqW41hPnID/2H63kDvvSFbsi7y08+rigl4sGIslAgcvNLqhHY4wAv
 tuxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LiPkVNVEwEF7mIHDgJRAH/2Nwi0eigtvOAqIhFuQtA8=;
 b=slvEMWwu5w0bxisVX6jp2GOdpLHn+d2zSaVM2Rvuaf5VotGhuWPoiLzqUb9YZcU9Lt
 HGRsyPnymPQzJpqrYs1SWZvmwXJ97A0l8VzpPwoniJ67ShWVMB01wag5eEAVbHYEUUuY
 4EpgTX7GPRDMwhsIFlKpBanaHqgYCS4gHeo3YDFWHajVBlxNqnNziWMabC8VQa4G5YqV
 fwnBR3PwVXUKqS59+E5n+NC9spuEemhe+SygSrNUFBucKL/5dA4vokdIk6KqwRSqrvAl
 tjjqLyoWevbMQLC6gblpWBA5JrddqDYSS0QHl/5vZkUJVElOCoJ2t5hSlEPOEbM8DdvY
 Z/tw==
X-Gm-Message-State: AOAM533FX+KeFKJdW5dXCedQRhdr084dR1KCm+lS9ujThZHZdsn5pgjX
 gPkPPTNM9Xqgc8H6yWHgyEN65yJUodEpynJe
X-Google-Smtp-Source: ABdhPJxrNEvpsUiA1a0in9i+iQCfF8cI+y12043VTs6mht8dejpRhVUGS6Ppny/KC2+jOvOZihx3HA==
X-Received: by 2002:a17:90a:1a4c:: with SMTP id
 12mr20307667pjl.195.1631873966448; 
 Fri, 17 Sep 2021 03:19:26 -0700 (PDT)
Received: from fedora34.. (125x103x255x1.ap125.ftth.ucom.ne.jp.
 [125.103.255.1])
 by smtp.gmail.com with ESMTPSA id l1sm10208453pju.15.2021.09.17.03.19.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Sep 2021 03:19:25 -0700 (PDT)
From: QI Fuli <fukuri.sai@gmail.com>
X-Google-Original-From: QI Fuli <qi.fuli@fujitsu.com>
To: ltp@lists.linux.it
Date: Fri, 17 Sep 2021 19:19:07 +0900
Message-ID: <20210917101907.2657-3-qi.fuli@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210917101907.2657-1-qi.fuli@fujitsu.com>
References: <20210917101907.2657-1-qi.fuli@fujitsu.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] syscalls/dup3_02: Convert to new API
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
Message-ID: <20210917101907.6vkRai1O5VKCtlWVvUCwjd-_CI5bmPKpw0RLJoJJ8Nk@z>

Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
---
 testcases/kernel/syscalls/dup3/dup3_02.c | 118 ++++++-----------------
 1 file changed, 29 insertions(+), 89 deletions(-)

diff --git a/testcases/kernel/syscalls/dup3/dup3_02.c b/testcases/kernel/syscalls/dup3/dup3_02.c
index e49ec3575..08a741240 100644
--- a/testcases/kernel/syscalls/dup3/dup3_02.c
+++ b/testcases/kernel/syscalls/dup3/dup3_02.c
@@ -1,118 +1,58 @@
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
+ * - EINVAL - oldfd is equal to newfd W/O using O_CLOEXEC flag
+ * - EINVAL - oldfd is equal to newfd W/ using O_CLOEXEC flag
+ * - EINVAL - flags contain an invalid value
  */
 
 #define _GNU_SOURCE
 
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
+static int new_fd = -1;
 
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
+	{&old_fd, &new_fd, -1}
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
