Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6E9D3B7F3
	for <ltp@archiver.kernel.org>; Mon,  8 Dec 2025 15:06:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A8E03CF515
	for <ltp@archiver.kernel.org>; Mon,  8 Dec 2025 16:06:32 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1984C3CF4B3
 for <ltp@lists.linux.it>; Mon,  8 Dec 2025 16:05:48 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A7D3610008EC
 for <ltp@lists.linux.it>; Mon,  8 Dec 2025 16:05:47 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3DED033683;
 Mon,  8 Dec 2025 15:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765206346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0He3ypyQdjrGuXp02W68AbPVdN/vXDCnfnb47NzUrgk=;
 b=FYcXt1P/H6aqUj+j1nQrfts9IuEuG2vahc2mrAS9OnZ3hDnxXYwNo9+rCzoAk+WCnDyWul
 Ew/DJ9PhtsAs7E8yEBovQfNPIJI2ev4Ao7M68d0HTHF4JX9sMlb5vR2K3hhFuIeoMqNnE0
 6Q9XTCn9Iu6EiLVN7g9T2qEk89eQ0Rs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765206346;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0He3ypyQdjrGuXp02W68AbPVdN/vXDCnfnb47NzUrgk=;
 b=NW6+kSU93EbZM0OXOf2zEoxbV4DfkUTBmDRiwr8TQTFMyH8XVwNCCTFcHoOPSRavSRZwHG
 ZUg5t9KfVkRtbTBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765206346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0He3ypyQdjrGuXp02W68AbPVdN/vXDCnfnb47NzUrgk=;
 b=FYcXt1P/H6aqUj+j1nQrfts9IuEuG2vahc2mrAS9OnZ3hDnxXYwNo9+rCzoAk+WCnDyWul
 Ew/DJ9PhtsAs7E8yEBovQfNPIJI2ev4Ao7M68d0HTHF4JX9sMlb5vR2K3hhFuIeoMqNnE0
 6Q9XTCn9Iu6EiLVN7g9T2qEk89eQ0Rs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765206346;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0He3ypyQdjrGuXp02W68AbPVdN/vXDCnfnb47NzUrgk=;
 b=NW6+kSU93EbZM0OXOf2zEoxbV4DfkUTBmDRiwr8TQTFMyH8XVwNCCTFcHoOPSRavSRZwHG
 ZUg5t9KfVkRtbTBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 142083EA65;
 Mon,  8 Dec 2025 15:05:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kFwoBErpNmnCWQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 08 Dec 2025 15:05:46 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  8 Dec 2025 16:05:41 +0100
Message-ID: <20251208150542.704006-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251208150542.704006-1-pvorel@suse.cz>
References: <20251208150542.704006-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.984]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] safe_keyctl: Skip with TCONF on EOPNOTSUPP
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
Cc: Mingyu Li <limy83@chinatelecom.cn>, Meng Yang <yangm50@chinatelecom.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

errno EOPNOTSUPP is likely a configuration issue, skip testing
with TCONF.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/lapi/keyctl.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/lapi/keyctl.h b/include/lapi/keyctl.h
index e08b8f1322..ab5c8a530f 100644
--- a/include/lapi/keyctl.h
+++ b/include/lapi/keyctl.h
@@ -209,10 +209,11 @@ static inline long safe_keyctl(const char *file, const int lineno,
 {
 	long rval;
 	int failure = 0;
+	int res = errno == EOPNOTSUPP ? TCONF : TBROK | TERRNO;
 
 	rval = keyctl(cmd, arg2, arg3, arg4, arg5);
 	if (rval == -1) {
-		tst_brk_(file, lineno, TBROK | TERRNO,
+		tst_brk_(file, lineno, res,
 			"keyctl(%d, %lu, %lu, %lu, %lu)",
 			cmd, arg2, arg3, arg4, arg5);
 	}
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
