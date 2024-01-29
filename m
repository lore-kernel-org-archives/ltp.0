Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B4FC47422
	for <ltp@archiver.kernel.org>; Mon, 29 Jan 2024 10:43:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F0A63CE116
	for <ltp@archiver.kernel.org>; Mon, 29 Jan 2024 11:43:48 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8BC513CB9A0
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 11:43:31 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 389E81A027AB
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 11:43:29 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A5BE42197F
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 10:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706525008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NHPCCWTJd79Si5bCzj+HmbjRJGukMJyypvh9kwZTlrU=;
 b=xUHGe8q6zyEMVvm7rXfvbS6UPzPRRQpsA0WS7JGJ9yycEm1kZso5kiGmXFeVH2JwTn2DqI
 RVf2M6XrwtVkJNjePkUvsEs9+2x0HfBKDJNXKt6gOh04JRVvoLhil9jRXeCyTpzqkskoYd
 OQvP/Gy/D5m+45b24mdhynhwWToRZOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706525008;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NHPCCWTJd79Si5bCzj+HmbjRJGukMJyypvh9kwZTlrU=;
 b=03g4FVtnX8tBqgeVYB5gGR3lDQzMRFRgWtWv0oztiTyDuL//9Z6XTNwMyfpHr6J2Ib/1ZA
 ynfCbmDH0K0cQ9Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706525008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NHPCCWTJd79Si5bCzj+HmbjRJGukMJyypvh9kwZTlrU=;
 b=xUHGe8q6zyEMVvm7rXfvbS6UPzPRRQpsA0WS7JGJ9yycEm1kZso5kiGmXFeVH2JwTn2DqI
 RVf2M6XrwtVkJNjePkUvsEs9+2x0HfBKDJNXKt6gOh04JRVvoLhil9jRXeCyTpzqkskoYd
 OQvP/Gy/D5m+45b24mdhynhwWToRZOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706525008;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NHPCCWTJd79Si5bCzj+HmbjRJGukMJyypvh9kwZTlrU=;
 b=03g4FVtnX8tBqgeVYB5gGR3lDQzMRFRgWtWv0oztiTyDuL//9Z6XTNwMyfpHr6J2Ib/1ZA
 ynfCbmDH0K0cQ9Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98BCF12FF7
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 10:43:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Dv60JFCBt2UbfwAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 10:43:28 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 29 Jan 2024 11:43:25 +0100
Message-ID: <20240129104327.10639-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_ONE(0.00)[1];
 RCVD_COUNT_THREE(0.00)[3]; TO_DN_NONE(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[36.68%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] splice07: Whitelist /proc/self/maps on pipe write
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

Just like with /dev/zero, splicing /proc/self/maps to writable pipe
is expected to pass. After generic splice() read emulation was removed,
it was reimplemented in commit b0072734ffaa ("tty, proc, kernfs, random:
Use copy_splice_read()")

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/syscalls/splice/splice07.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/splice/splice07.c b/testcases/kernel/syscalls/splice/splice07.c
index 1fa13b3e6..9c23e0aac 100644
--- a/testcases/kernel/syscalls/splice/splice07.c
+++ b/testcases/kernel/syscalls/splice/splice07.c
@@ -40,6 +40,7 @@ static void check_splice(struct tst_fd *fd_in, struct tst_fd *fd_out)
 		/* While these combinations succeeed */
 		case TST_FD_DEV_ZERO:
 		case TST_FD_FILE:
+		case TST_FD_PROC_MAPS:
 		case TST_FD_MEMFD:
 			return;
 		/* And this complains about socket not being connected */
-- 
2.42.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
