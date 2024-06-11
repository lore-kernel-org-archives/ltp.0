Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFBCCC25B76
	for <ltp@archiver.kernel.org>; Tue, 11 Jun 2024 07:39:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E18F33D0B79
	for <ltp@archiver.kernel.org>; Tue, 11 Jun 2024 09:39:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 111B73D0888
 for <ltp@lists.linux.it>; Tue, 11 Jun 2024 09:38:46 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C7DA16000F6
 for <ltp@lists.linux.it>; Tue, 11 Jun 2024 09:38:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 270BF21F4C;
 Tue, 11 Jun 2024 07:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718091524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6zLEAsDS43VU+wmWM/TWNOIBbX6sRZP1q/xdNi7yUoE=;
 b=kLiDAXikRAKZqyvu7FopyYAUgas77KgGDkmleLdKRtVILy1mD9pTktrXLTLTgO3edhNf6B
 lDI2RkNomJTu0G+KNQqbDGfEZqUJsQQMr3F1Y5+cLrqQV8ZMn8f4PCWkcdxMIgQU6qFcPq
 UtBWSpMZOzwI0fpET11kjEusLMOcAfk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718091524;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6zLEAsDS43VU+wmWM/TWNOIBbX6sRZP1q/xdNi7yUoE=;
 b=qw3Lb79Onh+4/cMYWSuzfmw3degz4Ba7lNFVfyW9fz+3IcL28fmi4BX2ZT1czRmExjU7ew
 p3iSpUwCSp8hPzCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718091524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6zLEAsDS43VU+wmWM/TWNOIBbX6sRZP1q/xdNi7yUoE=;
 b=kLiDAXikRAKZqyvu7FopyYAUgas77KgGDkmleLdKRtVILy1mD9pTktrXLTLTgO3edhNf6B
 lDI2RkNomJTu0G+KNQqbDGfEZqUJsQQMr3F1Y5+cLrqQV8ZMn8f4PCWkcdxMIgQU6qFcPq
 UtBWSpMZOzwI0fpET11kjEusLMOcAfk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718091524;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6zLEAsDS43VU+wmWM/TWNOIBbX6sRZP1q/xdNi7yUoE=;
 b=qw3Lb79Onh+4/cMYWSuzfmw3degz4Ba7lNFVfyW9fz+3IcL28fmi4BX2ZT1czRmExjU7ew
 p3iSpUwCSp8hPzCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 087C713A55;
 Tue, 11 Jun 2024 07:38:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OmEWAAT/Z2aRTgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 11 Jun 2024 07:38:44 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 11 Jun 2024 09:38:39 +0200
MIME-Version: 1.0
Message-Id: <20240611-seccomp-v2-1-14dfc432bf6c@suse.com>
X-B4-Tracking: v=1; b=H4sIAP7+Z2YC/z3MQQ7CIBCF4as0sxYDVKh25T1MF0gHOwtLwyjRN
 NxdbKLLf+blW4ExETL0zQoJMzHFuYbeNeAnN99Q0FgbtNQHaWUrGL2P90VIG9QRT8aoMUBdLwk
 DvTbpMtSeiB8xvTc4q+/1Z3R/IyuhRCelbQM6Y67uzE/Gff3BUEr5AN2NBcmdAAAA
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8129;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=GOC+A0LClokC2LtHECm/KrkS3imjXbfy7HpbX+b5nPE=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmZ/8AQFTFj6I9xSJOmUZ7rknxiO59DPkg8IcU6
 0Jjay4Jst2JAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZmf/AAAKCRDLzBqyILPm
 RgF1C/4hR7sYZMb22JHixToW3/x/knmFs56pYSPgmW6oNizMoUUOcMN0DEVm1NuniqBKVogrIux
 I3fijPHN7QrtC6+N8p5C9FGjPF9XGPyrT7mPnOSujx4BLV3nEgTcx1GfYi0HR3uyfYGi7/048gj
 fbwHf48njx7KIUOgJD6bDE2eZgMsMVgCJ/v0vfq8Xgp2n0hr56ZpneWZdaBxydLo3UJXrJUqOI7
 NKdCVa5Tce8/Qvkb4zr3GmD8nA6S98WqWw0DEW4R8DsiLotkskZ4EE6vlFvyq1dvvhtFlpjxbaL
 pVrbyMpsx/QrXkMMStQtIQFBGs8nvdbps+y3B/0VYLnUhuFFZbsji3yipThX1dgjaNXEhI/Hkei
 rZq8cgG/TPqXhqSE+iqY0zrwT5ePHhv8ynAdcBh6UJLRiphnwHDlIVPnZqu+zlEkfemrB2+gqiP
 F6uWsWy1I9Km3tiseWLNBV4P20jr4b1pPbucE5ZX8Hz3ia5gKWq5lQ9rZqOY7B0D9w0MM=
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Move prctl04 in seccomp testing suite
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
Changes in v2:
- more information about the current running variant 
- Link to v1: https://lore.kernel.org/r/20240607-seccomp-v1-1-70063fea55ba@suse.com
---
 runtest/syscalls                                   |  3 +-
 testcases/kernel/syscalls/prctl/.gitignore         |  1 -
 testcases/kernel/syscalls/seccomp/.gitignore       |  1 +
 testcases/kernel/syscalls/seccomp/Makefile         |  7 ++
 .../{prctl/prctl04.c => seccomp/seccomp01.c}       | 85 +++++++++++++---------
 5 files changed, 61 insertions(+), 36 deletions(-)

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
similarity index 73%
rename from testcases/kernel/syscalls/prctl/prctl04.c
rename to testcases/kernel/syscalls/seccomp/seccomp01.c
index 8b135d611..73ee09c1d 100644
--- a/testcases/kernel/syscalls/prctl/prctl04.c
+++ b/testcases/kernel/syscalls/seccomp/seccomp01.c
@@ -2,12 +2,14 @@
 /*
  * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
  * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
 /*\
  * [Description]
  *
- * Test PR_GET_SECCOMP and PR_SET_SECCOMP of prctl(2).
+ * Test PR_GET_SECCOMP and PR_SET_SECCOMP with both prctl(2) and seccomp().
+ * The second one is called via __NR_seccomp using tst_syscall().
  *
  * - If PR_SET_SECCOMP sets the SECCOMP_MODE_STRICT for the calling thread,
  *   the only system call that the thread is permitted to make are read(2),
@@ -35,6 +37,7 @@
 #include <stdlib.h>
 #include <stddef.h>
 #include "tst_test.h"
+#include "tst_kconfig.h"
 #include "lapi/syscalls.h"
 #include "lapi/prctl.h"
 #include "config.h"
@@ -62,11 +65,11 @@ static const struct sock_fprog  strict = {
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
@@ -94,8 +97,8 @@ static struct tcase {
 	"SECCOMP_MODE_FILTER doesn't permit exit()"}
 };
 
-
-static int mode_filter_not_supported;
+static int strict_not_supported;
+static int filter_not_supported;
 
 static void check_filter_mode_inherit(void)
 {
@@ -122,13 +125,20 @@ static void check_strict_mode(int val)
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
@@ -158,18 +168,20 @@ static void check_filter_mode(int val)
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
@@ -213,7 +225,7 @@ static void verify_prctl(unsigned int n)
 			return;
 		}
 
-		if (tc->pass_flag == 2 && mode_filter_not_supported == 0)
+		if (tc->pass_flag == 2)
 			tst_res(TFAIL,
 				"SECCOMP_MODE_FILTER permits exit() unexpectedly");
 	}
@@ -221,31 +233,36 @@ static void verify_prctl(unsigned int n)
 
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
+	tst_res(TINFO, "Testing variant: %s",
+		tst_variant == 1 ? "seccomp()" : "pctrl(PR_SET_SECCOMP)");
 
-		tst_res(TINFO, "kernel supports SECCOMP_MODE_FILTER");
-		return;
+	if (tst_kconfig_check(kconf_strict)) {
+		tst_brk(TCONF, "kernel doesn't support SECCOMP_MODE_STRICT. "
+				"Skipping CONFIG_SECCOMP tests");
+
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
