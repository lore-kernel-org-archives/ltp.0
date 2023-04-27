Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49493C77B73
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 12:08:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D5D1E3CE4C7
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 14:08:26 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 398803CE4C9
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 14:08:09 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1B5BD1A00A34
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 14:08:08 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 59DA321AFD
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 12:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1682597288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gBhhfUqGQ/kdzW9oPDed9ZfEjiCGZBIreRVs2LkQZFI=;
 b=P1tXNwZ5YEOq4io4XMKloUnzs2cyzC9Dxht5s3dp1JpLxQqAK84n0iJA6XAppNRUgihOda
 Nan2XLq95PKSaM/Tn/RCxFbd3eEPr3Edvgw8ul2kqFNkR1wVe7wIweNml7WavoItlehGx3
 TJnR+WKixzwUNRu++DTmi5ea9HAiAAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1682597288;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gBhhfUqGQ/kdzW9oPDed9ZfEjiCGZBIreRVs2LkQZFI=;
 b=+Osl4GummjqjuXNn50yF6l1oDkd4+mBBXo17u950rLlA/FxYfIPuCtYf32AY4L4LAjv8gw
 qoAYuNfTIOrxTjAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F1C9513910
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 12:08:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id s0trMadlSmSDSwAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 12:08:07 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu, 27 Apr 2023 17:37:58 +0530
Message-Id: <20230427120800.27849-3-akumar@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427120800.27849-1-akumar@suse.de>
References: <20230427120800.27849-1-akumar@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/5] dup03.c: use TST_EXP macro and make check fixes
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

- use TST_EXP_FAIL2() macro for expected failure check
- make check fixes: change vars to static
- reword doc comment

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/dup/dup03.c | 34 +++++++--------------------
 1 file changed, 8 insertions(+), 26 deletions(-)

diff --git a/testcases/kernel/syscalls/dup/dup03.c b/testcases/kernel/syscalls/dup/dup03.c
index 0e99813f4..d59e61f2b 100644
--- a/testcases/kernel/syscalls/dup/dup03.c
+++ b/testcases/kernel/syscalls/dup/dup03.c
@@ -6,48 +6,30 @@
  */
 /*\
  * [Description]
- * Negative test for dup(2) (too many fds).
  *
- * [Algorithm]
- * Open the maximum allowed number of file descriptors and then try to call
- * dup() once more and verify it fails with EMFILE.
+ * Verify that dup(2) syscall fails with errno EMFILE when the per-process
+ * limit on the number of open file descriptors has been reached.
  */
 
 #include <stdlib.h>
 #include "tst_test.h"
 
-int *fd;
-int nfds;
+static int *fd;
+static int nfds;
 
 static void run(void)
 {
-	TEST(dup(fd[0]));
+	TST_EXP_FAIL2(dup(fd[0]), EMFILE, "dup(%d)", fd[0]);
 
-	if (TST_RET < -1) {
-		tst_res(TFAIL, "Invalid dup() return value %ld", TST_RET);
-		return;
-	}
-
-	if (TST_RET == -1) {
-		if (TST_ERR == EMFILE)
-			tst_res(TPASS | TTERRNO, "dup() failed as expected");
-		else
-			tst_res(TFAIL | TTERRNO, "dup() failed unexpectedly");
-		return;
-	}
-
-	tst_res(TFAIL, "dup() succeeded unexpectedly");
-	SAFE_CLOSE(TST_RET);
+	if (TST_RET != -1)
+		SAFE_CLOSE(TST_RET);
 }
 
 static void setup(void)
 {
 	long maxfds;
 
-	maxfds = sysconf(_SC_OPEN_MAX);
-	if (maxfds == -1)
-		tst_brk(TBROK, "sysconf(_SC_OPEN_MAX) failed");
-
+	maxfds = SAFE_SYSCONF(_SC_OPEN_MAX);
 	fd = SAFE_MALLOC(maxfds * sizeof(int));
 
 	fd[0] = SAFE_OPEN("dupfile", O_RDWR | O_CREAT, 0700);
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
