Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1642CE77188
	for <ltp@archiver.kernel.org>; Mon,  6 Jan 2025 13:26:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8AB783C4BFC
	for <ltp@archiver.kernel.org>; Mon,  6 Jan 2025 14:26:41 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 56F2E3C4BC7
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 14:26:24 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BD34663CB2A
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 14:26:23 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E048D21161;
 Mon,  6 Jan 2025 13:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736169983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cJXvCOGRRI6ySQwzzy/r2pe2GRoLQINgsrPQIdFM7x4=;
 b=xWAEOi2StKaqwizlgMauIjN+3yR9ZKOlVaX/Ik06sx64eYAYxBvJ/r4GR3DxBk2TGbLmCL
 1L8eY27KXz2lZZQgOA2x84ZoF2q4Bw496peGI/j4pqKy6Z5Y8Iv274v32Vb8f1hRY9qaYc
 +fovXwmqHonSJHEsTUO4hUvq3iff6K4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736169983;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cJXvCOGRRI6ySQwzzy/r2pe2GRoLQINgsrPQIdFM7x4=;
 b=CxhwsjSDMpY9adamU/uq3DHJkm3/cF55aTpJd/bFDtqqmhL/a8+bGAW/ZHrQ8EQ5ZwWF+r
 D//CSgKosqv/nwAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QXVqjQed;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hSMt70Jr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736169982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cJXvCOGRRI6ySQwzzy/r2pe2GRoLQINgsrPQIdFM7x4=;
 b=QXVqjQedt9ZuzcIT1ldhzEeW0H6lbLNu0+tJQ8yp16XIKV7w1yooIMiyi5hSUqpGdhY2QU
 JepSTDsOtDa9ixMaCK/s5WAGnoSOwpGJs7qv4ziF/HA5l2Ts+byFbfOEDyNj2Q99+nhEeW
 7CGM8RTR+69O5qqbupIJe5nH/BFBB/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736169982;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cJXvCOGRRI6ySQwzzy/r2pe2GRoLQINgsrPQIdFM7x4=;
 b=hSMt70Jrvsa4Cvhq6a3ukMcxPSkbwpRWRodkeSu5jWwAPVbTXcZIDH4yPaXqC0Fv5uwNcW
 XJx7i0NG4y1Tr3BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF74413ABF;
 Mon,  6 Jan 2025 13:26:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id udmpLf7Ze2fMKgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 06 Jan 2025 13:26:22 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  6 Jan 2025 14:26:04 +0100
Message-ID: <20250106132607.25627-4-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250106132607.25627-1-chrubis@suse.cz>
References: <20250106132607.25627-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: E048D21161
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SUBJECT_HAS_EXCLAIM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_NONE(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim, suse.cz:mid, suse.cz:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/6] libs/ujson: Fix "Garbage after JSON string!"
 in strict mode
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
Acked-by: Petr Vorel <pvorel@suse.cz>
Fixes: c50a0e0751c8 ("libs: Vendor ujson library")
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
