Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B7BE64ABA
	for <ltp@archiver.kernel.org>; Tue,  3 Dec 2024 15:16:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE7C13DE31D
	for <ltp@archiver.kernel.org>; Tue,  3 Dec 2024 16:16:19 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5048D3DE306
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 16:15:30 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DAB55231817
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 16:15:29 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 80CC9210F6
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 15:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733238928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IaguDI3fwH1HmXGXIZVeUjhDGc94CZDIE3Z5jol8uQY=;
 b=wR7TDRElGk7a1uJwO1KXRtY2EqkA55nGEYwGlDaE0MmNjC1PyqH5mtHyITgB9nq318VwLG
 Aa4w5KuVsCWAbbVIJQTL6dHEr7hu7ToTOWkcNBD/lbO/wxviSfPyXY0stPOiIDn6stf32D
 IdvexWN4RJb/lMIlI1k/KIQVgAtmRxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733238928;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IaguDI3fwH1HmXGXIZVeUjhDGc94CZDIE3Z5jol8uQY=;
 b=dLF9jcyhgQvt/hOEyqaZW8+IAwnCRGUu+saUwzGbQ4uavzxjSvCBP4UGqhI4CIIOKrDCCz
 i7QMu1vUipbz4CDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wR7TDREl;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dLF9jcyh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733238928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IaguDI3fwH1HmXGXIZVeUjhDGc94CZDIE3Z5jol8uQY=;
 b=wR7TDRElGk7a1uJwO1KXRtY2EqkA55nGEYwGlDaE0MmNjC1PyqH5mtHyITgB9nq318VwLG
 Aa4w5KuVsCWAbbVIJQTL6dHEr7hu7ToTOWkcNBD/lbO/wxviSfPyXY0stPOiIDn6stf32D
 IdvexWN4RJb/lMIlI1k/KIQVgAtmRxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733238928;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IaguDI3fwH1HmXGXIZVeUjhDGc94CZDIE3Z5jol8uQY=;
 b=dLF9jcyhgQvt/hOEyqaZW8+IAwnCRGUu+saUwzGbQ4uavzxjSvCBP4UGqhI4CIIOKrDCCz
 i7QMu1vUipbz4CDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6FD54139C2
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 15:15:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HaFSGpAgT2erQwAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 03 Dec 2024 15:15:28 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  3 Dec 2024 16:15:27 +0100
Message-ID: <20241203151530.16882-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203151530.16882-1-chrubis@suse.cz>
References: <20241203151530.16882-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 80CC9210F6
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 SUBJECT_HAS_EXCLAIM(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 TO_DN_NONE(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/5] libs/ujson: Fix "Garbage after JSON string!" in
 strict mode
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

In strict mode warnings are converted into errors and filled into the
error buffer rather than being printed right away. That means that we
have to print error buffer after we issue a warning so that it's printed
in the strict mode (UJSON_READER_STRICT) as well.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 libs/ujson/ujson_reader.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/libs/ujson/ujson_reader.c b/libs/ujson/ujson_reader.c
index d508f00d3..9f86f25b7 100644
--- a/libs/ujson/ujson_reader.c
+++ b/libs/ujson/ujson_reader.c
@@ -1049,8 +1049,12 @@ void ujson_reader_finish(ujson_reader *self)
 {
 	if (ujson_reader_err(self))
 		ujson_err_print(self);
-	else if (!ujson_reader_consumed(self))
+	else if (!ujson_reader_consumed(self)) {
 		ujson_warn(self, "Garbage after JSON string!");
+
+		if (ujson_reader_err(self))
+			ujson_err_print(self);
+	}
 }
 
 void ujson_reader_free(ujson_reader *buf)
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
