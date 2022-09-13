Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C54CC54EE9
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 06:21:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 687463CAB9A
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 08:21:50 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD2243CAAE0
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 08:21:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 12406200B98
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 08:21:07 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7F3412247B;
 Tue, 13 Sep 2022 06:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663050067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MMYf5vH5MzBtWinCckDFU5F8geJ7KODMOKa/PyZrxPA=;
 b=tTgN6bn0/L+ejNJYEiAVQ6e9oKhhoxF2dLIfGqk/UdZmfvLHgBP+L63d2KaymvS1O9HoRB
 oXM8t4mdz3sadocqXhLDmTzYYV2CHWkNW8DU4fNP3WksNH30FBSB/tkdpwlJ1jwWaFRKjK
 cdlyd4kMhHhBlrRavMZvRT6jbTT7G40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663050067;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MMYf5vH5MzBtWinCckDFU5F8geJ7KODMOKa/PyZrxPA=;
 b=m6LdS5h3xJXlZMVl7ySKgQrmKAwX8XASw4q7XLrvu7YD7AsWHqcaoOWpAmvRKvYFFj10S9
 kqlizYKvKVRT5rCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 60C70139B3;
 Tue, 13 Sep 2022 06:21:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gGUxFlMhIGNKZwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 13 Sep 2022 06:21:07 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 13 Sep 2022 08:21:03 +0200
Message-Id: <20220913062103.3910-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220913062103.3910-1-pvorel@suse.cz>
References: <20220913062103.3910-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/3] fanotify14: Use TST_EXP_FD_ERRNO()
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

That greatly simplifies the code.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/syscalls/fanotify/fanotify14.c     | 118 +++++-------------
 1 file changed, 33 insertions(+), 85 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify14.c b/testcases/kernel/syscalls/fanotify/fanotify14.c
index 4a1953b33..594259ccf 100644
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
@@ -49,6 +50,7 @@ static int ignore_mark_unsupported;
 static struct test_case_t {
 	unsigned int init_flags;
 	unsigned int mark_flags;
+	/* zero mask expects to fail on fanotify_init() */
 	unsigned long long mask;
 	int expected_errno;
 } test_cases[] = {
@@ -140,7 +142,6 @@ static struct test_case_t {
 
 static void do_test(unsigned int number)
 {
-	int ret;
 	struct test_case_t *tc = &test_cases[number];
 
 	if (fan_report_target_fid_unsupported && tc->init_flags & FAN_REPORT_TARGET_FID) {
@@ -154,101 +155,48 @@ static void do_test(unsigned int number)
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
+	TST_EXP_FD_OR_FAIL(fanotify_fd = fanotify_init(tc->init_flags, O_RDONLY),
+			   !tc->mask && tc->expected_errno ? tc->expected_errno : 0);
 
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
+	TST_EXP_FD_OR_FAIL(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark_flags,
+					 tc->mask, AT_FDCWD, path),
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
