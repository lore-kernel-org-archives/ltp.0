Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AEEDCA9ED2
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 12:03:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 88F8C3EA81A
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 14:03:01 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 678793EA815
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 14:02:03 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C610E6002FB
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 14:02:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 57A4B1F45F;
 Tue, 13 Oct 2026 12:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791892922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Essr/9mvsYelqo9XEUhRpx9Ww7y2ATOmlocwvS3zNUI=;
 b=IkLqXoAofdiwQDYCyJZXGcP+/DH0l8TP3JE2/ZWqzqzV3oV0+kb48diHnDsjsT9Qi7HyBj
 2PsE9UM69VJcvgFckkFA6rwCA9Jd24Y9LswksyEAehuwzYUpFqG1lccAQoZMRFuP0Xgn+W
 R9bmRQqgmI1Gl7pFzKqczeGUgJcqC/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791892922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Essr/9mvsYelqo9XEUhRpx9Ww7y2ATOmlocwvS3zNUI=;
 b=QW/1bdjU0uSuF7Nt4Sgg8pglMmDLHTAJSfXNE2yh54TH3TmZbIakIMIyJWb23IH1q9e+bd
 Gtm3vm2Nqt3LbiBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IkLqXoAo;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="QW/1bdjU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791892922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Essr/9mvsYelqo9XEUhRpx9Ww7y2ATOmlocwvS3zNUI=;
 b=IkLqXoAofdiwQDYCyJZXGcP+/DH0l8TP3JE2/ZWqzqzV3oV0+kb48diHnDsjsT9Qi7HyBj
 2PsE9UM69VJcvgFckkFA6rwCA9Jd24Y9LswksyEAehuwzYUpFqG1lccAQoZMRFuP0Xgn+W
 R9bmRQqgmI1Gl7pFzKqczeGUgJcqC/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791892922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Essr/9mvsYelqo9XEUhRpx9Ww7y2ATOmlocwvS3zNUI=;
 b=QW/1bdjU0uSuF7Nt4Sgg8pglMmDLHTAJSfXNE2yh54TH3TmZbIakIMIyJWb23IH1q9e+bd
 Gtm3vm2Nqt3LbiBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C4311350B;
 Tue, 13 Oct 2026 12:02:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jWLfDrgdzmouEgAAD6G6ig:T7
 (envelope-from <andrea.cervesato@suse.de>); Tue, 13 Oct 2026 12:02:01 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 13 Oct 2026 14:02:02 +0200
MIME-Version: 1.0
Message-Id: <20261013-fix_core_lib_deepseek-v2-6-7a6670fd6fd6@suse.com>
References: <20261013-fix_core_lib_deepseek-v2-0-7a6670fd6fd6@suse.com>
In-Reply-To: <20261013-fix_core_lib_deepseek-v2-0-7a6670fd6fd6@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791892920; l=1608;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=s7KwHK4rhqP5M2+lMUCqkJnNdtlFhTtDO30/ZmkgfwI=;
 b=akz1x4MgiVvPJsigB5kh5lhbV3X/m7MauaeDSh0h/iOig8Mb3ysvliMZGKfX9mCQUpTpmfbTN
 aH+VHjaZTFCCt96YE7E8BMtv5vxxXPg56WRogDlctkE9b8RUqBLYrp6
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 57A4B1F45F
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_ALL(0.00)[]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.com:email, suse.de:dkim]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 06/15] ujson: reader: Combine UTF-16 surrogate pairs
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

RFC 8259 specifies that characters outside the BMP may be represented
as a surrogate pair (\uD800-\uDBFF followed by \uDC00-\uDFFF).
Currently, each \uXXXX escape is converted independently to UTF-8,
producing invalid surrogate code point sequences instead of combining
them into a single UTF-8 sequence. Lone surrogates are also improperly
accepted. Combine valid surrogate pairs and reject unpaired surrogates.

Fixes: c50a0e0751c8 ("libs: Vendor ujson library")
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 libs/ujson/ujson_reader.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/libs/ujson/ujson_reader.c b/libs/ujson/ujson_reader.c
index 6dde06e01..7bf5b91f2 100644
--- a/libs/ujson/ujson_reader.c
+++ b/libs/ujson/ujson_reader.c
@@ -134,6 +134,34 @@ static unsigned int parse_ucode_esc(ujson_reader *buf, char *str,
 	if (ucode < 0)
 		return 0;
 
+	if (ucode >= 0xdc00 && ucode <= 0xdfff) {
+		ujson_err(buf, "Unpaired low surrogate");
+		return 0;
+	}
+
+	if (ucode >= 0xd800 && ucode <= 0xdbff) {
+		int32_t low;
+
+		if (peekb(buf) != '\\' || peekb_off(buf, 1) != 'u') {
+			ujson_err(buf, "Unpaired high surrogate");
+			return 0;
+		}
+
+		getb(buf);
+		getb(buf);
+
+		low = parse_ucode_cp(buf);
+		if (low < 0)
+			return 0;
+
+		if (low < 0xdc00 || low > 0xdfff) {
+			ujson_err(buf, "Invalid low surrogate in escape sequence");
+			return 0;
+		}
+
+		ucode = 0x10000 + (((ucode - 0xd800) << 10) | (low - 0xdc00));
+	}
+
 	if (!str)
 		return ujson_utf8_bytes(ucode);
 

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
