Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E9AC38145
	for <ltp@archiver.kernel.org>; Tue,  6 Sep 2022 09:26:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2266A3CA94D
	for <ltp@archiver.kernel.org>; Tue,  6 Sep 2022 11:26:41 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1025D3C285E
 for <ltp@lists.linux.it>; Tue,  6 Sep 2022 11:26:21 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 56A82200B8C
 for <ltp@lists.linux.it>; Tue,  6 Sep 2022 11:26:21 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AB9661F8AF;
 Tue,  6 Sep 2022 09:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662456380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YRBXw2EIOf+YTeJKZ1vvmA0dT9Dv8BSSmCnZdXK66cY=;
 b=k6rhf4ZMfeFMEZgRYYFUkKTiYRU0OAcMbC/E8x/B622/ncQuWQHgxi23Lu616WDgOB1bHy
 w7cn+C7Cx/26VMabQPcPEQMO3mNklAmQRgAOQYn1PYWBYUYwjq/1kzp8I365MAW4hUq0hx
 +RzsToGtI2+G7jLy/YdtM61B9gT3ZAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662456380;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YRBXw2EIOf+YTeJKZ1vvmA0dT9Dv8BSSmCnZdXK66cY=;
 b=0ECM+m3/HXYS/rxcsuzqs4GNaR7ZnC7TpgW2FdI360BpDfHZ4uZWxxx6o7h+t5H9zDLnap
 5HlMT8byx9YyoEDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7534013A93;
 Tue,  6 Sep 2022 09:26:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cOSkGjwSF2NTawAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 06 Sep 2022 09:26:20 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  6 Sep 2022 11:26:14 +0200
Message-Id: <20220906092615.15116-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220906092615.15116-1-pvorel@suse.cz>
References: <20220906092615.15116-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] fanotify20: Simplify code
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
Cc: Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

* replace do_test() content with TST_EXP_FD_ERRNO() macro
* rename variables (shorten, use LTP common names)
* remove tc->want_err (not needed)
* add macro FLAGS_DESC (stringify)
* don't print number of tests (not needed for just 2 tests)

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/syscalls/fanotify/fanotify20.c     | 81 +++++--------------
 1 file changed, 19 insertions(+), 62 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
index de0fdb782..badc4c369 100644
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
+	TST_EXP_FD_ERRNO(fd = fanotify_init(tc->flags, O_RDONLY),
+			 tc->exp_errno);
 
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
