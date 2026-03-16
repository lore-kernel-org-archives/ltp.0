Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F52F506C1
	for <ltp@archiver.kernel.org>; Mon, 16 Mar 2026 12:40:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 260443E5682
	for <ltp@archiver.kernel.org>; Mon, 16 Mar 2026 13:40:55 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 540A93E4B8B
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 13:40:38 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A1E8720007F
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 13:40:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3FEB25BD2A;
 Mon, 16 Mar 2026 12:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773664829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eeJte4yJ8qfgCkXOCd+RXLx5yGbEFYJwG7F9azyCpVo=;
 b=grh340N9/5tmriwwaZr+Rdx7ydAJ619dNmWuGIL6Rxt6T0jkXqKWP38w/lR2qNIbMYkVBt
 lRD+e/uIjsdn6mswW3xDkB6PUtiX0RlumvGC16xcVve3i4O74uNgMK0fuhHNP4Q1X08bvu
 DhTZm/3y6ZSHEMcm0yQuSH4Ay3rJ9wo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773664829;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eeJte4yJ8qfgCkXOCd+RXLx5yGbEFYJwG7F9azyCpVo=;
 b=hdN2RiflkbmOzKNgV3wke2EOvp3Qko1mSOA6s7p6UJjsZaKvqLjTbQ/QQ2cjq3h10ySG90
 EYgvd86QK6QgGBAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=grh340N9;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hdN2Rifl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773664829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eeJte4yJ8qfgCkXOCd+RXLx5yGbEFYJwG7F9azyCpVo=;
 b=grh340N9/5tmriwwaZr+Rdx7ydAJ619dNmWuGIL6Rxt6T0jkXqKWP38w/lR2qNIbMYkVBt
 lRD+e/uIjsdn6mswW3xDkB6PUtiX0RlumvGC16xcVve3i4O74uNgMK0fuhHNP4Q1X08bvu
 DhTZm/3y6ZSHEMcm0yQuSH4Ay3rJ9wo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773664829;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eeJte4yJ8qfgCkXOCd+RXLx5yGbEFYJwG7F9azyCpVo=;
 b=hdN2RiflkbmOzKNgV3wke2EOvp3Qko1mSOA6s7p6UJjsZaKvqLjTbQ/QQ2cjq3h10ySG90
 EYgvd86QK6QgGBAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFDEF4273B;
 Mon, 16 Mar 2026 12:40:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VZcNNTz6t2l8agAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 16 Mar 2026 12:40:28 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 16 Mar 2026 13:40:21 +0100
Message-ID: <20260316124022.316230-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ASN(0.00)[asn:32098, ipnet:2800::/6, country:US];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 3FEB25BD2A
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tst_kconfig: Don't consider CONFIG_FAULT_INJECTION
 slow
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

Tumbleweed has only CONFIG_FAULT_INJECTION. All tests run ok before
(without 4x longer expected runtime), let's don't blindly increase it.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
IMHO the only effect of the detection on Tumbleweed would be if test
gets stuck will block testing for 2 min instead of just 30 sec.

Kind regards,
Petr

 lib/tst_kconfig.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index adc56503e2..5f778d2adc 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -647,7 +647,6 @@ static struct tst_kconfig_var slow_kconfigs[] = {
 	TST_KCONFIG_INIT("CONFIG_DEBUG_NET"),
 	TST_KCONFIG_INIT("CONFIG_EXT4_DEBUG"),
 	TST_KCONFIG_INIT("CONFIG_QUOTA_DEBUG"),
-	TST_KCONFIG_INIT("CONFIG_FAULT_INJECTION"),
 	TST_KCONFIG_INIT("CONFIG_DEBUG_OBJECTS")
 };
 
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
