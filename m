Return-Path: <SRS0=QfDu=OG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618B7C433EF
	for <ltp@archiver.kernel.org>; Thu, 16 Sep 2021 14:46:53 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA907604DC
	for <ltp@archiver.kernel.org>; Thu, 16 Sep 2021 14:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AA907604DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 650BC3C8980
	for <ltp@archiver.kernel.org>; Thu, 16 Sep 2021 16:46:51 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD0093C917C
 for <ltp@lists.linux.it>; Thu, 16 Sep 2021 16:46:24 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EC874200976
 for <ltp@lists.linux.it>; Thu, 16 Sep 2021 16:46:23 +0200 (CEST)
Received: by mail-pj1-x102b.google.com with SMTP id
 n13-20020a17090a4e0d00b0017946980d8dso7697178pjh.5
 for <ltp@lists.linux.it>; Thu, 16 Sep 2021 07:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qPb1cgBtrL2HvP6ZotJQ07e2VSsvHexV74nqpsAw6kE=;
 b=iJBxPB0bSguGoqyLSAqH2LbdS4UWqg9RVxTAiIUAU6DRAufDU4X4uIBbl07dQQ4xF7
 qqcrnfPd9Ltz8a21VBh9jGd05U9Bpr5BfIfvU3/EwlRRpnX01KbEJwRiMeVt5kT7NXvg
 0YAE6qDmRqYPhPPP0jbq+k7UkPmIO3OzoYqiJI2LvLDS2ftEoFBrskzJmVYh95s8G/1u
 JvLNX1P5H13Pq5tydzbuZNU3ZorZTyE/3yXjw1cWxldNTS+ynhsd5T+7XC/KSj6boTlp
 gkxJHLDll7E/Mjs05w1lS//6MApq5st4P/6Wf2x9w7VkR2t1uuysEPkp9+TKDkl/4f7/
 vqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qPb1cgBtrL2HvP6ZotJQ07e2VSsvHexV74nqpsAw6kE=;
 b=6MKSIX8WODK+lWei1N3xgBNmtGG634sLTRFsrU2FkjIHi20RVfYYCTJH4XY6ZXq90h
 70FbN1tR1cCKWKx0E+9QvJ/bRniYOQeheX7Xfxm3grAvjKu5TdAJXnAduhlSymwl+G2J
 0Aa6bvqJIY8Y+Y2tHegJhd11xAkggwHLaZua5jbm3QX2p87GpFdMrTz/oS5zm4jgB4Ou
 WTwopXh/XFfd7esNPtpV02GQMml1eno0mlCdrf4gRCGxCJW8hXO/RfzJJVV/MUMDkT3u
 MykHwCgJYT6KfXMmKtFGmABQRW3l0eRgeDousJEi1acteuyJcJsFKVAlYRxGT8uKtnfa
 2Ydw==
X-Gm-Message-State: AOAM533kXbiJCpN9cVYyVcQPhqBy+eWArLHCiwQ4IiGTL6Rx/Ubozknm
 Ghanq80zwHbhH7z2W7TM0GR/RImBJH7R27yc
X-Google-Smtp-Source: ABdhPJw5vEJSfGs68aUw5ol1P2en+JIEgJ8nxctvK2e0lvkYI3XltDZSjfgWemN4wCKLYqBNeOi9OA==
X-Received: by 2002:a17:90a:4498:: with SMTP id
 t24mr6384673pjg.235.1631803582406; 
 Thu, 16 Sep 2021 07:46:22 -0700 (PDT)
Received: from fedora34.. (125x103x255x1.ap125.ftth.ucom.ne.jp.
 [125.103.255.1])
 by smtp.gmail.com with ESMTPSA id v25sm3299097pfm.202.2021.09.16.07.46.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Sep 2021 07:46:22 -0700 (PDT)
From: QI Fuli <fukuri.sai@gmail.com>
X-Google-Original-From: QI Fuli <qi.fuli@fujitsu.com>
To: ltp@lists.linux.it
Date: Thu, 16 Sep 2021 23:46:04 +0900
Message-ID: <20210916144605.36204-2-qi.fuli@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210916144605.36204-1-qi.fuli@fujitsu.com>
References: <20210916144605.36204-1-qi.fuli@fujitsu.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] syscalls/dup3_01: Rewrite and convert to new API
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
Content-Type: multipart/mixed; boundary="===============0107704679=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210916144604.m9092S6oWd9ZBfjAVaf0i5t4EdzlsxtBJ6in4NAurG4@z>

--===============0107704679==
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

From: QI Fuli <qi.fuli@fujitsu.com>

    - divide into two testcases
    - convert to new API

Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
---
 testcases/kernel/syscalls/dup3/dup3_01.c | 157 ++++++++---------------
 1 file changed, 50 insertions(+), 107 deletions(-)

diff --git a/testcases/kernel/syscalls/dup3/dup3_01.c b/testcases/kernel/syscalls/dup3/dup3_01.c
index 6a44ec809..9a233f51b 100644
--- a/testcases/kernel/syscalls/dup3/dup3_01.c
+++ b/testcases/kernel/syscalls/dup3/dup3_01.c
@@ -1,120 +1,63 @@
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
+ *	Created - Jan 13 2009 - Ulrich Drepper <drepper@redhat.com>
+ *	Ported to LTP - Jan 13 2009 - Subrata <subrata@linux.vnet.ibm.com>
+ */
+
+/*\
+ * [Description]
+ * 	Testcase to check whether dup3() supports O_CLOEXEC flag.
+ */
+
 #include <stdio.h>
-#include <time.h>
-#include <unistd.h>
-#include <sys/syscall.h>
+#include <stdbool.h>
 #include <errno.h>
 
-#include "test.h"
-#include "lapi/fcntl.h"
+#include "tst_test.h"
 #include "lapi/syscalls.h"
-
-char *TCID = "dup3_01";
-int TST_TOTAL = 1;
-
-void cleanup(void)
+#include "tst_safe_macros.h"
+
+static struct tcase {
+	int oflag;
+	bool tflag;
+	char *desc;
+} tcases [] = {
+	{0, true, "dup3(0)"},
+	{O_CLOEXEC, false, "dup3(O_CLOEXEC)"},
+};
+
+static void setup(void)
 {
-	tst_rmdir();
-}
-
-void setup(void)
-{
-	TEST_PAUSE;
-	tst_tmpdir();
-}
+	if ((tst_kvercmp(2, 6, 27)) < 0)
+		tst_brk(TCONF,
+			"This test can only run on kernels 2.6.27 and higher");
+};
 
-int main(int argc, char *argv[])
+static void run(unsigned int i)
 {
 	int fd, coe;
+	struct tcase *tc = tcases + i;
 
-	tst_parse_opts(argc, argv, NULL, NULL);
+	TEST(tst_syscall(__NR_dup3, 1, 4, tc->oflag));
 
-	if ((tst_kvercmp(2, 6, 27)) < 0)
-		tst_brkm(TCONF, NULL,
-			 "This test can only run on kernels that are 2.6.27 and higher");
-	setup();
+	fd = TST_RET;
+	if (TST_RET == -1)
+		tst_brk(TFAIL | TTERRNO, "%s failed", tc->desc);
 
-	fd = ltp_syscall(__NR_dup3, 1, 4, 0);
-	if (fd == -1) {
-		tst_brkm(TFAIL | TERRNO, cleanup, "dup3(0) failed");
-	}
-	coe = fcntl(fd, F_GETFD);
-	if (coe == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup, "fcntl failed");
-	}
-	if (coe & FD_CLOEXEC) {
-		tst_brkm(TFAIL, cleanup, "dup3(0) set close-on-exec flag");
-	}
-	close(fd);
+	coe = SAFE_FCNTL(fd, F_GETFD);
+	if ((coe & FD_CLOEXEC) == tc->tflag)
+		tst_brk(TFAIL, "%s set close-on-exec flag", tc->desc);
+	else
+		tst_res(TPASS, "%s PASSED", tc->desc);
 
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
+	SAFE_CLOSE(fd);
+};
 
-	cleanup();
-	tst_exit();
-}
+static struct tst_test test = {
+	.setup = setup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_tmpdir = 1,
+	.test = run,
+};
-- 
2.31.1


--===============0107704679==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0107704679==--
