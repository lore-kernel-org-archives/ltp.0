Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFDC1C47422
	for <ltp@archiver.kernel.org>; Thu, 25 Jan 2024 15:51:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 28C363CFAFB
	for <ltp@archiver.kernel.org>; Thu, 25 Jan 2024 16:51:29 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A0F113CE1E6
 for <ltp@lists.linux.it>; Thu, 25 Jan 2024 16:51:14 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EE4321A0100A
 for <ltp@lists.linux.it>; Thu, 25 Jan 2024 16:51:13 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D212C1F88D;
 Thu, 25 Jan 2024 15:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706197872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zyeZk1KxQlGSa+S7DLlIoUWWc/eUp67r4UM/IPMbbHw=;
 b=N7Ni1WgZlzYF1L2eqKfd9rxSku5EL6Hw4cB2ERMApUtlmZeEnRthDXoapN4pJFWLvh1eRR
 xfbw4sryJeWSDsitQrTa5F8mTXrKVVBW3zWOM7Ky2zhjVfAW1ARLOL8o6winMw2rMN4VXv
 UL3P2ahjmCgbrnuWQRVbFEk4WsgsiWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706197872;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zyeZk1KxQlGSa+S7DLlIoUWWc/eUp67r4UM/IPMbbHw=;
 b=BnCxxh/MIprq7d2SpEXU4oMVdj7gXWKRPERL6SKq5UHfRYhtLOQX8y3HIPgKmszykp7sGl
 unX5RKLZaL3bBcDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706197871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zyeZk1KxQlGSa+S7DLlIoUWWc/eUp67r4UM/IPMbbHw=;
 b=uw/OXPEJJINc9oInsx75K+zvC8WDGbPbL0+Ly5TdlA3+jn1enovEllvddG1oQ9dcatrl5Z
 21YiTwON8z4/M7iBPX1L1f1p8uRBR3ROCQUwoR7MCOBvQ4okBCiFAuoNnnLAj4IJlcnszw
 I9k5ohYSdMCulyP9OmuDTYroFzuBEP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706197871;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zyeZk1KxQlGSa+S7DLlIoUWWc/eUp67r4UM/IPMbbHw=;
 b=WcCr2QLr8Am/EOX7tvbrGgmxYGLkn5/7uKRbppcWjj/mXagoEdKuUa1EhaAXAPrlQZesVM
 +QASCEWzevBT8kAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F0C313649;
 Thu, 25 Jan 2024 15:51:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 10QfG2+DsmXjbgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 25 Jan 2024 15:51:11 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 25 Jan 2024 16:51:07 +0100
Message-ID: <20240125155107.430656-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Bar: +++
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="uw/OXPEJ";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WcCr2QLr
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.34 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[5]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.15)[68.65%]
X-Rspamd-Queue-Id: D212C1F88D
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] splice07: Whitelist /dev/zero on pipe write
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
Cc: Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

/dev/zero on pipe write started to succeeded on kernel 6.7.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

@Jan could you please check the problem is a kernel 6.7 bug
or just wanted change and we should whitelist /dev/zero on pipe write?

Thanks!

Kind regards,
Petr

 testcases/kernel/syscalls/splice/splice07.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/splice/splice07.c b/testcases/kernel/syscalls/splice/splice07.c
index 135c42e47..1fa13b3e6 100644
--- a/testcases/kernel/syscalls/splice/splice07.c
+++ b/testcases/kernel/syscalls/splice/splice07.c
@@ -38,6 +38,7 @@ static void check_splice(struct tst_fd *fd_in, struct tst_fd *fd_out)
 	if (fd_out->type == TST_FD_PIPE_WRITE) {
 		switch (fd_in->type) {
 		/* While these combinations succeeed */
+		case TST_FD_DEV_ZERO:
 		case TST_FD_FILE:
 		case TST_FD_MEMFD:
 			return;
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
