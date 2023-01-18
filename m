Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30990C32793
	for <ltp@archiver.kernel.org>; Wed, 18 Jan 2023 15:48:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 158AD3CC86F
	for <ltp@archiver.kernel.org>; Wed, 18 Jan 2023 16:48:46 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A8AD13C1BBD
 for <ltp@lists.linux.it>; Wed, 18 Jan 2023 16:48:35 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3832F1000AE9
 for <ltp@lists.linux.it>; Wed, 18 Jan 2023 16:48:34 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1EAF65C081
 for <ltp@lists.linux.it>; Wed, 18 Jan 2023 15:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1674056914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gzwduUTcbG5nGb43AX4oPX98n2C+veaVVHujr5XpKk8=;
 b=GwVS8/jsgFxIwFXZSArWQqnu7rCsRfz7zWjeyZJ73OvzhnWnaqr6J/bsIE+iSuKLzDUswc
 Ep7+pLsphs1sOFgdbhOsE6RVcOPF4rWnd9LKXVprBh2ZyhsEPogtUguTnM819HWjeCpV//
 Uqf/fh+B1YuvfBknwS8KWxiREsEQ4Q0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1674056914;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gzwduUTcbG5nGb43AX4oPX98n2C+veaVVHujr5XpKk8=;
 b=+TuyQR7Z6NHg0L9deBp8Qs6CA2lcqGfiQrnkSB48N3IHIsCPBRSeBSdzsQon4YM4toFDpP
 msX3aSYI9UPP0QDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0B91C139D2
 for <ltp@lists.linux.it>; Wed, 18 Jan 2023 15:48:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PdRlAdIUyGM+EwAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 18 Jan 2023 15:48:34 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 18 Jan 2023 16:50:09 +0100
Message-Id: <20230118155009.16593-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.38.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/statvfs01: Close fd only on success
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

This fixes TBROK in the case that the creat() call has failed
unexpectedly and allows the test to continue.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/statvfs/statvfs01.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/statvfs/statvfs01.c b/testcases/kernel/syscalls/statvfs/statvfs01.c
index f17dc4cfa..c10c67b18 100644
--- a/testcases/kernel/syscalls/statvfs/statvfs01.c
+++ b/testcases/kernel/syscalls/statvfs/statvfs01.c
@@ -42,7 +42,8 @@ static void run(void)
 	toolong_fname[valid_len+1] = 0;
 
 	TST_EXP_FD(creat(valid_fname, 0444));
-	SAFE_CLOSE(TST_RET);
+	if (TST_PASS)
+		SAFE_CLOSE(TST_RET);
 
 	TST_EXP_FAIL(creat(toolong_fname, 0444), ENAMETOOLONG);
 }
-- 
2.38.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
