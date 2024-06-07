Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D30FAC27C53
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 08:42:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 23B333D0A7C
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 10:42:42 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 085453D0A72
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 10:42:26 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3B0C11A0BC5E
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 10:42:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2382221B00;
 Fri,  7 Jun 2024 08:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717749745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tfh5dLPmr6Bdts3livT2g7GVqNwFRExdPR0LxKIdP0A=;
 b=R498s1sb4anh+Obk+haq3BzRsQUvEZ0JFfoEMLOey9Clj6gAurSsA/P3pXMtNpqdn4PFZK
 iRVzH58m7BGF+mxRP2dXPtZ21Q1CamP8SQpaPm977d0VEUAU/2n+6jvM1QFHSfYHnrYXdM
 il3+oF43gTpEMr7vpdk8+sNhGihyFO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717749745;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tfh5dLPmr6Bdts3livT2g7GVqNwFRExdPR0LxKIdP0A=;
 b=ZPtOle7wDs5ipQcsjaO/EZcNxig52dr+hEoeSN9GvD1V/FIr0BLs++v2IdEjBEOIAZ8AMd
 HH40Eh9XrIwOHhBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717749744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tfh5dLPmr6Bdts3livT2g7GVqNwFRExdPR0LxKIdP0A=;
 b=X57IpIbSdyKtinaaF5stTKtZsMdqgZLfO9yYM3Qx4hhrVdqOGtyJeL+OOeKdFal8ihpja0
 AqHlhDLvDTNY/KbkfZiQmfzmLPWeCd/pBcrFvvV8R8fwhyLVQA8CHlkjY6LpFz+MJVjrno
 DzQ6GaB1utgtakyDmMW05RHzamXvBUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717749744;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tfh5dLPmr6Bdts3livT2g7GVqNwFRExdPR0LxKIdP0A=;
 b=B3D40n1B3VgPPYy8l8mQEKHWwWe4YdMOR/ZMVWCgeYlmgv04AYBLIcMinZZ55n3SxT5m+F
 xMpO5Vu33pVaxGCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05677133F3;
 Fri,  7 Jun 2024 08:42:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LVXzOu/HYmb1EQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 07 Jun 2024 08:42:23 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 07 Jun 2024 10:42:17 +0200
MIME-Version: 1.0
Message-Id: <20240607-seccomp-v1-1-70063fea55ba@suse.com>
X-B4-Tracking: v=1; b=H4sIAOjHYmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMwNj3eLU5OT83AJdA7M0Q4tUS1NTw5Q0JaDqgqLUtMwKsEnRsbW1AHq
 K3/BZAAAA
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7471;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=gGOLSgJsKM7M39F4wPeEBZEBUaP68VfP9cM/AF3LZXw=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmYsfryWuZWM8zdUoxKQGolIkp8yWXo4pAGft2C
 bksFUXC4riJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZmLH6wAKCRDLzBqyILPm
 RjvVC/9bYWlwDqX46dfSf3K91833i3hYGnOKkXnFlXyuT9W/5AqBDEArl6J+Oh6MBHbmiqC1iV8
 4I0S/AUJyaJO1va3/sKtqggUV8iLFusLI4k3fb9F/rMg2lEheAV2fSrvDHO6daLGOq9PMYS3XlZ
 YGtipZpHdsDa4n6RaWZ8Yun/LcRrygK6CSzXTG4eqlGJLzXq2ElN1E493VzwHcLxP2mFA2YCjDH
 H3cBzo67aEmoaB+RELSuoENeMw8bAGkcgH/qzaQW1RCflfITid2TQAF57DL7Uqe5tOWWNIv5JTM
 fCrJBxIWtxhCfxcpKM6MJYqxKT73YMag5xkFL5Uu7jV4ihDIi9UpIAnsRChGUhiAOepUHfMeAGn
 ZD+3S0ARLchN7OQnlds6bFZWvjhfKQoamGtgavcSlD44PsMNK+9wNxkgN2B/qPHdDxbkQURdETl
 i80EmEgUghc1XNrXmvZF60Kz9w1Xg9p25195ZeKovkQSaAwNx9aIHUAE3zNQnX7RKWDlU=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, fujitsu.com:email,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Move prctl04 in seccomp testing suite
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Andrea Cervesato <andrea.cervesato@suse.com>

prictl04 has been renamed as seccomp01 and a test variant has been added
in order to support the seccomp() syscall, that is currently equivalent
to prctl(PR_SET_SECCOMP).

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
This testing suite is aiming to test seccomp() syscall which is
supposed to wrap prctl(PR_SET_SECCOMP). Some parts have been moved from
prctl tesitng suite to a new seccomp testing suite and added a test
variant.
---
 runtest/syscalls                                   |  3 +-
 testcases/kernel/syscalls/prctl/.gitignore         |  1 -
 testcases/kernel/syscalls/seccomp/.gitignore       |  1 +
 testcases/kernel/syscalls/seccomp/Makefile         |  7 ++
 .../{prctl/prctl04.c => seccomp/seccomp01.c}       | 79 +++++++++++++---------
 5 files changed, 56 insertions(+), 35 deletions(-)

diff --git a/runtest/syscalls b/runtest/syscalls
index cf06ee563..a6614141a 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1021,7 +1021,6 @@ ppoll01 ppoll01
 prctl01 prctl01
 prctl02 prctl02
 prctl03 prctl03
-prctl04 prctl04
 prctl05 prctl05
 prctl06 prctl06
 prctl07 prctl07
@@ -1239,6 +1238,8 @@ sched_setattr01 sched_setattr01
 sched_getattr01 sched_getattr01
 sched_getattr02 sched_getattr02
 
+seccomp01 seccomp01
+
 select01 select01
 select02 select02
 select03 select03
diff --git a/testcases/kernel/syscalls/prctl/.gitignore b/testcases/kernel/syscalls/prctl/.gitignore
index 50ee4bf60..8bcc22f98 100644
--- a/testcases/kernel/syscalls/prctl/.gitignore
+++ b/testcases/kernel/syscalls/prctl/.gitignore
@@ -1,7 +1,6 @@
 /prctl01
 /prctl02
 /prctl03
-/prctl04
 /prctl05
 /prctl06
 /prctl06_execve
diff --git a/testcases/kernel/syscalls/seccomp/.gitignore b/testcases/kernel/syscalls/seccomp/.gitignore
new file mode 100644
index 000000000..9196906cf
--- /dev/null
+++ b/testcases/kernel/syscalls/seccomp/.gitignore
@@ -0,0 +1 @@
+seccomp01
diff --git a/testcases/kernel/syscalls/seccomp/Makefile b/testcases/kernel/syscalls/seccomp/Makefile
new file mode 100644
index 000000000..8cf1b9024
--- /dev/null
+++ b/testcases/kernel/syscalls/seccomp/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/prctl/prctl04.c b/testcases/kernel/syscalls/seccomp/seccomp01.c
similarity index 76%
rename from testcases/kernel/syscalls/prctl/prctl04.c
rename to testcases/kernel/syscalls/seccomp/seccomp01.c
index 8b135d611..8d3cf4c1d 100644
--- a/testcases/kernel/syscalls/prctl/prctl04.c
+++ b/testcases/kernel/syscalls/seccomp/seccomp01.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
  * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
 /*\
@@ -35,6 +36,7 @@
 #include <stdlib.h>
 #include <stddef.h>
 #include "tst_test.h"
+#include "tst_kconfig.h"
 #include "lapi/syscalls.h"
 #include "lapi/prctl.h"
 #include "config.h"
@@ -62,11 +64,11 @@ static const struct sock_fprog  strict = {
 	.filter = (struct sock_filter *)strict_filter
 };
 
-static void check_strict_mode(int);
-static void check_filter_mode(int);
+static void check_strict_mode(int mode);
+static void check_filter_mode(int mode);
 
 static struct tcase {
-	void (*func_check)();
+	void (*func_check)(int mode);
 	int pass_flag;
 	int val;
 	int exp_signal;
@@ -94,8 +96,8 @@ static struct tcase {
 	"SECCOMP_MODE_FILTER doesn't permit exit()"}
 };
 
-
-static int mode_filter_not_supported;
+static int strict_not_supported;
+static int filter_not_supported;
 
 static void check_filter_mode_inherit(void)
 {
@@ -122,13 +124,20 @@ static void check_strict_mode(int val)
 	int fd;
 	char buf[2];
 
+	if (strict_not_supported)
+		return;
+
 	fd = SAFE_OPEN(FNAME, O_RDWR | O_CREAT, 0666);
 
-	TEST(prctl(PR_SET_SECCOMP, SECCOMP_MODE_STRICT));
-	if (TST_RET == -1) {
-		tst_res(TFAIL | TTERRNO,
-			"prctl(PR_SET_SECCOMP) sets SECCOMP_MODE_STRICT failed");
-		return;
+	if (tst_variant == 1) {
+		TEST(tst_syscall(__NR_seccomp, SECCOMP_SET_MODE_STRICT, 0, NULL));
+		if (TST_RET == -1)
+			tst_brk(TBROK | TERRNO, "seccomp(SECCOMP_SET_MODE_STRICT) error");
+	} else {
+		TEST(prctl(PR_SET_SECCOMP, SECCOMP_MODE_STRICT, 0, NULL));
+
+		if (TST_RET == -1)
+			tst_brk(TBROK | TERRNO, "prctl(SECCOMP_MODE_STRICT) error");
 	}
 
 	switch (val) {
@@ -158,18 +167,20 @@ static void check_filter_mode(int val)
 {
 	int fd;
 
-	if (mode_filter_not_supported == 1) {
-		tst_res(TCONF, "kernel doesn't support SECCOMP_MODE_FILTER");
+	if (filter_not_supported)
 		return;
-	}
 
 	fd = SAFE_OPEN(FNAME, O_RDWR | O_CREAT, 0666);
 
-	TEST(prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &strict));
-	if (TST_RET == -1) {
-		tst_res(TFAIL | TERRNO,
-			"prctl(PR_SET_SECCOMP) sets SECCOMP_MODE_FILTER failed");
-		return;
+	if (tst_variant == 1) {
+		TEST(tst_syscall(__NR_seccomp, SECCOMP_SET_MODE_FILTER, 0, &strict));
+		if (TST_RET == -1)
+			tst_brk(TBROK | TERRNO, "seccomp(SECCOMP_SET_MODE_FILTER) error");
+	} else {
+		TEST(prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &strict));
+
+		if (TST_RET == -1)
+			tst_brk(TBROK | TERRNO, "prctl(SECCOMP_MODE_FILTER) error");
 	}
 
 	switch (val) {
@@ -213,7 +224,7 @@ static void verify_prctl(unsigned int n)
 			return;
 		}
 
-		if (tc->pass_flag == 2 && mode_filter_not_supported == 0)
+		if (tc->pass_flag == 2)
 			tst_res(TFAIL,
 				"SECCOMP_MODE_FILTER permits exit() unexpectedly");
 	}
@@ -221,31 +232,33 @@ static void verify_prctl(unsigned int n)
 
 static void setup(void)
 {
-	TEST(prctl(PR_GET_SECCOMP));
-	if (TST_RET == 0) {
-		tst_res(TINFO, "kernel supports PR_GET/SET_SECCOMP");
+	static const char * const kconf_strict[] = {"CONFIG_SECCOMP=y", NULL};
+	static const char * const kconf_filter[] = {"CONFIG_SECCOMP_FILTER=y", NULL};
 
-		TEST(prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, NULL));
-		if (TST_RET == -1 && TST_ERR == EINVAL) {
-			mode_filter_not_supported = 1;
-			return;
-		}
+	if (tst_kconfig_check(kconf_strict)) {
+		tst_brk(TCONF, "kernel doesn't support SECCOMP_MODE_STRICT. "
+				"Skipping CONFIG_SECCOMP tests");
 
-		tst_res(TINFO, "kernel supports SECCOMP_MODE_FILTER");
-		return;
+		strict_not_supported = 1;
+	} else {
+		tst_res(TINFO, "kernel supports SECCOMP_MODE_STRICT");
 	}
 
-	if (TST_ERR == EINVAL)
-		tst_brk(TCONF, "kernel doesn't support PR_GET/SET_SECCOMP");
+	if (tst_kconfig_check(kconf_filter)) {
+		tst_brk(TCONF, "kernel doesn't support SECCOMP_MODE_FILTER. "
+				"Skipping CONFIG_SECCOMP_FILTER tests");
 
-	tst_brk(TBROK | TTERRNO,
-		"current environment doesn't permit PR_GET/SET_SECCOMP");
+		filter_not_supported = 1;
+	} else {
+		tst_res(TINFO, "kernel supports SECCOMP_MODE_FILTER");
+	}
 }
 
 static struct tst_test test = {
 	.setup = setup,
 	.test = verify_prctl,
 	.tcnt = ARRAY_SIZE(tcases),
+	.test_variants = 2,
 	.forks_child = 1,
 	.needs_tmpdir = 1,
 	.needs_root = 1,

---
base-commit: 66517b89141fc455ed807f3b95e5260dcf9fb90f
change-id: 20240603-seccomp-06f18e9551df

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
