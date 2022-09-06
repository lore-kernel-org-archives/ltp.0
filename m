Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB413C38145
	for <ltp@archiver.kernel.org>; Tue,  6 Sep 2022 09:27:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 58C423CA956
	for <ltp@archiver.kernel.org>; Tue,  6 Sep 2022 11:27:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BA323C285E
 for <ltp@lists.linux.it>; Tue,  6 Sep 2022 11:26:22 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 589A4600B2D
 for <ltp@lists.linux.it>; Tue,  6 Sep 2022 11:26:21 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EA12833BB8;
 Tue,  6 Sep 2022 09:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662456380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0FvaZ9Au7YlCn1dzaaT5H5pXOK5wM2JHJ4MBDyMtvkU=;
 b=wlxXgob6qz8OWfU2CuZiKgSRaxYiCUlfRPrjS3sNuAiRVFWefyVcrAfDsbrsCxorZWgSCc
 nkH4/32tfz3PaalQ49CAlWQjLjwzRbDZDYVnmieF/rzsq30sOpggw5QE/GtOlUnv4Y/q4/
 RDgBXuQb47DRlTHDs1rZqkCk//ubnKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662456380;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0FvaZ9Au7YlCn1dzaaT5H5pXOK5wM2JHJ4MBDyMtvkU=;
 b=9CIvUsS0BJlTcTWIMUjmVhxNZ9ECF6OYVhaEYO1R5icaD2f8/jYiCSUyhNG/BxwaW8pl+J
 InI/cibz8nZnMeAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B979513A93;
 Tue,  6 Sep 2022 09:26:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OMS6KjwSF2NTawAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 06 Sep 2022 09:26:20 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  6 Sep 2022 11:26:15 +0200
Message-Id: <20220906092615.15116-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220906092615.15116-1-pvorel@suse.cz>
References: <20220906092615.15116-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] fanotify14: Use TST_EXP_FD_ERRNO()
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

That greatly simplifies the code.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/syscalls/fanotify/fanotify14.c     | 118 +++++-------------
 1 file changed, 33 insertions(+), 85 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify14.c b/testcases/kernel/syscalls/fanotify/fanotify14.c
index aa4db586e..47d013c9f 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify14.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify14.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2018 Matthew Bobrowski. All Rights Reserved.
+ * Copyright (c) Linux Test Project, 2020-2022
  *
  * Started by Matthew Bobrowski <mbobrowski@mbobrowski.org>
  */
@@ -48,6 +49,7 @@ static int fan_report_target_fid_unsupported;
 static struct test_case_t {
 	unsigned int init_flags;
 	unsigned int mark_flags;
+	/* zero mask expects to fail on fanotify_init() */
 	unsigned long long mask;
 	int expected_errno;
 } test_cases[] = {
@@ -111,7 +113,6 @@ static struct test_case_t {
 
 static void do_test(unsigned int number)
 {
-	int ret;
 	struct test_case_t *tc = &test_cases[number];
 
 	if (fan_report_target_fid_unsupported && tc->init_flags & FAN_REPORT_TARGET_FID) {
@@ -120,101 +121,48 @@ static void do_test(unsigned int number)
 		return;
 	}
 
-	fanotify_fd = fanotify_init(tc->init_flags, O_RDONLY);
-	if (fanotify_fd < 0) {
-		if (errno == tc->expected_errno) {
-			tst_res(TPASS,
-				"fanotify_fd=%d, fanotify_init(%x, O_RDONLY) "
-				"failed with error %d as expected",
-				fanotify_fd,
-				tc->init_flags, tc->expected_errno);
-			return;
-		}
-		tst_brk(TBROK | TERRNO,
-			"fanotify_fd=%d, fanotify_init(%x, O_RDONLY) failed",
-			fanotify_fd,
-			tc->init_flags);
-	}
+	TST_EXP_FD_ERRNO(fanotify_fd = fanotify_init(tc->init_flags, O_RDONLY),
+			 !tc->mask && tc->expected_errno ? tc->expected_errno : 0);
 
-	/*
-	 * A test case with a mask set to zero indicate that they've been
-	 * specifically designed to test and fail on the fanotify_init()
-	 * system call.
-	 */
-	if (tc->mask == 0) {
-		tst_res(TFAIL,
-			"fanotify_fd=%d fanotify_init(%x, O_RDONLY) "
-			"unexpectedly succeeded when tests with mask 0 are "
-			"expected to fail when calling fanotify_init()",
-			fanotify_fd,
-			tc->init_flags);
+	if (fanotify_fd < 0)
+		return;
+
+	if (!tc->mask)
 		goto out;
-	}
 
 	/* Set mark on non-dir only when expecting error ENOTDIR */
 	const char *path = tc->expected_errno == ENOTDIR ? FILE1 : MNTPOINT;
 
-	ret = fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark_flags,
-				tc->mask, AT_FDCWD, path);
-	if (ret < 0) {
-		if (errno == tc->expected_errno) {
-			tst_res(TPASS,
-				"ret=%d, fanotify_mark(%d, FAN_MARK_ADD | %x, "
-				"%llx, AT_FDCWD, %s) failed with error %d "
-				"as expected",
-				ret,
-				fanotify_fd,
-				tc->mark_flags,
-				tc->mask,
-				path, tc->expected_errno);
-			/*
-			 * ENOTDIR are errors for events/flags not allowed on a non-dir inode.
-			 * Try to set an inode mark on a directory and it should succeed.
-			 * Try to set directory events in filesystem mark mask on non-dir
-			 * and it should succeed.
-			 */
-			if (tc->expected_errno == ENOTDIR) {
-				SAFE_FANOTIFY_MARK(fanotify_fd, FAN_MARK_ADD | tc->mark_flags,
-						   tc->mask, AT_FDCWD, MNTPOINT);
-				tst_res(TPASS,
-					"Adding an inode mark on directory did not fail with "
-					"ENOTDIR error as on non-dir inode");
-			}
-			if (tc->expected_errno == ENOTDIR &&
-			    !(tc->mark_flags & FAN_MARK_ONLYDIR)) {
-				SAFE_FANOTIFY_MARK(fanotify_fd, FAN_MARK_ADD | tc->mark_flags |
-						   FAN_MARK_FILESYSTEM, tc->mask,
-						   AT_FDCWD, FILE1);
-				tst_res(TPASS,
-					"Adding a filesystem mark on non-dir did not fail with "
-					"ENOTDIR error as with an inode mark");
-			}
+	TST_EXP_FD_ERRNO(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark_flags,
+								   tc->mask, AT_FDCWD, path),
+					 tc->expected_errno);
 
-			goto out;
+	/*
+	 * ENOTDIR are errors for events/flags not allowed on a non-dir inode.
+	 * Try to set an inode mark on a directory and it should succeed.
+	 * Try to set directory events in filesystem mark mask on non-dir
+	 * and it should succeed.
+	 */
+	if (TST_PASS && tc->expected_errno == ENOTDIR) {
+		SAFE_FANOTIFY_MARK(fanotify_fd, FAN_MARK_ADD | tc->mark_flags,
+				   tc->mask, AT_FDCWD, MNTPOINT);
+		tst_res(TPASS,
+			"Adding an inode mark on directory did not fail with "
+			"ENOTDIR error as on non-dir inode");
+
+		if (!(tc->mark_flags & FAN_MARK_ONLYDIR)) {
+			SAFE_FANOTIFY_MARK(fanotify_fd, FAN_MARK_ADD | tc->mark_flags |
+					   FAN_MARK_FILESYSTEM, tc->mask,
+					   AT_FDCWD, FILE1);
+			tst_res(TPASS,
+				"Adding a filesystem mark on non-dir did not fail with "
+				"ENOTDIR error as with an inode mark");
 		}
-		tst_brk(TBROK | TERRNO,
-			"ret=%d, fanotify_mark(%d, FAN_MARK_ADD | %x, %llx, "
-			"AT_FDCWD, %s) failed",
-			ret,
-			fanotify_fd,
-			tc->mark_flags,
-			tc->mask,
-			FILE1);
 	}
 
-	tst_res(TFAIL,
-		"fanotify_fd=%d, ret=%d, fanotify_init(%x, O_RDONLY) and "
-		"fanotify_mark(%d, FAN_MARK_ADD | %x, %llx, AT_FDCWD, %s) did "
-		"not return any errors as expected",
-		fanotify_fd,
-		ret,
-		tc->init_flags,
-		fanotify_fd,
-		tc->mark_flags,
-		tc->mask,
-		FILE1);
 out:
-	SAFE_CLOSE(fanotify_fd);
+	if (fanotify_fd > 0)
+		SAFE_CLOSE(fanotify_fd);
 }
 
 static void do_setup(void)
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
