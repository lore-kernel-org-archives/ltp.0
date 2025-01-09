Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C691C02188
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 15:04:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CA403C262D
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 16:04:09 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4FF683C20E2
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 16:03:52 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 439B61BD1705
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 16:03:50 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 997A31F456;
 Thu,  9 Jan 2025 15:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736435029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sHm4O6v/VYHYNnPX6Uu6qCqU7V/BNsI3z1yeH9D52+k=;
 b=VLET3hOhbx+tig2kYPzNTVeccnLrC2xM7mKIkqAHyfGhLpuIYpYVHgG60DaEVfWeuqfLKM
 hKPtFuKpK4OM4cx/yysbPIe30ZDqZfIluGfYnbdHY+fdQ7D9Ybx0tkT/uy3cnqAXjjW1mM
 MlgGB1+Ljs6SYO8DKOzxv+8IHL+ipvM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736435029;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sHm4O6v/VYHYNnPX6Uu6qCqU7V/BNsI3z1yeH9D52+k=;
 b=XswuSRHKk0vEA4N5eOL8wI6Dm/QeIZmSjEMJ32jEtShuVL0hdVPPnSIlNCuTNvdNi6dDXd
 VHuYheD2QTolLmBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VLET3hOh;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=XswuSRHK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736435029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sHm4O6v/VYHYNnPX6Uu6qCqU7V/BNsI3z1yeH9D52+k=;
 b=VLET3hOhbx+tig2kYPzNTVeccnLrC2xM7mKIkqAHyfGhLpuIYpYVHgG60DaEVfWeuqfLKM
 hKPtFuKpK4OM4cx/yysbPIe30ZDqZfIluGfYnbdHY+fdQ7D9Ybx0tkT/uy3cnqAXjjW1mM
 MlgGB1+Ljs6SYO8DKOzxv+8IHL+ipvM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736435029;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sHm4O6v/VYHYNnPX6Uu6qCqU7V/BNsI3z1yeH9D52+k=;
 b=XswuSRHKk0vEA4N5eOL8wI6Dm/QeIZmSjEMJ32jEtShuVL0hdVPPnSIlNCuTNvdNi6dDXd
 VHuYheD2QTolLmBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 827B2139AB;
 Thu,  9 Jan 2025 15:03:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ndwoHlXlf2dsawAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 09 Jan 2025 15:03:49 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  9 Jan 2025 16:03:36 +0100
Message-ID: <20250109150336.25235-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: 997A31F456
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.cz:dkim, suse.cz:mid, suse.cz:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] safe_macros: Fix confusing safe_read() failure output
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

In the case that we read() less bytes than expected in the strict mode
we used the same tst_brk() as for the case when read() fails. However
for short reads the errno is in an udefined state and we possibly end up
with confusing TBROK message. Andrea reported EACESS ernno in the TBROK
message on a short read() while developing tests.

Reported-by: Andrea Cervesato <andrea.cervesato@suse.com>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/safe_macros.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 109268587..b224a5861 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -293,7 +293,7 @@ ssize_t safe_read(const char *file, const int lineno, void (*cleanup_fn) (void),
 
 	rval = read(fildes, buf, nbyte);
 
-	if (rval == -1 || (len_strict && (size_t)rval != nbyte)) {
+	if (rval == -1) {
 		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
 			"read(%d,%p,%zu) failed, returned %zd", fildes, buf,
 			nbyte, rval);
@@ -301,6 +301,10 @@ ssize_t safe_read(const char *file, const int lineno, void (*cleanup_fn) (void),
 		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
 			"Invalid read(%d,%p,%zu) return value %zd", fildes,
 			buf, nbyte, rval);
+	} else if (len_strict && (size_t)rval != nbyte) {
+		tst_brkm_(file, lineno, TBROK, cleanup_fn,
+			  "Short read(%d,%p,%zu) returned only %zd",
+			  fildes, buf, nbyte, rval);
 	}
 
 	return rval;
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
