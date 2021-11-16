Return-Path: <SRS0=zuCx=QD=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A002BC433EF
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 02:54:39 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 139B9619E8
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 02:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 139B9619E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A9B8B3C873F
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 03:54:37 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 935EC3C8772
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 03:54:17 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E0946601475
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 03:54:16 +0100 (CET)
Received: by mail-pl1-x62b.google.com with SMTP id n8so16142895plf.4
 for <ltp@lists.linux.it>; Mon, 15 Nov 2021 18:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iyzyfInJ9ME5ToB3inVowEbqIS4d/mBPWphNVpheWVY=;
 b=dGelCSWxxT00qf4elI/lhVDY/Uvg0h43dp9Jz9PNrRgs6i9diIsjtELhMTlZRpRf1c
 x0MImjBeMWgNEDYrtuo73P0LoSNXgf7yt7HmzRPGaEKEgGQ30T4OqZ/CqL5W5jyA0JKy
 PQ/+kTwAS28ZVorLKrPym6nNeRCFw6vI2Y2eNbfToMgLsgHanjZDUgyHKxjrwTn6YCc2
 DIdjE2MJyzAdYDKzRKTyu+WMBcnQyZ1wUMCRHukqHvik1inxlN0je8zfh4RKuxTSynSi
 ZuGoxueo6/l4qijZKHaJAjW2Dqug/T9qddzJpX84zCHwlF424gaLUZOMrnsbomMscqR2
 bQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iyzyfInJ9ME5ToB3inVowEbqIS4d/mBPWphNVpheWVY=;
 b=GWmhXWjqursTMftJqdX+aT6iSMMXKohl6IhkpusKYW3HNqQ2hiini6U5ClPWj4w4SX
 IndCUxjt4V8JsbtzypowOkd8R/V5it/arE6nOL1jCAYt3sTflYISC5I6mM9zvVpbWxzm
 r02OUQp/khiY4LrYXDk80zSkgHcd6+WzcVFbEX62W2nvF8aS51UkI584DCbKb3tyTWNI
 qVwQtln+GPZy+7hBQEvXC0rTVS+EkWA239WjBSei0NxhRM84AofMNopLxX0dOuLyPM0A
 FvXAZuEj5cxjTVd9+OkZ/Si/1bUEeNnAgT8e/phWYawlf8WVF8SOzJk6KS15Zo7AFrZo
 JoxA==
X-Gm-Message-State: AOAM533+kZoYUpUHKi4O3/fqDz52Y0p19IL1SIqO7wu0KfyTXPxfs3OL
 lDxhR96d4Kmbhshzy2qZ2k4hpS/TUFJYbw==
X-Google-Smtp-Source: ABdhPJxhrXhFEKYtQuss9y1flPrJpIKIXPd6PEAy6q9TL1jdWkR3Ym2OusFPzIqVZZIgipQccufEzw==
X-Received: by 2002:a17:902:b7c6:b0:141:9a3a:f213 with SMTP id
 v6-20020a170902b7c600b001419a3af213mr40978374plz.15.1637031255293; 
 Mon, 15 Nov 2021 18:54:15 -0800 (PST)
Received: from fedora34.. (125x103x255x1.ap125.ftth.ucom.ne.jp.
 [125.103.255.1])
 by smtp.gmail.com with ESMTPSA id e2sm13000922pgm.48.2021.11.15.18.54.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Nov 2021 18:54:14 -0800 (PST)
From: QI Fuli <fukuri.sai@gmail.com>
X-Google-Original-From: QI Fuli <qi.fuli@fujitsu.com>
To: ltp@lists.linux.it
Date: Tue, 16 Nov 2021 11:53:53 +0900
Message-Id: <20211116025354.2566-2-qi.fuli@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211116025354.2566-1-qi.fuli@fujitsu.com>
References: <20211116025354.2566-1-qi.fuli@fujitsu.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] syscalls/dup3_01: Rewrite dup3_01 and convert
 it to new API
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
Content-Type: multipart/mixed; boundary="===============1640321435=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1640321435==
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

From: QI Fuli <qi.fuli@fujitsu.com>

   - divide into two testcases
   - convert to new API 

Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
---
 testcases/kernel/syscalls/dup3/dup3_01.c | 163 ++++++++---------------
 1 file changed, 57 insertions(+), 106 deletions(-)

diff --git a/testcases/kernel/syscalls/dup3/dup3_01.c b/testcases/kernel/syscalls/dup3/dup3_01.c
index 6a44ec809..e8ed3a299 100644
--- a/testcases/kernel/syscalls/dup3/dup3_01.c
+++ b/testcases/kernel/syscalls/dup3/dup3_01.c
@@ -1,120 +1,71 @@
-/******************************************************************************/
-/*                                                                            */
-/* Copyright (c) Ulrich Drepper <drepper@redhat.com>                          */
-/* Copyright (c) International Business Machines  Corp., 2009                 */
-/*                                                                            */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/******************************************************************************/
-/******************************************************************************/
-/*                                                                            */
-/* File:        dup3_01.c                                                     */
-/*                                                                            */
-/* Description: This Program tests the new system call introduced in 2.6.27.  */
-/*              Ulrich´s comment as in:                                       */
-/* http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=336dd1f70ff62d7dd8655228caed4c5bfc818c56 */
-/*              says:                                                         */
-/* This patch adds the new dup3 syscall.  It extends the old dup2 syscall by  */
-/* one parameter which is meant to hold a flag value.  Support for the        */
-/* O_CLOEXEC flag is added in this patch. The following test must be adjusted */
-/* for architectures other than x86 and x86-64 and in case the                */
-/* syscall numbers changed.                                                   */
-/*                                                                            */
-/* Usage:  <for command-line>                                                 */
-/* dup3_01 [-c n] [-e][-i n] [-I x] [-p x] [-t]                               */
-/*      where,  -c n : Run n copies concurrently.                             */
-/*              -e   : Turn on errno logging.                                 */
-/*              -i n : Execute test n times.                                  */
-/*              -I x : Execute test for x seconds.                            */
-/*              -P x : Pause for x seconds between iterations.                */
-/*              -t   : Turn on syscall timing.                                */
-/*                                                                            */
-/* Total Tests: 1                                                             */
-/*                                                                            */
-/* Test Name:   dup3_01                                                       */
-/*                                                                            */
-/* Author:      Ulrich Drepper <drepper@redhat.com>                           */
-/*                                                                            */
-/* History:     Created - Jan 13 2009 - Ulrich Drepper <drepper@redhat.com>   */
-/*              Ported to LTP                                                 */
-/*                      - Jan 13 2009 - Subrata <subrata@linux.vnet.ibm.com>  */
-/******************************************************************************/
-#include <fcntl.h>
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Ulrich Drepper <drepper@redhat.com>
+ * Copyright (c) International Business Machines  Corp., 2009
+ * Created - Jan 13 2009 - Ulrich Drepper <drepper@redhat.com>
+ * Ported to LTP - Jan 13 2009 - Subrata <subrata@linux.vnet.ibm.com>
+ */
+/*\
+ * [Description]
+ * Testcase to check whether dup3() supports O_CLOEXEC flag.
+ */
+
+#define _GNU_SOURCE
+
 #include <stdio.h>
-#include <time.h>
-#include <unistd.h>
-#include <sys/syscall.h>
+#include <stdbool.h>
 #include <errno.h>
+#include <unistd.h>
+#include "tst_test.h"
+#include "tst_safe_macros.h"
 
-#include "test.h"
-#include "lapi/fcntl.h"
-#include "lapi/syscalls.h"
-
-char *TCID = "dup3_01";
-int TST_TOTAL = 1;
+static int fd = -1;
 
-void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tcase {
+	int coe_flag;
+	char *desc;
+} tcases [] = {
+	{0, "dup3(1, 4, 0)"},
+	{O_CLOEXEC, "dup3(1, 4, O_CLOEXEC)"},
+};
 
-void setup(void)
+static void cleanup(void)
 {
-	TEST_PAUSE;
-	tst_tmpdir();
+	if (fd > 0)
+		close(fd);
 }
-
-int main(int argc, char *argv[])
+static void run(unsigned int i)
 {
-	int fd, coe;
+	int ret;
+	struct tcase *tc = tcases + i;
 
-	tst_parse_opts(argc, argv, NULL, NULL);
+	TEST(dup3(1, 4, tc->coe_flag));
 
-	if ((tst_kvercmp(2, 6, 27)) < 0)
-		tst_brkm(TCONF, NULL,
-			 "This test can only run on kernels that are 2.6.27 and higher");
-	setup();
-
-	fd = ltp_syscall(__NR_dup3, 1, 4, 0);
-	if (fd == -1) {
-		tst_brkm(TFAIL | TERRNO, cleanup, "dup3(0) failed");
-	}
-	coe = fcntl(fd, F_GETFD);
-	if (coe == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup, "fcntl failed");
+	fd = TST_RET;
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "%s failed", tc->desc);
+		goto free;
 	}
-	if (coe & FD_CLOEXEC) {
-		tst_brkm(TFAIL, cleanup, "dup3(0) set close-on-exec flag");
-	}
-	close(fd);
 
-	fd = ltp_syscall(__NR_dup3, 1, 4, O_CLOEXEC);
-	if (fd == -1) {
-		tst_brkm(TFAIL | TERRNO, cleanup, "dup3(O_CLOEXEC) failed");
-	}
-	coe = fcntl(fd, F_GETFD);
-	if (coe == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup, "fcntl failed");
+	ret = SAFE_FCNTL(fd, F_GETFD);
+	if (tc->coe_flag) {
+		if (ret & FD_CLOEXEC)
+			tst_res(TPASS, "%s set close-on-exec flag", tc->desc);
+		else	
+			tst_res(TFAIL, "%s set close-on-exec flag", tc->desc);
+	} else {
+		if (ret & FD_CLOEXEC)
+			tst_res(TFAIL, "%s set close-on-exec flag", tc->desc);
+		else	
+			tst_res(TPASS, "%s set close-on-exec flag", tc->desc);
 	}
-	if ((coe & FD_CLOEXEC) == 0) {
-		tst_brkm(TFAIL, cleanup,
-			 "dup3(O_CLOEXEC) set close-on-exec flag");
-	}
-	close(fd);
-	tst_resm(TPASS, "dup3(O_CLOEXEC) PASSED");
 
-	cleanup();
-	tst_exit();
-}
+free:
+	SAFE_CLOSE(fd);
+};
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+	.cleanup = cleanup,
+};
-- 
2.31.1


--===============1640321435==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1640321435==--
