Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4354EFF8875
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 09:20:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F13D93E49DA
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 11:20:14 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C088A3E210C
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 11:19:57 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 29CC2200B3D
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 11:19:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 85F696A7CD
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 09:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777540796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1Xwc4dzH4mXgvOWli6Hm3DROT3gfQ4A4tIwzKIUo19M=;
 b=L4Dd5y9Bm5jQ2pCdQ+I4BzWNH8pt7X6RuxUuDRQiPLROzjc5Gi1F/8HUoL1kxR5KtdXIXx
 HgLAae+8YKOOd1qNVQBkABeexE9cxLGFBBiniFx8j4wMTRPsbGuXwwkoYpZwjaSHomdqYP
 jZehLVxTc10wQY7YTnPkl0X5o51Dzww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777540796;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1Xwc4dzH4mXgvOWli6Hm3DROT3gfQ4A4tIwzKIUo19M=;
 b=Qtq0VGauC+n/1nHjodoljiXOV7T7aa3vAMMCDQwVwAdKQ2VXBSPBvK+6ELNAMKHGNROmq7
 s2uzgNvUVerDOSBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777540796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1Xwc4dzH4mXgvOWli6Hm3DROT3gfQ4A4tIwzKIUo19M=;
 b=L4Dd5y9Bm5jQ2pCdQ+I4BzWNH8pt7X6RuxUuDRQiPLROzjc5Gi1F/8HUoL1kxR5KtdXIXx
 HgLAae+8YKOOd1qNVQBkABeexE9cxLGFBBiniFx8j4wMTRPsbGuXwwkoYpZwjaSHomdqYP
 jZehLVxTc10wQY7YTnPkl0X5o51Dzww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777540796;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1Xwc4dzH4mXgvOWli6Hm3DROT3gfQ4A4tIwzKIUo19M=;
 b=Qtq0VGauC+n/1nHjodoljiXOV7T7aa3vAMMCDQwVwAdKQ2VXBSPBvK+6ELNAMKHGNROmq7
 s2uzgNvUVerDOSBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75FC7593B0
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 09:19:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tNarG7we82k4OgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 09:19:56 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 30 Apr 2026 11:19:56 +0200
Message-ID: <20260430091956.10915-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib: tst_test: tst_reinit() abort when already
 initialized
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

Calling tst_reinit() when library is already initialized or calling it
for a second time is always mistake. With that we silenty drop the old
IPC region, that may have contained test results and there are likely
other problems possibly caused by initializing the test library twice.

To fix that this patch adds tst_brk() that abort the test if we call
tst_reinit() with already initialized test library.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 26f6510a0..fa61e1be4 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -196,6 +196,9 @@ void tst_reinit(void)
 	size_t size = getpagesize();
 	int fd;
 
+	if (ipc)
+		tst_brk(TBROK, "Test library already initialized!");
+
 	if (!path)
 		tst_brk(TBROK, IPC_ENV_VAR" is not defined");
 
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
