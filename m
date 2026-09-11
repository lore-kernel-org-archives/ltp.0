Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338F3C79FA1
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 07:54:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 497C43E724D
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 09:54:07 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 33EAB3C6512
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 09:53:51 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 901C1600678
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 09:53:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CA9A021D2D;
 Fri, 11 Sep 2026 07:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789113225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OdxZWJhqFaWr3vzUIG+pt/SbLArewDk7V2uGMN57Rmw=;
 b=Rim6B1DXJ/Jwwd+tPovKD4GWDGoYYSdYdY06mMqmd+AOO53QNAI6lxNikYKoYxNiPO4DqQ
 O+gnG46IW5NQzoqCwGaDjmtBE+r/O6u/Yv9i0BoU3umw0LRkiXf2jvDO6aC2JKGu2c3/g1
 nMLvu1SUI9YiziKtsQlSQPnXVSEXPS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789113225;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OdxZWJhqFaWr3vzUIG+pt/SbLArewDk7V2uGMN57Rmw=;
 b=gKC83S6s6ZR54GIiOoBiKCiLljHMh3nxwYbpriutmAvmqdeECuxLPuSZBIjB5lTSPYzDXT
 EYMcZ+A6cLdhSvCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Pp20YK0B;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VWMxClIv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789113221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OdxZWJhqFaWr3vzUIG+pt/SbLArewDk7V2uGMN57Rmw=;
 b=Pp20YK0B89wJq16LY9RgamsBcgeX+6SkrpyC6eQwj07OQ09kTDytq7mraJJZP2BW5Sl7Rk
 8UfzJpf4aAMJy+Z8y9YCaqC0yIJs0yiLvsftE1UWDU6FCYdQF5ziHuheQC2u1f8WJ9sJT1
 DOxDJ1WaGcus+4nIOIdijJkwY8WGpdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789113221;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OdxZWJhqFaWr3vzUIG+pt/SbLArewDk7V2uGMN57Rmw=;
 b=VWMxClIvDw2gggHwpEUMUFHV0xgqBxYEg7JWMktkcMcLB5rM4Q+oU1xQa+EZUKf9Px3JBL
 dG6uf8OefsOeztAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 91ACE136ED;
 Fri, 11 Sep 2026 07:53:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jJOlIYWzo2ryYAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 11 Sep 2026 07:53:41 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 11 Sep 2026 09:53:40 +0200
MIME-Version: 1.0
Message-Id: <20260911-fix_core_leak_astra-v1-1-bc5cb35a182a@suse.com>
X-B4-Tracking: v=1; b=H4sIAISzo2oC/yXMUQrCMBCE4auUfTbQBA2tVxEJ23TUVWllt5VC6
 d2N+vjBzL+SQQVGx2olxVtMxqHA7yrKNx6ucNIXU6hDrFvv3UWWlEdFeoIfiW1SdgixYd/2+3h
 oqDxfijL7VU/nv23u7sjTN0Xb9gHl8OW+dwAAAA==
X-Change-ID: 20260911-fix_core_leak_astra-e268a19d4658
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789113221; l=883;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=8MTwAM5Y6QDc25F/gKC4LVPBlzfP2wKj3n1/9CR6wpc=;
 b=V+TJi0vvLyOj1ymTUANwzaSkpLWzfqYlzt0xPjZ+KZyUpfzebqq351BQ9+7F+WUh2y59tzg3I
 BZFUa5iWyPpD6vR1eCxQ+dXViGTMsSHBP4lh2ZSPoLjDca/8u84Km7L
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Queue-Id: CA9A021D2D
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tst_af_alg: Fix control buffer memory leak
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

The ancillary control buffer allocated in tst_alg_sendmsg() is never
freed after sendmsg(), leaking memory on repeated calls in the same
process.

Free the buffer once sendmsg() completes.

Fixes: 3cbb963abb9e ("lib/tst_af_alg: add tst_alg_sendmsg()")
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 lib/tst_af_alg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/tst_af_alg.c b/lib/tst_af_alg.c
index 93757278f..10fb42da5 100644
--- a/lib/tst_af_alg.c
+++ b/lib/tst_af_alg.c
@@ -249,4 +249,6 @@ void tst_alg_sendmsg(int reqfd, const void *data, size_t datalen,
 	}
 
 	SAFE_SENDMSG(datalen, reqfd, &msg, params->msg_flags);
+
+	free(control);
 }

---
base-commit: b8f93f82fd94a598d632ee3785cf664efd97afae
change-id: 20260911-fix_core_leak_astra-e268a19d4658

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
