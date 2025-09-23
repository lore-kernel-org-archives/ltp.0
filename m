Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16528CAC5A7
	for <ltp@archiver.kernel.org>; Tue, 23 Sep 2025 15:48:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E9F6A3CDED0
	for <ltp@archiver.kernel.org>; Tue, 23 Sep 2025 17:48:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1EC123CDD49
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 17:48:36 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 46B561A00CA2
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 17:48:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 864B122344
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 15:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758642508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vqBQRnAYzrjWBPOFbWc40eIdCXNdKbazpGZ24QL6kMo=;
 b=bsVxXFas8lLJJG+RbqQ4omIGQzTLABUAxCw3mCsbEbeOE3JiVMcQCAjaA0LYwxmVSuKMry
 YVI086UDB4w7BQUlG39kbYZaZX1rP3yz0TtEwqQ5If5Jj/AEK0aRdIIW0g6l2MRakRmfdx
 iX6lmfDhG/RPxiKIECYCMda6VKo6zSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758642508;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vqBQRnAYzrjWBPOFbWc40eIdCXNdKbazpGZ24QL6kMo=;
 b=A5dnbVz3o5+kOhzW0srAvJDwUNBkFmwqi6p9wP0Q5wQCeaVfwj/e4AoR+OKkq35K5Fezu1
 +cI+heqj51QZ8aBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bsVxXFas;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=A5dnbVz3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758642508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vqBQRnAYzrjWBPOFbWc40eIdCXNdKbazpGZ24QL6kMo=;
 b=bsVxXFas8lLJJG+RbqQ4omIGQzTLABUAxCw3mCsbEbeOE3JiVMcQCAjaA0LYwxmVSuKMry
 YVI086UDB4w7BQUlG39kbYZaZX1rP3yz0TtEwqQ5If5Jj/AEK0aRdIIW0g6l2MRakRmfdx
 iX6lmfDhG/RPxiKIECYCMda6VKo6zSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758642508;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vqBQRnAYzrjWBPOFbWc40eIdCXNdKbazpGZ24QL6kMo=;
 b=A5dnbVz3o5+kOhzW0srAvJDwUNBkFmwqi6p9wP0Q5wQCeaVfwj/e4AoR+OKkq35K5Fezu1
 +cI+heqj51QZ8aBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E15D1388C
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 15:48:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NsuYHkzB0mguYQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 15:48:28 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 23 Sep 2025 17:48:27 +0200
Message-ID: <20250923154827.74305-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: 864B122344
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_ONE(0.00)[1];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] epoll_pwait06: Skip BPF map file descriptor
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

Older kernels don't support waiting for BPF map file descriptors using
epoll. Skip the subtest, other file descriptor types are sufficient.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

epoll_ctl(EPOLL_CTL_ADD) returns EPERM for BPF map file descriptor
on kernel v4.12.

 testcases/kernel/syscalls/epoll_pwait/epoll_pwait06.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait06.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait06.c
index 3bedc2cf5..d47327bed 100644
--- a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait06.c
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait06.c
@@ -36,6 +36,7 @@ static void run(void)
 		case TST_FD_DIR:
 		case TST_FD_DEV_ZERO:
 		case TST_FD_PROC_MAPS:
+		case TST_FD_BPF_MAP:
 		case TST_FD_FSOPEN:
 		case TST_FD_FSPICK:
 		case TST_FD_OPEN_TREE:
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
