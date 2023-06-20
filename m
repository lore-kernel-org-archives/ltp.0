Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88738EB64D8
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 16:30:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E631B3CE0EE
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 18:30:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9BE5E3CA8D7
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 18:30:31 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8C4671400BDE
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 18:30:29 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 32A8B218D9;
 Tue, 20 Jun 2023 16:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687278628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3mCcdPiCuNyGuVG93g/ZIWpgv9gwWnqrFhReap1IsBI=;
 b=uloGp7lyOKZz5FoEeOYb8oe0BXTk5ytYyqFWtp+Ykj4PMvYIAZTiZEcm8ktKaIIQkpjalW
 xuAdGC8qRyDOV8NSCOfo5199gGfh+TZAf7fjHlBDCiA+XWkMJQ0gwun0ymPPMBtGiz5ZJi
 qwt4s48CQlK62+buJG0qv9XPVQKgPJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687278628;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3mCcdPiCuNyGuVG93g/ZIWpgv9gwWnqrFhReap1IsBI=;
 b=B2Ks0W5BkOM3TE3dgyc1JkNTqjPGDQME4IN1NqECC/M0sL6uxr7bsmn7L3hjHuxDB/khoD
 613Q/KHtr8NwZTBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1F087133A9;
 Tue, 20 Jun 2023 16:30:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kRm8BiTUkWTVEQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Tue, 20 Jun 2023 16:30:28 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: Petr Vorel <pvorel@suse.cz>,
	ltp@lists.linux.it
Date: Tue, 20 Jun 2023 18:29:38 +0200
Message-ID: <20230620163027.22039-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/madvise11: Ignore unpoison failure under
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

Changes since v1: Print invalid return value in the error message

 testcases/kernel/syscalls/madvise/madvise11.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise11.c b/testcases/kernel/syscalls/madvise/madvise11.c
index 2cb45d00a..4c960dd35 100644
--- a/testcases/kernel/syscalls/madvise/madvise11.c
+++ b/testcases/kernel/syscalls/madvise/madvise11.c
@@ -323,7 +323,22 @@ static int open_unpoison_pfn(void)
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
+	if (TST_RET == -1) {
+		tst_brk(TBROK | TTERRNO, "open(%s) failed", debugfs_fp);
+	} else if (TST_RET < 0) {
+		tst_brk(TBROK | TTERRNO, "Invalid open() return value %ld",
+			TST_RET);
+	}
+
+	return TST_RET;
 }
 
 /*
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
