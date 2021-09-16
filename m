Return-Path: <SRS0=QfDu=OG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F81C433F5
	for <ltp@archiver.kernel.org>; Thu, 16 Sep 2021 14:46:44 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81365604DC
	for <ltp@archiver.kernel.org>; Thu, 16 Sep 2021 14:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 81365604DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE5AA3C915F
	for <ltp@archiver.kernel.org>; Thu, 16 Sep 2021 16:46:41 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A8FD73C917A
 for <ltp@lists.linux.it>; Thu, 16 Sep 2021 16:46:26 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 31BC36009F3
 for <ltp@lists.linux.it>; Thu, 16 Sep 2021 16:46:26 +0200 (CEST)
Received: by mail-pj1-x102b.google.com with SMTP id
 w19-20020a17090aaf9300b00191e6d10a19so4946126pjq.1
 for <ltp@lists.linux.it>; Thu, 16 Sep 2021 07:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0rHhMGXoWz0JSlrDoJyKhmK5uu8LzkRw62qKOCUI+Tc=;
 b=efVk79eTVjua2dpHjsPm6UQurwbvm2SjH0gAu/tYmmLMOuRnWzfs1Cnvd0sqEL9pch
 PwYzHTS2X2g1QbF57Wde2kcLWeTzcienOa5bWOlXNJhixk/VPv/MUoJGPHh/huJ5cY3I
 abDvRrDX4FN04nG8emvC14lPlvVqMPT8Tb8aSN7Xh8MrjqVxnSEY373of0JZaNj9giAT
 aDaRiFRzAdcoTJfdeDhu4kZKBP5RjPCBIskE7tYPni2IrYXgVmsFpgrrBdOSgzAU5h7g
 6ySTgAklnX0TUXdCyUD44HKqBrdZEoyl6WhqUBj9p2hpeHvNYpyrh+4TGsdjRqR/pxks
 s5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0rHhMGXoWz0JSlrDoJyKhmK5uu8LzkRw62qKOCUI+Tc=;
 b=qoNlf2Rf4ERMmwY1sujNHpDwL1VwVFptkTdnm9FLcj08gK3p/EZF1ktJZ4n79VD94G
 6YAhtbveDTit06IJhdQBRI99bq5SCeA8h8lHUjdENVNOMOfsKa6jOBz2wim9Qbvozl14
 pFE5mtsyYzuHk0SIAKMTJZnd4r18yt9//NzbOxK83zQL1TzCzY+BHPNTnGhmz5Fy5BRF
 c4GH9rmJzntVT8KfJuwzKIU9gzAU9E4hntc5lY3ehQPPP+9qjPX7U2CVi5RkgY4gLMgV
 JS8049jF4Lvs1zofQXbQoTlsuwrvOz8yxUIFyXxN9DY2E8stlxrNIonArk3YcmAKWqp8
 uSZw==
X-Gm-Message-State: AOAM532R//mefxIoAxKiiSeoGQVqoXBKcLoGS4KTjsChcOQyfETlq/tu
 1FclFrMnBN5fo0fNS2l6IWnIn0l3mPHmJRxI
X-Google-Smtp-Source: ABdhPJyYx5bJSOIzT7KZdeoA7F2Q9pg5vHuRBVCBTSUAgn/AE8oN8UwgNsh6D1WNMXZ7q6WllXMycg==
X-Received: by 2002:a17:902:680a:b0:139:edc9:ed4c with SMTP id
 h10-20020a170902680a00b00139edc9ed4cmr5168641plk.5.1631803584737; 
 Thu, 16 Sep 2021 07:46:24 -0700 (PDT)
Received: from fedora34.. (125x103x255x1.ap125.ftth.ucom.ne.jp.
 [125.103.255.1])
 by smtp.gmail.com with ESMTPSA id v25sm3299097pfm.202.2021.09.16.07.46.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Sep 2021 07:46:24 -0700 (PDT)
From: QI Fuli <fukuri.sai@gmail.com>
X-Google-Original-From: QI Fuli <qi.fuli@fujitsu.com>
To: ltp@lists.linux.it
Date: Thu, 16 Sep 2021 23:46:05 +0900
Message-ID: <20210916144605.36204-3-qi.fuli@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210916144605.36204-1-qi.fuli@fujitsu.com>
References: <20210916144605.36204-1-qi.fuli@fujitsu.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] syscalls/dup3_02: Convert to new API
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
Message-ID: <20210916144605.uCXT9slBMLpjR_-KANwJTvGIACOUTQgE4hTHqPtoO50@z>

From: QI Fuli <qi.fuli@fujitsu.com>

Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
---
 testcases/kernel/syscalls/dup3/dup3_02.c | 111 +++++------------------
 1 file changed, 25 insertions(+), 86 deletions(-)

diff --git a/testcases/kernel/syscalls/dup3/dup3_02.c b/testcases/kernel/syscalls/dup3/dup3_02.c
index e49ec3575..76c4e6e35 100644
--- a/testcases/kernel/syscalls/dup3/dup3_02.c
+++ b/testcases/kernel/syscalls/dup3/dup3_02.c
@@ -1,118 +1,57 @@
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
 
-/*
- * Description:
+/*\
+ * [Description]
  * Verify that,
  *  1. dup3() fails with -1 return value and sets errno to EINVAL
  *     if flags contain an invalid value or oldfd was equal to newfd.
  */
 
-#define _GNU_SOURCE
-
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
+#include "tst_test.h"
+#include "tst_safe_macros.h"
 #include "lapi/syscalls.h"
 
-
-static void setup(void);
-static void cleanup(void);
-
-#define INVALID_FLAG	-1
-
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
+	TST_EXP_FAIL2(tst_syscall(__NR_dup3, *tc->oldfd, *tc->newfd, tc->flags),
+				EINVAL,	"syscall(__NR_dup3, %d, %d, %d)",
+				*tc->oldfd, *tc->newfd, tc->flags);
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
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
