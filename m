Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645ECC433EF
	for <ltp@archiver.kernel.org>; Tue, 19 Jul 2022 07:27:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BBC983C95FF
	for <ltp@archiver.kernel.org>; Tue, 19 Jul 2022 09:27:24 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE1253C927B
 for <ltp@lists.linux.it>; Tue, 19 Jul 2022 09:27:14 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C3E2B1001750
 for <ltp@lists.linux.it>; Tue, 19 Jul 2022 09:27:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9C2F033A16
 for <ltp@lists.linux.it>; Tue, 19 Jul 2022 07:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1658215632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=k/RMutwmbkd7b5iTuXHtlK/PqAFYYVkPhGSH3EqjIGE=;
 b=AuoiHKFezi0341SeHn1hZFpAYp4juEhnuNNkV6Q6E25vdWCn8hCnuAmfFr+qezfb4ShdvV
 gKy5dox3W2mFZN8+OOgLEaHCskpsydFIAApuuNVWJbn5xPgTQmxgxo/xkDAbAZBZ/ZkBfn
 6K6VT57Pzy49/fHaKaN+rCbXEA3aRzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1658215632;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=k/RMutwmbkd7b5iTuXHtlK/PqAFYYVkPhGSH3EqjIGE=;
 b=NxHhy2OoLvh89lq0/60w1+VOI+GL18+oVzC9P6oAGZC1zYAJOp3P3qPhZr3S0CnF7LLS12
 ArnUy1fR7KErjeDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 195EE13488
 for <ltp@lists.linux.it>; Tue, 19 Jul 2022 07:27:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sGv3Ms9c1mIaLgAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Tue, 19 Jul 2022 07:27:11 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Tue, 19 Jul 2022 12:57:09 +0530
Message-Id: <20220719072709.20397-1-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] readahead01.c: use TST_EXP_FAIL() macro and fix
 warnings
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

cleanup using TST_EXP_FAIL() macro with expected errno code and fixing
checkpatch warnings

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 .../kernel/syscalls/readahead/readahead01.c   | 52 ++++---------------
 1 file changed, 9 insertions(+), 43 deletions(-)

diff --git a/testcases/kernel/syscalls/readahead/readahead01.c b/testcases/kernel/syscalls/readahead/readahead01.c
index a0be96065..4355457e9 100644
--- a/testcases/kernel/syscalls/readahead/readahead01.c
+++ b/testcases/kernel/syscalls/readahead/readahead01.c
@@ -21,52 +21,22 @@
 #include "lapi/syscalls.h"
 
 #if defined(__NR_readahead)
-static void check_ret(long expected_ret)
-{
-	if (expected_ret == TST_RET) {
-		tst_res(TPASS, "expected ret success - "
-			"returned value = %ld", TST_RET);
-		return;
-	}
-	tst_res(TFAIL, "unexpected failure - "
-		"returned value = %ld, expected: %ld",
-		TST_RET, expected_ret);
-}
-
-static void check_errno(long expected_errno)
-{
-	if (TST_ERR == expected_errno) {
-		tst_res(TPASS | TTERRNO, "expected failure");
-		return;
-	}
-
-	if (TST_ERR == 0)
-		tst_res(TFAIL, "call succeeded unexpectedly");
-	else
-		tst_res(TFAIL | TTERRNO, "unexpected failure - "
-			"expected = %ld : %s, actual",
-			expected_errno, strerror(expected_errno));
-}
 
 static void test_bad_fd(void)
 {
 	char tempname[PATH_MAX] = "readahead01_XXXXXX";
 	int fd;
 
-	tst_res(TINFO, "test_bad_fd -1");
-	TEST(readahead(-1, 0, getpagesize()));
-	check_ret(-1);
-	check_errno(EBADF);
+	tst_res(TINFO, "%s -1", __func__);
+	TST_EXP_FAIL(readahead(-1, 0, getpagesize()), EBADF);
 
-	tst_res(TINFO, "test_bad_fd O_WRONLY");
+	tst_res(TINFO, "%s O_WRONLY", __func__);
 	fd = mkstemp(tempname);
 	if (fd == -1)
 		tst_res(TFAIL | TERRNO, "mkstemp failed");
 	SAFE_CLOSE(fd);
 	fd = SAFE_OPEN(tempname, O_WRONLY);
-	TEST(readahead(fd, 0, getpagesize()));
-	check_ret(-1);
-	check_errno(EBADF);
+	TST_EXP_FAIL(readahead(fd, 0, getpagesize()), EBADF);
 	SAFE_CLOSE(fd);
 	unlink(tempname);
 }
@@ -75,23 +45,19 @@ static void test_invalid_fd(void)
 {
 	int fd[2];
 
-	tst_res(TINFO, "test_invalid_fd pipe");
+	tst_res(TINFO, "%s pipe", __func__);
 	SAFE_PIPE(fd);
-	TEST(readahead(fd[0], 0, getpagesize()));
-	check_ret(-1);
-	check_errno(EINVAL);
+	TST_EXP_FAIL(readahead(fd[0], 0, getpagesize()), EINVAL);
 	SAFE_CLOSE(fd[0]);
 	SAFE_CLOSE(fd[1]);
 
-	tst_res(TINFO, "test_invalid_fd socket");
+	tst_res(TINFO, "%s socket", __func__);
 	fd[0] = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
-	TEST(readahead(fd[0], 0, getpagesize()));
-	check_ret(-1);
-	check_errno(EINVAL);
+	TST_EXP_FAIL(readahead(fd[0], 0, getpagesize()), EINVAL);
 	SAFE_CLOSE(fd[0]);
 }
 
-void test_readahead(void)
+static void test_readahead(void)
 {
 	test_bad_fd();
 	test_invalid_fd();
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
