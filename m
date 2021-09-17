Return-Path: <SRS0=//k7=OH=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A663C433F5
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 10:19:37 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C45CC6103C
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 10:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C45CC6103C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 56BD43C8854
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 12:19:35 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D5E983C1D1D
 for <ltp@lists.linux.it>; Fri, 17 Sep 2021 12:19:25 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1EDE71400C5C
 for <ltp@lists.linux.it>; Fri, 17 Sep 2021 12:19:25 +0200 (CEST)
Received: by mail-pl1-x62e.google.com with SMTP id bb10so5900191plb.2
 for <ltp@lists.linux.it>; Fri, 17 Sep 2021 03:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wmvGXuiV5Cu5Da4aWM+a5mt+QDgN/cLtf6UyzdXYbLg=;
 b=B05tBaCKsAb4Pu12XexZBfIYyykKNAQoKGNkcWoS2dc1gfTPZlUrO5KQC/KlMMckLl
 2VLdNYKmrnNasw6JMA+7MFlV9vFSDhDOnrTbaS39Xe3pIckSkpT8n/0Q4RL81Hx6+ZaG
 yYm0OsIRephmKgyyBnFGRlkrybeEadT+nYy+fYO74zZR9xS0ubxwMDwDkhcimLs4D7O9
 NUvpdNVp0B1XtkCRY4FCE1jqJkhkMs8/EKclEOpyr5qIwpo+eMi6l9WTHzfEi9nXYGwu
 lD7E8hOFsdbW4jidDZNpkBXup1gV8d8h43cvsAmrKwbG0mIl008gSzYieYNi3kROr3OE
 xJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wmvGXuiV5Cu5Da4aWM+a5mt+QDgN/cLtf6UyzdXYbLg=;
 b=1hT8LVw5rIoh2Mzo6ZAF+M1GaaB7odwMAglOxzsO5gtTTmcpQ6zURTQci7C5bjXoK9
 xiaDhbiOpa1AXt/DPiFnZYJK7aPed/W9hTeNy0/4a7Zco+x4RsKwuiVn707l+7F1p4vB
 kWsuHMMADl9qvsjPJxERUVNXU0NPS/VK8mRPbOo/5Ey5xDMDamkFVPaZKncZJUYfDFPB
 SVgAqIIbfyYlfBHRW7As8omA1GWv34k4gmBSP8d/y/QJGqSVLe311HLa/a2zfJ880dWP
 evr86lpu5iA3NGR+SOEUyiM8kz12ZRuXNsjyXFI/JCnrm3YyhDGSvU4m5mXRl/mcFPav
 rLmQ==
X-Gm-Message-State: AOAM531m0I8xgkRRKZlyIY76vokJJhjcZQAfV0tV7oFj4O354EvnLKsw
 RUSI6Bc/E8dioxQ7+uNIJpmcmgSGmJ2PWdWu
X-Google-Smtp-Source: ABdhPJyCPvN7sp0iQE/p6T3nOts8lhr9cMbHs0VPTjY46JYxgQMmOqbgbavQj0vGC2SFaHOCY0VR+g==
X-Received: by 2002:a17:90a:14c4:: with SMTP id
 k62mr11467136pja.154.1631873963636; 
 Fri, 17 Sep 2021 03:19:23 -0700 (PDT)
Received: from fedora34.. (125x103x255x1.ap125.ftth.ucom.ne.jp.
 [125.103.255.1])
 by smtp.gmail.com with ESMTPSA id l1sm10208453pju.15.2021.09.17.03.19.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Sep 2021 03:19:23 -0700 (PDT)
From: QI Fuli <fukuri.sai@gmail.com>
X-Google-Original-From: QI Fuli <qi.fuli@fujitsu.com>
To: ltp@lists.linux.it
Date: Fri, 17 Sep 2021 19:19:06 +0900
Message-ID: <20210917101907.2657-2-qi.fuli@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210917101907.2657-1-qi.fuli@fujitsu.com>
References: <20210917101907.2657-1-qi.fuli@fujitsu.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] syscalls/dup3_01: Rewrite and convert to new
 API
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
Content-Type: multipart/mixed; boundary="===============0659732914=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210917101906.559qwBMB2919DeU6zuFOggLKkglRVnLU6UXzmTHy7_I@z>

--===============0659732914==
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

From: QI Fuli <qi.fuli@fujitsu.com>

    - divide into two testcases
    - convert to new API

Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
---
 testcases/kernel/syscalls/dup3/dup3_01.c | 159 +++++++----------------
 1 file changed, 47 insertions(+), 112 deletions(-)

diff --git a/testcases/kernel/syscalls/dup3/dup3_01.c b/testcases/kernel/syscalls/dup3/dup3_01.c
index 6a44ec809..3b3d9ae0d 100644
--- a/testcases/kernel/syscalls/dup3/dup3_01.c
+++ b/testcases/kernel/syscalls/dup3/dup3_01.c
@@ -1,120 +1,55 @@
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
-
-#include "test.h"
-#include "lapi/fcntl.h"
-#include "lapi/syscalls.h"
-
-char *TCID = "dup3_01";
-int TST_TOTAL = 1;
-
-void cleanup(void)
-{
-	tst_rmdir();
-}
-
-void setup(void)
-{
-	TEST_PAUSE;
-	tst_tmpdir();
-}
-
-int main(int argc, char *argv[])
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+
+static struct tcase {
+	int o_flag;
+	bool coe_flag;
+	char *desc;
+} tcases [] = {
+	{0, true, "dup3(1, 4, 0)"},
+	{O_CLOEXEC, false, "dup3(1, 4, O_CLOEXEC)"},
+};
+
+static void run(unsigned int i)
 {
-	int fd, coe;
+	int fd, ret;
+	struct tcase *tc = tcases + i;
 
-	tst_parse_opts(argc, argv, NULL, NULL);
+	TEST(dup3(1, 4, tc->o_flag));
 
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
+		return;
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
-	}
-	if ((coe & FD_CLOEXEC) == 0) {
-		tst_brkm(TFAIL, cleanup,
-			 "dup3(O_CLOEXEC) set close-on-exec flag");
-	}
-	close(fd);
-	tst_resm(TPASS, "dup3(O_CLOEXEC) PASSED");
+	ret = SAFE_FCNTL(fd, F_GETFD);
+	if ((ret & FD_CLOEXEC) == tc->coe_flag)
+		tst_res(TFAIL, "%s set close-on-exec flag", tc->desc);
+	else
+		tst_res(TPASS, "%s PASSED", tc->desc);
+
+	SAFE_CLOSE(fd);
+};
 
-	cleanup();
-	tst_exit();
-}
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+};
-- 
2.31.1


--===============0659732914==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0659732914==--
