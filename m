Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAAEC43334
	for <ltp@archiver.kernel.org>; Fri, 15 Jul 2022 14:25:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 656D33CAA15
	for <ltp@archiver.kernel.org>; Fri, 15 Jul 2022 16:25:35 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 75C543CAA15
 for <ltp@lists.linux.it>; Fri, 15 Jul 2022 16:25:25 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C948A600E55
 for <ltp@lists.linux.it>; Fri, 15 Jul 2022 16:25:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8F1FB34DD1
 for <ltp@lists.linux.it>; Fri, 15 Jul 2022 14:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657895123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oG8hc3yp0VztFbVKNKXjNWxx7ueO0pdrAhym9pZw4nU=;
 b=S1cHQfHtQoJcidPk/uyWG5r2q8gOoGFrZJqUMPDHkUM1cUVV2kQ9y0TTlUFVbE2Hg2o3Jj
 mqOJoFfxpQgRx2FC3uec1eL/pd1lN0oKyToOSbwUu4K4U869prJZlrYn3skQdfQl/5m25n
 bXZO506DRDO4kB4D+/opLzMb2RB2TiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657895123;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oG8hc3yp0VztFbVKNKXjNWxx7ueO0pdrAhym9pZw4nU=;
 b=210E/TvvffS+hyqtBXWPmSIeRr6BWPhoZpkIrn+uzadJir0nU1+Q8CXw/T9jFuS/4YGZET
 CUo6cwoHyYmH+CCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D3A513754
 for <ltp@lists.linux.it>; Fri, 15 Jul 2022 14:25:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OHYOMNJ40WKWQQAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Fri, 15 Jul 2022 14:25:22 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Fri, 15 Jul 2022 19:55:20 +0530
Message-Id: <20220715142520.6632-1-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/truncate03.c: use TST_EXP_FAIL() macro
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
 .../kernel/syscalls/truncate/truncate03.c     | 21 ++-----------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/testcases/kernel/syscalls/truncate/truncate03.c b/testcases/kernel/syscalls/truncate/truncate03.c
index a9cd4b3ed..1e19f7743 100644
--- a/testcases/kernel/syscalls/truncate/truncate03.c
+++ b/testcases/kernel/syscalls/truncate/truncate03.c
@@ -116,25 +116,8 @@ static void verify_truncate(unsigned int n)
 {
 	struct test_case_t *tc = &test_cases[n];
 
-	TEST(truncate(tc->pathname, tc->length));
-	if (TST_RET == 0) {
-		tst_res(TFAIL, "truncate() succeeded when failure expected");
-		return;
-	}
-
-	if (TST_RET != -1) {
-		tst_res(TFAIL, "truncate() returned invalid value %ld",
-			TST_RET);
-		return;
-	}
-
-	if (TST_ERR == tc->exp_errno) {
-		tst_res(TPASS | TTERRNO, "truncate() failed as expected");
-	} else {
-		tst_res(TFAIL | TTERRNO,
-			"truncate() failed unexpectedly; expected: %d - %s",
-			tc->exp_errno, strerror(tc->exp_errno));
-	}
+	TST_EXP_FAIL(truncate(tc->pathname, tc->length),
+				tc->exp_errno);
 }
 
 static struct tst_test test = {
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
