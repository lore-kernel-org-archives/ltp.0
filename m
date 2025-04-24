Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C39AC369D1
	for <ltp@archiver.kernel.org>; Thu, 24 Apr 2025 10:55:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D60D3CB314
	for <ltp@archiver.kernel.org>; Thu, 24 Apr 2025 12:55:57 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A6B73C041A
 for <ltp@lists.linux.it>; Thu, 24 Apr 2025 12:55:40 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 50D00140075B
 for <ltp@lists.linux.it>; Thu, 24 Apr 2025 12:55:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6C6FA21188;
 Thu, 24 Apr 2025 10:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1745492136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ybcaOUiJ6vH71EtGc8sHXNoq6emlfHZjxxi1jv7J4gU=;
 b=MNnLxWXIQv3BaHdJBpg82nd6FxJXBDNlg+73XrxQRub0pWEQ8oX5C6AVk4YUzif2xawdgB
 d5BFb9Rud3QiRIlC9NFS8UDS7ej5QfT7pFbNPpxaQd0leBCY1VqXKkfyaKe7HH4i+s93Jj
 elXxfhpfvlcxPD5n9fxQ0UxAztOGdv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1745492136;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ybcaOUiJ6vH71EtGc8sHXNoq6emlfHZjxxi1jv7J4gU=;
 b=hZBpWgJ6m3CILHM8YFXk2tpDoCkNmJFmr69sp3pVD5XYYK9yFnGc0T8HqADed1b4LBcCjb
 XUhyQYsHb9diOuCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MNnLxWXI;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hZBpWgJ6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1745492136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ybcaOUiJ6vH71EtGc8sHXNoq6emlfHZjxxi1jv7J4gU=;
 b=MNnLxWXIQv3BaHdJBpg82nd6FxJXBDNlg+73XrxQRub0pWEQ8oX5C6AVk4YUzif2xawdgB
 d5BFb9Rud3QiRIlC9NFS8UDS7ej5QfT7pFbNPpxaQd0leBCY1VqXKkfyaKe7HH4i+s93Jj
 elXxfhpfvlcxPD5n9fxQ0UxAztOGdv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1745492136;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ybcaOUiJ6vH71EtGc8sHXNoq6emlfHZjxxi1jv7J4gU=;
 b=hZBpWgJ6m3CILHM8YFXk2tpDoCkNmJFmr69sp3pVD5XYYK9yFnGc0T8HqADed1b4LBcCjb
 XUhyQYsHb9diOuCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 651A6139D0;
 Thu, 24 Apr 2025 10:55:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aIOqGKgYCmjnMgAAD6G6ig
 (envelope-from <akumar@suse.de>); Thu, 24 Apr 2025 10:55:36 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu, 24 Apr 2025 12:55:34 +0200
Message-ID: <20250424105536.21645-1-akumar@suse.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: 6C6FA21188
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.de:+]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.de:email, suse.de:dkim,
 suse.de:mid, imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] unshare03: use sizeof(long long) to fix for 32bit
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

when executing on 32bit compat layer
"nr_open = sizeof(long) * 8" does not evaluate to a large enough value
for /proc/sys/fs/nr_open.
unshare03.c:38: TBROK: Failed to close FILE '/proc/sys/fs/nr_open': EINVAL (22)
Use (long long) instead.

Fixes: fc8be6ed4 ("unshare03: Simplify EMFILE test by using fixed fd limit (sizeof(long) * 8)")
Suggested-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/unshare/unshare03.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/unshare/unshare03.c b/testcases/kernel/syscalls/unshare/unshare03.c
index c3b98930d..7128b3b97 100644
--- a/testcases/kernel/syscalls/unshare/unshare03.c
+++ b/testcases/kernel/syscalls/unshare/unshare03.c
@@ -27,7 +27,7 @@ static void run(void)
 		.exit_signal = SIGCHLD,
 	};
 
-	int nr_open = sizeof(long) * 8;
+	int nr_open = sizeof(long long) * 8;
 
 	SAFE_DUP2(2, nr_open + 1);
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
