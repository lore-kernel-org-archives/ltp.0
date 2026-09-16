Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E38FC88E77
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 14:05:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 156A83E8C49
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 16:05:11 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 46A273C72EC
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E71506002D2
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B46A81FD61;
 Wed, 16 Sep 2026 14:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3gX+iRDsBcN68XaVnlyB3I7sQokLuyRgD4W/10LZlnI=;
 b=Um8BVmxafCmLFiz+PvzkDCX2/PPdQMtnr7OS2aV8JjtqSolUjVC6QhD7+kUtWn5nAEzKBS
 hkHoLKZaYTeSQKM9dvCxJ4swjut7BeOQzSrZp54LY7uE96YNj7zdVHllpbhz98ZTv0HJkU
 s7kJHJbFGRQwSpRQJSBOAs8qiToZrcg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567454;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3gX+iRDsBcN68XaVnlyB3I7sQokLuyRgD4W/10LZlnI=;
 b=uCfyOufvfWIOjh1c6yKeSGPpGJPhrJ72w7FPGm4pvtGufqQojPOLjLYIuv3Nn1WJXpdySc
 sBCEnorItoJEkXBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bOwQfhFR;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QjYcARqW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3gX+iRDsBcN68XaVnlyB3I7sQokLuyRgD4W/10LZlnI=;
 b=bOwQfhFRDUWbkzDVsim9nPehM4sGKIitxxNetFIARkzsh71ctKB/uMMe7siCLdHW/prHaA
 VXHfRLJ5KaWGIkfJZUckw2a0vXAmX3uyAMTDVliBJe+7tmDsZBIsIwSb/ePeu/r9lzM2dK
 m9GQ6IwWjJlW/EQC1jXy/uO86omD+MI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567450;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3gX+iRDsBcN68XaVnlyB3I7sQokLuyRgD4W/10LZlnI=;
 b=QjYcARqWrgFXM4pOmXTM3ifd3UU9P0C0Kfn9pQ/LqxuscSDIX90x9LY2jBx5RbqbyV2GdG
 qB/F4xqtBv+f5+AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B6E3136D1;
 Wed, 16 Sep 2026 14:04:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1xhOO9ihqmqNRQAAD6G6ig:T3
 (envelope-from <pvorel@suse.cz>); Wed, 16 Sep 2026 14:04:10 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 16 Sep 2026 16:03:28 +0200
Message-ID: <20260916140402.1797325-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916140402.1797325-1-pvorel@suse.cz>
References: <20260916140402.1797325-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: B46A81FD61
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,suse.cz:mid];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 02/36] lapi/keyctl.h: Add SAFE_ADD_KEY()
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

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/lapi/keyctl.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/lapi/keyctl.h b/include/lapi/keyctl.h
index 1c6627f555..4ba797bf9c 100644
--- a/include/lapi/keyctl.h
+++ b/include/lapi/keyctl.h
@@ -283,8 +283,35 @@ static inline long safe_keyctl(const char *file, const int lineno,
 
 	return rval;
 }
+
 #define SAFE_KEYCTL(cmd, arg2, arg3, arg4, arg5) \
 	safe_keyctl(__FILE__, __LINE__, \
 	     (cmd), (arg2), (arg3), (arg4), (arg5))
 
+static inline key_serial_t safe_add_key(const char *file, const int lineno,
+			  const char *type, const char *desc,
+			  const void *payload, size_t size,
+			  key_serial_t keyring)
+{
+
+	int rval;
+
+	rval = add_key(type, desc, payload, size, keyring);
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			 "add_key(%s, '%s', %p, %ld, %d) failed",
+			 type, desc, payload, size, keyring);
+	} else if (rval < -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			 "Invalid add_key(%s, '%s', %p, %ld, %d) return value %d",
+			 type, desc, payload, size, keyring, rval);
+	}
+
+	return rval;
+}
+
+#define SAFE_ADD_KEY(type, desc, payload, size, keyring) \
+	safe_add_key(__FILE__, __LINE__, \
+                            (type), (desc), (payload), (size), (keyring))
 #endif	/* LAPI_KEYCTL_H__ */
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
