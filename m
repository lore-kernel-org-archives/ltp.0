Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B7E0C7EE25
	for <ltp@archiver.kernel.org>; Wed,  7 Jun 2023 14:45:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D0173CCE09
	for <ltp@archiver.kernel.org>; Wed,  7 Jun 2023 16:45:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C7563CAEF8
 for <ltp@lists.linux.it>; Wed,  7 Jun 2023 16:45:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 78CA1600AF9
 for <ltp@lists.linux.it>; Wed,  7 Jun 2023 16:45:19 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 46D8D219F2
 for <ltp@lists.linux.it>; Wed,  7 Jun 2023 14:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1686149118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=lXUKPPD94v0hYcns1uOsZD/q4JhXleUgpsYsNsYWmPg=;
 b=p3BMcdYZrEQBkT/JvbghuM3STVtQEzn7czXqL79DVlVh48HosIQru4sgyw3NAAzjtK/ADL
 7/+PQss31ZJe1I2MAzUu2++RwA3ywtFc1Pe4D3PIh+ncSKH8Gb1HUKYvDMf2iscgqFokWh
 PKpQ76kBe1tHcYXyYSa423Mh/r3npK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1686149118;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=lXUKPPD94v0hYcns1uOsZD/q4JhXleUgpsYsNsYWmPg=;
 b=GAL61+Ko2X9vpJlyn5beNalZlVl4Gwfjm0r7r1lZC+CsGP90EKHRTEs0lrx/1kuObpXS/V
 oYjOX2cP1l1I4TBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 36C2613776
 for <ltp@lists.linux.it>; Wed,  7 Jun 2023 14:45:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XrSNDP6XgGQeFgAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 07 Jun 2023 14:45:18 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  7 Jun 2023 16:45:17 +0200
Message-Id: <20230607144517.24972-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/madvise11: Ignore unpoison failure under
 kernel lockdown
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

When newer kernels are under lockdown, the unpoison-pfn sysfile
still appears writable to root but open() will always return EPERM.
This causes madvise11 to fail with TWARN during cleanup when run
with SecureBoot enabled.

Ignore the open(unpoison-pfn) failure due to lockdown and exit
successfully without cleanup. The test should not be skipped because
the leftover soft-offlined pages can trigger failures in later tests
and indirectly expose kernel bugs in hwpoison.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/syscalls/madvise/madvise11.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise11.c b/testcases/kernel/syscalls/madvise/madvise11.c
index 2cb45d00a..e63e28f8a 100644
--- a/testcases/kernel/syscalls/madvise/madvise11.c
+++ b/testcases/kernel/syscalls/madvise/madvise11.c
@@ -323,7 +323,20 @@ static int open_unpoison_pfn(void)
 	if (!mnt)
 		return -1;
 
-	return SAFE_OPEN(debugfs_fp, O_WRONLY);
+	TEST(open(debugfs_fp, O_WRONLY));
+
+	if (TST_RET == -1 && TST_ERR == EPERM && tst_lockdown_enabled()) {
+		tst_res(TINFO,
+			"Cannot restore soft-offlined memory due to lockdown");
+		return TST_RET;
+	}
+
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "open(%s) failed", debugfs_fp);
+	else if (TST_RET < 0)
+		tst_brk(TBROK | TTERRNO, "Invalid open() return value");
+
+	return TST_RET;
 }
 
 /*
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
