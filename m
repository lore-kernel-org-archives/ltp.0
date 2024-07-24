Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF9DC3DA63
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 09:23:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 177FC3D1C33
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 11:23:29 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5534E3C0123
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 11:23:14 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C82781408FB0
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 11:23:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CD764211C6
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 09:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721812991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PuVKyUbRYBrmhI/F1zLVhnUX/sKm+pheRlV+46GUGnw=;
 b=xdl6BgJZFDasDuvPWdvB22UvypzxbncyOKJTP7YNOJtQLxIivsRRQ/CthGCqYbn3YQSkK2
 z9J/LpS+Smzm8rAjAEsNn1KK87xokErBXZn/bOvOMkAFs+PoIboXK+bJVKz0SvVGo/WqeW
 nnkhVadM3zjhrxNbRxCfUryS92W4a5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721812991;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PuVKyUbRYBrmhI/F1zLVhnUX/sKm+pheRlV+46GUGnw=;
 b=ikghtzB+MGGDQ91yOIdTeHAvWXtMby5ZpcM91G5GFwikrFGWSjtac5+j10judzSdghURzA
 yt/0Iw4BGAwclbBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xdl6BgJZ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ikghtzB+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721812991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PuVKyUbRYBrmhI/F1zLVhnUX/sKm+pheRlV+46GUGnw=;
 b=xdl6BgJZFDasDuvPWdvB22UvypzxbncyOKJTP7YNOJtQLxIivsRRQ/CthGCqYbn3YQSkK2
 z9J/LpS+Smzm8rAjAEsNn1KK87xokErBXZn/bOvOMkAFs+PoIboXK+bJVKz0SvVGo/WqeW
 nnkhVadM3zjhrxNbRxCfUryS92W4a5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721812991;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PuVKyUbRYBrmhI/F1zLVhnUX/sKm+pheRlV+46GUGnw=;
 b=ikghtzB+MGGDQ91yOIdTeHAvWXtMby5ZpcM91G5GFwikrFGWSjtac5+j10judzSdghURzA
 yt/0Iw4BGAwclbBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99A671324F
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 09:23:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gxVVJP/HoGbDVQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 09:23:11 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 24 Jul 2024 11:22:38 +0200
Message-ID: <20240724092238.6774-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.44.2
MIME-Version: 1.0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.19 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_NONE(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: CD764211C6
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] tst_tmpdir: Do not SegFault when .needs_tmpdir was
 not set
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

Print TBROK message about the missing .needs_tmpdir flag instead.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
v2: Fix warning about undefined tst_brk() this is an old library
    file hence we need tst_brkm().

 lib/tst_tmpdir.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
index 1fb1bd698..7986f1bc0 100644
--- a/lib/tst_tmpdir.c
+++ b/lib/tst_tmpdir.c
@@ -358,6 +358,9 @@ char *tst_tmpdir_path(void)
 {
 	static char *tmpdir;
 
+	if (!TESTDIR)
+		tst_brkm(TBROK, NULL, ".needs_tmpdir must be set!");
+
 	if (tmpdir)
 		return tmpdir;
 
@@ -368,11 +371,16 @@ char *tst_tmpdir_path(void)
 
 char *tst_tmpdir_mkpath(const char *fmt, ...)
 {
-	size_t testdir_len = strlen(TESTDIR);
-	size_t path_len = testdir_len;
+	size_t testdir_len, path_len;
 	va_list va, vac;
 	char *ret;
 
+	if (!TESTDIR)
+		tst_brkm(TBROK, NULL, ".needs_tmpdir must be set!");
+
+	testdir_len = strlen(TESTDIR);
+	path_len = testdir_len;
+
 	va_start(va, fmt);
 	va_copy(vac, va);
 	path_len += vsnprintf(NULL, 0, fmt, va) + 2;
-- 
2.44.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
