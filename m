Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE768C77B73
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 12:08:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6EEDF3CE4B4
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 14:08:38 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 536FD3CE4AD
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 14:08:06 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4FB3320004F
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 14:08:05 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6F21A21B00
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 12:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1682597285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m+0p7LA5lY0DQhZjUUOzBsWPSvEplj7V2SvQSWSawYI=;
 b=sS4ZZNRY1Q8kFOYLd5NeE8P56W7E5XHRjXo1SWiYzcI65FV8ZbFhxiXpr3T1CpRutcVpT8
 FrFdbcACOkSuSCBJXLqeTyKL6BCyhJ64MnZ1BU497MnjLLyAawGJpH07c7RfrdBLSXqWxc
 xlGVTpE3wVP6gqrDgRgoYgKWqajfWlE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1682597285;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m+0p7LA5lY0DQhZjUUOzBsWPSvEplj7V2SvQSWSawYI=;
 b=srBHTGIJZzwmVV6KxUr43Zbsk+rIMHOrwGkGnwIQvTEJOaKJXYyB9GXYKrbAY03KJ/0MjQ
 hlqkS2C56dZF19AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 19D1313910
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 12:08:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id X7X1N6RlSmR5SwAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 12:08:04 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu, 27 Apr 2023 17:37:57 +0530
Message-Id: <20230427120800.27849-2-akumar@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427120800.27849-1-akumar@suse.de>
References: <20230427120800.27849-1-akumar@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/5] dup02.c: Simplify using TST_EXP macro and doc
 rewording
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

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/dup/dup02.c | 29 +++++----------------------
 1 file changed, 5 insertions(+), 24 deletions(-)

diff --git a/testcases/kernel/syscalls/dup/dup02.c b/testcases/kernel/syscalls/dup/dup02.c
index 528bcdbc1..1bb1d5be3 100644
--- a/testcases/kernel/syscalls/dup/dup02.c
+++ b/testcases/kernel/syscalls/dup/dup02.c
@@ -8,11 +8,9 @@
  */
 /*\
  * [Description]
- * Negative test for dup(2) with bad fds.
  *
- * [Algorithm]
- * Call dup(2) with invalid argument and make sure it returns -1 with errno set
- * to EBADF.
+ * Verify that dup(2) syscall fails with errno EBADF when called with
+ * invalid value for oldfd argument.
  */
 
 #include "tst_test.h"
@@ -29,27 +27,10 @@ static void run(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
 
-	TEST(dup(tc->fd));
+	TST_EXP_FAIL2(dup(tc->fd), tc->expected_errno, "dup(%d)", tc->fd);
 
-	if (TST_RET < -1) {
-		tst_res(TFAIL | TTERRNO, "Invalid dup() return value %ld",
-			TST_RET);
-		return;
-	}
-
-	if (TST_RET == -1) {
-		if (tc->expected_errno == TST_ERR) {
-			tst_res(TPASS | TTERRNO, "dup(%d) failed as expected",
-				tc->fd);
-		} else {
-			tst_res(TFAIL | TTERRNO, "dup(%d) failed unexpectedly",
-				tc->fd);
-		}
-		return;
-	}
-
-	tst_res(TFAIL, "dup(%d) succeeded unexpectedly", tc->fd);
-	SAFE_CLOSE(TST_RET);
+	if (TST_RET != -1)
+		SAFE_CLOSE(TST_RET);
 }
 
 static struct tst_test test = {
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
