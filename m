Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56EFC46CD2
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 14:21:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3AB333CE684
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 15:21:40 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB88B3CE24A
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 15:21:12 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6F959601A7F
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 15:21:12 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7C4F921EB2;
 Wed, 24 Jan 2024 14:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706106071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=m9DWAP0x/2l2SQxva4l3fzyrjEJdeu2bv5rKCPbCN/c=;
 b=mR3S6v0TjxAA10yyY0kpuzC+soGWXSsbOkH0vIx0b/zDHaAdYeK3FuVVZQE7lHOvA4J5HC
 rSK15j+251iWqYf3klyPSY5dDOEodPadOWCtMOMWbfhRQHGVhC3LShs9vu9tLEeQJwrhYS
 U02xBohGWyk+G1lglnQRw+VH9+ZXb2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706106071;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=m9DWAP0x/2l2SQxva4l3fzyrjEJdeu2bv5rKCPbCN/c=;
 b=+QLAwm7vbNbk2E4zMDPHc9NRrx70X6KXDw8+fzZeMDMIrAL3UjM4YRadrWt7E7i/WP17OY
 3E7AxdYfKWwqaiBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706106071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=m9DWAP0x/2l2SQxva4l3fzyrjEJdeu2bv5rKCPbCN/c=;
 b=mR3S6v0TjxAA10yyY0kpuzC+soGWXSsbOkH0vIx0b/zDHaAdYeK3FuVVZQE7lHOvA4J5HC
 rSK15j+251iWqYf3klyPSY5dDOEodPadOWCtMOMWbfhRQHGVhC3LShs9vu9tLEeQJwrhYS
 U02xBohGWyk+G1lglnQRw+VH9+ZXb2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706106071;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=m9DWAP0x/2l2SQxva4l3fzyrjEJdeu2bv5rKCPbCN/c=;
 b=+QLAwm7vbNbk2E4zMDPHc9NRrx70X6KXDw8+fzZeMDMIrAL3UjM4YRadrWt7E7i/WP17OY
 3E7AxdYfKWwqaiBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32EE41333E;
 Wed, 24 Jan 2024 14:21:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rPKHCdccsWUsWAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 24 Jan 2024 14:21:11 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 24 Jan 2024 15:21:08 +0100
Message-ID: <20240124142108.303782-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Bar: +++
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mR3S6v0T;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+QLAwm7v
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.49 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 TO_DN_SOME(0.00)[]; NEURAL_HAM_LONG(-1.00)[-0.998];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[31.38%]
X-Rspamd-Queue-Id: 7C4F921EB2
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] lib: tst_fd: Use tst_syscall() for TBROK
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

to avoid error on older distro (kernel 4.12)

tst_fd.c:144: TBROK: pidfd_open(): ENOSYS (38)

Fixes: a2b945776 ("lib: tst_fd: Avoid tst_brk(TCONF, ...) on older distros")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_fd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_fd.c b/lib/tst_fd.c
index ab7de81aa..a21a41131 100644
--- a/lib/tst_fd.c
+++ b/lib/tst_fd.c
@@ -139,7 +139,7 @@ static void open_timerfd(struct tst_fd *fd)
 
 static void open_pidfd(struct tst_fd *fd)
 {
-	fd->fd = syscall(__NR_pidfd_open, getpid(), 0);
+	fd->fd = tst_syscall(__NR_pidfd_open, getpid(), 0);
 	if (fd->fd < 0)
 		tst_brk(TBROK | TERRNO, "pidfd_open()");
 }
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
