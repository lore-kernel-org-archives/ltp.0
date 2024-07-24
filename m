Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6384C3DA63
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 09:19:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D677F3D1C14
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 11:18:59 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D9033C0123
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 11:18:44 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 019C810189AC
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 11:18:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D0EF71F796
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 09:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721812723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=BgI2fO7+cyCYwoLEsOQ1WHqIgSyCtWTKztxdr48b2SM=;
 b=VkATlkchDzNfoqAraaxhRwYm8/NZjIC6ri1vx0kYIvs6I+rK0Xt1vKsMHAqo22gywafKxq
 8iw/GY2ZJunFUDXXbEisPogRSvI47XtvqVyNl7AMnJ8H9glRPYLgQ6k9TfP/HZ/pezSD8s
 5fJkXkan0p+Y21wshtwFD6iCZqeEJN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721812723;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=BgI2fO7+cyCYwoLEsOQ1WHqIgSyCtWTKztxdr48b2SM=;
 b=Fxo4jqqr8b17v2pbsxsgpNGallFwDmGBT+LM5oOJpENpsWiA8YSftbDfVwZLNkc906TqsC
 KOfs2eSTfQrX8IAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="imKu/05e";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UJtJbmFi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721812722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=BgI2fO7+cyCYwoLEsOQ1WHqIgSyCtWTKztxdr48b2SM=;
 b=imKu/05eUM445RopHHVdv3SRj0EiU/kLJFVnK9lZ5zYwFkYOxRAdcGRRahqpc7nxKsxZ/f
 5IwTzzsFgi/FDogCR08hfNgHR643DpPQSl8jFP3DbLa7Yzb3dP3VmnUoab1yPUuJGAMrDU
 6LaMx9zJoRVuZrctNKQhMXQTAwOJ/KY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721812722;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=BgI2fO7+cyCYwoLEsOQ1WHqIgSyCtWTKztxdr48b2SM=;
 b=UJtJbmFi0MFDa6DzCRsvbE6onbzMwYrfL2Vo4yCZNgm8cFPgM775Qkai97UG2EQH4+N9zm
 8OVICi1ektpm9EBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD2EC1324F
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 09:18:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fMZ4LfLGoGbGVAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 09:18:42 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 24 Jul 2024 11:18:17 +0200
Message-ID: <20240724091817.5059-1-chrubis@suse.cz>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: D0EF71F796
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tst_tmpdir: Do not SegFault when .needs_tmpdir was
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
 lib/tst_tmpdir.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
index 1fb1bd698..bbb45dfa9 100644
--- a/lib/tst_tmpdir.c
+++ b/lib/tst_tmpdir.c
@@ -358,6 +358,9 @@ char *tst_tmpdir_path(void)
 {
 	static char *tmpdir;
 
+	if (!TESTDIR)
+		tst_brk(TBROK, ".needs_tmpdir must be set!");
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
+		tst_brk(TBROK, ".needs_tmpdir must be set!");
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
