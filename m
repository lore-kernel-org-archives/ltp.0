Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B44E5CA5FF0
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 13:27:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5151B3E2E37
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 15:27:57 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 27EC83E6B40
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 15:25:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BF9E4600758
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 15:25:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6614E21294;
 Mon,  5 Oct 2026 13:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791206747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RrB+xZ0Fm1cNfuOe6RDqi6GYg2worub/mTGvzUB7QkQ=;
 b=PTGGl3g7qqnDi8daEKxtpiBF4+QDUSJU4A/atZkRFlFQtzSBndhFBoMLFiIPiJtFRYhTYW
 UOh3tL88I0rdQcXmMWer5mBjcmBbsH7UBwcXOUR2JJR5CYqyZdL5iL/DlyRFAjeuoORwVG
 5H/RKXhxGgMQLwtZjiNpZ5Bm3L5xOdI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791206747;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RrB+xZ0Fm1cNfuOe6RDqi6GYg2worub/mTGvzUB7QkQ=;
 b=ESWsARLWVrNwu25xQabmyvtFlk8jcP/mXLOPoiurB3mLQRsiy32KUYcW9liU2oF3POOsM2
 JXUXMEJH1nxWpFCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791206743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RrB+xZ0Fm1cNfuOe6RDqi6GYg2worub/mTGvzUB7QkQ=;
 b=NQe886qs539qQ/xMBQ4FwwnlzIJ6f3jXUnViUpajXlXBoF39+IgKw2jwFOSt7LohcsDJLz
 w0x1BldBAKndHz5qcl1kSPJ93S/SgZaWfPomeTGDML20OWeeIAeNFUhTRwE3xG2yrzVhk2
 s+JBmJxGN3Dnw33dOwq9SlhC1bnKbpE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791206743;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RrB+xZ0Fm1cNfuOe6RDqi6GYg2worub/mTGvzUB7QkQ=;
 b=9aojKCxfTnkrqkH9v24uocTYycUHfSVFPE6ycBb/QKiZlCGb9oDiN2TD0/Okab7GjkkSfj
 gSYiGa994Gc5WfAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B45A13AED;
 Mon,  5 Oct 2026 13:25:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Q4tkH06lw2oibAAAD6G6ig:T6
 (envelope-from <andrea.cervesato@suse.de>); Mon, 05 Oct 2026 13:25:35 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 05 Oct 2026 15:25:33 +0200
MIME-Version: 1.0
Message-Id: <20261005-fix_core_lib_deepseek-v1-5-fec334ce8e80@suse.com>
References: <20261005-fix_core_lib_deepseek-v1-0-fec334ce8e80@suse.com>
In-Reply-To: <20261005-fix_core_lib_deepseek-v1-0-fec334ce8e80@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791206734; l=1928;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=DYX7wHfWWFaOkuzR+sY7S211+SxZZZIt/tuLM4u2STk=;
 b=aZFACd6jNuZY7udfOAcNvWxX+0SLhXnW5uci57rwWiNit9M86O4fXuHCv4Er8ooGteE8gXIop
 GfsbkfVJsAmDW/FAmeOZkSZLBPhKpohm/fN2C3zIkjXJyRZzVk36S2H
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.21 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.11)[-0.556]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 05/15] ujson: reader: Combine UTF-16 surrogate pairs
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

Also return the UTF-8 length instead of the code point when no output
buffer is given. The caller treats 0 as failure, so \u0000 made
copy_str() fail without setting an error message.

Fixes: c50a0e0751c8 ("libs: Vendor ujson library")
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 libs/ujson/ujson_reader.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/libs/ujson/ujson_reader.c b/libs/ujson/ujson_reader.c
index 2219c5801..0975ca1a1 100644
--- a/libs/ujson/ujson_reader.c
+++ b/libs/ujson/ujson_reader.c
@@ -134,8 +134,34 @@ static unsigned int parse_ucode_esc(ujson_reader *buf, char *str,
 	if (ucode < 0)
 		return 0;
 
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
+	} else if (ucode >= 0xdc00 && ucode <= 0xdfff) {
+		ujson_err(buf, "Unpaired low surrogate");
+		return 0;
+	}
+
 	if (!str)
-		return ucode;
+		return ujson_utf8_bytes(ucode);
 
 	if (ujson_utf8_bytes(ucode) + 1 >= len - off) {
 		ujson_err(buf, "String buffer too short!");

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
