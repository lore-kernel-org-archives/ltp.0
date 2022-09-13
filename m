Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80DAC6FA82
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 06:21:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 858A73CAB2B
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 08:21:39 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB7C13CAAE3
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 08:21:08 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 453B8200B9A
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 08:21:07 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 584FA5BDE1;
 Tue, 13 Sep 2022 06:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663050067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5PD7NvxYbdErXXWZq7jJkZPbjU1S2g7DlAI95i+A/50=;
 b=MR6v6fyg7S/cWtYpIGkbDJGEdLgICUThBhbR/QhkAtOhhiIRcl9lGkRGGUI1hFJQ+kDafk
 3qwJxhW8EddzbfPbKqiLRR0Tw5BKSxhhc7ehO/QR766gPhf1icxnXudGqXpemrKdOg+S8E
 y/PXtjFgYqjnZlfZtNtOH5vWVtvLimU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663050067;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5PD7NvxYbdErXXWZq7jJkZPbjU1S2g7DlAI95i+A/50=;
 b=EDVMy20LOFQv5f0EAHLZEPVTcaWfB0FH5C0Wtq17wOQW6Nfc84DHpqPEVbahej7PI21JKd
 TxWnvzuNv6e5CyAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3988B139B3;
 Tue, 13 Sep 2022 06:21:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8BO9DFMhIGNKZwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 13 Sep 2022 06:21:07 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 13 Sep 2022 08:21:02 +0200
Message-Id: <20220913062103.3910-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220913062103.3910-1-pvorel@suse.cz>
References: <20220913062103.3910-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/3] fanotify20: Simplify code
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

* replace do_test() content with TST_EXP_FD_OR_FAIL() macro
* rename variables (shorten, use LTP common names)
* remove tc->want_err (not needed)
* add macro FLAGS_DESC (stringify)
* don't print number of tests (not needed for just 2 tests)

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/syscalls/fanotify/fanotify20.c     | 81 +++++--------------
 1 file changed, 19 insertions(+), 62 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
index de0fdb782..71310fb86 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify20.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2021 Google. All Rights Reserved.
+ * Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
  *
  * Started by Matthew Bobrowski <repnop@google.com>
  */
@@ -25,26 +26,21 @@
 #include "fanotify.h"
 
 #define MOUNT_PATH	"fs_mnt"
+#define FLAGS_DESC(x) .flags = x, .desc = #x
 
-static int fanotify_fd;
+static int fd;
 
 static struct test_case_t {
-	char *name;
-	unsigned int init_flags;
-	int want_err;
-	int want_errno;
+	unsigned int flags;
+	char *desc;
+	int exp_errno;
 } test_cases[] = {
 	{
-		"fail on FAN_REPORT_PIDFD | FAN_REPORT_TID",
-		FAN_REPORT_PIDFD | FAN_REPORT_TID,
-		1,
-		EINVAL,
+		FLAGS_DESC(FAN_REPORT_PIDFD | FAN_REPORT_TID),
+		.exp_errno = EINVAL,
 	},
 	{
-		"pass on FAN_REPORT_PIDFD | FAN_REPORT_FID | FAN_REPORT_DFID_NAME",
-		FAN_REPORT_PIDFD | FAN_REPORT_FID | FAN_REPORT_DFID_NAME,
-		0,
-		0,
+		FLAGS_DESC(FAN_REPORT_PIDFD | FAN_REPORT_FID | FAN_REPORT_DFID_NAME),
 	},
 };
 
@@ -57,63 +53,24 @@ static void do_setup(void)
 	REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_BY_KERNEL(FAN_REPORT_PIDFD);
 }
 
-static void do_test(unsigned int num)
+static void do_test(unsigned int i)
 {
-	struct test_case_t *tc = &test_cases[num];
+	struct test_case_t *tc = &test_cases[i];
 
-	tst_res(TINFO, "Test #%d: %s", num, tc->name);
+	tst_res(TINFO, "Test %s on %s", tc->exp_errno ? "fail" : "pass",
+		tc->desc);
 
-	fanotify_fd = fanotify_init(tc->init_flags, O_RDONLY);
-	if (fanotify_fd < 0) {
-		if (!tc->want_err) {
-			tst_res(TFAIL,
-				"fanotify_fd=%d, fanotify_init(%x, O_RDONLY) "
-				"failed with error -%d but wanted success",
-				fanotify_fd, tc->init_flags, errno);
-			return;
-		}
+	TST_EXP_FD_OR_FAIL(fd = fanotify_init(tc->flags, O_RDONLY),
+			   tc->exp_errno);
 
-		if (errno != tc->want_errno) {
-			tst_res(TFAIL,
-				"fanotify_fd=%d, fanotify_init(%x, O_RDONLY) "
-				"failed with an unexpected error code -%d but "
-				"wanted -%d",
-				fanotify_fd, tc->init_flags,
-				errno, tc->want_errno);
-			return;
-		}
-
-		tst_res(TPASS,
-			"fanotify_fd=%d, fanotify_init(%x, O_RDONLY) "
-			"failed with error -%d as expected",
-			fanotify_fd, tc->init_flags, errno);
-		return;
-	}
-
-	/*
-	 * Catch test cases that had expected to receive an error upon calling
-	 * fanotify_init() but had unexpectedly resulted in a success.
-	 */
-	if (tc->want_err) {
-		tst_res(TFAIL,
-			"fanotify_fd=%d, fanotify_init(%x, O_RDONLY) "
-			"unexpectedly returned successfully, wanted error -%d",
-			fanotify_fd, tc->init_flags, tc->want_errno);
-		return;
-	}
-
-	tst_res(TPASS,
-		"fanotify_fd=%d, fanotify_init(%x, O_RDONLY) "
-		"successfully initialized notification group",
-		fanotify_fd, tc->init_flags);
-
-	SAFE_CLOSE(fanotify_fd);
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 }
 
 static void do_cleanup(void)
 {
-	if (fanotify_fd >= 0)
-		SAFE_CLOSE(fanotify_fd);
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 }
 
 static struct tst_test test = {
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
